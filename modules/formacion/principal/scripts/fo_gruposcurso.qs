/***************************************************************************
                 fo_gruposcurso.qs  -  description
                             -------------------
    begin                : vie ene 28 2011
    copyright            : (C) 2004-2011 by InfoSiAL S.L.
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
	var tdbAlumnosGC;
	function oficial( context ) { interna( context ); }
	function tbnInsertAlumno_clicked() {
		return this.ctx.oficial_tbnInsertAlumno_clicked();
	}
	function asociarAlumnoGrupo(codAlumno:String, cursor:FLSqlCursor):Boolean {
		return this.ctx.oficial_asociarAlumnoGrupo(codAlumno, cursor);
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
	this.iface.tdbAlumnosGC = this.child("tdbAlumnosGC");

 	connect(this.child("tbnInsertAlumno"), "clicked()", this, "iface.tbnInsertAlumno_clicked");
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
function oficial_tbnInsertAlumno_clicked()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	var curAlumnosGC:FLSqlCursor = this.child("tdbAlumnosGC").cursor();

	var codCentro = cursor.valueBuffer("codcentro");
	if (!codCentro || codCentro == "") {
		MessageBox.warning(util.translate("scripts", "Debe especificar un centro antes de agregar alumnos"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	
	var filtro = "codcentro = '" + codCentro + "'";
	var f:Object = new FLFormSearchDB("fo_selecciongruposcurso");
	var curAlumnos:FLSqlCursor = f.cursor();

	// Pasamos los que ya tenemos como seleccionados
	var datos:String = "";
	var qryAlumnosGC:FLSqlQuery = new FLSqlQuery();
	qryAlumnosGC.setTablesList("fo_alumnosgrupocurso");
	qryAlumnosGC.setSelect("codalumno");
	qryAlumnosGC.setFrom("fo_alumnosgrupocurso");
	qryAlumnosGC.setWhere("idgrupo = "+cursor.valueBuffer("idgrupo"));
	qryAlumnosGC.exec();
	while (qryAlumnosGC.next()) {
		datos += datos != "" ? "," : "";
		datos += "'" + qryAlumnosGC.value("codalumno") + "'";
	}
	
	curAlumnos.select();
	if (!curAlumnos.first()) {
		curAlumnos.setModeAccess(curAlumnos.Insert);
	} else {
		curAlumnos.setModeAccess(curAlumnos.Edit);
	}
	f.setMainWidget();
	curAlumnos.refreshBuffer();
	curAlumnos.setValueBuffer("datos", datos);
	curAlumnos.setValueBuffer("filtro", filtro);
	var datos:String = f.exec("datos");
	if (!datos || datos == "") {
		return false;
	}
	var alumnos = datos.toString().split(",");
	var cur = new FLSqlCursor("empresa");
	for (var i:Number = 0; i < alumnos.length; i++) {
		cur.transaction(false);
		try {
			if (this.iface.asociarAlumnoGrupo(alumnos[i], cursor)) {
				cur.commit();
			} else {
				cur.rollback();
				MessageBox.warning(util.translate("scripts", "Hubo un error en la asociación del alumno %1 al al grupo").arg(alumnos[i]), MessageBox.Ok, MessageBox.NoButton);
			}
		}
		catch (e) {
			cur.rollback();
			MessageBox.critical(util.translate("scripts", "Hubo un error en la asociación del alumno al grupo:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
		}
	}
	this.iface.tdbAlumnosGC.refresh();
}

function oficial_asociarAlumnoGrupo(codAlumno, cursor)
{
	var util:FLUtil = new FLUtil;
	var idGrupo:Number = cursor.valueBuffer("idgrupo");
	var curAlumnosGC:FLSqlCursor = new FLSqlCursor("fo_alumnosgrupocurso");
	
	// Si el alumno no está en la lista del grupo, lo añade.
	curAlumnosGC.select("codalumno = " + codAlumno);
	if (!curAlumnosGC.next()) {
		curAlumnosGC.setModeAccess(curAlumnosGC.Insert);
		curAlumnosGC.refreshBuffer();
		curAlumnosGC.setValueBuffer("idgrupo", idGrupo);
		curAlumnosGC.setValueBuffer("codalumno", util.sqlSelect("fo_alumnos", "codalumno", "codalumno = "+ codAlumno));
		curAlumnosGC.setValueBuffer("nombre", util.sqlSelect("fo_alumnos", "nombre", "codalumno = "+ codAlumno));
		if (!curAlumnosGC.commitBuffer()) {
			return false;;
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
