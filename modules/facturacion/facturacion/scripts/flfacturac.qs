/***************************************************************************
                 flfacturac.qs  -  description
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
	var ctx;
	function interna( context ) { this.ctx = context; }
	function beforeCommit_presupuestoscli(curPresupuesto) {
		return this.ctx.interna_beforeCommit_presupuestoscli(curPresupuesto);
	}
	function beforeCommit_pedidoscli(curPedido) {
		return this.ctx.interna_beforeCommit_pedidoscli(curPedido);
	}
	function beforeCommit_pedidosprov(curPedido) {
		return this.ctx.interna_beforeCommit_pedidosprov(curPedido);
	}
	function beforeCommit_albaranescli(curAlbaran) {
		return this.ctx.interna_beforeCommit_albaranescli(curAlbaran);
	}
	function beforeCommit_albaranesprov(curAlbaran) {
		return this.ctx.interna_beforeCommit_albaranesprov(curAlbaran);
	}
	function beforeCommit_facturascli(curFactura) {
		return this.ctx.interna_beforeCommit_facturascli(curFactura);
	}
	function beforeCommit_facturasprov(curFactura) {
		return this.ctx.interna_beforeCommit_facturasprov(curFactura);
	}
	function afterCommit_pedidoscli(curPedido) {
		return this.ctx.interna_afterCommit_pedidoscli(curPedido);
	}
	function afterCommit_albaranescli(curAlbaran) {
		return this.ctx.interna_afterCommit_albaranescli(curAlbaran);
	}
	function afterCommit_albaranesprov(curAlbaran) {
		return this.ctx.interna_afterCommit_albaranesprov(curAlbaran);
	}
	function afterCommit_facturascli(curFactura) {
		return this.ctx.interna_afterCommit_facturascli(curFactura);
	}
	function afterCommit_facturasprov(curFactura) {
		return this.ctx.interna_afterCommit_facturasprov(curFactura);
	}
	function afterCommit_lineasalbaranesprov(curLA) {
		return this.ctx.interna_afterCommit_lineasalbaranesprov(curLA);
	}
	function afterCommit_lineasfacturasprov(curLF) {
		return this.ctx.interna_afterCommit_lineasfacturasprov(curLF);
	}
	function afterCommit_lineaspresupuestoscli(curLP) {
		return this.ctx.interna_afterCommit_lineaspresupuestoscli(curLP);
	}
	function afterCommit_lineaspedidoscli(curLA) {
		return this.ctx.interna_afterCommit_lineaspedidoscli(curLA);
	}
	function afterCommit_lineaspedidosprov(curLA) {
		return this.ctx.interna_afterCommit_lineaspedidosprov(curLA);
	}
	function afterCommit_lineasalbaranescli(curLA) {
		return this.ctx.interna_afterCommit_lineasalbaranescli(curLA);
	}
	function afterCommit_lineasfacturascli(curLF) {
		return this.ctx.interna_afterCommit_lineasfacturascli(curLF);
	}
	function beforeCommit_lineaspresupuestoscli(curLinea) {
		return this.ctx.interna_beforeCommit_lineaspresupuestoscli(curLinea);
	}
	function beforeCommit_lineaspedidoscli(curLinea) {
		return this.ctx.interna_beforeCommit_lineaspedidoscli(curLinea);
	}
	function beforeCommit_lineaspedidosprov(curLinea) {
		return this.ctx.interna_beforeCommit_lineaspedidosprov(curLinea);
	}
	function beforeCommit_lineasalbaranescli(curLinea) {
		return this.ctx.interna_beforeCommit_lineasalbaranescli(curLinea);
	}
	function beforeCommit_lineasalbaranesprov(curLinea) {
		return this.ctx.interna_beforeCommit_lineasalbaranesprov(curLinea);
	}
	function beforeCommit_lineasfacturascli(curLinea) {
		return this.ctx.interna_beforeCommit_lineasfacturascli(curLinea);
	}
	function beforeCommit_lineasfacturasprov(curLinea) {
		return this.ctx.interna_beforeCommit_lineasfacturasprov(curLinea);
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var aDatosFR_; // Datos para la selección de líneas de facturas rectificativas
	var aLineasSel_;
	var curAsiento_;
	function oficial( context ) { interna( context ); }
	function obtenerHueco(codSerie, codEjercicio, tipo) {
		return this.ctx.oficial_obtenerHueco(codSerie, codEjercicio, tipo);
	}
	function establecerNumeroSecuencia(fN, value) {
		return this.ctx.oficial_establecerNumeroSecuencia(fN, value);
	}
	function cerosIzquierda(numero, totalCifras) {
		return this.ctx.oficial_cerosIzquierda(numero, totalCifras);
	}
	function construirCodigo(codSerie, codEjercicio, numero) {
		return this.ctx.oficial_construirCodigo(codSerie, codEjercicio, numero);
	}
	function siguienteNumero(codSerie, codEjercicio, fN) {
		return this.ctx.oficial_siguienteNumero(codSerie, codEjercicio, fN);
	}
	function agregarHueco(serie, ejercicio, numero, fN) {
		return this.ctx.oficial_agregarHueco(serie, ejercicio, numero, fN);
	}
	function asientoBorrable(idAsiento) {
		return this.ctx.oficial_asientoBorrable(idAsiento);
	}
	function generarAsientoFacturaCli(curFactura) {
		return this.ctx.oficial_generarAsientoFacturaCli(curFactura);
	}
	function generarPartidasVenta(curFactura, idAsiento, valoresDefecto) {
		return this.ctx.oficial_generarPartidasVenta(curFactura, idAsiento, valoresDefecto);
	}
	function generarPartidasIVACli(curFactura, idAsiento, valoresDefecto, ctaCliente) {
		return this.ctx.oficial_generarPartidasIVACli(curFactura, idAsiento, valoresDefecto, ctaCliente);
	}
	function generarPartidasIRPF(curFactura, idAsiento, valoresDefecto) {
		return this.ctx.oficial_generarPartidasIRPF(curFactura, idAsiento, valoresDefecto);
	}
	function generarPartidasRecFinCli(curFactura, idAsiento, valoresDefecto) {
		return this.ctx.oficial_generarPartidasRecFinCli(curFactura, idAsiento, valoresDefecto);
	}
	function generarPartidasIRPFProv(curFactura, idAsiento, valoresDefecto) {
		return this.ctx.oficial_generarPartidasIRPFProv(curFactura, idAsiento, valoresDefecto);
	}
	function generarPartidasRecFinProv(curFactura, idAsiento, valoresDefecto) {
		return this.ctx.oficial_generarPartidasRecFinProv(curFactura, idAsiento, valoresDefecto);
	}
	function generarPartidasCliente(curFactura, idAsiento, valoresDefecto, ctaCliente) {
		return this.ctx.oficial_generarPartidasCliente(curFactura, idAsiento, valoresDefecto, ctaCliente);
	}
	function regenerarAsiento(cur, valoresDefecto) {
		return this.ctx.oficial_regenerarAsiento(cur, valoresDefecto);
	}
	function datosAsientoRegenerado(cur, valoresDefecto) {
		return this.ctx.oficial_datosAsientoRegenerado(cur, valoresDefecto);
	}
	function generarAsientoFacturaProv(curFactura) {
		return this.ctx.oficial_generarAsientoFacturaProv(curFactura);
	}
	function generarPartidasCompra(curFactura, idAsiento, valoresDefecto, concepto) {
		return this.ctx.oficial_generarPartidasCompra(curFactura, idAsiento, valoresDefecto, concepto);
	}
	function generarPartidasIVAProv(curFactura, idAsiento, valoresDefecto, ctaProveedor, concepto) {
		return this.ctx.oficial_generarPartidasIVAProv(curFactura, idAsiento, valoresDefecto, ctaProveedor, concepto);
	}
	function generarPartidasProveedor(curFactura, idAsiento, valoresDefecto, ctaProveedor, concepto, sinIVA) {
		return this.ctx.oficial_generarPartidasProveedor(curFactura, idAsiento, valoresDefecto, ctaProveedor, concepto, sinIVA);
	}
	function datosCtaEspecial(ctaEsp, codEjercicio) {
		return this.ctx.oficial_datosCtaEspecial(ctaEsp, codEjercicio);
	}
	function datosCtaIVA(tipo, codEjercicio, codImpuesto) {
		return this.ctx.oficial_datosCtaIVA(tipo, codEjercicio, codImpuesto);
	}
	function datosCtaVentas(codEjercicio, codSerie) {
		return this.ctx.oficial_datosCtaVentas(codEjercicio, codSerie);
	}
	function datosCtaCliente(curFactura, valoresDefecto) {
		return this.ctx.oficial_datosCtaCliente(curFactura, valoresDefecto);
	}
	function datosCtaProveedor(curFactura, valoresDefecto) {
		return this.ctx.oficial_datosCtaProveedor(curFactura, valoresDefecto);
	}
	function asientoFacturaAbonoCli(curFactura, valoresDefecto){
		return this.ctx.oficial_asientoFacturaAbonoCli(curFactura, valoresDefecto);
	}
	function asientoFacturaAbonoProv(curFactura, valoresDefecto){
		return this.ctx.oficial_asientoFacturaAbonoProv(curFactura, valoresDefecto);
	}
	function datosDocFacturacion(fecha, codEjercicio, tipoDoc) {
		return this.ctx.oficial_datosDocFacturacion(fecha, codEjercicio, tipoDoc);
	}
	function tieneIvaDocCliente(codSerie, codCliente, codEjercicio) {
		return this.ctx.oficial_tieneIvaDocCliente(codSerie, codCliente, codEjercicio);
	}
	function tieneIvaDocProveedor(codSerie, codProveedor, codEjercicio) {
		return this.ctx.oficial_tieneIvaDocProveedor(codSerie, codProveedor, codEjercicio);
	}
	function automataActivado() {
		return this.ctx.oficial_automataActivado();
	}
	function comprobarRegularizacion(curFactura) {
		return this.ctx.oficial_comprobarRegularizacion(curFactura);
	}
	function recalcularHuecos(serie, ejercicio, fN) {
		return this.ctx.oficial_recalcularHuecos(serie, ejercicio, fN);
	}
	function mostrarTraza(codigo, tipo) {
		return this.ctx.oficial_mostrarTraza(codigo, tipo);
	}
	function datosPartidaFactura(curPartida, curFactura, tipo, concepto) {
		return this.ctx.oficial_datosPartidaFactura(curPartida, curFactura, tipo, concepto);
	}
	function eliminarAsiento(idAsiento) {
		return this.ctx.oficial_eliminarAsiento(idAsiento);
	}
	function siGenerarRecibosCli(curFactura, masCampos) {
		return this.ctx.oficial_siGenerarRecibosCli(curFactura, masCampos);
	}
	function validarIvaRecargoCliente(codCliente,id,tabla,identificador) {
		return this.ctx.oficial_validarIvaRecargoCliente(codCliente,id,tabla,identificador);
	}
	function validarIvaRecargoProveedor(codProveedor,id,tabla,identificador) {
		return this.ctx.oficial_validarIvaRecargoProveedor(codProveedor,id,tabla,identificador);
	}
	function comprobarFacturaAbonoCli(curFactura) {
		return this.ctx.oficial_comprobarFacturaAbonoCli(curFactura);
	}
	function comprobarFacturaAbonoProv(curFactura) {
		return this.ctx.oficial_comprobarFacturaAbonoProv(curFactura);
	}
	function consultarCtaEspecial(ctaEsp, codEjercicio) {
		return this.ctx.oficial_consultarCtaEspecial(ctaEsp, codEjercicio);
	}
	function crearCtaEspecial(codCtaEspecial, tipo, codEjercicio, desCta) {
		return this.ctx.oficial_crearCtaEspecial(codCtaEspecial, tipo, codEjercicio, desCta);
	}
	function comprobarCambioSerie(cursor) {
		return this.ctx.oficial_comprobarCambioSerie(cursor);
	}
	function netoVentasFacturaCli(curFactura) {
		return this.ctx.oficial_netoVentasFacturaCli(curFactura);
	}
	function netoComprasFacturaProv(curFactura) {
		return this.ctx.oficial_netoComprasFacturaProv(curFactura);
	}
	function datosConceptoAsiento(cur) {
		return this.ctx.oficial_datosConceptoAsiento(cur);
	}
	function subcuentaVentas(referencia, codEjercicio) {
		return this.ctx.oficial_subcuentaVentas(referencia, codEjercicio);
	}
	function regimenIVACliente(curDocCliente,cx) {
		return this.ctx.oficial_regimenIVACliente(curDocCliente,cx);
	}
// 	function liberarPedidosCli(curAlbaran) {
// 		return this.ctx.oficial_liberarPedidosCli(curAlbaran);
// 	}
// 	function liberarPedidosProv(curAlbaran) {
// 		return this.ctx.oficial_liberarPedidosProv(curAlbaran);
// 	}
	function restarCantidadCli(idLineaPedido, idLineaAlbaran) {
		return this.ctx.oficial_restarCantidadCli(idLineaPedido, idLineaAlbaran);
	}
	function restarCantidadProv(idLineaPedido, idLineaAlbaran) {
		return this.ctx.oficial_restarCantidadProv(idLineaPedido, idLineaAlbaran);
	}
	function actualizarPedidosCli(curAlbaran) {
		return this.ctx.oficial_actualizarPedidosCli(curAlbaran);
	}
	function actualizarPedidosProv(curAlbaran) {
		return this.ctx.oficial_actualizarPedidosProv(curAlbaran);
	}
	function actualizarLineaPedidoProv(idLineaPedido, idPedido, referencia, idAlbaran, cantidadLineaAlbaran) {
		return this.ctx.oficial_actualizarLineaPedidoProv(idLineaPedido, idPedido, referencia, idAlbaran, cantidadLineaAlbaran);
	}
	function sirveLineaPedidoProv(curLA) {
		return this.ctx.oficial_sirveLineaPedidoProv(curLA);
	}
	function actualizarEstadoPedidoProv(idPedido, curAlbaran) {
		return this.ctx.oficial_actualizarEstadoPedidoProv(idPedido, curAlbaran);
	}
	function obtenerEstadoPedidoProv(idPedido) {
		return this.ctx.oficial_obtenerEstadoPedidoProv(idPedido);
	}
	function actualizarLineaPedidoCli(idLineaPedido, idPedido, referencia, idAlbaran, cantidadLineaAlbaran) {
		return this.ctx.oficial_actualizarLineaPedidoCli(idLineaPedido, idPedido, referencia, idAlbaran, cantidadLineaAlbaran);
	}
	function sirveLineaPedidoCli(curLA) {
		return this.ctx.oficial_sirveLineaPedidoCli(curLA);
	}
	function actualizarEstadoPedidoCli(idPedido, curAlbaran) {
		return this.ctx.oficial_actualizarEstadoPedidoCli(idPedido, curAlbaran);
	}
	function obtenerEstadoPedidoCli(idPedido) {
		return this.ctx.oficial_obtenerEstadoPedidoCli(idPedido);
	}
	function liberarAlbaranesCli(idFactura) {
		return this.ctx.oficial_liberarAlbaranesCli(idFactura);
	}
	function liberarAlbaranCli(idAlbaran) {
		return this.ctx.oficial_liberarAlbaranCli(idAlbaran);
	}
	function liberarAlbaranesProv(idFactura) {
		return this.ctx.oficial_liberarAlbaranesProv(idFactura);
	}
	function liberarAlbaranProv(idAlbaran) {
		return this.ctx.oficial_liberarAlbaranProv(idAlbaran);
	}
	function liberarPresupuestoCli(idPresupuesto) {
		return this.ctx.oficial_liberarPresupuestoCli(idPresupuesto);
	}
	function actualizarPedidosLineaAlbaranCli(curLA) {
		return this.ctx.oficial_actualizarPedidosLineaAlbaranCli(curLA);
	}
	function actualizarPedidosLineaAlbaranProv(curLA) {
		return this.ctx.oficial_actualizarPedidosLineaAlbaranProv(curLA);
	}
	function aplicarComisionLineas(codAgente,tblHija,where) {
		return this.ctx.oficial_aplicarComisionLineas(codAgente,tblHija,where);
	}
	function calcularComisionLinea(codAgente,referencia) {
		return this.ctx.oficial_calcularComisionLinea(codAgente,referencia);
	}
	function arrayCostesAfectados(arrayInicial, arrayFinal) {
		return this.ctx.oficial_arrayCostesAfectados(arrayInicial, arrayFinal);
	}
	function compararArrayCoste(a, b) {
		return this.ctx.oficial_compararArrayCoste(a, b);
	}
	function esSubcuentaEspecial(codSubcuenta, codEjercicio, idTipoEsp) {
		return this.ctx.oficial_esSubcuentaEspecial(codSubcuenta, codEjercicio, idTipoEsp);
	}
	function campoImpuesto(campo, codImpuesto, fecha, cliProv) {
		return this.ctx.oficial_campoImpuesto(campo, codImpuesto, fecha, cliProv);
	}
	function datosImpuesto(codImpuesto, fecha) {
		return this.ctx.oficial_datosImpuesto(codImpuesto, fecha);
	}
	function valorDefecto(fN) {
		return this.ctx.oficial_valorDefecto(fN);
	}
	function actualizarArticulosProv(curLinea) {
		return this.ctx.oficial_actualizarArticulosProv(curLinea);
	}
	function avisarObservacionesCliente(codCliente) {
		return this.ctx.oficial_avisarObservacionesCliente(codCliente);
	}
	function ponDatosFacturaRec(aDatosFR) {
		return this.ctx.oficial_ponDatosFacturaRec(aDatosFR);
	}
	function dameDatosFacturaRec() {
		return this.ctx.oficial_dameDatosFacturaRec();
	}
	function ponSeleccionLineas(valores) {
		return this.ctx.oficial_ponSeleccionLineas(valores);
	}
	function dameSeleccionLineas() {
		return this.ctx.oficial_dameSeleccionLineas();
	}
	function comprobarDuplicidadCodigoFacturaCli(curFactura) {
		return this.ctx.oficial_comprobarDuplicidadCodigoFacturaCli(curFactura);
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
	function pub_cerosIzquierda(numero, totalCifras) {
		return this.cerosIzquierda(numero, totalCifras);
	}
	function pub_asientoBorrable(idAsiento) {
		return this.asientoBorrable(idAsiento);
	}
	function pub_regenerarAsiento(cur, valoresDefecto) {
		return this.regenerarAsiento(cur, valoresDefecto);
	}
	function pub_datosCtaEspecial(ctaEsp, codEjercicio) {
		return this.datosCtaEspecial(ctaEsp, codEjercicio);
	}
	function pub_siguienteNumero(codSerie, codEjercicio, fN) {
		return this.siguienteNumero(codSerie, codEjercicio, fN);
	}
	function pub_construirCodigo(codSerie, codEjercicio, numero) {
		return this.construirCodigo(codSerie, codEjercicio, numero);
	}
	function pub_agregarHueco(serie, ejercicio, numero, fN) {
		return this.agregarHueco(serie, ejercicio, numero, fN);
	}
	function pub_datosDocFacturacion(fecha, codEjercicio, tipoDoc) {
		return this.datosDocFacturacion(fecha, codEjercicio, tipoDoc);
	}
	function pub_tieneIvaDocCliente(codSerie, codCliente, codEjercicio) {
		return this.tieneIvaDocCliente(codSerie, codCliente, codEjercicio);
	}
	function pub_tieneIvaDocProveedor(codSerie, codProveedor, codEjercicio) {
		return this.tieneIvaDocProveedor(codSerie, codProveedor, codEjercicio);
	}
	function pub_automataActivado() {
		return this.automataActivado();
	}
	function pub_generarAsientoFacturaCli(curFactura) {
		return this.generarAsientoFacturaCli(curFactura);
	}
	function pub_generarAsientoFacturaProv(curFactura) {
		return this.generarAsientoFacturaProv(curFactura);
	}
	function pub_mostrarTraza(codigo, tipo) {
		return this.mostrarTraza(codigo, tipo);
	}
	function pub_eliminarAsiento(idAsiento) {
		return this.eliminarAsiento(idAsiento);
	}
	function pub_validarIvaRecargoCliente(codCliente,id,tabla,identificador) {
		return this.validarIvaRecargoCliente(codCliente,id,tabla,identificador);
	}
	function pub_validarIvaRecargoProveedor(codProveedor,id,tabla,identificador) {
		return this.validarIvaRecargoProveedor(codProveedor,id,tabla,identificador);
	}
	function pub_subcuentaVentas(referencia, codEjercicio) {
		return this.subcuentaVentas(referencia, codEjercicio);
	}
	function pub_regimenIVACliente(curDocCliente,cx) {
		return this.regimenIVACliente(curDocCliente,cx);
	}
	function pub_actualizarEstadoPedidoCli(idPedido, curAlbaran) {
		return this.actualizarEstadoPedidoCli(idPedido, curAlbaran);
	}
	function pub_actualizarEstadoPedidoProv(idPedido, curAlbaran) {
		return this.actualizarEstadoPedidoProv(idPedido, curAlbaran);
	}
	function pub_aplicarComisionLineas(codAgente,tblHija,where) {
		return this.aplicarComisionLineas(codAgente,tblHija,where);
	}
	function pub_calcularComisionLinea(codAgente,referencia) {
		return this.calcularComisionLinea(codAgente,referencia);
	}
	function pub_arrayCostesAfectados(arrayInicial, arrayFinal) {
		return this.arrayCostesAfectados(arrayInicial, arrayFinal);
	}
	function pub_campoImpuesto(campo, codImpuesto, fecha, cliProv) {
		return this.campoImpuesto(campo, codImpuesto, fecha, cliProv);
	}
	function pub_datosImpuesto(codImpuesto, fecha) {
		return this.datosImpuesto(codImpuesto, fecha);
	}
	function pub_valorDefecto(fN) {
		return this.valorDefecto(fN);
	}
	function pub_actualizarArticulosProv(curLinea) {
		return this.actualizarArticulosProv(curLinea);
	}
	function pub_avisarObservacionesCliente(codCliente) {
		return this.avisarObservacionesCliente(codCliente);
	}
	function pub_ponDatosFacturaRec(aDatosFR) {
		return this.ponDatosFacturaRec(aDatosFR);
	}
	function pub_dameDatosFacturaRec() {
		return this.dameDatosFacturaRec();
	}
	function pub_ponSeleccionLineas(valores) {
		return this.ponSeleccionLineas(valores);
	}
	function pub_dameSeleccionLineas() {
		return this.dameSeleccionLineas();
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
Se calcula el número del pedido como el siguiente de la secuencia asociada a su ejercicio y serie.

Se actualiza el estado del pedido.

Si el pedido está servido parcialmente y se quiere borrar, no se permite borrarlo o se dá la opción de cancelar lo pendiente de servir.
\end */
function interna_beforeCommit_pedidoscli(curPedido)
{
	var _i = this.iface;
	var numero;

	switch (curPedido.modeAccess()) {
		case curPedido.Insert: {
			if (!flfactppal.iface.pub_clienteActivo(curPedido.valueBuffer("codcliente"), curPedido.valueBuffer("fecha")))
				return false;
			if (curPedido.valueBuffer("numero") == 0) {
				numero = _i.siguienteNumero(curPedido.valueBuffer("codserie"), curPedido.valueBuffer("codejercicio"), "npedidocli");
				if (!numero)
					return false;
				curPedido.setValueBuffer("numero", numero);
				curPedido.setValueBuffer("codigo", formpedidoscli.iface.pub_commonCalculateField("codigo", curPedido));
			}
			break;
		}
		case curPedido.Edit: {
			if(!_i.comprobarCambioSerie(curPedido))
				return false;
			if (!flfactppal.iface.pub_clienteActivo(curPedido.valueBuffer("codcliente"), curPedido.valueBuffer("fecha")))
				return false;
			if (curPedido.valueBuffer("servido") == "Parcial") {
				var estado = _i.obtenerEstadoPedidoCli(curPedido.valueBuffer("idpedido"));
				if (estado == "Sí") {
					curPedido.setValueBuffer("servido", estado);
					curPedido.setValueBuffer("editable", false);
				}
			}
			break;
		}
		case curPedido.Del: {
			if (curPedido.valueBuffer("servido") == "Parcial") {
				sys.warnMsgBox(sys.translate("No se puede eliminar un pedido servido parcialmente.\nDebe borrar antes el albarán relacionado."));
				return false;
			}
			break;
		}
	}

	return true;
}

function interna_beforeCommit_lineaspresupuestoscli(curLinea)
{
	return true;
}

function interna_beforeCommit_lineaspedidoscli(curLinea)
{
	return true;
}

