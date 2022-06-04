/***************************************************************************
                 co_amortizaciones.qs  -  description
                             -------------------
    begin                : vie dic 28 2007
    copyright            : (C) 2007 by InfoSiAL S.L.
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
	function validateForm():Boolean { return this.ctx.interna_validateForm(); }
	function calculateField( fN:String ):String {
		return this.ctx.interna_calculateField( fN );
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var longSubcuenta:Number;
	var ejercicioActual:String;
	var bloqueoSubcuentaElem:Boolean;
	var bloqueoSubcuentaAmor:Boolean;
	var posActualPuntoSubcuentaElem:Number;
	var posActualPuntoSubcuentaAmor:Number;
	var bloqueoNumPeriodos:Boolean;
	var bloqueoVPeriodo:Boolean;
	var bloqueoPeriodo_, bloqueoPorcentajes_;
	
	function oficial( context ) { interna( context ); } 
	function bufferChanged(fN) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function calcularTotales() {
		return this.ctx.oficial_calcularTotales();
	}
	function filtraPartidasVenta() {
		return this.ctx.oficial_filtraPartidasVenta();
	}
	function filtraPartidasCompra() {
		return this.ctx.oficial_filtraPartidasCompra();
	}
// 	function habilitaPorComprado() {
// 		return this.ctx.oficial_habilitaPorComprado();
// 	}
	function habilitaPorVendido() {
		return this.ctx.oficial_habilitaPorVendido();
	}
	function habilitaPorEstado() {
		return this.ctx.oficial_habilitaPorEstado();
	}
	function calcularFechaFinPeriodo(fecha:Date,tipoPeriodo:String):Date {
		return this.ctx.oficial_calcularFechaFinPeriodo(fecha,tipoPeriodo);
	}
	function calcularDiasPeriodo(fecha:Date,tipoPeriodo:String):Number {
		return this.ctx.oficial_calcularDiasPeriodo(fecha,tipoPeriodo);
	}
	function commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.ctx.oficial_commonCalculateField(fN, cursor);
	}
	function dameListaSubcuentas(codGrupoContableAmo) {
		return this.ctx.oficial_dameListaSubcuentas(codGrupoContableAmo);
	}
	function tbnCerrarAmor_clicked() {
		return this.ctx.oficial_tbnCerrarAmor_clicked();
	}
	function reabrirAmortizacion() {
		return this.ctx.oficial_reabrirAmortizacion();
	}
	function cerrarAmortizacion() {
		return this.ctx.oficial_cerrarAmortizacion();
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
	function pub_calcularFechaFinPeriodo(fecha:Date,tipoPeriodo:String):Date {
		return this.calcularFechaFinPeriodo(fecha,tipoPeriodo);
	}
	function pub_calcularDiasPeriodo(fecha:Date,tipoPeriodo:String):Number {
		return this.calcularDiasPeriodo(fecha,tipoPeriodo);
	}
	function pub_commonCalculateField(fN, cursor) {
		return this.commonCalculateField(fN, cursor);
	}
	function pub_dameListaSubcuentas(codGrupoContableAmo) {
		return this.dameListaSubcuentas(codGrupoContableAmo);
	}
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
function interna_init()
{
	var _i = this.iface;
	var util:FLUtil = new FLUtil(); 
	var cursor = this.cursor();

	_i.ejercicioActual = flfactppal.iface.pub_ejercicioActual();

	_i.longSubcuenta = util.sqlSelect("ejercicios", "longsubcuenta", "codejercicio = '" + _i.ejercicioActual + "'");
	_i.bloqueoSubcuentaAmor = false;
	_i.posActualPuntoSubcuentaAmor = -1;
	_i.bloqueoSubcuentaElem = false;
	_i.posActualPuntoSubcuentaElem = -1;

	_i.bloqueoNumPeriodos = false;
	_i.bloqueoVPeriodo = false;
	_i.bloqueoPeriodo_ = false;
	_i.bloqueoPorcentajes_ = false;
	
	if(cursor.modeAccess() == cursor.Insert) {
// 		this.child("fdbIdSubcuentaElem").setFilter("codejercicio = '" + _i.ejercicioActual + "'");
// 		this.child("fdbDesSubcuentaElem").setValue("");
// 		this.child("fdbIdSubcuentaAmor").setFilter("codejercicio = '" + _i.ejercicioActual + "'");
// 		this.child("fdbDesSubcuentaAmor").setValue("");
	} else {
		if(cursor.valueBuffer("pendiente") == 0) {
// 			this.child("tdbDotaciones").setReadOnly(true);
			this.child("toolButtonInsert").setDisabled(true);
			this.child("fdbEstado").setDisabled(true);
		}
		if(util.sqlSelect("co_dotaciones","iddotacion","codamortizacion = '" + cursor.valueBuffer("codamortizacion") + "'")) {
// 			this.child("fdbFecha").setDisabled(true);
			this.child("fdbValorAdq").setDisabled(true);
			this.child("fdbValorResidual").setDisabled(true);
// 			this.child("fdbCodSubcuentaElem").setDisabled(true);
// 			this.child("fdbIdSubcuentaElem").setDisabled(true);
// 			this.child("fdbCodSubcuentaAmor").setDisabled(true);
// 			this.child("fdbIdSubcuentaAmor").setDisabled(true);
			this.child("fdbAmorAnual").setDisabled(true);
			this.child("fdbNumAnos").setDisabled(true);
			this.child("fdbAmorPrimerAno").setDisabled(true);
			this.child("fdbAmorUltimoAno").setDisabled(true);
// 			this.child("fdbPeriodo").setDisabled(true);
		}
		
		var subcuentas = _i.dameListaSubcuentas(cursor.valueBuffer("codgrupocontableamo"));
		this.child("tdbMovimientos").cursor().setMainFilter("codsubcuenta IN  (" + subcuentas + ")");
		this.child("tdbMovimientos").refresh();
	}
	_i.habilitaPorVendido();
// 	_i.habilitaPorComprado();
	_i.habilitaPorEstado();
	_i.filtraPartidasVenta();
	_i.filtraPartidasCompra();
	
	connect(this.child("tdbDotaciones").cursor(), "bufferCommited()", this, "iface.calcularTotales()");
	connect(this.child("tbnCerrarAmor"), "clicked()", _i, "tbnCerrarAmor_clicked()");
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
}

/** \C La subcuenta establecida debe existir en la tabla de subcuentas
\end */
function interna_validateForm():Boolean
{
	var _i = this.iface;
	var util:FLUtil = new FLUtil;
	var cursor = this.cursor();

	var codEjercicio:String = _i.ejercicioActual;
// 	if (!util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + cursor.valueBuffer("codsubcuentaelem") + "' AND codejercicio = '" + codEjercicio + "'")) {
// 		this.child("fdbCodSubcuentaElem").setDisabled(false);
// 		this.child("fdbIdSubcuentaElem").setDisabled(false);
// 		MessageBox.warning(util.translate("scripts", "No existe la subcuenta %1 para el ejercicio %2").arg(cursor.valueBuffer("codsubcuentaelem")).arg(codEjercicio), MessageBox.Ok, MessageBox.NoButton);
//   	return false;
// 	}
// 
// 	if (!util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + cursor.valueBuffer("codsubcuentaamor") + "' AND codejercicio = '" + codEjercicio + "'")) {
// 		this.child("fdbCodSubcuentaAmor").setDisabled(false);
// 		this.child("fdbIdSubcuentaAmor").setDisabled(false);
// 		MessageBox.warning(util.translate("scripts", "No existe la subcuenta %1 para el ejercicio %2").arg(cursor.valueBuffer("codsubcuentaamor")).arg(codEjercicio), MessageBox.Ok, MessageBox.NoButton);
//   	return false;
// 	}
	return true;
}

