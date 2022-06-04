/***************************************************************************
                 rh_nominas.qs  -  description
                             -------------------
    begin                : jue jul 26 2007
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
	function calculateField(fN:String):String { 
		return this.ctx.interna_calculateField(fN); 
	}
	function validateForm():String { 
		return this.ctx.interna_validateForm();
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	function oficial( context ) { interna( context ); }
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function obtenerEstado(codNomina:String):String {
		return this.ctx.oficial_obtenerEstado(codNomina);
	}
	function quitarDieta() {
		return this.ctx.oficial_quitarDieta();
	}
	function vincularDieta() {
		return this.ctx.oficial_vincularDieta();
	}
	function obtenerTotalDietas() {
		return this.ctx.oficial_obtenerTotalDietas();
	}
	function commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.ctx.oficial_commonCalculateField(fN, cursor);
	}
	function habilitarDieta() {
		return this.ctx.oficial_habilitarDieta();
	}
	function inhabilitarDieta() {
		return this.ctx.oficial_inhabilitarDieta();
	}
	function inhabilitarHorasExtra() {
		return this.ctx.oficial_inhabilitarHorasExtra();
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
	function pub_commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.commonCalculateField(fN, cursor);
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
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil;

	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this.child("tdbPagosNomina").cursor(), "bufferCommited()", this, "iface.obtenerEstado");
	connect(this.child("tdbPagosDieta").cursor(), "bufferCommited()", this, "iface.inhabilitarDieta");
	connect(this.child("tdbPagosHE").cursor(), "bufferCommited()", this, "iface.inhabilitarHorasExtra");
	connect(this.child("tdbDietas").cursor(), "bufferCommited()", this, "iface.obtenerTotalDietas");
	connect(this.child("tbnQuitarDieta"), "clicked()", this, "iface.quitarDieta");
	connect(this.child("tbnVincularDieta"), "clicked()", this, "iface.vincularDieta");

	if (cursor.modeAccess() == cursor.Insert || cursor.modeAccess() == cursor.Edit) 
		this.child("fdbCodEjercicio").setValue(flfactppal.iface.pub_ejercicioActual());

	if (cursor.modeAccess() == cursor.Insert) {
		var diaUno:Date = new Date();
		diaUno = cursor.valueBuffer("fechanomina");
		diaUno = diaUno.setDate(1);
		this.child("fdbFechaNomina").setValue(diaUno);
	} else {
		this.iface.bufferChanged("estadonomina");
	}
	this.child("tdbPartidas").setReadOnly(true);
	
	this.iface.habilitarDieta();
	this.iface.inhabilitarDieta();
	this.iface.inhabilitarHorasExtra();
}

function interna_calculateField(fN:String):String
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	var res:String = this.iface.commonCalculateField(fN, cursor);
	
	return res;
}

/** \C La subcuenta establecida debe existir en la tabla de subcuentas
\end */
function interna_validateForm():Boolean
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var fechaNomina = cursor.valueBuffer("fechanomina");
	var codEmpleado:String = cursor.valueBuffer("codempleado");
	var codNomina:String = cursor.valueBuffer("codnomina");

	if (util.sqlSelect("rh_nominas","codnomina","codnomina <> '" + codNomina + "' AND fechanomina = '" + fechaNomina + "' AND codempleado = '" + codEmpleado + "'")) {
		MessageBox.warning(util.translate("scripts", "Ya existe una nómina para el empleado %1 y la fecha %2.").arg(codEmpleado).arg(util.dateAMDtoDMA(fechaNomina)), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	if (util.sqlSelect("rh_dietas", "iddieta", "codempleado = '" + codEmpleado + "' AND codnomina IS NULL")) {
		var res:Number = MessageBox.warning(util.translate("scripts", "Existen dietas pendientes de asignar a nóminas para el empleado seleccionado.\n¿Desea continuar de todas formas?"), MessageBox.Yes, MessageBox.No);
		if (res != MessageBox.Yes)
			return false;
	}

	return true;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_bufferChanged(fN)
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	switch(fN) {
		case "codempleado": { 
			this.child("fdbSueldoBruto").setValue(this.iface.calculateField("sueldobruto"));
			this.child("fdbSegSocial").setValue(this.iface.calculateField("segsocial"));
			this.child("fdbCuotaPatronalSS").setValue(this.iface.calculateField("cuotapatronalss"));
			this.child("fdbIrpf").setValue(this.iface.calculateField("irpf"));
			this.child("fdbDescripcion").setValue(this.iface.calculateField("descripcion"));
			this.child("fdbPrecioHE").setValue(this.iface.calculateField("preciohe"));
			break;
		}
		case "sueldobruto":
		case "segsocial":
		case "irpf":
		case "dietas": {
			this.child("fdbSueldoNeto").setValue(this.iface.calculateField("sueldoneto"));
			break;
		}
		case "fechanomina": { 
			this.child("fdbDescripcion").setValue(this.iface.calculateField("descripcion"));
			break;
		}
		case "estadonomina": {
			switch (cursor.valueBuffer("estadonomina")) {
				case "Emitida": {
					this.child("gbxPrincipal").setEnabled(true);
					this.child("tbwNomina2").setTabEnabled("dietas", true);
					this.child("tbwNomina2").setTabEnabled("horasextra", true);
					break;
				}
				case "Pagada": {
					this.child("gbxPrincipal").setEnabled(false);
					this.child("tbwNomina2").setTabEnabled("dietas", false);
					this.child("tbwNomina2").setTabEnabled("horasextra", false);
					break;
				}
			}
		}
		case "horasextra":
		case "preciohe": {
			this.child("fdbTotalHE").setValue(this.iface.calculateField("totalhe"));
			break;
		}
		case "pagoindependientedieta": {
			this.iface.habilitarDieta();
			this.child("fdbSueldoNeto").setValue(this.iface.calculateField("sueldoneto"));
			break;
		}
	}
}

/** \D
Calcula el estado de la nómina en función de los pagos y devoluciones
@param	codNomina: Código de la nómina cuyo estado se desea calcular
@return	Estado de la nómina
\end */
function oficial_obtenerEstado(codNomina:String):String
{
	var estado:String = this.iface.calculateField("estadonomina");

	this.child("fdbEstadoNomina").setValue(estado);
}

function oficial_inhabilitarDieta()
{
	var util = new FLUtil();
	var cursor = this.cursor();
	var pagoDieta = util.sqlSelect("rh_pagosdieta", "idpago", "codnomina = '" + cursor.valueBuffer("codnomina") + "'");
	if (pagoDieta && pagoDieta != "") {
		this.child("gbxDietas").setEnabled(false);
	} else {
		this.child("gbxDietas").setEnabled(true);
	}
}

function oficial_inhabilitarHorasExtra()
{
	var util = new FLUtil();
	var cursor = this.cursor();
	var pagoHE = util.sqlSelect("rh_pagoshe", "idpago", "codnomina = '" + cursor.valueBuffer("codnomina") + "'");
	if (pagoHE && pagoHE != "") {
		this.child("gbxHorasExtra").setEnabled(false);
	} else {
		this.child("gbxHorasExtra").setEnabled(true);
	}
}

function oficial_vincularDieta()
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();
	
	var f:Object = new FLFormSearchDB("rh_dietas");
	var curDietas:FLSqlCursor = f.cursor();
	
	curDietas.setMainFilter("codempleado = '" + cursor.valueBuffer("codempleado") + "' AND codnomina IS NULL");
	f.setMainWidget();
	var idDieta:String = f.exec("iddieta");

	if (!idDieta)
		return;

	var codNomina:String = cursor.valueBuffer("codnomina");
	if (!util.sqlUpdate("rh_dietas", "codnomina", codNomina, "iddieta = " + idDieta))
		return;

	this.child("tdbDietas").refresh();
	this.iface.obtenerTotalDietas();
}

