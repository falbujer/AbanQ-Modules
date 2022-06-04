/***************************************************************************
                 fo_alumnos.qs  -  description
                             -------------------
    begin                : lun ago 17 2009
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
	var tdbAlumnosGC;
	function oficial( context ) { interna( context ); }
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function formReady() {
		return this.ctx.oficial_formReady();
	}
	function tbnInsertGrupo_clicked() {
		return this.ctx.oficial_tbnInsertGrupo_clicked();
	}
	function habilitarControles() {
		return this.ctx.oficial_habilitarControles();
	}
	function centroInhabilitado() {
		return this.ctx.oficial_centroInhabilitado();
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
	var cursor = this.cursor();

	this.iface.tdbAlumnosGC = this.child("tdbAlumnosGC");

	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this, "formReady()", this, "iface.formReady");
	connect(this.iface.tdbAlumnosGC.cursor(), "bufferCommited()", this, "iface.habilitarControles");
 	connect(this.child("tbnInsertGrupo"), "clicked()", this, "iface.tbnInsertGrupo_clicked");


	switch (cursor.modeAccess()) {
		case cursor.Insert: {
			break;
		}
	}
	this.iface.habilitarControles();
}

function interna_calculateField(fN:String):String
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var valor:String;

	switch (fN) {
		case "nombre": {
			valor = cursor.valueBuffer("apellidos") + ", " + cursor.valueBuffer("nombrepila");
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
function oficial_tbnInsertGrupo_clicked()
{
debug("oficial_tbnInsertGrupo_clicked");
	var util = new FLUtil();
	var cursor = this.cursor();
	if (cursor.modeAccess() == cursor.Insert) {
		if (!this.iface.tdbAlumnosGC.cursor().commitBufferCursorRelation()) {
			return false;
		}
	}
	
	var codAlumno = cursor.valueBuffer("codalumno");
	var codCentro = cursor.valueBuffer("codcentro");
	if (!codCentro || codCentro == "") {
		MessageBox.warning(util.translate("scripts", "Debe establecer el centro antes de seleccionar el grupo del alumno"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	
	var f = new FLFormSearchDB("fo_gruposcurso");
	var curGrupos:FLSqlCursor = f.cursor();
	curGrupos.setMainFilter("codcentro = '" + codCentro + "'");
	
	f.setMainWidget();
	var idGrupo = f.exec("idgrupo");
	if (!idGrupo) {
		return false;
	}
	if (util.sqlSelect("fo_alumnosgrupocurso", "idalumnogc", "codalumno = '" + codAlumno + "' AND idgrupo = " + idGrupo)) {
		MessageBox.warning(util.translate("scripts", "El alumno ya está asociado al curso seleccionado"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	var curAGC = new FLSqlCursor("fo_alumnosgrupocurso");
	curAGC.setModeAccess(curAGC.Insert);
	curAGC.refreshBuffer();
	curAGC.setValueBuffer("idgrupo", idGrupo);
	curAGC.setValueBuffer("codalumno", codAlumno);
	curAGC.setValueBuffer("nombre", cursor.valueBuffer("nombre"));
	if (!curAGC.commitBuffer()) {
		return false;
	}
	this.iface.tdbAlumnosGC.refresh();
	this.iface.habilitarControles();
	return true;
}

function oficial_habilitarControles()
{
	var _i = this.iface;
	_i.tdbAlumnosGC.refresh();
	this.child("fdbCodCentro").setDisabled(_i.centroInhabilitado());
}

function oficial_centroInhabilitado()
{
	var _i = this.iface;
	return _i.tdbAlumnosGC.cursor().size() > 0;
}

function oficial_bufferChanged(fN:String)
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	switch (fN) {
		case "nombrepila":
		case "apellidos": {
			this.child("fdbNombre").setValue(this.iface.calculateField("nombre"));
			break;
		}
	}
}

function oficial_formReady()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	if (cursor.modeAccess() != cursor.Insert) {
		return;
	}

	var aDatosAlumno:Array = formRecordclientes.iface.datosAltaAlumno_;
	if (!aDatosAlumno) {
		return;
	}
	this.child("fdbNombre").setValue(aDatosAlumno["nombre"]);
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