function interna_calculateField(fN)
{
	var res;
	var cursor = this.cursor();
	var _i = this.iface;
	
	switch(fN) {
		default: {
			res = _i.commonCalculateField(fN, cursor);
		}
	}

	return res;
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_bufferChanged(fN)
{
	var _i = this.iface;
	var cursor = this.cursor();
	
debug("cambia " + fN + " a " + cursor.valueBuffer(fN));
	
	var util:FLUtil = new FLUtil();

	switch(fN) {
// 		case "codsubcuentaelem": {
// 			if (!_i.bloqueoSubcuentaElem) {
// 				_i.bloqueoSubcuentaElem = true;
// 				_i.posActualPuntoSubcuentaElem = flcontppal.iface.pub_formatearCodSubcta(this, "fdbCodSubcuentaElem", _i.longSubcuenta, _i.posActualPuntoSubcuentaElem);
// 				_i.bloqueoSubcuentaElem = false;
// 			}
// 			break;
// 		}
// 		case "codsubcuentaamor": {
// 			if (!_i.bloqueoSubcuentaAmor) {
// 				_i.bloqueoSubcuentaAmor = true;
// 				_i.posActualPuntoSubcuentaAmor = flcontppal.iface.pub_formatearCodSubcta(this, "fdbCodSubcuentaAmor", _i.longSubcuenta, _i.posActualPuntoSubcuentaAmor);
// 				_i.bloqueoSubcuentaAmor = false;
// 			}
// 			break;
// 		}
		case "valoradquisicion":
		case "valorresidual": {
			cursor.setValueBuffer("valoramortizable",_i.calculateField("valoramortizable"));
			break;
		}
		case "valoramortizable": {
			cursor.setValueBuffer("amorperiodo",_i.calculateField("amorperiodo"));
			cursor.setValueBuffer("pendiente",_i.calculateField("pendiente"));
			break;
		}
		case "amorperiodo" : {
			_i.bloqueoVPeriodo = true;
			if(!_i.bloqueoNumPeriodos) {
				_i.bloqueoNumPeriodos = true;
				cursor.setValueBuffer("numperiodos",_i.calculateField("numperiodos"));
				_i.bloqueoNumPeriodos = false;
			}
			cursor.setValueBuffer("amorprimerperiodo",_i.calculateField("amorprimerperiodo"));
			if (!_i.bloqueoPeriodo_) {
				_i.bloqueoPeriodo_ = true;
				cursor.setValueBuffer("porcentajeperiodo",_i.calculateField("porcentajeperiodo"));
				_i.bloqueoPeriodo_ = false;
			}
			break;
		}
		case "porcentajeperiodo": {
			if (!_i.bloqueoPeriodo_) {
				_i.bloqueoPeriodo_ = true;
				cursor.setValueBuffer("amorperiodo", _i.calculateField("amorperiodo"));
				_i.bloqueoPeriodo_ = false;
			}
			if (!_i.bloqueoPorcentajes_) {
				_i.bloqueoPorcentajes_ = true;
				cursor.setValueBuffer("porcentajeanual", _i.calculateField("porcentajeanualperiodo"));
				_i.bloqueoPorcentajes_ = false;
			}
			break;
		}
		case "porcentajeanual": {
			if (!_i.bloqueoPorcentajes_) {
				_i.bloqueoPorcentajes_ = true;
				cursor.setValueBuffer("porcentajeperiodo", _i.calculateField("porcentajeperiodoanual"));
				_i.bloqueoPorcentajes_ = false;
			}
			break;
		}
		case "amorprimerperiodo": {
			cursor.setValueBuffer("amorultimoperiodo",_i.calculateField("amorultimoperiodo"));
			cursor.setValueBuffer("totalamortizado",_i.calculateField("totalamortizado"));
			break;
		}
		case "numperiodos": {
			if(!_i.bloqueoNumPeriodos) {
				_i.bloqueoNumPeriodos = true;
// 				_i.bloqueoNumPeriodos = true;
// 				if(!_i.bloqueoVPeriodo)
				cursor.setValueBuffer("amorperiodo",_i.calculateField("amorperiodo_plazos"));
				_i.bloqueoNumPeriodos = false;
			} //else
				//_i.bloqueoVPeriodo = false;
			//_i.bloqueoNumPeriodos = false;
			cursor.setValueBuffer("amorultimoperiodo",_i.calculateField("amorultimoperiodo"));
			break;
		}
		case "periodo": {
			if (!_i.bloqueoPorcentajes_) {
				_i.bloqueoPorcentajes_ = true;
				cursor.setValueBuffer("porcentajeperiodo", _i.calculateField("porcentajeperiodoanual"));
				_i.bloqueoPorcentajes_ = false;
			}
			cursor.setValueBuffer("amorprimerperiodo",_i.calculateField("amorprimerperiodo"));
			break;
		}
		case "fechainicio":{
			cursor.setValueBuffer("amorprimerperiodo",_i.calculateField("amorprimerperiodo"));
			break;
		}
		case "pendiente": {
			if (cursor.valueBuffer("pendiente") == 0) {
				this.child("toolButtonInsert").setDisabled(true);
				cursor.setValueBuffer("estado","Terminada");
				this.child("fdbEstado").setDisabled(true);
			}	
			if (cursor.valueBuffer("pendiente") > 0) {
				this.child("toolButtonInsert").setDisabled(false);
				cursor.setValueBuffer("estado","En Curso");
				this.child("fdbEstado").setDisabled(false);
			}
			break;
		}
// 		case "idfacturacompra": {
// 			_i.filtraPartidasCompra();
// 			break;
// 		}
		case "idfacturaventa": {
			_i.filtraPartidasVenta();
			break;
		}
// 		case "comprado": {
// 			if (!cursor.valueBuffer("comprado")) {
// 				cursor.setNull("idfacturacompra");
// 				_i.filtraPartidasCompra();
// 				this.child("fdbCodFacturaCompra").setValue("");
// 			}
// 			_i.habilitaPorComprado();
// 			break;
// 		}
		case "vendido": {
			if (!cursor.valueBuffer("vendido")) {
				cursor.setNull("idfacturaventa");
				_i.filtraPartidasVenta();
				this.child("fdbCodFacturaVenta").setValue("");
			}
			_i.habilitaPorVendido();
			break;
		}
		case "bloqueado": {
			cursor.setValueBuffer("estado", _i.calculateField("estado"));
			break;
		}
		case "estado": {
			_i.habilitaPorEstado();
			break;
		}
	}
}

function oficial_habilitaPorVendido()
{
	var _i = this.iface;
	var cursor = this.cursor();

	if (cursor.valueBuffer("vendido")) {
		this.child("fdbIdFacturaVenta").setDisabled(false);
	} else {
		this.child("fdbIdFacturaVenta").setDisabled(true);
	}
}

// function oficial_habilitaPorComprado()
// {
// 	var _i = this.iface;
// 	var cursor = this.cursor();
// 
// 	if (cursor.valueBuffer("comprado")) {
// 		this.child("fdbIdFacturaCompra").setDisabled(false);
// 	} else {
// 		this.child("fdbIdFacturaCompra").setDisabled(true);
// 	}
// }

function oficial_habilitaPorEstado()
{
	var _i = this.iface;
	var cursor = this.cursor();

	switch (cursor.valueBuffer("estado")) {
		case "En Curso":
		case "Suspendida": {
			this.child("fdbBloqueado").setDisabled(false);
			break;
		}
		case "Terminada":
		case "Cerrada": {
			this.child("fdbBloqueado").setDisabled(true);
			break;
		}
	}
}

function oficial_filtraPartidasCompra()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var codSubcuentaElem = AQUtil.sqlSelect("co_gruposcontablesamo", "codsubcuentaele", "codgrupo = '" + cursor.valueBuffer("codgrupocontableamo") + "'");
	
	var f = codSubcuentaElem ? "codsubcuenta = '" + codSubcuentaElem + "' AND codactivo = '" + cursor.valueBuffer("codamortizacion") + "' AND debe <> 0" : "1 = 2";

	// 	q.setSelect("codsubcuentaele, codsubcuentagas, codsubcuentaamo");
// 	q.setFrom("co_gruposcontablesamo");
// 	q.setWhere("codgrupo = '" + codGrupoContableAmo + "'");
// 	if (!q.exec()) {
// 		return false;
// 	}
// 	if (!q.first()) {
// 		return "'Not Found'";
// 	}
// 	var valor = "";
// 	valor += ("'" + q.value("codsubcuentaele") + "'");
// 	valor += q.value("codsubcuentagas") != "" ? (", '" + q.value("codsubcuentagas") + "'") : "";
// debug("lista = " + valor);
// 
// 	var idFC = cursor.valueBuffer("idfacturacompra");
// 	var idAsiento = idFC ? AQUtil.sqlSelect("facturasprov", "idasiento", "idfactura = " + idFC) : 0;
// 	idAsiento = isNaN(idAsiento) ? 0 : idAsiento;
// 	this.child("tdbPartidasCompra").setFilter("idasiento = " + idAsiento);
	this.child("tdbPartidasCompra").setFilter(f);
	this.child("tdbPartidasCompra").refresh();
}

