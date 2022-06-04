/***************************************************************************
                 gd_config.qs  -  description
                             -------------------
    begin                : vie jul 21 2006
    copyright            : (C) 2006 by InfoSiAL S.L.
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
	function beforeCommit_ms_mensajes(curMS:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_ms_mensajes(curMS);
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var fMensajes_:Object;
	var temporizador:String;
	var conexion_:String;
	function oficial( context ) { interna( context ); }
	function conectar():Boolean {
		return this.ctx.oficial_conectar();
	}
	function globalInit() {
		return this.ctx.oficial_globalInit();
	}
	function aviso() {
		return this.ctx.oficial_aviso();
	}
	function enviarMensaje(datos:Array):Boolean {
		return this.ctx.oficial_enviarMensaje(datos);
	}
	function generarEnvios(curMS:FLSqlCursor):Boolean {
		return this.ctx.oficial_generarEnvios(curMS);
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
	function pub_globalInit() {
		return this.globalInit();
	}
	function pub_aviso() {
		return this.aviso();
	}
	function pub_enviarMensaje(datos:Array):Boolean {
		return this.enviarMensaje(datos);
	}
	function pub_generarEnvios(curMS:FLSqlCursor):Boolean {
		return this.generarEnvios(curMS);
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
	
// 	this.iface.globalInit();	
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_conectar():Boolean
{
	var util:FLUtil = new FLUtil();
	var datosConexion:String = "";

	var nombreBD:String = sys.nameBD();
	datosConexion += "\n" + util.translate("scripts", "Base de datos %1").arg(nombreBD);

	var host:String = sys.nameHost();
	datosConexion += "\n" + util.translate("scripts", "Servidor %1").arg(host);
	
	var driver:String = "";
	if (sys.nameDriver().search("PSQL") > -1)
		driver = "PostgreSQL";
	else
		driver = "MySQL";
	datosConexion += "\n" + util.translate("scripts", "Driver %1").arg(driver);

	var puerto:String = "5432";/*sys.port();*/
	datosConexion += "\n" + util.translate("scripts", "Puerto %1").arg(puerto);

	if (!driver || !nombreBD || !host)
		return false;

	var usuario:String = sys.nameUser();
	var password:String = "";/*password();*/
