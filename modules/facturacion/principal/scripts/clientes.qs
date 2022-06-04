/***************************************************************************
                 clientes.qs  -  description
                             -------------------
    begin                : lun abr 26 2004
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
	function calculateCounter() { return this.ctx.interna_calculateCounter(); }
	function calculateField(fN) { return this.ctx.interna_calculateField(fN); }
	function validateForm() { return this.ctx.interna_validateForm(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var ejercicioActual:String;
	var longSubcuenta:String;
	var bloqueoSubcuenta:Boolean;
	var posActualPuntoSubcuenta:Number;
	var toolButtonInsertSub:Object;
	var toolButtonDelSub:Object;
	var toolButtonInsertContacto:Object;
	var toolButtonDeleteContacto:Object;
	var toolButtonDeleteContactoCliente:Object;
	var toolButtonInsertContactoCliente:Object;
	var toolButtonBuscarContacto:Object;
	var toolButtonEditContacto:Object;
	var tbnMayor:Object;
	var curContacto_:FLSqlCursor;

	function oficial( context ) { interna( context ); } 
	function cambiarDomFacturacion() {
		this.ctx.oficial_cambiarDomFacturacion();
	}
	function cambiarDomEnvio() {
		this.ctx.oficial_cambiarDomEnvio();
	}
	function cambiarDom(tipo) {
		this.ctx.oficial_cambiarDom(tipo);
	}
	function cargarDomFacturacion() {
		this.ctx.oficial_cargarDomFacturacion();
	}
	function bufferChanged(fN:String) {
		this.ctx.oficial_bufferChanged(fN);
	}
	function cambiarCuentaDom() {
		this.ctx.oficial_cambiarCuentaDom();
	}
	function controlRecibosDom() {
		this.ctx.oficial_controlRecibosDom();
	}
	function cambiarCuentaDomRecibosEmitidos() {
		this.ctx.oficial_cambiarCuentaDomRecibosEmitidos();
	}
	function borrarCuentaDom() {
		this.ctx.oficial_borrarCuentaDom();
	}
	function establecerSubcuenta() {
		this.ctx.oficial_establecerSubcuenta();
	}
	function toolButtonInsertSub_clicked() {
		this.ctx.oficial_toolButtonInsertSub_clicked();
	}
	function toolButtonDelSub_clicked() {
		this.ctx.oficial_toolButtonDelSub_clicked();
	}
	function imprimirPresupuesto() {
		this.ctx.oficial_imprimirPresupuesto();
	}
	function imprimirPedido() {
		this.ctx.oficial_imprimirPedido();
	}
	function imprimirAlbaran() {
		this.ctx.oficial_imprimirAlbaran();
	}
	function imprimirFactura() {
		this.ctx.oficial_imprimirFactura();
	}
	function imprimirRecibo() {
		this.ctx.oficial_imprimirRecibo();
	}
	function calcularSubcuentaCli(cursor:FLSqlCursor, longSubcuenta:Number) {
		return this.ctx.oficial_calcularSubcuentaCli(cursor, longSubcuenta);
	}
	function mostrarDesCuentaDom() {
		return this.ctx.oficial_mostrarDesCuentaDom();
	}
	function insertContacto(accion:String,codigo:String) {
		return this.ctx.oficial_insertContacto(accion,codigo);
	}
	function deleteContacto(codContacto:String, tabla:String, regAsociado:String) {
		return this.ctx.oficial_deleteContacto(codContacto, tabla, regAsociado);
	}
	function deleteContacto_clicked() {
		return this.ctx.oficial_deleteContacto_clicked();
	}
	function deleteContactoAsociado() {
		return this.ctx.oficial_deleteContactoAsociado();
	}
	function insertContactoAsociado(accion:String, codigo:String) {
		return this.ctx.oficial_insertContactoAsociado(accion, codigo);
	}
	function insertContactoAsociado_clicked() {
		return this.ctx.oficial_insertContactoAsociado_clicked();
	}
	function lanzarEdicionContacto() {
		return this.ctx.oficial_lanzarEdicionContacto();
	}
	function editarContacto(codContacto:String) {
		return this.ctx.oficial_editarContacto(codContacto);
	}
	function buscarContacto() {
		return this.ctx.oficial_buscarContacto();
	}
	function tbwCliente_currentChanged(nombre:String) {
		return this.ctx.oficial_tbwCliente_currentChanged(nombre);
	}
	function mostrarLibroMayor() {
		return this.ctx.oficial_mostrarLibroMayor();
	}
	function validarNifIva() {
		return this.ctx.oficial_validarNifIva();
	}
	function asociarContactoCliente() {
		return this.ctx.oficial_asociarContactoCliente();
	}
	function obtenerCodigoCliente(cursor:FLSqlCursor) {
		return this.ctx.oficial_obtenerCodigoCliente(cursor);
	}
	function validarDuplicidadCif() {
		return this.ctx.oficial_validarDuplicidadCif();
	}
  function validarCuentaDom() {
		return this.ctx.oficial_validarCuentaDom();
	}
	function commonCalculateField(fN, cursor) {
		return this.ctx.oficial_commonCalculateField(fN, cursor);
	}
	function tdbCuentas_bufferCommited() {
		return this.ctx.oficial_tdbCuentas_bufferCommited();
	}
	function tbnVerAsiento_clicked() {
		return this.ctx.oficial_tbnVerAsiento_clicked();
	}
	function iniciaVentas() {
		return this.ctx.oficial_iniciaVentas();
	}
	function columnasVentas() {
		return this.ctx.oficial_columnasVentas();
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
	function pub_calcularSubcuentaCli(cursor:FLSqlCursor, longSubcuenta:Number) {
		return this.calcularSubcuentaCli(cursor, longSubcuenta);
	}
	function pub_insertContacto(accion:String,codigo:String) {
		return this.insertContacto(accion,codigo);
	}
	function pub_deleteContacto(codContacto, tabla, regAsociado) {
		return this.deleteContacto(codContacto, tabla, regAsociado);
	}
	function pub_deleteContactoAsociado() {
		return this.deleteContactoAsociado();
	}
	function pub_insertContactoAsociado(accion:String,codigo:String) {
		return this.insertContactoAsociado(accion,codigo);
	}
	function pub_obtenerCodigoCliente(cursor:FLSqlCursor) {
		return this.obtenerCodigoCliente(cursor);
	}
	function pub_commonCalculateField(fN, cursor) {
		return this.commonCalculateField(fN, cursor);
	}
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
/** \D En el caso de el módulo principal de contabilidad esté cargado, el sistema actuará de la siguiente manera:

Al crearse un cliente se creará automáticamente una subcuenta asociada, cuyo código por defecto estará formado por	código de la cuenta especial de clientes + ceros de relleno para completar la longitud de subcuenta + código del cliente
\end */
function interna_init()
{
/** \C En la pestaña 'documentos' se encuentran los listados de documentos asociados al cliente. Todos estos datos se presentan en modo de solo lectura
 
Si está cargado el módulo de contabilidad, se habilita la pestaña 'contabilidad' del formulario

Cada cliente puede tener un conjunto de direcciones, de las cuales existen dos especiales. La dirección de facturación aparecerá por defecto en los documentos de facturación (albaranes, facturas, etc). La dirección de envío podrá utilizarse como dirección de destino postal o de paquetería. Una misma dirección puede ser de los dos tipos. No podrá haber más de una dirección de facturación ni de envío.

\end */
	var util= new FLUtil;
	var _i = this.iface;
	
	var cursor= this.cursor();
	if (sys.isLoadedModule("flfacturac")) {
		this.child("tdbFacturas").setEditOnly(true);
		this.child("tdbAlbaranes").setEditOnly(true);
		this.child("tdbPedidos").setEditOnly(true);
		this.child("tdbPresupuestos").setEditOnly(true);
	}
	if (sys.isLoadedModule("flfactteso")) {
		this.child("tdbRecibos").setEditOnly(true);
	}
	
	this.iface.toolButtonInsertContacto = this.child("toolButtonInsertContacto");
	this.iface.toolButtonDeleteContacto = this.child("toolButtonDeleteContacto");
	this.iface.toolButtonDeleteContactoCliente = this.child("toolButtonDeleteContactoCliente");
	this.iface.toolButtonInsertContactoCliente = this.child("toolButtonInsertContactoCliente");
	this.iface.toolButtonBuscarContacto = this.child("toolButtonBuscarContacto");
	this.iface.toolButtonEditContacto = this.child("toolButtonEditContacto");
	this.iface.tbnMayor = this.child("tbnMayor");
	
	this.iface.toolButtonInsertSub = this.child("toolButtonInsertSub");
	this.iface.toolButtonDelSub = this.child("toolButtonDeleteSub");
	
	this.iface.ejercicioActual = flfactppal.iface.pub_ejercicioActual();
	this.iface.longSubcuenta = util.sqlSelect("ejercicios", "longsubcuenta", "codejercicio = '" + this.iface.ejercicioActual + "'");
	this.iface.posActualPuntoSubcuenta = -1;

	connect(this.child("toolButtonPrintPre"), "clicked()", this, "iface.imprimirPresupuesto()");
	connect(this.child("toolButtonPrintPed"), "clicked()", this, "iface.imprimirPedido()");
	connect(this.child("toolButtonPrintAlb"), "clicked()", this, "iface.imprimirAlbaran()");
	connect(this.child("toolButtonPrintFac"), "clicked()", this, "iface.imprimirFactura()");
	connect(this.child("toolButtonPrintRec"), "clicked()", this, "iface.imprimirRecibo()");
	
	connect(this.child("pbDomFacturacion"), "clicked()", this, "iface.cambiarDomFacturacion()");
	connect(this.child("pbDomEnvio"), "clicked()", this, "iface.cambiarDomEnvio()");
	connect(this.child("tdbDirecciones").cursor(), "cursorUpdated()", this, "iface.cargarDomFacturacion()");
	connect(this.child("pbNuevoDomFacturacion"), "clicked()", this.child("tdbDirecciones"), "insertRecord()");
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
 	
	connect(this.child("tdbCuentas").cursor(), "bufferCommited()", _i, "tdbCuentas_bufferCommited");
	connect(this.child("pbnCuentaDom"), "clicked()", this, "iface.cambiarCuentaDom()");
	connect(this.child("pbnBorrarCuentaDom"), "clicked()", this, "iface.borrarCuentaDom()");
	this.child("gbxCuentaDom").setDisabled(true);
	
	connect(this.iface.toolButtonEditContacto, "clicked()", this, "iface.editarContacto()");
	connect(this.iface.toolButtonInsertContacto, "clicked()", this, "iface.insertContacto()");
	connect(this.iface.toolButtonDeleteContacto, "clicked()", this, "iface.deleteContacto_clicked()");
	connect(this.iface.toolButtonDeleteContactoCliente, "clicked()", this, "iface.deleteContactoAsociado()");
	connect(this.iface.toolButtonInsertContactoCliente, "clicked()", this, "iface.insertContactoAsociado_clicked()");
	connect(this.child("toolButtonEdit"), "clicked()", this, "iface.lanzarEdicionContacto()");
	connect(this.child("toolButtonBuscarContacto"), "clicked()", this, "iface.buscarContacto()");
	connect(this.iface.tbnMayor, "clicked()", this, "iface.mostrarLibroMayor()");
	connect(this.child("tbnVerAsiento"), "clicked()", _i, "tbnVerAsiento_clicked");

	this.child("tdbContactos").cursor().setMainFilter("codcontacto IN(SELECT codcontacto FROM contactosclientes WHERE codcliente = '" + cursor.valueBuffer("codcliente") + "')");
	this.child("tdbContactos").setReadOnly(false);

	/** \D Se carga el domicilio de facturación
	\end */
	this.iface.cargarDomFacturacion();

	/** \C En modo inserción, los campos --coddivisa--, --codpago--, --codcuentarem-- y --codserie-- toman los valores por defecto definidos para la empresa
	\end */
	if (cursor.modeAccess() == cursor.Insert) {
		cursor.setValueBuffer("coddivisa", flfactppal.iface.pub_valorDefectoEmpresa("coddivisa"));
		cursor.setValueBuffer("codpago", flfactppal.iface.pub_valorDefectoEmpresa("codpago"));
		cursor.setValueBuffer("codcuentarem", flfactppal.iface.pub_valorDefectoEmpresa("codcuentarem"));
		cursor.setValueBuffer("codserie", flfactppal.iface.pub_valorDefectoEmpresa("codserie"));
		if (sys.isLoadedModule("flcontppal"))
			this.iface.bufferChanged("codcliente");
	} else {
		this.iface.mostrarDesCuentaDom();
	}

	/** \C Si está cargado el módulo de contabilidad, se habilita la pestaña 'contabilidad' del formulario
	\end */
	if (sys.isLoadedModule("flcontppal")) {
		connect(this.child("tdbSubcuentas").cursor(), "newBuffer()", this, "iface.establecerSubcuenta()");
		connect(this.iface.toolButtonInsertSub, "clicked()", this, "iface.toolButtonInsertSub_clicked()");
		connect(this.iface.toolButtonDelSub, "clicked()", this, "iface.toolButtonDelSub_clicked()");
		this.iface.establecerSubcuenta();
		this.child("tdbPartidas").setReadOnly(true);
		this.child("tdbSubcuentas").setReadOnly(true);
	} else {
		this.child("tbwCliente").setTabEnabled("contabilidad", false);
	}
	
	/// Gestión documental
	if (sys.isLoadedModule("flcolagedo")) {
		var datosGD:Array;
		datosGD["txtRaiz"] = cursor.valueBuffer("codcliente") + ": " + cursor.valueBuffer("nombre");
		datosGD["tipoRaiz"] = "clientes";
		datosGD["idRaiz"] = cursor.valueBuffer("codcliente");
		flcolagedo.iface.pub_gestionDocumentalOn(this, datosGD);
	} else {
		this.child("tbwDocumentos").setTabEnabled("gesdocu", false);
	}

	if (sys.isLoadedModule("flcrm_ppal"))
		this.child("tdbContactos").cursor().setAction("crm_contactos");
	else
		this.child("tdbContactos").cursor().setAction("contactos");

	try {
		connect( this.child( "tbwCliente" ), "currentChanged(QString)", this, "iface.tbwCliente_currentChanged()" );
	} catch (e) {
	}
	
	this.child("tdbVentas").cursor().setAction("ventas");
	_i.iniciaVentas();
}

