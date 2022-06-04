/***************************************************************************
                 lineasinvetario.qs  -  description
                             -------------------
    begin                : jue may 19 2011
    copyright            : (C) 2011 by InfoSiAL S.L.
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
	function acceptedForm() { return this.ctx.interna_acceptedForm(); }
	function calculateField(fN) {
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
    function habilitarPorModo() {
		return this.ctx.oficial_habilitarPorModo();
	}
	function bufferChanged(fN) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function validarCantidades() {
		return this.ctx.oficial_validarCantidades();
	}
	function informarStock() {
		return this.ctx.oficial_informarStock();
	}
	function validarDuplicidad() {
		return this.ctx.oficial_validarDuplicidad();
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
/** \C 
En modo inserción, los valores de --cantidadini-- y --cantidadfin-- aparecen informados con la cantidad actual

En modo edición, no es posible cambiar los valores de --cantidadfin--, --fecha-- y --motivo--
\end */
function interna_init()
{
	var cursor = this.cursor();
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged()");
	
	this.iface.habilitarPorModo();
}

function interna_validateForm():Boolean
{
	if (!this.iface.informarStock()) {
		return false;
	}
	if (!this.iface.validarCantidades()) {
		return false;
	}
	if (!this.iface.validarDuplicidad()) {
		return false;
	}
	return true;
}

function interna_calculateField(fN)
{
	var util = new FLUtil();
	var cursor = this.cursor();
	var curInv = cursor.cursorRelation();
	var valor;
	switch (fN) {
		case "idstock": {
			var referencia = cursor.valueBuffer("referencia");
			if (!util.sqlSelect("articulos", "referencia" , "referencia = '" + referencia + "'")) {
				return false;
			}
			var codAlmacen = curInv.valueBuffer("codalmacen");
			valor = util.sqlSelect("stocks", "idstock", "referencia = '" + referencia + "' AND codalmacen = '" + codAlmacen + "'");
			if (!valor) {
				var oArticulo = new Object;
				oArticulo["referencia"] = referencia;
				valor = flfactalma.iface.pub_crearStock( codAlmacen, oArticulo );
			}
			break;
		}
		case "cantidadini": {
			var idStock = cursor.valueBuffer("idstock");
			valor = util.sqlSelect("stocks", "cantidad", "idstock = " + idStock);
			break;
		}
	}
	return valor;
}

/** \D
La --cantidadfin-- se actualiza en las regularizaciones de stocks
\end */
function interna_acceptedForm()
{
/*
		var cursor:FLSqlCursor = this.cursor();
		if (cursor.modeAccess() == cursor.Insert)
				formRecordregstocks.iface.pub_cambiarCantidad(cursor.valueBuffer("cantidadfin"));
*/
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_habilitarPorModo()
{
	var cursor = this.cursor();
	var insercion = cursor.modeAccess() == cursor.Insert;
	this.child("fdbCantidadFin").setDisabled(!insercion);
	this.child("fdbFecha").setDisabled(!insercion);
	this.child("fdbHora").setDisabled(!insercion);
	this.child("fdbReferencia").setDisabled(!insercion);
}

function oficial_bufferChanged(fN)
{
	var cursor = this.cursor();
	var curInv = cursor.cursorRelation();
	switch (fN) {
		case "referencia": {
			break;
		}
	}
}

function oficial_validarCantidades()
{
	/** \C
	El valor de --cantidadfin-- debe ser mayor que cero
	\end */
	var util = new FLUtil();
	var cursor = this.cursor();
	var cantidadFin = cursor.valueBuffer("cantidadfin");
	
	if (cantidadFin < 0) {
		MessageBox.warning(util.translate("scripts", "La cantidad debe ser mayor que cero"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
	return true;
}

function oficial_informarStock()
{
	var cursor = this.cursor();
	if (cursor.modeAccess() != cursor.Insert) {
		return true;
	}
	var util = new FLUtil();
	var idStock = this.iface.calculateField("idstock");
	if (!idStock) {
		MessageBox.warning(util.translate("scripts", "Error al calcular el identificado de stock para el artículo y almacén indicados"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
	cursor.setValueBuffer("idstock", idStock);
	cursor.setValueBuffer("cantidadini", this.iface.calculateField("cantidadini"));
	return true;
}

function oficial_validarDuplicidad()
{
	var util = new FLUtil();
	var cursor = this.cursor();
	var idStock = cursor.valueBuffer("idstock");
	var codInventario = cursor.valueBuffer("codinventario");
	
	if (util.sqlSelect("lineasregstocks", "id", "codinventario = '" + codInventario + "' AND idstock = " + idStock + " AND id <> " + cursor.valueBuffer("id"))) {
		var res = MessageBox.warning(util.translate("scripts", "Hay otra línea de inventario para este artículo.\n¿Desea continuar?"), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
		if (res != MessageBox.Yes) {
			return false;
		}
	}
	return true;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
