/***************************************************************************
 flejemplos.qs
 -------------------
 begin                : 28/01/2011
 copyright            : (C) 2003-2011 by InfoSiAL S.L.
 email                : mail@infosial.com
 ***************************************************************************/
/***************************************************************************
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; version 2 of the License.               *
 ***************************************************************************/
/***************************************************************************
 Este  programa es software libre. Puede redistribuirlo y/o modificarlo
 bajo  los  términos  de  la  Licencia  Pública General de GNU   en  su
 versión 2, publicada  por  la  Free  Software Foundation.
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
  var ctx;

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
  const NEW_EXAMPLE = 0;
  const EDI_EXAMPLE = 1;
  const DEL_EXAMPLE = 2;
  const EXE_EXAMPLE = 3;
  const CHANGE_ICON = 4;

  var mw_;
  var icw_;
  var cur_;
  var item_;

  var exId_ = function(i)
  {
    if (i == undefined)
      i = item_;
    else if ((typeof i) == "string")
      return String("idexample='%1'").arg(i);
    return String("idexample='%1'").arg(i.text());
  }
  var setCurItem_ = function()
  {
    var item = icw_.currentItem();
    if (!item || item.isValid != true)
      return false;
    item_ = item;
    return true;
  }
  var scrName_ = function(idExample, idScript)
  {
    var regx = /\.|\.qs/g;
    idExample = idExample.replace(regx, "");
    idScript = idScript.replace(regx, "");
    idExample = idExample.charAt(0).upper() +
                idExample.lower().mid(1);
    idScript = idScript.charAt(0).upper() +
               idScript.lower().mid(1);
    return "example" + idExample + idScript;
  }

  function oficial(context)
  {
    interna(context);
  }
  function init()
  {
    this.ctx.oficial_init();
  }
  function initWorkspace()
  {
    this.ctx.oficial_initWorkspace();
  }
  function eventFilter(o, e)
  {
    return this.ctx.oficial_eventFilter(o, e);
  }
  function doAction(type)
  {
    this.ctx.oficial_doAction(type);
  }
  function editScript(id)
  {
    this.ctx.oficial_editScript(id);
  }
  function saveScript(scrName)
  {
    this.ctx.oficial_saveScript(scrName);
  }
  function evaluateCode(idExample)
  {
    return this.ctx.oficial_evaluateCode(idExample);
  }
  function refreshIconView(clear)
  {
    this.ctx.oficial_refreshIconView(clear);
  }
  function refreshDescAndDoc()
  {
    this.ctx.oficial_refreshDescAndDoc();
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
  function pub_eventFilter(o, e)
  {
    return this.eventFilter(o, e);
  }
}

const iface = new ifaceCtx(this);
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/** @class_definition interna */
//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_init()
{
  var _i = this.iface;

  if (QSProject.entryFunction != "flejemplos.iface.init") {
    AQSql.update("ex_examples", ["runoninit"], [false]);
    AQSql.update("ex_scripts", ["editoninit"], [false]);
  }

  sys.AQTimer.singleShot(0, _i.initWorkspace)
}

function oficial_initWorkspace()
{
  var _i = this.iface;

  var mw = _i.mw_ = sys.modMainWidget(this.name);
  mw.eventFilterFunction = "flejemplos.iface.pub_eventFilter";
  mw.allowedEvents = [ AQS.ContextMenu, AQS.MouseButtonDblClick ];

  var icw = _i.icw_ = mw.child("icwExamples");
  icw.spacing = 20;
  connect(icw, "selectionChanged()", _i, "refreshDescAndDoc()");

  _i.cur_ = new AQSqlCursor("ex_examples");
  _i.refreshIconView();
  if (icw.count > 0)
    icw.setSelected(icw.firstItem(), true);

  var cur = _i.cur_;
  if (cur.select("runoninit=true") && cur.first()) {
    var scrName = _i.scrName_(cur.valueBuffer("idexample"), "main");
    cur.setModeAccess(AQSql.Edit);
    cur.refreshBuffer();
    cur.setValueBuffer("runoninit", false);
    cur.commitBuffer();
    mw.child(scrName).main();
  }
  cur.select("");

  cur = new AQSqlCursor("ex_scripts");
  if (cur.select("editoninit=true") && cur.first()) {
    var id = cur.valueBuffer("idserial");
    cur.setModeAccess(AQSql.Edit);
    cur.refreshBuffer();
    cur.setValueBuffer("editoninit", false);
    cur.commitBuffer();
    _i.editScript(id);
  }

  icw.installEventFilter(mw);
  connect(_i.cur_, "bufferCommited()", _i, "refreshDescAndDoc()");
}

