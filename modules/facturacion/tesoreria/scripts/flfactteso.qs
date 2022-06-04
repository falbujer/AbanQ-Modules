/***************************************************************************
                 flfactteso.qs  -  description
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
    function afterCommit_pagosdevolcli(curPD:FLSqlCursor) {
		return this.ctx.interna_afterCommit_pagosdevolcli(curPD);
	}
	function beforeCommit_pagosdevolcli(curPD:FLSqlCursor) {
		return this.ctx.interna_beforeCommit_pagosdevolcli(curPD);
	}
	function afterCommit_reciboscli(curR:FLSqlCursor) {
		return this.ctx.interna_afterCommit_reciboscli(curR);
	}
	function afterCommit_pagosdevolprov(curPD:FLSqlCursor) {
		return this.ctx.interna_afterCommit_pagosdevolprov(curPD);
	}
	function beforeCommit_pagosdevolprov(curPD:FLSqlCursor) {
		return this.ctx.interna_beforeCommit_pagosdevolprov(curPD);
	}
	function beforeCommit_remesas(curRemesa:FLSqlCursor) {
		return this.ctx.interna_beforeCommit_remesas(curRemesa);
	}
	function beforeCommit_pagosdevolrem(curPR:FLSqlCursor) {
		return this.ctx.interna_beforeCommit_pagosdevolrem(curPR);
	}
	function afterCommit_pagosdevolrem(curPD:FLSqlCursor) {
		return this.ctx.interna_afterCommit_pagosdevolrem(curPD);
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var curReciboCli:FLSqlCursor;
	var curPagoDevolCli_;
	var pagoIndirectoRemCli_, pagoDiferidoRemCli_
    function oficial( context ) { interna( context ); }
	function actualizarRiesgoCliente(codCliente:String) {
		return this.ctx.oficial_actualizarRiesgoCliente(codCliente);
	}
	function obtenerWhereEstadoRiesgoCliente() {
		return this.ctx.oficial_obtenerWhereEstadoRiesgoCliente();
	}
	function obtenerMasWhereRiesgoCliente() {
		return this.ctx.oficial_obtenerMasWhereRiesgoCliente();
	}
	function tienePagosDevCli(idRecibo:Number) {
		return this.ctx.oficial_tienePagosDevCli(idRecibo);
	}
	function regenerarRecibosCli(cursor:FLSqlCursor, emitirComo:String) {
		return this.ctx.oficial_regenerarRecibosCli(cursor, emitirComo);
	}
	function obtenerEmitirComo(cursor,emitirComo) {
		return this.ctx.oficial_obtenerEmitirComo(cursor,emitirComo);
	}
	function generarReciboCli(curFactura:FLSqlCursor, numRecibo:String, importe:Number, fechaVto:String, emitirComo:String, datosCuentaDom:Array, datosCuentaEmp:Array, datosSubcuentaEmp:Array) {
		return this.ctx.oficial_generarReciboCli(curFactura, numRecibo, importe, fechaVto, emitirComo, datosCuentaDom, datosCuentaEmp, datosSubcuentaEmp);
	}
	function generaRecibosPreviosCli(cursor, oRecibo) {
		return this.ctx.oficial_generaRecibosPreviosCli(cursor, oRecibo);
	}
	function generaReciboCli(curFactura, oRecibo) {
		return this.ctx.oficial_generaReciboCli(curFactura, oRecibo);
	}
	function obtenerDatosCuentaDom(codCliente:String) {
		return this.ctx.oficial_obtenerDatosCuentaDom(codCliente);
	}
	function obtenerDatosCuentaEmp(codCliente:String, codPago:String) {
		return this.ctx.oficial_obtenerDatosCuentaEmp(codCliente, codPago);
	}
	function obtenerDatosSubcuentaEmp(datosCuentaEmp:Array) {
		return this.ctx.oficial_obtenerDatosSubcuentaEmp(datosCuentaEmp);
	}
	function borrarRecibosCli(idFactura:Number) {
		return this.ctx.oficial_borrarRecibosCli(idFactura);
	}
	function calcFechaVencimientoCli(curFactura:FLSqlCursor, numPlazo:Number, diasAplazado:Number) {
		return this.ctx.oficial_calcFechaVencimientoCli(curFactura, numPlazo, diasAplazado);
	}
	function fechaValorFacturaCli(curFactura) {
		return this.ctx.oficial_fechaValorFacturaCli(curFactura);
	}
	function regenerarRecibosProv(cursor:FLSqlCursor, emitirComo:String) {
		return this.ctx.oficial_regenerarRecibosProv(cursor, emitirComo);
	}
	function datosReciboCli(curFactura, oRecibo) {
		return this.ctx.oficial_datosReciboCli(curFactura, oRecibo);
	}
	function calcularEstadoFacturaCli(idRecibo:String, idFactura:String) {
		return this.ctx.oficial_calcularEstadoFacturaCli(idRecibo, idFactura);
	}
	function estadosReciboFraCliBloqueo() {
		return this.ctx.oficial_estadosReciboFraCliBloqueo();
	}
	function cambiaUltimoPagoCli(idRecibo:String, idPagoDevol:String, unlock:Boolean) {
		return this.ctx.oficial_cambiaUltimoPagoCli(idRecibo, idPagoDevol, unlock);
	}
	function generarAsientoPagoDevolCli(curPD:FLSqlCursor) {
		return this.ctx.oficial_generarAsientoPagoDevolCli(curPD);
	}
	function dameEjercicioAsientoPD(curPD) {
		return this.ctx.oficial_dameEjercicioAsientoPD(curPD);
	}
	function generarPartidasCli(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array) {
		return this.ctx.oficial_generarPartidasCli(curPD, valoresDefecto, datosAsiento, recibo);
	}
	function dameDatosReciboCli(curPD) {
		return this.ctx.oficial_dameDatosReciboCli(curPD);
	}
	function dameSubcuentaCliPD(curPD, valoresDefecto, datosAsiento, recibo) {
		return this.ctx.oficial_dameSubcuentaCliPD(curPD, valoresDefecto, datosAsiento, recibo);
	}
	function pagoIndirectoRemesasCli() {
		return this.ctx.oficial_pagoIndirectoRemesasCli();
	}
	function pagoDiferidoRemesasCli() {
		return this.ctx.oficial_pagoDiferidoRemesasCli();
	}
	function datosPartidaPagoDevolCli(curPartida, curPD, valoresDefecto, datosAsiento, recibo) {
		return this.ctx.oficial_datosPartidaPagoDevolCli(curPartida, curPD, valoresDefecto, datosAsiento, recibo);
	}
	function importeReciboPagoDevolCli(curPD, recibo) {
		return this.ctx.oficial_importeReciboPagoDevolCli(curPD, recibo);
	}
	function generarPartidasBanco(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array) {
		return this.ctx.oficial_generarPartidasBanco(curPD, valoresDefecto, datosAsiento, recibo);
	}
	function importeReciboPagoBanco(curPD, recibo) {
		return this.ctx.oficial_importeReciboPagoBanco(curPD, recibo);
	}
	function generarPartidasCambio(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array) {
		return this.ctx.oficial_generarPartidasCambio(curPD, valoresDefecto, datosAsiento, recibo);
	}
	function comprobarCuentasDom(idRemesa:String) {
		return this.ctx.oficial_comprobarCuentasDom(idRemesa);
	}
	function automataActivado() {
		return this.ctx.oficial_automataActivado();
	}
	function generarAsientoPagoRemesa(curPR:FLSqlCursor) {
		return this.ctx.oficial_generarAsientoPagoRemesa(curPR);
	}
	function generarPartidasEFCOGC(curPR:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, remesa:Array) {
		return this.ctx.oficial_generarPartidasEFCOGC(curPR, valoresDefecto, datosAsiento, remesa);
	}
	function generarPartidasBancoRem(curPR:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, remesa:Array) {
		return this.ctx.oficial_generarPartidasBancoRem(curPR, valoresDefecto, datosAsiento, remesa);
	}
	function generarPartidasClienteRem(curPR, valoresDefecto, datosAsiento, remesa) {
		return this.ctx.oficial_generarPartidasClienteRem(curPR, valoresDefecto, datosAsiento, remesa);
	}
	function datosPartidaClienteRem(curPartida, curPD, valoresDefecto, datosAsiento, remesa) {
		return this.ctx.oficial_datosPartidaClienteRem(curPartida, curPD, valoresDefecto, datosAsiento, remesa);
	}
	function esPagoEstePagoDevol(curPD:FLSqlCursor) {
		return this.ctx.oficial_esPagoEstePagoDevol(curPD);
	}
	function generarAsientoInverso(idAsientoDestino:Number, idAsientoOrigen:Number, concepto:String, codEjercicio:String) {
		return this.ctx.oficial_generarAsientoInverso(idAsientoDestino, idAsientoOrigen, concepto, codEjercicio);
	}
	function totalesReciboCli() {
		return this.ctx.oficial_totalesReciboCli();
	}
	function datosPagoDevolCli(curFactura) {
		return this.ctx.oficial_datosPagoDevolCli(curFactura);
	}
	function actualizarTotalesReciboCli(idRecibo) {
		return this.ctx.oficial_actualizarTotalesReciboCli(idRecibo);
	}
  function valorDefectoTesoreria(valor) {
    return this.ctx.oficial_valorDefectoTesoreria(valor);
  }
  function modificaEstadoPagosRemesa(curPR, estado) {
    return this.ctx.oficial_modificaEstadoPagosRemesa(curPR, estado);
  }
  function cargaValoresDefecto() {
    return this.ctx.oficial_cargaValoresDefecto();
  }
  function creaGrupoRecibosCli(oParam) {
    return this.ctx.oficial_creaGrupoRecibosCli(oParam);
  }
  function creaGrupoRecibosMultiCli(oParam) {
    return this.ctx.oficial_creaGrupoRecibosMultiCli(oParam);
  }
  function reciboAgrupable(curRecibo) {
    return this.ctx.oficial_reciboAgrupable(curRecibo);
  }
  function copiarCampoGrupoRecibos(nombreCampo, cursor, campoInformado) {
    return this.ctx.oficial_copiarCampoGrupoRecibos(nombreCampo, cursor, campoInformado);
  }
  function obtenerSecuencia(prefijo) {
    return this.ctx.oficial_obtenerSecuencia(prefijo);
  }
  function quitaGrupoReciboCli(curR, totalizar) {
    return this.ctx.oficial_quitaGrupoReciboCli(curR, totalizar);
  }
  function ponGrupoReciboCli(curRecibo, idGrupo, totalizar) {
    return this.ctx.oficial_ponGrupoReciboCli(curRecibo, idGrupo, totalizar);
  }
  function quitaGrupoRecibosCli(oParam) {
    return this.ctx.oficial_quitaGrupoRecibosCli(oParam);
  }
  function controlEstadoFraCli(curR) {
    return this.ctx.oficial_controlEstadoFraCli(curR);
  }
  function totalizaGrupoRecibos(idGrupo) {
    return this.ctx.oficial_totalizaGrupoRecibos(idGrupo);
  }
  function dameDivisaEmpresa(codEjercicio) {
    return this.ctx.oficial_dameDivisaEmpresa(codEjercicio);
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
	function pub_actualizarRiesgoCliente(codCliente:String) {
		return this.actualizarRiesgoCliente(codCliente);
	}
	function pub_regenerarRecibosCli(cursor:FLSqlCursor, emitirComo:String) {
		return this.regenerarRecibosCli(cursor, emitirComo);
	}
	function pub_regenerarRecibosProv(cursor:FLSqlCursor, emitirComo:String) {
		return this.regenerarRecibosProv(cursor, emitirComo);
	}
	function pub_calcularEstadoFacturaCli(idRecibo:String, idFactura:String) {
		return this.calcularEstadoFacturaCli(idRecibo, idFactura);
	}
	function pub_comprobarCuentasDom(idRemesa:String) {
		return this.comprobarCuentasDom(idRemesa);
	}
	function pub_automataActivado() {
		return this.automataActivado();
	}
	function pub_actualizarTotalesReciboCli(idRecibo) {
		return this.actualizarTotalesReciboCli(idRecibo);
	}
  function pub_valorDefectoTesoreria(valor) {
    return this.valorDefectoTesoreria(valor);
  }
  function pub_cargaValoresDefecto() {
    return this.cargaValoresDefecto();
  }
  function pub_creaGrupoRecibosCli(oParam) {
    return this.creaGrupoRecibosCli(oParam);
  }
  function pub_quitaGrupoReciboCli(curR, totalizar) {
    return this.quitaGrupoReciboCli(curR, totalizar);
  }
  function pub_quitaGrupoRecibosCli(oParam) {
    return this.quitaGrupoRecibosCli(oParam);
  }
  function pub_ponGrupoReciboCli(curRecibo, idGrupo, totalizar) {
    return this.ponGrupoReciboCli(curRecibo, idGrupo, totalizar);
  }
  function pub_creaGrupoRecibosMultiCli(oParam) {
    return this.creaGrupoRecibosMultiCli(oParam);
  }
  function pub_totalesReciboCli() {
    return this.totalesReciboCli();
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
/** \D Se actualiza el campo idremesa de los pagos con el valor del campo idremesa del recibo
\end */
function interna_init()
{
	var util:FLUtil;
	if (!util.sqlSelect("remesas", "idremesa", "1 = 1"))
		return;
	if (util.sqlSelect("pagosdevolcli", "idremesa", "idremesa IS NOT NULL AND idremesa <> 0"))
		return;
	var qryRecibos= new FLSqlQuery;
	qryRecibos.setTablesList("reciboscli,pagosdevolcli");
	qryRecibos.setSelect("pd.idpagodevol, r.idremesa, MAX(pd.fecha)")
	qryRecibos.setFrom("reciboscli r INNER JOIN pagosdevolcli pd ON r.idrecibo = pd.idrecibo")
	qryRecibos.setWhere("r.idremesa IS NOT NULL AND r.idremesa <> 0 AND pd.tipo = 'Pago' AND (pd.idremesa IS NULL OR pd.idremesa = 0) GROUP BY pd.idpagodevol, r.idremesa");
	qryRecibos.setForwardOnly(true);
	if (!qryRecibos.exec())
		return;
	var editable:Boolean;
	var paso= 0;
	var curPD= new FLSqlCursor("pagosdevolcli");
	curPD.setActivatedCommitActions(false);
	curPD.transaction(false);
	try {
		util.createProgressDialog(sys.translate("Actualizando pagos de recibos remesados"), qryRecibos.size());
		while (qryRecibos.next()) {
			util.setProgress(paso)
			curPD.select("idpagodevol = " + qryRecibos.value("pd.idpagodevol"))
			if (!curPD.first()) {
				curPD.rollback();
				util.destroyProgressDialog();
				break;
			}
			editable = curPD.valueBuffer("editable");
			if (!editable) {
				curPD.setUnLock("editable", true);
				curPD.select("idpagodevol = " + qryRecibos.value("pd.idpagodevol"));
				curPD.first();
			}
			curPD.setModeAccess(curPD.Edit);
			curPD.refreshBuffer();
			curPD.setValueBuffer("idremesa", qryRecibos.value("r.idremesa"));
			if (!curPD.commitBuffer()) {
				curPD.rollback();
				util.destroyProgressDialog();
				break;
			}
			if (!editable) {
				curPD.select("idpagodevol = " + qryRecibos.value("pd.idpagodevol"));
				curPD.first();
				curPD.setUnLock("editable", false);
			}
			paso++;
		}
	} catch (e) {
		util.destroyProgressDialog();
		curPD.rollback();
	}
	curPD.setActivatedCommitActions(true);
	util.destroyProgressDialog();
	if (paso == qryRecibos.size()) {
		debug("Commit");
		curPD.commit();
	} else
		curPD.rollback();
}

