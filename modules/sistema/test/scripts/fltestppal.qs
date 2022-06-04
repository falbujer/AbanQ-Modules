/***************************************************************************
                 fltestppal.qs  -  description
                             -------------------
    begin                : lun abr 26 2004
    copyright            : (C) 2004 by InfoSiAL S.L.
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

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var idFuncional:String;
	var pathLocal:String;
	
    function oficial( context ) { interna( context ); } 
	function obtenerPathLocal():String {
		return this.ctx.oficial_obtenerPathLocal();
	}
	function cambiarPathLocal(dirActual:String):Boolean {
		return this.ctx.oficial_cambiarPathLocal(dirActual);
	}
	function obtenerIdFuncional():String {
		return this.ctx.oficial_obtenerIdFuncional();
	}
	function cambiarIdFuncional(versionActual:String):Boolean {
		return this.ctx.oficial_cambiarIdFuncional(versionActual);
	}
	function populateDB() {
		return this.ctx.oficial_populateDB();
	}
	function calculateField(tN:String, fN:String, fV:String):String {
		return this.ctx.oficial_calculateField(tN, fN, fV);
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends oficial {
    function head( context ) { oficial ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
    function ifaceCtx( context ) { head( context ); }
	function pub_calculateField(tN:String, fN:String, fV:String):String {
		return this.calculateField(tN, fN, fV);
	}
	function pub_obtenerPathLocal():String {
		return this.obtenerPathLocal();
	}
	function pub_obtenerIdFuncional():String {
		return this.obtenerIdFuncional();
	}
	function pub_cambiarPathLocal(path:String):String {
		return this.cambiarPathLocal(path);
	}
	function pub_cambiarIdFuncional(idFuncional:String):String {
		return this.cambiarIdFuncional(idFuncional);
	}
}

const iface = new ifaceCtx( this );
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
/** \D Crea las tablas de pasos, pruebas y sesiones para que el objeto FLTester del motor las encuentre ya creadas.

Muestra los valores de configuración del módulo al usuario para verificar que son los correctos
\end */
function interna_init()
{
	var cursor:FLSqlCursor = new FLSqlCursor("tt_objecttype");
	var util:FLUtil = new FLUtil;
	cursor.select();
	if (!cursor.first()) {
		MessageBox.information(util.translate("scripts", "Se insertarán los datos necesarios para empezar a trabajar"), MessageBox.Ok);
		this.iface.populateDB();
	}
	
	// Consulta en las tablas vacías para forzar su creación
	var util:FLUtil = new FLUtil;
	util.sqlSelect("tt_test", "idtest", "1 = 1", "tt_test");
	util.sqlSelect("tt_step", "idstep", "1 = 1", "tt_step");
	util.sqlSelect("tt_session", "idsession", "1 = 1", "tt_session");
		
	var curConfig:FLSqlCursor = new FLSqlCursor("tt_config");
	curConfig.select();
	if (!curConfig.first()) {
		MessageBox.information(util.translate("scripts", "Verifique que los valores de configuración son los correctos."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		this.execMainScript("tt_config");
	}
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D Puebla las tablas de objetos y acciones
\end */
function oficial_populateDB()
{
	var values:Array =
		[["Assignation", "Asignación de valores"],
		["Button", "Botón"],
		["Compare", "Comparación de dos valores"],
		["FLFieldDB", "Campo FLFieldDB"],
		["FLFormDB", "Formulario"],
		["FLTableDB", "Tabla FLTableDB"],
		["Query", "Consulta en BBDD"],
		["Script", "Script"],
		["Table", "Tabla"],
		["Test", "Prueba"],
		["MessageBox", "Cuadro de mensajes"],
		["QTabWidget", "Pestañas"],
		["ScriptDialog", "Diálogo lanzado por scripts"],
		["ScriptInput", "Entrada de datos lanzada por scrits"]];
	var cursor:FLSqlCursor = new FLSqlCursor("tt_objecttype");
	for (var i:Number = 0; i < values.length; i++) {
		with(cursor) {
			setModeAccess(cursor.Insert);
			refreshBuffer();
			setValueBuffer("idobjecttype", values[i][0]);
			setValueBuffer("description", values[i][1]);
			commitBuffer();
		}
	}
	delete cursor;

	var values:Array =
		[["Assignation", "assignateValues", "Asignar valores", "true"],
		["Button", "animateClick", "Pulsar el botón", "true"],
		["Compare", "compareItems", "Comparar ", "true"],
		["FLFieldDB", "searchValue", "Buscar valor", "false"],
		["FLFieldDB", "setValue", "Establecer valor", "true"],
		["FLFieldDB", "saveValue", "Guardar valor", "false"],
		["FLFormDB", "close",  "Cerrar formulario", "false"],
		["FLFormDB", "setFieldValues",  "Rellenar campos", "false"],
		["FLFormDB", "open",  "Abrir formulario", "true"],
		["FLTableDB", "selectRow", "Seleccionar registro", "true"],
		["Query", "execQuery", "Ejecutar consulta", "true"],
		["Script", "execFunction", "Ejecutar función", "true"],
		["Table", "deleteRecords", "Borrar registros", "true"],
		["Test", "execTest", "Ejecutar prueba", "true"],
		["MessageBox", "pushOk", "MessageBox - Pulsar Aceptar", "true"],
		["MessageBox", "pushCancel", "MessageBox - Pulsar Cancelar", "false"],
		["MessageBox", "pushYes", "MessageBox - Pulsar Sí", "false"],
		["MessageBox", "pushNo", "MessageBox - Pulsar No", "false"],
		["MessageBox", "pushAbort", "MessageBox - Pulsar Abortar", "false"],
		["MessageBox", "pushRetry", "MessageBox - Pulsar Reintentar", "false"],
		["MessageBox", "pushIgnore", "MessageBox - Pulsar Ignorar", "false"],
		["MessageBox", "pushYesToAll", "MessageBox - Pulsar Sí a Todo", "false"],
		["MessageBox", "pushNoToAll", "MessageBox - Pulsar No a Todo", "false"],
		["QTabWidget", "setPage", "Seleccionar pestaña", "true"],
		["ScriptDialog", "fillDialog", "Rellenar el diálogo", "true"],
		["ScriptInput", "setInputValue", "Rellenar el Input Dialog", "true"]];
	cursor = new FLSqlCursor("tt_action");
	for (var i:Number = 0; i < values.length; i++) {
		with(cursor) {
			setModeAccess(cursor.Insert);
			refreshBuffer();
			setValueBuffer("idobjecttype", values[i][0]);
			setValueBuffer("idaction", values[i][1]);
			setValueBuffer("description", values[i][2]);
			setValueBuffer("isdefault", values[i][3]);
			commitBuffer();
		}
	}
	delete cursor;

}

/** \D Obtiene la ruta al directorio de desarrollo
@return	Ruta al directorio
*/
function oficial_obtenerPathLocal():String {
	var util:FLUtil = new FLUtil;
	if (!this.iface.pathLocal) {
		this.iface.pathLocal = util.readSettingEntry("scripts/fltestppal/pathlocal");
		if (!this.iface.pathLocal) {
			MessageBox.information(util.translate("scripts", "No hay un directorio de trabajo establecido, por favor, seleccione el directorio"), MessageBox.Ok, MessageBox.NoButton);
			this.iface.cambiarPathLocal("");
		}
	}
	return this.iface.pathLocal;
}

/** \D Obtiene la funcionalidad en desarrollo 
@return	Identificador de la funcionalidad
*/
function oficial_obtenerIdFuncional():String 
{
	var util:FLUtil = new FLUtil;
	if (!this.iface.idFuncional) {
		this.iface.idFuncional = util.readSettingEntry("scripts/fltestppal/idfuncional");
		if (!this.iface.idFuncional) {
			MessageBox.information(util.translate("scripts", "No hay una funcionalidad en desarrollo establecida, por favor, seleccione una"), MessageBox.Ok, MessageBox.NoButton);
			this.iface.cambiarIdFuncional("");
		}
	}
	return this.iface.idFuncional;
}

/** \D Cambia el directorio de trabajo local

@param	dirActual: Ruta al nuevo directorio
@return	True si no hay error, false en caso contrario
*/
function oficial_cambiarPathLocal(dirActual:String):Boolean
{
	var util:FLUtil = new FLUtil;
	var directorio:String = FileDialog.getExistingDirectory(dirActual);
	if (!directorio)
		return false;
			
	util.writeSettingEntry("scripts/fltestppal/pathlocal", directorio);
	this.iface.pathLocal = util.readSettingEntry("scripts/fltestppal/pathlocal");
	return true;
}

/** \D Cambia el nombre de la funcionalidad en desarrollo 

@param	idFunActual: Nuevo identificador de la funcionalidad en desarrollo
@return	True si no hay error, false en caso contrario
*/
function oficial_cambiarIdFuncional(idFunActual:String):Boolean
{
	var util:FLUtil = new FLUtil;
	var idFuncional:String  = Input.getText(util.translate("scripts", "Funcionalidad en desarrollo"), idFunActual);
	
	util.writeSettingEntry("scripts/fltestppal/idfuncional", idFuncional);
	this.iface.idFuncional = util.readSettingEntry("scripts/fltestppal/idfuncional");
	return true;
}


//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////

//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