// 	var password:String = (requiereContra ? Input.getText( util.translate("scripts", "Password de conexión para %1 (en caso necesario)").arg(usuario)) : "");

	this.iface.conexion_ = "CX";
	if (!sys.addDatabase(driver, nombreBD, usuario, password, host, puerto, this.iface.conexion_)) {
		MessageBox.warning(util.translate("scripts", "Error en la conexión:%1").arg(datosConexion), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	return true;
}

function oficial_globalInit()
{
	var util:FLUtil = new FLUtil;
	var comprobar:String = util.readSettingEntry("scripts/flcolamens/comprobarmensajes");
	if (comprobar == "true") {

		var tiempo:Number = parseFloat(util.readSettingEntry("scripts/flcolamens/tiempomensajes"));
		if(tiempo) {
			tiempo = tiempo*60*1000;
			if(this.iface.conectar())
				this.iface.temporizador = startTimer(tiempo, this.iface.aviso);
		}
	}
}

function oficial_aviso()
{debug("oficial_aviso");
	var util:FLUtil;

	if(util.sqlSelect("ms_mensajes","idmensaje","propietario = '" + sys.nameUser() + "' AND avisar = true")) {
		killTimer(this.iface.temporizador);
		var f:Object;
		f = new FLFormSearchDB("ms_avisomensajes");
		f.setMainWidget();
		f.exec("idmensaje");

		util.sqlUpdate("ms_mensajes","avisar","false","propietario = '" + sys.nameUser() + "'");
		var tiempo:Number = parseFloat(util.readSettingEntry("scripts/flcolamens/tiempomensajes"));
		if(tiempo) {
			tiempo = tiempo*60*1000;
			this.iface.temporizador = startTimer(tiempo, this.iface.aviso);
		}

	}
}

function interna_beforeCommit_ms_mensajes(curMS:FLSqlCursor):Boolean
{
	var asunto:String;

	if(curMS.valueBuffer("asunto") == "" || !curMS.valueBuffer("asunto")) {
		asunto = curMS.valueBuffer("contenido").left(50) + "..."; 
		curMS.setValueBuffer("asunto",asunto);
	}
	return true;
}

// Datos
//     origen
//     usuariodest [flusers]
//	   grupodest [flgroups]
//     asunto
//     contenido

function oficial_enviarMensaje(datos:Array):Boolean
{
	var util:FLUtil;

	if(!datos)
		return false;

	var curMS:FLSqlCursor = (flcolamens.iface.conexion_ ? new FLSqlCursor("ms_mensajes",flcolamens.iface.conexion_) : new FLSqlCursor("ms_mensajes"));
	curMS.setModeAccess(curMS.Insesrt);	
	curMS.refreshBuffer();
	curMS.setValueBuffer("estado",datos["Enviado"]);
	curMS.setValueBuffer("origen",datos["origen"]);
	if(datos["usuariodest"] && datos["usuariodest"] != "")
		curMS.setValueBuffer("usuariodestino",datos["usuariodest"]);
	if(datos["grupodest"] && datos["grupodest"] != "")
		curMS.setValueBuffer("grupodestino",datos["grupodest"]);

	curMS.setValueBuffer("contenido",datos["contenido"]);
	if(datos["asunto"] && datos["asunto"] != "")
		curMS.setValueBuffer("asunto",datos["asunto"]);

	if(!curMS.commitBuffer())
		return false;
	
	var idMensaje:Number = curMS.valueBuffer("idmensaje");
	curMS.seleact("idmensaje = " + idMensaje);
	curMS.setModeAccess(curMS.Edit);
	curMS.refreshBuffer();

	if(!this.iface.generarEnvios(curMS))
		return false;

	return true;
}

function oficial_generarEnvios(curMS:FLSqlCursor):Boolean
{
	var util:FLUtil;

	var arrayUsuarios:Array = [];
	var grupoDes:String = curMS.valueBuffer("grupodestino");
	if(grupoDes && grupoDes != "") {
		var qryU:FLSqlQuery = (flcolamens.iface.conexion_ ? new FLSqlQuery("", flcolamens.iface.conexion_) : new FLSqlQuery());
		with (qryU) {
			setTablesList("flusers");
			setSelect("iduser");
			setFrom("flusers");
			setWhere("idgroup = '" + grupoDes + "'");
			setForwardOnly(true);
		}
		if (!qryU.exec())
			return false;

		while (qryU.next())
			arrayUsuarios[arrayUsuarios.length] = qryU.value("iduser");
	}
	else {
		var usuarioDes:String = curMS.valueBuffer("usuariodestino");
		if(usuarioDes && usuarioDes != "")
			arrayUsuarios[arrayUsuarios.length] = usuarioDes;
	}

	var curDestMens:FLSqlCursor = (flcolamens.iface.conexion_ ? new FLSqlCursor("ms_mensajes",flcolamens.iface.conexion_) : new FLSqlCursor("ms_mensajes"));	
	var hoy:Date = new Date();
	var ahora:String = hoy.toString().right(8);
	for(var u=0;u<arrayUsuarios.length;u++) {
		curDestMens.setModeAccess(curDestMens.Insert);
		curDestMens.refreshBuffer();
		curDestMens.setValueBuffer("fecha",hoy);
		curDestMens.setValueBuffer("hora",ahora);
		curDestMens.setValueBuffer("asunto",curMS.valueBuffer("asunto"));
		curDestMens.setValueBuffer("origen",curMS.valueBuffer("origen"));
		curDestMens.setValueBuffer("contenido",curMS.valueBuffer("contenido"));
		curDestMens.setValueBuffer("tipoobjeto","ms_mensajes");
		curDestMens.setValueBuffer("idobjeto",curMS.valueBuffer("idmensaje"));
		curDestMens.setValueBuffer("usuariodestino",arrayUsuarios[u]);
		curDestMens.setValueBuffer("propietario",arrayUsuarios[u]);
		curDestMens.setValueBuffer("estado","No leido");
		curDestMens.setValueBuffer("avisar",true);
		if(!curDestMens.commitBuffer())
			return false;
	}

	return true;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////