function oficial_filtraPartidasVenta()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var codSubcuentaGan = AQUtil.sqlSelect("co_gruposcontablesamo", "codsubcuentagan", "codgrupo = '" + cursor.valueBuffer("codgrupocontableamo") + "'");

	var idFV = cursor.valueBuffer("idfacturaventa");
	var idAsiento = idFV ? AQUtil.sqlSelect("facturascli", "idasiento", "idfactura = " + idFV) : 0;
	idAsiento = isNaN(idAsiento) ? 0 : idAsiento;
	this.child("tdbPartidasVenta").setFilter("idasiento = " + idAsiento + " AND codsubcuenta = '" + codSubcuentaGan + "'");
	this.child("tdbPartidasVenta").refresh();
}

function oficial_calcularTotales()
{
	var _i = this.iface;
	var util:FLUtil;
	var cursor = this.cursor();

	cursor.setValueBuffer("totalamortizado", _i.calculateField("totalamortizado"));
	cursor.setValueBuffer("pendiente", _i.calculateField("pendiente"));
	cursor.setValueBuffer("estado", _i.calculateField("estado"));

	if(util.sqlSelect("co_dotaciones","iddotacion","codamortizacion = '" + cursor.valueBuffer("codamortizacion") + "'")) {
// 		this.child("fdbFecha").setDisabled(true);
		this.child("fdbValorAdq").setDisabled(true);
		this.child("fdbValorResidual").setDisabled(true);
// 		this.child("fdbCodSubcuentaElem").setDisabled(true);
// 		this.child("fdbIdSubcuentaElem").setDisabled(true);
// 		this.child("fdbCodSubcuentaAmor").setDisabled(true);
// 		this.child("fdbIdSubcuentaAmor").setDisabled(true);
		this.child("fdbAmorAnual").setDisabled(true);
		this.child("fdbNumAnos").setDisabled(true);
		this.child("fdbAmorPrimerAno").setDisabled(true);
		this.child("fdbAmorUltimoAno").setDisabled(true);
		this.child("fdbPeriodo").setDisabled(true);
	}
	else {
// 		this.child("fdbFecha").setDisabled(false);
		this.child("fdbValorAdq").setDisabled(false);
		this.child("fdbValorResidual").setDisabled(false);
// 		this.child("fdbCodSubcuentaElem").setDisabled(false);
// 		this.child("fdbIdSubcuentaElem").setDisabled(false);
// 		this.child("fdbCodSubcuentaAmor").setDisabled(false);
// 		this.child("fdbIdSubcuentaAmor").setDisabled(false);
		this.child("fdbAmorAnual").setDisabled(false);
		this.child("fdbNumAnos").setDisabled(false);
		this.child("fdbAmorPrimerAno").setDisabled(false);
		this.child("fdbAmorUltimoAno").setDisabled(false);
		this.child("fdbPeriodo").setDisabled(false);
	}
}