function interna_beforeCommit_lineaspedidosprov(curLinea)
{
	return true;
}

function interna_beforeCommit_lineasalbaranescli(curLinea)
{
	return true;
}

function interna_beforeCommit_lineasalbaranesprov(curLinea)
{
	return true;
}

function interna_beforeCommit_lineasfacturascli(curLinea)
{
	return true;
}

function interna_beforeCommit_lineasfacturasprov(curLinea)
{
	return true;
}

/** \C
Se calcula el número del pedido como el siguiente de la secuencia asociada a su ejercicio y serie.

Se actualiza el estado del pedido.

Si el pedido está servido parcialmente y se quiere borrar, no se permite borrarlo o se dá la opción de cancelar lo pendiente de servir.
\end */
function interna_beforeCommit_pedidosprov(curPedido)
{
	var _i = this.iface;
	var numero;

	switch (curPedido.modeAccess()) {
		case curPedido.Insert: {
			if (curPedido.valueBuffer("numero") == 0) {
				numero = _i.siguienteNumero(curPedido.valueBuffer("codserie"), curPedido.valueBuffer("codejercicio"), "npedidoprov");
				if (!numero)
					return false;
				curPedido.setValueBuffer("numero", numero);
				curPedido.setValueBuffer("codigo", formpedidosprov.iface.pub_commonCalculateField("codigo", curPedido));
			}
			break;
		}
		case curPedido.Edit: {
			if(!_i.comprobarCambioSerie(curPedido))
				return false;
			if (curPedido.valueBuffer("servido") == "Parcial") {
				var estado = _i.obtenerEstadoPedidoProv(curPedido.valueBuffer("idpedido"));
				if (estado == "Sí") {
					curPedido.setValueBuffer("servido", estado);
					curPedido.setValueBuffer("editable", false);
					if (sys.isLoadedModule("flcolaproc")) {
						if (!flfactppal.iface.pub_lanzarEvento(curPedido, "pedidoProvAlbaranado"))
							return false;
					}
				}
			}
			break;
		}
		case curPedido.Del: {
			if (curPedido.valueBuffer("servido") == "Parcial") {
				sys.warnMsgBox(sys.translate("No se puede eliminar un pedido servido parcialmente.\nDebe borrar antes el albarán relacionado."));
				return false;
			}
			break;
		}
	}
	return true;
}

/* \C En el caso de que el módulo de contabilidad esté cargado y activado, genera o modifica el asiento contable correspondiente a la factura a cliente.
\end */
function interna_beforeCommit_facturascli(curFactura)
{
	var _i = this.iface;
	var numero;

	if (curFactura.modeAccess() == curFactura.Insert || curFactura.modeAccess() == curFactura.Edit) {
		if (!_i.comprobarFacturaAbonoCli(curFactura)) {
			return false;
		}
	}

	switch (curFactura.modeAccess()) {
		case curFactura.Insert: {
			if (!flfactppal.iface.pub_clienteActivo(curFactura.valueBuffer("codcliente"), curFactura.valueBuffer("fecha")))
				return false;
			if (curFactura.valueBuffer("numero") == 0) {
				_i.recalcularHuecos( curFactura.valueBuffer("codserie"), curFactura.valueBuffer("codejercicio"), "nfacturacli" );
				numero = _i.siguienteNumero(curFactura.valueBuffer("codserie"), curFactura.valueBuffer("codejercicio"), "nfacturacli");
				if (!numero)
					return false;
				curFactura.setValueBuffer("numero", numero);
				curFactura.setValueBuffer("codigo", formfacturascli.iface.pub_commonCalculateField("codigo", curFactura));
			}
			break;
		}
		case curFactura.Edit: {
			if(!_i.comprobarCambioSerie(curFactura))
				return false;
			if (!flfactppal.iface.pub_clienteActivo(curFactura.valueBuffer("codcliente"), curFactura.valueBuffer("fecha")))
				return false;
			break;
		}
	}

	if (curFactura.modeAccess() == curFactura.Insert || curFactura.modeAccess() == curFactura.Edit) {
		if(!_i.comprobarDuplicidadCodigoFacturaCli(curFactura))
			return false;
	}

	if (curFactura.modeAccess() == curFactura.Edit) {
		if (!formRecordfacturascli.iface.pub_actualizarLineasIva(curFactura)) {
			return false;
		}
	}

	if (curFactura.modeAccess() == curFactura.Insert || curFactura.modeAccess() == curFactura.Edit) {
		if (sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada")) {
			if (_i.generarAsientoFacturaCli(curFactura) == false) {
				return false;
			}
		}
	}
	return true;
}

/* \C En el caso de que el módulo de contabilidad esté cargado y activado, genera o modifica el asiento contable correspondiente a la factura a proveedor.
\end */
function interna_beforeCommit_facturasprov(curFactura)
{
	var _i = this.iface;
	var numero;

	if (curFactura.modeAccess() == curFactura.Insert || curFactura.modeAccess() == curFactura.Edit) {
		if (!_i.comprobarFacturaAbonoProv(curFactura)) {
			return false;
		}
	}

	if (curFactura.modeAccess() == curFactura.Edit) {
		if (!_i.comprobarCambioSerie(curFactura)) {
			return false;
		}
	}
	if (curFactura.modeAccess() == curFactura.Insert) {
		if (curFactura.valueBuffer("numero") == 0) {
			_i.recalcularHuecos( curFactura.valueBuffer("codserie"), curFactura.valueBuffer("codejercicio"), "nfacturaprov" );
			numero = _i.siguienteNumero(curFactura.valueBuffer("codserie"), curFactura.valueBuffer("codejercicio"), "nfacturaprov");
			if (!numero)
				return false;
			curFactura.setValueBuffer("numero", numero);
			curFactura.setValueBuffer("codigo", formfacturasprov.iface.pub_commonCalculateField("codigo", curFactura));
		}
	}

	if (curFactura.modeAccess() == curFactura.Insert || curFactura.modeAccess() == curFactura.Edit) {
		while (AQUtil.sqlSelect("facturasprov", "idfactura", "codejercicio = '" + curFactura.valueBuffer("codejercicio") + "' AND codserie = '" + curFactura.valueBuffer("codserie") + "' AND numero = '" + curFactura.valueBuffer("numero") + "' AND idfactura <> " + curFactura.valueBuffer("idfactura"))) {
			numero = _i.siguienteNumero(curFactura.valueBuffer("codserie"), curFactura.valueBuffer("codejercicio"), "nfacturaprov");
			if (!numero)
				return false;
			curFactura.setValueBuffer("numero", numero);
			curFactura.setValueBuffer("codigo", formfacturasprov.iface.pub_commonCalculateField("codigo", curFactura));
		}
	}

	if (curFactura.modeAccess() == curFactura.Edit) {
		if (!formRecordfacturasprov.iface.pub_actualizarLineasIva(curFactura)) {
			return false;
		}
	}

	if (curFactura.modeAccess() == curFactura.Insert || curFactura.modeAccess() == curFactura.Edit) {
		if (sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada")) {
			if (_i.generarAsientoFacturaProv(curFactura) == false) {
				return false;
			}
		}
	}
	return true;
}


/* \C Se calcula el número del albarán como el siguiente de la secuencia asociada a su ejercicio y serie.
Se recalcula el estado de los pedidos asociados al albarán
\end */
function interna_beforeCommit_albaranescli(curAlbaran)
{
	var _i = this.iface;
	var numero;

	switch (curAlbaran.modeAccess()) {
		case curAlbaran.Insert: {
			if (!flfactppal.iface.pub_clienteActivo(curAlbaran.valueBuffer("codcliente"), curAlbaran.valueBuffer("fecha")))
				return false;
			if (curAlbaran.valueBuffer("numero") == 0) {
				numero = _i.siguienteNumero(curAlbaran.valueBuffer("codserie"), curAlbaran.valueBuffer("codejercicio"), "nalbarancli");
				if (!numero)
					return false;
				curAlbaran.setValueBuffer("numero", numero);
				curAlbaran.setValueBuffer("codigo", formalbaranescli.iface.pub_commonCalculateField("codigo", curAlbaran));
			}
			break;
		}
		case curAlbaran.Edit: {
			if(!_i.comprobarCambioSerie(curAlbaran)) {
				return false;
			}
			if (!flfactppal.iface.pub_clienteActivo(curAlbaran.valueBuffer("codcliente"), curAlbaran.valueBuffer("fecha"))) {
				return false;
			}
// 			if(!_i.actualizarPedidosCli(curAlbaran)) {
// 				return false;
// 			}
			break;
		}
		case curAlbaran.Del: {
			break;
		}
	}
	
	if (!flfactppal.iface.pub_controlDatosMod(curAlbaran)) {
		return false;
	}

	return true;
}

/** \C Si el albarán se borra se actualizan los pedidos asociados
\end */
function interna_afterCommit_albaranescli(curAlbaran)
{
	switch (curAlbaran.modeAccess()) {
		case curAlbaran.Del: {
// 			if (!_i.liberarPedidosCli(curAlbaran)) {
// 				return false;
// 			}
			break;
		}
	}
	return true;
}

/** \C Si el albarán se borra se actualizan los pedidos asociados
\end */
function interna_afterCommit_albaranesprov(curAlbaran)
{
	var _i = this.iface;
	switch (curAlbaran.modeAccess()) {
		case curAlbaran.Del: {
// 			if (!_i.liberarPedidosProv(curAlbaran)) {
// 				return false;
// 			}
			break;
		}
	}
	return true;
}


/* \C Se calcula el número del albarán como el siguiente de la secuencia asociada a su ejercicio y serie.

Se recalcula el estado de los pedidos asociados al albarán
\end */
function interna_beforeCommit_albaranesprov(curAlbaran)
{
	var _i = this.iface;
	var numero;

	switch (curAlbaran.modeAccess()) {
		case curAlbaran.Insert: {
			if (curAlbaran.valueBuffer("numero") == 0) {
				numero = _i.siguienteNumero(curAlbaran.valueBuffer("codserie"), curAlbaran.valueBuffer("codejercicio"), "nalbaranprov");
				if (!numero)
					return false;
				curAlbaran.setValueBuffer("numero", numero);
				curAlbaran.setValueBuffer("codigo", formalbaranesprov.iface.pub_commonCalculateField("codigo", curAlbaran));
			}
			break;
		}
		case curAlbaran.Edit: {
			if (!_i.comprobarCambioSerie(curAlbaran)) {
				return false;
			}
// 			if (!_i.actualizarPedidosProv(curAlbaran)) {
// 				return false;
// 			}
			break;
		}
	}

	return true;
}

/* \C Se calcula el número del presupuesto como el siguiente de la secuencia asociada a su ejercicio y serie.
\end */
function interna_beforeCommit_presupuestoscli(curPresupuesto)
{
	var _i = this.iface;
	var numero;

	switch (curPresupuesto.modeAccess()) {
		case curPresupuesto.Insert: {
			if (!flfactppal.iface.pub_clienteActivo(curPresupuesto.valueBuffer("codcliente"), curPresupuesto.valueBuffer("fecha")))
				return false;
			if (curPresupuesto.valueBuffer("numero") == 0) {
				numero = _i.siguienteNumero(curPresupuesto.valueBuffer("codserie"), curPresupuesto.valueBuffer("codejercicio"), "npresupuestocli");
				if (!numero)
					return false;
				curPresupuesto.setValueBuffer("numero", numero);
				curPresupuesto.setValueBuffer("codigo", formpresupuestoscli.iface.pub_commonCalculateField("codigo", curPresupuesto));
			}
			break;
		}
		case curPresupuesto.Edit: {
			if(!_i.comprobarCambioSerie(curPresupuesto))
				return false;
			if (!flfactppal.iface.pub_clienteActivo(curPresupuesto.valueBuffer("codcliente"), curPresupuesto.valueBuffer("fecha")))
				return false;
			break;
		}
	}

	return true;
}

/** \C Si el pedido se borra se actualiza el presupuesto asociado
\end */
function interna_afterCommit_pedidoscli(curPedido)
{
	var _i = this.iface;
	switch (curPedido.modeAccess()) {
		case curPedido.Del: {
			if (!_i.liberarPresupuestoCli(curPedido.valueBuffer("idpresupuesto"))) {
				return false;
			}
			break;
		}
	}
	return true;
}

/* \C En el caso de que el módulo de tesorería esté cargado, genera o modifica los recibos correspondientes a la factura.

En el caso de que el módulo pincipal de contabilidad esté cargado y activado, y que la acción a realizar sea la de borrado de la factura, borra el asiento contable correspondiente.
\end */
function interna_afterCommit_facturascli(curFactura)
{
	var _i = this.iface;
	switch (curFactura.modeAccess()) {
		case curFactura.Del: {
			if (!_i.agregarHueco(curFactura.valueBuffer("codserie"), curFactura.valueBuffer("codejercicio"), curFactura.valueBuffer("numero"), "nfacturacli")) {
				return false;
			}
			if (!_i.liberarAlbaranesCli(curFactura.valueBuffer("idfactura"))) {
				return false;
			}
			break;
		}
	}

	if (sys.isLoadedModule("flfactteso") && curFactura.valueBuffer("tpv") == false) {
		if (curFactura.modeAccess() == curFactura.Insert || curFactura.modeAccess() == curFactura.Edit) {
			if (_i.siGenerarRecibosCli(curFactura))
				if (flfactteso.iface.pub_regenerarRecibosCli(curFactura) == false)
					return false;
		}
		if (curFactura.modeAccess() == curFactura.Del) {
			flfactteso.iface.pub_actualizarRiesgoCliente(curFactura.valueBuffer("codcliente"));
		}
	}

	if (sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada")) {
		switch (curFactura.modeAccess()) {
			case curFactura.Edit: {
				if (curFactura.valueBuffer("nogenerarasiento")) {
					var idAsientoAnterior = curFactura.valueBufferCopy("idasiento");
					if (idAsientoAnterior && idAsientoAnterior != "") {
						if (!_i.eliminarAsiento(idAsientoAnterior)) {
							return false;
						}
					}
				}
				break;
			}
			case curFactura.Del: {
				if (!_i.eliminarAsiento(curFactura.valueBuffer("idasiento"))) {
					return false;
				}
				break;
			}
		}
	}

	return true;
}

/* \C En el caso de que el módulo pincipal de contabilidad esté cargado y activado, y que la acción a realizar sea la de borrado de la factura, borra el asiento contable correspondiente.
\end */
function interna_afterCommit_facturasprov(curFactura)
{
	var _i = this.iface;
	if (sys.isLoadedModule("flfactteso")) {
		if (curFactura.modeAccess() == curFactura.Insert || curFactura.modeAccess() == curFactura.Edit) {
// 			if (curFactura.valueBuffer("total") != curFactura.valueBufferCopy("total")
// 				|| curFactura.valueBuffer("codproveedor") != curFactura.valueBufferCopy("codproveedor")
// 				|| curFactura.valueBuffer("codpago") != curFactura.valueBufferCopy("codpago")
// 				|| curFactura.valueBuffer("fecha") != curFactura.valueBufferCopy("fecha")) {
				if (!flfactteso.iface.pub_regenerarRecibosProv(curFactura)) {
					return false;
				}
// 			}
		}
	}

	switch (curFactura.modeAccess()) {
		case curFactura.Del: {
			if (!_i.liberarAlbaranesProv(curFactura.valueBuffer("idfactura"))) {
				return false;
			}
			break;
		}
	}

	if (sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada")) {
		switch (curFactura.modeAccess()) {
			case curFactura.Edit: {
				if (curFactura.valueBuffer("nogenerarasiento")) {
					var idAsientoAnterior = curFactura.valueBufferCopy("idasiento");
					if (idAsientoAnterior && idAsientoAnterior != "") {
						if (!_i.eliminarAsiento(idAsientoAnterior))
							return false;
					}
				}
				break;
			}
			case curFactura.Del: {
				if (!_i.eliminarAsiento(curFactura.valueBuffer("idasiento"))) {
					return false;
				}
				break;
			}
		}
	}
	return true;
}

/** \C
Actualización del stock correspondiente al artículo seleccionado en la línea
\end */
function interna_afterCommit_lineasalbaranesprov(curLA)
{
	var _i = this.iface;
	if (!_i.actualizarPedidosLineaAlbaranProv(curLA)) {
		return false;
	}

	if (sys.isLoadedModule("flfactalma")) {
		if (!flfactalma.iface.pub_controlStockAlbaranesProv(curLA)) {
			return false;
		}
	}

	return true;
}

/** \C
En el caso de que la factura no sea automática (no provenga de un albarán), realiza la actualización del stock correspondiente al artículo seleccionado en la línea.

Actualiza también el coste medio de los artículos afectados por el cambio.
\end */
function interna_afterCommit_lineasfacturasprov(curLF)
{
	var _i = this.iface;

	if (sys.isLoadedModule("flfactalma")) {
		if (!flfactalma.iface.pub_controlStockFacturasProv(curLF)) {
			return false;
		}
	}

	var curF = curLF.cursorRelation();
	if (!curF || curF.action() != "lineasfacturasprov") {
		var referencia, refAnterior;
		referencia = curLF.valueBuffer("referencia");
		if (referencia && referencia != "") {
			if (!flfactalma.iface.pub_cambiarCosteMedio(referencia)) {
				return false;
			}
		}
		if (curLF.modeAccess() == curLF.Edit) {
			refAnterior = curLF.valueBufferCopy("referencia");
			if (refAnterior && refAnterior != "" && refAnterior != referencia) {
				if (!flfactalma.iface.pub_cambiarCosteMedio(refAnterior)) {
					return false;
				}
			}
		}
	}

	return true;
}

/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea si el sistema
está configurado para ello
\end */
function interna_afterCommit_lineaspedidoscli(curLP)
{
	var _i = this.iface;

 	if (sys.isLoadedModule("flfactalma"))
		if (!flfactalma.iface.pub_controlStockPedidosCli(curLP)){
			return false;
		}
	return true;
}

function interna_afterCommit_lineaspresupuestoscli(curLP)
{
	return true;
}

/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea si el sistema
está configurado para ello
\end */
function interna_afterCommit_lineaspedidosprov(curLP)
{
	var _i = this.iface;

 	if (sys.isLoadedModule("flfactalma")) {
		if (!flfactalma.iface.pub_controlStockPedidosProv(curLP)) {
			return false;
		}
	}
	return true;
}

/** \C
Si la línea de albarán no proviene de una línea de pedido, realiza la actualización del stock correspondiente al artículo seleccionado en la línea
\end */
function interna_afterCommit_lineasalbaranescli(curLA)
{
	var _i = this.iface;


	if (sys.isLoadedModule("flfactalma")) {
		if (!flfactalma.iface.pub_controlStockAlbaranesCli(curLA)) {
			return false;
		}
	}

	if (!_i.actualizarPedidosLineaAlbaranCli(curLA)) {
		return false;
	}
	return true;
}