/** \C Se elimina, si es posible, el asiento contable asociado al pago o devolución
\end */
function interna_afterCommit_pagosdevolcli(curPD:FLSqlCursor)
{
	var _i = this.iface;
	var idRecibo= curPD.valueBuffer("idrecibo");
	/** \C Se cambia el pago anterior al actual para que sólo el último sea editable
	\end */
	switch (curPD.modeAccess()) {
		case curPD.Insert:
		case curPD.Edit: {
			if (!this.iface.cambiaUltimoPagoCli(idRecibo, curPD.valueBuffer("idpagodevol"), false))
				return false;
			break;
		}
		case curPD.Del: {
			if (!this.iface.cambiaUltimoPagoCli(idRecibo, curPD.valueBuffer("idpagodevol"), true))
				return false;
			break;
		}
	}
	
	if (!this.iface.calcularEstadoFacturaCli(idRecibo))
		return false;
	
	
	var util= new FLUtil();
	if (sys.isLoadedModule("flcontppal") == false || util.sqlSelect("empresa", "contintegrada", "1 = 1") == false)
		return true;

	switch (curPD.modeAccess()) {
		case curPD.Del: {
			if (curPD.isNull("idasiento"))
				return true;
	
			var idAsiento= curPD.valueBuffer("idasiento");
			if (flfacturac.iface.pub_asientoBorrable(idAsiento) == false)
				return false;
	
			if (!flfacturac.iface.pub_eliminarAsiento(idAsiento)) {
				return false;
			}
// 			var curAsiento= new FLSqlCursor("co_asientos");
// 			curAsiento.select("idasiento = " + idAsiento);
// 			if (curAsiento.first()) {
// 				curAsiento.setUnLock("editable", true);
// 				curAsiento.setModeAccess(curAsiento.Del);
// 				curAsiento.refreshBuffer();
// 				if (!curAsiento.commitBuffer())
// 					return false;
// 			}
			break;
		}
		case curPD.Edit: {
			if (curPD.valueBuffer("nogenerarasiento") || curPD.valueBuffer("tipo") == "Remesado" || (_i.pagoDiferidoRemesasCli() && !_i.pagoIndirectoRemesasCli(curPD))) {
				var idAsientoAnterior= curPD.valueBufferCopy("idasiento");
				if (idAsientoAnterior && idAsientoAnterior != "") {
					if (!flfacturac.iface.pub_eliminarAsiento(idAsientoAnterior))
						return false;
				}
			}
			break;
		}
	}
	
	return true;
}

/** \C Se regenera, si es posible, el asiento contable asociado al pago o devolución
\end */
function interna_beforeCommit_pagosdevolcli(curPD:FLSqlCursor)
{
	var util= new FLUtil();
	if (sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada") && !curPD.valueBuffer("nogenerarasiento")) {
		if (!this.iface.generarAsientoPagoDevolCli(curPD)) {
			return false;
		}
	}
	
	return true;
}

/** \C Se recalcula el riesgo alcanzado
\end */
function interna_afterCommit_reciboscli(curR)
{
	var _i = this.iface;
	
	if (curR.valueBuffer("codcliente")) {
		_i.actualizarRiesgoCliente(curR.valueBuffer("codcliente"));
	}
	if (!_i.controlEstadoFraCli(curR)) {
		return false;
	}
	
// 	if (!_i.controlTotalesGrupo(curR)) {
// 		return false;
// 	}
	
	return true;
}
/** \C Funcionalidad no implementada para la versión oficial
\end */
function interna_afterCommit_pagosdevolprov(curPD:FLSqlCursor)
{
	return true;
}

/** \C Funcionalidad no implementada para la versión oficial
\end */
function interna_beforeCommit_pagosdevolprov(curPD:FLSqlCursor)
{
	return true;
}

function interna_beforeCommit_remesas(curRemesa:FLSqlCursor)
{

	switch (curRemesa.modeAccess()) {
		/** \C La remesa puede borrarse si todos los pagos asociados pueden ser excluidos
		\end */
		case curRemesa.Del: {
			var idRemesa= curRemesa.valueBuffer("idremesa");
			var qryRecibos= new FLSqlQuery;
			qryRecibos.setTablesList("pagosdevolcli");
			qryRecibos.setSelect("DISTINCT(idrecibo)");
			qryRecibos.setFrom("pagosdevolcli");
			qryRecibos.setWhere("idremesa = " + idRemesa);
			qryRecibos.setForwardOnly(true);
			if (!qryRecibos.exec())
				return false;
			while (qryRecibos.next()) {
				if (!formRecordremesas.iface.pub_excluirReciboRemesa(qryRecibos.value(0), idRemesa))
					return false;
			}
		}
	}
	return true;
}

/** \C Se regenera, si es posible, el asiento contable asociado al pago de una remesa
\end */
function interna_beforeCommit_pagosdevolrem(curPR:FLSqlCursor)
{
	var util= new FLUtil();
	if (sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada") && !curPR.valueBuffer("nogenerarasiento")) {
		if (!this.iface.generarAsientoPagoRemesa(curPR))
			return false;
	}
	
	return true;
}

