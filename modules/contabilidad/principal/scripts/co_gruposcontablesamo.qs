/***************************************************************************
                 co_gruposcontablesamo.qs  -  description
                             -------------------
    begin                : jue nov 24 2011
    copyright            : (C) 2011 by InfoSiAL S.L.
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
class interna {
	var ctx:Object;
	function interna( context ) { this.ctx = context; }
	function init() {
		return this.ctx.interna_init();
	}
	function validateForm() {
		return this.ctx.interna_validateForm();
	}
	function calculateField(fN) {
		return this.ctx.interna_calculateField( fN );
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
  var longSubcuenta;
  var ejercicioActual;
  var bloqueoSubcuenta;
  var posActualPuntoSubcuentaElem, posActualPuntoSubcuentaAmor, posActualPuntoSubcuentaGas, posActualPuntoSubcuentaPer, posActualPuntoSubcuentaGan;

  function oficial( context ) { interna( context ); } 
  function bufferChanged(fN) {
    return this.ctx.oficial_bufferChanged(fN);
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
  
  _i.ejercicioActual = flfactppal.iface.pub_ejercicioActual();
  _i.longSubcuenta = AQUtil.sqlSelect("ejercicios", "longsubcuenta", "codejercicio = '" + _i.ejercicioActual + "'");
  _i.posActualPuntoSubcuentaAmor = -1;
  _i.posActualPuntoSubcuentaElem = -1;
	_i.posActualPuntoSubcuentaGas = -1;
	_i.posActualPuntoSubcuentaPer = -1;
	_i.posActualPuntoSubcuentaGan = -1;
  _i.bloqueoSubcuenta = false;
  
  this.child("fdbIdSubcuentaEle").setFilter("codejercicio = '" + _i.ejercicioActual + "'");
  this.child("fdbIdSubcuentaAmo").setFilter("codejercicio = '" + _i.ejercicioActual + "'");
	this.child("fdbIdSubcuentaGas").setFilter("codejercicio = '" + _i.ejercicioActual + "'");
	this.child("fdbIdSubcuentaPer").setFilter("codejercicio = '" + _i.ejercicioActual + "'");
	this.child("fdbIdSubcuentaGan").setFilter("codejercicio = '" + _i.ejercicioActual + "'");
	
  connect(cursor, "bufferChanged(QString)", _i, "bufferChanged");
}

function interna_validateForm()
{
  var _i = this.iface;
  var cursor = this.cursor();
  return true;
}

function interna_calculateField( fN )
{
  var _i = this.iface;
  var cursor = this.cursor();
  var valor;
  switch(fN) {
		case "mes": {
			break;
    }
  }
	return valor;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_bufferChanged(fN)
{
  var _i = this.iface;
  switch (fN) {
  case "codsubcuentaele": {
      if (!_i.bloqueoSubcuenta) {
        _i.bloqueoSubcuenta = true;
        _i.posActualPuntoSubcuentaElem = flcontppal.iface.pub_formatearCodSubcta(this, "fdbCodSubcuentaEle", _i.longSubcuenta, _i.posActualPuntoSubcuentaElem);
        _i.bloqueoSubcuenta = false;
      }
      break;
    }
  case "codsubcuentaamo": { 
      if (!_i.bloqueoSubcuenta) {
        _i.bloqueoSubcuenta = true;
        _i.posActualPuntoSubcuentaAmor = flcontppal.iface.pub_formatearCodSubcta(this, "fdbCodSubcuentaAmo", _i.longSubcuenta, _i.posActualPuntoSubcuentaAmor);
        _i.bloqueoSubcuenta = false;
      }
      break;
    }
    case "codsubcuentagas": { 
      if (!_i.bloqueoSubcuenta) {
        _i.bloqueoSubcuenta = true;
        _i.posActualPuntoSubcuentaGas = flcontppal.iface.pub_formatearCodSubcta(this, "fdbCodSubcuentaGas", _i.longSubcuenta, _i.posActualPuntoSubcuentaGas);
        _i.bloqueoSubcuenta = false;
      }
      break;
    }
    case "codsubcuentaper": { 
      if (!_i.bloqueoSubcuenta) {
        _i.bloqueoSubcuenta = true;
        _i.posActualPuntoSubcuentaPer = flcontppal.iface.pub_formatearCodSubcta(this, "fdbCodSubcuentaPer", _i.longSubcuenta, _i.posActualPuntoSubcuentaPer);
        _i.bloqueoSubcuenta = false;
      }
      break;
    }
    case "codsubcuentagan": { 
      if (!_i.bloqueoSubcuenta) {
        _i.bloqueoSubcuenta = true;
        _i.posActualPuntoSubcuentaGan = flcontppal.iface.pub_formatearCodSubcta(this, "fdbCodSubcuentaGan", _i.longSubcuenta, _i.posActualPuntoSubcuentaGan);
        _i.bloqueoSubcuenta = false;
      }
      break;
    }
  }
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////