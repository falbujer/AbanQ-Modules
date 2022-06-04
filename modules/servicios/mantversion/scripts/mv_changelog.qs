/***************************************************************************
                 mv_changelog.qs  -  description
                             -------------------
    begin                : jue ene 31 2008
    copyright            : (C) 2008 by InfoSiAL S.L.
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
  function validateForm(): Boolean { return this.ctx.interna_validateForm(); }
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
  if (cursorPadre) {
    if (cursorPadre.action() == "mv_funcional" || cursorPadre.action() == "mv_proyectos") {
      this.child("fdbIdModulo").close();
      this.child("fdbDescModulo").close();
      this.child("fdbIdVersionModFun").setFilter("codfuncional = '" + cursor.valueBuffer("codfuncional") + "'");
    }
    if (cursorPadre.action() == "mv_modulos") {
      this.child("fdbCodFuncional").close();
      this.child("fdbDescFuncional").close();
      this.child("fdbIdVersionModFun").setFilter("idmodulo = '" + cursor.valueBuffer("idmodulo") + "'");
    }
  }
}

function interna_validateForm(): Boolean {
  var util: FLUtil = new FLUtil();
  var cursor: FLSqlCursor = this.cursor();

  var modulo: String = cursor.valueBuffer("idmodulo");
  var funcional: String = cursor.valueBuffer("codfuncional");

  if ((!modulo || modulo == "") && (!funcional || funcional == ""))
  {
    MessageBox.warning(util.translate("scripts", "Debe establecer el m�dulo o la funcionalidad"), MessageBox.Ok, MessageBox.NoButton);
    return false;
  }

  return true;
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

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////