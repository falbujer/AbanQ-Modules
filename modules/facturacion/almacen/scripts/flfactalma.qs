/***************************************************************************
                 flfactalma.qs  -  description
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
	function afterCommit_stocks(curStock:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_stocks(curStock);
	}
	function beforeCommit_stocks(curStock:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_stocks(curStock);
	}
	function beforeCommit_articulos(curA) {
		return this.ctx.interna_beforeCommit_articulos(curA);
	}
	function afterCommit_articulos(curA) {
		return this.ctx.interna_afterCommit_articulos(curA);
	}
	function beforeCommit_articulostarifas(curAT) {
		return this.ctx.interna_beforeCommit_articulostarifas(curAT);
	}
	function beforeCommit_tarifas(curT) {
		return this.ctx.interna_beforeCommit_tarifas(curT);
	}
	function afterCommit_lineastransstock(curLTS) {
		return this.ctx.interna_afterCommit_lineastransstock(curLTS);
	}
	function afterCommit_lineasregstocks(curLRS) {
		return this.ctx.interna_afterCommit_lineasregstocks(curLRS);
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {

	var tsSilent_, lastProgress_;
	var logName_;

	function oficial( context ) { interna( context ); }
	function cambiarStock(codAlmacen:String, referencia:String, variacion:Number, campo:String):Boolean {
		return this.ctx.oficial_cambiarStock(codAlmacen, referencia, variacion, campo);
	}
	function cambiarCosteMedio(referencia:String):Boolean {
		return this.ctx.oficial_cambiarCosteMedio(referencia);
	}
	function controlStockPedidosCli(curLP:FLSqlCursor):Boolean {
		return this.ctx.oficial_controlStockPedidosCli(curLP);
	}
	function controlStockPedidosProv(curLP:FLSqlCursor):Boolean {
		return this.ctx.oficial_controlStockPedidosProv(curLP);
	}
	function controlStockAlbaranesCli(curLA:FLSqlCursor):Boolean {
		return this.ctx.oficial_controlStockAlbaranesCli(curLA);
	}
	function controlStockAlbaranesProv(curLA:FLSqlCursor):Boolean {
		return this.ctx.oficial_controlStockAlbaranesProv(curLA);
	}
	function controlStockFacturasCli(curLF:FLSqlCursor):Boolean {
		return this.ctx.oficial_controlStockFacturasCli(curLF);
	}
	function controlStockComandasCli(curLV:FLSqlCursor):Boolean {
		return this.ctx.oficial_controlStockComandasCli(curLV);
	}
	function controlStockFacturasProv(curLF:FLSqlCursor):Boolean {
		return this.ctx.oficial_controlStockFacturasProv(curLF);
	}
	function crearStock(codAlmacen, oArticulo):Number {
		return this.ctx.oficial_crearStock(codAlmacen, oArticulo);
	}
	function controlStockLineasTrans(curLTS:FLSqlCursor):Boolean {
		return this.ctx.oficial_controlStockLineasTrans(curLTS);
	}
	function controlStockValesTPV(curLinea:FLSqlCursor):Boolean {
		return this.ctx.oficial_controlStockValesTPV(curLinea);
	}
	function controlStock( curLinea:FLSqlCursor, campo:String, signo:Number, codAlmacen:String ):Boolean {
		return this.ctx.oficial_controlStock( curLinea, campo, signo, codAlmacen );
	}
	function controlStockPteRecibir(curLinea:FLSqlCursor, codAlmacen:String):Boolean {
		return this.ctx.oficial_controlStockPteRecibir(curLinea, codAlmacen);
	}
	function actualizarStockPteRecibir(aArticulo:Array, codAlmacen:String, idPedido:String):Boolean {
		return this.ctx.oficial_actualizarStockPteRecibir(aArticulo, codAlmacen, idPedido);
	}
	function controlStockReservado(curLinea:FLSqlCursor, codAlmacen:String):Boolean {
		return this.ctx.oficial_controlStockReservado(curLinea, codAlmacen);
	}
	function actualizarStockReservado(aArticulo:Array, codAlmacen:String, idPedido:String):Boolean {
		return this.ctx.oficial_actualizarStockReservado(aArticulo, codAlmacen, idPedido);
	}
	function comprobarStock(curStock:FLSqlCursor):Boolean {
		return this.ctx.oficial_comprobarStock(curStock);
	}
	function valorDefectoAlmacen(fN:String):String {
		return this.ctx.oficial_valorDefectoAlmacen(fN);
	}
	function controlRegStock(curLRS) {
		return this.ctx.oficial_controlRegStock(curLRS);
	}
	function consistenciaLinea(curLinea) {
		return this.ctx.oficial_consistenciaLinea(curLinea);
	}
	function controlStockFisicoArticulos(curStock) {
		return this.ctx.oficial_controlStockFisicoArticulos(curStock);
	}
	function controlStockCabComandas(curComanda) {
		return this.ctx.oficial_controlStockCabComandas(curComanda);
	}
	function controlDatosMod(curT) {
		return this.ctx.oficial_controlDatosMod(curT);
	}
	function registrarCambioCursor(curT) {
		return this.ctx.oficial_registrarCambioCursor(curT);
	}
	function ponLogName(nombreLog) {
		return this.ctx.oficial_ponLogName(nombreLog);
	}
	function creaPDSilent(totalSteps) {
		return this.ctx.oficial_creaPDSilent(totalSteps);
	}
	function setProgressPDSilent(p) {
		return this.ctx.oficial_setProgressPDSilent(p);
	}
	function procesaStocks(usuario) {
		return this.ctx.oficial_procesaStocks(usuario);
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
	function pub_cambiarStock(codAlmacen:String, referencia:String, variacion:Number, campo:String, noAvisar:Boolean ):Boolean {
		return this.cambiarStock(codAlmacen, referencia, variacion,campo, noAvisar);
	}
	function pub_crearStock(codAlmacen, oArticulo):Number {
		return this.crearStock(codAlmacen, oArticulo);
	}
	function pub_cambiarCosteMedio(referencia:String):Boolean {
		return this.cambiarCosteMedio(referencia);
	}
	function pub_controlStockPedidosCli(curLP:FLSqlCursor):Boolean {
		return this.controlStockPedidosCli(curLP);
	}
	function pub_controlStockPedidosProv(curLP:FLSqlCursor):Boolean {
		return this.controlStockPedidosProv(curLP);
	}
	function pub_controlStockAlbaranesCli(curLA:FLSqlCursor):Boolean {
		return this.controlStockAlbaranesCli(curLA);
	}
	function pub_controlStockAlbaranesProv(curLA:FLSqlCursor):Boolean {
		return this.controlStockAlbaranesProv(curLA);
	}
	function pub_controlStockFacturasCli(curLF:FLSqlCursor):Boolean {
		return this.controlStockFacturasCli(curLF);
	}
	function pub_controlStockComandasCli(curLV:FLSqlCursor):Boolean {
		return this.controlStockComandasCli(curLV);
	}
	function pub_controlStockFacturasProv(curLF:FLSqlCursor):Boolean {
		return this.controlStockFacturasProv(curLF);
	}
	function pub_controlStockValesTPV(curLinea:FLSqlCursor):Boolean {
		return this.controlStockValesTPV(curLinea);
	}
	function pub_valorDefectoAlmacen(fN:String):String {
		return this.valorDefectoAlmacen(fN);
	}
	function pub_consistenciaLinea(curLinea) {
		return this.consistenciaLinea(curLinea);
	}
	function pub_controlStockCabComandas(curComanda){
		return this.controlStockCabComandas(curComanda);
	}
	function pub_controlDatosMod(curT) {
		return this.controlDatosMod(curT);
	}
	function pub_creaPDSilent(totalSteps) {
		return this.creaPDSilent(totalSteps);
	}
	function pub_setProgressPDSilent(p) {
		return this.setProgressPDSilent(p);
	}
	function pub_ponLogName(nombreLog) {
		return this.ponLogName(nombreLog);
	}
  function pub_procesaStocks(usuario) {
    return this.procesaStocks(usuario);
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
/** \D Si no hay ningún almacén en la tabla almacenes se inserta uno por defecto
\end */
function interna_init()
{
	var cursor:FLSqlCursor = new FLSqlCursor("almacenes");
	cursor.select();
	if (!cursor.first()) {
		var util:FLUtil = new FLUtil();
		sys.infoMsgBox(sys.translate("Se insertará un almacén por defecto para empezar a trabajar."));
		with (cursor) {
			setModeAccess(Insert);
			refreshBuffer();
			setValueBuffer("codalmacen","ALG");
			setValueBuffer("nombre", sys.translate("ALMACEN GENERAL"));
			commitBuffer();
		}
		cursor = new FLSqlCursor("empresa");
		cursor.select();
		if (cursor.first()) {
			with (cursor) {
				setModeAccess(cursor.Edit);
				refreshBuffer();
				if (!valueBuffer("codalmacen")) {
					setValueBuffer("codalmacen","ALG");
					commitBuffer();
				}
			}
		}
	}
}

