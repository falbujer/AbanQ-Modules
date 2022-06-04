/***************************************************************************
                 i_inventario.qs  -  description
                             -------------------
    begin                : lun ene 16 2012
    copyright            : (C) 2012 by InfoSiAL S.L.
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
    function init() { this.ctx.interna_init(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	function oficial( context ) { interna( context ); } 
	function bufferChanged(fN) {
		this.ctx.oficial_bufferChanged(fN);
	}
	function habilitarPorActual() {
		this.ctx.oficial_habilitarPorActual();
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
debug("interna_init");
	var _i = this.iface;
	var cursor = this.cursor();
	connect(cursor, "bufferChanged(QString)", _i, "bufferChanged");
	_i.habilitarPorActual();
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_bufferChanged(fN)
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	switch(fN){
		case "actual": {
			_i.habilitarPorActual();
			break;
		}
	}
}

function oficial_habilitarPorActual()
{
debug("oficial_habilitarPorActual");
	var _i = this.iface;
	var cursor = this.cursor();
	
	if (cursor.valueBuffer("actual")) {
		this.child("fdbAFecha").setValue("");
		this.child("fdbAFecha").setDisabled(true);
		this.child("fdbIncluirSinStock").setDisabled(false);
	} else {
		this.child("fdbAFecha").setDisabled(false);
		this.child("fdbIncluirSinStock").setValue(true);
		this.child("fdbIncluirSinStock").setDisabled(true);
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
