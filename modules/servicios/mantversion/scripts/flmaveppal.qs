/***************************************************************************
                  flmaveppal.qs  -  description
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

/** @class_declaration interna */
////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

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

  function beforeCommit_mv_funcional(curTab: FLSqlCursor)
  {
    return this.ctx.interna_beforeCommit_mv_funcional(curTab);
  }
  function afterCommit_mv_funcional(curInc: FLSqlCursor)
  {
    return this.ctx.interna_afterCommit_mv_funcional(curInc);
  }
  function afterCommit_mv_changelog(curChg: FLSqlCursor)
  {
    return this.ctx.interna_afterCommit_mv_changelog(curChg);
  }
  function afterCommit_mv_actualizacionesfun(curAct: FLSqlCursor)
  {
    return this.ctx.interna_afterCommit_mv_actualizacionesfun(curAct);
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
  function anadirAConfig(idFuncional: String, codProyecto: String)
  {
    return this.ctx.oficial_anadirAConfig(idFuncional, codProyecto);
  }
  function totalizarPrecioModFun(curChg: FLSqlCursor)
  {
    return this.ctx.oficial_totalizarPrecioModFun(curChg);
  }
  function regenerarCambiosActualizacion(curAct: FLSqlCursor)
  {
    return this.ctx.oficial_regenerarCambiosActualizacion(curAct);
  }
  function establecerPrecioActualizacion(curAct: FLSqlCursor)
  {
    return this.ctx.oficial_establecerPrecioActualizacion(curAct);
  }
  function generarCambiosActualizacion(curAct: FLSqlCursor)
  {
    return this.ctx.oficial_generarCambiosActualizacion(curAct);
  }
  function borrarCambiosActualizacion(curAct: FLSqlCursor)
  {
    return this.ctx.oficial_borrarCambiosActualizacion(curAct);
  }
  function informaXmlComp(curFun)
  {
    return this.ctx.oficial_informaXmlComp(curFun);
  }
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends oficial
{
  var versionOficial: String;
  var pathLocal: String;
  var pathPeso: String;
  var urlRepositorioMod: String;
  var versionTronco_: String;
  var urlRepositorioFun: String;
  var urlRepositorioWebOficial: String;
  var urlRepositorioWebFun: String;
  var tipoDocActual: String;
  var funcionalActual: String;
  var xmlDif: FLDomDocument;
  var xmlPrevio: FLDomDocument;
  var localEnc_: String;

  function head(context)
  {
    oficial(context);
  }
  function init()
  {
    return this.ctx.head_init();
  }
  function obtenerPathLocal()
  {
    return this.ctx.head_obtenerPathLocal();
  }
  function cambiarPathLocal(dirActual: String)
  {
    return this.ctx.head_cambiarPathLocal(dirActual);
  }
  function obtenerPathPeso()
  {
    return this.ctx.head_obtenerPathPeso();
  }
  function cambiarPathPeso(dirActual: String)
  {
    return this.ctx.head_cambiarPathPeso(dirActual);
  }
  function obtenerUrlRepositorioMod()
  {
    return this.ctx.head_obtenerUrlRepositorioMod();
  }
  function obtenerUrlRepositorioFun()
  {
    return this.ctx.head_obtenerUrlRepositorioFun();
  }
  function obtenerUrlRepositorioWebOficial()
  {
    return this.ctx.head_obtenerUrlRepositorioWebOficial();
  }
  function obtenerUrlRepositorioWebFun()
  {
    return this.ctx.head_obtenerUrlRepositorioWebFun();
  }
  //  function obtenerVersionOficial() {
  //    return this.ctx.head_obtenerVersionOficial();
  //  }
  //  function cambiarVersionOficial(versionActual:String) {
  //    return this.ctx.head_cambiarVersionOficial(versionActual);
  //  }
  function ejecutarComando(comando: String)
  {
    return this.ctx.head_ejecutarComando(comando);
  }
  function obtenerXmlDif(ruta1: String, ruta2: String, codFuncional: String)
  {
    return this.ctx.head_obtenerXmlDif(ruta1, ruta2, codFuncional);
  }
  function compararNodos(nodo1: FLDomNode, nodo2: FLDomNode, ruta: String, idNodo: String)
  {
    return this.ctx.head_compararNodos(nodo1, nodo2, ruta, idNodo);
  }
  function obtenerIdNodo(nodo: FLDomNode, nomNodo: String, numNodo: String)
  {
    return this.ctx.head_obtenerIdNodo(nodo, nomNodo, numNodo);
  }
  function buscarNodoPorId(nodoPadre: FLDomNode, nombreNodo: String, id: Array)
  {
    return this.ctx.head_buscarNodoPorId(nodoPadre, nombreNodo, id);
  }
  function preprocesarNodo(nodo: FLDomNode)
  {
    return this.ctx.head_preprocesarNodo(nodo);
  }
  function obtenerNodoImagen(doc: FLDomDocument, nombre: String)
  {
    return this.ctx.head_obtenerNodoImagen(doc, nombre);
  }
  function anadirNodoDif(txt: String, nodo: FLDomNode)
  {
    return this.ctx.head_anadirNodoDif(txt, nodo);
  }
  function anadirNodoLista(listaNodos: Array, nomNodo: String)
  {
    return this.ctx.head_anadirNodoLista(listaNodos, nomNodo);
  }
  function buscarNodoLista(listaNodos: Array, nomNodo: String)
  {
    return this.ctx.head_buscarNodoLista(listaNodos, nomNodo);
  }
  function obtenerScriptDif(ruta1: String, ruta2: String, codFuncional: String)
  {
    return this.ctx.head_obtenerScriptDif(ruta1, ruta2, codFuncional);
  }
  function obtenerPhpDif(ruta1: String, ruta2: String, codFuncional: String)
  {
    return this.ctx.head_obtenerPhpDif(ruta1, ruta2, codFuncional);
  }
  function compararScripts(contenido1: String, contenido2: String)
  {
    return this.ctx.head_compararScripts(contenido1, contenido2);
  }
  function compararPhps(contenido1: String, contenido2: String)
  {
    return this.ctx.head_compararPhps(contenido1, contenido2);
  }
  function listaClases(contenido: String)
  {
    return this.ctx.head_listaClases(contenido);
  }
  function listaClasesPhp(contenido: String)
  {
    return this.ctx.head_listaClasesPhp(contenido);
  }
  function obtenerNombreClase(contenido: String, pos: Number)
  {
    return this.ctx.head_obtenerNombreClase(contenido, pos);
  }
  function buscarClase(nombre: String, tipo: String, lista: Array)
  {
    return this.ctx.head_buscarClase(nombre, tipo, lista);
  }
  function obtenerNombreClaseBase(contenido: String, pos: Number, clase: String)
  {
    return this.ctx.head_obtenerNombreClaseBase(contenido, pos, clase);
  }
  function gestionConfXml(contenidoParche: String, contenidoActual: String)
  {
    return this.ctx.head_gestionConfXml(contenidoParche, contenidoActual);
  }
  function gestionConfScript(qsDif: String, qsActual: String)
  {
    return this.ctx.head_gestionConfScript(qsDif, qsActual);
  }
  function gestionConfPhp(phpDif: String, phpActual: String)
  {
    return this.ctx.head_gestionConfPhp(phpDif, phpActual);
  }
  function obtenerTipoNodo(nomNodo: String)
  {
    return this.ctx.head_obtenerTipoNodo(nomNodo);
  }
  function aplicarParche(codFuncional: String, dirParche: String, dirDest: String)
  {
    return this.ctx.head_aplicarParche(codFuncional, dirParche, dirDest);
  }
  function aplicarParcheNodo(nodo: FLDomNode, dirParche: String, dirOrig: String, dirDest: String)
  {
    return this.ctx.head_aplicarParcheNodo(nodo, dirParche, dirOrig, dirDest);
  }
  function obtenerListaDep(codFuncional: String, versionBase: String)
  {
    return this.ctx.head_obtenerListaDep(codFuncional, versionBase);
  }
  function buscarPalabra(palabra: String, lista: Array)
  {
    return this.ctx.head_buscarPalabra(palabra, lista);
  }
  function sinDependencias(codFuncional: String, listaDep: Array)
  {
    return this.ctx.head_sinDependencias(codFuncional, listaDep);
  }
  function obtenerListaDepDes(codFuncional: String, versionBase: String)
  {
    return this.ctx.head_obtenerListaDepDes(codFuncional, versionBase);
  }
  //  function obtenerListaDepCliente(idCliente:String) {
  //    return this.ctx.head_obtenerListaDepCliente(idCliente);
  //  }
  function ordenarListaDep(listaDesordenada: Array)
  {
    return this.ctx.head_ordenarListaDep(listaDesordenada);
  }
  function checkoutMods(codFuncional: String, dirDestino1: String, dirDestino2: String, versionBase: String)
  {
    return this.ctx.head_checkoutMods(codFuncional, dirDestino1, dirDestino2, versionBase);
  }
  function checkoutParche(codFuncional: String, dirParche: String, versionBase: String)
  {
    return this.ctx.head_checkoutParche(codFuncional, dirParche, versionBase);
  }
  function ordenarNodos(listaNodos: FLDomNodeList)
  {
    return this.ctx.head_ordenarNodos(listaNodos);
  }
  function obtenerIdMin(lista: Array)
  {
    return this.ctx.head_obtenerIdMin(lista);
  }
  function compararIds(id1: Array, id2: Array)
  {
    return this.ctx.head_compararIds(id1, id2);
  }
  function guardarModsXml(listaMod: Array, ruta: String)
  {
    return this.ctx.head_guardarModsXml(listaMod, ruta);
  }
  function guardarModXml(mod: Array, ruta: String)
  {
    return this.ctx.head_guardarModXml(mod, ruta);
  }
  function obtenerIndiceMin(lista: Array)
  {
    return this.ctx.head_obtenerIndiceMin(lista);
  }
  function buscarUltClaseDerivada(listaClases: Array)
  {
    return this.ctx.head_buscarUltClaseDerivada(listaClases);
  }
  function buscarUltClaseDerivadaPhp(listaClases: Array)
  {
    return this.ctx.head_buscarUltClaseDerivadaPhp(listaClases);
  }
  function anadirTest(rutaDirTest: String, codFuncional: String)
  {
    return this.ctx.head_anadirTest(rutaDirTest, codFuncional);
  }
  function reemplazar(texto: String, antes: String, despues: String)
  {
    return this.ctx.head_reemplazar(texto, antes, despues);
  }
  function cargarCodificacionLocal()
  {
    return this.ctx.head_cargarCodificacionLocal();
  }
  function obtenerVersionTronco()
  {
    return this.ctx.head_obtenerVersionTronco();
  }
  function logAdd(txt)
  {
    return this.ctx.head_logAdd(txt);
  }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head
{
  var pub_log: Object;

  function ifaceCtx(context)
  {
    head(context);
  }
  function pub_obtenerPathLocal()
  {
    return this.obtenerPathLocal();
  }
  function pub_obtenerPathPeso()
  {
    return this.obtenerPathPeso();
  }
  function pub_obtenerUrlRepositorioMod()
  {
    return this.obtenerUrlRepositorioMod();
  }
  function pub_obtenerVersionTronco()
  {
    return this.obtenerVersionTronco();
  }
  function pub_obtenerUrlRepositorioFun()
  {
    return this.obtenerUrlRepositorioFun();
  }
  function pub_obtenerUrlRepositorioWebOficial()
  {
    return this.obtenerUrlRepositorioWebOficial();
  }
  function pub_obtenerUrlRepositorioWebFun()
  {
    return this.obtenerUrlRepositorioWebFun();
  }
  //  function pub_obtenerVersionOficial() {
  //    return this.obtenerVersionOficial();
  //  }
  function pub_obtenerPathRepositorio()
  {
    return this.obtenerPathRepositorio();
  }
  function pub_ejecutarComando(comando: String)
  {
    return this.ejecutarComando(comando);
  }
  function pub_obtenerXmlDif(ruta1: String, ruta2: String, codFuncional: String)
  {
    return this.obtenerXmlDif(ruta1, ruta2, codFuncional);
  }
  function pub_obtenerScriptDif(ruta1: String, ruta2: String, codFuncional: String)
  {
    return this.obtenerScriptDif(ruta1, ruta2, codFuncional);
  }
  function pub_obtenerPhpDif(ruta1: String, ruta2: String, codFuncional: String)
  {
    return this.obtenerPhpDif(ruta1, ruta2, codFuncional);
  }
  function pub_aplicarParche(codFuncional: String, dirParche: String, dirDest: String)
  {
    return this.aplicarParche(codFuncional, dirParche, dirDest);
  }
  function pub_aplicarParcheNodo(nodo: FLDomNode, dirParche: String, dirOrig: String, dirDest: String)
  {
    return this.aplicarParcheNodo(nodo, dirParche, dirOrig, dirDest);
  }
  function pub_obtenerListaDep(codFuncional: String, versionBase: String)
  {
    return this.obtenerListaDep(codFuncional, versionBase);
  }
  //  function pub_obtenerListaDepCliente(idCliente:String) {
  //    return this.obtenerListaDepCliente(idCliente);
  //  }
  function pub_checkoutMods(codFuncional: String, dirDestino1: String, dirDestino2: String, versionBase: String)
  {
    return this.checkoutMods(codFuncional, dirDestino1, dirDestino2, versionBase);
  }
  function pub_checkoutParche(codFuncional: String, dirParche: String, versionBase: String)
  {
    return this.checkoutParche(codFuncional, dirParche, versionBase);
  }
  function pub_cambiarPathLocal(dirActual)
  {
    return this.cambiarPathLocal(dirActual);
  }
  //  function pub_cambiarVersionOficial(versionActual:String) {
  //    return this.cambiarVersionOficial(versionActual);
  //  }
  function pub_anadirTest(rutaDirTest: String, codFuncional: String)
  {
    return this.anadirTest(rutaDirTest, codFuncional);
  }
  function pub_anadirAConfig(idFuncional: String, codProyecto: String)
  {
    return this.anadirAConfig(idFuncional, codProyecto);
  }
  function pub_logAdd(txt)
  {
    return this.logAdd(txt);
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

}

function interna_beforeCommit_mv_funcional(curFun)
{
  flsistwebi.iface.pub_setModificado(curFun);

  var _i = this.iface;

  if (!_i.informaXmlComp(curFun)) {
    return false;
  }
  return true;
}

function interna_afterCommit_mv_funcional(cursor: FLSqlCursor)
{
  flsistwebi.iface.pub_setBorrado(cursor);
  return true;
}

function interna_afterCommit_mv_changelog(curChg: FLSqlCursor)
{
  if (!this.iface.totalizarPrecioModFun(curChg)) {
    return false;
  }
  return true;
}

function interna_afterCommit_mv_actualizacionesfun(curAct: FLSqlCursor)
{
  if (!this.iface.regenerarCambiosActualizacion(curAct)) {
    return false;
  }
  return true;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_informaXmlComp(curFun)
{
  var _i = this.iface;
  if (curFun.modeAccess() != curFun.Edit) {
    return true;
  }
  var codFuncional = curFun.valueBuffer("codfuncional");
  var versionBase = curFun.valueBuffer("versionBase");

  var x = new FLDomDocument();
  x.setContent("<mvproject><modules/><extensions/></mvproject>");
  var e = x.firstChild().toElement();
  e.setAttribute("name", codFuncional);
  e.setAttribute("version", versionBase);

  xMod = x.firstChild().namedItem("modules");
  var qMod = new FLSqlQuery;
  qMod.setTablesList("mv_modulosfun");
  qMod.setSelect("idmodulo, version");
  qMod.setFrom("mv_modulosfun");
  qMod.setWhere("codfuncional = '" + codFuncional + "'");
  qMod.setForwardOnly(true);
  if (!qMod.exec()) {
    return false;
  }
  while (qMod.next()) {
    e = x.createElement("module");
    debug(e);
    e.setAttribute("name", qMod.value("idmodulo"));
    e.setAttribute("version", qMod.value("version") != "" ? qMod.value("version") : versionBase);
    xMod.appendChild(e);
  }

  xExt = x.firstChild().namedItem("extensions");
  var aExt = _i.obtenerListaDep(codFuncional, versionBase);
  for (var i = 0; i < aExt.length; i++) {
    e = x.createElement("extension");
    e.setAttribute("name", aExt[i]["fun"]);
    e.setAttribute("version", aExt[i]["ver"]);
    xExt.appendChild(e);
  }
  curFun.setValueBuffer("xmlcomp", x.toString(4));
  return true;
}
/** \D A�ade al directorio config el fichero de parche .xml asociado a una funcionalidad. A�ade tambi�n un nodo al fichero xml de configuraci�n del proyecto. Estos datos son le�dos por el m�dulo de documentaci�n para realizar documentaci�n de proyectos
@param idFuncional: Identificador de la funcionalidad que se a�ade
@param  codProyecto: Identificador del proyecto o funcionalidad que se genera
@return True si la adici�n se realiza correctamente, false en caso contrario
\end */
function oficial_anadirAConfig(idFuncional: String, codProyecto: String)
{
  // Funci�n obsoleta
  return true;

  var contenido: String;
  if (idFuncional == codProyecto)
    contenido = File.read(this.iface.pathLocal + codProyecto + "/" + idFuncional + "/" + idFuncional + ".xml");
  else
    contenido = File.read(this.iface.pathLocal + codProyecto + "/temp/" + idFuncional + ".xml");

  File.write(this.iface.pathLocal + codProyecto + "/config/" + idFuncional + ".xml", contenido);

  var xmlConfig = new FLDomDocument();
  var xmlAux = new FLDomDocument();

  if (File.exists(this.iface.pathLocal + codProyecto + "/config/config.xml"))
    contenido = File.read(this.iface.pathLocal + codProyecto + "/config/config.xml");
  else
    contenido = "<flmaveconfig:client name =\"" + codProyecto + "\"/>";

  if (!xmlConfig.setContent(contenido))
    return false;

  if (!xmlAux.setContent("<flmaveconfig:patch name =\"" + idFuncional + "\"/>"))
    return false;

  xmlConfig.firstChild().appendChild(xmlAux.firstChild());
  File.write(this.iface.pathLocal + codProyecto + "/config/config.xml", xmlConfig.toString(4));

  return true;
}

function oficial_totalizarPrecioModFun(curChg: FLSqlCursor)
{
  var util = new FLUtil;

  var idVersonMF = curChg.valueBuffer("idversionmodfun");
  var precio = util.sqlSelect("mv_changelog", "SUM(precio)", "idversionmodfun = " + idVersonMF);
  if (isNaN(precio)) {
    precio = 0;
  }
  if (!util.sqlUpdate("mv_versionesmodfun", "precio", precio, "idversionmodfun = " + idVersonMF)) {
    return false;
  }

  switch (curChg.modeAccess()) {
    case curChg.Edit: {
      var idVersonMFAnt = curChg.valueBufferCopy("idversionmodfun");
      if (idVersonMFAnt != idVersonMF) {
        precio = util.sqlSelect("mv_changelog", "SUM(precio)", "idversionmodfun = " + idVersonMFAnt);
        if (isNaN(precio)) {
          precio = 0;
        }
        if (!util.sqlUpdate("mv_versionesmodfun", "precio", precio, "idversionmodfun = " + idVersonMFAnt)) {
          return false;
        }
      }
      break;
    }
  }
  return true;
}

function oficial_regenerarCambiosActualizacion(curAct: FLSqlCursor)
{
  switch (curAct.modeAccess()) {
    case curAct.Insert: {
      if (!this.iface.generarCambiosActualizacion(curAct)) {
        return false;
      }
      if (!this.iface.establecerPrecioActualizacion(curAct)) {
        return false;
      }
      break;
    }
    case curAct.Edit: {
      if (!this.iface.borrarCambiosActualizacion(curAct)) {
        return false;
      }
      if (!this.iface.generarCambiosActualizacion(curAct)) {
        return false;
      }
      if (!this.iface.establecerPrecioActualizacion(curAct)) {
        return false;
      }
      break;
    }
    case curAct.Del: {
      if (!this.iface.borrarCambiosActualizacion(curAct)) {
        return false;
      }
      break;
    }
  }
  return true;
}

function oficial_establecerPrecioActualizacion(curAct: FLSqlCursor)
{
  var util = new FLUtil;

  var idActualizacion = curAct.valueBuffer("idactualizacion");
  var curActualizacion = new FLSqlCursor("mv_actualizacionesfun");
  curActualizacion.setActivatedCheckIntegrity(false);
  curActualizacion.setActivatedCommitActions(false);
  curActualizacion.select("idactualizacion = " + idActualizacion);
  if (!curActualizacion.first()) {
    return false;
  }
  curActualizacion.setModeAccess(curActualizacion.Edit);
  curActualizacion.refreshBuffer();
  var precio = util.sqlSelect("mv_cambiosactualizacion", "SUM(precio)", "idactualizacion = " + idActualizacion);
  if (isNaN(precio)) {
    precio = 0;
  }
  curActualizacion.setValueBuffer("precio", precio);
  if (!curActualizacion.commitBuffer()) {
    return false;
  }
  return true;
}

function oficial_generarCambiosActualizacion(curAct: FLSqlCursor)
{
	if (curAct.valueBuffer("esrevision")) {
		return true;
	}
  var codFuncional = curAct.valueBuffer("codfuncional");
  var versionDesde = curAct.valueBuffer("versiondesde");
  var versionHasta = curAct.valueBuffer("versionhasta");

  var curCambio = new FLSqlCursor("mv_cambiosactualizacion");
  var qryChangeLog = new FLSqlQuery;
  qryChangeLog.setTablesList("mv_changelog");
  qryChangeLog.setSelect("id, version, descripcion, precio");
  qryChangeLog.setFrom("mv_changelog");
  qryChangeLog.setForwardOnly(true);

  var curModulosFun = new FLSqlCursor("mv_modulosfun");
  curModulosFun.select("codfuncional = '" + codFuncional + "'");
  var idModulo: String;
  var verModulo: String;
  while (curModulosFun.next()) {
    idModulo = curModulosFun.valueBuffer("idmodulo");
    verModulo = curModulosFun.valueBuffer("version");
    if (!verModulo || verModulo == "") {
      verModulo = versionDesde;
    }
    qryChangeLog.setWhere("idmodulo = '" + idModulo + "' AND version > '" + versionDesde + "' AND version <= '" + versionHasta + "'");
    if (!qryChangeLog.exec()) {
      return false;
    }
    while (qryChangeLog.next()) {
      curCambio.setModeAccess(curCambio.Insert);
      curCambio.refreshBuffer();
      curCambio.setValueBuffer("idactualizacion", curAct.valueBuffer("idactualizacion"));
      curCambio.setValueBuffer("idcambio", qryChangeLog.value("id"));
      curCambio.setValueBuffer("version", qryChangeLog.value("version"));
      curCambio.setValueBuffer("descripcion", qryChangeLog.value("descripcion"));
      curCambio.setValueBuffer("precio", qryChangeLog.value("precio"));
      curCambio.setValueBuffer("funmod", idModulo);
      curCambio.setValueBuffer("codfuncional", codFuncional);
      if (!curCambio.commitBuffer()) {
        return false;
      }
    }
  }

  var listaFun = this.iface.obtenerListaDep(codFuncional, versionDesde);
  var funDependencia: String;
  var verDependencia: String;
  for (var i = 0; i < listaFun.length; i++) {
    funDependencia = listaFun[i]["fun"];
    verDependencia = listaFun[i]["ver"];
    qryChangeLog.setWhere("codfuncional = '" + funDependencia + "' AND version > '" + verDependencia + "' AND version <= '" + versionHasta + "'");
    if (!qryChangeLog.exec()) {
      return false;
    }
    while (qryChangeLog.next()) {
      curCambio.setModeAccess(curCambio.Insert);
      curCambio.refreshBuffer();
      curCambio.setValueBuffer("idactualizacion", curAct.valueBuffer("idactualizacion"));
      curCambio.setValueBuffer("idcambio", qryChangeLog.value("id"));
      curCambio.setValueBuffer("version", qryChangeLog.value("version"));
      curCambio.setValueBuffer("descripcion", qryChangeLog.value("descripcion"));
      curCambio.setValueBuffer("precio", qryChangeLog.value("precio"));
      curCambio.setValueBuffer("funmod", funDependencia);
      curCambio.setValueBuffer("codfuncional", codFuncional);
      if (!curCambio.commitBuffer()) {
        return false;
      }
    }
  }
  return true;
}

function oficial_borrarCambiosActualizacion(curAct: FLSqlCursor)
{
  var util = new FLUtil;
  if (!util.sqlDelete("mv_cambiosactualizacion", "idactualizacion = " + curAct.valueBuffer("idactualizacion"))) {
    return false;
  }
  return true;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
/** \D Obtiene la ruta al directorio de desarrollo
@return Ruta al directorio
\end */
function head_obtenerPathLocal()
{
  var util = new FLUtil;
  if (!this.iface.pathLocal) {
    this.iface.pathLocal = util.readSettingEntry("scripts/flmaveppal/pathlocal");
    if (!this.iface.pathLocal) {
      MessageBox.information(util.translate("scripts", "No hay un directorio de trabajo establecido, por favor, seleccione el directorio"), MessageBox.Ok, MessageBox.NoButton);
      this.iface.cambiarPathLocal("");
    }
  }

  return this.iface.pathLocal;
}

/** \D Obtiene la ruta al directorio de modulos que se usa para obtener el peso de un parche
@return Ruta al directorio
\end */
function head_obtenerPathPeso()
{
  /*
  var util= new FLUtil;
  if (!this.iface.pathPeso) {
    this.iface.pathPeso = util.readSettingEntry("scripts/flmaveppal/pathpeso");
    if (!this.iface.pathPeso ) {
      MessageBox.information(util.translate("scripts", "No hay un directorio de referencia para obtener el peso de los parches, por favor, seleccione el directorio"), MessageBox.Ok, MessageBox.NoButton);
      this.iface.cambiarPathPeso("");
    }
  }
  OBSOLETO
  */

  return this.iface.pathPeso;
}

/** \D Obtiene la versi�n oficial de los m�dulos a utilizar

@return Nombre de la versi�n
\end */
// function head_obtenerVersionOficial()
// {
//  var util= new FLUtil;
//  if (!this.iface.versionOficial) {
//    this.iface.versionOficial = util.readSettingEntry("scripts/flmaveppal/versionoficial");
//    if (!this.iface.versionOficial) {
//      MessageBox.information(util.translate("scripts", "No hay una versi�n de los m�dulos oficiales establecida, por favor, seleccione una"), MessageBox.Ok, MessageBox.NoButton);
//      this.iface.cambiarVersionOficial("");
//    }
//  }
//  return this.iface.versionOficial;
// }

/** \D Cambia el directorio de trabajo local

@param  dirActual: Ruta al nuevo directorio
@return True si no hay error, false en caso contrario
\end */
function head_cambiarPathLocal(dirActual: String)
{
  var util = new FLUtil;
  var directorio = FileDialog.getExistingDirectory(dirActual);
  if (!directorio)
    return false;

  util.writeSettingEntry("scripts/flmaveppal/pathlocal", directorio);
  this.iface.pathLocal = util.readSettingEntry("scripts/flmaveppal/pathlocal");
  return true;
}

/** \D Cambia el directorio de referencia para obtener el peso de los parches

@param  dirActual: Ruta al nuevo directorio
@return True si no hay error, false en caso contrario
\end */
function head_cambiarPathPeso(dirActual: String)
{
  /*  var util= new FLUtil;
    var directorio= FileDialog.getExistingDirectory(dirActual);
    if (!directorio)
      return false;

    util.writeSettingEntry("scripts/flmaveppal/pathpeso", directorio);
    this.iface.pathPeso = util.readSettingEntry("scripts/flmaveppal/pathpeso");
    return true;
  OBSOLETO
  */
}

/** \D Cambia el nombre de la versi�n oficial de los m�dulos

@param  versionActual: Nuevo nombre de la versi�n oficial
@return True si no hay error, false en caso contrario
\end */
// function head_cambiarVersionOficial(versionActual:String)
// {
//  var util= new FLUtil;
//
//  var resComando= this.iface.ejecutarComando("svn ls " + this.iface.obtenerUrlRepositorioMod() + "oficial/");
//  if (resComando.ok == false) {
//    if (this.iface.pub_log) {
//      this.iface.pub_logAdd("Error al listar el repositorio en " + this.iface.urlRepositorio + "oficial/");
//    }
//    return false;
//  }
//  var opciones= resComando.salida.split("\n");
//  opciones.pop();
//  var version = Input.getItem("Selecciona la versi�n", opciones, "", false, "Versi�n de m�dulos oficiales");
//  if (!version)
//    return false;
//
//  util.writeSettingEntry("scripts/flmaveppal/versionoficial", version);
//  this.iface.versionOficial = util.readSettingEntry("scripts/flmaveppal/versionoficial");
//  return true;
// }

/** \D Crea el registro de configuraci�n si no exist�a ya.
\end */
function head_init()
{
  var cursor = new FLSqlCursor("mv_config");
  var util = new FLUtil();
  cursor.select();
  if (!cursor.first()) {
    MessageBox.information(util.translate("scripts", "No hay valores de configuraci�n, debe crear estos valores para comenzar a trabajar."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
    this.execMainScript("mv_config");
  }
  this.iface.cargarCodificacionLocal();
}

/** \D Obtiene la url del repositorio de m�dulos

@return Valor de la URL
\end */
function head_obtenerUrlRepositorioMod()
{
  var util = new FLUtil();
  if (!this.iface.urlRepositorioMod)
    this.iface.urlRepositorioMod = util.sqlSelect("mv_config", "urlrepositoriomod", "1 = 1");

  return this.iface.urlRepositorioMod;
}

function head_obtenerVersionTronco()
{
  var util = new FLUtil();
  if (!this.iface.versionTronco_) {
    this.iface.versionTronco_ = util.sqlSelect("mv_config", "versiontronco", "1 = 1");
  }
  return this.iface.versionTronco_;
}
/** \D Obtiene la url del repositorio de funcionalidades

@return Valor de la URL
\end */
function head_obtenerUrlRepositorioFun()
{
  var util = new FLUtil();
  if (!this.iface.urlRepositorioFun)
    this.iface.urlRepositorioFun = util.sqlSelect("mv_config", "urlrepositoriofun", "1 = 1");

  return this.iface.urlRepositorioFun;
}

/** \D Obtiene la url del repositorio de codigo web oficial

@return Valor de la URL
\end */
function head_obtenerUrlRepositorioWebOficial()
{
  var util = new FLUtil();
  if (!this.iface.urlRepositorioWebOficial)
    this.iface.urlRepositorioWebOficial = util.sqlSelect("mv_config", "urlrepositorioweboficial", "1 = 1");

  return this.iface.urlRepositorioWebOficial;
}

/** \D Obtiene la url del repositorio de c�digo web funcional

@return Valor de la URL
\end */
function head_obtenerUrlRepositorioWebFun()
{
  var util = new FLUtil();
  if (!this.iface.urlRepositorioWebFun)
    this.iface.urlRepositorioWebFun = util.sqlSelect("mv_config", "urlrepositoriowebfun", "1 = 1");

  return this.iface.urlRepositorioWebFun;
}

/** \D
Ejecuta un comando externo
@param  comando: Comando a ejecutar
@return Array con dos datos:
  ok: True si no hay error, false en caso contrario
  salida: Mensaje de stdout o stderr obtenido
\end */
function head_ejecutarComando(comando: String)
{
  var res = [];
  Process.execute(comando);
  debug(comando);
  //this.iface.pub_logAdd(comando);
  if (Process.stderr != "") {
    res["ok"] = false;
    res["salida"] = Process.stderr;
    if (this.iface.pub_log) {
      this.iface.pub_logAdd("Error al ejecutar el comando: " + comando + "\n" + Process.stderr);
      this.iface.pub_logAdd(res.salida);
    }
  } else {
    res["ok"] = true;
    res["salida"] = Process.stdout;
  }

  return res;
}

/** Obtiene el fichero xml de las modificaciones (parche) que hay que hacer al fichero 1 para convertirlo en el fichero 2
@param  ruta1: Ruta al primer fichero
@param  ruta2: Ruta al segundo fichero
@param  codFuncional: C�digo de la funcionalidad que se est� tratando
@return Documento xml de diferencias o false si hay error
*/
function head_obtenerXmlDif(ruta1: String, ruta2: String, codFuncional: String)
{
  var contenido: String;
  this.iface.tipoDocActual = ruta1.substring(ruta1.findRev(".") + 1, ruta1.length);
  this.iface.funcionalActual = codFuncional;

  if (!File.exists(ruta1)) {
    this.iface.pub_logAdd("No se encuentra el fichero " + ruta1);
    return false;
  }
  contenido = File.read(ruta1);
  this.iface.xmlPrevio = new FLDomDocument();
  //var xml1= new FLDomDocument();
  //xml1.setContent(contenido);
  this.iface.xmlPrevio.setContent(contenido);

  if (!File.exists(ruta2)) {
    this.iface.pub_logAdd("No se encuentra el fichero " + ruta2);
    return false;
  }
  contenido = File.read(ruta2);
  var xml2 = new FLDomDocument();
  xml2.setContent(contenido);

  if (this.iface.xmlDif)
    delete this.iface.xmlDif;
  this.iface.xmlDif = new FLDomDocument();


  this.iface.xmlDif.setContent("<xupdate:modifications/>")
  if (!this.iface.compararNodos(this.iface.xmlPrevio.firstChild(), xml2.firstChild(), "", "")) {
    this.iface.pub_logAdd("Error comparando ficheros");
    return false;
  }

  var resultado = this.iface.xmlDif.toString();
  return resultado;
}

/** \D Compara dos nodos anotando las diferencias en un documento xml

@param  nodo1: Primer nodo a comparar
@param  nodo2: Segundo nodo a comparar
@param  ruta: ruta al nodo comparado
@return True si son iguales, false en caso contrario
\end */
function head_compararNodos(nodo1: FLDomNode, nodo2: FLDomNode, ruta: String, idNodo: String)
{
  var lista1 = nodo1.childNodes();
  var lista2 = nodo2.childNodes();

  var lo1 = this.iface.ordenarNodos(lista1);
  var lo2 = this.iface.ordenarNodos(lista2);

  var nombreHijo1: String;
  var nombreHijo2: String;

  var indiceLo1 = 0;
  var indiceLo2 = 0;
  var nodoHijo1: FLDomNode;
  var nodoHijo2: FLDomNode;

  var listaMod = [];

  if (ruta == "")
    ruta = "/" + nodo2.nodeName() + "[" + nodo2.nodeName() + ",1]";
  else
    ruta += "/" + nodo2.nodeName() + "[" + idNodo + "]";

  var limite1 = lo1.length; // - 1;
  var limite2 = lo2.length; // - 1;

  var comparacion: Number;
  do {
    if (indiceLo1 == limite1) {
      nodoHijo2 = lista2.item(lo2[indiceLo2].indice);
      nombreHijo2 = nodoHijo2.nodeName();
      comparacion = 1;
    } else if (indiceLo2 == limite2) {
      nodoHijo1 = lista1.item(lo1[indiceLo1].indice);
      nombreHijo1 = nodoHijo1.nodeName();
      comparacion = 2;
    } else {
      nodoHijo1 = lista1.item(lo1[indiceLo1].indice);
      nombreHijo1 = nodoHijo1.nodeName();
      nodoHijo2 = lista2.item(lo2[indiceLo2].indice);
      nombreHijo2 = nodoHijo2.nodeName();
      comparacion = this.iface.compararIds(lo1[indiceLo1].id, lo2[indiceLo2].id);
    }
    switch (comparacion) {
      case 0:
        if (nodoHijo2.nodeName() == "#text") {
          if (nodo1.toElement().text() == nodo2.toElement().text()) {
            return true;
          } else {
            txt = "<xupdate:update select=\"" + ruta + "/text()[1]\">" + nodo2.toElement().text()  + "</xupdate:update>";
            if (!this.iface.anadirNodoDif(txt))
              return false;
            return true;
          }
        }
        if (!nodoHijo2.isEqualNode(nodoHijo1)) {
          if (!this.iface.compararNodos(nodoHijo1, nodoHijo2, ruta, lo2[indiceLo2].id)) {
            this.iface.pub_logAdd("Error en los nodos hijos de " + ruta);
            return false;
          }
        }
        indiceLo1++;
        indiceLo2++;
        break;
      case 1:
        var i = listaMod.length;
        listaMod[i] = [];
        listaMod[i].indice = lo2[indiceLo2].indice;
        listaMod[i].nodo = nodoHijo2;
        indiceLo2++;
        break;
      case 2:
        var txt: String;
        txt = "<xupdate:delete select=\"" + ruta + "/" + nombreHijo1 + "[" + lo1[indiceLo1].id + "]\"/>";
        if (!this.iface.anadirNodoDif(txt))
          return false;
        indiceLo1++;
        break;
    }
  } while (indiceLo1 < limite1 || indiceLo2 < limite2);

  if (!this.iface.guardarModsXml(listaMod, ruta))
    return false;
  return true;
}

/** \D Guarda en el documento xml de diferencias los nodos <xupdate:insert-after> o <xupdate:append-first> en el orden correcto, de forma que los nodos de referencia en el atributo 'select'.

@param  listaMod: Array con los datos de los nodos a guardar:
  indice del nodo en el documento original (valor por el que se ordenar�)
  nodo: objeto nodo a insertar
@param  ruta: ruta al nodo padre de los nodos a insertar
@return True si no hay error, false en caso contrario
\end */
function head_guardarModsXml(listaMod: Array, ruta: String)
{
  var indiceMin: Number;
  for (var i = 0; i < listaMod.length; i++) {
    indiceMin = this.iface.obtenerIndiceMin(listaMod);
    if (!this.iface.guardarModXml(listaMod[indiceMin], ruta))
      return false;
    listaMod[indiceMin].indice = -1;
  }
  return true;
}

/** \D Obtiene el �ndice del elemento del array cuyo valor 'indice' es el m�nimo mayor que -1

@param  lista: Array con los datos de los nodos:
  indice del nodo en el documento original (valor por el que se ordenar�)
  nodo: objeto nodo a insertar
@return �ndice del elemento con valor m�nimo
\end */
function head_obtenerIndiceMin(lista: Array)
{
  var res = 0;
  while (lista[res].indice == -1)
    res++;

  var indice = res;
  while (indice < lista.length) {
    if (lista[indice].indice > -1) {
      if (lista[res].indice > lista[indice].indice)
        res = indice;
    }
    indice++;
  }
  return res;
}

/** \D Guarda un nodo xml de tipo <xupdate:insert-after> o <xupdate:append-first> en el documento xml de diferencias

@param  mod: Array con los datos del nodo a insertar:
  indice del nodo en el documento original (valor por el que se ordenar�)
  nodo: objeto nodo a insertar
@param  ruta: ruta al nodo padre del nodo a insertar
@return True si no hay error, false en caso contrario
\end */
function head_guardarModXml(mod: Array, ruta: String)
{
  var txt: String;
  var nodoPrevio = mod.nodo.previousSibling();
  if (nodoPrevio) {
    var indicePrevio = 0;
    for (var nodoAux = nodoPrevio; nodoAux; nodoAux = nodoAux.previousSibling()) {
      if (nodoAux.nodeName() == nodoPrevio.nodeName())
        indicePrevio++;
    }
    var idPrevio = this.iface.obtenerIdNodo(nodoPrevio, nodoPrevio.nodeName(), indicePrevio);
    txt = "<xupdate:insert-after select=\"" + ruta + "/" + nodoPrevio.nodeName() + "[" + idPrevio + "]\"/>";
  } else {
    txt = "<xupdate:append-first select=\"" + ruta + "\"/>";
  }
  if (!this.iface.anadirNodoDif(txt, mod.nodo))
    return false;

  return true;
}

/** \D Ordena una lista de nodos por el valor del Id de cada uno de ellos
@param  listaNodos: Objeto de lista de nodos
@return Array con los �ndices de los nodos ordenados. Los elementos de cada elemento del array son:
  indice: �ndice que ocupa el nodo en la lista listaNodos
  nombre: Nombre del nodo
  id: Valor del id del nodo
\end */
function head_ordenarNodos(listaNodos: FLDomNodeList)
{
  var res = [];
  if (!listaNodos)
    return res;

  var indice = 0;
  var indiceNodo: Number;
  var arrayAux = [];
  var listaIds = [];
  var nombreNodo: String;

  for (var i = 0; i < listaNodos.length(); i++) {
    nombreNodo = listaNodos.item(i).nodeName();
    if (listaNodos.item(i).isComment()) {
      continue;
    }
    if (nombreNodo == "images") {
      continue;
    }
    listaIds = this.iface.anadirNodoLista(listaIds, nombreNodo);
    indiceNodo = this.iface.buscarNodoLista(listaIds, nombreNodo);
    arrayAux[indice] = [];
    arrayAux[indice].indice = i;
    arrayAux[indice].nombre = nombreNodo;
    arrayAux[indice].id = this.iface.obtenerIdNodo(listaNodos.item(i), nombreNodo, listaIds[indiceNodo].cuenta);
    indice++;
  }
  var indiceMin: Number;
  for (var i = 0; i < arrayAux.length; i++) {
    indiceMin = this.iface.obtenerIdMin(arrayAux);
    res[i] = arrayAux[indiceMin];
    arrayAux[indiceMin] = 0;
  }
  return res;
}

/** \D Obtiene el �ndice del elemento del array cuyo valor 'id' es el m�nimo. Los elementos con valor 0 son deshechados.

@param  lista: Array con los datos de los nodos:
  indice: �ndice que ocupa el nodo en la lista listaNodos
  nombre: Nombre del nodo
  id: Valor del id del nodo
@return �ndice del elemento con valor m�nimo
\end */
function head_obtenerIdMin(lista: Array)
{
  var res = 0;
  while (lista[res] == 0)
    res++;

  var indice = res;
  while (indice < lista.length) {
    if (lista[indice] != 0) {
      if (this.iface.compararIds(lista[res].id, lista[indice].id) == 1)
        res = indice;
    }
    indice++;
  }
  return res;
}

/** \D Compara los Ids de dos nodos, comparando uno a uno todos sus elementos

@param  id1: Primer Id a comparar
@param  id2: Segundo Id a comparar
@return 0 si son iguales, 1 si el primero es mayor, 2 si el segundo es mayor
\end */
function head_compararIds(id1: Array, id2: Array)
{
  for (var i = 0; i < id1.length; i++) {
    if (id1[i] > id2[i])
      return 1;
    if (id2[i] > id1[i])
      return 2;
  }
  return 0;
}

/** \D
Obtiene el identificador un�voco de un nodo. Algunos nodos tienen valores �nicos determinados por su significado funcional (p.e. los nodos 'field' est�n identificados por el valor de su nodo hijo 'name')

@param  nodo: Nodo cuyo identificado se desea extraer
@param  nomNodo: Nombre del nodo
@param  numNodo: Ordinal del nodo en la lista de nodos hermanos con el mismo nombre
@return Array con los datos de identificaci�n del nodo. Por defecto es la combinaci�n nomNodo, numNodo
\end */
function head_obtenerIdNodo(nodo: FLDomNode, nomNodo: String, numNodo: String)
{
  var res = [];
  switch (this.iface.tipoDocActual) {
    case "xml":
      switch (nodo.nodeName()) {
        case "action":
          res[0] = nodo.namedItem("name").toElement().text();
          break;
        default:
          res[0] = nomNodo;
          res[1] = numNodo;
      }
      break;
		case "ts": {
			switch (nodo.nodeName()) {
        case "message":
          res[0] = nodo.namedItem("source").toElement().text();
          break;
        default:
          res[0] = nomNodo;
          res[1] = numNodo;
      }
			break;
		}
    case "ui":
      switch (nodo.nodeName()) {
        case "action":
          if (nodo.parentNode().nodeName() == "actions" || nodo.parentNode().nodeName() == "actiongroup") {
            // actions
            res[0] = nodo.firstChild().firstChild().toElement().text();
          } else {
            // menubar/item, toolbars/toolbar
            res[0] = nodo.toElement().attribute("name");
          }
          break;
        case "image":
          // images
          res[0] = nodo.toElement().attribute("name");
          res[1] = nodo.namedItem("data").toElement().text();
          break;
        case "toolbar":
        case "spacer":
          // toolbars
          res[0] = nodo.firstChild().firstChild().toElement().text();
          break;
        case "widget":
          res[0] = nodo.toElement().attribute("class");
          res[1] = nodo.firstChild().firstChild().toElement().text();
          break;
        case "includehint":
          res[0] = nodo.toElement().text();
          break;
        case "connection":
          res[0] = nodo.namedItem("sender").toElement().text();
          res[1] = nodo.namedItem("signal").toElement().text();
          res[2] = nodo.namedItem("receiver").toElement().text();
          res[3] = nodo.namedItem("slot").toElement().text();
          break;
        case "item":
          if (nodo.parentNode().nodeName() == "menubar") {
            res[0] = nodo.toElement().attribute("name");
          } else {
            res[0] = nomNodo;
            res[1] = numNodo;
          }
          break;
        case "property":
          res[0] = nodo.toElement().attribute("name");
          break;
        default:
          res[0] = nomNodo;
          res[1] = numNodo;
      }
      break;

    case "mtd":
      switch (nodo.nodeName()) {
        case "field":
          if (nodo.parentNode().nodeName() == "TMD") {
            res[0] = nodo.namedItem("name").toElement().text();
          } else {
            res[0] = nomNodo;
            res[1] = numNodo;
          }
          break;
        case "relation":
          res[0] = nodo.namedItem("table").toElement().text();
          res[1] = nodo.namedItem("field").toElement().text();
          break;
        case "associated":
          res[0] = nodo.namedItem("with").toElement().text();
          res[1] = nodo.namedItem("by").toElement().text();
          break;
        default:
          res[0] = nomNodo;
          res[1] = numNodo;
      }
      break;
  }
  return res;
}

/** \D
Busca un nodo determinado cuyo id coincida con el par�metro

@param  nodoPadre: Nodo padre del nodo buscado
@param  id: Array con los datos de identificaci�n del nodo. Por defecto es la combinaci�n nombre - n�mero de nodo
@return Nodo encontrado o 0 en caso de que no exista
\end */
function head_buscarNodoPorId(nodoPadre: FLDomNode, nombreNodo: String, id: Array)
{
  var res = 0;

  if (id.length > 1 && nombreNodo == id[0] && !isNaN(parseFloat(id[1]))) {
    var i = 0;
    for (var nodo = nodoPadre.firstChild(); nodo; nodo = nodo.nextSibling()) {
      if (nodo.nodeName() == id[0]) {
        if (++i == id[1]) {
          res = nodo;
          return res;
        }
      }
    }
  }

  switch (this.iface.tipoDocActual) {
    case "xml":
      switch (nombreNodo) {
        case "action":
          var listaAcciones = nodoPadre.toElement().elementsByTagName("action")
          for (var j = 0; j < listaAcciones.length(); j++) {
            if (listaAcciones.item(j).namedItem("name").toElement().text() == id[0]) {
              res = listaAcciones.item(j);
              break;
            }
          }
          return res;
          break;
      }
      break;
			
		case "ts":
      switch (nombreNodo) {
        case "message":
          var listaAcciones = nodoPadre.toElement().elementsByTagName("message")
          for (var j = 0; j < listaAcciones.length(); j++) {
            if (listaAcciones.item(j).namedItem("source").toElement().text() == id[0]) {
              res = listaAcciones.item(j);
              break;
            }
          }
          return res;
          break;
      }
      break;

    case "ui":
      switch (nombreNodo) {
        case "action":
          switch (nodoPadre.nodeName()) {
            case "actions":
            case "actiongroup":
              var listaAcciones = nodoPadre.toElement().elementsByTagName("action")
              for (var j = 0; j < listaAcciones.length(); j++) {
                if (listaAcciones.item(j).firstChild().firstChild().toElement().text() == id[0]) {
                  res = listaAcciones.item(j);
                  break;
                }
              }
              return res;
              break;
            case "toolbar":
            case "item":
              var listaAcciones = nodoPadre.toElement().elementsByTagName("action")
              for (var j = 0; j < listaAcciones.length(); j++) {
                if (listaAcciones.item(j).toElement().attribute("name") == id[0]) {
                  res = listaAcciones.item(j);
                  break;
                }
              }
              return res;
              break;
          }
          break;
        case "property":
          var listaPropiedades = nodoPadre.childNodes();
          for (var j = 0; j < listaPropiedades.length(); j++) {
            if (listaPropiedades.item(j).nodeName() != "property") {
              continue;
            }
            if (listaPropiedades.item(j).toElement().attribute("name") == id[0]) {
              res = listaPropiedades.item(j);
              break;
            }
          }
          return res;
          break;
        case "item":
          switch (nodoPadre.nodeName()) {
            case "menubar":
              var listaItems = nodoPadre.toElement().elementsByTagName("item")
              for (var j = 0; j < listaItems.length(); j++) {
                if (listaItems.item(j).toElement().attribute("name") == id[0]) {
                  res = listaItems.item(j);
                  break;
                }
              }
              return res;
              break;
          }
          break;
        case "image":
          switch (nodoPadre.nodeName()) {
            case "images":
              var listaImagenes = nodoPadre.toElement().elementsByTagName("image")
              for (var j = 0; j < listaImagenes.length(); j++) {
                if (listaImagenes.item(j).toElement().attribute("name") == id[0] &&
                listaImagenes.item(j).namedItem("data").toElement().text() == id[1]) {
                  res = listaImagenes.item(j);
                  break;
                }
              }
              return res;
              break;
          }
          break;

        case "toolbar":
          switch (nodoPadre.nodeName()) {
            case "toolbars":
              var listaToolbars = nodoPadre.toElement().elementsByTagName("toolbar");
              for (var j = 0; j < listaToolbars.length(); j++) {
                if (listaToolbars.item(j).firstChild().firstChild().toElement().text() == id[0]) {
                  res = listaToolbars.item(j);
                  break;
                }
              }
              return res;
              break;
          }
          break;
        case "spacer":
          for (var nodo = nodoPadre.firstChild(); nodo; nodo = nodo.nextSibling()) {
            if (nodo.nodeName() == "spacer" && nodo.firstChild().firstChild().toElement().text() == id[0]) {
              res = nodo;
              break;
            }
          }
          return res;
          break;
        case "connection":
          var listaConexiones = nodoPadre.toElement().elementsByTagName("connection")
          for (var j = 0; j < listaConexiones.length(); j++) {
            if (listaConexiones.item(j).namedItem("sender").toElement().text() == id[0] && listaConexiones.item(j).namedItem("signal").toElement().text() == id[1] && listaConexiones.item(j).namedItem("receiver").toElement().text() == id[2] && listaConexiones.item(j).namedItem("slot").toElement().text() == id[3]) {
              res = listaConexiones.item(j);
              break;
            }
          }
          return res;
          break;
        case "widget":
          var listaWidgets = nodoPadre.toElement().elementsByTagName("widget");
          for (var j = 0; j < listaWidgets.length(); j++) {
            if (listaWidgets.item(j).toElement().attribute("class") == id[0] &&
                listaWidgets.item(j).firstChild().firstChild().toElement().text() == id[1]) {
              res = listaWidgets.item(j);
              break;
            }
          }
          return res;
          break;
        case "includehint":
          var listaHints = nodoPadre.toElement().elementsByTagName("includehint")
          for (var j = 0; j < listaHints.length(); j++) {
            if (listaHints.item(j).toElement().text() == id[0]) {
              res = listaHints.item(j);
              break;
            }
          }
          return res;
          break;
      }
      break;

    case "mtd":
      switch (nombreNodo) {
        case "field":
          switch (nodoPadre.nodeName()) {
            case "TMD":
              var listaCampos = nodoPadre.toElement().childNodes();
              for (var j = 0; j < listaCampos.length(); j++) {
                if (listaCampos.item(j).nodeName() == "field") {
                  if (listaCampos.item(j).namedItem("name").toElement().text() == id[0]) {
                    res = listaCampos.item(j);
                    break;
                  }
                }
              }
              return res;
              break;
          }
          break;

        case "relation":
          var listaRelaciones = nodoPadre.toElement().elementsByTagName("relation")
          for (var j = 0; j < listaRelaciones.length(); j++) {
            if (listaRelaciones.item(j).namedItem("table").toElement().text() == id[0] &&
            listaRelaciones.item(j).namedItem("field").toElement().text() == id[1]) {
              res = listaRelaciones.item(j);
              break;
            }
          }
          return res;
          break;

        case "associated":
          var listaRelaciones = nodoPadre.toElement().elementsByTagName("associated")
          for (var j = 0; j < listaRelaciones.length(); j++) {
            if (listaRelaciones.item(j).namedItem("with").toElement().text() == id[0] &&
            listaRelaciones.item(j).namedItem("by").toElement().text() == id[1]) {
              res = listaRelaciones.item(j);
              break;
            }
          }
          return res;
          break;
      }
      break;
  }

  return res;
}

/** \D
Realiza ciertas acciones (generalmente a�adir un prefijo al identificador del nodo) para evitar duplicidades al a�adir un nodo nuevo al documento actual

@param  nodo: Nodo a a�adir
@return Nodo preprocesado o False si hay error
\end */
function head_preprocesarNodo(nodo: FLDomNode)
{
  var res = nodo.cloneNode();

  switch (this.iface.tipoDocActual) {
    case "ui":
      var listaImagenes = nodo.toElement().elementsByTagName("iconset");
      if (!listaImagenes)
        break;
      for (var j = 0; j < listaImagenes.length(); j++) {
        var nombreImagen = listaImagenes.item(j).toElement().text();
        var nodoImagen = this.iface.obtenerNodoImagen(nodo.ownerDocument(), nombreImagen);

        var nodoImagesPrevio = this.iface.xmlPrevio.firstChild().namedItem("images");
        if (!nodoImagesPrevio) {
          var nodoImagesDif = this.iface.xmlDif.elementsByTagName("images");
          if (!nodoImagesDif) {
            var txt = "<xupdate:append-first select=\"/UI[UI,1]\"> <images/> </xupdate:append-first>";
            if (!this.iface.anadirNodoDif(txt))
              return false;
          }
        }
        var txt = "<xupdate:append-first select=\"/UI[UI,1]/images[images,1]\" />";

        if (!nombreImagen.startsWith(this.iface.funcionalActual)) {
          nombreImagen = this.iface.funcionalActual + nombreImagen;
          nodoImagen.toElement().setAttribute("name", nombreImagen);
        }
        if (!this.iface.anadirNodoDif(txt, nodoImagen))
          return false;

        res.toElement().elementsByTagName("iconset").item(j).firstChild().setNodeValue(nombreImagen);

      }
      break;
  }
  return res;
}

/** \D Obtiene un nodo <UI><images><image> en un documento .ui con un determinado atributo name
@param  doc: xml correspondiente al documento ui
@param  nombre: valor del atributo name
@return nodo <image>
\end */
function head_obtenerNodoImagen(doc: FLDomDocument, nombre: String)
{
  var nodoImages = doc.namedItem("UI").namedItem("images");
  var listaImagenes = nodoImages.toElement().elementsByTagName("image")
  for (var j = 0; j < listaImagenes.length(); j++) {
    if (listaImagenes.item(j).toElement().attribute("name") == nombre) {
      return listaImagenes.item(j).cloneNode();
    }
  }
  return 0;
}

/** \D A�ade un nodo al documento de modificaciones
@param  txt: Texto del nodo a a�adir
@param  nodo: Nodo hijo a a�adir
@return true si no hay error, false en caso contrario
\end */
function head_anadirNodoDif(txt: String, nodo: FLDomNode)
{
  var rE: RegExp = /&(?!amp;)/g;
  rE.global = true;
  txt = txt.replace(rE, "&amp;");

  var xmlDifAux = new FLDomDocument;
  if (!(xmlDifAux.setContent(txt)))
    return false;

  if (nodo) {
    var nodoNuevo = this.iface.preprocesarNodo(nodo);
    if (!nodoNuevo)
      return false
             xmlDifAux.firstChild().appendChild(nodoNuevo.cloneNode());
  }
  this.iface.xmlDif.firstChild().appendChild(xmlDifAux.firstChild());
  return true;
}

/** \D Incrementa el valor 'cuenta' del elemento de la lista cuyo nombre coincide con el par�metro 'nomNodo'. Si el elemento no existe, se crea uno con 'cuenta' = 1
@param  listaNodos: Lista de nodos
@param  nomNodo: Nombre del nodo
@return Lista de nodos con el nodo a�adido
\end */
function head_anadirNodoLista(listaNodos: Array, nomNodo: String)
{
  var i: Number;
  for (i = 0; i < listaNodos.length; i++) {
    if (listaNodos[i].nombre == nomNodo)
      break;
  }
  if (i == listaNodos.length) {
    listaNodos[i] = [];
    listaNodos[i].nombre = nomNodo;
    listaNodos[i].cuenta = 1;
  } else
    listaNodos[i].cuenta += 1;

  return listaNodos;
}

/** \D Busca un nodo en la lista de nodos por nombre y obtiene el �ndice correspondiente
@param  listaNodos: Lista de nodos
@param  nomNodo: Nombre del nodo
@return Indice
\end */
function head_buscarNodoLista(listaNodos: Array, nomNodo: String)
{
  var i: Number;
  for (i = 0; i < listaNodos.length; i++) {
    if (listaNodos[i].nombre == nomNodo)
      break;
  }
  return i;
}

/** Obtiene el fichero de script de las modificaciones (parche) que hay que hacer al fichero 1 para convertirlo en el fichero 2
@param  ruta1: Ruta al primer fichero
@param  ruta2: Ruta al segundo fichero
@param  codFuncional: C�digo de la funcionalidad que se est� tratando
@return Documento script de diferencias o false si hay error
*/
function head_obtenerScriptDif(ruta1: String, ruta2: String, codFuncional: String)
{
  var contenido1: String;
  var contenido2: String;

  if (!File.exists(ruta1)) {
    this.iface.pub_logAdd("No se encuentra el fichero " + ruta1);
    return false;
  }
  contenido1 = File.read(ruta1);

  if (!File.exists(ruta2)) {
    this.iface.pub_logAdd("No se encuentra el fichero " + ruta2);
    return 0;
  }
  contenido2 = File.read(ruta2);

  var dif = this.iface.compararScripts(contenido1, contenido2);
  return dif;
}

/** Obtiene el fichero php de las modificaciones (parche) que hay que hacer al fichero 1 para convertirlo en el fichero 2
@param  ruta1: Ruta al primer fichero
@param  ruta2: Ruta al segundo fichero
@param  codFuncional: C�digo de la funcionalidad que se est� tratando
@return Documento script de diferencias o false si hay error
*/
function head_obtenerPhpDif(ruta1: String, ruta2: String, codFuncional: String)
{
  var contenido1: String;
  var contenido2: String;

  if (!File.exists(ruta1)) {
    this.iface.pub_logAdd("No se encuentra el fichero " + ruta1);
    return false;
  }
  contenido1 = File.read(ruta1);

  if (!File.exists(ruta2)) {
    this.iface.pub_logAdd("No se encuentra el fichero " + ruta2);
    return 0;
  }
  contenido2 = File.read(ruta2);

  var dif = this.iface.compararPhps(contenido1, contenido2);
  return dif;
}

/** \D Obtiene la declaraci�n y definici�n de las clases que est�n en el fichero 2 pero no en el fichero 1
@param  contenido1: Contenido del fichero 1
@param  contenido2: Contenido del fichero 2
@return String con la declaraci�n y definici�n de la clase.
\end */
function head_compararScripts(contenido1: String, contenido2: String)
{
  var res = "";
  var lista1 = this.iface.listaClases(contenido1);
  var lista2 = this.iface.listaClases(contenido2);

  var i: Number;
  for (i = 0; i < lista2.length; i++) {
    if (lista2[i].tipoClase == "declaration") {
      if (this.iface.buscarClase(lista2[i].nombreClase, "declaration", lista1) == -1) {
        res += "\n" + contenido2.substring(lista2[i].posInicio, lista2[i].posFin);
      }
    }
  }

  for (i = 0; i < lista2.length; i++) {
    if (lista2[i].tipoClase == "definition") {
      if (this.iface.buscarClase(lista2[i].nombreClase, "definition", lista1) == -1) {
        res += "\n" + contenido2.substring(lista2[i].posInicio, lista2[i].posFin);;
      }
    }
  }

  return res;
}

/** \D Obtiene la declaraci�n y definici�n de las clases que est�n en el fichero php 2 pero no en el fichero 1
@param  contenido1: Contenido del fichero 1
@param  contenido2: Contenido del fichero 2
@return String con la declaraci�n y definici�n de la clase.
\end */
function head_compararPhps(contenido1: String, contenido2: String)
{
  var res = "";
  var lista1 = this.iface.listaClasesPhp(contenido1);
  var lista2 = this.iface.listaClasesPhp(contenido2);

  var i: Number;
  for (i = 0; i < lista2.length; i++) {
    if (lista2[i].tipoClase == "definition") {
      if (this.iface.buscarClase(lista2[i].nombreClase, "definition", lista1) == -1) {
        res += "\n" + contenido2.substring(lista2[i].posInicio, lista2[i].posFin);;
      }
    }
  }

  return res;
}

/** \D Obtiene el �ndice de la clase que concuerda en nombre y tipo dentro de un vector de clases
@param  nombre: Nombre de la clase buscada
@param  tipo: Tipo de la clase buscada (declaration o definition)
@param  lista: Vector de clases
@return Indice de la clase encontrada o -1 si no se encuentra
\end */
function head_buscarClase(nombre: String, tipo: String, lista: Array)
{
  for (var i = 0; i < lista.length; i++) {
    if (lista[i].nombreClase == nombre && lista[i].tipoClase == tipo) {
      return i;
    }
  }
  return -1;
}

/** \D Obtiene un vector de clases con los siguientes datos para cada elemento:

@param  contenido: Contenido del fichero de script
@return Array con los datos de cada parte del script. Los miembros de cada elemento son:
  Nombre: Nombre de la clase
  Tipo: Indica si se trata de la declaracion (declaration) o de la definici�n (definition)
  ClaseBase: Nombre de la clase base (s�lo para tipo declaracion)
  posInicio: Posici�n (car�cter) en la que se inicia esta parte
  posFin: Posici�n (car�cter) en la que se finaliza esta parte
\end */
function head_listaClases(contenido: String)
{
  var sep = "[\\s,\\t,\\n,\{]*";
  var label: RegExp = new RegExp("/\\*\\*" + sep + "@class_");
  var res = [];
  var pos = 0;
  var posNueva = contenido.find(label, pos);
  var indice = 0;
  while (posNueva != contenido.length) {
    var clase = [];
    var posAux = contenido.find("@class_", posNueva) + 7;
    clase.tipoClase = this.iface.obtenerNombreClase(contenido, posAux);
    clase.nombreClase = this.iface.obtenerNombreClase(contenido, posAux + clase.tipoClase.length);
    if (contenido.substring(posAux, posAux + 11) == "declaration")
      clase.nombreClaseBase =  this.iface.obtenerNombreClaseBase(contenido, posAux, clase.nombreClase);
    var posFinClase = contenido.find(label, posNueva + 1);
    if (posFinClase == -1)
      posFinClase = contenido.length;
    clase.posInicio = posNueva;
    clase.posFin = posFinClase - 1;

    res[indice++] = clase;
    posNueva = posFinClase;
  }
  return res;
}

/** \D Obtiene un vector de clases con los siguientes datos para cada elemento:

@param  contenido: Contenido del fichero de script
@return Array con los datos de cada parte del script. Los miembros de cada elemento son:
  Nombre: Nombre de la clase
  Tipo: Indica si se trata de la declaracion (s�lo hay definition)
  ClaseBase: Nombre de la clase base
  posInicio: Posici�n (car�cter) en la que se inicia esta parte
  posFin: Posici�n (car�cter) en la que se finaliza esta parte
\end */
function head_listaClasesPhp(contenido: String)
{
  var sep = "[\\s,\\t,\\n,\{]*";
  var label: RegExp = new RegExp("/\\*\\*" + sep + "@class_");
  var labelMain: RegExp = new RegExp("/\\*\\*" + sep + "@main_");
  var res = [];
  var pos = 0;
  var posNueva = contenido.find(label, pos);
  var posMain = contenido.find(labelMain, pos);
  var indice = 0;
  while (posNueva > -1) {
    debug("posNueva = " + posNueva);
    var clase = [];
    var posAux = contenido.find("@class_", posNueva) + 7;
    clase.tipoClase = this.iface.obtenerNombreClase(contenido, posAux);
    clase.nombreClase = this.iface.obtenerNombreClase(contenido, posAux + clase.tipoClase.length);
    clase.nombreClaseBase = this.iface.obtenerNombreClaseBase(contenido, posAux, clase.nombreClase);
    var posFinClase = contenido.find(label, posNueva + 1);
    debug("posFinClase = " + posFinClase);

    clase.posInicio = posNueva;
    if (posFinClase == -1) {
      posNueva = -1;
      if (posMain > -1)
        posFinClase = posMain;
      else
        posFinClase = contenido.length;
    } else {
      posNueva = posFinClase;
    }
    clase.posFin = posFinClase - 1;

    res[indice++] = clase;
  }
  return res;
}
/** \D Obtiene la palabra siguiente a la palabra extends (nombre de una clase base)

@param  contenido: Contenido del fichero
@param  pos: Posici�n a partir de la cual buscar la palabra
@param  clase: Nombre de la clase derivada
@return palabra
\end */
function head_obtenerNombreClaseBase(contenido: String, pos: Number, clase: String)
{
  var sep = "[\\s,\\t,\\n,\{]*";
  var label: RegExp = new RegExp(clase + sep + "extends");
  var posExtends = contenido.find(label, pos);
  if (posExtends == -1)
    return "";

  posExtends = contenido.find("extends", pos);
  return this.iface.obtenerNombreClase(contenido, posExtends + 7);
}

/** \D Obtiene la siguiente palabra (texto entre los caracteres ' ', tab, newline, '*')
@param  contenido: Contenido del fichero
@param  pos: Posici�n a partir de la cual buscar la palabra
@return palabra
\end */
function head_obtenerNombreClase(contenido: String, pos: Number)
{
  var nombre = "";
  var estado = 0;
  var indice = 0;
  var caracter: String;

  while (estado < 2) {
    caracter = contenido.charAt(pos + indice);
    switch (estado) {
      case 0: // Antes del nombre
        if (caracter != " " && caracter != "\t" && caracter != "\n" && caracter != "*" && caracter != "{") {
          nombre = caracter;
          estado = 1;
        }
        break;
      case 1: // En el nombre
        if (caracter != " " && caracter != "\t" && caracter != "\n" && caracter != "*" && caracter != "{") {
          nombre += caracter;
        } else {
          estado = 2;
        }
        break;
    }
    indice++;
  }
  return nombre;
}

/** \D
Resuelve autom�ticamente un conflicto en un archivo xml (ui, mtd, xml)

@param  contenidoParche: Contenido del parche de modificaciones
@param  contenidoActual: Contenido del fichero sin modificar
@return contenido del fichero modificado, false si hay error
\end */
function head_gestionConfXml(contenidoParche: String, contenidoActual: String)
{
  var xmlActual = new FLDomDocument;
  xmlActual.setContent(contenidoActual);

  var xmlNuevo = new FLDomDocument;
  xmlNuevo.setContent(contenidoActual);

  var xmlDif = new FLDomDocument;
  xmlDif.setContent(contenidoParche);

  var nodoDoc = xmlDif.namedItem("xupdate:modifications");
  var nodoActual: FLDomNode;
  var nodoDif: FLDomNode;
  var nombreNodo: String;
  var rutaNodo: Array;

  var tipoNodo: String;
  var nomNodo: String;
  var numNodo: String;
  var nodoEncontrado = 0;
  var idNodo: Array;
  var i: Number;

  for (nodoDif = nodoDoc.firstChild(); nodoDif; nodoDif = nodoDif.nextSibling()) {
    nombreNodo = nodoDif.nodeName();
    //this.iface.pub_logAdd(nombreNodo);
    rutaNodo = nodoDif.attributeValue("select").split("/");
    nodoActual = xmlActual;
    tipoNodo = ""
               nomNodo = "";
    numNodo = "";
    nodoEncontrado = 0;
    if (idNodo) delete idNodo;

    for (i = 1; i < rutaNodo.length; i++) {
      if (rutaNodo[i].charAt(0) == "@") {
        nomNodo = rutaNodo[i];
        numNodo = 0;
      } else {
        nomNodo = rutaNodo[i].substring(0, rutaNodo[i].find("["));
        numNodo = rutaNodo[i].substring(rutaNodo[i].find("[") + 1, rutaNodo[i].find("]"));
      }

      tipoNodo = this.iface.obtenerTipoNodo(nomNodo);
      if (tipoNodo != "normal")
        continue;

      idNodo = numNodo.split(",");
      var nodoAux = nodoActual;
      nodoActual = this.iface.buscarNodoPorId(nodoActual, nomNodo, idNodo);
      if (!nodoActual || nodoActual == 0) {
        if (i == (rutaNodo.length - 1))
          nodoEncontrado = 1;
        else
          nodoEncontrado = 2;
        nodoActual = nodoAux;
        break;
      }
    }
    switch (nombreNodo) {
      case "xupdate:insert-after":
        switch (nodoEncontrado) {
          case 0:
            var nodoAux = nodoDif.firstChild().cloneNode();
            nodoActual = nodoActual.parentNode().insertAfter(nodoAux, nodoActual);
            break;
          case 1:
            this.iface.pub_logAdd("Insert-after: No se ha encontrado el nodo de referencia en " + nodoDif.attributeValue("select"));
            this.iface.pub_logAdd("Warning: El nodo se insertar� como �ltimo hijo");
            var nodoAux = nodoDif.firstChild().cloneNode();
            nodoActual = nodoActual.appendChild(nodoAux);
            break;
          case 2:
            this.iface.pub_logAdd("Insert-after: No se ha encontrado la ruta de referencia para " + nodoDif.attributeValue("select") + "en " + nomNodo + "-" + rutaNodo[i]);
            this.iface.pub_logAdd("Error: El nodo no puede insertarse");
            return false;
            break;
        }
        break;
      case "xupdate:append-first":
        switch (nodoEncontrado) {
          case 0:
            var nodoAux = nodoDif.firstChild().cloneNode();
            nodoActual = nodoActual.insertBefore(nodoAux);
            break;
          case 1:
          case 2:
            this.iface.pub_logAdd("Append-first:");
            this.iface.pub_logAdd("Error: Se perdi� el nodo actual buscando " + nodoDif.attributeValue("select") + " en " + nomNodo + "-" + rutaNodo[i]);
            return false;
        }
        break;
      case "xupdate:delete":
        switch (nodoEncontrado) {
          case 0:
            nodoActual = nodoActual.parentNode().removeChild(nodoActual);
            break;
          case 1:
            this.iface.pub_logAdd("Delete: Eliminaci�n de " + nodoDif.attributeValue("select"));
            this.iface.pub_logAdd("Warning: El nodo especificado no existe");
            break;
          case 2:
            this.iface.pub_logAdd("Delete:");
            this.iface.pub_logAdd("Error: Se perdi� el nodo actual buscando " + nodoDif.attributeValue("select") + " en " + nomNodo + "-" + idNodo);
            return false;
            break;
        }
        break;
      case "xupdate:update":
        switch (nodoEncontrado) {
          case 0:
            switch (tipoNodo) {
              case "normal":
                break;
              case "texto":
                nodoActual.firstChild().setNodeValue(nodoDif.firstChild().nodeValue());
                break;
              case "atributo":
                var nomAtributo = nomNodo.substring(1, nomNodo.length);
                nodoActual.toElement().setAttribute(nomAtributo, nodoDif.firstChild().nodeValue());
                break;
            }
            break;
          case 1:
          case 2:
            this.iface.pub_logAdd("Update:");
            this.iface.pub_logAdd("Error: Se perdi� el nodo actual buscando " + nodoDif.attributeValue("select") + " en " + nomNodo + "-" + idNodo);
            return false;
            break;
        }
        break;
    }
  }

  return xmlActual.toString(4);
}

/** \D
Obtiene el tipo de nodo que se va a modificar, en funci�n del nombre del nodo

@param  nomNodo: Nombre del nodo
@return tipo del nodo. Los posibles valores son:
  atributo: El nombre del nodo empieza por @
  texto: El nombre del nodo es text()
  normal: Cualquier otro caso
\end */
function head_obtenerTipoNodo(nomNodo: String)
{
  if (nomNodo.charAt(0) == "@") {
    return "atributo";
  } else if (nomNodo == "text()") {
    return "texto";
  } else {
    return "normal";
  }
}

/** \D
Resuelve autom�ticamente un conflicto en un archivo de script (qs)

@param  contenidoParche: Contenido del parche de modificaciones
@param  contenidoActual: Contenido del fichero sin modificar
@return contenido del fichero modificado, false si hay error
\end */
function head_gestionConfScript(qsDif: String, qsActual: String)
{
  var qsNuevo = qsActual;
  var posIniPalabra: Number;
  var posFinPalabra: Number;
  var indiceClase: Number;
  var indiceClaseBase: Number;
  var posAux = 0;
  var reAux: RegExp;
  var labelDeclaracion = "@class_declaration";
  var sep = "[\\s,\\t,\\n,{]";
  var sep2 = "[\\s,\\t,\\n,{,(]";

  var listaNuevo = this.iface.listaClases(qsNuevo);
  var listaDif = this.iface.listaClases(qsDif);
  var listaClasesBase = [];

  var nombreClase: String;
  var nombreClasePrevia: String;

  for (var indice = 0; indice < listaDif.length; indice++) {

    nombreClase = listaDif[indice].nombreClase;
    if (listaDif[indice].tipoClase == "declaration") {
      listaClasesBase[nombreClase] = listaDif[indice].nombreClaseBase;
      nombreClasePrevia = "";
      for (var i = 0; i < listaNuevo.length; i++) {
        nombreClasePrevia = listaNuevo[i].nombreClase;
        reAux = new RegExp("class" + sep + nombreClasePrevia + sep + "extends" + sep + listaClasesBase[nombreClase] + sep);
        posAux = qsNuevo.find(reAux, listaNuevo[i].posInicio);
        if (posAux != -1)
          break;
      }

      if (posAux != -1) {
        // Cambia 'extends claseBase' por 'extends claseNueva' en la clase que ser� hija de claseNueva
        reAux = new RegExp(listaClasesBase[nombreClase] + sep);
        posIniPalabra = qsNuevo.find(reAux, posAux);
        posFinPalabra = posIniPalabra + listaClasesBase[nombreClase].length;
        qsNuevo = qsNuevo.substring(0, posIniPalabra) + nombreClase + qsNuevo.substring(posFinPalabra, qsNuevo.length - 1);
        // Cambia el constructor para que llame al constructor de la clase nueva
        reAux = new RegExp("function" + sep + nombreClasePrevia + sep + "*\\(");
        posAux = qsNuevo.find(reAux, posAux);
        if (posAux == -1) {
          debug("Error buscando function " + nombreClasePrevia);
          return false;
        }
        reAux = new RegExp(listaClasesBase[nombreClase] + sep2);
        posIniPalabra = qsNuevo.find(reAux, posAux);
        if (posIniPalabra == -1) {
          debug("Error buscando clase base " + listaClasesBase[nombreClase]);
          return false;
        }
        posFinPalabra = posIniPalabra + listaClasesBase[nombreClase].length;
        qsNuevo = qsNuevo.substring(0, posIniPalabra) + nombreClase + qsNuevo.substring(posFinPalabra, qsNuevo.length - 1);
      }

      // Introduce la declaraci�n de la clase nueva
      listaNuevo = this.iface.listaClases(qsNuevo);
      indiceClaseBase = this.iface.buscarClase(listaClasesBase[nombreClase], "declaration", listaNuevo);
      // debug("Buscando " + listaClasesBase[nombreClase] + " en " + listaNuevo.join(" - "));
      indiceClase = this.iface.buscarClase(nombreClase, "declaration", listaDif);
      qsNuevo = qsNuevo.substring(0, listaNuevo[indiceClaseBase].posFin) + "\n" + qsDif.substring(listaDif[indiceClase].posInicio, listaDif[indiceClase].posFin) + "\n" + qsNuevo.substring(listaNuevo[indiceClaseBase].posFin + 1, qsNuevo.length);
    } else {
      // Introduce la definici�n de la clase nueva
      listaNuevo = this.iface.listaClases(qsNuevo);
      indiceClaseBase = this.iface.buscarClase(listaClasesBase[nombreClase], "definition", listaNuevo);

      if (indiceClaseBase == -1)
        indiceClaseBase = listaNuevo.length - 1;
      indiceClase = this.iface.buscarClase(nombreClase, "definition", listaDif);
      qsNuevo = qsNuevo.substring(0, listaNuevo[indiceClaseBase].posFin) + "\n" + qsDif.substring(listaDif[indiceClase].posInicio, listaDif[indiceClase].posFin + 1) + "\n" + qsNuevo.substring(listaNuevo[indiceClaseBase].posFin + 1, qsNuevo.length + 1);
    }
  }

  // Cambia, si es necesario la clase del objeto iface
  listaNuevo = this.iface.listaClases(qsNuevo);
  reAux = new RegExp("const" + sep + "iface" + sep + "=" + sep + "new");
  posAux = qsNuevo.find(reAux);
  posIniPalabra = qsNuevo.find("new", posAux) + 4;
  posFinPalabra = qsNuevo.find("(", posAux) - 1;
  var ultimaClase = this.iface.buscarUltClaseDerivada(listaNuevo);
  if (!ultimaClase) {
    this.iface.pub_logAdd("Error de consistencia en la estructura de clases");
    return false;
  }
  qsNuevo = qsNuevo.substring(0, posIniPalabra) + ultimaClase +
            qsNuevo.substring(posFinPalabra + 1, qsNuevo.length);
  return qsNuevo;
}

/** \D
Resuelve autom�ticamente un conflicto en un archivo de c�digo php(qs)

@param  contenidoParche: Contenido del parche de modificaciones
@param  contenidoActual: Contenido del fichero sin modificar
@return contenido del fichero modificado, false si hay error
\end */
function head_gestionConfPhp(qsDif: String, qsActual: String)
{
  var qsNuevo = qsActual;
  var posIniPalabra: Number;
  var posFinPalabra: Number;
  var indiceClase: Number;
  var indiceClaseBase: Number;
  var posAux = 0;
  var posMain = 0;
  var reAux: RegExp;
  var labelDeclaracion = "@class_definition";
  var sep = "[\\s,\\t,\\n,{]";

  var listaNuevo = this.iface.listaClasesPhp(qsNuevo);
  var listaDif = this.iface.listaClasesPhp(qsDif);
  var listaClasesBase = [];

  for (var indice = 0; indice < listaDif.length; indice++) {
    var nombreClase = listaDif[indice].nombreClase;
    if (listaDif[indice].tipoClase == "definition") {
      listaClasesBase[nombreClase] = listaDif[indice].nombreClaseBase;
      var nombreClasePrevia: String;
      for (var i = 0; i < listaNuevo.length; i++) {
        nombreClasePrevia = listaNuevo[i].nombreClase;
        reAux = new RegExp("class" + sep + nombreClasePrevia + sep + "extends" + sep + listaClasesBase[nombreClase] + sep);
        posAux = qsNuevo.find(reAux, listaNuevo[i].posInicio);
        if (posAux != -1)
          break;
      }

      if (posAux != -1) {
        // Cambia 'extends claseBase' por 'extends claseNueva' en la clase que ser� hija de claseNueva
        posIniPalabra = qsNuevo.find(listaClasesBase[nombreClase], posAux);
        posFinPalabra = posIniPalabra + listaClasesBase[nombreClase].length;
        qsNuevo = qsNuevo.substring(0, posIniPalabra) + nombreClase + qsNuevo.substring(posFinPalabra, qsNuevo.length - 1);
      }

      // Introduce la declaraci�n de la clase nueva
      listaNuevo = this.iface.listaClasesPhp(qsNuevo);
      indiceClaseBase = this.iface.buscarClase(listaClasesBase[nombreClase], "definition", listaNuevo);
      indiceClase = this.iface.buscarClase(nombreClase, "definition", listaDif);
      qsNuevo = qsNuevo.substring(0, listaNuevo[indiceClaseBase].posFin) + "\n" + qsDif.substring(listaDif[indiceClase].posInicio, listaDif[indiceClase].posFin) + "\n" + qsNuevo.substring(listaNuevo[indiceClaseBase].posFin + 1, qsNuevo.length);
    } else {
      // No debe entrar nunca para archivos php (s�lo tienen definition)
    }
  }

  // Cambia, si es necesario la clase del objeto iface
  listaNuevo = this.iface.listaClasesPhp(qsNuevo);
  reAux = new RegExp("@main_class_definition");
  posAux = qsNuevo.find(reAux);
  posAux = qsNuevo.find("extends", posAux);
  posIniPalabra = posAux + 8;
  posFinPalabra = qsNuevo.find("{", posIniPalabra);
  var ultimaClase = this.iface.buscarUltClaseDerivadaPhp(listaNuevo);
  if (!ultimaClase) {
    this.iface.pub_logAdd("Error de consistencia en la estructura de clases");
    return false;
  }
  posAux = qsNuevo.find("extends", posAux);
  qsNuevo = qsNuevo.substring(0, posIniPalabra) + ultimaClase +
            qsNuevo.substring(posFinPalabra, qsNuevo.length);
  return qsNuevo;
}

/** \D Busca la clase la clase derivada que no es base de ninguna otra clase en un script. Tambi�n comprueba que todas las clases del script forman una cadena de herencia continua y de una sola rama

@param listaClases: Lista con los datos de cada una de las clases
@return nombre de la clase buscada o false si no existe o si la estructura de clases no es correcta
\end */
function head_buscarUltClaseDerivada(listaClases: Array)
{
  var datosClases = [];
  var indice = 0;
  var clase = "";
  for (var i = 0; i < listaClases.length; i++) {
    if (listaClases[i].tipoClase != "declaration")
      continue;
    datosClases[indice] = [];
    datosClases[indice].clase = listaClases[i].nombreClase;
    datosClases[indice].claseBase = listaClases[i].nombreClaseBase;
    indice++;
  }
  for (var i = 0; i < datosClases.length; i++) {
    var k: Number;
    for (k = 0; k < datosClases.length; k++) {
      if (datosClases[k].claseBase == clase) {
        clase = datosClases[k].clase;
        break;
      }
    }
    if (k == datosClases.length)
      return false;
  }
  return clase;
}

/** \D Busca la clase la clase derivada que no es base de ninguna otra clase en un fichero php. Tambi�n comprueba que todas las clases del fichero forman una cadena de herencia continua y de una sola rama
@param listaClases: Lista con los datos de cada una de las clases
@return nombre de la clase buscada o false si no existe o si la estructura de clases no es correcta
\end */

function head_buscarUltClaseDerivadaPhp(listaClases: Array)
{
  var datosClases = [];
  var indice = 0;
  var clase = "";
  for (var i = 0; i < listaClases.length; i++) {
    if (listaClases[i].tipoClase != "definition")
      continue;
    datosClases[indice] = [];
    datosClases[indice].clase = listaClases[i].nombreClase;
    datosClases[indice].claseBase = listaClases[i].nombreClaseBase;
    indice++;
  }
  for (var i = 0; i < datosClases.length; i++) {
    var k: Number;
    for (k = 0; k < datosClases.length; k++) {
      if (datosClases[k].claseBase == clase) {
        clase = datosClases[k].clase;
        break;
      }
    }
    if (k == datosClases.length)
      return false;
  }
  return clase;
}

/** \D Aplica el parche de una determinada funcionalidad

@param  codFuncional: funcionalidad
@param  dirParche: directorio donde reside dicho parche
@param  dirDest: directorio donde se aplicar� el parche
@return True si no hay error, false en caso contrario
\end */
function head_aplicarParche(codFuncional: String, dirParche: String, dirDest: String)
{
  Dir.current = this.iface.obtenerPathLocal();
  if (!File.exists(dirParche + "/" + codFuncional + ".xml")) {
    this.iface.pub_logAdd("El parche " + codFuncional + " est� vac�o");
    return true;
  }
  var xmlParche = new FLDomDocument;
  xmlParche.setContent(File.read(dirParche + "/" + codFuncional + ".xml"));
  var nodo: FLDomNode;
  var nodoDoc = xmlParche.namedItem("flpatch:modifications");

  for (nodo = nodoDoc.firstChild(); nodo; nodo = nodo.nextSibling()) {
    if (!this.iface.aplicarParcheNodo(nodo, dirParche, dirDest, dirDest)) {
      return false;
    }
  }
  return true;
}

function head_aplicarParcheNodo(nodo: FLDomNode, dirParche: String, dirOrig: String, dirDest: String)
{
  var pathFichero = nodo.toElement().attribute("path");
  var nombre = nodo.toElement().attribute("name");

  if (!File.exists(this.iface.obtenerPathLocal() + dirParche + "/" + nombre)) {
    this.iface.pub_logAdd("El fichero " + dirParche + "/" + nombre + " no existe");
    return false;
  }
  /// Si no existe el directorio origen es porque el m�dulo de turno no ha bajado, porque el cliente no lo tiene aunque la extensi�n lo toque
  if (!File.exists(this.iface.pathLocal + dirOrig + "/" + pathFichero)) {
    return true;
  }
  var contenido: String;
  switch (nodo.nodeName()) {
    case "flpatch:patchXml":
      this.iface.pub_logAdd("Aplicando parche a " + nombre);
      if (!File.exists(this.iface.pathLocal + dirOrig + "/" + pathFichero + nombre)) {
        this.iface.pub_logAdd("El fichero " + this.iface.pathLocal + dirParche + "/" + pathFichero + nombre + " no existe");
        return false;
      }
      this.iface.tipoDocActual = nombre.substring(nombre.findRev(".") + 1, nombre.length);
      contenido = this.iface.gestionConfXml(File.read(this.iface.pathLocal + dirParche + "/" + nombre), File.read(this.iface.pathLocal + dirOrig + "/" + pathFichero + nombre));
      if (!contenido) {
        this.iface.pub_logAdd("Error al aplicar el parche al fichero " + nombre);
        return false;
      }
      contenido = this.iface.reemplazar(contenido, "&quot;", "\"");
      File.write(this.iface.pathLocal + dirDest + "/" + pathFichero + nombre, contenido);
      break;

    case "flpatch:patchScript":
      this.iface.pub_logAdd("Aplicando parche a " + nombre);
      // debug("Ruta = " + this.iface.pathLocal + dirOrig + "/" + pathFichero + nombre);
      if (!File.exists(this.iface.pathLocal + dirOrig + "/" + pathFichero + nombre)) {
        this.iface.pub_logAdd("El fichero " + this.iface.pathLocal + dirParche + "/" + nombre + " no existe");
        return false;
      }
      contenido = this.iface.gestionConfScript(File.read(this.iface.pathLocal + dirParche + "/" + nombre), File.read(this.iface.pathLocal + dirOrig + "/" + pathFichero + nombre));
      if (!contenido) {
        this.iface.pub_logAdd("Error al aplicar el parche al fichero " + nombre);
        return false;
      }
      contenido = this.iface.reemplazar(contenido, "&quot;", "\"");
      File.write(this.iface.pathLocal + dirDest + "/" + pathFichero + nombre, contenido);
      break;

    case "flpatch:patchPhp":
      this.iface.pub_logAdd("Aplicando parche a " + nombre);
      if (!File.exists(this.iface.pathLocal + dirOrig + "/" + pathFichero + nombre)) {
        this.iface.pub_logAdd("El fichero " + this.iface.pathLocal + dirParche + "/" + nombre + " no existe");
        return false;
      }
      contenido = this.iface.gestionConfPhp(File.read(this.iface.pathLocal + dirParche + "/" + nombre), File.read(this.iface.pathLocal + dirOrig + "/" + pathFichero + nombre));
      if (!contenido) {
        this.iface.pub_logAdd("Error al aplicar el parche al fichero " + nombre);
        return false;
      }
      contenido = this.iface.reemplazar(contenido, "&quot;", "\"");
      File.write(this.iface.pathLocal + dirDest + "/" + pathFichero + nombre, contenido);
      break;

    case "flpatch:replaceFile":
      this.iface.pub_logAdd("Reemplazando " + nombre);
      var comando = "cp -f " + this.iface.pathLocal + dirParche + "/" + nombre + " " + this.iface.pathLocal + dirDest + "/" + pathFichero + nombre;
      var resComando = this.iface.ejecutarComando(comando);
      if (resComando.ok == false) {
        this.iface.pub_logAdd("Error al copiar el fichero con: " + comando);
        return;
      }
      /// Si el parche incluye un cambio sobre un archivo kut, se borra el correspondiente archivo ar para que sea el kut el que se cargue.
      if (nombre.endsWith(".kut")) {
        var nombreAr = nombre.left(nombre.length - 3);
        nombreAr += "ar";
        comando = "rm -f " + this.iface.pathLocal + dirDest + "/" + pathFichero + nombreAr;
        resComando = this.iface.ejecutarComando(comando);
        if (resComando.ok == false) {
          this.iface.pub_logAdd("Error al eliminar el fichero con: " + comando);
          return;
        }
      }
      if (nombre.endsWith(".ar") && (dirDest.endsWith("modulos") || dirDest.endsWith("prueba") || dirDest.endsWith("modulos/") || dirDest.endsWith("prueba/"))) {
        contenido = File.read(this.iface.pathLocal + dirParche + "/" + nombre);
        contenido = sys.toUnicode(contenido, "UTF-8");
        var contenidoKut = flar2kut.iface.pub_ar2kut(contenido);
        contenidoKut = sys.fromUnicode(contenidoKut, this.iface.localEnc_);
        var nombreKut = nombre.left(nombre.length - 2);
        nombreKut += "kut";
        File.write(this.iface.pathLocal + dirDest + "/" + pathFichero + nombreKut, contenidoKut);
      }
      break;
    case "flpatch:addFile":
      this.iface.pub_logAdd("A�adiendo " + nombre);
      var comando = "cp -f " + this.iface.pathLocal + dirParche + "/" + nombre + " " + this.iface.pathLocal + dirDest + "/" + pathFichero + nombre;
      var resComando = this.iface.ejecutarComando(comando);
      if (resComando.ok == false) {
        this.iface.pub_logAdd("Error al copiar el fichero con: " + comando);
        return;
      }
      if (nombre.endsWith(".ar") && (dirDest.endsWith("modulos") || dirDest.endsWith("prueba") || dirDest.endsWith("modulos/") || dirDest.endsWith("prueba/"))) {
        contenido = File.read(Dir.cleanDirPath(this.iface.pathLocal + dirParche + "/" + nombre));
        contenido = sys.toUnicode(contenido, "UTF-8");
        var contenidoKut = flar2kut.iface.pub_ar2kut(contenido);
        contenidoKut = sys.fromUnicode(contenidoKut, this.iface.localEnc_);
        var nombreKut = nombre.left(nombre.length - 2);
        nombreKut += "kut";
        File.write(Dir.cleanDirPath(this.iface.pathLocal + dirDest + "/" + pathFichero + nombreKut), contenidoKut);
      }
      //      contenido = File.read(this.iface.pathLocal + dirParche + "/" + nombre);
      break;
  }

  this.iface.pub_logAdd("OK");
  sys.processEvents();
  return true;
}

function head_cargarCodificacionLocal()
{
  var util = new FLUtil;
  this.iface.localEnc_ = util.readSettingEntry("scripts/sys/conversionArENC");
  if (!this.iface.localEnc_) {
    this.iface.localEnc_ = "ISO-8859-15";
  }
}

/** \D Obtiene una lista ordenada (orden de instalaci�n) de las funcionalidades de las que depende una determinada funcionalidad

@param  codFuncional: funcionalidad
@return Lista de funcionalidades
\end */
function head_obtenerListaDep(codFuncional: String, versionBase: String)
{
  // debug("F = " + codFuncional);
  var listaDesordenada = this.iface.obtenerListaDepDes(codFuncional, versionBase);
  // debug("LD = ");
  // for (var i= 0; i < listaDesordenada.length; i++) { debug("i = " + i + ", fun = " + listaDesordenada[i]["fun"] + ", ver = " + listaDesordenada[i]["ver"]); }
  var listaOrdenada = this.iface.ordenarListaDep(listaDesordenada);
//   debug("LO");
//   for (var i= 0; i < listaOrdenada.length; i++) { debug("i = " + i + ", fun = " + listaOrdenada[i]["fun"] + ", ver = " + listaOrdenada[i]["ver"]); }
  return listaOrdenada;
}

/** \D Obtiene una lista ordenada (orden de instalaci�n) de las funcionalidades asociadas a un cliente, as� como de sus dependencias

@param  idCliente: identificador del cliente
@return Lista de funcionalidades
\end */
// function head_obtenerListaDepCliente(idCliente:String)
// {
//  var listaDesordenada= [];
//  var qryDep= new FLSqlQuery();
//  qryDep.setTablesList("mv_funcionalcli");
//  qryDep.setSelect("codfuncional");
//  qryDep.setFrom("mv_funcionalcli");
//  qryDep.setWhere("idcliente = '" + idCliente + "'");
//  if (!qryDep.exec()) {
//    this.iface.pub_logAdd ("Error al ejecutar la consulta");
//    return false;
//  }
//  while (qryDep.next()) {
//    listaDesordenada[listaDesordenada.length] = qryDep.value(0);
//    listaDesordenada = listaDesordenada.concat(this.iface.obtenerListaDepDes(qryDep.value(0)));
//  }
//
//  var listaOrdenada= this.iface.ordenarListaDep(listaDesordenada);
//  return listaOrdenada;
// }

/** \D Ordena una lista de funcionalidades desde las padres hasta las hijas y con las repeticiones eliminadas

@param  listaDesordenada: Lista a ordenar
@return Lista ordenada
\end */
function head_ordenarListaDep(listaDesordenada: Array)
{
  var listaOrdenada = [];
  var iDesor = 0;
  var procesadas = 0;
  var iOrden = 0, funcionalidad: String;
  while (procesadas < listaDesordenada.length) {
    if (this.iface.sinDependencias(listaDesordenada[iDesor]["fun"], listaDesordenada)) {
      listaOrdenada[iOrden] = [];
      funcionalidad = listaDesordenada[iDesor]["fun"];
      listaOrdenada[iOrden]["fun"] = funcionalidad;
      listaOrdenada[iOrden]["ver"] = listaDesordenada[iDesor]["ver"];
      iOrden++;

      var i = iDesor;
      do {
        listaDesordenada[i]["fun"] = "";
        procesadas++;

        i = this.iface.buscarPalabra(funcionalidad, listaDesordenada)
      } while (i > -1)
            iDesor = -1;
    }
    if (++iDesor == listaDesordenada.length) {
      iDesor = 0;
    }
  }

  return listaOrdenada;
}

/** \D Busca el elemento de la lista cuyo valor coincide con el par�metro 'palabra'

@param  palabra: palabra buscada
@param  lista: lista de palabras
@return indice del elemento cuyo valor coincide, o -1 si no existe
\end */
function head_buscarPalabra(palabra: String, lista: Array)
{
  for (var i = 0; i < lista.length; i++) {
    if (lista[i]["fun"] == palabra) {
      return i;
    }
  }
  return -1;
}

/** \D Indica si una funcionalidad tiene o no dependencias dentro de una lista dada

@param  codFuncional: funcionalidad
@param  listaDep: lista de funcionalidades
@return true si tiene dependencias, false en caso contrario
\end */
function head_sinDependencias(codFuncional: String, listaDep: Array)
{
  if (codFuncional == "") {
    return false;
  }
  var qryDep = new FLSqlQuery();
  qryDep.setTablesList("mv_dependencias");
  qryDep.setSelect("codpadre");
  qryDep.setFrom("mv_dependencias");
  qryDep.setWhere("codhijo = '" + codFuncional + "'");
  if (!qryDep.exec()) {
    this.iface.pub_logAdd("Error al ejecutar la consulta");
    return false;
  }
  while (qryDep.next()) {
    if (this.iface.buscarPalabra(qryDep.value(0), listaDep) != -1) {
      return false;
    }
  }
  return true;
}

/** \D Obtiene una lista desordenada de las funcionalidades de las que depende una determinada funcionalidad

@param  codFuncional: funcionalidad
@return Lista de funcionalidades
\end */
function head_obtenerListaDepDes(codFuncional: String, versionBase: String)
{
  var lista = [];
  var qryDep = new FLSqlQuery();
  qryDep.setTablesList("mv_dependencias");
  qryDep.setSelect("d.codpadre, d.version, f.proyecto, f.versionbase");
  qryDep.setFrom("mv_dependencias d INNER JOIN mv_funcional f ON d.codpadre = f.codfuncional");
  qryDep.setWhere("d.codhijo = '" + codFuncional + "' ORDER BY d.orden");
  if (!qryDep.exec()) {
    this.iface.pub_logAdd("Error al ejecutar la consulta");
    return false;
  }

  var indice, version;
  while (qryDep.next()) {
    indice = lista.length;
    lista[indice] = [];
    lista[indice]["fun"] = qryDep.value("d.codpadre");
    version = qryDep.value("d.version");
    if (!version || version == "") {
      version = versionBase;
    }
    lista[indice]["ver"] = version;
		if (qryDep.value("f.proyecto")) {
			/// Cuando se depende de un proyecto se baja el proyecto en su �ltima versi�n pero el resto de funcionalidades en la versi�n base del mismo. Esto permite bajar la misma versi�n de extensiones que las del proyecto del que se hereda, y evita que se bajen todas las dependencias del proyecto en la �ltima versi�n
			version = qryDep.value("f.versionbase");
		}
    lista = lista.concat(this.iface.obtenerListaDepDes(lista[indice]["fun"], version));
  }
  return lista;
}

/** \D Obtiene los m�dulos necesarios para instalar una determinada funcionalidad

@param  codFuncional: funcionalidad
@param  dirDestino1: directorio base donde instalar los m�dulos
@param  dirDestino2: directorio donde instalar los m�dulos
@return True si no hay error, false en caso contrario
\end */
function head_checkoutMods(codFuncional: String, dirDestino1: String, dirDestino2: String, versionBase: String)
{
	var _i = this.iface;
  var util = new FLUtil;

  var codigoWeb = util.sqlSelect("mv_funcional", "codigoweb", "codfuncional = '" + codFuncional + "'");
  var repositorio: String;
  if (codigoWeb) {
    repositorio = this.iface.urlRepositorioWebOficial;
  } else {
    repositorio = this.iface.urlRepositorioMod;
		if (!repositorio) {
			repositorio = _i.obtenerUrlRepositorioMod();
		}
  }

  Dir.current = this.iface.pathLocal + dirDestino1 + "/" + dirDestino2;

  var qryMods = new FLSqlQuery();
  qryMods.setTablesList("mv_modulosfun,mv_modulos,mv_areas");
  qryMods.setSelect("mf.idmodulo, m.directorio, a.directorio, s.directorio, mf.version");
  qryMods.setFrom("mv_modulosfun mf INNER JOIN mv_modulos m ON mf.idmodulo = m.idmodulo INNER JOIN mv_areas a ON m.idarea = a.idarea INNER JOIN mv_secciones s ON a.idseccion = s.idseccion");
  qryMods.setWhere("mf.codfuncional = '" + codFuncional + "'");
  if (!qryMods.exec()) {
    this.iface.pub_logAdd("Error al ejecutar la consulta de m�dulos afectados por " + codFuncional);
    return false;
  }
  var dirArea: String;
  var dirMod: String;
  var dirSec: String;

  debug("versionBase " + versionBase);
  debug("this.iface.versionTronco_ " + this.iface.versionTronco_);
  if (!versionBase || versionBase == this.iface.versionTronco_) {
    versionBase = "tronco";
  }

  var versionMod: String;
  while (qryMods.next()) {
    dirMod = qryMods.value("m.directorio");
    dirArea = qryMods.value("a.directorio");
    dirSec = qryMods.value("s.directorio");
    versionMod = qryMods.value("mf.version");
    if (versionMod == this.iface.versionTronco_) {
      versionMod = "tronco";
    }
    if (!versionMod || versionMod == "") {
      versionMod = versionBase;
    }
    // debug("****Sec = " + dirSec);
    // debug("****Area = " + dirArea);
    // debug("****Mod = " + dirMod);
    this.iface.pub_logAdd("Obteniendo m�dulo " + dirArea + "/" + dirMod);
    if (!File.exists(dirArea)) {
      var resComando = this.iface.ejecutarComando("mkdir " + dirArea);
      if (resComando.ok == false) {
        this.iface.pub_logAdd("Error mkdir " + dirArea);
        return false;
      }
      var comando: String;
      if (dirSec == "oficial") {
        comando = "svn checkout -N " +  repositorio + dirSec + "/" + versionMod + "/" + dirArea + " " +  dirArea;
      } else {
        comando = "svn checkout -N " +  repositorio + dirSec + "/" + "tronco/" + dirArea + " " +  dirArea;
      }
      var resComando = this.iface.ejecutarComando(comando);
      if (resComando.ok == false) {
        this.iface.pub_logAdd("Error checkout " + dirArea);
        return false;
      }
    }
    if (File.exists(dirArea + "/" + dirMod)) {
      continue;
    }
    var comando: String;
    if (dirSec == "oficial") {
      comando = "svn checkout " + repositorio + dirSec + "/" + versionMod + "/" + dirArea + "/" + dirMod + " " +  dirArea + "/" + dirMod;
    } else {
      comando = "svn checkout " + repositorio + dirSec + "/" + "tronco/" + dirArea + "/" + dirMod + " " +  dirArea + "/" + dirMod;
    }
    var resComando = this.iface.ejecutarComando(comando);
    if (resComando.ok == false) {
      this.iface.pub_logAdd("Error checkout " + dirArea + "/" + dirMod);
      return false;
    }
    if (!this.iface.anadirTest(dirDestino1 + "/" + dirDestino2 + "/" + dirArea + "/" + dirMod, dirDestino1)) {
      return false;
    }
    this.iface.pub_logAdd("OK");
    sys.processEvents();
  }

  // debug("Borrando svn de " + this.iface.pathLocal + dirDestino1 + "/" + dirDestino2);
  var shell = "rm -rf $(find " + this.iface.pathLocal + dirDestino1 + "/" + dirDestino2 + " -name .svn)\n";

  File.write(this.iface.pathLocal + "delsvn.sh", shell);
  comando = "chmod 777 " + this.iface.pathLocal + "delsvn.sh";
  resComando = flmaveppal.iface.pub_ejecutarComando(comando);
  if (resComando.ok == false) {
    this.iface.pub_logAdd("Error al borrar los archivos ocultos de subversion en " + dirDestino1 + "/" + dirDestino2);
    return false;
  }

  comando = this.iface.pathLocal + "delsvn.sh ";
  resComando = flmaveppal.iface.pub_ejecutarComando(comando);
  if (resComando.ok == false) {
    this.iface.pub_logAdd("Error al borrar los archivos ocultos de subversion en " + dirDestino1 + "/" + dirDestino2);
    return false;
  }

  //  var resComando= this.iface.ejecutarComando("rm -rf .svn");
  //  if (resComando.ok == false) {
  //    this.iface.pub_logAdd("Error al borrar los archivos ocultos de subversion en " + dirDestino1 + "/" + dirDestino2);
  //    return false;
  //  }
  return true;
}

/** \D Concatena las pruebas de un directorio test al directorio test global del parche

@param  rutaDirTest: ruta al directorio donde obtener el parche, relativa al directorio de funcionalidades local
@param  codFuncional: Nombre de la funcionalidad (directorio) donde se concatenar�n las pruebas obtenidas (tambi�n puede ser un identificador de cliente)
@return True si no hay error, false en caso contrario
*/
function head_anadirTest(rutaDirTest: String, codFuncional: String)
{
  return true;
  /// Obsoleto
  rutaDirTestC = this.iface.pathLocal + rutaDirTest + "/test";
  if (!File.exists(rutaDirTestC))
    return true;
  var dirTestOrigen = new Dir(rutaDirTestC);
  var ficherosCsv = dirTestOrigen.entryList("*.csv");
  var contenido = "";
  var rutaFichDestino = "";
  var rutaFichOrigen = "";

  if (!File.exists(this.iface.pathLocal + codFuncional + "/test")) {
    var dirTest = new Dir(this.iface.pathLocal + codFuncional);
    dirTest.mkdir("test");
  }

  for (var i = 0; i < ficherosCsv.length; i++) {
    rutaFichDestino = this.iface.pathLocal + codFuncional + "/test/" + ficherosCsv[i];
    rutaFichOrigen = rutaDirTestC + "/" + ficherosCsv[i];
    if (File.exists(rutaFichDestino))
      contenido = File.read(rutaFichDestino);
    else
      contenido = "";
    contenido += File.read(rutaFichOrigen);
    File.write(rutaFichDestino, contenido);
  }
  return true;
}

/** \D Obtiene un parche del repositorio

@param  codFuncional: funcionalidad
@param  dirParche: directorio donde obtener el parche
@return True si no hay error, false en caso contrario
\end */
function head_checkoutParche(codFuncional: String, dirParche: String, versionBase: String)
{
  var util = new FLUtil;
  var comando: String;
  var resComando: Array;
  this.iface.pub_logAdd("Obteniendo parche " + codFuncional);

  Dir.current = flmaveppal.iface.pathLocal;
  if (File.exists(dirParche)) {
    resComando = this.iface.ejecutarComando("svn up " + dirParche);
    if (resComando.ok == false) {
      this.iface.pub_logAdd("Error al actualizar el directorio " + dirParche);
      return false;
    }
  } else {
    var codigoWeb = util.sqlSelect("mv_funcional", "codigoweb", "codfuncional = '" + codFuncional + "'");
    var repositorio: String;
    // debug("CO " + versionBase);
    // debug("versionBase = " + versionBase + ". this.iface.versionTronco_ = " + this.iface.versionTronco_);
    if (!versionBase || versionBase == this.iface.versionTronco_) {
      versionBase = "tronco";
    }
    // debug("CO2 " + versionBase);
    if (codigoWeb) {
      repositorio = this.iface.urlRepositorioWebFun;
    } else {
      repositorio = this.iface.urlRepositorioFun + versionBase + "/";
    }
    comando = "svn checkout " + repositorio + codFuncional + "/tronco/ " + dirParche;
    resComando = this.iface.ejecutarComando(comando);
    if (resComando.ok == false) {
      this.iface.pub_logAdd("Error en el checkout del parche " + codFuncional + " en " + dirParche);
      return false;
    }
  }

  this.iface.pub_logAdd("OK");
  sys.processEvents();
  return true;
}

function head_reemplazar(texto: String, antes: String, despues: String)
{
  var resultado = texto;
  while (resultado.find(antes) > 0) {
    resultado = resultado.replace(antes, despues);
  }
  return resultado;
}

function head_logAdd(txt)
{
  var _i = this.iface;
  if (!_i.pub_log) {
    debug(txt);
    return;
  }
  return sys.testAndRun(_i.pub_log, "log", "append", txt);
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////