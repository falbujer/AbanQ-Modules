/***************************************************************************
                 mv_modulos.qs  -  description
                             -------------------
    begin                : jue sep 09 2010
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
    return this.ctx.interna_init();
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
  function filtrarCambios()
  {
    return this.ctx.oficial_filtrarCambios();
  }
  function dameFiltroCambios(): String {
    return this.ctx.oficial_dameFiltroCambios();
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

  connect(this.child("tdbVersionesModFun").cursor(), "newBuffer()", this, "iface.filtrarCambios");
  connect(this.child("tdbChangeLog").cursor(), "bufferCommited()", this.child("tdbVersionesModFun"), "refresh()");
  this.iface.filtrarCambios();
}

function interna_validateForm(): Boolean {
  var util: FLUtil = new FLUtil();
  var cursor: FLSqlCursor = this.cursor();

  return true;
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_filtrarCambios()
{
  var filtro: String = this.iface.dameFiltroCambios();
  this.child("tdbChangeLog").setFilter(filtro);
  this.child("tdbChangeLog").refresh();
}

function oficial_dameFiltroCambios(): String {
  var filtro: String = "";

  var curVersionMF: FLSqlCursor = this.child("tdbVersionesModFun").cursor();
  var idVersionMF: String = curVersionMF.valueBuffer("idversionmodfun");
  if (idVersionMF)
  {
    filtro = "idversionmodfun = " + idVersionMF;
  }
  return filtro;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////