function interna_beforeCommit_articulos(curA)
{
	var _i = this.iface;

	if (!_i.controlDatosMod(curA)) {
		return false;
	}

	return true;
}

function interna_beforeCommit_articulostarifas(curAT)
{
	var _i = this.iface;

	if (!_i.controlDatosMod(curAT)) {
		return false;
	}

	return true;
}

function interna_beforeCommit_tarifas(curT)
{
	var _i = this.iface;

	if (!_i.controlDatosMod(curT)) {
		return false;
	}

	return true;
}
/** \D
Actualiza el stock físico total en la tabla de artículos
\end */
function interna_afterCommit_stocks(curStock)
{
	var _i = this.iface;
	if (!_i.controlStockFisicoArticulos(curStock)) {
		return false;
	}
	return true;
}

function interna_afterCommit_articulos(curA)
{
	return true;
}

/** \D
Avisa al usuario en caso de querer borrar un stock con cantidad distinta de 0
\end */
function interna_beforeCommit_stocks(curStock)
{
	var util:FLUtil = new FLUtil;
	switch (curStock.modeAccess()) {
		case curStock.Del: {
			if (parseFloat(curStock.valueBuffer("cantidad")) != 0) {
				var res:Number = MessageBox.warning(sys.translate("Va a eliminar un registro de stock con cantidad distinta de 0.\n¿Está seguro?"), MessageBox.No, MessageBox.Yes);
				if (res != MessageBox.Yes)
					return false;
			}
			break;
		}
		default: {
			curStock.setValueBuffer("necesidad", formRecordregstocks.iface.pub_commonCalculateField("necesidad", curStock));
			break;
		}
	}
	return true;
}

