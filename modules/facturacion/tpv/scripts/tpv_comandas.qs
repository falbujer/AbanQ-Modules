/***************************************************************************
                 tpv_comandas.qs  -  description
                             -------------------
    begin                : lun ago 19 2005
    copyright            : Por ahora (C) 2005 by InfoSiAL S.L.
    email                : lveb@telefonica.net
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
class interna
{
  var ctx;
  function interna(context)
  {
    this.ctx = context;
  }
  function init()
  {
    return this.ctx.interna_init();
  }
  function calculateField(fN)
  {
    return this.ctx.interna_calculateField(fN);
  }
  function validateForm()
  {
    return this.ctx.interna_validateForm();
  }
  function acceptedForm()
  {
    return this.ctx.interna_acceptedForm();
  }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna
{
  var lblCantEntregada;
  var lblCantCambio;
  var lblCantPte;
  var lblEntregado;
  var lblCambio;
  var fdbEstado;
  var seleccionado;
  var refrescoActivo;
  var txtCanArticulo;
  var txtDesArticulo;
  var txtPvpArticulo;
  var ivaArticulo, pvpVariable;
  var tbnInsertarLinea;
  var cursor;
  var curLineas;
  var curPagos;
  var bloqueoProvincia;
  var importePagado;
  var config_;
  var soloVentas_;
	var txtVarios_;
	var aDatos_;
	var hayValoresLocales_;
	var anularClicked_;
	
  function oficial(context)
  {
    interna(context);
  }
  function inicializarControles()
  {
    return this.ctx.oficial_inicializarControles();
  }
  function calcularTotales()
  {
    return this.ctx.oficial_calcularTotales();
  }
  function bufferChanged(fN)
  {
    return this.ctx.oficial_bufferChanged(fN);
  }
  function verificarHabilitaciones()
  {
    return this.ctx.oficial_verificarHabilitaciones();
  }
  function fdbReferencia_lostFocus()
  {
    return this.ctx.oficial_fdbReferencia_lostFocus();
  }
  function realizarPago()
  {
    return this.ctx.oficial_realizarPago();
  }
  function imprimirQuickClicked()
  {
    return this.ctx.oficial_imprimirQuickClicked();
  }
  function guardarComandaImpresion()
  {
    return this.ctx.oficial_guardarComandaImpresion();
  }
  function lanzarImpresionTicketRegalo()
  {
    return this.ctx.oficial_lanzarImpresionTicketRegalo();
  }
  function imprimirValeEmitido(idTpvComanda)
  {
    return this.ctx.oficial_imprimirValeEmitido(idTpvComanda);
  }
  function imprimirValesUsados(cursor)
  {
    return this.ctx.oficial_imprimirValesUsados(cursor);
  }
  function seleccionarTodo()
  {
    return this.ctx.oficial_seleccionarTodo();
  }
  function unoMas()
  {
    return this.ctx.oficial_unoMas();
  }
  function unoMenos()
  {
    return this.ctx.oficial_unoMenos();
  }
  function aplicarDescuento()
  {
    return this.ctx.oficial_aplicarDescuento();
  }
  function sumarUno(idLinea)
  {
    return this.ctx.oficial_sumarUno(idLinea);
  }
  function restarUno(idLinea)
  {
    return this.ctx.oficial_restarUno(idLinea);
  }
  function descontar(idLinea, descuentoLineal, porDescuento)
  {
    return this.ctx.oficial_descontar(idLinea, descuentoLineal, porDescuento);
  }
  function calcularTotalesLinea(fN, cursor)
  {
    return this.ctx.oficial_calcularTotalesLinea(fN, cursor);
  }
  function aplicarTarifa()
  {
    return this.ctx.oficial_aplicarTarifa();
  }
  function desconectar()
  {
    return this.ctx.oficial_desconectar();
  }
  function crearPago(importe, formaPago, refVale)
  {
    return this.ctx.oficial_crearPago(importe, formaPago, refVale);
  }
  function procesaCantidadTarjeta(curCantidadPago)
  {
    return this.ctx.oficial_procesaCantidadTarjeta(curCantidadPago);
  }
  function procesaCantidadEfectivo(curCantidadPago)
  {
    return this.ctx.oficial_procesaCantidadEfectivo(curCantidadPago);
  }
  function procesaCantidadVale(curCantidadPago)
  {
    return this.ctx.oficial_procesaCantidadVale(curCantidadPago);
  }
  function procesaCantidadesPago(curCantidadPago)
  {
    return this.ctx.oficial_procesaCantidadesPago(curCantidadPago);
  }
  function dameImporteEntregado(curCantidadPago)
  {
    return this.ctx.oficial_dameImporteEntregado(curCantidadPago);
  }
  function iniciaBufferCanPago(curCantidadPago)
  {
    return this.ctx.oficial_iniciaBufferCanPago(curCantidadPago);
  }
  function datosPago(curPago, formaPago, refVale)
  {
    return this.ctx.oficial_datosPago(curPago, formaPago, refVale);
  }
  function refrescarPte()
  {
    return this.ctx.oficial_refrescarPte();
  }
  function calcularPagado()
  {
    return this.ctx.oficial_calcularPagado();
  }
  function abrirCajonClicked()
  {
    return this.ctx.oficial_abrirCajonClicked();
  }
  function pasarSiguienteVenta()
  {
    return this.ctx.oficial_pasarSiguienteVenta();
  }
  function insertarLineaClicked()
  {
    return this.ctx.oficial_insertarLineaClicked();
  }
  function datosLineaVenta()
  {
    return this.ctx.oficial_datosLineaVenta();
  }
  function datosLineaVentaArt()
  {
    return this.ctx.oficial_datosLineaVentaArt();
  }
  function datosLineaVentaPvpUnitario()
  {
    return this.ctx.oficial_datosLineaVentaPvpUnitario();
  }
  function datosLineaVentaIva()
  {
    return this.ctx.oficial_datosLineaVentaIva();
  }
  function datosLineaVentaCantidad()
  {
    return this.ctx.oficial_datosLineaVentaCantidad();
  }
  function datosLineaVentaPrecio()
  {
    return this.ctx.oficial_datosLineaVentaPrecio();
  }
  function mostrarFactura()
  {
    return this.ctx.oficial_mostrarFactura();
  }
  function datosVisorArt(curLineas)
  {
    return this.ctx.oficial_datosVisorArt(curLineas);
  }
  function datosVisorPagar()
  {
    return this.ctx.oficial_datosVisorPagar();
  }
  function datosVisorImprimir()
  {
    return this.ctx.oficial_datosVisorImprimir();
  }
  function formatearLineaVisor(codPuntoVenta, numLinea, datos, formato)
  {
    return this.ctx.oficial_formatearLineaVisor(codPuntoVenta, numLinea, datos, formato);
  }
  function escribirEnVisor(codPuntoVenta, datos)
  {
    return this.ctx.oficial_escribirEnVisor(codPuntoVenta, datos);
  }
  function aplicarTarifaLinea(codTarifa)
  {
    return this.ctx.oficial_aplicarTarifaLinea(codTarifa);
  }
  function cargarConfiguracion()
  {
    return this.ctx.oficial_cargarConfiguracion();
  }
  function cursorAPosicionInicial()
  {
    return this.ctx.oficial_cursorAPosicionInicial();
  }
  function pbnPagar_clicked()
  {
    return this.ctx.oficial_pbnPagar_clicked();
  }
  function pbnEmitirVale_clicked()
  {
    return this.ctx.oficial_pbnEmitirVale_clicked();
  }
  function guardaComanda()
  {
    return this.ctx.oficial_guardaComanda();
  }
  function pbnAnularVale_clicked()
  {
    return this.ctx.oficial_pbnAnularVale_clicked();
  }
  function fdbCodBarras_returnPressed()
  {
    return this.ctx.oficial_fdbCodBarras_returnPressed();
  }
  function fdbReferencia_returnPressed()
  {
    return this.ctx.oficial_fdbReferencia_returnPressed();
  }
  function conectarInsercionRapida()
  {
    return this.ctx.oficial_conectarInsercionRapida();
  }
  function actualizarIvaLineas(codCliente)
  {
    return this.ctx.oficial_actualizarIvaLineas(codCliente);
  }
  function calcularIvaLinea(referencia)
  {
    return this.ctx.oficial_calcularIvaLinea(referencia);
  }
  function tbwComanda_currentChanged(tabName)
  {
    return this.ctx.oficial_tbwComanda_currentChanged(tabName);
  }
  function tbnStock_clicked()
  {
    return this.ctx.oficial_tbnStock_clicked();
  }
  function mostrarRecargo()
  {
    return this.ctx.oficial_mostrarRecargo();
  }
  function insertarLinea()
  {
    return this.ctx.oficial_insertarLinea();
  }
  function limpiarDatos()
  {
    return this.ctx.oficial_limpiarDatos();
  }
  function habilitarPorTipoDoc()  {
    return this.ctx.oficial_habilitarPorTipoDoc();
  }
  function habilitarTicketRegalo()  {
    return this.ctx.oficial_habilitarTicketRegalo();
  }
  function habilitarBotones()  {
    return this.ctx.oficial_habilitarBotones();
  }
  function habilitarPagar()  {
    return this.ctx.oficial_habilitarPagar();
  }
  function habilitarEmitirVale()  {
    return this.ctx.oficial_habilitarEmitirVale();
  }
  function habilitarAnularVale()  {
    return this.ctx.oficial_habilitarAnularVale();
  }
  function pbnVentaClicked(){
    return this.ctx.oficial_pbnVentaClicked();
  }
  function pbnReservaClicked(){
    return this.ctx.oficial_pbnReservaClicked();
  }
  function pbnPresupuestoClicked(){
    return this.ctx.oficial_pbnPresupuestoClicked();
  }
  function pbnDevolucionClicked(){
    return this.ctx.oficial_pbnDevolucionClicked();
  }
  function devolverLineasComandas(){
    return this.ctx.oficial_devolverLineasComandas();
  }
  function masDatosComanda(q){
    return this.ctx.oficial_masDatosComanda(q);
  }
  function dameSelectComanda(){
    return this.ctx.oficial_dameSelectComanda();
  }
  function controlTipoDoc(){
    return this.ctx.oficial_controlTipoDoc();
  }
  function funcionesTPV()
  {
    return this.ctx.oficial_funcionesTPV();
  }
  function comprobarTotalPago()
  {
    return this.ctx.oficial_comprobarTotalPago();
  }
  function validarIvaRecargoCliente()
  {
    return this.ctx.oficial_validarIvaRecargoCliente();
  }
  function datosComanda(codigo)
  {
    return this.ctx.oficial_datosComanda(codigo);
  }
  function commonCalculateField(fN, cursor)
  {
    return this.ctx.oficial_commonCalculateField(fN, cursor);
  }
  function ponerSignoCantidad()
  {
    return this.ctx.oficial_ponerSignoCantidad();
  }
  function mostrarCamposDevolucion()
  {
    return this.ctx.oficial_mostrarCamposDevolucion();
  }
  function valoresLocales() {
    return this.ctx.oficial_valoresLocales();
  }
  function tbnBloquearUsuario_clicked() {
    return this.ctx.oficial_tbnBloquearUsuario_clicked();
  }
  function tbnTicketRegalo_clicked() {
    return this.ctx.oficial_tbnTicketRegalo_clicked();
  }
  function habilitaPorSeguridad() {
    return this.ctx.oficial_habilitaPorSeguridad();
  }
  function dameAgenteVenta(codTerminal) {
    return this.ctx.oficial_dameAgenteVenta(codTerminal);
  }
  function dameIdTpv() {
    return this.ctx.oficial_dameIdTpv();
  }
  function ponCantidadRegalo(valores)
  {
    return this.ctx.oficial_ponCantidadRegalo(valores);
  }
  function ponCantidadRegaloLinea(aDatos)
  {
    return this.ctx.oficial_ponCantidadRegaloLinea(aDatos);
  }
  function imprimirTicketRegalo()
  {
    return this.ctx.oficial_imprimirTicketRegalo();
  }
  function validarPago(curPago)
  {
    return this.ctx.oficial_validarPago(curPago);
  }
  function pushButtonCancel_clicked()
  {
    return this.ctx.oficial_pushButtonCancel_clicked();
  }
  function actualizarCantidadRegalo(idLinea, on)
  {
		return this.ctx.oficial_actualizarCantidadRegalo(idLinea, on);
  }
  function calculaPuntosVenta()
  {
		return this.ctx.oficial_calculaPuntosVenta();
  }
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends oficial
{
  function head(context)
  {
    oficial(context);
  }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head
{
  function ifaceCtx(context)
  {
    head(context);
  }
  function pub_commonCalculateField(fN, cursor) {
		return this.commonCalculateField(fN, cursor);
	}
  function pub_imprimirValesUsados(cursor) {
		return this.imprimirValesUsados(cursor);
	}
  function pub_dameIdTpv() {
		return this.dameIdTpv();
	}
  function pub_ponCantidadRegalo(valores) {
		return this.ponCantidadRegalo(valores);
	}
  function pub_dameAgenteVenta(codTerminal) {
		return this.dameAgenteVenta(codTerminal);
	}
}

const iface = new ifaceCtx(this);
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition interna */
////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
/** \C
Se calcula el arqueo buscando uno abierto para ese punto de venta que corresponda con la fecha establecida<br/>
Se establece por defecto el punto de venta local y como agente el agente asociado al punto de venta.
<br/>Al pulsar el botón pagar y establecer una cantidad la comanda se muestra en el recuadro superior derecho el importe entregado por el cliente y calcula el cambio que debemos devolverle.<br/>
Al pagar una comanda ésta se cerrará automáticamente creándose la factura, recibo, pago y asiento contable correspondientes.
*/
function interna_init()
{
	var _i = this.iface;
  var cursor = this.cursor();

	formtpv_comandas.iface.masterComandasCargada_ = false;
	
  _i.bloqueoProvincia = false;
	_i.txtVarios_ = sys.translate("VARIOS");

  if (!_i.curLineas) {
    _i.curLineas = this.child("tdbLineasComanda").cursor();
  }
  if (!_i.curPagos) {
    _i.curPagos = this.child("tdbPagos").cursor();
  }
  _i.lblCantEntregada = this.child("lblCantEntregada");
  _i.lblCantCambio = this.child("lblCantCambio");
  _i.lblCantPte = this.child("lblCantPte");
  _i.lblEntregado = this.child("lblEntregado");
  _i.lblCambio = this.child("lblCambio");
  _i.fdbEstado = this.child("fdbEstado");
  _i.lblCantCambio.setText("");
  _i.lblCantEntregada.setText("");
  _i.lblEntregado.setText("");
  _i.lblCambio.setText("");
  _i.seleccionado = false;
  _i.refrescoActivo = true;

  _i.txtCanArticulo = this.child("txtCanArticulo");
  _i.txtDesArticulo = this.child("txtDesArticulo");
  _i.txtPvpArticulo = this.child("txtPvpArticulo");
  _i.ivaArticulo = "";
	_i.pvpVariable = false;
  _i.tbnInsertarLinea = this.child("tbnInsertarLinea");
  _i.anularClicked_ = false;

	if(this.child("gbxRecibos")){
		this.child("tdbRecibos").setReadOnly(true);
	}
	
  connect(cursor, "bufferChanged(QString)", _i, "bufferChanged");
  connect(this.child("tbwComanda"), "currentChanged(QString)", _i, "tbwComanda_currentChanged");

  connect(_i.curLineas, "bufferCommited()", _i, "calcularTotales()");
  connect(_i.curPagos, "bufferCommited()", _i, "calcularPagado()");

  connect(this.child("pbnPagar"), "clicked()", _i, "pbnPagar_clicked()");
  connect(this.child("pbnEmitirVale"), "clicked()", _i, "pbnEmitirVale_clicked()");
  connect(this.child("pbnAnularVale"), "clicked()", _i, "pbnAnularVale_clicked()");
  connect(this.child("tbnPrintQuick"), "clicked()", _i, "imprimirQuickClicked()");
  connect(this.child("tbnSelTodo"), "clicked()", _i, "seleccionarTodo()");
  connect(this.child("tbnUnoMas"), "clicked()", _i, "unoMas()");
  connect(this.child("tbnUnoMenos"), "clicked()", _i, "unoMenos()");
  connect(this.child("tbnDescuento"), "clicked()", _i, "aplicarDescuento()");
  connect(this.child("tbnOpenCash"), "clicked()", _i, "abrirCajonClicked()");
  connect(_i.tbnInsertarLinea, "clicked()", _i, "insertarLineaClicked()");
  connect(this.child("tbnStock"), "clicked()", _i, "tbnStock_clicked()");
  connect(this.child("toolButtonZoomFactura"), "clicked()", _i, "mostrarFactura()");

  connect(_i.txtDesArticulo, "returnPressed()", _i, "insertarLineaClicked()");
  connect(_i.txtCanArticulo, "returnPressed()", _i, "insertarLineaClicked()");
  connect(_i.txtPvpArticulo, "returnPressed()", _i, "insertarLineaClicked()");
	connect(this.child("fdbReferencia").editor(), "lostFocus()", _i, "fdbReferencia_lostFocus()");
	
  connect(this.child("pbnVenta"), "clicked()", _i, "pbnVentaClicked()");
  connect(this.child("pbnReserva"), "clicked()", _i, "pbnReservaClicked()");
  connect(this.child("pbnPresupuesto"), "clicked()", _i, "pbnPresupuestoClicked()");
  connect(this.child("pbnDevolucion"), "clicked()", _i, "pbnDevolucionClicked()");
  connect(this.child("tbnBloquearUsuario"), "clicked()", _i, "tbnBloquearUsuario_clicked()");
  connect(this.child("tbnTicketRegalo"), "clicked()", _i, "tbnTicketRegalo_clicked()");
  disconnect(this.child("pushButtonCancel"), "clicked()", this.obj(), "reject()");
  connect(this.child("pushButtonCancel"), "clicked()", _i, "pushButtonCancel_clicked");

	connect(this.child("tdbLineasComanda"), "primaryKeyToggled(QVariant, bool)", _i, "actualizarCantidadRegalo");

	_i.hayValoresLocales_ = true;
  _i.refrescarPte();
  switch (cursor.modeAccess()) {
    case cursor.Insert: {
			var hoy = new Date;
      cursor.setValueBuffer("fecha", hoy.toString());
			if (!_i.valoresLocales()) {
				_i.hayValoresLocales_ = false;
				sys.AQTimer.singleShot(0, formRecordtpv_comandas.close);
				return;
			}
      this.child("fdbTarifa").setValue(AQUtil.sqlSelect("tpv_datosgenerales", "tarifa", "1=1"));
      this.child("fdbCodPago").setValue(AQUtil.sqlSelect("tpv_datosgenerales", "pagoefectivo", "1=1"));

      _i.txtCanArticulo.text = 1;
      this.child("fdbCodCliente").setValue(AQUtil.sqlSelect("tpv_datosgenerales", "codcliente", "1 = 1"));
      break;
    }
    case cursor.Edit: {
      this.child("fdbCodigo").setDisabled(true);
      this.child("fdbCodTpvPuntoventa").setDisabled(true);
      _i.txtCanArticulo.text = 1;
      break;
    }
  }
	_i.inicializarControles();
	_i.bufferChanged("tipopago");

	_i.importePagado = 0;

	_i.cargarConfiguracion();
	_i.mostrarRecargo();
	_i.habilitarPorTipoDoc();
	_i.ponerSignoCantidad();
	_i.habilitaPorSeguridad(); 
	
	_i.habilitarTicketRegalo();
}