/** \C Se elimina, si es posible, el asiento contable asociado al pago o devolución
\end */
function interna_afterCommit_pagosdevolrem(curPD:FLSqlCursor)
{
	var _i = this.iface;
	var util= new FLUtil();
	if (sys.isLoadedModule("flcontppal") == false || util.sqlSelect("empresa", "contintegrada", "1 = 1") == false)
		return true;

	var pagoIndirecto = _i.valorDefectoTesoreria("pagoindirecto");
	var pagoDiferido = _i.valorDefectoTesoreria("pagodiferido");
	switch (curPD.modeAccess()) {
		case curPD.Del: {
			if (pagoDiferido && !pagoIndirecto) {
				/// Pago diferido. Se cambia el estado para forzar el borrado de los asientos de pago
				if (!_i.modificaEstadoPagosRemesa(curPD, "Remesado")) {
					return false;
				}
			}
			
			if (curPD.isNull("idasiento"))
				return true;
	
			var idAsiento= curPD.valueBuffer("idasiento");
			if (flfacturac.iface.pub_asientoBorrable(idAsiento) == false)
				return false;
	
			var curAsiento= new FLSqlCursor("co_asientos");
			curAsiento.select("idasiento = " + idAsiento);
			if (curAsiento.first()) {
				curAsiento.setUnLock("editable", true);
				curAsiento.setModeAccess(curAsiento.Del);
				curAsiento.refreshBuffer();
				if (!curAsiento.commitBuffer())
					return false;
			}
			break;
		}
		case curPD.Edit: {
			if (curPD.valueBuffer("nogenerarasiento")) {
				var idAsientoAnterior= curPD.valueBufferCopy("idasiento");
				if (idAsientoAnterior && idAsientoAnterior != "") {
					if (!flfacturac.iface.pub_eliminarAsiento(idAsientoAnterior))
						return false;
				}
			}
			break;
		}
	}
	
	return true;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D Actualiza el valor del riesgo alcanzado para un cliente. El valor se calcula como la suma de importes de: recibos emitidos - recibos pagados + recibos devueltos
@param codCliente: Código del cliente
\end */
function oficial_actualizarRiesgoCliente(codCliente:String)
{
	var _i = this.iface;
	
	var whereEstado = _i.obtenerWhereEstadoRiesgoCliente();
	var masWhere = _i.obtenerMasWhereRiesgoCliente();
	
	var riesgo= parseFloat(AQUtil.sqlSelect( "reciboscli", "SUM(importe)", "codcliente='" + codCliente + "'" + whereEstado + masWhere));
	if (!riesgo || isNaN(riesgo))
		riesgo = 0;

	AQUtil.sqlUpdate( "clientes", "riesgoalcanzado", riesgo, "codcliente = '" + codCliente + "'" );

	if ( !flfactteso.iface.pub_automataActivado() ) {
		var riesgoMax= parseFloat(AQUtil.sqlSelect( "clientes", "riesgomax", "codcliente = '" + codCliente + "'" ));
		if ( riesgo >= riesgoMax && riesgoMax > 0 ) {
			MessageBox.warning(sys.translate("El cliente ") + codCliente + sys.translate(" ha superado el riesgo máximo"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		}
	}
}

function oficial_obtenerWhereEstadoRiesgoCliente()
{
	return " AND estado NOT IN ('Pagado','Agrupado')";
}

function oficial_obtenerMasWhereRiesgoCliente()
{
	return "";
}

/** \D Genera las partidas inversas correspondientes a un asiento, asociándolas a otro.
@param idAsientoDestino Asiento de destino para la partida
@param idAsientoOrigen Asiento de origen para la partida
@param concepto Concepto de la partida inversa
\end */
/// Llamada por recibos_prov
function oficial_generarAsientoInverso(idAsientoDestino:Number, idAsientoOrigen:Number, concepto:String, codEjercicio:String)
{
	var util= new FLUtil;
	var curPartida= new FLSqlCursor("co_partidas");
	curPartida.select("idasiento = " + idAsientoDestino);
	qryPartidaOriginal = new FLSqlQuery();
	with(qryPartidaOriginal) {
		setTablesList("co_partidas");
		setSelect("codsubcuenta, debe, haber, coddivisa, tasaconv, debeME, haberME");
		setFrom("co_partidas");
		setWhere("idasiento = " + idAsientoOrigen);
	}
	try { qryPartidaOriginal.setForwardOnly( true ); } catch (e) {}
	if (!qryPartidaOriginal.exec())
		return false;

	while (qryPartidaOriginal.next()) {
		var idSubcuenta= util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + qryPartidaOriginal.value(0) + "' AND codejercicio = '" + codEjercicio + "'");
		if (!idSubcuenta) {
			MessageBox.warning(sys.translate("No existe la subcuenta ")  + qryPartidaOriginal.value(0) + sys.translate(" correspondiente al ejercicio ") + codEjercicio + sys.translate(".\nPara poder realizar el asiento debe crear antes esta subcuenta"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return false;
		}
		with(curPartida) {
			setModeAccess(curPartida.Insert);
			refreshBuffer();
			setValueBuffer("concepto", concepto);
			setValueBuffer("idsubcuenta", idSubcuenta);
			setValueBuffer("codsubcuenta", qryPartidaOriginal.value(0));
			setValueBuffer("idasiento", idAsientoDestino);
			setValueBuffer("debe", qryPartidaOriginal.value(2));
			setValueBuffer("haber", qryPartidaOriginal.value(1));
			setValueBuffer("coddivisa", qryPartidaOriginal.value(3));
			setValueBuffer("tasaconv", qryPartidaOriginal.value(4));
			setValueBuffer("debeME", qryPartidaOriginal.value(6));
			setValueBuffer("haberME", qryPartidaOriginal.value(5));
		}
		if (!curPartida.commitBuffer())
			return false;
	}
	return true;
}

/* \D Indica si un determinado recibo tiene pagos y/o devoluciones asociadas.
@param idRecibo: Identificador del recibo
@return True: Tiene, False: No tiene
\end */
function oficial_tienePagosDevCli(idRecibo:Number)
{
	var curPagosDev= new FLSqlCursor("pagosdevolcli");
	curPagosDev.select("idrecibo = " + idRecibo);
	return curPagosDev.next();
}

/* \D Calcula la fecha de vencimiento de un recibo, como la fecha de facturación más los días del plazo correspondiente
@param curFactura: Cursor posicionado en el registro de facturas correspondiente a la factura
@param numPlazo: Número del plazo actual
@param diasAplazado: Días de aplazamiento del pago
@return Fecha de vencimiento
\end */
function oficial_calcFechaVencimientoCli(curFactura:FLSqlCursor, numPlazo:Number, diasAplazado:Number)
{
	var util = new FLUtil;
	var _i = this.iface;
	var fechaValor = _i.fechaValorFacturaCli(curFactura);
	return util.addDays(fechaValor, diasAplazado);
}

function oficial_fechaValorFacturaCli(curFactura)
{
	return curFactura.valueBuffer("fecha");
}

/* \D Regenera los recibos asociados a una factura a cliente.
Si la contabilidad está activada, genera los correspondientes asientos de pago y devolución.

@param cursor: Cursor posicionado en el registro de facturascli correspondiente a la factura
@return True: Regeneración realizada con éxito, False: Error
\end */
function oficial_regenerarRecibosCli(cursor, emitirComo)
{
	var util= new FLUtil();
	var contActiva= sys.isLoadedModule("flcontppal") && util.sqlSelect("empresa", "contintegrada", "1 = 1");

	var idFactura= cursor.valueBuffer("idfactura");
	var total = parseFloat(cursor.valueBuffer("total"));

	if (!this.iface.borrarRecibosCli(idFactura))
		return false;
		
	if (total == 0) {
		return true;
	}

	var codPago = cursor.valueBuffer("codpago");
	var codCliente = cursor.valueBuffer("codcliente");

	var emitirComo= this.iface.obtenerEmitirComo(cursor,emitirComo);
	
	var datosCuentaDom = this.iface.obtenerDatosCuentaDom(codCliente);
	if (datosCuentaDom.error == 2) {
		return false;
	}
	var numRecibo = 1;
	var numPlazo = 1;
	var importe:Number;
	var diasAplazado:Number;
	var fechaVencimiento:String;
	var datosCuentaEmp= false;
	var datosSubcuentaEmp= false;

	if (emitirComo == "Pagados") {
		emitirComo = "Pagado";
		/** \D Si los recibos deben emitirse como pagados, se generarán los registros de pago asociados a cada recibo. Si el módulo Principal de contabilidad está cargado, se generará el correspondienta asiento. La subcuenta contable del Debe del apunte corresponderá a la subcuenta contable asociada a la cuenta corriente correspondiente a la forma de pago de la factura. Si dicha cuenta corriente no está especificada, la subcuenta contable del Debe del asiento será la correspondiente a la cuenta especial Caja.
		\end */
		datosCuentaEmp = this.iface.obtenerDatosCuentaEmp(codCliente, codPago);
		if (datosCuentaEmp.error == 2) {
			return false;
		}
		if (contActiva) {
			datosSubcuentaEmp = this.iface.obtenerDatosSubcuentaEmp(datosCuentaEmp);
			if (datosSubcuentaEmp.error == 2) {
				return false;
			}
		}
	} else {
		emitirComo = "Emitido";
	}
	var oRecibo = new Object;
	oRecibo["emitircomo"] = emitirComo;
	oRecibo["datoscuentadom"] = datosCuentaDom;
	oRecibo["datoscuentaemp"] = datosCuentaEmp;
	oRecibo["datossubcuentaemp"] = datosSubcuentaEmp;

	var datosRecibosPrevios = this.iface.generaRecibosPreviosCli(cursor, oRecibo);
	if (!datosRecibosPrevios) {
		return false;
	}
	numRecibo = datosRecibosPrevios["numrecibo"];
	total = datosRecibosPrevios["totalpendiente"];
	
	var importeAcumulado = 0;
	var curPlazos= new FLSqlCursor("plazos");
	curPlazos.select("codpago = '" + codPago + "' ORDER BY dias");
	if(curPlazos.size() == 0) {
		MessageBox.warning(sys.translate("No se pueden generar los recibos, la forma de pago ") + codPago + sys.translate("no tiene plazos de pago asociados"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
	while (curPlazos.next()) {
		diasAplazado = curPlazos.valueBuffer("dias");
		if ( curPlazos.at() == ( curPlazos.size() - 1 ) ) {
			importe = parseFloat(total) - parseFloat(importeAcumulado);
		} else {
			importe = (parseFloat(total) * parseFloat(curPlazos.valueBuffer("aplazado"))) / 100;
		}
		importe = util.roundFieldValue(importe, "reciboscli","importe");
		importeAcumulado = parseFloat(importeAcumulado) + parseFloat(importe);

		fechaVencimiento = this.iface.calcFechaVencimientoCli(cursor, numPlazo, diasAplazado);
		oRecibo["numrecibo"] = numRecibo;
		oRecibo["importe"] = importe;
		oRecibo["fechavto"] = fechaVencimiento;
		if (!this.iface.generaReciboCli(cursor, oRecibo)) {
			return false;
		}
		numRecibo++;
		numPlazo++;
	}

	if (emitirComo == "Pagado") {
		if (!this.iface.calcularEstadoFacturaCli(false, idFactura))
			return false;
	}

	if (cursor.valueBuffer("codcliente"))
		if (sys.isLoadedModule("flfactteso"))
			this.iface.actualizarRiesgoCliente(codCliente);

	return true;
}

function oficial_obtenerEmitirComo(cursor,emitirComo)
{
	var valor = "";
	
	var codPago = cursor.valueBuffer("codpago");
	if(codPago && codPago != "")
		valor = AQUtil.sqlSelect("formaspago", "genrecibos", "codpago = '" + codPago + "'");
	
	if(!valor || valor == "")
		valor = "Emitidos";
	
	return valor;		
}
	
function oficial_generaRecibosPreviosCli(cursor, oRecibo)
{
	var aDatos = new Object();
	aDatos["numrecibo"] = 1;
	aDatos["totalpendiente"] = parseFloat(cursor.valueBuffer("total"));
	return aDatos;
}


function oficial_actualizarTotalesReciboCli(idRecibo)
{
	this.iface.curReciboCli = new FLSqlCursor("reciboscli");
	this.iface.curReciboCli.select("idrecibo = " + idRecibo);
	if (!this.iface.curReciboCli.first()) {
		return false;
	}
	this.iface.curReciboCli.setModeAccess(this.iface.curReciboCli.Edit);
	this.iface.curReciboCli.refreshBuffer();
	if (!this.iface.totalesReciboCli()) {
		return false;
	}
	if (!this.iface.curReciboCli.commitBuffer()) {
		return false;
	}
	return true;
}

/** \D Genera un recibo con los datos proporcionados. Si el recibo se emite como pagado y la contabilidad está integrada, se generará el asiento de pago correspondiente

@param curFactura: Cursor posicionado en la factura de la que proviene el recibo
@param numRecibo: Ordinal del recibo dentro del grupo de recibos asociados a la factura
@param importe: Importe del recibo
@param fechaVto: Fecha de vencimiento
@param emitirComo: Indica si el recibo se emitirá como 'Pagado' o como 'Emitido'.
@param datosCuentaDom: Datos de la cuenta de domiciación, si existe
@param datosCuentaEmp: Datos de la cuenta de la empresa para realizar el pago
@param datosSubcuentaEmp: Datos contables de la subcuenta asociada a la cuenta bancaria de la empresa
@return True si no hay error, false en caso contrario
\end */
function oficial_generarReciboCli(curFactura, numRecibo, importe, fechaVto, emitirComo, datosCuentaDom, datosCuentaEmp, datosSubcuentaEmp)
{
	var oRecibo = new Object;
	oRecibo["numrecibo"] = numRecibo;
	oRecibo["importe"] = importe;
	oRecibo["fechavto"] = fechaVto;
	oRecibo["emitircomo"] = emitirComo;
	oRecibo["datoscuentadom"] = datosCuentaDom;
	oRecibo["datoscuentaemp"] = datosCuentaEmp;
	oRecibo["datossubcuentaemp"] = datosSubcuentaEmp;
	return this.iface.generaReciboCli(curFactura, oRecibo);
}

function oficial_generaReciboCli(curFactura, oRecibo)
{
	var numRecibo = oRecibo["numrecibo"];
	var importe = oRecibo["importe"];
	var fechaVto = oRecibo["fechavto"];
	var emitirComo = oRecibo["emitircomo"];
	var datosCuentaDom = oRecibo["datoscuentadom"];
	var datosCuentaEmp = oRecibo["datoscuentaemp"];
	var datosSubcuentaEmp = oRecibo["datossubcuentaemp"];
	
	if (!this.iface.curReciboCli) {
		this.iface.curReciboCli = new FLSqlCursor("reciboscli");
	}
	var util= new FLUtil();
	var importeEuros= importe * parseFloat(curFactura.valueBuffer("tasaconv"));
	var divisa= util.sqlSelect("divisas", "descripcion", "coddivisa = '" + curFactura.valueBuffer("coddivisa") + "'");
	var codDir= curFactura.valueBuffer("coddir");
	with (this.iface.curReciboCli) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("numero", numRecibo);
		setValueBuffer("idfactura", curFactura.valueBuffer("idfactura"));
		setValueBuffer("importe", importe);
		setValueBuffer("texto", util.enLetraMoneda(importe, divisa));
		setValueBuffer("importeeuros", importeEuros);
		setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
		setValueBuffer("codigo", curFactura.valueBuffer("codigo") + "-" + flfacturac.iface.pub_cerosIzquierda(numRecibo, 2));
		setValueBuffer("codcliente", curFactura.valueBuffer("codcliente"));
		setValueBuffer("nombrecliente", curFactura.valueBuffer("nombrecliente"));
		setValueBuffer("cifnif", curFactura.valueBuffer("cifnif"));
		setValueBuffer("codagente", curFactura.valueBuffer("codagente"));
		setValueBuffer("codpago", curFactura.valueBuffer("codpago"));
		if (codDir == 0)
			setNull("coddir");
		else
			setValueBuffer("coddir", codDir);
		setValueBuffer("direccion", curFactura.valueBuffer("direccion"));
		setValueBuffer("codpostal", curFactura.valueBuffer("codpostal"));
		setValueBuffer("ciudad", curFactura.valueBuffer("ciudad"));
		setValueBuffer("provincia", curFactura.valueBuffer("provincia"));
		setValueBuffer("codpais", curFactura.valueBuffer("codpais"));
		setValueBuffer("fecha", curFactura.valueBuffer("fecha"));

		if (datosCuentaDom.error == 0) {
			setValueBuffer("codcuenta", datosCuentaDom.codcuenta);
			setValueBuffer("descripcion", datosCuentaDom.descripcion);
			setValueBuffer("ctaentidad", datosCuentaDom.ctaentidad);
			setValueBuffer("ctaagencia", datosCuentaDom.ctaagencia);
			setValueBuffer("cuenta", datosCuentaDom.cuenta);
			setValueBuffer("dc", datosCuentaDom.dc);
		}
		setValueBuffer("fechav", fechaVto);
		setValueBuffer("estado", emitirComo);
	}
	this.iface.curReciboCli.setValueBuffer("codcuentapagocli", formRecordreciboscli.iface.pub_commonCalculateField("codcuentapagocli", this.iface.curReciboCli));
	if (!this.iface.datosReciboCli(curFactura, oRecibo)) {
		return false;
	}
	if (!this.iface.curReciboCli.commitBuffer()) {
		return false;
	}
	if (emitirComo == "Pagado") {
		var idRecibo = this.iface.curReciboCli.valueBuffer("idrecibo");
		this.iface.curPagoDevolCli_ = new FLSqlCursor("pagosdevolcli");
		with(this.iface.curPagoDevolCli_) {
			setModeAccess(Insert);
			refreshBuffer();
			setValueBuffer("idrecibo", idRecibo);
			setValueBuffer("tipo", "Pago");
			setValueBuffer("fecha", curFactura.valueBuffer("fecha"));
			setValueBuffer("tasaconv", curFactura.valueBuffer("tasaconv"));
			if (datosCuentaEmp.error == 0) {
				setValueBuffer("codcuenta", datosCuentaEmp.codcuenta);
				setValueBuffer("descripcion", datosCuentaEmp.descripcion);
				setValueBuffer("ctaentidad", datosCuentaEmp.ctaentidad);
				setValueBuffer("ctaagencia", datosCuentaEmp.ctaagencia);
				setValueBuffer("dc", datosCuentaEmp.dc);
				setValueBuffer("cuenta", datosCuentaEmp.cuenta);
			}
			if (datosSubcuentaEmp && datosSubcuentaEmp.error == 0) {
				setValueBuffer("codsubcuenta", datosSubcuentaEmp.codsubcuenta);
				setValueBuffer("idsubcuenta", datosSubcuentaEmp.idsubcuenta);
			}
		}
		if (!this.iface.datosPagoDevolCli(curFactura)) {
			return false;
		}
		if (!this.iface.curPagoDevolCli_.commitBuffer()) {
			return false;
		}
		this.iface.curReciboCli.select("idrecibo = " + idRecibo);
		if (this.iface.curReciboCli.first()) {
			this.iface.curReciboCli.setModeAccess(this.iface.curReciboCli.Edit);
			this.iface.curReciboCli.refreshBuffer();
		
			if (!this.iface.totalesReciboCli()) {
				return false;
			}
			if (!this.iface.curReciboCli.commitBuffer()) {
				return false;
			}
		}
	}
	return true;
}

function oficial_datosPagoDevolCli(curFactura)
{
	return true;
}

function oficial_totalesReciboCli()
{
	this.iface.curReciboCli.setValueBuffer("fechapago", formRecordreciboscli.iface.pub_commonCalculateField("fechapago", this.iface.curReciboCli));
	this.iface.curReciboCli.setValueBuffer("codcuentapagocli", formRecordreciboscli.iface.pub_commonCalculateField("codcuentapagocli", this.iface.curReciboCli));
	this.iface.curReciboCli.setValueBuffer("situacion", formRecordreciboscli.iface.pub_commonCalculateField("situacion", this.iface.curReciboCli));
	return true;
}

/* \D Borra los recibos asociados a una factura. No es posible borrar recibos que pertenecen a una remesa o que tienen pagos o devoluciones asociados.

@param idFactura: Identificador de la factura de la que provienen los recibos
@return False si hay error o si el recibo no se puede borrar, true si los recibos se borran correctamente
\end */
function oficial_borrarRecibosCli(idFactura:Number)
{
	var curRecibos = new FLSqlCursor("reciboscli");
	curRecibos.select("idfactura = " + idFactura);
	while (curRecibos.next()) {
		curRecibos.setModeAccess(curRecibos.Browse);
		curRecibos.refreshBuffer();
		if (curRecibos.valueBuffer("idremesa") != 0) {
			return false;
		}
		if (this.iface.tienePagosDevCli(curRecibos.valueBuffer("idrecibo"))) {
			return false;
		}
	}
	curRecibos.select("idfactura = " + idFactura);
	while (curRecibos.next()) {
		curRecibos.setModeAccess(curRecibos.Del);
		curRecibos.refreshBuffer();
		if (!curRecibos.commitBuffer())
			return false;
	}
	return true;
}

/* \D Obtiene los datos de la cuenta de domiciliación de un cliente

@param codCliente: Identificador del cliente
@return Array con los datos de la cuenta o false si no existe o hay un error. Los elementos de este array son:
	descripcion: Descripcion de la cuenta
	ctaentidad: Código de entidad bancaria
	ctaagencia: Código de oficina
	cuenta: Número de cuenta
	dc: Dígitos de control
	codcuenta: Código de la cuenta en la tabla de cuentas
	error: 0.Sin error 1.Datos no encontrados 2.Error
\end */
function oficial_obtenerDatosCuentaDom(codCliente:String)
{
	var datosCuentaDom= [];
	var util= new FLUtil;
	var domiciliarEn= util.sqlSelect("clientes", "codcuentadom", "codcliente = '" + codCliente + "'");

	if (domiciliarEn != "") {
		datosCuentaDom = flfactppal.iface.pub_ejecutarQry("cuentasbcocli", "descripcion,ctaentidad,ctaagencia,cuenta,codcuenta", "codcuenta = '" + domiciliarEn + "'");
		switch (datosCuentaDom.result) {
		case -1:
			datosCuentaDom.error = 1;
			break;
		case 0:
			datosCuentaDom.error = 2;
			break;
		case 1:
			datosCuentaDom.dc = util.calcularDC(datosCuentaDom.ctaentidad + datosCuentaDom.ctaagencia) + util.calcularDC(datosCuentaDom.cuenta);
			datosCuentaDom.error = 0;
			break;
		}
	} else {
		datosCuentaDom.error = 1;
	}

	return datosCuentaDom;
}

/* \D Obtiene los datos de la cuenta de la empresa asociada a un determinado cliente o forma de pago. Si el cliente está informado, toma su cuenta 'Remesar en'. Si no lo está, se toma la cuenta bancaria asociada a la forma de pago

@param codPago: Identificador de la forma de pago
@return Array con los datos de la cuenta o false si no existe o hay un error. Los elementos de este array son:
	descripcion: Descripcion de la cuenta
	ctaentidad: Código de entidad bancaria
	ctaagencia: Código de oficina
	cuenta: Número de cuenta
	dc: Dígitos de control
	codsubcuenta: Código de la subcuenta contable asociada
	codcuenta: Código de la cuenta en la tabla de cuentas
	error: 0.Sin error 1.Datos no encontrados 2.Error
\end */
function oficial_obtenerDatosCuentaEmp(codCliente:String, codPago:String)
{
	var util= new FLUtil;
	var datosCuentaEmp= [];
	var codCuentaEmp= util.sqlSelect("clientes", "codcuentarem", "codcliente = '" + codCliente + "'");
	if (!codCuentaEmp)
		codCuentaEmp = util.sqlSelect("formaspago", "codcuenta", "codpago = '" + codPago + "'");
		
	if (!codCuentaEmp.toString().isEmpty()) {
		datosCuentaEmp = flfactppal.iface.pub_ejecutarQry("cuentasbanco", "descripcion,ctaentidad,ctaagencia,cuenta,codsubcuenta,codcuenta", "codcuenta = '" + codCuentaEmp + "'");
		switch (datosCuentaEmp.result) {
		case -1:
			datosCuentaEmp.error = 1;
			break;
		case 0:
			datosCuentaEmp.error = 2;
			break;
		case 1:
			datosCuentaEmp.dc = util.calcularDC(datosCuentaEmp.ctaentidad + datosCuentaEmp.ctaagencia) + util.calcularDC(datosCuentaEmp.cuenta);
			datosCuentaEmp.error = 0;
			break;
		}
	} else {
		datosCuentaEmp.error = 1;
	}
	return datosCuentaEmp;
}

/* \D Obtiene los datos de la subcuenta contable asociada a una determinada cuenta bancaria. Si la cuenta bancaria no existe busca la subcuenta contable correspondiente a Caja.

@param datosCuentaEmp: Datos de la cuenta bancaria
@return Array con los datos de la subcuenta o false si no existe o hay un error. Los elementos de este array son:
	codsubcuenta: Código de subcuenta
	idsubcuenta: Identificador de la subcuenta en la tabla de subcuenta
	error: 0.Sin error 1.Datos no encontrados 2.Error
\end */
function oficial_obtenerDatosSubcuentaEmp(datosCuentaEmp:Array)
{
	var util= new FLUtil;
	var datosSubcuentaEmp= [];
	var codEjercicio= flfactppal.iface.pub_ejercicioActual();
	if (datosCuentaEmp.error == 0) {
		datosSubcuentaEmp = flfactppal.iface.pub_ejecutarQry("co_subcuentas", "idsubcuenta,codsubcuenta", "codsubcuenta = '" + datosCuentaEmp.codsubcuenta + "' AND codejercicio = '" + codEjercicio + "'");
		switch (datosSubcuentaEmp.result) {
		case -1:
			MessageBox.warning(sys.translate("La cuenta bancaria asociada a la forma de pago seleccionada no tiene una cuenta contable válida asociada"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			datosSubcuentaEmp.error = 2;
			break;
		case 0:
			datosSubcuentaEmp.error = 2;
			break;
		case 1:
			datosSubcuentaEmp.error = 0;
		}
	} else {
		datosSubcuentaEmp = flfacturac.iface.pub_datosCtaEspecial("CAJA", codEjercicio);
	}
	return datosSubcuentaEmp;
}

/* \D Regenera los recibos asociados a una factura a proveedor. Funcionalidad no disponible en la versión oficial
\end */
function oficial_regenerarRecibosProv(cursor:FLSqlCursor, emitirComo:String)
{
	return true;
}

/* \D Función para sobrecargar. Sirve para añadir al cursor del recibo los datos que añada la extensión
\end */
function oficial_datosReciboCli(curFactura, oRecibo)
{
	return true;
}

/** \D Cambia la factura relacionada con un recibo a editable o no editable en función de si tiene pagos asociados o no
@param	idRecibo: Identificador de un recibo asociado a la factura
@param	idFactura: Identificador de la factura
@return	true si la verificación del estado es correcta, false en caso contrario
\end */
function oficial_calcularEstadoFacturaCli(idRecibo, idFactura)
{
	debug("oficial_calcularEstadoFacturaCli");
	var _i = this.iface;
	var util= new FLUtil();
	if (!idFactura) {
		idFactura = util.sqlSelect("reciboscli", "idfactura", "idrecibo = " + idRecibo);
		if (!idFactura) { /// Recibo agrupado
			debug("agrupado");
			return true;
		}
	}
	
	var idReciboBloq = AQUtil.sqlSelect("reciboscli", "idrecibo", "idfactura = " + idFactura + " AND estado IN (" + _i.estadosReciboFraCliBloqueo() + ")");
debug("idReciboBloq " + idReciboBloq);
	var editable = idReciboBloq ? false : true;
debug("editable " + editable);
	
	var curFactura= new FLSqlCursor("facturascli");
	curFactura.select("idfactura = " + idFactura);
	if (!curFactura.first()) {
		return false;
	}
	curFactura.setUnLock("editable", editable);
	
	
// 	var qryPagos= new FLSqlQuery();
// 	qryPagos.setTablesList("reciboscli,pagosdevolcli");
// 	qryPagos.setSelect("p.idpagodevol");
// 	qryPagos.setFrom("reciboscli r INNER JOIN pagosdevolcli p ON r.idrecibo = p.idrecibo");
// 	qryPagos.setWhere("r.idfactura = " + idFactura);
// 	qryPagos.setForwardOnly( true );
// 	if (!qryPagos.exec()) {
// 		return false;
// 	}
// 	var curFactura= new FLSqlCursor("facturascli");
// 	curFactura.select("idfactura = " + idFactura);
// 	if (!curFactura.first()) {
// 		return false;
// 	}
//   if (qryPagos.size() == 0) {
//     curFactura.setUnLock("editable", true);
//   } else {
//     curFactura.setUnLock("editable", false);
//   }
  return true;
}

function oficial_estadosReciboFraCliBloqueo()
{
	return "'Pagado', 'Devuelto', 'Remesado', 'Agrupado'";
}

/** \D Cambia la el estado del último pago anterior al especificado, de forma que se mantenga como único pago editable el último de todos
@param	idRecibo: Identificador del recibo al que pertenecen los pagos tratados
@param	idPagoDevol: Identificador del pago que ha cambiado
@param	unlock: Indicador de si el últim pago debe ser editable o no
@return	true si la verificación del estado es correcta, false en caso contrario
\end */
function oficial_cambiaUltimoPagoCli(idRecibo:String, idPagoDevol:String, unlock:Boolean)
{
	var curPagosDevol= new FLSqlCursor("pagosdevolcli");
	curPagosDevol.select("idrecibo = " + idRecibo + " AND idpagodevol <> " + idPagoDevol + " ORDER BY fecha, idpagodevol");
	if (curPagosDevol.last())
		curPagosDevol.setUnLock("editable", unlock);
		
	return true;
}

function oficial_dameEjercicioAsientoPD(curPD)
{
	var codEjercicio;
	if (curPD.valueBuffer("tpv")) {
		codEjercicio = AQUtil.sqlSelect("reciboscli r INNER JOIN facturascli f ON r.idfactura = f.idfactura", "f.codejercicio", "r.idrecibo = " + curPD.valueBuffer("idrecibo"), "reciboscli");
	} else {
		codEjercicio = flfactppal.iface.pub_ejercicioActual();
	}
	return codEjercicio;
}

/** \Genera o regenera el asiento contable asociado a un pago o devolución de recibo
@param	curPD: Cursor posicionado en el pago o devolución cuyo asiento se va a regenerar
@return	true si la regeneración se realiza correctamente, false en caso contrario
\end */
function oficial_generarAsientoPagoDevolCli(curPD:FLSqlCursor)
{
  var _i = this.iface;
  var util = new FLUtil();
  if (curPD.modeAccess() != curPD.Insert && curPD.modeAccess() != curPD.Edit) {
    return true;
  }
  
  if (curPD.valueBuffer("nogenerarasiento")) {
    curPD.setNull("idasiento");
    return true;
  }
  
  var codEjercicio = _i.dameEjercicioAsientoPD(curPD);
  var datosDoc= flfacturac.iface.pub_datosDocFacturacion(curPD.valueBuffer("fecha"), codEjercicio, "pagosdevolcli");
  if (!datosDoc.ok)
    return false;
  if (datosDoc.modificaciones == true) {
    codEjercicio = datosDoc.codEjercicio;
    curPD.setValueBuffer("fecha", datosDoc.fecha);
  }
  
  var datosAsiento= [];
  var valoresDefecto:Array;
  valoresDefecto["codejercicio"] = codEjercicio;
  valoresDefecto["coddivisa"] = _i.dameDivisaEmpresa(codEjercicio);
	
  var curTransaccion= new FLSqlCursor("empresa");
  curTransaccion.transaction(false);
  try {
    switch (curPD.valueBuffer("tipo")) {
    case "Pago":
		case "Remesado": { 
				if (curPD.valueBuffer("idremesa") && _i.pagoDiferidoRemesasCli() && !_i.pagoIndirectoRemesasCli(curPD)) {
					/// El asiento se genera por pago de remesa, no por pago de recibo.
					curPD.setNull("idasiento"); /// para remesas a medio al hacer el cambio en programación de generación de asiento de pago por pago a pago por remesa
					break;
				}
// 				if (curPD.valueBuffer("tipo") == "Remesado" && !_i.pagoIndirectoRemesasCli(curPD)) {
// 					/// El asiento se genera cuando pasa a Pago
// 					curPD.setNull("idasiento"); /// Actúa en el caso de que se borre el pago de la remesa y haya que eliminar los asientos asociados a los pagos que pasan a de Pago a Remesado
// 					break;
// 				}
        datosAsiento = flfacturac.iface.pub_regenerarAsiento(curPD, valoresDefecto);
        if (datosAsiento.error == true) {
          throw sys.translate("Error al regenerar el asiento");
        }
        
        
        var recibo = _i.dameDatosReciboCli(curPD);
        if (recibo.result != 1) {
          throw sys.translate("Error al obtener los datos del recibo");
        }
        if (!this.iface.generarPartidasCli(curPD, valoresDefecto, datosAsiento, recibo)) {
          throw sys.translate("Error al obtener la partida de cliente");
        }
        if (!this.iface.generarPartidasBanco(curPD, valoresDefecto, datosAsiento, recibo)) {
          throw sys.translate("Error al obtener la partida de banco");
        }
        if (!this.iface.generarPartidasCambio(curPD, valoresDefecto, datosAsiento, recibo)) {
          throw sys.translate("Error al obtener la partida de diferencias por cambio");
        }
        curPD.setValueBuffer("idasiento", datosAsiento.idasiento);
         if (!flcontppal.iface.pub_comprobarAsiento(datosAsiento.idasiento)) {
           throw sys.translate("Error al comprobar el asiento");
         };
        break;
      }
    case "Devolución": {
        datosAsiento = flfacturac.iface.pub_regenerarAsiento(curPD, valoresDefecto);
        if (datosAsiento.error == true) {
          throw sys.translate("Error al regenerar el asiento");
        }
        var recibo= flfactppal.iface.pub_ejecutarQry("reciboscli", "coddivisa,importe,importeeuros,idfactura,codigo,nombrecliente,codcliente", "idrecibo = " + curPD.valueBuffer("idrecibo"));
        if (recibo.result != 1) {
          throw sys.translate("Error al obtener los datos del recibo");
        }
        if (!this.iface.generarPartidasCli(curPD, valoresDefecto, datosAsiento, recibo)) {
          throw sys.translate("Error al obtener la partida de cliente");
        }
        if (!this.iface.generarPartidasBanco(curPD, valoresDefecto, datosAsiento, recibo)) {
          throw sys.translate("Error al obtener la partida de banco");
        }
        if (!this.iface.generarPartidasCambio(curPD, valoresDefecto, datosAsiento, recibo)) {
          throw sys.translate("Error al obtener la partida de diferencias por cambio");
        }
         curPD.setValueBuffer("idasiento", datosAsiento.idasiento);
         if (!flcontppal.iface.pub_comprobarAsiento(datosAsiento.idasiento)) {
           throw sys.translate("Error al comprobar el asiento");
         };
        break;
      }
//     case "Remesado": { /// El asiento se genera cuando pasa a Pago
// 			curPD.setNull("idasiento"); /// Actúa en el caso de que se borre el pago de la remesa y haya que eliminar los asientos asociados a los pagos que pasan a de Pago a Remesado
//         break;
//       }
    }
  } catch (e) {
    curTransaccion.rollback();
    var codRecibo= util.sqlSelect("reciboscli", "codigo", "idrecibo = " + curPD.valueBuffer("idrecibo"));
    MessageBox.warning(sys.translate("Error al generar el asiento correspondiente a %1 del recibo %2:").arg(curPD.valueBuffer("tipo")).arg(codRecibo) + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
    return false;
  }
  curTransaccion.commit();
  return true;
}

function oficial_pagoIndirectoRemesasCli()
{
	var _i = this.iface;
	if (_i.pagoIndirectoRemCli_ == undefined) {
		_i.cargaValoresDefecto();
		if (_i.pagoIndirectoRemCli_ == undefined) {
			MessageBox.critical(sys.translate("Error al obtener los valores por defecto del módulo de tesorería"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
			return false;
		}
	}
	return _i.pagoIndirectoRemCli_;
}

function oficial_pagoDiferidoRemesasCli()
{
	var _i = this.iface;
	if (_i.pagoDiferidoRemCli_ == undefined) {
		_i.cargaValoresDefecto();
		if (_i.pagoDiferidoRemCli_  == undefined) {
			MessageBox.critical(sys.translate("Error al obtener los valores por defecto del módulo de tesorería"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
			return false;
		}
	}
	return _i.pagoDiferidoRemCli_ ;
}

function oficial_dameDatosReciboCli(curPD)
{
	var _i = this.iface;
	
	return flfactppal.iface.pub_ejecutarQry("reciboscli", "codpago,coddivisa,importe,importeeuros,idfactura,codigo,nombrecliente,codcliente", "idrecibo = " + curPD.valueBuffer("idrecibo"));
}

function oficial_dameSubcuentaCliPD(curPD, valoresDefecto, datosAsiento, recibo)
{
	var _i = this.iface;
	var ctaHaber = [];
	var codEjercicioFac:String;
	/** \C La cuenta del haber del asiento de pago será la misma cuenta de tipo CLIENT que se usó para realizar el asiento de la correspondiente factura
	\end */
	var idAsientoFactura = AQUtil.sqlSelect("reciboscli r INNER JOIN facturascli f" +
		" ON r.idfactura = f.idfactura", "f.idasiento",
		"r.idrecibo = " + curPD.valueBuffer("idrecibo"),
		"facturascli,reciboscli");
	if (!idAsientoFactura) {
		codEjercicioFac = false;
	} else {
		codEjercicioFac = AQUtil.sqlSelect("co_asientos", "codejercicio", "idasiento = " + idAsientoFactura);
	}
	var codCliente = AQUtil.sqlSelect("reciboscli", "codcliente", "idrecibo = " + curPD.valueBuffer("idrecibo"));
	if (codEjercicioFac == valoresDefecto.codejercicio) {
		ctaHaber.codsubcuenta = AQUtil.sqlSelect("co_subcuentascli", "codsubcuenta", "codcliente = '" + codCliente + "' AND codejercicio = '" + codEjercicioFac + "'");
		if(!ctaHaber.codsubcuenta)
			ctaHaber.codsubcuenta = AQUtil.sqlSelect("co_partidas p" + " INNER JOIN co_subcuentas s ON p.idsubcuenta = s.idsubcuenta INNER JOIN co_cuentas c ON c.idcuenta = s.idcuenta", 	"s.codsubcuenta", "p.idasiento = " + idAsientoFactura + " AND c.idcuentaesp = 'CLIENT'", 	"co_partidas,co_subcuentas,co_cuentas");
		else
				ctaHaber.codsubcuenta = AQUtil.sqlSelect("co_partidas p INNER JOIN co_subcuentas s ON p.idsubcuenta = s.idsubcuenta",	"s.codsubcuenta", "p.idasiento = " + idAsientoFactura + " AND s.codsubcuenta = '" + ctaHaber.codsubcuenta + "'", 	"co_partidas,co_subcuentas,co_cuentas");
		
		if (!ctaHaber.codsubcuenta) {
			MessageBox.warning(sys.translate("No se ha encontrado la subcuenta de cliente del asiento contable correspondiente a la factura a pagar"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return false;
		}
	} else {
		if (codCliente && codCliente != "") {
			ctaHaber.codsubcuenta = AQUtil.sqlSelect("co_subcuentascli", "codsubcuenta", "codcliente = '" + codCliente + "' AND codejercicio = '" + valoresDefecto.codejercicio + "'");
			if (!ctaHaber.codsubcuenta) {
				MessageBox.warning(sys.translate("El cliente %1 no tiene definida ninguna subcuenta en el ejercicio %2.\nEspecifique la subcuenta en la pestaña de contabilidad del formulario de clientes").arg(codCliente).arg(valoresDefecto.codejercicio), MessageBox.Ok, MessageBox.NoButton);
				return false;
			}
		} else {
			ctaHaber = flfacturac.iface.pub_datosCtaEspecial("CLIENT", valoresDefecto.codejercicio);
			if (!ctaHaber.codsubcuenta) {
				MessageBox.warning(sys.translate("No tiene definida ninguna cuenta de tipo CLIENT.\nDebe crear este tipo especial y asociarlo a una cuenta\nen el módulo principal de contabilidad"), MessageBox.Ok, MessageBox.NoButton);
				return false;
			}
		}
	}
	ctaHaber.idsubcuenta = AQUtil.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + ctaHaber.codsubcuenta + "' AND codejercicio = '" + valoresDefecto.codejercicio + "'");
	if (!ctaHaber.idsubcuenta) {
		MessageBox.warning(sys.translate("No existe la subcuenta %1 correspondiente al ejercicio.\nPara poder realizar el pago debe crear antes esta subcuenta.").arg(ctaHaber.codsubcuenta).arg(valoresDefecto.codejercicio), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
		return false;
	}
	return ctaHaber;
}

/** \D Genera la partida correspondiente al cliente del asiento de pago
@param	curPD: Cursor del pago o devolución
@param	valoresDefecto: Array de valores por defecto (ejercicio, divisa, etc.)
@param	datosAsiento: Array con los datos del asiento
@param	recibo: Array con los datos del recibo asociado al pago
@return	true si la generación es correcta, false en caso contrario
\end */
function oficial_generarPartidasCli(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array)
{
	var _i = this.iface;
	var util= new FLUtil();
	var ctaHaber = _i.dameSubcuentaCliPD(curPD, valoresDefecto, datosAsiento, recibo);
	if (!ctaHaber) {
		return false;
	}
	var haber = 0;
	var haberME = 0;
	var tasaConvHaber = 1;
	
	var importeTotal = _i.importeReciboPagoDevolCli(curPD, recibo);
	if (valoresDefecto.coddivisa == recibo.coddivisa) {
		haber = importeTotal;
		haberMe = 0;
	} else {
		tasaConvHaber = AQUtil.sqlSelect("reciboscli r INNER JOIN facturascli f ON r.idfactura = f.idfactura ", "tasaconv", "idrecibo = " + curPD.valueBuffer("idrecibo"), "reciboscli,facturascli");
		haber = parseFloat(importeTotal) * parseFloat(tasaConvHaber);
		haberME = parseFloat(importeTotal);
	}

// 	if (valoresDefecto.coddivisa == recibo.coddivisa) {
// 		haber = _i.importeReciboPagoDevol(cuPD, recibo);
// 		haberMe = 0;
// 	} else {
// 		tasaconvHaber = util.sqlSelect("reciboscli r INNER JOIN facturascli f ON r.idfactura = f.idfactura ", "tasaconv", "idrecibo = " + curPD.valueBuffer("idrecibo"), "reciboscli,facturascli");
// 		haber = parseFloat(recibo.importeeuros);
// 		haberME = parseFloat(recibo.importe);
// 	}
	haber = util.roundFieldValue(haber, "co_partidas", "haber");
	haberME = util.roundFieldValue(haberME, "co_partidas", "haberme");
	
	var esAbono= util.sqlSelect("reciboscli r INNER JOIN facturascli f ON r.idfactura = f.idfactura", "deabono", "idrecibo = " + curPD.valueBuffer("idrecibo"), "reciboscli,facturascli");
	var esPago= this.iface.esPagoEstePagoDevol(curPD);
	
	var curPartida= new FLSqlCursor("co_partidas");
	with(curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		try {
			setValueBuffer("concepto", datosAsiento.concepto);
		} catch (e) {
			setValueBuffer("concepto", curPD.valueBuffer("tipo") + " recibo " + recibo.codigo + " - " + recibo.nombrecliente);
		}
		setValueBuffer("idsubcuenta", ctaHaber.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaHaber.codsubcuenta);
		setValueBuffer("idasiento", datosAsiento.idasiento);
		if (esPago) {
			if (esAbono) {
				setValueBuffer("debe", haber * -1);
				setValueBuffer("haber", 0);
			} else {
				setValueBuffer("debe", 0);
				setValueBuffer("haber", haber);
			}
		} else {
			if (esAbono) {
				setValueBuffer("haber", haber * -1);
				setValueBuffer("debe", 0);
			} else {
				setValueBuffer("haber", 0);
				setValueBuffer("debe", haber);
			}
		}
		setValueBuffer("coddivisa", recibo.coddivisa);
		setValueBuffer("tasaconv", tasaConvHaber);
		setValueBuffer("debeME", 0);
		setValueBuffer("haberME", haberME);
	}
	if (!_i.datosPartidaPagoDevolCli(curPartida, curPD, valoresDefecto, datosAsiento, recibo)) {
		return false;
	}
	if (!curPartida.commitBuffer())
		return false;

	return true;
}

function oficial_importeReciboPagoDevolCli(curPD, recibo)
{
	return recibo.importe;
}


function oficial_datosPartidaPagoDevolCli(curPartida, curPD, valoresDefecto, datosAsiento, recibo)
{
	return true;
}

/** \D Genera la partida correspondiente al banco o a caja del asiento de pago
@param	curPD: Cursor del pago o devolución
@param	valoresDefecto: Array de valores por defecto (ejercicio, divisa, etc.)
@param	datosAsiento: Array con los datos del asiento
@param	recibo: Array con los datos del recibo asociado al pago
@return	true si la generación es correcta, false en caso contrario
\end */
function oficial_generarPartidasBanco(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array)
{
	var _i = this.iface;
	
	var ctaDebe= [];
	ctaDebe.codsubcuenta = curPD.valueBuffer("codsubcuenta");
	ctaDebe.idsubcuenta = AQUtil.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + ctaDebe.codsubcuenta + "' AND codejercicio = '" + valoresDefecto.codejercicio + "'");
	if (!ctaDebe.idsubcuenta) {
		MessageBox.warning(sys.translate("No tiene definida la subcuenta %1 en el ejercicio %2.\nAntes de dar el pago debe crear la subcuenta o modificar el ejercicio").arg(ctaDebe.codsubcuenta).arg(valoresDefecto.codejercicio), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	var debe = 0;
	var debeME = 0;
	var tasaConvDebe = 1;
	
	var importeTotal = _i.importeReciboPagoBanco(curPD, recibo);
	if (valoresDefecto.coddivisa == recibo.coddivisa) {
		debe = importeTotal;
		debeMe = 0;
	} else {
		tasaConvDebe = AQUtil.sqlSelect("reciboscli r INNER JOIN facturascli f ON r.idfactura = f.idfactura ", "tasaconv", "idrecibo = " + curPD.valueBuffer("idrecibo"), "reciboscli,facturascli");
		debe = parseFloat(importeTotal) * parseFloat(tasaConvDebe);
		debeME = parseFloat(importeTotal);
	}
	
// 	if (valoresDefecto.coddivisa == recibo.coddivisa) {
// 		debe = recibo.importe;
// 		debeME = 0;
// 	} else {
// 		tasaConvDebe = curPD.valueBuffer("tasaconv");
// 		debe = parseFloat(recibo.importe) * parseFloat(tasaConvDebe);
// 		debeME = parseFloat(recibo.importe);
// 	}

	debe = AQUtil.roundFieldValue(debe, "co_partidas", "debe");
	debeME = AQUtil.roundFieldValue(debeME, "co_partidas", "debeme");

	var esAbono= AQUtil.sqlSelect("reciboscli r INNER JOIN facturascli f ON r.idfactura = f.idfactura", "deabono", "idrecibo = " + curPD.valueBuffer("idrecibo"), "reciboscli,facturascli");
	var esPago= this.iface.esPagoEstePagoDevol(curPD);
	
	var curPartida= new FLSqlCursor("co_partidas");
	with(curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		try {
			setValueBuffer("concepto", datosAsiento.concepto);
		} catch (e) {
			setValueBuffer("concepto", curPD.valueBuffer("tipo") + " recibo " + recibo.codigo + " - " + recibo.nombrecliente);
		}
		setValueBuffer("idsubcuenta", ctaDebe.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaDebe.codsubcuenta);
		setValueBuffer("idasiento", datosAsiento.idasiento);
		if (esPago) {
			if (esAbono) {
				setValueBuffer("debe", 0);
				setValueBuffer("haber", debe * -1);
			} else {
				setValueBuffer("debe", debe);
				setValueBuffer("haber", 0);
			}
		} else {
			if (esAbono) {
				setValueBuffer("haber", 0);
				setValueBuffer("debe", debe * -1);
			} else {
				setValueBuffer("haber", debe);
				setValueBuffer("debe", 0);
			}
		}
		
		setValueBuffer("coddivisa", recibo.coddivisa);
		setValueBuffer("tasaconv", tasaConvDebe);
		setValueBuffer("debeME", debeME);
		setValueBuffer("haberME", 0);
	}
	if (!curPartida.commitBuffer())
		return false;

	return true;
}

function oficial_importeReciboPagoBanco(curPD, recibo)
{
	return recibo.importe;
}

/** \D Genera, si es necesario, la partida de diferecias positivas o negativas de cambio
@param	curPD: Cursor del pago o devolución
@param	valoresDefecto: Array de valores por defecto (ejercicio, divisa, etc.)
@param	datosAsiento: Array con los datos del asiento
@param	recibo: Array con los datos del recibo asociado al pago
@return	true si la generación es correcta, false en caso contrario
\end */
function oficial_generarPartidasCambio(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array)
{
	/** \C En el caso de que la divisa sea extranjera y la tasa de cambio haya variado desde el momento de la emisión de la factura, la diferencia se imputará a la correspondiente cuenta de diferencias de cambio.
	\end */

	if (valoresDefecto.coddivisa == recibo.coddivisa)
		return true;

	var util= new FLUtil();
	var debe= 0;
	var haber= 0;
	var tasaconvDebe= 1;
	var tasaconvHaber= 1;
	var diferenciaCambio= 0;
		
	tasaconvDebe = curPD.valueBuffer("tasaconv");
	tasaconvHaber = util.sqlSelect("reciboscli r INNER JOIN facturascli f ON r.idfactura = f.idfactura ", "tasaconv", "idrecibo = " + curPD.valueBuffer("idrecibo"), "reciboscli,facturascli");
	debe = parseFloat(recibo.importe) * parseFloat(tasaconvDebe);
	debe = util.roundFieldValue(debe, "co_partidas", "debe");

	haber = parseFloat(recibo.importeeuros);
	haber = util.roundFieldValue(haber, "co_partidas", "debe");

	diferenciaCambio = debe - haber;
	if (util.buildNumber(diferenciaCambio, "f", 2) == "0.00" || util.buildNumber(diferenciaCambio, "f", 2) == "-0.00") {
		diferenciaCambio = 0;
		return true;
	}
	
	diferenciaCambio = util.roundFieldValue(diferenciaCambio, "co_partidas", "debe");

	var ctaDifCambio= [];
	var debeDifCambio= 0;
	var haberDifCambio= 0;
	if (diferenciaCambio > 0) {
		ctaDifCambio = flfacturac.iface.pub_datosCtaEspecial("CAMPOS", valoresDefecto.codejercicio);
		if (ctaDifCambio.error != 0)
			return false;
		debeDifCambio = 0;
		haberDifCambio = diferenciaCambio;
	} else {
		ctaDifCambio = flfacturac.iface.pub_datosCtaEspecial("CAMNEG", valoresDefecto.codejercicio);
		if (ctaDifCambio.error != 0)
			return false;
		diferenciaCambio = 0 - diferenciaCambio;
		debeDifCambio = diferenciaCambio;
		haberDifCambio = 0;
	}
	/// Esto lo usan algunas extensiones
// 	if (curPD.valueBuffer("tipo") == "Devolución") {
// 		var aux= debeDifCambio;
// 		debeDifCambio = haberDifCambio;
// 		haberDifCambio = aux;
// 	}
	var esPago= this.iface.esPagoEstePagoDevol(curPD);
	
	var curPartida= new FLSqlCursor("co_partidas");
	with(curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		try {
			setValueBuffer("concepto", datosAsiento.concepto);
		} catch (e) {
			setValueBuffer("concepto", curPD.valueBuffer("tipo") + " recibo " + recibo.codigo + " - " + recibo.nombrecliente);
		}
		setValueBuffer("idsubcuenta", ctaDifCambio.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaDifCambio.codsubcuenta);
		setValueBuffer("idasiento", datosAsiento.idasiento);
		if (esPago) {
			setValueBuffer("debe", debeDifCambio);
			setValueBuffer("haber", haberDifCambio);
		} else {
			setValueBuffer("debe", haberDifCambio);
			setValueBuffer("haber", debeDifCambio);
		}
		setValueBuffer("coddivisa", valoresDefecto.coddivisa);
		setValueBuffer("tasaconv", 1);
		setValueBuffer("debeME", 0);
		setValueBuffer("haberME", 0);
	}
	if (!curPartida.commitBuffer())
		return false;

	return true;
}

function oficial_esPagoEstePagoDevol(curPD:FLSqlCursor)
{
	return (curPD.valueBuffer("tipo") == "Pago");
}

function oficial_comprobarCuentasDom(idRemesa:String)
{
	var util= new FLUtil();
	
	var qryRecibos= new FLSqlQuery;
	qryRecibos.setTablesList("pagosdevolcli,reciboscli,cuentasbcocli");
	qryRecibos.setSelect("r.codigo, r.codcliente, r.nombrecliente");
	qryRecibos.setFrom("pagosdevolcli pd INNER JOIN reciboscli r ON pd.idrecibo = r.idrecibo LEFT OUTER JOIN cuentasbcocli cc ON (r.codcliente = cc.codcliente AND r.codcuenta = cc.codcuenta)");
	qryRecibos.setWhere("pd.idremesa = " + idRemesa + " AND cc.codcuenta IS NULL ORDER BY codcliente, codigo");
	qryRecibos.setForwardOnly( true );
	if (!qryRecibos.exec())
		return false;
debug(qryRecibos.sql());
	var msgError= "";
	var i= 0;
	while (qryRecibos.next()) {
		msgError += "\n" + sys.translate("Cliente: %1 (%2), Recibo %3").arg(qryRecibos.value("r.nombrecliente")).arg(qryRecibos.value("r.codcliente")).arg(qryRecibos.value("r.codigo"));
	}
	if (msgError != "") {
		var res= MessageBox.warning(sys.translate("Los siguientes recibos no tienen especificada una cuenta de domiciliación válida:") + msgError + "\n" + sys.translate("¿Desea continuar?"), MessageBox.Yes, MessageBox.No);
		if (res != MessageBox.Yes)
			return false;
	}
	return true;
}

/** \D Indica si el módulo de autómata está instalado y activado
@return	true si está activado, false en caso contrario
\end */
function oficial_automataActivado()
{
	if (!sys.isLoadedModule("flautomata"))
		return false;
	
	if (formau_automata.iface.pub_activado())
		return true;
	
	return false;
}

/** \Genera o regenera el asiento contable asociado a un pago de una remesa
@param	curPR: Cursor posicionado en el pago cuyo asiento se va a regenerar
@return	true si la regeneración se realiza correctamente, false en caso contrario
\end */
function oficial_generarAsientoPagoRemesa(curPR:FLSqlCursor)
{ 
  var _i = this.iface;
  var util= new FLUtil();
  if (curPR.modeAccess() != curPR.Insert && curPR.modeAccess() != curPR.Edit)
    return true;
  
  if (curPR.valueBuffer("nogenerarasiento")) {
    curPR.setNull("idasiento");
    return true;
  }
  var codEjercicio= flfactppal.iface.pub_ejercicioActual();
  var datosDoc= flfacturac.iface.pub_datosDocFacturacion(curPR.valueBuffer("fecha"), codEjercicio, "pagosdevolrem");
  if (!datosDoc.ok)
    return false;
  if (datosDoc.modificaciones == true) {
    codEjercicio = datosDoc.codEjercicio;
    curPR.setValueBuffer("fecha", datosDoc.fecha);
  }
  
  var datosAsiento= [];
  var valoresDefecto:Array;
  valoresDefecto["codejercicio"] = codEjercicio;
  valoresDefecto["coddivisa"] = _i.dameDivisaEmpresa(codEjercicio);
  
  var pagoIndirecto_ = flfactteso.iface.pub_valorDefectoTesoreria("pagoindirecto");
  var pagoDiferido_ = flfactteso.iface.pub_valorDefectoTesoreria("pagodiferido");
  
  var curTransaccion= new FLSqlCursor("empresa");
  curTransaccion.transaction(false);
  try {
    if (pagoIndirecto_) {
      datosAsiento = flfacturac.iface.pub_regenerarAsiento(curPR, valoresDefecto);
      if (datosAsiento.error == true) {
        throw sys.translate("Error al regenerar el asiento");
      }	
      var remesa= flfactppal.iface.pub_ejecutarQry("remesas", "coddivisa,total,fecha,idremesa,codsubcuenta,codcuenta", "idremesa = " + curPR.valueBuffer("idremesa"));
      if (remesa.result != 1) {
        throw sys.translate("Error al obtener los datos de la remesa");
      }
      if (curPR.valueBuffer("tipo") == "Pago") {
        if (!this.iface.generarPartidasEFCOGC(curPR, valoresDefecto, datosAsiento, remesa)) {
          throw sys.translate("Error al obtener la partida de efectos comerciales de gestión de cobro");
        }
        if (!this.iface.generarPartidasBancoRem(curPR, valoresDefecto, datosAsiento, remesa)) {
          throw sys.translate("Error al generar la partida de banco");
        }
      }
      curPR.setValueBuffer("idasiento", datosAsiento.idasiento);
      if (!flcontppal.iface.pub_comprobarAsiento(datosAsiento.idasiento)) {
        throw sys.translate("Error al comprobar el asiento");
      }
    } else { /// Pago diferido. Los registros de pago pasan a tipo Pago,lo cual fuerza la creación de su asiento correspondiente
			datosAsiento = flfacturac.iface.pub_regenerarAsiento(curPR, valoresDefecto);
      if (datosAsiento.error == true) {
        throw sys.translate("Error al regenerar el asiento");
      }	
      var remesa= flfactppal.iface.pub_ejecutarQry("remesas", "coddivisa,total,fecha,idremesa,codsubcuenta,codcuenta", "idremesa = " + curPR.valueBuffer("idremesa"));
      if (remesa.result != 1) {
        throw sys.translate("Error al obtener los datos de la remesa");
      }
      if (curPR.valueBuffer("tipo") == "Pago") {
        if (!this.iface.generarPartidasClienteRem(curPR, valoresDefecto, datosAsiento, remesa)) {
          throw sys.translate("Error al obtener la partida de efectos comerciales de gestión de cobro");
        }
        if (!this.iface.generarPartidasBancoRem(curPR, valoresDefecto, datosAsiento, remesa)) {
          throw sys.translate("Error al generar la partida de banco");
        }
      }
      curPR.setValueBuffer("idasiento", datosAsiento.idasiento);
      if (!flcontppal.iface.pub_comprobarAsiento(datosAsiento.idasiento)) {
        throw sys.translate("Error al comprobar el asiento");
      }
      if (!_i.modificaEstadoPagosRemesa(curPR, "Pago")) {
        throw sys.translate("Error al modificar el estado de pagos de la remesa");
      }
    }
  } catch (e) {
    curTransaccion.rollback();
    MessageBox.warning(sys.translate("Error al generar el asiento de la remesa:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
    return false;
  }
  curTransaccion.commit();
  
  return true;
}

function oficial_modificaEstadoPagosRemesa(curPR, estado)
{
	debug("oficial_modificaEstadoPagosRemesa XXXXXXXXXXXXXXXXXXXXXXXX" + estado);
	var _i = this.iface;
	var idRecibo;
	var curR = new FLSqlCursor("pagosdevolcli");
	curR.select("idremesa = " + curPR.valueBuffer("idremesa"));
	if (!_i.curReciboCli) {
		_i.curReciboCli = new FLSqlCursor("reciboscli");
	}
	while (curR.next()) {
		curR.setModeAccess(curR.Edit);
		curR.refreshBuffer();
		if (!curR.valueBuffer("editable")) {
			continue;
		}
		idRecibo = curR.valueBuffer("idrecibo");
		curR.setValueBuffer("tipo", estado);
		curR.setValueBuffer("fecha", curPR.valueBuffer("fecha"));
		if (!curR.commitBuffer()) {
			return false;
		}
		_i.curReciboCli.select("idrecibo = " + idRecibo);
		if (!_i.curReciboCli.first()) {
			return false;
		}
		_i.curReciboCli.setModeAccess(_i.curReciboCli.Edit);
		_i.curReciboCli.refreshBuffer();
		_i.curReciboCli.setValueBuffer("estado", formRecordreciboscli.iface.pub_obtenerEstado(idRecibo));
		if (!_i.totalesReciboCli()) {
			return false;
		}
		if (!_i.curReciboCli.commitBuffer()) {
			return false;
		}
	}
	return true;
}

/** \D Genera la parte del asiento del pago correspondiente a la subcuenta especial EFCOGC
@param	curPR: Cursor del pago de la remesa
@param	idAsiento: Id del asiento asociado
@param	valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@return	VERDADERO si no hay error, FALSO en otro caso
\end */
function oficial_generarPartidasEFCOGC(curPR:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, remesa:Array)
{
	var util= new FLUtil();

	var haber= 0;
	var haberME= 0;
	var ctaHaber= [];
	ctaHaber.codsubcuenta = util.sqlSelect("cuentasbanco","codsubcuentaecgc","codcuenta = '" + remesa.codcuenta + "'");

	if (!ctaHaber.codsubcuenta || ctaHaber.codsubcuenta == "") {
		MessageBox.warning(sys.translate("No tiene definida de efectos comerciales de gestión de cobro para la cuenta %1").arg(remesa.codcuenta), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	ctaHaber.idsubcuenta = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + ctaHaber.codsubcuenta + "' AND codejercicio = '" + valoresDefecto.codejercicio + "'");
	if (!ctaHaber.idsubcuenta) {
		MessageBox.warning(sys.translate("No tiene definida la subcuenta %1 en el ejercicio %2.\nAntes de dar el pago debe crear la subcuenta o modificar el ejercicio").arg(ctaDebe.codsubcuenta).arg(valoresDefecto.codejercicio), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	haber = remesa.total;
	haberME = 0;
	haber = util.roundFieldValue(haber, "co_partidas", "haber");
	haberME = util.roundFieldValue(haberME, "co_partidas", "haberme");

	var curPartida= new FLSqlCursor("co_partidas");
	with (curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		setValueBuffer("concepto", curPR.valueBuffer("tipo") + " " + sys.translate("remesa") + " " + remesa.idremesa);
		setValueBuffer("idsubcuenta", ctaHaber.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaHaber.codsubcuenta);
		setValueBuffer("idasiento", datosAsiento.idasiento);
		setValueBuffer("debe", 0);
		setValueBuffer("haber", haber);
		setValueBuffer("debeME", 0);
		setValueBuffer("haberME", haberME);
	}
		
	if (!curPartida.commitBuffer())
		return false;

	return true;
}

/** \D Genera la parte del asiento del pago correspondiente a la subcuentas de clientes de una remesa
@param	curPR: Cursor del pago de la remesa
@param	idAsiento: Id del asiento asociado
@param	valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@return	VERDADERO si no hay error, FALSO en otro caso
\end */
function oficial_generarPartidasClienteRem(curPR:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, remesa:Array)
{
	var _i = this.iface;

	var haber = 0;
	var haberME = 0;
	var ctaHaber = [];
	
	var curPartida= new FLSqlCursor("co_partidas");
	var curPD = new FLSqlCursor("pagosdevolcli");
	curPD.select("idremesa = " + remesa.idremesa);
	var codRecibo;
	while (curPD.next()) {
		curPD.setModeAccess(curPD.Browse);
		curPD.refreshBuffer();
		codRecibo = AQUtil.sqlSelect("reciboscli", "codigo", "idrecibo = " + curPD.valueBuffer("idrecibo"));
		ctaHaber = _i.dameSubcuentaCliPD(curPD, valoresDefecto, datosAsiento, remesa);
		if (!ctaHaber) {
			return false;
		}
		haber = AQUtil.sqlSelect("reciboscli", "importe", "idrecibo = " + curPD.valueBuffer("idrecibo"));
		haber = isNaN(haber) ? 0 : haber;
		haberME = 0;
		haber = AQUtil.roundFieldValue(haber, "co_partidas", "haber");
		haberME = AQUtil.roundFieldValue(haberME, "co_partidas", "haberme");

		with (curPartida) {
			setModeAccess(curPartida.Insert);
			refreshBuffer();
			setValueBuffer("concepto", sys.translate("Recibo remesado %1").arg(codRecibo));
			setValueBuffer("idsubcuenta", ctaHaber.idsubcuenta);
			setValueBuffer("codsubcuenta", ctaHaber.codsubcuenta);
			setValueBuffer("idasiento", datosAsiento.idasiento);
			setValueBuffer("debe", 0);
			setValueBuffer("haber", haber);
			setValueBuffer("debeME", 0);
			setValueBuffer("haberME", haberME);
		}
		if (!_i.datosPartidaClienteRem(curPartida, curPD, valoresDefecto, datosAsiento, remesa)) {
			return false;
		}
		
		if (!curPartida.commitBuffer()) {
			return false;
		}
	}

	return true;
}

function oficial_datosPartidaClienteRem(curPartida, curPD, valoresDefecto, datosAsiento, remesa)
{
	return true;
}

/** \D Genera la partida correspondiente al banco o a caja del asiento de pago de la remesa
@param	curPR: Cursor del pago de la remesa
@param	valoresDefecto: Array de valores por defecto (ejercicio, divisa, etc.)
@param	datosAsiento: Array con los datos del asiento
@param	recibo: Array con los datos del recibo asociado al pago de la remesa
@return	true si la generación es correcta, false en caso contrario
\end */
function oficial_generarPartidasBancoRem(curPR:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, remesa:Array)
{
	var util= new FLUtil();
	var ctaDebe= [];
	ctaDebe.codsubcuenta = util.sqlSelect("cuentasbanco", "codsubcuenta", "codcuenta = '" + remesa.codcuenta + "'");
	ctaDebe.idsubcuenta = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + ctaDebe.codsubcuenta + "' AND codejercicio = '" + valoresDefecto.codejercicio + "'");
	if (!ctaDebe.idsubcuenta) {
		MessageBox.warning(sys.translate("No tiene definida la subcuenta %1 en el ejercicio %2.\nAntes de dar el pago debe crear la subcuenta o modificar el ejercicio").arg(ctaDebe.codsubcuenta).arg(valoresDefecto.codejercicio), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	var debe= 0;
	var debeME= 0;
	var tasaconvDebe= 1;
	if (valoresDefecto.coddivisa == remesa.coddivisa) {
		debe = parseFloat(remesa.total);
		debeME = 0;
	} else {
		tasaconvDebe = curPR.valueBuffer("tasaconv");
		debe = parseFloat(remesa.total) * parseFloat(tasaconvDebe);
		debeME = parseFloat(remesa.total);
	}
	debe = util.roundFieldValue(debe, "co_partidas", "debe");
	debeME = util.roundFieldValue(debeME, "co_partidas", "debeme");

	var curPartida= new FLSqlCursor("co_partidas");
	with(curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		setValueBuffer("concepto", curPR.valueBuffer("tipo") + " " + sys.translate("remesa") + " " + remesa.idremesa);
		setValueBuffer("idsubcuenta", ctaDebe.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaDebe.codsubcuenta);
		setValueBuffer("idasiento", datosAsiento.idasiento);
		setValueBuffer("debe", debe);
		setValueBuffer("haber", 0);
		setValueBuffer("coddivisa", remesa.coddivisa);
		setValueBuffer("tasaconv", tasaconvDebe);
		setValueBuffer("debeME", debeME);
		setValueBuffer("haberME", 0);
	}
	if (!curPartida.commitBuffer())
		return false;

	return true;
}

function oficial_valorDefectoTesoreria(valor)
{
  return AQUtil.sqlSelect("factteso_general", valor, "1 = 1");
}

function oficial_cargaValoresDefecto()
{
	debug("oficial_cargaValoresDefecto");
	var _i = this.iface;
	_i.pagoIndirectoRemCli_ = _i.valorDefectoTesoreria("pagoindirecto");
	_i.pagoDiferidoRemCli_ = _i.valorDefectoTesoreria("pagodiferido");
}

function oficial_creaGrupoRecibosMultiCli(oParam)
{
	var _i = this.iface;
	
	var aRecibos = oParam.aRecibos;
	var idGrupo;
	var curR = new FLSqlCursor("reciboscli");
	for (var i = 0; i < aRecibos.length; i++) {
		curR.select("idrecibo = " + aRecibos[i]);
		if (!curR.first()) {
			return false;
		}
		if (i == 0) {
			oParam.idRecibo = aRecibos[i];
			if (!_i.creaGrupoRecibosCli(oParam)) {
				return false;
			}
			idGrupo = oParam.idGrupo;
		} else {
			if (!_i.ponGrupoReciboCli(curR, idGrupo, true)) {
				return false;
			}
		}
	}
	return true;	
}

/// Crea un grupo de recibos a partir de un recibo inicial
function oficial_creaGrupoRecibosCli(oParam)
{
	var _i = this.iface;
	
	var idRecibo = oParam.idRecibo;
	
	var curR = new FLSqlCursor("reciboscli");
	curR.select("idrecibo = " + idRecibo);
	if (!curR.first()) {
		MessageBox.warning(sys.translate("Error al localizar el recibo"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
		return false;
	}
	curR.setModeAccess(curR.Edit);
	curR.refreshBuffer();
	var codRecibo = curR.valueBuffer("codigo");
	if (!_i.reciboAgrupable(curR)) {
		MessageBox.warning(sys.translate("El recibo %1 no puede agruparse").arg(codRecibo), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
		return false;
	}
	
	if (!_i.curReciboCli) {
		_i.curReciboCli = new FLSqlCursor("reciboscli");
	}
	_i.curReciboCli.setModeAccess(_i.curReciboCli.Insert);
	_i.curReciboCli.refreshBuffer();

	var camposRecibo = AQUtil.nombreCampos("reciboscli");
	var totalCampos = camposRecibo[0];

	var campoInformado= [];
	for (var i = 1; i <= totalCampos; i++) {
		campoInformado[camposRecibo[i]] = false;
	}
	for (var i = 1; i <= totalCampos; i++) {
		if (!_i.copiarCampoGrupoRecibos(camposRecibo[i], curR, campoInformado)) {
			return false;
		}
	}
	var idGrupo = _i.curReciboCli.valueBuffer("idrecibo");
	var codGrupo = _i.curReciboCli.valueBuffer("codigo");
	if (!_i.curReciboCli.commitBuffer()) {
		return false;
	}
	curR.setValueBuffer("estado", "Agrupado");
	curR.setValueBuffer("idgrupo", idGrupo);
	if (!curR.commitBuffer()) {
		return false;
	}
	oParam.idGrupo = idGrupo;
	oParam.codGrupo = codGrupo;

	return true;
}

function oficial_reciboAgrupable(curRecibo)
{
	return (curRecibo.valueBuffer("estado") == "Emitido" || curRecibo.valueBuffer("estado") == "Devuelto");
}

function oficial_copiarCampoGrupoRecibos(nombreCampo, cursor, campoInformado)
{
// debug("oficial_copiarCampoGrupoRecibos " + nombreCampo);
	var _i = this.iface;
	
	if (campoInformado[nombreCampo]) {
		return true;
	}
	var nulo = false;

	switch (nombreCampo) {
		case "idrecibo":
		case "idfactura": {
			return true;
			break;
		}
		case "numero": {
			valor = _i.obtenerSecuencia("GRC");
			break;
		}
		case "codigo": {
			if (!campoInformado["numero"]) {
				if (!_i.copiarCampoGrupoRecibos("numero", cursor, campoInformado)) {
					return false;
				}
			}
			valor = "GRC" + flfactppal.iface.pub_cerosIzquierda(_i.curReciboCli.valueBuffer("numero"), 9);
			break;
		}
		case "estado": {
			valor = "Emitido";
			break;
		}
		case "texto": {
			if (!campoInformado["coddivisa"]) {
				if (!_i.copiarCampoGrupoRecibos("coddivisa", cursor, campoInformado)) {
					return false;
				}
			}
			if (!campoInformado["importe"]) {
				if (!_i.copiarCampoGrupoRecibos("importe", cursor, campoInformado)) {
					return false;
				}
			}
			var moneda = AQUtil.sqlSelect("divisas", "descripcion", "coddivisa = '" + cursor.valueBuffer("coddivisa") + "'");
			valor = AQUtil.enLetraMoneda(_i.curReciboCli.valueBuffer("importe"), moneda);
			break;
		}
		default: {
			if (cursor.isNull(nombreCampo)) {
				nulo = true;
			} else {
				valor = cursor.valueBuffer(nombreCampo);
			}
		}
	}
	if (nulo) {
		_i.curReciboCli.setNull(nombreCampo);
	} else {
		_i.curReciboCli.setValueBuffer(nombreCampo, valor);
	}
	campoInformado[nombreCampo] = true;
	
	return true;
}

function oficial_obtenerSecuencia(prefijo)
{
	var _i = this.iface;
	var valor = AQUtil.sqlSelect("secuenciastesoreria", "valor", "prefijo = '" + prefijo + "'");
	if (!valor) {
		valor = 1;
		var curSecuencia = new FLSqlCursor("secuenciastesoreria");
		curSecuencia.setModeAccess(curSecuencia.Insert);
		curSecuencia.refreshBuffer();
		curSecuencia.setValueBuffer("prefijo", prefijo);
		curSecuencia.setValueBuffer("valor", valor);
		if (!curSecuencia.commitBuffer()) {
			return false;
		}
	} else {
		valor += 1;
		AQSql.update("secuenciastesoreria", ["valor"], [valor], "prefijo = '" + prefijo + "'");
	}
	return valor;
}

function oficial_quitaGrupoRecibosCli(oParam)
{
debug("oficial_quitaGrupoRecibosCli");
	var _i = this.iface;
	var idGrupo = oParam.idGrupo;
	var estado = AQUtil.sqlSelect("reciboscli", "estado", "idrecibo = " + idGrupo);
	if (estado != "Emitido") {
		MessageBox.warning(sys.translate("Sólo puede eliminar grupos de recibos en estado Emitido"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
		return false;
	}
	var curR = new FLSqlCursor("reciboscli");
	curR.select("idgrupo = " + idGrupo);
	while (curR.next()) {
		if (!_i.quitaGrupoReciboCli(curR, true)) {
			return false;
		}
	}

	if (!_i.curReciboCli) {
		_i.curReciboCli = new FLSqlCursor("reciboscli");
	}
	_i.curReciboCli.select("idrecibo = " + idGrupo);
	if (!_i.curReciboCli.first()) {
		return false;
	}
	_i.curReciboCli.setModeAccess(_i.curReciboCli.Del);
	_i.curReciboCli.refreshBuffer();
	if (_i.curReciboCli.valueBuffer("importeeuros") != 0) {
		return false;
	}
	if (!_i.curReciboCli.isNull("idfactura")) {
		return false;
	}
	if (!_i.curReciboCli.commitBuffer()) {
		return false;
	}
	return true;
}

function oficial_quitaGrupoReciboCli(curRecibo, totalizar)
{
	var _i = this.iface;
	curRecibo.setModeAccess(curRecibo.Edit);
	curRecibo.refreshBuffer();
	
	if (curRecibo.isNull("idgrupo")) {
		return false;
	}
	var idGrupo = curRecibo.valueBuffer("idgrupo");
	curRecibo.setNull("idgrupo");
	curRecibo.setValueBuffer("estado", formRecordreciboscli.iface.pub_commonCalculateField("estado", curRecibo));
	if (!curRecibo.commitBuffer()) {
		return false;
	}
	if (totalizar) {
		if (!_i.totalizaGrupoRecibos(idGrupo)) {
			return false;
		}
	}
	return true;
}

function oficial_controlEstadoFraCli(curR)
{
	var _i = this.iface;
	var idFactura = curR.valueBuffer("idfactura");
	if (!idFactura) { /// Recibo agrupado
		return true;
	}
	
	switch (curR.modeAccess()) {
		case curR.Edit: {
			if (curR.valueBuffer("estado") != curR.valueBufferCopy("estado")) {
				if (!_i.calcularEstadoFacturaCli(false, idFactura)) {
					return false;
				}
			}
			break;
		}
		case curR.Insert: {
			_i.calcularEstadoFacturaCli(false, idFactura);
			break;
		}
	}
	return true;
}

function oficial_ponGrupoReciboCli(curRecibo, idGrupo, totalizar)
{
	var _i = this.iface;
	curRecibo.setModeAccess(curRecibo.Edit);
	curRecibo.refreshBuffer();
	
	var codRecibo = curRecibo.valueBuffer("codigo");
	if (!_i.reciboAgrupable(curRecibo)) {
		MessageBox.warning(sys.translate("El recibo %1 no puede agruparse").arg(codRecibo), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
		return false;
	}
	var dGrupo = flfactppal.iface.pub_ejecutarQry("reciboscli", "codcliente,coddivisa", "idrecibo = " + idGrupo);
	if (dGrupo.result != 1) {
		return false;
	}
	if (curRecibo.valueBuffer("codcliente") != dGrupo.codcliente  || curRecibo.valueBuffer("coddivisa") != dGrupo.coddivisa) {
		MessageBox.warning(sys.translate("Error al agregar el recibo %1 al grupo. El cliente o la divisa no coinciden").arg(codRecibo), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
		return false;
	}
	if (!curRecibo.isNull("idgrupo")) {
		return false;
	}
	curRecibo.setValueBuffer("idgrupo", idGrupo);
	curRecibo.setValueBuffer("estado", "Agrupado");
	if (!curRecibo.commitBuffer()) {
		return false;
	}
	if (totalizar) {
		if (!_i.totalizaGrupoRecibos(idGrupo)) {
			return false;
		}
	}
	return true;
}

function oficial_totalizaGrupoRecibos(idGrupo)
{
	var _i = this.iface;
	debug("oficial_totalizaGrupoRecibos");
	var curG = new FLSqlCursor("reciboscli");
	curG.select("idrecibo = " + idGrupo);
	if (!curG.first()) {
		return false;
	}
	curG.setModeAccess(curG.Edit);
	curG.refreshBuffer();
	curG.setValueBuffer("importe", formRecordreciboscli.iface.pub_commonCalculateField("importegrupo", curG));
	curG.setValueBuffer("importeeuros", formRecordreciboscli.iface.pub_commonCalculateField("importeeurosgrupo", curG));
	curG.setValueBuffer("estado", formRecordreciboscli.iface.pub_commonCalculateField("estado", curG));
	if (!curG.commitBuffer()) {
		return false;
	}
	return true;
}

function oficial_dameDivisaEmpresa(codEjercicio)
{
	return flfactppal.iface.pub_valorDefectoEmpresa("coddivisa");
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