function oficial_calcularFechaFinPeriodo(fecha:Date,tipoPeriodo:String):Date
{
	var _i = this.iface;
	var dia:Number = fecha.getDate();
	var mes:Number = fecha.getMonth();
	var ano:Number = fecha.getYear();

// ### Calculo correcto de año bisiesto
//	var res:Number = ano / 4;
//	if (res == 502)
//		res = 1
//	else
//		res = 0;
  var res;
	var bisiesto = (ano%4==0) && ((ano%100!= 0) || (ano%400==0));
	if (bisiesto) 
	  res = 1;
	else 
	  res = 0;
// ### Calculo correcto de año bisiesto

	switch (tipoPeriodo) {
		case "Mensual": {
			switch (mes) {
				case 2:
					dia = (28 + res);
					break;
				case 1:
				case 3:
				case 5:
				case 7:
				case 8:
				case 10:
				case 12:
					dia = 31;
					break;
				case 4:
				case 6:
				case 9:
				case 11:
					dia = 30;
					break;
			}
		}
		break;
		case "Trimestral": {
			if(mes <= 3) {
				dia = 31;
				mes = 3;
				break;
			}
			if (mes <= 6) {
				dia = 30;
				mes = 6
				break;
			}
			if (mes <= 9){
				dia = 30;
				mes = 9
				break;
			}
			if (mes <= 12) {
				dia = 31;
				mes = 12;
				break;
			}
		}
		break;
		case "Semestral": {
			if(mes <= 6) {
				dia = 30;
				mes = 6;
				break;
			}
			if (mes <= 13) {
				dia = 31;
				mes = 12;
				break;
			}
		}
		break;
		case "Anual": {
			dia = 31;
			mes = 12;
		}
		break;
	}

	var fechaFin:Date = new Date(ano,mes,dia);
	return fechaFin;
}