function interna_afterCommit_lineastransstock(curLTS:FLSqlCursor):Boolean {
	return this.iface.controlStockLineasTrans(curLTS);
}

function interna_afterCommit_lineasregstocks(curLRS)
{
debug("interna_afterCommit_lineasregstocks");
	if (!this.iface.controlRegStock(curLRS)) {
		return false;
	}
	return true;
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D Cambia el valor del stock en un determinado almacén. Se comprueba si el valor de la variación es negativo y mayor al stock actual, en cuyo caso se avisa al usuario de la falta de existencias

@param codAlmacen Código del almacén
@param referencia Referencia del artículo
@param variación Variación en el número de existencias del artículo
@param	campo: Nombre del campo a modificar. Si el campo es vacío o es --cantidad-- se llama a la función padre
@return True si la modificación tuvo éxito, false en caso contrario
\end */
function oficial_cambiarStock(codAlmacen:String, referencia:String, variacion:Number, campo:String, noAvisar:Boolean ):Boolean
{
	var util:FLUtil = new FLUtil();
	if (referencia == "" || !referencia) {
		return true;
	}

	if (codAlmacen == "" || !codAlmacen) {
		return true;
	}

	if ( !campo || campo == "") {
		return false;
	}

	var idStock:String;
	idStock = util.sqlSelect("stocks", "idstock", "referencia = '" + referencia + "' AND codalmacen = '" + codAlmacen + "'");
	if ( !idStock ) {
		var oArticulo = new Object;
		oArticulo["referencia"] = referencia;
		idStock = this.iface.crearStock( codAlmacen, oArticulo );
		if ( !idStock ) {
			return false;
		}
	}
	var curStock:FLSqlCursor = new FLSqlCursor( "stocks" );
	curStock.select( "idstock = " + idStock );
	if ( !curStock.first() ) {
		return false;
	}

	curStock.setModeAccess( curStock.Edit );
	curStock.refreshBuffer();

	var cantidadPrevia:Number = parseFloat( curStock.valueBuffer( campo ) );
	var nuevaCantidad:Number = cantidadPrevia + parseFloat( variacion );

// 	if (nuevaCantidad < 0 && campo == "cantidad") {
// 		if (!util.sqlSelect("articulos", "controlstock", "referencia = '" + referencia + "'")) {
// 			MessageBox.warning( util.translate("scripts", "El artículo %1 no permite ventas sin stock. Este movimiento dejaría el stock de %2 con cantidad %3.\n").arg(referencia).arg(codAlmacen).arg(nuevaCantidad), MessageBox.Ok, MessageBox.NoButton);
// 			return false;
// 		}
// 	}

	curStock.setValueBuffer( campo, nuevaCantidad );
	if (campo == "cantidad" || campo == "reservada") {
		curStock.setValueBuffer("disponible", formRecordregstocks.iface.pub_commonCalculateField("disponible", curStock));
	}

	if (!this.iface.comprobarStock(curStock)) {
		return false;
	}

	if ( !curStock.commitBuffer() ) {
		return false;
	}

	return true;
}

/** \D Comprueba, en el caso de que el artículo no permita ventas sin stock, si el stock que se va a guardar incumple dicha condición
@param	curStock: Cursor a guardar
@return	True si la comprobación es correcta, false en caso contrario
\end */
function oficial_comprobarStock(curStock:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	var referencia:String = curStock.valueBuffer("referencia");
	var codAlmacen:String = curStock.valueBuffer("codalmacen");
	if (util.sqlSelect("articulos", "controlstock", "referencia = '" + referencia + "'")) {
		return true;
	}

	var stockPedidos:Boolean = flfactppal.iface.pub_valorDefectoEmpresa("stockpedidos");

	var cantidadControl:Number;
	if (stockPedidos) {
		cantidadControl = curStock.valueBuffer("disponible");
	} else {
		cantidadControl = curStock.valueBuffer("cantidad");
	}
	if (cantidadControl < 0) {
		var nombreCantidad:String;
		if (stockPedidos) {
			nombreCantidad = sys.translate("cantidad disponible");
		} else {
			nombreCantidad = sys.translate("cantidad en stock");
		}
		if (!util.sqlSelect("articulos", "controlstock", "referencia = '" + referencia + "'")) {
			sys.warnMsgBox(sys.translate("El artículo %1 no permite ventas sin stock. Este movimiento dejaría el stock de %2 con %3 %4.\n").arg(referencia).arg(codAlmacen).arg(nombreCantidad).arg(cantidadControl));
			return false;
		}
	}
	return true;
}

/** \D Recalcula el coste medio de compra de un artículo como media del coste en todos los albaranes de proveedor

@param referencia Referencia del artículo
@return True si la modificación tuvo éxito, false en caso contrario
\end */
function oficial_cambiarCosteMedio(referencia:String):Boolean
{
	if (referencia == "")
		return true;

	var util:FLUtil = new FLUtil();
	var sumCant:Number = util.sqlSelect("lineasfacturasprov", "SUM(cantidad)", "referencia = '" + referencia + "'");
	if ( !sumCant )
		return true;
	var cM:Number = util.sqlSelect("lineasfacturasprov", "(SUM(pvptotal) / SUM(cantidad))", "referencia = '" + referencia + "'");
	if (!cM)
		cM = 0;

	var curArticulo:FLSqlCursor = new FLSqlCursor("articulos");
	curArticulo.select("referencia = '" + referencia + "'");
	if (curArticulo.first()) {
		curArticulo.setModeAccess(curArticulo.Edit);
		curArticulo.refreshBuffer();
		curArticulo.setValueBuffer("costemedio", cM);
		curArticulo.commitBuffer();
	}

	return true;
}

/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea
\end */
function oficial_controlStockPedidosCli(curLP:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLP.valueBuffer("referencia") + "'")) {
		return true;
	}

	var codAlmacen:String;
	var curRel:FLSqlCursor = curLP.cursorRelation();
	if (curRel && curRel.table() == "pedidoscli") {
		codAlmacen = curRel.valueBuffer("codalmacen");
	} else {
		codAlmacen = util.sqlSelect("pedidoscli", "codalmacen", "idpedido = " + curLP.valueBuffer("idpedido"));
	}
	if (!codAlmacen || codAlmacen == "") {
		return true;
	}

	if (!this.iface.controlStockReservado(curLP, codAlmacen)) {
		return false;
	}
	return true;
}

