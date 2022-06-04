/***************************************************************************
                 tpv_lineasvale.qs  -  description
                             -------------------
    begin                : mie nov 15 2006
    copyright            : Por ahora (C) 2006 by InfoSiAL S.L.
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
    function init() {
		this.ctx.interna_init();
	}
	function validateForm() {
		return this.ctx.interna_validateForm();
	}
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
	var tdbVentas:Object;
	function oficial( context ) { interna( context ); }
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
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
/** \C Las líneas de val permiten introducir artículos que el cliente devuelve y que, por tanto, pueden volver a integrarse en el stock. El almacén al que se asociarán por defecto los artículos devueltos será el asociado al punto de venta actual
*/
function interna_init()
{
	var util= new FLUtil();
	var cursor= this.cursor();

	var curRel= cursor.cursorRelation();
	var idComanda= curRel.valueBuffer("idtpv_comanda");
	if (idComanda && idComanda != "") {
		this.child("fdbIdLinea").setFilter("idtpv_comanda = " + idComanda);
	}

	switch (cursor.modeAccess()) {
		case cursor.Insert: {
			var codTerminal = flfact_tpv.iface.pub_valorDefectoTPV("codterminal");
			if (codTerminal) {
				this.child("fdbCodAlmacen").setValue(util.sqlSelect("tpv_puntosventa", "codalmacen", "codtpv_puntoventa ='" + codTerminal + "'"));
			}
			break;
		}
		case cursor.Edit: {
			this.child("fdbCodAlmacen").setDisabled(true);
			break;
		}
	}
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
}

function interna_validateForm()
{
	var util= new FLUtil();
	var cursor= this.cursor();

	/** \C Se avisa al usuario si la cantidad devuelta es superior a la cantidad de la correspondiente línea de venta
	\end */
	var idLinea= cursor.valueBuffer("idtpv_linea");
	if (idLinea && idLinea != "") {
		var cantidadLinea= util.sqlSelect("tpv_lineascomanda", "cantidad", "idtpv_linea = " + idLinea);
		if (cantidadLinea) {
			if (parseFloat(cursor.valueBuffer("cantidad")) > parseFloat(cantidadLinea)) {
				var res= MessageBox.warning(util.translate("scripts", "La cantidad devuelta supera la cantidad de la correspondiente línea de venta (%1).\n¿Desea continuar?").arg(cantidadLinea), MessageBox.No, MessageBox.Yes);
				if (res != MessageBox.Yes)
					return false;
			}
		}
	}
	return true;
}

function interna_calculateField(fN:String)
{
	var valor:String;
	var util= new FLUtil;
	var cursor= this.cursor();
	switch (fN) {
		case "pvptotal": {
			var idLinea= cursor.valueBuffer("idtpv_linea");
			var porIva= util.sqlSelect("tpv_lineascomanda", "iva", "idtpv_linea = " + idLinea);
			if (!porIva || isNaN(porIva))
				porIva = 0;
			var netoTotal= util.sqlSelect("tpv_lineascomanda", "pvptotal", "idtpv_linea = " + idLinea);
			if (!netoTotal || isNaN(netoTotal))
				netoTotal = 0;
			valor = parseFloat(netoTotal) * (100 + parseFloat(porIva)) / 100;
			valor = util.roundFieldValue(valor, "tpv_lineasvale", "pvptotal");
			break;
		}
	}
	return valor;
}

/** @class_definition oficial */
/////////////////////////////////////////////////////////////////
//// OFICIAL ////////////////////////////////////////////////////
function oficial_bufferChanged(fN:String)
{
	var cursor= this.cursor();
	switch (fN) {
		case "idtpv_linea": {
			this.child("fdbPvpTotal").setValue(this.iface.calculateField("pvptotal"));
			break;
		}
	}
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