function interna_calculateField(fN)
{
	var _i = this.iface;
	var cursor = this.cursor();
	var valor;
	switch(fN) {
		case "codsubcuenta": {
			valor = _i.calcularSubcuentaCli(cursor, _i.longSubcuenta);
			break;
		}
		case "codsubcuentaporid": {
			valor = AQUtil.sqlSelect("co_subcuentas", "codsubcuenta", "idsubcuenta = " + cursor.valueBuffer("idsubcuenta"));
			valor = valor ? valor : "";
			break;
		}
		case "fechabaja": {
			if (cursor.valueBuffer("debaja")) {
				var hoy= new Date;
				valor = hoy.toString();
			} else {
				valor = "NAN";
			}
			break;
		}
		default: {
			valor = _i.commonCalculateField(fN, cursor);
		}
	}
	return valor;
}

/** \D Calcula un nuevo código de cliente
\end */
function interna_calculateCounter()
{
	var cursor= this.cursor();
	return this.iface.obtenerCodigoCliente(cursor);
}

function interna_validateForm()
{
  var _i = this.iface;
  var cursor= this.cursor();
  var util= new FLUtil;
  /** \C Si el cliente está de baja, la fecha de comienzo de la baja debe estar informada
  \end */
  if (cursor.valueBuffer("debaja") && cursor.isNull("fechabaja")) {
    MessageBox.warning(util.translate("scripts", "Si el cliente está de baja debº1e introducir la correspondiente fecha de inicio de la baja"), MessageBox.Ok, MessageBox.NoButton);
    return false;
  }

  if (!_i.validarNifIva()) {
    return false;
  }
  if (!_i.validarDuplicidadCif()) {
    return false;
  }
  if (!_i.validarCuentaDom()) {
    return false;
  }
  
  return true;
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_obtenerCodigoCliente(cursor:FLSqlCursor)
{
	var util= new FLUtil();
	return util.nextCounter("codcliente", cursor);
}

/** \D Marca el domicilio seleccionado en la lista como el de facturación
\end */
function oficial_cambiarDomFacturacion()
{
		this.iface.cambiarDom("domfacturacion");
}

/** \D Marca el domicilio seleccionado en la lista como el de envío
\end */
function oficial_cambiarDomEnvio()
{
		this.iface.cambiarDom("domenvio");
}

/** \D Marca el domicilio seleccionado en la lista como el de facturación o envío modificando la tabla de direcciones de cliente

@param tipo Tipo de dirección (facturación o envío)
\end */
function oficial_cambiarDom(tipo)
{
		var cursor= this.child("tdbDirecciones").cursor();
		var cursorBorrar= new FLSqlCursor("dirclientes");

		cursorBorrar.select("codcliente = '" + cursor.valueBuffer("codcliente") + "' AND " + tipo + " = 'true'");
		cursorBorrar.first();
		cursorBorrar.setModeAccess(cursorBorrar.Edit);
		cursorBorrar.refreshBuffer();
		cursorBorrar.setValueBuffer(tipo, "false");
		cursorBorrar.commitBuffer();

		cursor.setModeAccess(cursor.Edit);
		cursor.refreshBuffer();
		cursor.setValueBuffer(tipo, "true");
		cursor.commitBuffer();

		this.child("tdbDirecciones").refresh();

		this.iface.cargarDomFacturacion();
}

/** \D Carga el domicilio de facturación desde la tabla de direcciones de clientes al campo de texto del formulario. Es llamado al inicio de la carga del formulario o cuando cambia el domicilio de facturación
\end */
function oficial_cargarDomFacturacion()
{
		var label= this.child("lblDomFacturacion");
		var textLabel:String;
		var botonNuevo= this.child("pbNuevoDomFacturacion");
		var cursor= new FLSqlCursor("dirclientes");
		var partesDireccion= ["descripcion", "direccion", "codpostal", "ciudad", "provincia", "codpais"];

		cursor.select("codcliente = '" + this.cursor().valueBuffer("codcliente") + "' AND domfacturacion = 'true'");
		if (cursor.first()) {
				botonNuevo.setEnabled(false);
				cursor.refreshBuffer();
				textLabel = "";
				for (i = 0; i < partesDireccion.length; i++) {
						if (cursor.valueBuffer(partesDireccion[i])) {
								if (i > 0)
										textLabel = textLabel + "\n";
								textLabel = textLabel + cursor.valueBuffer(partesDireccion[i]);
						}
				}
				label.setText(textLabel);
		} else {
				botonNuevo.setEnabled(true);
				label.setText("");
		}
}

function oficial_bufferChanged(fN)
{
	var _i = this.iface;
	var cursor = this.cursor();
	switch(fN) {
		case "idsubcuenta": {
			sys.setObjText(this, "fdbCodSubcuenta", _i.calculateField("codsubcuentaporid"));
			break;
		}
	/** \C
	Al introducir --codsubcuenta--, si el usuario pulsa la tecla "punto" (.), la subcuenta se informa automaticamente con el código de cuenta más tantos ceros como sea necesario para completar la longitud de subcuenta asociada al ejercicio actual.
	\end */
		case "codsubcuenta": {
			if (!this.iface.bloqueoSubcuenta) {
				this.iface.bloqueoSubcuenta = true;
				this.iface.posActualPuntoSubcuenta = flcontppal.iface.pub_formatearCodSubcta(this, "fdbCodSubcuenta", this.iface.longSubcuenta, this.iface.posActualPuntoSubcuenta);
				this.iface.bloqueoSubcuenta = false;
			}
			break;
		}
	/** \C
	El valor de --codsubcuenta-- en modo de inserción será 430 + el código de cliente, más los ceros intermedios necesarios para completar la longitud de subcuenta establecida para el ejercicio actual.
	\end */
		case "codcliente": {
			if (cursor.modeAccess() == cursor.Insert) {
				this.iface.bloqueoSubcuenta = true;
				this.child("fdbCodSubcuenta").setValue(this.iface.calculateField("codsubcuenta"));
				this.iface.bloqueoSubcuenta = false;
			}
			break;
		}
		case "debaja": {
			var fecha= this.iface.calculateField("fechabaja");
			this.child("fdbFechaBaja").setValue(fecha);
			if (fecha == "NAN") {
				cursor.setNull("fechabaja");
			}
			break;
		}
		case "codcuentadom": {
			_i.mostrarDesCuentaDom();
			break;
		}
	}
}

function oficial_calcularSubcuentaCli(cursor:FLSqlCursor, longSubcuenta:Number)
{
	var util= new FLUtil();
	var codSubcuenta= util.sqlSelect("co_cuentas", "codcuenta", "idcuentaesp = 'CLIENT' ORDER BY codcuenta");
	if (!codSubcuenta)
		return false;

	var codCliente= cursor.valueBuffer("codcliente");
	if (!codCliente)
		codCliente = "";
	var numCeros= longSubcuenta - codSubcuenta.length - codCliente.length;
	for (var i= 0; i < numCeros; i++)
		codSubcuenta += "0";

	if (codSubcuenta.length + codCliente.length > longSubcuenta)
		codCliente = codCliente.right(longSubcuenta - codSubcuenta.length);

	codSubcuenta += codCliente;
	return codSubcuenta;
}

function oficial_cambiarCuentaDom()
{
	var _i = this.iface;
	var curCuenta= this.child("tdbCuentas").cursor();
	var codCuentaDom = curCuenta.valueBuffer("codcuenta");
	var desCuentaDom = curCuenta.valueBuffer("descripcion");
	

	if (!codCuentaDom) return;
	
	this.cursor().setValueBuffer("codcuentadom", codCuentaDom);
	this.iface.mostrarDesCuentaDom();
	//this.child("leDescCuentaDom").text = " " + desCuentaDom;
	
	var util= new FLUtil;
    
	var cursor= this.cursor();
	var codCliente= cursor.valueBuffer("codcliente");
	
	if (!_i.controlRecibosDom()) {
		return;
	}
}

function oficial_controlRecibosDom()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var codCliente = cursor.valueBuffer("codcliente");	
	var codCuentaDom = cursor.valueBuffer("codcuentadom");
	
	var numRecibos = AQUtil.sqlSelect("reciboscli", "count(*)", "estado IN ('Emitido', 'Devuelto') AND codcliente = '" + codCliente + "'");
	if (!numRecibos || numRecibos == 0) {
		sys.infoMsgBox(sys.translate("Se ha establecido la cuenta %1 como cuenta de domiciliación para este cliente.\n").arg(codCuentaDom));
	} else {
		var res = MessageBox.information(sys.translate("Se ha establecido la cuenta %1 como cuenta de domiciliación para este cliente.\n¿Desea cambiar sus %2 recibos pendientes de pago a la nueva cuenta  de domiciliación?").arg(codCuentaDom).arg(numRecibos), MessageBox.Yes, MessageBox.No, MessageBox.NoButton, "AbanQ");
		if (res == MessageBox.Yes){
			_i.cambiarCuentaDomRecibosEmitidos();
		}
	}
}

