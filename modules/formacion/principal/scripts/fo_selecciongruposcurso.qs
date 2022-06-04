/**************************************************************************
                 fo_selecciongruposcurso.qs  -  description
                             -------------------
    begin                : jue dic 21 2006
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
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var tdbAlumnos:Object;
	var tdbAlumnosSel:Object;
	
    function oficial( context ) { interna( context ); } 
	function seleccionar() {
		return this.ctx.oficial_seleccionar();
	}
	function quitar() {
		return this.ctx.oficial_quitar();
	}
	function refrescarTablas() {
		return this.ctx.oficial_refrescarTablas();
	}
	function tbnTodos_clicked() {
		return this.ctx.oficial_tbnTodos_clicked();
	}
	function tbnNinguno_clicked() {
		return this.ctx.oficial_tbnNinguno_clicked();
	}
	function tbnTodosSel_clicked() {
		return this.ctx.oficial_tbnTodosSel_clicked();
	}
	function tbnNingunoSel_clicked() {
		return this.ctx.oficial_tbnNingunoSel_clicked();
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
Este formulario muestra una lista de alumnos de un centro que cumplen un determinado filtro, y permite al usuario seleccionar uno o más alumnos de la lista
\end */
function interna_init()
{
	this.iface.tdbAlumnos = this.child("tdbAlumnos");
	this.iface.tdbAlumnosSel = this.child("tdbAlumnosSel");
	
	this.iface.tdbAlumnos.setReadOnly(true);
	this.iface.tdbAlumnosSel.setReadOnly(true);
	
	var filtro:String = this.cursor().valueBuffer("filtro");
	if (filtro && filtro != "") {
		this.iface.tdbAlumnos.cursor().setMainFilter(filtro);
		this.iface.tdbAlumnosSel.cursor().setMainFilter(filtro);
	}
	this.iface.refrescarTablas();
	
	connect(this.iface.tdbAlumnos.cursor(), "recordChoosed()", this, "iface.seleccionar()");
	connect(this.iface.tdbAlumnosSel.cursor(), "recordChoosed()", this, "iface.quitar()");
	connect(this.child("tbnSeleccionar"), "clicked()", this, "iface.seleccionar()");
	connect(this.child("tbnQuitar"), "clicked()", this, "iface.quitar()");
	connect(this.child("tbnTodos"), "clicked()", this, "iface.tbnTodos_clicked()");
	connect(this.child("tbnNinguno"), "clicked()", this, "iface.tbnNinguno_clicked()");
	connect(this.child("tbnTodosSel"), "clicked()", this, "iface.tbnTodosSel_clicked()");
	connect(this.child("tbnNingunoSel"), "clicked()", this, "iface.tbnNingunoSel_clicked()");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D Refresca las tablas, en función del filtro y de los datos seleccionados hasta el momento
*/
function oficial_refrescarTablas()
{
	var datos:String = this.cursor().valueBuffer("datos");
	var filtro:String = this.cursor().valueBuffer("filtro");
	if (filtro && filtro != "") {
		filtro += " AND ";
	}
	if (!datos || datos == "") {
		this.iface.tdbAlumnos.cursor().setMainFilter(filtro + "1 = 1");
		this.iface.tdbAlumnosSel.cursor().setMainFilter(filtro + "1 = 2");
	} else {
		this.iface.tdbAlumnos.cursor().setMainFilter(filtro + "codalumno NOT IN (" + datos + ")");
		this.iface.tdbAlumnosSel.cursor().setMainFilter(filtro + "codalumno IN (" + datos + ")");
	}
	this.iface.tdbAlumnos.refresh();
	this.iface.tdbAlumnosSel.refresh();
}

/** \D Incluye un alumno en la lista de datos
*/
function oficial_seleccionar()
{
	var cursor:FLSqlCursor = this.cursor();
	var datos:String = cursor.valueBuffer("datos");

	var aAlumnos:Array = this.iface.tdbAlumnos.primarysKeysChecked();
	if (aAlumnos && aAlumnos.length > 0) {
		var listaAlumnos:String = "'"+aAlumnos.join("','")+"'";
		if (!datos || datos == "") {
			datos = listaAlumnos;
		} else {
			datos += "," + listaAlumnos;
		}
		for (var i:Number = 0; i < aAlumnos.length; i++) {
			this.iface.tdbAlumnos.setPrimaryKeyChecked(aAlumnos[i], false);
		}
	}
	cursor.setValueBuffer("datos", datos);
	
	this.iface.refrescarTablas();
}

/** \D Quita un alumno de la lista de datos
*/
function oficial_quitar()
{
	var cursor:FLSqlCursor = this.cursor();
	var datos:String = cursor.valueBuffer("datos");

	if (!datos || datos == "") {
		return;
	}
	var alumnos:Array = datos.split(",");
	var aAlumnos:Array = this.iface.tdbAlumnosSel.primarysKeysChecked();
	if (!aAlumnos || aAlumnos.length == 0) {
		return;
	}
	var datosNuevos:String = "";
	
	var quitar:Boolean;
	for (var i:Number = 0; i < alumnos.length; i++) {
		quitar = false;
		for (var iAlumno:Number = 0; iAlumno < aAlumnos.length; iAlumno++) {
			// Ojo: tenemos en cuenta que los códigos ban entre el símbolo '
			if (alumnos[i] == "'" + aAlumnos[iAlumno] + "'") {
				quitar = true;
				break;
			}
		}
		if (quitar) {
			this.iface.tdbAlumnosSel.setPrimaryKeyChecked(alumnos[i], false);
			continue;
		}
		if (datosNuevos == "") {
			datosNuevos = alumnos[i];
		} else {
			datosNuevos += "," + alumnos[i];
		}
	}
	cursor.setValueBuffer("datos", datosNuevos);

	this.iface.refrescarTablas();
}

/** \D Selecciona todos los alumnos de la tabla superior
\end */
function oficial_tbnTodos_clicked()
{
	var filtro:String = this.iface.tdbAlumnos.cursor().mainFilter();
	if (!filtro || filtro == "") {
		return;
	}
	var qryAlumnos:FLSqlQuery = new FLSqlQuery();
	qryAlumnos.setTablesList("fo_alumnos");
	qryAlumnos.setSelect("codalumno");
	qryAlumnos.setFrom("fo_alumnos");
	qryAlumnos.setWhere(filtro);
	qryAlumnos.setForwardOnly(true);
	if (!qryAlumnos.exec()) {
		return false;
	}
	while (qryAlumnos.next()) {
		this.iface.tdbAlumnos.setPrimaryKeyChecked(qryAlumnos.value("codalumno"), true);
	}
	this.iface.tdbAlumnos.refresh();
}

/** \D Elimina la selección de todos los alumnos de la tabla superior
\end */
function oficial_tbnNinguno_clicked()
{
	this.iface.tdbAlumnos.clearChecked();
	this.iface.tdbAlumnos.refresh();
}

/** \D Selecciona todos los alumnos de la tabla inferior
\end */
function oficial_tbnTodosSel_clicked()
{
	var filtro:String = this.iface.tdbAlumnosSel.cursor().mainFilter();
	if (!filtro || filtro == "") {
		return;
	}
	var qryAlumnos:FLSqlQuery = new FLSqlQuery();
	qryAlumnos.setTablesList("fo_alumnos");
	qryAlumnos.setSelect("codalumno");
	qryAlumnos.setFrom("fo_alumnos");
	qryAlumnos.setWhere(filtro);
	qryAlumnos.setForwardOnly(true);
	if (!qryAlumnos.exec()) {
		return false;
	}
	while (qryAlumnos.next()) {
		this.iface.tdbAlumnosSel.setPrimaryKeyChecked(qryAlumnos.value("codalumno"), true);
	}
	this.iface.tdbAlumnosSel.refresh();
}

/** \D Elimina la selección de todos los alumnos de la tabla inferior
\end */
function oficial_tbnNingunoSel_clicked()
{
	this.iface.tdbAlumnosSel.clearChecked();
	this.iface.tdbAlumnosSel.refresh();
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
