/***************************************************************************
                 recibosfacturacli.qs  -  description
                             -------------------
    begin                : mie may 23 2012
    copyright            : (C) 2012 by InfoSiAL S.L.
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
	function validateForm() {
		return this.ctx.interna_validateForm();
	}
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
	function habilitaControles() {
		return this.ctx.oficial_habilitaControles();
	}
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function validarCuentaBancaria() {
		return this.ctx.oficial_validarCuentaBancaria();
	}
	function commonCalculateField(fN:String, cursor:FLSqlCursor) {
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
	var cursor = this.cursor();
	
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	if (cursor.modeAccess() == cursor.Edit) {
		this.child("pushButtonAcceptContinue").close();
	}
// 	this.child("fdbTexto").setValue(this.iface.calculateField("texto"));
	_i.habilitaControles();
}
/** \C
El importe del recibo debe ser menor o igual del que tenía anteriormente. Si es menor el recibo se fraccionará.
La fecha de vencimiento debe ser siempre igual o posterior a la fecha de emisión del recibo.
\end */
function interna_validateForm()
{
	var cursor= this.cursor();
	
	if (!formRecordreciboscli.iface.pub_commonValidateForm(cursor)) {
		return false;
	}

	return true;
}

function interna_calculateField(fN:String)
{
	var cursor = this.cursor();
	valor = formRecordreciboscli.iface.pub_commonCalculateField(fN, cursor);
	return valor;
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_habilitaControles()
{
	this.child("fdbImporte").setDisabled(true);
}

function oficial_bufferChanged(fN)
{
	formRecordreciboscli.iface.pub_commonBufferChanged(fN, this);
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
