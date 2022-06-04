/***************************************************************************
                 wi_datos.qs  -  description
                             -------------------
    begin                : lun sep 21 2004
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

/** @file */

////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/** @class_declaration interna */
//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
class interna {
    var ctx:Object;
    function interna( context ) { this.ctx = context; }
    function init() { this.ctx.interna_init(); }
    function main() { this.ctx.interna_main(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	
	var conexion:String;
	var tablas:Array;
	var tablasGenerales:Array;
	
    function oficial( context ) { interna( context ); } 
	
	function conectar():Boolean {
		return this.ctx.oficial_conectar();
	}
	function desconectar():Boolean {
		return this.ctx.oficial_desconectar();
	}
	
	function subirDatos():Boolean {
		return this.ctx.oficial_subirDatos();
	}
	function bajarDatos():Boolean {
		return this.ctx.oficial_bajarDatos();
	}
	function importarTabla(tabla:String, nomTabla:String):Number {
		return this.ctx.oficial_importarTabla(tabla, nomTabla);
	}
	function exportarTabla(tabla:String, nomTabla:String, campoClave:String):Number {
		return this.ctx.oficial_exportarTabla(tabla, nomTabla, campoClave);
	}
	function importarPedidos():Number {
		return this.ctx.oficial_importarPedidos();
	}
	function actualizarPedidos():Number {
		return this.ctx.oficial_actualizarPedidos();
	}
	function obtenerListaCampos(tabla:String):Array {
		return this.ctx.oficial_obtenerListaCampos(tabla);
	}
	function obsoletosTabla(tabla:String, campoClave:String):Number {
		return this.ctx.oficial_obsoletosTabla(tabla, campoClave);
	}
	function registrosIguales(listaCampos:Array, curLoc:FLSqlCursor, curRem:FLSqlCursor) {
		return this.ctx.oficial_registrosIguales(listaCampos, curLoc, curRem);
	}
	function actualizarMetadatos() {
		return this.ctx.oficial_actualizarMetadatos();
	}
	function borrarLocal(curMod:FLSqlCursor) {
		return this.ctx.oficial_borrarLocal(curMod);
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

////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/** @class_definition interna */
//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////

function init() {
    this.iface.init();
}

function main() {
    this.iface.main();
}

function interna_init() 
{
	this.iface.conexion = "remota";
	connect( this.child( "pbnUp" ), "clicked()", this, "iface.subirDatos" );
	connect( this.child( "pbnDown" ), "clicked()", this, "iface.bajarDatos" );
	connect( this.child( "pbnUpMetadata" ), "clicked()", this, "iface.actualizarMetadatos" );

	this.iface.tablas = new Array(
		"impuestos",
		"series",
		"ejercicios",
		"empresa",
		"paises",
// 		"cuentasbanco",
		"formaspago",
		
		"se_zonaspartners",
 		"se_partners",
		"se_zonasporpartner",
 		"se_incidencias",
		
		"familias",
		"wi_modulosfam",
		"mv_funcional",
		"articulos",
		"articuloscomp",
		"articulosrel",
		"wi_modulosart",
		
		"wi_modulosweb",
		"wi_noticias",
		"wi_consultas",
		"wi_categoriasenlaces",
		"wi_enlaces",
		
		"wi_secciones",
		"wi_apartados",
		"wi_menuitems",
		
		"wi_idiomas",
		"wi_traducciones",
		"wi_usuarios",
		"wi_ramasusuarios",
		"wi_docprivadausuarios",
		"wi_faqs",
		
		"gd_documentos"
				
	);
}

function interna_main()
{
	var util:FLUtil = new FLUtil();
	
	var f = new FLFormSearchDB("wi_datos");
	var cursor:FLSqlCursor = f.cursor();

	cursor.select();
	if (!cursor.first())
		cursor.setModeAccess(cursor.Insert);
	else
		cursor.setModeAccess(cursor.Edit);

	f.setMainWidget();
	cursor.refreshBuffer();
	var commitOk:Boolean = false;
	var acpt:Boolean;
	cursor.transaction(false);
	while (!commitOk) {
		acpt = false;
		f.exec("id");
		acpt = f.accepted();
		if (!acpt) {
			if (cursor.rollback())
					commitOk = true;
		} else {
			if (cursor.commitBuffer()) {
					cursor.commit();
					commitOk = true;
			}
		}
		f.close();
	}
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_subirDatos()
{
	var util:FLUtil = new FLUtil();
	
// 	var res = MessageBox.information(util.translate("scripts", "A continuación se establecerá una conexión con la base de datos remota\ny se actualizarán los artículos y otros datos que hayan sido modificados\n\n¿Desea continuar?"),
// 		MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
// 	if (res != MessageBox.Yes)
// 		return false;

	if (!this.iface.conectar())
		return false;
	
	var msgResumen:String = util.translate("scripts", "Resultados:\n");
	var numExportados:Number;
	var numEliminados:Number;
	var totalExportados:Number = 0;

	// Eliminar borrados
	for (var i:Number = this.iface.tablas.length - 1; i >= 0; i--) {
	
		numEliminados = this.iface.obsoletosTabla(this.iface.tablas[i]);
		if (numEliminados > 0)
			msgResumen += "\n" + this.iface.tablas[i] + "   " + 
				util.translate("scripts", "Eliminados: ") + numEliminados;

		totalExportados += numEliminados;
	}

	// Actualizar modificados
	for (var i:Number = 0; i < this.iface.tablas.length; i++) {
	
		this.child("leMsg").text = "Exportando <b>" + this.iface.tablas[i] + "</b>...";
		numExportados = this.iface.exportarTabla(this.iface.tablas[i], this.iface.tablas[i]);
		if (numExportados > 0)
			msgResumen += "\n" + this.iface.tablas[i] + "   " + 
				util.translate("scripts", "Modificados o nuevos: ") + numExportados;

		totalExportados += numExportados;
	
	}
	
	// Actualizar pedidos
	numEliminados = this.iface.obsoletosTabla("pedidoscli", "codigo");
	if (numEliminados > 0)
		msgResumen += "\n" + util.translate("scripts", "Pedidos eliminados: ") + numEliminados;
	
  	numPedidos = this.iface.actualizarPedidos();
// 	numPedidos = this.iface.exportarTabla("pedidoscli", "Pedidos", "codigo");
 	if (numPedidos > 0) {
 		totalExportados += numPedidos;
 		msgResumen += "\n" + util.translate("scripts", "Pedidos actualizados: ") + numPedidos;
 	}

	if (totalExportados > 0)
		MessageBox.information(msgResumen, MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
	else
		MessageBox.information(util.translate("scripts", "No se encontraron registros para actualizar"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);

	this.iface.desconectar();
		
	this.child("leMsg").text = "Proceso finalizado";
}

function oficial_bajarDatos()
{
	var util:FLUtil = new FLUtil();
	
/*	var res = MessageBox.information(util.translate("scripts", "A continuación se establecerá una conexión con la base de datos remota\ny se descargarán los nuevos clientes y pedidos\n\n¿Desea continuar?"),
		MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
	if (res != MessageBox.Yes)
		return false;*/
	
	if (!this.iface.conectar())
		return false;
	
	var msgResumen:String = util.translate("scripts", "Registros nuevos o actualizados:\n");

	this.child("leMsg").text = "Importando <b>usuarios</b>...";
	var numImportados:Number = this.iface.importarTabla("wi_usuarios", "Usuarios");
	msgResumen += "\n" + util.translate("scripts", "Usuarios") + ": " + numImportados;

	this.child("leMsg").text = "Importando <b>consultas</b>...";
	numImportados = this.iface.importarTabla("wi_consultas", "Consultas");
	msgResumen += "\n" + util.translate("scripts", "Consultas") + ": " + numImportados;

	this.child("leMsg").text = "Importando <b>pedidos</b>...";
	numImportados = this.iface.importarPedidos();
	msgResumen += "\n\n" + util.translate("scripts", "Pedidos") + ": " + numImportados;

	MessageBox.information(msgResumen, MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);

	this.iface.desconectar();
	this.child("pushButtonAccept").animateClick();
}

function oficial_conectar() 
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();

	var driver:String = cursor.valueBuffer("driver");
	var nombreBD:String = cursor.valueBuffer("nombrebd");
	var usuario:String = cursor.valueBuffer("usuario");
	var host:String = cursor.valueBuffer("host");
	var puerto:String = cursor.valueBuffer("puerto");

	var tipoDriver:String;
	if (sys.nameDriver().search("PSQL") > -1)
		tipoDriver = "PostgreSQL";
	else
		tipoDriver = "MySQL";

	if (host == sys.nameHost() && nombreBD == sys.nameBD() && driver == tipoDriver) {
		MessageBox.warning(util.translate("scripts",
			"Los datos de conexión son los de la presente base de datos\nDebe indicar los datos de conexión de la base de datos remota"),
			MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}

	if (!driver || !nombreBD || !usuario || !host) {
		MessageBox.warning(util.translate("scripts",
			"Debe indicar el tipo de base de datos, nombre de la misma, usuario y servidor"),
			MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}

	var password:String = Input.getText( util.translate("scripts", "Password de conexión (en caso necesario)") );

	this.child("leMsg").text = "Conectando...";

	if (!sys.addDatabase(driver, nombreBD, usuario, password, host, puerto, this.iface.conexion)) {
		this.child("leMsg").text = "Error de conexión";
		return false;
	}
		
	this.child("leMsg").text = "Conectado";
	return true;
}

function oficial_desconectar() 
{
	var cursor:FLSqlCursor = this.cursor();
	var nombreBD:String = cursor.valueBuffer("nombrebd");
	
	if (!sys.removeDatabase(this.iface.conexion));
		return false;
		
	return true;
}

function oficial_importarTabla(tabla:String, nomTabla:String)
{
	var util:FLUtil = new FLUtil();

	var curLoc:FLSqlCursor = new FLSqlCursor(tabla);
  	var curRem:FLSqlCursor = new FLSqlCursor(tabla, this.iface.conexion);

	var campoClave:String = curLoc.primaryKey();
	var listaCampos:Array = this.iface.obtenerListaCampos(tabla);

	var valorClave;
	var paso:Number = 0;
	var importados:Number = 0;
 	var valor;

 	curRem.select("modificado = true");
	util.createProgressDialog( util.translate( "scripts", "Importando " ) + nomTabla, curRem.size());
	util.setProgress(1);

 	while (curRem.next()) {
		util.setProgress(paso++);

 		valorClave = curRem.valueBuffer(campoClave);
		curLoc.select(campoClave + " = '" + valorClave + "'");

		// Actualizacion (si toca)
		if (curLoc.first()) {
			curLoc.setModeAccess(curLoc.Edit);				
			// Si ya está en local, lo actualizamos en remoto como no modificado
			curRem.setModeAccess(curLoc.Edit);
			curRem.refreshBuffer();
			curRem.setValueBuffer("modificado", false);
			
			if (!curRem.commitBuffer())
				debug(util.translate("scripts",	"Error al actualizar la tabla local %0 en el código/id " ).arg(tabla) + valorClave);
		}
		else
			curLoc.setModeAccess(curLoc.Insert);

		curLoc.refreshBuffer();

		// Bucle de campos
		for(var i = 0; i < listaCampos.length; i++) {

			// Excepciones *****************
			if (listaCampos[i] == "coddir" && tabla == "pedidoscli")
				continue;

			valor = curRem.valueBuffer(listaCampos[i]);
			curLoc.setValueBuffer(listaCampos[i], valor);
		}

		// El local queda sin modificar
		curLoc.setValueBuffer("modificado", false);

		// OK local
		if (curLoc.commitBuffer()) {

			curRem.setModeAccess(curLoc.Edit);
			curRem.refreshBuffer();
			curRem.setValueBuffer("modificado", false);
 			if (!curRem.commitBuffer())
 				debug(util.translate("scripts",	"Error al actualizar la tabla local %0 el código/id " ).arg(tabla) + valorClave);

			importados++;
		}

		// Error
		else
			debug(util.translate("scripts",	"Error al importar en la tabla remota %0 el código/id " ).arg(tabla) + valorClave);
	}

	return importados;
}

function oficial_importarPedidos()
{
	var util:FLUtil = new FLUtil();

	// Pedidos
	var curLoc:FLSqlCursor = new FLSqlCursor("pedidoscli");
  	var curRem:FLSqlCursor = new FLSqlCursor("pedidoscli", this.iface.conexion);
	var campoClave:String = "codigo";
	var listaCampos:Array = this.iface.obtenerListaCampos("pedidoscli");

	var curLocL:FLSqlCursor = new FLSqlCursor("lineaspedidoscli");
  	var curRemL:FLSqlCursor = new FLSqlCursor("lineaspedidoscli", this.iface.conexion);
	var listaCamposL:Array = this.iface.obtenerListaCampos("lineaspedidoscli");

	var valorClave;
	var idPedido:Number;
	var paso:Number = 0;
	var importados:Number = 0;

 	curRem.select("modificado = true");
	
	util.createProgressDialog( util.translate( "scripts", "Importando pedidos" ), curLoc.size());
	util.setProgress(1);
	
 	while (curRem.next()) {

		util.setProgress(paso++);
		modificado = false;

 		valorClave = curRem.valueBuffer(campoClave);
		curLoc.select(campoClave + " = '" + valorClave + "'");

		if (curLoc.first()) {
			// Si ya está en local, lo actualizamos en remoto como no modificado
			curRem.setModeAccess(curLoc.Edit);
			curRem.refreshBuffer();
			curRem.setValueBuffer("modificado", false);
			if (!curRem.commitBuffer())
				debug(util.translate("scripts",	"Error al actualizar la tabla remota pedidoscli en el código/id " ) + valorClave);
			continue;
		}

		curLoc.setModeAccess(curLoc.Insert);
		curLoc.refreshBuffer();

		// Bucle de campos
		for(var i = 0; i < listaCampos.length; i++) {

			// Excepciones *****************
			if ((listaCampos[i] == "coddir" || listaCampos[i] == "coddirenv" || listaCampos[i] == "idpedido"))
				continue;

			curLoc.setValueBuffer(listaCampos[i], curRem.valueBuffer(listaCampos[i]));
		}

		curLoc.setValueBuffer("publico", true);
		if (curLoc.commitBuffer())
			importados++;
		else
			debug(util.translate("scripts",	"Error al importar el pedido " ) + valorClave);

		
		idPedidoRem = curRem.valueBuffer("idpedido");
		idPedidoLoc = curLoc.valueBuffer("idpedido");

		// Lineas *******************
	 	curRemL.select("idpedido = " + idPedidoRem);
	 	while (curRemL.next()) {

			curLocL.setModeAccess(curLocL.Insert);
			curLocL.refreshBuffer();

			for(var iL = 0; iL < listaCamposL.length; iL++) {

				// Excepciones *****************
				if (listaCamposL[iL] == "idlinea") continue;

				curLocL.setValueBuffer(listaCamposL[iL], curRemL.valueBuffer(listaCamposL[iL]));
			}

			curLocL.setValueBuffer("idpedido", idPedidoLoc);

			if (!curLocL.commitBuffer())
				debug(util.translate("scripts",	"Error al importar en la línea de pedido para el pedido " ) + valorClave);
		}


	}

	util.destroyProgressDialog();
	return importados;
}


function oficial_exportarTabla(tabla:String, nomTabla:String, campoClave:String)
{
	var util:FLUtil = new FLUtil();
	
	debug("exportando " + nomTabla);

	var curMod:FLSqlCursor = new FLSqlCursor("wi_modificados");
 	
 	curMod.select("tabla = '" + tabla + "'");
	if (curMod.size() == 0) 
		return 0;
	
	var curLoc:FLSqlCursor = new FLSqlCursor(tabla);
  	var curRem:FLSqlCursor = new FLSqlCursor(tabla, this.iface.conexion);

	if (!campoClave)
		campoClave = curLoc.primaryKey();
	
	var listaCampos:Array = this.iface.obtenerListaCampos(tabla);
	
	var valorClave;
	var paso:Number = 0;
	var exportados:Number = 0;
	
	util.createProgressDialog( util.translate( "scripts", "Exportando " ) + tabla, curMod.size());
	util.setProgress(1);
	debug("Tabla " + tabla);

 	while (curMod.next()) {

		util.setProgress(paso++);
		
		curLoc.select(campoClave + " = '" + curMod.valueBuffer("clave") + "'");
		
		if (!curLoc.first()) {
			this.iface.borrarLocal(curMod);
			continue;
		}

		switch(tabla) {
			case "mv_funcional":
				if (!util.sqlSelect("articulos", "referencia", "codfuncional = '" + curLoc.valueBuffer("codfuncional") + "'")) {
					this.iface.borrarLocal(curMod);
					continue;	
				}
			break;
			
			case "gd_documentos":
				var codTipo:String = curLoc.valueBuffer("codtipo");
				if (codTipo != "Captura" && codTipo != "Documento" && codTipo != "Vídeo") {
					this.iface.borrarLocal(curMod);
					continue;	
				}
			break;
		}

 		
		valorClave = curLoc.valueBuffer(campoClave);

		curRem.select(campoClave + " = '" + valorClave + "'");

		// Actualizacion (si toca)
		if (curRem.first()) {
			if (this.iface.registrosIguales(listaCampos, curLoc, curRem)) {
				this.iface.borrarLocal(curMod);
				continue;
			}
			curRem.setModeAccess(curRem.Edit);
		}
		else {
			curRem.setModeAccess(curRem.Insert);
		}

		curRem.refreshBuffer();
		curRem.setActivatedCheckIntegrity(false);

		// Bucle de campos
		for(var i = 0; i < listaCampos.length; i++) {
			curRem.setValueBuffer(listaCampos[i], curLoc.valueBuffer(listaCampos[i]));
		}

		// OK remoto
		if (curRem.commitBuffer()) {

			// Actualizamos el local como no modificado
			if (!curMod.valueBuffer("borrado"))
				this.iface.borrarLocal(curMod);

			exportados++;
		}

		// Error
		else {
			debug(util.translate("scripts",	"Error al exportar en la tabla remota %0 el código/id " ).arg(tabla) + valorClave);
		}

	}

	util.destroyProgressDialog();
	return exportados;
}


function oficial_actualizarPedidos():Number
{
	var util:FLUtil = new FLUtil();
	var tabla:String = "pedidoscli";

	var curMod:FLSqlCursor = new FLSqlCursor("wi_modificados");
 	curMod.select("tabla = '" + tabla + "'");
 	debug("tabla = '" + tabla + "'");
	if (curMod.size() == 0) 
		return 0;	
	
	var curLoc:FLSqlCursor = new FLSqlCursor(tabla);
  	var curRem:FLSqlCursor = new FLSqlCursor(tabla, this.iface.conexion);
 	
	var campoClave:String = "codigo";
	var listaCampos = new Array("estado", "horapago");

	var valorClave;
	var paso:Number = 0;
	var exportados:Number = 0;

	util.createProgressDialog( util.translate( "scripts", "Actualizando pedidos" ), curMod.size());
	util.setProgress(1);
	
 	while (curMod.next()) {

		util.setProgress(paso++);
 		
 		curLoc.select("idpedido = " + curMod.valueBuffer("clave"));
		if (!curLoc.first()) {
			this.iface.borrarLocal(curMod);
			continue;
		}
 		 		
 		valorClave = curLoc.valueBuffer(campoClave);

		debug(campoClave + " = '" + valorClave + "'");
		curRem.select(campoClave + " = '" + valorClave + "'");

		// Actualizacion (si toca)
		if (!curRem.first())  {
			this.iface.borrarLocal(curMod);
			continue;
		}

		curRem.setModeAccess(curRem.Edit);
		curRem.refreshBuffer();

		// Bucle de campos
		for(var i = 0; i < listaCampos.length; i++)
			curRem.setValueBuffer(listaCampos[i], curLoc.valueBuffer(listaCampos[i]));

		// OK remoto. Borramos el registro en la tabla de modificados
		if (curRem.commitBuffer()) {
			this.iface.borrarLocal(curMod);
			exportados++;
		}

		// Error
		else
			debug(util.translate("scripts",	"Error al exportar en la tabla remota %0 el código/id " ).arg(tabla) + valorClave);

	}

	util.destroyProgressDialog();
	return exportados;
}

/** \D Elimina los registros en remoto que han sido eliminados en local previamente
*/
function oficial_obsoletosTabla(tabla:String, campoClave:String):Number
{
	var util:FLUtil = new FLUtil();

	var curMod:FLSqlCursor = new FLSqlCursor("wi_modificados");
 	curMod.select("tabla = '" + tabla + "' AND borrado = true");
	if (!curMod.size())
		return 0;
	
	var curLoc:FLSqlCursor = new FLSqlCursor(tabla);
  	var curRem:FLSqlCursor = new FLSqlCursor(tabla, this.iface.conexion);

	if (!campoClave)
		campoClave = curLoc.primaryKey();
	
	var valorClave;
	var paso:Number = 0;
	var eliminados:Number = 0;

	util.createProgressDialog( util.translate( "scripts", "Buscando eliminados en " ) + tabla, curMod.size());
	util.setProgress(1);
	
 	while (curMod.next()) {

		util.setProgress(paso++);

		curRem.select(campoClave + " = '" + curMod.valueBuffer("clave") + "'");
		if (!curRem.first()) {
			this.iface.borrarLocal(curMod);
			continue;	
		}
		
		curRem.setModeAccess(curRem.Del);
		curRem.refreshBuffer();
		curRem.setActivatedCheckIntegrity(false);
		
		if (curRem.commitBuffer()) {
			eliminados++;
			this.iface.borrarLocal(curMod);
		}
		else {
			debug(util.translate("scripts",	"Error al eliminar de la tabla remota %0 el código/id " ).arg(tabla) + valorClave);
		}
	}

	util.destroyProgressDialog();
	return eliminados;
}


function oficial_obtenerListaCampos(tabla:String):Array
{
	var util:FLUtil = new FLUtil();
	var contenido:String = util.sqlSelect("flfiles", "contenido", "nombre = '" + tabla + ".mtd'");
	
	var xmlContenido = new FLDomDocument();
	xmlContenido.setContent(contenido);
	
	var listaCampos:FLDomNodeList;
	listaCampos= xmlContenido.elementsByTagName("field");
	
	var arrayCampos:Array = [];
	var paso:Number = 0;
	for(var i = 0; i < listaCampos.length(); i++) {
		if (!listaCampos.item(i).namedItem("name")) 
			continue;
		arrayCampos[paso] = listaCampos.item(i).namedItem("name").toElement().text();
		paso++;
	}
	return arrayCampos;
}

function oficial_registrosIguales(listaCampos:Array, curLoc:FLSqlCursor, curRem:FLSqlCursor):Array
{
	var util:FLUtil = new FLUtil();
	var shaLoc:String = "";
	var shaRem:String = "";

	for(var i = 0; i < listaCampos.length; i++) {
	
		switch (curLoc.fieldType(listaCampos[i])) {
		 
			// Tipo bool - unificar postgre y mysql
		 	case 18:			
				if (curLoc.valueBuffer(listaCampos[i]))
					shaLoc += "true";
				else (curLoc.valueBuffer(listaCampos[i]))
					shaLoc += "false";
				
				if (curRem.valueBuffer(listaCampos[i]))
					shaRem += "true";
				else (curRem.valueBuffer(listaCampos[i]))
					shaRem += "false";
			break;
			
			// Tipo numérico
		 	case 16:
		 	case 17:
		 	case 18:
		 	case 19:
				shaLoc += parseFloat(curLoc.valueBuffer(listaCampos[i])).toString();
				shaRem += parseFloat(curRem.valueBuffer(listaCampos[i])).toString();
			break;
			
			default:
				shaLoc += util.sha1(curLoc.valueBuffer(listaCampos[i]));
				shaRem += util.sha1(curRem.valueBuffer(listaCampos[i]));
		}
	}
	
	if (shaLoc == shaRem)
		return true;
		
	
	return false;
}


/** Actualiza las tablas flmetadata y flfiles en la bd remota
*/
function oficial_actualizarMetadatos()
{
	var util:FLUtil = new FLUtil();
	
// 	var res = MessageBox.information(util.translate("scripts", "A continuación se establecerá una conexión con la base de datos remota\ny se actualizarán los metadatos de todas las tablas\n\n¿Desea continuar?"),
// 		MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
// 	if (res != MessageBox.Yes)
// 		return false;

	if (!this.iface.conectar())
		return false;
	
	var filtro:String = "";
	for (var i:Number = 0; i < this.iface.tablas.length; i++) {
		if (i > 0) filtro += ",";
		filtro +=  "'" + this.iface.tablas[i] + ".mtd'";
	}
	
	filtro +=  ",'wi_usuarios.mtd','pedidoscli.mtd','lineaspedidoscli.mtd'";
	filtro = "nombre IN (" + filtro + ")";
	
	var tabla:String = "flfiles";
	var campoClave:String = "nombre";
	var listaCampos = ["nombre", "bloqueo", "idmodulo", "sha", "contenido"];
	
	var valorClave:String;
	var curLoc:FLSqlCursor = new FLSqlCursor(tabla);
  	var curRem:FLSqlCursor = new FLSqlCursor(tabla, this.iface.conexion);
	var paso:Number = 0;

 	curLoc.select(filtro);

// 	if (!curLoc.size())
// 		return;

	util.createProgressDialog( util.translate( "scripts", "Exportando " ) + tabla, curLoc.size());
	util.setProgress(1);

 	while (curLoc.next()) {

		util.setProgress(paso++);
		valorClave = curLoc.valueBuffer(campoClave);

		util.setLabelText( util.translate( "scripts", "Exportando estructura de " ) + curLoc.valueBuffer("nombre"));
		
		curRem.select(campoClave + " = '" + valorClave + "'");

		// Actualizacion (si toca)
		if (curRem.first())
			curRem.setModeAccess(curRem.Edit);
		else
			curRem.setModeAccess(curRem.Insert);

		curRem.refreshBuffer();

		// Bucle de campos
		for(var i = 0; i < listaCampos.length; i++)
			curRem.setValueBuffer(listaCampos[i], curLoc.valueBuffer(listaCampos[i]));

		// OK remoto
		if (!curRem.commitBuffer())
			debug(util.translate("scripts",	"Error al exportar en la tabla remota %0 el código/id " ).arg(tabla) + valorClave);

	}

	util.destroyProgressDialog();
	
	MessageBox.information("Actualización finalizada", MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
	this.iface.desconectar();
}

function oficial_borrarLocal(curMod:FLSqlCursor)
{
	var util:FLUtil = new FLUtil();
	curMod.setModeAccess(curMod.Del);
	curMod.refreshBuffer();
	if (!curMod.commitBuffer())
		debug(util.translate("scripts",	"Error al actualizar la tabla local %0 el código/id " ).arg(tabla) + valorClave);
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
