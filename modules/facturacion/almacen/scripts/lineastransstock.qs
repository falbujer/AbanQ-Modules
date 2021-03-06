/***************************************************************************
                 lineastransstock.qs  -  description
                             -------------------
    begin                : mar sep 27 2006
    copyright            : (C) 2006 by InfoSiAL S.L.
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
    function calculateField(fN,cursor) { return this.ctx.interna_calculateField(fN,cursor); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var canPrevia:Number;
	function oficial( context ) { interna( context ); }
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function refrescarStock() {
		return this.ctx.oficial_refrescarStock();
	}
	function commonCalculateField(fN, cursor) {
		return this.ctx.oficial_commonCalculateField(fN, cursor);
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
	function pub_commonCalculateField(fN, cursor) {
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
\end */
function interna_init()
{
	var _i = this.iface;
	var cursor = this.cursor();

	connect(cursor, "bufferChanged(QString)", _i, "bufferChanged");
	_i.canPrevia = cursor.valueBuffer("cantidad");
	_i.refrescarStock();

	switch (cursor.modeAccess()) {
		case cursor.Edit: {
			this.child("fdbReferencia").setDisabled(true);
			break;
		}
		case cursor.Insert: {
			this.child("fdbNumLinea").setValue(_i.calculateField("numlinea"));
			break;
		}
	}
}

function interna_calculateField(fN)
{
	var _i = this.iface;
	var cursor = this.cursor();
	var valor;

	switch (fN) {
		default: {
			valor = _i.__commonCalculateField(fN, cursor);
		}
	}
	return valor;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_bufferChanged(fN:String)
{
	var cursor:FLSqlCursor = this.cursor();

	switch (fN) {
		case "referencia":
		case "cantidad": {
			this.iface.refrescarStock();
			break;
		}
	}
}

/** \D Muestra las cantidades inicial y final para los almacenes de origen y destino
\end */
function oficial_refrescarStock()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	var codAlmaOrigen:String = cursor.cursorRelation().valueBuffer("codalmaorigen");
	var codAlmaDestino:String = cursor.cursorRelation().valueBuffer("codalmadestino");
	this.child("lblAlmacenOrigen").text = util.translate("scripts", "Almac?n origen (%1)").arg(codAlmaOrigen);
	this.child("lblAlmacenDestino").text = util.translate("scripts", "Almac?n destino (%1)").arg(codAlmaDestino);

	var referencia:String = cursor.valueBuffer("referencia");
	if (!referencia || referencia == "") {
		this.child("lblCanInicialOrigen").text = "-";
		this.child("lblCanFinalOrigen").text = "-";
		this.child("lblCanInicialDestino").text = "-";
		this.child("lblCanFinalDestino").text = "-";
		return;
	}

	var cantidad:Number = parseFloat(cursor.valueBuffer("cantidad"));
	if (!cantidad || cantidad== "") {
		cantidad = 0;
	}

	var cantidadOrigen:Number = util.sqlSelect("stocks", "cantidad", "codalmacen = '" + codAlmaOrigen + "' AND referencia = '" + referencia + "'");
	if (!cantidadOrigen || isNaN(cantidadOrigen))
		cantidadOrigen = 0;
	cantidadOrigen += parseFloat(this.iface.canPrevia);

	this.child("lblCanInicialOrigen").text = cantidadOrigen;
	this.child("lblCanFinalOrigen").text = cantidadOrigen - cantidad;

	var cantidadDestino:Number = util.sqlSelect("stocks", "cantidad", "codalmacen = '" + codAlmaDestino + "' AND referencia = '" + referencia + "'");
	if (!cantidadDestino || isNaN(cantidadDestino))
		cantidadDestino = 0;
	cantidadDestino -= parseFloat(this.iface.canPrevia);

	this.child("lblCanInicialDestino").text = cantidadDestino;
	this.child("lblCanFinalDestino").text = cantidadDestino + cantidad;
}

function oficial_commonCalculateField(fN, cursor)
{
	var _i = this.iface;
	var valor;

	switch (fN) {
		case "numlinea": {
			var id = cursor.valueBuffer("idtrans");
			valor = parseInt(AQUtil.sqlSelect("lineastransstock", "numlinea", "idtrans = " + id + " ORDER BY numlinea DESC LIMIT 1"));
			if (isNaN(valor)) {
				valor = 0;
			}
			valor++;
			break;
		}
	}
	return valor;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