function oficial_eventFilter(o, e)
{
  var _i = this.iface;

  switch (o.name) {
      // icwExamples Handle events
    case "icwExamples": {
      switch (e.type) {
        case AQS.ContextMenu: {
          var item = _i.icw_.findItem(e.eventData.pos);
          var popMenu = new QPopupMenu;

          popMenu.insertItem("Nuevo ejemplo", _i.NEW_EXAMPLE);
          if (item.isValid == true) {
            popMenu.insertItem("Editar ejemplo", _i.EDI_EXAMPLE);
            popMenu.insertItem("Eliminar ejemplo", _i.DEL_EXAMPLE);
            popMenu.insertItem("Cambiar icono", _i.CHANGE_ICON);

            var qry = new AQSqlQuery;
            qry.setSelect("idscript,idserial");
            qry.setFrom("ex_scripts");
            qry.setWhere(_i.exId_(item));

            var subMenu;
            if (qry.exec() && qry.size() > 0) {
              subMenu = new QPopupMenu(popMenu);
              while (qry.next())
                subMenu.insertItem(qry.value(0), qry.value(1));
            }

            if (subMenu != undefined) {
              popMenu.insertSeparator();
              popMenu.insertItem("Editar script", subMenu);
              popMenu.insertItem("Ejecutar ejemplo", _i.EXE_EXAMPLE);
              subMenu.checkable = false;
              connect(subMenu, "activated(int)", _i, "editScript()");
            }
          }

          popMenu.checkable = false;
          connect(popMenu, "activated(int)", _i, "doAction()");
          popMenu.exec(e.eventData.globalPos);
          return true;
        }

        case AQS.MouseButtonDblClick: {
          var item = _i.icw_.findItem(e.eventData.pos);
          if (item.isValid != true)
            return false;
          _i.doAction(_i.EDI_EXAMPLE);
          return true;
        }
      }
      break;
    }
    // END icwExamples Handle events
  }

  return false;
}

function oficial_doAction(type)
{
  var _i = this.iface;

  switch (type) {
    case _i.NEW_EXAMPLE: {
      var id = Input.getText("Identificador", undefined, "AbanQ");
      if (id && AQSql.insert(_i.cur_, ["idexample"], [id])) {
        _i.refreshIconView();
      }
      break;
    }

    case _i.EDI_EXAMPLE: {
      if (!_i.setCurItem_())
        break;
      var cur = _i.cur_;
      sys.AQTimer.singleShot(0, function() {
        if (cur.select(_i.exId_()) && cur.first())
          cur.editRecord();
      });
      break;
    }

    case _i.DEL_EXAMPLE: {
      if (!_i.setCurItem_())
        break;
      if (MessageBox.No == MessageBox.warning("¿Eliminar ejemplo?",
                                              MessageBox.No, MessageBox.Yes,
                                              MessageBox.NoButton, "AbanQ"))
        break;
      if (AQSql.del(_i.cur_, _i.exId_())) {
        _i.icw_.removeCurrentItem();
      }
      break;
    }

    case _i.EXE_EXAMPLE: {
      if (!_i.setCurItem_())
        break;

      AQSql.update(_i.cur_, ["runoninit"], [true], _i.exId_());

      var idExample = _i.item_.text();
      if (!_i.evaluateCode(idExample)) {
        AQSql.update(_i.cur_, ["runoninit"], [false], _i.exId_());

        var scrName = _i.scrName_(idExample, "main");
        if (QSProject.object(scrName) == undefined)
          break;

        var funMain = QSProject.object(scrName).main;
        if ((typeof funMain) == "function")
          funMain();
      }
      break;
    }

    case _i.CHANGE_ICON: {
      if (!_i.setCurItem_())
        break;
      var icon = new QPixmap(sys.dialogGetFileImage());
      if (!icon.isNull()) {
        var ba = new QByteArray;
        var bu = new QBuffer(ba);
        bu.open(File.WriteOnly);
        icon.save(bu, "PNG");
        bu.close();
        if (AQSql.update(_i.cur_, ["icon"], [ba], _i.exId_()))
          _i.item_.setPixmap(icon);
      }
      break;
    }

    default :
      debug(String("Accion %1 todavia no implementada").arg(type));
      break;
  }
}