/** \C
En el caso de que la factura no sea automática (no provenga de un albarán), realiza la actualización del stock correspondiente al artículo seleccionado en la línea
\end */
function interna_afterCommit_lineasfacturascli(curLF)
{
	var _i = this.iface;

	if (sys.isLoadedModule("flfactalma")) {
		if (!flfactalma.iface.pub_controlStockFacturasCli(curLF)){
			return false;
		}
	}
	return true;
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_actualizarPedidosLineaAlbaranCli(curLA)
{
	var _i = this.iface;

	var idLineaPedido = parseFloat(curLA.valueBuffer("idlineapedido"));
	if (idLineaPedido == 0) {
		return true;
	}

	switch (curLA.modeAccess()) {
		case curLA.Insert: {
// 			if (!_i.actualizarLineaPedidoCli(curLA.valueBuffer("idlineapedido"), curLA.valueBuffer("idpedido") , curLA.valueBuffer("referencia"), curLA.valueBuffer("idalbaran"), curLA.valueBuffer("cantidad"))) {
// 				return false;
// 			}
			if (!_i.sirveLineaPedidoCli(curLA)) {
				return false;
			}
			if (!_i.actualizarEstadoPedidoCli(curLA.valueBuffer("idpedido"), curLA)) {
				return false;
			}
			break;
		}
		case curLA.Edit: {
			if (curLA.valueBuffer("cantidad") != curLA.valueBufferCopy("cantidad")) {
// 				if (!_i.actualizarLineaPedidoCli(curLA.valueBuffer("idlineapedido"), curLA.valueBuffer("idpedido") , curLA.valueBuffer("referencia"), curLA.valueBuffer("idalbaran"), curLA.valueBuffer("cantidad"))) {
// 					return false;
// 				}
				if (!_i.sirveLineaPedidoCli(curLA)) {
					return false;
				}
				if (!_i.actualizarEstadoPedidoCli(curLA.valueBuffer("idpedido"), curLA)) {
					return false;
				}
			}
			break;
		}
		case curLA.Del: {
			var idPedido = curLA.valueBuffer("idpedido");
			var idLineaAlbaran = curLA.valueBuffer("idlinea");
			if (!_i.restarCantidadCli(idLineaPedido, idLineaAlbaran)) {
				return false;
			}
			_i.actualizarEstadoPedidoCli(idPedido);
			break;
		}
	}
	return true;
}

function oficial_actualizarPedidosLineaAlbaranProv(curLA)
{
	var _i = this.iface;

	var idLineaPedido = parseFloat(curLA.valueBuffer("idlineapedido"));
	if (idLineaPedido == 0) {
		return true;
	}

	switch (curLA.modeAccess()) {
		case curLA.Insert: {
			if (!_i.sirveLineaPedidoProv(curLA)) {
				return false;
			}
			/// Obsoleta, se usa sirveLineaPedidoProv
// 			if (!_i.actualizarLineaPedidoProv(curLA.valueBuffer("idlineapedido"), curLA.valueBuffer("idpedido") , curLA.valueBuffer("referencia"), curLA.valueBuffer("idalbaran"), curLA.valueBuffer("cantidad"))) {
// 				return false;
// 			}
			if (!_i.actualizarEstadoPedidoProv(curLA.valueBuffer("idpedido"), curLA)) {
				return false;
			}
			break;
		}
		case curLA.Edit: {
			if (curLA.valueBuffer("cantidad") != curLA.valueBufferCopy("cantidad")) {
				if (!_i.sirveLineaPedidoProv(curLA)) {
					return false;
				}
// 				if (!_i.actualizarLineaPedidoProv(curLA.valueBuffer("idlineapedido"), curLA.valueBuffer("idpedido") , curLA.valueBuffer("referencia"), curLA.valueBuffer("idalbaran"), curLA.valueBuffer("cantidad"))) {
// 					return false;
// 				}
				if (!_i.actualizarEstadoPedidoProv(curLA.valueBuffer("idpedido"), curLA)) {
					return false;
				}
			}
			break;
		}
		case curLA.Del: {
			var idPedido = curLA.valueBuffer("idpedido");
			var idLineaAlbaran = curLA.valueBuffer("idlinea");
			if (!_i.restarCantidadProv(idLineaPedido, idLineaAlbaran)) {
				return false;
			}
			_i.actualizarEstadoPedidoProv(idPedido);
			break;
		}
	}
	return true;
}

/** \D
Obtiene el primer hueco de la tabla de huecos (documentos de facturación que han sido borrados y han dejado su código disponible para volver a ser usado)
@param codSerie: Código de serie del documento
@param codEjercicio: Código de ejercicio del documento
@param tipo: Tipo de documento (factura a cliente, a proveedor)
@return Número correspondiente al primer hueco encontrado (0 si no se encuentra ninguno)
\end */
function oficial_obtenerHueco(codSerie, codEjercicio, tipo)
{
	var _i = this.iface;

	var cursorHuecos = new FLSqlCursor("huecos");
	var numHueco = 0;
	cursorHuecos.select("upper(codserie)='" + codSerie + "' AND upper(codejercicio)='" + codEjercicio + "' AND upper(tipo)='" + tipo + "' ORDER BY numero;");
	if (cursorHuecos.next()) {
		numHueco = cursorHuecos.valueBuffer("numero");
		cursorHuecos.setActivatedCheckIntegrity(false);
		cursorHuecos.setModeAccess(cursorHuecos.Del);
		cursorHuecos.refreshBuffer();
		cursorHuecos.commitBuffer();
	}
	return numHueco;
}

function oficial_establecerNumeroSecuencia(fN, value)
{
	return (parseFloat(value) + 1);
}

/** \D
Rellena un string con ceros a la izquierda hasta completar la logitud especificada
@param numero: String que contiene el número
@param totalCifras: Longitud a completar
\end */
function oficial_cerosIzquierda(numero, totalCifras)
{
	var ret = numero.toString();
	var numCeros = totalCifras - ret.length;
	for ( ; numCeros > 0 ; --numCeros)
		ret = "0" + ret;
	return ret;
}

function oficial_construirCodigo(codSerie, codEjercicio, numero)
{
	var _i = this.iface;
	return _i.cerosIzquierda(codEjercicio, 4) +
		_i.cerosIzquierda(codSerie, 2) +
		_i.cerosIzquierda(numero, 6);
}

/** \D
Obtiene el siguiente número de la secuencia de documentos
@param codSerie: Código de serie del documento
@param codEjercicio: Código de ejercicio del documento
@param fN: Tipo de documento (factura a cliente, a proveedor, albarán, etc.)
@return Número correspondiente al siguiente documento en la serie o false si hay error
\end */
function oficial_siguienteNumero(codSerie, codEjercicio, fN)
{
	var numero;
	var _i = this.iface;
	var cursorSecuencias = new FLSqlCursor("secuenciasejercicios");

	cursorSecuencias.setContext(this);
	cursorSecuencias.setActivatedCheckIntegrity(false);
	cursorSecuencias.select("upper(codserie)='" + codSerie + "' AND upper(codejercicio)='" + codEjercicio + "';");
	if (cursorSecuencias.next()) {
		if (fN == "nfacturaprov") {
			var numeroHueco = _i.obtenerHueco(codSerie, codEjercicio, "FP");
			if (numeroHueco != 0) {
				cursorSecuencias.setActivatedCheckIntegrity(true);
				return numeroHueco;
			}
		}
		if (fN == "nfacturacli") {
			var numeroHueco = _i.obtenerHueco(codSerie, codEjercicio, "FC");
			if (numeroHueco != 0) {
				cursorSecuencias.setActivatedCheckIntegrity(true);
				return numeroHueco;
			}
		}

		/** \C
		Para minimizar bloqueos las secuencias se han separado en distintos registros de otra tabla
		llamada secuencias
		\end */
		var cursorSecs = new FLSqlCursor( "secuencias" );
		cursorSecs.setContext( this );
		cursorSecs.setActivatedCheckIntegrity( false );
		/** \C
		Si el registro no existe lo crea inicializandolo con su antiguo valor del campo correspondiente
		en la tabla secuenciasejercicios.
		\end */
		var idSec = cursorSecuencias.valueBuffer( "id" );
		cursorSecs.select( "id=" + idSec + " AND nombre='" + fN + "'" );
		if ( !cursorSecs.next() ) {
			numero = cursorSecuencias.valueBuffer(fN);
			if (!numero || isNaN(numero)) {
				numero = 1;
			}
			cursorSecs.setModeAccess( cursorSecs.Insert );
			cursorSecs.refreshBuffer();
			cursorSecs.setValueBuffer( "id", idSec );
			cursorSecs.setValueBuffer( "nombre", fN );
			cursorSecs.setValueBuffer( "valor", _i.establecerNumeroSecuencia( fN, numero ) );
			cursorSecs.commitBuffer();
		} else {
			cursorSecs.setModeAccess( cursorSecs.Edit );
			cursorSecs.refreshBuffer();
			if ( !cursorSecs.isNull( "valorout" ) )
				numero = cursorSecs.valueBuffer( "valorout" );
			else
				numero = cursorSecs.valueBuffer( "valor" );
			cursorSecs.setValueBuffer( "valorout", _i.establecerNumeroSecuencia( fN, numero ) );
			cursorSecs.commitBuffer();
		}
		cursorSecs.setActivatedCheckIntegrity( true );
	} else {
		/** \C
		Si la serie no existe para el ejercicio actual se consultará al usuario si la quiere crear
		\end */
		var res = MessageBox.warning(sys.translate("La serie ") + codSerie + sys.translate(" no existe para el ejercicio ") + codEjercicio + sys.translate(".\n¿Desea crearla?"), MessageBox.Yes,MessageBox.No);
		if (res != MessageBox.Yes) {
			cursorSecuencias.setActivatedCheckIntegrity(true);
			return false;
		}
		cursorSecuencias.setModeAccess(cursorSecuencias.Insert);
		cursorSecuencias.refreshBuffer();
		cursorSecuencias.setValueBuffer("codserie", codSerie);
		cursorSecuencias.setValueBuffer("codejercicio", codEjercicio);
		numero = "1";
		cursorSecuencias.setValueBuffer(fN, "2");
		if (!cursorSecuencias.commitBuffer()) {
			cursorSecuencias.setActivatedCheckIntegrity(true);
			return false;
		}
	}
	cursorSecuencias.setActivatedCheckIntegrity(true);
	return numero;
}

/** \D
Agrega un hueco a la tabla de huecos
@param serie: Código de serie del documento
@param ejercicio: Código de ejercicio del documento
@param numero: Número del documento
@param fN: Tipo de documento (factura a cliente, a proveedor, albarán, etc.)
@return true si el hueco se inserta correctamente o false si hay error
\end */
function oficial_agregarHueco(serie, ejercicio, numero, fN)
{
	var _i = this.iface;
	return _i.recalcularHuecos( serie, ejercicio, fN );
}

/* \D Indica si el asiento asociado a la factura puede o no regenerarse, según pertenezca a un ejercicio abierto o cerrado
@param idAsiento: Identificador del asiento
@return True: Asiento borrable, False: Asiento no borrable
\end */
function oficial_asientoBorrable(idAsiento)
{
	var _i = this.iface;
	var qryEjerAsiento = new FLSqlQuery();
	qryEjerAsiento.setTablesList("ejercicios,co_asientos");
	qryEjerAsiento.setSelect("e.estado");
	qryEjerAsiento.setFrom("co_asientos a INNER JOIN ejercicios e" +
			" ON a.codejercicio = e.codejercicio");
	qryEjerAsiento.setWhere("a.idasiento = " + idAsiento);
	try { qryEjerAsiento.setForwardOnly( true ); } catch (e) {}

	if (!qryEjerAsiento.exec())
		return false;

	if (!qryEjerAsiento.next())
		return true;

	if (qryEjerAsiento.value(0) != "ABIERTO") {
		sys.errorMsgBox(sys.translate("No puede realizarse la modificación porque el asiento contable correspondiente pertenece a un ejercicio cerrado"));
		return false;
	}

	return true;
}

/** \U Genera o regenera el asiento correspondiente a una factura de cliente
@param	curFactura: Cursor con los datos de la factura
@return	VERDADERO si no hay error. FALSO en otro caso
\end */
function oficial_generarAsientoFacturaCli(curFactura)
{
	var _i = this.iface;

	if (curFactura.modeAccess() != curFactura.Insert && curFactura.modeAccess() != curFactura.Edit)
		return true;

	if (curFactura.valueBuffer("nogenerarasiento")) {
		curFactura.setNull("idasiento");
		return true;
	}

	if (!_i.comprobarRegularizacion(curFactura)){
		return false;
	}
	var datosAsiento = [];
	var valoresDefecto = [];
	valoresDefecto["codejercicio"] = curFactura.valueBuffer("codejercicio");
	valoresDefecto["coddivisa"] = flfactppal.iface.pub_valorDefectoEmpresa("coddivisa");

	var curTransaccion = new FLSqlCursor("facturascli");
	curTransaccion.transaction(false);
	try {
		datosAsiento = _i.regenerarAsiento(curFactura, valoresDefecto);
		if (datosAsiento.error == true)
			throw sys.translate("Error al regenerar el asiento");

		var ctaCliente = _i.datosCtaCliente(curFactura, valoresDefecto);
		if (ctaCliente.error != 0)
			throw sys.translate("Error al leer los datos de subcuenta de cliente");

		if (!_i.generarPartidasCliente(curFactura, datosAsiento.idasiento, valoresDefecto, ctaCliente))
			throw sys.translate("Error al generar las partidas de cliente");

		if (!_i.generarPartidasIRPF(curFactura, datosAsiento.idasiento, valoresDefecto))
			throw sys.translate("Error al generar las partidas de IRPF");

		if (!_i.generarPartidasIVACli(curFactura, datosAsiento.idasiento, valoresDefecto, ctaCliente))
			throw sys.translate("Error al generar las partidas de IVA");

		if (!_i.generarPartidasRecFinCli(curFactura, datosAsiento.idasiento, valoresDefecto))
			throw sys.translate("Error al generar las partidas de recargo financiero");

		if (!_i.generarPartidasVenta(curFactura, datosAsiento.idasiento, valoresDefecto))
			throw sys.translate("Error al generar las partidas de venta");

		curFactura.setValueBuffer("idasiento", datosAsiento.idasiento);

		if (curFactura.valueBuffer("deabono") == true)
			if (!_i.asientoFacturaAbonoCli(curFactura, valoresDefecto))
				throw sys.translate("Error al generar el asiento correspondiente a la factura de abono");

		if (!flcontppal.iface.pub_comprobarAsiento(datosAsiento.idasiento))
			throw sys.translate("Error al comprobar el asiento");
	} catch (e) {
		curTransaccion.rollback();
		sys.warnMsgBox(sys.translate("Error al generar el asiento correspondiente a la factura %1:").arg(curFactura.valueBuffer("codigo")) + "\n" + e);
		return false;
	}
	curTransaccion.commit();

	return true;
}

/** \D Genera la parte del asiento de factura correspondiente a la subcuenta de ventas
@param	curFactura: Cursor de la factura
@param	idAsiento: Id del asiento asociado
@param	valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@return	VERDADERO si no hay error, FALSO en otro caso
\end */
function oficial_generarPartidasVenta(curFactura, idAsiento, valoresDefecto)
{
	var _i = this.iface;
	var ctaVentas = _i.datosCtaVentas(valoresDefecto.codejercicio, curFactura.valueBuffer("codserie"));
	if (ctaVentas.error != 0) {
		sys.warnMsgBox(sys.translate("No se ha encontrado una subcuenta de ventas para esta factura."));
		return false;
	}
	var haber = 0;
	var haberME = 0;
	var monedaSistema = (valoresDefecto.coddivisa == curFactura.valueBuffer("coddivisa"));
	if (monedaSistema) {
		haber = _i.netoVentasFacturaCli(curFactura);
		haberME = 0;
	} else {
		haber = parseFloat(AQUtil.sqlSelect("co_partidas", "SUM(debe - haber)", "idasiento = " + idAsiento));
		haberME = _i.netoVentasFacturaCli(curFactura);
	}
	haber = AQUtil.roundFieldValue(haber, "co_partidas", "haber");
	haberME = AQUtil.roundFieldValue(haberME, "co_partidas", "haberme");

	var curPartida = new FLSqlCursor("co_partidas");
	with (curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		setValueBuffer("idsubcuenta", ctaVentas.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaVentas.codsubcuenta);
		setValueBuffer("idasiento", idAsiento);
		setValueBuffer("debe", 0);
		setValueBuffer("haber", haber);
		setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
		setValueBuffer("tasaconv", curFactura.valueBuffer("tasaconv"));
		setValueBuffer("debeME", 0);
		setValueBuffer("haberME", haberME);
	}

	_i.datosPartidaFactura(curPartida, curFactura, "cliente")

	if (!curPartida.commitBuffer())
		return false;
	return true;
}

function oficial_netoVentasFacturaCli(curFactura)
{
	return parseFloat(curFactura.valueBuffer("neto"));
}
function oficial_netoComprasFacturaProv(curFactura)
{
	return parseFloat(curFactura.valueBuffer("neto"));
}

/** \D Genera la parte del asiento de factura correspondiente a la subcuenta de IVA y de recargo de equivalencia, si la factura lo tiene
@param	curFactura: Cursor de la factura
@param	idAsiento: Id del asiento asociado
@param	valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@param	ctaCliente: Array con los datos de la contrapartida
@return	VERDADERO si no hay error, FALSO en otro caso
\end */
function oficial_generarPartidasIVACli(curFactura, idAsiento, valoresDefecto, ctaCliente)
{
	var _i = this.iface;
	var haber = 0;
	var haberME = 0;
	var baseImponible = 0;
	var recargo;
	var iva;

	var regimenIVA = _i.regimenIVACliente(curFactura);
	if (!regimenIVA) {
		sys.warnMsgBox(sys.translate("Error al obtener el régimen de IVA asociado a la factura %1.\nCompruebe que el cliente tiene un régimen de IVA establecido").arg(curFactura.valueBuffer("codigo")));
		return false;
	}

	var monedaSistema = (valoresDefecto.coddivisa == curFactura.valueBuffer("coddivisa"));
	var qryIva = new FLSqlQuery();
	qryIva.setTablesList("lineasivafactcli");
	qryIva.setSelect("neto, iva, totaliva, recargo, totalrecargo, codimpuesto");
	qryIva.setFrom("lineasivafactcli");
	qryIva.setWhere("idfactura = " + curFactura.valueBuffer("idfactura"));
	try { qryIva.setForwardOnly( true ); } catch (e) {}
	if (!qryIva.exec())
		return false;

	while (qryIva.next()) {
		iva = parseFloat(qryIva.value("iva"));
		if (isNaN(iva)) {
			iva = 0;
		}
		recargo = parseFloat(qryIva.value("recargo"));
		if (isNaN(recargo)) {
			recargo = 0;
		}
		if (monedaSistema) {
			haber = parseFloat(qryIva.value(2));
			haberME = 0;
			baseImponible = parseFloat(qryIva.value(0));
		} else {
			haber = parseFloat(qryIva.value(2)) * parseFloat(curFactura.valueBuffer("tasaconv"));
			haberME = parseFloat(qryIva.value(2));
			baseImponible = parseFloat(qryIva.value(0))  * parseFloat(curFactura.valueBuffer("tasaconv"));
		}
		haber = AQUtil.roundFieldValue(haber, "co_partidas", "haber");
		haberME = AQUtil.roundFieldValue(haberME, "co_partidas", "haberme");
		baseImponible = AQUtil.roundFieldValue(baseImponible, "co_partidas", "baseimponible");

		var ctaIvaRep:Array;
		var textoError;
		switch (regimenIVA) {
			case "U.E.": {
				ctaIvaRep = _i.datosCtaIVA("IVAEUE", valoresDefecto.codejercicio,qryIva.value(5));
				textoError = sys.translate("I.V.A. entregas intracomunitarias (IVAEUE)");
				break;
			}
			case "Exento": {
				ctaIvaRep = _i.datosCtaIVA("IVAREX", valoresDefecto.codejercicio, qryIva.value(5));
				textoError = sys.translate("I.V.A. repercutido exento (IVAREX)");
				break;
			}
			case "Exportaciones": {
				ctaIvaRep = _i.datosCtaIVA("IVARXP", valoresDefecto.codejercicio, qryIva.value(5));
				textoError = sys.translate("I.V.A. repercutido exportaciones (IVARXP)");
				break;
			}
			default: {
				ctaIvaRep = _i.datosCtaIVA("IVAREP", valoresDefecto.codejercicio, qryIva.value(5));
				textoError = sys.translate("I.V.A. repercutido R. General(IVAREP)");
			}
		}
		if (ctaIvaRep.error != 0) {
			sys.infoMsgBox(sys.translate("La cuenta especial de %1 no tiene asignada subcuenta.\nDebe asociarla en el módulo Principal del área Financiera").arg(textoError));
			return false;
		}

		var curPartida = new FLSqlCursor("co_partidas");
		with (curPartida) {
			setModeAccess(curPartida.Insert);
			refreshBuffer();
			setValueBuffer("idsubcuenta", ctaIvaRep.idsubcuenta);
			setValueBuffer("codsubcuenta", ctaIvaRep.codsubcuenta);
			setValueBuffer("idasiento", idAsiento);
			setValueBuffer("debe", 0);
			setValueBuffer("haber", haber);
			setValueBuffer("baseimponible", baseImponible);
			setValueBuffer("iva", iva);
			setValueBuffer("recargo", recargo);
			setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
			setValueBuffer("tasaconv", curFactura.valueBuffer("tasaconv"));
			setValueBuffer("idcontrapartida", ctaCliente.idsubcuenta);
			setValueBuffer("codcontrapartida", ctaCliente.codsubcuenta);
			setValueBuffer("debeME", 0);
			setValueBuffer("haberME", haberME);
			setValueBuffer("codserie", curFactura.valueBuffer("codserie"));
			setValueBuffer("cifnif", curFactura.valueBuffer("cifnif"));
		}

		_i.datosPartidaFactura(curPartida, curFactura, "cliente")

		if (!curPartida.commitBuffer())
			return false;

		if (monedaSistema) {
			haber = parseFloat(qryIva.value(4));
			haberME = 0;
		} else {
			haber = parseFloat(qryIva.value(4)) * parseFloat(curFactura.valueBuffer("tasaconv"));
			haberME = parseFloat(qryIva.value(4));
		}
		haber = AQUtil.roundFieldValue(haber, "co_partidas", "haber");
		haberME = AQUtil.roundFieldValue(haberME, "co_partidas", "haberme");

		if (parseFloat(haber) != 0) {
			var ctaRecargo = _i.datosCtaIVA("IVARRE", valoresDefecto.codejercicio, qryIva.value(5));
			if (ctaRecargo.error != 0) {
				sys.warnMsgBox(sys.translate("No tiene definida cuál es la subcuenta  asociada al recargo de equivalencia en ventas.\nPara definirla vaya a Facturación->Principal->Impuestos e indíquela en el/los impuestos correspondientes"));
				return false;
			}
			var curPartida = new FLSqlCursor("co_partidas");
			with (curPartida) {
				setModeAccess(curPartida.Insert);
				refreshBuffer();
				setValueBuffer("idsubcuenta", ctaRecargo.idsubcuenta);
				setValueBuffer("codsubcuenta", ctaRecargo.codsubcuenta);
				setValueBuffer("idasiento", idAsiento);
				setValueBuffer("debe", 0);
				setValueBuffer("haber", haber);
				setValueBuffer("baseimponible", baseImponible);
				setValueBuffer("iva", iva);
				setValueBuffer("recargo", recargo);
				setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
				setValueBuffer("tasaconv", curFactura.valueBuffer("tasaconv"));
				setValueBuffer("idcontrapartida", ctaCliente.idsubcuenta);
				setValueBuffer("codcontrapartida", ctaCliente.codsubcuenta);
				setValueBuffer("debeME", 0);
				setValueBuffer("haberME", haberME);
				setValueBuffer("codserie", curFactura.valueBuffer("codserie"));
				setValueBuffer("cifnif", curFactura.valueBuffer("cifnif"));
			}

			_i.datosPartidaFactura(curPartida, curFactura, "cliente")

			if (!curPartida.commitBuffer())
				return false;
		}
	}
	return true;
}

/** \D Obtiene el régimen de IVA asociado a una factura de cliente
@param	curFactura: Factura
@return	Régimen de IVA
\end */
function oficial_regimenIVACliente(curDocCliente,cx)
{
	var _i = this.iface;

	if(!cx || cx == "")
		cx = "default";

	var regimen;
	var codCliente = curDocCliente.valueBuffer("codcliente");
	if (codCliente && codCliente != "") {
		regimen = AQUtil.sqlSelect("clientes", "regimeniva", "codcliente = '" + codCliente + "'","clientes",cx);
	} else {
		regimen = "General";
	}
	return regimen;
}

/** \D Genera la parte del asiento de factura correspondiente a la subcuenta de IRPF, si la factura lo tiene
@param	curFactura: Cursor de la factura
@param	idAsiento: Id del asiento asociado
@param	valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@return	VERDADERO si no hay error, FALSO en otro caso
\end */
function oficial_generarPartidasIRPF(curFactura, idAsiento, valoresDefecto)
{
		var _i = this.iface;
		var irpf = parseFloat(curFactura.valueBuffer("totalirpf"));
		if (irpf == 0)
				return true;
		var debe = 0;
		var debeME = 0;
		var ctaIrpf = _i.datosCtaEspecial("IRPF", valoresDefecto.codejercicio);
		if (ctaIrpf.error != 0) {
			sys.warnMsgBox(sys.translate("No tiene ninguna cuenta contable marcada como cuenta especial\nIRPF (IRPF para clientes).\nDebe asociar la cuenta a la cuenta especial en el módulo Principal del área Financiera"));
			return false;
		}

		var monedaSistema = (valoresDefecto.coddivisa == curFactura.valueBuffer("coddivisa"));
		if (monedaSistema) {
				debe = irpf;
				debeME = 0;
		} else {
				debe = irpf * parseFloat(curFactura.valueBuffer("tasaconv"));
				debeME = irpf;
		}
		debe = AQUtil.roundFieldValue(debe, "co_partidas", "debe");
		debeME = AQUtil.roundFieldValue(debeME, "co_partidas", "debeme");

		var curPartida = new FLSqlCursor("co_partidas");
		with (curPartida) {
				setModeAccess(curPartida.Insert);
				refreshBuffer();
				setValueBuffer("idsubcuenta", ctaIrpf.idsubcuenta);
				setValueBuffer("codsubcuenta", ctaIrpf.codsubcuenta);
				setValueBuffer("idasiento", idAsiento);
				setValueBuffer("debe", debe);
				setValueBuffer("haber", 0);
				setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
				setValueBuffer("tasaconv", curFactura.valueBuffer("tasaconv"));
				setValueBuffer("debeME", debeME);
				setValueBuffer("haberME", 0);
		}

		_i.datosPartidaFactura(curPartida, curFactura, "cliente")

		if (!curPartida.commitBuffer())
				return false;

		return true;
}

/** \D Genera la parte del asiento de factura correspondiente a la subcuenta de recargo financiero para clientes, si la factura lo tiene
@param	curFactura: Cursor de la factura
@param	idAsiento: Id del asiento asociado
@param	valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@return	VERDADERO si no hay error, FALSO en otro caso
\end */
function oficial_generarPartidasRecFinCli(curFactura, idAsiento, valoresDefecto)
{
	var _i = this.iface;
	var recFinanciero = parseFloat(curFactura.valueBuffer("recfinanciero") * curFactura.valueBuffer("neto") / 100);
	if (!recFinanciero)
		return true;
	var haber = 0;
	var haberME = 0;

	var ctaRecfin = [];
	ctaRecfin = _i.datosCtaEspecial("INGRF", valoresDefecto.codejercicio);
	if (ctaRecfin.error != 0) {
		sys.warnMsgBox(sys.translate("No tiene ninguna cuenta contable marcada como cuenta especial\nINGRF (recargo financiero en ingresos) \nDebe asociar una cuenta contable a esta cuenta especial en el módulo Principal del área Financiera"));
		return false;
	}

	var monedaSistema = (valoresDefecto.coddivisa == curFactura.valueBuffer("coddivisa"));
	if (monedaSistema) {
		haber = recFinanciero;
		haberME = 0;
	} else {
		haber = recFinanciero * parseFloat(curFactura.valueBuffer("tasaconv"));
		haberME = recFinanciero;
	}
	haber = AQUtil.roundFieldValue(haber, "co_partidas", "haber");
	haberME = AQUtil.roundFieldValue(haberME, "co_partidas", "haberme");

	var curPartida = new FLSqlCursor("co_partidas");
	with (curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		setValueBuffer("idsubcuenta", ctaRecfin.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaRecfin.codsubcuenta);
		setValueBuffer("idasiento", idAsiento);
		setValueBuffer("haber", haber);
		setValueBuffer("debe", 0);
		setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
		setValueBuffer("tasaconv", curFactura.valueBuffer("tasaconv"));
		setValueBuffer("haberME", haberME);
		setValueBuffer("debeME", 0);
	}

	_i.datosPartidaFactura(curPartida, curFactura, "cliente")

	if (!curPartida.commitBuffer())
			return false;

	return true;
}

/** \D Genera la parte del asiento de factura correspondiente a la subcuenta de IRPF para proveedores, si la factura lo tiene
@param	curFactura: Cursor de la factura
@param	idAsiento: Id del asiento asociado
@param	valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@return	VERDADERO si no hay error, FALSO en otro caso
\end */
function oficial_generarPartidasIRPFProv(curFactura, idAsiento, valoresDefecto)
{
	var _i = this.iface;
	var irpf = parseFloat(curFactura.valueBuffer("totalirpf"));
	if (irpf == 0)
			return true;
	var haber = 0;
	var haberME = 0;

	var ctaIrpf = [];
	ctaIrpf.codsubcuenta = AQUtil.sqlSelect("lineasfacturasprov lf INNER JOIN articulos a ON lf.referencia = a.referencia", "a.codsubcuentairpfcom", "lf.idfactura = " + curFactura.valueBuffer("idfactura") + " AND a.codsubcuentairpfcom IS NOT NULL", "lineasfacturasprov,articulos");
	if (ctaIrpf.codsubcuenta) {
		var hayDistintasSubcuentas = AQUtil.sqlSelect("lineasfacturasprov lf INNER JOIN articulos a ON lf.referencia = a.referencia", "a.referencia", "lf.idfactura = " + curFactura.valueBuffer("idfactura") + " AND (a.codsubcuentairpfcom <> '" + ctaIrpf.codsubcuenta + "' OR a.codsubcuentairpfcom  IS NULL)", "lineasfacturasprov,articulos");
		if (hayDistintasSubcuentas) {
			sys.warnMsgBox(sys.translate("No es posible generar el asiento contable de una factura que tiene artículos asignados a distintas subcuentas de IRPF.\nDebe corregir la asociación de las subcuentas de IRPF a los artículos o bien crear distintas facturas para cada subcuenta."));
			return false;
		}
		ctaIrpf.idsubcuenta = AQUtil.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + ctaIrpf.codsubcuenta + "' AND codejercicio = '" + valoresDefecto.codejercicio + "'");
		if (!ctaIrpf.idsubcuenta) {
			sys.warnMsgBox(sys.translate("No existe la subcuenta de IRPF %1 para el ejercicio %2.\nAntes de generar el asiento debe crear esta subcuenta.").arg(ctaIrpf.codsubcuenta).arg(valoresDefecto.codejercicio));
			return false;
		}
	} else {
		ctaIrpf = _i.datosCtaEspecial("IRPFPR", valoresDefecto.codejercicio);
		if (ctaIrpf.error != 0) {
			sys.warnMsgBox(sys.translate("No tiene ninguna cuenta contable marcada como cuenta especial\nIRPFPR (IRPF para proveedores / acreedores).\nDebe asociar la cuenta a la cuenta especial en el módulo Principal del área Financiera"));
			return false;
		}
	}

	var monedaSistema = (valoresDefecto.coddivisa == curFactura.valueBuffer("coddivisa"));
	if (monedaSistema) {
		haber = irpf;
		haberME = 0;
	} else {
		haber = irpf * parseFloat(curFactura.valueBuffer("tasaconv"));
		haberME = irpf;
	}
	haber = AQUtil.roundFieldValue(haber, "co_partidas", "haber");
	haberME = AQUtil.roundFieldValue(haberME, "co_partidas", "haberme");

	var curPartida = new FLSqlCursor("co_partidas");
	with (curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		setValueBuffer("idsubcuenta", ctaIrpf.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaIrpf.codsubcuenta);
		setValueBuffer("idasiento", idAsiento);
		setValueBuffer("debe", 0);
		setValueBuffer("haber", haber);
		setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
		setValueBuffer("tasaconv", curFactura.valueBuffer("tasaconv"));
		setValueBuffer("debeME", 0);
		setValueBuffer("haberME", haberME);
	}

	_i.datosPartidaFactura(curPartida, curFactura, "proveedor")

	if (!curPartida.commitBuffer())
			return false;

	return true;
}


