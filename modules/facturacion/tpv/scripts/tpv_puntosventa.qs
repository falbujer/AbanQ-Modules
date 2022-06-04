/***************************************************************************
                 tpv_puntosventa.qs  -  description
                             -------------------
    begin                : vie jun 02 2006
    copyright            : Por ahora (C) 2006 by InfoSiAL S.L.
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
  function oficial(context)
  {
    interna(context);
  }
  function bufferChanged(fN: String)
  {
    return this.ctx.oficial_bufferChanged(fN);
  }
  function establecerValoresDefecto()
  {
    return this.ctx.oficial_establecerValoresDefecto();
  }
  function habilitarVisor()
  {
    return this.ctx.oficial_habilitarVisor();
  }
  function habilitarTermica()
  {
    return this.ctx.oficial_habilitarTermica();
  }
  function tbnTestCajon_clicked()
  {
    return this.ctx.oficial_tbnTestCajon_clicked();
  }
  function tbnTestLogo_clicked()
  {
    return this.ctx.oficial_tbnTestLogo_clicked();
  }
  function tbnTestCortar_clicked()
  {
    return this.ctx.oficial_tbnTestCortar_clicked();
  }
  function tbnTestBarcode_clicked()
  {
    return this.ctx.oficial_tbnTestBarcode_clicked();
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
  connect(cursor, "bufferChanged(QString)", _i, "bufferChanged");
  connect(this.child("pbnEstablecerValores"), "clicked()", _i, "establecerValoresDefecto()");
  
  connect(this.child("tbnTestCajon"), "clicked()", _i, "tbnTestCajon_clicked");
  connect(this.child("tbnTestLogo"), "clicked()", _i, "tbnTestLogo_clicked");
  connect(this.child("tbnTestCortar"), "clicked()", _i, "tbnTestCortar_clicked");
  connect(this.child("tbnTestBarcode"), "clicked()", _i, "tbnTestBarcode_clicked");

  _i.habilitarVisor();
  _i.habilitarTermica();
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////


function oficial_establecerValoresDefecto()
{
  var cursor = this.cursor();
  var util = new FLUtil();

  var res = MessageBox.information(
              util.translate("scripts", 
                             "Va a establecer los campos a sus valores por defecto.\n¿Está seguro?"),
              MessageBox.Yes, MessageBox.No
            );
  if (res != MessageBox.Yes) {
    return false;
  } else {
    cursor.setValueBuffer("baudratevisor", "9600");
    cursor.setValueBuffer("bitdatosvisor", "8");
    cursor.setValueBuffer("paridadvisor", "Sin paridad");
    cursor.setValueBuffer("bitstopvisor", "1");
    cursor.setValueBuffer("flowcontrol", "FLOW_OFF");
    cursor.setValueBuffer("iniciarvisor", "27,64");
    cursor.setValueBuffer("limpiarvisor", "12");
    cursor.setValueBuffer("prefprimeralinea", "27,81,65");
    cursor.setValueBuffer("sufprimeralinea", "13");
    cursor.setValueBuffer("prefsegundalinea", "27,81,66");
    cursor.setValueBuffer("sufsegundalinea", "13");
  }
}

function oficial_habilitarVisor()
{
  var cursor = this.cursor();
  if (cursor.valueBuffer("usarvisor") == false) {
    this.child("gbxVisor").setDisabled(true);
  } else {
    this.child("gbxVisor").setDisabled(false);
  }
}

function oficial_bufferChanged(fN: String)
{
  switch (fN) {
    case "valoresdefecto": {
      this.iface.establecerValoresDefecto();
      break;
    }
    case "usarvisor": {
      this.iface.habilitarVisor();
      break;
    }
    case "tipoimpresora": {
      this.iface.habilitarTermica();
      break;
    }
  }
}

function oficial_habilitarTermica()
{
  var cursor = this.cursor();
  if (cursor.valueBuffer("tipoimpresora") == "Térmica") {
    this.child("gbxTermica").setEnabled(true);
  } else {
    this.child("gbxTermica").setEnabled(false);
  }
}

function oficial_tbnTestCajon_clicked()
{
  var cursor = this.cursor();
  var printer = new FLPosPrinter();
  printer.setPrinterName(cursor.valueBuffer("impresora"));
  printer.send("ESC:" + cursor.valueBuffer("abrircajon"));
  printer.flush();
}

function oficial_tbnTestLogo_clicked()
{
  var cursor = this.cursor();
  var printer = new FLPosPrinter();
  printer.setPrinterName(cursor.valueBuffer("impresora"));
  printer.send("ESC:" + cursor.valueBuffer("esclogo"));  
printer.send("ESC:1B,64,05"); /// 5 líneas
  printer.flush();
}

function oficial_tbnTestCortar_clicked()
{
  var cursor = this.cursor();
  var printer = new FLPosPrinter();
  printer.setPrinterName(cursor.valueBuffer("impresora"));
  printer.send("ESC:" + cursor.valueBuffer("esccortarpapel"));
  printer.flush();
}

function oficial_tbnTestBarcode_clicked()
{
	var _i = this.iface;
  var cursor = this.cursor();
  var printer = new FLPosPrinter();
  var barcode = Input.getText(sys.translate("Código de barras"));
  if (!barcode) {
    return;
  }
  var hexBarcode = flfact_tpv.iface.pub_dameString2Hex(barcode);
	if (!hexBarcode) {
		return false;
	}
  printer.setPrinterName(cursor.valueBuffer("impresora"));
  printer.send("ESC:" + cursor.valueBuffer("escbarcode") + "," + hexBarcode);
printer.send("ESC:1B,64,05"); /// 5 líneas
  printer.flush();
}



//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////