function oficial_editScript(id)
{
  var _i = this.iface;

  var qry = new AQSqlQuery;
  qry.setSelect("idobject,idexample");
  qry.setFrom("ex_scripts");
  qry.setWhere("idserial=" + id);

  if (!qry.exec() || !qry.next())
    return;

  var scr = QSProject.script(qry.value(0));
  if (!scr) {
    AQSql.update("ex_scripts", ["editoninit"], [true], "idserial=" + id);
    if (!_i.evaluateCode(qry.value(1)))
      AQSql.update("ex_scripts", ["editoninit"], [false], "idserial=" + id);
    return;
  }

  var wb = QSProject.workbench();
  wb.open();
  wb.showScript(scr);
}

function oficial_saveScript(scrName)
{
  var _i = this.iface;

  var scr = QSProject.script(scrName);
  if (!scr)
    return;
  AQSql.update("ex_scripts", ["code"], [scr.code()],
               "idobject='" + scrName + "'");
  _i.init();
}

function oficial_evaluateCode(idExample)
{
  var _i = this.iface;

  var qry = new AQSqlQuery;
  qry.setSelect("idscript,code,idserial");
  qry.setFrom("ex_scripts");
  qry.setWhere(_i.exId_(idExample));

  if (!qry.exec() || !qry.size() > 0)
    return false;

  var scriptInfos = [];
  var scrFileName = "#flejemplos.iface.saveScript@%1";
  while (qry.next()) {
    var scrName = _i.scrName_(idExample, qry.value(0));
    var scrCode = qry.value(1);
    var scr = QSProject.script(scrName);

    AQSql.update("ex_scripts", ["idobject"], [scrName],
                 "idserial='" + qry.value(2) + "'");

    if (!scr) {
      scriptInfos.push([scrName, scrCode, QSProject.New,
                        scrFileName.arg(scrName)]);
      continue;
    }
    if (scr.code() != scrCode)
      scriptInfos.push([scrName, scrCode, QSProject.Changed,
                        scrFileName.arg(scrName)]);
  }

  if (scriptInfos.length > 0) {
    for (var i = 0; i < scriptInfos.length; ++i) {
      var scrInfo = scriptInfos[i];
      if (scrInfo[2] == QSProject.New)
        QSProject.addObject(new QObject(_i.mw_, scrInfo[0]));
    }
    QSProject.evaluateScripts(scriptInfos, "flejemplos.iface.init");
    return true;
  }

  return false;
}

function oficial_refreshIconView(clear)
{
  var _i = this.iface;

  if (clear)
    _i.icw_.clear();

  var qry = new AQSqlQuery;
  qry.setSelect("idexample,icon");
  qry.setFrom("ex_examples");

  if (qry.exec()) {
    while (qry.next()) {
      var id = qry.value(0);
      var item = _i.icw_.findItem(id);
      if (item.isValid == true)
        continue;
      var ba = new QByteArray(qry.value(1));
      var icon = new QPixmap(ba);
      if (!icon.isNull())
        item = new QIconViewItem(_i.icw_, id, icon);
      else
        item = new QIconViewItem(_i.icw_, id);
    }
  }
}

function oficial_refreshDescAndDoc()
{
  var _i = this.iface;

  if (!_i.setCurItem_())
    return;

  var cur = _i.cur_;
  sys.AQTimer.singleShot(0, function() {
    if (cur.select(_i.exId_()) && cur.first()) {
      _i.mw_.child("ledDesc").text = cur.valueBuffer("description");
      _i.mw_.child("tedDoc").text = cur.valueBuffer("doc");
    }
  });
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