function interna_calculateField(fN)
{
  debug("calcula " + fN);
  var _i = this.iface;
  var valor;
  var cursor = this.cursor();

  switch (fN) {
      /** \C
      El --pagado-- es la suma de los pagos
      */
    case "pagado": {
      valor = AQUtil.sqlSelect("tpv_pagoscomanda", "SUM(importe)", "idtpv_comanda = " + cursor.valueBuffer("idtpv_comanda") + " AND estado = '" + AQUtil.translate("scripts" , "Pagado") + "'");
      valor = AQUtil.roundFieldValue(valor, "tpv_comandas", "pagado");
      break;
    }
    /** \C
    El --Pendiente-- es el --total-- menos el --pagado--
    */
    case "pendiente": {
      valor = parseFloat(cursor.valueBuffer("total")) - parseFloat(cursor.valueBuffer("pagado"));
      break;
    }
    /** \C
    El --total-- es el --neto-- más el --totaliva--
    */
    case "total": {
      var neto = parseFloat(cursor.valueBuffer("neto"));
      var totalIva = parseFloat(cursor.valueBuffer("totaliva"));
      var totalRecargo = parseFloat(cursor.valueBuffer("totalrecargo"));
      valor = neto + totalIva + totalRecargo;
      break;
    }
    /** \C
    El --neto-- es la suma del pvp total de las líneas de la comanda
    */
    case "neto": {
      valor = AQUtil.sqlSelect("tpv_lineascomanda", "SUM(pvptotal)", "idtpv_comanda = " + cursor.valueBuffer("idtpv_comanda"));
      if (!valor)
        valor = 0;
      valor = AQUtil.roundFieldValue(valor, "tpv_comandas", "neto");
      break;
    }
    /** \C
    El --totaliva-- es la suma del iva correspondiente a las líneas de la comanda
    */
    case "totaliva": {
      valor = AQUtil.sqlSelect("tpv_lineascomanda", "SUM((pvptotal * iva) / 100)", "idtpv_comanda = " + cursor.valueBuffer("idtpv_comanda"));
      valor = AQUtil.roundFieldValue(valor, "tpv_comandas", "totaliva");
      break;
    }
    case "totalrecargo": {
      valor = AQUtil.sqlSelect("tpv_lineascomanda", "SUM((pvptotal * recargo) / 100)", "idtpv_comanda = " + cursor.valueBuffer("idtpv_comanda"));
      valor = AQUtil.roundFieldValue(valor, "tpv_comandas", "totalrecargo");
      break;
    }
    case "ivaarticulo": {
      valor = AQUtil.sqlSelect("articulos", "codimpuesto", "referencia = '" + cursor.valueBuffer("referencia") + "'");
      break;
    }
    case "pvpvariable": {
      valor = AQUtil.sqlSelect("articulos", "pvpvariable", "referencia = '" + cursor.valueBuffer("referencia") + "'");
      break;
    }
    case "desarticulo": {
      valor = AQUtil.sqlSelect("articulos", "descripcion", "referencia = '" + cursor.valueBuffer("referencia") + "'");
      if (!valor)
        valor = "";
      break;
    }
    case "pvparticulo": {
      valor = formRecordtpv_lineascomanda.iface.calcularPvpTarifa(cursor.valueBuffer("referencia"), cursor.valueBuffer("codtarifa"));
			valor = isNaN(valor) ? 0 : valor;
			valor = AQUtil.roundFieldValue(valor, "tpv_lineascomanda", "pvpunitario");
      break;
    }
    case "estado": {
      var total = parseFloat(cursor.valueBuffer("total"));
      if (total != 0 && total == parseFloat(cursor.valueBuffer("pagado"))) {
        valor = "Cerrada";
      } else {
        valor = "Abierta";
      }
      break;
    }
    case "coddir": {
      valor = AQUtil.sqlSelect("dirclientes", "id", "codcliente = '" + cursor.valueBuffer("codcliente") +  "' AND domfacturacion = 'true'");
      if (!valor) {
        valor = "";
      }
      break;
    }
    case "provincia": {
      valor = AQUtil.sqlSelect("dirclientes", "provincia", "id = " + cursor.valueBuffer("coddir"));
      if (!valor)
        valor = cursor.valueBuffer("provincia");
      break;
    }
    case "codpais": {
      valor = AQUtil.sqlSelect("dirclientes", "codpais", "id = " + cursor.valueBuffer("coddir"));
      if (!valor)
        valor = cursor.valueBuffer("codpais");
      break;
    }
    case "coste": {
      valor = AQUtil.sqlSelect("articulosprov", "coste", "referencia = '" + cursor.valueBuffer("referencia") + "' AND pordefecto = true");
      if (!valor)
        valor = "";
      break;
    }
		case "numlineascomanda": {
			valor =  parseFloat(AQUtil.sqlSelect("tpv_lineascomanda","count(*)", "idtpv_comanda = '" + cursor.valueBuffer("idtpv_comanda") + "'"));
			break;
		}
		default: {
			valor = _i.commonCalculateField(fN, cursor);
		}
  }
  debug("valor " + valor);
  return valor;
}

/** \D Comprueba que el total es mayor que la suma de los pagos y por otro lado que se corresponda el estado al indicado por el usuario,preguntando en caso contrario si se desea realizar el cambio.
\end */
function interna_validateForm()
{
	var _i = this.iface;
  var cursor = this.cursor();
	
	if(!_i.comprobarTotalPago()){
		return false;
	}
	
  if (!flfactppal.iface.pub_validarProvincia(cursor)) {
    return false;
  }
  
	if(!_i.validarIvaRecargoCliente()){
		return false;
	}

  if(!soloVentas_){
		if(!_i.controlTipoDoc()){
			return false;
		}
	}

  return true;
}

