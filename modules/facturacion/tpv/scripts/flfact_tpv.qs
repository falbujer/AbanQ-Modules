/***************************************************************************
								 flfact_tpv.qs  -  description
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
		this.ctx.interna_init();
	}
	function beforeCommit_tpv_comandas(curComanda: FLSqlCursor)
	{
		return this.ctx.interna_beforeCommit_tpv_comandas(curComanda);
	}
	function afterCommit_tpv_comandas(curComanda: FLSqlCursor)
	{
		return this.ctx.interna_afterCommit_tpv_comandas(curComanda);
	}
	function beforeCommit_tpv_pagoscomanda(curPago)
	{
		return this.ctx.interna_beforeCommit_tpv_pagoscomanda(curPago);
	}
	function afterCommit_tpv_lineasvale(curLinea: FLSqlCursor)
	{
		return this.ctx.interna_afterCommit_tpv_lineasvale(curLinea);
	}
	function afterCommit_tpv_pagoscomanda(curPago)
	{
		return this.ctx.interna_afterCommit_tpv_pagoscomanda(curPago);
	}
	function afterCommit_tpv_lineascomanda(curLinea: FLSqlCursor)
	{
		return this.ctx.interna_afterCommit_tpv_lineascomanda(curLinea);
	}
	function beforeCommit_tpv_arqueos(curArqueo: FLSqlCursor)
	{
		return this.ctx.interna_beforeCommit_tpv_arqueos(curArqueo);
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna
{
	var oImpresoraPV_, printer;
	var printerXPos, printerYPos, printerESC;
	var textoPrinter = "";
	var artConsultaStock_;
	var costeAc_, totalAc_;
	var agenteActivo_;
	var codPagosTPV_;
	var curFactura: FLSqlCursor;
	var curLineaFactura: FLSqlCursor;

	function oficial(context)
	{
		interna(context);
	}
	function ejecutarQry(tabla, campos, where, listaTablas)
	{
		return this.ctx.oficial_ejecutarQry(tabla, campos, where, listaTablas);
	}
	function copiarLinea(idFactura: Number, curLineaComanda: FLSqlCursor)
	{
		return this.ctx.oficial_copiarLinea(idFactura, curLineaComanda);
	}
	function copiarLineas(idComanda: Number, idFactura: Number)
	{
		return this.ctx.oficial_copiarLineas(idComanda, idFactura);
	}
	function soloCabeceraFactura(curComanda)
	{
		return this.ctx.oficial_soloCabeceraFactura(curComanda);
	}
	function crearFactura(curComanda: FLSqlCursor)
	{
		return this.ctx.oficial_crearFactura(curComanda);
	}
	function borrarFactura(idFactura: String)
	{
		return this.ctx.oficial_borrarFactura(idFactura);
	}
	function valoresIniciales()
	{
		return this.ctx.oficial_valoresIniciales();
	}
	function datosLineaFactura(curLineaComanda: FLSqlCursor)
	{
		return this.ctx.oficial_datosLineaFactura(curLineaComanda);
	}
	function dameDatosRecibo(curComanda)
	{
		return this.ctx.oficial_dameDatosRecibo(curComanda);
	}
	function generarRecibos(curComanda)
	{
		return this.ctx.oficial_generarRecibos(curComanda);
	}
	function generarReciboPagados(qryFactura, curComanda)
	{
		return this.ctx.oficial_generarReciboPagados(qryFactura, curComanda);
	}
	function generarReciboPendiente(qryFactura, datosRecibo, curComanda)
	{
		return this.ctx.oficial_generarReciboPendiente(qryFactura, datosRecibo, curComanda);
	}
	function generarRecibo(qryFactura, datosRecibo, curComanda)
	{
		return this.ctx.oficial_generarRecibo(qryFactura, datosRecibo, curComanda);
	}
	function pagarRecibo(idRecibo, datosRecibo, curComanda)
	{
		return this.ctx.oficial_pagarRecibo(idRecibo, datosRecibo, curComanda);
	}
	function totalesFactura(curComanda: FLSqlCursor)
	{
		return this.ctx.oficial_totalesFactura(curComanda);
	}
	function datosFactura(curComanda: FLSqlCursor)
	{
		return this.ctx.oficial_datosFactura(curComanda);
	}
	function imprimirDatos(datos: String, maxLon: Number, alineacion: Number)
	{
		return this.ctx.oficial_imprimirDatos(datos, maxLon, alineacion);
	}
	function establecerImpresora(impresora: String)
	{
		return this.ctx.oficial_establecerImpresora(impresora);
	}
	function flushImpresora()
	{
		return this.ctx.oficial_flushImpresora();
	}
	function impNuevaLinea(numLineas: Number)
	{
		return this.ctx.oficial_impNuevaLinea(numLineas);
	}
	function impAlinearH(alineacion: Number)
	{
		return this.ctx.oficial_impAlinearH(alineacion);
	}
	function impResaltar(resaltar: Boolean)
	{
		return this.ctx.oficial_impResaltar(resaltar);
	}
	function impTamLetra(tamLetra)
	{
		return this.ctx.oficial_impTamLetra(tamLetra);
	}
	function impSubrayar(subrayar: Boolean)
	{
		return this.ctx.oficial_impSubrayar(subrayar);
	}
	function impCortar()
	{
		return this.ctx.oficial_impCortar();
	}
	function impLogo()
	{
		return this.ctx.oficial_impLogo();
	}
	function impFont(font)
	{
		return this.ctx.oficial_impFont(font);
	}
	function impSimboloEuro()
	{
		return this.ctx.oficial_impSimboloEuro();
	}
  function impBarcode(barcode)
  {
    return this.ctx.oficial_impBarcode(barcode);
  }
	function espaciosIzquierda(texto: String, totalLongitud: Number)
	{
		return this.ctx.oficial_espaciosIzquierda(texto, totalLongitud);
	}
	function subcuentaDefecto(nombre, codEjercicio, curAC)
	{
		return this.ctx.oficial_subcuentaDefecto(nombre, codEjercicio, curAC);
	}
	function subcuentaCausa(codCausa: String, codEjercicio: String)
	{
		return this.ctx.oficial_subcuentaCausa(codCausa, codEjercicio);
	}
	function generarAsientoArqueo(curArqueo: FLSqlCursor)
	{
		return this.ctx.oficial_generarAsientoArqueo(curArqueo);
	}
	function comprobarRegularizacion(curArqueo: FLSqlCursor)
	{
		return this.ctx.oficial_comprobarRegularizacion(curArqueo);
	}
	function regenerarAsiento(curArqueo: FLSqlCursor, valoresDefecto: Array)
	{
		return this.ctx.oficial_regenerarAsiento(curArqueo, valoresDefecto);
	}
	//  function generarPartidasCliente(curArqueo: FLSqlCursor, idAsiento: Number, valoresDefecto: Array)
	//  {
	//    return this.ctx.oficial_generarPartidasCliente(curArqueo, idAsiento, valoresDefecto);
	//  }
	//  function generarPartidasVentasIva(curArqueo: FLSqlCursor, idAsiento: Number, valoresDefecto: Array)
	//  {
	//    return this.ctx.oficial_generarPartidasVentasIva(curArqueo, idAsiento, valoresDefecto);
	//  }
	//  function generarPartidasPago(curArqueo: FLSqlCursor, idAsiento: Number, valoresDefecto: Array)
	//  {
	//    return this.ctx.oficial_generarPartidasPago(curArqueo, idAsiento, valoresDefecto);
	//  }
	function generarPartidasMovi(curArqueo, idAsiento, valoresDefecto)
	{
		return this.ctx.oficial_generarPartidasMovi(curArqueo, idAsiento, valoresDefecto);
	}
	function generarPartidasMoviCierre(curArqueo, idAsiento, valoresDefecto)
	{
		return this.ctx.oficial_generarPartidasMoviCierre(curArqueo, idAsiento, valoresDefecto);
	}
	function generarPartidasDif(curArqueo, idAsiento, valoresDefecto)
	{
		return this.ctx.oficial_generarPartidasDif(curArqueo, idAsiento, valoresDefecto);
	}
	function conceptoPartida(curArqueo: FLSqlCursor, masConcepto: String)
	{
		return this.ctx.oficial_conceptoPartida(curArqueo, masConcepto);
	}
	function borrarAsientoArqueo(curArqueo: FLSqlCursor, idAsiento: String)
	{
		return this.ctx.oficial_borrarAsientoArqueo(curArqueo, idAsiento);
	}
	function sincronizarConFacturacion(curComanda)
	{
		return this.ctx.oficial_sincronizarConFacturacion(curComanda);
	}
	function sincronizaFactura(oParam)
	{
		return this.ctx.oficial_sincronizaFactura(oParam);
	}
	function sincronizaDevolucion(curComanda)
	{
		return this.ctx.oficial_sincronizaDevolucion(curComanda);
	}
	function obtenerCodigoComanda(curComanda)
	{
		return this.ctx.oficial_obtenerCodigoComanda(curComanda);
	}
	function damePrefijo(curComanda)
	{
		return this.ctx.oficial_damePrefijo(curComanda);
	}
	function comprobarSincronizacion(curComanda)
	{
		return this.ctx.oficial_comprobarSincronizacion(curComanda);
	}
	function comprobarPagoAnticipado(oParam)
	{
		return this.ctx.oficial_comprobarPagoAnticipado(oParam);
	}
	function generarPartidasArqueo(curArqueo, datosAsiento, valoresDefecto)
	{
		return this.ctx.oficial_generarPartidasArqueo(curArqueo, datosAsiento, valoresDefecto);
	}
	function valorDefectoTPV(campo: String)
	{
		return this.ctx.oficial_valorDefectoTPV(campo);
	}
	function obtenerSerieFactura(curComanda)
	{
		return this.ctx.oficial_obtenerSerieFactura(curComanda);
	}
	function dameEjercicioFactura(curComanda)
	{
		return this.ctx.oficial_dameEjercicioFactura(curComanda);
	}
	function dameDivisaFactura(curComanda)
	{
		return this.ctx.oficial_dameDivisaFactura(curComanda);
	}
	function borrarRecibosFactura(idFactura: String)
	{
		return this.ctx.oficial_borrarRecibosFactura(idFactura);
	}
	function borrarLineasFactura(idFactura: String)
	{
		return this.ctx.oficial_borrarLineasFactura(idFactura);
	}
	function modificarFactura(curComanda: FLSqlCursor, idFactura: String)
	{
		return this.ctx.oficial_modificarFactura(curComanda, idFactura);
	}
	function comprobarAlmacenesComandas()
	{
		return this.ctx.oficial_comprobarAlmacenesComandas();
	}
	function consultarStock(oArticulo)
	{
		return this.ctx.oficial_consultarStock(oArticulo);
	}
	function dameArtConsultaStock()
	{
		return this.ctx.oficial_dameArtConsultaStock();
	}
	function iniciarTotales(nodo, campo)
	{
		return this.ctx.oficial_iniciarTotales(nodo, campo);
	}
	function calcularBeneficio(nodo, campo)
	{
		return this.ctx.oficial_calcularBeneficio(nodo, campo);
	}
	function mostrarTotales(nodo, campo)
	{
		return this.ctx.oficial_mostrarTotales(nodo, campo);
	}
	function controlArquePagoComanda(curPago)
	{
		return this.ctx.oficial_controlArquePagoComanda(curPago);
	}
	function generarAsientoPagoComanda(curPago)
	{
		return this.ctx.oficial_generarAsientoPagoComanda(curPago);
	}
	function generarAsientoPagoDevolucion(curPago)
	{
		return this.ctx.oficial_generarAsientoPagoDevolucion(curPago);
	}
	function generarPartidasPCAnticiposCli(curPago, valoresDefecto, datosAsiento, oPago)
	{
		return this.ctx.oficial_generarPartidasPCAnticiposCli(curPago, valoresDefecto, datosAsiento, oPago);
	}
	function generarPartidasPCBanco(curPago, valoresDefecto, datosAsiento, oPago)
	{
		return this.ctx.oficial_generarPartidasPCBanco(curPago, valoresDefecto, datosAsiento, oPago);
	}
	function generarPartidasVentas(curPago, valoresDefecto, datosAsiento, oPago)
	{
		return this.ctx.oficial_generarPartidasVentas(curPago, valoresDefecto, datosAsiento, oPago);
	}
	function generarPartidasDevolucion(curPago, valoresDefecto, datosAsiento, oPago)
	{
		return this.ctx.oficial_generarPartidasDevolucion(curPago, valoresDefecto, datosAsiento, oPago);
	}
	function dameSubcuentaPCAnticiposCli(curPago, valoresDefecto, datosAsiento, oPago)
	{
		return this.ctx.oficial_dameSubcuentaPCAnticiposCli(curPago, valoresDefecto, datosAsiento, oPago);
	}
	function dameSubcuentaVale(curPago, valoresDefecto, datosAsiento, oPago)
	{
		return this.ctx.oficial_dameSubcuentaVale(curPago, valoresDefecto, datosAsiento, oPago);
	}
	function dameSubcuentaVenta(curPago, valoresDefecto, datosAsiento, oPago)
	{
		return this.ctx.oficial_dameSubcuentaVenta(curPago, valoresDefecto, datosAsiento, oPago);
	}
	function dameSubcuentaPCBanco(curPago, valoresDefecto, datosAsiento, oPago)
	{
		return this.ctx.oficial_dameSubcuentaPCBanco(curPago, valoresDefecto, datosAsiento, oPago);
	}
	function dameDatosPagoAsiento(curPago)
	{
		return this.ctx.oficial_dameDatosPagoAsiento(curPago);
	}
	function datosPartidaPCAnticipo(curPartida, curPago, valoresDefecto, datosAsiento, oPago)
	{
		return this.ctx.oficial_datosPartidaPCAnticipo(curPartida, curPago, valoresDefecto, datosAsiento, oPago);
	}
	function ponAgenteActivo(codAgente)
	{
		return this.ctx.oficial_ponAgenteActivo(codAgente);
	}
	function validarAgente(codAgente,noAutentificar)
	{
		return this.ctx.oficial_validarAgente(codAgente,noAutentificar);
	}
  function cambiarAgenteActivo(codAgente,noAutentificar)
	{
		return this.ctx.oficial_cambiarAgenteActivo(codAgente,noAutentificar)
	}
  function actualizarSaldo(refVale)
	{
		return this.ctx.oficial_actualizarSaldo(refVale);
	}
	function datosActualizarSaldo(curC)
	{
		return this.ctx.oficial_datosActualizarSaldo(curC);
	}
	function controlDatosMod(curT) {
		return this.ctx.oficial_controlDatosMod(curT);
	}
	function registrarCambioCursor(curT) {
		return this.ctx.oficial_registrarCambioCursor(curT);
	}
  function controlDevolEfectivo(curPago)
  {
    return this.ctx.oficial_controlDevolEfectivo(curPago);
  }
  function validaAgenteDevolEfectivo()
  {
    return this.ctx.oficial_validaAgenteDevolEfectivo();
  }
  function estableceImpresoraPV(codPuntoVenta)
  {
    return this.ctx.oficial_estableceImpresoraPV(codPuntoVenta);
  }
  function dameImpresoraPV()
  {
    return this.ctx.oficial_dameImpresoraPV();
  }
  function dameString2Hex(s)
  {
    return this.ctx.oficial_dameString2Hex(s);
  }
  function esUnaTienda()
  {
    return this.ctx.oficial_esUnaTienda();
  }
  function esBDLocal()
  {
    return this.ctx.oficial_esBDLocal();
  }
  function totalPagosArqueo(curP)
  {
    return this.ctx.oficial_totalPagosArqueo(curP);
  }
  function totalizaPagosArqueo(codArqueo, codPago)
  {
    return this.ctx.oficial_totalizaPagosArqueo(codArqueo, codPago);
  }
  function marcaHoraComanda(curC)
	{
		return this.ctx.oficial_marcaHoraComanda(curC);
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
	function pub_ejecutarQry(tabla, campos, where, listaTablas)
	{
		return this.ejecutarQry(tabla, campos, where, listaTablas);
	}
	function pub_borrarAsientoArqueo(curArqueo: FLSqlCursor, idAsiento: String)
	{
		return this.borrarAsientoArqueo(curArqueo, idAsiento);
	}
	function pub_valorDefectoTPV(campo: String)
	{
		return this.valorDefectoTPV(campo);
	}
	function pub_crearFactura(curComanda: FLSqlCursor)
	{
		return this.crearFactura(curComanda);
	}
	function pub_generarRecibos(curComanda: FLSqlCursor)
	{
		return this.generarRecibos(curComanda);
	}
	function pub_consultarStock(oArticulo)
	{
		return this.consultarStock(oArticulo);
	}
	function pub_dameArtConsultaStock()
	{
		return this.dameArtConsultaStock();
	}
	function pub_iniciarTotales(nodo, campo)
	{
		return this.iniciarTotales(nodo, campo);
	}
	function pub_calcularBeneficio(nodo, campo)
	{
		return this.calcularBeneficio(nodo, campo);
	}
	function pub_mostrarTotales(nodo, campo)
	{
		return this.mostrarTotales(nodo, campo);
	}
	function pub_ponAgenteActivo(codAgente)
	{
		return this.ponAgenteActivo(codAgente);
	}
	function pub_validarAgente(codAgente,noAutentificar) {
		return this.validarAgente(codAgente,noAutentificar);
	}
  function pub_cambiarAgenteActivo(codAgente,noAutentificar) {
		return this.cambiarAgenteActivo(codAgente,noAutentificar);
	}
  function pub_controlDevolEfectivo(curPago) {
    return this.controlDevolEfectivo(curPago);
  }
  function pub_controlDevolEfectivo(curPago) {
    return this.controlDevolEfectivo(curPago);
  }
  function pub_estableceImpresoraPV(codPuntoVenta) {
    return this.estableceImpresoraPV(codPuntoVenta);
  }
  function pub_dameImpresoraPV() {
    return this.dameImpresoraPV();
  }
  function pub_dameString2Hex(s) {
    return this.dameString2Hex(s);
  }
  function pub_esUnaTienda()
  {
    return this.esUnaTienda();
  }
  function pub_esBDLocal()
  {
    return this.esBDLocal();
  }
  function pub_establecerImpresora(impresora)
  {
    return this.establecerImpresora(impresora);
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
/** \D
Si es la primera vez que se ejecuta establece los valores iniciales de Datos Generales
*/
function interna_init()
{
	var cursor = new FLSqlCursor("tpv_datosgenerales");
	var _i = this.iface;

	cursor.select();
	if (!cursor.first()) {
		MessageBox.information(sys.translate("Se establecerán algunos valores iniciales para empezar a trabajar."),MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		_i.valoresIniciales();
		this.execMainScript("tpv_datosgenerales");
	}

	_i.comprobarAlmacenesComandas();
}

/** \C Si se ha seleccionado la opción de facturación integrada, se creará una factura por venta. Si no se ha seleccionado, se generará cuando la venta sea a cuenta y el usuario lo permita
\end */
function interna_beforeCommit_tpv_comandas(curComanda)
{
	var _i = this.iface;

	if (!_i.marcaHoraComanda(curComanda)) {
		return false;
	}

	var codComanda = curComanda.valueBuffer("codigo");
	var idTpvComanda = curComanda.valueBuffer("idtpv_comanda");
	switch (curComanda.modeAccess()) {
		case curComanda.Insert: {
			if (curComanda.valueBuffer("codigo") == "0") {
				curComanda.setValueBuffer("codigo", _i.obtenerCodigoComanda(curComanda));
			}
			if (curComanda.valueBuffer("codigo") == "" || curComanda.valueBuffer("codigo") == "0") {
				MessageBox.warning(sys.translate("El código de la venta no puede estar vacío"), MessageBox.Ok, MessageBox.NoButton);
				return false;
			}
			if (AQUtil.sqlSelect("tpv_comandas", "idtpv_comanda", "codigo = '" + codComanda + "' AND idtpv_comanda != " + idTpvComanda)) {
				var res = MessageBox.information(sys.translate("Ya existe una venta con este código.\n¿Desea continuar?"), MessageBox.Yes, MessageBox.No);
				if (res != MessageBox.Yes) {
					return false;
				}
			}
			break;
		}
	}
	if (!_i.comprobarSincronizacion(curComanda)) {
		return false;
	}
	return true;
}

function interna_afterCommit_tpv_comandas(curComanda: FLSqlCursor)
{
	var _i = this.iface;

	if (!flfactalma.iface.pub_controlStockCabComandas(curComanda)){
		return false;
	}

	return true;
}

function interna_beforeCommit_tpv_pagoscomanda(curPago)
{
	var _i = this.iface;

	if(!_i.controlArquePagoComanda(curPago)){
		return false;
	}
	return true;
}

function interna_afterCommit_tpv_pagoscomanda(curPago)
{
	var _i = this.iface;

	if (!_i.totalPagosArqueo(curPago)) {
		return false;
	}

	switch (curPago.modeAccess()) {
		case curPago.Insert:
		case curPago.Edit: {
			/** \C Si se ha pagado con un vale, se actualiza su saldo
			\end */
			var refVale = curPago.valueBuffer("refvale");
			if (refVale && refVale != "") {
				_i.actualizarSaldo(refVale);
			}
			break;
		}
		case curPago.Del: {
			/** \C Si se ha pagado con un vale, se actualiza su saldo
			\end */
			var refVale = curPago.valueBuffer("refvale");
			if (refVale && refVale != "") {
				_i.actualizarSaldo(refVale);
			}
			if (sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada") && !curPago.valueBuffer("nogenerarasiento")) {
				if (curPago.isNull("idasiento")){
					return true;
				}
				var idAsiento= curPago.valueBuffer("idasiento");
				if (flfacturac.iface.pub_asientoBorrable(idAsiento) == false){
					return false;
				}
				if (!flfacturac.iface.pub_eliminarAsiento(idAsiento)){
					return false;
				}
			}
			break;
		}
	}
	return true;
}

/** \C  Al modificar las líneas de vale (artículos devueltos), el stock de los artículos correspondientes se modifica en consonancia
\end */
function interna_afterCommit_tpv_lineasvale(curLinea)
{
	if (!flfactalma.iface.pub_controlStockValesTPV(curLinea)){
		return false;
	}
	return true;
}

/** \C  Al modificar las líneas de comanda (artículos vendidos), el stock de los artículos correspondientes se modifica en consonancia
\end */
function interna_afterCommit_tpv_lineascomanda(curLinea: FLSqlCursor)
{
	if (!flfactalma.iface.pub_controlStockComandasCli(curLinea)){
		return false;
	}
	return true;
}

/** \C  Al Cerrar o abrir el arqueo se genera o borra el correspondiente asiento contable
\end */
function interna_beforeCommit_tpv_arqueos(curArqueo: FLSqlCursor)
{
	var _i = this.iface;

	if (sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada")) {
		switch (curArqueo.modeAccess()) {
		case curArqueo.Edit: {
				var estadoActual = curArqueo.valueBuffer("abierta");
				var estadoPrevio = curArqueo.valueBufferCopy("abierta");
				if (estadoActual != estadoPrevio) {
					if (!estadoActual) {
						if (!_i.generarAsientoArqueo(curArqueo)) {
							return false;
						}
					}
				}
				break;
			}
		}
	}
	return true;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_comprobarSincronizacion(curComanda)
{
	var _i = this.iface;

	if (curComanda.modeAccess() == curComanda.Insert) {
		return true;
	}
// 	if (!flfactalma.iface.pub_controlStockCabComandas(curComanda)){
// 		return false;
// 	}
// 	if (curComanda.valueBuffer("tipodoc") != "VENTA") {
// 		return true;
// 	}
	var integracionFac = AQUtil.sqlSelect("tpv_datosgenerales", "integracionfac", "1 = 1");
	var pendiente = parseFloat(curComanda.valueBuffer("pendiente"));
	if (pendiente != 0 || integracionFac || !curComanda.isNull("idfactura")) {
		if (!_i.sincronizarConFacturacion(curComanda)) {
			return false;
		}
	}
	return true;
}

function oficial_comprobarPagoAnticipado(oParam)
{
	var _i = this.iface;
	var curComanda = oParam.curComanda;

	if (curComanda.valueBuffer("tipodoc") != "RESERVA") {
		return true;
	}
	if (!(sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada"))) {
		return true;
	}

	var idComanda = curComanda.valueBuffer("idtpv_comanda");

	var q = new FLSqlQuery();
	q.setSelect("idpago,nogenerarasiento,idasiento,editable");
	q.setFrom("tpv_pagoscomanda");
	q.setWhere("idtpv_comanda = " + idComanda);
	q.setForwardOnly(true);
	if (!q.exec()) {
		return false;
	}

	var curPago = new FLSqlCursor("tpv_pagoscomanda");
	var noGA, idAsiento;
	while (q.next()) {
		idAsiento = q.value("idasiento");
		noGA = q.value("nogenerarasiento");
// 		if(q.value(1)){
// 			continue;
// 		}
// 		if(q.value(2)){
// 			continue;
// 		}
		if(!q.value("editable")){
			continue;
		}
		curPago.select("idpago = " + q.value(0));
		curPago.first();
		curPago.setModeAccess(curPago.Edit);
		curPago.refreshBuffer();
		if (!_i.generarAsientoPagoComanda(curPago)) {
			return false;
		}
		if(!curPago.commitBuffer()){
			return false;
		}
		if (noGA && idAsiento) {
			if (!flfacturac.iface.pub_eliminarAsiento(idAsiento)) {
				return false;
			}
		}
	}
	return true;
}

/** \D Ejecuta una query especificada

@param tabla Argumento de setTablesList
@param campo Argumento de setSelect
@param tabla Argumento de setWhere
@param tabla Argumento de setFrom

@return Un array con los datos de los campos seleccionados. Un campo extra
'result' que es 1 = Ok, 0 = Error, -1 No encontrado
*/
function oficial_ejecutarQry(tabla, campos, where, listaTablas)
{
	var _i = this.iface;

	var campo = campos.split(",");
	var valor = [];
	valor["result"] = 1;
	var query = new FLSqlQuery();
	if (listaTablas)
		query.setTablesList(listaTablas);
	else
		query.setTablesList(tabla);
	query.setSelect(campo);
	query.setFrom(tabla);
	query.setWhere(where + ";");
	if (query.exec()) {
		if (query.next()) {
			for (var i = 0; i < campo.length; i++) {
				valor[campo[i]] = query.value(i);
			}
		} else {
			valor.result = -1;
		}
	} else {
		MessageBox.critical(sys.translate("Falló la consulta") + query.sql(), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		valor.result = 0;
	}

	return valor;
}

/** \D Copia una linea de la comanda  a la factura

@param idFactura identificador de la factura
@param curLineaComanda cursor de las lineas de la comanda
@return Boolean, true si la linea se ha copiado correctamente y false si ha habido algún errror
*/
function oficial_copiarLinea(idFactura: Number, curLineaComanda: FLSqlCursor)
{
	var _i = this.iface;

	if (!_i.curLineaFactura)
		_i.curLineaFactura = new FLSqlCursor("lineasfacturascli");

	with(_i.curLineaFactura) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("idfactura", idFactura);
	}

	if (!_i.datosLineaFactura(curLineaComanda))
		return false;

	if (!_i.curLineaFactura.commitBuffer())
		return false;

	return _i.curLineaFactura.valueBuffer("idlinea");
}

/** \D Copia campo a campo una linea de la comanda en una línea de la factura
@param curLineaComanda cursor de las lineas de la comanda
@return Boolean, true si la linea se ha copiado correctamente y false si ha habido algún errror
*/
function oficial_datosLineaFactura(curLineaComanda: FLSqlCursor)
{
	var _i = this.iface;

	with(_i.curLineaFactura) {
		setValueBuffer("referencia", curLineaComanda.valueBuffer("referencia"));
		setValueBuffer("descripcion", curLineaComanda.valueBuffer("descripcion"));
		setValueBuffer("pvpunitario", curLineaComanda.valueBuffer("pvpunitario"));
		setValueBuffer("cantidad", curLineaComanda.valueBuffer("cantidad"));
		setValueBuffer("pvpsindto", curLineaComanda.valueBuffer("pvpsindto"));
		setValueBuffer("pvptotal", curLineaComanda.valueBuffer("pvptotal"));
		setValueBuffer("codimpuesto", curLineaComanda.valueBuffer("codimpuesto"));
		setValueBuffer("iva", curLineaComanda.valueBuffer("iva"));
		setValueBuffer("recargo", curLineaComanda.valueBuffer("recargo"));
		setValueBuffer("dtolineal", curLineaComanda.valueBuffer("dtolineal"));
		setValueBuffer("dtopor", curLineaComanda.valueBuffer("dtopor"));
	}
	/// Para la extensión de subcuenta de ventas por artículos
	var subctaVentas = flfacturac.iface.pub_subcuentaVentas(curLineaComanda.valueBuffer("referencia"));
	if (subctaVentas) {
		_i.curLineaFactura.setValueBuffer("codsubcuenta", subctaVentas.codsubcuenta);
		_i.curLineaFactura.setValueBuffer("idsubcuenta", subctaVentas.idsubcuenta);
	}
	return true;
}
/** \D Copia todas las lineas de la acomanda a la factura

@param idComanda identificador de la comanda
@param idFactura idfentificador de la factura
@return Boolean true si se han copiado todas las líneas correctamente y fasle si ha habido algún error
*/
function oficial_copiarLineas(idComanda: Number, idFactura: Number)
{
	var _i = this.iface;
	var curLineaComanda = new FLSqlCursor("tpv_lineascomanda");
	curLineaComanda.select("idtpv_comanda = " + idComanda);
	while (curLineaComanda.next()) {
		if (!_i.copiarLinea(idFactura, curLineaComanda))
			return false;
	}
	return true;
}

function oficial_soloCabeceraFactura(curComanda)
{
	return false;
}

/** \D Crea la factura a partir de una comanda
@param curComanda cursor de la comanda
@return False si ha habido algún error y el idFactura se se ha creado correctamente
*/
function oficial_crearFactura(curComanda)
{
	var _i = this.iface;
	var idFactura;

	if (!_i.curFactura) {
		_i.curFactura = new FLSqlCursor("facturascli");
	}
	_i.curFactura.setModeAccess(_i.curFactura.Insert);
	_i.curFactura.refreshBuffer();

	if (!_i.datosFactura(curComanda)) {
		return false;
	}
	if (!_i.curFactura.commitBuffer()) {
		return false;
	}
	idFactura = _i.curFactura.valueBuffer("idfactura");
	if (_i.soloCabeceraFactura(curComanda)) {
		return idFactura;
	}
	if (!_i.copiarLineas(curComanda.valueBuffer("idtpv_comanda"), idFactura)) {
		return false;
	}
	_i.curFactura.select("idfactura = " + idFactura);
	if (!_i.curFactura.first()) {
		return false;
	}
	if (!formRecordfacturascli.iface.pub_actualizarLineasIva(_i.curFactura)) {
		return false;
	}
	_i.curFactura.setModeAccess(_i.curFactura.Edit);
	_i.curFactura.refreshBuffer();

	if (!_i.totalesFactura(curComanda)) {
		return false;
	}
	if (!_i.curFactura.commitBuffer()) {
		return false;
	}
	return idFactura;
}

/** \D Crea la factura a partir de una comanda

@param curComanda cursor de la comanda
@param idFactura Número de la factura
@return False si ha habido algún error y el idFactura se se ha creado correctamente
*/
function oficial_modificarFactura(curComanda, idFactura)
{
	var _i = this.iface;

	if (!_i.borrarRecibosFactura(idFactura)) {
		return false;
	}
	if (!_i.curFactura) {
		_i.curFactura = new FLSqlCursor("facturascli");
	}
	_i.curFactura.select("idfactura = " + idFactura);
	if (!_i.curFactura.first()) {
		return false;
	}
	_i.curFactura.setModeAccess(_i.curFactura.Edit);
	_i.curFactura.refreshBuffer();

	if (!_i.borrarLineasFactura(idFactura)) {
		return false;
	}

	if (!_i.datosFactura(curComanda)) {
		return false;
	}
	var iC = _i.curFactura.valueBuffer("nogenerarasiento");
	if (_i.soloCabeceraFactura(curComanda)) {
		if (!_i.curFactura.commitBuffer()) {
			return false;
		}
		return idFactura;
	} else {
		_i.curFactura.setValueBuffer("nogenerarasiento", true); /// Evita generar el asiento con la factura sin terminar
		if (!_i.curFactura.commitBuffer()) {
			return false;
		}
	}

	if (!_i.copiarLineas(curComanda.valueBuffer("idtpv_comanda"), idFactura)) {
		return false;
	}
	_i.curFactura.select("idfactura = " + idFactura);
	if (!_i.curFactura.first()) {
		return false;
	}
	if (!formRecordfacturascli.iface.pub_actualizarLineasIva(_i.curFactura)) {
		return false;
	}
	_i.curFactura.setModeAccess(_i.curFactura.Edit);
	_i.curFactura.refreshBuffer();
	_i.curFactura.setValueBuffer("nogenerarasiento", iC);
	if (!_i.totalesFactura(curComanda)) {
		return false;
	}
	if (!_i.curFactura.commitBuffer()) {
		return false;
	}
	return idFactura;
}

/** \D Calcula los datos de totale de la factura
@return true el cálculo se realiza correcamente, false en caso contrario
\end */
function oficial_totalesFactura(curComanda: FLSqlCursor)
{
	var _i = this.iface;

	with(_i.curFactura) {
		setValueBuffer("neto", formfacturascli.iface.pub_commonCalculateField("neto", this));
		setValueBuffer("totaliva", formfacturascli.iface.pub_commonCalculateField("totaliva", this));
		setValueBuffer("totalrecargo", formfacturascli.iface.pub_commonCalculateField("totalrecargo", this));
		setValueBuffer("totalirpf", formfacturascli.iface.pub_commonCalculateField("totalirpf", this));
		setValueBuffer("totalrecargo", formfacturascli.iface.pub_commonCalculateField("totalrecargo", this));
		setValueBuffer("total", formfacturascli.iface.pub_commonCalculateField("total", this));
		setValueBuffer("totaleuros", formfacturascli.iface.pub_commonCalculateField("totaleuros", this));
		setValueBuffer("codigo", formfacturascli.iface.pub_commonCalculateField("codigo", this));
	}
	return true;
}

/** \D Establece los datos de la factura a partir del registro de ventas
@param  curComanda: Cursor posicionado en el registro de ventas
@return true si la copia de datos es correcta, false en caso contrario
\end */
function oficial_datosFactura(curComanda)
{
	var _i = this.iface;

	var codAlmacen = AQUtil.sqlSelect("tpv_puntosventa", "codalmacen", "codtpv_puntoventa = '" + curComanda.valueBuffer("codtpv_puntoventa") + "'");
	if (!codAlmacen || codAlmacen == "")
		codAlmacen = flfactppal.iface.pub_valorDefectoEmpresa("codalmacen");

	var codCliente = curComanda.valueBuffer("codcliente");
	var nomCliente = curComanda.valueBuffer("nombrecliente");
	var cifCliente = curComanda.valueBuffer("cifnif");
	var direccion = curComanda.valueBuffer("direccion");

	if (!nomCliente || nomCliente == "") {
		nomCliente = "-";
	}
	if (!cifCliente || cifCliente == "") {
		cifCliente = "-";
	}
	if (!direccion || direccion == "") {
		direccion = "-";
	}

	var serieCliente = _i.obtenerSerieFactura(curComanda);

	var codPago = AQUtil.sqlSelect("tpv_pagoscomanda", "codpago", "idtpv_comanda = " + curComanda.valueBuffer("idtpv_comanda") + " ORDER BY importe DESC");
	if (!codPago) {
		codPago = curComanda.valueBuffer("codpago");
	}

	with(_i.curFactura) {
		if (codCliente && codCliente != "") {
			setValueBuffer("codcliente", codCliente);
		}
		setValueBuffer("nombrecliente", nomCliente);
		setValueBuffer("cifnif", cifCliente);
		setValueBuffer("direccion", direccion);
		if (curComanda.valueBuffer("coddir") != 0) {
			setValueBuffer("coddir", curComanda.valueBuffer("coddir"));
		}
		setValueBuffer("codpostal", curComanda.valueBuffer("codpostal"));
		setValueBuffer("ciudad", curComanda.valueBuffer("ciudad"));
		setValueBuffer("provincia", curComanda.valueBuffer("provincia"));
		setValueBuffer("codpais", curComanda.valueBuffer("codpais"));
		setValueBuffer("fecha", curComanda.valueBuffer("fecha"));
		setValueBuffer("hora", curComanda.valueBuffer("hora"));
		setValueBuffer("codejercicio", _i.dameEjercicioFactura(curComanda));
		setValueBuffer("coddivisa", _i.dameDivisaFactura(curComanda));
		setValueBuffer("codpago", codPago);
		setValueBuffer("codalmacen", codAlmacen);
		setValueBuffer("codserie", serieCliente);
		setValueBuffer("tasaconv", AQUtil.sqlSelect("divisas", "tasaconv", "coddivisa = '" + flfactppal.iface.pub_valorDefectoEmpresa("coddivisa") + "'"));
		setValueBuffer("automatica", true);
		setValueBuffer("tpv", true);
	}
	return true;
}

function oficial_dameDivisaFactura(curComanda)
{
	return flfactppal.iface.pub_valorDefectoEmpresa("coddivisa");
}

function oficial_dameEjercicioFactura(curComanda)
{
	return flfactppal.iface.pub_ejercicioActual();
}

function oficial_obtenerSerieFactura(curComanda)
{
	var _i = this.iface;

	var codSerie = _i.valorDefectoTPV("codserie");
	if (!codSerie) {
		var codCliente = curComanda.valueBuffer("codcliente");
		var serieCliente = "";
		if (codCliente && codCliente != "") {
			serieCliente = AQUtil.sqlSelect("clientes", "codserie", "codcliente = '" + codCliente + "'");
		}

		if (!serieCliente || serieCliente == "") {
			serieCliente = flfactppal.iface.pub_valorDefectoEmpresa("codserie");
		}
		codSerie = serieCliente;
	}
	return codSerie;
}

/** \D
Crea una nueva forma de pago y establece los valores del formulario Datos Genenrales
*/
function oficial_valoresIniciales()
{
	var _i = this.iface;
	var cursor;

	var fP = [["CONT", "CONTADO"], ["TARJ", "TARJETA"], ["VALE", "VALES"]];
	for (var i = 0; i < fP.length; i++) {
		var formaPago = AQUtil.sqlSelect("formaspago","codpago","codpago = '" + fP[i][0] + "'");

		if (!formaPago || formaPago == ""){
			cursor = new FLSqlCursor("formaspago");
			with(cursor) {
				setModeAccess(cursor.Insert);
				refreshBuffer();
				setValueBuffer("codpago", fP[i][0]);
				setValueBuffer("descripcion",fP[i][1]);
				setValueBuffer("genrecibos", "Pagados");
				commitBuffer();
			}
			delete cursor;

			cursor = new FLSqlCursor("plazos");
			with(cursor) {
				setModeAccess(cursor.Insert);
				refreshBuffer();
				setValueBuffer("codpago", fP[i][0]);
				setValueBuffer("dias", "0");
				setValueBuffer("aplazado", "100");
				commitBuffer();
			}
			delete cursor;
		}
	}

	cursor = new FLSqlCursor("tpv_datosgenerales");
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("tarifa", "");
		setValueBuffer("pagoefectivo", "CONT");
		setValueBuffer("pagotarjeta", "TARJ");
		setValueBuffer("pagovale", "VALE");
		commitBuffer();
	}
}

/** \D Borra la factura especificada, eliminando sus pagos si existen
@param  idFactura: Identificador de la factura a borrar
@return true si la factura se borra correctamente, false en caso contrario
\end */
function oficial_borrarFactura(idFactura: String)
{
	var _i = this.iface;

	if (!_i.borrarRecibosFactura(idFactura)) {
		return false;
	}

	if (!AQUtil.sqlDelete("facturascli", "idfactura = " + idFactura)) {
		return false;
	}

	return true;
}

function oficial_borrarRecibosFactura(idFactura: String)
{
	var _i = this.iface;
	if (sys.isLoadedModule("flfactteso")) {
		var qryRecibos = new FLSqlQuery();
		qryRecibos.setTablesList("reciboscli,pagosdevolcli");
		qryRecibos.setSelect("idpagodevol");
		qryRecibos.setFrom("reciboscli r INNER JOIN pagosdevolcli p ON r.idrecibo = p.idrecibo");
		qryRecibos.setWhere("r.idfactura = " + idFactura + " ORDER BY p.idrecibo, p.fecha DESC, p.idpagodevol DESC");
		try {
			qryRecibos.setForwardOnly(true);
		} catch (e) {}
		if (!qryRecibos.exec()) {
			return false;
		}
		var curPagos = new FLSqlCursor("pagosdevolcli");
		while (qryRecibos.next()) {
			curPagos.select("idpagodevol = " + qryRecibos.value("idpagodevol"));
			if (!curPagos.first()) {
				return false;
			}
			curPagos.setModeAccess(curPagos.Del);
			if (!curPagos.refreshBuffer()) {
				return false;;
			}
			if (!curPagos.commitBuffer()) {
				return false;
			}
		}

		var curRecibos = new FLSqlCursor("reciboscli");
		curRecibos.select("idfactura = " + idFactura);
		while (curRecibos.next()) {
			curRecibos.setModeAccess(curRecibos.Del);
			curRecibos.refreshBuffer();
			if (!curRecibos.commitBuffer()) {
				return false;
			}
		}
	}
	return true;
}

/** \C Genera un recibo pagado por cada pago asociada a la comanda
@param  curComanda: cursor posiciondado en la comanda
@return true si la generación se realiza correctamente, false en caso contrario
\end */
function oficial_generarRecibos(curComanda)
{
	var _i = this.iface;

	if (!sys.isLoadedModule("flfactteso")) {
		return true;
	}

	var AQUtil= new FLUtil;

	var idFactura = curComanda.valueBuffer("idfactura");
	var qryFactura = new FLSqlQuery();
	qryFactura.setTablesList("facturascli");
	qryFactura.setSelect("idfactura, coddivisa, codigo, codcliente, nombrecliente, cifnif, coddir, direccion, codpostal, ciudad, provincia, codpais, tasaconv, codejercicio");
	qryFactura.setFrom("facturascli");
	qryFactura.setWhere("idfactura = " + idFactura);
	try {
		qryFactura.setForwardOnly( true );
	} catch (e) {
		debug("error: " + e);
	}

	if (!qryFactura.exec()){
		return false;
	}
	if (!qryFactura.first()){
		return false;
	}

	var datosRecibo = _i.generarReciboPagados(qryFactura, curComanda);

	if(!datosRecibo){
		return false;
	}

	if(!_i.generarReciboPendiente(qryFactura, datosRecibo, curComanda)){
		return false;
	}
	return true;
}

function oficial_generarReciboPagados(qryFactura, curComanda)
{
	var _i = this.iface;

	var curPagos= new FLSqlCursor("tpv_pagoscomanda");
	var curPago= new FLSqlCursor("tpv_pagoscomanda");
	curPago.setActivatedCommitActions(false);

	curPagos.select("idtpv_comanda = " + curComanda.valueBuffer("idtpv_comanda") + " AND estado = '" + sys.translate("Pagado") + "'");

	var _i = this.iface;
	var datosRecibo = _i.dameDatosRecibo(curComanda);

	datosRecibo.numRecibo = 1;
	datosRecibo.estado = "Pagado";
	datosRecibo.totalPagado = 0;

	var idRecibo;
	var importe;
	var esEditable;
	while (curPagos.next()) {
		curPagos.setModeAccess(curPagos.Browse);
		curPagos.refreshBuffer();
		curPago.select("idpago = " + curPagos.valueBuffer("idpago"));
		if (!curPago.first()) {
			return false;
		}
		esEditable = curPago.valueBuffer("editable");
		if (!esEditable) {
			curPago.setUnLock("editable", true);
			curPago.select("idpago = " + curPagos.valueBuffer("idpago"));
			if (!curPago.first()) {
				return false;
			}
		}
		curPago.setModeAccess(curPago.Edit);
		curPago.refreshBuffer();

		datosRecibo.importe = parseFloat(curPago.valueBuffer("importe"));
		datosRecibo.fecha = curPago.valueBuffer("fecha");
		datosRecibo.codPago = curPago.valueBuffer("codpago");
		datosRecibo.curPago = curPago;

		idRecibo = _i.generarRecibo(qryFactura, datosRecibo, curComanda);
		if (!idRecibo) {
			return false;
		}
		datosRecibo.numRecibo++;
		datosRecibo.totalPagado += datosRecibo.importe;

		curPago.setValueBuffer("idrecibo", idRecibo);
		if (!curPago.commitBuffer()) {
			return false;
		}
		if (!esEditable) {
			curPago.select("idpago = " + curPagos.valueBuffer("idpago"));
			if (!curPago.first()) {
				return false;
			}
			curPago.setUnLock("editable", false);
		}
	}

	return datosRecibo;
}

function oficial_generarReciboPendiente(qryFactura, datosRecibo, curComanda)
{
	var _i = this.iface;

	datosRecibo.importe = parseFloat(curComanda.valueBuffer("total")) - parseFloat(datosRecibo.totalPagado);
	if (datosRecibo.importe > 0) {
		datosRecibo.estado = "Emitido";
		datosRecibo.fecha = curComanda.valueBuffer("fecha");
		datosRecibo.curPago = false;
		datosRecibo.codPago = flfactppal.iface.pub_valorDefectoEmpresa("codpago");

		var idRecibo = _i.generarRecibo(qryFactura, datosRecibo, curComanda);
		if (!idRecibo) {
			return false;
		}
	}

	return true;
}

function oficial_dameDatosRecibo(curComanda)
{
	var _i = this.iface;
	var datosRecibo = new Object;

	var idFactura = curComanda.valueBuffer("idfactura");
	datosRecibo.moneda = AQUtil.sqlSelect("facturascli f INNER JOIN divisas d ON f.coddivisa = d.coddivisa", "d.descripcion", "f.idfactura = " + idFactura, "facturascli,divisas");
	return datosRecibo;
}

/** \C Genera un recibo más un pago asociado al pago de la comanda
@param  qryFactura: consulta que contiene los datos de la factura
@param  datosRecibo: Array con los siguientes datos relativos al recibo:
	importe
	número
	fecha
	moneda
	estado
@return identificador del recibo, o false si hay error
\end */
function oficial_generarRecibo(qryFactura, datosRecibo, curComanda)
{
	var _i = this.iface;

	var curRecibo = new FLSqlCursor("reciboscli");
	with(curRecibo) {
		setModeAccess(Insert);
		refreshBuffer()
				setValueBuffer("numero", datosRecibo.numRecibo);
		setValueBuffer("idfactura", qryFactura.value("idfactura"));
		setValueBuffer("importe", datosRecibo.importe);
		setValueBuffer("importeeuros", datosRecibo.importe * parseFloat(qryFactura.value("tasaconv")));
		setValueBuffer("coddivisa", qryFactura.value("coddivisa"));
		setValueBuffer("codigo", qryFactura.value("codigo") + "-" + flfacturac.iface.pub_cerosIzquierda(datosRecibo.numRecibo, 2));
		setValueBuffer("codcliente", qryFactura.value("codcliente"));
		setValueBuffer("nombrecliente", qryFactura.value("nombrecliente"));
		setValueBuffer("cifnif", qryFactura.value("cifnif"));
		if (qryFactura.value("coddir"))
			setValueBuffer("coddir", qryFactura.value("coddir"));
		else
			setNull("coddir");
		setValueBuffer("direccion", qryFactura.value("direccion"));
		setValueBuffer("codpostal", qryFactura.value("codpostal"));
		setValueBuffer("ciudad", qryFactura.value("ciudad"));
		setValueBuffer("provincia", qryFactura.value("provincia"));
		setValueBuffer("codpais", qryFactura.value("codpais"));
		setValueBuffer("fecha", datosRecibo.fecha);
		setValueBuffer("fechav", datosRecibo.fecha);
		setValueBuffer("estado", datosRecibo.estado);
		setValueBuffer("codpago", datosRecibo.codPago);
		setValueBuffer("texto", AQUtil.enLetraMoneda(datosRecibo.importe, datosRecibo.moneda));
	}
	if (!curRecibo.commitBuffer())
		return false;

	var idRecibo = curRecibo.valueBuffer("idrecibo");
	if (datosRecibo.estado == sys.translate("Pagado")) {
		if (!_i.pagarRecibo(idRecibo, datosRecibo, curComanda))
			return false;
	}

	return idRecibo;
}

/** \C
Crea un registro de pago en tesorería asociado al recibo especificado
@param  idRecibo: Identificador del recibo a pagar
@param  datpsRecibo: Array con los datos del recibo
@return true si el pago se crea correctamente, false en caso contrario
\end */
function oficial_pagarRecibo(idRecibo, datosRecibo, curComanda)
{
	var _i = this.iface;

	var hayContabilidad = (sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada"));
	var ejercicioActual = flfactppal.iface.pub_ejercicioActual();

	var idSubcuenta = "";
	var codSubcuenta = "";
	var cuenta = "";
	var entidad = "";
	var agencia = "";

	var curPago = datosRecibo.curPago;
	if (!curPago.isNull("idasiento")) { /// Pago a cuenta
		if (hayContabilidad) {
			codSubcuenta = AQUtil.sqlSelect("co_partidas", "codsubcuenta", "idasiento = " + curPago.valueBuffer("idasiento") + " AND haber <> 0");
			if (!codSubcuenta) {
				MessageBox.warning(sys.translate("Error al obtener la subcuenta de pago a cuenta (anticipo) correspondiente al pago a cuenta de la comanda"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
				return false;
			}
		}
	} else {
		if (datosRecibo.codPago == flfact_tpv.iface.pub_valorDefectoTPV("pagoefectivo")) { /// Pago por caja
			if (hayContabilidad) {
				var datosSubcuenta = _i.subcuentaDefecto("CAJA", ejercicioActual, curComanda);
				if (datosSubcuenta["error"] != 0) {
					MessageBox.warning(sys.translate("Error al obtener la subcuenta de caja"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
					return false;
				}
				codSubcuenta = datosSubcuenta.codsubcuenta;
				idSubcuenta = datosSubcuenta.idsubcuenta;
			}
		}
		else if (datosRecibo.codPago == flfact_tpv.iface.pub_valorDefectoTPV("pagovale")) { /// Pago por vale
			if (hayContabilidad) {
				var datosSubcuenta = _i.subcuentaDefecto("VALE", ejercicioActual, curComanda);
				if (datosSubcuenta["error"] != 0) {
					MessageBox.warning(sys.translate("Error al obtener la subcuenta de vale"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
					return false;
				}
				codSubcuenta = datosSubcuenta.codsubcuenta;
				idSubcuenta = datosSubcuenta.idsubcuenta;
			}
		}
		else if (datosRecibo.codPago == flfact_tpv.iface.pub_valorDefectoTPV("pagotarjeta")) { /// Pago con tarjeta
			if (hayContabilidad) {
				var datosSubcuenta = _i.subcuentaDefecto("TARJETA", ejercicioActual, curComanda);
				if (datosSubcuenta["error"] != 0) {
					MessageBox.warning(sys.translate("Error al obtener la subcuenta de tarjeta"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
					return false;
				}
				codSubcuenta = datosSubcuenta.codsubcuenta;
				idSubcuenta = datosSubcuenta.idsubcuenta;
			}
		} else { /// Para el resto de pagos que no estén sacará la cuenta por defecto
			var qryCuenta = new FLSqlQuery;
			qryCuenta.setTablesList("formaspago,cuentasbanco");
			qryCuenta.setSelect("cuenta,ctaentidad,ctaagencia,codsubcuenta");
			qryCuenta.setFrom("formaspago f INNER JOIN cuentasbanco c ON f.codcuenta = c.codcuenta")
			qryCuenta.setWhere("f.codpago = '" + datosRecibo.codPago + "'")
			qryCuenta.setForwardOnly(true);

			if (!qryCuenta.exec()) {
				return false;
			}
			if (qryCuenta.first()) {
				cuenta = qryCuenta.value("cuenta");
				entidad = qryCuenta.value("ctaentidad");
				agencia = qryCuenta.value("ctaagencia");
				codSubcuenta = qryCuenta.value("codsubcuenta");
			}
		}
	}

	if (hayContabilidad && !(codSubcuenta && codSubcuenta != "")) {
		MessageBox.warning(sys.translate("Error al obtener la subcuenta asociada al pago"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
		return false;
	}

	var curPagoDevol = new FLSqlCursor("pagosdevolcli");
	with(curPagoDevol) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("idrecibo", idRecibo);
		setValueBuffer("fecha", datosRecibo.fecha);
		setValueBuffer("tipo", "Pago");
		setValueBuffer("cuenta", cuenta);
		setValueBuffer("ctaagencia", agencia);
		setValueBuffer("ctaentidad", entidad);
		if (hayContabilidad) {/// Solo se guarda el código, el id se calcula en el momento de hacer el asiento contable
			//setValueBuffer("idsubcuenta", idSubcuenta);
			setValueBuffer("codsubcuenta", codSubcuenta);
		} else {
			//setNull("idsubcuenta");
			setNull("codsubcuenta");
		}
		setValueBuffer("tpv", true);
	}
	if (!curPagoDevol.commitBuffer()) {
		return false;
	}
	return true;
}

/** \D Envia una cadena de caracteres a la impresora
@param  datos: Cadena de caracteres
@param  maxLon: Número de caracteres máximo a enviar. Si este valor no está informado se envia toda la cadena.
\end */
function oficial_imprimirDatos(datos: String, maxLon: Number, alineacion: Number)
{
	var _i = this.iface;

	// Si hay códigos de escape por imprimir, se imprimen antes de enviar los datos
	if (_i.printerESC != "ESC:") {
		_i.printer.send(_i.printerESC);
		_i.printerESC = "ESC:";
	}
	if (!datos)
		datos = "";
	else
		datos = datos.toString();

	if (maxLon && maxLon != 0) {
		datos = datos.left(maxLon);
		if (datos.length < maxLon) {
			if (alineacion == 2)
				datos = _i.espaciosIzquierda(datos, maxLon);
			else
				datos = flfactppal.iface.pub_espaciosDerecha(datos, maxLon);
		}
	}

	_i.printer.send(datos);
	_i.printerXPos += datos.length;

	_i.textoPrinter += datos;
}

function oficial_espaciosIzquierda(texto: String, totalLongitud: Number)
{
	var _i = this.iface;

	var ret = "";
	var numEspacios = totalLongitud - texto.toString().length;
	for (; numEspacios > 0 ; --numEspacios)
		ret += " ";
	ret += texto.toString();
	return ret;
}

function oficial_impNuevaLinea(numLineas: Number)
{
	var _i = this.iface;

	if (!numLineas)
		numLineas = 1;

	if (numLineas == 1) {
		_i.printerESC += "0A";
		_i.printer.send(_i.printerESC);
	} else {
		_i.printerESC += "1B,64," + flfactppal.iface.pub_cerosIzquierda(numLineas, 2);
		_i.printer.send(_i.printerESC);
	}
	_i.printerESC = "ESC:";
	_i.printerXPos = 1;
	_i.printerYPos += numLineas;

	for (var i = 0; i < numLineas; i++)
		_i.textoPrinter += "\n";
}

function oficial_impLogo()
{
  var _i = this.iface;
  if (!_i.oImpresoraPV_) {
    return;
  }
  var escLogo = _i.oImpresoraPV_.esclogo;
  if (!escLogo || escLogo == "") {
    return;
  }
  _i.printer.send("ESC:" + escLogo);
}

function oficial_impFont(font)
{
	var _i = this.iface;

	if (font)
		_i.printerESC += "1B,4D,01,";
	else
		_i.printerESC += "1B,4D,00,";
}

function oficial_impSimboloEuro()
{
	var _i = this.iface;
	_i.printerESC += "1B,74,13,D5,";
	_i.printerESC += "1B,74,19,";
}

function oficial_impCortar()
{
	var _i = this.iface;
	if (!_i.oImpresoraPV_) {
		return;
	}
	var escCortar = _i.oImpresoraPV_.esccortarpapel;
	if (!escCortar || escCortar == "") {
		escCortar = "1B,6D";
	}
	_i.printer.send("ESC:" + escCortar);
}


function oficial_impBarcode(barcode)
{
  var _i = this.iface;
  if (!_i.oImpresoraPV_) {
    return;
  }
  var escBarcode = _i.oImpresoraPV_.escbarcode;
  if (!escBarcode || escBarcode == "") {
    return;
  }
  var hexBarcode = _i.dameString2Hex(barcode);
  if (!hexBarcode || hexBarcode == "") {
    return;
  }
  _i.printer.send("ESC:" + escBarcode + "," + hexBarcode);
}

/** \D Activa o desactiva el resaltado de letra
@param  alineación: Posibles valores:
	0. Alinear a la izquieda
	1. Centrar
	2. Alinear a la derecha
\end */
function oficial_impAlinearH(alineacion: Number)
{
	var _i = this.iface;

	var tipo = "00";
	switch (alineacion) {
	case 0: {
			tipo = "00";
			break;
		}
	case 1: {
			tipo = "01";
			break;
		}
	case 2: {
			tipo = "02";
			break;
		}
	}
	_i.printerESC += "0D,1B,61," + tipo + ",";
}

/** \D Activa o desactiva el resaltado de letra
@param  resaltar: Indica si hay que activar o desactivar el resaltado
\end */
function oficial_impResaltar(resaltar: Boolean)
{
	var _i = this.iface;

	if (resaltar)
		_i.printerESC += "1B,45,01,";
	else
		_i.printerESC += "1B,45,00,";
}

/** \D Selecciona el tamaño de letra
@param  tamLetra: Posibles valores:
	0. Normal
	1. Mediano
	2. Grande
\end */
function oficial_impTamLetra(tamLetra)
{
	var _i = this.iface;

	var sizeCode = "00";
	switch (tamLetra) {
		case 0: {
			sizeCode = "00";
			break;
		}
		case 1: {
			sizeCode = "11";
			break;
		}
		case 2: {
			sizeCode = "22";
			break;
		}
	}
	_i.printerESC += "1D,21," + sizeCode + ",";
}

/** \D Activa o desactiva el subrayado de letra
@param  resaltar: Indica si hay que activar o desactivar el subrayado
\end */
function oficial_impSubrayar(subrayar: Boolean)
{
	var _i = this.iface;

	if (subrayar)
		_i.printerESC += "1B,2D,01,";
	else
		_i.printerESC += "1B,2D,00,";
}

function oficial_flushImpresora()
{
	var _i = this.iface;

	debug(_i.textoPrinter);
	_i.textoPrinter = "";

	if (_i.printerESC != "ESC:") {
		_i.printer.send(_i.printerESC);
		_i.printerESC = "ESC:";
	}
	_i.printer.flush();
}

function oficial_establecerImpresora(impresora)
{
	var _i = this.iface;
	if (!impresora && _i.printer) {
		/// Se usa para destruir y volver a construir el objeto al inicio de cada informe, para evitar que se llene el buffer.
		impresora = _i.printer.printerName();
	}
	if (!impresora && _i.oImpresoraPV_) {
		impresora = _i.oImpresoraPV_["nombre"];
	}
	if (_i.printer){
		_i.printer.cleanup();
	}
	_i.printer = new FLPosPrinter();
	_i.printer.setPrinterName(impresora);
	_i.printerXPos = 1;
	_i.printerYPos = 1;
	_i.printerESC = "ESC:1B,74,19,";
	_i.impAlinearH(0);
	_i.impResaltar(false);
}

/** \U Genera o regenera el asiento correspondiente a un arqueo de TPV
@param  curArqueo: Cursor con los datos del arqueo
@return VERDADERO si no hay error. FALSO en otro caso
\end */
function oficial_generarAsientoArqueo(curArqueo)
{
	var _i = this.iface;

	if (curArqueo.modeAccess() != curArqueo.Edit) {
		return true;
	}

	if (curArqueo.valueBuffer("nogenerarasiento")) {
		curArqueo.setNull("idasiento");
		return true;
	}

	if (!_i.comprobarRegularizacion(curArqueo)) {
		return false;
	}

	var datosAsiento = [];
	var valoresDefecto: Array;
	valoresDefecto["codejercicio"] = flfactppal.iface.pub_ejercicioActual();
	valoresDefecto["coddivisa"] = flfactppal.iface.pub_valorDefectoEmpresa("coddivisa");

	datosAsiento = _i.regenerarAsiento(curArqueo, valoresDefecto);
	if (datosAsiento.error == true) {
		return false;
	}

	if (!_i.generarPartidasArqueo(curArqueo, datosAsiento, valoresDefecto)) {
		return false;
	}

	if (!flcontppal.iface.pub_comprobarAsiento(datosAsiento.idasiento)) {
		return false;
	}

	if (!AQUtil.sqlSelect("co_partidas", "idpartida", "idasiento = " + datosAsiento.idasiento)) {
		if (!_i.pub_borrarAsientoArqueo(curArqueo, datosAsiento.idasiento)) {
			return false;
		}
	} else {
		curArqueo.setValueBuffer("idasiento", datosAsiento.idasiento);
	}
	return true;
}

function oficial_generarPartidasArqueo(curArqueo, datosAsiento, valoresDefecto)
{
	var _i = this.iface;

	if (!_i.generarPartidasMovi(curArqueo, datosAsiento.idasiento, valoresDefecto)) {
		return false;
	}

	if (!_i.generarPartidasMoviCierre(curArqueo, datosAsiento.idasiento, valoresDefecto)) {
		return false;
	}

	if (!_i.generarPartidasDif(curArqueo, datosAsiento.idasiento, valoresDefecto)) {
		return false;
	}
	return true;
}

/** \D Comprueba que si la factura tiene IVA, no esté incluida en un período de regularización ya cerrado
@param  curFactura: Cursor de la factura de cliente o proveedor
@return TRUE si la factura no tiene IVA o teniéndolo su fecha no está incluida en ningún período ya cerrado. FALSE en caso contrario
\end */
function oficial_comprobarRegularizacion(curArqueo: FLSqlCursor)
{
	var _i = this.iface;

	var fecha = curArqueo.valueBuffer("diahasta");
	var codEjercicio = flfactppal.iface.pub_ejercicioActual();
	if (AQUtil.sqlSelect("co_regiva", "idregiva", "fechainicio <= '" + fecha + "' AND fechafin >= '" + fecha + "' AND codejercicio = '" + codEjercicio + "'")) {
		MessageBox.warning(sys.translate("No puede incluirse el asiento de la factura en un período de I.V.A. ya regularizado"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	return true;
}

/** \D Genera o regenera el registro en la tabla de asientos correspondiente a la factura. Si el asiento ya estaba creado borra sus partidas asociadas.
@param  curArqueo: Cursor posicionado en el registro de arqueo
@param  valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@return array con los siguientes datos:
asiento.idasiento: Id del asiento
asiento.numero: numero del asiento
asiento.fecha: fecha del asiento
asiento.error: indicador booleano de que ha habido un error en la función
\end */
function oficial_regenerarAsiento(curArqueo: FLSqlCursor, valoresDefecto: Array)
{
	var _i = this.iface;
	var asiento = [];
	var idAsiento = curArqueo.valueBuffer("idasiento");
	if (curArqueo.isNull("idasiento") || curArqueo.valueBuffer("idasiento") == 0) {
		var curAsiento = new FLSqlCursor("co_asientos");
		with(curAsiento) {
			setModeAccess(curAsiento.Insert);
			refreshBuffer();
			setValueBuffer("numero", 0);
			setValueBuffer("fecha", curArqueo.valueBuffer("diahasta"));
			setValueBuffer("codejercicio", valoresDefecto.codejercicio);
		}
		if (!curAsiento.commitBuffer()) {
			asiento.error = true;
			return asiento;
		}
		asiento.idasiento = curAsiento.valueBuffer("idasiento");
		asiento.numero = curAsiento.valueBuffer("numero");
		asiento.fecha = curAsiento.valueBuffer("fecha");
		curAsiento.select("idasiento = " + asiento.idasiento);
		curAsiento.first();
		curAsiento.setUnLock("editable", false);
	} else {
		if (!flfacturac.iface.pub_asientoBorrable(idAsiento)) {
			asiento.error = true;
			return asiento;
		}

		var curAsiento = new FLSqlCursor("co_asientos");
		curAsiento.select("idasiento = " + idAsiento);
		if (!curAsiento.first()) {
			asiento.error = true;
			return asiento;
		}
		curAsiento.setUnLock("editable", true);

		curAsiento.select("idasiento = " + idAsiento);
		if (!curAsiento.first()) {
			asiento.error = true;
			return asiento;
		}
		curAsiento.setModeAccess(curAsiento.Edit);
		curAsiento.refreshBuffer();
		curAsiento.setValueBuffer("fecha", curArqueo.valueBuffer("diahasta"));

		if (!curAsiento.commitBuffer()) {
			asiento.error = true;
			return asiento;
		}
		curAsiento.select("idasiento = " + idAsiento);
		if (!curAsiento.first()) {
			asiento.error = true;
			return asiento;
		}
		curAsiento.setUnLock("editable", false);

		asiento = flfactppal.iface.pub_ejecutarQry("co_asientos", "idasiento,numero,fecha,codejercicio", "idasiento = '" + idAsiento + "'");
		if (asiento.codejercicio != valoresDefecto.codejercicio) {
			MessageBox.warning(sys.translate("Está intentando regenerar un asiento del ejercicio %1 en el ejercicio %2.\nVerifique que su ejercicio actual es correcto. Si lo es y está actualizando un pago, bórrelo y vuélvalo a crear.").arg(asiento.codejercicio).arg(valoresDefecto.codejercicio), MessageBox.Ok, MessageBox.NoButton);
			asiento.error = true;
			return asiento;
		}
		var curPartidas = new FLSqlCursor("co_partidas");
		curPartidas.select("idasiento = " + idAsiento);
		while (curPartidas.next()) {
			curPartidas.setModeAccess(curPartidas.Del);
			curPartidas.refreshBuffer();
			if (!curPartidas.commitBuffer()) {
				asiento.error = true;
				return asiento;
			}
		}
	}

	asiento.error = false;
	return asiento;
}

/** \D Borra el registro en la tabla de asientos correspondiente a un arqueo de ventas.
@param  curArqueo: Cursor posicionado en el registro de arqueo
@param  valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@return True si el asiento se borra correctamente o no existe, false en caso contrario
\end */
function oficial_borrarAsientoArqueo(curArqueo: FLSqlCursor, idAsiento: String)
{
	var _i = this.iface;

	if (!flfacturac.iface.pub_asientoBorrable(idAsiento)) {
		return false;
	}

	var curAsiento = new FLSqlCursor("co_asientos");
	curAsiento.select("idasiento = " + idAsiento);
	if (!curAsiento.first()) {
		return false;
	}
	curAsiento.setUnLock("editable", true);

	//  curAsiento.select("idasiento = " + idAsiento);
	//  if (!curArqueo.first()) {
	//    return false;
	//  }
	//  curArqueo.setModeAccess(curArqueo.Edit);
	//  curArqueo.refreshBuffer();
	//  curArqueo.setNull("idasiento");
	//  if (!curArqueo.commitBuffer()) {
	//    return false;
	//  }

	if (!AQUtil.sqlDelete("co_asientos", "idasiento = " + idAsiento)) {
		return false;
	}

	return true;
}

/** \D Genera la parte del asiento de arqueo correspondiente a las subcuentas de clientes
@param  curArqueo: Cursor del arqueo
@param  idAsiento: Id del asiento asociado
@param  valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@return VERDADERO si no hay error, FALSO en otro caso
\end */
/*
function oficial_generarPartidasCliente(curArqueo:FLSqlCursor, idAsiento, valoresDefecto:Array)
{
	var AQUtil= new FLUtil();

	var qrySubcuentas= new FLSqlQuery;
	with (qrySubcuentas) {
		setTablesList("");
		setSelect("c.codcliente, SUM(p.importe)");
		setFrom("tpv_pagoscomanda p INNER JOIN tpv_comandas c ON p.idtpv_comanda = c.idtpv_comanda");
		setWhere("p.idtpv_arqueo = '" + curArqueo.valueBuffer("idtpv_arqueo") + "' AND c.idfactura IS NULL GROUP BY c.codcliente");
		setForwardOnly(true);
	}
	if (!qrySubcuentas.exec())
		return false;

	var ctaCliente= [];
	var codCliente;
	var debe= 0;
	var debeME= 0;

	while (qrySubcuentas.next()) {
		codCliente = qrySubcuentas.value("c.codcliente");
		if (codCliente && codCliente != "") {
			ctaCliente = flfactppal.iface.pub_datosCtaCliente( codCliente, valoresDefecto );
			if (ctaCliente.error != 0) {
				MessageBox.warning(sys.translate("Error al obtener los datos de la subcuenta asociada al cliente %1").arg(codCliente), MessageBox.Ok, MessageBox.NoButton);
				return false;
			}
		} else {
			ctaCliente = flfacturac.iface.pub_datosCtaEspecial("CLIENT", valoresDefecto.codejercicio);
			if (ctaCliente.error != 0) {
				MessageBox.warning(sys.translate("Error al obtener los datos de la subcuenta genérica de clientes. Asegúrese de que en el módulo de contabilidad tiene una cuenta o subcuenta asociada a la cuenta especial CLIENT"), MessageBox.Ok, MessageBox.NoButton);
				return false;
			}
		}
		debe = qrySubcuentas.value("SUM(p.importe)");
		debeME = 0;
		debe = AQUtil.roundFieldValue(debe, "co_partidas", "debe");

		var curPartida= new FLSqlCursor("co_partidas");
		with (curPartida) {
			setModeAccess(curPartida.Insert);
			refreshBuffer();
			setValueBuffer("idsubcuenta", ctaCliente.idsubcuenta);
			setValueBuffer("codsubcuenta", ctaCliente.codsubcuenta);
			setValueBuffer("idasiento", idAsiento);
			setValueBuffer("debe", debe);
			setValueBuffer("haber", 0);
			setValueBuffer("coddivisa", valoresDefecto.coddivisa);
			setValueBuffer("tasaconv", 1);
			setValueBuffer("debeME", debeME);
			setValueBuffer("haberME", 0);
		}

		curPartida.setValueBuffer("concepto", _i.conceptoPartida(curArqueo, sys.translate("Cliente %1").arg(codCliente)));

		if (!curPartida.commitBuffer())
			return false;

		with (curPartida) {
			setModeAccess(curPartida.Insert);
			refreshBuffer();
			setValueBuffer("idsubcuenta", ctaCliente.idsubcuenta);
			setValueBuffer("codsubcuenta", ctaCliente.codsubcuenta);
			setValueBuffer("idasiento", idAsiento);
			setValueBuffer("debe", 0);
			setValueBuffer("haber", debe);
			setValueBuffer("coddivisa", valoresDefecto.coddivisa);
			setValueBuffer("tasaconv", 1);
			setValueBuffer("debeME", 0);
			setValueBuffer("haberME", debeME);
		}

		curPartida.setValueBuffer("concepto", _i.conceptoPartida(curArqueo, sys.translate("Cliente %1").arg(codCliente)));

		if (!curPartida.commitBuffer())
			return false;
	}
	return true;
}
*/

/** \D Genera la parte del asiento de arqueo correspondiente a las subcuentas de clientes
@param  curArqueo: Cursor del arqueo
@param  idAsiento: Id del asiento asociado
@param  valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@return VERDADERO si no hay error, FALSO en otro caso
\end */
/*
function oficial_generarPartidasVentasIva(curArqueo:FLSqlCursor, idAsiento, valoresDefecto:Array)
{
	var AQUtil= new FLUtil();

	var qrySubcuentas= new FLSqlQuery;
	with (qrySubcuentas) {
		setTablesList("");
		setSelect("c.codcliente, c.idtpv_comanda, c.codigo, SUM(p.importe), c.total, c.totaliva, c.neto");
		setFrom("tpv_pagoscomanda p INNER JOIN tpv_comandas c ON p.idtpv_comanda = c.idtpv_comanda");
		setWhere("p.idtpv_arqueo = '" + curArqueo.valueBuffer("idtpv_arqueo") + "' AND c.idfactura IS NULL GROUP BY c.codcliente, c.idtpv_comanda, c.codigo, c.total, c.totaliva, c.neto ORDER BY c.codcliente");
		setForwardOnly(true);
	}
	if (!qrySubcuentas.exec())
		return false;

	var ctaVentas= _i.subcuentaDefecto("VENTAS", valoresDefecto.codejercicio);
	if (ctaVentas.error != 0)
		return false;

	var ivas= [];

	var ctaCliente:Array;
	var codComanda;
	var codCliente;
	var cifCliente;
	var codClientePrevio= "";
	var acumTotal= 0;
	var acumIVA= 0;
	//var acumIVACliente= 0;
	//var acumNetoCliente= 0;
	var totalComanda;
	var totalPagado;
	var haber= 0;
	var haberME= 0;

	var curPartida= new FLSqlCursor("co_partidas");
	var qryLineasIva= new FLSqlQuery();
	qryLineasIva.setTablesList("tpv_lineascomanda");
	qryLineasIva.setSelect("SUM(pvptotal), codimpuesto, iva");
	qryLineasIva.setFrom("tpv_lineascomanda");
	qryLineasIva.setForwardOnly(true);

	var codImpuesto;
	var iva;
	var indiceIva;
	var acumIvaComanda;
	var acumBaseComanda;
debug(qrySubcuentas.sql());
	while (qrySubcuentas.next()) {
		codCliente = qrySubcuentas.value("c.codcliente");
debug (codCliente);

		codComanda = qrySubcuentas.value("c.codigo");
		totalComanda = parseFloat(qrySubcuentas.value("c.total"));
		totalPagado = parseFloat(qrySubcuentas.value("SUM(p.importe)"));
		if (totalComanda != totalPagado) {
			MessageBox.warning(sys.translate("Error al procesar la venta %1:\nEl total de pagos asociados al arqueo actual no coincide con el total de la venta.\nSi se trata de una venta a cuenta, debe editarla y generar una factura asociada para poder cerrar el arqueo.").arg(codComanda), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
		acumTotal += totalComanda;

		qryLineasIva.setWhere("idtpv_comanda = " + qrySubcuentas.value("c.idtpv_comanda") + " GROUP BY codimpuesto, iva");
		if (!qryLineasIva.exec())
			return false;

		acumIvaComanda = 0;
		acumBaseComanda = 0;
		while (qryLineasIva.next()) {
			codImpuesto = qryLineasIva.value("codimpuesto");
			iva = qryLineasIva.value("iva");
			if (!iva || isNaN(iva))
				iva = 0;

			for (indiceIva = 0; indiceIva < ivas.length; indiceIva++) {
				if (ivas[indiceIva]["codimpuesto"] == codImpuesto)
					break;
			}
			if (indiceIva == ivas.length) {
				ivas[indiceIva] = [];
				ivas[indiceIva]["codimpuesto"] = codImpuesto;
				ivas[indiceIva]["iva"] = iva;
				ivas[indiceIva]["subcuenta"] = flfacturac.iface.datosCtaIVA("IVAREP", valoresDefecto.codejercicio, codImpuesto);
				if (ivas[indiceIva]["subcuenta"].error != 0)
					return false;
				ivas[indiceIva]["acumuladoiva"] = 0;
				ivas[indiceIva]["acumuladobase"] = 0;
			}
			acumBaseComanda += parseFloat(qryLineasIva.value("SUM(pvptotal)"));
			acumIvaComanda += parseFloat(qryLineasIva.value("SUM(pvptotal)")) * parseFloat(ivas[indiceIva]["iva"]) / 100;
			ivas[indiceIva]["acumuladobase"] += parseFloat(qryLineasIva.value("SUM(pvptotal)"));
			ivas[indiceIva]["acumuladoiva"] += parseFloat(qryLineasIva.value("SUM(pvptotal)")) * parseFloat(ivas[indiceIva]["iva"]) / 100;
		}
		if ((acumIvaComanda + acumBaseComanda) != totalComanda) {
			MessageBox.warning(sys.translate("Error al procesar el IVA de la comanda %1. La suma de valores (%2) no coincide con el total (%3)").arg(qrySubcuentas.value("c.codigo")).arg(acumIvaComanda + acumBaseComanda).arg(totalComanda), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}

		acumIVA += parseFloat(qrySubcuentas.value("c.totaliva"));
		//acumIVACliente += parseFloat(qrySubcuentas.value("c.totaliva"));
		//acumNetoCliente += parseFloat(qrySubcuentas.value("c.neto"));

		if (codCliente != codClientePrevio) {
			cifCliente = AQUtil.sqlSelect("clientes", "cifnif", "codcliente = '" + codCliente + "'");
			ctaCliente = flfactppal.iface.pub_datosCtaCliente( codCliente, valoresDefecto );
			if (ctaCliente.error != 0) {
				MessageBox.warning(sys.translate("Error al obtener los datos de la subcuenta asociada al cliente %1").arg(codCliente), MessageBox.Ok, MessageBox.NoButton);
				return false;
			}

			for (var i= 0; i < ivas.length; i++) {
				// IVA
				haber = ivas[i]["acumuladoiva"];
				if (haber == 0)
					continue;
				haberME = 0;
				haber = AQUtil.roundFieldValue(haber, "co_partidas", "haber");

				with (curPartida) {
					setModeAccess(curPartida.Insert);
					refreshBuffer();
					setValueBuffer("idsubcuenta", ivas[i]["subcuenta"].idsubcuenta);
					setValueBuffer("codsubcuenta", ivas[i]["subcuenta"].codsubcuenta);
					setValueBuffer("idasiento", idAsiento);
					setValueBuffer("debe", 0);
					setValueBuffer("haber", haber);
					setValueBuffer("coddivisa", valoresDefecto.coddivisa);
					setValueBuffer("tasaconv", 1);
					setValueBuffer("debeME", 0);
					setValueBuffer("haberME", haberME);
					setValueBuffer("baseimponible", ivas[i]["acumuladobase"]);
					setValueBuffer("iva", ivas[i]["iva"]);
					//setValueBuffer("recargo", ¿?);
					setValueBuffer("idcontrapartida", ctaCliente.idsubcuenta);
					setValueBuffer("codcontrapartida", ctaCliente.codsubcuenta);
					//setValueBuffer("codserie", ¿?);
					setValueBuffer("cifnif", cifCliente);
				}
			debug(codCliente);
debug(sys.translate("I.V.A. %1% Cliente %2").arg(ivas[i]["iva"]).arg(codCliente));
debug(sys.translate("I.V.A. %1 Cliente %2").arg(ivas[i]["iva"]).arg(codCliente));
				curPartida.setValueBuffer("concepto", _i.conceptoPartida(curArqueo, sys.translate("I.V.A. %1% Cliente %2").arg(ivas[i]["iva"]).arg(codCliente)));

				if (!curPartida.commitBuffer())
					return false;

				ivas[i]["acumuladobase"] = 0;
				ivas[i]["acumuladoiva"] = 0;
			}
		}
	}
	cifCliente = AQUtil.sqlSelect("clientes", "cifnif", "codcliente = '" + codCliente + "'");
	ctaCliente = flfactppal.iface.pub_datosCtaCliente( codCliente, valoresDefecto );
	if (ctaCliente.error != 0) {
		MessageBox.warning(sys.translate("Error al obtener los datos de la subcuenta asociada al cliente %1").arg(codCliente), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	for (var i= 0; i < ivas.length; i++) {
		// IVA
		haber = ivas[i]["acumuladoiva"];
		if (haber == 0)
			continue;
		haberME = 0;
		haber = AQUtil.roundFieldValue(haber, "co_partidas", "haber");

		with (curPartida) {
			setModeAccess(curPartida.Insert);
			refreshBuffer();
			setValueBuffer("idsubcuenta", ivas[i]["subcuenta"].idsubcuenta);
			setValueBuffer("codsubcuenta", ivas[i]["subcuenta"].codsubcuenta);
			setValueBuffer("idasiento", idAsiento);
			setValueBuffer("debe", 0);
			setValueBuffer("haber", haber);
			setValueBuffer("coddivisa", valoresDefecto.coddivisa);
			setValueBuffer("tasaconv", 1);
			setValueBuffer("debeME", 0);
			setValueBuffer("haberME", haberME);
			setValueBuffer("baseimponible", ivas[i]["acumuladobase"]);
			setValueBuffer("iva", ivas[i]["iva"]);
			//setValueBuffer("recargo", ¿?);
			setValueBuffer("idcontrapartida", ctaCliente.idsubcuenta);
			setValueBuffer("codcontrapartida", ctaCliente.codsubcuenta);
			//setValueBuffer("codserie", ¿?);
			setValueBuffer("cifnif", cifCliente);
		}
	debug(codCliente);
		curPartida.setValueBuffer("concepto", _i.conceptoPartida(curArqueo, sys.translate("I.V.A. %1% Cliente %2").arg(ivas[i]["iva"]).arg(codCliente)));

		if (!curPartida.commitBuffer())
			return false;

		ivas[i]["acumuladobase"] = 0;
		ivas[i]["acumuladoiva"] = 0;
	}

	// Ventas
	haber = acumTotal - acumIVA;
	haberME = 0;
	haber = AQUtil.roundFieldValue(haber, "co_partidas", "haber");

	if (parseFloat(haber) != 0) {
		with (curPartida) {
			setModeAccess(curPartida.Insert);
			refreshBuffer();
			setValueBuffer("idsubcuenta", ctaVentas.idsubcuenta);
			setValueBuffer("codsubcuenta", ctaVentas.codsubcuenta);
			setValueBuffer("idasiento", idAsiento);
			setValueBuffer("debe", 0);
			setValueBuffer("haber", haber);
			setValueBuffer("coddivisa", valoresDefecto.coddivisa);
			setValueBuffer("tasaconv", 1);
			setValueBuffer("debeME", 0);
			setValueBuffer("haberME", haberME);
		}
		curPartida.setValueBuffer("concepto", _i.conceptoPartida(curArqueo, sys.translate("Ventas")));

		if (!curPartida.commitBuffer())
			return false;
	}
	return true;
}
*/

/** \D Genera la parte del asiento de arqueo correspondiente a las subcuentas de pagos
@param  curArqueo: Cursor del arqueo
@param  idAsiento: Id del asiento asociado
@param  valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@return VERDADERO si no hay error, FALSO en otro caso
\end */
/*
function oficial_generarPartidasPago(curArqueo:FLSqlCursor, idAsiento, valoresDefecto:Array)
{
	var AQUtil= new FLUtil();

	var qrySubcuentas= new FLSqlQuery;
	with (qrySubcuentas) {
		setTablesList("");
		setSelect("p.codpago, SUM(p.importe)");
		setFrom("tpv_pagoscomanda p INNER JOIN tpv_comandas c ON p.idtpv_comanda = c.idtpv_comanda");
		setWhere("p.idtpv_arqueo = '" + curArqueo.valueBuffer("idtpv_arqueo") + "' AND c.idfactura IS NULL GROUP BY p.codpago");
		setForwardOnly(true);
	}
	if (!qrySubcuentas.exec())
		return false;

	var codPago;
	var debe= 0;
	var debeME= 0;
	var codPagoEfectivo= AQUtil.sqlSelect("tpv_datosgenerales", "pagoefectivo", "1 = 1");
	var codPagoTarjeta= AQUtil.sqlSelect("tpv_datosgenerales", "pagotarjeta", "1 = 1");
	var codPagoVale= AQUtil.sqlSelect("tpv_datosgenerales", "pagovale", "1 = 1");

	var ctaPago:Array;
	while (qrySubcuentas.next()) {
		codPago = qrySubcuentas.value("p.codpago");
		switch (codPago) {
			case codPagoEfectivo: {
				ctaPago = _i.subcuentaDefecto("CAJA", valoresDefecto.codejercicio);
				if (ctaPago.error != 0)
					return false;
				break;
			}
			case codPagoTarjeta: {
				ctaPago = _i.subcuentaDefecto("TARJETA", valoresDefecto.codejercicio);
				if (ctaPago.error != 0)
					return false;
				break;
			}
			case codPagoVale: {
				ctaPago = _i.subcuentaDefecto("VALE", valoresDefecto.codejercicio);
				if (ctaPago.error != 0)
					return false;
				break;
			}
			default: {
				var codComanda= AQUtil.sqlSelect("tpv_pagoscomanda p INNER JOIN tpv_comandas c ON p.idtpv_comanda = c.idtpv_comanda", "c.codigo", "p.codpago = '" + codPago + "'");
				MessageBox.warning(sys.translate("Al menos la venta %1 contiene una forma de pago que no está calificada como Efectivo, Tarjeta o Vales en el formulario de datos generales del módulo de TPV.\nPara generar el asiento asociado al arqueo actual debe corregir la forma de pago de esta venta.").arg(codComanda), MessageBox.Ok, MessageBox.NoButton);
				break;
			}
		}
		debe = qrySubcuentas.value("SUM(p.importe)");
		debeME = 0;
		debe = AQUtil.roundFieldValue(debe, "co_partidas", "debe");

		var curPartida= new FLSqlCursor("co_partidas");
		with (curPartida) {
			setModeAccess(curPartida.Insert);
			refreshBuffer();
			setValueBuffer("idsubcuenta", ctaPago.idsubcuenta);
			setValueBuffer("codsubcuenta", ctaPago.codsubcuenta);
			setValueBuffer("idasiento", idAsiento);
			setValueBuffer("debe", debe);
			setValueBuffer("haber", 0);
			setValueBuffer("coddivisa", valoresDefecto.coddivisa);
			setValueBuffer("tasaconv", 1);
			setValueBuffer("debeME", debeME);
			setValueBuffer("haberME", 0);
		}

		curPartida.setValueBuffer("concepto", _i.conceptoPartida(curArqueo, sys.translate("Pagos")));

		if (!curPartida.commitBuffer())
			return false;
	}
	return true;
}
*/

/** \D Genera la parte del asiento de arqueo correspondiente a los movimientos de caja extraordinarios
@param  curArqueo: Cursor del arqueo
@param  idAsiento: Id del asiento asociado
@param  valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@return VERDADERO si no hay error, FALSO en otro caso
\end */
function oficial_generarPartidasMovi(curArqueo, idAsiento, valoresDefecto)
{
	var _i = this.iface;

	var qryMovimientos = new FLSqlQuery;
	with(qryMovimientos) {
		setTablesList("tpv_movimientos");
		setSelect("SUM(cantidad), codcausa");
		setFrom("tpv_movimientos");
		setWhere("idtpv_arqueo = '" + curArqueo.valueBuffer("idtpv_arqueo") + "' GROUP BY codcausa");
		setForwardOnly(true);
	}
	if (!qryMovimientos.exec())
		return false;

	var debe = 0;
	var debeCaja = 0;
	var haber = 0;
	var haberCaja = 0;
	var totalMovi = parseFloat(curArqueo.valueBuffer("totalmov"));
	if (totalMovi == 0)
		return true;

	if (totalMovi > 0) {
		debeCaja = totalMovi;
		haberCaja = 0;
	} else {
		totalMovi = totalMovi * -1;
		debeCaja = 0;
		haberCaja = totalMovi;
	}
	debeCaja = AQUtil.roundFieldValue(debeCaja, "co_partidas", "debe");
	haberCaja = AQUtil.roundFieldValue(haberCaja, "co_partidas", "haber");

	var codPagoEfectivo = AQUtil.sqlSelect("tpv_datosgenerales", "pagoefectivo", "1 = 1");

	var ctaCaja = _i.subcuentaDefecto("CAJA", valoresDefecto.codejercicio, curArqueo);
	if (ctaCaja.error != 0)
		return false;

	var ctaMovi: Array;
	var importeMovi: Number;
	var codCausa: String;
	var curPartida = new FLSqlCursor("co_partidas");
	while (qryMovimientos.next()) {
		importeMovi = parseFloat(qryMovimientos.value("SUM(cantidad)"));
		if (!importeMovi || isNaN(importeMovi) || importeMovi == 0)
			continue;

		codCausa = qryMovimientos.value("codcausa");
		if (!codCausa || codCausa == "") {
			MessageBox.warning(sys.translate("No es posible generar el asiento contable asociado al arqueo por la siguiente razón:\nHay al menos un movimiento de caja que no tiene establecida una causa.\nVerifique que todos los movimientos tienen asociada una causa y que ésta tiene asociada una cuenta contable"), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
		ctaMovi = _i.subcuentaCausa(codCausa, valoresDefecto.codejercicio);
		if (ctaMovi.error != 0)
			return false;

		if (importeMovi > 0) {
			debe = 0;
			haber = importeMovi;
		} else {
			importeMovi = importeMovi * -1;
			debe = importeMovi;
			haber = 0;
		}
		debe = AQUtil.roundFieldValue(debe, "co_partidas", "debe");
		haber = AQUtil.roundFieldValue(haber, "co_partidas", "haber");

		with(curPartida) {
			setModeAccess(curPartida.Insert);
			refreshBuffer();
			setValueBuffer("idsubcuenta", ctaMovi.idsubcuenta);
			setValueBuffer("codsubcuenta", ctaMovi.codsubcuenta);
			setValueBuffer("idasiento", idAsiento);
			setValueBuffer("debe", debe);
			setValueBuffer("haber", haber);
			setValueBuffer("coddivisa", valoresDefecto.coddivisa);
			setValueBuffer("tasaconv", 1);
			setValueBuffer("debeME", 0);
			setValueBuffer("haberME", 0);
		}

		curPartida.setValueBuffer("concepto", _i.conceptoPartida(curArqueo, sys.translate("Movimientos efectivo")));

		if (!curPartida.commitBuffer())
			return false;
	}

	with(curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		setValueBuffer("idsubcuenta", ctaCaja.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaCaja.codsubcuenta);
		setValueBuffer("idasiento", idAsiento);
		setValueBuffer("debe", debeCaja);
		setValueBuffer("haber", haberCaja);
		setValueBuffer("coddivisa", valoresDefecto.coddivisa);
		setValueBuffer("tasaconv", 1);
		setValueBuffer("debeME", 0);
		setValueBuffer("haberME", 0);
	}

	curPartida.setValueBuffer("concepto", _i.conceptoPartida(curArqueo, sys.translate("Movimientos efectivo")));

	if (!curPartida.commitBuffer())
		return false;

	return true;
}

/** \D Genera la parte del asiento de arqueo correspondiente al movimiento de ciere de caja
@param  curArqueo: Cursor del arqueo
@param  idAsiento: Id del asiento asociado
@param  valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@return VERDADERO si no hay error, FALSO en otro caso
\end */
function oficial_generarPartidasMoviCierre(curArqueo, idAsiento, valoresDefecto)
{
	var _i = this.iface;

	var debe = 0;
	var debeCaja = 0;
	var haber = 0;
	var haberCaja = 0;
	var totalMovi = parseFloat(curArqueo.valueBuffer("sacadodecaja"));
	if (totalMovi == 0) {
		return true;
	}

	if (totalMovi > 0) {
		debe = totalMovi;
		haber = 0;
		debeCaja = 0;
		haberCaja = totalMovi;
	} else {
		totalMovi = totalMovi * -1;
		debe = 0;
		haber = totalMovi;
		debeCaja = totalMovi;
		haberCaja = 0;
	}
	debe = AQUtil.roundFieldValue(debe, "co_partidas", "debe");
	haber = AQUtil.roundFieldValue(haber, "co_partidas", "haber");
	debeCaja = AQUtil.roundFieldValue(debeCaja, "co_partidas", "debe");
	haberCaja = AQUtil.roundFieldValue(haberCaja, "co_partidas", "haber");

	var codPagoEfectivo = AQUtil.sqlSelect("tpv_datosgenerales", "pagoefectivo", "1 = 1");

	var ctaCaja = _i.subcuentaDefecto("CAJA", valoresDefecto.codejercicio, curArqueo);
	if (ctaCaja.error != 0) {
		MessageBox.warning(sys.translate("Error al generar el asiento: No tiene una subcuenta asociada a la cuenta especial CAJA"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	var codCausa = AQUtil.sqlSelect("tpv_datosgenerales", "codcausacierre", "1 = 1");
	if (!codCausa || codCausa == "") {
		MessageBox.warning(sys.translate("No es posible generar el asiento contable asociado al arqueo por la siguiente razón:\nNo tiene establecida la causa asociada al movimiento de cierre.\nAsocie la causa en el formulario de datos genrales y verifique que ésta tiene asociada una cuenta contable"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	var ctaMovi = _i.subcuentaCausa(codCausa, valoresDefecto.codejercicio);
	if (ctaMovi.error != 0) {
		MessageBox.warning(sys.translate("Error al generar el asiento: No tiene asociada una subcuenta vália a la Causa asociada al movimiento de cierre.\nEdite dicha Causa y asóciele una subcuenta válida."), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	var curPartida = new FLSqlCursor("co_partidas");

	with(curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		setValueBuffer("idsubcuenta", ctaMovi.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaMovi.codsubcuenta);
		setValueBuffer("idasiento", idAsiento);
		setValueBuffer("debe", debe);
		setValueBuffer("haber", haber);
		setValueBuffer("coddivisa", valoresDefecto.coddivisa);
		setValueBuffer("tasaconv", 1);
		setValueBuffer("debeME", 0);
		setValueBuffer("haberME", 0);
	}

	curPartida.setValueBuffer("concepto", _i.conceptoPartida(curArqueo, sys.translate("Movimiento de cierre")));

	if (!curPartida.commitBuffer())
		return false;

	with(curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		setValueBuffer("idsubcuenta", ctaCaja.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaCaja.codsubcuenta);
		setValueBuffer("idasiento", idAsiento);
		setValueBuffer("debe", debeCaja);
		setValueBuffer("haber", haberCaja);
		setValueBuffer("coddivisa", valoresDefecto.coddivisa);
		setValueBuffer("tasaconv", 1);
		setValueBuffer("debeME", 0);
		setValueBuffer("haberME", 0);
	}

	curPartida.setValueBuffer("concepto", _i.conceptoPartida(curArqueo, sys.translate("Movimiento de cierre")));

	if (!curPartida.commitBuffer())
		return false;

	return true;
}

/** \D Genera la parte del asiento de arqueo correspondiente a las diferencias de efectivo detectadas al hacer el arqueo
@param  curArqueo: Cursor del arqueo
@param  idAsiento: Id del asiento asociado
@param  valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@return VERDADERO si no hay error, FALSO en otro caso
\end */
function oficial_generarPartidasDif(curArqueo, idAsiento, valoresDefecto)
{
	var _i = this.iface;

	var debe = 0;
	var debeCaja = 0;
	var haber = 0;
	var haberCaja = 0;
	var difEfectivo = curArqueo.valueBuffer("diferenciaefectivo");
	difEfectivo = parseFloat(difEfectivo);
	if (difEfectivo == 0)
		return true;

	var codPagoEfectivo = AQUtil.sqlSelect("tpv_datosgenerales", "pagoefectivo", "1 = 1");

	var ctaCaja = _i.subcuentaDefecto("CAJA", valoresDefecto.codejercicio, curArqueo);
	if (ctaCaja.error != 0)
		return false;

	var ctaDif: Array;
	if (difEfectivo > 0) {
		haber = difEfectivo;
		debeCaja = difEfectivo;
		ctaDif = _i.subcuentaDefecto("DIFPOS", valoresDefecto.codejercicio, curArqueo);
		if (ctaDif.error != 0)
			return false;
	} else {
		difEfectivo = difEfectivo * -1;
		debe = difEfectivo;
		haberCaja = difEfectivo;
		ctaDif = _i.subcuentaDefecto("DIFNEG", valoresDefecto.codejercicio, curArqueo);
		if (ctaDif.error != 0)
			return false;
	}
	debe = AQUtil.roundFieldValue(debe, "co_partidas", "debe");
	haber = AQUtil.roundFieldValue(haber, "co_partidas", "haber");
	debeCaja = AQUtil.roundFieldValue(debeCaja, "co_partidas", "debe");
	haberCaja = AQUtil.roundFieldValue(haberCaja, "co_partidas", "haber");

	var curPartida = new FLSqlCursor("co_partidas");
	with(curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		setValueBuffer("idsubcuenta", ctaDif.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaDif.codsubcuenta);
		setValueBuffer("idasiento", idAsiento);
		setValueBuffer("debe", debe);
		setValueBuffer("haber", haber);
		setValueBuffer("coddivisa", valoresDefecto.coddivisa);
		setValueBuffer("tasaconv", 1);
		setValueBuffer("debeME", 0);
		setValueBuffer("haberME", 0);
	}

	curPartida.setValueBuffer("concepto", _i.conceptoPartida(curArqueo, sys.translate("Diferencias efectivo")));

	if (!curPartida.commitBuffer())
		return false;

	with(curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		setValueBuffer("idsubcuenta", ctaCaja.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaCaja.codsubcuenta);
		setValueBuffer("idasiento", idAsiento);
		setValueBuffer("debe", debeCaja);
		setValueBuffer("haber", haberCaja);
		setValueBuffer("coddivisa", valoresDefecto.coddivisa);
		setValueBuffer("tasaconv", 1);
		setValueBuffer("debeME", 0);
		setValueBuffer("haberME", 0);
	}

	curPartida.setValueBuffer("concepto", _i.conceptoPartida(curArqueo, sys.translate("Diferencias efectivo")));

	if (!curPartida.commitBuffer())
		return false;

	return true;
}

/** \D Establece los datos opcionales de una partida de asientos de arqueo
Para facilitar personalizaciones en las partidas.
Se ponen datos de concepto, tipo de documento, documento y factura
@param  curPartida: Cursor sobre la partida
@param  curArqueo: Cursor sobre el arqueo
@param  masConcepto: Concepto, opcional
*/
function oficial_conceptoPartida(curArqueo: FLSqlCursor, masConcepto: String)
{
	var _i = this.iface;

	var concepto = sys.translate("Arqueo de caja ") + curArqueo.valueBuffer("idtpv_arqueo");
	if (masConcepto)
		concepto += " " + masConcepto;

	return concepto;
}

function oficial_subcuentaCausa(codCausa: String, codEjercicio: String)
{
	var _i = this.iface;

	var datos = [];
	datos["error"] = 1;

	var q = new FLSqlQuery();

	var codSubcuenta = AQUtil.sqlSelect("tpv_causasmovimiento", "codsubcuenta", "codcausa = '" + codCausa + "'");
	if (!codSubcuenta) {
		MessageBox.warning(sys.translate("No tiene especificada la subcuenta asociada a la causa de movimiento de caja %1.\nDebe editar la causa y asociar la correspondiente subcuenta contable").arg(codCausa), MessageBox.Ok, MessageBox.NoButton);
		return datos;
	}

	with(q) {
		setTablesList("co_subcuentas");
		setSelect("s.idsubcuenta, s.codsubcuenta");
		setFrom("co_subcuentas s");
		setWhere("s.codsubcuenta = '" + codSubcuenta + "' AND s.codejercicio = '" + codEjercicio + "'");
		setForwardOnly(true);
	}
	if (!q.exec()) {
		datos["error"] = 2;
		return datos;
	}
	if (q.first()) {
		datos["error"] = 0;
		datos["idsubcuenta"] = q.value(0);
		datos["codsubcuenta"] = q.value(1);
		return datos;
	}

	return datos;
}

///curArqueo puede ser el cursor de una comanda o de un arqueo. Se usa para saber el punto de venta y a partir de ahí sobrecargar si es necesario esta función para obtener las cuentas por defecto del punto de venta y no de datos generales de TPV
function oficial_subcuentaDefecto(nombre, codEjercicio, curAC)
{
	var _i = this.iface;

	var datos = [];
	datos["error"] = 1;

	var q = new FLSqlQuery();

	var codSubcuenta: String;
	switch (nombre) {
	case "VENTAS": {
			codSubcuenta = AQUtil.sqlSelect("tpv_datosgenerales", "codsubcuentaven", "1 = 1");
			if (!codSubcuenta) {
				MessageBox.warning(sys.translate("No tiene especificada la subcuenta de ventas a utilizar en el asiento de pago.\nDebe especificar dicha subcuenta en el formulario de datos generales del módulo de TPV"), MessageBox.Ok, MessageBox.NoButton);
				return datos;
			}
			break;
		}
	case "CAJA": {
			codSubcuenta = AQUtil.sqlSelect("tpv_datosgenerales", "codsubcuentacaja", "1 = 1");
			if (!codSubcuenta) {
				MessageBox.warning(sys.translate("No tiene especificada la subcuenta de caja a utilizar en el asiento de pago.\nDebe especificar dicha subcuenta en el formulario de datos generales del módulo de TPV"), MessageBox.Ok, MessageBox.NoButton);
				return datos;
			}
			break;
		}
	case "TARJETA": {
			codSubcuenta = AQUtil.sqlSelect("tpv_datosgenerales", "codsubcuentatar", "1 = 1");
			if (!codSubcuenta) {
				MessageBox.warning(sys.translate("No tiene especificada la subcuenta de pago con tarjeta ventas a utilizar en el asiento de pago.\nDebe especificar dicha subcuenta en el formulario de datos generales del módulo de TPV"), MessageBox.Ok, MessageBox.NoButton);
				return datos;
			}
			break;
		}
	case "VALE": {
			codSubcuenta = AQUtil.sqlSelect("tpv_datosgenerales", "codsubcuentavale", "1 = 1");
			if (!codSubcuenta) {
				MessageBox.warning(sys.translate("No tiene especificada la subcuenta de pago con vale a utilizar en el asiento de pago.\nDebe especificar dicha subcuenta en el formulario de datos generales del módulo de TPV"), MessageBox.Ok, MessageBox.NoButton);
				return datos;
			}
			break;
		}
	case "DIFPOS": {
			codSubcuenta = AQUtil.sqlSelect("tpv_datosgenerales", "codsubcuentadifpos", "1 = 1");
			if (!codSubcuenta) {
				MessageBox.warning(sys.translate("No tiene especificada la subcuenta de diferencias positivas de cambio a utilizar en el asiento de arqueo.\nDebe especificar dicha subcuenta en el formulario de datos generales del módulo de TPV"), MessageBox.Ok, MessageBox.NoButton);
				return datos;
			}
			break;
		}
	case "DIFNEG": {
			codSubcuenta = AQUtil.sqlSelect("tpv_datosgenerales", "codsubcuentadifneg", "1 = 1");
			if (!codSubcuenta) {
				MessageBox.warning(sys.translate("No tiene especificada la subcuenta de diferencias negativas de cambio a utilizar en el asiento de arqueo.\nDebe especificar dicha subcuenta en el formulario de datos generales del módulo de TPV"), MessageBox.Ok, MessageBox.NoButton);
				return datos;
			}
			break;
		}
	case "ANTICIPO": {
			codSubcuenta = AQUtil.sqlSelect("tpv_datosgenerales", "codsubcuentaanticipo", "1 = 1");
			if (!codSubcuenta) {
				MessageBox.warning(sys.translate("No tiene especificada la subcuenta de entregas a cuenta (anticipos) a utilizar en el asiento de pago.\nDebe especificar dicha subcuenta en el formulario de datos generales del módulo de TPV"), MessageBox.Ok, MessageBox.NoButton);
				return datos;
			}
			break;
		}
	}

	with(q) {
		setTablesList("co_subcuentas");
		setSelect("s.idsubcuenta, s.codsubcuenta");
		setFrom("co_subcuentas s");
		setWhere("s.codsubcuenta = '" + codSubcuenta + "' AND s.codejercicio = '" + codEjercicio + "'");
		setForwardOnly(true);
	}
	if (!q.exec()) {
		datos["error"] = 2;
		return datos;
	}
	if (!q.first()) {
		MessageBox.warning(sys.translate("No se ha encontrado la subcuenta %1 configurada como subcuenta %2 en los parámetros generales del TPV\npara el ejercicio %3").arg(codSubcuenta).arg(nombre).arg(codEjercicio), MessageBox.Ok, MessageBox.NoButton);
		return datos;
	}

	datos["error"] = 0;
	datos["idsubcuenta"] = q.value(0);
	datos["codsubcuenta"] = q.value(1);

	return datos;
}

function oficial_sincronizarConFacturacion(curComanda)
{
	var _i = this.iface;


	switch (curComanda.valueBuffer("tipodoc")) {
		case "DEVOLUCION":
		case "VENTA": {
			var oParam = new Object;
			oParam.curComanda = curComanda;
			oParam.errorMsg = sys.translate("Error al sincronizar la venta con su factura");
			var f = new Function("oParam", "return flfact_tpv.iface.sincronizaFactura(oParam)");
			if (!sys.runTransaction(f, oParam)) {
				return false;
			}
// 			if (!_i.sincronizaFactura(curComanda)) {
// 				return false;
// 			}
			break;
		}/*
		case "DEVOLUCION": {
			if (!_i.sincronizaDevolucion(curComanda)) {
				return false;
			}
			break;
		}*/
		case "RESERVA": {
			var oParam = new Object;
			oParam.curComanda = curComanda;
			oParam.errorMsg = sys.translate("Error al sincronizar la reserva con su pago anticipado");
			var f = new Function("oParam", "return flfact_tpv.iface.comprobarPagoAnticipado(oParam)");
			if (!sys.runTransaction(f, oParam)) {
				return false;
			}
// 			if (!_i.comprobarPagoAnticipado(curComanda)) {
// 				return false;
// 			}
			break;
		}
	}
	return true;
}

function oficial_sincronizaFactura(oParam)
{
	var _i = this.iface;
	var curComanda = oParam.curComanda;

	switch (curComanda.modeAccess()) {
		case curComanda.Insert: {
			var idFactura = _i.crearFactura(curComanda);
			if (!idFactura) {
				return false;
			}
			curComanda.setValueBuffer("idfactura", idFactura);
			break;
		}
		case curComanda.Edit: {
			var idFactura = curComanda.valueBuffer("idfactura");
			if (idFactura && AQUtil.sqlSelect("facturascli", "idfactura", "idfactura = " + idFactura)) {
				if (!_i.modificarFactura(curComanda, idFactura)) {
					return false;
				}
			} else {
				idFactura = _i.crearFactura(curComanda);
				if (!idFactura) {
					return false;
				}
				curComanda.setValueBuffer("idfactura", idFactura);
			}
			if (!_i.generarRecibos(curComanda)) {
				return false;
			}
			break;
		}
		case curComanda.Del: {
			var idFactura = curComanda.valueBuffer("idfactura");
			var curPago = new FLSqlCursor("tpv_pagoscomanda");
			curPago.select("idtpv_comanda = " + curComanda.valueBuffer("idtpv_comanda"));
			curPago.setForwardOnly(true);
			while (curPago.next()) {
				if (!curPago.valueBuffer("editable")) {
					MessageBox.warning(sys.translate("El pago de la venta está bloqueado, posiblemente por estar cerrado su arqueo.\nNo es posible eliminarlo."), MessageBox.Ok, MessageBox.NoButton);
					return false;
				}
				curPago.setModeAccess(curPago.Del);
				curPago.refreshBuffer();
				if (!curPago.commitBuffer()) {
					return false;
				}
			}
			if (!_i.borrarFactura(idFactura)) {
				return false;
			}
			break;
		}
	}
	return true;
}

function oficial_sincronizaDevolucion(curComanda)
{
	var _i = this.iface;

	if (!(sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada"))) {
		return true;
	}

	var idComanda = curComanda.valueBuffer("idtpv_comanda");

	var q = new FLSqlQuery();
	q.setSelect("idpago,nogenerarasiento,idasiento,editable");
	q.setFrom("tpv_pagoscomanda");
	q.setWhere("idtpv_comanda = " + idComanda);
	q.setForwardOnly(true);
	if (!q.exec()) {
		return false;
	}

	var curPago = new FLSqlCursor("tpv_pagoscomanda");
	var noGA, idAsiento;
	while (q.next()) {
		idAsiento = q.value("idasiento");
		noGA = q.value("nogenerarasiento");

		if(!q.value("editable")){
			continue;
		}
		curPago.select("idpago = " + q.value(0));
		curPago.first();
		curPago.setModeAccess(curPago.Edit);
		curPago.refreshBuffer();
		if (!_i.generarAsientoPagoDevolucion(curPago)) {
			return false;
		}
		if(!curPago.commitBuffer()){
			return false;
		}
		if (noGA && idAsiento) {
			if (!flfacturac.iface.pub_eliminarAsiento(idAsiento)) {
				return false;
			}
		}
	}
	return true;
}

function oficial_obtenerCodigoComanda(curComanda)
{
	var _i = this.iface;

	var prefijo = _i.damePrefijo(curComanda);
	if(!prefijo){
		prefijo = "";
	}
	var ultimoTiquet = AQUtil.sqlSelect("tpv_secuenciascomanda", "valor", "prefijo = '" + prefijo + "'");

	if (!ultimoTiquet) {
		var idUltimo = AQUtil.sqlSelect("tpv_comandas", "codigo", "codigo LIKE '" + prefijo + "%' ORDER BY codigo DESC");

		if (idUltimo) {
			ultimoTiquet = parseFloat(idUltimo);
		} else {
			ultimoTiquet = 0;
		}
		ultimoTiquet += 1;
		var curSecuencia = new FLSqlCursor("tpv_secuenciascomanda");
		curSecuencia.setModeAccess(curSecuencia.Insert);
		curSecuencia.refreshBuffer();
		curSecuencia.setValueBuffer("prefijo", prefijo);
		curSecuencia.setValueBuffer("valor", ultimoTiquet);
		if (!curSecuencia.commitBuffer()) {
			return false;
		}
	} else {
		ultimoTiquet += 1;
		AQUtil.sqlUpdate("tpv_secuenciascomanda", "valor", ultimoTiquet, "prefijo = '" + prefijo + "'");
	}

	var codigo = prefijo + flfacturac.iface.pub_cerosIzquierda(ultimoTiquet, 12 - prefijo.length);

	return codigo;
}

function oficial_damePrefijo(curComanda)
{
	var _i = this.iface;

	var prefijo = "";
	return prefijo;
}

function oficial_valorDefectoTPV(campo)
{
	var valor;
	switch (campo) {
		case "codterminal": {
			valor = AQUtil.readSettingEntry("scripts/fltpv_ppal/codTerminal");
			valor = valor == "false" ? false : valor;
			break;
		}
		default: {
			valor = AQUtil.sqlSelect("tpv_datosgenerales", campo, "1 = 1");
		}
	}
	return valor;
}

function oficial_borrarLineasFactura(idFactura: String)
{
	var _i = this.iface;

	var curLinea = new FLSqlCursor("lineasfacturascli");
	curLinea.select("idfactura = " + idFactura);
	while (curLinea.next()) {
		curLinea.setModeAccess(curLinea.Del);
		curLinea.refreshBuffer();
		if (!curLinea.commitBuffer()) {
			return false;
		}
	}
	return true;
}

/** Informa el nuevo campo almacén en las comandas previas a su introducción
\end */
function oficial_comprobarAlmacenesComandas()
{
	var _i = this.iface;

	var curComandas = new FLSqlCursor("tpv_comandas");
	curComandas.select("codalmacen = 'NULL'");
	curComandas.setActivatedCommitActions(false);
	curComandas.setActivatedCheckIntegrity(false);
	var codTerminal: String;
	while (curComandas.next()) {
		curComandas.setModeAccess(curComandas.Edit);
		curComandas.refresh();
		codTerminal = curComandas.valueBuffer("codtpv_puntoventa");
		curComandas.setValueBuffer("codalmacen", AQUtil.sqlSelect("tpv_puntosventa", "codalmacen", "codtpv_puntoventa = '" + codTerminal + "'"));
		if (!curComandas.commitBuffer()) {
			return false;
		}
	}
	return true;
}

function oficial_consultarStock(oArticulo)
{
	var _i = this.iface;

	var f = new FLFormSearchDB("tpv_consultastocks");
	var cursor:FLSqlCursor = f.cursor();

	cursor.select();
	if (!cursor.first()) {
		cursor.setModeAccess(cursor.Insert);
	} else {
		cursor.setModeAccess(cursor.Edit);
	}
	cursor.refreshBuffer();
	f.setMainWidget();
	_i.artConsultaStock_ = oArticulo;
	var idStock = f.exec("idstock");
}

function oficial_dameArtConsultaStock()
{
	var _i = this.iface;
	return _i.artConsultaStock_;
}

function oficial_iniciarTotales(nodo, campo)
{
	var _i = this.iface;
		_i.costeAc_ = 0;
	_i.totalAc_ = 0;
}

function oficial_calcularBeneficio(nodo, campo)
{
	var _i = this.iface;

	var valor;
	var coste = parseFloat(nodo.attributeValue("tpv_lineascomanda.cantidad * tpv_lineascomanda.costeunitario"));
	coste = isNaN(coste) ? 0 : coste;
	var venta = parseFloat(nodo.attributeValue("tpv_lineascomanda.pvptotal"));
	coste = isNaN(coste) ? 0 : coste;
	_i.costeAc_ += coste;
	_i.totalAc_ += venta;

	valor = coste != 0 ? ((venta - coste) / coste) * 100 : 100;
	if (!valor || isNaN(valor)) {
		valor = 0;
	}
	return valor;
}

function oficial_mostrarTotales(nodo, campo)
{
	var _i = this.iface;

	var valor;
	switch (campo) {
	case "coste": {
			valor = _i.costeAc_;
			break;
		}
	case "total": {
			valor = _i.totalAc_;
			break;
		}
	case "beneficio": {
			valor = _i.totalAc_ - _i.costeAc_;
			break;
		}
	case "porbeneficio": {
			if (_i.costeAc_ == 0) {
				valor =  100;
			} else {
				valor = ((_i.totalAc_ - _i.costeAc_) / _i.costeAc_) * 100;
			}
			if (!valor || isNaN(valor)) {
				valor = 0;
			}
			break;
		}
	}
	return valor;
}

function oficial_controlArquePagoComanda(curPago)
{
	var _i = this.iface;

	if (!curPago.valueBuffer("idtpv_arqueo")) {
		var qryarqueos = new FLSqlQuery();
		qryarqueos.setTablesList("tpv_arqueos");
		qryarqueos.setSelect("idtpv_arqueo");
		qryarqueos.setFrom("tpv_arqueos");
		qryarqueos.setWhere("ptoventa = '" + curPago.valueBuffer("codtpv_puntoventa") + "' AND abierta = true AND diadesde <= '" + curPago.valueBuffer("fecha") + "'");
		if (!qryarqueos.exec())
			return;
		/** \C
		Comprueba que existe un arqueo abierto que corresponda con los datos de la comanda antes de crear una nueva.
		*/
		if (!qryarqueos.first()) {
			MessageBox.warning(sys.translate("No existe ningún arqueo abierto para este punto de venta y esta fecha.\nAntes de crear una venta debe crear el aqueo."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return false;
		}
		if (qryarqueos.size() > 1) {
			/** \C
			No se puede crear una comanda si existen más de un arqueo a los que pueda pertenecer
			*/
			MessageBox.warning(sys.translate("Existe mas de un arqueo abierto para este punto de venta y esta fecha."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return false;
		}
		curPago.setValueBuffer("idtpv_arqueo", qryarqueos.value(0));
	}
	return true;
}

function oficial_generarAsientoPagoComanda(curPago)
{
	var _i = this.iface;

	if (curPago.modeAccess() != curPago.Insert && curPago.modeAccess() != curPago.Edit) {
    return true;
  }

  if (curPago.valueBuffer("nogenerarasiento")) {
    curPago.setNull("idasiento");
    return true;
  }

  var codEjercicio = flfactppal.iface.pub_ejercicioActual();
  var datosDoc= flfacturac.iface.pub_datosDocFacturacion(curPago.valueBuffer("fecha"), codEjercicio, "tpv_pagoscomanda");
  if (!datosDoc.ok){
    return false;
	}
  if (datosDoc.modificaciones == true) {
    codEjercicio = datosDoc.codEjercicio;
    curPago.setValueBuffer("fecha", datosDoc.fecha);
  }

  var datosAsiento = [];

	var curComanda = new FLSqlCursor("tpv_comandas");
	curComanda.select("idtpv_comanda = " + curPago.valueBuffer("idtpv_comanda"));
	if(!curComanda.first()) {
		return false;
	}

  var valoresDefecto = [];
  valoresDefecto["codejercicio"] = codEjercicio;
  valoresDefecto["coddivisa"] = AQUtil.sqlSelect("empresa", "coddivisa", "1 = 1");

  var curTransaccion= new FLSqlCursor("empresa");
  curTransaccion.transaction(false);
  try {
		datosAsiento = flfacturac.iface.pub_regenerarAsiento(curPago, valoresDefecto);
		if (datosAsiento.error == true) {
			throw sys.translate("Error al regenerar el asiento");
		}
		if (curComanda) {
			datosAsiento["concepto"] = sys.translate("Pago anticipo venta %1").arg(curComanda.valueBuffer("codigo"));
		} else {
			datosAsiento["concepto"] = sys.translate("Pago anticipo venta %1").arg(AQUtil.sqlSelect("tpv_comandas", "codigo", "idtpv_comanda = " + curPago.valueBuffer("idtpv_comanda")));
		}
		var oPago = _i.dameDatosPagoAsiento(curPago);

		if (!_i.generarPartidasPCAnticiposCli(curPago, valoresDefecto, datosAsiento, oPago)) {
			throw sys.translate("Error al obtener la partida de cliente");
		}
		if (!_i.generarPartidasPCBanco(curPago, valoresDefecto, datosAsiento, oPago)) {
			throw sys.translate("Error al obtener la partida de banco");
		}
		curPago.setValueBuffer("idasiento", datosAsiento.idasiento);
		if (!flcontppal.iface.pub_comprobarAsiento(datosAsiento.idasiento)) {
			throw sys.translate("Error al comprobar el asiento");
		}
  }
  catch (e) {
		curTransaccion.rollback();
		MessageBox.warning(sys.translate("Error al generar el asiento asociado al pago") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
		return false;
  }
  curTransaccion.commit();
  return true;
}



function oficial_generarAsientoPagoDevolucion(curPago)
{
	var _i = this.iface;

	if (curPago.modeAccess() != curPago.Insert && curPago.modeAccess() != curPago.Edit) {
    return true;
  }

  if (curPago.valueBuffer("nogenerarasiento")) {
    curPago.setNull("idasiento");
    return true;
  }

  var codEjercicio = flfactppal.iface.pub_ejercicioActual();
  var datosDoc= flfacturac.iface.pub_datosDocFacturacion(curPago.valueBuffer("fecha"), codEjercicio, "tpv_pagoscomanda");
  if (!datosDoc.ok){
    return false;
	}
  if (datosDoc.modificaciones == true) {
    codEjercicio = datosDoc.codEjercicio;
    curPago.setValueBuffer("fecha", datosDoc.fecha);
  }

  var datosAsiento = [];

	var curComanda = new FLSqlCursor("tpv_comandas");
	curComanda.select("idtpv_comanda = " + curPago.valueBuffer("idtpv_comanda"));
	if(!curComanda.first()) {
		return false;
	}

  var valoresDefecto = [];
  valoresDefecto["codejercicio"] = codEjercicio;
  valoresDefecto["coddivisa"] = AQUtil.sqlSelect("empresa", "coddivisa", "1 = 1");

  var curTransaccion= new FLSqlCursor("empresa");
  curTransaccion.transaction(false);
  try {
		datosAsiento = flfacturac.iface.pub_regenerarAsiento(curPago, valoresDefecto);
		if (datosAsiento.error == true) {
			throw sys.translate("Error al regenerar el asiento");
		}
		if (curComanda) {
			datosAsiento["concepto"] = sys.translate("Pago devolución %1").arg(curComanda.valueBuffer("codigo"));
		} else {
			datosAsiento["concepto"] = sys.translate("Pago devolución %1").arg(AQUtil.sqlSelect("tpv_comandas", "codigo", "idtpv_comanda = " + curPago.valueBuffer("idtpv_comanda")));
		}
		var oPago = _i.dameDatosPagoAsiento(curPago);

		if (!_i.generarPartidasDevolucion(curPago, valoresDefecto, datosAsiento, oPago)) {
			throw sys.translate("Error al obtener la partida de devolución");
		}
		if (!_i.generarPartidasVentas(curPago, valoresDefecto, datosAsiento, oPago)) {
			throw sys.translate("Error al obtener la partida de venta");
		}
		curPago.setValueBuffer("idasiento", datosAsiento.idasiento);
		if (!flcontppal.iface.pub_comprobarAsiento(datosAsiento.idasiento)) {
			throw sys.translate("Error al comprobar el asiento");
		}
  }
  catch (e) {
		curTransaccion.rollback();
		MessageBox.warning(sys.translate("Error al generar el asiento asociado al pago") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
		return false;
  }
  curTransaccion.commit();
  return true;
}

function oficial_generarPartidasPCAnticiposCli(curPago, valoresDefecto, datosAsiento, oPago)
{
	var _i = this.iface;

	var ctaHaber = _i.dameSubcuentaPCAnticiposCli(curPago, valoresDefecto, datosAsiento, oPago);
	if (!ctaHaber) {
		return false;
	}
	var haber = 0;
	var haberME = 0;
	var tasaConvHaber = 1;

	var importeTotal = curPago.valueBuffer("importe");
	if (valoresDefecto.coddivisa == oPago.coddivisa) {
		haber = importeTotal;
		haberMe = 0;
	} else {
		tasaConvHaber = oPago.tasaconv;
		haber = parseFloat(importeTotal) * parseFloat(tasaConvHaber);
		haberME = parseFloat(importeTotal);
	}

	haber = AQUtil.roundFieldValue(haber, "co_partidas", "haber");
	haberME = AQUtil.roundFieldValue(haberME, "co_partidas", "haberme");

	var curPartida= new FLSqlCursor("co_partidas");
	with(curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		setValueBuffer("concepto", datosAsiento.concepto);
		setValueBuffer("idsubcuenta", ctaHaber.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaHaber.codsubcuenta);
		setValueBuffer("idasiento", datosAsiento.idasiento);
		setValueBuffer("debe", 0);
		setValueBuffer("haber", haber);
		setValueBuffer("coddivisa", oPago.coddivisa);
		setValueBuffer("tasaconv", tasaConvHaber);
		setValueBuffer("debeME", 0);
		setValueBuffer("haberME", haberME);
	}
	if (!_i.datosPartidaPCAnticipo(curPartida, curPago, valoresDefecto, datosAsiento, oPago)) {
		return false;
	}
	if (!curPartida.commitBuffer()){
		return false;
	}

	return true;
}

function oficial_generarPartidasDevolucion(curPago, valoresDefecto, datosAsiento, oPago)
{
	var _i = this.iface;

	var ctaHaber = _i.dameSubcuentaVale(curPago, valoresDefecto, datosAsiento, oPago);
	if (!ctaHaber) {
		return false;
	}
	var haber = 0;
	var haberME = 0;
	var tasaConvHaber = 1;

	var importeTotal = curPago.valueBuffer("importe");
	if (valoresDefecto.coddivisa == oPago.coddivisa) {
		haber = importeTotal;
		haberMe = 0;
	} else {
		tasaConvHaber = oPago.tasaconv;
		haber = parseFloat(importeTotal) * parseFloat(tasaConvHaber);
		haberME = parseFloat(importeTotal);
	}

	haber = AQUtil.roundFieldValue(haber, "co_partidas", "haber");
	haberME = AQUtil.roundFieldValue(haberME, "co_partidas", "haberme");

	var curPartida= new FLSqlCursor("co_partidas");
	with(curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		setValueBuffer("concepto", datosAsiento.concepto);
		setValueBuffer("idsubcuenta", ctaHaber.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaHaber.codsubcuenta);
		setValueBuffer("idasiento", datosAsiento.idasiento);
		setValueBuffer("debe", 0);
		setValueBuffer("haber", haber);
		setValueBuffer("coddivisa", oPago.coddivisa);
		setValueBuffer("tasaconv", tasaConvHaber);
		setValueBuffer("debeME", 0);
		setValueBuffer("haberME", haberME);
	}

	if (!curPartida.commitBuffer()){
		return false;
	}

	return true;
}

function oficial_generarPartidasPCBanco(curPago, valoresDefecto, datosAsiento, oPago)
{
	var _i = this.iface;

	var ctaDebe = _i.dameSubcuentaPCBanco(curPago, valoresDefecto, datosAsiento, oPago);
	if(!ctaDebe){
		return false;
	}
	var debe = 0;
	var debeME = 0;
	var tasaConvDebe = 1;

	var importeTotal = curPago.valueBuffer("importe");

	if (valoresDefecto.coddivisa == oPago.coddivisa) {
		debe = importeTotal;
		debeMe = 0;
	} else {
		tasaConvHaber = oPago.tasaconv;
		debe = parseFloat(importeTotal) * parseFloat(tasaConvDebe);
		debeME = parseFloat(importeTotal);
	}

	debe = AQUtil.roundFieldValue(debe, "co_partidas", "debe");
	debeME = AQUtil.roundFieldValue(debeME, "co_partidas", "debeme");

	var curPartida= new FLSqlCursor("co_partidas");
	with(curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		setValueBuffer("concepto", datosAsiento.concepto);
		setValueBuffer("idsubcuenta", ctaDebe.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaDebe.codsubcuenta);
		setValueBuffer("idasiento", datosAsiento.idasiento);
		setValueBuffer("haber", 0);
		setValueBuffer("debe", debe);
		setValueBuffer("coddivisa", oPago.coddivisa);
		setValueBuffer("tasaconv", tasaConvDebe);
		setValueBuffer("debeME", debeME);
		setValueBuffer("haberME", 0);
	}
	if (!curPartida.commitBuffer()){
		return false;
	}
	return true;
}

function oficial_generarPartidasVentas(curPago, valoresDefecto, datosAsiento, oPago)
{
	var _i = this.iface;

	var ctaDebe = _i.dameSubcuentaVenta(curPago, valoresDefecto, datosAsiento, oPago);
	if(!ctaDebe){
		return false;
	}
	var debe = 0;
	var debeME = 0;
	var tasaConvDebe = 1;

	var importeTotal = curPago.valueBuffer("importe");

	if (valoresDefecto.coddivisa == oPago.coddivisa) {
		debe = importeTotal;
		debeMe = 0;
	} else {
		tasaConvHaber = oPago.tasaconv;
		debe = parseFloat(importeTotal) * parseFloat(tasaConvDebe);
		debeME = parseFloat(importeTotal);
	}

	debe = AQUtil.roundFieldValue(debe, "co_partidas", "debe");
	debeME = AQUtil.roundFieldValue(debeME, "co_partidas", "debeme");

	var curPartida= new FLSqlCursor("co_partidas");
	with(curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		setValueBuffer("concepto", datosAsiento.concepto);
		setValueBuffer("idsubcuenta", ctaDebe.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaDebe.codsubcuenta);
		setValueBuffer("idasiento", datosAsiento.idasiento);
		setValueBuffer("haber", 0);
		setValueBuffer("debe", debe);
		setValueBuffer("coddivisa", oPago.coddivisa);
		setValueBuffer("tasaconv", tasaConvDebe);
		setValueBuffer("debeME", debeME);
		setValueBuffer("haberME", 0);
	}
	if (!curPartida.commitBuffer()){
		return false;
	}
	return true;
}

function oficial_dameSubcuentaPCAnticiposCli(curPago, valoresDefecto, datosAsiento, oPago)
{
	var _i = this.iface;

	var curComanda = new FLSqlCursor("tpv_comandas");
	curComanda.select("idtpv_comanda = " + curPago.valueBuffer("idtpv_comanda"));
	if(!curComanda.first()) {
		return false;
	}
	var datos = _i.subcuentaDefecto("ANTICIPO", valoresDefecto.codejercicio, curComanda);

	if(datos["error"] != 0){
		return false;
	}
	return datos;
}

function oficial_dameSubcuentaVenta(curPago, valoresDefecto, datosAsiento, oPago)
{
	var _i = this.iface;

	var curComanda = new FLSqlCursor("tpv_comandas");
	curComanda.select("idtpv_comanda = " + curPago.valueBuffer("idtpv_comanda"));
	if(!curComanda.first()) {
		return false;
	}
	var datos = _i.subcuentaDefecto("VENTAS", valoresDefecto.codejercicio, curComanda);

	if(datos["error"] != 0){
		return false;
	}
	return datos;
}

function oficial_dameSubcuentaVale(curPago, valoresDefecto, datosAsiento, oPago)
{
	var _i = this.iface;

	var curComanda = new FLSqlCursor("tpv_comandas");
	curComanda.select("idtpv_comanda = " + curPago.valueBuffer("idtpv_comanda"));
	if(!curComanda.first()) {
		return false;
	}
	var datos = _i.subcuentaDefecto("VALE", valoresDefecto.codejercicio, curComanda);

	if(datos["error"] != 0){
		return false;
	}
	return datos;
}

function oficial_dameSubcuentaPCBanco(curPago, valoresDefecto, datosAsiento, oPago)
{
	var _i = this.iface;

	var codPago = curPago.valueBuffer("codpago");
	var qryCuenta = new FLSqlQuery;
	qryCuenta.setTablesList("formaspago,cuentasbanco");
	qryCuenta.setSelect("codsubcuenta");
	qryCuenta.setFrom("formaspago f INNER JOIN cuentasbanco c ON f.codcuenta = c.codcuenta")
	qryCuenta.setWhere("f.codpago = '" + codPago + "'")
	qryCuenta.setForwardOnly(true);

	if (!qryCuenta.exec()){
		return false;
	}
	var datos = [];

	if (!qryCuenta.first()) {
		MessageBox.warning(sys.translate("La forma de pago %1 no tiene asociada una cuenta bancaria o ésta no tiene asociada una subcuenta contable").arg(codPago), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	datos["codsubcuenta"] = qryCuenta.value("codsubcuenta");
	datos["idsubcuenta"] = AQUtil.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + datos["codsubcuenta"] + "' AND codejercicio = '" + valoresDefecto.codejercicio + "'");
	if (!datos.idsubcuenta) {
		MessageBox.warning(sys.translate("No tiene definida la subcuenta %1 en el ejercicio %2.\nAntes de dar el pago debe crear la subcuenta o modificar el ejercicio").arg(datos.codsubcuenta).arg(valoresDefecto.codejercicio), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	return datos;
}


function oficial_dameDatosPagoAsiento(curPago)
{
	var _i = this.iface;

	var oPago = new Object;
	oPago["coddivisa"] = AQUtil.sqlSelect("empresa", "coddivisa", "1 = 1");
	oPago["tasaconv"] = 1;
	return oPago;
}

function oficial_datosPartidaPCAnticipo(curPartida, curPago, valoresDefecto, datosAsiento, oPago)
{
	return true;
}

function oficial_ponAgenteActivo(codAgente)
{
	var _i = this.iface;
// 	if (!codAgente || codAgente == "") {
// 		if (!_i.agenteActivo_ || _i.agenteActivo_ == "") {
// 			var codTerminal = _i.valorDefectoTPV("codterminal");
// 			if(codTerminal) {
// 				codAgente = AQUtil.sqlSelect("tpv_puntosventa","codtpv_agente","codtpv_puntoventa = '" + codTerminal + "'");
// 			} else {
// 				codAgente = false;
// 			}
// 			_i.agenteActivo_ = codAgente;
// 		}
// 	} else {
// 		if (!AQUtil.sqlSelect("tpv_agentes","codtpv_agente","codtpv_agente = '" + codAgente + "'")) {
// 			codAgente = false;
// 		}
		_i.agenteActivo_ = codAgente;
// 	}
	return true;
}

function oficial_cambiarAgenteActivo(codAgente,noAutentificar)
{
  var _i = this.iface;
  var codAA = _i.validarAgente(codAgente,noAutentificar);
  if (!codAA) {
    return false;
  }
  _i.agenteActivo_ = codAA;
  return true;
}

function oficial_validarAgente(codAgente,noAutentificar)
{
	var _i = this.iface;

	var usuario = sys.nameUser();
	var f = new FLFormSearchDB("tpv_claveacceso");
	var cursor = f.cursor();

	cursor.setActivatedCheckIntegrity(false);
	cursor.select("usuario = '" + usuario + "'");
	if (!cursor.first()) {
		cursor.setModeAccess(cursor.Insert);
	} else {
		cursor.setModeAccess(cursor.Edit);
	}

	f.setMainWidget();
	cursor.refreshBuffer();
	cursor.setValueBuffer("usuario", usuario);
	cursor.setValueBuffer("codtpv_agente", codAgente);
	cursor.setValueBuffer("ok", false);
	cursor.setValueBuffer("noautentificar", noAutentificar);
	var acpt= f.exec("id");

	if (!acpt) {
		return false;
	}
	if (!cursor.valueBuffer("ok")) {
		MessageBox.warning(sys.translate("Clave incorrecta"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
		return false;
	}
  return cursor.valueBuffer("codtpv_agente");
}

function oficial_actualizarSaldo(refVale)
{
	var _i = this.iface;
	var curC = new FLSqlCursor("tpv_comandas");
	curC.setActivatedCommitActions(false);
	curC.select("codigo = '" + refVale + "'");
	if (!curC.first()) {
		return false;
	}
	curC.setModeAccess(curC.Edit);
	curC.refreshBuffer();
	curC.setValueBuffer("saldoconsumido", formRecordtpv_comandas.iface.pub_commonCalculateField("saldoconsumido", curC));
	curC.setValueBuffer("saldopendiente", formRecordtpv_comandas.iface.pub_commonCalculateField("saldopendiente", curC));
	if (!_i.datosActualizarSaldo(curC)) {
		return false;
	}
	if (!curC.commitBuffer()) {
		return false;
	}
	return true;
}

function oficial_datosActualizarSaldo(curC)
{
	return true;
}

function oficial_controlDatosMod(curT)
{
 	var _i = this.iface;
	switch (curT.modeAccess()) {
		case curT.Insert: {
			var d = new Date;
			curT.setValueBuffer("idusuarioalta", sys.nameUser());
			curT.setValueBuffer("idusuariomod", sys.nameUser());
			curT.setValueBuffer("fechaalta", d.toString());
			curT.setValueBuffer("fechamod", d.toString());
			break;
		}
		case curT.Edit: {
			if (!_i.registrarCambioCursor(curT)) {
				break;
			}
			var d = new Date;
			curT.setValueBuffer("idusuariomod", sys.nameUser());
			curT.setValueBuffer("fechamod", d.toString());
			break;
		}
	}
	return true;
}

function oficial_registrarCambioCursor(curT)
{
	switch (curT.table()) {
		case "x": {
			return true;
		}
		default: {
			return true;
		}
	}
	return true;
}

function oficial_controlDevolEfectivo(curPago)
{
  var _i = this.iface;

  var importe = curPago.valueBuffer("importe");
  if (importe >= 0) {
    return true;
  }
  if (!flfact_tpv.iface.pub_valorDefectoTPV("autagentedevol")) {
    return true;
  }
  var codPago = curPago.valueBuffer("codpago");
  var codPagoVale = flfact_tpv.iface.pub_valorDefectoTPV("pagovale");
  if (!codPagoVale || codPagoVale == ""){
    MessageBox.information(sys.translate("No tiene configurada la forma de pago en vales en el formulario de datos generales"), MessageBox.Ok, MessageBox.NoButton);
  }
  if (codPago == codPagoVale) {
    return true;
  }

  var codAgente = _i.validaAgenteDevolEfectivo();
  if (!codAgente) {
    return false;
  }
  curPago.setValueBuffer("codtpv_agente", codAgente);
  return true;
}

function oficial_validaAgenteDevolEfectivo()
{
  return flfact_tpv.iface.pub_validarAgente(flfact_tpv.iface.agenteActivo_);
}

function oficial_estableceImpresoraPV(codPuntoVenta)
{
	var _i = this.iface;

	if (!codPuntoVenta) {
		codPuntoVenta = flfact_tpv.iface.pub_valorDefectoTPV("codterminal");;
		if (!codPuntoVenta) {
			codPuntoVenta = AQUtil.sqlSelect("tpv_puntosventa", "codtpv_puntoventa", "1 = 1") ;
		}
	}

	var imp= flfactppal.iface.pub_ejecutarQry("tpv_puntosventa", "tipoimpresora,impresora,impresoratermica,abrircajon,esccortarpapel,escbarcode,esclogo", "codtpv_puntoventa = '" + codPuntoVenta + "'");
	if (imp.result != 1) {
		return false;
	}
	_i.oImpresoraPV_ = new Object;
	_i.oImpresoraPV_["nombre"] = imp.tipoimpresora == "ESC-POS" ? imp.impresora : imp.impresoratermica;
	_i.oImpresoraPV_["tipo"] = imp.tipoimpresora;
	_i.oImpresoraPV_["esccajon"] = imp.abrircajon;
	_i.oImpresoraPV_["esccortarpapel"] = imp.esccortarpapel;
	_i.oImpresoraPV_["escbarcode"] = imp.escbarcode;
	_i.oImpresoraPV_["esclogo"] = imp.esclogo;
	if (_i.oImpresoraPV_["tipo"] == "ESC-POS") {
		_i.establecerImpresora(_i.oImpresoraPV_["nombre"]);
	}
	return _i.oImpresoraPV_;
}

function oficial_dameImpresoraPV()
{
	var _i = this.iface;
	return _i.oImpresoraPV_;
}

function oficial_dameString2Hex(s)
{
  if (!s || s == "") {
    return "";
  }
  var hexCode = "0123456789ABCDEF";
  var c, sHex = "";
  for (var i = 0; i < s.length; i++) {
    c = s.charCodeAt(i);
    p2 = c % 16;
    p1 = (c - p2) / 16;
    sHex += sHex != "" ? "," : "";
    sHex += hexCode.charAt(p1);
    sHex += hexCode.charAt(p2);
  }
  return sHex;
}

function oficial_esUnaTienda()
{
	var _i = this.iface;
	if (_i.esBDLocal()) {
		return true;
	}
	/// Para las conexiones online con la BD central desde tiendas
	if (_i.valorDefectoTPV("codterminal")) {
		return true;
	}
	return false;
}

function oficial_esBDLocal()
{
	/// Función a sobrecargar por sincro_tpv. Sirve para preparar otras extensiones de TPV para la sincronización
  return false;
}

function oficial_totalPagosArqueo(curP)
{
	var _i = this.iface;
	var codArqueo = curP.valueBuffer("idtpv_arqueo");
	var codPago = curP.valueBuffer("codpago");
	if (!_i.totalizaPagosArqueo(codArqueo, codPago)) {
		return false;
	}
	if (curP.modeAccess() == curP.Edit) {
		var codPagoAnt = curP.valueBufferCopy("codpago");
		if (codPagoAnt && codPagoAnt != codPago) {
			if (!_i.totalizaPagosArqueo(codArqueo, codPagoAnt)) {
				return false;
			}
		}
	}
	return true;
}

function oficial_totalizaPagosArqueo(codArqueo, codPago)
{
	var _i = this.iface;
	if (!_i.codPagosTPV_) {
		_i.codPagosTPV_ = new Object;
		var pE = _i.valorDefectoTPV("pagoefectivo");
		if (!pE || pE == "") {
			sys.warnMsgBox(sys.translate("Debe indicar una forma de pago en efectivo en el formulario de configuración del módulo de TPV"));
			return false;
		}
		var pT = _i.valorDefectoTPV("pagotarjeta");
		if (!pT || pT == "") {
			sys.warnMsgBox(sys.translate("Debe indicar una forma de pago con tarjeta en el formulario de configuración del módulo de TPV"));
			return false;
		}
		var pV = _i.valorDefectoTPV("pagovale");
		if (!pV || pV == "") {
			sys.warnMsgBox(sys.translate("Debe indicar una forma de pago con vale en el formulario de configuración del módulo de TPV"));
			return false;
		}

		_i.codPagosTPV_[pE] = "pagosefectivo";
		_i.codPagosTPV_[pT] = "pagostarjeta";
		_i.codPagosTPV_[pV] = "pagosvale";
	}
	if (!(codPago in _i.codPagosTPV_)) {
		return false;
	}
	var campoPago = _i.codPagosTPV_[codPago];
	var curArqueo = new FLSqlCursor("tpv_arqueos");
	curArqueo.select("idtpv_arqueo = '" + codArqueo + "'");
	if (!curArqueo.first()) {
		return false;
	}

	curArqueo.setModeAccess(curArqueo.Edit);
	curArqueo.refreshBuffer();
	curArqueo.setValueBuffer(campoPago, formRecordtpv_arqueos.iface.pub_commonCalculateField(campoPago, curArqueo));
	if(campoPago == "pagosvale"){
		curArqueo.setValueBuffer("devolucionesvale", formRecordtpv_arqueos.iface.pub_commonCalculateField("devolucionesvale", curArqueo));
	}
	curArqueo.setValueBuffer("totalpagos", formRecordtpv_arqueos.iface.pub_commonCalculateField("totalpagos", curArqueo));
	if (!curArqueo.commitBuffer()) {
		return false;
	}
	return true;
}

function oficial_marcaHoraComanda(curC)
{
	if (curC.modeAccess() != curC.Insert) {
		return true;
	}
	var d = new Date;
	curC.setValueBuffer("hora", d.toString().right(8));
	return true;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
