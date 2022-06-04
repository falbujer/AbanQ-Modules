/***************************************************************************
                 se_incidencias.qs  -  description
                             -------------------
    begin                : lun jun 20 2005
    copyright            : (C) 2005 by InfoSiAL S.L.
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
	function calculateField(fN:String):String {
		return this.ctx.interna_calculateField(fN);
	}
    function validateForm() {
		return this.ctx.interna_validateForm();
	}
	function calculateCounter() {
		return this.ctx.interna_calculateCounter();
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var precioHora:Number;
	var bloqueoHoras_:Boolean;
	var bloqueoEstado_:Boolean;
	function oficial( context ) { interna( context ); } 
	function editarSolucion() { return this.ctx.oficial_editarSolucion(); }
	function responderMail() { return this.ctx.oficial_responderMail(); }
	function controlCampos() { return this.ctx.oficial_controlCampos(); }
	function calcularHorasReales() { 
		return this.ctx.oficial_calcularHorasReales(); 
	}
	function desconectar() {
		return this.ctx.oficial_desconectar();
	}
	function filtrarContactos() {
		return this.ctx.oficial_filtrarContactos();
	}
// 	function accionesAutomaticas() {
// 		return this.ctx.oficial_accionesAutomaticas();
// 	}
	function notificarCambioEstado() {
		return this.ctx.oficial_notificarCambioEstado();
	}
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function pedirFecha(titulo:String, etiqueta:String, valorDefecto:Date):Date {
		return this.ctx.oficial_pedirFecha(titulo, etiqueta, valorDefecto);
	}
	function tdbComunicaciones_bufferCommited() {
		return this.ctx.oficial_tdbComunicaciones_bufferCommited();
	}
// 	function realizarAccionAutomatica(accion:Array):Boolean {
// 		return this.ctx.oficial_realizarAccionAutomatica(accion);
// 	}
	function tdbHorasFacturadas_bufferCommited() {
		return this.ctx.oficial_tdbHorasFacturadas_bufferCommited();
	}
	function tdbHorasTrabajadas_bufferCommited() {
		return this.ctx.oficial_tdbHorasTrabajadas_bufferCommited();
	}
	function commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.ctx.oficial_commonCalculateField(fN, cursor);
	}
	function formReady() {
		return this.ctx.oficial_formReady();
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends oficial {
    function head( context ) { oficial ( context ); }
    function pub_commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.commonCalculateField(fN, cursor);
	}
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
function interna_calculateCounter()
{
	var util:FLUtil = new FLUtil();
	var siguienteCodigo:String = flservppal.iface.pub_siguienteSecuencia("se_incidencias","codigo",6);
	return siguienteCodigo
}
/** \C
Las incidencias s�lo podr�n crearse desde un subproyecto o per�odo de actualizacion

Cuando la incidencia sea creada a partir de un subproyecto, el campo --idpactualizacion--
ser� deshabilitado

Cuando la incidencia sea creada a partir de un per�odo de actualizacion, el campo --codsubproyecto--
ser� deshabilitado

Para las nuevas incidencias, el --codcliente-- ser� asignado autom�ticamente a partir del per�odo de actualizacion o subproyecto al que pertenezca la incidencia

\end */
function interna_init()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	
	this.iface.bloqueoHoras_ = false;
	this.iface.bloqueoEstado_ = false;
	
	if (cursor.modeAccess() == cursor.Insert) {
		this.child("fdbCodEncargado").setValue(sys.nameUser());
		cursor.setValueBuffer("codigo",this.iface.calculateCounter());
		var curRel:FLSqlCursor = cursor.cursorRelation();
		if (curRel) {
			switch (curRel.table()) {
				case "se_subproyectos": {
					this.child("fdbCodFuncional").setValue(util.sqlSelect("se_proyectos", "codfuncional", "codigo = '"+ curRel.valueBuffer("codproyecto") + "'"));
					this.child("fdbCodProyecto").setValue(curRel.valueBuffer("codproyecto"));
					this.child("fdbCodCliente").setValue(curRel.valueBuffer("codcliente"));
					this.child("fdbCodContacto").setValue(curRel.valueBuffer("codcontacto"));
					this.child("fdbCodFuncional").setDisabled(true);
					this.child("fdbCodProyecto").setDisabled(true);
					this.child("fdbCodCliente").setDisabled(true);
					break;
				}
				case "se_proyectos": {
					this.child("fdbCodFuncional").setValue(curRel.valueBuffer("codfuncional"));
					this.child("fdbCodCliente").setValue(curRel.valueBuffer("codcliente"));
					this.child("fdbCodFuncional").setDisabled(true);
					this.child("fdbCodCliente").setDisabled(true);
					break;
				}
				case "clientes": {
					this.child("tbwIncidencias").setTabEnabled("envios", false);
					break;
				}
			}
		}
	}
	
	if (cursor.modeAccess() == cursor.Edit) {
		this.iface.controlCampos();
	}
	
	this.child("fdbIdPActualizacion").setDisabled(true);
	
	
	var estado:String = cursor.valueBuffer("estado");
	if (estado != "Resuelta") {
		this.child("fdbFechaCierre").setDisabled(true);
		this.child("pbnEditarSolucion").setDisabled(true);
	}
	
	this.child("fdbPublico").setDisabled(true);

	connect( this.child("pbnEditarSolucion"), "clicked()", this, "iface.editarSolucion" );
	connect( this.child("pbnResponder"), "clicked()", this, "iface.responderMail" );
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this, "closed()", this, "iface.desconectar");
	connect(this.child("tdbComunicaciones").cursor(), "bufferCommited()", this, "iface.tdbComunicaciones_bufferCommited");
	connect(this.child("tdbHorasFacturadas").cursor(), "bufferCommited()", this, "iface.tdbHorasFacturadas_bufferCommited");
	connect(this.child("tdbHorasTrabajadas").cursor(), "bufferCommited()", this, "iface.tdbHorasTrabajadas_bufferCommited");
	connect(this, "formReady()", this, "iface.formReady");
	
	this.iface.filtrarContactos();
	this.child("fdbIdFactura").setFilter("codcliente = '" + cursor.valueBuffer("codcliente") + "'");
	
	this.iface.precioHora = parseFloat(util.sqlSelect("se_opciones INNER JOIN articulos ON se_opciones.refcostehora = articulos.referencia", "articulos.pvp", "1 = 1", "se_opciones,articulos"));

	
}

