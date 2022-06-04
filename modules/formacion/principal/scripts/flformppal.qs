/***************************************************************************
                 flformppal.qs  -  description
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
	function beforeCommit_fo_sesiones(curSesion:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_fo_sesiones(curSesion);
	}
	function afterCommit_fo_sesionesalumno(curSA:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_fo_sesionesalumno(curSA);
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var curSesionesAlumno_:FLSqlCursor;
	function oficial( context ) { interna( context ); }
	function actualizarSesionesPorSesion(curSesion:FLSqlCursor):Boolean {
		return this.ctx.oficial_actualizarSesionesPorSesion(curSesion);
	}
	function datosSesionCambiados(curSesion:FLSqlCursor):Boolean {
		return this.ctx.oficial_datosSesionCambiados(curSesion);
	}
	function heredarDatosSesion(curSesion:FLSqlCursor):Boolean {
		return this.ctx.oficial_heredarDatosSesion(curSesion);
	}
	function crearSesionAlumno(curSesion:FLSqlCursor, curAlumno:FLSqlCursor, masDatos:Array):Number {
		return this.ctx.oficial_crearSesionAlumno(curSesion, curAlumno, masDatos);
	}
	function datosSesionAlumno(curSesion:FLSqlCursor, curAlumno:FLSqlCursor, masDatos:Array):Boolean {
		return this.ctx.oficial_datosSesionAlumno(curSesion, curAlumno, masDatos);
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
	function pub_crearSesionAlumno(curSesion:FLSqlCursor, curAlumno:FLSqlCursor, masDatos:Array):Number {
		return this.crearSesionAlumno(curSesion, curAlumno, masDatos);
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
}


function interna_beforeCommit_fo_sesiones(curSesion:FLSqlCursor):Boolean
{
	switch (curSesion.modeAccess()) {
		case curSesion.Edit: {
			if (!this.iface.actualizarSesionesPorSesion(curSesion)) {
				return false;
			}
			break;
		}
	}
	return true;
}

function interna_afterCommit_fo_sesionesalumno(curSA:FLSqlCursor):Boolean
{
	return true;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D Comprueba si los datos de la sesión han cambiado y cambia en consecuencia los de la tabla de sesiones por alumno
@param curSesion: Cursor de la sesión
\end */
function oficial_actualizarSesionesPorSesion(curSesion:FLSqlCursor):Boolean
{
	if (!this.iface.datosSesionCambiados(curSesion)) {
		return true;
	}

	if (!this.iface.curSesionesAlumno_) {
		this.iface.curSesionesAlumno_ = new FLSqlCursor("sesionesalumno");
	}

	this.iface.curSesionesAlumno_.select("codsesion = '" + curSesion.valueBuffer("codsesion") + "'");
	this.iface.curSesionesAlumno_.setActivatedCommitActions(false);
	while (this.iface.curSesionesAlumno_.next()) {
		this.iface.curSesionesAlumno_.setModeAccess(this.iface.curSesionesAlumno_.Edit);
		this.iface.curSesionesAlumno_.refreshBuffer();
		if (!this.iface.heredarDatosSesion(curSesion)) {
			return false;
		}
		if (!this.iface.curSesionesAlumno_.commitBuffer()) {
			return false;
		}
	}

	return true;
}

/** \D Comprueba si los datos de la sesión han cambiado
@param curSesion: Cursor de la sesión
\end */
function oficial_datosSesionCambiados(curSesion:FLSqlCursor):Boolean
{
	var cambio:Boolean =  (curSesion.valueBufferCopy("fecha") != curSesion.valueBuffer("fecha")) || (curSesion.valueBufferCopy("codhorario") != curSesion.valueBuffer("codhorario")) || (curSesion.valueBufferCopy("horadesde") != curSesion.valueBuffer("horadesde")) || (curSesion.valueBufferCopy("horahasta") != curSesion.valueBuffer("horahasta")) || (curSesion.valueBufferCopy("estado") != curSesion.valueBuffer("estado"));

	return cambio;
}

/** \D Copia los datos de una sesión en los de la tabla alumnos por sesión
@param curSesion: Cursor de la sesión
\end */
function oficial_heredarDatosSesion(curSesion:FLSqlCursor):Boolean
{
	with (this.iface.curSesionesAlumno_) {
		setValueBuffer("fecha", curSesion.valueBuffer("fecha"));
		setValueBuffer("codhorario", curSesion.valueBuffer("codhorario"));
		setValueBuffer("horadesde", curSesion.valueBuffer("horadesde"));
		setValueBuffer("horahasta", curSesion.valueBuffer("horahasta"));
		setValueBuffer("estado", curSesion.valueBuffer("estado"));
	}
	return true;
}

function oficial_crearSesionAlumno(curSesion:FLSqlCursor, curAlumno:FLSqlCursor, masDatos:Array):Number
{
	var util:FLUtil = new FLUtil;

	var codAlumno:String = curAlumno.valueBuffer("codalumno");

	if (!this.iface.curSesionesAlumno_) {
		this.iface.curSesionesAlumno_ = new FLSqlCursor("fo_sesionesalumno");
	}
	this.iface.curSesionesAlumno_.setModeAccess(this.iface.curSesionesAlumno_.Insert);
	this.iface.curSesionesAlumno_.refreshBuffer();
	this.iface.curSesionesAlumno_.setValueBuffer("codsesion", curSesion.valueBuffer("codsesion"));
	this.iface.curSesionesAlumno_.setValueBuffer("codalumno", codAlumno);
	this.iface.curSesionesAlumno_.setValueBuffer("asiste", true);
	this.iface.curSesionesAlumno_.setValueBuffer("nombre", util.sqlSelect("fo_alumnos", "nombre", "codalumno = '" + codAlumno + "'"));
	if (!this.iface.heredarDatosSesion(curSesion)) {
		return false;
	}
	if (!this.iface.datosSesionAlumno(curSesion, curAlumno, masDatos)) {
		return false;
	}
	if (!this.iface.curSesionesAlumno_.commitBuffer()) {
		return false;
	}
	return this.iface.curSesionesAlumno_.valueBuffer("idsesion");
}

function oficial_datosSesionAlumno(curSesion:FLSqlCursor, curAlumno:FLSqlCursor, masDatos:Array):Boolean
{
	return true;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