/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea
en caso de que no venga de un pedido, o que la opción general de control
de stocks en pedidos esté inhabilitada
\end */
function oficial_controlStockAlbaranesCli(curLA:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();

	if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLA.valueBuffer("referencia") + "'")) {
		return true;
	}

	var codAlmacen:String;
	var curRel:FLSqlCursor = curLA.cursorRelation();
	if (curRel && curRel.table() == "albaranescli") {
		codAlmacen = curRel.valueBuffer("codalmacen");
	} else {
		codAlmacen = util.sqlSelect("albaranescli", "codalmacen", "idalbaran = " + curLA.valueBuffer("idalbaran"));
	}
	if (!codAlmacen || codAlmacen == "") {
		return true;
	}


	if (!this.iface.controlStock( curLA, "cantidad", -1, codAlmacen )) {
		return false;
	}

	return true;
}

/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea
\end */
function oficial_controlStockFacturasCli(curLF:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();

	if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLF.valueBuffer("referencia") + "'")) {
		return true;
	}
	if (util.sqlSelect("facturascli", "automatica", "idfactura = " + curLF.valueBuffer("idfactura"))) {
		return true;
	}

	var codAlmacen:String;
	var curRel:FLSqlCursor = curLF.cursorRelation();
	if (curRel && curRel.table() == "facturascli") {
		codAlmacen = curRel.valueBuffer("codalmacen");
	} else {
		codAlmacen = util.sqlSelect("facturascli", "codalmacen", "idfactura = " + curLF.valueBuffer("idfactura"));
	}
	if (!codAlmacen || codAlmacen == "") {
		return true;
	}
	if (!this.iface.controlStock(curLF, "cantidad", -1, codAlmacen)) {
		return false;
	}
	return true;
}

/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea
\end */
function oficial_controlStockComandasCli(curLV:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();

	if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLV.valueBuffer("referencia") + "'")) {
		return true;
	}

	var codAlmacen = util.sqlSelect("tpv_comandas c INNER JOIN tpv_puntosventa pv ON c.codtpv_puntoventa = pv.codtpv_puntoventa", "pv.codalmacen", "idtpv_comanda = " + curLV.valueBuffer("idtpv_comanda"), "tpv_comandas,tpv_puntosventa");
	if (!codAlmacen || codAlmacen == "") {
		return true;
	}
