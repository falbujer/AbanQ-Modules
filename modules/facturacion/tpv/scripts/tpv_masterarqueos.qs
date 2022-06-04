/***************************************************************************
                 tpv_masterarqueos.qs  -  description
                             -------------------
    begin                : jue nov 17 2005
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
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna
{
  var tdbRecords;
  var ckbSoloPV;
	var importeA_;
	var importeB_;
	var importeC_;
	var codDivisa_;
	var diaHasta_;
	var horaHasta_;
	var retiradas_;
	var msgNoImpresos_;
	
  function oficial(context)
  {
    interna(context);
  }
  function abrirCerrarArqueo_clicked()
  {
    return this.ctx.oficial_abrirCerrarArqueo_clicked();
  }
  function abrirCerrarArqueo()
  {
    return this.ctx.oficial_abrirCerrarArqueo();
  }
  function fechaCierre(curArqueo)
  {
    return this.ctx.oficial_fechaCierre(curArqueo);
  }
  function confirmarFechaCierre(diaHasta, horaHasta)
  {
    return this.ctx.oficial_confirmarFechaCierre(diaHasta, horaHasta);
  }/**
  function imprimir_clicked()
  {
    return this.ctx.oficial_imprimir_clicked();
  }
  function imprimirTiqueArqueo(codArqueo)
  {
    return this.ctx.oficial_imprimirTiqueArqueo(codArqueo);
  }*/
  function abrirCerrarPagos(idArqueo, abrir)
  {
    return this.ctx.oficial_abrirCerrarPagos(idArqueo, abrir);
  }
  function filtrarArqueos()
  {
    return this.ctx.oficial_filtrarArqueos();
  }
  function generarFacturasVentas(idArqueo)
  {
    return this.ctx.oficial_generarFacturasVentas(idArqueo);
  }
  function consultarCierre()
  {
    return this.ctx.oficial_consultarCierre();
  }/**
  function imprimirQuick_clicked()
  {
    return this.ctx.oficial_imprimirQuick_clicked();
  }
  function imprimirQuick(codArqueo, impresora)
  {
    return this.ctx.oficial_imprimirQuick(codArqueo, impresora);
  }*/
  function comprobarDiferencias(curArqueo)
  {
    return this.ctx.oficial_comprobarDiferencias(curArqueo);
  }
  
  /// Santi
	function procesarEstado() {
		return this.ctx.oficial_procesarEstado();
	}
	function toolButtonPrint_clicked() {
		return this.ctx.oficial_toolButtonPrint_clicked();
	}
	function dameTipoImpresora() {
		return this.ctx.oficial_dameTipoImpresora();
	}
	function mostrarMensajeNoImpresos() {
		return this.ctx.oficial_mostrarMensajeNoImpresos();
	}
	function posiblesInformesArqueo() {
		return this.ctx.oficial_posiblesInformesArqueo();
	}
	function imprimirResumenArqueo(nombreInforme, tipoImpresora) {
		return this.ctx.oficial_imprimirResumenArqueo(nombreInforme, tipoImpresora);
	}
  function imprimirInformeArqueo(nombreInforme)
  {
    return this.ctx.oficial_imprimirInformeArqueo(nombreInforme);
  }
  function imprimirArqueoPOS(nombreInforme, impresora)
  {
    return this.ctx.oficial_imprimirArqueoPOS(nombreInforme, impresora);
  }
  function previoImpresion(nombreInforme, impresora)
  {
    return this.ctx.oficial_previoImpresion(nombreInforme, impresora);
  }
  function imprimirCierreArqueoPOS(q)
  {
    return this.ctx.oficial_imprimirCierreArqueoPOS(q);
  }
  function imprimirResumenEmitidosPOS(q)
  {
    return this.ctx.oficial_imprimirResumenEmitidosPOS(q);
  }
  function imprimirResumenRecibidosPOS(q)
  {
    return this.ctx.oficial_imprimirResumenRecibidosPOS(q);
  }
  function imprimirResumenAnuladosPOS(q)
  {
    return this.ctx.oficial_imprimirResumenAnuladosPOS(q);
  }
  function imprimirArqueoTermica(nombreInforme, impresora, codPuntoVenta)
  {
    return this.ctx.oficial_imprimirArqueoTermica(nombreInforme, impresora, codPuntoVenta);
  }
  function lanzarRptViewer(nombreInforme, q, impresora)
  {
    return this.ctx.oficial_lanzarRptViewer(nombreInforme, q, impresora);
  }
  function establecerConsultaArqueo(nombreInforme)
  {
    return this.ctx.oficial_establecerConsultaArqueo(nombreInforme);
  }
  function mensajeSinResultados(nombreInforme)
  {
    return this.ctx.oficial_mensajeSinResultados(nombreInforme);
  }
  function dameSelect(nombreInforme)
  {
    return this.ctx.oficial_dameSelect(nombreInforme);
  }
  function dameFrom(nombreInforme)
  {
    return this.ctx.oficial_dameFrom(nombreInforme);
  }
  function dameWhere(nombreInforme)
  {
    return this.ctx.oficial_dameWhere(nombreInforme);
  }
  function adornosCabeceraCierre(q)
  {
    return this.ctx.oficial_adornosCabeceraCierre(q);
  }
  function datosTiqueEmpresa(q)
  {
    return this.ctx.oficial_datosTiqueEmpresa(q);
  }
  function imprimirConteo(q)
  {
    return this.ctx.oficial_imprimirConteo(q);
  }
  function imprimirBilletes(q, aBilletes)
  {
    return this.ctx.oficial_imprimirBilletes(q, aBilletes);
  }
  function imprimirMonedas(q, aMonedas)
  {
    return this.ctx.oficial_imprimirMonedas(q, aMonedas);
  }
  function imprimirTotalConteo(q)
  {
    return this.ctx.oficial_imprimirTotalConteo(q);
  }
  function imprimirResumenes(q)
  {
    return this.ctx.oficial_imprimirResumenes(q);
  }
  function imprimirResumenEfectivo(q)
  {
    return this.ctx.oficial_imprimirResumenEfectivo(q);
  }
  function imprimirResumenVale(q)
  {
    return this.ctx.oficial_imprimirResumenVale(q);
  }
  function imprimirResumenTarjeta(q)
  {
    return this.ctx.oficial_imprimirResumenTarjeta(q);
  }
  function imprimirRetidasEfectivo(q, saldoIngreso)
  {
    return this.ctx.oficial_imprimirRetidasEfectivo(q, saldoIngreso);
  }
  function imprimirDiferencia(q)
  {
    return this.ctx.oficial_imprimirDiferencia(q);
  }
  function imprimirPieCierre(q)
  {
    return this.ctx.oficial_imprimirPieCierre(q);
  }
  function comprobarCoincidenciaArqueo(diaHasta, diaDesde, ptoVenta, idArqueo)
  {
    return this.ctx.oficial_comprobarCoincidenciaArqueo(diaHasta, diaDesde, ptoVenta, idArqueo);
  }
  function imprimirCabeceraResumen(q, titulo)
  {
    return this.ctx.oficial_imprimirCabeceraResumen(q, titulo);
  }
  function imprimirLineasResumenEmitidos(q)
  {
    return this.ctx.oficial_imprimirLineasResumenEmitidos(q);
  }
  function imprimirLineasResumenRecibidos(q)
  {
    return this.ctx.oficial_imprimirLineasResumenRecibidos(q);
  }
  function imprimirLineasResumenAnulados(q)
  {
    return this.ctx.oficial_imprimirLineasResumenAnulados(q);
  }
  function imprimirPieResumen(q, resumen)
  {
    return this.ctx.oficial_imprimirPieResumen(q, resumen);
  }
  function imprimirTotalesResumen(resumen)
  {
    return this.ctx.oficial_imprimirTotalesResumen(resumen);
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
  function pub_abrirCerrarArqueo()
  {
    return this.abrirCerrarArqueo();
  }
  function pub_abrirCerrarPagos(idArqueo, abrir)
  {
    return this.abrirCerrarPagos(idArqueo, abrir);
  }
  function pub_imprimirQuick(codComanda, impresora)
  {
    return this.imprimirQuick(codComanda, impresora);
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
El botón abrir cerrar arqueo del formulario maestro permite abir o cerrar una arqueo.
Para poder cerrar una arqueo deben estar cerradas todas sus comandas
*/
function interna_init()
{
	var _i = this.iface;
  var cursor = this.cursor();

  _i.tdbRecords = this.child("tableDBRecords");
  _i.ckbSoloPV = this.child("ckbSoloPV");

  connect(this.child("tbnBlocDesbloc"), "clicked()", _i, "abrirCerrarArqueo_clicked()");
  connect(this.child("ckbSoloPV"), "clicked()",  _i, "filtrarArqueos()");
  connect(cursor, "bufferCommited()",  _i, "consultarCierre()");
  connect(this.child("toolButtonPrint"), "clicked()", _i, "toolButtonPrint_clicked()");
  connect(this.child("tbnPrintQuick"), "clicked()", _i, "imprimirQuick_clicked()");

	connect(_i.tdbRecords, "currentChanged()", _i, "procesarEstado()");
	
	this.child("tbnPrintQuick").close();
  _i.filtrarArqueos();
	
	/// Estos importes se van a acumular en los .next() y después se sacan en diferentes informes.
	_i.importeA_ = 0;
	_i.importeB_ = 0;
	_i.importeC_ = 0;
	
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D
Abre una transacción y llama a la función abrirCerrarArqueo
*/
function oficial_abrirCerrarArqueo_clicked()
{
	var _i = this.iface;
  var cursor = this.cursor();

	var curT = new FLSqlCursor("empresa");
	curT.transaction(false);
  try {
    if (_i.abrirCerrarArqueo()) {
      curT.commit();
    } else {
      curT.rollback();
      return false;
    }
  } catch (e) {
    curT.rollback();
    MessageBox.critical(sys.translate("Hubo un error en abrir o cerrar el arqueo:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
  }
  cursor.commit();
	try{
		_i.tdbRecords.refresh();
	}
	catch(e){
		MessageBox.critical(sys.translate("Hubo un error al refrescar la tabla. ") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
	}
}

/** \D
Abre o cierra el arqueo seleccionado
Para cerrar el arqueo debben estar cerradas todas sus comandas
Antes de cerrar el arqueo debemos establecer una fecha de cierre que será por defecto la fecha de la última comanda
La fecha de cierre debe ser siempre posterior a la fecha de inicio
El intervalo de fechas no puede solaparse al intervalo de otro arqueo ya existente
@return true si se ha abiert o cerrado correctamente y false si ha habido algún error
*/
function oficial_abrirCerrarArqueo()
{
	var _i = this.iface;
  var cursor = this.cursor();
	
  var diaHasta = cursor.valueBuffer("diahasta");
  var horaHasta = cursor.valueBuffer("horahasta");
  var diaDesde = cursor.valueBuffer("diadesde");
  var ptoVenta = cursor.valueBuffer("ptoventa");
  var idArqueo = cursor.valueBuffer("idtpv_arqueo");

  var curArqueo = new FLSqlCursor("tpv_arqueos");
  curArqueo.select("idtpv_arqueo = '" + idArqueo + "'");
  if (!curArqueo.first()) {
    return false;
  }
  curArqueo.setModeAccess(curArqueo.Edit);
  curArqueo.refreshBuffer();

  if (curArqueo.valueBuffer("abierta")) {
	  var codTerminal = flfact_tpv.iface.pub_valorDefectoTPV("codterminal");
		if (codTerminal && AQUtil.sqlSelect("tpv_puntosventa", "codtpv_puntoventa", "codtpv_puntoventa ='" + codTerminal + "'")) {
			var agente = formRecordtpv_arqueos.iface.pub_dameAgenteArqueo(codTerminal);
			if (!agente || agente == "") {
				return false;
			}
			curArqueo.setValueBuffer("codtpv_agentecierre", agente);
		} else {
			MessageBox.warning(sys.translate("No hay establecido ningún Punto de Venta Local\no el Punto de Venta establecido no es válido.\nSeleccione un Punto de Venta válido en la tabla \ny pulse el botón Cambiar"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
			return false;
		}
		
		if(!_i.comprobarDiferencias(curArqueo)){
			return false;
		}
		
    if (!curArqueo.valueBuffer("diahasta")) {
			if(!_i.fechaCierre(curArqueo)){
				return false;
			}
			if(_i.diaHasta_ == undefined || _i.horaHasta_ == undefined){
				return true;
			}
      diaHasta = _i.diaHasta_;
			horaHasta = _i.horaHasta_;
			/**
			importeEfectivo = parseFloat(importeEfectivo.value);
			cambioCaja = parseFloat(cambioCaja.value);
			movCierre = parseFloat(movCierre.value);
			
			if(parseFloat(importeEfectivo) != parseFloat(curArqueo.valueBuffer("totalcaja"))){
				MessageBox.warning(sys.translate("No se puede modificar el importe del total de la caja desde esta ventana.\nSi desea cambiar este valor edite este campo desde el formulario de edición y vuelva a proceder al cierre"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
				return false;
			}
			if(importeEfectivo != (cambioCaja + movCierre)){
				MessageBox.warning(sys.translate("El importe a sacar (mov. cierre) + el cambio a dejar en la caja debe de ser igual al importe en efectivo contado en caja."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
				return false;
			}*/
      curArqueo.setValueBuffer("diahasta", diaHasta);
			curArqueo.setValueBuffer("horahasta", horaHasta);
			///curArqueo.setValueBuffer("sacadodecaja", movCierre);
    } else {
      diaHasta = curArqueo.valueBuffer("diahasta");
	  horaHasta = curArqueo.valueBuffer("horahasta");
    }

    if (diaHasta < diaDesde) {
      MessageBox.warning(sys.translate("La fecha de cierre debe ser posterior a la fecha de inicio"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
      return false;
    }
    
    if(!_i.comprobarCoincidenciaArqueo(diaHasta, diaDesde, ptoVenta, idArqueo)){
			return false;
		}
    
    if(!_i.confirmarFechaCierre(diaHasta, horaHasta)){
			return false;
		}
    /// NUEVO. YA SE MODIFICARÁ MEJOR.
    var cambioCaja = Input.getNumber(sys.translate("Cambio dejado en caja: "), parseFloat(curArqueo.valueBuffer("inicio")), 2);
    var importeEfectivo = parseFloat(curArqueo.valueBuffer("totalcaja"));
		var movCierre = importeEfectivo - cambioCaja;
		
		curArqueo.setValueBuffer("sacadodecaja", movCierre);
    /// Sigue el código que había
    if (!_i.abrirCerrarPagos(idArqueo, false)) {
      return false;
    }
    curArqueo.setValueBuffer("abierta", false);
    if (!curArqueo.commitBuffer()) {
      return false;
    }
  } else {
    var res = MessageBox.information(sys.translate("Se reabrirá el arqueo ¿Está seguro?"), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
    if (res != MessageBox.Yes) {
      return false;
    }

    if (!_i.abrirCerrarPagos(idArqueo, true)) {
      return false;
    }
    curArqueo.setUnLock("abierta", true);

    curArqueo.select("idtpv_arqueo = '" + idArqueo + "'");
    if (!curArqueo.first()) {
      return false;
    }
    curArqueo.setModeAccess(curArqueo.Edit);
    curArqueo.refreshBuffer();
    curArqueo.setNull("diahasta");
		curArqueo.setNull("horahasta");
		curArqueo.setValueBuffer("sacadodecaja", 0);
		curArqueo.setNull("codtpv_agentecierre");
    var idAsiento = curArqueo.valueBuffer("idasiento");
    curArqueo.setNull("idasiento");
    if (!curArqueo.commitBuffer()) {
      return false;
    }

    if (idAsiento && idAsiento != "") {
      if (!flfact_tpv.iface.pub_borrarAsientoArqueo(curArqueo, idAsiento)) {
        return false;
      }
    }
  }
	
	if(formtpv_comandas.iface.masterComandasCargada_){
		formtpv_comandas.iface.pub_valoresLocales();
	}
	
	this.child("tableDBRecords").refresh();
	_i.procesarEstado();
	
  return true;
}

function oficial_fechaCierre(curArqueo)
{
	var _i = this.iface;
  var cursor = this.cursor();
	
	var dialog = new Dialog(sys.translate("Fecha de Cierre"), 0, "fcierre");
	dialog.OKButtonText = sys.translate("Aceptar");
	dialog.cancelButtonText = sys.translate("Cancelar");

	var fecha = new DateEdit;
	fecha.date = AQUtil.sqlSelect("tpv_pagoscomanda", "MAX(fecha)", "idtpv_arqueo = '" + curArqueo.valueBuffer("idtpv_arqueo") + "'");
	if (!fecha.date){
		fecha.date = cursor.valueBuffer("diadesde");
	}
	fecha.label = sys.translate("Fecha de Cierre:");
	dialog.add(fecha);

	var ahora = new Date();
	var hora = new TimeEdit;
	hora.time = ahora.toString().right(8);
//       if (!hora.date)
//         hora.date = diaDesde;
	hora.label = sys.translate("Hora de Cierre:");
	dialog.add(hora);
			
	/**var importeEfectivo = new NumberEdit;
	importeEfectivo.value = curArqueo.valueBuffer("totalcaja");
	importeEfectivo.label = sys.translate("Importe en efectivo:");
	importeEfectivo.decimals = 2;
	dialog.add(importeEfectivo);
	
	var cambioCaja = new NumberEdit;
	cambioCaja.value = curArqueo.valueBuffer("inicio");
	cambioCaja.label = sys.translate("Cambio en caja:");
	cambioCaja.decimals = 2;
	dialog.add(cambioCaja);
	
	var movCierre = new NumberEdit;
	movCierre.value = (parseFloat(curArqueo.valueBuffer("totalcaja")) - parseFloat(curArqueo.valueBuffer("inicio"))).toString();
	movCierre.label = sys.translate("Mov. cierre:");
	movCierre.decimals = 2;
	dialog.add(movCierre);*/

	if (!dialog.exec()) {
		_i.diaHasta_ = undefined;
		_i.horaHasta_ = undefined;
		return true;
	}
	if (!fecha.date) {
		return false;
	}
	_i.diaHasta_ = fecha.date;
	_i.horaHasta_ = hora.time;
	return true;
}

function oficial_confirmarFechaCierre(diaHasta, horaHasta)
{
	var _i = this.iface;
  var cursor = this.cursor();
	
	var res = MessageBox.warning(sys.translate("El arqueo se cerrará con fecha %1 y hora %2. ¿Desea continuar?").arg(AQUtil.dateAMDtoDMA(diaHasta)).arg(horaHasta.toString().right(8)), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
	if (res != MessageBox.Yes) {
		return false;
	}
	return true;
}

/** \D Abre o cierra los pagos asociados a un arqueo
@param  idArqueo: Identificador del arqueo
@param  abrir: True indica que los pagos deben abrirse, false que deben cerrarse
@retuen true si el proceso se realiza correctamente, false en caso contrario
\end */
function oficial_abrirCerrarPagos(idArqueo, abrir)
{
	var _i = this.iface;
  var cursor = this.cursor();

  var mensaje;
  if (abrir)
    mensaje = sys.translate("Reabriendo arqueo %1...").arg(idArqueo);
  else
    mensaje = sys.translate("Cerrando arqueo %1...").arg(idArqueo);

  var qryPagos = new FLSqlQuery;
  qryPagos.setTablesList("tpv_pagoscomanda");
  qryPagos.setSelect("idpago, idtpv_comanda");
  qryPagos.setFrom("tpv_pagoscomanda");
  qryPagos.setWhere("idtpv_arqueo = '" + idArqueo + "' ORDER BY idtpv_comanda");
  qryPagos.setForwardOnly(true);
  if (!qryPagos.exec())
    return false;

  var curPagos = new FLSqlCursor("tpv_pagoscomanda");

  AQUtil.createProgressDialog(mensaje, qryPagos.size());
  var progreso = 1;
  var idComanda;
  var idComandaPrevia = "";
  AQUtil.setProgress(progreso);
  while (qryPagos.next()) {
    idComanda = qryPagos.value("idtpv_comanda");
    curPagos.select("idpago = " + qryPagos.value("idpago"));
    if (!curPagos.first())
      return false;
    curPagos.setUnLock("editable", abrir);
    AQUtil.setProgress(progreso++);
  }

  AQUtil.destroyProgressDialog();
  if (!abrir) {
    if (!_i.generarFacturasVentas(idArqueo))
      return false;
  }

  return true;
}

function oficial_generarFacturasVentas(idArqueo)
{
	var _i = this.iface;
  var cursor = this.cursor();
  
  var curComandas = new FLSqlCursor("tpv_comandas");
  curComandas.select("idfactura IS NULL AND idtpv_comanda IN (select idtpv_comanda from tpv_pagoscomanda where idtpv_arqueo = '" + idArqueo + "')");
  curComandas.setActivatedCommitActions(false);

  AQUtil.createProgressDialog(sys.translate("Generando facturas de venta"), curComandas.size());
  var progreso = 1;
  while (curComandas.next()) {
    AQUtil.setProgress(progreso++);
    curComandas.setModeAccess(curComandas.Edit);
    curComandas.refreshBuffer()
    idFactura = flfact_tpv.iface.pub_crearFactura(curComandas);
    if (!idFactura) {
      AQUtil.destroyProgressDialog();
      return false;
    }
    curComandas.setValueBuffer("idfactura", idFactura);
    if (!flfact_tpv.iface.pub_generarRecibos(curComandas)) {
      AQUtil.destroyProgressDialog();
      return false;
    }
    if (!curComandas.commitBuffer()) {
      AQUtil.destroyProgressDialog();
      return false;
    }
  }
  AQUtil.destroyProgressDialog();
  return true;
}

/** \C
Imprime un tique para el arqueo seleccionado
*//**
function oficial_imprimir_clicked()
{
	var _i = this.iface;
  var cursor = this.cursor();
	
  var codArqueo = cursor.valueBuffer("idtpv_arqueo");
  if (!codArqueo)
    return false;

  if (!_i.imprimirTiqueArqueo(codArqueo)) {
    return false;
  }
}
*/
/** \D Lanza la función imprimir con los datos del arqueo
Si no está cargado el módulo de informes mostrará un mensaje de aviso
@param codArqueo código del arqueo del que queremos sacar el tique
*/
/**
function oficial_imprimirTiqueArqueo(codArqueo)
{
	var _i = this.iface;
  var cursor = this.cursor();
	
  if (sys.isLoadedModule("flfactinfo")) {
    if (!cursor.isValid())
      return;
    var curImprimir = new FLSqlCursor("tpv_i_arqueos");
    curImprimir.setModeAccess(curImprimir.Insert);
    curImprimir.refreshBuffer();
    curImprimir.setValueBuffer("descripcion", "temp");
    curImprimir.setValueBuffer("d_tpv__arqueos_idtpv__arqueo", codArqueo);
    curImprimir.setValueBuffer("h_tpv__arqueos_idtpv__arqueo", codArqueo);
    flfactinfo.iface.pub_lanzarInforme(curImprimir, "tpv_i_arqueos");
  } else
    flfactppal.iface.pub_msgNoDisponible("Informes");
}*/

/** \D Activa o desactiva el filtro que muestra únicamente los arqueos del puesto por defecto.
\end */
function oficial_filtrarArqueos()
{
	var _i = this.iface;
  var cursor = this.cursor();
	
  var filtro = "";
  if (_i.ckbSoloPV.checked) {
    var codTerminal =  flfact_tpv.iface.pub_valorDefectoTPV("codterminal");
    if (codTerminal) {
      filtro += "ptoventa = '" + codTerminal + "'";
    }
  }
  cursor.setMainFilter(filtro);
  _i.tdbRecords.refresh();
}

/** \C Si el arqueo está abierto y se ha informado un movimiento de cierre se pregunta al usuario si desea cerrarlo
\end */
function oficial_consultarCierre()
{
	var _i = this.iface;
  var cursor = this.cursor();

  /*if (cursor.valueBuffer("sacadodecaja") > 0 && cursor.valueBuffer("abierta")) {
    var res = MessageBox.warning(sys.translate("¿Desea cerrar el arqueo %1?").arg(cursor.valueBuffer("idtpv_arqueo")), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
    if (res == MessageBox.Yes) {

      if (!formtpv_arqueos.iface.pub_abrirCerrarArqueo()) {
        return false;
      }
    }
  }*/
	return true;
}

function oficial_comprobarDiferencias(curArqueo)
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var difEfectivo = cursor.valueBuffer("diferenciaefectivo");
	var difTarjeta = cursor.valueBuffer("diferenciatarjeta");
	var difVale = cursor.valueBuffer("diferenciavale");
	
	if(difEfectivo != 0 || difTarjeta != 0 || difVale != 0){
		var res = MessageBox.warning(sys.translate("No cuadra la caja con lo calculado. ¿Desea continuar?"), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
		if (res != MessageBox.Yes) {
			return false;
		}
	}
	
	return true;
}

function oficial_procesarEstado()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	if (!cursor.valueBuffer("abierta")) {
		this.child("toolButtonPrint").setDisabled(false);
	} else {
		this.child("toolButtonPrint").setDisabled(true);
	}
}

function oficial_toolButtonPrint_clicked()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var tipoImpresora = _i.dameTipoImpresora();
		
	var dialog = new Dialog;
	dialog.caption = sys.translate("Seleccione Resumen/es a imprimir:");
	dialog.okButtonText = sys.translate("Aceptar");
	dialog.cancelButtonText = sys.translate("Cancelar");
	
	var aInfo = _i.posiblesInformesArqueo();
	var aChk = new Array(aInfo.length);

	for(var i = 0; i < aChk.length; i++){
		aChk[i] = new CheckBox;
		aChk[i].text = aInfo[i][0];
		aChk[i].checked = aInfo[i][2];
		dialog.add(aChk[i]);
	}
	
	if (!dialog.exec()) {
		return;
	}
	_i.msgNoImpresos_ = "";
	for (var i = 0; i < aChk.length; i++) {
		if (aChk[i].checked) {
			_i.imprimirResumenArqueo(aInfo[i][1], tipoImpresora);
			if(tipoImpresora != "ESC-POS"){
				///Sacamos estos informes sólo si es impresora ESC-POS, aunque el script está preparado para mostrar informes kugar. Habría que diseñarlos bien y sobrecargar las queries.
				return;
			}
		}
	}
	_i.mostrarMensajeNoImpresos();
}

function oficial_mostrarMensajeNoImpresos()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	if(_i.msgNoImpresos_ != ""){
		sys.infoMsgBox(_i.msgNoImpresos_);
	}
}

function oficial_dameTipoImpresora()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var tipoImpresora;
	
	var codPuntoVenta =  flfact_tpv.iface.pub_valorDefectoTPV("codterminal");
	if (!codPuntoVenta){
		return "Defecto";
	}
	tipoImpresora = AQUtil.sqlSelect("tpv_puntosventa", "tipoimpresora", "codtpv_puntoventa = '" + codPuntoVenta + "'");
	if(!tipoImpresora){
		tipoImpresora = "Defecto";
	}
	return tipoImpresora;
}

function oficial_posiblesInformesArqueo()
{
	var _i = this.iface;
	var cursor = this.cursor();
			
	/// 1º campo: texto para el checkbox, 2º campo: nombre del informe a pasar a la función de impresión  
	var aInformes = [["Cierre Arqueo","tpv_i_cierrearqueo",false], ["Resumen de vales emitidos","tpv_i_resumenvales_emitidos",false], ["Resumen de vales recibidos","tpv_i_resumenvales_recibidos",false], ["Resumen de vales anulados","tpv_i_resumenvales_anulados",false]];

	/// Utilizar aInfomes.push(["texto check", "nombreInforme",bool]); para añadir más informes en las extensiones
	return aInformes;
}

function oficial_imprimirResumenArqueo(nombreInforme, tipoImpresora)
{
	var _i = this.iface;
	var cursor = this.cursor();
	var impresora;
	var codPuntoVenta =  flfact_tpv.iface.pub_valorDefectoTPV("codterminal");
	
	switch (tipoImpresora) {
		case "Defecto":{
			sys.infoMsgBox("Establezca una impresora ESC-POS en el formulario de punto de venta para sacar el informe.");
			///_i.imprimirInformeArqueo(nombreInforme);
			break;
		}
		case "ESC-POS":{
			impresora = AQUtil.sqlSelect("tpv_puntosventa", "impresora", "codtpv_puntoventa = '" + codPuntoVenta + "'") ;
			_i.imprimirArqueoPOS(nombreInforme, impresora);
			break;
		}
		case "Térmica":{
			sys.infoMsgBox("Este informe no está disponible para impresoras térmicas.\nEstablezca una impresora ESC-POS en el formulario de punto de venta para sacar el informe.");
			/**impresora = AQUtil.sqlSelect("tpv_puntosventa", "impresoratermica", "codtpv_puntoventa = '" + codPuntoVenta + "'");
			_i.imprimirArqueoTermica(nombreInforme, impresora, codPuntoVenta);*/
			break;
		}
		default:{
			flfactppal.iface.pub_msgNoDisponible("Informes");
		}
	}
}

function oficial_imprimirInformeArqueo(nombreInforme)
{  
	var _i = this.iface;
  var cursor = this.cursor();
	
	if (sys.isLoadedModule("flfactinfo")) {
    if (!cursor.isValid()){
      return;
		}
    var curImprimir = new FLSqlCursor("tpv_i_arqueos");
    curImprimir.setModeAccess(curImprimir.Insert);
    curImprimir.refreshBuffer();
    curImprimir.setValueBuffer("descripcion", "temp");
    curImprimir.setValueBuffer("d_tpv__arqueos_idtpv__arqueo", cursor.valueBuffer("idtpv_arqueo"));
    curImprimir.setValueBuffer("h_tpv__arqueos_idtpv__arqueo", cursor.valueBuffer("idtpv_arqueo"));
    flfactinfo.iface.pub_lanzarInforme(curImprimir, nombreInforme);
  } 
  else{
    flfactppal.iface.pub_msgNoDisponible("Informes");
	}
}

function oficial_imprimirArqueoPOS(nombreInforme, impresora)
{  
	var _i = this.iface;
  var cursor = this.cursor();
	
	var q = _i.previoImpresion(nombreInforme, impresora);
	
	if(!q){
		return;
	}
	
	_i.codDivisa_ = q.value("empresa.coddivisa");
	
	switch (nombreInforme) {
		case "tpv_i_cierrearqueo":{
			_i.imprimirCierreArqueoPOS(q);
			break;
		}
		case "tpv_i_resumenvales_emitidos":{
			_i.imprimirResumenEmitidosPOS(q);
			break;
		}
		case "tpv_i_resumenvales_recibidos":{
			_i.imprimirResumenRecibidosPOS(q);
			break;
		}
		case "tpv_i_resumenvales_anulados":{
			_i.imprimirResumenAnuladosPOS(q);
			break;
		}
		default:{
			flfactppal.iface.pub_msgNoDisponible("Informes");
		}
	}
}

function oficial_previoImpresion(nombreInforme, impresora)
{  
	var _i = this.iface;
  var cursor = this.cursor();
	
	var q = _i.establecerConsultaArqueo(nombreInforme);
	
	if(!q){
		return false;
	}
  if (!q.exec()) {
    return false;
  }
  if (!q.first()) {
		return false;
	}
	flfact_tpv.iface.pub_establecerImpresora(impresora);
	return q;
}

function oficial_imprimirCierreArqueoPOS(q)
{  
	var _i = this.iface;
  var cursor = this.cursor();
	
	_i.adornosCabeceraCierre(q);
	_i.datosTiqueEmpresa(q);
	_i.imprimirConteo(q);
	_i.imprimirResumenes(q);
	_i.imprimirDiferencia(q);
	_i.imprimirPieCierre(q);
	
	formtpv_comandas.iface.pub_finImpresion();
}

function oficial_imprimirResumenEmitidosPOS(q)
{  
	var _i = this.iface;
  var cursor = this.cursor();
	
	_i.imprimirCabeceraResumen(q, "Emitidos");
	
	/// Este bucle lo hago así porque ya ha habido antes un q.first() para sacar los datos anteriores. Si no lo hiciera así no mostraría la primera línea de la consulta con los datos del vale.
	_i.importeA_ = 0;
	
	do{
		_i.imprimirLineasResumenEmitidos(q);
		_i.importeA_ += parseFloat(q.value("pc.importe"));
	}while(q.next())
	
	/// Para posicionar el cursor de nuevo.
	q.first();
	_i.imprimirPieResumen(q, "Emitidos");
	
	formtpv_comandas.iface.pub_finImpresion();
}

function oficial_imprimirResumenRecibidosPOS(q)
{  
	var _i = this.iface;
  var cursor = this.cursor();
	
	_i.imprimirCabeceraResumen(q, "Recibidos");
	
	_i.importeA_ = 0;
	_i.importeB_ = 0;
	_i.importeC_ = 0;
	
	var refValeAnterior = "";
	var refValeActual = "";
	do{
		refValeActual = q.value("pc.refvale");
		if(refValeActual != refValeAnterior){
			_i.imprimirLineasResumenRecibidos(q);
			_i.importeA_ += parseFloat(q.value("c.total"))*(-1);
			_i.importeB_ += parseFloat(q.value("pc.importe"));
			_i.importeC_ += parseFloat(q.value("c.saldopendiente"));
		}
		refValeAnterior = refValeActual;
	}while(q.next());
	q.first();
	_i.imprimirPieResumen(q, "Recibidos");
	formtpv_comandas.iface.pub_finImpresion();
}

function oficial_imprimirResumenAnuladosPOS(q)
{  
	var _i = this.iface;
  var cursor = this.cursor();
	
	_i.importeA_ = 0;
	_i.importeB_ = 0;
	
	_i.imprimirCabeceraResumen(q, "Anulados");
	do{
		_i.imprimirLineasResumenAnulados(q);
		_i.importeA_ += parseFloat(q.value("c.total"))*(-1);
		_i.importeB_ += parseFloat(q.value("pc.importe"));
	}while(q.next());
	q.first();
	_i.imprimirPieResumen(q, "Anulados");
	formtpv_comandas.iface.pub_finImpresion();
}

function oficial_imprimirArqueoTermica(nombreInforme, impresora, codPuntoVenta)
{  
	var _i = this.iface;
  var cursor = this.cursor();
	
	var pixel = AQUtil.sqlSelect("tpv_puntosventa", "pixel", "codtpv_puntoventa = '" + codPuntoVenta + "'");
	if (!pixel || isNaN(pixel)) {
		pixel = 780;
	}
	var resolucion = AQUtil.sqlSelect("tpv_puntosventa", "resolucion", "codtpv_puntoventa = '" + codPuntoVenta + "'");
	if (!resolucion || isNaN(resolucion)) {
		resolucion = 300;
	}

	/// Ahora esta función no se está llamando porque sólo imprimimos si la impresora es esc-pos. De modificarlo habría que crear o sobrecargar la función que crea la consulta si no es correcta.
	var q = _i.establecerConsultaArqueo(nombreInforme);
	
	if(!q){
		return false;
	}
	
	_i.lanzarRptViewer(nombreInforme, q, impresora);
}


function oficial_lanzarRptViewer(nombreInforme, q, impresora)
{  
	var _i = this.iface;
  var cursor = this.cursor();
	
	var rptViewer = new FLReportViewer();
	
	rptViewer.setReportTemplate(nombreInforme);
	rptViewer.setReportData(q);
	rptViewer.renderReport();
	rptViewer.setPrinterName(impresora);
	/** Se comenta para sacar el informe con el visor de informes. Sobrecargar en la extensión que se considere.
	rptViewer.printReport();*/
	rptViewer.exec();
}

function oficial_establecerConsultaArqueo(nombreInforme)
{  
	var _i = this.iface;
  var cursor = this.cursor();
	
	var select = _i.dameSelect(nombreInforme);
	var from = _i.dameFrom(nombreInforme);
	var where = _i.dameWhere(nombreInforme);
	var q = new FLSqlQuery();
		
	q.setSelect(select);
	q.setFrom(from)
  q.setWhere(where);
	
	debug("CONSULTA ARQUEO: " + q.sql());
	
	if (!q.exec()) {
		sys.infoMsgBox("Falló la consulta");
		return false;
	} 
	if(!q.first()) {
		switch(nombreInforme){
			case "tpv_i_resumenvales_emitidos":{
				_i.msgNoImpresos_ += "-No se han EMITIDO vales en este arqueo.\n";
				break;
			}
			case "tpv_i_resumenvales_recibidos":{
				_i.msgNoImpresos_ += "-No se han RECIBIDOS vales en este arqueo.\n";
				break;
			}
			case "tpv_i_resumenvales_anulados":{
				_i.msgNoImpresos_ += "-No se han ANULADO vales en este arqueo.\n";
				break;
			}
			default:{
				_i.msgNoImpresos_ += _i.mensajeSinResultados(nombreInforme);
			}
		}
		return false;
  }
  return q;
}

function oficial_mensajeSinResultados(nombreInforme)
{  
	var _i = this.iface;
  var cursor = this.cursor();
	
	var msg = "-----\n";
	
	return msg;
}

function oficial_dameSelect(nombreInforme)
{  
	var _i = this.iface;
  var cursor = this.cursor();

	var select = "";
	
	switch (nombreInforme) {
		case "tpv_i_cierrearqueo":{
			select = "empresa.nombre, empresa.cifnif, empresa.direccion, empresa.ciudad, empresa.telefono, empresa.coddivisa, tpv_agentes.descripcion, ar.totalcaja, ar.observaciones, ar.inicio, ar.ptoventa, ar.idtpv_arqueo, ar.diferenciaefectivo, ar.diferenciavale, ar.diferenciatarjeta, ar.pagosefectivo, ar.pagostarjeta, ar.pagosvale, ar.devolucionesvale";
			break;
		}
		case "tpv_i_resumenvales_emitidos":{
			select = "empresa.coddivisa, empresa.nombre, ar.idtpv_arqueo, ar.ptoventa, c.codigo, c.idtpv_comanda, pc.importe, lc.codigovale, tpv_agentes.descripcion";
			break;
		}
		case "tpv_i_resumenvales_recibidos":
		case "tpv_i_resumenvales_anulados":{
			select = "empresa.coddivisa, empresa.nombre, ar.idtpv_arqueo, ar.ptoventa, c.codigo, c.total, c.idtpv_comanda, c.saldopendiente, c.saldoconsumido, pc.refvale, pc.importe, tpv_agentes.descripcion";
			break;
		}
		default:{
			flfactppal.iface.pub_msgNoDisponible("Informes");
		}
	}
	return select;
}

function oficial_dameFrom(nombreInforme)
{  
	var _i = this.iface;
  var cursor = this.cursor();

	var from = "";
	
	switch (nombreInforme) {
		case "tpv_i_cierrearqueo":{
			from = "empresa, tpv_arqueos ar INNER JOIN tpv_agentes ON ar.codtpv_agentecierre = tpv_agentes.codtpv_agente ";
			break;
		}
		case "tpv_i_resumenvales_emitidos":{
			from = "empresa, tpv_arqueos ar INNER JOIN tpv_agentes ON ar.codtpv_agentecierre = tpv_agentes.codtpv_agente INNER JOIN tpv_pagoscomanda pc ON ar.idtpv_arqueo = pc.idtpv_arqueo INNER JOIN tpv_comandas c ON c.idtpv_comanda = pc.idtpv_comanda INNER JOIN tpv_lineascomanda lc ON c.idtpv_comanda = lc.idtpv_comanda";
			break;
		}
		case "tpv_i_resumenvales_recibidos":
		case "tpv_i_resumenvales_anulados":{
			from = "empresa, tpv_arqueos ar INNER JOIN tpv_agentes ON ar.codtpv_agentecierre = tpv_agentes.codtpv_agente INNER JOIN tpv_pagoscomanda pc ON ar.idtpv_arqueo = pc.idtpv_arqueo INNER JOIN tpv_comandas c ON c.codigo = pc.refvale";
			break;
		}
		default:{
			flfactppal.iface.pub_msgNoDisponible("Informes");
		}
	}
	return from;
}

function oficial_dameWhere(nombreInforme)
{  
	var _i = this.iface;
  var cursor = this.cursor();

	var where = "";
	if(flfactppal.iface.pub_extension("multiempresa")) {
		var ejercicioActual = flfactppal.iface.pub_ejercicioActual();
		var idEmpresa = AQUtil.sqlSelect("ejercicios", "idempresa", "codejercicio = '" + ejercicioActual + "'");
		where += "empresa.id = " + idEmpresa + " AND ";
	}
	
	var codPago = flfact_tpv.iface.pub_valorDefectoTPV("pagovale");
			
	switch (nombreInforme) {
		case "tpv_i_cierrearqueo":{
			where += "ar.idtpv_arqueo = '" + cursor.valueBuffer("idtpv_arqueo") + "'";
			break;
		}
		case "tpv_i_resumenvales_emitidos":{
			where += "ar.idtpv_arqueo = '" + cursor.valueBuffer("idtpv_arqueo") + "' AND pc.codpago = '" + codPago+ "' AND c.tipodoc = 'DEVOLUCION' AND pc.importe < 0 AND lc.cantidad < 0 GROUP BY empresa.coddivisa, empresa.nombre, ar.idtpv_arqueo, ar.ptoventa, c.codigo, c.idtpv_comanda, pc.importe, lc.codigovale, tpv_agentes.descripcion";
			break;
		}
		case "tpv_i_resumenvales_recibidos":{
			where += "ar.idtpv_arqueo = '" + cursor.valueBuffer("idtpv_arqueo") + "' AND pc.codpago = '" + codPago+ "' AND pc.importe > 0 AND pc.refvale <> '' AND c.codigo = pc.refvale AND pc.anulado = false GROUP BY empresa.coddivisa, empresa.nombre, ar.idtpv_arqueo, ar.ptoventa, c.codigo, c.total, c.idtpv_comanda, c.saldopendiente, c.saldoconsumido, pc.refvale, pc.importe, tpv_agentes.descripcion ORDER BY pc.refvale";
			break;
		}
		case "tpv_i_resumenvales_anulados":{
			where += "ar.idtpv_arqueo = '" + cursor.valueBuffer("idtpv_arqueo") + "' AND pc.codpago = '" + codPago+ "' AND pc.importe > 0 AND pc.refvale <> '' AND c.codigo = pc.refvale AND pc.anulado = true GROUP BY empresa.coddivisa, empresa.nombre, ar.idtpv_arqueo, ar.ptoventa, c.codigo, c.total, c.idtpv_comanda, c.saldopendiente, c.saldoconsumido, pc.refvale, pc.importe, tpv_agentes.descripcion ORDER BY pc.refvale";
			break;
		}
		default:{
			flfactppal.iface.pub_msgNoDisponible("Informes");
		}
	}
	return where;
}

function oficial_adornosCabeceraCierre(q)
{
  flfact_tpv.iface.impLogo();
	
  flfact_tpv.iface.impResaltar(true);
  flfact_tpv.iface.impSubrayar(true);
	flfact_tpv.iface.impAlinearH(1);
	flfact_tpv.iface.imprimirDatos("*** CIERRE DE ARQUEO ***");
  flfact_tpv.iface.impNuevaLinea();
  flfact_tpv.iface.impResaltar(false);
  flfact_tpv.iface.impSubrayar(false);
}

function oficial_datosTiqueEmpresa(q)
{
  flfact_tpv.iface.imprimirDatos(q.value("empresa.nombre"));
  flfact_tpv.iface.impResaltar(false);
  flfact_tpv.iface.impSubrayar(false);
  flfact_tpv.iface.impNuevaLinea();
  flfact_tpv.iface.imprimirDatos(q.value("empresa.direccion"));
  flfact_tpv.iface.impNuevaLinea();
  flfact_tpv.iface.imprimirDatos(q.value("empresa.ciudad"));
  flfact_tpv.iface.impNuevaLinea();
  flfact_tpv.iface.imprimirDatos(sys.translate("Telef.") + "  ");
  flfact_tpv.iface.imprimirDatos(q.value("empresa.telefono"));
  flfact_tpv.iface.impNuevaLinea();
  flfact_tpv.iface.imprimirDatos(sys.translate("N.I.F.") + "  ");
  flfact_tpv.iface.imprimirDatos(q.value("empresa.cifnif"));

}

function oficial_imprimirConteo(q)
{
	var _i = this.iface;
	var cursor = this.cursor();
	
  flfact_tpv.iface.impNuevaLinea();
  flfact_tpv.iface.impResaltar(false);
  flfact_tpv.iface.impSubrayar(true);
	flfact_tpv.iface.imprimirDatos("",40);
  flfact_tpv.iface.impNuevaLinea(2);
	flfact_tpv.iface.impAlinearH(1);
	
  flfact_tpv.iface.impResaltar(false);
  flfact_tpv.iface.impSubrayar(false);
	
	flfact_tpv.iface.imprimirDatos("CONTEO EUROS");
  flfact_tpv.iface.impNuevaLinea(2);
	flfact_tpv.iface.impAlinearH(0);
	
	flfact_tpv.iface.imprimirDatos(sys.translate("Cantidad"), 10, 2);
	flfact_tpv.iface.imprimirDatos(sys.translate("          Tipo"), 20, 0);
	flfact_tpv.iface.imprimirDatos(sys.translate("Totales"), 10, 2);
	flfact_tpv.iface.impNuevaLinea(2);
	
	if(!formRecordtpv_arqueos.iface.pub_cargaStringList(cursor, true)){
		sys.infoMsgBox("Falló la carga de billetes y monedas");
		return false;
	}
	
	/// En tpv_arqueos no se guardan los campos b500,b200... porque esto sólo sería válido para euros. Los valores se guardan en un string.
	var aBilletes = formRecordtpv_arqueos.iface.aValorCantBilletes;
	var aMonedas = formRecordtpv_arqueos.iface.aValorCantMonedas;
	
	_i.imprimirBilletes(q, aBilletes);
	_i.imprimirMonedas(q, aMonedas);
	_i.imprimirTotalConteo(q);
	
}

function oficial_imprimirBilletes(q, aBilletes)
{
	var valor;
	var _i = this.iface;
	
	for (f = 0; f < formRecordtpv_arqueos.iface.numBilletes; f++){
		flfact_tpv.iface.imprimirDatos(aBilletes[f]["cantidad"], 10, 2);
		flfact_tpv.iface.imprimirDatos(" " + sys.translate("Bill. ") + aBilletes[f]["valor"] + " " + _i.codDivisa_, 19, 0);
		valor = parseFloat(aBilletes[f]["valor"]) * parseFloat(aBilletes[f]["cantidad"]);
		flfact_tpv.iface.imprimirDatos(AQUtil.formatoMiles(AQUtil.roundFieldValue(valor, "tpv_arqueos", "totalcaja")), 10, 2);
		if(_i.codDivisa_ == "EUR"){
			flfact_tpv.iface.impSimboloEuro();
		}
		flfact_tpv.iface.impNuevaLinea();
  }
}

function oficial_imprimirMonedas(q, aMonedas)
{
	var _i = this.iface;
	var valor;
	var codDivisa = q.value("empresa.coddivisa");
	
	for (f = 0; f < formRecordtpv_arqueos.iface.numMonedas; f++){
		flfact_tpv.iface.imprimirDatos(aMonedas[f]["cantidad"], 10, 2);
		flfact_tpv.iface.imprimirDatos(" " + sys.translate("Mon. ") + AQUtil.formatoMiles(aMonedas[f]["valor"]) + " " + _i.codDivisa_, 19, 0);
		valor = parseFloat(aMonedas[f]["valor"]) * parseFloat(aMonedas[f]["cantidad"]);
		flfact_tpv.iface.imprimirDatos(AQUtil.formatoMiles(AQUtil.roundFieldValue(valor, "tpv_arqueos", "totalcaja")) , 10, 2);
		if(_i.codDivisa_ == "EUR"){
			flfact_tpv.iface.impSimboloEuro();
		}
		flfact_tpv.iface.impNuevaLinea();
  }
}

function oficial_imprimirTotalConteo(q)
{
	var _i = this.iface;
	flfact_tpv.iface.impNuevaLinea();
	flfact_tpv.iface.imprimirDatos(" " + sys.translate("Total:"), 27, 2);
	flfact_tpv.iface.imprimirDatos(AQUtil.formatoMiles(AQUtil.roundFieldValue(parseFloat(q.value("ar.totalcaja")), "tpv_arqueos", "totalcaja")), 12, 2);
	if(_i.codDivisa_ == "EUR"){
		flfact_tpv.iface.impSimboloEuro();
	}
	flfact_tpv.iface.impNuevaLinea();
}

function oficial_imprimirResumenes(q)
{
	var _i = this.iface;
	
	_i.imprimirResumenEfectivo(q);
	_i.imprimirResumenTarjeta(q);
	_i.imprimirResumenVale(q);
}
	
function oficial_imprimirResumenEfectivo(q)
{
	var _i = this.iface;
	
  flfact_tpv.iface.impResaltar(false);
  flfact_tpv.iface.impSubrayar(true);
	flfact_tpv.iface.imprimirDatos("",40);
  flfact_tpv.iface.impNuevaLinea(2);
	flfact_tpv.iface.impAlinearH(1);
	
  flfact_tpv.iface.impResaltar(false);
  flfact_tpv.iface.impSubrayar(false);
	
	flfact_tpv.iface.imprimirDatos("RESUMEN EFECTIVO");
  flfact_tpv.iface.impNuevaLinea();
	flfact_tpv.iface.impAlinearH(0);
	
	var totalCaja = parseFloat(q.value("ar.totalcaja"));
	var cambioInicio = parseFloat(q.value("ar.inicio"));
	var saldoIngreso = totalCaja - cambioInicio;
	
	flfact_tpv.iface.imprimirDatos(sys.translate("Pagos efectivo"), 20, 0);
	flfact_tpv.iface.imprimirDatos(AQUtil.formatoMiles(AQUtil.roundFieldValue(q.value("ar.pagosefectivo"), "tpv_arqueos", "totalcaja")), 19, 2);
	if(_i.codDivisa_ == "EUR"){
		flfact_tpv.iface.impSimboloEuro();
	}
  flfact_tpv.iface.impNuevaLinea(2);
	
	flfact_tpv.iface.imprimirDatos(sys.translate("Contado efectivo"), 20, 0);
	flfact_tpv.iface.imprimirDatos(AQUtil.formatoMiles(AQUtil.roundFieldValue(totalCaja, "tpv_arqueos", "totalcaja")), 19, 2);
	if(_i.codDivisa_ == "EUR"){
		flfact_tpv.iface.impSimboloEuro();
	}
  flfact_tpv.iface.impNuevaLinea();
	
	flfact_tpv.iface.imprimirDatos(sys.translate("- Cambio inicial"), 20, 0);
	flfact_tpv.iface.imprimirDatos(AQUtil.formatoMiles(AQUtil.roundFieldValue(cambioInicio, "tpv_arqueos", "totalcaja")), 19, 2);
	if(_i.codDivisa_ == "EUR"){
		flfact_tpv.iface.impSimboloEuro();
	}
  flfact_tpv.iface.impNuevaLinea();
	
	_i.imprimirRetidasEfectivo(q, saldoIngreso);
	
	saldoIngreso += _i.retiradas_;
	
  flfact_tpv.iface.impResaltar(true);
	flfact_tpv.iface.imprimirDatos(sys.translate("A Ingresar"), 20, 0);
	flfact_tpv.iface.imprimirDatos(AQUtil.formatoMiles(AQUtil.roundFieldValue(saldoIngreso, "tpv_arqueos", "totalcaja")), 19, 2);
	if(_i.codDivisa_ == "EUR"){
		flfact_tpv.iface.impSimboloEuro();
	}
  flfact_tpv.iface.impNuevaLinea();
  flfact_tpv.iface.impResaltar(false);
}
	
function oficial_imprimirRetidasEfectivo(q, saldoIngreso)
{
	var _i = this.iface;
	_i.retiradas_ = 0;
}

function oficial_imprimirResumenTarjeta(q)
{
	var _i = this.iface;
	
  flfact_tpv.iface.impNuevaLinea();
  flfact_tpv.iface.impResaltar(false);
  flfact_tpv.iface.impSubrayar(true);
	flfact_tpv.iface.imprimirDatos("",40);
  flfact_tpv.iface.impNuevaLinea(2);
	flfact_tpv.iface.impAlinearH(1);
	
  flfact_tpv.iface.impResaltar(false);
  flfact_tpv.iface.impSubrayar(false);
	
	flfact_tpv.iface.imprimirDatos("RESUMEN TARJETA");
  flfact_tpv.iface.impNuevaLinea();
	flfact_tpv.iface.impAlinearH(0);
	
  flfact_tpv.iface.impResaltar(true);
	flfact_tpv.iface.imprimirDatos(sys.translate("Pagos tarjeta"), 20, 0);
	flfact_tpv.iface.imprimirDatos(AQUtil.formatoMiles(AQUtil.roundFieldValue(q.value("ar.pagostarjeta"), "tpv_arqueos", "totalcaja")), 19, 2);
	if(_i.codDivisa_ == "EUR"){
		flfact_tpv.iface.impSimboloEuro();
	}
  flfact_tpv.iface.impNuevaLinea();
  flfact_tpv.iface.impResaltar(false);
}
	
function oficial_imprimirResumenVale(q)
{
	var _i = this.iface;
	
  flfact_tpv.iface.impNuevaLinea();
  flfact_tpv.iface.impResaltar(false);
  flfact_tpv.iface.impSubrayar(true);
	flfact_tpv.iface.imprimirDatos("",40);
  flfact_tpv.iface.impNuevaLinea(2);
	flfact_tpv.iface.impAlinearH(1);
	
  flfact_tpv.iface.impResaltar(false);
  flfact_tpv.iface.impSubrayar(false);
	
	flfact_tpv.iface.imprimirDatos("RESUMEN VALES");
  flfact_tpv.iface.impNuevaLinea();
	flfact_tpv.iface.impAlinearH(0);
	
	flfact_tpv.iface.imprimirDatos(sys.translate("Pagos con Vale"), 20, 0);
	flfact_tpv.iface.imprimirDatos(AQUtil.formatoMiles(AQUtil.roundFieldValue(q.value("ar.pagosvale"), "tpv_arqueos", "totalcaja")), 19, 2);
	if(_i.codDivisa_ == "EUR"){
		flfact_tpv.iface.impSimboloEuro();
	}
  flfact_tpv.iface.impNuevaLinea();
	
	flfact_tpv.iface.imprimirDatos(sys.translate("Vales Emitidos"), 20, 0);
	flfact_tpv.iface.imprimirDatos(AQUtil.formatoMiles(AQUtil.roundFieldValue(q.value("ar.devolucionesvale"), "tpv_arqueos", "totalcaja")), 19, 2);
	if(_i.codDivisa_ == "EUR"){
		flfact_tpv.iface.impSimboloEuro();
	}
  flfact_tpv.iface.impNuevaLinea();
}

function oficial_imprimirDiferencia(q)
{
	var _i = this.iface;
	var cursor = this.cursor();
	/**
	Se utiliza en juguetiland*/
}

function oficial_imprimirPieCierre(q)
{
	var _i = this.iface;
	
  flfact_tpv.iface.impNuevaLinea();
  flfact_tpv.iface.impResaltar(false);
  flfact_tpv.iface.impSubrayar(true);
	flfact_tpv.iface.imprimirDatos("",40);
  flfact_tpv.iface.impNuevaLinea(2);
	flfact_tpv.iface.impAlinearH(1);
	
  flfact_tpv.iface.impResaltar(false);
  flfact_tpv.iface.impSubrayar(false);
	
	flfact_tpv.iface.imprimirDatos("OBSERVACIONES");
  flfact_tpv.iface.impNuevaLinea(2);
	flfact_tpv.iface.impAlinearH(0);
	
	flfact_tpv.iface.impFont(1);
	/// Coge un string y lo va imprimiendo por líneas tantos caracteres como longitud de la misma sin partir las palabras
	formtpv_comandas.iface.pub_imprimirTextoPieEmpresa(q.value("ar.observaciones"), 56);
	flfact_tpv.iface.impFont(0);
}

function oficial_comprobarCoincidenciaArqueo(diaHasta, diaDesde, ptoVenta, idArqueo)
{
	/**
	var _i = this.iface;
	var cursor = this.cursor();
	
	if (AQUtil.sqlSelect("tpv_arqueos", "diadesde", "idtpv_arqueo <> '" + idArqueo + "' AND ptoventa = '" + ptoVenta + "' AND ((diadesde >= '" + diaDesde + "' AND diahasta <= '" + diaDesde + "') OR (diadesde >= '" + diaHasta + "' AND diahasta <= '" + diaHasta + "'))")) {
		MessageBox.warning(sys.translate("Ya existe un arqueo para ese punto de venta que coincide con ese intervalo de fechas"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}*/
	return true;
}

function oficial_imprimirCabeceraResumen(q, titulo)
{
	var _i = this.iface;
	
  flfact_tpv.iface.impResaltar(true);
  flfact_tpv.iface.impSubrayar(true);
	flfact_tpv.iface.impAlinearH(1);
	flfact_tpv.iface.imprimirDatos("*** Resumen de Vales " + titulo + " ***");
  flfact_tpv.iface.impNuevaLinea(2);
  flfact_tpv.iface.impResaltar(false);
  flfact_tpv.iface.impSubrayar(false);
	
	flfact_tpv.iface.imprimirDatos("Caja: " + q.value("ar.ptoventa").right(1), 7,0);
	
	var d = new Date;
	flfact_tpv.iface.imprimirDatos(" " + AQUtil.dateAMDtoDMA(d.toString()), 11, 0);
	flfact_tpv.iface.imprimirDatos("Cierre:",14,2);
	flfact_tpv.iface.imprimirDatos(q.value("ar.idtpv_arqueo"),8,2);
	flfact_tpv.iface.impNuevaLinea(2);
	
  flfact_tpv.iface.impSubrayar(true);
  flfact_tpv.iface.impFont(1);
	
	switch(titulo){
		case "Emitidos":{
			flfact_tpv.iface.imprimirDatos(sys.translate("Nº Vale"), 22,0);
			flfact_tpv.iface.imprimirDatos(sys.translate("Ticket Origen"), 22, 0);
			flfact_tpv.iface.imprimirDatos(sys.translate("Importe"), 12, 2);
			break;
		}
		case "Recibidos":{
			flfact_tpv.iface.imprimirDatos(sys.translate("Nº Vale"), 17, 0);
			flfact_tpv.iface.imprimirDatos(sys.translate("Tot.Importe"), 13, 2);
			flfact_tpv.iface.imprimirDatos(sys.translate("Dispuesto"), 13, 2);
			flfact_tpv.iface.imprimirDatos(sys.translate("Saldo Pte."), 13, 2);
			break;
		}
		case "Anulados":{
			flfact_tpv.iface.imprimirDatos(sys.translate("Nº Vale"), 20,0);
			flfact_tpv.iface.imprimirDatos(sys.translate("Total Importe"), 18, 2);
			flfact_tpv.iface.imprimirDatos(sys.translate("Imp. Anulado"), 18, 2);
			break;
		}
	}
	flfact_tpv.iface.impNuevaLinea();
  flfact_tpv.iface.impSubrayar(false);
	flfact_tpv.iface.impNuevaLinea();
}

function oficial_imprimirLineasResumenEmitidos(q)
{
	var _i = this.iface;
	
	flfact_tpv.iface.imprimirDatos(q.value("c.codigo"), 22,0);
	flfact_tpv.iface.imprimirDatos(q.value("lc.codigovale"), 22, 0);
	var valor = parseFloat(q.value("pc.importe")* (-1));
	flfact_tpv.iface.imprimirDatos(AQUtil.formatoMiles(AQUtil.roundFieldValue(valor, "tpv_arqueos", "totalcaja")), 11, 2);
  if(_i.codDivisa_ == "EUR"){
		flfact_tpv.iface.impSimboloEuro();
	}
	flfact_tpv.iface.impNuevaLinea();
}

function oficial_imprimirLineasResumenRecibidos(q)
{
	var _i = this.iface;
	
	flfact_tpv.iface.imprimirDatos(q.value("pc.refvale"), 17,0);
	flfact_tpv.iface.imprimirDatos(AQUtil.formatoMiles(AQUtil.roundFieldValue(parseFloat(q.value("c.total")) * (-1), "tpv_arqueos", "totalcaja")), 12, 2);
  if(_i.codDivisa_ == "EUR"){
		flfact_tpv.iface.impSimboloEuro();
	}
	flfact_tpv.iface.imprimirDatos(AQUtil.formatoMiles(AQUtil.roundFieldValue(q.value("pc.importe"), "tpv_arqueos", "totalcaja")), 12, 2);
  if(_i.codDivisa_ == "EUR"){
		flfact_tpv.iface.impSimboloEuro();
	}
	flfact_tpv.iface.imprimirDatos(AQUtil.formatoMiles(AQUtil.roundFieldValue(q.value("c.saldopendiente"), "tpv_arqueos", "totalcaja")), 12, 2);
  if(_i.codDivisa_ == "EUR"){
		flfact_tpv.iface.impSimboloEuro();
	}
	flfact_tpv.iface.impNuevaLinea();
}

function oficial_imprimirLineasResumenAnulados(q)
{
	var _i = this.iface;
	
	flfact_tpv.iface.imprimirDatos(q.value("pc.refvale"), 20,0);
	flfact_tpv.iface.imprimirDatos(AQUtil.formatoMiles(AQUtil.roundFieldValue(parseFloat(q.value("c.total"))*(-1), "tpv_arqueos", "totalcaja")), 17, 2);
  if(_i.codDivisa_ == "EUR"){
		flfact_tpv.iface.impSimboloEuro();
	}
	flfact_tpv.iface.imprimirDatos(AQUtil.formatoMiles(AQUtil.roundFieldValue(q.value("pc.importe"), "tpv_arqueos", "totalcaja")), 17, 2);
  if(_i.codDivisa_ == "EUR"){
		flfact_tpv.iface.impSimboloEuro();
	}
	flfact_tpv.iface.impNuevaLinea();
}

function oficial_imprimirPieResumen(q, resumen)
{
	var _i = this.iface;
	
	flfact_tpv.iface.impFont(0);
	_i.imprimirTotalesResumen(resumen);
	
	flfact_tpv.iface.impAlinearH(1);
	flfact_tpv.iface.imprimirDatos(sys.translate("GRAPAR ESTE RESUMEN AL CIERRE"));
	
	flfact_tpv.iface.impNuevaLinea();
	flfact_tpv.iface.imprimirDatos("Usuario: ");
	flfact_tpv.iface.imprimirDatos(q.value("tpv_agentes.descripcion"));
	flfact_tpv.iface.impNuevaLinea();
}

function oficial_imprimirTotalesResumen(resumen)
{
	var _i = this.iface;
	
  flfact_tpv.iface.impSubrayar(true);
	flfact_tpv.iface.imprimirDatos("",40);
  flfact_tpv.iface.impNuevaLinea();
	
  flfact_tpv.iface.impSubrayar(false);
	
	flfact_tpv.iface.imprimirDatos("Total",6,0);
	
	switch(resumen){
		case "Emitidos":{
			flfact_tpv.iface.imprimirDatos(AQUtil.formatoMiles(AQUtil.roundFieldValue(parseFloat(_i.importeA_) * (-1), "tpv_arqueos", "totalcaja")),33,2);
			if(_i.codDivisa_ == "EUR"){
				flfact_tpv.iface.impSimboloEuro();
			}
			break;
		}
		case "Recibidos":{
			flfact_tpv.iface.imprimirDatos(AQUtil.formatoMiles(AQUtil.roundFieldValue(_i.importeA_, "tpv_arqueos", "totalcaja")),13,2);
			if(_i.codDivisa_ == "EUR"){
				flfact_tpv.iface.impSimboloEuro();
			}
			flfact_tpv.iface.imprimirDatos(AQUtil.formatoMiles(AQUtil.roundFieldValue(_i.importeB_, "tpv_arqueos", "totalcaja")),9,2);
			if(_i.codDivisa_ == "EUR"){
				flfact_tpv.iface.impSimboloEuro();
			}
			flfact_tpv.iface.imprimirDatos(AQUtil.formatoMiles(AQUtil.roundFieldValue(_i.importeC_, "tpv_arqueos", "totalcaja")),9,2);
			if(_i.codDivisa_ == "EUR"){
				flfact_tpv.iface.impSimboloEuro();
			}
			break;
		}
		case "Anulados":{
			flfact_tpv.iface.imprimirDatos(AQUtil.formatoMiles(AQUtil.roundFieldValue(_i.importeA_, "tpv_arqueos", "totalcaja")),21,2);
			if(_i.codDivisa_ == "EUR"){
				flfact_tpv.iface.impSimboloEuro();
			}
			flfact_tpv.iface.imprimirDatos(AQUtil.formatoMiles(AQUtil.roundFieldValue(_i.importeB_, "tpv_arqueos", "totalcaja")),11,2);
			if(_i.codDivisa_ == "EUR"){
				flfact_tpv.iface.impSimboloEuro();
			}
			break;
		}
		case "Retirada":{
			flfact_tpv.iface.imprimirDatos(AQUtil.formatoMiles(AQUtil.roundFieldValue(parseFloat(_i.importeA_), "tpv_arqueos", "totalcaja")),33,2);
			if(_i.codDivisa_ == "EUR"){
				flfact_tpv.iface.impSimboloEuro();
			}
			break;
		}
	}
  flfact_tpv.iface.impNuevaLinea(2);
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