/** \D Genera la parte del asiento de factura correspondiente a la subcuenta de clientes
@param	curFactura: Cursor de la factura
@param	idAsiento: Id del asiento asociado
@param	valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@param	ctaCliente: Datos de la subcuenta del cliente asociado a la factura
@return	VERDADERO si no hay error, FALSO en otro caso
\end */
function oficial_generarPartidasCliente(curFactura, idAsiento, valoresDefecto, ctaCliente)
{
		var _i = this.iface;
		var debe = 0;
		var debeME = 0;
		var monedaSistema = (valoresDefecto.coddivisa == curFactura.valueBuffer("coddivisa"));
		if (monedaSistema) {
				debe = parseFloat(curFactura.valueBuffer("total"));
				debeME = 0;
		} else {
				debe = parseFloat(curFactura.valueBuffer("total")) * parseFloat(curFactura.valueBuffer("tasaconv"));
				debeME = parseFloat(curFactura.valueBuffer("total"));
		}
		debe = AQUtil.roundFieldValue(debe, "co_partidas", "debe");
		debeME = AQUtil.roundFieldValue(debeME, "co_partidas", "debeme");

		var curPartida = new FLSqlCursor("co_partidas");

		with (curPartida) {
				setModeAccess(curPartida.Insert);
				refreshBuffer();
				setValueBuffer("idsubcuenta", ctaCliente.idsubcuenta);
				setValueBuffer("codsubcuenta", ctaCliente.codsubcuenta);
				setValueBuffer("idasiento", idAsiento);
				setValueBuffer("debe", debe);
				setValueBuffer("haber", 0);
				setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
				setValueBuffer("tasaconv", curFactura.valueBuffer("tasaconv"));
				setValueBuffer("debeME", debeME);
				setValueBuffer("haberME", 0);
		}

		_i.datosPartidaFactura(curPartida, curFactura, "cliente")

		if (!curPartida.commitBuffer())
				return false;

		return true;
}

