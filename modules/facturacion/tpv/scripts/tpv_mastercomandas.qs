/***************************************************************************
                 tpv_mastercomandas.qs  -  description
                             -------------------
    begin                : mar nov 15 2005
    copyright            : Por ahora (C) 2005 by InfoSiAL S.L.
    email                : lveb@telefonica.net
 ***************************************************************************/
/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundatsetton; either version 2 of the License, or     *
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
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna
{
  var tbnBlocDesbloc;
  var tdbRecords;
  var ckbSoloHoy;
  var ckbSoloPV;
	var curComandaCopia_;
	var curLineaComandaCopia_;
	var curPagoComandaCopia_;
	var masterComandasCargada_ = false;
	var hayLineas_;
	
  function oficial(context)
  {
    interna(context);
  }
  function abrirComanda_clicked()
  {
    return this.ctx.oficial_abrirComanda_clicked();
  }
  function abrirComanda(idComanda)
  {
    return this.ctx.oficial_abrirComanda(idComanda);
  }
  function eliminarFactura(idFactura)
  {
    return this.ctx.oficial_eliminarFactura(idFactura);
  }
  function imprimir_clicked()
  {
    return this.ctx.oficial_imprimir_clicked();
  }
  function imprimirTiqueComanda(codComanda)
  {
    return this.ctx.oficial_imprimirTiqueComanda(codComanda);
  }
  function imprimirTiqueSeleccionado(quick)
  {
    return this.ctx.oficial_imprimirTiqueSeleccionado(quick);
  }
  function imprimirFactura_clicked()
  {
    return this.ctx.oficial_imprimirFactura_clicked();
  }
  function abrirCajon_clicked()
  {
    return this.ctx.oficial_abrirCajon_clicked();
  }
  function imprimirQuick_clicked()
  {
    return this.ctx.oficial_imprimirQuick_clicked();
  }
  function abrirCajon(impresora, escAbrir)
  {
    return this.ctx.oficial_abrirCajon(impresora, escAbrir);
  }
  function imprimirQuick(codComanda)
  {
    return this.ctx.oficial_imprimirQuick(codComanda);
  }
  function filtrarVentas()
  {
    return this.ctx.oficial_filtrarVentas();
  }
  function filtroVentas()
  {
    return this.ctx.oficial_filtroVentas();
  }
  function filtroHoy(filtro)
  {
    return this.ctx.oficial_filtroHoy(filtro);
  }
  function filtroTerminal(filtro)
  {
    return this.ctx.oficial_filtroTerminal(filtro);
  }
  function filtroTipoDoc(filtro)
  {
    return this.ctx.oficial_filtroTipoDoc(filtro);
  }
  function imprimirTiquePOS(codComanda, qry)
  {
    return this.ctx.oficial_imprimirTiquePOS(codComanda, qry);
  }
  function imprimirPieTicket(qryTicket)
  {
    return this.ctx.oficial_imprimirPieTicket(qryTicket);
  }
  function imprimirPieVale(qryVale,imprimeLineas)
  {
    return this.ctx.oficial_imprimirPieVale(qryVale,imprimeLineas);
  }
  function imprimirDespedida(agente)
  {
    return this.ctx.oficial_imprimirDespedida(agente);
  }
  function imprimirTotalesComanda(qryTicket)
  {
    return this.ctx.oficial_imprimirTotalesComanda(qryTicket);
  }
  function imprimirTotalesVale(qryTicket,imprimeLineas)
  {
    return this.ctx.oficial_imprimirTotalesVale(qryTicket,imprimeLineas);
  }
  function imprimirPagosComanda(qryTicket)
  {
    return this.ctx.oficial_imprimirPagosComanda(qryTicket);
  }
  function descripcionLinea(aDescripcion, pos, longitud)
  {
    return this.ctx.oficial_descripcionLinea(aDescripcion, pos, longitud);
  }
  function finImpresion()
  {
    return this.ctx.oficial_finImpresion();
  }
  function imprimirTextoPieEmpresa(pieTicket, longLinea)
  {
    return this.ctx.oficial_imprimirTextoPieEmpresa(pieTicket, longLinea);
  }
  function imprimirCabeceraTicket(qryTicket)
  {
    return this.ctx.oficial_imprimirCabeceraTicket(qryTicket);
  }
  function imprimirCabeceraVale(qryTicket,imprimeLineas)
  {
    return this.ctx.oficial_imprimirCabeceraVale(qryTicket,imprimeLineas);
  }
  function imprimirLineaTicket(qryTicket)
  {
    return this.ctx.oficial_imprimirLineaTicket(qryTicket);
  }
  function imprimirLineaVale(qryVale)
  {
    return this.ctx.oficial_imprimirLineaVale(qryVale);
  }
  function adornosCabeceraVale(qryVale)
  {
    return this.ctx.oficial_adornosCabeceraVale(qryVale);
  }
  function datosListadoComandasVale(listadoComandas)
  {
    return this.ctx.oficial_datosListadoComandasVale(listadoComandas);
  }
  function adornosCabeceraTicket(qryTicket)
  {
    return this.ctx.oficial_adornosCabeceraTicket(qryTicket);
  }
  function adornosCabeceraTicketRegalo(qryTicket)
  {
    return this.ctx.oficial_adornosCabeceraTicketRegalo(qryTicket);
  }
  function datosTiqueEmpresa(qryTicket)
  {
    return this.ctx.oficial_datosTiqueEmpresa(qryTicket);
  }
  function imprimirCabeceraTicketRegalo(qryTicket)
  {
    return this.ctx.oficial_imprimirCabeceraTicketRegalo(qryTicket);
  }
  function imprimirLineaTicketRegalo(qryTicket)
  {
    return this.ctx.oficial_imprimirLineaTicketRegalo(qryTicket);
  }
  function imprimirPieTicketRegalo(qryTicket)
  {
    return this.ctx.oficial_imprimirPieTicketRegalo(qryTicket);
  }
  function imprimirVale(idTpvComanda)
  {
    return this.ctx.oficial_imprimirVale(idTpvComanda);
  }
  function imprimirValeKugar(idTpvComanda)
  {
    return this.ctx.oficial_imprimirValeKugar(idTpvComanda);
  }
  function imprimirValePOS(idTpvComanda)
  {
    return this.ctx.oficial_imprimirValePOS(idTpvComanda);
  }
  function esPrimerValeEmitido(qryVale)
  {
    return this.ctx.oficial_esPrimerValeEmitido(qryVale);
  }
  function dameParamInformeVale(idTpvComanda)
  {
    return this.ctx.oficial_dameParamInformeVale(idTpvComanda);
  }
  function dameParamInformeComanda(idTpvComanda)
  {
    return this.ctx.oficial_dameParamInformeComanda(idTpvComanda);
  }
  function dameWhere(codComanda)
  {
    return this.ctx.oficial_dameWhere(codComanda);
  }
  function dameWhereRegalo(idComanda, cadenaDatos)
  {
    return this.ctx.oficial_dameWhereRegalo(idComanda, cadenaDatos);
  }
  function dameWhereVale(idComanda)
  {
    return this.ctx.oficial_dameWhereVale(idComanda);
  }
  function dameGroupVale()
  {
    return this.ctx.oficial_dameGroupVale();
  }
  function anularVenta_clicked()
  {
    return this.ctx.oficial_anularVenta_clicked();
  }
  function creaComandaNegativa()
  {
    return this.ctx.oficial_creaComandaNegativa();
  }
  function creaComandaRectificada()
  {
    return this.ctx.oficial_creaComandaRectificada();
  }
  function copiarCabeceraComanda(tipoComandaCopia)
  {
    return this.ctx.oficial_copiarCabeceraComanda(tipoComandaCopia);
  }
  function copiarLineasComanda(tipoComandaCopia)
  {
    return this.ctx.oficial_copiarLineasComanda(tipoComandaCopia);
  }
  function copiarPagosComanda()
  {
    return this.ctx.oficial_copiarPagosComanda();
  }
  function copiarCampoComanda(nombreCampo, curOriginal, campoInformado, tipoComandaCopia)
  {
    return this.ctx.oficial_copiarCampoComanda(nombreCampo, curOriginal, campoInformado, tipoComandaCopia);
  }
  function copiarCampoLineaComanda(nombreCampo, curOriginal, campoInformado, tipoComandaCopia)
  {
    return this.ctx.oficial_copiarCampoLineaComanda(nombreCampo, curOriginal, campoInformado, tipoComandaCopia);
  }
	function copiarCampoPago(nombreCampo, curOriginal, campoInformado) {
		return this.ctx.oficial_copiarCampoPago(nombreCampo, curOriginal, campoInformado);
	}
  function imprimirTicketRegalo(idComanda, aDatos)
  {
    return this.ctx.oficial_imprimirTicketRegalo(idComanda, aDatos);
  }
  function imprimirIvas(qryTicket)
  {
    return this.ctx.oficial_imprimirIvas(qryTicket);
  }
	function dameMasFormasPago(idComanda)
	{
		return this.ctx.oficial_dameMasFormasPago(idComanda);
	}
  function imprimirTiquePOSRegalo(qry)
  {
    return this.ctx.oficial_imprimirTiquePOSRegalo(qry);
  }
  function valoresLocales() {
    return this.ctx.oficial_valoresLocales();
  }
  function comprobarTpv() {
    return this.ctx.oficial_comprobarTpv();
  }
	function pushButtonCancel_clicked() {
		return this.ctx.oficial_pushButtonCancel_clicked();
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
  function pub_imprimirTiqueComanda(codComanda)
  {
    return this.imprimirTiqueComanda(codComanda);
  }
  function pub_abrirCajon(impresora, escAbrir)
  {
    return this.abrirCajon(impresora, escAbrir);
  }
  function pub_imprimirQuick(codComanda)
  {
    return this.imprimirQuick(codComanda);
  }
  function pub_imprimirVale(idTpvComanda)
  {
    return this.imprimirVale(idTpvComanda);
  }
  function pub_imprimirValePOS(idTpvComanda)
  {
    return this.imprimirValePOS(idTpvComanda);
  }
  function pub_imprimirTicketRegalo(idComanda, aDatos)
  {
    return this.imprimirTicketRegalo(idComanda, aDatos);
  }
  function pub_datosTiqueEmpresa(qryTicket)
  {
    return this.datosTiqueEmpresa(qryTicket);
  }
  function pub_finImpresion()
  {
    return this.finImpresion();
  }
  function pub_imprimirTextoPieEmpresa(texto, longLinea)
  {
    return this.imprimirTextoPieEmpresa(texto, longLinea);
  }
  function pub_valoresLocales()
  {
    return this.valoresLocales();
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
function interna_init()
{
	var _i = this.iface;
	_i.masterComandasCargada_ = true;
  _i.tbnBlocDesbloc = this.child("tbnBlocDesbloc");
  _i.tdbRecords = this.child("tableDBRecords");
  _i.ckbSoloHoy = this.child("ckbSoloHoy");
  _i.ckbSoloPV = this.child("ckbSoloPV");

  connect(_i.tbnBlocDesbloc, "clicked()", _i, "abrirComanda_clicked()");
  connect(this.child("toolButtonPrint"), "clicked()", _i, "imprimir_clicked()");
  connect(this.child("tbnPrintQuick"), "clicked()", _i, "imprimirQuick_clicked()");
  connect(this.child("tbnOpenCash"), "clicked()",  _i, "abrirCajon_clicked()");
  connect(this.child("tbnImprimirFactura"), "clicked()",  _i, "imprimirFactura_clicked()");
  connect(this.child("tbnAnularVenta"), "clicked()",  _i, "anularVenta_clicked()");
  connect(this.child("ckbSoloHoy"), "clicked()",  _i, "filtrarVentas()");
  connect(this.child("ckbSoloPV"), "clicked()",  _i, "filtrarVentas()");
  connect(this.child("cmbTipoDoc"), "activated(QString)", _i, "filtrarVentas()");

	disconnect(this.child("pushButtonCancel"), "clicked()", this.obj(), "reject()");
	connect(this.child("pushButtonCancel"), "clicked()", _i, "pushButtonCancel_clicked");
	
	_i.valoresLocales();
//   flfact_tpv.iface.pub_actualizarAgenteVentas();	
  _i.filtrarVentas();
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D
Abre una comanda
No se podrá abir una comanda si su arqueo está cerrado
@return Boolean, devuelve true si todo se ha ejecutado correctamente y false si hay algún error
*/
function oficial_abrirComanda_clicked()
{
  var _i = this.iface;
  var cursor = this.cursor();
  var idFactura = cursor.valueBuffer("idfactura");
  var idComanda = cursor.valueBuffer("idtpv_comanda");
  if (!idComanda)
    return false;

  if (cursor.valueBuffer("estado") == "Abierta") {
    MessageBox.warning(sys.translate("La venta ya está abierta"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
    return true;
  }

  /*
  if (!AQUtil.sqlSelect("tpv_arqueos", "abierta", "idtpv_arqueo = '" + cursor.valueBuffer("idtpv_arqueo") + "'")) {
    MessageBox.warning(sys.translate("No pueden abrirse ventas asociadas a un arqueo cerrado"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
    return true;
  }
  */

  var res = MessageBox.warning(sys.translate("Va a abrir la venta seleccionada"), MessageBox.Ok, MessageBox.Cancel);
  if (res != MessageBox.Ok)
    return true;

  cursor.transaction(false);
  try {
    if (_i.abrirComanda(idComanda))
      cursor.commit();
    else {
      cursor.rollback();
      return false;
    }
  } catch (e) {
    cursor.rollback();
    MessageBox.critical(sys.translate("Hubo un error en la apertura de la venta:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
  }

  _i.tdbRecords.refresh();

  return true;
}

/** \D Abre la comanda
@param  idComanda: identificador de la comanda
@return true si la comanda se abre correctamente, false en caso contrario
\end */
function oficial_abrirComanda(idComanda)
{
  var _i = this.iface;
  var curComanda = new FLSqlCursor("tpv_comandas");
  curComanda.select("idtpv_comanda = " + idComanda);
  if (!curComanda.first())
    return false;
  curComanda.setUnLock("editable", true)

  curComanda.select("idtpv_comanda = " + idComanda);
  if (!curComanda.first())
    return false;

  curComanda.setModeAccess(curComanda.Edit);
  curComanda.refreshBuffer();
  curComanda.setValueBuffer("estado", "Abierta");
  if (!curComanda.commitBuffer())
    return false;

  return true;
}
/** \D
Elimina los el pago, recibo y factura que corresponden a la comanda
@param idFactura identificador de la factura a borrar
@return Boolean, devuelve true si todo se ha ejecutado correctamente y fasle si hay algún error
*/
function oficial_eliminarFactura(idFactura)
{
  var _i = this.iface;
  var curFactura = new FLSqlCursor("facturascli");
  curFactura.select("idfactura = " + idFactura);
  if (!curFactura.first())
    return false;
  var codRecibo = curFactura.valueBuffer("codigo") + "-01";
  if (AQUtil.sqlSelect("reciboscli", "estado", "codigo = '" + codRecibo + "'") == "Pagado") {
    var idrecibo = AQUtil.sqlSelect("reciboscli", "idrecibo", "codigo = '" + codRecibo + "'");
    var curPagos = new FLSqlCursor("pagosdevolcli");
    curPagos.select("idrecibo = " + idrecibo);
    if (!curPagos.first())
      return false;
    curPagos.setModeAccess(curPagos.Del);
    curPagos.refreshBuffer();
    if (!curPagos.commitBuffer())
      return false;
    var curRecibos = new FLSqlCursor("reciboscli");
    curRecibos.select("idrecibo = " + idrecibo);
    if (!curRecibos.first())
      return false;
    curRecibos.setModeAccess(curRecibos.Edit);
    curRecibos.refreshBuffer();
    curRecibos.setValueBuffer("estado", "Emitido");
    if (!curRecibos.commitBuffer())
      return false;
    curFactura.setUnLock("editable", true);
  }
  curFactura.setModeAccess(curFactura.Del);
  curFactura.refreshBuffer();
  if (!curFactura.commitBuffer())
    return false;
  return true;
}

/** \D
Abre una transacción y llama a la función ImprimirTiqueComanda
*/
function oficial_imprimir_clicked()
{
  var _i = this.iface;
  _i.imprimirTiqueSeleccionado(false);
  
  /*
var cursor = this.cursor();
  var codComanda = cursor.valueBuffer("codigo");
  var idTpvComanda = cursor.valueBuffer("idtpv_comanda");
	var tipoDoc = cursor.valueBuffer("tipodoc");
  if (!codComanda){
    return false;
	}
	switch(tipoDoc){
		case "DEVOLUCION":{
			_i.imprimirVale(idTpvComanda);
			break;
		}
		default:{
			_i.imprimirTiqueComanda(codComanda);
			formRecordtpv_comandas.iface.pub_imprimirValesUsados(cursor);
			break;
		}
	}
  _i.tdbRecords.cursor().refresh();
  */
}

/** \D
Si el módulo de informes no está cargado muestra un mensaje de aviso y si lo está lanza el informe correspondiente
@param codComanda codigo de la comanda a imprimir
@return true si se imprime correctamente y false si ha algún error
*/
function oficial_imprimirTiqueComanda(codComanda)
{
	var _i = this.iface;
  var cursor = this.cursor();
	var idTpvComanda = AQUtil.sqlSelect("tpv_comandas", "idtpv_comanda", "codigo = '" + codComanda+ "'");
	
	var oParam = _i.dameParamInformeComanda(idTpvComanda);
	if (!oParam) {
		return;
	}
	
  if (sys.isLoadedModule("flfactinfo")) {
    var curImprimir = new FLSqlCursor("tpv_i_comandas");
    curImprimir.setModeAccess(curImprimir.Insert);
    curImprimir.refreshBuffer();
    curImprimir.setValueBuffer("descripcion", "temp");
    curImprimir.setValueBuffer("d_tpv__comandas_codigo", codComanda);
    curImprimir.setValueBuffer("h_tpv__comandas_codigo", codComanda);
    flfactinfo.iface.pub_lanzaInforme(curImprimir, oParam);
  } else
    flfactppal.iface.pub_msgNoDisponible("Informes");

}

/** \D
Manda a imprimir directamente a la impresora la comanda actualmente seleccionada
*/
function oficial_imprimirQuick_clicked()
{
	var _i = this.iface;
  _i.imprimirTiqueSeleccionado(true);
}

function oficial_imprimirTiqueSeleccionado(quick)
{
  var _i = this.iface;
  var cursor = this.cursor();
  var codComanda = cursor.valueBuffer("codigo");
  var idTpvComanda = cursor.valueBuffer("idtpv_comanda");
  var tipoDoc = cursor.valueBuffer("tipodoc");
  if (!codComanda){
    return false;
  }
  switch(tipoDoc){
  case "DEVOLUCION":{
      _i.imprimirVale(idTpvComanda);
			/// Se vuelve a imprimir el tique porque en la devolución puede haber comprado algo de menor valor que puede a su vez ser devuelto, y es necesario como justificante.
			if (quick) {
        _i.imprimirQuick(cursor.valueBuffer("codigo"));
      } else {
        _i.imprimirTiqueComanda(codComanda);
      }
      break;
    }
  default:{
      if (quick) {
        _i.imprimirQuick(cursor.valueBuffer("codigo"));
      } else {
        _i.imprimirTiqueComanda(codComanda);
      }
      formRecordtpv_comandas.iface.pub_imprimirValesUsados(cursor);
      break;
    }
  }
}

function oficial_imprimirQuick(codComanda)
{
  var _i = this.iface;
  var q = new FLSqlQuery("tpv_i_comandas");
  
  q.setWhere(_i.dameWhere(codComanda));
  if (!q.exec()) {
    MessageBox.critical(sys.translate("Falló la consulta"), MessageBox.Ok, MessageBox.NoButton);
    return;
  } else {
    if (!q.first()) {
      MessageBox.warning(sys.translate("No hay registros que cumplan los criterios de búsqueda establecidos"), MessageBox.Ok, MessageBox.NoButton);
      return;
    }
  }
  
  var oImp = flfact_tpv.iface.pub_estableceImpresoraPV();
	if (!oImp) {
		return false;
	}
	if (oImp.tipo == "ESC-POS") {
    _i.imprimirTiquePOS(codComanda, q);
  } else {
//     var pixel = AQUtil.sqlSelect("tpv_puntosventa", "pixel",
//                                "codtpv_puntoventa = '" + codPuntoVenta + "'");
//     if (!pixel || isNaN(pixel)) {
//       pixel = 0;
//     }
//     var resolucion = AQUtil.sqlSelect("tpv_puntosventa", "resolucion",
//                                     "codtpv_puntoventa = '" + codPuntoVenta + "'");
//     if (!resolucion || isNaN(resolucion)) {
//       resolucion = 0;
//     }
    var rptViewer = new FLReportViewer();
		/* Porque se queda y el resto de informes sale deformado
    if (pixel != 0) {
      rptViewer.setPixel(pixel);
    }
    if (resolucion != 0) {
      rptViewer.setResolution(resolucion);
    }
		*/
    rptViewer.setReportTemplate("tpv_i_comandas");
    rptViewer.setReportData(q);
    rptViewer.renderReport();
    rptViewer.setPrinterName(oImp.nombre);
		rptViewer.printReport();
  }
  return true;
}

function oficial_imprimirTiquePOS(codComanda, qryTicket)
{
  var _i = this.iface;
	
	flfact_tpv.iface.pub_establecerImpresora();
  
  var primerRegistro = true;
  if (!qryTicket.exec()) {
    return false;
  }
  while (qryTicket.next()) {
    if (primerRegistro) {
			if (!_i.adornosCabeceraTicket(qryTicket)) {
				return false;
			}
      if (!_i.datosTiqueEmpresa(qryTicket)) {
        return false;
      }
      _i.imprimirCabeceraTicket(qryTicket);
    }

    primerRegistro = false;
		_i.imprimirLineaTicket(qryTicket);
  }

	if(!qryTicket.first()){
		return false;
	}
	_i.imprimirPieTicket(qryTicket);
	
	_i.finImpresion();

/// Eliminado porque parece que corta dos veces el papel en ciertas instalaciones
// 	var printer:FLPosPrinter = new FLPosPrinter();
// 	printer.setPrinterName( impresora );
// 	printer.send( "ESC:1B,64,05,1B,69" );
// 	printer.flush();
}

function oficial_imprimirCabeceraTicket(qryTicket)
{ 
	flfact_tpv.iface.impNuevaLinea(2);
	//flfact_tpv.iface.imprimirDatos(sys.translate("Nº Ticket") + ": " + qryTicket.value("tpv_comandas.codigo"));
	/**debido al cambio en la facturación que se impone a partir del 1 de enero de 2013, se sustituyen los tickets por facturas simplificadas para ventas al por menor, se modifica el texto de los tiquets:
	ej.:"Nº Fact.Simplificada/nº serie: AFUE00001756 / AFUE"
*/
	flfact_tpv.iface.imprimirDatos(sys.translate("Nº fact.simp./nº serie:") + qryTicket.value("tpv_comandas.codigo") + "/" + qryTicket.value("tpv_comandas.codigo").left(4), 40,0);
	flfact_tpv.iface.impNuevaLinea();
	flfact_tpv.iface.imprimirDatos(sys.translate("Fecha") + ": " + AQUtil.dateAMDtoDMA(qryTicket.value("tpv_comandas.fecha")));

	var hora = qryTicket.value("tpv_comandas.hora").toString();
	hora = hora.right(8);
	hora = hora.left(5);
	flfact_tpv.iface.imprimirDatos("   " + sys.translate("Hora") + ": " + hora);
	flfact_tpv.iface.impNuevaLinea(2);
	flfact_tpv.iface.imprimirDatos(sys.translate("ARTICULO"), 20);
	flfact_tpv.iface.imprimirDatos(sys.translate("CANTIDAD"), 10, 2);
	flfact_tpv.iface.imprimirDatos(sys.translate("IMPORTE"), 10, 2);
	flfact_tpv.iface.impNuevaLinea();
}

function oficial_imprimirCabeceraVale(qryVale, imprimeLineas)
{ 
	flfact_tpv.iface.impNuevaLinea(2);
	flfact_tpv.iface.imprimirDatos(sys.translate("Nº Vale") + ": " + qryVale.value("tpv_comandas.codigo"));
	flfact_tpv.iface.impNuevaLinea();
	flfact_tpv.iface.imprimirDatos(sys.translate("Fecha") + ": " + AQUtil.dateAMDtoDMA(qryVale.value("tpv_comandas.fecha")));

	var hora = qryVale.value("tpv_comandas.hora").toString();
	hora = hora.right(8);
	hora = hora.left(5);
	flfact_tpv.iface.imprimirDatos("   " + sys.translate("Hora") + ": " + hora);
	flfact_tpv.iface.impNuevaLinea(2);
	flfact_tpv.iface.impAlinearH(1);
	flfact_tpv.iface.impResaltar(true);
	flfact_tpv.iface.imprimirDatos("*** " + sys.translate("VALE DE DEVOLUCIÓN") + " ***");
	flfact_tpv.iface.impNuevaLinea();
	flfact_tpv.iface.impResaltar(false);
	flfact_tpv.iface.impAlinearH(0);
	
	if (imprimeLineas) {
		flfact_tpv.iface.impNuevaLinea();
		flfact_tpv.iface.imprimirDatos(sys.translate("ARTICULO"), 20);
		flfact_tpv.iface.imprimirDatos(sys.translate("CANTIDAD"), 10, 2);
		flfact_tpv.iface.imprimirDatos(sys.translate("IMPORTE"), 10, 2);
		flfact_tpv.iface.impNuevaLinea();
	}
}

function oficial_imprimirLineaTicket(qryTicket)
{
	var cantidad = qryTicket.value("tpv_lineascomanda.cantidad");
	var totalLinea = qryTicket.value("tpv_lineascomanda.pvptotal");
	var totalLinea = AQUtil.roundFieldValue(totalLinea, "tpv_comandas", "total");

	descripcion = qryTicket.value("tpv_lineascomanda.descripcion");

	flfact_tpv.iface.imprimirDatos(descripcion, 20);
	flfact_tpv.iface.imprimirDatos(cantidad, 10, 2);
	flfact_tpv.iface.imprimirDatos(totalLinea, 10, 2);
	flfact_tpv.iface.impNuevaLinea();
}

function oficial_imprimirLineaVale(qryVale)
{
	var _i = this.iface;
	_i.imprimirLineaTicket(qryVale);
}

function oficial_imprimirPieTicket(qryTicket)
{
	var _i = this.iface;
	
	var agente = qryTicket.value("tpv_agentes.descripcion");
	
	_i.imprimirTotalesComanda(qryTicket);
	
	_i.imprimirPagosComanda(qryTicket);
	
	_i.imprimirIvas(qryTicket);
	
	_i.imprimirDespedida(agente);
	
	if (qryTicket.value("empresa.pieticket")) {
		_i.imprimirTextoPieEmpresa(qryTicket.value("empresa.pieticket"), 40)
	}
  flfact_tpv.iface.impBarcode(qryTicket.value("tpv_comandas.codigo"));
}

function oficial_imprimirPieVale(qryVale,imprimeLineas)
{
  var _i = this.iface;

  var agente = qryVale.value("tpv_agentes.descripcion");
	
  _i.imprimirTotalesVale(qryVale,imprimeLineas);
	
  flfact_tpv.iface.impBarcode(qryVale.value("tpv_comandas.codigo"));
  flfact_tpv.iface.impNuevaLinea();
// 	if(imprimeLineas) {
// 		_i.imprimirDespedida(agente);
// 	
// 		if(qryVale.value("empresa.pieticket")){
// 			_i.imprimirTextoPieEmpresa(qryTicket.value("empresa.pieticket"), 40)
// 		}
// 	}
}

function oficial_imprimirDespedida(agente)
{
  flfact_tpv.iface.impAlinearH(1);

  flfact_tpv.iface.impNuevaLinea();
  flfact_tpv.iface.imprimirDatos(sys.translate("GRACIAS POR SU VISITA"));
  flfact_tpv.iface.impAlinearH(0);
  flfact_tpv.iface.impNuevaLinea(2);
  flfact_tpv.iface.impSubrayar(true);
  flfact_tpv.iface.imprimirDatos(sys.translate("Le atendió") + ":");
  flfact_tpv.iface.impSubrayar(false);
  flfact_tpv.iface.imprimirDatos("   " + agente);
  flfact_tpv.iface.impNuevaLinea();
}

function oficial_imprimirTotalesComanda(qryTicket)
{
	var _i = this.iface;
	
	var totaliva = AQUtil.roundFieldValue(qryTicket.value("tpv_comandas.totaliva"), "tpv_comandas", "totaliva");
	var neto = AQUtil.roundFieldValue(qryTicket.value("tpv_comandas.neto"), "tpv_comandas", "neto");
	var total = AQUtil.roundFieldValue(qryTicket.value("tpv_comandas.total"), "tpv_comandas", "total");
	
  flfact_tpv.iface.impNuevaLinea();
  flfact_tpv.iface.imprimirDatos(sys.translate("Total Neto"), 30);
  flfact_tpv.iface.imprimirDatos(neto, 10, 2);
  flfact_tpv.iface.impNuevaLinea();
  flfact_tpv.iface.imprimirDatos(sys.translate("Total I.V.A."), 30);
  flfact_tpv.iface.imprimirDatos(totaliva, 10, 2);
  flfact_tpv.iface.impNuevaLinea();
  flfact_tpv.iface.imprimirDatos(sys.translate("Total Ticket"), 30);
  flfact_tpv.iface.imprimirDatos(total, 10, 2);
}

function oficial_imprimirTotalesVale(qryVale,imprimeLineas)
{
	var _i = this.iface;
	
	var total = parseFloat(qryVale.value("tpv_comandas.total"))*-1;
	total = AQUtil.roundFieldValue(total, "tpv_comandas", "total");
	var saldo = AQUtil.roundFieldValue(qryVale.value("tpv_comandas.saldopendiente"), "tpv_comandas", "total");
	
	flfact_tpv.iface.impNuevaLinea();
	
	if(!imprimeLineas) {
			flfact_tpv.iface.imprimirDatos(sys.translate("Saldo Inicial"), 30);
	}
	else {
		var totaliva = parseFloat(qryVale.value("tpv_comandas.totaliva"))*-1;
		totaliva = AQUtil.roundFieldValue(totaliva, "tpv_comandas", "totaliva");
		var neto = parseFloat(qryVale.value("tpv_comandas.neto"))*-1;
		neto = AQUtil.roundFieldValue(neto, "tpv_comandas", "neto");
		
		flfact_tpv.iface.imprimirDatos(sys.translate("Total Neto"), 30);
		flfact_tpv.iface.imprimirDatos(neto, 10, 2);
		flfact_tpv.iface.impNuevaLinea();
		flfact_tpv.iface.imprimirDatos(sys.translate("Total I.V.A."), 30);
		flfact_tpv.iface.imprimirDatos(totaliva, 10, 2);
		flfact_tpv.iface.impNuevaLinea();
		
		flfact_tpv.iface.imprimirDatos(sys.translate("Total Vale"), 30);		
	}
	  
	flfact_tpv.iface.imprimirDatos(total, 10, 2);
	flfact_tpv.iface.impNuevaLinea();
	flfact_tpv.iface.imprimirDatos(sys.translate("Saldo Actual"), 30);
	flfact_tpv.iface.impResaltar(true);
	flfact_tpv.iface.imprimirDatos(saldo, 10, 2);
	flfact_tpv.iface.impResaltar(true);
	flfact_tpv.iface.impNuevaLinea();
}

function oficial_imprimirTextoPieEmpresa(pieTicket, longLinea)
{
	var _i = this.iface;
	
	if(!longLinea || longLinea == undefined){
		longLinea = 40;
	}
	
	var aPie = pieTicket.split(" ");
	pieTicket = _i.descripcionLinea(aPie, 0, longLinea);
	var pos = 0;
	while(pieTicket != ""){
		flfact_tpv.iface.imprimirDatos(pieTicket, longLinea);
		pieTicket = pieTicket.split(" ");
		pos += pieTicket.length - 1;
		pieTicket = _i.descripcionLinea(aPie, pos, longLinea);
		flfact_tpv.iface.impNuevaLinea();
	}

}

function oficial_finImpresion()
{ 
  flfact_tpv.iface.impNuevaLinea(8);
  flfact_tpv.iface.impCortar();
  flfact_tpv.iface.impNuevaLinea(1);
  flfact_tpv.iface.flushImpresora();
}

function oficial_descripcionLinea(aDescripcion, pos, longitud)
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var linea = "";
	var lineaTemp;
	
	for(var i = pos; i < aDescripcion.length; i++){
		lineaTemp = linea + aDescripcion[i];
		if(lineaTemp.length < longitud){
			linea = lineaTemp + " ";
		}
		else{
			i = aDescripcion.length;
		}
	}
	
	linea = linea.left(longitud);

	return linea;
}

function oficial_imprimirPagosComanda(qryTicket)
{
  var _i = this.iface;
	
	flfact_tpv.iface.impNuevaLinea();
	
	var fpEfectivo = flfact_tpv.iface.pub_valorDefectoTPV("pagoefectivo");
	
	var q = new AQSqlQuery;
	q.setSelect("SUM(importe),COUNT(*)");
	q.setFrom("tpv_pagoscomanda");
	q.setWhere("idtpv_comanda = '" + qryTicket.value("tpv_comandas.idtpv_comanda") + "' AND codpago = '" + fpEfectivo + "' GROUP BY codpago");
	 
	if(!q.exec()){
		debug("No se ha ejecutado la consulta.");
		return;
	}
	if(!q.first()){
		debug("No hay forma de pago en efectivo.");
	}
	var importe = q.value("SUM(importe)");
	var impEfectivo = 0;
	/*var importe = AQUtil.sqlSelect("tpv_pagoscomanda", "SUM(importe)", "idtpv_comanda = '" + qryTicket.value("tpv_comandas.idtpv_comanda") + "' AND codpago = '" + fpEfectivo + "' GROUP BY codpago");*/
	if(importe){
		impEfectivo = importe;
	}
	var ultEntregado = AQUtil.sqlSelect("tpv_comandas","ultentregado","idtpv_comanda = '" + qryTicket.value("tpv_comandas.idtpv_comanda") + "'");
	if(ultEntregado){
		if(ultEntregado > impEfectivo){
			impEfectivo = ultEntregado;
		}
	}
	if(parseFloat(impEfectivo) > 0){
		flfact_tpv.iface.impNuevaLinea();
		flfact_tpv.iface.imprimirDatos(sys.translate("Efectivo") + ":");
		flfact_tpv.iface.imprimirDatos(AQUtil.roundFieldValue(impEfectivo, "tpv_comandas", "total"), 10, 2);
	}
	
	var fpTarjeta = flfact_tpv.iface.pub_valorDefectoTPV("pagotarjeta");
	var impTarjeta = AQUtil.sqlSelect("tpv_pagoscomanda", "SUM(importe)", "idtpv_comanda = '" + qryTicket.value("tpv_comandas.idtpv_comanda") + "' AND codpago = '" + fpTarjeta + "' GROUP BY codpago");
	
	if(impTarjeta){
		flfact_tpv.iface.impNuevaLinea();
		flfact_tpv.iface.imprimirDatos(sys.translate("Tarjeta") + ":");
		flfact_tpv.iface.imprimirDatos(AQUtil.roundFieldValue(impTarjeta, "tpv_comandas", "total"), 10, 2);
	}
	
	var fpVales = flfact_tpv.iface.pub_valorDefectoTPV("pagovale");
	var impVale = AQUtil.sqlSelect("tpv_pagoscomanda", "SUM(importe)", "idtpv_comanda = '" + qryTicket.value("tpv_comandas.idtpv_comanda") + "' AND codpago = '" + fpVales + "' GROUP BY codpago");
	
	if(impVale){
		flfact_tpv.iface.impNuevaLinea();
		flfact_tpv.iface.imprimirDatos(sys.translate("Vales") + ":");
		flfact_tpv.iface.imprimirDatos(AQUtil.roundFieldValue(impVale, "tpv_comandas", "total"), 10, 2);
	}
	
	_i.dameMasFormasPago(qryTicket.value("tpv_comandas.idtpv_comanda"));
		
	flfact_tpv.iface.impNuevaLinea();
	flfact_tpv.iface.imprimirDatos(sys.translate("Cambio") + ":");
	if(parseFloat(q.value("COUNT(*)")) == 1){
		if(parseFloat(impEfectivo) > 0){
			if(impEfectivo == ultEntregado){
				var ultCambio = AQUtil.sqlSelect("tpv_comandas","ultcambio","idtpv_comanda = '" + qryTicket.value("tpv_comandas.idtpv_comanda") + "'");
				if(ultCambio){
					flfact_tpv.iface.imprimirDatos(AQUtil.roundFieldValue(ultCambio, "tpv_comandas", "total"), 10, 2);
				}
				else{
					flfact_tpv.iface.imprimirDatos("0,00", 10, 2);
				}
			}
			else{
				flfact_tpv.iface.imprimirDatos("0,00", 10, 2);
			}
		}
	}
	else{
		flfact_tpv.iface.imprimirDatos("0,00", 10, 2);
	}
	
}

function oficial_imprimirIvas(qryTicket)
{
	var _i = this.iface;
	
	flfact_tpv.iface.impNuevaLinea(2);
	
	var q = new FLSqlQuery();
	q.setSelect("iva,SUM(pvpsindto)");
	q.setFrom("tpv_lineascomanda");
	q.setWhere("idtpv_comanda = '" + qryTicket.value("tpv_comandas.idtpv_comanda") + "' GROUP BY iva");
	q.setForwardOnly(true);
	if (!q.exec()) {
		return false;
	}
	var totalIvaLinea;
	while(q.next()){
	totalIvaLinea = parseFloat(q.value("iva")) * parseFloat(q.value("SUM(pvpsindto)"))/100;
  flfact_tpv.iface.imprimirDatos(AQUtil.roundFieldValue(q.value("iva"),"tpv_comandas", "total") + " " + sys.translate("% I.V.A. de ") + AQUtil.roundFieldValue(q.value("SUM(pvpsindto)"),"tpv_comandas", "total") + ":");
  flfact_tpv.iface.imprimirDatos(AQUtil.roundFieldValue(totalIvaLinea,"tpv_comandas", "total"), 10, 2);
  flfact_tpv.iface.impNuevaLinea();
	}
}

function oficial_dameMasFormasPago(idComanda)
{
	return true;
}

function oficial_imprimirTiquePOSRegalo(qryTicket)
{
  var _i = this.iface;
  
	flfact_tpv.iface.pub_establecerImpresora();
	
  var primerRegistro = true;

  if (!qryTicket.exec()) {
    return false;
  }
  while (qryTicket.next()) {
    if (primerRegistro) {
			if (!_i.adornosCabeceraTicketRegalo(qryTicket)) {
				return false;
			}
      if (!_i.datosTiqueEmpresa(qryTicket)) {
        return false;
      }
      _i.imprimirCabeceraTicketRegalo(qryTicket);
    }

    primerRegistro = false;
		_i.imprimirLineaTicketRegalo(qryTicket);
  }

	if(!qryTicket.first()){
		return false;
	}
  _i.imprimirPieTicketRegalo(qryTicket);

  _i.finImpresion();

/// Eliminado porque parece que corta dos veces el papel en ciertas instalaciones
// 	var printer:FLPosPrinter = new FLPosPrinter();
// 	printer.setPrinterName( impresora );
// 	printer.send( "ESC:1B,64,05,1B,69" );
// 	printer.flush();
}

function oficial_imprimirCabeceraTicketRegalo(qryTicket)
{
	flfact_tpv.iface.impNuevaLinea(2);
	flfact_tpv.iface.imprimirDatos("*** " + sys.translate("TICKET REGALO") + " *** ");
	flfact_tpv.iface.impNuevaLinea(2);
	flfact_tpv.iface.imprimirDatos(sys.translate("Nº Ticket") + ": " + qryTicket.value("tpv_comandas.codigo"));
	flfact_tpv.iface.impNuevaLinea();
	flfact_tpv.iface.imprimirDatos(sys.translate("Fecha") + ": " + AQUtil.dateAMDtoDMA(qryTicket.value("tpv_comandas.fecha")));

	var hora = qryTicket.value("tpv_comandas.hora").toString();
	hora = hora.right(8);
	hora = hora.left(5);
	flfact_tpv.iface.imprimirDatos("   " + sys.translate("Hora") + ": " + hora);
	flfact_tpv.iface.impNuevaLinea(2);
	flfact_tpv.iface.imprimirDatos(sys.translate("REF."), 10);
	flfact_tpv.iface.imprimirDatos(sys.translate("DESCRIPCIÓN"), 20);
	flfact_tpv.iface.imprimirDatos(sys.translate("CANTIDAD"), 10, 2);
	flfact_tpv.iface.impNuevaLinea(2);

	agente = qryTicket.value("tpv_agentes.descripcion");
}

function oficial_imprimirLineaTicketRegalo(qryTicket)
{
	var referencia = qryTicket.value("tpv_lineascomanda.referencia");
	var cantidad = qryTicket.value("tpv_lineascomanda.canregalo");
	var descripcion = qryTicket.value("tpv_lineascomanda.descripcion");
	
	flfact_tpv.iface.imprimirDatos(referencia, 10);
	flfact_tpv.iface.imprimirDatos(descripcion, 20);
	flfact_tpv.iface.imprimirDatos(cantidad, 10, 2);
	flfact_tpv.iface.impNuevaLinea();
}

function oficial_imprimirPieTicketRegalo(qryTicket)
{
	var agente = qryTicket.value("tpv_agentes.descripcion");

	flfact_tpv.iface.impAlinearH(1);

  flfact_tpv.iface.impNuevaLinea();
  flfact_tpv.iface.imprimirDatos(sys.translate("GRACIAS POR SU VISITA"));
  flfact_tpv.iface.impAlinearH(0);
  flfact_tpv.iface.impNuevaLinea(2);
  flfact_tpv.iface.impSubrayar(true);
  flfact_tpv.iface.imprimirDatos(sys.translate("Le atendió") + ":");
  flfact_tpv.iface.impSubrayar(false);
  flfact_tpv.iface.imprimirDatos("   " + agente);
  flfact_tpv.iface.impNuevaLinea();
  flfact_tpv.iface.impBarcode(qryTicket.value("tpv_comandas.codigo"));
}

function oficial_adornosCabeceraVale(qryVale)
{
	return true;
}

function oficial_datosListadoComandasVale(listadoComandas)
{
	return true;
}

function oficial_adornosCabeceraTicket(qryTicket)
{
	return true;
}

function oficial_adornosCabeceraTicketRegalo(qryTicket)
{
	return true;
}

function oficial_datosTiqueEmpresa(qryTicket)
{
  var _i = this.iface;

  flfact_tpv.iface.impLogo();

  flfact_tpv.iface.imprimirDatos(qryTicket.value("empresa.nombre"));
  flfact_tpv.iface.impResaltar(false);
  flfact_tpv.iface.impSubrayar(false);
  flfact_tpv.iface.impNuevaLinea();
  flfact_tpv.iface.imprimirDatos(qryTicket.value("empresa.direccion"));
  flfact_tpv.iface.impNuevaLinea();
  flfact_tpv.iface.imprimirDatos(qryTicket.value("empresa.ciudad"));
  flfact_tpv.iface.impNuevaLinea();
  flfact_tpv.iface.imprimirDatos(sys.translate("Telef.") + "  ");
  flfact_tpv.iface.imprimirDatos(qryTicket.value("empresa.telefono"));
  flfact_tpv.iface.impNuevaLinea();
  flfact_tpv.iface.imprimirDatos(sys.translate("N.I.F.") + "  ");
  flfact_tpv.iface.imprimirDatos(qryTicket.value("empresa.cifnif"));
  return true;
}
/** \D
Abre el cajón del punto de venta actual
*/
function oficial_abrirCajon_clicked()
{
  var _i = this.iface;
	
	var oImp = flfact_tpv.iface.pub_estableceImpresoraPV();
	if (!oImp) {
		return false;
	}
  _i.abrirCajon(oImp.nombre, oImp.esccajon);
}

/** \D
Abre el cajón portamonedas conectado a una impresora
@impresora Nombre de la impresora LPR donde está conectado el cajón
*/
function oficial_abrirCajon(impresora, escAbrir)
{
  var printer = new FLPosPrinter();
  printer.setPrinterName(impresora);

  if (!escAbrir) {
    escAbrir = "1B,7,14,14,7";
  }
  debug("Enviando " + "ESC:" + escAbrir);
  printer.send("ESC:" + escAbrir);
  printer.flush();
}

/** \D
Imprime la factura correspondiente a la venta seleccionada
*/
function oficial_imprimirFactura_clicked()
{
  var _i = this.iface;
  var cursor = this.cursor();

  var codComanda = cursor.valueBuffer("codigo");
  if (!codComanda) {
    return;
  }

  var idFactura = cursor.valueBuffer("idfactura");
  if (!idFactura) {
    var res = MessageBox.warning(sys.translate("La venta seleccionada todavía no tiene una factura asociada. ¿Desea crearla ahora?"), MessageBox.Yes, MessageBox.No);
    if (res != MessageBox.Yes) {
      return;
    }

    var curComanda = new FLSqlCursor("tpv_comandas");
    curComanda.transaction(false);
    try {
      idFactura = flfact_tpv.iface.pub_crearFactura(cursor);
      if (!idFactura) {
        throw sys.translate("La función crearFactura ha fallado");
      }

      /// Evita que se llame a sincronizarConFacturación otra vez
      curComanda.setActivatedCommitActions(false);

      curComanda.select("codigo = '" + codComanda + "'");
      if (!curComanda.first()) {
        throw sys.translate("Error al buscar la venta seleccionada");
      }
      curComanda.setModeAccess(curComanda.Edit);
      curComanda.refreshBuffer();
      curComanda.setValueBuffer("idfactura", idFactura);
      if (!curComanda.commitBuffer()) {
        throw sys.translate("Error al actualizar la venta con el Id de la factura generada");
      }
      if (!flfact_tpv.iface.pub_generarRecibos(curComanda)) {
        return false;
      }
      curComanda.commit();
    } catch (e) {
      curComanda.rollback();
      MessageBox.critical(sys.translate("Hubo un error al generar la factura:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
    }
  }

  var codFactura = AQUtil.sqlSelect("facturascli", "codigo", "idfactura = " + idFactura);
  if (codFactura) {
    formfacturascli.iface.pub_imprimir(codFactura);
  }
}

function oficial_imprimirTicketRegalo(idComanda, aDatos)
{
	var _i = this.iface;
  var cursor = this.cursor();

  var q = new FLSqlQuery("tpv_i_regalo");
	
	var cadenaDatos = "";
	for(var i = 0; i < aDatos.length; i++){
		cadenaDatos += aDatos[i].toString();
		if(i < (aDatos.length - 1)){
			cadenaDatos += ",";
		}
	}
	q.setWhere(_i.dameWhereRegalo(idComanda, cadenaDatos));
	debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> CONSULTA REGALO: " + q.sql());
  if (!q.exec()) {
    MessageBox.critical(sys.translate("Falló la consulta"), MessageBox.Ok, MessageBox.NoButton);
    return false;
  } else {
    if (!q.first()) {
      MessageBox.warning(sys.translate("No hay registros que cumplan los criterios de búsqueda establecidos"), MessageBox.Ok, MessageBox.NoButton);
      return false;
    }
  }
  
	var oImp = flfact_tpv.iface.pub_estableceImpresoraPV();
	if (!oImp) {
		return false;
	}

  if (oImp.tipo == "ESC-POS") {
		 _i.imprimirTiquePOSRegalo(q);
  } else {
    var rptViewer = new FLReportViewer();
    rptViewer.setReportTemplate("tpv_i_regalo");
    rptViewer.setReportData(q);
    rptViewer.renderReport();
    rptViewer.setPrinterName(oImp.nombre);
		rptViewer.impDirecta = false;
		rptViewer.printReport();
  }
  return true;
	
}

/** \D Activa o desactiva el filtro que muestra únicamente las últimas ventas o las del puesto por defecto. El filtro mejora el rendimiento
\end */
function oficial_filtrarVentas()
{
	var _i = this.iface;
  var cursor = this.cursor();
	
  var filtro = _i.filtroVentas();
  if (!filtro && filtro != ""){
    return;
	}
	
	if(!_i.masterComandasCargada_){
		this.close();
		var f = new FLFormSearchDB("tpv_comandas");
		var curComandas = f.cursor();
		curComandas.setMainFilter("1 = 1");
		f.setMainWidget();
	}
	else{
		cursor.setMainFilter(filtro);
	_i.tdbRecords.refresh();
	}
}

function oficial_filtroVentas()
{
  var filtro = "";
  var _i = this.iface;
	
	filtro = _i.filtroHoy(filtro);
	filtro = _i.filtroTerminal(filtro);
	filtro = _i.filtroTipoDoc(filtro);
	
	return filtro;
}
	
function oficial_filtroHoy(filtro)
{
  var _i = this.iface;
  if (_i.ckbSoloHoy.checked) {
    var hoy = new Date;
    filtro = "fecha = '" + hoy.toString().left(10) + "'";
  }
	return filtro;
}

function oficial_filtroTerminal(filtro)
{
  var _i = this.iface;
  if (_i.ckbSoloPV.checked) {
    var codTerminal = flfact_tpv.iface.pub_valorDefectoTPV("codterminal");
    if (codTerminal) {
      if (filtro != "")
        filtro += " AND ";
      filtro += "codtpv_puntoventa = '" + codTerminal + "'";
    }
  }
	return filtro;
}
	
function oficial_filtroTipoDoc(filtro)
{
  var _i = this.iface;
	var cmbTipoDoc = this.child("cmbTipoDoc").currentText;
	switch(cmbTipoDoc){
		case "VENTAS":{
      if (filtro != ""){
        filtro += " AND ";
			}
			filtro += "tipodoc IN ('VENTA', 'venta', 'Venta')";
			break;
		}
		case "DEVOLUCIONES/VALES":{
      if (filtro != ""){
        filtro += " AND ";
			}
			filtro += "tipodoc IN ('DEVOLUCION', 'devolucion', 'Devolucion')";
			break;
		}
		case "RESERVAS":{
      if (filtro != ""){
        filtro += " AND ";
			}
			filtro += "tipodoc IN ('RESERVA', 'reserva', 'Reserva')";
			break;
		}
		case "PRESUPUESTOS":{
      if (filtro != ""){
        filtro += " AND ";
			}
			filtro += "tipodoc IN ('PRESUPUESTO', 'presupuesto', 'Presupuesto')";
			break;
		}
		default:{
			break;
		}
	}
  return filtro;
}

/** \D Llama a una función de impresión u otra en función del tipo de impresora asociada el punto de venta actual
@param  idTpvComanda: id de la comanda de devolución a imprimir
\end */
function oficial_imprimirVale(idTpvComanda)
{
  var _i = this.iface;

  var oImp = flfact_tpv.iface.pub_estableceImpresoraPV();
	if (!oImp) {
		return false;
	}
  if (oImp.tipo == "ESC-POS"){
    _i.imprimirValePOS(idTpvComanda);
	} else {
		_i.imprimirValeKugar(idTpvComanda);
	}
}

/** \D Función de impresión de vales para impresoras térmicas, a través de Kugar
@param  idTpvComanda: id de la comanda de devolución a imprimir
\end */
function oficial_imprimirValeKugar(idTpvComanda)
{
  var _i = this.iface;
  var cursor = this.cursor();
	var codigo = AQUtil.sqlSelect("tpv_comandas", "codigo", "idtpv_comanda = '" + idTpvComanda+ "'");
	
	var oParam = _i.dameParamInformeVale(idTpvComanda);
	if (!oParam) {
		return;
	}
  if (sys.isLoadedModule("flfactinfo")) {
    var curImprimir = new FLSqlCursor("tpv_i_comandas");
    curImprimir.setModeAccess(curImprimir.Insert);
    curImprimir.refreshBuffer();
    curImprimir.setValueBuffer("descripcion", "temp");
    curImprimir.setValueBuffer("d_tpv__comandas_codigo", codigo);
		curImprimir.setValueBuffer("h_tpv__comandas_codigo", codigo);
    flfactinfo.iface.pub_lanzaInforme(curImprimir, oParam);
  } else{
    flfactppal.iface.pub_msgNoDisponible("Informes");
	}
}

function oficial_dameParamInformeVale(idTpvComanda)
{
  var _i = this.iface;
  var oParam = flfactinfo.iface.pub_dameParamInforme();
  oParam.nombreInforme = "tpv_i_vales";
	
	var oImp = flfact_tpv.iface.pub_dameImpresoraPV();
	if (!oImp) {
		return false;
	}
  oParam.printerName = oImp.nombre;
	oParam.impDirecta = true;
	oParam.whereFijo = "";
  return oParam;
}

function oficial_dameParamInformeComanda(idTpvComanda)
{
  var _i = this.iface;
	
  var oParam = flfactinfo.iface.pub_dameParamInforme();
  oParam.nombreInforme = "tpv_i_comandas";
	oParam.whereFijo = "";
	
  return oParam;
}

/** \D Función de impresión de vales para impresoras ESC-POS
@param  idTpvComanda: id de la comanda de devolución a imprimir
\end */
function oficial_imprimirValePOS(idTpvComanda)
{
  var _i = this.iface;
  var cursor = this.cursor();
	
	flfact_tpv.iface.pub_establecerImpresora();
	
  var qryVale = new FLSqlQuery("tpv_i_comandas");
  qryVale.setWhere(_i.dameWhereVale(idTpvComanda) + _i.dameGroupVale());
	debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>> CONSULTA VALE: " + qryVale.sql());
	if (!qryVale.exec()){
    return false;
	}
	_i.hayLineas_ = true;
	if (!qryVale.first()){
    qryVale = new FLSqlQuery("tpv_i_comandas_nolineas");
		_i.hayLineas_ = false;
		qryVale.setWhere(_i.dameWhereVale(idTpvComanda) + _i.dameGroupVale());
		debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>> CONSULTA VALE 2: " + qryVale.sql());
	}
	if(parseFloat(qryVale.value("tpv_comandas.saldopendiente")) <= 0){
		return false;
	}
	var primerRegistro = true;
	var imprimeLineas;
	var listadoComandas = "";
	var codigoValeAnt;
	var codigoValeAct;
	
	while (qryVale.next() && _i.hayLineas_) {
		codigoValeAct = qryVale.value("tpv_lineascomanda.codigovale");
		if(codigoValeAct == codigoValeAnt || codigoValeAct == "0" || !codigoValeAct){
			continue;
		}
		listadoComandas += codigoValeAct + ", ";
		codigoValeAnt = codigoValeAct;
	}
	listadoComandas = listadoComandas.substring(0, listadoComandas.length - 2) + ".";
	
	if (!qryVale.first()){
    return false;
	}
	do {
		if (primerRegistro) {
			if (!_i.adornosCabeceraVale(qryVale)) {
				return false;
			}
			if (!_i.datosTiqueEmpresa(qryVale)) {
				return false;
			}
			if (!_i.datosListadoComandasVale(listadoComandas)) {
				return false;
			}
      
      imprimeLineas = _i.esPrimerValeEmitido(qryVale);
      
			_i.imprimirCabeceraVale(qryVale,imprimeLineas);
		
			if(!imprimeLineas) {
				break;
			}
		}
		primerRegistro = false;
		_i.imprimirLineaVale(qryVale);
  }while (qryVale.next());

	if (!qryVale.first()){
		return false;
	}
	_i.imprimirPieVale(qryVale,imprimeLineas);
	_i.hayLineas_ = true;
	_i.finImpresion();
}

function oficial_esPrimerValeEmitido(qryVale)
{
	var _i = this.iface;
	var esPrimer = true;
	
	var total = parseFloat(qryVale.value("tpv_comandas.total"))*-1;
	total = AQUtil.roundFieldValue(total, "tpv_comandas", "total");
	var saldo = parseFloat(qryVale.value("tpv_comandas.saldopendiente"));
	saldo = AQUtil.roundFieldValue(saldo, "tpv_comandas", "total");
	
	if(saldo != total) {
		esPrimer = false;
	}

	return esPrimer;
}
	
function oficial_dameWhere(codComanda)
{
	var _i = this.iface;
	var where = "codigo = '" + codComanda + "'";
	return where;
}

function oficial_dameWhereRegalo(idComanda, cadenaDatos)
{
	var _i = this.iface;
	var where = "tpv_comandas.idtpv_comanda = '" + idComanda + "' AND tpv_lineascomanda.idtpv_linea IN (" + cadenaDatos + ") AND tpv_lineascomanda.canregalo > 0";
	return where;
}

function oficial_dameWhereVale(idComanda)
{
	var _i = this.iface;
	/// Cambiado para sacar todas las líneas sean o no devueltas y así coincida el total con el saldo
	///var where = "tpv_comandas.idtpv_comanda = '" + idComanda + "' AND tpv_lineascomanda.cantidad < 0 ";
	var where = "tpv_comandas.idtpv_comanda = '" + idComanda + "'";
	return where;
}

function oficial_dameGroupVale()
{
	var _i = this.iface;
	var groupBy = ""/*" GROUP BY empresa.nombre, empresa.cifnif, empresa.direccion, empresa.ciudad, empresa.telefono,empresa.pieticket, tpv_comandas.idtpv_comanda, tpv_comandas.codigo, tpv_comandas.fecha, tpv_comandas.codtpv_agente, tpv_comandas.neto, tpv_comandas.totaliva, tpv_comandas.hora, tpv_comandas.saldopendiente, tpv_comandas.total, tpv_lineascomanda.referencia, tpv_lineascomanda.pvpunitario, tpv_lineascomanda.cantidad, tpv_lineascomanda.pvptotal, tpv_lineascomanda.descripcion, tpv_agentes.descripcion, tpv_lineascomanda.idtpv_linea"*/;
	return groupBy;
}


/** \D
Anula la venta seleccionada creando otra negativa
*/
function oficial_anularVenta_clicked()
{
  var _i = this.iface;
  var cursor = this.cursor();

  var codComanda = cursor.valueBuffer("codigo");
  if (!codComanda) {
    return false;
  }
  
  var anulada = cursor.valueBuffer("anulada");
  if (anulada) {
		if(cursor.valueBuffer("total") >= 0){
			MessageBox.warning(sys.translate("La venta ya ha sido anulada previamente."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
		}
		else{
			MessageBox.warning(sys.translate("La venta es una anulación.\nNo se puede anular."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
		}
   return false;
  }
  
  var curTransaccion= new FLSqlCursor("empresa");
  curTransaccion.transaction(false);
  try {
		if(!_i.creaComandaNegativa()){
			curTransaccion.rollback();
			MessageBox.warning(sys.translate("Ha habido un error al crear la venta negativa."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
			return false;
		}
		if(!_i.creaComandaRectificada()){
			curTransaccion.rollback();
			MessageBox.warning(sys.translate("Ha habido un error al crear la venta a rectificar."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
			return false;
		}
	}
  catch (e) {
		curTransaccion.rollback();
		MessageBox.warning(sys.translate("Ha habido un error al copiar la venta a anular.") + "\n" + e, MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
		return false;
  }
  curTransaccion.commit();
	
  _i.tdbRecords.refresh();
	
	return true;
}

/** \D
Copia una comanda pero en negativo para anular otra comanda
*/
function oficial_creaComandaNegativa()
{
  var _i = this.iface;
	
	if(!_i.copiarCabeceraComanda("negativa")){
		return false;
	}
	if(!_i.copiarLineasComanda("negativa")){
		return false;
	}
	if(!_i.copiarPagosComanda()){
		return false;
	}
	
	/// Para que sincronice con facturación y cree los asientos contables.
	var idComanda = _i.curComandaCopia_.valueBuffer("idtpv_comanda");
	_i.curComandaCopia_.select("idtpv_comanda = " + idComanda);
	if (!_i.curComandaCopia_.first()) {
		return false;
	}
	_i.curComandaCopia_.setModeAccess(_i.curComandaCopia_.Edit);
	_i.curComandaCopia_.refreshBuffer();
	_i.curComandaCopia_.setValueBuffer("anulada", true);
	_i.curComandaCopia_.setValueBuffer("editable", false);
	if (!_i.curComandaCopia_.commitBuffer()) {
		return false;
	}
	return true;
}

/** \D
Copia una comanda pero sin los pagos para que se pueda rectificar.
*/
function oficial_creaComandaRectificada()
{
  var _i = this.iface;
	
	if(!_i.copiarCabeceraComanda("rectificada")){
		return false;
	}
	if(!_i.copiarLineasComanda("rectificada")){
		return false;
	}
	
	return true;
}

function oficial_copiarCabeceraComanda(tipoComandaCopia)
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	if (!_i.curComandaCopia_) {
		_i.curComandaCopia_ = new FLSqlCursor("tpv_comandas");
		_i.curComandaCopia_.setActivatedCheckIntegrity(false);
	}
	
	var campos = AQUtil.nombreCampos("tpv_comandas");
	var totalCampos = campos[0];
	var campoInformado = [];
	
	cursor.setActivatedCheckIntegrity(false);
	cursor.setActivatedCommitActions(false);
	
	cursor.setModeAccess(cursor.Edit);
	cursor.refreshBuffer();
	
	for (var i = 1; i <= totalCampos; i++) {
		campoInformado[campos[i]] = false;
	}
	
	_i.curComandaCopia_.setModeAccess(_i.curComandaCopia_.Insert);
	_i.curComandaCopia_.refreshBuffer();
	
	for (var i = 1; i <= totalCampos; i++) {
		if (!_i.copiarCampoComanda(campos[i], cursor, campoInformado, tipoComandaCopia)) {
			return false;
		}
	}
	if (!_i.curComandaCopia_.commitBuffer()) {
		return false;
	}
	
	if(tipoComandaCopia == "negativa"){
		cursor.setValueBuffer("anulada", true);
		cursor.setValueBuffer("editable", false);
		if (!cursor.commitBuffer()) {
			return false;
		}
	}
	cursor.setActivatedCommitActions(true);
	return true;
}

function oficial_copiarLineasComanda(tipoComandaCopia)
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var idComanda = cursor.valueBuffer("idtpv_comanda");
	var idComandaNegativa = _i.curComandaCopia_.valueBuffer("idtpv_comanda");
	
	if (!_i.curLineaComandaCopia_) {
		_i.curLineaComandaCopia_ = new FLSqlCursor("tpv_lineascomanda");
		_i.curLineaComandaCopia_.setActivatedCheckIntegrity(false);
	}
	
	if (!AQUtil.sqlDelete("tpv_lineascomanda", "idtpv_comanda = " + idComandaNegativa)) {
		return false;
	}
	
	var campos = AQUtil.nombreCampos("tpv_lineascomanda");
	var totalCampos = campos[0];
	var campoInformado = [];
	
	var curLineaComanda = new FLSqlCursor("tpv_lineascomanda");
	curLineaComanda.setActivatedCheckIntegrity(false);
	curLineaComanda.select("idtpv_comanda = '" + idComanda + "'");
	
	while (curLineaComanda.next()) {
		curLineaComanda.setModeAccess(curLineaComanda.Browse);
		curLineaComanda.refreshBuffer();

		_i.curLineaComandaCopia_.setModeAccess(_i.curLineaComandaCopia_.Insert);
		_i.curLineaComandaCopia_.refreshBuffer();

		_i.curLineaComandaCopia_.setValueBuffer("idtpv_comanda", idComandaNegativa);
		for (var i = 1; i <= totalCampos; i++) {
			campoInformado[campos[i]] = false;
		}
		for (var i = 1; i <= totalCampos; i++) {
			if (!_i.copiarCampoLineaComanda(campos[i], curLineaComanda, campoInformado, tipoComandaCopia)) {
				return false;
			}
		}
		if (!_i.curLineaComandaCopia_.commitBuffer()) {
			return false;
		}
	}
	return true;
}

function oficial_copiarPagosComanda()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	
	var idComanda = cursor.valueBuffer("idtpv_comanda");
	
	var idComandaNegativa = _i.curComandaCopia_.valueBuffer("idtpv_comanda");
	
	if (!_i.curPagoComandaCopia_) {
		_i.curPagoComandaCopia_ = new FLSqlCursor("tpv_pagoscomanda");
	}
	
	if (!AQUtil.sqlDelete("tpv_pagoscomanda", "idtpv_comanda = " + idComandaNegativa)) {
		return false;
	}
	
	var campos = AQUtil.nombreCampos("tpv_pagoscomanda");
	var totalCampos = campos[0];
	var campoInformado = [];
	
	
	var curPagoComanda = new FLSqlCursor("tpv_pagoscomanda");
	curPagoComanda.select("idtpv_comanda = '" + idComanda + "'");
	
	while (curPagoComanda.next()) {
		curPagoComanda.setModeAccess(curPagoComanda.Browse);
		curPagoComanda.refreshBuffer();

		_i.curPagoComandaCopia_.setModeAccess(_i.curPagoComandaCopia_.Insert);
		_i.curPagoComandaCopia_.refreshBuffer();

		_i.curPagoComandaCopia_.setValueBuffer("idtpv_comanda", idComandaNegativa);
		for (var i = 1; i <= totalCampos; i++) {
			campoInformado[campos[i]] = false;
		}
		for (var i = 1; i <= totalCampos; i++) {
			if (!_i.copiarCampoPago(campos[i], curPagoComanda, campoInformado)) {
				return false;
			}
		}
		if (!_i.curPagoComandaCopia_.commitBuffer()) {
			return false;
		}
	}
	return true;
}

function oficial_copiarCampoComanda(nombreCampo, curOriginal, campoInformado, tipoComandaCopia)
{
	var _i = this.iface;
	
	if (campoInformado[nombreCampo]) {
		return true;
	}
	
	var nulo = false;

	switch (nombreCampo) {
		case "idtpv_comanda": 
		case "idfactura": {
			return true;
			break;
		}
		case "codigo":{
			valor = 0;
			break;
		}
		case "neto":
		case "total":
		case "totaliva":
		case "totalrecargo":{
			switch (tipoComandaCopia){
				case "negativa":{
					valor = parseFloat(curOriginal.valueBuffer(nombreCampo)) * (-1);
					break;
				}
				case "rectificada":{
					valor = parseFloat(curOriginal.valueBuffer(nombreCampo));
					break;
				}
				default:{
					break;
				}
			}
			break;
		}
		case "pagado":{
			switch (tipoComandaCopia){
				case "negativa":{
					valor = parseFloat(curOriginal.valueBuffer(nombreCampo)) * (-1);
					break;
				}
				case "rectificada":{
					valor = 0;
					break;
				}
				default:{
					break;
				}
			}
			break;
		}
		case "pendiente":{
			switch (tipoComandaCopia){
				case "negativa":{
					valor = parseFloat(curOriginal.valueBuffer(nombreCampo)) * (-1);
					break;
				}
				case "rectificada":{
					valor = parseFloat(curOriginal.valueBuffer("total"));
					break;
				}
				default:{
					break;
				}
			}
			break;
		}
		case "fecha":{
			var hoy = new Date();
			valor = hoy;
			break;
		}
		case "editable":{
			valor = true;
			break;
		}
		case "anulada":{
			valor = false;
			break;
		}
		case "estado":{
			switch (tipoComandaCopia){
				case "negativa":{
					valor = "Cerrada";
					break;
				}
				case "rectificada":{
					valor = "Abierta";
					break;
				}
				default:{
					break;
				}
			}
			break;
		}
		default: {
			if (curOriginal.isNull(nombreCampo)) {
				nulo = true;
			} else {
				valor = curOriginal.valueBuffer(nombreCampo);
			}
		}
	}
	if (nulo) {
		_i.curComandaCopia_.setNull(nombreCampo);
	} else {
		_i.curComandaCopia_.setValueBuffer(nombreCampo, valor);
	}
	campoInformado[nombreCampo] = true;
	
	return true;
}

function oficial_copiarCampoLineaComanda(nombreCampo, curOriginal, campoInformado, tipoComandaCopia)
{
	var _i = this.iface;
	
	if (campoInformado[nombreCampo]) {
		return true;
	}
	var nulo = false;

	switch (nombreCampo) {
		case "idtpv_comanda":
		case "idtpv_linea": {
			return true;
			break;
		}
		case "cantidad":
		case "pvptotal":
		case "pvpsindto":{
			switch (tipoComandaCopia){
				case "negativa":{
					valor = parseFloat(curOriginal.valueBuffer(nombreCampo)) * (-1);
					break;
				}
				case "rectificada":{
					valor = parseFloat(curOriginal.valueBuffer(nombreCampo));
					break;
				}
				default:{
					break;
				}
			}
			break;
		}
		default: {
			if (curOriginal.isNull(nombreCampo)) {
				nulo = true;
			} else {
				valor = curOriginal.valueBuffer(nombreCampo);
			}
		}
	}
	if (nulo) {
		_i.curLineaComandaCopia_.setNull(nombreCampo);
	} else {
		_i.curLineaComandaCopia_.setValueBuffer(nombreCampo, valor);
	}
	campoInformado[nombreCampo] = true;
	
	return true;
}

function oficial_copiarCampoPago(nombreCampo, curOriginal, campoInformado)
{
	var _i = this.iface;
	
	if (campoInformado[nombreCampo]) {
		return true;
	}
	var nulo = false;

	switch (nombreCampo) {
		case "idtpv_arqueo":
		case "idtpv_comanda":
		case "idpago": {
			return true;
			break;
		}
		case "importe":{
			valor = parseFloat(curOriginal.valueBuffer(nombreCampo)) * (-1);
			break;
		}
		case "fecha":{
			var hoy = new Date();
			valor = hoy;
			break;
		}
		default: {
			if (curOriginal.isNull(nombreCampo)) {
				nulo = true;
			} else {
				valor = curOriginal.valueBuffer(nombreCampo);
			}
		}
	}
	if (nulo) {
		_i.curPagoComandaCopia_.setNull(nombreCampo);
	} else {
		_i.curPagoComandaCopia_.setValueBuffer(nombreCampo, valor);
	}
	campoInformado[nombreCampo] = true;
	
	return true;
}

function oficial_valoresLocales()
{
	var _i = this.iface;
	
	if(!_i.comprobarTpv()){
		this.child("lblAvisoTPV").show();
		_i.tdbRecords.setEditOnly(true);
	}
	else{
		this.child("toolButtomInsert").setDisabled(false);
		this.child("lblAvisoTPV").close();
		_i.tdbRecords.setEditOnly(false);
	}
}
	
function oficial_comprobarTpv()
{
	var _i = this.iface;
	
  var codTerminal = flfact_tpv.iface.pub_valorDefectoTPV("codterminal");
	if (!codTerminal){
		sys.setObjText(this, "lblAvisoTPV", "No hay un punto de venta establecido.");
		return false;
	}
	var puntoVenta = AQUtil.sqlSelect("tpv_puntosventa", "codtpv_puntoventa", "codtpv_puntoventa = '" + codTerminal + "'");
	if(!puntoVenta){
		sys.setObjText(this, "lblAvisoTPV", "No existe el punto de venta establecido.");
		return false;
	}
	if (!formRecordtpv_comandas.iface.pub_dameAgenteVenta(codTerminal)) {
		sys.setObjText(this, "lblAvisoTPV", "No hay un agente asignado al punto de venta establecido.");
		return false;
	}
	
	var idArqueo = AQUtil.sqlSelect("tpv_arqueos","idtpv_arqueo","abierta AND ptoventa = '" + puntoVenta + "'");
	if(!idArqueo){
		sys.setObjText(this, "lblAvisoTPV", "No hay un arqueo abierto.");
		return false;
	}
	return true;
}

function oficial_pushButtonCancel_clicked()
{
	var _i = this.iface;
	_i.masterComandasCargada_ = false;
	this.close();

}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