function oficial_calcularDiasPeriodo(fecha, tipoPeriodo)
{
	var fInicio = new Date(Date.parse(fecha.toString()));
	var fFin = new Date(Date.parse(fecha.toString()));
	
	var mesInicio = fInicio.getMonth();
	var anoInicio = fInicio.getYear();
	var mesFin;
	var anoFin;
	
	switch (tipoPeriodo) {
		case "Mensual": {
			mesFin = mesInicio + 1;
			anoFin = anoInicio;
			break;
		}
		case "Trimestral": {
			mesInicio = (Math.floor(mesInicio / 4) * 4) + 1;
			mesFin = mesInicio + 3;
			anoFin = anoInicio;
			break;
		}
		case "Semestral": {
			mesInicio = (Math.floor(mesInicio / 6) * 6) + 1;
			mesFin = mesInicio + 6;
			anoFin = anoInicio;
			break;
		}
		break;
		case "Anual": {
			mesInicio = 1;
			mesFin = mesInicio;
			anoFin = anoInicio + 1;
			break;
		}
		break;
	}
	if (mesFin > 12) {
		mesFin -= 12;
		anoFin++;
	}
	fInicio.setDate(1);
	fInicio.setMonth(mesInicio);
	fFin.setDate(1);
	fFin.setMonth(mesFin);
	fFin.setYear(anoFin);
debug("inicio " + fInicio.toString());
debug("fin " + fFin.toString());
debug("dif " + AQUtil.daysTo(fInicio, fFin));
	
	return AQUtil.daysTo(fInicio, fFin);
	
// 	var _i = this.iface;
// 	var mes:Number = fecha.getMonth();
// 	var ano:Number = fecha.getYear();
// 	var res:Number = ano / 4;
// 	if (res == 502)
// 		res = 1
// 	else
// 		res = 0;
// 
// 	switch (tipoPeriodo) {
// 		case "Mensual": {
// 			
// 			switch (mes) {
// 				case 2:
// 					return (28 + res);
// 				case 1:
// 				case 3:
// 				case 5:
// 				case 7:
// 				case 8:
// 				case 10:
// 				case 12:
// 					return 31;
// 				case 4:
// 				case 6:
// 				case 9:
// 				case 11:
// 					return 30;
// 			}
// 		}
// 		break;
// 		case "Trimestral": {
// 			if(mes <= 3)
// 				return (90 + res);
// 			if (mes <= 6)
// 				return 91;
// 			if (mes <= 12)
// 				return 92;
// 		}
// 		break;
// 		case "Semestral": {
// 			if (mes <= 6)
// 				return (181 + res);
// 			else
// 				return 184;
// 		}
// 		break;
// 		case "Anual": {
// 			return (365 + res);
// 		}
// 		break;
// 	}
}

