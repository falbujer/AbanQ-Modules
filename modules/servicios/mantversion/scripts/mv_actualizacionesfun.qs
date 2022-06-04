/***************************************************************************
                 mv_actualizacionesfun.qs  -  description
                             -------------------
    begin                : vie sep 10 2010
    copyright            : (C) 2010 by InfoSiAL S.L.
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
  const DIR_PROJECTS = "/media/volume01_no_raid/updater_projects/";

  var pbGenDir_;

  function oficial(context)
  {
    interna(context);
  }
  function init()
  {
    this.ctx.oficial_init();
  }
  function validarRevision()
  {
    return this.ctx.oficial_validarRevision();
  }
  function genProjectUpdateDir(codFuncional)
  {
    return this.ctx.oficial_genProjectUpdateDir(codFuncional);
  }
  function genDownloadDir()
  {
    return this.ctx.oficial_genDownloadDir();
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
  var cursor: FLSqlCursor = this.cursor();
  var cursorPadre: FLSqlCursor = cursor.cursorRelation();
  switch (cursor.modeAccess()) {
    case cursor.Insert: {
      if (cursorPadre) {
        this.child("fdbVersionDesde").setValue(cursorPadre.valueBuffer("versionbase"));
      }
      var idUsuario: String = sys.nameUser();
      this.child("fdbIdUsuario").setValue(idUsuario);
      break;
    }
  }
}

function interna_validateForm()
{
  var _i = this.iface;

  if (!_i.validarRevision()) {
    return false;
  }
  return true;
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_init()
{
  var _i = this.iface;

  _i.__init();

  var modeAcc = this.cursor().modeAccess();

  _i.pbGenDir_ = this.child("pbGenDir");
  if (modeAcc == AQSql.Edit || modeAcc == AQSql.Insert)
    connect(_i.pbGenDir_, "clicked()", _i, "genDownloadDir()");
  else if (_i.pbGenDir_)
    _i.pbGenDir_.enabled = false;
}

function oficial_validarRevision()
{
  var cursor = this.cursor();
  if (!cursor.valueBuffer("esrevision")) {
    return true;
  }
  var vDesde = cursor.valueBuffer("versiondesde");
  var vHasta = cursor.valueBuffer("versionhasta");
  if (vDesde != vHasta) {
    MessageBox.warning(sys.translate("En las revisiones, la versión inicial y final deben coincidir"),
                       MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
    return false;
  }
  return true;
}

function oficial_genProjectUpdateDir(codFuncional)
{
  var _i = this.iface;

  var proName = AQUtil.sqlSelect("mv_funcional", "nombreproyecto",
                                 "codfuncional = '" + codFuncional + "'");
  if (!proName || proName.isEmpty()) {
    flmaveppal.iface.pub_logAdd("Debe establecer el nombre del proyecto donde generar el directorio 'modulos'");
    return "";
  }

  var dirProjects = _i.DIR_PROJECTS;
  var oldDirProjects = flmaveppal.iface.pub_obtenerPathLocal();

  AQUtil.writeSettingEntry("scripts/flmaveppal/pathlocal", dirProjects);
  flmaveppal.iface.pathLocal = dirProjects;

  formmv_proyectos.iface.pathLocal = flmaveppal.iface.pub_obtenerPathLocal();
  flmaveppal.iface.cargarCodificacionLocal();
  formmv_proyectos.iface.urlRepositorioMod = flmaveppal.iface.pub_obtenerUrlRepositorioMod();
  formmv_proyectos.iface.urlRepositorioFun = flmaveppal.iface.pub_obtenerUrlRepositorioFun();
  flmaveppal.iface.pub_obtenerVersionTronco();

  var dirBase = dirProjects + proName;

  formmv_proyectos.iface.pub_bajarPro(codFuncional);

  AQUtil.writeSettingEntry("scripts/flmaveppal/pathlocal", oldDirProjects);
  flmaveppal.iface.pathLocal = oldDirProjects;

  var revision = "";
  var dirBaseRev = "";

  try {
    Process.execute(["svnversion", "-n", dirBase + "/temp"]);
    revision = Process.stdout;
    File.write(dirBase + "/REVISION", revision);
    dirBaseRev = dirBase + "_" + revision;
    Process.execute(["rm", "-fr", dirBaseRev]);
    Process.execute(["mv", "-f", dirBase, dirBaseRev]);
  } catch (e) {
    flmaveppal.iface.pub_logAdd("" + e);
  }

  if (revision.isEmpty() || dirBaseRev.isEmpty())
    return "";

  var packageName = proName + "_pack_" + revision;
  var absPack = dirBaseRev + "/" + packageName;
  var packager = new AQPackager(absPack);

  var okPack = packager.pack(dirBaseRev + "/modulos", false);
  var logs = packager.logMessages();
  if (logs.length != 0) {
    var msg = "\n";
    for (var i = 0; i < logs.length; ++i)
      msg += logs[i];
    flmaveppal.iface.pub_logAdd(msg);
  }
  if (!okPack) {
    var errors = packager.errorMessages();
    if (errors.length != 0) {
      var msg = sys.translate(
                  "Hubo los siguientes errores al intentar empaquetar los módulos:"
                );
      msg += "\n";
      for (var i = 0; i < errors.length; ++i)
        msg += errors[i] + "\n";
      flmaveppal.iface.pub_logAdd(msg);
      return "";
    }
  }

  try {
    Process.execute(["mv", "-f", absPack + "/modules.def", dirBaseRev]);
    Process.execute(["mv", "-f", absPack + "/files.def", dirBaseRev]);
    Process.execute(["rm", "-fr", absPack]);
    Process.execute(["rm", "-fr", absPack + ".abanq"]);
    Process.execute(["rm", "-fr", dirBaseRev + "/config"]);
    Process.execute(["rm", "-fr", dirBaseRev + "/doc"]);
    Process.execute(["rm", "-fr", dirBaseRev + "/temp"]);
    Process.execute(["chmod", "ugo+rw", "-R", dirBaseRev]);
  } catch (e) {
    flmaveppal.iface.pub_logAdd("" + e);
    return "";
  }

  return dirBaseRev;
}

function oficial_genDownloadDir()
{
  var _i = this.iface;

  var cur = this.cursor();
  var ok = true;

  this.setDisabled(true);
  flmaveppal.iface.pub_log = this;

  var dirBaseRev = _i.genProjectUpdateDir(cur.valueBuffer("codfuncional"));
  ok = !dirBaseRev.isEmpty();

  if (ok)
    cur.setValueBuffer("nombreupdate", dirBaseRev);

  if (ok) {
    var file = new QFile(dirBaseRev + "/modules.def");
    if (!file.open(File.ReadOnly)) {
      flmaveppal.iface.pub_logAdd(file.errorString());
      ok = false;
    }
    if (ok) {
      var ts = new QTextStream(file.ioDevice());
      ts.setEncoding(AQS.UnicodeUTF8);
      var cnt = ts.read();
      cur.setValueBuffer("modulesdef", sys.toUnicode(cnt, "utf8"));
    }
  }

  if (ok) {
    var file = new QFile(dirBaseRev + "/files.def");
    if (!file.open(File.ReadOnly)) {
      flmaveppal.iface.pub_logAdd(file.errorString());
      ok = false;
    }
    if (ok) {
      var ts = new QTextStream(file.ioDevice());
      ts.setEncoding(AQS.UnicodeUTF8);
      var cnt = ts.read();
      cur.setValueBuffer("filesdef", sys.toUnicode(cnt, "utf8"));
    }
  }

  if (ok) {
    var now = new Date;
    cur.setValueBuffer("fechaupdate", now);
    cur.setValueBuffer("horaupdate", now.toString().right(8));
  }

  flmaveppal.iface.pub_log = undefined;
  this.setDisabled(false);

  if (!ok)
    sys.errorMsgBox(sys.translate("Error al generar el directorio para descarga"));
  return ok;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
