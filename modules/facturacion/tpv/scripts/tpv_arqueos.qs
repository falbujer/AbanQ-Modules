/***************************************************************************
                 tpv_arqueos.qs  -  description
                             -------------------
    begin                : mar nov 15 2005
    copyright            : Por ahora (C) 2005 by InfoSiAL S.L.
    email                : lveb@telefonica.net
 ***************************************************************************/
/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free S.voftware Foundation; either version 2 of the License, or     *
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
    var ctx;
    function interna( context ) { this.ctx = context; }
    function init() { this.ctx.interna_init(); }
	function calculateField(fN) { return this.ctx.interna_calculateField(fN); }
	function validateForm() {return this.ctx.interna_validateForm(); }
	function calculateCounter() { return this.ctx.interna_calculateCounter(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var tdbMovimientos;
	var mVAL_, mCAN_, mOCU_, bVAL_, bCAN_, bOCU_;
	var aValorCantMonedas,aValorCantBilletes;
	var hayCamposAntiguos;
	var numBilletes, numMonedas;

	var aControlesFdb_;
  var eventWatcher_;
	
	var pulsadoEnter_;
	
	var rojo_;
	var verde_;
	var blanco_;
	var azul_;
	
  function oficial( context ) { interna( context ); }
  
	function commonCalculateField(fN, cursor) {
		return this.ctx.oficial_commonCalculateField(fN, cursor);
	}
	function calcularValores() {
		return this.ctx.oficial_calcularValores();
	}
	function bufferChanged(fN) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function desconectar(){
		return this.ctx.oficial_desconectar();
	}
	function guardarValoresDefecto() {
		return this.ctx.oficial_guardarValoresDefecto();
	}
	function construirTablaMoneda() {
		return this.ctx.oficial_construirTablaMoneda();
	}
	function construirTablaBillete() {
		return this.ctx.oficial_construirTablaBillete();
	}
	function cargarTablaBillete() {
		return this.ctx.oficial_cargarTablaBillete();
	}
	function cargarTablaMoneda() {
		return this.ctx.oficial_cargarTablaMoneda();
	}
	function recuperarDatosCamposMonedas() {
		return this.ctx.oficial_recuperarDatosCamposMonedas();
	}
	function cargaArrayValorDivisa() {
		return this.ctx.oficial_cargaArrayValorDivisa();
	}
	function quitaEspacios(s) {
		return this.ctx.oficial_quitaEspacios(s);
	}
	function tblMonedas_valueChanged(f, c) {
		return this.ctx.oficial_tblMonedas_valueChanged(f, c);
	}
  function tblBilletes_valueChanged(f, c) {
    return this.ctx.oficial_tblBilletes_valueChanged(f, c);
  }
	function validarCantidad(cantidad)
	{
		return this.ctx.oficial_validarCantidad(cantidad);
	}
	function ponValorBilletes()
	{
		return this.ctx.oficial_ponValorBilletes();
	}
	function ponValorMonedas()
	{
		return this.ctx.oficial_ponValorMonedas();
	}
	function ponerCamposCero()
	{
		return this.ctx.oficial_ponerCamposCero();
	}
	function cargaStringList(cursor, master)
	{
		return this.ctx.oficial_cargaStringList(cursor, master);
	}
	function cargaStringListMonedas(cursor)
	{
		return this.ctx.oficial_cargaStringListMonedas(cursor);
	}
	function cargaStringListBilletes(cursor)
	{
		return this.ctx.oficial_cargaStringListBilletes(cursor);
	}
	function dameAgenteArqueo(codTerminal) {
		return this.ctx.oficial_dameAgenteArqueo(codTerminal);
	}
	function habilitaPorSeguridad() {
		return this.ctx.oficial_habilitaPorSeguridad();
	}
	function comprobarCoincidenciaArqueo() {
		return this.ctx.oficial_comprobarCoincidenciaArqueo();
	}
	function tblBilletes_currentChanged(f, c) {
		return this.ctx.oficial_tblBilletes_currentChanged(f, c);
	}
	function tblMonedas_currentChanged(f, c) {
		return this.ctx.oficial_tblMonedas_currentChanged(f, c);
	}
	function iniciarArrayControlesFdb() {
		return this.ctx.oficial_iniciarArrayControlesFdb();
	}
  function initEventFilter()  {
    this.ctx.oficial_initEventFilter();
  }
  function eventFilter(o, e)  {
    this.ctx.oficial_eventFilter(o, e);
  }
  function initWatch(obj) {
    this.ctx.oficial_initWatch(obj);
  }
  function finishWatch(obj)  {
    this.ctx.oficial_finishWatch(obj);
  }
	function colores() {
		return this.ctx.oficial_colores();
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
	function pub_commonCalculateField(fN, cursor) {
		return this.commonCalculateField(fN, cursor);
	}
	function pub_dameArrayMonedas() {
		return this.dameArrayMonedas();
	}
	function pub_dameArrayBilletes() {
		return this.dameArrayBilletes();
	}
	function pub_dameNumBilletes() {
		return this.dameNumBilletes();
	}
	function pub_dameNumMonedas() {
		return this.dameNumMonedas();
	}
	function pub_dameAgenteArqueo(codTerminal) {
		return this.dameAgenteArqueo(codTerminal);
	}
	function pub_cargaStringList(cursor, master) {
		return this.cargaStringList(cursor, master);
	}
	function pub_eventFilter(o, e)  {
    this.eventFilter(o, e);
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
/** \C
La pestaña de movimientos muestra las entradas y salidas de caja que no se deben a ventas 
normales (cuando se mete cambio, cuando se transfiere dinero de una caja a 
otra, etc).<br/>
La pestaña de ventas muestra todos los pagos asociados al arqueo y suma los totales de las los pagos en efectivo, en vale y con tarjeta.
El total de efectivo 'En Caja' es el importe que hay realmente en caja 
contando dinero en efectivo. El formulario ofrece una serie de campos asociados con las distintas monedas y billetes para facilitar el cálculo de este dato.<br/>
El total de tarjeta 'En Caja' es la suma de los importes de los tiques de 
pagos con tarjeta. <br/>
El total de efectivo 'Calculado' es el total que se obtiene sumando los importes de las comandas con forma de pago 'CONT' mas el importe total de los movimientos realizados.<br/>
El total de tarjeta 'Calculado' es el total que se obtiene sumando los importes de las comandas con forma de pago 'TARJ'.
El total de vales 'Calculado' es el total que se obtiene sumando los importes de las comandas con forma de pago 'VALE'.
Las diferencias de efectivo y tarjeta son la resta del total 'En Caja' menos el total 'Calculado'.
*/
function interna_init()
{
	var _i = this.iface;
	var cursor= this.cursor();
	
	_i.colores();
	
	_i.tdbMovimientos = this.child("tdbMovimientos");
	connect(_i.tdbMovimientos.cursor(), "bufferCommited()", _i, "calcularValores()");
	connect(cursor, "bufferChanged(QString)", _i, "bufferChanged");
	connect(this, "closed()", _i, "desconectar()");
	this.child("tdbComandas").setReadOnly(false);
	
	if (!sys.isLoadedModule("flcontppal")) {
		this.child("tbwArqueo").setTabEnabled("contabilidad", false);
	}

	if (cursor.modeAccess() == cursor.Insert) {
		var codTerminal = flfact_tpv.iface.pub_valorDefectoTPV("codterminal");
		if (codTerminal && AQUtil.sqlSelect("tpv_puntosventa", "codtpv_puntoventa", "codtpv_puntoventa ='" + codTerminal + "'")) {
			this.child("fdbPuntoVenta").setValue(codTerminal);
			var agente = _i.dameAgenteArqueo(codTerminal);
			if (!agente || agente == "") {
				this.close();
				return false;
			}
			this.child("fdbAgenteApertura").setValue(agente);
		} else {
			MessageBox.warning(
			AQUtil.translate("scripts",
							"No hay establecido ningún Punto de Venta Local\no el Punto de Venta establecido no es válido.\nSeleccione un Punto de Venta válido en la tabla \ny pulse el botón Cambiar"),
			MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton
			);
			this.form.close();
			return false;
		}
// 		var codTerminal = flfact_tpv.iface.pub_valorDefectoTPV("codterminal");
// 		cursor.setValueBuffer("ptoventa",codTerminal);
		cursor.setValueBuffer("totalmov", 0);
// 		var fecha= AQUtil.sqlSelect("tpv_arqueos", "MAX(diahasta)", "idtpv_arqueo <> '" + cursor.valueBuffer("idtpv_arqueo") + "'");
// 		if (fecha)
// 			cursor.setValueBuffer("diadesde",AQUtil.addDays(fecha,1));
		var fecha = new Date();
		cursor.setValueBuffer("diadesde",fecha);
		cursor.setValueBuffer("horadesde",fecha.toString().right(8));
	} else {
		this.child("fdbPuntoVenta").setDisabled(true);
		this.child("fdbAgenteApertura").setDisabled(true);
		this.child("fdbCantInicial").setDisabled(true);
		this.child("fdbDiaDesde").setDisabled(true);
		this.child("fdbHoraDesde").setDisabled(true);
	}
	if (cursor.valueBuffer("abierta")) {
		this.child("fdbDiaHasta").setValue("");
		this.child("fdbHoraHasta").setValue("");
	}
		
	_i.hayCamposAntiguos = false;
	if(!_i.guardarValoresDefecto()){
		return false;
	}
	
  connect(this.child("tblMonedas"), "valueChanged(int, int)", _i, "tblMonedas_valueChanged()");
  connect(this.child("tblBilletes"), "valueChanged(int, int)", _i, "tblBilletes_valueChanged()");
	
  connect(this.child("tblMonedas"), "currentChanged(int, int)", _i, "tblMonedas_currentChanged()");
  connect(this.child("tblBilletes"), "currentChanged(int, int)", _i, "tblBilletes_currentChanged()");
	
	_i.construirTablaBillete();
	_i.construirTablaMoneda();
	_i.cargarTablaBillete();
	_i.cargarTablaMoneda();
	_i.calcularValores();
	_i.habilitaPorSeguridad();
	
	_i.pulsadoEnter_ = true;
	
	if(cursor.modeAccess() == cursor.Edit){
		this.child("tblBilletes").editCell(0, _i.bCAN_);
	}
	
	_i.aControlesFdb_ = _i.iniciarArrayControlesFdb();
  _i.initEventFilter();
	for(var i = 0; i < _i.aControlesFdb_.length; i++){
		_i.initWatch(this.mainWidget().child(_i.aControlesFdb_[i]).editor());
	}
  _i.initWatch(this.mainWidget().child("tblBilletes"));
  _i.initWatch(this.mainWidget().child("tblMonedas"));
}

function interna_calculateField(fN)
{
	var _i = this.iface;
	var cursor= this.cursor();
	var valor;
	switch (fN) {
		case "inicio": {
			var inicio= 0;
			var qryarqueos= new FLSqlQuery();
			qryarqueos.setTablesList("tpv_arqueos");
			qryarqueos.setSelect("diahasta, totalcaja, totalmov, sacadodecaja");
			qryarqueos.setFrom("tpv_arqueos");
			qryarqueos.setWhere("idtpv_arqueo <> '" + cursor.valueBuffer("idtpv_arqueo") + "' AND ptoventa = '" + cursor.valueBuffer("ptoventa") + "' ORDER BY diahasta DESC");
			if (!qryarqueos.exec())
				return;
			if (qryarqueos.first())
				inicio = qryarqueos.value("totalcaja") - qryarqueos.value("sacadodecaja");
			valor = inicio;
			break;
		}
		default: {
			valor = _i.commonCalculateField(fN, this.cursor());
		}
	}
	return valor;
}
/** \C
No se puede crear más de un arqueo para un mismo punto de venta con un mismo intervalo
Si al aceptar el formulario de arqueos existe una cantidad para el movimiento de cierre nos preguntará si deseamos cerrar el arqueo
*/

function interna_validateForm()
{
	var _i = this.iface;
	var cursor= this.cursor();
	
	/// Este setFocus al campo totaltarjeta se hace para que si ha habido alguna celda de la tabla de billetes y monedas que se ha editado pero no ha perdido el foco para que lo pierda y se guarde el valor modificado. Si la celda no pierde el foco no se refresca la tabla.
	this.child("fdbTotalTarjeta").setFocus();
	
	if(!_i.comprobarCoincidenciaArqueo()){
		return false;
	}
	if(!_i.ponValorMonedas()){
		return false;
	}
	if(!_i.ponValorBilletes()){
		return false;
	}
	if(_i.hayCamposAntiguos){
		if(!_i.ponerCamposCero()){
			return false;
		}
	}
	return true;
}

/** \D
Calcula el siguiente código para el arqueo
*/
function interna_calculateCounter()
{
	var _i = this.iface;
	return AQUtil.nextCounter("idtpv_arqueo", this.cursor());
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_commonCalculateField(fN, cursor)
{
	var valor;
	var _i = this.iface;
	switch (fN) {
		/** \C
		El campo --totalcaja-- se calcula como la suma de los campos --b500-- --b200-- --b100-- --b50-- --b20-- --b10-- --b5-- --m2-- --m1-- --m050-- --m020-- --m010-- --m005-- --m002-- --m001--
		*/
		case "totalcaja": {
			var totalBilletes = 0;
			var totalMonedas = 0;
			var tblB = this.child("tblBilletes");
			var tblM = this.child("tblMonedas");
			
			var valorBillete;
			var cantBilletes;
			var valorMoneda;
			var cantMonedas;
			
			for (var f = 0; f < _i.numBilletes; f++){
				valorBillete = parseFloat(tblB.text(f,_i.bOCU_));
				cantBilletes = parseFloat(tblB.text(f,_i.bCAN_));
				totalBilletes = totalBilletes + (valorBillete * cantBilletes);
			}
			
			for (var f = 0; f < _i.numMonedas; f++){
				valorMoneda = parseFloat(tblM.text(f,_i.mOCU_));
				cantMonedas = parseFloat(tblM.text(f,_i.mCAN_));
				totalMonedas = totalMonedas + (valorMoneda * cantMonedas);
			}
			
			/*
			var b500= parseFloat(cursor.valueBuffer("b500")) * 500;
			var b200= parseFloat(cursor.valueBuffer("b200")) * 200;
			var b100= parseFloat(cursor.valueBuffer("b100")) * 100;
			var b50= parseFloat(cursor.valueBuffer("b50")) * 50;
			var b20= parseFloat(cursor.valueBuffer("b20")) * 20;
			var b10= parseFloat(cursor.valueBuffer("b10")) * 10;
			var b5= parseFloat(cursor.valueBuffer("b5")) * 5;
			var m2= parseFloat(cursor.valueBuffer("m2")) * 2;
			var m1= parseFloat(cursor.valueBuffer("m1"));
			var m050= parseFloat(cursor.valueBuffer("m050")) * 0.5;
			var m020= parseFloat(cursor.valueBuffer("m020")) * 0.2;
			var m010= parseFloat(cursor.valueBuffer("m010")) * 0.1;
			var m005= parseFloat(cursor.valueBuffer("m005")) * 0.05;
			var m002= parseFloat(cursor.valueBuffer("m002")) * 0.02;
			var m001= parseFloat(cursor.valueBuffer("m001")) * 0.01;*/
			valor = totalBilletes + totalMonedas;
			break;
		}
		/** \C
		El total de ventas en efectivo es la suma de los totales de las comandas con forma de pago 'CONT' 
		*/
		case "totalpagos": {
			valor = parseFloat(cursor.valueBuffer("pagosefectivo")) + parseFloat(cursor.valueBuffer("pagostarjeta")) + parseFloat(cursor.valueBuffer("pagosvale")) + parseFloat(cursor.valueBuffer("devolucionesvale"));
			valor = AQUtil.roundFieldValue(valor, "tpv_arqueos", "totalcaja");
			break;
		}
		case "pagosefectivo": {
			var codPago= AQUtil.sqlSelect("tpv_datosgenerales", "pagoefectivo", "1 = 1");
			valor = AQUtil.sqlSelect("tpv_pagoscomanda", "SUM(importe)", "idtpv_arqueo = '" + cursor.valueBuffer("idtpv_arqueo") + "' AND codpago = '" + codPago + "'");
			if (!valor || isNaN(valor))
				valor = 0;
			valor = AQUtil.roundFieldValue(valor, "tpv_arqueos", "totalcaja");
			break;
		}
		/** \C
		El total de ventas con tarjeta es la suma de los totales de las comandas con forma de pago 'TARJ' 
		*/
		case "pagostarjeta": {
			var codPago= AQUtil.sqlSelect("tpv_datosgenerales", "pagotarjeta", "1 = 1");
			valor = AQUtil.sqlSelect("tpv_pagoscomanda", "SUM(importe)", "idtpv_arqueo = '" + cursor.valueBuffer("idtpv_arqueo") + "' AND codpago = '" + codPago + "'");
			if (!valor || isNaN(valor))
				valor = 0;
			valor = AQUtil.roundFieldValue(valor, "tpv_arqueos", "totalcaja");
			break;
		}
		/** \C
		El total de ventas con tarjeta es la suma de los totales de las comandas con forma de pago 'TARJ' 
		*/
		case "pagosvale": {
			var codPago = AQUtil.sqlSelect("tpv_datosgenerales", "pagovale", "1 = 1");
			valor = AQUtil.sqlSelect("tpv_pagoscomanda", "SUM(importe)", "idtpv_arqueo = '" + cursor.valueBuffer("idtpv_arqueo") + "' AND codpago = '" + codPago + "' AND importe > 0");
			if (!valor || isNaN(valor))
				valor = 0;
			valor = AQUtil.roundFieldValue(valor, "tpv_arqueos", "totalcaja");
			break;
		}
		case "devolucionesvale": {
			var codPago = AQUtil.sqlSelect("tpv_datosgenerales", "pagovale", "1 = 1");
			valor = AQUtil.sqlSelect("tpv_pagoscomanda", "SUM(importe)", "idtpv_arqueo = '" + cursor.valueBuffer("idtpv_arqueo") + "' AND codpago = '" + codPago + "' AND importe < 0");
			if (!valor || isNaN(valor))
				valor = 0;
			valor = AQUtil.roundFieldValue(valor, "tpv_arqueos", "totalcaja");
			break;
		}
		/** \C
		La diferencia de efectivo es el --totalcaja-- menos la suma de las ventas 'CONT'
		*/
		case "diferenciaEfectivo": {
			valor = parseFloat(_i.commonCalculateField("totalcaja", cursor)) - parseFloat(_i.commonCalculateField("calculadoEfectivo", cursor));
			valor = AQUtil.roundFieldValue(valor, "tpv_arqueos", "totalcaja");
			break;
		}
		/** \C
		La diferencia de tarjeta es el --totaltarjeta-- menos la suma de las ventas 'TARJ'
		*/
		case "diferenciaTarjeta": {
			valor = parseFloat(cursor.valueBuffer("totaltarjeta")) - parseFloat(_i.commonCalculateField("calculadoTarjeta", cursor));
			valor = AQUtil.roundFieldValue(valor, "tpv_arqueos", "totalcaja");
			break;
		}
		/** \C
		La diferencia de vales es el --totalvale-- menos la suma de las ventas 'VALE'
		*/
		case "diferenciaVale": {
			valor = parseFloat(cursor.valueBuffer("totalvale")) - parseFloat(_i.commonCalculateField("calculadoVale", cursor)); 
			valor = AQUtil.roundFieldValue(valor, "tpv_arqueos", "totalvale");
			break;
		}
		/** \C
		El total de ventas en efectivo es la suma de los pagos en efectivo más los movimientos de caja
		*/
		case "calculadoEfectivo": {
			valor = parseFloat(_i.commonCalculateField("totalmov", cursor)) + parseFloat(cursor.valueBuffer("inicio")) + parseFloat(_i.commonCalculateField("pagosefectivo", cursor));
			valor = AQUtil.roundFieldValue(valor, "tpv_arqueos", "totalcaja");
			break;
		}
		/** \C
		El total de ventas con tarjeta es la suma de los totales de las comandas con forma de pago 'TARJ' 
		*/
		case "calculadoTarjeta": {
			valor = parseFloat(_i.commonCalculateField("pagostarjeta", cursor));
			valor = AQUtil.roundFieldValue(valor, "tpv_arqueos", "totalcaja");
			break;
		}
		/** \C
		El total de ventas con vales es la suma de los totales de las comandas con forma de pago 'VALE' 
		*/
		case "calculadoVale": {
			valor = parseFloat(_i.commonCalculateField("pagosvale", cursor)) + parseFloat(_i.commonCalculateField("devolucionesvale", cursor));
			valor = AQUtil.roundFieldValue(valor, "tpv_arqueos", "totalcaja");
			break;
		}
		/** \C
		El total --totalmov-- es la suma de las cantidades de todos los movimientos del arqueo
		*/
		case "totalmov": {
			valor = AQUtil.sqlSelect("tpv_movimientos","SUM(cantidad)","idtpv_arqueo = '" + cursor.valueBuffer("idtpv_arqueo") + "'");
			if (!valor || isNaN(valor))
				valor = 0;
			break;
		}
	}
	return valor;

}

/** \D
Calcula los totales
*/
function oficial_calcularValores()
{
	var _i = this.iface;
	var cursor= this.cursor();
	
	var total;
	cursor.setValueBuffer("totalmov",_i.calculateField("totalmov"));
	
// 	this.child("fdbVentasEfectivo").setValue(_i.calculateField("ventasefectivo"));
// 	
// 	this.child("fdbVentasTarjeta").setValue(_i.calculateField("ventastarjeta"));
// 
// 	this.child("fdbVentasVale").setValue(_i.calculateField("ventasvale"));
// 
// 	this.child("fdbTotalVentas").setValue(_i.calculateField("totalventas"));
	
	cursor.setValueBuffer("totalcaja", _i.calculateField("totalcaja"));
	
	total = _i.calculateField("calculadoEfectivo");
	this.child("lblCalculadoEfectivo").setText(AQUtil.formatoMiles(total));
	
	total = _i.calculateField("calculadoTarjeta");
	this.child("lblCalculadoTarjeta").setText(AQUtil.formatoMiles(total));

	total = _i.calculateField("calculadoVale");
	this.child("lblCalculadoVale").setText(AQUtil.formatoMiles(total));
	
	total = _i.calculateField("diferenciaEfectivo");
	this.child("lblDiferenciaEfectivo").setText(AQUtil.formatoMiles(total));
	cursor.setValueBuffer("diferenciaefectivo",total);
	
	total = _i.calculateField("diferenciaTarjeta");
	this.child("lblDiferenciaTarjeta").setText(AQUtil.formatoMiles(total));
	cursor.setValueBuffer("diferenciatarjeta",total);

	total = _i.calculateField("diferenciaVale");
	this.child("lblDiferenciaVale").setText(AQUtil.formatoMiles(total));
	cursor.setValueBuffer("diferenciavale",total);
}

function oficial_bufferChanged(fN)
{
	var _i = this.iface;
	var cursor= this.cursor();

	switch (fN) {
		/** \C
		Cuando cambia el total por tarjeta, el total por vales o alguno de los campos --b500--, --b200--, --b100-- ... se recalculan los totales
		*/
		case "inicio":
		case "totalvale":
		case "totaltarjeta":
		case "b500":
		case "b200":
		case "b100":
		case "b50":
		case "b20":
		case "b10":
		case "b5":
		case "m2":
		case "m1":
		case "m050":
		case "m020":
		case "m010":
		case "m005":
		case "m002":
		case "m001": {
			_i.calcularValores();
			break;
		}
		case "ptoventa": {
			if (cursor.modeAccess() == cursor.Insert) {
				this.child("fdbCantInicial").setValue(_i.calculateField("inicio"));
			}
		}
	}
}
/** \D
Desconecta las funciones conectadas en el init
*/
function oficial_desconectar()
{
	var _i = this.iface;
	disconnect(_i.tdbMovimientos.cursor(), "bufferCommited()", _i, "calcularValores()");
	disconnect(this.cursor(), "bufferChanged(QString)", _i, "bufferChanged");
}

function oficial_construirTablaMoneda()
{
	var cabecera = "";
	var _i = this.iface;
	var c = 0;
	
	_i.mVAL_ = c++;
	cabecera += sys.translate("Valor de la moneda") + "/";
	_i.mCAN_ = c++;
	cabecera += sys.translate("Cantidad de monedas") + "/";
	_i.mOCU_ = c++;
	cabecera += sys.translate("Valor de la moneda (oculto)") + "/";
	
	var tblM = this.child("tblMonedas");
	tblM.setNumCols(c);
	
	tblM.setColumnWidth(_i.mVAL_, 130);
	tblM.setColumnWidth(_i.mCAN_, 130);
	tblM.setColumnWidth(_i.mOCU_, 130);
	tblM.hideColumn(_i.mOCU_);
	
	tblM.setColumnReadOnly(_i.mVAL_, true);

	tblM.setColumnLabels("/", cabecera);
	
}

function oficial_construirTablaBillete()
{
	var cabecera = "";
	var _i = this.iface;
	var c = 0;
	
	_i.bVAL_ = c++;
	cabecera += sys.translate("Valor del billete") + "/";
	_i.bCAN_ = c++;
	cabecera += sys.translate("Cantidad de billetes") + "/";
	_i.bOCU_ = c++;
	cabecera += sys.translate("Valor del billete (oculto)") + "/";
	
	var tblB = this.child("tblBilletes");
	tblB.setNumCols(c);
	
	tblB.setColumnWidth(_i.bVAL_, 130);
	tblB.setColumnWidth(_i.bCAN_, 130);
	tblB.setColumnWidth(_i.bOCU_, 130);
	tblB.hideColumn(_i.bOCU_);
	
	tblB.setColumnReadOnly(_i.bVAL_, true);

	tblB.setColumnLabels("/", cabecera);
	
}

function oficial_guardarValoresDefecto()
{
  var _i = this.iface;
  var cursor = this.cursor();
	
	_i.aValorCantBilletes = [];
	_i.aValorCantMonedas = [];
	_i.numMonedas = 0;
	_i.numBilletes = 0;
	
	///Compruebo que en los campos stringlist de arqueos (valorcantbilletes y valorcantmonedas)no haya nada si no cargo los arrays que van a rellenar las desde esos campos.
	if(!cursor.valueBuffer("valorcantbilletes") || cursor.valueBuffer("valorcantbilletes") == "" || !cursor.valueBuffer("valorcantmonedas") || cursor.valueBuffer("valorcantmonedas") == ""){
		///Compruebo que no haya valores almacenados en los campos de monedas y billetes que se utilizaban antes para dar compatibilidad a los clientes que funcionaban con la anterior versión de arqueos.
		if (parseFloat(cursor.valueBuffer("m2")) != 0 || 
				parseFloat(cursor.valueBuffer("m1")) != 0 || 
				parseFloat(cursor.valueBuffer("m050")) != 0 || 
				parseFloat(cursor.valueBuffer("m020")) != 0 || 
				parseFloat(cursor.valueBuffer("m010")) != 0 || 
				parseFloat(cursor.valueBuffer("m005")) != 0 || 
				parseFloat(cursor.valueBuffer("m002")) != 0 || 
				parseFloat(cursor.valueBuffer("m001")) != 0 ||
				parseFloat(cursor.valueBuffer("b500")) != 0 || 
				parseFloat(cursor.valueBuffer("b200")) != 0 || 
				parseFloat(cursor.valueBuffer("b100")) != 0 || 
				parseFloat(cursor.valueBuffer("b50")) != 0 || 
				parseFloat(cursor.valueBuffer("b20")) != 0 || 
				parseFloat(cursor.valueBuffer("b10")) != 0 || 
				parseFloat(cursor.valueBuffer("b5")) != 0) {
					if(!_i.recuperarDatosCamposMonedas()){
						return false;
					}
					_i.hayCamposAntiguos = true;
		}
		///Si no hay valores en los campos de monedas y billetes entonces busco las monedas y billetes del país de la empresa, poniendo las cantidades a cero.
		else{
			if(!_i.cargaArrayValorDivisa()){
				MessageBox.information(sys.translate("Debe de editar los valores de monedas y billetes en el apartado de divisas del área principal de facturación para la divisa del TPV."),MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton,"AbanQ");
				this.form.close();
				return false;
			}
		}
	}
	else{
		if(!_i.cargaStringList(cursor, false)){
			MessageBox.information(sys.translate("Ha habido un problema al cargar los datos almacenados."),MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton,"AbanQ");
			this.form.close();
			return false;
		}
	}
	return true;
}

/// Si hay algún campo de moneda o billete con valor distinto a cero es que fue editado anteriormente y entonces recojo sus valores en los arrays para cargar las tablas.
function oficial_recuperarDatosCamposMonedas()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	_i.aValorCantBilletes[0] = [];
	_i.aValorCantBilletes[1] = [];
	_i.aValorCantBilletes[2] = [];
	_i.aValorCantBilletes[3] = [];
	_i.aValorCantBilletes[4] = [];
	_i.aValorCantBilletes[5] = [];
	_i.aValorCantBilletes[6] = [];
	
	_i.aValorCantBilletes[0]["valor"] = "500";
	_i.aValorCantBilletes[1]["valor"] = "200";
	_i.aValorCantBilletes[2]["valor"] = "100";
	_i.aValorCantBilletes[3]["valor"] = "50";
	_i.aValorCantBilletes[4]["valor"] = "20";
	_i.aValorCantBilletes[5]["valor"] = "10";
	_i.aValorCantBilletes[6]["valor"] = "5";
	
	_i.aValorCantBilletes[0]["cantidad"] = parseFloat(cursor.valueBuffer("b500"));
	_i.aValorCantBilletes[1]["cantidad"] = parseFloat(cursor.valueBuffer("b200"));
	_i.aValorCantBilletes[2]["cantidad"] = parseFloat(cursor.valueBuffer("b100"));
	_i.aValorCantBilletes[3]["cantidad"] = parseFloat(cursor.valueBuffer("b50"));
	_i.aValorCantBilletes[4]["cantidad"] = parseFloat(cursor.valueBuffer("b20"));
	_i.aValorCantBilletes[5]["cantidad"] = parseFloat(cursor.valueBuffer("b10"));
	_i.aValorCantBilletes[6]["cantidad"] = parseFloat(cursor.valueBuffer("b5"));
	
	_i.numBilletes = 7;

	_i.aValorCantMonedas[0] = [];
	_i.aValorCantMonedas[1] = [];
	_i.aValorCantMonedas[2] = [];
	_i.aValorCantMonedas[3] = [];
	_i.aValorCantMonedas[4] = [];
	_i.aValorCantMonedas[5] = [];
	_i.aValorCantMonedas[6] = [];
	_i.aValorCantMonedas[7] = [];
	
	_i.aValorCantMonedas[0]["valor"] = "2";
	_i.aValorCantMonedas[1]["valor"] = "1";
	_i.aValorCantMonedas[2]["valor"] = "0.50";
	_i.aValorCantMonedas[3]["valor"] = "0.20";
	_i.aValorCantMonedas[4]["valor"] = "0.10";
	_i.aValorCantMonedas[5]["valor"] = "0.05";
	_i.aValorCantMonedas[6]["valor"] = "0.02";
	_i.aValorCantMonedas[7]["valor"] = "0.01";
	
	_i.aValorCantMonedas[0]["cantidad"] = parseFloat(cursor.valueBuffer("m2"));
	_i.aValorCantMonedas[1]["cantidad"] = parseFloat(cursor.valueBuffer("m1"));
	_i.aValorCantMonedas[2]["cantidad"] = parseFloat(cursor.valueBuffer("m050"));
	_i.aValorCantMonedas[3]["cantidad"] = parseFloat(cursor.valueBuffer("m020"));
	_i.aValorCantMonedas[4]["cantidad"] = parseFloat(cursor.valueBuffer("m010"));
	_i.aValorCantMonedas[5]["cantidad"] = parseFloat(cursor.valueBuffer("m005"));
	_i.aValorCantMonedas[6]["cantidad"] = parseFloat(cursor.valueBuffer("m002"));
	_i.aValorCantMonedas[7]["cantidad"] = parseFloat(cursor.valueBuffer("m001"));
	
	_i.numMonedas = 8;
	
	return true;
}

function oficial_cargaArrayValorDivisa()
{
  var _i = this.iface;
  var cursor = this.cursor();
	
	var codDivisa = flfactppal.iface.pub_valorDefectoEmpresa("coddivisa");
	
	var stringMonedaBillete = "";
	if (codDivisa != "EUR"){
		stringMonedaBillete = AQUtil.sqlSelect("divisas","monedabillete","coddivisa = '" + codDivisa + "'");
		if(!stringMonedaBillete){
			return false;
		}
	}
	else{
		stringMonedaBillete = "b500,b200,b100,b50,b20,b10,b5,m2,m1,m0.50,m0.20,m0.10,m0.05,m0.02,m0.01";
	}
	stringMonedaBillete = _i.quitaEspacios(stringMonedaBillete);
	
	var aMB = stringMonedaBillete.split(",");
	var prefijo;
	var longitud;
	var m = 0;
	var b = 0;
	for (var i = 0; i < aMB.length; i++){
		longitud = aMB[i].length;
		longitud--;
		prefijo = aMB[i].toString().left(1);
		valor = aMB[i].toString().right(longitud);
		if(prefijo == "m" || prefijo == "M"){
			_i.aValorCantMonedas[m] = [];
			_i.aValorCantMonedas[m]["valor"] = valor;
			_i.aValorCantMonedas[m]["cantidad"] = 0;
			m++;
		}
		if(prefijo == "b" || prefijo == "B"){
			_i.aValorCantBilletes[b] = [];
			_i.aValorCantBilletes[b]["valor"] = valor;
			_i.aValorCantBilletes[b]["cantidad"] = 0;
			b++;
		}
	}
	_i.numBilletes = b;
	_i.numMonedas = m;
	return true;
}

function oficial_cargaStringList(cursor, master)
{
  var _i = this.iface;
	
	if(master){
		_i.aValorCantBilletes = [];
		_i.aValorCantMonedas = [];
		_i.numMonedas = 0;
		_i.numBilletes = 0;
	}
	
	if(!_i.cargaStringListMonedas(cursor)){
		return false;
	}
	if(!_i.cargaStringListBilletes(cursor)){
		return false;
	}
	return true;
}
	
function oficial_cargaStringListBilletes(cursor)
{
	var _i = this.iface;
	
	var aBilletes = cursor.valueBuffer("valorcantbilletes").split(",");
	var b = 0;
	
	for (var i = 0; i < aBilletes.length; i++){
		_i.aValorCantBilletes[i] = [];
	}
	for (var i = 0; i < aBilletes.length; i++){
		valor = aBilletes[i].toString();
		if( i % 2 == 0){
			_i.aValorCantBilletes[b]["valor"] = valor;
		}
		else{
			_i.aValorCantBilletes[b]["cantidad"] = valor;
			b++;
		}
	}
	_i.numBilletes = b;
	return true;
}
	
function oficial_cargaStringListMonedas(cursor)
{
	var _i = this.iface;
	
	var aMonedas = cursor.valueBuffer("valorcantmonedas").split(",");
	var m = 0;
	
	for (var i = 0; i < aMonedas.length; i++){
		_i.aValorCantMonedas[i] = [];
	}
	for (var i = 0; i < aMonedas.length; i++){
		valor = aMonedas[i].toString();
		if( i % 2 == 0){
			_i.aValorCantMonedas[m]["valor"] = valor;
		}
		else{
			_i.aValorCantMonedas[m]["cantidad"] = valor;
			m++;
		}
	}
	_i.numMonedas = m;
	return true;
}

function oficial_cargarTablaBillete()
{
  var _i = this.iface;
  var cursor = this.cursor();
	
  var tblB = this.child("tblBilletes");
  tblB.setNumRows(0);
	
	for (f = 0; f < _i.numBilletes; f++){
		tblB.insertRows(f, 1);
		tblB.setText(f, _i.bVAL_, "Billetes de " + _i.aValorCantBilletes[f]["valor"]);
		tblB.setText(f, _i.bOCU_, _i.aValorCantBilletes[f]["valor"]);
		tblB.setText(f, _i.bCAN_, _i.aValorCantBilletes[f]["cantidad"]);
  }
}


function oficial_cargarTablaMoneda()
{
  var _i = this.iface;
  var cursor = this.cursor();
	
  var tblM = this.child("tblMonedas");
  tblM.setNumRows(0);
	
	for (f = 0; f < _i.numMonedas; f++){
		tblM.insertRows(f, 1);
		tblM.setText(f, _i.mVAL_, "Monedas de " + _i.aValorCantMonedas[f]["valor"]);
		tblM.setText(f, _i.mOCU_, _i.aValorCantMonedas[f]["valor"]);
		tblM.setText(f, _i.mCAN_, _i.aValorCantMonedas[f]["cantidad"]);
  }
}

function oficial_quitaEspacios(s)
{
	var n = "", c;
	for (var i = 0; i < s.length; i++) {
		c = s.charAt(i);
		n += c != " " ? c : "";
	}
	return n;
}


function oficial_tblBilletes_valueChanged(f, c)
{
  var _i = this.iface;
  var cursor = this.cursor();
	
  if (c != _i.bCAN_) {
    return;
  }
  var tblB = this.child("tblBilletes");
	
  cantidad = parseFloat(tblB.text(f, _i.bCAN_));
	
	if(!_i.validarCantidad(cantidad)){
    MessageBox.warning(sys.translate("La cantidad introducida no es válida."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
    tblB.setText(f, _i.bCAN_, 0);
		return;
	}
		
	_i.calcularValores();
	
  return true;
}

function oficial_tblMonedas_valueChanged(f, c)
{
  var _i = this.iface;
  var cursor = this.cursor();
	
  if (c != _i.mCAN_) {
    return;
  }
  var tblM = this.child("tblMonedas");
	
  cantidad = parseFloat(tblM.text(f, _i.mCAN_).toString());
  
	if(!_i.validarCantidad(cantidad)){
    MessageBox.warning(sys.translate("La cantidad introducida no es válida."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
    tblM.setText(f, _i.mCAN_, 0);
		return;
	}
	_i.calcularValores();
	
  return true;
}

function oficial_validarCantidad(cantidad)
{
  if (isNaN(cantidad)) {
    return false;
  }
  if (parseFloat(cantidad) < 0){
    return false;
  }
  if (cantidad != Math.round(cantidad)) {
    return false;
  }
  return true;
}

function oficial_ponValorBilletes()
{
  var _i = this.iface;
  var cursor = this.cursor();
	var sBilletes = "";

	var tblB = this.child("tblBilletes");

	for(var f = 0; f < _i.numBilletes; f++){
		sBilletes += tblB.text(f,_i.bOCU_);
		sBilletes += ",";
		sBilletes += tblB.text(f,_i.bCAN_);
		sBilletes += ",";
	}
	cursor.setValueBuffer("valorcantbilletes", sBilletes);
	return true;
}

function oficial_ponValorMonedas()
{
  var _i = this.iface;
  var cursor = this.cursor();
	var sMonedas = "";
	
	var tblM = this.child("tblMonedas");
	
	for(var f = 0; f < _i.numMonedas; f++){
		sMonedas += tblM.text(f,_i.mOCU_);
		sMonedas += ",";
		sMonedas += tblM.text(f,_i.mCAN_);
		sMonedas += ",";
	}
	cursor.setValueBuffer("valorcantmonedas", sMonedas);
	return true;
}

function oficial_ponerCamposCero()
{
  var _i = this.iface;
	var cursor = this.cursor();

	cursor.setValueBuffer("b500", 0);
	cursor.setValueBuffer("b200", 0);
	cursor.setValueBuffer("b100", 0);
	cursor.setValueBuffer("b50", 0);
	cursor.setValueBuffer("b20", 0);
	cursor.setValueBuffer("b10", 0);
	cursor.setValueBuffer("b5", 0);
	cursor.setValueBuffer("m2", 0);
	cursor.setValueBuffer("m1", 0);
	cursor.setValueBuffer("m050", 0);
	cursor.setValueBuffer("m020", 0);
	cursor.setValueBuffer("m010", 0);
	cursor.setValueBuffer("m005", 0);
	cursor.setValueBuffer("m002", 0);
	cursor.setValueBuffer("m001", 0);

	_i.hayCamposAntiguos = false;
	
	return true;
}

function oficial_dameAgenteArqueo(codTerminal)
{
	var _i = this.iface;
	var codAgente = flfact_tpv.iface.agenteActivo_;
	if (!codAgente || codAgente == "") {
		codAgente = AQUtil.sqlSelect("tpv_puntosventa", "codtpv_agente", "codtpv_puntoventa ='" + codTerminal + "'");
	}
	if (flfact_tpv.iface.pub_valorDefectoTPV("autagentearqueo")) {
		if (!flfact_tpv.iface.pub_cambiarAgenteActivo(codAgente)) {
			return false;
		}
	} else {
		flfact_tpv.iface.pub_ponAgenteActivo(codAgente)
	}
	codAgente = flfact_tpv.iface.agenteActivo_;
	if (!codAgente) {
		MessageBox.warning(sys.translate("No ha establecido ningún agente de venta"),MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
	return codAgente;
}

function oficial_habilitaPorSeguridad()
{
	if (flfact_tpv.iface.pub_valorDefectoTPV("autagentearqueo")) {
		this.child("fdbAgenteApertura").setDisabled(true);
		this.child("fdbAgenteCierre").setDisabled(true);
	}
}

function oficial_comprobarCoincidenciaArqueo()
{
	var _i = this.iface;
	var cursor= this.cursor();
	
	/**var diaDesde= this.child("fdbDiaDesde").value();
	var ptoVenta= this.child("fdbPuntoVenta").value();
	var idArqueo= cursor.valueBuffer("idtpv_arqueo");
	
	if (cursor.modeAccess() == cursor.Insert) {
		if(AQUtil.sqlSelect("tpv_arqueos","diadesde","idtpv_arqueo <> '" + idArqueo + "' AND ptoventa = '" + ptoVenta + "' AND (diadesde >= '" + diaDesde + "' OR diahasta >= '" + diaDesde + "')")){
			MessageBox.warning(sys.translate("Ya existe un arqueo para ese punto de venta que coincide con ese intervalo de fechas"),MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return false;
		}
	}*/
	
	var ptoVenta= this.child("fdbPuntoVenta").value();
	var idArqueo= cursor.valueBuffer("idtpv_arqueo");
	
	if (cursor.modeAccess() == cursor.Insert) {
		if(AQUtil.sqlSelect("tpv_arqueos","diadesde","idtpv_arqueo <> '" + idArqueo + "' AND ptoventa = '" + ptoVenta + "' AND abierta")){
			MessageBox.warning(sys.translate("Ya existe un arqueo abierto para ese punto de venta."),MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return false;
		}
	}
	return true;
}

function oficial_tblBilletes_currentChanged(f, c)
{
  var _i = this.iface;
  var cursor = this.cursor();
	
	var tblB = this.child("tblBilletes").numRows();
	
	if(tblB == 0){
		return;
	}
	if(c == _i.bVAL_){
		this.child("tblBilletes").editCell(f, _i.bCAN_);
	}
	if(c == _i.bCAN_ && f == 0 && _i.pulsadoEnter_){
		this.mainWidget().child("tblMonedas").setFocus();
		this.child("tblMonedas").editCell(0, _i.mCAN_);
		_i.pulsadoEnter_ = false;
	}
	if(c == _i.bCAN_ && f == 0 && !_i.pulsadoEnter_){
		_i.pulsadoEnter_ = true;
	}
/**
	for(var fila = 0; fila < tblB; fila++){
		this.child("tblBilletes").setCellBackgroundColor(fila, _i.bCAN_, _i.verde_);
	}
	this.child("tblBilletes").setCellBackgroundColor(f, _i.bCAN_, _i.azul_);
*/
}

function oficial_tblMonedas_currentChanged(f, c)
{
  var _i = this.iface;
  var cursor = this.cursor();
	var tblM = this.child("tblMonedas").numRows();
	
	if(tblM == 0){
		return;
	}

	if(c == _i.mVAL_){
		this.child("tblMonedas").editCell(f, _i.mCAN_);
	}
	
	if(c == _i.mCAN_ && f == 0 && _i.pulsadoEnter_){
		this.child("fdbTotalTarjeta").setFocus();
		_i.pulsadoEnter_ = false;
	}
	if(c == _i.mCAN_ && f == 0 && !_i.pulsadoEnter_){
		_i.pulsadoEnter_ = true;
	}
	
}

function oficial_iniciarArrayControlesFdb()
{
	var aControles = ["fdbIdArqueo", "fdbPuntoVenta", "fdbDiaDesde", "fdbHoraDesde", "fdbDiaHasta", "fdbHoraHasta", "fdbCantInicial", "fdbSacado", "fdbAgenteApertura", "fdbAgenteCierre", "fdbTotalCaja", "fdbTotalTarjeta", "fdbTotalVale", "fdbObservaciones"];
	return aControles;
}

function oficial_initEventFilter()
{
  var _i = this.iface;

  _i.eventWatcher_ = new QObject;
  _i.eventWatcher_.eventFilterFunction = this.name + ".iface.pub_eventFilter";
  _i.eventWatcher_.allowedEvents = [AQS.FocusIn, AQS.FocusOut/**, AQS.KeyRelease*/];
}

function oficial_eventFilter(o, e)
{
	var cursor = this.cursor();
	var _i = this.iface;
	
  switch (e.type) {
		/**case AQS.KeyRelease: {
			if(e.eventData["key"] == 4100 || e.eventData["key"] == 4101){
				var nombreControl = "";
				var j = -1;
				if(o.rtti() == "LineEdit") {
					if (o.parentWidget()){
						nombreControl = o.parentWidget().name;
					}
				}
				else if(o.rtti() == "Table" || o.rtti() == "PushButton") {
					nombreControl = o.name;
				}
				switch(nombreControl){
					case "tblLineas":{
						this.child("txtCanArticulo").setFocus();
						break;
					}
				}
			}
      return true;
    }*/
    case AQS.FocusIn: {
      if (o.rtti() == "LineEdit" || o.rtti() == "Table") {
        o.paletteBackgroundColor = "#BCF5A9";
      }
      return true;
    }
    case AQS.FocusOut: {
      if(o.rtti() == "LineEdit" || o.rtti() == "Table") {
        o.paletteBackgroundColor = "#FFFFFF";
      }
      return true;
    }
  }
  return false;
}

function oficial_initWatch(obj)
{
  if (obj == undefined)
    return;
  var _i = this.iface;
  obj.installEventFilter(_i.eventWatcher_);
}

function oficial_finishWatch(obj)
{
  if (obj == undefined)
    return;
  var _i = this.iface;
  obj.removeEventFilter(_i.eventWatcher_);
}

function oficial_colores()
{
  var _i = this.iface;
	
  _i.azul_ = new Color("blue");
  _i.rojo_ = new Color("red");
  _i.verde_ = new Color(188, 245, 169);
  _i.blanco_ = new Color("white");
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