function oficial_quitarDieta()
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();
	
	var curDietas:FLSqlCursor = this.child("tdbDietas").cursor();

	var idDieta:String = curDietas.valueBuffer("iddieta");
	if (!idDieta)
		return;

	curDietas.select("iddieta = " + idDieta);
	if (!curDietas.first())
		return;
	curDietas.setModeAccess(curDietas.Edit);
	curDietas.refreshBuffer();
	curDietas.setNull("codnomina");
	if (!curDietas.commitBuffer())
		return;
	
	this.child("tdbDietas").refresh();
//	this.child("fdbDietas").setValue(this.iface.calculateField("dietas"));
}

function oficial_obtenerTotalDietas()
{
	this.child("fdbDietas").setValue(this.iface.calculateField("dietas"));
}

function oficial_habilitarDieta()
{
	var cursor = this.cursor();
	if (cursor.valueBuffer("pagoindependientedieta")) {
		this.child("fdbDietas").setShowEditor(false);
		this.child("fdbDietas").setShowAlias(false);
		this.child("fdbDietas2").setShowEditor(true);
		this.child("fdbDietas2").setShowAlias(true);
		this.child("twDietas").setTabEnabled("pagosdietas", true);
	} else {
		this.child("fdbDietas2").setShowEditor(false);
		this.child("fdbDietas2").setShowAlias(false);
		this.child("fdbDietas").setShowEditor(true);
		this.child("fdbDietas").setShowAlias(true);
		this.child("twDietas").setTabEnabled("pagosdietas", false);
	}
}