function oficial_cambiarCuentaDomRecibosEmitidos()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var codCuentaDom = cursor.valueBuffer("codcuentadom");
	var hayCuenta = codCuentaDom && codCuentaDom != "";
	var qryCuenta= new FLSqlQuery();
	if (hayCuenta) {
		qryCuenta.setTablesList("cuentasbcocli");
		qryCuenta.setSelect("codcuenta,descripcion,ctaentidad,ctaagencia,cuenta");
		qryCuenta.setFrom("cuentasbcocli");
		qryCuenta.setWhere("cuentasbcocli.codcuenta = '" + codCuentaDom + "'");
		if (!qryCuenta.exec()){
			return false;
		}
		if (!qryCuenta.first()) {
			return false;
		}
	}
	var curRecibo = new FLSqlCursor("reciboscli");
	var codCliente = cursor.valueBuffer("codcliente");
	curRecibo.select("estado IN ('Emitido', 'Devuelto') AND codcliente = '" + codCliente + "'");
	
	var valoresRecibo = "";
	
	while(curRecibo.next()){
		curRecibo.setModeAccess(curRecibo.Edit);
		curRecibo.refreshBuffer();
		if (hayCuenta) {
			curRecibo.setValueBuffer("codcuenta", qryCuenta.value("codcuenta"));
			curRecibo.setValueBuffer("descripcion", qryCuenta.value("descripcion"));
			curRecibo.setValueBuffer("ctaentidad", qryCuenta.value("ctaentidad"));
			curRecibo.setValueBuffer("ctaagencia", qryCuenta.value("ctaagencia"));
			curRecibo.setValueBuffer("cuenta", qryCuenta.value("cuenta"));
			curRecibo.setValueBuffer("dc", formRecordreciboscli.iface.pub_commonCalculateField("dc", curRecibo));
		} else {
			curRecibo.setNull("codcuenta");
			curRecibo.setNull("descripcion");
			curRecibo.setNull("ctaentidad");
			curRecibo.setNull("ctaagencia");
			curRecibo.setNull("cuenta");
			curRecibo.setNull("dc");
		}
		if (!curRecibo.commitBuffer()) {
			return false;
		}
		valoresRecibo += "Recibo: " + curRecibo.valueBuffer("codigo") + "    "+ "Importe: " + AQUtil.roundFieldValue(curRecibo.valueBuffer("importeeuros"), "reciboscli", "importe") + "    " + "Fecha: " + AQUtil.dateAMDtoDMA(curRecibo.valueBuffer("fecha")) + "\n";	
	}

	sys.infoMsgBox(sys.translate("Se han cambiado correctamente  los recibos pendientes de pago:\n \n%1 ").arg(valoresRecibo));
}

