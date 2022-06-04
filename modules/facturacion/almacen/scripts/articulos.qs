/***************************************************************************
                 articulos.qs  -  description
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
	function calculateField(fN:String):String { return this.ctx.interna_calculateField(fN); }
	function validateForm():Boolean {return this.ctx.interna_validateForm();}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var ejercicioActual:String;
	var longSubcuenta:Number;
	var bloqueoSubcuenta:Boolean;
	var posActualPuntoSubcuenta:Number;
	var posActualPuntoSubcuentaIRPF:Number;
	var tbnProvDefecto:Object;

	function oficial( context ) { interna( context ); }
	function generarArticulosTarifas() {
		return this.ctx.oficial_generarArticulosTarifas();
	}
	function calcularStockFisico() {
		return this.ctx.oficial_calcularStockFisico();
	}
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function genCodBar(fN:String) {
		return this.ctx.oficial_genCodBar(fN);
	}
	function eliminarStock():Boolean {
		return this.ctx.oficial_eliminarStock();
	}
	function borrarDatosStock(referencia:String):Boolean {
		return this.ctx.oficial_borrarDatosStock(referencia);
	}
	function marcarProvDefecto() {
		return this.ctx.oficial_marcarProvDefecto();
	}
	function establecerProveedorDefecto(referencia:String, codProveedor:String):Boolean {
		return this.ctx.oficial_establecerProveedorDefecto(referencia, codProveedor);
	}
	function establecerDatosAlta() {
		return this.ctx.oficial_establecerDatosAlta();
	}
	function iniciaVentas() {
		return this.ctx.oficial_iniciaVentas();
	}
	function iniciaCompras() {
		return this.ctx.oficial_iniciaCompras();
	}
	function columnasVentas() {
		return this.ctx.oficial_columnasVentas();
	}
	function columnasCompras() {
		return this.ctx.oficial_columnasCompras();
	}
	function commonCalculateField(fN, cursor) {
		return this.ctx.oficial_commonCalculateField(fN, cursor);
	}
	function formReady() {
		return this.ctx.oficial_formReady();
	}
	function iniciaHistoricos() {
		return this.ctx.oficial_iniciaHistoricos();
	}
	function detalleHistoricoCA() {
		return this.ctx.oficial_detalleHistoricoCA();
	}
	function detalleHistoricoCF() {
		return this.ctx.oficial_detalleHistoricoCF();
	}
	function detalleHistoricoVA() {
		return this.ctx.oficial_detalleHistoricoVA();
	}
	function detalleHistoricoVF() {
		return this.ctx.oficial_detalleHistoricoVF();
	}
	function totalizaCA() {
		return this.ctx.oficial_totalizaCA();
	}
	function totalizaCF() {
		return this.ctx.oficial_totalizaCF();
	}
	function totalizaVA() {
		return this.ctx.oficial_totalizaVA();
	}
	function totalizaVF() {
		return this.ctx.oficial_totalizaVF();
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
	function pub_establecerProveedorDefecto(referencia:String, codProveedor:String):Boolean {
		return this.establecerProveedorDefecto(referencia, codProveedor);
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
/** \C El valor de --stockfis-- se calcula automáticamente para cada artículo como la suma de existencias del artículo en todos los almacenes.
\end */
function interna_init()
{
	var _i = this.iface;
	var util = new FLUtil();
	var cursor = this.cursor();

	this.iface.tbnProvDefecto = this.child("tbnProvDefecto");
	if (this.iface.tbnProvDefecto)
	    connect (this.iface.tbnProvDefecto, "clicked()", this, "iface.marcarProvDefecto");
	if (this.child("pbnGenerarArticulosTarifas"))
		connect(this.child("pbnGenerarArticulosTarifas"), "clicked()", this, "iface.generarArticulosTarifas");
	if (this.child("tdbStocks"))
		connect(this.child("tdbStocks").cursor(), "cursorUpdated()", this, "iface.calcularStockFisico()");

	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this, "formReady()", _i, "formReady");

	switch (cursor.modeAccess()) {
		case cursor.Insert: {
			this.iface.establecerDatosAlta();
			break;
		}
		case cursor.Browse: {
			sys.disableObj(this, "pbnGenerarArticulosTarifas");
			break;
		}
		case cursor.Edit: {
			if (cursor.valueBuffer("nostock")) {
				this.child("tbwArticulo").setTabEnabled("stocks", false);
			} else {
				this.child("tbwArticulo").setTabEnabled("stocks", true);
			}
			break;
		}
	}
	this.iface.genCodBar("codbarras");

	this.iface.bufferChanged("secompra");
	this.iface.bufferChanged("sevende");

	if (sys.isLoadedModule("flcontppal")) {
		this.iface.ejercicioActual = flfactppal.iface.pub_ejercicioActual();
		this.iface.longSubcuenta = util.sqlSelect("ejercicios", "longsubcuenta", "codejercicio = '" + this.iface.ejercicioActual + "'");
		this.iface.bloqueoSubcuenta = false;
		this.iface.posActualPuntoSubcuenta = -1;
		if (this.child("fdbIdSubcuentaCom"))
			this.child("fdbIdSubcuentaCom").setFilter("codejercicio = '" + this.iface.ejercicioActual + "'");
		if (this.child("fdbIdSubcuentaIrpfCom"))
			this.child("fdbIdSubcuentaIrpfCom").setFilter("codejercicio = '" + this.iface.ejercicioActual + "'");
	} else{
		this.child("tbwArticulo").setTabEnabled("contabilidad", false);
	}
	if (sys.isLoadedModule("flfact_tpv")) {
		this.child("tbwArticulo").setTabEnabled("tpv", true);
	} else {
		this.child("tbwArticulo").setTabEnabled("tpv", false);
	}
	_i.iniciaVentas()
	_i.iniciaCompras()
}