debug("restando por venta");
	if (!this.iface.controlStock(curLV, "cantidad", -1, codAlmacen)) {
		return false;
	}

	return true;
}

/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea
\end */
function oficial_controlStockPedidosProv(curLP:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLP.valueBuffer("referencia") + "'")) {
		return true;
	}

	var codAlmacen:String;
	var curRel:FLSqlCursor = curLP.cursorRelation();
	if (curRel && curRel.table() == "pedidosprov") {
		codAlmacen = curRel.valueBuffer("codalmacen");
	} else {
		codAlmacen = util.sqlSelect("pedidosprov", "codalmacen", "idpedido = " + curLP.valueBuffer("idpedido"));
	}
	if (!codAlmacen || codAlmacen == "") {
		return true;
	}

	if (!this.iface.controlStockPteRecibir(curLP, codAlmacen)) {
		return false;
	}

	return true;
}

/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea
\end */
function oficial_controlStockAlbaranesProv(curLA:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();

	if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLA.valueBuffer("referencia") + "'")) {
		return true;
	}
	var codAlmacen:String;
	var curRel:FLSqlCursor = curLA.cursorRelation();
	if (curRel && curRel.table() == "albaranesprov") {
		codAlmacen = curRel.valueBuffer("codalmacen");
	} else {
		codAlmacen = util.sqlSelect("albaranesprov", "codalmacen", "idalbaran = " + curLA.valueBuffer("idalbaran"));
	}
	if (!codAlmacen || codAlmacen == "") {
		return true;
	}

	if (!this.iface.controlStock(curLA, "cantidad", 1, codAlmacen)) {
		return false;
	}
	return true;
}

/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea
\end */
function oficial_controlStockFacturasProv(curLF:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLF.valueBuffer("referencia") + "'")) {
		return true;
	}
	if (util.sqlSelect("facturasprov", "automatica", "idfactura = " + curLF.valueBuffer("idfactura"))) {
		return true;
	}
	var codAlmacen:String;
	var curRel:FLSqlCursor = curLF.cursorRelation();
	if (curRel && curRel.table() == "facturasprov") {
		codAlmacen = curRel.valueBuffer("codalmacen");
	} else {
		codAlmacen = util.sqlSelect("facturasprov", "codalmacen", "idfactura = " + curLF.valueBuffer("idfactura"));
	}
	if (!codAlmacen || codAlmacen == "") {
		return true;
	}

	if (!this.iface.controlStock(curLF, "cantidad", 1, codAlmacen)) {
		return false;
	}
	return true;
}

/** \D Crea un registro de stock para el almacén y artículo especificados
@param	codAlmacen: Almacén
@param	oArticulo: Objeto con los datos identificativos del artículo
@return	identificador del stock o false si hay error
\end */
function oficial_crearStock(codAlmacen, oArticulo):Number
{
	var util:FLUtil = new FLUtil;
	var curStock:FLSqlCursor = new FLSqlCursor("stocks");
	with(curStock) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("codalmacen", codAlmacen);
		setValueBuffer("referencia", oArticulo.referencia);
		setValueBuffer("nombre", util.sqlSelect("almacenes", "nombre", "codalmacen = '" + codAlmacen + "'"));
		setValueBuffer("cantidad", 0);
		if (!commitBuffer())
			return false;
	}
	return curStock.valueBuffer("idstock");
}

/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea
\end */
function oficial_controlStockLineasTrans(curLTS:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	var codAlmacenOrigen:String = util.sqlSelect("transstock", "codalmaorigen", "idtrans = " + curLTS.valueBuffer("idtrans"));
	if (!codAlmacenOrigen || codAlmacenOrigen == "")
		return true;

	var codAlmacenDestino:String = util.sqlSelect("transstock", "codalmadestino", "idtrans = " + curLTS.valueBuffer("idtrans"));
	if (!codAlmacenDestino || codAlmacenDestino == "")
		return true;

	if (!this.iface.controlStock(curLTS, "cantidad", -1, codAlmacenOrigen))
			return false;

	if (!this.iface.controlStock(curLTS, "cantidad", 1, codAlmacenDestino))
			return false;

	return true;
}

/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea
\end */
function oficial_controlStockValesTPV(curLinea:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();

	if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLinea.valueBuffer("referencia") + "'"))
		return true;

	var codAlmacen:String = curLinea.valueBuffer("codalmacen");
	if (!codAlmacen || codAlmacen == "")
		return true;

	if (!this.iface.controlStock(curLinea, "cantidad", 1, codAlmacen))
			return false;

	return true;
}

