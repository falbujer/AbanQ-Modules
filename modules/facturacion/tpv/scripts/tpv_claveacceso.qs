/***************************************************************************
                 tpv_claveacceso.qs  -  description
                             -------------------
    begin                : mar ago 14 2012
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
	var bloqueoProvincia:Boolean;
	function oficial( context ) { interna( context ); }
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function comprobar() {
		return this.ctx.oficial_comprobar();
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
/** \C Si en la tabla de direcciones de clientes no hay todavía ninguna dirección asociada al cliente, la primera dirección introducida se tomará como dirección de facturación y dirección de envío
\end */
function interna_init()
{
	var cursor = this.cursor();
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this.child("ledContra"), "returnPressed()", this, "iface.comprobar()");
	
	var pbAccept = this.child( "pushButtonAccept" );
	disconnect( pbAccept, "clicked()", this.obj(), "accept()" );
	connect( pbAccept, "clicked()", this, "iface.comprobar()" );
	
	if (cursor.valueBuffer("codtpv_agente")) {
		this.child("ledContra").setFocus();
	}
	
	if(cursor.valueBuffer("noautentificar"))
		this.child("gbxContra").close();
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_bufferChanged(fN:String)
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	switch (fN) {
		case "provincia": {
			break;
		}
	}
}

function oficial_comprobar()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	if(cursor.valueBuffer("noautentificar")) {
		cursor.setValueBuffer("ok", true);
		this.obj().accept();
	}
	
	var clave = AQUtil.sqlSelect("tpv_agentes", "claveacceso", "codtpv_agente = '" + cursor.valueBuffer("codtpv_agente") + "'");
	if (clave == undefined) {
		return false;
	}
	
	var claveUsuario = this.child("ledContra").text;

	if (clave == claveUsuario) {
		cursor.setValueBuffer("ok", true);
		this.obj().accept();
	} else {
		this.obj().accept();
	}
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
