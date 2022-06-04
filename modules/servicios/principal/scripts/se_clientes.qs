/***************************************************************************
                 se_clientes.qs  -  description
                             -------------------
    begin                : lun jun 20 2005
    copyright            : (C) 2005 by InfoSiAL S.L.
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
////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/** @class_declaration interna */
//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
class interna {
    var ctx:Object;
    function interna( context ) { this.ctx = context; }
    function init() { this.ctx.interna_init(); }
	function calculateField(fN:String) {
		return this.ctx.interna_calculateField(fN);
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
    function oficial( context ) { interna( context ); } 
	function cambioChkPendientes() {	return this.ctx.oficial_cambioChkPendientes(); }
// 	function calcularSaldo() {	
// 		return this.ctx.oficial_calcularSaldo(); 
// 	}
	function accionesAutomaticas() {
		return this.ctx.oficial_accionesAutomaticas();
	}
	function realizarAccionAutomatica(accion:Array) {
		return this.ctx.oficial_realizarAccionAutomatica(accion);
	}
	function responderMail() {
		return this.ctx.oficial_responderMail();
	}
	function commonCalculateField(fN:String, cursor:FLSqlCursor) {
		return this.ctx.oficial_commonCalculateField(fN, cursor);
	}
	function tdbIncidencias_bufferCommited() {
		return this.ctx.oficial_tdbIncidencias_bufferCommited();
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
    function pub_commonCalculateField(fN:String, cursor:FLSqlCursor) {
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

/** \C
En la pestaña incidencias podemos ver sólo las incedencias pendientes
seleccionando la opción Sólo Pendientes
*/
function interna_init()
{
	connect(this.child("chkPendientes"), "clicked()", this, "iface.cambioChkPendientes");
	connect(this.child("pbnResponder"), "clicked()", this, "iface.responderMail" );
	connect(this.child("tdbIncidencias").cursor(), "bufferCommited()", this, "iface.tdbIncidencias_bufferCommited");
	connect(this, "formReady()", this, "iface.accionesAutomaticas");

	this.child("chkPendientes").checked = false;
}

function interna_calculateField(fN:String)
{
	var cursor= this.cursor();
	var util= new FLUtil();
	var valor:String;
	
	valor = this.iface.commonCalculateField(fN, cursor);
// 	switch(fN) {
// 		case "horasfact":
// 		case "horastrab":
// 		case "beneficiohora": {
// 			valor = this.iface.commonCalculateField(fN, cursor);
// 			break;
// 		}
// 	}
	return valor;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D Filtra las tabla de incidencias por incidencias pendientes de ese subproyecto si está activa la opcion de SóloPendientes, si no lo está la filta mostrando todas las incidencias del subproyecto y refresca la tabla
\end */
function oficial_cambioChkPendientes()
{ 
	var filtro = this.child("chkPendientes").checked == true ? 
		"estado = 'Pendiente'" :
		"";
		
	this.child("tdbIncidencias").setFilter(filtro);
	this.child("tdbIncidencias").refresh();
}

/** \D Lanza la respuesta a una comunicación seleccionada en el formulario maestro.
El id de dicha comunicacion queda registrado en la variable codigoConResp, y a continuación
se abre el formulario de inserción de una nueva comunicación.
\end */
function oficial_responderMail()
{
	var util= new FLUtil();
	var curCom= this.child("tdbComunicaciones").cursor();	

 	util.writeSettingEntry("scripts/flservppal/codigoComResp", curCom.valueBuffer("codigo"));
	
	this.child("toolButtomInsertCom").animateClick();
}	

// function oficial_calcularSaldo()
// {
// 	var cursor= this.cursor();
// 	var saldo= flservppal.iface.pub_calcularSaldoCliente(cursor.valueBuffer("codcliente"));
// 	if (isNaN(saldo)) {
// 		return false;
// 	}
// 	cursor.setValueBuffer("saldocreditos", saldo);
// }

function oficial_accionesAutomaticas()
{
	var acciones= flcolaproc.iface.pub_accionesAuto();
	if (!acciones) {
		return;
	}
	var i= 0;
	while (i < acciones.length && acciones[i]["usada"]) { i++; }
	if (i == acciones.length) {
		return;
	}

	while (i < acciones.length && acciones[i]["contexto"] == "se_clientes") {
		if (!this.iface.realizarAccionAutomatica(acciones[i])) {
			break;
		}
		i++;
	}
}

/** \D Realizar una determinada acción.
@return: Se devuelve false si algo falla o si la acción implica que no debe realizarse ninguna acción subsiguiente en el contexto actual.
\end */ 
function oficial_realizarAccionAutomatica(accion:Array)
{
debug("oficial_realizarAccionAutomatica " + accion["accion"]);
	var util= new FLUtil;
	var cursor= this.cursor();

	switch (accion["accion"]) {
		case "insertar_comunicacion": {
			accion["usada"] = true;
			var curComunicaciones= this.child("tdbComunicaciones").cursor();
			curComunicaciones.insertRecord();
			break;
		}
		case "insertar_incidencia": {
debug("En insertar_incidencia");
			accion["usada"] = true;
			var curIncidencias= this.child("tdbIncidencias").cursor();
			curIncidencias.insertRecord();
			break;
		}
		default: {
			return false;
		}
	}
	return true;
}

function oficial_commonCalculateField(fN:String, cursor:FLSqlCursor)
{
	var util= new FLUtil;
	var valor= "";
	switch (fN) {
		case "horasfact": {
			valor = util.sqlSelect("se_incidencias i INNER JOIN se_horasfacturadas hf ON i.codigo = hf.codincidencia", "SUM(hf.horas)", "i.codcliente= '" + cursor.valueBuffer("codcliente") + "'", "se_incidencias,se_horasfacturadas");
			if (!valor || isNaN(valor)) {
				valor = 0;
			}
			break;
		}
		case "horastrab": {
			valor = util.sqlSelect("se_horastrabajadas", "SUM(horas)", "codcliente= '" + cursor.valueBuffer("codcliente") + "'");
			if (!valor || isNaN(valor)) {
				valor = 0;
			}
			break;
		}
		case "beneficiohora": {
			var hTrab= parseFloat(cursor.valueBuffer("horastrab"));
			hTrab = isNaN(hTrab) ? 0 : hTrab;
			var hFact= parseFloat(cursor.valueBuffer("horasfact"));
			hFact = isNaN(hFact) ? 0 : hFact;
			if (hFact == 0) {
				valor = -999;
			} else {
				valor = (hFact - hTrab) * 100 / hFact;
				valor = util.roundFieldValue(valor, "clientes", "beneficiohora");
			}
			break;
		}
		case "saldocreditos": {
			var codCliente= cursor.valueBuffer("codcliente");
			valor = util.sqlSelect("se_incidencias", "SUM(precio)", "codcliente = '" + codCliente + "' AND enbolsa = true");
			valor = isNaN(valor) ? 0 : valor;
			valor = util.roundFieldValue(valor, "clientes", "saldocreditos");
			break;
		}
		case "facturado2010": {
			var codCliente = cursor.valueBuffer("codcliente");
			valor = util.sqlSelect("facturascli", "SUM(total)", "codcliente = '" + codCliente + "' AND fecha >= '2010-01-01'");
			valor = isNaN(valor) ? 0 : valor;
			valor = util.roundFieldValue(valor, "clientes", "facturado2010");
			break;
		}
		case "horastrab2010": {
			valor = util.sqlSelect("se_horastrabajadas", "SUM(horas)", "codcliente= '" + cursor.valueBuffer("codcliente") + "' AND fecha >= '2010-01-01'");
			valor = isNaN(valor) ? 0 : valor;
			valor = util.roundFieldValue(valor, "clientes", "horastrab2010");
			break;
		}
		case "brutohora2010": {
			var facturado = parseFloat(cursor.valueBuffer("facturado2010"));
			facturado = isNaN(facturado) ? 0 : facturado;
			var trabajado = parseFloat(cursor.valueBuffer("horastrab2010"));
			trabajado = isNaN(trabajado) ? 0 : trabajado;
			valor = trabajado != 0 ? facturado / trabajado : 0;
			valor = util.roundFieldValue(valor, "clientes", "brutohora2010");
			break;
		}
	}
	return valor;
}

function oficial_tdbIncidencias_bufferCommited()
{
	this.child("fdbHorasFact").setValue(this.iface.calculateField("horasfact"));
	this.child("fdbHorasTrab").setValue(this.iface.calculateField("horastrab"));
	this.child("fdbBeneficioHora").setValue(this.iface.calculateField("beneficiohora"));
	this.child("fdbSaldoCreditos").setValue(this.iface.calculateField("saldocreditos"));
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