function oficial_controlStockCabComandas(curComanda)
{
	var _i = this.iface;
	if (curComanda.modeAccess() != curComanda.Edit) {
		return true;
	}
	var tipoDocAct = curComanda.valueBuffer("tipodoc");
	var tipoDocAnt = curComanda.valueBufferCopy("tipodoc");

	debug("oficial_controlStockCabComandas tipoDocAct: " + tipoDocAct);
	debug("oficial_controlStockCabComandas tipoDocAnt: " + tipoDocAnt);

	if (!tipoDocAct == tipoDocAnt) {
		return true;
	}
	if (tipoDocAct != "PRESUPUESTO" && tipoDocAnt != "PRESUPUESTO"){
		return true;
	}
	var cantidad, referencia;
	var curLineaComanda = new FLSqlCursor("tpv_lineascomanda");
	curLineaComanda.select("idtpv_comanda = " + curComanda.valueBuffer("idtpv_comanda"));
	while (curLineaComanda.next()) {
		curLineaComanda.setModeAccess(curLineaComanda.Browse);
		curLineaComanda.refreshBuffer();
    referencia = curLineaComanda.valueBuffer("referencia");
		if (!referencia) {
			continue;
		}
		cantidad = curLineaComanda.valueBuffer("cantidad");
		if (tipoDocAct != "PRESUPUESTO") {
			cantidad *= -1;
		}
		if (!_i.cambiarStock(curComanda.valueBuffer("codalmacen"), curLineaComanda.valueBuffer("referencia"), cantidad, "cantidad")) {
			return false;
		}
	}
	return true;
}

/** \D Incrementa o decrementa el stock en función de la variación experimentada por una línea de documento de facturación
@param	curLinea: Cursor posicionado en la línea de documento de facturación
@param	campo: Campo a modificar
@param	operación: Indica si la cantidad debe sumarse o restarse del stock
@param	codAlmacen: Código del almacén asociado al stock a modificar
@return	True si el control se realiza correctamente, false en caso contrario
*/
function oficial_controlStock( curLinea:FLSqlCursor, campo:String, signo:Number, codAlmacen:String ):Boolean
{
	var variacion:Number;
	var cantidad:Number = parseFloat( curLinea.valueBuffer( "cantidad" ) );
	var cantidadPrevia:Number = parseFloat( curLinea.valueBufferCopy( "cantidad" ) );

	if ( curLinea.table() == "lineaspedidoscli" || curLinea.table() == "lineaspedidosprov" ) {
		cantidad -= parseFloat( curLinea.valueBuffer( "totalenalbaran" ) );
		cantidadPrevia -= parseFloat( curLinea.valueBufferCopy( "totalenalbaran" ) );
	}

	switch(curLinea.modeAccess()) {
		case curLinea.Insert: {
			variacion = signo * cantidad;
			if ( !this.iface.cambiarStock( codAlmacen, curLinea.valueBuffer( "referencia" ), variacion, campo ) )
				return false;
			break;
		}
		case curLinea.Del: {
			variacion = signo * -1 * cantidad;
			if ( !this.iface.cambiarStock( codAlmacen, curLinea.valueBuffer( "referencia" ), variacion, campo ) )
				return false;
			break;
		}
		case curLinea.Edit: {
			if (curLinea.valueBuffer( "referencia" ) != curLinea.valueBufferCopy( "referencia" )) {
				variacion = signo * -1 * cantidadPrevia;
				if ( !this.iface.cambiarStock( codAlmacen, curLinea.valueBufferCopy( "referencia" ), variacion, campo ) )
					return false;
				variacion = signo * cantidad;
				if ( !this.iface.cambiarStock( codAlmacen, curLinea.valueBuffer( "referencia" ), variacion, campo, true ) )
					return false;
			}
			else {
				if(cantidad != cantidadPrevia);
				variacion = (cantidad - cantidadPrevia) * signo;
				if (!this.iface.cambiarStock( codAlmacen, curLinea.valueBuffer( "referencia" ), variacion, campo) )
					return false;
			}
			break;
		}
	}

	return true;
}

function oficial_controlStockPteRecibir(curLinea:FLSqlCursor, codAlmacen:String):Boolean
{
	var util:FLUtil = new FLUtil;

	var idPedido:String = curLinea.valueBuffer("idpedido");
	var aArticulo:Array = [];
	aArticulo["referencia"] = curLinea.valueBuffer("referencia");
	if (aArticulo["referencia"] && aArticulo["referencia"] != "") {
		if (!this.iface.actualizarStockPteRecibir(aArticulo, codAlmacen, idPedido)) {
			return false;
		}
	}

	var aArticuloPrevio:Array = [];
	aArticuloPrevio["referencia"] = curLinea.valueBufferCopy("referencia");
	if (aArticuloPrevio["referencia"] && aArticuloPrevio["referencia"] != "" && aArticuloPrevio["referencia"] != aArticulo["referencia"]) {
		if (!this.iface.actualizarStockPteRecibir(aArticuloPrevio, codAlmacen, idPedido)) {
			return false;
		}
	}

	return true;
}

