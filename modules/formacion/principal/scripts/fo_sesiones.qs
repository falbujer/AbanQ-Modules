/***************************************************************************
                 fo_sesiones.qs  -  description
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
	var tdbSesionesAlumno:Object;
	function oficial( context ) { interna( context ); }
	function altaRapida() {
		return this.ctx.oficial_altaRapida();
	}
	function guardar() {
		return this.ctx.oficial_guardar();
	}
	function ordenColsAlumnos():Array {
		return this.ctx.oficial_ordenColsAlumnos();
	}
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function establecerTotalAlumnos() {
		return this.ctx.oficial_establecerTotalAlumnos();
	}
	function datosAccesoSesionAlumno(curSesion:FLSqlCursor, curAlumno:FLSqlCursor):Array {
		return this.ctx.oficial_datosAccesoSesionAlumno(curSesion, curAlumno);
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

	this.iface.tdbSesionesAlumno = this.child("tdbSesionesAlumno");

	connect(this.child("ledAltaRapida"), "returnPressed()", this, "iface.altaRapida");
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this.iface.tdbSesionesAlumno.cursor(), "bufferCommited()", this, "iface.establecerTotalAlumnos");

	switch (cursor.modeAccess()) {
		case cursor.Insert: {
			break;
		}
	}
	var campos:Array = this.iface.ordenColsAlumnos();
	this.iface.tdbSesionesAlumno.setOrderCols(campos);
}

function interna_calculateField(fN:String):String
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var valor:String;

	switch (fN) {
		case "canalumnos": {
			valor = parseInt(util.sqlSelect("fo_sesionesalumno", "COUNT(*)", "codsesion = '" + cursor.valueBuffer("codsesion") + "'"));
			valor = (isNaN(valor) ? 0 : valor);
			break;
		}
	}
	return valor;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_altaRapida()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	if (cursor.modeAccess() == cursor.Insert) {
		if (!this.iface.tdbSesionesAlumno.cursor().commitBufferCursorRelation()) {
			return false;
		}
	}
	var codAlumno:String = this.child("ledAltaRapida").text;

	var curAlumno:FLSqlCursor = new FLSqlCursor("fo_alumnos");
	curAlumno.select("codalumno = '" + codAlumno + "'");
	if (!curAlumno.first()) {
		MessageBox.warning(util.translate("scripts", "No existe ningún alumno con código %1").arg(codAlumno), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	curAlumno.setModeAccess(curAlumno.Browse);
	curAlumno.refreshBuffer();
	var masDatos:Array = this.iface.datosAccesoSesionAlumno(cursor, curAlumno);
	if (!masDatos) {
		return false;
	}
	if (!flformppal.iface.pub_crearSesionAlumno(cursor, curAlumno, masDatos)) {
		return false;
	}
	this.iface.tdbSesionesAlumno.refresh();
	this.iface.guardar();
	this.iface.establecerTotalAlumnos();
	this.child("ledAltaRapida").text = "";
}

/** \D Comprueba si el alumno tiene acceso a la sesión y genera un array con otros datos necesarios para el alta de la sesión por alumno.
@param curSesion: Cursor de la sesión
@param curAlumno: Cursor del alumno
\end */
function oficial_datosAccesoSesionAlumno(curSesion:FLSqlCursor, curAlumno:FLSqlCursor):Array
{
	var a:Array = [];
	return a;
}

/** \D Guarda la transacción actual y abre una nueva
\end */
function oficial_guardar()
{
	var cursor:FLSqlCursor = this.cursor();
	var codSesion:String = cursor.valueBuffer("codsesion");

	cursor.commitBuffer();
	cursor.commit();
	cursor.transaction(false);
	cursor.select("codsesion = '" + codSesion + "'");
	cursor.first();
	cursor.setModeAccess(cursor.Edit);
	cursor.refreshBuffer();
}

/** \D Creaun array con el orden de columnas para la tabla de alumnos
\end */
function oficial_ordenColsAlumnos():Array
{
	var arrayCampos:Array = ["codalumno", "nombre", "fecha", "codhorario", "asiste", "horadesde", "horahasta"];
	return arrayCampos;
}

/** \D Totaliza los alumnos
\end */
function oficial_establecerTotalAlumnos()
{
	this.child("fdbCanAlumnos").setValue(this.iface.calculateField("canalumnos"));
}

function oficial_bufferChanged(fN:String)
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	switch (fN) {
		case "X": {
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