/** \D Genera o regenera el registro en la tabla de asientos correspondiente a la factura. Si el asiento ya estaba creado borra sus partidas asociadas.
@param	curFactura: Cursor posicionado en el registro de factura
@param	valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@return	array con los siguientes datos:
asiento.idasiento: Id del asiento
asiento.numero: numero del asiento
asiento.fecha: fecha del asiento
asiento.error: indicador booleano de que ha habido un error en la función
\end */
function oficial_regenerarAsiento(cur, valoresDefecto)
{
	var _i = this.iface;
	var asiento = [];
	var campoAsiento = "campoasiento" in valoresDefecto ? valoresDefecto["campoasiento"] : "idasiento";
	var campoFecha = "campofecha" in valoresDefecto ? valoresDefecto["campofecha"] : "fecha";
	var idAsiento = cur.valueBuffer(campoAsiento);
	if (cur.isNull("idasiento")) {

		var datosAsiento = _i.datosConceptoAsiento(cur);

		if (!_i.curAsiento_) {
			_i.curAsiento_ = new FLSqlCursor("co_asientos");
		}
		_i.curAsiento_.setModeAccess(_i.curAsiento_.Insert);
		_i.curAsiento_.refreshBuffer();
		_i.curAsiento_.setValueBuffer("numero", 0);
		_i.curAsiento_.setValueBuffer("fecha", cur.valueBuffer(campoFecha));
		_i.curAsiento_.setValueBuffer("codejercicio", valoresDefecto.codejercicio);
		_i.curAsiento_.setValueBuffer("concepto", datosAsiento.concepto);
		_i.curAsiento_.setValueBuffer("tipodocumento", datosAsiento.tipoDocumento);
		_i.curAsiento_.setValueBuffer("documento", datosAsiento.documento);
		if (!_i.datosAsientoRegenerado(cur, valoresDefecto)) {
			asiento.error = true;
			return asiento;
		}

		if (!_i.curAsiento_.commitBuffer()) {
			asiento.error = true;
			return asiento;
		}
		asiento.idasiento = _i.curAsiento_.valueBuffer("idasiento");
		asiento.numero = _i.curAsiento_.valueBuffer("numero");
		asiento.fecha = _i.curAsiento_.valueBuffer("fecha");
		asiento.concepto = _i.curAsiento_.valueBuffer("concepto");
		asiento.tipodocumento = _i.curAsiento_.valueBuffer("tipodocumento");
		asiento.documento = _i.curAsiento_.valueBuffer("documento");

		_i.curAsiento_.select("idasiento = " + asiento.idasiento);
		_i.curAsiento_.first();
		_i.curAsiento_.setUnLock("editable", false);
	} else {
		var datosAsiento = _i.datosConceptoAsiento(cur);

		if (!_i.asientoBorrable(idAsiento)) {
			asiento.error = true;
			return asiento;
		}

		if (!_i.curAsiento_) {
			_i.curAsiento_ = new FLSqlCursor("co_asientos");
		}
		_i.curAsiento_.select("idasiento = " + idAsiento);
		if (!_i.curAsiento_.first()) {
			asiento.error = true;
			return asiento;
		}
		_i.curAsiento_.setUnLock("editable", true);

		_i.curAsiento_.select("idasiento = " + idAsiento);
		if (!_i.curAsiento_.first()) {
			asiento.error = true;
			return asiento;
		}
		_i.curAsiento_.setModeAccess(_i.curAsiento_.Edit);
		_i.curAsiento_.refreshBuffer();
		_i.curAsiento_.setValueBuffer("fecha", cur.valueBuffer(campoFecha));
		_i.curAsiento_.setValueBuffer("concepto", datosAsiento.concepto);
		_i.curAsiento_.setValueBuffer("tipodocumento", datosAsiento.tipoDocumento);
		_i.curAsiento_.setValueBuffer("documento", datosAsiento.documento);
		if (!_i.datosAsientoRegenerado(cur, valoresDefecto)) {
			asiento.error = true;
			return asiento;
		}
		if (!_i.curAsiento_.commitBuffer()) {
			asiento.error = true;
			return asiento;
		}
		_i.curAsiento_.select("idasiento = " + idAsiento);
		if (!_i.curAsiento_.first()) {
			asiento.error = true;
			return asiento;
		}
		_i.curAsiento_.setUnLock("editable", false);

		asiento = flfactppal.iface.pub_ejecutarQry("co_asientos", "idasiento,numero,fecha,codejercicio,concepto,tipodocumento,documento", "idasiento = '" + idAsiento + "'");
		if (asiento.codejercicio != valoresDefecto.codejercicio) {
			sys.warnMsgBox(sys.translate("Está intentando regenerar un asiento del ejercicio %1 en el ejercicio %2.\nVerifique que su ejercicio actual es correcto. Si lo es y está actualizando un pago, bórrelo y vuélvalo a crear.").arg(asiento.codejercicio).arg(valoresDefecto.codejercicio));
			asiento.error = true;
			return asiento;
		}
		var curPartidas = new FLSqlCursor("co_partidas");
		curPartidas.select("idasiento = " + idAsiento);
		var idP = 0;
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

function oficial_datosAsientoRegenerado(cur, valoresDefecto)
{
	return true;
}

function oficial_datosConceptoAsiento(cur)
{
	var _i = this.iface;
	var datosAsiento = [];

	switch (cur.table()) {
		case "facturascli": {
			datosAsiento.concepto = "Nuestra factura " + cur.valueBuffer("codigo") + " - " + cur.valueBuffer("nombrecliente");
			datosAsiento.documento = cur.valueBuffer("codigo");
			datosAsiento.tipoDocumento = "Factura de cliente";
			break;
		}
		case "facturasprov": {
			var numProveedor = cur.valueBuffer("numproveedor");
			if (numProveedor && numProveedor != "") {
				numProveedor = numProveedor + " / ";
			}
			datosAsiento.concepto = "Su factura " + numProveedor + cur.valueBuffer("codigo") + " - " + cur.valueBuffer("nombre");
			datosAsiento.documento = cur.valueBuffer("codigo");
			datosAsiento.tipoDocumento = "Factura de proveedor";
			break;
		}
		case "pagosdevolcli": {
			var codRecibo = AQUtil.sqlSelect("reciboscli", "codigo", "idrecibo = " + cur.valueBuffer("idrecibo"));
			var nombreCli = AQUtil.sqlSelect("reciboscli", "nombrecliente", "idrecibo = " + cur.valueBuffer("idrecibo"));

			switch (cur.valueBuffer("tipo")) {
				case "Pago": {
					datosAsiento.concepto = sys.translate("Pago recibo %1 - %2").arg(codRecibo).arg(nombreCli);
					break;
				}
				case "Remesado": {
					datosAsiento.concepto = sys.translate("Remesa recibo %1 - %2").arg(codRecibo).arg(nombreCli);
					break;
				}
				case "Devolución": {
					datosAsiento.concepto = sys.translate("Devolución recibo %1 - %2").arg(codRecibo).arg(nombreCli);
					break;
				}
				default: {
					datosAsiento.concepto = "";
				}
			}
			datosAsiento.tipoDocumento = sys.translate("Recibo");
			datosAsiento.documento = codRecibo;
			break;
		}
		case "pagosdevolrem": {
			if (cur.valueBuffer("tipo") == "Pago")
				datosAsiento.concepto = cur.valueBuffer("tipo") + " " + "remesa" + " " + cur.valueBuffer("idremesa");
				datosAsiento.tipoDocumento = "";
				datosAsiento.documento = "";
			break;
		}
		case "co_dotaciones": {
			datosAsiento.concepto = "Dotación de " + AQUtil.sqlSelect("co_amortizaciones","elemento","codamortizacion = '" + cur.valueBuffer("codamortizacion") + "'") + " - " + AQUtil.dateAMDtoDMA(cur.valueBuffer("fecha"));
			datosAsiento.documento = "";
			datosAsiento.tipoDocumento = "";
			break;
		}
		case "co_amortizaciones": {
			datosAsiento.concepto = sys.translate("Cierre amortización %1 - %2").arg(cur.valueBuffer("codamortizacion")).arg(cur.valueBuffer("elemento"));
			datosAsiento.documento = "";
			datosAsiento.tipoDocumento = "";
			break;
		}
		case "tpv_pagoscomanda": {
			var venta = AQUtil.sqlSelect("tpv_comandas","codigo","idtpv_comanda = '" + cur.valueBuffer("idtpv_comanda") + "'");
			var tipoDoc = AQUtil.sqlSelect("tpv_comandas","tipodoc","codigo = '" + venta + "'");
			switch(tipoDoc){
				case "DEVOLUCION":{
					datosAsiento.concepto = "Pago devolución " + venta + " en TPV ";
					datosAsiento.documento = "";
					datosAsiento.tipoDocumento = ""/** Hay que añadir el string a "tipodocumento" de la tabla "co_asientos"(módulo de contabilidad)*/;
					break;
				}
				default:{
					datosAsiento.concepto = "Pago anticipo reserva " + venta + " en TPV ";
					datosAsiento.documento = "";
					datosAsiento.tipoDocumento = "Pago a cuenta"/** Hay que añadir el string a "tipodocumento" de la tabla "co_asientos"(módulo de contabilidad)*/;
					break;
				}
			}
			break;
		}
		default:
			datosAsiento.concepto = "";
			datosAsiento.documento = "";
			datosAsiento.tipoDocumento = "";
	}
	return datosAsiento;
}

function oficial_eliminarAsiento(idAsiento)
{
	var _i = this.iface;
	if (!idAsiento || idAsiento == "")
		return true;

	if (!_i.asientoBorrable(idAsiento))
		return false;

	var curAsiento = new FLSqlCursor("co_asientos");
	curAsiento.select("idasiento = " + idAsiento);
	if (!curAsiento.first())
		return false;

	curAsiento.setUnLock("editable", true);
	if (!AQUtil.sqlDelete("co_asientos", "idasiento = " + idAsiento)) {
		curAsiento.setValueBuffer("idasiento", idAsiento);
		return false;
	}
	return true;
}

/** \U Genera o regenera el asiento correspondiente a una factura de proveedor
@param	curFactura: Cursor con los datos de la factura
@return	VERDADERO si no hay error. FALSO en otro caso
\end */
/** \C El concepto de los asientos de factura de proveedor será 'Su factura ' + número de proveedor asociado a la factura. Si el número de proveedor no se especifica, el concepto será 'Su factura ' + código de factura.
\end */
function oficial_generarAsientoFacturaProv(curFactura)
{
	var _i = this.iface;

	if (curFactura.modeAccess() != curFactura.Insert && curFactura.modeAccess() != curFactura.Edit)
		return true;

	if (curFactura.valueBuffer("nogenerarasiento")) {
		curFactura.setNull("idasiento");
		return true;
	}

	if (!_i.comprobarRegularizacion(curFactura))
		return false;

	var _i = this.iface;
	var datosAsiento = [];
	var valoresDefecto = [];
	valoresDefecto["codejercicio"] = curFactura.valueBuffer("codejercicio");
	valoresDefecto["coddivisa"] = flfactppal.iface.pub_valorDefectoEmpresa("coddivisa");

	var curTransaccion = new FLSqlCursor("facturascli");
	curTransaccion.transaction(false);
	try {
		datosAsiento = _i.regenerarAsiento(curFactura, valoresDefecto);
		if (datosAsiento.error == true) {
			throw sys.translate("Error al regenerar el asiento");
		}

		var numProveedor = curFactura.valueBuffer("numproveedor");
		var concepto = "";
		if (!numProveedor || numProveedor == "") {
			concepto = sys.translate("Su factura ") + curFactura.valueBuffer("codigo");
		} else {
			concepto = sys.translate("Su factura ") + numProveedor;
		}
		concepto += " - " + curFactura.valueBuffer("nombre");

		var ctaProveedor = _i.datosCtaProveedor(curFactura, valoresDefecto);
		if (ctaProveedor.error != 0) {
			throw sys.translate("Error al obtener la subcuenta del proveedor");
		}

		// Las partidas generadas dependen del régimen de IVA del proveedor
		var regimenIVA = AQUtil.sqlSelect("proveedores", "regimeniva", "codproveedor = '" + curFactura.valueBuffer("codproveedor") + "'");

		switch(regimenIVA) {
			case "UE": {
				if (!_i.generarPartidasProveedor(curFactura, datosAsiento.idasiento, valoresDefecto, ctaProveedor, concepto, true)) {
					throw sys.translate("Error al generar la partida de proveedor");
				}
				if (!_i.generarPartidasIRPFProv(curFactura, datosAsiento.idasiento, valoresDefecto)) {
					throw sys.translate("Error al generar la partida de IRPF");
				}
				if (!_i.generarPartidasRecFinProv(curFactura, datosAsiento.idasiento, valoresDefecto)) {
					throw sys.translate("Error al generar la partida recargo financiero");
				}
				if (!_i.generarPartidasIVAProv(curFactura, datosAsiento.idasiento, valoresDefecto, ctaProveedor, concepto)) {
					throw sys.translate("Error al generar la partida de IVA");
				}
				if (!_i.generarPartidasCompra(curFactura, datosAsiento.idasiento, valoresDefecto, concepto)) {
					throw sys.translate("Error al generar la partida de compras");
				}
				break;
			}
			case "Exento": {
				if (!_i.generarPartidasProveedor(curFactura, datosAsiento.idasiento, valoresDefecto, ctaProveedor, concepto, true)) {
					throw sys.translate("Error al generar la partida de proveedor");
				}
				if (!_i.generarPartidasRecFinProv(curFactura, datosAsiento.idasiento, valoresDefecto)) {
					throw sys.translate("Error al generar la partida de recargo financiero");
				}
				if (!_i.generarPartidasIRPFProv(curFactura, datosAsiento.idasiento, valoresDefecto)) {
					throw sys.translate("Error al generar la partida de IRPF");
				}
				if (!_i.generarPartidasIVAProv(curFactura, datosAsiento.idasiento, valoresDefecto, ctaProveedor, concepto)) {
					throw sys.translate("Error al generar la partida de IVA");
				}
				if (!_i.generarPartidasCompra(curFactura, datosAsiento.idasiento, valoresDefecto, concepto)) {
					throw sys.translate("Error al generar la partida de compras");
				}
				break;
			}
			default: {
				if (!_i.generarPartidasProveedor(curFactura, datosAsiento.idasiento, valoresDefecto, ctaProveedor, concepto)) {
					throw sys.translate("Error al generar la partida de proveedor");
				}
				if (!_i.generarPartidasIRPFProv(curFactura, datosAsiento.idasiento, valoresDefecto)) {
					throw sys.translate("Error al generar la partida de IRPF");
				}
				if (!_i.generarPartidasRecFinProv(curFactura, datosAsiento.idasiento, valoresDefecto)) {
					throw sys.translate("Error al generar la partida de recargo financiero");
				}
				if (!_i.generarPartidasIVAProv(curFactura, datosAsiento.idasiento, valoresDefecto, ctaProveedor, concepto)) {
					throw sys.translate("Error al generar la partida de IVA");
				}
				if (!_i.generarPartidasCompra(curFactura, datosAsiento.idasiento, valoresDefecto, concepto)) {
					throw sys.translate("Error al generar la partida de compra");
				}
			}
		}

		curFactura.setValueBuffer("idasiento", datosAsiento.idasiento);
		if (curFactura.valueBuffer("deabono") == true) {
			if (!_i.asientoFacturaAbonoProv(curFactura, valoresDefecto)) {
				throw sys.translate("Error al modificar el asiento de abono");
			}
		}

		if (!flcontppal.iface.pub_comprobarAsiento(datosAsiento.idasiento)) {
			throw sys.translate("Error al comprobar el asiento");
		}
	} catch (e) {
		curTransaccion.rollback();
		sys.warnMsgBox(sys.translate("Error al generar el asiento correspondiente a la factura %1:").arg(curFactura.valueBuffer("codigo")) + "\n" + e);
		return false;
	}
	curTransaccion.commit();

	return true;
}

/** \D Genera la parte del asiento de factura de proveedor correspondiente a la subcuenta de compras
@param	curFactura: Cursor de la factura
@param	idAsiento: Id del asiento asociado
@param	valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@param	concepto: Concepto de la partida
@return	VERDADERO si no hay error, FALSO en otro caso
\end */
function oficial_generarPartidasCompra(curFactura, idAsiento, valoresDefecto, concepto)
{
	var _i = this.iface;

	var ctaCompras = [];
	var monedaSistema = (valoresDefecto.coddivisa == curFactura.valueBuffer("coddivisa"));
	var debe = 0;
	var debeME = 0;
	var idUltimaPartida = 0;

	/** \C En el asiento correspondiente a las facturas de proveedor, se generarán tantas partidas de compra como subcuentas distintas existan en las líneas de factura
	\end */
	var qrySubcuentas = new FLSqlQuery();
	with (qrySubcuentas) {
		setTablesList("lineasfacturasprov");
		setSelect("codsubcuenta, SUM(pvptotal)");
		setFrom("lineasfacturasprov");
		setWhere("idfactura = " + curFactura.valueBuffer("idfactura") + " GROUP BY codsubcuenta");
	}
	try { qrySubcuentas.setForwardOnly( true ); } catch (e) {}

	if (!qrySubcuentas.exec())
			return false;

	if (qrySubcuentas.size() == 0) { // || curFactura.valueBuffer("deabono")) {
	/// \D Si la factura es de abono se genera una sola partida de compras que luego se convertirá a partida de devolución de compras ** CORREGIDO: No se debe hacer esto puesto que la subcuenta de devolución puede ser distinta para cada tipo de compra. Sólo las subcuentas COMPRA serán pasadas a DEVCOM ** */
		ctaCompras = _i.datosCtaEspecial("COMPRA", valoresDefecto.codejercicio);
		if (ctaCompras.error != 0) {
			sys.warnMsgBox(sys.translate("No existe ninguna subcuenta marcada como cuenta especial de COMPRA para %1").arg(valoresDefecto.codejercicio));
			return false;
		}
		if (monedaSistema) {
			debe = _i.netoComprasFacturaProv(curFactura);
			debeME = 0;
		} else {
			debe = parseFloat(curFactura.valueBuffer("neto")) * parseFloat(curFactura.valueBuffer("tasaconv"));
			debeME = _i.netoComprasFacturaProv(curFactura);
		}
		debe = AQUtil.roundFieldValue(debe, "co_partidas", "debe");
		debeME = AQUtil.roundFieldValue(debeME, "co_partidas", "debeme");

		var curPartida = new FLSqlCursor("co_partidas");
		with (curPartida) {
			setModeAccess(curPartida.Insert);
			refreshBuffer();
			setValueBuffer("idsubcuenta", ctaCompras.idsubcuenta);
			setValueBuffer("codsubcuenta", ctaCompras.codsubcuenta);
			setValueBuffer("idasiento", idAsiento);
			setValueBuffer("debe", debe);
			setValueBuffer("haber", 0);
			setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
			setValueBuffer("tasaconv", curFactura.valueBuffer("tasaconv"));
			setValueBuffer("debeME", debeME);
			setValueBuffer("haberME", 0);
		}

		_i.datosPartidaFactura(curPartida, curFactura, "proveedor", concepto);

		if (!curPartida.commitBuffer())
			return false;
		idUltimaPartida = curPartida.valueBuffer("idpartida");
	} else {
		while (qrySubcuentas.next()) {
			if (qrySubcuentas.value(0) == "" || !qrySubcuentas.value(0)) {
				ctaCompras = _i.datosCtaEspecial("COMPRA", valoresDefecto.codejercicio);
				if (ctaCompras.error != 0)
					return false;
			} else {
				ctaCompras.codsubcuenta = qrySubcuentas.value(0);
				ctaCompras.idsubcuenta = AQUtil.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + qrySubcuentas.value(0) + "' AND codejercicio = '" + valoresDefecto.codejercicio + "'");
				if (!ctaCompras.idsubcuenta) {
					sys.warnMsgBox(sys.translate("No existe la subcuenta ")  + ctaCompras.codsubcuenta + sys.translate(" correspondiente al ejercicio ") + valoresDefecto.codejercicio + sys.translate(".\nPara poder crear la factura debe crear antes esta subcuenta"));
					return false;
				}
			}

			if (monedaSistema) {
				debe = parseFloat(qrySubcuentas.value(1));
				debeME = 0;
			} else {
				debe = parseFloat(qrySubcuentas.value(1)) * parseFloat(curFactura.valueBuffer("tasaconv"));
				debeME = parseFloat(qrySubcuentas.value(1));
			}
			debe = AQUtil.roundFieldValue(debe, "co_partidas", "debe");
			debeME = AQUtil.roundFieldValue(debeME, "co_partidas", "debeme");

			var curPartida = new FLSqlCursor("co_partidas");
			with (curPartida) {
				setModeAccess(curPartida.Insert);
				refreshBuffer();
				setValueBuffer("idsubcuenta", ctaCompras.idsubcuenta);
				setValueBuffer("codsubcuenta", ctaCompras.codsubcuenta);
				setValueBuffer("idasiento", idAsiento);
				setValueBuffer("debe", debe);
				setValueBuffer("haber", 0);
				setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
				setValueBuffer("tasaconv", curFactura.valueBuffer("tasaconv"));
				setValueBuffer("debeME", debeME);
				setValueBuffer("haberME", 0);
			}

			_i.datosPartidaFactura(curPartida, curFactura, "proveedor", concepto);

			if (!curPartida.commitBuffer())
				return false;
			idUltimaPartida = curPartida.valueBuffer("idpartida");
		}
	}

	/** \C En los asientos de factura de proveedor, y en el caso de que se use moneda extranjera, la última partida de compras tiene un saldo tal que haga que el asiento cuadre perfectamente. Esto evita errores de redondeo de conversión de moneda entre las partidas del asiento.
	\end */
	if (!monedaSistema) {
		debe = parseFloat(AQUtil.sqlSelect("co_partidas", "SUM(haber - debe)", "idasiento = " + idAsiento + " AND idpartida <> " + idUltimaPartida));
		if (debe && !isNaN(debe) && debe != 0) {
			debe = parseFloat(AQUtil.roundFieldValue(debe, "co_partidas", "debe"));
			if (!AQUtil.sqlUpdate("co_partidas", "debe", debe, "idpartida = " + idUltimaPartida))
				return false;
		}
	}

	return true;
}

/** \D Genera la parte del asiento de factura de proveedor correspondiente a la subcuenta de IVA y de recargo de equivalencia, si la factura lo tiene
@param	curFactura: Cursor de la factura
@param	idAsiento: Id del asiento asociado
@param	valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@param	ctaProveedor: Array con los datos de la contrapartida
@param	concepto: Concepto de la partida
@return	VERDADERO si no hay error, FALSO en otro caso
\end */
function oficial_generarPartidasIVAProv(curFactura, idAsiento, valoresDefecto, ctaProveedor, concepto)
{
	var _i = this.iface;

	var haber = 0;
	var haberME = 0;
	var baseImponible = 0;
	var monedaSistema = (valoresDefecto.coddivisa == curFactura.valueBuffer("coddivisa"));
	var recargo;
	var iva;

	var regimenIVA = AQUtil.sqlSelect("proveedores","regimeniva","codproveedor = '" + curFactura.valueBuffer("codproveedor") + "'");
	var codCuentaEspIVA;

	var qryIva = new FLSqlQuery();
	qryIva.setTablesList("lineasivafactprov");

	if (regimenIVA == "UE")
		qryIva.setSelect("neto, iva, neto*iva/100, recargo, neto*recargo/100, codimpuesto");
	else
		qryIva.setSelect("neto, iva, totaliva, recargo, totalrecargo, codimpuesto");

	qryIva.setFrom("lineasivafactprov");
	qryIva.setWhere("idfactura = " + curFactura.valueBuffer("idfactura"));
	try { qryIva.setForwardOnly( true ); } catch (e) {}
	if (!qryIva.exec())
		return false;


	while (qryIva.next()) {
		iva = parseFloat(qryIva.value("iva"));
		if (isNaN(iva)) {
			iva = 0;
		}
		recargo = parseFloat(qryIva.value("recargo"));
		if (isNaN(recargo)) {
			recargo = 0;
		}
		if (monedaSistema) {
			debe = parseFloat(qryIva.value(2));
			debeME = 0;
			baseImponible = parseFloat(qryIva.value(0));
		} else {
			debe = parseFloat(qryIva.value(2)) * parseFloat(curFactura.valueBuffer("tasaconv"));
			debeME = parseFloat(qryIva.value(2));
			baseImponible = parseFloat(qryIva.value(0)) * parseFloat(curFactura.valueBuffer("tasaconv"));
		}
		debe = AQUtil.roundFieldValue(debe, "co_partidas", "debe");
		debeME = AQUtil.roundFieldValue(debeME, "co_partidas", "debeme");
		baseImponible = AQUtil.roundFieldValue(baseImponible, "co_partidas", "baseimponible");

		switch(regimenIVA) {
			case "UE": {
				codCuentaEspIVA = "IVASUE";
				if (curFactura.valueBuffer("servicios")) {
					codCuentaEspIVA = "IVASSE";
				} else {
					codCuentaEspIVA = "IVASUE";
				}
				break;
			}
			case "General": {
				codCuentaEspIVA = "IVASOP";
				break;
			}
			case "Exento": {
				codCuentaEspIVA = "IVASEX";
				break;
			}
			case "Importaciones": {
				return true; /// No se introduce partida de IVA en facturas de importación. El IVA se cobra en la factura del transitario
// 				codCuentaEspIVA = "IVASIM";
				break;
			}
			case "Agrario": {
				codCuentaEspIVA = "IVASRA";
				break;
			}
			default: {
				codCuentaEspIVA = "IVASOP";
			}
		}

		var ctaIvaSop = _i.datosCtaIVA(codCuentaEspIVA, valoresDefecto.codejercicio, qryIva.value(5));
		if (ctaIvaSop.error != 0) {
			sys.warnMsgBox(sys.translate("Esta factura pertenece al régimen IVA tipo %1.\nNo existe ninguna cuenta contable marcada como tipo especial %2\n\nDebe asociar una cuenta contable a dicho tipo especial en el módulo Principal del área Financiera").arg(regimenIVA).arg(codCuentaEspIVA));
			return false;
		}
		var curPartida = new FLSqlCursor("co_partidas");
		with (curPartida) {
			setModeAccess(curPartida.Insert);
			refreshBuffer();
			setValueBuffer("idsubcuenta", ctaIvaSop.idsubcuenta);
			setValueBuffer("codsubcuenta", ctaIvaSop.codsubcuenta);
			setValueBuffer("idasiento", idAsiento);
			setValueBuffer("debe", debe);
			setValueBuffer("haber", 0);
			setValueBuffer("baseimponible", baseImponible);
			setValueBuffer("iva", iva);
			setValueBuffer("recargo", recargo);
			setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
			setValueBuffer("tasaconv", curFactura.valueBuffer("tasaconv"));
			setValueBuffer("idcontrapartida", ctaProveedor.idsubcuenta);
			setValueBuffer("codcontrapartida", ctaProveedor.codsubcuenta);
			setValueBuffer("debeME", debeME);
			setValueBuffer("haberME", 0);
			setValueBuffer("codserie", curFactura.valueBuffer("codserie"));
			setValueBuffer("cifnif", curFactura.valueBuffer("cifnif"));
		}

		_i.datosPartidaFactura(curPartida, curFactura, "proveedor")

		if (!curPartida.commitBuffer())
			return false;


		// Otra partida de haber de IVA sobre una cuenta 477 para compensar en UE
		if (regimenIVA == "UE") {

			haber = debe;
			haberME = debeME;
			if (curFactura.valueBuffer("servicios")) {
				codCuentaEspIVA = "IVARSE";
			} else {
				codCuentaEspIVA = "IVARUE";
			}
			var ctaIvaSop = _i.datosCtaIVA(codCuentaEspIVA, valoresDefecto.codejercicio, qryIva.value(5));
			if (ctaIvaSop.error != 0) {
				return false;
			}
			var curPartida = new FLSqlCursor("co_partidas");
			with (curPartida) {
				setModeAccess(curPartida.Insert);
				refreshBuffer();
				setValueBuffer("idsubcuenta", ctaIvaSop.idsubcuenta);
				setValueBuffer("codsubcuenta", ctaIvaSop.codsubcuenta);
				setValueBuffer("idasiento", idAsiento);
				setValueBuffer("debe", 0);
				setValueBuffer("haber", haber);
				setValueBuffer("baseimponible", baseImponible);
				setValueBuffer("iva", iva);
				setValueBuffer("recargo", recargo);
				setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
				setValueBuffer("tasaconv", curFactura.valueBuffer("tasaconv"));
				setValueBuffer("idcontrapartida", ctaProveedor.idsubcuenta);
				setValueBuffer("codcontrapartida", ctaProveedor.codsubcuenta);
				setValueBuffer("debeME", 0);
				setValueBuffer("haberME", haberME);
				setValueBuffer("codserie", curFactura.valueBuffer("codserie"));
				setValueBuffer("cifnif", curFactura.valueBuffer("cifnif"));
			}

			_i.datosPartidaFactura(curPartida, curFactura, "proveedor", concepto)

			if (!curPartida.commitBuffer())
				return false;
		}

		if (monedaSistema) {
			debe = parseFloat(qryIva.value(4));
			debeME = 0;
		} else {
			debe = parseFloat(qryIva.value(4)) * parseFloat(curFactura.valueBuffer("tasaconv"));
			debeME = parseFloat(qryIva.value(4));
		}
		debe = AQUtil.roundFieldValue(debe, "co_partidas", "debe");
		debeME = AQUtil.roundFieldValue(debeME, "co_partidas", "debeme");

		if (parseFloat(debe) != 0) {
			var ctaRecargo = _i.datosCtaIVA("IVADEU", valoresDefecto.codejercicio, qryIva.value(5));
			if (ctaRecargo.error != 0)
				return false;
			var curPartida = new FLSqlCursor("co_partidas");
			with (curPartida) {
				setModeAccess(curPartida.Insert);
				refreshBuffer();
				setValueBuffer("idsubcuenta", ctaRecargo.idsubcuenta);
				setValueBuffer("codsubcuenta", ctaRecargo.codsubcuenta);
				setValueBuffer("idasiento", idAsiento);
				setValueBuffer("debe", debe);
				setValueBuffer("haber", 0);
				setValueBuffer("baseimponible", baseImponible);
				setValueBuffer("iva", iva);
				setValueBuffer("recargo", recargo);
				setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
				setValueBuffer("tasaconv", curFactura.valueBuffer("tasaconv"));
				setValueBuffer("idcontrapartida", ctaProveedor.idsubcuenta);
				setValueBuffer("codcontrapartida", ctaProveedor.codsubcuenta);
				setValueBuffer("debeME", debeME);
				setValueBuffer("haberME", 0);
				setValueBuffer("codserie", curFactura.valueBuffer("codserie"));
				setValueBuffer("cifnif", curFactura.valueBuffer("cifnif"));
			}

			_i.datosPartidaFactura(curPartida, curFactura, "proveedor", concepto)

			if (!curPartida.commitBuffer())
				return false;
		}
	}
	return true;
}

/** \D Genera la parte del asiento de factura correspondiente a la subcuenta de proveedor
@param	curFactura: Cursor de la factura
@param	idAsiento: Id del asiento asociado
@param	valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@param	ctaCliente: Datos de la subcuenta del proveedor asociado a la factura
@param	concepto: Concepto a asociar a la factura
@return	VERDADERO si no hay error, FALSO en otro caso
\end */
function oficial_generarPartidasProveedor(curFactura, idAsiento, valoresDefecto, ctaProveedor, concepto, sinIVA)
{
		var _i = this.iface;

		var haber = 0;
		var haberME = 0;
		var totalIVA = 0;

		if (sinIVA)
			totalIVA = parseFloat(curFactura.valueBuffer("totaliva"));

		var monedaSistema = (valoresDefecto.coddivisa == curFactura.valueBuffer("coddivisa"));
		if (monedaSistema) {
				haber = parseFloat(curFactura.valueBuffer("total"));
				haber -= totalIVA;
				haberME = 0;
		} else {
				haber = (parseFloat(curFactura.valueBuffer("total")) - totalIVA) * parseFloat(curFactura.valueBuffer("tasaconv"));
				haberME = parseFloat(curFactura.valueBuffer("total"));
		}
		haber = AQUtil.roundFieldValue(haber, "co_partidas", "haber");
		haberME = AQUtil.roundFieldValue(haberME, "co_partidas", "haberme");

		var curPartida = new FLSqlCursor("co_partidas");
		with (curPartida) {
				setModeAccess(curPartida.Insert);
				refreshBuffer();
				setValueBuffer("idsubcuenta", ctaProveedor.idsubcuenta);
				setValueBuffer("codsubcuenta", ctaProveedor.codsubcuenta);
				setValueBuffer("idasiento", idAsiento);
				setValueBuffer("debe", 0);
				setValueBuffer("haber", haber);
				setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
				setValueBuffer("tasaconv", curFactura.valueBuffer("tasaconv"));
				setValueBuffer("debeME", 0);
				setValueBuffer("haberME", haberME);
		}

		_i.datosPartidaFactura(curPartida, curFactura, "proveedor", concepto);

		if (!curPartida.commitBuffer())
				return false;
		return true;
}

/** \D Genera la parte del asiento de factura correspondiente a la subcuenta de recargo financiero para proveedores, si la factura lo tiene
@param	curFactura: Cursor de la factura
@param	idAsiento: Id del asiento asociado
@param	valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@return	VERDADERO si no hay error, FALSO en otro caso
\end */
function oficial_generarPartidasRecFinProv(curFactura, idAsiento, valoresDefecto)
{
	var _i = this.iface;

	var recFinanciero = parseFloat(curFactura.valueBuffer("recfinanciero") * curFactura.valueBuffer("neto") / 100);
	if (!recFinanciero)
		return true;
	var debe = 0;
	var debeME = 0;

	var ctaRecfin = [];
	ctaRecfin = _i.datosCtaEspecial("GTORF", valoresDefecto.codejercicio);
	if (ctaRecfin.error != 0) {
		sys.warnMsgBox(sys.translate("No tiene ninguna cuenta contable marcada como cuenta especial\nGTORF (recargo financiero en gastos).\nDebe asociar una cuenta contable a esta cuenta especial en el módulo Principal del área Financiera"));
		return false;
	}

	var monedaSistema = (valoresDefecto.coddivisa == curFactura.valueBuffer("coddivisa"));
	if (monedaSistema) {
		debe = recFinanciero;
		debeME = 0;
	} else {
		debe = recFinanciero * parseFloat(curFactura.valueBuffer("tasaconv"));
		debeME = recFinanciero;
	}
	debe = AQUtil.roundFieldValue(debe, "co_partidas", "debe");
	debeME = AQUtil.roundFieldValue(debeME, "co_partidas", "debeme");

	var curPartida = new FLSqlCursor("co_partidas");
	with (curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		setValueBuffer("idsubcuenta", ctaRecfin.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaRecfin.codsubcuenta);
		setValueBuffer("idasiento", idAsiento);
		setValueBuffer("debe", debe);
		setValueBuffer("haber", 0);
		setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
		setValueBuffer("tasaconv", curFactura.valueBuffer("tasaconv"));
		setValueBuffer("debeME", debeME);
		setValueBuffer("haberME", 0);
	}

	_i.datosPartidaFactura(curPartida, curFactura, "proveedor");

	if (!curPartida.commitBuffer())
			return false;

	return true;
}

/* \D Devuelve el código e id de la subcuenta especial correspondiente a un determinado ejercicio. Primero trata de obtener los datos a partir del campo cuenta de co_cuentasesp. Si este no existe o no produce resultados, busca los datos de la cuenta (co_cuentas) marcada con el tipo especial buscado.
@param ctaEsp: Tipo de cuenta especial
@codEjercicio: Código de ejercicio
@return Los datos componen un vector de tres valores:
error: 0.Sin error 1.Datos no encontrados 2.Error al ejecutar la query
idsubcuenta: Identificador de la subcuenta
codsubcuenta: Código de la subcuenta
\end */
function oficial_datosCtaEspecial(ctaEsp, codEjercicio)
{
	var _i = this.iface;

	var datos = [];
	var q = new FLSqlQuery();

	with(q) {
		setTablesList("co_subcuentas,co_cuentasesp");
		setSelect("s.idsubcuenta, s.codsubcuenta");
		setFrom("co_cuentasesp ce INNER JOIN co_subcuentas s ON ce.codsubcuenta = s.codsubcuenta");
		setWhere("ce.idcuentaesp = '" + ctaEsp + "' AND s.codejercicio = '" + codEjercicio + "'  ORDER BY s.codsubcuenta");
	}
	try { q.setForwardOnly( true ); } catch (e) {}
	if (!q.exec()) {
		datos["error"] = 2;
		return datos;
	}
	if (q.next()) {
		datos["error"] = 0;
		datos["idsubcuenta"] = q.value(0);
		datos["codsubcuenta"] = q.value(1);
		return datos;
	}

	with(q) {
		setTablesList("co_cuentas,co_subcuentas,co_cuentasesp");
		setSelect("s.idsubcuenta, s.codsubcuenta");
		setFrom("co_cuentasesp ce INNER JOIN co_cuentas c ON ce.codcuenta = c.codcuenta INNER JOIN co_subcuentas s ON c.idcuenta = s.idcuenta");
		setWhere("ce.idcuentaesp = '" + ctaEsp + "' AND c.codejercicio = '" + codEjercicio + "' ORDER BY s.codsubcuenta");
	}
	try { q.setForwardOnly( true ); } catch (e) {}
	if (!q.exec()) {
		datos["error"] = 2;
		return datos;
	}
	if (q.next()) {
		datos["error"] = 0;
		datos["idsubcuenta"] = q.value(0);
		datos["codsubcuenta"] = q.value(1);
		return datos;
	}

	with(q) {
		setTablesList("co_cuentas,co_subcuentas");
		setSelect("s.idsubcuenta, s.codsubcuenta");
		setFrom("co_cuentas c INNER JOIN co_subcuentas s ON c.idcuenta = s.idcuenta");
		setWhere("c.idcuentaesp = '" + ctaEsp + "' AND c.codejercicio = '" + codEjercicio + "' ORDER BY s.codsubcuenta");
	}
	try { q.setForwardOnly( true ); } catch (e) {}
	if (!q.exec()) {
		datos["error"] = 2;
		return datos;
	}
	if (!q.next()) {
		if (_i.consultarCtaEspecial(ctaEsp, codEjercicio)) {
			return _i.datosCtaEspecial(ctaEsp, codEjercicio);
		} else {
			datos["error"] = 1;
			return datos;
		}
	}

	datos["error"] = 0;
	datos["idsubcuenta"] = q.value(0);
	datos["codsubcuenta"] = q.value(1);
	return datos;
}

function oficial_consultarCtaEspecial(ctaEsp, codEjercicio)
{
	var _i = this.iface;
	switch (ctaEsp) {
		case "IVASUE": {
			var res = MessageBox.warning(sys.translate("No tiene establecida la subcuenta de IVA soportado para adquisiciones intracomunitaras (IVASUE).\nEsta subcuenta es necesaria para almacenar información útil para informes como el de facturas emitidas o el modelo 303.\n¿Desea indicar cuál es esta subcuenta ahora?"), MessageBox.Yes, MessageBox.No);
			if (res != MessageBox.Yes)
				return false;
			return _i.crearCtaEspecial("IVASUE", "subcuenta", codEjercicio, sys.translate("IVA soportado en adquisiciones intracomunitarias U.E."));
			break;
		}
		case "IVARUE": {
			var res = MessageBox.warning(sys.translate("No tiene establecida la subcuenta de IVA repercutido para adquisiciones intracomunitaras (IVARUE).\nEsta subcuenta es necesaria para almacenar información útil para informes como el de facturas emitidas o el modelo 303.\n¿Desea indicar cuál es esta subcuenta ahora?"), MessageBox.Yes, MessageBox.No);
			if (res != MessageBox.Yes)
				return false;
			return _i.crearCtaEspecial("IVARUE", "subcuenta", codEjercicio, sys.translate("IVA repercutido en adquisiciones intracomunitarias U.E."));
			break;
		}
		case "IVASSE": {
			var res= MessageBox.warning(sys.translate("No tiene establecida la subcuenta de IVA soportado para recepción de servicios intracomunitaros (IVASSE).\nEsta subcuenta es necesaria para almacenar información útil para informes como el de facturas emitidas o el modelo 303.\n¿Desea indicar cuál es esta subcuenta ahora?"), MessageBox.Yes, MessageBox.No);
			if (res != MessageBox.Yes)
				return false;
			return _i.crearCtaEspecial("IVASUE", "subcuenta", codEjercicio, sys.translate("IVA soportado para recepción de servicios intracomunitaros U.E."));
			break;
		}
		case "IVARSE": {
			var res= MessageBox.warning(sys.translate("No tiene establecida la subcuenta de IVA soportado para recepción de servicios intracomunitaros (IVARSE).\nEsta subcuenta es necesaria para almacenar información útil para informes como el de facturas emitidas o el modelo 303.\n¿Desea indicar cuál es esta subcuenta ahora?"), MessageBox.Yes, MessageBox.No);
			if (res != MessageBox.Yes)
				return false;
			return _i.crearCtaEspecial("IVARSE", "subcuenta", codEjercicio, sys.translate("IVA soportado para recepción de servicios intracomunitaros U.E."));
			break;
		}
		case "IVAEUE": {
			var res = MessageBox.warning(sys.translate("No tiene establecida la subcuenta de IVA para entregas intracomunitaras (IVAEUE).\nEsta subcuenta es necesaria para almacenar información útil para informes como el de facturas emitidas o el modelo 303.\n¿Desea indicar cuál es esta subcuenta ahora?"), MessageBox.Yes, MessageBox.No);
			if (res != MessageBox.Yes)
				return false;
			return _i.crearCtaEspecial("IVAEUE", "subcuenta", codEjercicio, sys.translate("IVA en entregas intracomunitarias U.E."));
			break;
		}
		default: {
			return false;
		}
	}
	return false;
}

/** \D Devuelve el código e id de la subcuenta correspondiente a un impuesto y ejercicio determinados
@param	ctaEsp: Tipo de cuenta (IVA soportado, repercutido, Recargo de equivalencia)

@param	codEjercicio: Código de ejercicio
@param	codImpuesto: Código de impuesto
@return Los datos componen un vector de tres valores:
error: 0.Sin error 1.Datos no encontrados 2.Error al ejecutar la query
idsubcuenta: Identificador de la subcuenta
codsubcuenta: Código de la subcuenta
\end */
function oficial_datosCtaIVA(tipo, codEjercicio, codImpuesto)
{
	var _i = this.iface;
	var datos = [];
	var codSubcuenta;

	if (!codImpuesto || codImpuesto == "") {
		/// Si no hay una subcuenta asociada al impuesto se toma la primera subcuenta marcada con el tipo especial indicado
		codSubcuenta = AQUtil.sqlSelect("co_subcuentas", "codsubcuenta", "idcuentaesp = '" + tipo + "' AND codejercicio = '" + codEjercicio + "' ORDER BY codsubcuenta");
		if (!codSubcuenta || codSubcuenta == "") {
			return _i.datosCtaEspecial(tipo, codEjercicio);
		}
	}

	if (tipo == "IVAREP") {
		codSubcuenta = AQUtil.sqlSelect("impuestos", "codsubcuentarep", "codimpuesto = '" + codImpuesto + "'");
	}
	if (tipo == "IVASOP") {
		codSubcuenta = AQUtil.sqlSelect("impuestos", "codsubcuentasop", "codimpuesto = '" + codImpuesto + "'");
	}
	if (tipo == "IVAACR") {
		codSubcuenta = AQUtil.sqlSelect("impuestos", "codsubcuentaacr", "codimpuesto = '" + codImpuesto + "'");
	}
	if (tipo == "IVARRE") {
		/// Nueva cuenta especial. Como antes se usaba IVAACR se tiene esto en cuenta
		codSubcuenta = false;
		var curPrueba = new FLSqlCursor("impuestos");
		if (curPrueba.fieldType("codsubcuentaivarepre") != 0) {
			codSubcuenta = AQUtil.sqlSelect("impuestos", "codsubcuentaivarepre", "codimpuesto = '" + codImpuesto + "'");
		}
		if (!codSubcuenta) {
			codSubcuenta = AQUtil.sqlSelect("impuestos", "codsubcuentaacr", "codimpuesto = '" + codImpuesto + "'");
		}
	}
	if (tipo == "IVADEU") {
		codSubcuenta = AQUtil.sqlSelect("impuestos", "codsubcuentadeu", "codimpuesto = '" + codImpuesto + "'");
	}
	if (tipo == "IVARUE") {
		codSubcuenta = AQUtil.sqlSelect("impuestos", "codsubcuentaivadevadue", "codimpuesto = '" + codImpuesto + "'");
	}
	if (tipo == "IVASUE") {
		codSubcuenta = AQUtil.sqlSelect("impuestos", "codsubcuentaivadedadue", "codimpuesto = '" + codImpuesto + "'");
	}
	if (tipo == "IVARSE") {
		codSubcuenta = AQUtil.sqlSelect("impuestos", "codsubcuentaivarepspue", "codimpuesto = '" + codImpuesto + "'");
	}
	if (tipo == "IVASSE") {
		codSubcuenta = AQUtil.sqlSelect("impuestos", "codsubcuentaivasopspue", "codimpuesto = '" + codImpuesto + "'");
	}
	if (tipo == "IVAEUE") {
		codSubcuenta = AQUtil.sqlSelect("impuestos", "codsubcuentaivadeventue", "codimpuesto = '" + codImpuesto + "'");
	}
	if (tipo == "IVASIM") {
		var curPrueba = new FLSqlCursor("impuestos");
		if (curPrueba.fieldType("codsubcuentaivasopimp") != 0) {
			codSubcuenta = AQUtil.sqlSelect("impuestos", "codsubcuentaivasopimp", "codimpuesto = '" + codImpuesto + "'");
		} else {
			tipo = "IVASOP";
		}
	}
	if (tipo == "IVARXP") {
		var curPrueba = new FLSqlCursor("impuestos");
		if (curPrueba.fieldType("codsubcuentaivarepexp") != 0) {
			codSubcuenta = AQUtil.sqlSelect("impuestos", "codsubcuentaivarepexp", "codimpuesto = '" + codImpuesto + "'");
		} else {
			tipo = "IVARXP";
		}
	}
	if (tipo == "IVAREX") {
		var curPrueba = new FLSqlCursor("impuestos");
		if (curPrueba.fieldType("codsubcuentaivarepexe") != 0) {
			codSubcuenta = AQUtil.sqlSelect("impuestos", "codsubcuentaivarepexe", "codimpuesto = '" + codImpuesto + "'");
		} else {
			tipo = "IVAREX";
		}
	}
	if (tipo == "IVASEX") {
		var curPrueba = new FLSqlCursor("impuestos");
		if (curPrueba.fieldType("codsubcuentaivasopexe") != 0) {
			codSubcuenta = AQUtil.sqlSelect("impuestos", "codsubcuentaivasopexe", "codimpuesto = '" + codImpuesto + "'");
		} else {
			tipo = "IVASEX";
		}
	}
	if (tipo == "IVASRA") {
		codSubcuenta = AQUtil.sqlSelect("impuestos", "codsubcuentaivasopagra", "codimpuesto = '" + codImpuesto + "'");
	}


	if (!codSubcuenta || codSubcuenta == "") {
		/// Si no hay una subcuenta asociada al impuesto se toma la primera subcuenta marcada con el tipo especial indicado
		codSubcuenta = AQUtil.sqlSelect("co_subcuentas", "codsubcuenta", "idcuentaesp = '" + tipo + "' AND codejercicio = '" + codEjercicio + "' ORDER BY codsubcuenta");
		if (!codSubcuenta || codSubcuenta == "") {
			return _i.datosCtaEspecial(tipo, codEjercicio);
		}
	}

	var q = new FLSqlQuery();
	with(q) {
		setTablesList("co_subcuentas");
		setSelect("idsubcuenta, codsubcuenta");
		setFrom("co_subcuentas");
		setWhere("codsubcuenta = '" + codSubcuenta + "' AND codejercicio = '" + codEjercicio + "'");
	}
	try { q.setForwardOnly( true ); } catch (e) {}
	if (!q.exec()) {
		datos["error"] = 2;
		return datos;
	}
	if (!q.next()) {
		return _i.datosCtaEspecial(tipo, codEjercicio);
	}

	datos["error"] = 0;
	datos["idsubcuenta"] = q.value(0);
	datos["codsubcuenta"] = q.value(1);
	return datos;
}

/* \D Devuelve el código e id de la subcuenta de ventas correspondiente a un determinado ejercicio. La cuenta de ventas es la asignada a la serie de facturación. En caso de no estar establecida es la correspondiente a la subcuenta especial marcada como ventas
@param ctaEsp: Tipo de cuenta especial
@param codEjercicio: Código de ejercicio
@param codSerie: Código de serie de la factura
@return Los datos componen un vector de tres valores:
error: 0.Sin error 1.Datos no encontrados 2.Error al ejecutar la query
idsubcuenta: Identificador de la subcuenta
codsubcuenta: Código de la subcuenta
\end */
function oficial_datosCtaVentas(codEjercicio, codSerie)
{
		var _i = this.iface;
		var datos = [];

		var codCuenta = AQUtil.sqlSelect("series", "codcuenta", "codserie = '" + codSerie + "'");
		if (codCuenta.toString().isEmpty())
				return _i.datosCtaEspecial("VENTAS", codEjercicio);

		var q = new FLSqlQuery();
		with(q) {
				setTablesList("co_cuentas,co_subcuentas");
				setSelect("idsubcuenta, codsubcuenta");
				setFrom("co_cuentas c INNER JOIN co_subcuentas s ON c.idcuenta = s.idcuenta");
				setWhere("c.codcuenta = '" + codCuenta + "' AND c.codejercicio = '" + codEjercicio + "' ORDER BY codsubcuenta");
		}
		try { q.setForwardOnly( true ); } catch (e) {}
		if (!q.exec()) {
				datos["error"] = 2;
				return datos;
		}
		if (!q.next()) {
				datos["error"] = 1;
				return datos;
		}

		datos["error"] = 0;
		datos["idsubcuenta"] = q.value(0);
		datos["codsubcuenta"] = q.value(1);
		return datos;
}

/* \D Devuelve el código e id de la subcuenta de cliente correspondiente a una  determinada factura
@param curFactura: Cursor posicionado en la factura
@param valoresDefecto: Array con los datos de ejercicio y divisa actuales
@return Los datos componen un vector de tres valores:
error: 0.Sin error 1.Datos no encontrados 2.Error al ejecutar la query
idsubcuenta: Identificador de la subcuenta
codsubcuenta: Código de la subcuenta
\end */
function oficial_datosCtaCliente(curFactura, valoresDefecto)
{
	return flfactppal.iface.pub_datosCtaCliente( curFactura.valueBuffer("codcliente"), valoresDefecto );
}

/* \D Devuelve el código e id de la subcuenta de proveedor correspondiente a una  determinada factura
@param curFactura: Cursor posicionado en la factura
@param valoresDefecto: Array con los datos de ejercicio y divisa actuales
@return Los datos componen un vector de tres valores:
error: 0.Sin error 1.Datos no encontrados 2.Error al ejecutar la query
idsubcuenta: Identificador de la subcuenta
codsubcuenta: Código de la subcuenta
\end */
function oficial_datosCtaProveedor(curFactura, valoresDefecto)
{
	return flfactppal.iface.pub_datosCtaProveedor( curFactura.valueBuffer("codproveedor"), valoresDefecto );
}

/* \D Regenera el asiento correspondiente a una factura de abono de cliente
@param	curFactura: Cursor con los datos de la factura
@param valoresDefecto: Array con los datos de ejercicio y divisa actuales
@return	VERDADERO si no hay error. FALSO en otro caso
\end */
function oficial_asientoFacturaAbonoCli(curFactura, valoresDefecto)
{
	var _i = this.iface;

	var idAsiento  = curFactura.valueBuffer("idasiento").toString();
	var idFactura = curFactura.valueBuffer("idfactura");
	var curPartidas = new FLSqlCursor("co_partidas");
	var debe = 0;
	var haber = 0;
	var debeME = 0;
	var haberME = 0;
	var aux;

	curPartidas.select("idasiento = '" + idAsiento + "'");
	while (curPartidas.next()) {
		curPartidas.setModeAccess(curPartidas.Edit);
		curPartidas.refreshBuffer();
		debe = parseFloat(curPartidas.valueBuffer("debe"));
		haber = parseFloat(curPartidas.valueBuffer("haber"));
		debeME = parseFloat(curPartidas.valueBuffer("debeme"));
		haberME = parseFloat(curPartidas.valueBuffer("haberme"));
		aux = debe;
		debe = haber * -1;
		haber = aux * -1;
		aux = debeME;
		debeME = haberME * -1;
		haberME = aux * -1;
		debe = AQUtil.roundFieldValue(debe, "co_partidas", "debe");
		haber = AQUtil.roundFieldValue(haber, "co_partidas", "haber");
		debeME = AQUtil.roundFieldValue(debeME, "co_partidas", "debeme");
		haberME = AQUtil.roundFieldValue(haberME, "co_partidas", "haberme");

		curPartidas.setValueBuffer("debe",  debe);
		curPartidas.setValueBuffer("haber", haber);
		curPartidas.setValueBuffer("debeme",  debeME);
		curPartidas.setValueBuffer("haberme", haberME);

		if (!curPartidas.commitBuffer())
			return false;
	}

	var qryPartidasVenta = new FLSqlQuery();
	qryPartidasVenta.setTablesList("co_partidas,co_subcuentas,co_cuentas");
	qryPartidasVenta.setSelect("p.idsubcuenta, p.codsubcuenta");
	qryPartidasVenta.setFrom("co_partidas p INNER JOIN co_subcuentas s ON s.idsubcuenta = p.idsubcuenta INNER JOIN co_cuentas c ON c.idcuenta = s.idcuenta ");
	qryPartidasVenta.setWhere("c.idcuentaesp = 'VENTAS' AND idasiento = " + idAsiento);
	try { qryPartidasVenta.setForwardOnly( true ); } catch (e) {}

	if (!qryPartidasVenta.exec()) {
		return false;
	}
	if (qryPartidasVenta.size == 0) {
		return true;
	}

	var curPartidasVenta = new FLSqlCursor("co_partidas");
	var ctaDevolVentas = false;
	var codSubcuentaDev;
	while (qryPartidasVenta.next()) {
		codSubcuentaDev = qryPartidasVenta.value("p.codsubcuenta");
		if (!_i.esSubcuentaEspecial(codSubcuentaDev, valoresDefecto.codejercicio, "VENTAS")) {
			continue;
		}
		if (!ctaDevolVentas) {
			ctaDevolVentas = _i.datosCtaEspecial("DEVVEN", valoresDefecto.codejercicio);
			if (ctaDevolVentas.error == 1) {
				sys.warnMsgBox(sys.translate("No tiene definida una subcuenta especial de devoluciones de ventas.\nEl asiento asociado a la factura no puede ser creado"));
				return false;
			}
			if (ctaDevolVentas.error == 2) {
				return false;
			}
		}
		curPartidasVenta.select("idasiento = " + idAsiento + " AND idsubcuenta = " + qryPartidasVenta.value(0));
		curPartidasVenta.first();
		curPartidasVenta.setModeAccess(curPartidasVenta.Edit);
		curPartidasVenta.refreshBuffer();
		curPartidasVenta.setValueBuffer("idsubcuenta",  ctaDevolVentas.idsubcuenta);
		curPartidasVenta.setValueBuffer("codsubcuenta",  ctaDevolVentas.codsubcuenta);
		if (!curPartidasVenta.commitBuffer()) {
			return false;
		}
	}

	return true;
}


/* \D Regenera el asiento correspondiente a una factura de abono de proveedor
@param	curFactura: Cursor con los datos de la factura
@param valoresDefecto: Array con los datos de ejercicio y divisa actuales
@return	VERDADERO si no hay error. FALSO en otro caso
\end */
function oficial_asientoFacturaAbonoProv(curFactura, valoresDefecto)
{
	var _i = this.iface;

	var idAsiento  = curFactura.valueBuffer("idasiento").toString();
	var idFactura = curFactura.valueBuffer("idfactura");
	var curPartidas = new FLSqlCursor("co_partidas");
	var debe = 0;
	var haber = 0;
	var debeME = 0;
	var haberME = 0;
	var aux;

	curPartidas.select("idasiento = '" + idAsiento + "'");
	while (curPartidas.next()) {
		curPartidas.setModeAccess(curPartidas.Edit);
		curPartidas.refreshBuffer();
		debe = parseFloat(curPartidas.valueBuffer("debe"));
		haber = parseFloat(curPartidas.valueBuffer("haber"));
		debeME = parseFloat(curPartidas.valueBuffer("debeme"));
		haberME = parseFloat(curPartidas.valueBuffer("haberme"));
		aux = debe;
		debe = haber * -1;
		haber = aux * -1;
		aux = debeME;
		debeME = haberME * -1;
		haberME = aux * -1;
		debe = AQUtil.roundFieldValue(debe, "co_partidas", "debe");
		haber = AQUtil.roundFieldValue(haber, "co_partidas", "haber");
		debeME = AQUtil.roundFieldValue(debeME, "co_partidas", "debeme");
		haberME = AQUtil.roundFieldValue(haberME, "co_partidas", "haberme");

		curPartidas.setValueBuffer("debe",  debe);
		curPartidas.setValueBuffer("haber", haber);
		curPartidas.setValueBuffer("debeme",  debeME);
		curPartidas.setValueBuffer("haberme", haberME);

		if (!curPartidas.commitBuffer())
			return false;
	}

	var qryPartidasCompra = new FLSqlQuery();
	qryPartidasCompra.setTablesList("co_partidas,co_subcuentas,co_cuentas");
	qryPartidasCompra.setSelect("p.idsubcuenta,p.codsubcuenta");
	qryPartidasCompra.setFrom("co_partidas p INNER JOIN co_subcuentas s ON s.idsubcuenta = p.idsubcuenta INNER JOIN co_cuentas c ON c.idcuenta = s.idcuenta ");
	qryPartidasCompra.setWhere("c.idcuentaesp = 'COMPRA' AND idasiento = " + idAsiento);
	try { qryPartidasCompra.setForwardOnly( true ); } catch (e) {}

	if (!qryPartidasCompra.exec()) {
		return false;
	}

	if (qryPartidasCompra.size() == 0) {
		return true;
	}

	var curPartidasCompra = new FLSqlCursor("co_partidas");
	var ctaDevolCompra = false;
	var codSubcuentaDev;
	while (qryPartidasCompra.next()) {
		codSubcuentaDev = qryPartidasCompra.value("p.codsubcuenta");
		if (!_i.esSubcuentaEspecial(codSubcuentaDev, valoresDefecto.codejercicio, "COMPRA")) {
			continue;
		}
		if (!ctaDevolCompra) {
			ctaDevolCompra = _i.datosCtaEspecial("DEVCOM", valoresDefecto.codejercicio);
			if (ctaDevolCompra.error == 1) {
				sys.warnMsgBox(sys.translate("No tiene definida una subcuenta especial de devoluciones de compras.\nEl asiento asociado a la factura no puede ser creado"));
				return false;
			}
			if (ctaDevolCompra.error == 2) {
				return false;
			}
		}
		curPartidasCompra.select("idasiento = " + idAsiento + " AND idsubcuenta = " + qryPartidasCompra.value(0));
		curPartidasCompra.first();
		curPartidasCompra.setModeAccess(curPartidasCompra.Edit);
		curPartidasCompra.refreshBuffer();
		curPartidasCompra.setValueBuffer("idsubcuenta",  ctaDevolCompra.idsubcuenta);
		curPartidasCompra.setValueBuffer("codsubcuenta",  ctaDevolCompra.codsubcuenta);
		if (!curPartidasCompra.commitBuffer()) {
			return false;
		}
	}
	return true;
}

/** \D Indica si una subcuenta es de un determinado tipo especial
@param	codSubcuenta: Código de subcuenta
@param	codEjercicio: Ejercicio en el que comprobarlo.
@param	idTipoEsp: Tipo especial
\end */
function oficial_esSubcuentaEspecial(codSubcuenta, codEjercicio, idTipoEsp)
{
	var _i = this.iface;

	if (!codEjercicio) {
		codEjercicio = flfactppal.iface.pub_ejercicioActual();
	}
	var qrySubcuenta = new FLSqlQuery;
	qrySubcuenta.setTablesList("co_subcuentas,co_cuentas");
	qrySubcuenta.setSelect("s.idcuentaesp, c.codcuenta, c.idcuentaesp");
	qrySubcuenta.setFrom("co_subcuentas s INNER JOIN co_cuentas c ON s.idcuenta = c.idcuenta");
	qrySubcuenta.setWhere("s.codsubcuenta = '" + codSubcuenta + "' AND s.codejercicio = '" + codEjercicio + "'");
	qrySubcuenta.setForwardOnly(true);

	if (!qrySubcuenta.exec()) {
		return false;
	}
	if (!qrySubcuenta.first()) {
		return false;
	}
	if (qrySubcuenta.value("s.idcuenaesp") == idTipoEsp || qrySubcuenta.value("c.idcuentaesp") == idTipoEsp) {
		return true;
	}
	var codCuenta = qrySubcuenta.value("c.codcuenta");
	var qryTipoEsp = new FLSqlQuery;
	qryTipoEsp.setTablesList("co_cuentasesp");
	qryTipoEsp.setSelect("codcuenta, codsubcuenta");
	qryTipoEsp.setFrom("co_cuentasesp");
	qryTipoEsp.setWhere("idcuentaesp = '" + idCuentaEsp + "'");
	qryTipoEsp.setForwardOnly(true);
	if (!qryTipoEsp.exec()) {
		return false;
	}
	if (!qryTipoEsp.first()) {
		return false;
	}
	if (qryTipoEsp.value("codsubcuenta") == codSubcuenta || qryTipoEsp.value("codcuenta") == codCuenta) {
		return true;
	}
	return false;
}

/** \D Si la fecha no está dentro del ejercicio, propone al usuario la selección de uno nuevo
@param	fecha: Fecha del documento
@param	codEjercicio: Ejercicio del documento
@param	tipoDoc: Tipo de documento a generar
@return	Devuelve un array con los siguientes datos:
ok:	Indica si la función terminó correctamente (true) o con error (false)
modificaciones: Indica si se ha modificado algún valor (fecha o ejercicio)
fecha: Nuevo valor para la fecha modificada
codEjercicio: Nuevo valor para el ejercicio modificado
\end */
function oficial_datosDocFacturacion(fecha, codEjercicio, tipoDoc)
{
	var _i = this.iface;

	var res = [];
	res["ok"] = true;
	res["modificaciones"] = false;

	if (AQUtil.sqlSelect("ejercicios", "codejercicio", "codejercicio = '" + codEjercicio + "' AND '" + fecha + "' BETWEEN fechainicio AND fechafin"))
		return res;

	var f = new FLFormSearchDB("fechaejercicio");
	var cursor = f.cursor();

	cursor.select();
	if (!cursor.first()){
		cursor.setModeAccess(cursor.Insert);
	}
	else{
		cursor.setModeAccess(cursor.Edit);
	}
	cursor.refreshBuffer();

	cursor.refreshBuffer();
	cursor.setValueBuffer("fecha", fecha);
	cursor.setValueBuffer("codejercicio", codEjercicio);
	cursor.setValueBuffer("label", tipoDoc);
	cursor.commitBuffer();
	cursor.select();

	if (!cursor.first()) {
		res["ok"] = false;
		return res;
	}

	cursor.setModeAccess(cursor.Edit);
	cursor.refreshBuffer();

	f.setMainWidget();

	var acpt = f.exec("codejercicio");
	if (!acpt) {
		res["ok"] = false;
		return res;
	}
	res["modificaciones"] = true;
	res["fecha"] = cursor.valueBuffer("fecha");
	res["codEjercicio"] = cursor.valueBuffer("codejercicio");

	if (res.codEjercicio != flfactppal.iface.pub_ejercicioActual()) {
		if (tipoDoc != "pagosdevolcli" && tipoDoc != "pagosdevolprov" && tipoDoc != "tpv_pagoscomanda") {
			sys.infoMsgBox(sys.translate("Ha seleccionado un ejercicio distinto del actual.\nPara visualizar los documentos generados debe cambiar el ejercicio actual en la ventana\nde empresa y volver a abrir el formulario maestro correspondiente a los documentos generados"));
		}
	}

	return res;
}

/** \C Establece si un documento de cliente debe tener IVA. No lo tendrá si el cliente seleccionado está exento o es UE, o la serie seleccionada sea sin IVA
@param	codSerie: Serie del documento
@param	codCliente: Código del cliente
@return	Devuelve 3 posibles valores:
	0: Si no debe tener ni IVA ni recargo de equivalencia,
	1: Si debe tener IVA pero no recargo de equivalencia,
	2: Si debe tener IVA y recargo de equivalencia
\end */
function oficial_tieneIvaDocCliente(codSerie, codCliente, codEjercicio)
{
	var _i = this.iface;
	var conIva = true;

	if (AQUtil.sqlSelect("series", "siniva", "codserie = '" + codSerie + "'"))
		return 0;
	else {
		var regIva = AQUtil.sqlSelect("clientes", "regimeniva", "codcliente = '" + codCliente + "'");
		if (regIva == "Exento")
			return 0;
		else
			if (!AQUtil.sqlSelect("clientes", "recargo", "codcliente = '" + codCliente + "'"))
				return 1;
	}

	return 2;
}

/** \C Establece si un documento de proveedor debe tener IVA. No lo tendrá si el proveedor seleccionado está exento o es UE, o la serie seleccionada sea sin IVA
@param	codSerie: Serie del documento
@param	codProveedor: Código del proveedor
@return	Devuelve 3 posibles valores:
	0: Si no debe tener ni IVA ni recargo de equivalencia,
	1: Si debe tener IVA pero no recargo de equivalencia,
	2: Si debe tener IVA y recargo de equivalencia
\end */
function oficial_tieneIvaDocProveedor(codSerie, codProveedor, codEjercicio)
{
	var _i = this.iface;
	var tieneIva;

	if (AQUtil.sqlSelect("series", "siniva", "codserie = '" + codSerie + "'")) {
		tieneIva = 0;
	} else {
		var regIva = AQUtil.sqlSelect("proveedores", "regimeniva", "codproveedor = '" + codProveedor + "'");
		if (regIva == "Exento") {
			tieneIva = 0;
		} else if (flfactppal.iface.pub_valorDefectoEmpresa("recequivalencia")) {
			tieneIva = 2;
		} else {
			tieneIva = 1;
		}
	}
	return tieneIva;
}

/** \D Indica si el módulo de autómata está instalado y activado
@return	true si está activado, false en caso contrario
\end */
function oficial_automataActivado()
{
	if (!sys.isLoadedModule("flautomata")){
		return false;
	}
	if (formau_automata.iface.pub_activado()){
		return true;
	}
	return false;
}

/** \D Comprueba que si la factura tiene IVA, no esté incluida en un período de regularización ya cerrado
@param	curFactura: Cursor de la factura de cliente o proveedor
@return TRUE si la factura no tiene IVA o teniéndolo su fecha no está incluida en ningún período ya cerrado. FALSE en caso contrario
\end */
function oficial_comprobarRegularizacion(curFactura)
{
	var _i = this.iface;

	var fecha = curFactura.valueBuffer("fecha");
	if (AQUtil.sqlSelect("co_regiva", "idregiva", "fechainicio <= '" + fecha + "' AND fechafin >= '" + fecha + "' AND codejercicio = '" + curFactura.valueBuffer("codejercicio") + "'")) {
		sys.warnMsgBox(sys.translate("No puede incluirse el asiento de la factura en un período de I.V.A. ya regularizado"));
		return false;
	}
	return true;
}

/** \D
Recalcula la tabla huecos y el último valor de la secuencia de numeración.
@param serie: Código de serie del documento
@param ejercicio: Código de ejercicio del documento
@param fN: Tipo de documento (factura a cliente, a proveedor, albarán, etc.)
@return true si el calculo se ralizó correctamente
\end */
function oficial_recalcularHuecos( serie, ejercicio, fN ) {
	var _i = this.iface;
	var tipo;
	var tabla;

	if ( fN == "nfacturaprov" ) {
		tipo = "FP";
		tabla = "facturasprov"
	} else if (fN == "nfacturacli") {
		tipo = "FC";
		tabla = "facturascli";
	}

	var idSec = AQUtil.sqlSelect( "secuenciasejercicios", "id", "codserie = '" + serie + "' AND codejercicio = '" + ejercicio + "'" );

	if ( idSec ) {
		var nHuecos = parseInt( AQUtil.sqlSelect( "huecos", "count(*)", "codserie = '" + serie + "' AND codejercicio = '" + ejercicio + "' AND tipo = '" + tipo + "'" ) );
		var nFacturas = parseInt( AQUtil.sqlSelect( tabla, "count(*)", "codserie = '" + serie + "' AND codejercicio = '" + ejercicio + "'" ) );
		var maxFactura = parseInt( AQUtil.sqlSelect( "secuencias", "valorout", "id = " + idSec + " AND nombre='" + fN + "'" ) ) - 1;
		if (isNaN(maxFactura))
			maxFactura = 0;

		if ( maxFactura - nFacturas != nHuecos ) {
			var nSec = 0;
			var nFac = 0;
			var ultFac = -1;
			var cursorHuecos = new FLSqlCursor("huecos");
			var qryFac = new FLSqlQuery();

			AQUtil.createProgressDialog( sys.translate("Calculando huecos en la numeración..." ), maxFactura );

			qryFac.setTablesList( tabla );
			qryFac.setSelect( "numero" );
			qryFac.setFrom( tabla );
			qryFac.setWhere( "codserie = '" + serie + "' AND codejercicio = '" + ejercicio + "'" );
			qryFac.setOrderBy( "codigo asc" );
			qryFac.setForwardOnly( true );

			if ( !qryFac.exec() )
				return true;

			AQUtil.sqlDelete( "huecos", "codserie = '" + serie + "' AND codejercicio = '" + ejercicio + "' AND ( tipo = 'XX' OR tipo = '" + tipo + "')" );

			while ( qryFac.next() ) {
				nFac = qryFac.value( 0 );

				// Por si hay duplicados, que no debería haberlos...
				if (ultFac == nFac)
					continue;
				ultFac = nFac;

				AQUtil.setProgress( ++nSec );
				while ( nSec < nFac ) {
					cursorHuecos.setModeAccess( cursorHuecos.Insert );
					cursorHuecos.refreshBuffer();
					cursorHuecos.setValueBuffer( "tipo", tipo );
					cursorHuecos.setValueBuffer( "codserie", serie );
					cursorHuecos.setValueBuffer( "codejercicio", ejercicio );
					cursorHuecos.setValueBuffer( "numero", nSec );
					cursorHuecos.commitBuffer();
					AQUtil.setProgress( ++nSec );
				}
			}

			AQUtil.setProgress( ++nSec );
			AQUtil.sqlUpdate( "secuencias", "valorout", nSec, "id = " + idSec + " AND nombre='" + fN + "'" );

			AQUtil.setProgress( maxFactura );
			AQUtil.destroyProgressDialog();
		}
	}

	return true;
}

/** \D Lanza el formulario que muestra los documentos relacionados con un determinado documento de facturación
@param	codigo: Código del documento
@param	tipo: Tipo del documento
\end */
function oficial_mostrarTraza(codigo, tipo)
{
	var _i = this.iface;
	AQUtil.sqlDelete("trazadoc", "usuario = '" + sys.nameUser() + "'");

	var f = new FLFormSearchDB("trazadoc");
	var curTraza = f.cursor();
	curTraza.setModeAccess(curTraza.Insert);
	curTraza.refreshBuffer();
	curTraza.setValueBuffer("usuario", sys.nameUser());
	curTraza.setValueBuffer("codigo", codigo);
	curTraza.setValueBuffer("tipo", tipo);
	if (!curTraza.commitBuffer())
		return false;;

	curTraza.select("usuario = '" + sys.nameUser() + "'");
	if (!curTraza.first())
		return false;

	curTraza.setModeAccess(curTraza.Browse);
	f.setMainWidget();
	curTraza.refreshBuffer();
	var acpt = f.exec("usuario");
}

/** \D Establece los datos opcionales de una partida de IVA decompras/ventas.
Para facilitar personalizaciones en las partidas.
Se ponen datos de concepto, tipo de documento, documento y factura
@param	curPartida: Cursor sobre la partida
@param	curFactura: Cursor sobre la factura
@param	tipo: cliente / proveedor
@param	concepto: Concepto, opcional
*/
function oficial_datosPartidaFactura(curPartida, curFactura, tipo, concepto)
{
	var _i = this.iface;

	if (tipo == "cliente") {
		if (concepto) {
			curPartida.setValueBuffer("concepto", concepto);
		} else {
			curPartida.setValueBuffer("concepto", sys.translate("Nuestra factura") + " " + curFactura.valueBuffer("codigo") + " - " + curFactura.valueBuffer("nombrecliente"));
		}
		// Si es de IVA
		if (curPartida.valueBuffer("cifnif")) {
			curPartida.setValueBuffer("tipodocumento", "Factura de cliente");
		}
	}
	else {
		if (concepto) {
			curPartida.setValueBuffer("concepto", concepto);
		} else {
			var numFactura = curFactura.valueBuffer("numproveedor");
			if (numFactura == "") {
				numFactura = curFactura.valueBuffer("codigo");
			}
			curPartida.setValueBuffer("concepto", sys.translate("Su factura") + " " + numFactura + " - " + curFactura.valueBuffer("nombre"));
		}

		// Si es de IVA
		if (curPartida.valueBuffer("cifnif")) {
			curPartida.setValueBuffer("tipodocumento", "Factura de proveedor");
		}
	}

	// Si es de IVA
	if (curPartida.valueBuffer("cifnif")) {
		curPartida.setValueBuffer("documento", curFactura.valueBuffer("codigo"));
		curPartida.setValueBuffer("factura", curFactura.valueBuffer("numero"));
	}
}

/** \D Comprueba si hay condiciones para regenerar los recibos de una factura
cuando se edita la misma. Para sobrecargar en extensiones
@param	curFactura: Cursor de la factura
@param	masCampos: Array con los nombres de campos adicionales. Opcional
@return	VERDADERO si hay que regenerar, FALSO en otro caso
\end */
function oficial_siGenerarRecibosCli(curFactura, masCampos)
{
	var _i = this.iface;
	var camposAcomprobar = new Array("codcliente","total","codpago","fecha");

	for (var i = 0; i < camposAcomprobar.length; i++)
		if (curFactura.valueBuffer(camposAcomprobar[i]) != curFactura.valueBufferCopy(camposAcomprobar[i]))
			return true;

	if (masCampos) {
		for (i = 0; i < masCampos.length; i++)
			if (curFactura.valueBuffer(masCampos[i]) != curFactura.valueBufferCopy(masCampos[i]))
				return true;
	}

	return false;
}

function oficial_validarIvaRecargoCliente(codCliente,id,tabla,identificador)
{
	var _i = this.iface;

	if(!codCliente)
		return true;

	var regimenIva = AQUtil.sqlSelect("clientes","regimeniva","codcliente = '" + codCliente + "'");
	var aplicarRecargo = AQUtil.sqlSelect("clientes","recargo","codcliente = '" + codCliente + "'");

	var q = new FLSqlQuery();
	q.setTablesList(tabla);
	q.setSelect("iva,recargo");
	q.setFrom(tabla);
	q.setWhere(identificador + " = " + id);

	if (!q.exec())
		return false;

	var preguntadoIva = false;
	var preguntadoRecargo = false;
	while (q.next() && (!preguntadoIva || !preguntadoRecargo)) {
				var iva = parseFloat(q.value("iva"));
		if(!iva)
			iva = 0;
		var recargo = parseFloat(q.value("recargo"));
		if(!recargo)
			recargo = 0;

		if(!preguntadoIva) {
			switch (regimenIva) {
				case "General": {
					if (iva == 0) {
						var res = MessageBox.warning(sys.translate("El cliente %1 tiene establecido un régimen de I.V.A. %2\ny en alguna o varias de las lineas no hay establecido un % de I.V.A.\n¿Desea continuar de todas formas?").arg(codCliente).arg(regimenIva), MessageBox.Yes,MessageBox.No);
						preguntadoIva = true;
						if (res != MessageBox.Yes)
							return false;
					}
				}
				break;
				case "Exento": {
					if (iva != 0) {
						var res = MessageBox.warning(sys.translate("El cliente %1 tiene establecido un régimen de I.V.A. %2\ny en alguna o varias de las lineas hay establecido un % de I.V.A.\n¿Desea continuar de todas formas?").arg(codCliente).arg(regimenIva), MessageBox.Yes,MessageBox.No);
						preguntadoIva = true;
						if (res != MessageBox.Yes)
							return false;
					}
				}
				break;
			}
		}
		if(!preguntadoRecargo) {
			if (aplicarRecargo && recargo == 0) {
				var res = MessageBox.warning(sys.translate("Al cliente %1 se le debe aplicar Recargo de Equivalencia\ny en alguna o varias de las lineas no hay establecido un % de R. Equivalencia.\n¿Desea continuar de todas formas?").arg(codCliente), MessageBox.Yes,MessageBox.No);
				preguntadoRecargo = true;
				if (res != MessageBox.Yes)
					return false;
			}
			if (!aplicarRecargo && recargo != 0) {
				var res = MessageBox.warning(sys.translate("Al cliente %1 no se le debe aplicar Recargo de Equivalencia\ny en alguna o varias de las lineas hay establecido un % de R. Equivalencia.\n¿Desea continuar de todas formas?").arg(codCliente), MessageBox.Yes,MessageBox.No);
				preguntadoRecargo = true;
				if (res != MessageBox.Yes)
					return false;
			}
		}
	}

	return true;
}

function oficial_validarIvaRecargoProveedor(codProveedor,id,tabla,identificador)
{
	var _i = this.iface;

	if(!codProveedor)
		return true;

	var regimenIva = AQUtil.sqlSelect("proveedores","regimeniva","codproveedor = '" + codProveedor + "'");
	var aplicarRecargo = AQUtil.sqlSelect("empresa","recequivalencia","1 = 1");

	var q = new FLSqlQuery();
	q.setTablesList(tabla);
	q.setSelect("iva,recargo");
	q.setFrom(tabla);
	q.setWhere(identificador + " = " + id);

	if (!q.exec())
		return false;

	var preguntadoIva = false;
	var preguntadoRecargo = false;
	while (q.next()  && (!preguntadoIva || !preguntadoRecargo)) {
		var iva = parseFloat(q.value("iva"));
		if(!iva)
			iva = 0;
		var recargo = parseFloat(q.value("recargo"));
		if(!recargo)
			recargo = 0;

		if(!preguntadoIva) {
			switch (regimenIva) {
				case "General":
				case "U.E.": {
					if (iva == 0) {
						var res = MessageBox.warning(sys.translate("El proveedor %1 tiene establecido un régimen de I.V.A. %2\ny en alguna o varias de las lineas no hay establecido un % de I.V.A.\n¿Desea continuar de todas formas?").arg(codProveedor).arg(regimenIva), MessageBox.Yes,MessageBox.No);
						preguntadoIva = true;
						if (res != MessageBox.Yes)
							return false;
					}
				}
				break;
				case "Exento": {
					if (iva != 0) {
						var res = MessageBox.warning(sys.translate("El proveedor %1 tiene establecido un régimen de I.V.A. %2\ny en alguna o varias de las lineas hay establecido un % de I.V.A.\n¿Desea continuar de todas formas?").arg(codProveedor).arg(regimenIva), MessageBox.Yes,MessageBox.No);
						preguntadoIva = true;
						if (res != MessageBox.Yes)
							return false;
					}
				}
				break;
			}
		}
		if(!preguntadoRecargo) {
			if (aplicarRecargo && recargo == 0) {
				var res = MessageBox.warning(sys.translate("En los datos de empresa está activa al opción Aplicar Recargo de Equivalencia\ny en alguna o varias de las lineas no hay establecido un % de R. Equivalencia.\n¿Desea continuar de todas formas?"), MessageBox.Yes,MessageBox.No);
				preguntadoRecargo = true;
				if (res != MessageBox.Yes)
					return false;
			}
			if (!aplicarRecargo && recargo != 0) {
				var res = MessageBox.warning(sys.translate("En los datos de empresa no está activa al opción Aplicar Recargo de Equivalencia\ny en alguna o varias de las lineas hay establecido un % de R. Equivalencia.\n¿Desea continuar de todas formas?"), MessageBox.Yes,MessageBox.No);
				preguntadoRecargo = true;
				if (res != MessageBox.Yes)
					return false;
			}
		}
	}

	return true;
}

function oficial_comprobarFacturaAbonoCli(curFactura)
{
	var _i = this.iface;
	if (curFactura.valueBuffer("deabono") == true) {
		var idFacturaRect = curFactura.valueBuffer("idfacturarect");
		if (!idFacturaRect) {
			sys.warnMsgBox(sys.translate("Debe seleccionar la factura que desea abonar"));
			return false;
		}
		var codFacturaB = AQUtil.sqlSelect("facturascli", "codigo", "idfacturarect = " + idFacturaRect + " AND idfactura <> " + curFactura.valueBuffer("idfactura"));
		if (codFacturaB) {
			var codFacturaA = AQUtil.sqlSelect("facturascli", "codigo", "idfactura = " + idFacturaRect);
			var res = MessageBox.warning(sys.translate("La factura %1 ya está rectificada en la factura %2. ¿Desea continuar?").arg(codFacturaA).arg(codFacturaB), MessageBox.Yes, MessageBox.No);
			if (res != MessageBox.Yes) {
				return false;
			}
		}
// 		if (!curFactura.valueBuffer("idfacturarect")){
// 			var res = MessageBox.warning(AQUtil.translate("scripts", "No ha indicado la factura que desea abonar.\n¿Desea continuar?"), MessageBox.No, MessageBox.Yes);
// 			if (res != MessageBox.Yes) {
// 				return false;
// 			}
// 		} else {
// 			if (AQUtil.sqlSelect("facturascli", "idfacturarect", "idfacturarect = " + curFactura.valueBuffer("idfacturarect") + " AND idfactura <> " + curFactura.valueBuffer("idfactura"))) {
// 				MessageBox.warning(AQUtil.translate("scripts", "La factura ") +  AQUtil.sqlSelect("facturascli", "codigo", "idfactura = " + curFactura.valueBuffer("idfacturarect"))  + AQUtil.translate("scripts", " ya está abonada"),MessageBox.Ok, MessageBox.NoButton,MessageBox.NoButton);
// 				return false;
// 			}
// 		}
	}
	return true;
}

function oficial_comprobarFacturaAbonoProv(curFactura)
{
	var _i = this.iface;
	if (curFactura.valueBuffer("deabono") == true) {
		var idFacturaRect = curFactura.valueBuffer("idfacturarect");
		if (!idFacturaRect) {
			sys.warnMsgBox(sys.translate("Debe seleccionar la factura que desea abonar"));
			return false;
		}
		var codFacturaB = AQUtil.sqlSelect("facturasprov", "codigo", "idfacturarect = " + idFacturaRect + " AND idfactura <> " + curFactura.valueBuffer("idfactura"));
		if (codFacturaB) {
			var codFacturaA = AQUtil.sqlSelect("facturasprov", "codigo", "idfactura = " + idFacturaRect);
			var res = MessageBox.warning(sys.translate("La factura %1 ya está rectificada en la factura %2. ¿Desea continuar?").arg(codFacturaA).arg(codFacturaB), MessageBox.Yes, MessageBox.No);
			if (res != MessageBox.Yes) {
				return false;
			}
		}
	}
	return true;
}
function oficial_crearCtaEspecial(codCtaEspecial, tipo, codEjercicio, desCta)
{
	var _i = this.iface;

	var codSubcuenta;
	if (tipo == "subcuenta") {
		var f = new FLFormSearchDB("co_subcuentas");
		var curSubcuenta = f.cursor();
		curSubcuenta.setMainFilter("codejercicio = '" + codEjercicio + "'");

		f.setMainWidget();
		codSubcuenta = f.exec("codsubcuenta");
		if (!codSubcuenta)
			return false;
	}
	var curCtaEspecial = new FLSqlCursor("co_cuentasesp");
	curCtaEspecial.select("idcuentaesp = '" + codCtaEspecial + "'");
	if (curCtaEspecial.first()) {
		curCtaEspecial.setModeAccess(curCtaEspecial.Edit);
		curCtaEspecial.refreshBuffer();
	} else {
		curCtaEspecial.setModeAccess(curCtaEspecial.Insert);
		curCtaEspecial.refreshBuffer();
		curCtaEspecial.setValueBuffer("idcuentaesp", codCtaEspecial);
		curCtaEspecial.setValueBuffer("descripcion", desCta);
	}
	if (codSubcuenta && codSubcuenta != "") {
		curCtaEspecial.setValueBuffer("codsubcuenta", codSubcuenta);
	}
	if (!curCtaEspecial.commitBuffer())
		return false;

	return true;
}

function oficial_comprobarCambioSerie(cursor)
{
	var _i = this.iface;
	if(!cursor.valueBuffer("codserie") || cursor.valueBuffer("codserie") == "" || !cursor.valueBufferCopy("codserie") || cursor.valueBufferCopy("codserie") == "")
		return true;
	if(cursor.valueBuffer("codserie") != cursor.valueBufferCopy("codserie")) {
		var _i = this.iface;
		sys.warnMsgBox(sys.translate("No se puede modificar la serie.\nSerie anterior:%1 - Serie actual:%2").arg(cursor.valueBufferCopy("codserie")).arg(cursor.valueBuffer("codserie")));
		return false;
	}
	return true;
}

/** Función a sobrecargar por la extensión de subcuenta de ventas por artículo
\end */
function oficial_subcuentaVentas(referencia, codEjercicio)
{
	return false;
}

// function oficial_liberarPedidosCli(curAlbaran)
// {
// 	var idLineaAlbaran;
// 	var idLineaPedido;
// 	var numeroPedido;
//
// 	var query = new FLSqlQuery();
// 	query.setTablesList("lineasalbaranescli");
// 	query.setSelect("idlineapedido, idlinea");
// 	query.setFrom("lineasalbaranescli");
// 	query.setWhere("idalbaran = " + curAlbaran.valueBuffer("idalbaran") + " AND idlineapedido <> 0;");
// 	query.exec();
//
// 	while (query.next()) {
// 		idLineaPedido = query.value("idlineapedido");
// 		idLineaAlbaran = query.value("idlinea");
// 		if (!_i.restarCantidadCli(idLineaPedido, idLineaAlbaran)) {
// 			return false;
// 		}
// 	}
//
// 	var qryPedido = new FLSqlQuery();
// 	qryPedido.setTablesList("lineasalbaranescli");
// 	qryPedido.setSelect("idpedido");
// 	qryPedido.setFrom("lineasalbaranescli");
// 	qryPedido.setWhere("idalbaran = " + curAlbaran.valueBuffer("idalbaran") + " AND idpedido <> 0 GROUP BY idpedido;");
// 	qryPedido.exec();
// 	while (qryPedido.next()) {
// 		idPedido = qryPedido.value("idpedido");
// 		formRecordlineasalbaranescli.iface.pub_actualizarEstadoPedido(idPedido, curAlbaran);
// 	}
// 	return true;
// }

// function oficial_liberarPedidosProv(curAlbaran)
// {
// 	var idLineaAlbaran;
// 	var idLineaPedido;
// 	var numeroPedido;
//
// 	var query = new FLSqlQuery();
// 	query.setTablesList("lineasalbaranesprov");
// 	query.setSelect("idlineapedido, idlinea");
// 	query.setFrom("lineasalbaranesprov");
// 	query.setWhere("idalbaran = " + curAlbaran.valueBuffer("idalbaran") + " AND idlineapedido <> 0;");
// 	query.exec();
//
// 	while (query.next()) {
// 		idLineaPedido = query.value("idlineapedido");
// 		idLineaAlbaran = query.value("idlinea");
// 		if (!_i.restarCantidadProv(idLineaPedido, idLineaAlbaran)) {
// 			return false;
// 		}
// 	}
//
// 	var qryPedido = new FLSqlQuery();
// 	qryPedido.setTablesList("lineasalbaranesprov");
// 	qryPedido.setSelect("idpedido");
// 	qryPedido.setFrom("lineasalbaranesprov");
// 	qryPedido.setWhere("idalbaran = " + curAlbaran.valueBuffer("idalbaran") + " AND idpedido <> 0 GROUP BY idpedido;");
// 	qryPedido.exec();
// 	while (qryPedido.next()) {
// 		idPedido = qryPedido.value("idpedido");
// 		formRecordlineasalbaranesprov.iface.pub_actualizarEstadoPedido(idPedido);
// 	}
// 	return true;
// }

/** \D
Cambia el valor del campo totalenalbarán de una determinada línea de pedido, calculándolo como la suma de cantidades en otras líneas distintas de la línea de albarán indicada
@param idLineaPedido: Identificador de la línea de pedido
@param idLineaAlbaran: Identificador de la línea de albarán
\end */
function oficial_restarCantidadCli(idLineaPedido, idLineaAlbaran)
{
	var _i = this.iface;
	var cantidad = parseFloat(AQUtil.sqlSelect("lineasalbaranescli", "SUM(cantidad)", "idlineapedido = " + idLineaPedido + " AND idlinea <> " + idLineaAlbaran));
	if (isNaN(cantidad))
		cantidad = 0;

	var curLineaPedido = new FLSqlCursor("lineaspedidoscli");
	curLineaPedido.select("idlinea = " + idLineaPedido);
	if (curLineaPedido.first()) {
		curLineaPedido.setModeAccess(curLineaPedido.Edit);
		curLineaPedido.refreshBuffer();
		curLineaPedido.setValueBuffer("totalenalbaran", cantidad);

		if (!curLineaPedido.commitBuffer()) {
			return false;
		}
	}
	return true;
}

/** \D
Cambia el valor del campo totalenalbarán de una determinada línea de pedido, calculándolo como la suma de cantidades en otras líneas distintas de la línea de albarán indicada
@param idLineaPedido: Identificador de la línea de pedido
@param idLineaAlbaran: Identificador de la línea de albarán
\end */
function oficial_restarCantidadProv(idLineaPedido, idLineaAlbaran)
{
	var _i = this.iface;
	var cantidad = parseFloat(AQUtil.sqlSelect("lineasalbaranesprov", "SUM(cantidad)", "idlineapedido = " + idLineaPedido + " AND idlinea <> " + idLineaAlbaran));
	if (isNaN(cantidad))
		cantidad = 0;

	var curLineaPedido = new FLSqlCursor("lineaspedidosprov");
	curLineaPedido.select("idlinea = " + idLineaPedido);
	if (curLineaPedido.first()) {
		curLineaPedido.setModeAccess(curLineaPedido.Edit);
		curLineaPedido.refreshBuffer();
		curLineaPedido.setValueBuffer("totalenalbaran", cantidad);

		if (!curLineaPedido.commitBuffer()) {
			return false;
		}
	}
	return true;
}

function oficial_actualizarPedidosCli(curAlbaran)
{
	return true;
/*
	var _i = this.iface;

	var query = new FLSqlQuery();
	query.setTablesList("lineasalbaranescli");
	query.setSelect("idlineapedido, idpedido, referencia, idalbaran, cantidad");
	query.setFrom("lineasalbaranescli");
	query.setWhere("idalbaran = " + curAlbaran.valueBuffer("idalbaran") + " AND idlineapedido <> 0 ORDER BY idpedido");
	try { query.setForwardOnly( true ); } catch (e) {}
	query.exec();
	var idPedido = 0;
	while (query.next()) {
		if (!_i.actualizarLineaPedidoCli(query.value(0), query.value(1), query.value(2), query.value(3), query.value(4))) {
			return false;
		}

		if (idPedido != query.value(1)) {
			if (!_i.actualizarEstadoPedidoCli(query.value(1), curAlbaran))
				return false;
		}
		idPedido = query.value(1)
	}
	return true;*/
}

function oficial_actualizarPedidosProv(curAlbaran)
{
	return true;
}

/** \C
Actualiza el campo total en albarán de la línea de pedido correspondiente (si existe).
@param	idLineaPedido: Id de la línea a actualizar
@param	idPedido: Id del pedido a actualizar
@param	referencia del artículo contenido en la línea
@param	idAlbaran: Id del albarán en el que se sirve el pedido
@param	cantidadLineaAlbaran: Cantidad total de artículos de la referencia actual en el albarán
@return	True si la actualización se realiza correctamente, false en caso contrario
\end */
/// Función OBSOLETA, se deja por compatibilidad con extensiones. Se usa sirveLineaPedidoProv
function oficial_actualizarLineaPedidoProv(idLineaPedido, idPedido, referencia, idAlbaran, cantidadLineaAlbaran)
{
	var _i = this.iface;

	var curLA = new FLSqlCursor("lineasalbaranesprov");
	curLA.select("idalbaran = " + idAlbaran + " AND idlineapedido = " + idLineaPedido + " AND idpedido = " + idPedido + " AND referencia = '" + referencia + "' AND cantidad = " + cantidadLineaAlbaran);
	if (!curLA.first()) {
		return false;
	}
	if (!_i.sirveLineaPedidoProv(curLA)) {
		return false;
	}
	return true;
}

function oficial_sirveLineaPedidoProv(curLA)
{
	var _i = this.iface;

	var idLineaPedido = curLA.valueBuffer("idlineapedido");
	if (idLineaPedido == 0) {
		return true;
	}
	var idPedido = curLA.valueBuffer("idpedido");
	var referencia = curLA.valueBuffer("referencia");
	var idLineaAlbaran = curLA.valueBuffer("idlinea");
	var canAlbaran = curLA.valueBuffer("cantidad");

	var cantidadServida;
	var curLineaPedido = new FLSqlCursor("lineaspedidosprov");
	curLineaPedido.select("idlinea = " + idLineaPedido);
	curLineaPedido.setModeAccess(curLineaPedido.Edit);
	if (!curLineaPedido.first()) {
		return true;
	}
	var cantidadPedido = parseFloat(curLineaPedido.valueBuffer("cantidad"));
	var query = new FLSqlQuery();
	query.setTablesList("lineasalbaranesprov");
	query.setSelect("SUM(cantidad)");
	query.setFrom("lineasalbaranesprov");
	query.setWhere("idlineapedido = " + idLineaPedido + " AND idlinea <> " + idLineaAlbaran);
	if (!query.exec()) {
		return false;
	}
	if (query.next()) {
		var canOtros = parseFloat(query.value("SUM(cantidad)"));
		if (isNaN(canOtros)) {
			canOtros = 0;
		}
		cantidadServida = canOtros + parseFloat(canAlbaran);
	}
	if (cantidadServida > cantidadPedido) {
		cantidadServida = cantidadPedido;
	}
	curLineaPedido.setValueBuffer("totalenalbaran", cantidadServida);
	if (!curLineaPedido.commitBuffer()) {
		return false;
	}

	return true;
}

/** \C
Marca el pedido como servido o parcialmente servido según corresponda.
@param	idPedido: Id del pedido a actualizar
@param	curAlbaran: Cursor posicionado en el albarán que modifica el estado del pedido
@return	True si la actualización se realiza correctamente, false en caso contrario
\end */
function oficial_actualizarEstadoPedidoProv(idPedido, curAlbaran)
{
	var _i = this.iface;

	var estado = _i.obtenerEstadoPedidoProv(idPedido);
	if (!estado) {
		return false;
	}
	var curPedido = new FLSqlCursor("pedidosprov");
	curPedido.select("idpedido = " + idPedido);
	if (curPedido.first()) {
		if (estado == curPedido.valueBuffer("servido")) {
			return true;
		}
		curPedido.setUnLock("editable", true);
	}

	curPedido.select("idpedido = " + idPedido);
	curPedido.setModeAccess(curPedido.Edit);
	if (curPedido.first()) {
		curPedido.setValueBuffer("servido", estado);
		if (estado == "Sí") {
			curPedido.setValueBuffer("editable", false);
			if (sys.isLoadedModule("flcolaproc")) {
				if (!flfactppal.iface.pub_lanzarEvento(curPedido, "pedidoProvAlbaranado")) {
					return false;
				}
			}
		}
		if (!curPedido.commitBuffer()) {
			return false;
		}
	}
	return true;
}

/** \C
Obtiene el estado de un pedido
@param	idPedido: Id del pedido a actualizar
@return	True si la actualización se realiza correctamente, false en caso contrario
\end */
function oficial_obtenerEstadoPedidoProv(idPedido)
{
	var _i = this.iface;
	var query = new FLSqlQuery();

	query.setTablesList("lineaspedidosprov");
	query.setSelect("cantidad, totalenalbaran, cerrada");
	query.setFrom("lineaspedidosprov");
	query.setWhere("idpedido = " + idPedido);
	if (!query.exec()) {
		return false;
	}

	var estado = "";
	var totalServidas = 0;
	var parcial = false;
	var totalLineas = 0; //query.size();
	var totalCerradas = 0;

	var cantidad, cantidadServida;
	var cerrada;
	while (query.next()) {
		cantidad = parseFloat(query.value("cantidad"));
		if (cantidad == 0) {
			continue;
		}
		totalLineas++;
		cantidadServida = parseFloat(query.value("totalenalbaran"));
		cerrada = query.value("cerrada");
		if (cerrada) {
			totalCerradas++;
		} else if (cantidad <= cantidadServida) {
			totalServidas++;
		} else {
			if (cantidad > cantidadServida && cantidadServida != 0) {
				parcial = true;
			}
		}
	}
	if (totalLineas == 0) {
		return "No";
	}

	var totalAServir = totalLineas - totalCerradas;
	if (parcial) {
		estado = "Parcial";
	} else {
		if (totalServidas == 0 && totalCerradas == 0) {
			estado = "No";
		} else {
			if (totalServidas >= totalAServir) {
				estado = "Sí";
			} else {
				estado = "Parcial";
			}
		}
	}
	return estado;
}

/** \C
Actualiza el campo total en albarán de la línea de pedido correspondiente (si existe).
@param	idLineaPedido: Id de la línea a actualizar
@param	idPedido: Id del pedido a actualizar
@param	referencia del artículo contenido en la línea
@param	idAlbaran: Id del albarán en el que se sirve el pedido
@param	cantidadLineaAlbaran: Cantidad total de artículos de la referencia actual en el albarán
@return	True si la actualización se realiza correctamente, false en caso contrario
\end */
/// Función OBSOLETA, se deja por compatibilidad con extensiones. Se usa sirveLineaPedidoCli
function oficial_actualizarLineaPedidoCli(idLineaPedido, idPedido, referencia, idAlbaran, cantidadLineaAlbaran)
{
	var _i = this.iface;

	var curLA = new FLSqlCursor("lineasalbaranescli");
	curLA.select("idalbaran = " + idAlbaran + " AND idlineapedido = " + idLineaPedido + " AND idpedido = " + idPedido + " AND referencia = '" + referencia + "' AND cantidad = " + cantidadLineaAlbaran);
	if (!curLA.first()) {
		return false;
	}
	if (!_i.sirveLineaPedidoCli(curLA)) {
		return false;
	}
	return true;
}

function oficial_sirveLineaPedidoCli(curLA)
{
	var _i = this.iface;

	var idLineaPedido = curLA.valueBuffer("idlineapedido");
	if (idLineaPedido == 0) {
		return true;
	}
	var idPedido = curLA.valueBuffer("idpedido");
	var referencia = curLA.valueBuffer("referencia");
	var idLineaAlbaran = curLA.valueBuffer("idlinea");
	var canAlbaran = curLA.valueBuffer("cantidad");

	if (idLineaPedido == 0) {
		return true;
	}

	var cantidadServida;
	var curLineaPedido = new FLSqlCursor("lineaspedidoscli");
	curLineaPedido.select("idlinea = " + idLineaPedido);
	curLineaPedido.setModeAccess(curLineaPedido.Edit);
	if (!curLineaPedido.first()) {
		return true;
	}

	var cantidadPedido = parseFloat(curLineaPedido.valueBuffer("cantidad"));
	var query = new FLSqlQuery();
	query.setTablesList("lineasalbaranescli");
	query.setSelect("SUM(cantidad)");
	query.setFrom("lineasalbaranescli");
	query.setWhere("idlineapedido = " + idLineaPedido + " AND idlinea <> " + idLineaAlbaran);
	if (!query.exec()) {
		return false;
	}
	if (query.next()) {
		var canOtros = parseFloat(query.value("SUM(cantidad)"));
		if (isNaN(canOtros)) {
			canOtros = 0;
		}
		cantidadServida = canOtros + parseFloat(canAlbaran);
	}
	if (cantidadServida > cantidadPedido) {
		cantidadServida = cantidadPedido;
	}

	curLineaPedido.setValueBuffer("totalenalbaran", cantidadServida);
	if (!curLineaPedido.commitBuffer()) {
		return false;
	}

	return true;
}

/** \C
Marca el pedido como servido o parcialmente servido según corresponda.
@param	idPedido: Id del pedido a actualizar
@param	curAlbaran: Cursor posicionado en el albarán que modifica el estado del pedido
@return	True si la actualización se realiza correctamente, false en caso contrario
\end */
function oficial_actualizarEstadoPedidoCli(idPedido, curAlbaran)
{
	var _i = this.iface;

	var estado = _i.obtenerEstadoPedidoCli(idPedido);
	if (!estado) {
		return false;
	}

	var curPedido = new FLSqlCursor("pedidoscli");
	curPedido.select("idpedido = " + idPedido);
	if (curPedido.first()) {
		if (estado == curPedido.valueBuffer("servido")) {
			return true;
		}
		curPedido.setUnLock("editable", true);
	}

	curPedido.select("idpedido = " + idPedido);
	curPedido.setModeAccess(curPedido.Edit);
	if (curPedido.first()) {
		curPedido.setValueBuffer("servido", estado);
		if (estado == "Sí") {
			curPedido.setValueBuffer("editable", false);
		}
		if (!curPedido.commitBuffer()) {
			return false;
		}
	}
	return true;
}

/** \C
Obtiene el estado de un pedido
@param	idPedido: Id del pedido a actualizar
@return	Estado del pedido
\end */
function oficial_obtenerEstadoPedidoCli(idPedido)
{
	var _i = this.iface;
	var query = new FLSqlQuery();

	query.setTablesList("lineaspedidoscli");
	query.setSelect("cantidad, totalenalbaran, cerrada");
	query.setFrom("lineaspedidoscli");
	query.setWhere("idpedido = " + idPedido);
	if (!query.exec()) {
		return false;
	}

	var estado = "";
	var totalServidas = 0;
	var parcial = false;
	var totalLineas = 0; //query.size();
	var totalCerradas = 0;

	var cantidad, cantidadServida;
	var cerrada;
	while (query.next()) {
		cantidad = parseFloat(query.value("cantidad"));
		if (cantidad == 0) {
			continue;
		}
		totalLineas++;
		cantidadServida = parseFloat(query.value("totalenalbaran"));
		cerrada = query.value("cerrada");
		if (cerrada) {
			totalCerradas++;
		} else if (cantidad <= cantidadServida) {
			totalServidas++;
		} else {
			if (cantidad > cantidadServida && cantidadServida != 0) {
				parcial = true;
			}
		}
	}
	if (totalLineas == 0) {
		return "No";
	}

	var totalAServir = totalLineas - totalCerradas;
	if (parcial) {
		estado = "Parcial";
	} else {
		if (totalServidas == 0 && totalCerradas == 0) {
			estado = "No";
		} else {
			if (totalServidas >= totalAServir) {
				estado = "Sí";
			} else {
				estado = "Parcial";
			}
		}
	}
	return estado;
}

/** \D
Llama a la función liberarAlbaran para todos los albaranes agrupados en una factura
@param idFactura: Identificador de la factura
\end */
function oficial_liberarAlbaranesCli(idFactura)
{
	var _i = this.iface;

	var curAlbaranes = new FLSqlCursor("albaranescli");
	curAlbaranes.select("idfactura = " + idFactura);
	while (curAlbaranes.next()) {
		if (!_i.liberarAlbaranCli(curAlbaranes.valueBuffer("idalbaran"))) {
			return false;
		}
	}
	return true;
}

/** \D
Desbloquea un albarán que estaba asociado a una factura
@param idAlbaran: Identificador del albarán
\end */
function oficial_liberarAlbaranCli(idAlbaran)
{
	var _i = this.iface;

	var curAlbaran = new FLSqlCursor("albaranescli");
	with(curAlbaran) {
		select("idalbaran = " + idAlbaran);
		first();
		setUnLock("ptefactura", true);
		select("idalbaran = " + idAlbaran);
		first();
		setModeAccess(Edit);
		refreshBuffer();
		setValueBuffer("idfactura", "0");
	}
	if (!curAlbaran.commitBuffer()) {
		return false;
	}
	return true;
}

/** \D
Llama a la función liberarAlbaran para todos los albaranes agrupados en una factura
@param idFactura: Identificador de la factura
\end */
function oficial_liberarAlbaranesProv(idFactura)
{
	var _i = this.iface;

	var curAlbaranes = new FLSqlCursor("albaranesprov");
	curAlbaranes.select("idfactura = " + idFactura);
	while (curAlbaranes.next()) {
		if (!_i.liberarAlbaranProv(curAlbaranes.valueBuffer("idalbaran"))) {
			return false;
		}
	}
	return true;
}

/** \D
Desbloquea un albarán que estaba asociado a una factura
@param idAlbaran: Identificador del albarán
\end */
function oficial_liberarAlbaranProv(idAlbaran)
{
	var _i = this.iface;

	var curAlbaran = new FLSqlCursor("albaranesprov");
	with(curAlbaran) {
		select("idalbaran = " + idAlbaran);
		first();
		setUnLock("ptefactura", true);
		setModeAccess(Edit);
		refreshBuffer();
		setValueBuffer("idfactura", "0");
	}
	if (!curAlbaran.commitBuffer()) {
		return false;
	}
	return true;
}

function oficial_liberarPresupuestoCli(idPresupuesto)
{
	var _i = this.iface;

	if (idPresupuesto) {
		var curPresupuesto = new FLSqlCursor("presupuestoscli");
		curPresupuesto.select("idpresupuesto = " + idPresupuesto);
		if (!curPresupuesto.first()) {
			return false;
		}
		with(curPresupuesto) {
			setUnLock("editable", true);
		}
	}
	return true;
}

function oficial_aplicarComisionLineas(codAgente,tblHija,where)
{
	var _i = this.iface;

	var numLineas = AQUtil.sqlSelect(tblHija,"count(idlinea)",where);
	if(!numLineas)
		return true;

	var referencia = "";
	var comision = 0;

	if(!codAgente || codAgente == "")
		return false;

	var curLineas = new FLSqlCursor(tblHija);
	curLineas.select(where);

	AQUtil.createProgressDialog(sts.translate("Actualizando comisión ..." ), numLineas);

	var i = 0;
	while (curLineas.next()) {
		AQUtil.setProgress(i++);
		curLineas.setActivatedCommitActions(false);
		curLineas.setModeAccess(curLineas.Edit);
		curLineas.refreshBuffer();
// 		comision = formRecordlineaspedidoscli.iface.pub_commonCalculateField("porcomision",curLineas);
		referencia = curLineas.valueBuffer("referencia");
		comision = _i.calcularComisionLinea(codAgente,referencia);
		comision = AQUtil.roundFieldValue(comision, tblHija, "porcomision");
		curLineas.setValueBuffer("porcomision",comision);
		if(!curLineas.commitBuffer()) {
			AQUtil.destroyProgressDialog();
			return false;
		}
	}
	AQUtil.setProgress(numLineas);
	AQUtil.destroyProgressDialog();
	return true;
}

function oficial_calcularComisionLinea(codAgente,referencia)
{
	var _i = this.iface;
	var valor = -1;

	if(referencia && referencia != "") {
		var id = AQUtil.sqlSelect("articulosagen", "id", "referencia = '" + referencia + "' AND codagente = '" + codAgente + "'");
		if(id)
			valor = parseFloat(AQUtil.sqlSelect("articulosagen", "comision", "id = " + id));
	}

	if(valor == -1)
		valor = parseFloat(AQUtil.sqlSelect("agentes", "porcomision", "codagente = '" + codAgente + "'"));

	valor = AQUtil.roundFieldValue(valor, "agentes", "porcomision");

	return valor;
}

function oficial_arrayCostesAfectados(arrayInicial, arrayFinal)
{
	var _i = this.iface;
	var arrayAfectados = [];
	var iAA = 0;
	var iAI = 0;
	var iAF = 0;
	var longAI = 0;
	if(arrayInicial) {
		longAI = arrayInicial.length;
		arrayInicial.sort(this.iface.compararArrayCoste);
	}
	
	var longAF = 0;
	if(arrayFinal) {
		longAF = arrayFinal.length;
		arrayFinal.sort(this.iface.compararArrayCoste);
	}

// debug("ARRAY INICIAL");
// for (var i = 0; i < arrayInicial.length; i++) {
// 	debug(" " + arrayInicial[i]["idarticulo"] + "-" + arrayInicial[i]["cantidad"]);
// }
// debug("ARRAY FINAL");
// for (var i = 0; i < arrayFinal.length; i++) {
// 	debug(" " + arrayFinal[i]["idarticulo"] + "-" + arrayFinal[i]["cantidad"]);
// }

// debug("ARRAY INICIAL ORDENADO");
// for (var i = 0; i < arrayInicial.length; i++) {
// 	debug(" " + arrayInicial[i]["idarticulo"] + "-" + arrayInicial[i]["cantidad"]);
// }
// debug("ARRAY FINAL ORDENADO");
// for (var i = 0; i < arrayFinal.length; i++) {
// 	debug(" " + arrayFinal[i]["idarticulo"] + "-" + arrayFinal[i]["cantidad"]);
// }
	var comparacion;
	while (iAI < longAI || iAF < longAF) {
		if (iAI < longAI && iAF < longAF) {
			comparacion = _i.compararArrayCoste(arrayInicial[iAI], arrayFinal[iAF]);
		} else if (iAF < longAF) {
			comparacion = 1;
		} else if (iAI < longAI) {
			comparacion = -1;
		}
		switch (comparacion) {
			case 1: {
				arrayAfectados[iAA] = [];
				arrayAfectados[iAA]["idarticulo"] = arrayFinal[iAF]["idarticulo"];
				iAF++;
				iAA++;
				break;
			}
			case -1: {
				arrayAfectados[iAA] = [];
				arrayAfectados[iAA]["idarticulo"] = arrayInicial[iAI]["idarticulo"];
				iAI++;
				iAA++;
				break;
			}
			case 0: {
				if ((arrayInicial[iAI]["cantidad"] != arrayFinal[iAF]["cantidad"]) || (arrayInicial[iAI]["pvptotal"] != arrayFinal[iAF]["pvptotal"])) {
					arrayAfectados[iAA] = [];
					arrayAfectados[iAA]["idarticulo"] = arrayFinal[iAI]["idarticulo"];
					iAA++;
				}
				iAI++;
				iAF++;
				break;
			}
		}
	}
	return arrayAfectados;
}

/** \D Función de comparación de dos arrays con datos de cálculo de coste medio. La comparación se hace en base al identificador del artículo
@param	a: Array 1
@param	b: Array 2
@return	1: a > b, -1: a < b, 0: a = b
\end */
function oficial_compararArrayCoste(a, b)
{
	var _i = this.iface;

	var resultado = 0;
	if (a["idarticulo"] > b["idarticulo"]) {
		resultado = 1;
	} else if (a["idarticulo"] < b["idarticulo"]) {
		resultado = -1;
	}return resultado;
}

function oficial_campoImpuesto(campo, codImpuesto, fecha, cliProv)
{
	var _i = this.iface;
	return parseFloat(AQUtil.sqlSelect("impuestos", campo, "codimpuesto = '" + codImpuesto + "'"));
}

function oficial_datosImpuesto(codImpuesto, fecha)
{
	var _i = this.iface;

	var datosImpuesto:Array;
	var qryImpuesto = new FLSqlQuery();
	qryImpuesto.setTablesList("impuestos");
	qryImpuesto.setSelect("iva, recargo");
	qryImpuesto.setFrom("impuestos");
	qryImpuesto.setWhere("codimpuesto = '" + codImpuesto + "'");
	try { qryImpuesto.setForwardOnly( true ); } catch (e) {}

	if (!qryImpuesto.exec()) {
		return false;
	}

	if (!qryImpuesto.first()) {
		return false;
	}

	datosImpuesto.iva = qryImpuesto.value("iva");
	datosImpuesto.recargo = qryImpuesto.value("recargo");
	return datosImpuesto;
}

function oficial_valorDefecto(fN)
{
	var _i = this.iface;
	var valor = AQUtil.sqlSelect("facturac_general", fN, "1 = 1");
	if (!valor) {
		return "";
	}
	return valor;
}

function oficial_actualizarArticulosProv(cursor)
{
	var _i = this.iface;

	var tablaDoc = cursor.table();
	var actualizarArtProv = flfacturac.iface.pub_valorDefecto("actualizarartprov");
	if ((tablaDoc == "albaranesprov" && actualizarArtProv != "Albaranes de proveedor") || (tablaDoc == "facturasprov" && actualizarArtProv != "Facturas de proveedor")) {
		return true;
	}
	var nTabla;
	var nClave;
	switch (tablaDoc) {
		case "albaranesprov": {
			nTabla = "lineasalbaranesprov";
			nClave = "idalbaran";
			break;
		}
		case "facturasprov": {
			nTabla = "lineasfacturasprov";
			nClave = "idfactura";
			break;
		}
	}

	var _i = this.iface;
	var codProveedor = cursor.valueBuffer("codproveedor");
	var nombreProv = cursor.valueBuffer("nombre");
	var codDivisa = cursor.valueBuffer("coddivisa");

	var qryLineas = new FLSqlQuery();
	qryLineas.setTablesList(nTabla);
	qryLineas.setSelect("referencia, pvpunitario");
	qryLineas.setFrom(nTabla);
	qryLineas.setWhere(nClave + " = " + cursor.valueBuffer(nClave));

	if (!qryLineas.exec()) {
		return false;
	}

	var curArtProv = new FLSqlCursor("articulosprov");
	var hayOtroArtProv, porDefecto, referencia;
	while (qryLineas.next()) {
		referencia = qryLineas.value("referencia");
		if (!referencia || referencia == "") {
			continue;
		}
		curArtProv.select("referencia = '" + referencia + "' AND codproveedor = '" + codProveedor + "'");
		if (!curArtProv.first()) {
			hayOtroArtProv = AQUtil.sqlSelect("articulosprov", "id", "referencia = '" + referencia + "'");
			porDefecto = (!hayOtroArtProv || isNaN(hayOtroArtProv)) ? true : false;
			curArtProv.setModeAccess(curArtProv.Insert);
			curArtProv.refreshBuffer();
			curArtProv.setValueBuffer("codproveedor", codProveedor);
			curArtProv.setValueBuffer("nombre", nombreProv);
			curArtProv.setValueBuffer("referencia", referencia);
			curArtProv.setValueBuffer("pordefecto", porDefecto);
		} else {
			curArtProv.setModeAccess(curArtProv.Edit);
			curArtProv.refreshBuffer();
		}
		curArtProv.setValueBuffer("coddivisa", codDivisa);
		curArtProv.setValueBuffer("coste", qryLineas.value("pvpunitario"));
		if (!curArtProv.commitBuffer()) {
			return false;
		}
	}

	return true;
}

function oficial_avisarObservacionesCliente(codCliente)
{
	var _i = this.iface;
	if (!codCliente || codCliente == "") {
		return true;
	}
	var aviso = _i.valorDefecto("avisocliente");
	if (aviso) {
		var observaciones = AQUtil.sqlSelect("clientes", "observaciones", "codcliente = '" + codCliente + "'");
		if (observaciones && observaciones != "") {
			sys.infoMsgBox(sys.translate("Aviso sobre el cliente %1:\n%2").arg(codCliente).arg(observaciones));
		}
	}
	return true;
}

function oficial_ponDatosFacturaRec(aDatosFR)
{
	var _i = this.iface;
	_i.aDatosFR_ = aDatosFR;
}

function oficial_dameDatosFacturaRec()
{
	var _i = this.iface;
	return _i.aDatosFR_;
}

function oficial_ponSeleccionLineas(valores)
{
	var _i = this.iface;
	_i.aLineasSel_ = valores;
}

function oficial_dameSeleccionLineas()
{
	var _i = this.iface;
	return _i.aLineasSel_;
}

function oficial_comprobarDuplicidadCodigoFacturaCli(curFactura)
{
	var _i = this.iface;

	while (AQUtil.sqlSelect("facturascli", "idfactura", "codejercicio = '" + curFactura.valueBuffer("codejercicio") + "' AND codserie = '" + curFactura.valueBuffer("codserie") + "' AND numero 	= '" + curFactura.valueBuffer("numero") + "' AND idfactura <> " + curFactura.valueBuffer("idfactura"))) {
		numero = _i.siguienteNumero(curFactura.valueBuffer("codserie"), curFactura.valueBuffer("codejercicio"), "nfacturacli");
		if (!numero)
			return false;
		curFactura.setValueBuffer("numero", numero);
		curFactura.setValueBuffer("codigo", formfacturascli.iface.pub_commonCalculateField("codigo", curFactura));
	}

	return true;
}
//// OFICIAL ////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