function oficial_commonCalculateField(fN:String, cursor:FLSqlCursor):String
{
	var util:FLUtil = new FLUtil();
	var res:String;
	
	switch (fN) {
		case "sueldobruto": {
			res = util.sqlSelect("rh_empleados","sueldobruto","codempleado = '" + cursor.valueBuffer("codempleado") + "'");
			break;
		}
		case "segsocial": {
			res = util.sqlSelect("rh_empleados","segsocial","codempleado = '" + cursor.valueBuffer("codempleado") + "'");
			break;		
		}
		case "cuotapatronalss": {
			res = util.sqlSelect("rh_empleados","cuotapatronalss","codempleado = '" + cursor.valueBuffer("codempleado") + "'");
			break;		
		}
		case "irpf": {
			res = util.sqlSelect("rh_empleados","irpf","codempleado = '" + cursor.valueBuffer("codempleado") + "'");
			break;
		}
		case "sueldoneto": {
			if (cursor.valueBuffer("pagoindependientedieta")) {
				res = parseFloat(cursor.valueBuffer("sueldobruto")) - parseFloat(cursor.valueBuffer("segsocial")) - parseFloat(cursor.valueBuffer("irpf"));
			} else {
				res = parseFloat(cursor.valueBuffer("sueldobruto")) - parseFloat(cursor.valueBuffer("segsocial")) - parseFloat(cursor.valueBuffer("irpf")) + parseFloat(cursor.valueBuffer("dietas"));
			}
			res = util.roundFieldValue(res, "rh_nominas", "sueldoneto");
			break;
		}
		case "descripcion": {
			var fechaNomina:String = util.dateAMDtoDMA(cursor.valueBuffer("fechanomina"));
			fechaNomina = fechaNomina.right(7);
			var nombreEmpleado:String = util.sqlSelect("rh_empleados","nombre","codempleado = '" + cursor.valueBuffer("codempleado") + "'");
			if (!nombreEmpleado || nombreEmpleado == "")
				return false;
			var apellidosEmpleado:String = util.sqlSelect("rh_empleados","apellidos","codempleado = '" + cursor.valueBuffer("codempleado") + "'");
			if (!apellidosEmpleado || apellidosEmpleado == "")
				return false;
			res = fechaNomina + " - " + nombreEmpleado + " " + apellidosEmpleado;
			break;
		}	
		case "estadonomina": {
			res = "Emitida";
			var curPagos:FLSqlCursor = new FLSqlCursor("rh_pagosnomina");
			curPagos.select("codnomina = '" + cursor.valueBuffer("codnomina") + "' ORDER BY fecha DESC, idpago DESC");
			if (curPagos.first()) {
				curPagos.setModeAccess(curPagos.Browse);
				curPagos.refreshBuffer();
				if (curPagos.valueBuffer("tipo") == "Pago")
					res = "Pagada";
			}
			break;
		}
		case "dietas": {
			res = util.sqlSelect("rh_dietas", "SUM(total)", "codnomina = '" + cursor.valueBuffer("codnomina") + "'");
			if (!res)
				res = 0;
			res = util.roundFieldValue(res, "rh_nominas", "dietas");
			break;
		}
		case "dietasptes": {
			res = util.sqlSelect("rh_dietas", "SUM(total)", "codempleado = '" + cursor.valueBuffer("codempleado") + "' AND codnomina IS NULL");
			if (!res)
				res = 0;
			res = util.roundFieldValue(res, "rh_nominas", "dietas");
			break;
		}
		case "preciohe": {
			res = util.sqlSelect("rh_empleados","preciohe","codempleado = '" + cursor.valueBuffer("codempleado") + "'");
			break;
		}
		case "totalhe": {
			res = parseFloat(cursor.valueBuffer("horasextra")) * parseFloat(cursor.valueBuffer("preciohe"));
			res = util.roundFieldValue(res, "rh_nominas", "totalhe");
			break;
		}
	}
	return res;
}

//// OFICIAL ////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