function interna_calculateField(fN)
{
	var _i = this.iface;
	var cursor = this.cursor();
	var valor;

	switch (fN) {
		case "stockfis": {
			valor = AQUtil.sqlSelect("stocks", "SUM(cantidad)",  "referencia= '" + cursor.valueBuffer("referencia") + "'");
			break;
		}
		default: {
			valor = _i.commonCalculateField(fN, cursor);
			break;
		}
	}

	return valor;
}

function interna_validateForm():Boolean
{
	return true;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_commonCalculateField(fN,cursor)
{
	return "";
}

/** \D Genera las líneas de tarifas para un determinado artículo mediante el pvp base y los incrementos de cada tarifa. Cada línea contiene la referencia del artículo, el código de tarifa y el precio calculado para la tarifa.
\end */
function oficial_generarArticulosTarifas()
{
		var cursor:FLSqlCursor = this.cursor();
		var referencia:String = cursor.valueBuffer("referencia");
		var pvp:Number = cursor.valueBuffer("pvp");
		var codTarifa:String;
		var incLineal:Number;
		var incPorcentual:Number;
		var pvpTarifa:Number;

		var curArtTar:FLSqlCursor = this.child("tdbArticulosTarifas").cursor()
		var qryTarifas:FLSqlQuery = new FLSqlQuery();

/** \D Los incrementos lineal y porcentual de la tarifa sobre el precio base pueden acumularse
Las tarifas del artículo son eliminadas y regeneradas después
\end */
		qryTarifas.setTablesList("tarifas");
		qryTarifas.setSelect("codtarifa,inclineal,incporcentual");
		qryTarifas.setFrom("tarifas");

		qryTarifas.exec();
		while (qryTarifas.next()) {
			codTarifa = qryTarifas.value(0);
			with(curArtTar) {
				select("referencia = '" + referencia + "' AND codtarifa = '" + codTarifa + "'");
				if (first()) {
					setModeAccess(Del);
					refreshBuffer();
					commitBuffer();
				}
			}
		}

		qryTarifas.exec();
		while (qryTarifas.next()) {
			codTarifa = qryTarifas.value(0);
			incLineal = parseFloat(qryTarifas.value(1));
			incPorcentual = parseFloat(qryTarifas.value(2));
			pvpTarifa = ((pvp * (100 + incPorcentual)) / 100) + incLineal;
			with(curArtTar) {
				setModeAccess(Insert);
				refreshBuffer();
				setValueBuffer("referencia", referencia);
				setValueBuffer("codtarifa", codTarifa);
				setValueBuffer("pvp", pvpTarifa);
				commitBuffer();
			}
		}

		this.child("tdbArticulosTarifas").refresh();
}

/** \D Informa el campo --stockfis--
\end */
function oficial_calcularStockFisico()
{
		this.child("fdbStockFisico").setValue(this.iface.calculateField("stockfis"));
}

function oficial_bufferChanged(fN:String)
{
	var cursor:FLSqlCursor = this.cursor();

	switch (fN) {
		case "tipocodbarras":
		case "codbarras": {
			this.iface.genCodBar(fN)
			break;
		}
		case "codsubcuentacom": {
			if (this.child("fdbCodSubcuentaCom")) {
				if (!this.iface.bloqueoSubcuenta) {
					this.iface.bloqueoSubcuenta = true;
					this.iface.posActualPuntoSubcuenta = flcontppal.iface.pub_formatearCodSubcta(this, "fdbCodSubcuentaCom", this.iface.longSubcuenta, this.iface.posActualPuntoSubcuenta);
					this.iface.bloqueoSubcuenta = false;
				}
			}
			break;
		}
		case "codsubcuentairpfcom": {
			if (this.child("fdbCodSubcuentaIrpfCom")) {
				if (!this.iface.bloqueoSubcuenta) {
					this.iface.bloqueoSubcuenta = true;
					this.iface.posActualPuntoSubcuentaIRPF = flcontppal.iface.pub_formatearCodSubcta(this, "fdbCodSubcuentaIrpfCom", this.iface.longSubcuenta, this.iface.posActualPuntoSubcuentaIRPF);
					this.iface.bloqueoSubcuenta = false;
				}
			}
			break;
		}
		case "nostock": {
			if (this.child("tbwArticulo")) {
				if (cursor.valueBuffer("nostock")) {
					if (this.iface.eliminarStock()) {
						this.child("tbwArticulo").setTabEnabled("stocks", false);
					} else {
						this.child("fdbNoStock").setValue(false);
					}
				} else {
					this.child("tbwArticulo").setTabEnabled("stocks", true);
				}
			}
			break;
		}
		case "secompra": {
			if (this.child("tbwArticulo")) {
				if(!cursor.valueBuffer("secompra"))
					this.child("tbwArticulo").setTabEnabled("compra", false);
				else
					this.child("tbwArticulo").setTabEnabled("compra", true);
			}
			break;
		}
		case "sevende": {
			if (this.child("tbwArticulo")) {
				if(!cursor.valueBuffer("sevende"))
					this.child("tbwArticulo").setTabEnabled("venta", false);
				else
					this.child("tbwArticulo").setTabEnabled("venta", true);
			}
			break;
		}
	}
}

function oficial_genCodBar(fN)
{
	if (!this.child("pixmapCodBar")) {
		return;
	}
	if (fN == "tipocodbarras" || fN == "codbarras") {
		var cursor:FLSqlCursor = this.cursor();
		var type:String = cursor.valueBuffer("tipocodbarras");
		var value:String = cursor.valueBuffer("codbarras");

		var auxCodBar:FLCodBar = new FLCodBar(0);
		var codBar:FLCodBar = new FLCodBar(value, auxCodBar.nameToType(type), 10, 1, 0, 0, true);
		var pixmap:Object = codBar.pixmap();
		if (codBar.validBarcode())
			this.child("pixmapCodBar").setPixmap(pixmap);
		else
			this.child("pixmapCodBar").setPixmap(codBar.pixmapError());
	}
}

function oficial_eliminarStock():Boolean
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	var referencia:String = cursor.valueBuffer("referencia");
	if (util.sqlSelect("stocks", "idstock", "referencia = '" + referencia + "'")) {
		var res:Number = MessageBox.warning(util.translate("scripts", "Existen valores de stock para este artículo.\nSi lo que desea hacer es indicar que se permiten ventas sin stock de este material, pulse Cancelar e indíquelo en la pestaña de Stocks.\nSi quiere eliminar completamente los datos de stock asociados a este artículo pulse Aceptar. Esta acción no es reversible."), MessageBox.Cancel, MessageBox.Ok);
		if (res != MessageBox.Ok) {
			return false;
		}
	}
	var curTrans:FLSqlCursor = new FLSqlCursor("stocks");
	curTrans.transaction(false);
	try {
		if (this.iface.borrarDatosStock(referencia)) {
			curTrans.commit();
		} else {
			curTrans.rollback();
			return false;
		}
	}
	catch (e) {
		curTrans.rollback();
		MessageBox.critical(util.translate("scripts", "Error al eliminar los datos de stock para el artículo %1").arg(referencia), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	return true;
}

function oficial_borrarDatosStock(referencia:String):Boolean
{
	var util:FLUtil = new FLUtil;
	if (!util.sqlDelete("stocks", "referencia = '" + referencia + "'")) {
		return false;
	}

	return true;
}

function oficial_marcarProvDefecto()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var curProv:FLSqlCursor = this.child("tdbArticulosProv").cursor();
	if (!curProv.valueBuffer("id"))
		return;

	var referencia:String = cursor.valueBuffer("referencia");
	var codProveedor:String = curProv.valueBuffer("codproveedor");
	if (!this.iface.establecerProveedorDefecto(referencia, codProveedor)) {
		return;
	}
	this.child("tdbArticulosProv").refresh();
}

function oficial_establecerProveedorDefecto(referencia:String, codProveedor:String):Boolean
{
	var util:FLUtil = new FLUtil;
	if (!util.sqlUpdate("articulosprov", "pordefecto", false, "referencia = '" + referencia + "'")) {
		return false;
	}

	if (!util.sqlUpdate("articulosprov", "pordefecto", true, "referencia = '" + referencia + "' AND codproveedor = '" + codProveedor + "'")) {
		return false;
	}

	return true;
}

function oficial_establecerDatosAlta()
{
debug("oficial_establecerDatosAlta " + flfactalma.iface.pub_valorDefectoAlmacen("codimpuesto"));
	this.child("fdbImpuesto").setValue(flfactalma.iface.pub_valorDefectoAlmacen("codimpuesto"));
}

function oficial_iniciaVentas()
{
	var _i = this.iface;
	var t = this.child("tdbVentas");
	if (!t) {
		return;
	}
	if (t.cursor().table() == "articulos") {
		this.child("tbwHistorico").setTabEnabled("ventas", false);
		return;
	}
	var cVentas = _i.columnasVentas();
	t.setOrderCols(cVentas);

	var tA = this.child("tdbVentasAlb");
	tA.setOrderCols(cVentas);
}

function oficial_columnasVentas()
{
	return ["codigo", "fecha", "codcliente", "nombrecliente", "pvpunitario", "cantidad", "pvpsindto", "pvptotal"];
}

function oficial_iniciaCompras()
{
	var _i = this.iface;
	var t = this.child("tdbCompras");
	if (!t) {
		return;
	}
	if (t.cursor().table() == "articulos") {
		this.child("tbwHistorico").setTabEnabled("compras", false);
		return;
	}
	var cCompras = _i.columnasCompras();
	t.setOrderCols(cCompras);

	var tA = this.child("tdbComprasAlb");
	tA.setOrderCols(cCompras);
}

function oficial_columnasCompras()
{
	return ["codigo", "fecha", "codproveedor", "nombre", "pvpunitario", "cantidad", "pvpsindto", "pvptotal"];
}

function oficial_formReady()
{
	var _i = this.iface;
	_i.iniciaHistoricos();


// 	connect(dataTable.obj(), "doubleClicked(int, int)", _i, "prueba");
//   dataTable.hideColumn(2);
}
function oficial_iniciaHistoricos()
{
	var _i = this.iface;
	var tdbCA = this.mainWidget().child("tdbComprasAlb");
	if (tdbCA) {
		var dataTable = tdbCA.tableRecords();
		connect(dataTable, "recordChoosed()", _i, "detalleHistoricoCA");
		try {
			connect(this.child("tdbComprasAlb"), "refreshed()", _i, "totalizaCA");
		}	catch (e) {}
	}
	var tdbCF = this.mainWidget().child("tdbCompras");
	if (tdbCF) {
		var dataTable = tdbCF.tableRecords();
		connect(dataTable, "recordChoosed()", _i, "detalleHistoricoCF");
		try {
			connect(this.child("tdbCompras"), "refreshed()", _i, "totalizaCF");
		}	catch (e) {}
	}
	var tdbVA = this.mainWidget().child("tdbVentasAlb");
	if (tdbVA) {
		var dataTable = tdbVA.tableRecords();
		connect(dataTable, "recordChoosed()", _i, "detalleHistoricoVA");
		try {
			connect(this.child("tdbVentasAlb"), "refreshed()", _i, "totalizaVA");
		}	catch (e) {}
	}
	var tdbVF = this.mainWidget().child("tdbVentas");
	if (tdbVF) {
		var dataTable = tdbVF.tableRecords();
		connect(dataTable, "recordChoosed()", _i, "detalleHistoricoVF");
		try {
			connect(this.child("tdbVentas"), "refreshed()", _i, "totalizaVF");
		}	catch (e) {}
	}
}

function oficial_detalleHistoricoCA()
{
	var curAP = new FLSqlCursor("albaranesprov");
	curAP.select("idalbaran = " + this.child("tdbComprasAlb").cursor().valueBuffer("idalbaran"));
	if (curAP.first()) {
		curAP.browseRecord();
	}
}

function oficial_detalleHistoricoCF()
{
	var curFP = new FLSqlCursor("facturasprov");
	curFP.select("idfactura = " + this.child("tdbCompras").cursor().valueBuffer("idfactura"));
	if (curFP.first()) {
		curFP.browseRecord();
	}
}

function oficial_detalleHistoricoVA()
{
	var curAC = new FLSqlCursor("albaranescli");
	curAC.select("idalbaran = " + this.child("tdbVentasAlb").cursor().valueBuffer("idalbaran"));
	if (curAC.first()) {
		curAC.browseRecord();
	}
}

function oficial_detalleHistoricoVF()
{
	var curFC = new FLSqlCursor("facturascli");
	curFC.select("idfactura = " + this.child("tdbVentas").cursor().valueBuffer("idfactura"));
	if (curFC.first()) {
		curFC.browseRecord();
	}
}

function oficial_totalizaCA()
{
	var cursor = this.cursor();

	var articulo = cursor.valueBuffer("referencia");

	var tdbCA = this.child("tdbComprasAlb");
	var filtro = tdbCA.filter();
	filtro += filtro && filtro != "" ? " AND " : "";
	filtro += "lineasalbaranesprov.referencia = '" + articulo + "'";

	var filtro2 = tdbCA.findFilter();
	filtro += filtro2 && filtro2 != "" ? " AND " : "";
	filtro += filtro2;

	var qryTotales = new FLSqlQuery;
	qryTotales.setSelect("sum(lineasalbaranesprov.cantidad),sum(lineasalbaranesprov.pvptotal)");
	qryTotales.setFrom("lineasalbaranesprov INNER JOIN albaranesprov ON albaranesprov.idalbaran = lineasalbaranesprov.idalbaran");
	qryTotales.setWhere(filtro);

	if (!qryTotales.exec()) {
		return false;
	}

	var tCan = 0, tCoste = 0;
	if (qryTotales.first()) {
		tCan = qryTotales.value("sum(lineasalbaranesprov.cantidad)");
		tCoste = qryTotales.value("sum(lineasalbaranesprov.pvptotal)");

		tCan = AQUtil.formatoMiles(AQUtil.roundFieldValue(tCan, "albaranesprov", "total"));
		tCoste = AQUtil.formatoMiles(AQUtil.roundFieldValue(tCoste, "albaranesprov", "total"));
	}
	sys.setObjText(this, "lblTotalCanCA", sys.translate("Total cantidad: %1").arg(tCan));
	sys.setObjText(this, "lblTotalCosteCA", sys.translate("Total coste: %1").arg(tCoste));
}

function oficial_totalizaCF()
{
	var cursor = this.cursor();

	var articulo = cursor.valueBuffer("referencia");

	var tdbCF = this.child("tdbCompras");
	var filtro = tdbCF.filter();
	filtro += filtro && filtro != "" ? " AND " : "";
	filtro += "lineasfacturasprov.referencia = '" + articulo + "'";

	var filtro2 = tdbCF.findFilter();
	filtro += filtro2 && filtro2 != "" ? " AND " : "";
	filtro += filtro2;

	var qryTotales = new FLSqlQuery;
	qryTotales.setSelect("sum(lineasfacturasprov.cantidad),sum(lineasfacturasprov.pvptotal)");
	qryTotales.setFrom("lineasfacturasprov INNER JOIN facturasprov ON facturasprov.idfactura = lineasfacturasprov.idfactura");
	qryTotales.setWhere(filtro);

	if (!qryTotales.exec()) {
		return false;
	}

	var tCan = 0, tCoste = 0;
	if (qryTotales.first()) {
		tCan = qryTotales.value("sum(lineasfacturasprov.cantidad)");
		tCoste = qryTotales.value("sum(lineasfacturasprov.pvptotal)");

		tCan = AQUtil.formatoMiles(AQUtil.roundFieldValue(tCan, "facturasprov", "total"));
		tCoste = AQUtil.formatoMiles(AQUtil.roundFieldValue(tCoste, "facturasprov", "total"));
	}
	sys.setObjText(this, "lblTotalCanCF", sys.translate("Total cantidad: %1").arg(tCan));
	sys.setObjText(this, "lblTotalCosteCF", sys.translate("Total coste: %1").arg(tCoste));
}

function oficial_totalizaVA()
{
	var cursor = this.cursor();

	var articulo = cursor.valueBuffer("referencia");

	var tdbVA = this.child("tdbVentasAlb");
	var filtro = tdbVA.filter();
	filtro += filtro && filtro != "" ? " AND " : "";
	filtro += "lineasalbaranescli.referencia = '" + articulo + "'";

	var filtro2 = tdbVA.findFilter();
	filtro += filtro2 && filtro2 != "" ? " AND " : "";
	filtro += filtro2;

	var qryTotales = new FLSqlQuery;
	qryTotales.setSelect("sum(lineasalbaranescli.cantidad),sum(lineasalbaranescli.pvptotal)");
	qryTotales.setFrom("lineasalbaranescli INNER JOIN albaranescli ON albaranescli.idalbaran = lineasalbaranescli.idalbaran");
	qryTotales.setWhere(filtro);

	if (!qryTotales.exec()) {
		return false;
	}

	var tCan = 0, tPrecio = 0;
	if (qryTotales.first()) {
		tCan = qryTotales.value("sum(lineasalbaranescli.cantidad)");
		tPrecio = qryTotales.value("sum(lineasalbaranescli.pvptotal)");

		tCan = AQUtil.formatoMiles(AQUtil.roundFieldValue(tCan, "albaranescli", "total"));
		tPrecio = AQUtil.formatoMiles(AQUtil.roundFieldValue(tPrecio, "albaranescli", "total"));
	}
	sys.setObjText(this, "lblTotalCanVA", sys.translate("Total cantidad: %1").arg(tCan));
	sys.setObjText(this, "lblTotalPrecioVA", sys.translate("Total precio: %1").arg(tPrecio));
}

function oficial_totalizaVF()
{
	var cursor = this.cursor();

	var articulo = cursor.valueBuffer("referencia");

	var tdbVF = this.child("tdbVentas");
	var filtro = tdbVF.filter();
	filtro += filtro && filtro != "" ? " AND " : "";
	filtro += "lineasfacturascli.referencia = '" + articulo + "'";

	var filtro2 = tdbVF.findFilter();
	filtro += filtro2 && filtro2 != "" ? " AND " : "";
	filtro += filtro2;

	var qryTotales = new FLSqlQuery;
	qryTotales.setSelect("sum(lineasfacturascli.cantidad),sum(lineasfacturascli.pvptotal)");
	qryTotales.setFrom("lineasfacturascli INNER JOIN facturascli ON facturascli.idfactura = lineasfacturascli.idfactura");
	qryTotales.setWhere(filtro);

	if (!qryTotales.exec()) {
		return false;
	}

	var tCan = 0, tPrecio = 0;
	if (qryTotales.first()) {
		tCan = qryTotales.value("sum(lineasfacturascli.cantidad)");
		tPrecio = qryTotales.value("sum(lineasfacturascli.pvptotal)");

		tCan = AQUtil.formatoMiles(AQUtil.roundFieldValue(tCan, "facturascli", "total"));
		tPrecio = AQUtil.formatoMiles(AQUtil.roundFieldValue(tPrecio, "facturascli", "total"));
	}
	sys.setObjText(this, "lblTotalCanVF", sys.translate("Total cantidad: %1").arg(tCan));
	sys.setObjText(this, "lblTotalPrecioVF", sys.translate("Total precio: %1").arg(tPrecio));
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
