/***************************************************************************
                 wi_comunicaciones.qs  -  description
                             -------------------
    begin                : mar sep 4 2007
    copyright            : (C) 2007 by InfoSiAL S.L.
    email                : mail@infosial.com
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
//  ***************************************************************************/

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
	function calculateField(fN:String):String { return this.ctx.interna_calculateField(fN); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
 	var procesoMail:FLProcess;
    function oficial( context ) { interna( context ); } 
	function bufferChanged(fN:String) {	return this.ctx.oficial_bufferChanged(fN); }
    function importarMail() { return this.ctx.oficial_importarMail() ;}
	function procesarFichero(file:File ,arrayLineas:Array ,numLineas:Number):String { return this.ctx.oficial_procesarFichero(file,arrayLineas,numLineas);	}
	function extraerFecha(cadena:String):Date { return this.ctx.oficial_extraerFecha(cadena);}
	function convertirMes(cadena:String):String { return this.ctx.oficial_convertirMes(cadena);}
	function extraerHora(cadena:String):Date { return this.ctx.oficial_extraerHora(cadena);}
	function extraerFechaHora(cadena:String):Date { return this.ctx.oficial_extraerFechaHora(cadena);}
	function corregirCadena(tipoCodificacion:String,cadena:String):String{ return this.ctx.oficial_corregirCadena(tipoCodificacion,cadena);}
	function enviarMail() { return this.ctx.oficial_enviarMail(); }
	function mailEnviado() { return this.ctx.oficial_mailEnviado(); }
	function controlEstado() { return this.ctx.oficial_controlEstado(); }
	function establecerRespuesta() { return this.ctx.oficial_establecerRespuesta(); }
	function crearRemitente():String { return this.ctx.oficial_crearRemitente(); }
	function selecDestinatario() { return this.ctx.oficial_selecDestinatario(); }
	function insertarPlantillaTexto() { return this.ctx.oficial_insertarPlantillaTexto(); }
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

/** \C

El cliente no podrá ser modificado
\end */
function interna_init()
{
	var util:FLUtil = new FLUtil();
	
	var cursor:FLSqlCursor = this.cursor();
	var texto:String = "";

	if (cursor.modeAccess() == cursor.Insert) {
	
		this.child("fdbCodCliente").setValue(this.iface.calculateField("codcliente"));
	
		var hoy = new Date();
		this.cursor().setValueBuffer("hora", hoy.toString().mid(11, 5));
 		this.cursor().setValueBuffer("enviadopor", this.iface.crearRemitente());
 		this.cursor().setValueBuffer("asunto", "Su pedido " + cursor.cursorRelation().valueBuffer("codigo") + " en Abanq");
			
		
		this.iface.establecerRespuesta();
	}
	
	this.iface.controlEstado();
	
	connect( this.child("pbnImportarMail"), "clicked()", this, "iface.importarMail" );
	connect( this.child("pbnEnviarMail"), "clicked()", this, "iface.enviarMail");
	connect( this.child("pbnSelecDestinatario"), "clicked()", this, "iface.selecDestinatario");
	connect( this.child("pbnInsertarPlantillaTexto"), "clicked()", this, "iface.insertarPlantillaTexto()" );

	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	
	if(this.child("fdbCodCliente").value() && this.child("fdbCodCliente").value() != "")
		this.child("fdbCodCliente").setDisabled(true);

	this.child("fdbAdjuntarPDF").setDisabled(true);
	this.child("fdbAdjuntarPDF").close();
}

function interna_calculateField(fN:String):String
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();
	var valor:String;

	switch(fN) {
		case "codcliente" :
			valor = cursor.cursorRelation().valueBuffer("codcliente");
			if(!valor)
				valor = "";
		break;
	}
	return valor;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_bufferChanged(fN:String)
{ 
	var cursor:FLSqlCursor = this.cursor();
	/** \D Al cambiar el --estado-- activa o desactiva determinados controles
	\end */
	switch (fN) {
		case "estado": 
			this.iface.controlEstado();
			break;
	}
}

/** \D Realiza la importación de un correo electrónico desde un fichero en disco
parseando el contenido para rellenar los campos del registro
\end */
function oficial_importarMail() 
{
	var util:FLUtil = new FLUtil();
	
	var cursor:FLSqlCursor = this.cursor();
	var archivo:String = FileDialog.getOpenFileName("*", util.translate("scripts","Elegir Fichero"));
			
	if (!archivo)
		return;
		
	var file = new File( archivo );
	
	try {
		file.open( File.ReadOnly );
	}
	catch (e) {
		return false;
	}
	
	var arrayLineas:Array;
	var numLineas:Number = 0;
	var texto:String = "";
	var tipoCodificacion:String = "";
	while(!file.eof){
		var linea:String = file.readLine();
		if(linea.find("charset=") != -1 ){
			if(linea.find("utf-8") != -1)
				tipoCodificacion = "utf-8";
			if(linea.find("iso-8859-1") != -1)
				tipoCodificacion = "iso-8859-1";
			if(linea.find("us-ascii") != -1)
				tipoCodificacion = "us-ascii";
		}
	}
	
	file.close();
	
	file = new File( archivo );
	
	try {
		file.open( File.ReadOnly );
	}
	catch (e) {
		return false;
	}
	
	while (!file.eof){
		switch (this.iface.procesarFichero(file,arrayLineas,numLineas))
		{
			case "from":
				arrayLineas[0] = this.iface.corregirCadena(tipoCodificacion,arrayLineas[0]);
				this.child("fdbEnviadoPor").setValue(arrayLineas[0]);
				break;
			case "to":
				arrayLineas[0] = this.iface.corregirCadena(tipoCodificacion,arrayLineas[0]);
				this.child("fdbPara").setValue(arrayLineas[0]);
				break;
			case "subject":
				arrayLineas[0] = this.iface.corregirCadena(tipoCodificacion,arrayLineas[0]);
				this.child("fdbAsunto").setValue(arrayLineas[0]);
				break;
					
			case "texto": 
				for(i=0;i<arrayLineas.length;i++)
					texto += arrayLineas[i];
				texto = this.iface.corregirCadena(tipoCodificacion,texto);
				break;
			case "date":
				var fecha = new Date();
				this.child("fdbFecha").setValue(this.iface.extraerFecha(arrayLineas[0]));
				this.child("fdbHora").setValue(this.iface.extraerHora(arrayLineas[0]));
				break;
		}
	}

	this.child("txtTexto").text += texto;
	this.cursor().setValueBuffer("texto", texto);
	this.cursor().setValueBuffer("estado", "Recibido");
}


/** \D Crea los campos de texto necesarios para el correo: asunto, cuerpo,
destino, etc. Estos campos son pasados como parámetros al comando kmail. 
Para ejecutar el comando se introduce el mismo en un fichero ejecutable y se
ejecuta el mismo
\end */
function oficial_enviarMail()
{
	var util:FLUtil = new FLUtil();
	var adjuntos:String = "";

	this.setDisabled( false );
	
	var asunto:String = "\"" + this.cursor().valueBuffer("asunto") + "\"";
	
	var cuerpo:String = this.cursor().valueBuffer("texto");
	var patternRE:RegExp = new RegExp("\"");
	patternRE.global = true;
	cuerpo = cuerpo.replace(patternRE, "'");
	cuerpo = cuerpo + "\n\n\nUn saludo,";
	
	cuerpo = "\"" + cuerpo + "\"";
	
	var destinatario:String = this.child("fdbPara").value();
	
	var comando:String = flservppal.iface.pub_componerCorreo(destinatario, asunto, cuerpo, adjuntos);
	
	var rutaSer:String = util.readSettingEntry("scripts/flservppal/dirServicios");
	var fichProceso = rutaSer + "principal/packets/comandomail";
	var f = new File(fichProceso);
	f.open(File.WriteOnly);
	f.write(comando);
	f.close();
	
	this.iface.procesoMail = new FLProcess(fichProceso);
 	connect(this.iface.procesoMail, "exited()", this, "iface.mailEnviado");
   	this.iface.procesoMail.start();
}

/** \D Una vez enviado el mail, se actualizan los campos de --fecha--, --hora-- y --estado--
\end */
function oficial_mailEnviado()
{
	var util:FLUtil = new FLUtil();
	var res = MessageBox.information(util.translate("scripts", "Pulse \"Aceptar\" DESPUÉS de enviar el mensaje correctamente"),
			MessageBox.Ok, MessageBox.Cancel, MessageBox.NoButton);
	
	this.setDisabled( false );
	
	if (res == MessageBox.Ok) {
		var hoy = new Date();
		
		var ahora:String = hoy.toString().mid(11, 5);
		this.cursor().setValueBuffer("fecha", hoy);
		this.cursor().setValueBuffer("hora", ahora);
		this.cursor().setValueBuffer("estado", "Enviado");
		this.accept();
	}
}

/** \D Toma una cadena de caracteres y sustituye los caracteres extraños por
los normales
@param cadena Cadena de texto a corregir
@param tipoCodificacion Tipo de codificación utilizada
@return Cadena de texto corregida
\end */
function oficial_corregirCadena(tipoCodificacion:String,cadena:String):String
{
	var array:Array = new Array;
	
	switch (tipoCodificacion){
		case "utf-8":{
			array = [["=C3=B3","ó"],["=C3=A9","é"],
					["=C3=A1","á"],["=C3=AD","í"],
					["=C3=BA","ú"],["=?utf-8?Q?",""],
					["3D",""],["=20",""],
					["=C3=B1","ñ"],["=\n",""],
					["?="," "],["=BF","¿"],
					["=C2",""],["utf-8?Q?",""]];
			break;
		}
		default:{
			array = [["=?",""],["=3D","="],
				 ["iso-8859-15?q?",""],["=26","&"],
				 ["iso-8859-1?q?",""],["=24","$"],
				 ["=D1","Ñ"],["=BF","¿"],
				 ["?=",""],["=3F","?"],
				 ["=F1","ñ"],["=A1","¡"],
				 ["=E1","á"],["=5B","["],
				 ["=C1","Á"],["=5D","]"],
				 ["=E9","é"],["=7B","{"],
				 ["=C9","É"],["=7D","}"],
				 ["=F3","ó"],["=5F","_"],
				 ["=ED","í"],["=5C","\\"],
				 ["=CD","Í"],["iso-8859-1?b?3A==","Ü"],
				 ["=D3","Ó"],["iso-8859-1?b?ug==","º"],
				 ["=FA","ú"],["iso-8859-1?b?qg==","ª"],
				 ["=DA","Ú"],["iso-8859-1?b?/A==","ü"],
				 ["=23","#"],["=25","%"],
				 ["=20"," "],["=2D",""],
				 ["=E7","ç"],["=B7","·"],
				 ["=46","F"],["ISO-8859-1?Q?",""]];
		}
	}

	var cadenaAux:String = cadena;

	 while (1 == 1) {
		for (i=0;i<array.length;i++) {
			var indice:Number;
			do {
				indice = cadena.find(array[i][0]);
				if (indice >= 0)
					cadena = cadena.replace(array[i][0],array[i][1]);
			} while ( indice >= 0)
		}

		if (cadena == cadenaAux)
			return cadena;

		cadenaAux = cadena;
	}
}


/** \D Convierte la fecha contenida en el fichero de correo electrónico en
un objeto fecha
@param cadena Texto con la fecha
@return Objeto fecha correspondiente
\end */
function oficial_extraerFecha(cadena:String):Date
{
	var fecha = new Date();
	
	var dia:String = cadena.mid(5,2);
	var i:Number = 0;
	if(dia.find(" ") != -1){
		dia = dia.left(1);	
		dia = "0" + dia;
		i=1;
	}	
	var aux:String = cadena.mid(8-i,3);
	var mes:Number = this.iface.convertirMes(aux);
	var anio:Number = cadena.mid(12-i,4);
	
	fecha.setDate(dia);
	fecha.setMonth(mes);
	fecha.setYear(anio);
	
	return fecha;
}


/** \D Convierte la hora contenida en el fichero de correo electrónico en
una cadena con formato de hora HH:MM:SS
@param cadena Texto con la hora
@return Texto con la hora convertida
\end */
function oficial_extraerHora(cadena:String):String
{
	var hora = String
	
	var dia:String = cadena.mid(5,2);
	var i:Number = 0;
	if(dia.find(" ") != -1)
		i=1;
		
	var hora:Number = cadena.mid(17-i,2);
	var min:Number = cadena.mid(20-i,2);
	var seg:Number = cadena.mid(23-i,2);
	hora = hora+ ":" + min + ":" + seg;
	
	return hora;
}

/** \D Convierte la fecha/hora contenida en el fichero de correo electrónico en
una cadena con formato de fecha/hora YYYY:MM:DD-THH:MM:SS
@param cadena Texto con la hora
@return Texto con la hora convertida
\end */
function oficial_extraerFechaHora(cadena:String):String
{
	var fecha:String;
	
	var dia:String = cadena.mid(5,2);
	var i:Number = 0;
	if(dia.find(" ") != -1){
	dia = dia.left(1);
	dia = "0" + dia;
		i=1;
	}
	
	var aux:String = cadena.mid(8 - i,3);
	var mes:Number = this.iface.convertirMes(aux);
	var anio:Number = cadena.mid(12 - i,4);
	
	fecha = anio + "-" + mes + "-" + dia + "T";
	
	var hora:Number = cadena.mid(17 - i,2);
	var min:Number = cadena.mid(20 - i,2);
	var seg:Number = cadena.mid(23 - i,2);
	
	fecha += hora + ":" + min + ":" + seg;
		
	return fecha;
}

/** \D Convierte el código de mes en un número de dos cifras
@param cadena Código del mes con formato MMM
@return Número de dos cifras con el código del mes
\end */
function oficial_convertirMes(cadena:String):String
{
	switch (cadena)
	{
		case "Jan": return "01";
		case "Feb": return "02";
		case "Mar": return "03";
		case "Apr": return "04";
		case "May": return "05";
		case "Jun": return "06";
		case "Jul": return "07";
		case "Aug": return "08";
		case "Sep": return "09";
		case "Oct": return "10";
		case "Nov": return "11";
		case "Dec": return "12";
	}
}


/** \D Lee el fichero del correo electrónico y lo procesa
\end */
function oficial_procesarFichero(file,arrayLineas,numLineas):String
{
	var tipoDato:String = "";
	var linea:String = "";
	var lineaBuffer:String = "";
	var paso:Number = 0;
	
	while (!file.eof) {
		lineaBuffer = file.readLine();
		linea = lineaBuffer;
		if(linea.find("From:") == 0){
		arrayLineas[0]= linea.substring(6);
			numLineas = 1;
			tipoDato = "from";
			return tipoDato;
		}
		if(linea.find("To:") == 0){
			arrayLineas[0]= linea.substring(4);
			numLineas = 1;
			tipoDato = "to";
			return tipoDato;
		}
		if(linea.find("Subject:") == 0){
			arrayLineas[0]= linea.substring(9);
			numLineas = 1;
			tipoDato = "subject";
			return tipoDato;
		}
		if(linea.find("Date:") == 0){
			arrayLineas[0]= linea.substring(6);
			numLineas = 1;
			tipoDato = "date";
			return tipoDato;
		}
		if(linea.find("X-KMail-MDN-Sent:") == 0 || linea.find("X-Length:") == 0){
			var boundaryEncontrado:Number = 0
			while (!file.eof && boundaryEncontrado <= 1){
				lineaBuffer = file.readLine();
				if(lineaBuffer.find("--Boundary") == 0){
					boundaryEncontrado++;
					if (boundaryEncontrado == 1){
						var i:Number = 0;
						while(i< 6 && !file.eof){
							lineaBuffer = file.readLine();
							i++;
						}
					}
				}
				if(boundaryEncontrado <= 1){
					linea = lineaBuffer;
					arrayLineas[numLineas] = linea;
					numLineas++;
				}
			}
			tipoDato = "texto";
			return tipoDato;
		}
	}
		
}

/** \D Bloquea la edición de determinados controles en función del
estado de la comunicación
\end */
function oficial_controlEstado() 
{
	switch(this.cursor().valueBuffer("estado")) {	
		case "Nuevo":
			bloqueo = false;
		break;
		default:
			bloqueo = true;
	}
	
	this.child("pbnEnviarMail").setDisabled(bloqueo);
	this.child("fdbEnviadoPor").setDisabled(bloqueo);
	this.child("fdbPara").setDisabled(bloqueo);
	this.child("fdbAsunto").setDisabled(bloqueo);
	this.child("fdbFecha").setDisabled(bloqueo);
	this.child("fdbHora").setDisabled(bloqueo);
}


/** \D Cuando la comunicación se crea como respuesta a una comunicación previa,
se establece el destinatario como el remitente anterior y se prepara el texto
del cuerpo como el cuerpo del mensaje anterior como cita. Para ello usamos la
variable scripts/flservppal/codigoComResp
\end */
function oficial_establecerRespuesta()
{
	var util:FLUtil = new FLUtil();
 	var codResponderA = util.readSettingEntry("scripts/flservppal/codigoComResp");
	
	if (codResponderA == 0) return;
 	util.writeSettingEntry("scripts/flservppal/codigoComResp", 0);
	
	var cursor = this.cursor();	
	
	var curCom:FLSqlCursor = new FLSqlCursor("se_comunicaciones");
	curCom.select("codigo = '" + codResponderA + "'");
	
	if (curCom.first()) {
		
		var nuevoTexto:String = 
					"\n\nEl día " + curCom.valueBuffer("fecha") + 
				" " + curCom.valueBuffer("enviadopor") + 
 				" escribió:\n\n";
		
		var lineas = curCom.valueBuffer("texto");
		lineas = lineas.split("\n");
		for(i=0; i<lineas.length; i++) nuevoTexto += "> " + lineas[i] + "\n";
		
		cursor.setValueBuffer("texto", nuevoTexto);
		cursor.setValueBuffer("asunto", "Re: " + curCom.valueBuffer("asunto"));
	}
}

/** \D Toma como remitente de la comunicación el usuario que esté establecido
en las preferencias del módulo
\end */
function oficial_crearRemitente():String
{
	var util:FLUtil = new FLUtil();
	
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("se_usuarios");
	q.setFrom("se_usuarios");
	q.setSelect("nombre,email");
	q.setWhere("codigo = '" + util.readSettingEntry("scripts/flservppal/codusuario") + "'");
	
	if (!q.exec()) return;
	if (q.first())  
		return q.value(0) + " <" + q.value(1) + ">"; 
		
	return "";
}

/** \D Busca el destinatario en la tabla de clientes. Cuando hay varios 
contactos en la agenda del cliente permite seleccionar uno de ellos
\end */
function oficial_selecDestinatario()
{
	var util:FLUtil = new FLUtil();
	var arrayMails:Array = [];
	var emailPrincipal:String = util.sqlSelect("clientes", "email", "codcliente = '" + this.child("fdbCodCliente").value() + "'");
	var nombrePrincipal:String = util.sqlSelect("clientes", "nombre", "codcliente = '" + this.child("fdbCodCliente").value() + "'");
			
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("contactosclientes,crm_contactos");
	q.setFrom("contactosclientes INNER JOIN crm_contactos ON contactosclientes.codcontacto = crm_contactos.codcontacto");
	q.setSelect("crm_contactos.email,crm_contactos.nombre");
	q.setWhere("contactosclientes.codcliente = '" + this.child("fdbCodCliente").value() + "' AND (crm_contactos.email <> '' AND crm_contactos.email IS NOT NULL)");
	if (!q.exec()) return false;
	
	var dialog = new Dialog(util.translate ( "scripts", "Contactos del cliente" ), 0);
	dialog.caption = "Selecciona el destinatario";
	dialog.OKButtonText = util.translate ( "scripts", "Aceptar" );
	dialog.cancelButtonText = util.translate ( "scripts", "Cancelar" );
	
	var bgroup:GroupBox = new GroupBox;
	dialog.add( bgroup );
	var cB:Array = [];
	var nEmails:Number = 0;	
	
	cB[nEmails] = new CheckBox;
	cB[nEmails].text = util.translate ( "scripts", nombrePrincipal + " (" + emailPrincipal + ")");
	arrayMails[nEmails] = emailPrincipal;
	cB[nEmails].checked = true;
	bgroup.add( cB[nEmails] );
	nEmails ++;
	
	while (q.next())  {
		cB[nEmails] = new CheckBox;
		cB[nEmails].text = util.translate ( "scripts", q.value(1) + " (" + q.value(0) + ")");
		arrayMails[nEmails] = q.value(0);
		cB[nEmails].checked = false;
		bgroup.add( cB[nEmails] );
		nEmails ++;
	}
	if (nEmails > 1){
		nEmails --;
		var lista:String = "";
		if(dialog.exec()) {
			for (var i:Number = 0; i <= nEmails; i++)
				if (cB[i].checked == true)
					lista += arrayMails[i] + ",";
		}
		else
			return;
		lista = lista.left(lista.length -1)
		if (lista == "")
			return;
		this.child("fdbPara").setValue(lista);
	}
	else
		this.child("fdbPara").setValue(emailPrincipal);
	
}

/** \D Carga el texto de una plantilla al final del contenido del mensaje
*/
function oficial_insertarPlantillaTexto() 
{
	var util:FLUtil = new FLUtil();
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("se_plantillastexto");
	q.setFrom("se_plantillastexto");
	q.setSelect("descripcion,texto");
	q.setWhere("1 = 1");
	
	if (!q.exec()) return;
	
	var dialog = new Dialog(util.translate ( "scripts", "Plantillas" ), 0);
	dialog.caption = "Selecciona la plantilla";
	dialog.OKButtonText = util.translate ( "scripts", "Aceptar" );
	dialog.cancelButtonText = util.translate ( "scripts", "Cancelar" );
	
	var bgroup:GroupBox = new GroupBox;
	dialog.add( bgroup );
	var cB:Array = [];
	var nPlan:Number = 0;
	
	while (q.next())  {
		cB[nPlan] = new RadioButton;
		cB[nPlan].text = util.translate ( "scripts", q.value(0));
		cB[nPlan].checked = false;
		bgroup.add( cB[nPlan] );
		nPlan ++;
	}
	if (nPlan > 0){
		nPlan --;
		if(dialog.exec()) {
			if(!q.first())
				return false;
			for (var i:Number = 0; i <= nPlan; i++){
				if (cB[i].checked == true){
					var texto:String = q.value(1);
					texto = this.cursor().valueBuffer("texto") + "\n\n\n---------------------------------------\n\n" + texto;
					this.cursor().setValueBuffer("texto", texto);
					this.child("txtTexto").text += texto;
					return;
				}
				q.next();
			}
		}
		else
			return;
	}

// 	var curPlan:FLSqlCursor = new FLSqlCursor("se_plantillastexto");
// 	var formPlan:Object = new FLFormSearchDB("se_plantillastexto");
// 	formPlan.setCursor(curPlan);
// 	formPlan.setMainWidget();
// 	
// 	var texto:String = formPlan.exec("texto");
// 	texto = this.cursor().valueBuffer("texto") + "\n\n\n---------------------------------------\n\n" + texto;
// 	this.cursor().setValueBuffer("texto", texto);
// 	this.child("txtTexto").text = texto;
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
