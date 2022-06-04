/***************************************************************************
                 ms_mastermensajes.qs  -  description
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
	var filtroUsuario:String;
	const PAPELERA:Number = 0;
	const BORRADORES:Number = 1;
	const ENVIADOS:Number = 2;
	const RECIBIDOS:Number = 3;

	function oficial( context ) { interna( context ); }
	function cambiarCarpeta(carpeta:Number) {
		return this.ctx.oficial_cambiarCarpeta(carpeta);
	}
	function activarBoton(boton:Number) {
		return this.ctx.oficial_activarBoton(boton);
	}
	function crearMensajeNuevo() {
		return this.ctx.oficial_crearMensajeNuevo();
	}
	function borrarMensaje() {
		return this.ctx.oficial_borrarMensaje();
	}
	function marcarLeido() {
		return this.ctx.oficial_marcarLeido();
	}
	function marcarNoLeido() {
		return this.ctx.oficial_marcarNoLeido();
	}
	function responderMensaje() {
		return this.ctx.oficial_responderMensaje();
	}
	function enviarMensaje() {
		return this.ctx.oficial_enviarMensaje();
	}
	function mostrarMensaje() {
		return this.ctx.oficial_mostrarMensaje();
	}
	function refrescarMensajes() {
		return this.ctx.oficial_refrescarMensajes();
	}
	function formularioAbierto():Boolean {
		return this.ctx.oficial_formularioAbierto();
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
	function pub_formularioAbierto():Boolean {
		return this.formularioAbierto();
	}
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
// 	if (flcolamens.iface.fMensajes_) {
// 		try {
// 			flcolamens.iface.fMensajes_.close();
// 		} catch (e) {}
// 	}
	flcolamens.iface.fMensajes_ = this;

	var util:FLUtil = new FLUtil();

	connect(this.child("botones"), "clicked(int)", this, "iface.activarBoton");
	connect(this.child("tbnNuevo"), "clicked()", this, "iface.crearMensajeNuevo");
	connect(this.child("tbnPapelera"), "clicked()", this, "iface.borrarMensaje");
	connect(this.child("tbnMarcarLeido"), "clicked()", this, "iface.marcarLeido");
	connect(this.child("tbnResponder"), "clicked()", this, "iface.responderMensaje");
	connect(this.child("tbnMarcarNoLeido"), "clicked()", this, "iface.marcarNoLeido");
	connect(this.child("tbnEnviar"), "clicked()", this, "iface.enviarMensaje");
	connect(this.child("tdbMensajes"),"currentChanged()", this, "iface.mostrarMensaje");
	connect(this.child("tbnComprobar"), "clicked()", this, "iface.refrescarMensajes");

	this.iface.filtroUsuario = "propietario = '" + sys.nameUser() + "'";

	this.iface.activarBoton(this.iface.RECIBIDOS);
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_cambiarCarpeta(carpeta:Number)
{
	var util:FLUtil;

	var filtro:String = "";

	switch(carpeta) {
		case this.iface.PAPELERA: {
			filtro = "estado = 'Borrado'";

			this.child("tbnResponder").setDisabled(true);
			this.child("tbnMarcarLeido").setDisabled(true);
			this.child("tbnMarcarNoLeido").setDisabled(true);
			this.child("tbnEnviar").setDisabled(true);
			break;
		}
		case this.iface.BORRADORES: {
			filtro = "estado = 'Borrador'";

			this.child("tbnResponder").setDisabled(true);
			this.child("tbnMarcarLeido").setDisabled(true);
			this.child("tbnMarcarNoLeido").setDisabled(true);
			this.child("tbnEnviar").setDisabled(false);
			break;
		}
		case this.iface.ENVIADOS: {
			filtro = "estado = 'Enviado'";
	
			this.child("tbnResponder").setDisabled(true);
			this.child("tbnMarcarLeido").setDisabled(true);
			this.child("tbnMarcarNoLeido").setDisabled(true);
			this.child("tbnEnviar").setDisabled(false);
			break;
		}
		case this.iface.RECIBIDOS: {
			filtro = "estado IN ('Recibido','No leido')";

			this.child("tbnResponder").setDisabled(false);
			this.child("tbnMarcarLeido").setDisabled(false);
			this.child("tbnMarcarNoLeido").setDisabled(false);
			this.child("tbnEnviar").setDisabled(true);
			break;
		}
	}

	this.child("tdbMensajes").cursor().setMainFilter(this.iface.filtroUsuario + " AND " + filtro);
	this.iface.refrescarMensajes();
}

function oficial_activarBoton(boton:Number)
{
	for(var i=0;i<4;i++) {
		if(i == boton)
			this.iface.cambiarCarpeta(boton);
		else
			this.child("boton" + i).on = false;
	}
}

function oficial_crearMensajeNuevo()
{
	var curMens:FLSqlCursor = (flcolamens.iface.conexion_ ? new FLSqlCursor("ms_mensajes",flcolamens.iface.conexion_) : new FLSqlCursor("ms_mensajes"));
	
	curMens.insertRecord();
}

function oficial_borrarMensaje()
{
	var util:FLUtil;

	var arrayMensajes = this.child("tdbMensajes").primarysKeysChecked();
	if(arrayMensajes.length == 0) {
		MessageBox.information(util.translate("scripts", "No hay ningún mensaje seleccionado."), MessageBox.Ok, MessageBox.NoButton);
		return;
	}

	var curMens:FLSqlCursor = (flcolamens.iface.conexion_ ? new FLSqlCursor("ms_mensajes",flcolamens.iface.conexion_) : new FLSqlCursor("ms_mensajes"));

	var preguntado:Boolean = false;
	for(var i=0;i<arrayMensajes.length;i++) {
		var idMensaje:Number = arrayMensajes[i];
// 	var idMensaje:Number = this.child("tdbMensajes").cursor().valueBuffer("idmensaje");
				
		curMens.select("idmensaje = " + idMensaje);
		curMens.first();
		if (curMens.valueBuffer("estado") != "Borrado") { 
			if(!preguntado) {
				var res:Number = MessageBox.information(util.translate("scripts", "¿Seguro que desea enviar los mensajes a la papelera?"), MessageBox.Yes, MessageBox.No);
				if(res != MessageBox.Yes)
					return;
				preguntado = true;
			}
			curMens.setModeAccess(curMens.Edit);
			curMens.refreshBuffer();
			curMens.setValueBuffer("estado","Borrado");
			if (!curMens.commitBuffer()) {
				return false;
			}
			this.iface.refrescarMensajes();
		}
		else {
			if(!preguntado) {
				var res:Number = MessageBox.information(util.translate("scripts", "¿Seguro que desea eliminar los mensajes?"), MessageBox.Yes, MessageBox.No);
				if(res != MessageBox.Yes)
					return;
				preguntado = true;
			}	
			curMens.setModeAccess(curMens.Del);
			curMens.refreshBuffer();
			if (!curMens.commitBuffer()) {
				return false;
			}
			this.child("tdbMensajes").refresh();
		}
	}
}

function oficial_marcarLeido()
{
	var util:FLUtil;

	var arrayMensajes = this.child("tdbMensajes").primarysKeysChecked();
	if(arrayMensajes.length == 0) {
		MessageBox.information(util.translate("scripts", "No hay ningún mensaje seleccionado."), MessageBox.Ok, MessageBox.NoButton);
		return;
	}

	var curMens:FLSqlCursor = (flcolamens.iface.conexion_ ? new FLSqlCursor("ms_mensajes",flcolamens.iface.conexion_) : new FLSqlCursor("ms_mensajes"));

	for(var i=0;i<arrayMensajes.length;i++) {
		var idMensaje:Number = arrayMensajes[i];

		curMens.select("idmensaje = " + idMensaje);
		curMens.first();
		curMens.setModeAccess(curMens.Edit);
		curMens.refreshBuffer();
		curMens.setValueBuffer("estado","Recibido");
		if(!curMens.commitBuffer())
			return false;
	}

	this.iface.refrescarMensajes();
}

function oficial_marcarNoLeido()
{
	var util:FLUtil;

	var arrayMensajes = this.child("tdbMensajes").primarysKeysChecked();
	if(arrayMensajes.length == 0) {
		MessageBox.information(util.translate("scripts", "No hay ningún mensaje seleccionado."), MessageBox.Ok, MessageBox.NoButton);
		return;
	}

	var curMens:FLSqlCursor = (flcolamens.iface.conexion_ ? new FLSqlCursor("ms_mensajes",flcolamens.iface.conexion_) : new FLSqlCursor("ms_mensajes"));

	for(var i=0;i<arrayMensajes.length;i++) {
		var idMensaje:Number = arrayMensajes[i];

		curMens.select("idmensaje = " + idMensaje);
		curMens.first();
		curMens.setModeAccess(curMens.Edit);
		curMens.refreshBuffer();
		curMens.setValueBuffer("estado","No leido");
		if(!curMens.commitBuffer())
			return false;
	}

	this.iface.refrescarMensajes();
}

function oficial_responderMensaje()
{
debug(1);
	var util:FLUtil;
debug(this.child("tdbMensajes"));
	var idMensaje:Number = this.child("tdbMensajes").cursor().valueBuffer("idmensaje");
debug(2);
	if(!idMensaje) {
		MessageBox.information(util.translate("scripts", "No hay ningún mensaje seleccionado."), MessageBox.Ok, MessageBox.NoButton);
		return;
	}

	var curMS:FLSqlCursor = (flcolamens.iface.conexion_ ? new FLSqlCursor("ms_mensajes",flcolamens.iface.conexion_) : new FLSqlCursor("ms_mensajes"));
	curMS.select("idmensaje = " + idMensaje);
	curMS.first();
	curMS.setModeAccess(curMS.Edit);
	curMS.refreshBuffer();

	var f:Object;
	var curMens:FLSqlCursor;
	f = (flcolamens.iface.conexion_ ? new FLFormSearchDB("ms_respondermensaje",flcolamens.iface.conexion_) : new FLFormSearchDB("ms_respondermensaje"));
	curMens = f.cursor();
	curMens.setModeAccess(curMens.Insert);
	curMens.refreshBuffer();

	curMens.setValueBuffer("origen",sys.nameUser());
	curMens.setValueBuffer("usuariodestino",curMS.valueBuffer("origen"));
	curMens.setValueBuffer("asunto","Re: " + curMS.valueBuffer("asunto"));
	curMens.setValueBuffer("contenido","--------Mensaje original:-------\n" + curMS.valueBuffer("contenido") + "\n-----------------------------------\n\n");
	
	f.setMainWidget();
	if (f.exec("idmensaje")) {
		if (curMens.commitBuffer())
			curMens.commit();
	}

	this.iface.refrescarMensajes();
}

function oficial_enviarMensaje()
{
	var util:FLUtil;

	var idMensaje:Number = this.child("tdbMensajes").cursor().valueBuffer("idmensaje");
	if(!idMensaje) {
		MessageBox.information(util.translate("scripts", "No hay ningún mensaje seleccionado."), MessageBox.Ok, MessageBox.NoButton);
		return;
	}

	var curMS:FLSqlCursor = (flcolamens.iface.conexion_ ? new FLSqlCursor("ms_mensajes",flcolamens.iface.conexion_) : new FLSqlCursor("ms_mensajes"));
	curMS.select("idmensaje = " + idMensaje);
	curMS.first();
	curMS.setModeAccess(curMS.Edit);
	curMS.refreshBuffer();

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
// 		if(!curDestMens.commitBuffer())
// 			return false;
// 	}

	curMS.setValueBuffer("estado","Enviado");
	if(!curMS.commitBuffer())
		return false;

	this.iface.refrescarMensajes();
}

function oficial_mostrarMensaje()
{
	var util:FLUtil;

	var idMensaje:Number = this.cursor().valueBuffer("idmensaje");
	if(!idMensaje) {
		this.child("tlbDetallesMensaje").text = ""
		this.child("tlbMensaje").text = "";
		return;
	}

	var curMS:FLSqlCursor = (flcolamens.iface.conexion_ ? new FLSqlCursor("ms_mensajes",flcolamens.iface.conexion_) : new FLSqlCursor("ms_mensajes"));
	curMS.select("idmensaje = " + idMensaje);
	curMS.first();
	curMS.setModeAccess(curMS.Edit);
	curMS.refreshBuffer();

	var destino:String = curMS.valueBuffer("grupodestino");
	if(!destino || destino == "")
		destino = curMS.valueBuffer("usuariodestino");
	
	var detalles:String = "<b>De: </b>" + curMS.valueBuffer("origen") + "     <b>     Para: </b>" + destino + " <b>     Fecha:</b>  " + util.dateAMDtoDMA(curMS.valueBuffer("fecha")) + " <b>   Hora:</b> " + curMS.valueBuffer("hora").toString().right(8) + "<br><b>Asunto: </b>" + curMS.valueBuffer("asunto")

	this.child("tlbDetallesMensaje").text = detalles;
	this.child("tlbMensaje").text = curMS.valueBuffer("contenido");
}

function oficial_refrescarMensajes()
{
// 	var arrayMensajes = this.child("tdbMensajes").primarysKeysChecked();
// 	var idMensaje:Number
// 	for(var i=0;i<arrayMensajes.length;i++) {
// 		idMensaje = arrayMensajes[i];
// 		this.child("tdbMensajes").setPrimaryKeyChecked(idMensaje,false);
// 	}
	this.child("tdbMensajes").clearChecked();
	this.child("tdbMensajes").refresh();
}

function oficial_formularioAbierto():Boolean
{
	if(this.cursor().isValid()) {
		debug("abierto");
		return true;
	}
	else {
		debug("cerrado");
		return false;
	}
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////