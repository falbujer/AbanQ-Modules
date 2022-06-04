/***************************************************************************
                 co_masteramortizaciones.qs  -  description
                             -------------------
    begin                : mar mar 03 2010
    copyright            : (C) 2010 by InfoSiAL S.L.
    email                : mail@infosial.com
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/
 
/** @file */
 
/** @class_declaration interna */
////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
class interna {
    var ctx:Object;
    function interna( context ) { this.ctx = context; }
    function init() { this.ctx.interna_init(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var tdbRecords:FLTableDB;
	var pbnGenerar:String;
	var msgDotaciones_:String;
	var importeDot_;
	var numDotaciones_;
	var cantidadDot_;
    function oficial( context ) { interna( context ); }
	function pbnGenerar_clicked() {
		return this.ctx.oficial_pbnGenerar_clicked();
	}
	function muestraDotacionesRealizadas() {
		return this.ctx.oficial_muestraDotacionesRealizadas();
	}
	function generarDotaciones(fechaLimite) {
		return this.ctx.oficial_generarDotaciones(fechaLimite);
	}
	function generarDotacionesAmor(qryAmor, fechaLimite) {
		return this.ctx.oficial_generarDotacionesAmor(qryAmor, fechaLimite);
	}
	function filtrarTabla() {
		return this.ctx.oficial_filtrarTabla();
	}
	function filtroTabla() {
		return this.ctx.oficial_filtroTabla();
	}
	function dameFiltroGenerarDotaciones() {
		return this.ctx.oficial_dameFiltroGenerarDotaciones();
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends oficial {
    function head( context ) { oficial ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
    function ifaceCtx( context ) { head( context ); }
}

const iface = new ifaceCtx( this );
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition interna */
////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
/** \C El formulario mostrará las cuentas asociadas al ejercicio actual
\end */
function interna_init()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	this.iface.tdbRecords = this.child("tableDBRecords");
	this.iface.pbnGenerar = this.child("pbnGenerar");

	connect(this.iface.pbnGenerar, "clicked()", this, "iface.pbnGenerar_clicked"),
	
	this.iface.filtrarTabla();
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_muestraDotacionesRealizadas()
{
	var _i = this.iface;
	var dialog = new Dialog;
	dialog.okButtonText = sys.translate("Aceptar");
	dialog.cancelButtonText = sys.translate("Cancelar");
	dialog.title = sys.translate("Dotaciones creadas");
	var gB = new GroupBox;
	gB.title = sys.translate("Pulse Aceptar para guardarlas en la base de datos");
	var tE = new TextEdit;
	tE.text = _i.msgDotaciones_
	gB.add(tE);
	dialog.add(gB);
	if (!dialog.exec()) {
		return false;
	}
	return true;
}

function oficial_pbnGenerar_clicked()
{
	var _i = this.iface;
	var util:FLUtil = new FLUtil;
	var dialog = new Dialog;
	dialog.caption = "Introduzca la fecha límite de las dotaciones a generar";
	dialog.okButtonText = util.translate("scripts", "OK");
	dialog.cancelButtonText = util.translate("scripts", "Cancelar");
	
	var hoy:Date = new Date;
	hoy.setDate(1);
	var fechaDefecto:String = util.addMonths(hoy, 1);
	fechaDefecto = util.addDays(fechaDefecto, -1);

	var dedLimite = new DateEdit;
	dedLimite.label = "Fecha límite: ";
	dedLimite.date = fechaDefecto;
	dialog.add( dedLimite );

	if (!dialog.exec()) {
		return false;
	}

	var fechaLimite:Date = dedLimite.date;
	if (!fechaLimite || fechaLimite == "") {
		MessageBox.warning(util.translate("scripts", "Debe establecer las fecha límite"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	var mesL:Number = fechaLimite.getMonth();
	var fechaComp:String = util.addDays(fechaLimite, 1);
	var fechaLimiteC:Date = new Date(Date.parse(fechaComp.toString()));
	
	var mesL:Number = fechaLimite.getMonth();
	var mesLC:Number = fechaLimiteC.getMonth();
	if (mesL == mesLC) {
		MessageBox.warning(util.translate("scripts", "La fecha indicada debe ser fin de mes"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	this.iface.msgDotaciones_ = "";
	this.iface.importeDot_ = 0;
	this.iface.cantidadDot_ = 0;
	var curTransaccion:FLSqlCursor = new FLSqlCursor("empresa");
	curTransaccion.transaction(false);
	try {
		if (this.iface.generarDotaciones(fechaLimite)) {
			if (_i.muestraDotacionesRealizadas()) {
				curTransaccion.commit();
			} else {
				curTransaccion.rollback();
			}
// 			var res:Number = MessageBox.information(util.translate("scripts", "Dotaciones generadas:\n") + this.iface.msgDotaciones_, MessageBox.Ok, MessageBox.Cancel);
// 			res == MessageBox.Ok ? curTransaccion.commit() : curTransaccion.rollback();
				
		} else {
			curTransaccion.rollback();
			MessageBox.warning(util.translate("scripts", "Error al generar las dotaciones"), MessageBox.Ok, MessageBox.NoButton);
		}
	} catch (e) {
		curTransaccion.rollback();
		MessageBox.critical(util.translate("scripts", "Error al generar las dotaciones: ") + e, MessageBox.Ok, MessageBox.NoButton);
	}
}

function oficial_generarDotaciones(fechaLimite:Date):Boolean
{
	var util:FLUtil = new FLUtil;
	
	this.iface.numDotaciones_ = 0;
	var where = this.iface.dameFiltroGenerarDotaciones();
	var qryAmor:FLSqlQuery = new FLSqlQuery;
	qryAmor.setTablesList("co_amortizaciones");
	qryAmor.setSelect("codamortizacion, elemento");
	qryAmor.setFrom("co_amortizaciones");
	qryAmor.setWhere(where);
	qryAmor.setForwardOnly(true);
	if (!qryAmor.exec()) {
		return false;
	}
	while (qryAmor.next()) {
		this.iface.msgDotaciones_ += "\n" + util.translate("scripts", "Elemento: %1").arg(qryAmor.value("elemento"));
		if (!this.iface.generarDotacionesAmor(qryAmor, fechaLimite)) {
			MessageBox.warning(sys.translate("Error al generar las dotaciones asociadas al elemento:\n%1 . %2").arg(qryAmor.value("codamortizacion")).arg(qryAmor.value("elemento")), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return false;
		}
	}
	/// Controla que el mensaje de confirmación no sea demasiado largo
	if (this.iface.numDotaciones_ == 0) {
		this.iface.msgDotaciones_ = util.translate("scripts", "No es necesario generar dotaciones");
	} else if (this.iface.numDotaciones_ > 25) {
		this.iface.msgDotaciones_ = util.translate("scripts", "Se han generado %1 dotaciones por un total de %2").arg(this.iface.cantidadDot_).arg(util.roundFieldValue(this.iface.importeDot_, "co_dotaciones", "importe"));
	}

	return true;
}

function oficial_dameFiltroGenerarDotaciones()
{
	return "estado = 'En Curso' AND pendiente > 0 AND NOT bloqueado";
}

function oficial_generarDotacionesAmor(qryAmor:FLSqlQuery, fechaLimite:Date):Boolean
{
	var util:FLUtil = new FLUtil;
	var codAmor:String = qryAmor.value("codamortizacion");

// 	var fechaUltimaDot:String = util.sqlSelect("co_dotaciones", "fechafin", "codamortizacion = '" + codAmor + "' ORDER BY fechafin DESC");
// 	var dotCompletas:Boolean = (util.daysTo(fechaUltimaDot, fechaLimite) <= 0);
	var pendiente:Number = parseFloat(util.sqlSelect("co_amortizaciones", "pendiente", "codamortizacion = '" + codAmor + "'"));
	pendiente = (isNaN(pendiente) ? 0 : pendiente);
	var curDotacion:FLSqlCursor = new FLSqlCursor("co_dotaciones");
	var curAmortizacion:FLSqlCursor = new FLSqlCursor("co_amortizaciones");
	var fechaInicio:String, fechaFin:String, importe:Number;
// 	while (pendiente > 0 && !dotCompletas) {
	while (pendiente > 0) {
		curDotacion.setModeAccess(curDotacion.Insert);
		curDotacion.refreshBuffer();
		curDotacion.setValueBuffer("codamortizacion", codAmor);
		fechaInicio = formRecordco_dotaciones.iface.pub_commonCalculateField("fechainicio", curDotacion);
		curDotacion.setValueBuffer("fechainicio", fechaInicio);
		fechaFin = formRecordco_dotaciones.iface.pub_commonCalculateField("fechafin", curDotacion);
		if (util.daysTo(fechaFin, fechaLimite) < 0) {
			break;
		}
		curDotacion.setValueBuffer("fechafin", fechaFin);
		curDotacion.setValueBuffer("fecha", fechaFin);
		importe = formRecordco_dotaciones.iface.pub_commonCalculateField("importeinicio", curDotacion);
		curDotacion.setValueBuffer("importe", importe);
		curDotacion.setValueBuffer("acumulado", formRecordco_dotaciones.iface.pub_commonCalculateField("acumulado", curDotacion));
		curDotacion.setValueBuffer("resto", formRecordco_dotaciones.iface.pub_commonCalculateField("resto", curDotacion));
		curDotacion.setValueBuffer("porcentaje", formRecordco_dotaciones.iface.pub_commonCalculateField("porcentaje", curDotacion));
		if (!curDotacion.commitBuffer()) {
			return false;
		}
		this.iface.msgDotaciones_ += "\n\t" + util.translate("scripts", "Dotación: Desde %1 hasta %2. Importe: %3").arg(util.dateAMDtoDMA(fechaInicio)).arg(util.dateAMDtoDMA(fechaFin)).arg(util.roundFieldValue(importe, "co_dotaciones", "importe"));
		this.iface.importeDot_ += parseFloat(importe);
		this.iface.cantidadDot_++;
		curAmortizacion.select("codamortizacion = '" + codAmor + "'");
		if (!curAmortizacion.first()) {
			return false;
		}
		curAmortizacion.setModeAccess(curAmortizacion.Edit);
		curAmortizacion.refreshBuffer();
		curAmortizacion.setValueBuffer("totalamortizado", formRecordco_amortizaciones.iface.pub_commonCalculateField("totalamortizado", curAmortizacion));
		curAmortizacion.setValueBuffer("pendiente", formRecordco_amortizaciones.iface.pub_commonCalculateField("pendiente", curAmortizacion));
		curAmortizacion.setValueBuffer("estado", formRecordco_amortizaciones.iface.pub_commonCalculateField("estado", curAmortizacion));
		if (!curAmortizacion.commitBuffer()) {
			return false;
		}

// 		fechaUltimaDot = util.sqlSelect("co_dotaciones", "fechafin", "codamortizacion = '" + codAmor + "' ORDER BY fechafin DESC");
// 		dotCompletas = (util.daysTo(fechaUltimaDot, fechaLimite) <= 0);
		pendiente = parseFloat(util.sqlSelect("co_amortizaciones", "pendiente", "codamortizacion = '" + codAmor + "'"));
		pendiente = (isNaN(pendiente) ? 0 : pendiente);

		this.iface.numDotaciones_++;
	}
	
	return true;
}

function oficial_filtrarTabla():Boolean
{
	var filtro = this.iface.filtroTabla();
	this.cursor().setMainFilter(filtro);
	return true;
}

function oficial_filtroTabla():String
{
	var filtro = "";
	
	return filtro;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
