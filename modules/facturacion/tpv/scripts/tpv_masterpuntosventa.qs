/***************************************************************************
                 tpv_masterpuntosventa.qs  -  description
                             -------------------
    begin                : lun nov 14 2005
    copyright            : Por ahora (C) 2005 by InfoSiAL S.L.
    email                : lveb@telefonica.net
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
  var lblPVentaActual;
  function oficial(context)
  {
    interna(context);
  }
  function actualizarPuntoVentaActual()
  {
    return this.ctx.oficial_actualizarPuntoVentaActual();
  }
  function cambiarPuntoVenta()
  {
    return this.ctx.oficial_cambiarPuntoVenta();
  }
  function tbnBorrarPVLocal_clicked()
  {
    return this.ctx.oficial_tbnBorrarPVLocal_clicked();
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
/** \C
En el formulario maestro se muestra el punto de venta establecido como local que saldrá por defecto en las comandas y arqueos
El botón cambiar permite cambiar el punto de venta local
*/
function interna_init()
{
	var _i = this.iface;
  _i.lblPVentaActual = this.child("lblPVentaActual");
  connect(this.child("pbnCambiar"), "clicked()", _i, "cambiarPuntoVenta()");
	connect(this.child("tbnBorrarPVLocal"), "clicked()", _i, "tbnBorrarPVLocal_clicked()");
	
  _i.actualizarPuntoVentaActual();
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D
Cambia el punto de venta local por el punto de venta seleccionado en ese momento
*/
function oficial_cambiarPuntoVenta()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
  var valor = cursor.valueBuffer("codtpv_puntoventa");
  AQUtil.writeSettingEntry("scripts/fltpv_ppal/codTerminal", valor);
  _i.actualizarPuntoVentaActual();
	
	if(formtpv_comandas.iface.masterComandasCargada_){
		formtpv_comandas.iface.pub_valoresLocales();
	}
}

function oficial_tbnBorrarPVLocal_clicked()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
  AQUtil.writeSettingEntry("scripts/fltpv_ppal/codTerminal", false);
  _i.actualizarPuntoVentaActual();
	
	if(formtpv_comandas.iface.masterComandasCargada_){
		formtpv_comandas.iface.pub_valoresLocales();
	}
}

/** \D
Muestra el codigo y descripcion del punto de venta local
*/
function oficial_actualizarPuntoVentaActual()
{
	var _i = this.iface;
	var t = sys.translate("Punto de venta local NO ESTABLECIDO");
  var codTerminal = flfact_tpv.iface.pub_valorDefectoTPV("codterminal");
  if (codTerminal) {
		var descripcion = AQUtil.sqlSelect("tpv_puntosventa", "descripcion", "codtpv_puntoventa = '" + codTerminal + "'");
		if (descripcion) {
			t = codTerminal + " - " + descripcion;
		}
	}
  _i.lblPVentaActual.text = t;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
