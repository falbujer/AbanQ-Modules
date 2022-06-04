/***************************************************************************
                 mv_funcional.qs  -  description
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
  function validateForm(): Boolean {
    return this.ctx.interna_validateForm();
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
  function bufferChanged(fN: String)
  {
    return this.ctx.oficial_bufferChanged(fN);
  }
  function filtrarCambios()
  {
    return this.ctx.oficial_filtrarCambios();
  }
  function dameFiltroCambios(): String {
    return this.ctx.oficial_dameFiltroCambios();
  }
  function descargarDoc()
  {
    return this.ctx.oficial_descargarDoc();
  }
  function rutaDoc(): String {
    return this.ctx.oficial_rutaDoc();
  }
  function habilitarPorProyecto()
  {
    return this.ctx.oficial_habilitarPorProyecto();
  }
  function actualizarVersionForm()
  {
    return this.ctx.oficial_actualizarVersionForm();
  }
  function tbnActualizarVer_clicked()
  {
    return this.ctx.oficial_tbnActualizarVer_clicked();
  }
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends oficial
{
  function head(context)
  {
    oficial(context);
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
  var _i = this.iface;
  var cursor = this.cursor();

  //  var campos:Array = ["codfuncional","version","fecha","cambios","publico","idmodulo"]
  //  this.child("tdbChangeLog").setOrderCols(campos);

  connect(this.child("tdbActualizacionesFun").cursor(), "newBuffer()", _i, "filtrarCambios");
  connect(this.child("tdbActualizacionesFun").cursor(), "bufferCommited()", _i, "actualizarVersionForm");
  connect(this.cursor(), "bufferChanged(QString)", _i, "bufferChanged");
  connect(this.child("tbnActualizarVer"), "clicked()", _i, "tbnActualizarVer_clicked");

  // Gestión documental
  if (sys.isLoadedModule("flcolagedo")) {
    var datosGD: Array;
    datosGD["txtRaiz"] = cursor.valueBuffer("codfuncional") + ": " + cursor.valueBuffer("desccorta");
    datosGD["tipoRaiz"] = "mv_funcional";
    datosGD["idRaiz"] = cursor.valueBuffer("codfuncional");
    flcolagedo.iface.pub_gestionDocumentalOn(this, datosGD);

    this.child("txtRuta").text = _i.rutaDoc();
    this.child("txtRuta").setDisabled(true);
    connect(this.child("pbnDescargar"), "clicked()", this, "iface.descargarDoc()");

  } else {
    this.child("tbwFuncional").setTabEnabled("gesdocu", false);
  }
  this.child("fdbVersion").close();
  _i.habilitarPorProyecto();

}

/** \C La --version-- siempre debe tener por prefijo --versionmodulos--
\end */
function interna_validateForm(): Boolean {
  var util: FLUtil = new FLUtil();

  var version: String = this.child("fdbVersion").value();
  var versionModulos: String = this.child("fdbVersionModulos").value();

  if (version.find(versionModulos) != 0)
  {
    MessageBox.critical
    (util.translate("scripts", "La versión de la extensión debe tener como prefijo\nla versión mínima de los módulos"),
    MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
    return false;
  }

  return true;
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_tbnActualizarVer_clicked()
{
  var cursor = this.cursor();
  var vB = cursor.valueBuffer("versionbase");

  var res = MessageBox.warning(sys.translate("Vas a pasar todos los módulos y dependencias a la versión %1.\n¿Estás seguro?").arg(vB), MessageBox.Yes, MessageBox.No, MessageBox.NoButton, "AbanQ");
  if (res != MessageBox.Yes) {
    return;
  }

  var codFuncional = cursor.valueBuffer("codfuncional");
  if (!AQSql.update("mv_modulosfun", ["version"], [""], "codfuncional = '" + codFuncional + "'")) {
    return;
  }
  this.child("tdbModulos").refresh();
  if (!AQSql.update("mv_dependencias", ["version"], [""], "codhijo = '" + codFuncional + "'")) {
    return;
  }
  this.child("tdbDependencias").refresh();
}

function oficial_filtrarCambios()
{
  var filtro: String = this.iface.dameFiltroCambios();
  this.child("tdbCambiosActualizacion").setFilter(filtro);
  this.child("tdbCambiosActualizacion").refresh();
}

function oficial_dameFiltroCambios(): String {
  var filtro: String = "";

  var curActualizacion: FLSqlCursor = this.child("tdbActualizacionesFun").cursor();
  var idActualizacion: String = curActualizacion.valueBuffer("idactualizacion");
  if (idActualizacion)
  {
    filtro = "idactualizacion = " + idActualizacion;
  }
  return filtro;
}

function oficial_bufferChanged(fN: String)
{
  var cursor: FLSqlCursor = this.cursor();
  switch (fN) {
    case "versionmodulos": {
      /** \C Al cambiar la --versionmodulos-- la --version-- será igual
      \end */
      this.child("fdbVersion").setValue(this.child("fdbVersionModulos").value());
      break;
    }
    case "proyecto": {
      if (!cursor.valueBuffer("proyecto")) {
        this.child("fdbVersionBase").setValue("");
      }
      this.iface.habilitarPorProyecto();
      break;
    }
  }
}

function oficial_descargarDoc()
{
  var util: FLUtil = new FLUtil;
  var cursor: FLSqlCursor = this.cursor();
  var codigo = cursor.valueBuffer("codFuncional");

  var pathFichero: String = this.child("txtRuta").text;
  if (!File.exists(pathFichero)) {
    MessageBox.critical
    (util.translate("scripts", "No existe la ruta a los documentos. Debes establecerla\nen el módulo de gestión documental"),
     MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
    return false;
  }

  var dir = new Dir(pathFichero);
  if (!dir.fileExists("doc"))
    dir.mkdir("doc");

  if (!dir.fileExists("cap"))
    dir.mkdir("cap");

  var q: FLSqlQuery = new FLSqlQuery();
  q.setTablesList("gd_documentos");
  q.setFrom("gd_documentos")
  q.setSelect("codigo");

  q.setWhere("codigo like 'doc_" + codigo + "%'");
  if (!q.exec())
    return;

  var paso: Number = 0;
  util.createProgressDialog(util.translate("scripts", "Descargando documentos..."), q.size());

  while (q.next()) {
    util.setProgress(paso++);
    if (!flcolagedo.iface.pub_obtenerDocumento(q.value(0), pathFichero + "/doc/" + q.value(0) + ".odt"))
      continue;
  }

  util.destroyProgressDialog();


  q.setWhere("codigo like 'cap_" + codigo + "%'");
  if (!q.exec())
    return;

  util.createProgressDialog(util.translate("scripts", "Descargando capturas..."), q.size());

  while (q.next()) {
    util.setProgress(paso++);
    if (!flcolagedo.iface.pub_obtenerDocumento(q.value(0), pathFichero + "/cap/" + q.value(0) + ".png"))
      continue;
  }

  util.destroyProgressDialog();

  MessageBox.information(util.translate("scripts", "Se descargaron los documentos"), MessageBox.Ok, MessageBox.NoButton);
}

function oficial_rutaDoc(): String {
  var util: FLUtil = new FLUtil;
  return util.readSettingEntry("scripts/flcolagedo/dirLocal");
}

function oficial_habilitarPorProyecto()
{
  var cursor: FLSqlCursor = this.cursor();
  if (cursor.valueBuffer("proyecto")) {
    this.child("fdbVersionBase").setDisabled(false);
    //    this.child("tbwFuncional").setTabEnabled("changelog", false);
    this.child("tbwFuncional").setTabEnabled("actualizaciones", true);
    this.child("tbnActualizarVer").enabled = true;
  } else {
    this.child("fdbVersionBase").setDisabled(true);
    //    this.child("tbwFuncional").setTabEnabled("changelog", true);
    this.child("tbwFuncional").setTabEnabled("actualizaciones", false);
    this.child("tbnActualizarVer").enabled = false;
  }
}

function oficial_actualizarVersionForm()
{
  var util: FLUtil = new FLUtil;
  var cursor: FLSqlCursor = this.cursor();
  var codFuncional: String = cursor.valueBuffer("codfuncional");

  this.child("tdbCambiosActualizacion").refresh();
  var maxVersion: String = util.sqlSelect("mv_actualizacionesfun", "versionhasta", "codfuncional = '" + codFuncional + "' AND disponible ORDER BY fecha DESC, idactualizacion DESC");
  if (!maxVersion) {
    return;
  }
  this.child("fdbVersionBase").setValue(maxVersion);

}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////