function oficial_mostrarDesCuentaDom()
{
	var util= new FLUtil;
	var cursor= this.cursor();
	var desCuentaDom= util.sqlSelect("cuentasbcocli", "descripcion", "codcuenta = '" + cursor.valueBuffer("codcuentadom") + "'");
	if (desCuentaDom)
		this.child("leDescCuentaDom").text = " " + desCuentaDom;
}

function oficial_borrarCuentaDom()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	cursor.setValueBuffer("codcuentadom", "");
	this.child("leDescCuentaDom").text = "";
	
	_i.controlRecibosDom()
}

/** \C Al seleccionar un registro de la tabla de subcuentas por ejercicio, la pestaña de Contabilidad muestra los datos relativos a la subcuenta seleccionada */
function oficial_establecerSubcuenta() 
{
	if (!sys.isLoadedModule("flcontppal"))
		return false;
		
	var util= new FLUtil;
	var curSubcuenta= this.child("tdbSubcuentas").cursor();

	if (!curSubcuenta.isValid())
		this.cursor().setNull("idsubcuenta");
	else 
		this.cursor().setValueBuffer("idsubcuenta", curSubcuenta.valueBuffer("idsubcuenta"));
	
	this.child("tdbPartidas").refresh();
}

/** \C Para insertar una subcuenta asociada al cliente actual, el usuario debe seleccionar el ejercicio al que irá asociada dicha subcuenta */
function oficial_toolButtonInsertSub_clicked()
{
	var cursor= this.cursor();
	var util= new FLUtil;
	
	if (cursor.modeAccess() == cursor.Insert) {
		var curSubcuentas= this.child("tdbSubcuentas").cursor();
		curSubcuentas.setModeAccess(curSubcuentas.Insert);
		curSubcuentas.commitBufferCursorRelation();
		this.child("tdbSubcuentas").refresh();
		return;
	}
	
	var codSubcuenta= cursor.valueBuffer("codsubcuenta");
	if (!codSubcuenta || codSubcuenta == "") {
		MessageBox.warning(util.translate("scripts", "Especifique el código de subcuenta a crear en el campo Subcuenta"), MessageBox.Ok, MessageBox.NoButton);
		return;
	}
		
	var formEjercicios= new FLFormSearchDB("ejercicios");
	var curEjercicios= formEjercicios.cursor();
	
	formEjercicios.setMainWidget();
	var codEjercicio= formEjercicios.exec("codejercicio");

	if (codEjercicio) {
		if (!util.sqlSelect("co_epigrafes", "idepigrafe", "codejercicio = '" + codEjercicio + "'")) {
			MessageBox.warning(util.translate("scripts", "No existe plan general contable para el ejercicio seleccionado"), MessageBox.Ok, MessageBox.NoButton);
			return;
		}
		
		var longSubcuenta= util.sqlSelect("ejercicios", "longsubcuenta", "codejercicio = '" + codEjercicio + "'");
		if (!longSubcuenta || longSubcuenta != codSubcuenta.length) {
			MessageBox.warning(util.translate("scripts", "La longitud de la subcuenta no coincide con la establecida para el ejercicio seleccionado"), MessageBox.Ok, MessageBox.NoButton);
			return;
		}
		var idSubcuenta= flfactppal.iface.pub_crearSubcuenta(codSubcuenta, cursor.valueBuffer("nombre"), "CLIENT", codEjercicio);
		if (!idSubcuenta) {
			MessageBox.critical(util.translate("scripts", "Hubo un error al crear la subcuenta"), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
		flfactppal.iface.pub_crearSubcuentaCli(codSubcuenta, idSubcuenta, cursor.valueBuffer("codcliente"), codEjercicio);
		
		this.child("tdbSubcuentas").refresh();
	}
}

/** \D Borra la vinculación cliente - subcuenta seleccionada, ofreciendo la posibilidad de borrar también la subcuenta si ésta está vacía 
\end */
function oficial_toolButtonDelSub_clicked()
{
	var curTablaSub= this.child("tdbSubcuentas").cursor();
	if (!curTablaSub.isValid())
		return;
	var idSubcuenta= curTablaSub.valueBuffer("idsubcuenta");
		
	var util= new FLUtil;
	var res = MessageBox.information(util.translate("scripts", "Va a eliminar la vinculación de la subcuenta seleccionada al cliente actual."), MessageBox.Ok, MessageBox.Cancel);
	if (res != MessageBox.Ok)
		return;
	
	var saldo= util.sqlSelect("co_subcuentas", "saldo", "idsubcuenta = " + idSubcuenta);
	if (saldo == 0) {
		if (!util.sqlSelect("co_partidas", "idpartida", "idsubcuenta = " + idSubcuenta)) {
			if (!util.sqlSelect("co_subcuentascli", "idsubcuenta", "idsubcuenta = " + idSubcuenta + " AND codcliente <> '" + this.cursor().valueBuffer("codcliente") + "'")) {
				var res = MessageBox.information(util.translate("scripts", "La subcuenta seleccionada no contiene ninguna partida ni está vinculada a otro cliente.\n¿Desea eliminarla junto con la vinculación?"), MessageBox.Yes, MessageBox.No);
				if (res == MessageBox.Yes) {
					util.sqlDelete("co_subcuentas", "idsubcuenta = " + idSubcuenta);
					this.child("tdbSubcuentas").refresh();
					this.iface.establecerSubcuenta();
					return;
				}
			}
		}
	}
	
	util.sqlDelete("co_subcuentascli", "id = " + curTablaSub.valueBuffer("id"));
	this.child("tdbSubcuentas").refresh();
	this.iface.establecerSubcuenta();
}

/** \D Imprime el presupuesto seleccionado
\end */
function oficial_imprimirPresupuesto()
{
	var codPresupuesto= this.child("tdbPresupuestos").cursor().valueBuffer("codigo");
	if (!codPresupuesto)
		return;
	formpresupuestoscli.iface.pub_imprimir(codPresupuesto);
}
/** \D Imprime el pedido seleccionado
\end */
function oficial_imprimirPedido()
{
	var codPedido= this.child("tdbPedidos").cursor().valueBuffer("codigo");
	if (!codPedido)
		return;
	formpedidoscli.iface.pub_imprimir(codPedido);
}
/** \D Imprime el albarán seleccionado
\end */
function oficial_imprimirAlbaran()
{
	var codAlbaran= this.child("tdbAlbaranes").cursor().valueBuffer("codigo");
	if (!codAlbaran)
		return;
	formalbaranescli.iface.pub_imprimir(codAlbaran);
}
/** \D Imprime la factura seleccionada
\end */
function oficial_imprimirFactura()
{
	var codFactura= this.child("tdbFacturas").cursor().valueBuffer("codigo");
	if (!codFactura)
		return;
	formfacturascli.iface.pub_imprimir(codFactura);
}
/** \D Imprime el recibo seleccionado
\end */
function oficial_imprimirRecibo()
{
	var codRecibo= this.child("tdbRecibos").cursor().valueBuffer("codigo");
	if (!codRecibo)
		return;
	formreciboscli.iface.pub_imprimir(codRecibo);
}

function oficial_insertContacto(accion:String,codigo:String)
{
	var cursor= this.cursor();
	if (cursor.modeAccess() == cursor.Insert) {
		if (!this.child("tdbDirecciones").cursor().commitBufferCursorRelation())
			return false;
	}
	if (this.iface.curContacto_) {
		delete this.iface.curContacto_;
	}
	this.iface.curContacto_ = new FLSqlCursor("crm_contactos");
	if (!sys.isLoadedModule("flcrm_ppal")) {
		this.iface.curContacto_.setAction("contactos");
	}
	connect(this.iface.curContacto_, "bufferCommited()", this, "iface.asociarContactoCliente");
	this.iface.curContacto_.insertRecord();
}

function oficial_asociarContactoCliente()
{
	var util= new FLUtil;
	var cursor= this.cursor();

	var codCliente= cursor.valueBuffer("codcliente");
	var codContacto= this.iface.curContacto_.valueBuffer("codcontacto");
	if (!util.sqlSelect("contactosclientes", "id", "codcontacto = '" + codContacto + "' AND codcliente = '" + codCliente + "'")) {
		var curContactoCliente= new FLSqlCursor("contactosclientes");
		curContactoCliente.setModeAccess(curContactoCliente.Insert);
		curContactoCliente.refreshBuffer();
		curContactoCliente.setValueBuffer("codcontacto", codContacto);
		curContactoCliente.setValueBuffer("codcliente", codCliente);
		
		if (!curContactoCliente.commitBuffer()) {
			return false;
		}
	}
	var codContactoCliente = cursor.valueBuffer("codcontacto");
	if (!codContactoCliente || codContactoCliente == "") {
		this.child("fdbCodContacto").setValue(codContacto);
	}
	this.child("tdbContactos").refresh();
}

function oficial_deleteContacto_clicked()
{
	var cursor= this.cursor();
	var codCliente= cursor.valueBuffer("codcliente");

	var codContacto= this.child("tdbContactos").cursor().valueBuffer("codcontacto");
	if(!codContacto || codContacto == "") {
		MessageBox.information(util.translate("scripts", "No hay ningún registro seleccionado"), MessageBox.Ok, MessageBox.NoButton);
		return;
	}
	this.iface.deleteContacto(codContacto, "clientes", codCliente);
	this.child("tdbContactos").refresh();
}

function oficial_deleteContacto(codContacto:String, tabla:String, regAsociado:String)
{
	var util:FLUtil;
	
	var whereClientes= "";
	var whereProveedores= "";
	var whereTarjetas= "";
	switch (tabla) {
		case "clientes": {
			whereClientes = " AND codcliente <> '" + regAsociado + "'";
			break;
		}
		case "proveedores": {
			whereProveedores = " AND codproveedor <> '" + regAsociado + "'";
			break;
		}
		case "crmtarjetas": {
			whereTarjetas = " AND codtarjeta <> '" + regAsociado + "'";
			break;
		}
	}
	var preguntar= false;
	if (sys.isLoadedModule("flcrm_ppal")) {
		if (util.sqlSelect("crm_contactostarjetas", "codcontacto", "codcontacto = '" + codContacto + "'" + whereTarjetas)) {
			preguntar = true;		
		}
	}
	if (!preguntar && util.sqlSelect("contactosclientes", "codcontacto", "codcontacto = '" + codContacto + "'" + whereClientes)) {
		preguntar = true;		
	} else if (!preguntar && util.sqlSelect("contactosproveedores", "codcontacto", "codcontacto = '" + codContacto + "'" + whereProveedores)) {
		preguntar = true;
	}
	if (preguntar) {
	var res= MessageBox.information(util.translate("scripts", "El contacto seleccionado está vinculado a otros registros. Si lo elimina se eliminarán todas las vinculaciones. ¿Desea continuar?"), MessageBox.Yes, MessageBox.No);
		if (res != MessageBox.Yes) {
			return true;
		}
	} else {
		var res= MessageBox.information(util.translate("scripts", "El registro seleccionado será borrado. ¿Está seguro?"), MessageBox.Yes, MessageBox.No);
		if (res != MessageBox.Yes) {
			return true;
		}
	}
	
	if (!util.sqlDelete("crm_contactos", "codcontacto = '" + codContacto + "'")) {
		return false;
	}
	return true;
}

function oficial_deleteContactoAsociado()
{
	var util:FLUtil;
	var cursor= this.cursor();
	var codCliente= cursor.valueBuffer("codcliente");
	
// 	if (accion == "crm_tarjetas")
// 		f = new FLFormSearchDB("crm_editcontactotarjeta");
// 	else {

	var curContactos= this.child("tdbContactos").cursor();
	var codContacto= curContactos.valueBuffer("codcontacto");
	if (!codContacto) {
		MessageBox.warning(util.translate("scripts", "No hay ningún contacto seleccionado"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	var res:Number;
// 	if (accion == "crm_tarjetas")
// 		res = MessageBox.information(util.translate("scripts", "Se va a desvincular el contacto seleccionado de la tarjeta. ¿Está seguro?"), MessageBox.Yes, MessageBox.No);
// 	else
	res = MessageBox.information(util.translate("scripts", "Se va a desvincular el contacto seleccionado del cliente. ¿Está seguro?"), MessageBox.Yes, MessageBox.No);
	if (res != MessageBox.Yes) {
		return false;
	}
	if (!util.sqlDelete("contactosclientes", "codcontacto = '" + codContacto + "' AND codcliente = '" + codCliente + "'")) {
		return false;
	}
	this.child("tdbContactos").refresh();
}

function oficial_insertContactoAsociado(accion:String, codAsociado:String)
{
	f = new FLFormSearchDB("crm_contactos");
	f.setMainWidget();
	var codContacto= f.exec("codcontacto");
	if (!codContacto) {
		return false;
	}

	if (f.accepted()) {
		if (accion == "crm_tarjetas") {
			var curContactoTarjeta= new FLSqlCursor("crm_contactostarjeta");
			curContactoTarjeta.setModeAccess(curContactoTarjeta.Insert);
			curContactoTarjeta.refreshBuffer();
			curContactoTarjeta.setValueBuffer("codcontacto", codContacto);
			curContactoTarjeta.setValueBuffer("codtarjeta", codAsociado);
			
			if (!curContactoTarjeta.commitBuffer()) {
				return false;
			}
		} else {
			var curContactoCliente= new FLSqlCursor("contactosclientes");
			curContactoCliente.setModeAccess(curContactoCliente.Insert);
			curContactoCliente.refreshBuffer();
			curContactoCliente.setValueBuffer("codcontacto", codContacto);
			curContactoCliente.setValueBuffer("codcliente", codAsociado);
			
			if (!curContactoCliente.commitBuffer()) {
				return false;
			}
		}
	}
	return true;
}

function oficial_insertContactoAsociado_clicked()
{
	var cursor= this.cursor();
	if (cursor.modeAccess() == cursor.Insert) {
		if (!this.child("tdbDirecciones").cursor().commitBufferCursorRelation()) {
			return false;
		}
	}
	var codCliente= cursor.valueBuffer("codcliente");
	this.iface.insertContactoAsociado("clientes", codCliente);
	this.child("tdbContactos").refresh();
}

function oficial_editarContacto(codContacto:String)
{
	var cursor= this.cursor();
	if (cursor.modeAccess() == cursor.Insert) {
		if (!this.child("tdbDirecciones").cursor().commitBufferCursorRelation())
			return false;
	}

	if (this.iface.curContacto_) {
		delete this.iface.curContacto_;
	}
	this.iface.curContacto_ = new FLSqlCursor("crm_contactos");
	if (!sys.isLoadedModule("flcrm_ppal")) {
		this.iface.curContacto_.setAction("contactos");
	}

	if (!codContacto) {
		codContacto = this.child("tdbContactos").cursor().valueBuffer("codcontacto");
		if (!codContacto || codContacto == "") {
			MessageBox.information(util.translate("scripts", "No hay ningún registro seleccionado"), MessageBox.Ok, MessageBox.NoButton);
			return;
		}
	}
	this.iface.curContacto_.select("codcontacto = '" + codContacto + "'");
	if (!this.iface.curContacto_.first()) {
		return;
	}

	connect(this.iface.curContacto_, "bufferCommited()", this, "iface.asociarContactoCliente");
	this.iface.curContacto_.editRecord();
}

function oficial_lanzarEdicionContacto()
{
	var util:FLUtil;
	var cursor= this.cursor();

	var codContacto= cursor.valueBuffer("codcontacto");
	if (!codContacto || codContacto == "") {
		this.iface.insertContacto();
	} else {
		this.iface.editarContacto(codContacto);
	}
	return true;
}

function oficial_buscarContacto()
{
	var cursor= this.cursor();
	var f:Object;
	if (sys.isLoadedModule("flcrm_ppal"))
		f = new FLFormSearchDB("crm_contactos");
	else
		f = new FLFormSearchDB("contactos");

	var codCliente= cursor.valueBuffer("codcliente");
	if (!codCliente) {
		return;
	}

	f.setMainWidget();
	f.cursor().setMainFilter("codcontacto IN(SELECT codcontacto FROM contactosclientes WHERE codcliente = '" + codCliente + "')");
	var codContacto= f.exec("codcontacto");
	if (!codContacto) {
		return;
	}

	cursor.setValueBuffer("codcontacto", codContacto);
}

function oficial_tbwCliente_currentChanged(nombre:String)
{
	var cursor= this.cursor();
	var util= new FLUtil();
	
	switch (nombre) {
		case "contabilidad": {
			var codEjercicioActual = flfactppal.iface.pub_ejercicioActual();
			var qrySubcuentasCli= new FLSqlQuery;
			with (qrySubcuentasCli) {
				setTablesList("co_subcuentascli");
				setSelect("codejercicio");
				setFrom("co_subcuentascli");
				setWhere("codcliente = '" + cursor.valueBuffer("codcliente") + "' ORDER BY codejercicio");
				setForwardOnly(true);
			}
			if (!qrySubcuentasCli.exec())
				return false;
			var fila= -1;
			while (qrySubcuentasCli.next()) {
				fila++;
				if (qrySubcuentasCli.value("codejercicio") == codEjercicioActual) {
					break;
				}
			}
			if (fila > -1) {
				this.child("tdbSubcuentas").setCurrentRow(fila);
			}
			break;
		}
	}
}

function oficial_mostrarLibroMayor()
{
	var util:FLUtil;
	var cursor= this.cursor();
	var codSubcuenta= this.child("tdbSubcuentas").cursor().valueBuffer("codsubcuenta");
	var codEjercicio= this.child("tdbSubcuentas").cursor().valueBuffer("codejercicio");
	if(!codSubcuenta || codSubcuenta == "" || !codEjercicio || codEjercicio == "") {
		MessageBox.warning(util.translate("scripts","Debe seleccionar una subcuenta por ejercicio"),MessageBox.Ok, MessageBox.NoButton,MessageBox.NoButton);
		return;
	}

	var curImprimir= new FLSqlCursor("co_i_mayor");
	curImprimir.setModeAccess(curImprimir.Insert);
	curImprimir.refreshBuffer();
	curImprimir.setValueBuffer("descripcion", "temp");
	curImprimir.setValueBuffer("d_co__subcuentas_codsubcuenta", codSubcuenta);
	curImprimir.setValueBuffer("h_co__subcuentas_codsubcuenta", codSubcuenta);
	curImprimir.setValueBuffer("i_co__subcuentas_codejercicio", codEjercicio);

	flcontinfo.iface.pub_lanzarInforme(curImprimir, "co_i_mayor", "", "co_subcuentas.codsubcuenta, co_asientos.fecha, co_asientos.numero", "", "", curImprimir.valueBuffer("id"));
}

function oficial_validarNifIva()
{
	var util= new FLUtil;
	var cursor= this.cursor();
	
	var tipoIdFiscal= cursor.valueBuffer("tipoidfiscal");
	if (tipoIdFiscal == "NIF/IVA") {
		var error= flfactppal.iface.pub_validarNifIva(cursor.valueBuffer("cifnif"));
		if (!error) {
			return false;
		} else {
			if (error != "OK") {
				MessageBox.warning(util.translate("scripts", "Error al validar el NIF/IVA:\n%1").arg(error), MessageBox.Ok, MessageBox.NoButton);
				return false;
			}
		}
	}
	return true;
}

function oficial_validarDuplicidadCif()
{
	var util = new FLUtil;
	var cursor = this.cursor();
	
	if (!flfactppal.iface.valorDefecto("cifunicos")) {
		return true;
	}
	var codCliente = cursor.valueBuffer("codcliente");
	var cifNif = cursor.valueBuffer("cifnif");
	var tipoIdFiscal = cursor.valueBuffer("tipoidfiscal");
	if (!tipoIdFiscal || tipoIdFiscal == "Otro") {
		return true;
	}
	var codDuplicado = util.sqlSelect("clientes", "codcliente", "cifnif = '" + cifNif + "' AND tipoidfiscal = '" + tipoIdFiscal + "' AND codcliente <> '" + codCliente + "'");
	if (codDuplicado) {
		MessageBox.warning(util.translate("scripts", "Ya existe otro cliente (código %1) con identificador fiscal %2 de tipo %3").arg(codDuplicado).arg(cifNif).arg(tipoIdFiscal), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	return true;
}

function oficial_validarCuentaDom()
{
  var util = new FLUtil;
  var cursor = this.cursor();
  var codCD = cursor.valueBuffer("codcuentadom");
  if (!codCD) {
    return true;
  }
  if (!util.sqlSelect("cuentasbcocli", "codcuenta", "codcuenta = '" + codCD + "' AND codcliente = '" + cursor.valueBuffer("codcliente") + "'")) {
    MessageBox.warning(util.translate("scripts", "La cuenta de domiciliación indicada no coincide con ninguna de las cuentas del cliente. Bórrela o seleccione otra."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
    return false;
  }
  
  return true;
}

function oficial_commonCalculateField(fN, cursor)
{
	return true;
}

function oficial_tdbCuentas_bufferCommited()
{
	var _i = this.iface;
	var cursor = this.cursor();
	var codCliente = cursor.valueBuffer("codcliente");
	var codCuentaDom = cursor.valueBuffer("codcuentadom");
	if (codCuentaDom) {
		if (!AQUtil.sqlSelect("cuentasbcocli", "codcuenta", "codcliente = '" + codCliente + "' AND codcuenta = '" + codCuentaDom + "'")) {
			codCuentaDom = AQUtil.sqlSelect("cuentasbcocli", "codcuenta", "codcliente = '" + codCliente + "'");
			sys.setObjText(this, "fdbCodCuentaDom", codCuentaDom ? codCuentaDom : "");
		}
	} else {
		codCuentaDom = AQUtil.sqlSelect("cuentasbcocli", "codcuenta", "codcliente = '" + codCliente + "'");
		sys.setObjText(this, "fdbCodCuentaDom", codCuentaDom ? codCuentaDom : "");
	}
}

function oficial_tbnVerAsiento_clicked()
{
	var curP = this.child("tdbPartidas").cursor();
	var idAsiento = curP.valueBuffer("idasiento");
	if (!idAsiento) {
		return;
	}
	var curA = new FLSqlCursor("co_asientos");
	curA.select("idasiento = " + idAsiento);
	if (!curA.first()) {
		return false;
	}
	curA.browseRecord();
}

function oficial_iniciaVentas()
{
	var _i = this.iface;
	var t = this.child("tdbVentas");
	if (!t) {
		return;
	}
	if (t.cursor().table() == "clientes") {
		this.child("tbwDocumentos").setTabEnabled("ventas", false);
		return;
	}
	
	var cVentas = _i.columnasVentas();
	t.setOrderCols(cVentas);
}

function oficial_columnasVentas()
{
	return ["codigo", "fecha", "referencia", "descripcion", "pvpunitario", "cantidad", "pvpsindto", "pvptotal"];
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