function oficial_commonCalculateField(fN, cursor)
{
	var _i = this.iface;
	var util:FLUtil = new FLUtil;
	var res;
	
	switch(fN) {
		case "valoramortizable":{
			var vAdquisicion:Number = parseFloat(cursor.valueBuffer("valoradquisicion"));
			if (!vAdquisicion)
				vAdquisicion = 0;
			var vResidual:Number = parseFloat(cursor.valueBuffer("valorresidual"));
			if (!vResidual)
				vResidual = 0;
			res = vAdquisicion - vResidual;
			break;
		}
		case "porcentajeperiodoanual": {
			switch (cursor.valueBuffer("periodo")) {
				case "Mensual": {
					res = cursor.valueBuffer("porcentajeanual") / 12;
					break;
				}
				case "Trimestral": {
					res = cursor.valueBuffer("porcentajeanual") / 4;
					break;
				}
				case "Semestral": {
					res = cursor.valueBuffer("porcentajeanual") / 2;
					break;
				}
				case "Anual": {
					res = cursor.valueBuffer("porcentajeanual");
					break;
				}
			}
			res = AQUtil.roundFieldValue(res, "co_amortizaciones", "porcentajeperiodo");
			break;
		}
		case "porcentajeanualperiodo": {
			switch (cursor.valueBuffer("periodo")) {
				case "Mensual": {
					res = cursor.valueBuffer("porcentajeperiodo") * 12;
					break;
				}
				case "Trimestral": {
					res = cursor.valueBuffer("porcentajeperiodo") * 4;
					break;
				}
				case "Semestral": {
					res = cursor.valueBuffer("porcentajeperiodo") * 2;
					break;
				}
				case "Anual": {
					res = cursor.valueBuffer("porcentajeperiodo");
					break;
				}
			}
			res = AQUtil.roundFieldValue(res, "co_amortizaciones", "porcentajeperiodo");
			break;
		}
		case "porcentajeperiodo":{
			var metodo:String = cursor.valueBuffer("metodo");
			if(metodo == "Lineal") {
				var amorPeriodo:Number = parseFloat(cursor.valueBuffer("amorperiodo"));
				if (!amorPeriodo)
					amorPeriodo = 0;
				var vAmortizable:Number = parseFloat(cursor.valueBuffer("valoramortizable"));
				if (vAmortizable && vAmortizable != 0)
					res = (amorPeriodo / vAmortizable) * 100;
			}
			res = AQUtil.roundFieldValue(res, "co_amortizaciones", "porcentajeperiodo");
			break;
		}
		case "numperiodos":{
			var metodo:String = cursor.valueBuffer("metodo");
			if(metodo == "Lineal") {
				var vAmortizable:Number = parseFloat(cursor.valueBuffer("valoramortizable"));
				if (!vAmortizable)
					vAmortizable = 0;
				var amorPeriodo:Number = parseFloat(cursor.valueBuffer("amorperiodo"));
				if (amorPeriodo && amorPeriodo != 0)
					res = vAmortizable / amorPeriodo;
			}
			break;
		}
		case "amorperiodo": {
			var vAmortizable = parseFloat(cursor.valueBuffer("valoramortizable"));
			vAmortizable = isNaN(vAmortizable) ? 0 : vAmortizable;
			var porAmor = cursor.valueBuffer("porcentajeperiodo");
			porAmor = isNaN(porAmor) ? 0 : porAmor;
			if (porAmor == 0) {
				return 0;
			}
			res = vAmortizable * porAmor / 100;
			res = AQUtil.roundFieldValue(res, "co_amortizaciones", "amorperiodo");
// 			var vAmortizable:Number = parseFloat(cursor.valueBuffer("valoramortizable"));
// 			if (!vAmortizable)
// 				vAmortizable = 0;
// 			var numPeriodos:Number = parseFloat(cursor.valueBuffer("numperiodos"));
// 			if (numPeriodos && numPeriodos != 0)
// 				res = vAmortizable / numPeriodos;
			break;
		}
		case "amorperiodo_plazos": {
// 			var vAmortizable = parseFloat(cursor.valueBuffer("valoramortizable"));
// 			vAmortizable = isNaN(vAmortizable) ? 0 : vAmortizable;
// 			var porAmor = cursor.valueBuffer("porcentajeperiodo");
// 			porAmor = isNaN(porAmor) ? 0 : porAmor;
// 			if (porAmor == 0) {
// 				return 0;
// 			}
// 			res = vAmortizable * porAmor / 100;
// 			res = AQUtil.roundFieldValue(res, "co_amortizaciones", "amorperiodo");
			
			var vAmortizable:Number = parseFloat(cursor.valueBuffer("valoramortizable"));
			vAmortizable = isNaN(vAmortizable) ? 0 : vAmortizable;
			var numPeriodos:Number = parseFloat(cursor.valueBuffer("numperiodos"));
			numPeriodos = isNaN(numPeriodos) ? 0 : numPeriodos;
			if (numPeriodos == 0) {
				return 0;
			}
			res = vAmortizable / numPeriodos;
			res = AQUtil.roundFieldValue(res, "co_amortizaciones", "amorperiodo");
			break;
		}
		case "amorprimerperiodo": {
			var metodo:String = cursor.valueBuffer("metodo");
			if (metodo == "Lineal") {
				var amorPeriodo:Number = parseFloat(cursor.valueBuffer("amorperiodo"));
				if (!amorPeriodo)
					amorPeriodo = 0;
				var fechaAdquisicion = cursor.isNull("fechainicio") ? cursor.valueBuffer("fecha") : cursor.valueBuffer("fechainicio");
				
				var tipoPeriodo:String = cursor.valueBuffer("periodo");

				var periodo:Number = fechaAdquisicion.getYear();
				var fechaFinPeriodo:Date = _i.calcularFechaFinPeriodo(fechaAdquisicion,tipoPeriodo);

				var dias = parseFloat(util.daysTo(fechaAdquisicion, fechaFinPeriodo)) + 1;
				var diasPeriodo = _i.calcularDiasPeriodo(fechaAdquisicion, tipoPeriodo);
debug("dias " + dias);
debug("diasPeriodo " + diasPeriodo);
				res = amorPeriodo * dias / diasPeriodo;
			}
			break;
		}
		case "amorultimoperiodo": {
			var metodo:String = cursor.valueBuffer("metodo");
			if (metodo == "Lineal") {
				var vAmortizable = parseFloat(cursor.valueBuffer("valoramortizable"));
				vAmortizable = isNaN(vAmortizable) ? 0 : vAmortizable;
				var amorPeriodo = parseFloat(cursor.valueBuffer("amorperiodo"));
				amorPeriodo = isNaN(amorPeriodo) ? 0 : amorPeriodo;
				var numPeriodos = parseFloat(cursor.valueBuffer("numperiodos"));
				numPeriodos = isNaN(numPeriodos) ? 0 : numPeriodos;
				var amorPrimerPeriodo = parseFloat(cursor.valueBuffer("amorprimerperiodo"));
				amorPrimerPeriodo = isNaN(amorPrimerPeriodo) ? 0 : amorPrimerPeriodo;
				res = vAmortizable - (amorPeriodo * (numPeriodos - 1)) - amorPrimerPeriodo;
				res = res < 0 ? 0 : res;
			}
			break;
		}			
		case "totalamortizado": {
			res = parseFloat(util.sqlSelect("co_dotaciones","SUM(importe)","codamortizacion = '" + cursor.valueBuffer("codamortizacion") + "'"));
			if (!res) {
				res = 0;
			}
			break;
		}
		case "pendiente": {
			var vAmortizable:Number = parseFloat(cursor.valueBuffer("valoramortizable"));
			if (!vAmortizable) {
				vAmortizable = 0;
			}
			var totalAmortizado:Number = parseFloat(cursor.valueBuffer("totalamortizado"));
			if (!totalAmortizado) {
				totalAmortizado = 0;
			}
			res = vAmortizable - totalAmortizado;
			break;
		}
		case "estado": {
			var pendiente = cursor.valueBuffer("pendiente");
			if (cursor.valueBuffer("estado") == "En Curso" && cursor.valueBuffer("bloqueado")) {
				res = "Suspendida";
			} else if (cursor.valueBuffer("estado") == "Suspendida" && !cursor.valueBuffer("bloqueado")) {
				res = pendiente == 0 ? "Terminada" : "En Curso";
			} else {
				res = pendiente == 0 ? "Terminada" : "En Curso";
			}
// 			var pendiente:Number = parseFloat(cursor.valueBuffer("pendiente"));
// 			if (!pendiente) {
// 				pendiente = 0;
// 			}
// 			if (pendiente == 0) {
// 				res = "Terminada";
// 			} else {
// 				if (cursor.valueBuffer("estado") == "Terminada") {
// 					res = "En Curso";
// 				} else {
// 					res = cursor.valueBuffer("estado");
// 				}
// 			}
			break;
		}
	}

	return res;
}