/** \D Si la comanda está completamente pagada, pasa a estado Cerrada
\end */
function interna_acceptedForm()
{
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_pushButtonCancel_clicked()
{
  var res = MessageBox.warning(sys.translate("¿Desea cancelar la venta actual?"), MessageBox.Yes, MessageBox.No, MessageBox.NoButton, "AbanQ");
  if (res != MessageBox.Yes) {
    return;
  }
	sys.AQTimer.singleShot(0, formRecordtpv_comandas.reject);
}
/** \D
Llama a la función verificarHabilitaciones
*/
function oficial_inicializarControles()
{
	var _i = this.iface;
  _i.verificarHabilitaciones();
}

/** \D
Calcula el neto, totaliva y total llamando a la función calculateField
*/
function oficial_calcularTotales()
{
	var _i = this.iface;
	
  this.child("fdbNeto").setValue(_i.calculateField("neto"));
  this.child("fdbTotalIva").setValue(_i.calculateField("totaliva"));
  this.child("fdbTotalRecargo").setValue(_i.calculateField("totalrecargo"));
  this.child("fdbTotalComanda").setValue(_i.calculateField("total"));

  _i.verificarHabilitaciones();
}

function oficial_bufferChanged(fN)
{
	var _i = this.iface;
  var cursor = this.cursor();
  switch (fN) {
      /** \C
      Al cambiar el --totaliva-- se calcula el --total--
      */
    case "totaliva": {
      this.child("fdbTotalComanda").setValue(_i.calculateField("total"));
      _i.verificarHabilitaciones();
      break;
    }
    /** \C
    Al cambiar el --total-- o el --pagado-- se actualiza el pendiente de pago
    */
    case "total":
    case "pagado": {
      this.child("fdbPendiente").setValue(_i.calculateField("pendiente"));
      _i.refrescarPte();
      cursor.setValueBuffer("estado", _i.calculateField("estado"));
			///_i.habilitarTicketRegalo();
      break;
    }
    /** \C
    Al calculase el arqueo se desabilita el código, punto de venta, agente y fecha
    */
    case "idtpv_arqueo": {
      if (cursor.valueBuffer("idtpv_arqueo")) {
        this.child("fdbCodigo").setDisabled(true);
        this.child("fdbCodTpvPuntoventa").setDisabled(true);
        this.child("fdbAgente").setDisabled(true);
        this.child("fdbFecha").setDisabled(true);
      }
      break;
    }
    /** \C
    Al cambiar la --codtarifa-- se recalculan los totales aplicando la nueva tarifa a todas las lineas de la comanda preguntando antes si deseamos hacerlo
    */
    case "codtarifa": {
      if (!cursor.valueBuffer("codtarifa"))
        break;
      if (this.child("tdbLineasComanda").cursor().size() > 0) {
        var res = MessageBox.warning(sys.translate("¿Desea aplicar la nueva tarifa a todas las lineas?"), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
        if (res == MessageBox.Yes)
          _i.aplicarTarifa();
      }
      break;
    }
    /** \C
    Al cambiar el --tipopago-- se calcula la forma de pago establecida por defecto para ese tipo de pago en el formulario de datos generales
    */
    case "tipopago": {
      if (cursor.valueBuffer("tipopago") == "Efectivo") {
        var pagoEfectivo = AQUtil.sqlSelect("tpv_datosgenerales", "pagoefectivo", "1=1");
        if (!pagoEfectivo || pagoEfectivo == "")
          MessageBox.information(sys.translate("No tiene configurada la forma de pago efectivo en el formulario de datos generales"), MessageBox.Ok, MessageBox.NoButton);
        cursor.setValueBuffer("codpago", pagoEfectivo);
      } else if (cursor.valueBuffer("tipopago") == "Tarjeta") {
        var pagoTarjeta = AQUtil.sqlSelect("tpv_datosgenerales", "pagotarjeta", "1=1");
        if (!pagoTarjeta || pagoTarjeta == "")
          MessageBox.information(sys.translate("No tiene configurada la forma de pago tarjeta en el formulario de datos generales"), MessageBox.Ok, MessageBox.NoButton);
        cursor.setValueBuffer("codpago", pagoTarjeta);
      } else {
        var pagoVale = AQUtil.sqlSelect("tpv_datosgenerales", "pagovale", "1=1");
        if (!pagoVale || pagoVale == "")
          MessageBox.information(sys.translate("No tiene configurada la forma de pago vale en el formulario de datos generales"), MessageBox.Ok, MessageBox.NoButton);
        cursor.setValueBuffer("codpago", pagoVale);
      }
      break;
    }
    /** \C
    Al cambiar la --referencia-- se calcula su descripción y precio unitario, y se almacena su impuesto asociado
    */
    case "referencia": {
      var referencia = cursor.valueBuffer("referencia");
			if ((!referencia || referencia == "") && _i.txtDesArticulo.text == _i.txtVarios_) {
				break;
			}
			_i.txtDesArticulo.text = _i.calculateField("desarticulo");
      _i.txtPvpArticulo.text = _i.calculateField("pvparticulo");
      _i.ivaArticulo = _i.calculateField("ivaarticulo");
			_i.pvpVariable = _i.calculateField("pvpvariable");
      /// Quitado. No sabemos por qué se puso esto aquí
      /*
      if(cursor.valueBuffer("tipopago") == "Efectivo")
        cursor.setValueBuffer("codpago",AQUtil.sqlSelect("tpv_datosgenerales","pagoefectivo","1=1"));
      else
        cursor.setValueBuffer("codpago",AQUtil.sqlSelect("tpv_datosgenerales","pagotarjeta","1=1"));
      */
      break;
    }
    /** \C
    El valor de --coddir-- por defecto corresponde a la dirección del cliente marcada como dirección de facturación
    \end */
    case "codcliente": {
      this.child("fdbCodDir").setValue("0");
      this.child("fdbCodDir").setValue(_i.calculateField("coddir"));
      _i.actualizarIvaLineas(cursor.valueBuffer("codcliente"));
			_i.mostrarRecargo()
      break;
    }
    case "provincia": {
      if (!_i.bloqueoProvincia) {
        _i.bloqueoProvincia = true;
        flfactppal.iface.pub_obtenerProvincia(this);
        _i.bloqueoProvincia = false;
      }
      break;
    }
    case "idprovincia": {
      if (cursor.valueBuffer("idprovincia") == 0)
        cursor.setNull("idprovincia");
      break;
    }
    case "coddir": {
      this.child("fdbProvincia").setValue(_i.calculateField("provincia"));
      this.child("fdbCodPais").setValue(_i.calculateField("codpais"));
      break;
    }
    case "codbarrasLinea": {
      var referencia = AQUtil.sqlSelect("articulos", "referencia", "codbarras = '" + cursor.valueBuffer("codbarras") + "'");
      if (referencia) {
        this.child("fdbReferencia").setValue(referencia);
      }
      break;
    }
    case "codbarras": {
      /// Borrar cuando funcione codBarras_returnPressed()
      var referencia = AQUtil.sqlSelect("articulos", "referencia", "codbarras = '" + cursor.valueBuffer("codbarras") + "'");
      if (referencia) {
        this.child("fdbReferencia").setValue(referencia);
      }
      break;
    }
		case "tipodoc": {
			_i.habilitarPorTipoDoc();
			break;
		}
		case "pendiente":{
			_i.habilitarBotones();
		}
  }
}

function oficial_fdbReferencia_lostFocus()
{
	var _i = this.iface;
	var cursor= this.cursor();
	var referencia = cursor.valueBuffer("referencia");
	if (!referencia || referencia == "") {
		_i.txtDesArticulo.text = _i.txtVarios_;
	}
}

/** \C
Si la comanda está cerrada no podrá modificarse.<br/>
Si el --total-- es 0 no se podrá pagar, aplicar un descuento o sumar y restar 1 a la cantidad de las lineas
*/
function oficial_verificarHabilitaciones()
{
  var _i = this.iface;
  var cursor = this.cursor();

	_i.habilitarBotones();

  if (!AQUtil.sqlSelect("tpv_lineascomanda", "idtpv_linea", "idtpv_comanda = " + cursor.valueBuffer("idtpv_comanda"))) {
    this.child("fdbCodAlmacen").setDisabled(false);
  } else {
    this.child("fdbCodAlmacen").setDisabled(true);
  }
}

/** \C
Al establecer una cantidad de pago se calcula el importe a devolver
Si el importe entregado es mayor o igual al importe total de las lineas de la comanda, ésta se establecerá como cerrada
*/
function oficial_realizarPago()
{
  var _i = this.iface;
  var cursor = this.cursor();

  _i.datosVisorPagar();

  _i.refrescarPte();
	/** impPendiente se ha cambiado de sacarlo del label a sacarlo del campo porque ahora se formatea a miles (1.230,55) y toma el punto como decimal. 
  var impPendiente = parseFloat(_i.lblCantPte.text);*/
  var impPendiente = parseFloat(cursor.valueBuffer("pendiente"));
  if (!impPendiente){
    return false;
  }
  
  var idUsuario = sys.nameUser();
  var f = new FLFormSearchDB("tpv_cantidadpago");
  var curCantidadPago = f.cursor();

  curCantidadPago.select("idusuario = '" + idUsuario + "'");
  if (!curCantidadPago.first()) {
    curCantidadPago.setModeAccess(curCantidadPago.Insert);
  } else {
    curCantidadPago.setModeAccess(curCantidadPago.Edit);
  }
  f.setMainWidget();
  curCantidadPago.refreshBuffer();
  curCantidadPago.setValueBuffer("idusuario", idUsuario);
  curCantidadPago.setValueBuffer("importe", impPendiente);
	
	if (flfactppal.iface.pub_extension("puntos_tpv")) {
		curCantidadPago.setValueBuffer("puntosventa", _i.calculaPuntosVenta());
	}
	if (flfactppal.iface.pub_extension("fun_juguetiland")) {
		curCantidadPago.setValueBuffer("tipodoc", cursor.valueBuffer("tipodoc"));
		curCantidadPago.setValueBuffer("totalcomanda", cursor.valueBuffer("total"));
	}
  if (!_i.iniciaBufferCanPago(curCantidadPago)) {
    return false;
  }

  var entregado = f.exec("importe");
  if (!entregado) {
    return false;
  }
  _i.importePagado = entregado;

  curCantidadPago.commitBuffer();
  
  var impEntregado = _i.dameImporteEntregado(curCantidadPago);
  if (impEntregado == 0) {
    return false;
  }
  
  if (!_i.procesaCantidadesPago(curCantidadPago)) {
    return false;
  }
  
  _i.lblEntregado.setText(sys.translate("Entregado"));
  _i.lblCantEntregada.setText(AQUtil.formatoMiles(AQUtil.roundFieldValue(impEntregado, "tpv_comandas", "total")));

  return true;
}

function oficial_iniciaBufferCanPago(curCantidadPago)
{
  curCantidadPago.setNull("importeefectivo");
  curCantidadPago.setNull("cambioefectivo");
  curCantidadPago.setNull("importetarjeta");
	curCantidadPago.setNull("codtarjetapago");
  curCantidadPago.setNull("importevales");
  return true;
}

function oficial_dameImporteEntregado(curCantidadPago)
{
  var _i = this.iface;
  var importeTarjeta = curCantidadPago.isNull("importetarjeta") ? 0 : curCantidadPago.valueBuffer("importetarjeta");
  var importeEfectivo = curCantidadPago.isNull("importeefectivo") ? 0 : curCantidadPago.valueBuffer("importeefectivo");
  var importeVales = curCantidadPago.isNull("importevales") ? 0 : curCantidadPago.valueBuffer("importevales");
  return  importeVales + importeEfectivo + importeTarjeta;
}

function oficial_procesaCantidadesPago(curCantidadPago)
{
  var _i = this.iface;
  
  if (!_i.procesaCantidadEfectivo(curCantidadPago)) {
    return false;
  }
  
  if (!_i.procesaCantidadTarjeta(curCantidadPago)) {
    return false;
  }
  
  if (!_i.procesaCantidadVale(curCantidadPago)) {
    return false;
  }
  return true;
}  
  
function oficial_procesaCantidadEfectivo(curCantidadPago)
{
  var _i = this.iface;
  var cursor = this.cursor();
  
  var importeEfectivo = curCantidadPago.isNull("importeefectivo") ? 0 : curCantidadPago.valueBuffer("importeefectivo");
  var cambio = curCantidadPago.isNull("cambioefectivo") ? 0 : curCantidadPago.valueBuffer("cambioefectivo");
  if (importeEfectivo != 0) { /// Distinto de cero porque se admiten devoluciones de efectivo
    if (!_i.crearPago(AQUtil.roundFieldValue(importeEfectivo - cambio, "tpv_pagoscomanda", "importe"), "Efectivo")) {
      return false;
    } 
    cursor.setValueBuffer("ultentregado", AQUtil.roundFieldValue(importeEfectivo, "tpv_comandas", "total"));
  }
 /// if (cambio > 0) {
    _i.lblCambio.setText(sys.translate("Cambio"));
    _i.lblCantCambio.setText(AQUtil.formatoMiles(AQUtil.roundFieldValue(cambio, "tpv_comandas", "total")));
  ///}
  cursor.setValueBuffer("ultcambio", AQUtil.roundFieldValue(cambio, "tpv_comandas", "total"));
  return true;
}

function oficial_procesaCantidadTarjeta(curCantidadPago)
{
  var _i = this.iface;
  var cursor = this.cursor();
  
  var importeTarjeta = curCantidadPago.isNull("importetarjeta") ? 0 : curCantidadPago.valueBuffer("importetarjeta");
	var codTarjetaPago = curCantidadPago.valueBuffer("codtarjetapago");
  if (importeTarjeta > 0){
    if (!_i.crearPago(importeTarjeta , "Tarjeta", codTarjetaPago)) {
      return false;
    }
  }
  return true;
}

function oficial_procesaCantidadVale(curCantidadPago)
{
  var _i = this.iface;
  var cursor = this.cursor();
  
  var importeVales = curCantidadPago.isNull("importevales") ? 0 : curCantidadPago.valueBuffer("importevales");
  if (importeVales != 0) {
    var datosVales = curCantidadPago.valueBuffer("datosvales");
    if (datosVales == "") {
      return false;
    }
    var aVales = datosVales.split("\n");
    var aVale, importeVale;
    for (var v = 0; v < (aVales.length - 1); v++) {
      aVale = aVales[v].split("*");
      importeVale = aVale[1];
      if (!_i.crearPago(importeVale, "Vales", aVale[0])) {
        return false;
      }
    }
  }
  return true;
}

/** \D
Imprime el tique de la comanda. Antes guarda los datos actuales para poder obtenerlos correctamente en el informe
*/
function oficial_imprimirQuickClicked()
{
	var _i = this.iface;
  var cursor = this.cursor();

  _i.datosVisorImprimir();

	if(!_i.guardarComandaImpresion()){
		return;
	}

	var tipoDoc = cursor.valueBuffer("tipodoc");
	switch (tipoDoc){
		case "devolucion":
		case "DEVOLUCION":{
			_i.imprimirValeEmitido(cursor.valueBuffer("idtpv_comanda"));
			/// Se vuelve a imprimir el tique porque en la devolución puede haber comprado algo de menor valor que puede a su vez ser devuelto, y es necesario como justificante.
			if (!formtpv_comandas.iface.pub_imprimirQuick(cursor.valueBuffer("codigo"))){
				return;
			}
			break;
		}
		default:{
			if (!formtpv_comandas.iface.pub_imprimirQuick(cursor.valueBuffer("codigo"))){
				return;
			}
			if (!_i.imprimirValesUsados(cursor)) {
				return;
			}
			break;
		}
	}
	
	_i.lanzarImpresionTicketRegalo();
}
	
function oficial_guardarComandaImpresion()
{
	var _i = this.iface;
  var cursor = this.cursor();
	
	if (!_i.validateForm()){
    return false;
	}
  _i.acceptedForm();
  if (!cursor.commitBuffer()){
    return false;
	}
  cursor.setModeAccess(cursor.Edit);
  cursor.refreshBuffer();
	
	return true;
}

function oficial_lanzarImpresionTicketRegalo()
{
  var _i = this.iface;
	var cursor = this.cursor();
	
	_i.aDatos_ = this.child("tdbLineasComanda").primarysKeysChecked();
	if(_i.aDatos_.length > 0){
		_i.imprimirTicketRegalo();
	}
}

/** \D
Imprime el tique del vale. Antes guarda los datos actuales para poder obtenerlos correctamente en el informe
*/
function oficial_imprimirValeEmitido(idTpvComanda)
{
  var _i = this.iface;
	var cursor = this.cursor();
	/**if (!_i.validateForm()){
    return false;
	}
  _i.acceptedForm(); 
	if (!cursor.commitBuffer()){
    return false;
	}
	cursor.setModeAccess(cursor.Edit);
  cursor.refreshBuffer();*/

	formtpv_comandas.iface.pub_imprimirVale(idTpvComanda);
	return true;
}

/// Reimprime los vales usados para pagar que todavía tienen saldo
function oficial_imprimirValesUsados(cursor)
{
	var _i = this.iface;
	var idComanda = cursor.valueBuffer("idtpv_comanda");
	
	var q = new FLSqlQuery();
	q.setSelect("c.idtpv_comanda,c.saldopendiente,c.codigo");
	q.setFrom("tpv_pagoscomanda pc INNER JOIN tpv_comandas c ON pc.refvale = c.codigo");
	q.setWhere("pc.idtpv_comanda = " + idComanda + " GROUP BY c.idtpv_comanda,c.saldopendiente,c.codigo,pc.refvale");
	q.setForwardOnly(true);

	if (!q.exec()) {
		return false;
	}
	
	var valesCero = "";
	while (q.next()) {
		if(q.value("c.saldopendiente") == 0) {
			if(valesCero != ""){
				valesCero +=  ", ";
			}
			valesCero += q.value("c.codigo");
			continue;
		}
		formtpv_comandas.iface.pub_imprimirVale(q.value("c.idtpv_comanda"));
	}
	
	/**if(valesCero != "") {
		MessageBox.information(sys.translate("Los siguientes vales han quedado con saldo 0:\n%1").arg(valesCero), MessageBox.Ok, MessageBox.NoButton);
	}*/
	
	return true;
}

/** \D
Selecciona todas las lineas de la comanda
*/
function oficial_seleccionarTodo()
{
	var _i = this.iface;
  if (_i.seleccionado) {
    this.child("tbnSelTodo").setOn(false);
    _i.seleccionado = false;
  } else {
    this.child("tbnSelTodo").setOn(true);
    _i.seleccionado = true;
  }
}

/** \D
Suma uno a la cantidad de las líneas seleccionadas
*/
function oficial_unoMas()
{
  this.child("tdbLineasComanda").refresh();
	var _i = this.iface;
  var cursor = this.cursor();
  var curTrans = new FLSqlCursor("tpv_lineascomanda");

  if (_i.seleccionado) {
    var qry = new FLSqlQuery();
    qry.setTablesList("tpv_lineascomanda");
    qry.setSelect("idtpv_linea");
    qry.setFrom("tpv_lineascomanda");
    qry.setWhere("idtpv_comanda = '" + cursor.valueBuffer("idtpv_comanda") + "'");
    if (!qry.exec())
      return;
    while (qry.next()) {
      curTrans.transaction(false);
      try {
        if (_i.sumarUno(qry.value(0)))
          curTrans.commit();
        else
          curTrans.rollback();
      } catch (e) {
        MessageBox.warning(AQUtil.translate("scripts", "Hubo un error al incrementar la cantidad de las líneas:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
        curTrans.rollback();
      }
    }
  } else {
    curTrans.transaction(false);
    try {
      if (_i.sumarUno(this.child("tdbLineasComanda").cursor().valueBuffer("idtpv_linea")))
        curTrans.commit();
      else
        curTrans.rollback();
    } catch (e) {
      MessageBox.warning(AQUtil.translate("scripts", "Hubo un error al incrementar la cantidad de las líneas:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
      curTrans.rollback();
    }
  }

  this.child("tdbLineasComanda").refresh();
}

/** \D
Suma uno a la cantidad de una linea
@param idLinea identificador de la linea
@return devuelve true si se ha sumado correctamente y false si ha habido algún error
*/
function oficial_sumarUno(idLinea)
{
	var _i = this.iface;
  if (!idLinea){
    return false;
	}
  var curLinea = new FLSqlCursor("tpv_lineascomanda");
  curLinea.select("idtpv_linea = " + idLinea);
  curLinea.first();
  curLinea.setModeAccess(curLinea.Edit);
  curLinea.refreshBuffer();
  curLinea.setValueBuffer("cantidad", parseFloat(curLinea.valueBuffer("cantidad")) + 1);
  curLinea.setValueBuffer("pvpsindto", _i.calcularTotalesLinea("pvpsindto", curLinea));
  curLinea.setValueBuffer("pvptotal", _i.calcularTotalesLinea("pvptotal", curLinea));
  if (!curLinea.commitBuffer())
    return false;

  _i.calcularTotales();
  return true;
}

/** \D
Resta uno a la cantidad de las lineas seleccionadas
Si la cantidad es cero elimina las lineas
*/
function oficial_unoMenos()
{
	var _i = this.iface;
  var cursor = this.cursor();
  var curTrans = new FLSqlCursor("tpv_lineascomanda");

  if (_i.seleccionado) {
    var qry = new FLSqlQuery();
    qry.setTablesList("tpv_lineascomanda");
    qry.setSelect("idtpv_linea");
    qry.setFrom("tpv_lineascomanda");
    qry.setWhere("idtpv_comanda = '" + cursor.valueBuffer("idtpv_comanda") + "'");
    if (!qry.exec())
      return;
    while (qry.next()) {
      curTrans.transaction(false);
      try {
        if (_i.restarUno(qry.value(0)))
          curTrans.commit();
        else
          curTrans.rollback();
      } catch (e) {
        MessageBox.warning(AQUtil.translate("scripts", "Hubo un error al decrementar la cantidad de las líneas:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
        curTrans.rollback();
      }
    }
  } else {
    curTrans.transaction(false);
    try {
      if (_i.restarUno(this.child("tdbLineasComanda").cursor().valueBuffer("idtpv_linea")))
        curTrans.commit();
      else
        curTrans.rollback();
    } catch (e) {
      MessageBox.warning(AQUtil.translate("scripts", "Hubo un error al decrementar la cantidad de las líneas:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
      curTrans.rollback();
    }
  }
  this.child("tdbLineasComanda").refresh();
}

/** \D
Resta uno a la cantidad de una linea
@param idLinea identificador de la linea
@return devuelve true si se ha restado correctamente y false si ha habido algún error
*/
function oficial_restarUno(idLinea)
{
  if (!idLinea){
    return false;
	}
  var _i = this.iface;
  var curLinea = new FLSqlCursor("tpv_lineascomanda");
  curLinea.select("idtpv_linea = " + idLinea);
  curLinea.first();
  var cantidad = parseFloat(curLinea.valueBuffer("cantidad")) - 1;
  if (cantidad == 0) {
    var res = MessageBox.warning(sys.translate("La cantidad de la linea ") + idLinea + sys.translate(" es 0 ¿Seguro que desea eliminarla?"), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
    if (res != MessageBox.Yes)
      return false;
    curLinea.setModeAccess(curLinea.Del);
  } else {
    curLinea.setModeAccess(curLinea.Edit);
    curLinea.refreshBuffer();
    curLinea.setValueBuffer("cantidad", cantidad);
    curLinea.setValueBuffer("pvpsindto", _i.calcularTotalesLinea("pvpsindto", curLinea));
    curLinea.setValueBuffer("pvptotal", _i.calcularTotalesLinea("pvptotal", curLinea));
  }
  if (!curLinea.commitBuffer()){
    return false;
	}
	this.child("tdbLineasComanda").refresh();
  _i.calcularTotales();
	_i.habilitarAnularVale();
  return true;
}

/** \D
Aplica un descueto a las líneas selecciondas
*/
function oficial_aplicarDescuento()
{
  var _i = this.iface;
  var dialog = new Dialog(sys.translate("Descuento"), 0, "desucento");

  dialog.OKButtonText = sys.translate("Aceptar");
  dialog.cancelButtonText = sys.translate("Cancelar");

  var descuentoLineal = new NumberEdit;
  descuentoLineal.value = this.child("tdbLineasComanda").cursor().valueBuffer("dtolineal");
  descuentoLineal.label = sys.translate("Descuento lineal:");
  descuentoLineal.maximum = this.child("tdbLineasComanda").cursor().valueBuffer("pvpsindto");
  descuentoLineal.decimals = 2;
  dialog.add(descuentoLineal);

  var porDescuento = new NumberEdit;
  porDescuento.value = this.child("tdbLineasComanda").cursor().valueBuffer("dtopor");
  porDescuento.label = sys.translate("% Descuento:");
  porDescuento.maximum = 100;
  porDescuento.decimals = 2;
  dialog.add(porDescuento);

  if (!dialog.exec())
    return true;

  if (_i.seleccionado) {
    var qry = new FLSqlQuery();
    qry.setTablesList("tpv_lineascomanda");
    qry.setSelect("idtpv_linea");
    qry.setFrom("tpv_lineascomanda");
    qry.setWhere("idtpv_comanda = '" + this.cursor().valueBuffer("idtpv_comanda") + "'");
    if (!qry.exec())
      return;
    while (qry.next())
      _i.descontar(qry.value(0), descuentoLineal.value, porDescuento.value);
  } else
    _i.descontar(this.child("tdbLineasComanda").cursor().valueBuffer("idtpv_linea"), descuentoLineal.value, porDescuento.value);

  this.child("tdbLineasComanda").refresh();
}

/** \D
Aplica un descuento a la linea
@param idLinea identificador de la linea
@param descuentoLineal descuento lineal
@param porDescuento descuento en porcentaje
@return devuelve true si se ha aplicado correctamente y false si ha habido algún error
*/
function oficial_descontar(idLinea, descuentoLineal, porDescuento)
{
	var _i = this.iface;
  if (!idLinea){
    return false;
	}
  var curLinea = new FLSqlCursor("tpv_lineascomanda");
  curLinea.select("idtpv_linea = " + idLinea);
  curLinea.first();
  curLinea.setModeAccess(curLinea.Edit);
  curLinea.refreshBuffer();
  curLinea.setValueBuffer("dtolineal", descuentoLineal);
  curLinea.setValueBuffer("dtopor", porDescuento);
  curLinea.setValueBuffer("pvptotal", _i.calcularTotalesLinea("pvptotal", curLinea));
  if (!curLinea.commitBuffer())
    return false;
  _i.calcularTotales();
  return true;
}

/** \D
Calcula los totales de la linea de la factura creada
*/
function oficial_calcularTotalesLinea(fN, cursor)
{
  var _i = this.iface;
  var valor;

  switch (fN) {
      /** \c
      EL --pvpsindto-- es el --pvpunitario-- multiplicado por la --cantidad--
      */
    case "pvpsindto": {
      valor = parseFloat(cursor.valueBuffer("pvpunitario")) * parseFloat(cursor.valueBuffer("cantidad"));
      valor = AQUtil.roundFieldValue(valor, "tpv_lineascomanda", "pvpsindto");
      break;
    }
    /** \c
    EL --pvptotal-- es el --pvpsindto-- menos el descuento --dtopor-- menos el --dtolineal--
    */
    case "pvptotal": {
      var dtoPor = (cursor.valueBuffer("pvpsindto") * cursor.valueBuffer("dtopor")) / 100;
      dtoPor = AQUtil.roundFieldValue(dtoPor, "tpv_lineascomanda", "pvpsindto");
      valor = cursor.valueBuffer("pvpsindto") - parseFloat(dtoPor) - cursor.valueBuffer("dtolineal");
      break;
    }
  }
  return valor;
}

/** \D
Aplica la tarifa establecida a todas las lineas de la comanda
*/
function oficial_aplicarTarifa()
{
	var _i = this.iface;
	
  var codTarifa = this.cursor().valueBuffer("codtarifa");
  var qry = new FLSqlQuery();
  qry.setTablesList("tpv_lineascomanda");
  qry.setSelect("idtpv_linea,referencia");
  qry.setFrom("tpv_lineascomanda");
  qry.setWhere("idtpv_comanda = '" + this.cursor().valueBuffer("idtpv_comanda") + "'");
  if (!qry.exec()) {
    return;
  }

  if (!_i.curLineas) {
    _i.curLineas = this.child("tdbLineasComanda").cursor();
  }
  while (qry.next()) {
    //    var pvp= formRecordtpv_lineascomanda.iface.pub_calcularPvpTarifa(qry.value(1),codTarifa);
    _i.curLineas.select("idtpv_linea = " + qry.value("idtpv_linea"));
    _i.curLineas.first();

    _i.curLineas.setModeAccess(_i.curLineas.Edit);
    _i.curLineas.refreshBuffer();
    if (!_i.aplicarTarifaLinea(codTarifa)) {
      return false;
    }
    if (!_i.curLineas.commitBuffer()) {
      return;
    }
  }

  _i.calcularTotales();
  this.child("tdbLineasComanda").refresh();
}

function oficial_aplicarTarifaLinea(codTarifa)
{
	var _i = this.iface;
	
  _i.curLineas.setValueBuffer("pvpunitario", formRecordtpv_lineascomanda.iface.pub_commonCalculateField("pvpunitario", _i.curLineas));
  _i.curLineas.setValueBuffer("pvpsindto",
                                      formRecordtpv_lineascomanda.iface.pub_commonCalculateField("pvpsindto", _i.curLineas));
  _i.curLineas.setValueBuffer("pvptotal",
                                      formRecordtpv_lineascomanda.iface.pub_commonCalculateField("pvptotal", _i.curLineas));
  return true;
}

/** \D
Desconecta las funciones conectadas en el init
*/
function oficial_desconectar()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
  disconnect(cursor, "bufferChanged(QString)", _i, "bufferChanged");
  disconnect(this.child("tdbLineasComanda").cursor(), "bufferCommited()", _i, "calcularTotales()");
  disconnect(this.child("pbnPagar"), "clicked()", _i, "realizarPago()");
  disconnect(this.child("tbnPrintQuick"), "clicked()", _i, "imprimirQuickClicked()");
  disconnect(this.child("tbnSelTodo"), "clicked()", _i, "seleccionarTodo()");
  disconnect(this.child("tbnUnoMas"), "clicked()", _i, "unoMas()");
  disconnect(this.child("tbnUnoMenos"), "clicked()", _i, "unoMenos()");
  disconnect(this.child("tbnDescuento"), "clicked()", _i, "aplicarDescuento()");
  disconnect(this.child("tbnOpenCash"), "clicked()", _i, "abrirCajonClicked()");
}

/** \D
Crea un pago
@param  importe: Importe del pago
@return true si el pago se crea correctamente, false en caso contrario
*/
function oficial_crearPago(importe, formaPago, refVale)
{
  var _i = this.iface;
  var cursor = this.cursor();
	
  _i.refrescoActivo = false;

  var fecha = new Date;
  var idComanda = cursor.valueBuffer("idtpv_comanda");

  var curPago = this.child("tdbPagos").cursor();
  disconnect(curPago, "bufferChanged(QString)", formRecordtpv_pagoscomanda, "iface.bufferChanged");
  var codTerminal = flfact_tpv.iface.pub_valorDefectoTPV("codterminal");
	
  with(curPago) {
    setModeAccess(Insert);
    refreshBuffer();
    setValueBuffer("idtpv_comanda", idComanda);
    setValueBuffer("importe", importe);
    setValueBuffer("fecha", fecha);
    setValueBuffer("estado", sys.translate("Pagado"));
    if (codTerminal) {
      setValueBuffer("codtpv_puntoventa", codTerminal);
      setValueBuffer("codtpv_agente", cursor.valueBuffer("codtpv_agente")); 
    }
  }
  if (!_i.datosPago(curPago, formaPago, refVale)) {
    _i.refrescoActivo = true;
    return false;
  }
  if (!_i.validarPago(curPago)) {
    _i.refrescoActivo = true;
    return false;
  }

  if (!curPago.commitBuffer()) {
    _i.refrescoActivo = true;
    return false;
  }

  _i.refrescoActivo = true;
  _i.verificarHabilitaciones();
  return true;
}

function oficial_validarPago(curPago)
{
  var _i = this.iface;
	
  if (!flfact_tpv.iface.pub_controlDevolEfectivo(curPago)) {
    return false;
  }
  return true;
}

function oficial_datosPago(curPago, formaPago, refVale)
{
  var _i = this.iface;
	
	switch (formaPago){
		case "Efectivo":{
			var pagoEfectivo = AQUtil.sqlSelect("tpv_datosgenerales", "pagoefectivo", "1=1");
			if (!pagoEfectivo || pagoEfectivo == "") {
				MessageBox.information(sys.translate("No tiene configurada la forma de pago efectivo en el formulario de datos generales"), MessageBox.Ok, MessageBox.NoButton);
			}
			curPago.setValueBuffer("codpago", pagoEfectivo);
			break;
		}
		case "Tarjeta":{
			 var pagoTarjeta = AQUtil.sqlSelect("tpv_datosgenerales", "pagotarjeta", "1=1");
			if (!pagoTarjeta || pagoTarjeta == ""){
				MessageBox.information(sys.translate("No tiene configurada la forma de pago por tarjeta en el formulario de datos generales"), MessageBox.Ok, MessageBox.NoButton);
			}
			curPago.setValueBuffer("codpago", pagoTarjeta);
			curPago.setValueBuffer("codtarjetapago", refVale);
			break;
		}
		case "Vales":{
			var pagoVale = flfact_tpv.iface.pub_valorDefectoTPV("pagovale");
			if (!pagoVale || pagoVale == ""){
				MessageBox.information(sys.translate("No tiene configurada la forma de pago en vales en el formulario de datos generales"), MessageBox.Ok, MessageBox.NoButton);
			}
			curPago.setValueBuffer("codpago", pagoVale);
			curPago.setValueBuffer("refvale", refVale);
			if(_i.anularClicked_){
				curPago.setValueBuffer("anulado", true);
			}
			else{
				curPago.setValueBuffer("anulado", false);
			}
			break;
		}
		default: {
			break;
		}
	}
	return true;
}

/** \D Refresca el display con la cantidad pendiente de pago
\end */
function oficial_refrescarPte()
{
  var _i = this.iface;
  if (!_i.refrescoActivo){
    return;
	}
	
	var cantidadPte = AQUtil.roundFieldValue(this.cursor().valueBuffer("pendiente"), "tpv_comandas", "total");
	cantidadPte = AQUtil.formatoMiles(cantidadPte);
	
  _i.lblCantPte.setText(cantidadPte);
  _i.lblEntregado.setText("");
  _i.lblCambio.setText("");
  _i.lblCantEntregada.setText("");
  _i.lblCantCambio.setText("");

}

/** \D Calcula el total pagado cuando el cursor de pagos cambia
\end */
function oficial_calcularPagado()
{
	var _i = this.iface;
  this.child("fdbPagado").setValue(_i.calculateField("pagado"));
}

/** \D Abre el cajón portamonedas
*/
function oficial_abrirCajonClicked()
{
  var _i = this.iface;

	var oImp = flfact_tpv.iface.pub_estableceImpresoraPV();
	if (!oImp) {
		return false;
	}
  formtpv_comandas.iface.pub_abrirCajon(oImp.nombre, oImp.esccajon);
}

/** \D Pasa a la siguiente venta
*/
function oficial_pasarSiguienteVenta()
{
  var _i = this.iface;

	this.child("pushButtonAccept").setDisabled(false);
	this.child("pushButtonAcceptContinue").setDisabled(false);
	var res = MessageBox.information(sys.translate("Venta realizada.\nPulse aceptar para pasar a la siguiente"), MessageBox.Ok, MessageBox.Cancel);
	if (res != MessageBox.Ok) {
		return;
	}
	this.child("pushButtonAcceptContinue").animateClick();
}

/** \D Inserta la línea con los datos de inserción rápida
\end */
function oficial_insertarLineaClicked()
{
	var _i = this.iface;
	
	_i.insertarLinea();
	_i.limpiarDatos();
	_i.ponerSignoCantidad();
}

function oficial_insertarLinea()
{
	var _i = this.iface;
  if (isNaN(parseFloat(_i.txtCanArticulo.text)))
    return;
  if (isNaN(parseFloat(_i.txtPvpArticulo.text)))
    return;
  if (_i.txtDesArticulo.text == "")
    return;

  var cursor = this.cursor();
  _i.curLineas = this.child("tdbLineasComanda").cursor();
  _i.curLineas.setModeAccess(_i.curLineas.Insert);

  if (cursor.modeAccess() == cursor.Insert) {
    if (!_i.curLineas.commitBufferCursorRelation()) {
      return;
    }
  }
  _i.curLineas.refreshBuffer();
  if (!_i.datosLineaVenta()) {
    return;
  }
  
	_i.datosVisorArt(_i.curLineas);

  if (!_i.curLineas.commitBuffer()) {
    return;
  }

}
  
function oficial_limpiarDatos()
{
	var _i = this.iface;
	
  _i.txtCanArticulo.text = "";
  this.child("fdbReferencia").setValue("");
  this.child("fdbCodBarras").setValue("");
  _i.txtDesArticulo.text = "";
  _i.txtPvpArticulo.text = "";
  _i.ivaArticulo = "";
	_i.pvpVariable = false;
  _i.txtCanArticulo.text = "1";
  _i.cursorAPosicionInicial();

  this.child("tdbLineasComanda").refresh();
}

/** |D Establece los datos de la línea de ventas a crear mediante la inserción rápida
\end */
function oficial_datosLineaVenta()
{
	var _i = this.iface;
	if (!_i.datosLineaVentaArt()) {
		return false;
	}
	if (!_i.datosLineaVentaIva()) {
		return false;
	}
	if (!_i.datosLineaVentaPvpUnitario()) {
		return false;
	}
	if (!_i.datosLineaVentaCantidad()) {
		return false;
	}
	if (!_i.datosLineaVentaPrecio()) {
		return false;
	}
	return true;
}

function oficial_datosLineaVentaArt()
{
  var _i = this.iface;
  var cursor = this.cursor();
  _i.curLineas.setValueBuffer("referencia", cursor.valueBuffer("referencia"));
  _i.curLineas.setValueBuffer("descripcion", _i.txtDesArticulo.text);
  
  return true;
}

function oficial_datosLineaVentaPvpUnitario()
{
  var _i = this.iface;
  var cursor = this.cursor();
  _i.curLineas.setValueBuffer("pvpunitario", AQUtil.roundFieldValue(_i.txtPvpArticulo.text, "tpv_lineascomanda", "pvpunitario"));
  
  return true;
}

function oficial_datosLineaVentaIva()
{
  var _i = this.iface;
  var cursor = this.cursor();
  _i.curLineas.setValueBuffer("codimpuesto",  _i.calcularIvaLinea(_i.curLineas.valueBuffer("referencia")));
  _i.curLineas.setValueBuffer("iva", formRecordtpv_lineascomanda.iface.pub_commonCalculateField("iva", _i.curLineas));
  _i.curLineas.setValueBuffer("recargo", formRecordtpv_lineascomanda.iface.pub_commonCalculateField("recargo", _i.curLineas));
  
  return true;
}

function oficial_datosLineaVentaCantidad()
{
  var _i = this.iface;
  var cursor = this.cursor();
  _i.curLineas.setValueBuffer("cantidad", AQUtil.roundFieldValue(_i.txtCanArticulo.text, "tpv_lineascomanda", "cantidad"));
  
  return true;
}

function oficial_datosLineaVentaPrecio()
{
  var _i = this.iface;
  var cursor = this.cursor();
  _i.curLineas.setValueBuffer("pvpsindto", formRecordtpv_lineascomanda.iface.pub_commonCalculateField("pvpsindto", _i.curLineas));
  _i.curLineas.setValueBuffer("dtopor", formRecordtpv_lineascomanda.iface.pub_commonCalculateField("dtopor", _i.curLineas));
  _i.curLineas.setValueBuffer("pvptotal", formRecordtpv_lineascomanda.iface.pub_commonCalculateField("pvptotal", _i.curLineas));
  _i.curLineas.setValueBuffer("costeunitario", formRecordtpv_lineascomanda.iface.pub_commonCalculateField("costeunitario", _i.curLineas));

  return true;
}

function oficial_calcularIvaLinea(referencia)
{
  var _i = this.iface;
  var cursor = this.cursor();
  var valor;
	
  var codSerie = "";
  if (flfacturac.iface.pub_tieneIvaDocCliente(codSerie, cursor.valueBuffer("codcliente"))) {
    if (referencia) {
      valor = AQUtil.sqlSelect("articulos", "codimpuesto", "referencia = '" + referencia + "'");
    } else {
      valor = flfactalma.iface.pub_valorDefectoAlmacen("codimpuesto");
    }
  } else {
    valor = "";
  }
  return valor;
}

/** \D Muestra la factura asociada a la venta
\end */
function oficial_mostrarFactura()
{
  var _i = this.iface;
  var cursor = this.cursor();
	
  var idFactura = cursor.valueBuffer("idfactura");
  if (!idFactura || idFactura == "")
    return;
  var curFactura = new FLSqlCursor("facturascli");
  curFactura.select("idfactura = " + idFactura);
  if (!curFactura.first())
    return;
  curFactura.browseRecord();
}

function oficial_datosVisorArt(curLineas)
{
  var _i = this.iface;
  var cursor = this.cursor();
	
  var codPuntoVenta = cursor.valueBuffer("codtpv_puntoventa");

  var datos = [];
  datos[0] = cursor.valueBuffer("referencia");

  var des = AQUtil.sqlSelect("articulos", "descripcion", "referencia = '" + datos[0] + "'");
  if (!des)
    des = "";
  datos[1] = des;

  var otrosDatos = [];
  otrosDatos[0] = "PVP";

  var precio = AQUtil.roundFieldValue(this.child("txtPvpArticulo").text, "tpv_comandas", "total");
  if (!precio || precio == "")
    precio = 0;
  otrosDatos[1] = precio;

  var linea1 = _i.formatearLineaVisor(codPuntoVenta, 1, datos, "CONCAT");
  var linea2 = _i.formatearLineaVisor(codPuntoVenta, 2, otrosDatos, "SEPARAR");
  var datosVisor = [];
  datosVisor[0] = linea1;
  datosVisor[1] = linea2;
  debug(datosVisor);
  _i.escribirEnVisor(codPuntoVenta, datosVisor);
}

function oficial_datosVisorPagar()
{
  var _i = this.iface;
  var cursor = this.cursor();
  var codPuntoVenta = cursor.valueBuffer("codtpv_puntoventa");

  var datos = [];
  datos[0] = "TOTAL";
  datos[1] = cursor.valueBuffer("total");

  var linea1 = _i.formatearLineaVisor(codPuntoVenta, 1, datos, "SEPARAR");
  var linea2 = "";
  var datosVisor = [];
  datosVisor[0] = linea1;
  datosVisor[1] = linea2;
  _i.escribirEnVisor(codPuntoVenta, datosVisor);
}

function oficial_datosVisorImprimir()
{
  var _i = this.iface;
  var cursor = this.cursor();
	
  var codPuntoVenta = cursor.valueBuffer("codtpv_puntoventa");
  var datos = [];
  datos [0] = "ENTREGADO";
  datos [1] = AQUtil.roundFieldValue(_i.importePagado, "tpv_comandas", "total");

  var otrosDatos = [];
  otrosDatos[0] = "CAMBIO";
  otrosDatos[1] = AQUtil.roundFieldValue(parseFloat(_i.importePagado - cursor.valueBuffer("total")), "tpv_comandas", "total");

  var linea1 = _i.formatearLineaVisor(codPuntoVenta, 1, datos, "SEPARAR");
  var linea2 = _i.formatearLineaVisor(codPuntoVenta, 2, otrosDatos, "SEPARAR");
  var datosVisor = [];
  datosVisor[0] = linea1;
  datosVisor[1] = linea2;
  _i.escribirEnVisor(codPuntoVenta, datosVisor);
}

function oficial_formatearLineaVisor(codPuntoVenta, numLinea, datos, formato)
{
  var _i = this.iface;
  var cursor = this.cursor();
	
  var cadena = "";
  var longLinea = AQUtil.sqlSelect("tpv_puntosventa", "numcaractvisor", "codtpv_puntoventa = '" + codPuntoVenta + "'");
  if (!longLinea) {
    longLinea  = 25;
  }
  var numDatos = datos.length;

  switch (formato) {
    case "CONCAT": {
      for (var i = 0; i < numDatos; i++) {
        if (cadena == "") {
          cadena = datos[i];
        } else {
          cadena += "-" + datos[i];
        }
      }
      cadena = cadena.left(longLinea);
      break;
    }
    case "SEPARAR": {
      var ultimoValor = datos[numDatos - 1].toString();
      for (var i = 0; i < (numDatos - 1); i++)
        cadena += datos[i] + " ";
      var totalEspacios = longLinea - cadena.length - ultimoValor.length;
      if (totalEspacios < 0) {
        cadena = cadena.left(longLinea - (ultimoValor.length + 1));
        cadena += " ";
      } else {
        for (var i = 0; i < totalEspacios; i++)
          cadena += " ";
      }
      cadena += ultimoValor;
      break;
    }
  }

  var visor = "";
  for (var i = 0; i < longLinea; i++) {
    visor += "*";
  }
  debug(visor);
  debug(cadena);
  return cadena;
}

function oficial_escribirEnVisor(codPuntoVenta, datos)
{
  var _i = this.iface;

  try {
    var serialPort = new FLSerialPort(nameSerialPort);
  } catch (e) {
    return;
  }

  var usarVisor = AQUtil.sqlSelect("tpv_puntosventa", "usarvisor", "codtpv_puntoventa = '" + codPuntoVenta + "'");
  if (usarVisor != true) {
    return;
  }
  var nameSerialPort = AQUtil.sqlSelect("tpv_puntosventa", "nombrepuertovisor", "codtpv_puntoventa = '" + codPuntoVenta + "'");

  if (!nameSerialPort || nameSerialPort == "") {
    MessageBox.information(AQUtil.translate("scripts",
                                          "No es posible usar el visor asociado al punto de venta '" + codPuntoVenta + "'.\n Debe informar el campo Nombre puerto en el formulario del punto de venta"), MessageBox.Ok, MessageBox.NoButton);
    return false;
  }

  var serialPort = new FLSerialPort(nameSerialPort);

  var baud = "";
  var baudRateVisor = AQUtil.sqlSelect("tpv_puntosventa", "baudratevisor", "codtpv_puntoventa = '" + codPuntoVenta + "'");
  if (!baudRateVisor || baudRateVisor == "") {
    MessageBox.information(AQUtil.translate("scripts",
                                          "No es posible usar el visor asociado al punto de venta '" + codPuntoVenta + "'.\n Debe informar el campo Baud Rate en el formulario del punto de venta"), MessageBox.Ok, MessageBox.NoButton);
    return false;
  }
  switch (baudRateVisor) {
    case "50": {
      baud = serialPort.BAUD50;
      break;
    }
    case "75": {
      baud = serialPort.BAUD75;
      break;
    }
    case "110": {
      baud = serialPort.BAUD110;
      break;
    }
    case "134": {
      baud = serialPort.BAUD134;
      break;
    }
    case "150": {
      baud = serialPort.BAUD150;
      break;
    }
    case "200": {
      baud = serialPort.BAUD200;
      break;
    }
    case "300": {
      baud = serialPort.BAUD300;
      break;
    }
    case "600": {
      baud = serialPort.BAUD600;
      break;
    }
    case "1200": {
      baud = serialPort.BAUD1200;
      break;
    }
    case "1800": {
      baud = serialPort.BAUD1800;
      break;
    }
    case "2400": {
      baud = serialPort.BAUD2400;
      break;
    }
    case "4800": {
      baud = serialPort.BAUD4800;
      break;
    }
    case "9600": {
      baud = serialPort.BAUD9600;
      break;
    }
    case "14400": {
      baud = serialPort.BAUD14400;
      break;
    }
    case "19200": {
      baud = serialPort.BAUD19200;
      break;
    }
    case "38400": {
      baud = serialPort.BAUD38400;
      break;
    }
    case "56000": {
      baud = serialPort.BAUD56000;
      break;
    }
    case "57600": {
      baud = serialPort.BAUD57600;
      break;
    }
    case "76800": {
      baud = serialPort.BAUD76800;
      break;
    }
    case "115200": {
      baud = serialPort.BAUD115200;
      break;
    }
    case "128000": {
      baud = serialPort.BAUD128000;
      break;
    }
    case "256000": {
      baud = serialPort.BAUD256000;
      break;
    }
  }

  var data = "";
  var bitDatos = AQUtil.sqlSelect("tpv_puntosventa", "bitdatosvisor", "codtpv_puntoventa = '" + codPuntoVenta + "'");
  if (!bitDatos || bitDatos == "") {
    MessageBox.information(AQUtil.translate("scripts",
                                          "No es posible usar el visor asociado al punto de venta '" + codPuntoVenta + "'.\n Debe informar el campo Bit datos en el formulario del punto de venta"), MessageBox.Ok, MessageBox.NoButton);
    return false;
  }
  switch (bitDatos) {
    case "5": {
      data = serialPort.DATA_5;
      break;
    }
    case "6": {
      data = serialPort.DATA_6;
      break;
    }
    case "7": {
      data = serialPort.DATA_7;
      break;
    }
    case "8": {
      data = serialPort.DATA_8;
      break;
    }
  }

  var par = "";
  var paridad = AQUtil.sqlSelect("tpv_puntosventa", "paridadvisor", "codtpv_puntoventa = '" + codPuntoVenta + "'");
  if (!paridad || paridad == "") {
    MessageBox.information(AQUtil.translate("scripts",
                                          "No es posible usar el visor asociado al punto de venta '" + codPuntoVenta + "'.\n Debe informar el campo Paridad en el formulario del punto de venta"), MessageBox.Ok, MessageBox.NoButton);
    return false;
  }
  switch (paridad) {
    case "Sin paridad": {
      par = serialPort.PAR_NONE;
      break;
    }
    case "Impar": {
      par = serialPort.PAR_ODD;
      break;
    }
    case "Par": {
      par = serialPort.PAR_EVEN;
      break;
    }
    case "MARK": {
      par = serialPort.PAR_MARK;
      break;
    }
    case "SPACE": {
      par = serialPort.PAR_SPACE;
      break;
    }
  }

  var stop = "";
  var bitStop = AQUtil.sqlSelect("tpv_puntosventa", "bitstopvisor", "codtpv_puntoventa = '" + codPuntoVenta + "'");
  if (!bitStop || bitStop == "") {
    MessageBox.information(AQUtil.translate("scripts",
                                          "No es posible usar el visor asociado al punto de venta '" + codPuntoVenta + "'.\n Debe informar el campo Bit stop en el formulario del punto de venta"), MessageBox.Ok, MessageBox.NoButton);
    return false;
  }
  switch (bitStop) {
    case "1": {
      stop = serialPort.STOP_1;
      break;
    }
    case "1_5": {
      stop = serialPort.STOP_1_5;
      break;
    }
    case "2": {
      stop = serialPort.STOP_2;
      break;
    }
  }

  var flow = "";
  var flowControl = AQUtil.sqlSelect("tpv_puntosventa", "flowcontrol", "codtpv_puntoventa = '" + codPuntoVenta + "'");
  if (!flowControl || flowControl == "") {
    MessageBox.information(AQUtil.translate("scripts",
                                          "No es posible usar el visor asociado al punto de venta '" + codPuntoVenta + "'.\n Debe informar el campo Control Flujo en el formulario del punto de venta"), MessageBox.Ok, MessageBox.NoButton);
    return false;
  }
  switch (flowControl) {
    case "FLOW_HARDWARE": {
      flow = serialPort.FLOW_HARDWARE;
      break;
    }
    case "FLOW_OFF": {
      flow = serialPort.FLOW_OFF;
      break;
    }
    case "FLOW_XONXOFF": {
      flow = serialPort.FLOW_XONXOFF;
      break;
    }
  }
  serialPort.setBaudRate(baud);
  serialPort.setDataBits(data);
  serialPort.setParity(par);
  serialPort.setStopBits(stop);
  serialPort.setFlowControl(flow);
  serialPort.setTimeout(0, 30);

  var qry = new FLSqlQuery();
  qry.setTablesList("tpv_puntosventa");
  qry.setSelect("iniciarvisor, limpiarvisor, prefprimeralinea, sufprimeralinea, prefsegundalinea, sufsegundalinea");
  qry.setFrom("tpv_puntosventa");
  qry.setWhere("codtpv_puntoventa = '" + codPuntoVenta + "'");
  if (!qry.exec())
    return;
  var iniciar = "";
  var limpiar = "";
  var prefPrimera = "";
  var sufPrimera = "";
  var prefSegunda = "";
  var sufSegunda = "";
  if (qry.first()) {
    var iniciarVisor = qry.value("iniciarvisor");
    var arrayIniciarVisor = iniciarVisor.split(",");
    for (var i = 0; i < arrayIniciarVisor.length; i++) {
      iniciar += String.fromCharCode(arrayIniciarVisor[i]);
    }
    var limpiarVisor = qry.value("limpiarvisor");
    var arrayLimpiarVisor = limpiarVisor.split(",");
    for (var i = 0; i < arrayLimpiarVisor.length; i++) {
      limpiar += String.fromCharCode(arrayLimpiarVisor[i]);
    }
    var ppl = qry.value("prefprimeralinea");
    var arrayPpl = ppl.split(",");
    for (var i = 0; i < arrayPpl.length; i++) {
      prefPrimera += String.fromCharCode(arrayPpl[i]);
    }
    var spl = qry.value("sufprimeralinea");
    var arraySpl = spl.split(",");
    for (var i = 0; i < arraySpl.length; i++) {
      sufPrimera += String.fromCharCode(arraySpl[i]);
    }
    var psl = qry.value("prefsegundalinea");
    var arraySpl = psl.split(",");
    for (var i = 0; i < arraySpl.length; i++) {
      prefSegunda += String.fromCharCode(arraySpl[i]);
    }
    var ssl = qry.value("sufsegundalinea");
    var arraySsl = ssl.split(",");
    for (var i = 0; i < arraySsl.length; i++) {
      sufSegunda += String.fromCharCode(arraySsl[i]);
    }
  }

  var sec;
  if (serialPort.open()) {
    sec = iniciar;
    sec += limpiar;
    sec += prefPrimera;
    sec += datos[0];
    sec += sufPrimera;
    sec += prefSegunda;
    sec += datos[1];
    sec += sufSegunda;
    serialPort.writeText(sec);
    serialPort.close();
  }
}

//     debug( "Prueba posdiplay" );
//     var nameSerialPort= "/dev/ttyS0";
//     var serialPort= new FLSerialPort( nameSerialPort );
//
//     serialPort.setBaudRate( serialPort.BAUD9600 );
//     serialPort.setDataBits( serialPort.DATA_8 );
//     serialPort.setParity( serialPort.PAR_NONE );
//     serialPort.setStopBits( serialPort.STOP_1 );
//     serialPort.setFlowControl( serialPort.FLOW_HARDWARE );
//     serialPort.setTimeout( 0, 30 );
//
//     var sec:String;
//     if ( serialPort.open() ) {
//  sec = String.fromCharCode( 27, 64, 12, 27, 81, 65 );
//  sec += datos[0];
//  sec += String.fromCharCode( 13, 27, 81, 66 );
//  sec += datos[1];
//  sec += String.fromCharCode( 13 );
//  serialPort.writeText( sec );
//  serialPort.close();
//     } else
//  debug( "Error abriendo puerto serie " + nameSerialPort );

/** \C Posicina el cursor según la parametrización indicada en el formulario de Datos Generales
\end */
function oficial_cursorAPosicionInicial()
{
  var _i = this.iface;
  var posInicial = _i.config_["ircursorinicio"];
  switch (posInicial) {
    case "Referencia": {
      this.child("fdbReferencia").setFocus();
      break;
    }
    case "Cod.Barras": {
      this.child("fdbCodBarras").setFocus();
      break;
    }
    case "Cantidad": {
      this.child("txtCanArticulo").setFocus();
      break;
    }
  }
}

/** \C Carga los parámetros de configuración del formulario de datos generales de TPV
\end */
function oficial_cargarConfiguracion()
{
	var _i = this.iface;
	
  _i.config_ = flfact_tpv.iface.pub_ejecutarQry("tpv_datosgenerales", "rvimprimirtique,rvabrircajon,rvpasarsiguiente,ircursorinicio,irultrarrapida,soloventas", "1 = 1", "tpv_datosgenerales");
  if (_i.config_.result != 1) {
    return;
  }

  _i.conectarInsercionRapida();

  _i.cursorAPosicionInicial();
	
	_i.funcionesTPV();
}

function oficial_conectarInsercionRapida()
{
	var _i = this.iface;
	
  try {
    connect(this.child("fdbReferencia"), "keyReturnPressed()", _i, "fdbReferencia_returnPressed");
    connect(this.child("fdbCodBarras"), "keyReturnPressed()", _i, "fdbCodBarras_returnPressed");
  } catch (e) {}
  return true;
}
function oficial_fdbCodBarras_returnPressed()
{
  var _i = this.iface;
  var cursor = this.cursor();
  _i.bufferChanged("codbarrasLinea");

  if (_i.config_["irultrarrapida"]) {
		if (_i.pvpVariable) {
			this.child("txtPvpArticulo").selectAll();
			this.child("txtPvpArticulo").setFocus();
		} else {
			_i.insertarLineaClicked();
		}
  } else {
    this.child("txtDesArticulo").setFocus();
  }
}

function oficial_fdbReferencia_returnPressed()
{
  var _i = this.iface;
  var cursor = this.cursor();

  if (_i.config_["irultrarrapida"]) {
    if (_i.pvpVariable) {
			this.child("txtPvpArticulo").selectAll();
			this.child("txtPvpArticulo").setFocus();
		} else {
			_i.insertarLineaClicked();
		}
  } else {
    this.child("txtDesArticulo").setFocus();
  }
}

function oficial_actualizarIvaLineas(codCliente)
{
  var _i = this.iface;
  var cursor = this.cursor();
	
  var codImpuesto = "";
  var curLinea = this.child("tdbLineasComanda").cursor(); /// Usamos el cursor del FLTableDB y no uno nuevo para que tenga cursorRelation asociado, necesario para los cálculos
  curLinea.select("idtpv_comanda = " + cursor.valueBuffer("idtpv_comanda"));
  while (curLinea.next()) {
    curLinea.setModeAccess(curLinea.Edit);
    curLinea.refreshBuffer();
    curLinea.setValueBuffer("codimpuesto", _i.calcularIvaLinea(curLinea.valueBuffer("referencia")));
    curLinea.setValueBuffer("iva", formRecordtpv_lineascomanda.iface.pub_commonCalculateField("iva", curLinea));
		curLinea.setValueBuffer("recargo", formRecordtpv_lineascomanda.iface.pub_commonCalculateField("recargo", curLinea));
    curLinea.commitBuffer();
  }
  _i.calcularTotales();
  this.child("tdbLineasComanda").refresh();
}

function oficial_pbnPagar_clicked()
{
	var _i = this.iface;
  var cursor = this.cursor();
	
	this.child("pushButtonAccept").setDisabled(true);
	this.child("pushButtonAcceptContinue").setDisabled(true);
	
	this.child("tbwComanda").showPage("lineas");
	
	_i.realizarPago();
	
	var pendiente = parseFloat(cursor.valueBuffer("pendiente"));
	if (!isNaN(pendiente) && pendiente == 0) {
		
		if (!_i.guardaComanda()) {
			return false;
		}
		if (_i.config_["rvimprimirtique"]) {
			_i.imprimirQuickClicked();
		}
		if (_i.config_["rvabrircajon"]) {
			_i.abrirCajonClicked();
		}
		if (_i.config_["rvpasarsiguiente"]) {
			_i.pasarSiguienteVenta();
		}
	}
	
	_i.verificarHabilitaciones();
	this.child("pushButtonAccept").setDisabled(false);
	this.child("pushButtonAcceptContinue").setDisabled(false);
}

function oficial_guardaComanda()
{
	return true; /// Este código se puede habilitar en el cliente que lo necesite.
	
	var _i = this.iface;
	var cursor = this.cursor();
	
	if (!_i.validateForm()) {
		return false;
	}
	var indice = cursor.atFrom();
	if (!cursor.commitBuffer()) {
		return false;
	}
	if (!cursor.commit()) {
		return false;
	}
	if (!cursor.transaction(false)) {
		return false;
	}
	if (!cursor.seek(indice)) {
		return false;
	}
	cursor.setModeAccess(cursor.Edit);
	cursor.refreshBuffer();
	
	return true;
}


function oficial_pbnEmitirVale_clicked()
{
	var _i = this.iface;
  var cursor = this.cursor();
	
	sys.setObjText(this, "fdbSaldoPendiente", parseFloat(cursor.valueBuffer("total")) * (-1)); 
	if (!_i.crearPago(parseFloat(cursor.valueBuffer("pendiente")), "Vales")) {
		sys.setObjText(this, "fdbSaldoPendiente", 0);
		return false;
	}
	sys.setObjText(this, "lblCantPte", AQUtil.roundFieldValue("0", "tpv_comandas", "total"));
	cursor.setValueBuffer("pendiente", 0);
	
	if(!_i.guardarComandaImpresion()){
		return;
	}
	_i.imprimirValeEmitido(cursor.valueBuffer("idtpv_comanda"));
	/// Se vuelve a imprimir el tique porque en la devolución puede haber comprado algo de menor valor que puede a su vez ser devuelto, y es necesario como justificante.
	if (!formtpv_comandas.iface.pub_imprimirQuick(cursor.valueBuffer("codigo"))){
		return;
	}
		
	_i.verificarHabilitaciones();
}

function oficial_tbwComanda_currentChanged(tabName)
{
  var _i = this.iface;
  var cursor = this.cursor();
	
  return true;
}

function oficial_tbnStock_clicked()
{
  var _i = this.iface;
  var cursor = this.cursor();
	
  var curLinea = this.child("tdbLineasComanda").cursor();
  if (!curLinea) {
    return false;
  }

  var oArticulo = new Object;
  oArticulo.referencia = curLinea.valueBuffer("referencia");
  oArticulo.barcode = false;
  if (!flfact_tpv.iface.pub_consultarStock(oArticulo)) {
    return false;
  }
  return true;
}

function oficial_mostrarRecargo()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var codCliente = cursor.valueBuffer("codcliente");
	if (codCliente && codCliente != "" && AQUtil.sqlSelect("clientes", "recargo", "codcliente = '" + codCliente + "'")) {
		this.child("fdbTotalRecargo").obj().show();
	} else {
		this.child("fdbTotalRecargo").close();
	}
}

function oficial_habilitarBotones()
{
  var _i = this.iface;
  var cursor = this.cursor();

	_i.habilitarPagar();
	_i.habilitarEmitirVale();
	_i.habilitarAnularVale();
}

function oficial_habilitarPagar()
{
	var _i = this.iface;
	var cursor = this.cursor();
    
	if (parseFloat(this.child("fdbTotalComanda").value()) > 0) {
		this.child("tbnTicketRegalo").setDisabled(false);
	} else {
		this.child("tbnTicketRegalo").setDisabled(true);
	}
	/**
	if (parseFloat(this.child("fdbPendiente").value()) > 0) {
		this.child("pbnPagar").setDisabled(false);
	} else {
		this.child("pbnPagar").setDisabled(true);
	}*/
}

function oficial_habilitarEmitirVale()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	if (parseFloat(this.child("fdbTotalComanda").value()) < 0) {
		this.child("pbnEmitirVale").setDisabled(false);
		this.child("fdbSaldoPendiente").obj().show();
	} else {
		this.child("pbnEmitirVale").setDisabled(true);
		this.child("fdbSaldoPendiente").close();
	}
	if (parseFloat(this.child("fdbPendiente").value()) < 0) {
		this.child("pbnEmitirVale").setDisabled(false);
		this.child("fdbSaldoPendiente").obj().show();
	} else{
		this.child("pbnEmitirVale").setDisabled(true);
		this.child("fdbSaldoPendiente").close();
	}
	if((parseFloat(this.child("fdbTotalComanda").value()) < 0) && (parseFloat(this.child("fdbPendiente").value()) == 0)){
		this.child("fdbSaldoPendiente").obj().show();
	}
}

function oficial_habilitarAnularVale()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var lineas = this.child("tdbLineasComanda").cursor().size();
	var pagos = this.child("tdbPagos").cursor().size();

	if(lineas > 0 || pagos > 0){
		this.child("pbnAnularVale").setDisabled(true);
	}
	else{
		this.child("pbnAnularVale").setDisabled(false);
	}
}

function oficial_habilitarTicketRegalo()
{
	var _i = this.iface;
	var cursor = this.cursor();
	/**
	if(cursor.valueBuffer("estado") == "Cerrada"){
		this.child("tbnTicketRegalo").enabled = true;
	}
	else{
		this.child("tbnTicketRegalo").enabled = false;
	}*/
	
	if(this.child("tbnTicketRegalo").on){
		this.child("tbnTicketRegalo").animateClick();
	}
}

function oficial_habilitarPorTipoDoc()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var tipoDoc = cursor.valueBuffer("tipodoc");
	
	switch (tipoDoc){
		case "venta":
		case "VENTA": {
			if (cursor.isNull("idfactura")) {
				this.child("pbnReserva").enabled = true;
				this.child("pbnPresupuesto").enabled = true;
			} else {
				this.child("pbnReserva").enabled = false;
				this.child("pbnPresupuesto").enabled = false;
			}
			this.child("pbnVenta").enabled = false;
			this.child("lblTipoDoc").paletteForegroundColor = new QColor(0,102,0);
			sys.setObjText(this, "lblTipoDoc", sys.translate("VENTA"));
			break;
		}
		case "presupuesto":
		case "PRESUPUESTO": {
			this.child("pbnReserva").enabled = true;
			this.child("pbnPresupuesto").enabled = false;
			this.child("pbnVenta").enabled = true;
			this.child("lblTipoDoc").paletteForegroundColor = new QColor(0,30,255);
			sys.setObjText(this, "lblTipoDoc", sys.translate("PRESUPUESTO"));
			break;
		}
		case "reserva":
		case "RESERVA": {
			this.child("pbnReserva").enabled = false;
			this.child("pbnPresupuesto").enabled = true;
			this.child("pbnVenta").enabled = true;
			this.child("lblTipoDoc").paletteForegroundColor = new QColor(170,85,255);
			sys.setObjText(this, "lblTipoDoc", sys.translate("RESERVA"));
			break;
		}
		
		case "devolucion":
		case "DEVOLUCION": {
			var numLineas = _i.calculateField("numlineascomanda");
			if(numLineas > 0){
				this.child("pbnReserva").enabled = false;
				this.child("pbnPresupuesto").enabled = false;
				this.child("pbnVenta").enabled = false;
			}
			else{
				this.child("pbnReserva").enabled = true;
				this.child("pbnPresupuesto").enabled = true;
				this.child("pbnVenta").enabled = true;
			}
			this.child("lblTipoDoc").paletteForegroundColor = new QColor(170,0,0);
			sys.setObjText(this, "lblTipoDoc", sys.translate("DEVOLUCIÓN"));
			break;
		}
		default: {
			break;
		}
	}
}

function oficial_pbnVentaClicked()
{
	var _i = this.iface;
  var cursor = this.cursor();

	this.child("lblTipoDoc").paletteForegroundColor = new QColor(255,0,0);
	sys.setObjText(this, "lblTipoDoc", "VENTA");
	cursor.setValueBuffer("tipodoc", "VENTA");
}

function oficial_pbnReservaClicked()
{
	var _i = this.iface;
  var cursor = this.cursor();

	this.child("lblTipoDoc").paletteForegroundColor = new QColor(170,85,255);
	sys.setObjText(this, "lblTipoDoc", "RESERVA");
	cursor.setValueBuffer("tipodoc", "RESERVA");
}

function oficial_pbnPresupuestoClicked()
{
	var _i = this.iface;
  var cursor = this.cursor();

	this.child("lblTipoDoc").paletteForegroundColor = new QColor(0,30,255);
	sys.setObjText(this, "lblTipoDoc", "PRESUPUESTO");
	cursor.setValueBuffer("tipodoc", "PRESUPUESTO");
}

function oficial_pbnDevolucionClicked()
{
	var _i = this.iface;
  var cursor = this.cursor();
	
	if(this.child("pbnDevolucion").on){
		if(!_i.devolverLineasComandas()){
			return;
		}
	}
	else{
		cursor.setValueBuffer("tipodoc", "VENTA");
	}
	_i.habilitarPorTipoDoc();
	_i.calcularTotales();
	_i.ponerSignoCantidad();
	this.child("tdbLineasComanda").refresh();
}

function oficial_devolverLineasComandas()
{
	var _i = this.iface;
  var cursor = this.cursor();
	
	var codigoAnt = cursor.valueBuffer("codigo");
	
	this.child("tdbLineasComanda").cursor().commitBufferCursorRelation();

	var tpvVales = new FLFormSearchDB("tpv_vales_comanda");
	
	var curVales = tpvVales.cursor();
	
	curVales.select();
	curVales.setModeAccess(curVales.Insert);
	curVales.refreshBuffer();
	curVales.setValueBuffer("codigo", "");
	curVales.setValueBuffer("referencia", cursor.valueBuffer("codigo"));
	curVales.setValueBuffer("idtpv_comanda", cursor.valueBuffer("idtpv_comanda"));

	tpvVales.setMainWidget();
	tpvVales.exec();
	if(!tpvVales.accepted()){
		return false;
	}
	
	if(!_i.datosComanda(curVales.valueBuffer("codigo"))){
		return false;
	}
	//_i.mostrarCamposDevolucion();
	cursor.setValueBuffer("tipodoc", "DEVOLUCION");
	return true;
}

function oficial_datosComanda(codigo)
{
	var _i = this.iface;
	var cursor = this.cursor();

	var selectComanda = _i.dameSelectComanda();
	
	var q = new FLSqlQuery();
	q.setSelect(selectComanda);
	q.setFrom("tpv_comandas");
	q.setWhere("codigo = '" + codigo + "'");
	q.setForwardOnly(true);
	if (!q.exec()) {
		return false;
	}
	if(!q.first()){
		return true;
	}
	
	cursor.setValueBuffer("codcliente", q.value(0));
	
	if(!q.value(1) || q.value(1) == 0 || q.value(1) == "") {
		cursor.setNull("coddir");
	}
	else {
		cursor.setValueBuffer("coddir", q.value(1));
	}
	
	cursor.setValueBuffer("codpostal", q.value(2));
	cursor.setValueBuffer("ciudad", q.value(3));
	cursor.setValueBuffer("idprovincia", q.value(4));
	cursor.setValueBuffer("provincia", q.value(5));
	cursor.setValueBuffer("direccion", q.value(6));
	cursor.setValueBuffer("codpais", q.value(7));
	cursor.setValueBuffer("cifnif", q.value(8));
	cursor.setValueBuffer("nombrecliente", q.value(9));
	
	_i.masDatosComanda(q);
	
	return true;
}

function oficial_masDatosComanda(q)
{
	var _i = this.iface;
	var cursor = this.cursor();
	
}

function oficial_dameSelectComanda()
{
	var _i = this.iface;
	var cursor = this.cursor();

	var select = "codcliente,coddir,codpostal,ciudad,idprovincia,provincia,direccion,codpais,cifnif,nombrecliente";
	return select;
}

function oficial_controlTipoDoc()
{
	var _i = this.iface;
	var cursor = this.cursor();
	var res;
	
	var pendiente = parseFloat(cursor.valueBuffer("pendiente"));
	var total = parseFloat(cursor.valueBuffer("total"));
	var tipoDoc = cursor.valueBuffer("tipodoc");
	
	if (tipoDoc == "DEVOLUCION" || tipoDoc == "devolucion") {
		if (total < 0) {
			return true;
		} else {
			tipoDoc = "VENTA";
		}
	}
	if (tipoDoc == "VENTA" && pendiente != 0){
		res = MessageBox.warning(sys.translate("No ha realizado el pago completo de la compra. \n¿Desea continuar como reserva?"), MessageBox.Yes, MessageBox.No);
		if (res == MessageBox.Yes){
			cursor.setValueBuffer("tipoDoc","RESERVA");
		} else {
			return false;
		}
	} else if (tipoDoc != "VENTA" && pendiente == 0){
		res = MessageBox.warning(sys.translate("Ha realizado el pago completo de la compra. \n¿Desea continuar como venta?"), MessageBox.Yes, MessageBox.No);
		if (res == MessageBox.Yes){
			cursor.setValueBuffer("tipoDoc","VENTA");
		} else {
			return false;
		}
	} else if (tipoDoc == "PRESUPUESTO" && pendiente != total){
		res = MessageBox.warning(sys.translate("Ha realizado el pago parcial de la compra. \n¿Desea continuar como reserva?"), MessageBox.Yes, MessageBox.No);
		if (res == MessageBox.Yes){
			cursor.setValueBuffer("tipoDoc","RESERVA");
		} else {
			return false;
		}
	}
	
	return true;
}

function oficial_funcionesTPV()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
  soloVentas_ = _i.config_["soloventas"];
	
	if(soloVentas_){
		this.child("pbnVenta").close();
		this.child("pbnPresupuesto").close();
		this.child("pbnReserva").close();
		this.child("pbnDevolucion").close();
		cursor.setValueBuffer("tipoDoc","VENTA");
	}
	
}

function oficial_comprobarTotalPago()
{
	var _i = this.iface;
	var cursor = this.cursor();

	if(cursor.valueBuffer("tipodoc") != "DEVOLUCION"){
		if (parseFloat(cursor.valueBuffer("total")) < parseFloat(cursor.valueBuffer("pagado"))) {
			cursor.setValueBuffer("tipodoc", "DEVOLUCION");
			/**MessageBox.warning(sys.translate("El total de la venta no puede ser inferior a los pagos registrados"), MessageBox.Ok, MessageBox.NoButton);
			return false;*/
		}
	}
	return true;
}

function oficial_validarIvaRecargoCliente()
{
	var _i = this.iface;
	var cursor = this.cursor();

  var idComanda = cursor.valueBuffer("idtpv_comanda");
  var codCliente = cursor.valueBuffer("codcliente");
	
  if (!flfacturac.iface.pub_validarIvaRecargoCliente(codCliente, idComanda, "tpv_lineascomanda", "idtpv_comanda")) {
    return false;
  }
  
	return true;
}

function oficial_commonCalculateField(fN, cursor)
{
	var _i = this.iface;
	var valor;
	
	switch (fN) {
		case "saldoconsumido":{
			valor = AQUtil.sqlSelect("tpv_pagoscomanda", "SUM(importe)", "refvale = '" + cursor.valueBuffer("codigo") + "'");
			if(!valor){
				valor = 0;
			}
			break;
		}
		case "saldopendiente":{
			var saldoInicial = parseFloat(cursor.valueBuffer("total")) * (-1);
			var saldoConsumido = cursor.valueBuffer("saldoconsumido");
			valor = parseFloat(saldoInicial) - parseFloat(saldoConsumido);
			break;
		}
	}
	return valor;
}

function oficial_ponerSignoCantidad()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	if(this.child("pbnDevolucion").on){
// 		_i.txtCanArticulo.setText(-1); Quitado por ahora porque lo normal es que se elija lo devuelto de otra tienda y luego se compre algo
		_i.txtCanArticulo.setText(1); 
	}
	else{
		_i.txtCanArticulo.setText(1);
	}
}

function oficial_mostrarCamposDevolucion()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	this.child("lblTipoDoc").paletteForegroundColor = new QColor(90,195,90);
	sys.setObjText(this, "lblTipoDoc", "DEVOLUCION");
	cursor.setValueBuffer("tipodoc", "DEVOLUCION");
	this.child("fdbSaldoPendiente").obj().show();
}

function oficial_valoresLocales()
{
	var _i = this.iface;
	
  var codTerminal = flfact_tpv.iface.pub_valorDefectoTPV("codterminal");
	if (codTerminal && AQUtil.sqlSelect("tpv_puntosventa", "codtpv_puntoventa", "codtpv_puntoventa = '" + codTerminal + "'")) {
		this.child("fdbCodTpvPuntoventa").setValue(codTerminal);
		this.child("fdbCodAlmacen").setValue(AQUtil.sqlSelect("tpv_puntosventa", "codalmacen", "codtpv_puntoventa ='" + codTerminal + "'"));
		var codAgente = _i.dameAgenteVenta(codTerminal);
		if (!codAgente) {
			return false;
		}
		this.child("fdbAgente").setValue(codAgente);
	} else {
		MessageBox.warning(sys.translate("No hay establecido ningún Punto de Venta Local\no el Punto de Venta establecido no es válido.\nSeleccione un Punto de Venta válido en la tabla \ny pulse el botón Cambiar"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
	return true;
}

function oficial_dameAgenteVenta(codTerminal)
{
	var _i = this.iface;
	var cursor = this.cursor();
	var codAgente = flfact_tpv.iface.agenteActivo_;
	if (!codAgente || codAgente == "") {
		codAgente = AQUtil.sqlSelect("tpv_puntosventa", "codtpv_agente", "codtpv_puntoventa ='" + codTerminal + "'");
		if (flfact_tpv.iface.pub_valorDefectoTPV("autagenteventa")) {
			if (!flfact_tpv.iface.pub_cambiarAgenteActivo(codAgente)) {
				return false;
			}
		} else {
			flfact_tpv.iface.pub_ponAgenteActivo(codAgente)
		}
	}
	codAgente = flfact_tpv.iface.agenteActivo_;
	if (!codAgente) {
		MessageBox.warning(sys.translate("No ha establecido ningún agente de venta"),MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
	return codAgente;
}

function oficial_tbnBloquearUsuario_clicked()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var codAgente = cursor.valueBuffer("codtpv_agente");
	flfact_tpv.iface.pub_ponAgenteActivo(false);
	var codAgenteNuevo = false;
	while (!codAgenteNuevo) {
		flfact_tpv.iface.pub_cambiarAgenteActivo(codAgente);
		codAgenteNuevo = flfact_tpv.iface.agenteActivo_;
	}
	this.child("fdbAgente").setValue(codAgenteNuevo);
}

function oficial_habilitaPorSeguridad()
{
	if (flfact_tpv.iface.pub_valorDefectoTPV("autagenteventa")) {
		this.child("fdbAgente").setDisabled(true);
	}
}

/** Abre un formulario con una tabla con las líneas de comandas con la referencia, descripción, cantidad de la línea y una celda editable para la cantidad que iría en el ticket regalo.Se cambia por la función que está debajo.
function oficial_tbnTicketRegalo_clicked()
{
	var _i = this.iface;
	var cursor = this.cursor();

	var curLineas = new FLSqlCursor("tpv_lineascomanda");
	var f= new FLFormSearchDB(curLineas, "tpv_seleccionlineasregalo");
	
	f.setMainWidget();
	f.exec();
	
	if (f.accepted()) {
		if(!_i.ponCantidadRegaloLinea(_i.aDatos_)){
			return false;
		}
 		if(!_i.imprimirTicketRegalo()){
			return false;
		}
	} 
	else {
		return false;
	}
	
	return true;
}*/

function oficial_tbnTicketRegalo_clicked()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	if(this.child("tbnTicketRegalo").on){
		this.child("tdbLineasComanda").setCheckColumnEnabled(true);
		this.child("tdbLineasComanda").setAliasCheckColumn("Regalo");
		
		var q = new FLSqlQuery();
		q.setSelect("lc.idtpv_linea");
		q.setFrom("tpv_comandas c INNER JOIN tpv_lineascomanda lc ON c.idtpv_comanda = lc.idtpv_comanda");
		q.setWhere("lc.idtpv_comanda = " + cursor.valueBuffer("idtpv_comanda") + " AND canregalo > 0");
		q.setForwardOnly(true);
		
		debug(q.sql());
		if (!q.exec()) {
			return false;
		}
		while (q.next()) {
			this.child("tdbLineasComanda").setPrimaryKeyChecked(q.value(0), true);
		}
	}
	else{
		this.child("tdbLineasComanda").setCheckColumnEnabled(false);
	}
	
	this.child("tdbLineasComanda").refresh(true, true);
}

function oficial_dameIdTpv()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var idtpv = cursor.valueBuffer("idtpv_comanda");
	return idtpv;
}

function oficial_ponCantidadRegalo(valores)
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	_i.aDatos_ = valores;
}

function oficial_ponCantidadRegaloLinea(aDatos)
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var curLinea = new FLSqlCursor("tpv_lineascomanda");
	
	for(var i = 0; i < aDatos.length; i++){
		curLinea.select("idtpv_linea = " + aDatos[i]["idlinea"]);
		curLinea.first();
		curLinea.setModeAccess(curLinea.Edit);
		curLinea.refreshBuffer();
		curLinea.setValueBuffer("canregalo", parseFloat(aDatos[i]["canregalo"]));
		if (!curLinea.commitBuffer()){
			return false;
		}
	}
	return true;
}

function oficial_imprimirTicketRegalo()
{
	var _i = this.iface;
  var cursor = this.cursor();

	if (!formtpv_comandas.iface.pub_imprimirTicketRegalo(cursor.valueBuffer("idtpv_comanda"), _i.aDatos_)){
		return false;
	}
	return true;
}

function oficial_actualizarCantidadRegalo(idLinea, on)
{
	var _i = this.iface;
  var cursor = this.cursor();
	
	_i.curLineas.select("idtpv_linea = " + idLinea);
	_i.curLineas.first();

	_i.curLineas.setModeAccess(_i.curLineas.Edit);
	_i.curLineas.refreshBuffer();
	
	if(on){
		_i.curLineas.setValueBuffer("canregalo", _i.curLineas.valueBuffer("cantidad"));
	}
	else{
		_i.curLineas.setValueBuffer("canregalo", 0);
	}
	
	if (!_i.curLineas.commitBuffer()) {
		return;
	}
	this.child("tdbLineasComanda").refresh();
}

function oficial_pbnAnularVale_clicked()
{
	var _i = this.iface;
  var cursor = this.cursor();
		
	this.child("tdbLineasComanda").cursor().commitBufferCursorRelation();

	var tpvVales = new FLFormSearchDB("tpv_anularvales");
	
	var curVales = tpvVales.cursor();
	
	curVales.select();
	curVales.setModeAccess(curVales.Insert);
	curVales.refreshBuffer();
	curVales.setValueBuffer("codigo", "");
	curVales.setValueBuffer("idtpv_comanda", cursor.valueBuffer("idtpv_comanda"));

	tpvVales.setMainWidget();
	var id = tpvVales.exec("id");

  if (!id) {
    return false;
  }
	if(!tpvVales.accepted()){
		return false;
	}
	curVales.commitBuffer();
	var codigo = AQUtil.sqlSelect("tpv_anularvales", "codigo", "id = " + id);

	var saldo = parseFloat(AQUtil.sqlSelect("tpv_comandas", "saldopendiente", "codigo = '" + codigo + "'"));
	
	if(!_i.crearPago((saldo * (-1)), "Efectivo")){
		return false;
	}
	_i.anularClicked_ = true;
	
	if(!_i.crearPago(saldo, "Vales", codigo)){
		_i.anularClicked_ = false;
		return false;
	}
	
	_i.anularClicked_ = false;
	return true;
}

function oficial_calculaPuntosVenta()
{
	return 0;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
