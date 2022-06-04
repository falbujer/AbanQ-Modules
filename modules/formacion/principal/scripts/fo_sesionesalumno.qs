/***************************************************************************
                 fo_sesionesalumno.qs  -  description
                             -------------------
    begin                : jue ago 13 2009
    copyright            : (C) 2004-2009 by InfoSiAL S.L.
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
		return this.ctx.interna_init();
	}
	function validateForm():Boolean {
		return this.ctx.interna_validateForm();
	}
	function calculateField(fN:String):String {
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
	function informarDatosSesion() {
		return this.ctx.oficial_informarDatosSesion();
	}
	function informarDatosAlumno() {
		return this.ctx.oficial_informarDatosAlumno();
	}
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
function interna_init()
{
	var cursor:FLSqlCursor = this.cursor();

	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");

	switch (cursor.modeAccess()) {
		case cursor.Insert: {
			var curRel:FLSqlCursor = cursor.cursorRelation();
			if (curRel && curRel.table() == "fo_sesiones") {
				this.iface.informarDatosSesion();
			} else if (curRel && curRel.table() == "fo_alumnos") {
				this.iface.informarDatosAlumno();
			}
			break;
		}
	}
}

function interna_validateForm():Boolean
{
	return true;
}

function interna_calculateField(fN:String):String
{
	var valor:String;
	switch (fN) {
		case "x": {
			break;
		}
	}
	return valor;s
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_informarDatosSesion()
{
	var cursor:FLSqlCursor = this.cursor();
	var curRel:FLSqlCursor = cursor.cursorRelation();

	this.child("fdbFecha").setValue(curRel.valueBuffer("fecha"));
	this.child("fdbCodHorario").setValue(curRel.valueBuffer("codhorario"));
	this.child("fdbHoraDesde").setValue(curRel.valueBuffer("horadesde"));
	this.child("fdbHoraHasta").setValue(curRel.valueBuffer("horahasta"));
	this.child("fdbEstado").setValue(curRel.valueBuffer("estado"));
}

function oficial_informarDatosAlumno()
{
	var cursor:FLSqlCursor = this.cursor();
	var curRel:FLSqlCursor = cursor.cursorRelation();

	this.child("fdbNombre").setValue(curRel.valueBuffer("nombre"));
}

function oficial_bufferChanged(fN:String)
{
	switch (fN) {
		case "x": {
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
