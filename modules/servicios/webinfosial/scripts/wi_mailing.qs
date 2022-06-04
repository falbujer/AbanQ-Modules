/***************************************************************************
                 wi_mailing.qs  -  description
                             -------------------
    begin                : lun sep 21 2004
    copyright            : (C) 2004 by InfoSiAL S.L.
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
    function init() { this.ctx.interna_init(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	function oficial( context ) { interna( context ); } 
    function regenerarLista() { 
    	return this.ctx.oficial_regenerarLista(); 
    }
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
	connect(this.child("pbnRegenerarLista"), "clicked()", this, "iface.regenerarLista");
	connect(this.child("pbnEnviar"), "clicked()", this, "iface.enviar");
}



//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_regenerarLista()
{
	var util:FLUtil = new FLUtil;
	
	var res = MessageBox.information(util.translate("scripts", "Se borrarán todos los registros de la lista ¿Estás seguro?"), MessageBox.Yes, MessageBox.No);
	if (res != MessageBox.Yes)
		return;
	
	var cursor:FLSqlCursor = this.cursor();
	
	var idMailing:String = cursor.valueBuffer("id");
	var destinatarios:String = cursor.valueBuffer("destinatarios");
	var tabla:String, campoMail:String, campoNombre:String;	

	switch(destinatarios) {
		case "Partners":
			tabla = "se_partners";
			campoMail = "email";
			campoNombre = "nombre";
		break;
	}
	
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList(tabla);
	q.setFrom(tabla);
	q.setSelect(campoNombre + "," + campoMail);

	if (!q.exec()) {
		MessageBox.critical(util.translate("scripts", "Falló la consulta de direcciones"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return;
	}
	
	util.sqlDelete("wi_enviosmailing", "idmailing = " + idMailing);
	
	var curTab:FLSqlCursor = new FLSqlCursor("wi_enviosmailing");
	while(q.next()) {
		
		if (!q.value(1))
			continue;
	
		curTab.setModeAccess(curTab.Insert);
		curTab.refreshBuffer();
		curTab.setValueBuffer("idmailing", idMailing);
		curTab.setValueBuffer("nombre", q.value(0));
		curTab.setValueBuffer("email", q.value(1));
		curTab.setValueBuffer("enviado", false);
		curTab.commitBuffer();
	}
	
	this.child("tdbEnviosMailing").refresh();
}

function oficial_enviar()
{
	var util:FLUtil = new FLUtil;
	
	var res = MessageBox.information(util.translate("scripts", "Se enviarán todos los mensajes pendientes ¿Estás seguro?"), MessageBox.Yes, MessageBox.No);
	if (res != MessageBox.Yes)
		return;
	
	var cursor:FLSqlCursor = this.cursor();
	var idMailing:String = cursor.valueBuffer("id");
	var limite:String = cursor.valueBuffer("limite");
	
	var cliCorr:FLSmtpClient = new FLSmtpClient;
	
	var curTab:FLSqlCursor = new FLSqlCursor("wi_enviosmailing");
	curTab.select("enviado=false AND idmailing = " + idMailing);
	
	util.createProgressDialog( util.translate( "scripts", "Enviando " ), curTab.size());
	var paso:Number = 0;

	while(curTab.next()) {
		debug("enviando a " + curTab.valueBuffer("email"));
		util.setProgress(paso++);
		util.setLabelText(util.translate( "scripts", "Enviando a " + curTab.valueBuffer("email")));
		
		cliCorr.setTo(curTab.valueBuffer("email"));
		cliCorr.setSubject(cursor.valueBuffer("asunto"));
		cliCorr.setBody(cursor.valueBuffer("texto"));
		cliCorr.setFrom(cursor.valueBuffer("desde"));
		if (!File.exists(Dir.home + "/firma.txt"))
			File.write(Dir.home + "/firma.txt", "InfoSiAL S.L.");
		cliCorr.addAttachment(Dir.home + "/firma.txt");
		
		cliCorr.startSend();
		
		curTab.setModeAccess(curTab.Edit);
		curTab.refreshBuffer();
		curTab.setValueBuffer("enviado", true);
		curTab.commitBuffer();
		
		if (limite && paso >= limite)
			break;
	}
	
	util.destroyProgressDialog();
	this.child("tdbEnviosMailing").refresh();
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////

//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
