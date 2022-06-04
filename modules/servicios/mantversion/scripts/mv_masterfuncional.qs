/***************************************************************************
                 mv_masterfuncional.qs  -  description
                             -------------------
    begin                : lun mar 28 2005
    copyright            : (C) 2005 by InfoSiAL S.L.
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
/* \C
Este formulario permite realizar las operaciones que componen el ciclo completo de desarrollo de una funcionalidad:
<ul>
  <li>Crear una nueva funcionalidad en el repositorio: Crearemos primero el registro de la funcionalidad y despu�s, con el registro seleccionado, pulsaremos el bot�n 'Crear funcionalidad en el repositorio'. Esto genera un nuevo directorio 'nombre_funcionalidad/tronco/' en la rama del repositorio .../funcional/</li>
  <li>Obtener una copia local de la funcionalidad. Con la funcionalidad seleccionada pulsaremos el bot�n 'Obtener funcionalidad del repositorio'. Esto nos crea, en el directorio de trabajo, un directorio con el nombre de la funcionalidad, as� como tres subdirectorios:
      <ul>
        <li>previo: Contiene los m�dulos afectados en su estado previo a la aplicaci�n del parche.</li>
        <li>nuevo: Contiene los m�dulos afectados una vez aplicado el parche.</li>
        <li>nombre_funcionalidad: Contiene el fichero de parche nombre_funcionalidad.xml y los ficheros nuevos y de diferencias que componen el parche. </li>
        <li>test: Contiene los ficheros de las pruebas asociadas a cada una de las funcionalidades
      </ul>
  </li>
  <li>Desarrollar la funcionalidad: Para ello actuaremos siempre sobre el directorio Nuevo, modificando los ficheros que sea necesario hasta completar la funcionalidad. Una vez echo esto, o siempre que queramos guardar el trabajo realizado, debemos pulsar el bot�n 'Actualizar funcionalidad', de forma que el directorio Nombre_funcionalidad se regenera autom�ticamente a partir de las diferencias encontradas entre los directorios Previo y Nuevo.</li>
  <li>Subir la copia local de la funcionalidad seleccionadad al repositorio: Seleccionaremos la funcionalidad y pulsaremos el bot�n 'Subir funcionalidad al repositorio'. Con ello subiremos el contenido del directoio Nombre_funcionalidad/Nombre_funcionalidad al repositorio. Antes de realizar la operaci�n podremos incluir el el fichero Changelog asociado a la funcionalidad una o m�s entradas que describan los cambios realizados</li>
</ul>

Comprobaci�n del parche. Para cerciorarnos de que el parche funciona correctamente, podemos generar un directorio de pruebas mediante el bot�n 'Generar una funcionalidad de prueba'. Esto permite crear un directorio �prueba' que es copia de 'previo' y que tiene aplicadas las modificaciones del parche. Si todo va bien, la funcionalidad del directorio 'prueba' debe coincidir con la del directorio 'nuevo'.

En el desarrollo normal, a la hora de pasar un cambio de uno o m�s ficheros esde 'nuevo' hasta 'prueba', podemos usar el bot�n 'Recargar Pruebas'. Mediante este bot�n detectamos los ficheros modificados, actualizamos el parche y lo aplicamos de nuevo sobre el directorio 'prueba'.
*/
////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/** @class_declaration interna */
//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
class interna
{
  var ctx: Object;
  function interna(context)
  {
    this.ctx = context;
  }
  function init()
  {
    this.ctx.interna_init();
  }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna
{
  function oficial(context)
  {
    interna(context);
  }
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends oficial {
	var tbnCrearFun:Object;
	var tbnBajarFun:Object;
	var tbnSubirFun:Object;
	var tbnActualizarFun:Object;
	var tbnProbarFun:Object;
	var tbnRecargarFun:Object;
	var util:FLUtil;
	var pathLocal:String;
	var urlRepositorioMod:String;
// 	var urlRepositorioFun:String;
// 	var versionTronco_:String;
// 	var urlRepositorioWebOficial:String;
// 	var urlRepositorioWebFun:String;
// 	var versionOficial:String;
	var xmlParche:FLDomDocument;
	var funcionalParche:String;
		
	function head( context ) { oficial ( context ); }
	function tbnCrearFun_clicked() {
		return this.ctx.head_tbnCrearFun_clicked();
	}
	function dameCodFuncional(curId) {
		return this.ctx.head_dameCodFuncional(curId);
	}
	function mtdBajarFun(curId) {
		return this.ctx.head_mtdBajarFun(curId);
	}
	function mtdSubirFun(curId) {
		return this.ctx.head_mtdSubirFun(curId);
	}
	function mtdBajarPro(curId) {
		return this.ctx.head_mtdBajarPro(curId);
	}
	function mtdExportarPro(curId) {
		return this.ctx.head_mtdExportarPro(curId);
	}
	function mtdActualizarFun(curId) {
		return this.ctx.head_mtdActualizarFun(curId);
	}
	function mtdProbarFun(curId) {
		return this.ctx.head_mtdProbarFun(curId);
	}
	function mtdRecargarFun(curId) {
		return this.ctx.head_mtdRecargarFun(curId);
	}
	function tbnProbarFun_clicked() {
		return this.ctx.head_tbnProbarFun_clicked();
	}
	function tbnRecargarFun_clicked() {
		return this.ctx.head_tbnRecargarFun_clicked();
	}
	function crearFun(codFuncional:String) {
		return this.ctx.head_crearFun(codFuncional);
	}
	function bajarFun(codFuncional:String) {
		return this.ctx.head_bajarFun(codFuncional);
	}
	function subirFun(codFuncional:String) {
		return this.ctx.head_subirFun(codFuncional);
	}
	function actualizarFun(codFuncional:String) {
		return this.ctx.head_actualizarFun(codFuncional);
	}
	function probarFun(codFuncional:String) {
		return this.ctx.head_probarFun(codFuncional);
	}
	function recargarFun(codFuncional:String) {
		return this.ctx.head_recargarFun(codFuncional);
	}
	function generarDirPrevio(codFuncional:String):Boolean {
		return this.ctx.head_generarDirPrevio(codFuncional);
	}
	function generarDirPrueba(codFuncional:String, directorio:String):Boolean {
		return this.ctx.head_generarDirPrueba(codFuncional, directorio);
	}
	function crearParche(ruta:String):Boolean {
		return this.ctx.head_crearParche(ruta);
	}
	function funcionalidadExiste(codFuncional:String):Boolean {
		return this.ctx.head_funcionalidadExiste(codFuncional);
	}
	function grabarFicheroParche(ruta:String, nombre:String, contenido:String):Boolean {
		return this.ctx.head_grabarFicheroParche(ruta, nombre, contenido);
	}
	function actualizarChangelog(codFuncional:String):Boolean {
		return this.ctx.head_actualizarChangelog(codFuncional);
	}
	function regenerarParche(codFuncional:String):Boolean {
		return this.ctx.head_regenerarParche(codFuncional);
	}
	function parcheFichero(nombre:String, ruta:String, comprobar:Boolean):Boolean {
		return this.ctx.head_parcheFichero(nombre, ruta, comprobar);
	}
	function anadirNodoParche(txt:String, comprobar:Boolean):Boolean {
		return this.ctx.head_anadirNodoParche(txt, comprobar);
	}
	function buscarNodoParche(nombre:String, ruta:String):FLDomNode {
		return this.ctx.head_buscarNodoParche(nombre, ruta);
	}
	function lanzarLog(accion, codFuncional) {
		return this.ctx.head_lanzarLog(accion, codFuncional);
	}
	function comprobarConsistencia(codFuncional:String):Boolean {
		return this.ctx.head_comprobarConsistencia(codFuncional);
	}
	function anadirFicheroParche(ruta:String, nombre:String):Boolean {
		return this.ctx.head_anadirFicheroParche(ruta, nombre);
	}
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head
{
  function ifaceCtx(context)
  {
    head(context);
  }
  function pub_crearFun(codFuncional: String)
  {
    return this.crearFun(codFuncional);
  }
  function pub_bajarFun(codFuncional: String)
  {
    return this.bajarFun(codFuncional);
  }
  function pub_subirFun(codFuncional: String)
  {
    return this.subirFun(codFuncional);
  }
  function pub_actualizarFun(codFuncional: String)
  {
    return this.actualizarFun(codFuncional);
  }
  function pub_probarFun(codFuncional: String)
  {
    return this.probarFun(codFuncional);
  }
  function pub_recargarFun(codFuncional: String)
  {
    return this.recargarFun(codFuncional);
  }
	function pub_mtdBajarFun(curId) {
		return this.mtdBajarFun(curId);
	}
	function pub_mtdSubirFun(curId) {
		return this.mtdSubirFun(curId);
	}
	function pub_mtdBajarPro(curId)  {
		return this.mtdBajarPro(curId);
	}
	function pub_mtdExportarPro(curId)  {
		return this.mtdExportarPro(curId);
	}
	function pub_mtdActualizarFun(curId) {
		return this.mtdActualizarFun(curId);
	}
	function pub_mtdProbarFun(curId) {
		return this.mtdProbarFun(curId);
	}
	function pub_mtdRecargarFun(curId) {
		return this.mtdRecargarFun(curId);
	}
}

const iface = new ifaceCtx(this);
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
	this.iface.pathLocal = flmaveppal.iface.pub_obtenerPathLocal();
	flmaveppal.iface.pub_obtenerVersionTronco()
	flmaveppal.iface.cargarCodificacionLocal();
// 	this.iface.urlRepositorioMod = flmaveppal.iface.pub_obtenerUrlRepositorioMod();
// 	this.iface.urlRepositorioFun = flmaveppal.iface.pub_obtenerUrlRepositorioFun();
// 	this.iface.versionTronco_ = flmaveppal.iface.pub_obtenerVersionTronco();
// 	this.iface.urlRepositorioWebOficial = flmaveppal.iface.pub_obtenerUrlRepositorioWebOficial();
// 	this.iface.urlRepositorioWebFun = flmaveppal.iface.pub_obtenerUrlRepositorioWebFun();
// 	this.iface.versionOficial = flmaveppal.iface.pub_obtenerVersionOficial();
	
	this.iface.tbnCrearFun = this.child("tbnCrearFun");
	this.iface.tbnBajarFun = this.child("tbnBajarFun");
	this.iface.tbnSubirFun = this.child("tbnSubirFun");
	this.iface.tbnActualizarFun = this.child("tbnActualizarFun");
	this.iface.tbnProbarFun = this.child("tbnProbarFun");
	this.iface.tbnRecargarFun = this.child("tbnRecargarFun");
	
	connect(this.iface.tbnCrearFun, "clicked()", this, "iface.tbnCrearFun_clicked()");
	connect(this.iface.tbnBajarFun, "clicked()", this, "iface.mtdBajarFun()");
	connect(this.iface.tbnSubirFun, "clicked()", this, "iface.mtdSubirFun()");
	connect(this.iface.tbnActualizarFun, "clicked()", this, "iface.mtdActualizarFun()");
	connect(this.iface.tbnProbarFun, "clicked()", this, "iface.mtdProbarFun()");
	connect(this.iface.tbnRecargarFun, "clicked()", this, "iface.mtdRecargarFun()");
	
	this.cursor().setMainFilter("esproyecto = false");
	this.child("tableDBRecords").refresh();
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

/** \D Funci�n intermedia que llama a la pantalla de log estableciendo antes el c�digo de la acci�n a realizar sobre la funcionalidad o el cliente.
\end */
function head_tbnRecargarFun_clicked()
{
  this.iface.lanzarLog("FR");
}
function head_tbnProbarFun_clicked()
{
  this.iface.lanzarLog("FP");
}
function head_mtdSubirFun(curId) 
{
	var _i = this.iface;
	if (!_i.pathLocal) {
		_i.pathLocal = flmaveppal.iface.pub_obtenerPathLocal();
	}
	if (!curId) {
		var cursor = this.cursor();
		curId = cursor.valueBuffer("codfuncional");
	}	
	var codFuncional = _i.dameCodFuncional(curId);
	if (!codFuncional) {
		return;
	}
	this.iface.lanzarLog("FS", codFuncional);
}

function head_mtdBajarPro(curId) 
{
	var _i = this.iface;
	if (!_i.pathLocal) {
		_i.pathLocal = flmaveppal.iface.pub_obtenerPathLocal();
	}
	if (!curId) {
		var cursor = this.cursor();
		curId = cursor.valueBuffer("codfuncional");
	}	
	var codFuncional = _i.dameCodFuncional(curId);
	if (!codFuncional) {
		return;
	}
	this.iface.lanzarLog("PB", codFuncional);
}

function head_mtdExportarPro(curId) 
{
	var _i = this.iface;
	if (!_i.pathLocal) {
		_i.pathLocal = flmaveppal.iface.pub_obtenerPathLocal();
	}
	if (!curId) {
		var cursor = this.cursor();
		curId = cursor.valueBuffer("codfuncional");
	}	
	var codFuncional = _i.dameCodFuncional(curId);
	if (!codFuncional) {
		return;
	}
	this.iface.lanzarLog("PE", codFuncional);
}

function head_tbnCrearFun_clicked()
{
  this.iface.lanzarLog("FC");
}

function head_dameCodFuncional(curId)
{
	var codFuncional;
	debug(typeof(curId));
	if (typeof(curId) == "String" || typeof(curId) == "string" || typeof(curId) == "number") {
		codFuncional = curId;
	} else {
		switch (curId.table()) {
			case "mv_funcional": {
				codFuncional = curId.valueBuffer("codfuncional");
				break;
			}
			case "se_proyectos": {
				codFuncional = AQUtil.sqlSelect("mv_funcional", "codfuncional", "nombreproyecto = '" + curId.valueBuffer("codfuncional") + "'");
				break;
			}
			case "se_subproyectos": {
				codFuncional = AQUtil.sqlSelect("se_proyectos p INNER JOIN mv_funcional f ON p.codfuncional = f.nombreproyecto", "f.codfuncional", "p.codigo = '" + curId.valueBuffer("codproyecto") + "'", "se_proyectos,mv_funcional");
				break;
			}
		}
	} 
	if (!codFuncional) {
		MessageBox.warning(sys.translate("Error al buscar el c�digo de la funcionalidad"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
	return codFuncional;
}

function head_mtdBajarFun(curId) 
{
	var _i = this.iface;
	var lE = AQUtil.readSettingEntry("scripts/sys/conversionArENC");
	if (lE != "ISO-8859-15") {
		var res = MessageBox.warning(sys.translate("La codificaci�n para .ar no es ISO-8859-15. �Desea continuar?"), MessageBox.Yes, MessageBox.No);
		if (res != MessageBox.Yes) {
			return;
		}
	}
	if (!_i.pathLocal) {
		_i.pathLocal = flmaveppal.iface.pub_obtenerPathLocal();
	}
	if (!curId) {
		var cursor = this.cursor();
		curId = cursor.valueBuffer("codfuncional");
	}	
	var codFuncional = _i.dameCodFuncional(curId);
	if (!codFuncional) {
		return;
	}
	_i.lanzarLog("FB", codFuncional);
}

function head_mtdActualizarFun(curId)
{
	var _i = this.iface;
	if (!_i.pathLocal) {
		_i.pathLocal = flmaveppal.iface.pub_obtenerPathLocal();
	}
	if (!curId) {
		var cursor = this.cursor();
		curId = cursor.valueBuffer("codfuncional");
	}	
	var codFuncional = _i.dameCodFuncional(curId);
	if (!codFuncional) {
		return;
	}
	this.iface.lanzarLog("FA", codFuncional);
}

function head_mtdProbarFun(curId)
{
	var _i = this.iface;
	if (!_i.pathLocal) {
		_i.pathLocal = flmaveppal.iface.pub_obtenerPathLocal();
	}
	if (!curId) {
		var cursor = this.cursor();
		curId = cursor.valueBuffer("codfuncional");
	}	
	var codFuncional = _i.dameCodFuncional(curId);
	if (!codFuncional) {
		return;
	}
	this.iface.lanzarLog("FP", codFuncional);
}

function head_mtdRecargarFun(curId)
{
	var _i = this.iface;
	if (!_i.pathLocal) {
		_i.pathLocal = flmaveppal.iface.pub_obtenerPathLocal();
	}
	if (!curId) {
		var cursor = this.cursor();
		curId = cursor.valueBuffer("codfuncional");
	}	
	var codFuncional = _i.dameCodFuncional(curId);
	if (!codFuncional) {
		return;
	}
	this.iface.lanzarLog("FR", codFuncional);
}

/** \D Lanza el formulario de log, estableciendo antes en una variable global el tipo de acci�n a realizar
\end */
function head_lanzarLog(accion, codFuncional)
{
	if (!codFuncional) {
		codFuncional = this.cursor().valueBuffer("codfuncional");
	}
	if (!codFuncional) {
		return;
	}
	var miVar:FLVar = new FLVar();
	miVar.set("ACCIONMV", accion);
	
	flmaveppal.iface.pub_obtenerUrlRepositorioMod()
	flmaveppal.iface.pub_log = new FLFormSearchDB("mv_log");
	var cursor:FLSqlCursor = flmaveppal.iface.pub_log.cursor();
	cursor.select("codfuncional = '" + codFuncional + "'");
	cursor.first();
	cursor.setModeAccess(cursor.Browse);
	flmaveppal.iface.pub_log.setMainWidget();
	cursor.refreshBuffer();
	flmaveppal.iface.pub_log.exec("codfuncional");
	flmaveppal.iface.pub_log.close();
}

/** \D Genera un subdirectorio con la funcionalidad que en debe ser igual al directorio 'Nuevo' y sirve para comprobar que el parche generado funciona correctamente
\end */
function head_recargarFun(codFuncional: String)
{
  Dir.current = flmaveppal.iface.pathLocal;
  if (!File.exists(codFuncional)) {
    MessageBox.warning(Dir.current + "/" + codFuncional + "\n" + AQUtil.translate("scripts", "El directorio local no existe. No es posible regenerar el directorio de prueba"), MessageBox.Yes, MessageBox.NoButton, MessageBox.NoButton);
    return;
  }

  if (!File.exists(codFuncional + "/prueba")) {
    MessageBox.warning(Dir.current + "/" + codFuncional + "\n" + AQUtil.translate("scripts", "El directorio prueba no existe. Debe crear el directorio."), MessageBox.Yes, MessageBox.NoButton, MessageBox.NoButton);
    return;
  }

  if (!this.iface.regenerarParche(codFuncional)) {
    flmaveppal.iface.pub_logAdd("Error al regenerar el parche y el directorio de pruebas");
    return;
  }

  flmaveppal.iface.pub_logAdd(AQUtil.translate("scripts", "El parche y el directorio de pruebas asociado a la funcionalidad seleccionada ha sido regenerado correctamente"));
  sys.processEvents();
}

/** \D Busca los ficheros que se han modificado despu�s de el fichero de parche 'funcionalidad.xml'. Para cada fichero extrae su parche, lo aplica al directorio 'prueba' y modifica el parche 'funcionalidad.xml'

@param  codFuncional: C�digo de la funcionalidad
@return True si no hay error, false en caso contrario
\end */
function head_regenerarParche(codFuncional: String): Boolean {
  var dirParche: String = codFuncional + "/" + codFuncional + "/";
  var rutaParche: String = flmaveppal.iface.pathLocal + dirParche;

  this.iface.funcionalParche = codFuncional;
  if (!this.iface.xmlParche)
    this.iface.xmlParche = new FLDomDocument;

  if (!this.iface.xmlParche.setContent(File.read(rutaParche + codFuncional + ".xml")))
  {
    flmaveppal.iface.pub_logAdd("Error al leer el fichero " + codFuncional + ".xml");
    return false;
  }

  Dir.current = flmaveppal.iface.pathLocal + codFuncional + "/nuevo/";
  var comando: String = "find . -newer " + rutaParche + codFuncional + ".xml -type f";
  var resComando: Array = flmaveppal.iface.pub_ejecutarComando(comando);
  if (resComando.ok == false)
  {
    flmaveppal.iface.pub_logAdd("Error al Buscar los ficheros que han cambiado en el directorio nuevo");
    return false;
  }

  var ruta: String;
  var nombre: String;
  var ficheros: Array = resComando.salida.split("\n");
  if (ficheros.length == 1)
    return true;

  var posAux: Number;
  for (var i: Number = 0; i < (ficheros.length - 1); i++)
  {
    posAux = ficheros[i].findRev("/") + 1;
    nombre = ficheros[i].substring(posAux, ficheros[i].length);
    if (nombre.endsWith("~"))
      continue;
    ruta = ficheros[i].substring(2, posAux);
    if (!this.iface.parcheFichero(nombre, ruta, true))
      return false;

    var nodo: FLDomNode = this.iface.buscarNodoParche(nombre, ruta);
    if (!nodo)
      continue;

    if (!flmaveppal.iface.pub_aplicarParcheNodo(nodo, dirParche, codFuncional + "/previo/", codFuncional + "/prueba/"))
      return false;
  }

  if (!this.iface.grabarFicheroParche(flmaveppal.iface.pathLocal + dirParche,
  codFuncional + ".xml", this.iface.xmlParche.toString(4)))
  {
    flmaveppal.iface.pub_logAdd("Error al guardar el fichero " + codFuncional + ".xml");
    return false;
  }

  return true;
}

/** \D Genera un subdirectorio con la funcionalidad que en debe ser igual al directorio 'Nuevo' y sirve para comprobar que el parche generado funciona correctamente
\end */
function head_probarFun(codFuncional: String)
{
  if (!this.iface.funcionalidadExiste(codFuncional)) {
    return;
  }

  Dir.current = flmaveppal.iface.pathLocal;
  if (!File.exists(codFuncional)) {
    MessageBox.warning(Dir.current + "/" + codFuncional + "\n" + AQUtil.translate("scripts", "El directorio local no existe. No es posible generar el directorio de prueba"), MessageBox.Yes, MessageBox.NoButton, MessageBox.NoButton);
    return;
  }

  if (!this.iface.generarDirPrueba(codFuncional, "prueba")) {
    flmaveppal.iface.pub_logAdd("Error al generar el directorio 'prueba'");
    return;
  }

  var comando: String = "touch " + flmaveppal.iface.pathLocal + codFuncional + "/" + codFuncional + "/" + codFuncional + ".xml";
  var resComando: Array = flmaveppal.iface.pub_ejecutarComando(comando);
  if (resComando.ok == false) {
    return;
  }

  flmaveppal.iface.pub_logAdd(AQUtil.translate("scripts", "El directorio de pruebas asociado a la funcionalidad seleccionada ha sido regenerado correctamente"));
  sys.processEvents();
}

/** \D Actualiza la funcionalidad seleccionada en el repositorio
\end */
function head_subirFun(codFuncional: String)
{
  if (!this.iface.funcionalidadExiste(codFuncional))
    return;


  if (!this.iface.comprobarConsistencia(codFuncional))
    return;

  var res: Number = MessageBox.warning(AQUtil.translate("scripts", "Va a actualizar en el repositorio la funcionalidad %1").arg(codFuncional), MessageBox.Yes, MessageBox.No);
  if (res != MessageBox.Yes)
    return;

  if (!this.iface.actualizarChangelog(codFuncional)) {
    flmaveppal.iface.pub_logAdd("Error al actualizar el Changelog");
    return false;
  }

  var comando: String = "svn commit " + flmaveppal.iface.pathLocal + codFuncional + "/" + codFuncional + " -m AUTO_ACTUALIZACION_" + codFuncional;
  flmaveppal.iface.pub_logAdd("Ejecutando " + comando);
  var resComando: Array = flmaveppal.iface.pub_ejecutarComando(comando);
  if (resComando.ok == false) {
    flmaveppal.iface.pub_logAdd(AQUtil.translate("scripts", "Error al actualizar la funcionalidad en el repositorio"));
    return;
  }
  flmaveppal.iface.pub_logAdd("OK");

  flmaveppal.iface.pub_logAdd(AQUtil.translate("scripts", "La funcionalidad seleccionada se actualiz� correctamente en el repositorio"));

  // Actualizamos la fecha de modificaci�n
  var hoy = new Date();
  var cursor: FLSqlCursor = this.cursor();
  cursor.setModeAccess(cursor.Edit);
  cursor.refreshBuffer();
  cursor.setValueBuffer("fechamod", hoy);
  if (!cursor.commitBuffer())
    flmaveppal.iface.pub_logAdd("Error al actualizar la fecha de modificaci�n de la funcionalidad");
  else
    flmaveppal.iface.pub_logAdd("Fecha de modificaci�n actualizada a  " + hoy.toString());

  sys.processEvents();
}

/** \D Comprueba que todos los ficheros del directorio del parche est�n en la lista del parche y viceversa
@param  codFuncional: C�digo de la funcionalidad a comprobar
\end */
function head_comprobarConsistencia(codFuncional: String): Boolean {
  Dir.current = flmaveppal.iface.pub_obtenerPathLocal();
  var dirParche: String = codFuncional + "/" + codFuncional;

  flmaveppal.iface.pub_logAdd("Comprobando consistencia para %1...".arg(codFuncional));
  sys.processEvents();

  if (!File.exists(dirParche + "/" + codFuncional + ".xml"))
  {
    flmaveppal.iface.pub_logAdd("El parche " + codFuncional + " est� vac�o");
    return false;
  }
  var xmlParche: FLDomDocument = new FLDomDocument;
  xmlParche.setContent(File.read(dirParche + "/" + codFuncional + ".xml"));
  var nodo: FLDomNode;
  var nodoDoc: FLDomNode = xmlParche.namedItem("flpatch:modifications");

  var ok: Boolean = true;
  var fichero: String;
  for (nodo = nodoDoc.firstChild(); nodo; nodo = nodo.nextSibling())
  {
    fichero = nodo.toElement().attribute("name");
    if (!File.exists(dirParche + "/" + fichero)) {
      ok = false;
      flmaveppal.iface.pub_logAdd("La entrada para el fichero %1 del fichero %2 no existe en el directorio %2".arg(fichero).arg(codFuncional + ".xml").arg(codFuncional));
    }
  }

  var dirFuncional = new Dir(dirParche);
  var ficheros: Array = dirFuncional.entryList("*");
  var encontrado: Boolean;
  //  var contenido:String = "";
  //  var rutaFichDestino:String = "";
  //  var rutaFichOrigen:String = "";

  for (var i: Number = 0; i < ficheros.length; i++)
  {
    //rutaFichero = dirParche + "/" + ficheros[i];
    debug("ficheros = " + ficheros[i]);
    if (ficheros[i] == "." || ficheros[i] == "..") {
      continue;
    }
    if (ficheros[i] == "Changelog" || ficheros[i] == "test") {
      continue;
    }
    if (ficheros[i].endsWith("~")) {
      continue;
    }
    if (ficheros[i] == (codFuncional + ".xml")) {
      continue;
    }
    encontrado = false;
    for (nodo = nodoDoc.firstChild(); nodo; nodo = nodo.nextSibling()) {
      if (nodo.toElement().attribute("name") == ficheros[i]) {
        encontrado = true;
        break;
      }
    }
    if (!encontrado) {
      ok = false;
      flmaveppal.iface.pub_logAdd("El fichero %1 no tiene una entrada en el fichero de parche %2)".arg(ficheros[i]).arg(codFuncional + ".xml"));
    }
  }
  if (ok)
  {
    flmaveppal.iface.pub_logAdd("COMPROBACI�N DE CONSISTENCIA OK");
  } else {
    flmaveppal.iface.pub_logAdd("ERROR DE CONSISTENCIA EN EL PARCHE");
  }

  return ok;
}

/** \D Actualiza el fichero Changelog asociado a la funcionalidad seleccionada antes de hacer un commit al repositorio. La actualizaci�n de este fichero es opcional a menos que el fichero est� vac�o.
@param  codFuncional: C�digo de la funcionalidad a actualizar
\end */
function head_actualizarChangelog(codFuncional: String): Boolean {
  var existe: Boolean = File.exists(this.iface.pathLocal + codFuncional + "/" + codFuncional + "/Changelog");
  if (existe)
  {
    var res: Number = MessageBox.information(AQUtil.translate("scripts", "�Desea actualizar el fichero Changelog asociado?"), MessageBox.Yes, MessageBox.No);
    if (res != MessageBox.Yes) {
      return true;
    }
  }
  var contenido: String = "";
  if (existe)
    contenido = File.read(this.iface.pathLocal + codFuncional + "/" + codFuncional + "/Changelog");
  else {
    var hoyFecha: Date = new Date;
    var hoyString: String = hoyFecha.toString();
    hoyString = hoyString.substring(8, 10) + "/" + hoyString.substring(5, 7) + "/" + hoyString.substring(0, 4);
    contenido = "!! " + hoyString + " SVN:\n* Creaci�n de la funcionalidad " + codFuncional;
  }

  var dialog = new Dialog;
  dialog.caption = "Changelog de " + codFuncional;
  dialog.okButtonText = "Aceptar"
  dialog.cancelButtonText = "Cancelar";

  var txtContenido = new TextEdit;
  txtContenido.text = contenido;
  dialog.add(txtContenido);

  if (dialog.exec())
  {
    contenido = txtContenido.text;
    if (!this.iface.grabarFicheroParche(this.iface.pathLocal + codFuncional + "/" + codFuncional + "/",
    "Changelog", contenido)) {
      flmaveppal.iface.pub_logAdd("Error al guardar el fichero Changelog");
      return false;
    }
  }

  return true;
}

/** \D Crea una funcionalidad en el repositorio
\end */
function head_crearFun(codFuncional: String)
{
  var util: FLUtil = new FLUtil;

  if (this.iface.funcionalidadExiste(codFuncional)) {
    MessageBox.warning(AQUtil.translate("scripts", "La funcionalidad seleccionada ya existe en el repositorio"), MessageBox.Ok, MessageBox.NoButton);
    return false;
  }

  var repositorio: String;
  var codigoWeb: Boolean = util.sqlSelect("mv_funcional", "codigoweb", "codfuncional = '" + codFuncional + "'");
  if (codigoWeb) {
    var urlRepositorioWebFun: String = flmaveppal.iface.pub_obtenerUrlRepositorioWebFun();
    repositorio = urlRepositorioWebFun;
  } else {
    var urlRepositorioFun: String = flmaveppal.iface.pub_obtenerUrlRepositorioFun();
    repositorio = urlRepositorioFun  + "tronco/";
  }
  var res: Number = MessageBox.warning(util.translate("scripts", "Va a crear en el repositorio %1 la funcionalidad %2").arg(repositorio).arg(codFuncional), MessageBox.Yes, MessageBox.No);
  if (res != MessageBox.Yes)
    return;

  var comando: String = "svn mkdir " + repositorio + codFuncional + " -m AUTO_CREACION_" + codFuncional;
  var resComando: Array = flmaveppal.iface.pub_ejecutarComando(comando);
  if (resComando.ok == false) {
    flmaveppal.iface.pub_logAdd(AQUtil.translate("scripts", "Error al crear la funcionalidad en el repositorio"));
    return;
  }

  comando = "svn mkdir " + repositorio + codFuncional + "/tronco -m AUTO_CREACION_" + codFuncional;
  resComando = flmaveppal.iface.pub_ejecutarComando(comando);
  if (resComando.ok == false) {
    flmaveppal.iface.pub_logAdd(AQUtil.translate("scripts", "Error al crear la funcionalidad en el repositorio"));
    return;
  }

  //  comando = "svn mkdir " + repositorio + codFuncional + "/tronco/test -m AUTO_CREACION_" + codFuncional;
  //  resComando = flmaveppal.iface.pub_ejecutarComando(comando);
  //  if (resComando.ok == false) {
  //    flmaveppal.iface.pub_logAdd(AQUtil.translate("scripts", "Error al crear la funcionalidad en el repositorio"));
  //    return;
  //  }

  flmaveppal.iface.pub_logAdd(AQUtil.translate("scripts", "La funcionalidad seleccionada se cre� correctamente en el repositorio:\n%1").arg(repositorio));
  sys.processEvents();
}

/** \D Comprueba si una determinada funcionalidad existe o no en el repositorio

@param  codFuncional: funcionalidad
@return True si la funcionalidad existe, false en caso contrario
\end */
function head_funcionalidadExiste(codFuncional: String): Boolean {
  var util: FLUtil = new FLUtil;
  var codigoWeb: Boolean = util.sqlSelect("mv_funcional", "codigoweb", "codfuncional = '" + codFuncional + "'");
  //  var versionBase:String = util.sqlSelect("mv_funcional", "versionbase", "codfuncional = '" + codFuncional + "'");
  //  if (!versionBase || versionBase == flmaveppal.iface.pub_obtenerVersionTronco()) {
  //    versionBase = "tronco";
  //  }
  // debug(codigoWeb);
  var comando: String;
  if (codigoWeb)
  {
    var urlRepositorioWebFun: String = flmaveppal.iface.pub_obtenerUrlRepositorioWebFun();
    // debug(urlRepositorioWebFun);
    comando = "svn ls " + urlRepositorioWebFun + codFuncional;
  } else {
    var urlRepositorioFun: String = flmaveppal.iface.pub_obtenerUrlRepositorioFun();
    comando = "svn ls " + urlRepositorioFun + "tronco/" + codFuncional;
  }
  // debug(comando);

  var resComando: Array = flmaveppal.iface.pub_ejecutarComando(comando);
  return resComando.ok;
}

/** \D Obtiene la funcionalidad del repositorio, creando los directorios previo, nuevo y nombre_funcionalidad para poder editarla.
\end */
function head_bajarFun(codFuncional: String)
{
  if (!this.iface.funcionalidadExiste(codFuncional))
    return;

  var dialog: Dialog = new Dialog;
  dialog.caption = AQUtil.translate("scripts", "Obtener funcionalidad");
  dialog.OKButtonText = AQUtil.translate("scripts", "Aceptar");
  dialog.cancelButtonText = AQUtil.translate("scripts", "Cancelar");

  var bgroup: GroupBox = new GroupBox;
  dialog.add(bgroup);

  var lblModBase: CheckBox = new CheckBox;
  lblModBase.text = AQUtil.translate("scripts", "M�dulos y funcionalidad base");
  lblModBase.checked = true;
  bgroup.add(lblModBase);

  var lblParche: CheckBox = new CheckBox;
  lblParche.text = AQUtil.translate("scripts", "Parche de funcionalidad");
  lblParche.checked = true;
  bgroup.add(lblParche);

  if (!dialog.exec())
    return;

  if (!lblModBase.checked && !lblParche.checked)
    return;

  Dir.current = flmaveppal.iface.pathLocal;
  if (File.exists(codFuncional)) {
    var res: Number = MessageBox.warning(Dir.current + "/" + codFuncional + "\n" + AQUtil.translate("scripts", "El directorio local ya existe �desea sobreescribirlo?"), MessageBox.Yes, MessageBox.No);
    if (res != MessageBox.Yes)
      return;
  } else {
    var resComando: Array = flmaveppal.iface.pub_ejecutarComando("mkdir " + codFuncional);
    if (resComando.ok == false) {
      flmaveppal.iface.pub_logAdd("Error mkdir arbol");
      return;
    }
  }


  if (File.exists(codFuncional + "/nuevo") && File.exists(codFuncional + "/" + codFuncional + "/" + codFuncional + ".xml")) {
    var comando: String = "find " + codFuncional + "/nuevo -newer " + codFuncional + "/" + codFuncional + "/" + codFuncional + ".xml -type f";
    var resComando: Array = flmaveppal.iface.pub_ejecutarComando(comando);
    if (resComando.ok == false) {
      flmaveppal.iface.pub_logAdd("Error al Buscar los ficheros que han cambiado en el directorio nuevo");
      return false;
    }
    var ficheros: Array = resComando.salida.split("\n");
    if (ficheros.length > 1) {
      var res: Number = MessageBox.warning(AQUtil.translate("scripts", "Los siguientes ficheros han sido modificados despues de la �ltima generaci�n del parche:\n") + resComando.salida + AQUtil.translate("scripts", "�desea continuar?"), MessageBox.Yes, MessageBox.No);
      if (res != MessageBox.Yes)
        return;
    }
  }

  if (lblModBase.checked) {
    if (!this.iface.generarDirPrevio(codFuncional)) {
      flmaveppal.iface.pub_logAdd("Error al generar el directorio 'previo'");
      return;
    }
  }

  if (lblParche.checked) {
    if (!flmaveppal.iface.pub_checkoutParche(codFuncional, codFuncional + "/" + codFuncional)) {
      flmaveppal.iface.pub_logAdd("Error al obtener el parche " + codFuncional);
      return false;
    }
  }

  if (!this.iface.generarDirPrueba(codFuncional, "nuevo")) {
    flmaveppal.iface.pub_logAdd("Error al generar el directorio 'nuevo'");
    return;
  }

  flmaveppal.iface.pub_logAdd(AQUtil.translate("scripts", "La funcionalidad seleccionada ha sido obtenida correctamente"));

  var cleanupDom = new FLDomDocument;
  cleanupDom.cleanup();

  sys.processEvents();
}

/** \D Regenera los ficheros de funcionalidad ('funcionalidad.xml' y ficheros modificados)
\end */
function head_actualizarFun(codFuncional)
{
  //var codFuncional: String = this.cursor().valueBuffer("codfuncional");
  if (!codFuncional) {
    MessageBox.warning(AQUtil.translate("scripts", "No hay ninguna funcionalidad seleccionada"), MessageBox.Ok, MessageBox.NoButton);
    return;
  }

  flmaveppal.iface.pub_logAdd("Creando parche para " + codFuncional);
  this.iface.funcionalParche = codFuncional;
  if (!this.iface.xmlParche)
    this.iface.xmlParche = new FLDomDocument;
  this.iface.xmlParche.setContent("<flpatch:modifications name=\"" + codFuncional + "\"/>");
  if (!this.iface.crearParche("")) {
    flmaveppal.iface.pub_logAdd("Error creando el parche " + codFuncional);
    return;
  }

  if (!this.iface.grabarFicheroParche(this.iface.pathLocal + "/" + codFuncional + "/" + codFuncional + "/", codFuncional + ".xml", this.iface.xmlParche.toString(4))) {
    flmaveppal.iface.pub_logAdd("Error al guardar el fichero " + codFuncional + ".xml");
    return;
  }
  flmaveppal.iface.pub_logAdd("Parche creado");
  sys.processEvents();

  MessageBox.information(AQUtil.translate("scripts", "La funcionalidad seleccionada se actualiz� correctamente"), MessageBox.Ok, MessageBox.NoButton);
}

/** \D Funci�n recursiva que regenera los ficheros de funcionalidad ('funcionalidad.xml' y ficheros modificados) en la ruta especificada.

@param  ruta: path donde reside la funcionalidad a generar
@return True si la generaci�n del parche se realiza con �xito, false en caso contrario
\end */
function head_crearParche(ruta: String): Boolean {
  var rutaNuevo: String = this.iface.pathLocal + this.iface.funcionalParche + "/nuevo/" + ruta;
  var dirNuevo: Dir = new Dir(rutaNuevo);

  var ficheros: Array = dirNuevo.entryList("*", Dir.Files);
  for (var i: Number = 0; i < ficheros.length; i++)
  {
    if (ficheros[i].endsWith("~"))
      continue;
    if (!this.iface.parcheFichero(ficheros[i], ruta, false))
      return false;
  }

  var directorios: Array = dirNuevo.entryList("*", Dir.Dirs);
  for (var i: Number = 0; i < directorios.length; i++)
  {
    if (directorios[i].startsWith("."))
      continue;
    if (!this.iface.crearParche(ruta + directorios[i] + "/")) {
      flmaveppal.iface.pub_logAdd("Error al crear parche en la ruta " + ruta + directorios[i] + "/");
      return false;
    }
  }
  return true;
}

/** \D Funci�n que actualiza el fichero de parche para un determinado fichero

@param  nombre: Nombre del fichero
@param  ruta: Path relativo al directorio 'nuevo' donde reside el fichero
@param  sustituir: Indica si el nodo de diferencias generado sustituir� a un nodo ya existente en el fichero de parche
@return True si no hay error, false en caso contrario
\end */
function head_parcheFichero(nombre: String, ruta: String, sustituir: Boolean): Boolean {
  var rutaNuevo: String = this.iface.pathLocal + this.iface.funcionalParche + "/nuevo/" + ruta;
  var rutaPrevio: String = this.iface.pathLocal + this.iface.funcionalParche + "/previo/" + ruta;
  var rutaParche: String = this.iface.pathLocal + this.iface.funcionalParche + "/" + this.iface.funcionalParche + "/";

  if (File.exists(rutaPrevio + nombre))
  {
    var comando: String = "diff --brief " + rutaNuevo + nombre + " " + rutaPrevio + nombre;
    var resComando: Array = flmaveppal.iface.pub_ejecutarComando(comando);
    if (resComando.ok == false)
      return false;
    if (resComando.salida != "") {
      var extension: String = nombre.substring(nombre.findRev(".") + 1, nombre.length);
      var contenido: String;
debug("extension " + extension);
      switch (extension) {
        case "ui":
        case "mtd":
				case "ts":
        case "xml":
          flmaveppal.iface.pub_logAdd("Generando parche para " + nombre);
          contenido = flmaveppal.iface.pub_obtenerXmlDif(rutaPrevio + nombre, rutaNuevo + nombre, this.iface.funcionalParche);
          if (!contenido) {
            flmaveppal.iface.pub_logAdd("Error al obtener diferencias para el fichero xml " + nombre);
            return false;
          }
          if (!this.iface.anadirNodoParche("<flpatch:patchXml name=\"" + nombre + "\" path=\"" + ruta + "\"/>", sustituir)) {
            return false;
          }
          if (!this.iface.grabarFicheroParche(rutaParche, nombre, contenido)) {
            flmaveppal.iface.pub_logAdd("Error al guardar el fichero " + nombre);
            return false;
          }
          break;
        case "qs":
          flmaveppal.iface.pub_logAdd("Generando parche para " + nombre);
          contenido = flmaveppal.iface.pub_obtenerScriptDif(rutaPrevio + nombre, rutaNuevo + nombre, this.iface.funcionalParche);
          if (!contenido) {
            flmaveppal.iface.pub_logAdd("Error al obtener diferencias para el script " + nombre);
            return false;
          }
          if (!this.iface.anadirNodoParche("<flpatch:patchScript name=\"" + nombre + "\" path=\"" + ruta + "\"/>", sustituir)) {
            return false;
          }
          if (!this.iface.grabarFicheroParche(rutaParche, nombre, contenido)) {
            flmaveppal.iface.pub_logAdd("Error al guardar el fichero " + nombre);
            return false;
          }
          break;
        case "php":
          flmaveppal.iface.pub_logAdd("Generando parche para " + nombre);
          contenido = flmaveppal.iface.pub_obtenerPhpDif(rutaPrevio + nombre, rutaNuevo + nombre, this.iface.funcionalParche);
          if (!contenido) {
            flmaveppal.iface.pub_logAdd("Error al obtener diferencias para el fichero php " + nombre);
            return false;
          }
          if (!this.iface.anadirNodoParche("<flpatch:patchPhp name=\"" + nombre + "\" path=\"" + ruta + "\"/>", sustituir)) {
            return false;
          }
          if (!this.iface.grabarFicheroParche(rutaParche, nombre, contenido)) {
            flmaveppal.iface.pub_logAdd("Error al guardar el fichero " + nombre);
            return false;
          }
          break;
        default:
          flmaveppal.iface.pub_logAdd("Leyendo nueva versi�n de " + nombre);

          //          contenido = File.read(rutaNuevo + nombre);
          if (!this.iface.anadirNodoParche("<flpatch:replaceFile name=\"" + nombre + "\" path=\"" + ruta + "\"/>", sustituir))
            return false;

          var comando: String = "cp -f " + rutaNuevo + nombre + " " + rutaParche + nombre;
          var resComando: Array = flmaveppal.iface.pub_ejecutarComando(comando);
          if (resComando.ok == false) {
            this.iface.pub_logAdd("Error al copiar el fichero con: " + comando);
            return;
          }
          if (!this.iface.anadirFicheroParche(rutaParche, nombre)) {
            return false;
          }
      }

      flmaveppal.iface.pub_logAdd("OK");
    }
  } else {
    flmaveppal.iface.pub_logAdd("Leyendo nuevo fichero " + nombre);
    if (!this.iface.anadirNodoParche("<flpatch:addFile name=\"" + nombre + "\" path=\"" + ruta + "\"/>", sustituir))
    {
      return false;
    }

    var comando: String = "cp -f " + rutaNuevo + nombre + " " + rutaParche + nombre;
    var resComando: Array = flmaveppal.iface.pub_ejecutarComando(comando);
    if (resComando.ok == false)
    {
      this.iface.pub_logAdd("Error al copiar el fichero con: " + comando);
      return;
    }
    if (!this.iface.anadirFicheroParche(rutaParche, nombre))
    {
      return false;
    }
    //    if (!this.iface.grabarFicheroParche(rutaParche, nombre, File.read(rutaNuevo + nombre))) {
    //      flmaveppal.iface.pub_logAdd("Error al guardar el fichero " + nombre);
    //      return false;
    //    }
    flmaveppal.iface.pub_logAdd("OK");
    sys.processEvents();
  }
  return true;
}

/** \D Establece el tipo de documento actual

@param  tipoDoc: Tipo de documento
@return true su no hay error, false en caso contrario
\end */
function head_anadirNodoParche(txt: String, sustituir: Boolean): Boolean {
  var xmlAux: FLDomDocument = new FLDomDocument;
  if (!(xmlAux.setContent(txt)))
    return false;

  if (sustituir)
  {
    var nombre: String = xmlAux.firstChild().toElement().attribute("name");
    var ruta: String = xmlAux.firstChild().toElement().attribute("path");
    var nodoPrevio: FLDomNode = this.iface.buscarNodoParche(nombre, ruta);
    if (nodoPrevio) {
      this.iface.xmlParche.firstChild().replaceChild(xmlAux.firstChild(), nodoPrevio);
    } else {
      this.iface.xmlParche.firstChild().appendChild(xmlAux.firstChild());
    }
  } else {
    this.iface.xmlParche.firstChild().appendChild(xmlAux.firstChild());
  }

  return true;
}

/** \D Busca un nodo en el fichero de parche por los atributos 'name' y 'path'

@param  nombre: Valor del atributo 'name'
@param  ruta: Valor del atributo 'path'
@return Nodo si se ha encontrado, false en caso contrario
\end */
function head_buscarNodoParche(nombre: String, ruta: String): FLDomNode {
  var listaNodos: FLDomNodeList = this.iface.xmlParche.firstChild().childNodes();
  for (var j: Number = 0; j < listaNodos.length(); j++)
  {
    if (listaNodos.item(j).toElement().attribute("name") == nombre && listaNodos.item(j).toElement().attribute("path") == ruta) {
      return listaNodos.item(j);
    }
  }
  return false;
}

/** \D Guarda un fichero en disco y lo incluye en el control de versiones

@param  ruta: ruta del fichero
@param  nombre: nombre del fichero
@param  contenido: contenido del fichero
@return True si no hay error, false en caso contrario
\end */
function head_grabarFicheroParche(ruta: String, nombre: String, contenido: String): Boolean {
  File.write(ruta + nombre, contenido);
  if (!this.iface.anadirFicheroParche(ruta, nombre))
  {
    return false;
  }

  return true;
}

function head_anadirFicheroParche(ruta: String, nombre: String): Boolean {
  var resComando: Array = flmaveppal.iface.pub_ejecutarComando("svn status " + ruta + nombre);
  if (resComando.ok == false)
    return false;
  if (resComando.salida.charAt(0) == "?")
    resComando = flmaveppal.iface.pub_ejecutarComando("svn add " + ruta + nombre);
  return true;
}


/** \D Genera el directorio 'prueba' como copia de 'previo' m�s el parche correspondiente a la funcionalidad a desarrollar sin bajar dicho parche del repositorio, es decir, con la copia local

@param  codFuncional: funcionalidad
@return True si no hay error, false en caso contrario
\end */
function head_generarDirPrueba(codFuncional: String, directorio: String): Boolean {
  Dir.current = flmaveppal.iface.pathLocal + codFuncional;

  flmaveppal.iface.pub_logAdd("Regenerando directorio " + Dir.current + "/" + directorio);
  var resComando: Array = flmaveppal.iface.pub_ejecutarComando("rm -rf " + directorio);
  if (resComando.ok == false)
  {
    return false;
  }

  resComando = flmaveppal.iface.pub_ejecutarComando("cp -rf previo " + directorio);
  if (resComando.ok == false)
  {
    flmaveppal.iface.pub_logAdd("Error al crear el directorio " + directorio);
    return false;
  }
  flmaveppal.iface.pub_logAdd("OK");
  sys.processEvents();

  if (!flmaveppal.iface.pub_aplicarParche(codFuncional, codFuncional + "/" + codFuncional, codFuncional + "/" + directorio))
  {
    flmaveppal.iface.pub_logAdd("Error al aplicar el parche " + codFuncional + " sobre " + directorio);
    return false;
  }
  return true;
}

/** \D Crea el directorio previo como el total de los m�dulos afectados m�s los parches de las funcionalidades de las cuales depende la funcionalidad a desarrollar

@param  codFuncional: funcionalidad
@return True si no hay error, false en caso contrario
\end */
function head_generarDirPrevio(codFuncional: String): Boolean {
  var util: FLUtil = new FLUtil;
  var versionBase: String = util.sqlSelect("mv_funcional", "versionbase", "codfuncional = '" + codFuncional + "'");

  var resComando: Array = flmaveppal.iface.pub_ejecutarComando("rm -rf " + codFuncional + "/previo ");
  if (resComando.ok == false)
  {
    return;
  }

  resComando = flmaveppal.iface.pub_ejecutarComando("rm -rf " + codFuncional + "/test ");
  if (resComando.ok == false)
  {
    return;
  }

  if (!File.exists(codFuncional + "/doc"))
  {
    resComando = flmaveppal.iface.pub_ejecutarComando("mkdir " + codFuncional + "/doc");
    if (resComando.ok == false) {
      flmaveppal.iface.pub_logAdd("Error mkdir �rbol");
      return;
    }
  }

  resComando = flmaveppal.iface.pub_ejecutarComando("rm -rf " + codFuncional + "/config");
  if (resComando.ok == false)
  {
    flmaveppal.iface.pub_logAdd("Error mkdir �rbol");
    return;
  }
  resComando = flmaveppal.iface.pub_ejecutarComando("mkdir " + codFuncional + "/config");
  if (resComando.ok == false)
  {
    flmaveppal.iface.pub_logAdd("Error mkdir �rbol");
    return;
  }

  resComando = flmaveppal.iface.pub_ejecutarComando("mkdir " + codFuncional + "/previo ");
  if (resComando.ok == false)
  {
    flmaveppal.iface.pub_logAdd("Error mkdir arbol");
    return;
  }

  if (!flmaveppal.iface.pub_checkoutMods(codFuncional, codFuncional, "previo", versionBase))
  {
    flmaveppal.iface.pub_logAdd("Error al obtener los m�dulos afectados por la funcionalidad " + codFuncional);
    return false;
  }

  var listaDep: Array = flmaveppal.iface.pub_obtenerListaDep(codFuncional, versionBase);
  if (!listaDep)
  {
    flmaveppal.iface.pub_logAdd("Error al obtener la lista de dependencias de " + codFuncional);
    return false;
  }

  // debug("Funcional = " + codFuncional);
  // debug("versionBase = " + versionBase);
  var funPadre: String, verPadre: String;
  for (var i: Number = 0; i < listaDep.length; i++)
  {
    funPadre = listaDep[i]["fun"];
    verPadre = listaDep[i]["ver"];
    debug("funPadre = " + funPadre);
    debug("verPadre = " + verPadre);

    resComando = flmaveppal.iface.pub_ejecutarComando("rm -rf " + flmaveppal.iface.pathLocal + "/" + codFuncional + "/temp");
    if (resComando.ok == false) {
      flmaveppal.iface.pub_logAdd("Error al borrar el directorio temporal");
      return false;
    }
    /// No se obtienen los m�dulos de las dependencias para evitar colar m�dulos no comprados
    //    if (!flmaveppal.iface.pub_checkoutMods(funPadre, codFuncional, "previo", versionBase)) {
    //      flmaveppal.iface.pub_logAdd("Error al obtener los m�dulos afectados por la funcionalidad " + funPadre);
    //      return false;
    //    }
    if (!flmaveppal.iface.pub_checkoutParche(funPadre, codFuncional + "/temp", verPadre)) {
      debug("Error");
      flmaveppal.iface.pub_logAdd("Error al obtener el parche " + funPadre);
      return false;
    }
    if (!flmaveppal.iface.pub_aplicarParche(funPadre, codFuncional + "/temp", codFuncional + "/previo")) {
      flmaveppal.iface.pub_logAdd("Error al aplicar el parche " + funPadre);
      return false;
    }
    if (!flmaveppal.iface.pub_anadirTest(codFuncional + "/temp", codFuncional)) {
      flmaveppal.iface.pub_logAdd("Error al a�adir las pruebas de " + funPadre);
      return false;
    }
    if (!flmaveppal.iface.pub_anadirAConfig(funPadre, codFuncional)) {
      flmaveppal.iface.pub_logAdd("Error al a�adir la funcionalidad " + funPadre + " al fichero de configuraci�n del proyecto");
      return false;
    }
  }

  return true;
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