function oficial_actualizarStockPteRecibir(aArticulo:Array, codAlmacen:String, idPedido:String):Boolean
{
	var util:FLUtil = new FLUtil;

	var referencia:String = aArticulo["referencia"];
	var idStock:String = util.sqlSelect("stocks", "idstock", "referencia = '" + referencia + "' AND codalmacen = '" + codAlmacen + "'");
	if ( !idStock ) {
		idStock = this.iface.crearStock( codAlmacen, aArticulo );
		if ( !idStock ) {
			return false;
		}
	}
	var pteRecibir:Number = util.sqlSelect("lineaspedidosprov lp INNER JOIN pedidosprov p ON lp.idpedido = p.idpedido", "sum(lp.cantidad - lp.totalenalbaran)", "p.codalmacen = '" + codAlmacen + "' AND (p.servido IN ('No', 'Parcial') OR p.idpedido = " + idPedido + ") AND lp.referencia = '" + referencia + "' AND (lp.cerrada IS NULL OR lp.cerrada = false)", "lineaspedidosprov,pedidosprov");

	if (isNaN(pteRecibir)) {
		pteRecibir = 0;
	}

	var curStock:FLSqlCursor = new FLSqlCursor("stocks");
	curStock.select("idstock = " + idStock);
	if (!curStock.first()) {
		return false;
	}
	curStock.setModeAccess(curStock.Edit);
	curStock.refreshBuffer();
	curStock.setValueBuffer("pterecibir", pteRecibir);
	if (!curStock.commitBuffer()) {
		return false;
	}
	return true;
}

function oficial_controlStockReservado(curLinea:FLSqlCursor, codAlmacen:String):Boolean
{
	var util:FLUtil = new FLUtil;

	var idPedido:String = curLinea.valueBuffer("idpedido");
	var aArticulo:Array = [];
	aArticulo["referencia"] = curLinea.valueBuffer("referencia");
	if (aArticulo["referencia"] && aArticulo["referencia"] != "") {
		if (!this.iface.actualizarStockReservado(aArticulo, codAlmacen, idPedido)) {
			return false;
		}
	}

	var aArticuloPrevio:Array = [];
	aArticuloPrevio["referencia"] = curLinea.valueBufferCopy("referencia");
	if (aArticuloPrevio["referencia"] && aArticuloPrevio["referencia"] != "" && aArticuloPrevio["referencia"] != aArticulo["referencia"]) {
		if (!this.iface.actualizarStockReservado(aArticuloPrevio, codAlmacen, idPedido)) {
			return false;
		}
	}

	return true;
}

function oficial_actualizarStockReservado(aArticulo:Array, codAlmacen:String, idPedido:String):Boolean
{
	var util:FLUtil = new FLUtil;

	var referencia:Array = aArticulo["referencia"];
	var idStock:String = util.sqlSelect("stocks", "idstock", "referencia = '" + referencia + "' AND codalmacen = '" + codAlmacen + "'");
	if ( !idStock ) {
		idStock = this.iface.crearStock( codAlmacen, aArticulo );
		if ( !idStock ) {
			return false;
		}
	}

	var reservada:Number = util.sqlSelect("lineaspedidoscli lp INNER JOIN pedidoscli p ON lp.idpedido = p.idpedido", "sum(lp.cantidad - lp.totalenalbaran)", "p.codalmacen = '" + codAlmacen + "' AND (p.servido IN ('No', 'Parcial') OR p.idpedido = " + idPedido + ") AND lp.referencia = '" + referencia + "' AND (lp.cerrada IS NULL OR lp.cerrada = false)", "lineaspedidoscli,pedidoscli");
	if (isNaN(reservada)) {
		reservada = 0;
	}

	var curStock:FLSqlCursor = new FLSqlCursor("stocks");
	curStock.select("idstock = " + idStock);
	if (!curStock.first()) {
		return false;
	}
	curStock.setModeAccess(curStock.Edit);
	curStock.refreshBuffer();
	curStock.setValueBuffer("reservada", reservada);
	curStock.setValueBuffer("disponible", formRecordregstocks.iface.pub_commonCalculateField("disponible", curStock));
	if (!this.iface.comprobarStock(curStock)) {
		return false;
	}
	if (!curStock.commitBuffer()) {
		return false;
	}
	return true;
}

function oficial_valorDefectoAlmacen(fN:String):String
{
	var query:FLSqlQuery = new FLSqlQuery();

	query.setTablesList( "factalma_general" );
	query.setForwardOnly( true );
	query.setSelect( fN );
	query.setFrom( "factalma_general" );
	if ( query.exec() ) {
		if ( query.next() ) {
			return query.value( 0 );
		}
	}

	return "";
}

