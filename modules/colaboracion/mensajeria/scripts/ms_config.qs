/***************************************************************************
                 ms_config.qs  -  description
                             -------------------
    begin                : vie mar 12 2010
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
class interna {
	var ctx:Object;
	function interna( context ) { this.ctx = context; }
	function main() {
		this.ctx.interna_main();
	}
	function init() {
		this.ctx.interna_init();
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	function oficial( context ) { interna( context ); }
	function cambiarComprobar() {
		return this.ctx.oficial_cambiarComprobar();
	}
	function cambiarTiempoMensajes(valor:String) {
		return this.ctx.oficial_cambiarTiempoMensajes(valor);
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

////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/** @class_definition interna */
//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////

function interna_main()
{
	var f:Object = new FLFormSearchDB("ms_config");
	var cursor:FLSqlCursor = f.cursor();

	cursor.select();
	if (!cursor.first())
		cursor.setModeAccess(cursor.Insert);
	else
		cursor.setModeAccess(cursor.Edit);
	f.setMainWidget();
	if (cursor.modeAccess() == cursor.Insert)
		f.child("pushButtonCancel").setDisabled(true);
	cursor.refreshBuffer();
	var commitOk:Boolean = false;
	var acpt:Boolean;
	cursor.transaction(false);
	while (!commitOk) {
		acpt = false;
		f.exec("id");
		acpt = f.accepted();
		if (!acpt) {
			if (cursor.rollback())
				commitOk = true;
		} else {
			if (cursor.commitBuffer()) {
				cursor.commit();
				commitOk = true;
			}
		}
		f.close();
	}
}

function interna_init()
{
	var util:FLUtil = new FLUtil();
	this.child("chkComprobar").checked = util.readSettingEntry("scripts/flcolamens/comprobarmensajes");
	this.child("lineEditMinutos").text = util.readSettingEntry("scripts/flcolamens/tiempomensajes");

	connect( this.child( "chkComprobar" ), "clicked()", this, "iface.cambiarComprobar" );
	connect(this.child("lineEditMinutos"), "textChanged(QString)", this, "iface.cambiarTiempoMensajes()");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_cambiarComprobar()
{
	var util:FLUtil;

	if(this.child("chkComprobar").checked) {
		util.writeSettingEntry("scripts/flcolamens/comprobarmensajes", true);
		var tiempo:Number = parseFloat(util.readSettingEntry("scripts/flcolamens/tiempomensajes"));
		if(tiempo) {
			tiempo = tiempo*60*1000;
			flcolamens.iface.temporizador = startTimer(tiempo, flcolamens.iface.pub_aviso);
		}
		this.child("lineEditMinutos").setDisabled(false);
	}
	else {
		killTimer(flcolamens.iface.temporizador);
		util.writeSettingEntry("scripts/flcolamens/comprobarmensajes", false);
		this.child("lineEditMinutos").setDisabled(true);
	}
}

function oficial_cambiarTiempoMensajes(valor:String)
{
	var util:FLUtil;
	util.writeSettingEntry("scripts/flcolamens/tiempomensajes", valor);
	killTimer(flcolamens.iface.temporizador);
	var tiempo:Number = parseFloat(valor);
	if(tiempo && util.readSettingEntry("scripts/flcolamens/comprobarmensajes") == "true") {
		tiempo = tiempo*60*1000;
		flcolamens.iface.temporizador = startTimer(tiempo, flcolamens.iface.aviso);
	}
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////



//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////