function interna_calculateField(fN:String):String
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();
	var valor:String;

	switch(fN) {
		/** \D
		El --codcliente-- se hereda del subproyecto o de la actualizaci�n correspondiente dependiendo de donde provenga incidencia
		\end */
		case "codcliente": {
			var codSubproyecto:String = this.child("fdbCodSubproyecto").value();
			var idPActualizacion:Number = this.child("fdbIdPActualizacion").value();
			var codCliente:String;
			
			if (codSubproyecto) {
				valor = util.sqlSelect("se_subproyectos", "codcliente", "codigo = '" + codSubproyecto + "'")
			}
			
			if (idPActualizacion) {
				valor = util.sqlSelect("se_pactualizacion", "codcliente", "id = '" + idPActualizacion + "'")
			}
			break;
		}
		case "precio":
		case "horas":
		case "horastrab":
		case "beneficiohora": {
			valor = this.iface.commonCalculateField(fN, cursor);
			break;
		}
		case "codfuncional": {
			var curRel:FLSqlCursor = cursor.cursorRelation();
			if (curRel && curRel.table() == "se_subproyectos") {
				valor = curRel.valueBuffer("dirlocal");
			} else {
				valor = util.sqlSelect("se_subproyectos", "dirlocal", "codigo = '" + cursor.valueBuffer("codsubproyecto") + "'");
			}
			if (valor && valor.toString().length > 1) {
				valor = valor.left(valor.length - 1);
			}
			break;
		}
		case "horasporhacer": {
			valor = parseFloat(cursor.valueBuffer("horasplan")) - parseFloat(cursor.valueBuffer("horashechas"));
			break;
		}
		case "horashechas": {
			valor = parseFloat(cursor.valueBuffer("horasplan")) - parseFloat(cursor.valueBuffer("horasporhacer"));
			break;
		}
		case "atiempo": {
			if (cursor.isNull("fechaplan") || cursor.isNull("fechaestimada")) {
				valor = true;
			} else {
				if (util.daysTo(cursor.valueBuffer("fechaestimada"), cursor.valueBuffer("fechaplan")) < 0) {
					valor = false;
				} else {
					valor = true;
				}
			}
		}
	}
	return valor;
}