function oficial_dameListaSubcuentas(codGrupoContableAmo)
{
	var _i = this.iface;
	var q = new FLSqlQuery;
	q.setSelect("codsubcuentaele, codsubcuentagas, codsubcuentaamo");
	q.setFrom("co_gruposcontablesamo");
	q.setWhere("codgrupo = '" + codGrupoContableAmo + "'");
	if (!q.exec()) {
		return false;
	}
	if (!q.first()) {
		return "'Not Found'";
	}
	var valor = "";
	valor += ("'" + q.value("codsubcuentaele") + "'");
	valor += q.value("codsubcuentaamo") != "" ? (", '" + q.value("codsubcuentaamo") + "'") : "";
debug("lista = " + valor);
	return valor;
}

function oficial_tbnCerrarAmor_clicked()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var estado = cursor.valueBuffer("estado");
	switch (estado) {
		case "Cerrada": {
			if (!_i.reabrirAmortizacion()) {
				return false;
			}
			break;
		}
		case "Suspendida":
		case "En Curso":
		case "Terminada":{
			if (!_i.cerrarAmortizacion()) {
				return false;
			}
			break;
		}
	}
}

function oficial_reabrirAmortizacion()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var res = MessageBox.warning(sys.translate("Va a reabrir la amortización. Esto borrará el asiento de cierre.\n¿Desea continuar?"), MessageBox.Yes, MessageBox.No, MessageBox.NoButton, "AbanQ");
	if (res != MessageBox.Yes) {
		return false;
	}
	
	cursor.setValueBuffer("estado", "En Curso");
	cursor.setValueBuffer("estado", _i.calculateField("estado")); /// Pasa a suspendida si es necesario
	sys.setObjText(this, "fdbFechaCierre", "NULL");
	cursor.setNull("fechacierre");
	cursor.setNull("idasientocierre");
	this.child("tdbPartidasCierre").refresh();
	sys.setObjText(this, "fdbNumAsientoCierre", "");
	sys.setObjText(this, "fdbEjercicioCierre", "");
	return true;
}

function oficial_cerrarAmortizacion()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	if (cursor.isNull("fechacierre")) {
		MessageBox.warning(sys.translate("Debe informar la fecha de cierre"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
		return false;
	}
	
	var res = MessageBox.warning(sys.translate("Va a cerrar la amortización. El asiento de cierre se generará al aceptar el formulario.\n¿Desea continuar?"), MessageBox.Yes, MessageBox.No, MessageBox.NoButton, "AbanQ");
	if (res != MessageBox.Yes) {
		return false;
	}
	
	cursor.setValueBuffer("estado", "Cerrada");
	return true;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