function oficial_controlRegStock(curLRS)
{
debug("oficial_controlRegStock");
	var curRel = curLRS.cursorRelation();
	if (curRel && curRel.table() == "stocks") {
		return true;
	}
	var curStock = new FLSqlCursor("stocks");
	curStock.select("idstock = " + curLRS.valueBuffer("idstock"));
	if (!curStock.first()) {
debug("idstock = " + curLRS.valueBuffer("idstock"));
		return false;
	}
	curStock.setModeAccess(curStock.Edit);
	curStock.refreshBuffer();

	var fechaUltReg:String = formRecordregstocks.iface.commonCalculateField("fechaultreg", curStock);
	if (fechaUltReg) {
		curStock.setValueBuffer("fechaultreg", fechaUltReg);
		curStock.setValueBuffer("horaultreg", formRecordregstocks.iface.commonCalculateField("horaultreg", curStock));
		curStock.setValueBuffer("cantidadultreg", formRecordregstocks.iface.commonCalculateField("cantidadultreg", curStock));
	} else {
		curStock.setNull("fechaultreg");
		curStock.setNull("horaultreg");
		curStock.setValueBuffer("cantidadultreg", 0);
	}
	curStock.setValueBuffer("cantidad", formRecordregstocks.iface.commonCalculateField("cantidad", curStock));
	curStock.setValueBuffer("disponible", formRecordregstocks.iface.commonCalculateField("disponible", curStock));
	if (!curStock.commitBuffer()) {
		debug("!curStock.commitBuffer");
		return false;
	}
	return true;
}

function oficial_consistenciaLinea(curLinea)
{
	return true;
}

function oficial_controlStockFisicoArticulos(curStock)
{
	var referencia = curStock.valueBuffer("referencia");
	var stockFisico = AQUtil.sqlSelect("stocks", "SUM(cantidad)", "referencia = '" + referencia + "'");
	var curA = new FLSqlCursor("articulos");
	curA.setActivatedCommitActions(false);
	switch (curStock.modeAccess()) {
		case curStock.Edit: {
			var refAnterior = curStock.valueBufferCopy("referencia");
			if (referencia != refAnterior) {
				curA.select("referencia = '" + refAnterior + "'");
				if (curA.first()) {
					curA.setModeAccess(curA.Edit);
					curA.refreshBuffer();
					curA.setValueBuffer("stockfis", stockFisico);
					if (!curA.commitBuffer()) {
						return false;
					}
				}
			}
		}
		case curStock.Insert:
		case curStock.Del: {
			curA.select("referencia = '" + referencia + "'");
			if (curA.first()) {
				curA.setModeAccess(curA.Edit);
				curA.refreshBuffer();
				curA.setValueBuffer("stockfis", stockFisico);
				if (!curA.commitBuffer()) {
					return false;
				}
			}
			break;
		}
	}
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
		case "articulos": {
			return true;
		}
		default: {
			return true;
		}
	}
	return true;
}

function oficial_ponLogName(nombreLog)
{
	var _i = this.iface;
	_i.logName_ = nombreLog;

	return nombreLog;
}

function oficial_creaPDSilent(totalSteps)
{
	var _i = this.iface;
	_i.tsSilent_ = totalSteps;
	_i.lastProgress_ = 0;
}

function oficial_setProgressPDSilent(p)
{
	var _i = this.iface;
	if (!_i.tsSilent_) {
		return;
	}
	var progreso = Math.round((p / _i.tsSilent_) * 100);
	if ((progreso - _i.lastProgress_) > 2) {
		var totalC = Math.round(progreso / 2);
		var linea = "";
		for (var c = 0; c < totalC; c++) {
			linea += "*";
		}
		linea += " " + progreso.toString() + "%";
		if(!flfactppal.iface.pub_appendTextToLogFile(_i.logName_, linea)){
			sys.infoMsgBox(linea);
		}
		_i.lastProgress_ = progreso;
	}
}

function oficial_procesaStocks(usuario)
{
	var idUsuario = usuario ? usuario : sys.nameUser();

	var _i = this.iface;

	var curSP = new FLSqlCursor("stocksptes");
	curSP.select("idusuario = '" + idUsuario + "'");
	var idStock;

	var p = 0;
	while (curSP.next()) {
		curSP.setModeAccess(curSP.Del);
		curSP.refreshBuffer();
		idStock = curSP.valueBuffer("idstock");
		debug("procesando stock " + idStock);
		switch (curSP.valueBuffer("tipoactualizacion")) {
			case "STOCK_FISICO": {
				if (!_i.actualizarStockT0(idStock)) {
					return false;
				}
				break;
			}
			case "PTE_SERVIR": {
				if (!_i.revisarReservasStock(idStock)) {
					return false;
				}
				break;
			}
			case "PTE_RECIBIR": {
				if (!_i.actualizarStockPteRecibirT0(idStock)) {;
					return false;
				}
				break;
			}
		}
		debug("Commit Stock Pte");
		if (!curSP.commitBuffer()) {
			debug("Error al procesar stock pte " + idStock);
			return false;
		}
		debug("Commit Stock Pte OK");
	}
debug("Commit Stock Pte OK TODO");
	return true;
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
