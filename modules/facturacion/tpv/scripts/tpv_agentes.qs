/***************************************************************************
                 tpv_agentes.qs  -  description
                             -------------------
    begin                : mar ago 14 2012
    copyright            : Por ahora (C) 2012 by InfoSiAL S.L.
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
	var ctx;
	function interna( context ) { this.ctx = context; }
	function init() { this.ctx.interna_init(); }
	function calculateField(fN) { return this.ctx.interna_calculateField(fN); }
	function validateForm() {return this.ctx.interna_validateForm(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var cambiandoClave_, clavesCorrectas_;
	function oficial( context ) { interna( context ); }
	function commonCalculateField(fN, cursor) {
		return this.ctx.oficial_commonCalculateField(fN, cursor);
	}
	function bufferChanged(fN) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function iniciaClaves() {
		return this.ctx.oficial_iniciaClaves();
	}
	function pbnCambiarClave_clicked() {
		return this.ctx.oficial_pbnCambiarClave_clicked();
	}
	function ledClaveAcceso_textChanged() {
		return this.ctx.oficial_ledClaveAcceso_textChanged();
	}
	function compruebaClaves() {
		return this.ctx.oficial_compruebaClaves();
	}
	function habilitaPorClaveAcceso() {
		return this.ctx.oficial_habilitaPorClaveAcceso();
	}
	function validarClaves() {
		return this.ctx.oficial_validarClaves();
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
function interna_init()
{
	var _i = this.iface;
	var cursor = this.cursor();

	connect(cursor, "bufferChanged(QString)", _i, "bufferChanged");
	connect(this.child("pbnCambiarClave"), "clicked()", _i, "pbnCambiarClave_clicked");
	connect(this.child("ledClaveAcceso1"), "textChanged(QString)", _i, "ledClaveAcceso_textChanged");
	connect(this.child("ledClaveAcceso2"), "textChanged(QString)", _i, "ledClaveAcceso_textChanged");
	
	_i.iniciaClaves();
}

function interna_calculateField(fN)
{
	var _i = this.iface;
	var cursor = this.cursor();
	return _i.__commonCalculateField(fN, cursor);
}

/** \C
No se puede crear más de un arqueo para un mismo punto de venta con un mismo intervalo
Si al aceptar el formulario de arqueos existe una cantidad para el movimiento de cierre nos preguntará si deseamos cerrar el arqueo
*/
function interna_validateForm()
{
	var _i = this.iface;
	
	if (!_i.validarClaves()) {
		return false;
	}
	return true;
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_commonCalculateField(fN, cursor)
{
	var valor;
	var _i = this.iface;
	switch (fN) {
		case "totalcaja": {
			break;
		}
	}
	return valor;

}


function oficial_bufferChanged(fN)
{
	var _i = this.iface;
	var cursor= this.cursor();

	switch (fN) {
		case "m001": {
			break;
		}
	}
}

function oficial_iniciaClaves()
{
	var _i = this.iface;
	var cursor = this.cursor();
	this.child("ledClaveAcceso1").text = cursor.valueBuffer("claveacceso");
	this.child("ledClaveAcceso2").text = cursor.valueBuffer("claveacceso");
	_i.clavesCorrectas_ = true;
	_i.cambiandoClave_ = false;
	_i.habilitaPorClaveAcceso();
}

function oficial_habilitaPorClaveAcceso()
{
	var _i = this.iface;
	var cursor = this.cursor();
	if (_i.cambiandoClave_) {
		this.child("ledClaveAcceso1").enabled = true;
		this.child("ledClaveAcceso2").show();
		this.child("lblRepita").show();
		this.child("lblClaveValida").show();
	} else {
		this.child("ledClaveAcceso1").enabled = false;
		this.child("ledClaveAcceso2").close();
		this.child("lblRepita").close();
		this.child("lblClaveValida").close();
	}
}

function oficial_pbnCambiarClave_clicked()
{
	var _i = this.iface;
	var cursor = this.cursor();
	if (_i.cambiandoClave_) {
		if (_i.clavesCorrectas_) {
			cursor.setValueBuffer("claveacceso", this.child("ledClaveAcceso1").text);
			_i.cambiandoClave_ = false;
			_i.habilitaPorClaveAcceso();
		}
	} else {
		this.child("ledClaveAcceso2").text = "";
		this.child("ledClaveAcceso1").text = "";
		_i.cambiandoClave_ = true;
		_i.habilitaPorClaveAcceso();
		this.child("ledClaveAcceso1").setFocus();
	}
}

function oficial_validarClaves()
{
	var _i = this.iface;
	var cursor = this.cursor();
	if (_i.cambiandoClave_) {
		if (_i.clavesCorrectas_) {
			var res = MessageBox.warning(sys.translate("¿Guardar la nueva clave de acceso?"), MessageBox.Yes, MessageBox.No, MessageBox.NoButton, "AbanQ");
			if (res == MessageBox.Yes) {
				cursor.setValueBuffer("claveacceso", this.child("ledClaveAcceso1").text);
			}
		}
	}
	return true;
}



function oficial_ledClaveAcceso_textChanged()
{
	var _i = this.iface;
	var cursor = this.cursor();
	var c1 = this.child("ledClaveAcceso1").text;
	var c2 = this.child("ledClaveAcceso2").text;
	if (_i.compruebaClaves()) {
		_i.clavesCorrectas_ = true;
		this.child("lblClaveValida").text = sys.translate("Clave válida");
		this.child("lblClaveValida").paletteForegroundColor = new Color(0, 100, 0);
	} else {
		_i.clavesCorrectas_ = false;
		this.child("lblClaveValida").text = sys.translate("Clave no válida");
		this.child("lblClaveValida").paletteForegroundColor = new Color(150, 0, 0);
	}
}

function oficial_compruebaClaves()
{
	var c1 = this.child("ledClaveAcceso1").text;
	var c2 = this.child("ledClaveAcceso2").text;
	return (c1 == c2);
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
