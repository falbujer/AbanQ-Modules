/***************************************************************************
                 ms_mensajes.qs  -  description
                             -------------------
    begin                : mar mar 16 2010
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
	function enviar() {
		return this.ctx.oficial_enviar();
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
function interna_init()
{
	switch(this.cursor().modeAccess()) {
		case this.cursor().Insert: {
			this.cursor().setValueBuffer("propietario",sys.nameUser());
			this.child("fdbOrigen").setValue(sys.nameUser());	
			break;
		}
		case this.cursor().Edit: {
			if(this.cursor().valueBuffer("estado") != "Borrador") {
				this.child("gbxComunicacion").setDisabled(true);
				this.child("gbxContenido").setDisabled(true);
			}
			break;
		}
	}
	
	try {
		this.child("pushButtonCancel").close();
		this.child("pushButtonAccept").close();
		this.child("pushButtonAcceptContinue").close();
	}
	catch (e) {
	}

	connect(this.child("tbnEnviar"), "clicked()", this, "iface.enviar");
	connect(this.child("tbnAceptar"),"clicked()", this.obj(), "accept()" );
	connect(this.child("tbnCancelar"),"clicked()", this.obj(), "reject()" );
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_enviar()
{
	var util:FLUtil;

	var curMS:FLSqlCursor = this.cursor();
	var idMensaje:Number = curMS.valueBuffer("idmensaje");
	if(!idMensaje) {
		return;
	}

// 	var curMS:FLSqlCursor = (flcolamens.iface.conexion_ ? new FLSqlCursor("ms_mensajes",flcolamens.iface.conexion_) : new FLSqlCursor("ms_mensajes"));
// 	curMS.select("idmensaje = " + idMensaje);
// 	curMS.first();
// 	curMS.setModeAccess(curMS.Edit);
// 	curMS.refreshBuffer();

	if(!flcolamens.iface.pub_generarEnvios(curMS))
		return false;

// 	var arrayUsuarios:Array = [];
// 	var grupoDes:String = curMS.valueBuffer("grupodestino");
// 	if(grupoDes && grupoDes != "") {
// 		var qryU:FLSqlQuery = (flcolamens.iface.conexion_ ? new FLSqlQuery("", flcolamens.iface.conexion_) : new FLSqlQuery());
// 		with (qryU) {
// 			setTablesList("flusers");
// 			setSelect("iduser");
// 			setFrom("flusers");
// 			setWhere("idgroup = '" + grupoDes + "'");
// 			setForwardOnly(true);
// 		}
// 		if (!qryU.exec())
// 			return false;
// 
// 		while (qryU.next())
// 			arrayUsuarios[arrayUsuarios.length] = qryU.value("iduser");
// 	}
// 	else {
// 		var usuarioDes:String = curMS.valueBuffer("usuariodestino");
// 		if(usuarioDes && usuarioDes != "")
// 			arrayUsuarios[arrayUsuarios.length] = usuarioDes;
// 	}
// 
// 	var curDestMens:FLSqlCursor = (flcolamens.iface.conexion_ ? new FLSqlCursor("ms_mensajes",flcolamens.iface.conexion_) : new FLSqlCursor("ms_mensajes"));	
// 	var hoy:Date = new Date();
// 	var ahora:String = hoy.toString().right(8);
// 	for(var u=0;u<arrayUsuarios.length;u++) {
// 		curDestMens.setModeAccess(curDestMens.Insert);
// 		curDestMens.refreshBuffer();
// 		curDestMens.setValueBuffer("fecha",hoy);
// 		curDestMens.setValueBuffer("hora",ahora);
// 		curDestMens.setValueBuffer("asunto",curMS.valueBuffer("asunto"));
// 		curDestMens.setValueBuffer("origen",curMS.valueBuffer("origen"));
// 		curDestMens.setValueBuffer("contenido",curMS.valueBuffer("contenido"));
// 		curDestMens.setValueBuffer("tipoobjeto","ms_mensajes");
// 		curDestMens.setValueBuffer("idobjeto",curMS.valueBuffer("idmensaje"));
// 		curDestMens.setValueBuffer("usuariodestino",arrayUsuarios[u]);
// 		curDestMens.setValueBuffer("propietario",arrayUsuarios[u]);
// 		curDestMens.setValueBuffer("estado","No leido");
// 		curDestMens.setValueBuffer("avisar",true);
// 		if(!curDestMens.commitBuffer())
// 			return false;
// 	}

	curMS.setValueBuffer("estado","Enviado");
// 	if(!curMS.commitBuffer())
// 		return false;

	this.obj().accept();
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////