/** \C
La --fechaapertura-- no puede ser posterior a la --fechacierre--
\end */
function interna_validateForm()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	
	var fechaApertura:String = cursor.valueBuffer("fechaapertura");
	var fechaCierre:String = cursor.valueBuffer("fechacierre");
	var estado:String = cursor.valueBuffer("estado");
	var precio:Number = cursor.valueBuffer("precio");
	var tipo:String = cursor.valueBuffer("tipo");
	
	if (tipo == "Compra de creditos" && precio <=0) {
		MessageBox.warning(util.translate("scripts","La compra de cr�ditos ha de tener un valor de cr�ditos positivo"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
	
	if (tipo == "Pago con creditos" && precio >=0) {
		MessageBox.warning(util.translate("scripts","El pago con creditos cr�ditos ha de tener un valor de cr�ditos negativo"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
	
	if (fechaCierre < fechaApertura && estado == "Resuelta") {
		MessageBox.warning(util.translate("scripts","La fecha de cierre no puede ser anterior a la fecha de apertura"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}

	if (parseFloat(cursor.valueBuffer("precio")) < 0 && !cursor.valueBuffer("enbolsa")) {
		var res:Number = MessageBox.warning(util.translate("scripts","Has establecido un precio negativo.\n�Vas a incluir la incidencia en una bolsa de horas?"), MessageBox.Yes, MessageBox.No);
		if (res != MessageBox.No)
			return false;
	}

	

	return true;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_formReady()
{
	debug("oficial_formReady");
	flservppal.iface.pub_accionesAutomaticas(this);
}

/** \D Abre la ventana de edici�n del texto de la soluci�n. Al final
del texto a�ade las marcas de soluci�n para que el usuario escriba 
debajo el contenido de dicha soluci�n
\end */
function oficial_editarSolucion() 
{	
	var cursor = this.cursor();

	var contenido:String = "";
	
	var nuevoTexto:String = this.cursor().valueBuffer( "descripcion" ) + 
				"\n\n=============================================" + 
				"\nSOLUCION \n" + 
				"=============================================\n\n";

		this.child( "txtTexto" ).text = nuevoTexto;
		this.cursor().setValueBuffer("descripcion", nuevoTexto);
}


/** \D Lanza la respuesta a una comunicaci�n seleccionada en el formulario maestro.
El id de dicha comunicacion queda registrado en la variable codigoConResp, y a continuaci�n
se abre el formulario de inserci�n de una nueva comunicaci�n.
\end */
function oficial_responderMail()
{
	var util:FLUtil = new FLUtil();
	var curCom:FLSqlCursor = this.child("tdbComunicaciones").cursor();	

 	util.writeSettingEntry("scripts/flservppal/codigoComResp", curCom.valueBuffer("codigo"));
	
	this.child("toolButtomInsertCom").animateClick();
}


function oficial_bufferChanged(fN:String)
{ 
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	
/** \C Cuando el --estado-- de la incidencia es "Resuelta" se habilita 
--fechacierre-- y �sta se establece a la fecha actual. Tambi�n se habilita el bot�n
de insertar soculi�n
\end */
	switch (fN) {
		case "estado": {
			var estado:String = cursor.valueBuffer("estado");
			switch (estado) {
				case "Resuelta": {
					var hoy = new Date();
					this.child("pbnEditarSolucion").setDisabled(false);
					this.child("fdbFechaCierre").setDisabled(false);
					this.child("fdbFechaCierre").setValue(hoy);
					this.child("fdbFechaRevision").setValue("NULL");
					break;
				}
				case "En espera":
				case "En pruebas": {
					var hoy = new Date();
					var fechaRevision:Date = cursor.valueBuffer("fecharevision");
					if (!fechaRevision || util.daysTo(fechaRevision, hoy) >= 0) {
						fechaRevision = this.iface.pedirFecha(util.translate("scripts", "Fecha de pr�xima revisi�n"), util.translate("scripts", "Fecha"), hoy);
						if (fechaRevision) {
							this.child("fdbFechaRevision").setValue(fechaRevision);
						}
					}

					this.child("fdbFechaCierre").setDisabled(true);
					this.child("pbnEditarSolucion").setDisabled(true);
					break;
				}
				default: {
					this.child("fdbFechaCierre").setDisabled(true);
					this.child("pbnEditarSolucion").setDisabled(true);
					this.child("fdbFechaRevision").setValue("NULL");
				}
			}
			flservppal.iface.pub_sincronizarProcesoIncidencia(cursor);
			if (!this.iface.bloqueoEstado_) {
				if (!this.iface.notificarCambioEstado()) {
					return;
				}
			}
			break;
		}
		/** \C Cuando el tipo de incidencia no es una mejora �sta no puede facturarse
		\end */
		case "tipo" :
			this.iface.controlCampos();
			break;
		/** \C Si la incidencia ya est� facturada no se podr� cambiar el n�mero de horas
		\end */
		case "idfactura": {
/*
			if(cursor.valueBuffer("idfactura"))
				this.child("fdbHoras").setDisabled(true);
*/
			break;
		}
		case "horas": {
			this.child("fdbPrecio").setValue(this.iface.calculateField("precio"));
			break;
		}
		case "enbolsa": {
			this.child("fdbPublico").setValue(cursor.valueBuffer("enbolsa"));
			break;
		}
		case "codsubproyecto": {
			this.child("fdbCodFuncional").setValue(this.iface.calculateField("codfuncional"));
			break;
		}
		case "horasplan":
		case "horashechas":{
			if (!this.iface.bloqueoHoras_) {
				this.iface.bloqueoHoras_ = true;
				this.child("fdbHorasPorHacer").setValue(this.iface.calculateField("horasporhacer"));
				this.iface.bloqueoHoras_ = false;
			}
			break;
		}
		case "horasporhacer": {
			if (!this.iface.bloqueoHoras_) {
				this.iface.bloqueoHoras_ = true;
				this.child("fdbHorasHechas").setValue(this.iface.calculateField("horashechas"));
				this.iface.bloqueoHoras_ = false;
			}
			break;
		}
		case "fechaplan":
		case "fechaestimada":{
			this.child("fdbATiempo").setValue(this.iface.calculateField("atiempo"));
			break;
		}
		case "codcliente": {
			this.iface.filtrarContactos();
			break;
		}
	}
}

/** \D Crea un di�logo que pide una fecha al usuario
@param	titulo: T�tulo de la groupbox que contiene la fecha
@param	etiqueta: Etiqueta del control fecha
@param	valorDefecto: Valor por defecto del control fecha
@return Fecha indicada por el usuario o false si cancela
\end */
function oficial_pedirFecha(titulo:String, etiqueta:String, valorDefecto:Date):Date
{
	var util:FLUtil = new FLUtil;

	var dialogo:Dialog = new Dialog;
	dialogo.okButtonText = util.translate("scripts", "Aceptar");
	dialogo.cancelButtonText = util.translate("scripts", "Cancelar");

	var gbxContenedor:GroupBox = new GroupBox;
	gbxContenedor.title = titulo;
	dialogo.add(gbxContenedor);

	var dedFecha:DateEdit = new DateEdit;
	dedFecha.label = etiqueta;
	if (valorDefecto) {
		dedFecha.date = valorDefecto;
	}
	gbxContenedor.add(dedFecha);

	if (!dialogo.exec()) {
		return false;
	}
	return dedFecha.date;
}

function oficial_controlCampos()
{
	var cursor:FLSqlCursor = this.cursor();
	
	switch(cursor.valueBuffer("Tipo")) {
		
		case "Compra de creditos":	
			cursor.setValueBuffer("enbolsa", true);
			this.child("fdbIdFactura").setDisabled(false);
			this.child("fdbCodFactura").setDisabled(false);
			this.child("fdbEstado").setDisabled(true);
			this.child("fdbEnBolsa").setDisabled(true);
			
			cursor.setValueBuffer("estado", "Resuelta");
			cursor.setValueBuffer("enbolsa", true);
		break;
	
		case "Pago con creditos":	
			cursor.setValueBuffer("enbolsa", true);
			this.child("fdbIdFactura").setDisabled(true);
			this.child("fdbCodFactura").setDisabled(true);
			this.child("fdbIdPedido").setDisabled(false);
			this.child("fdbCodPedido").setDisabled(false);
			this.child("fdbEstado").setDisabled(true);
			this.child("fdbEnBolsa").setDisabled(true);
			
			cursor.setValueBuffer("estado", "Resuelta");
			cursor.setValueBuffer("enbolsa", true);
		break;
		
		default:
			this.child("fdbIdFactura").setDisabled(false);
			this.child("fdbCodFactura").setDisabled(false);
			this.child("fdbIdPedido").setDisabled(true);
			this.child("fdbCodPedido").setDisabled(true);
			this.child("fdbEstado").setDisabled(false);
			this.child("fdbEnBolsa").setDisabled(false);
	}
}

function oficial_desconectar()
{
	var cursor:FLSqlCursor = this.cursor();
	disconnect( this.child("pbnEditarSolucion"), "clicked()", this, "iface.editarSolucion" );
	disconnect( this.child("pbnResponder"), "clicked()", this, "iface.responderMail" );
	disconnect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	disconnect(this, "closed()", this, "desconectar");
}

function oficial_filtrarContactos()
{
	var cursor:FLSqlCursor = this.cursor();
	var codCliente:String = cursor.valueBuffer("codcliente");
	var filtro:String = "";
	if (codCliente && codCliente != "") {
		filtro = "codcontacto IN (SELECT codcontacto FROM contactosclientes WHERE codcliente = '" + codCliente + "')";
	}
	this.child("fdbCodContacto").setFilter(filtro); 
}

// function oficial_accionesAutomaticas()
// {
// debug("oficial_accionesAutomaticas");
// 	var util:FLUtil = new FLUtil;
// 	var cursor:FLSqlCursor = this.cursor();
// 	var acciones:Array = flcolaproc.iface.pub_accionesAuto();
// 	if (!acciones) {
// 		return;
// 	}
// 	var i:Number = 0;
// 	while (i < acciones.length && acciones[i]["usada"]) { i++; }
// 	if (i == acciones.length) {
// 		return;
// 	}
// 
// 	while (i < acciones.length && acciones[i]["contexto"] == "se_incidencias") {
// 		if (!this.iface.realizarAccionAutomatica(acciones[i])) {
// 			break;
// 		}
// 		i++;
// 	}
// }

/** \D Realizar una determinada acci�n.
@return: Se devuelve false si algo falla o si la acci�n implica que no debe realizarse ninguna acci�n subsiguiente en el contexto actual.
\end */ 
// function oficial_realizarAccionAutomatica(accion:Array):Boolean
// {
// 	var util:FLUtil = new FLUtil;
// 	var cursor:FLSqlCursor = this.cursor();
// 
// 	switch (accion["accion"]) {
// 		case "insertar_comunicacion": {
// 			accion["usada"] = true;
// 			var curComunicaciones:FLSqlCursor = this.child("tdbComunicaciones").cursor();
// 			curComunicaciones.insertRecord();
// 			break;
// 		}
// 		case "alta_automatica": {
// 			accion["usada"] = true;
// 			this.child("fdbDesccorta").setValue(accion["desccorta"]);
// 			break;
// 		}
// 		case "responder_comunicacion": {
// 			accion["usada"] = true;
// 			var opciones:Array = [util.translate("scripts", "No responder"),
// 				util.translate("scripts", "Pasar a EN ESPERA y responder"),
// 				util.translate("scripts", "Pasar a RESUELTA y responder"),
// 				util.translate("scripts", "Pasar a EN PRUEBAS y responder"),
// 				util.translate("scripts", "Pasar a EN DESARROLLO y responder")];
// 			var opcion:Number = flfactppal.iface.pub_elegirOpcion(opciones);
// 			if (opcion == -1) {
// 				break;
// 			}
// debug("opcion = " + opcion);
// 			var estado:String = "";
// 			switch (opcion) {
// 				case 0: { break; }
// 				case 1: { estado = "En espera"; break; }
// 				case 2: { estado = "Resuelta"; break; }
// 				case 3: { estado = "En pruebas"; break; }
// 				case 4: { estado = "En desarrollo"; break; }
// 			}
// 			if (estado != "") {
// 				this.iface.bloqueoEstado_ = true;
// 				cursor.setValueBuffer("estado", estado);
// 				this.iface.bloqueoEstado_ = false;
// 				this.child("pbnResponder").animateClick();
// 			}
// 			break;
// 		}
// 		default: {
// 			return false;
// 		}
// 	}
// 	return true;
// }

function oficial_notificarCambioEstado():Boolean
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	var estado:String = cursor.valueBuffer("estado");
	var codRecibido:String = util.sqlSelect("se_comunicaciones", "codigo", "codincidencia = '" + cursor.valueBuffer("codigo") + "' AND estado = 'Recibido' ORDER BY codigo DESC");

	var dialogo:Dialog = flservppal.iface.pub_dameDialogoD();
	var gbxGeneral:GroupBox = flservppal.iface.pub_dameGroupBoxD(util.translate("scripts", "Cambio a %1").arg(estado));
	dialogo.add(gbxGeneral);
	var chkNotificar:CheckBox;
	chkNotificar = flservppal.iface.pub_dameCheckBoxD(util.translate("scripts", "Notificar"));
	gbxGeneral.add(chkNotificar);
	var chkCitar:CheckBox;
	if (codRecibido) {
		chkCitar = flservppal.iface.pub_dameCheckBoxD(util.translate("scripts", "Citar �ltima comunicaci�n"));
		gbxGeneral.add(chkCitar);
	}
	
	if (!dialogo.exec()) {
		return false;
	}
	if (!chkNotificar.checked) {
		return false,
	}

	if (codRecibido && chkCitar.checked) {
		util.writeSettingEntry("scripts/flservppal/codigoComResp", codRecibido);
	}
	this.child("toolButtomInsertCom").animateClick();

// 	switch (estado) {
// 		case "Resuelta": {
// 			var res:Number = MessageBox.information(util.translate("scripts", "�Notificar resoluci�n?"), MessageBox.Yes, MessageBox.No);
// 			if (res == MessageBox.Yes) {
// 				var acciones:Array = [];
// 				acciones[0] = flcolaproc.iface.pub_arrayAccion("se_comunicaciones", "notificar_resolucion");
// 				flcolaproc.iface.pub_setAccionesAuto(acciones);
// 				this.child("toolButtomInsertCom").animateClick();
// 			}
// 			break;
// 		}
// 		case "En pruebas": {
// 			var res:Number = MessageBox.information(util.translate("scripts", "�Notificar paso a pruebas?"), MessageBox.Yes, MessageBox.No);
// 			if (res == MessageBox.Yes) {
// 				var acciones:Array = [];
// 				acciones[0] = flcolaproc.iface.pub_arrayAccion("se_comunicaciones", "notificar_pruebas");
// 				flcolaproc.iface.pub_setAccionesAuto(acciones);
// 				this.child("toolButtomInsertCom").animateClick();
// 			}
// 			break;
// 		}
// 	}
	return true;
}

function oficial_tdbComunicaciones_bufferCommited()
{
	flservppal.iface.pub_accionesAutomaticas(this);
	//this.iface.accionesAutomaticas();
}

function oficial_tdbHorasFacturadas_bufferCommited()
{
	this.child("fdbHoras").setValue(this.iface.calculateField("horas"));
	this.child("fdbHorasTrab").setValue(this.iface.calculateField("horastrab"));
	this.child("fdbBeneficioHora").setValue(this.iface.calculateField("beneficiohora"));
	this.child("fdbPrecio").setValue(this.iface.calculateField("precio"));
}

function oficial_tdbHorasTrabajadas_bufferCommited()
{
	this.child("fdbHorasTrab").setValue(this.iface.calculateField("horastrab"));
	this.child("fdbBeneficioHora").setValue(this.iface.calculateField("beneficiohora"));
}

function oficial_commonCalculateField(fN, cursor)
{
	var util:FLUtil = new FLUtil;
	var valor:String = "";
	switch (fN) {
		case "horas": {
			valor = util.sqlSelect("se_horasfacturadas", "SUM(horas)", "codincidencia = '" + cursor.valueBuffer("codigo") + "'");
			if (!valor || isNaN(valor)) {
				valor = 0;
			}
			break;
		}
		case "horastrab": {
			valor = util.sqlSelect("se_horastrabajadas", "SUM(horas)", "codincidencia = '" + cursor.valueBuffer("codigo") + "'");
			if (!valor || isNaN(valor)) {
				valor = 0;
			}
			break;
		}
		case "beneficiohora": {
			var hTrab:Number = parseFloat(cursor.valueBuffer("horastrab"));
			hTrab = isNaN(hTrab) ? 0 : hTrab;
			var hPres:Number = parseFloat(cursor.valueBuffer("horas"));
			hPres = isNaN(hPres) ? 0 : hPres;
			if (hPres == 0) {
				valor = -999;
			} else {
				valor = (hPres - hTrab) * 100 / hPres;
				valor = util.roundFieldValue(valor, "se_incidencias", "beneficiohora");
			}
			break;
		}
		case "precio": {
			valor = util.sqlSelect("se_horasfacturadas", "SUM(precio)", "codincidencia = '" + cursor.valueBuffer("codigo") + "'");
			if (!valor || isNaN(valor)) {
				valor = 0;
			}
			valor = valor * -1;
			break;
		}
		
	}
	return valor;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
