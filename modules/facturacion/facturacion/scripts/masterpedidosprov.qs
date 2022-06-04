/***************************************************************************
                 masterpedidosprov.qs  -  description
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
    function preloadMainFilter() {
		return this.ctx.interna_preloadMainFilter();
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var pbnGAlbaran:Object;
	var pbnGFactura:Object;
	var tdbRecords:FLTableDB;
	var tbnImprimir:Object;
	var tbnAbrirCerrar:Object;
	var curAlbaran:FLSqlCursor;
	var curLineaAlbaran:FLSqlCursor;

    function oficial( context ) { interna( context ); } 
	function procesarEstado() {
		return this.ctx.oficial_procesarEstado();
	}
	function imprimir(codPedido:String) {
		return this.ctx.oficial_imprimir(codPedido);
	}
	function dameParamInforme(idPedido) {
		return this.ctx.oficial_dameParamInforme(idPedido);
	}
	function pbnGenerarAlbaran_clicked() {
		return this.ctx.oficial_pbnGenerarAlbaran_clicked();
	}
	function pbnGenerarFactura_clicked() {
		return this.ctx.oficial_pbnGenerarFactura_clicked();
	}
	function generarAlbaran(where:String, cursor:FLSqlCursor, datosAgrupacion:Array):Number {
		return this.ctx.oficial_generarAlbaran(where, cursor, datosAgrupacion);
	}
	function commonCalculateField(fN, cursor, cx) {
		return this.ctx.oficial_commonCalculateField(fN, cursor, cx);
	}
	function copiaLineas(idPedido:Number, idAlbaran:Number, codAlmacen:String):Boolean {
		return this.ctx.oficial_copiaLineas(idPedido, idAlbaran, codAlmacen);
	}
	function copiaLineaPedido(curLineaPedido:FLSqlCursor, idAlbaran:Number):Number {
		return this.ctx.oficial_copiaLineaPedido(curLineaPedido, idAlbaran);
	}
	function actualizarDatosPedido(where:String, idAlbaran:String):Boolean {
		return this.ctx.oficial_actualizarDatosPedido(where, idAlbaran);
	}
	function totalesAlbaran():Boolean {
		return this.ctx.oficial_totalesAlbaran();
	}
	function datosAlbaran(curPedido:FLSqlCursor, where:String, datosAgrupacion:Array):Boolean {
		return this.ctx.oficial_datosAlbaran(curPedido, where, datosAgrupacion);
	}
	function datosLineaAlbaran(curLineaPedido:FLSqlCursor):Boolean {
		return this.ctx.oficial_datosLineaAlbaran(curLineaPedido);
	}
	function abrirCerrarPedido(curId) {
		return this.ctx.oficial_abrirCerrarPedido(curId);
	}
	function tbnAbrirCerrar_clicked() {
		return this.ctx.oficial_tbnAbrirCerrar_clicked();
	}
	function filtrarTabla():Boolean {
		return this.ctx.oficial_filtrarTabla();
	}
	function filtroTabla():String {
		return this.ctx.oficial_filtroTabla();
	}
	function colorEstado(fN, fV, cursor, fT, sel) {
		return this.ctx.oficial_colorEstado(fN, fV, cursor, fT, sel);
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
	function pub_commonCalculateField(fN, cursor, cx) {
		return this.commonCalculateField(fN, cursor, cx);
	}
	function pub_generarAlbaran(where:String, cursor:FLSqlCursor, datosAgrupacion:Array):Number {
		return this.generarAlbaran(where, cursor, datosAgrupacion);
	}
	function pub_imprimir(codPedido:String) {
		return this.imprimir(codPedido);
	}
	function pub_abrirCerrarPedido(curId) {
		return this.abrirCerrarPedido(curId);
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
Este es el formulario maestro de pedidos a proveedor.
\end */
function interna_init()
{
	this.iface.pbnGAlbaran = this.child("pbnGenerarAlbaran");
	this.iface.pbnGFactura = this.child("pbnGenerarFactura");
	this.iface.tdbRecords = this.child("tableDBRecords");
	this.iface.tbnImprimir = this.child("toolButtonPrint");
	this.iface.tbnAbrirCerrar = this.child("tbnAbrirCerrar");

	connect(this.iface.pbnGAlbaran, "clicked()", this, "iface.pbnGenerarAlbaran_clicked()");
	connect(this.iface.pbnGFactura, "clicked()", this, "iface.pbnGenerarFactura_clicked()");
	connect(this.iface.tdbRecords, "currentChanged()", this, "iface.procesarEstado()");
	connect(this.iface.tbnImprimir, "clicked()", this, "iface.imprimir");
	connect(this.iface.tbnAbrirCerrar, "clicked()", this, "iface.tbnAbrirCerrar_clicked()");

	this.iface.procesarEstado();
}

function interna_preloadMainFilter()
{
  return this.iface.filtroTabla();
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \C
Al pulsar el bot�n imprimir se lanzar� el informe correspondiente al pedido seleccionado (en caso de que el m�dulo de informes est� cargado)
\end */
function oficial_imprimir(codPedido:String)
{
	var util = new FLUtil;
	if (sys.isLoadedModule("flfactinfo")) {
		var idPedido, codigo;
		if (codPedido) {
			codigo = codPedido;
			idPedido = util.sqlSelect("pedidosprov", "idpedido","codigo = '" + codigo + "'");
		} else {
			var cursor = this.cursor();
			if (!cursor.isValid()) {
				return;
			}
			codigo = this.cursor().valueBuffer("codigo");
			idPedido = this.cursor().valueBuffer("idpedido");
		}
		if (!idPedido) {
			return;
		}
		
		var oParam = this.iface.dameParamInforme(idPedido);
		if (!oParam) {
			return;
		}
		var curImprimir:FLSqlCursor = new FLSqlCursor("i_pedidosprov");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("d_pedidosprov_codigo", codigo);
		curImprimir.setValueBuffer("h_pedidosprov_codigo", codigo);
		flfactinfo.iface.pub_lanzaInforme(curImprimir, oParam);
	} else {
		flfactppal.iface.pub_msgNoDisponible("Informes");
	}
}

function oficial_dameParamInforme(idPedido)
{
	var oParam = flfactinfo.iface.pub_dameParamInforme();
	oParam.nombreInforme = "i_pedidosprov";
	return oParam;
}

function oficial_procesarEstado()
{
		if (this.cursor().valueBuffer("editable") == true) {
				this.iface.pbnGAlbaran.setEnabled(true);
				this.iface.pbnGFactura.setEnabled(true);
		} else {
				this.iface.pbnGAlbaran.setEnabled(false);
				this.iface.pbnGFactura.setEnabled(false);
		}
}

/** \C
Al pulsar el bot�n de generar albar�n se crear� el albar�n correspondiente al pedido seleccionado.
\end */
function oficial_pbnGenerarAlbaran_clicked()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var where:String = "idpedido = " + cursor.valueBuffer("idpedido");

	if (cursor.valueBuffer("editable") == false) {
		MessageBox.warning(util.translate("scripts", "El pedido ya est� servido"), MessageBox.Ok, MessageBox.NoButton);
		this.iface.procesarEstado();
		return;
	}
	this.iface.pbnGAlbaran.setEnabled(false);
	this.iface.pbnGFactura.setEnabled(false);

	cursor.transaction(false);
	try {
		if (this.iface.generarAlbaran(where, cursor))
			cursor.commit();
		else
			cursor.rollback();
	}
	catch (e) {
		cursor.rollback();
		MessageBox.critical(util.translate("scripts", "Hubo un error en la generaci�n del albar�n:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
	}
	
	this.iface.tdbRecords.refresh();
	this.iface.procesarEstado();
}

/** \C
Al pulsar el bot�n de generar factura se crear�n tanto el albar�n como la factura correspondientes al pedido seleccionado.
\end */
function oficial_pbnGenerarFactura_clicked()
{
	var idAlbaran:Number;
	var idFactura:Number;
	var util:FLUtil = new FLUtil;
	var curAlbaran:FLSqlCursor = new FLSqlCursor("albaranesprov");
	var cursor:FLSqlCursor = this.cursor();
	var where:String = "idpedido = " + cursor.valueBuffer("idpedido");

	if (cursor.valueBuffer("editable") == false) {
		MessageBox.warning(util.translate("scripts", "El pedido ya est� servido. Genere la factura desde la ventana de albaranes"), MessageBox.Ok, MessageBox.NoButton);
		this.iface.procesarEstado();
		return;
	}
	this.iface.pbnGAlbaran.setEnabled(false);
	this.iface.pbnGFactura.setEnabled(false);

	cursor.transaction(false);
	try {
		idAlbaran = this.iface.generarAlbaran(where, cursor);
		if (idAlbaran) {
			where = "idalbaran = " + idAlbaran;
			curAlbaran.select(where);
			if (curAlbaran.first()) {
				cursor.commit();
				cursor.transaction(false);
				idFactura = formalbaranesprov.iface.pub_generarFactura(where, curAlbaran);
				if (idFactura) {
					cursor.commit();
				} else
					cursor.rollback();
			} else
				cursor.rollback();
		} else
			cursor.rollback();
    }
	catch (e) {
		cursor.rollback();
		MessageBox.critical(util.translate("scripts", "Hubo un error en la generaci�n de la factura:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
	}
	
	this.iface.tdbRecords.refresh();
	this.iface.procesarEstado();
}

/** \D 
Genera el albar�n asociado a uno o m�s pedidos
@param where: Sentencia where para la consulta de b�squeda de los pedidos a agrupar
@param cursor: Cursor con los datos principales que se copiar�n del pedido al albar�n
@param datosAgrupacion: Array con los datos indicados en el formulario de agrupaci�n de pedidos
@return Identificador del albar�n generado. FALSE si hay error
\end */
function oficial_generarAlbaran(where:String, curPedido:FLSqlCursor, datosAgrupacion:Array):Number
{
	if (!this.iface.curAlbaran)
		this.iface.curAlbaran = new FLSqlCursor("albaranesprov");
	
	this.iface.curAlbaran.setModeAccess(this.iface.curAlbaran.Insert);
	this.iface.curAlbaran.refreshBuffer();
	
	if (!this.iface.datosAlbaran(curPedido, where, datosAgrupacion))
		return false;
	
	if (!this.iface.curAlbaran.commitBuffer()) {
		return false;
	}
	
	var idAlbaran:Number = this.iface.curAlbaran.valueBuffer("idalbaran");
	
	var qryPedidos:FLSqlQuery = new FLSqlQuery();
	qryPedidos.setTablesList("pedidosprov");
	qryPedidos.setSelect("idpedido");
	qryPedidos.setFrom("pedidosprov");
	qryPedidos.setWhere(where);

	if (!qryPedidos.exec())
		return false;

	var idPedido:String;
	while (qryPedidos.next()) {
		idPedido = qryPedidos.value(0);
		if (!this.iface.copiaLineas(idPedido, idAlbaran)) {
			return false;
		}
	}

	this.iface.curAlbaran.select("idalbaran = " + idAlbaran);
	if (this.iface.curAlbaran.first()) {
		this.iface.curAlbaran.setModeAccess(this.iface.curAlbaran.Edit);
		this.iface.curAlbaran.refreshBuffer();
		
		if (!this.iface.totalesAlbaran()) {
			return false;
		}
		if (!flfacturac.iface.pub_actualizarArticulosProv(this.iface.curAlbaran)) {
			return false;
		}
		if (!this.iface.curAlbaran.commitBuffer()) {
			return false;
		}
	}
	return idAlbaran;
}

/** \D Informa los datos de un albar�n a partir de los de uno o varios pedidos
@param	curPedido: Cursor que contiene los datos a incluir en el albar�n
@param where: Sentencia where para la consulta de b�squeda de los pedidos a agrupar
@param datosAgrupacion: Array con los datos indicados en el formulario de agrupaci�n de pedidos
@return	True si el c�lculo se realiza correctamente, false en caso contrario
\end */
function oficial_datosAlbaran(curPedido:FLSqlCursor, where:String, datosAgrupacion:Array):Boolean
{
	var fecha:String;
	var hora:String;
	if (datosAgrupacion) {
		fecha = datosAgrupacion["fecha"];
		hora = datosAgrupacion["hora"];
	} else {
		var hoy:Date = new Date();
		fecha = hoy.toString();
		hora = hoy.toString().right(8);
	}
	
	var codEjercicio:String = curPedido.valueBuffer("codejercicio");
	var datosDoc:Array = flfacturac.iface.pub_datosDocFacturacion(fecha, codEjercicio, "albaranesprov");
	if (!datosDoc.ok)
		return false;
	if (datosDoc.modificaciones == true) {
		codEjercicio = datosDoc.codEjercicio;
		fecha = datosDoc.fecha;
	}

	with (this.iface.curAlbaran) {
		setValueBuffer("codproveedor", curPedido.valueBuffer("codproveedor"));
		setValueBuffer("nombre", curPedido.valueBuffer("nombre"));
		setValueBuffer("cifnif", curPedido.valueBuffer("cifnif"));
		setValueBuffer("coddivisa", curPedido.valueBuffer("coddivisa"));
		setValueBuffer("tasaconv", curPedido.valueBuffer("tasaconv"));
		setValueBuffer("recfinanciero", curPedido.valueBuffer("recfinanciero"));
		setValueBuffer("codpago", curPedido.valueBuffer("codpago"));
		setValueBuffer("codalmacen", curPedido.valueBuffer("codalmacen"));
		setValueBuffer("fecha", fecha);
		setValueBuffer("hora", hora);
		setValueBuffer("codserie", curPedido.valueBuffer("codserie"));
		setValueBuffer("codejercicio", codEjercicio);
		setValueBuffer("tasaconv", curPedido.valueBuffer("tasaconv"));
		setValueBuffer("recfinanciero", curPedido.valueBuffer("recfinanciero"));
		setValueBuffer("irpf", curPedido.valueBuffer("irpf"));
		setValueBuffer("observaciones", curPedido.valueBuffer("observaciones"));
	}
	
	return true;
}

/** \D Informa los datos de un albar�n referentes a totales (I.V.A., neto, etc.)
@return	True si el c�lculo se realiza correctamente, false en caso contrario
\end */
function oficial_totalesAlbaran():Boolean
{
	with (this.iface.curAlbaran) {
		setValueBuffer("neto", formalbaranesprov.iface.pub_commonCalculateField("neto", this));
		setValueBuffer("totaliva", formalbaranesprov.iface.pub_commonCalculateField("totaliva", this));
		setValueBuffer("totalirpf", formalbaranesprov.iface.pub_commonCalculateField("totalirpf", this));
		setValueBuffer("totalrecargo", formalbaranesprov.iface.pub_commonCalculateField("totalrecargo", this));
		setValueBuffer("total", formalbaranesprov.iface.pub_commonCalculateField("total", this));
		setValueBuffer("totaleuros", formalbaranesprov.iface.pub_commonCalculateField("totaleuros", this));
	}
	return true;
}


function oficial_actualizarDatosPedido(where:String, idAlbaran:String):Boolean
{
	var curPedidos:FLSqlCursor = new FLSqlCursor("pedidosprov");
	curPedidos.select(where);
	while (curPedidos.next()) {
		curPedidos.setModeAccess(curPedidos.Edit);
		curPedidos.refreshBuffer();
		curPedidos.setValueBuffer("servido", "S�");
		curPedidos.setValueBuffer("editable", false);
		if(!curPedidos.commitBuffer()) 
			return false;
	}
	return true;
}

function oficial_commonCalculateField(fN, cursor, cx)
{
	var _i = this.iface;
	var valor:String;

	if(!cx || cx == "")
		cx = "default";
	
	/** \C
	El --c�digo-- se construye como la concatenaci�n de --codserie--, --codejercicio-- y --numero--
	\end */
	if (fN == "codigo") {
		valor = flfacturac.iface.pub_construirCodigo(cursor.valueBuffer("codserie"), cursor.valueBuffer("codejercicio"), cursor.valueBuffer("numero"));
	}

	switch (fN) {
		/** \C
		El --total-- es el --neto-- menos el --totalirpf-- m�s el --totaliva-- m�s el --totalrecargo-- m�s el --recfinanciero--
		\end */
		case "total": {
			var neto = parseFloat(cursor.valueBuffer("neto"));
			var totalIrpf = parseFloat(cursor.valueBuffer("totalirpf"));
			var totalIva = parseFloat(cursor.valueBuffer("totaliva"));
			var totalRecargo = parseFloat(cursor.valueBuffer("totalrecargo"));
			var recFinanciero = (parseFloat(cursor.valueBuffer("recfinanciero")) * neto) / 100;
			recFinanciero = parseFloat(AQUtil.roundFieldValue(recFinanciero, "pedidosprov", "total"));
			valor = neto - totalIrpf + totalIva + totalRecargo + recFinanciero;
			valor = parseFloat(AQUtil.roundFieldValue(valor, "pedidosprov", "total"));
			break;
		}
		/** \C
		El --totaleuros-- es el producto del --total-- por la --tasaconv--
		\end */
		case "totaleuros":{
			var total = parseFloat(cursor.valueBuffer("total"));
			var tasaConv = parseFloat(cursor.valueBuffer("tasaconv"));
			valor = total * tasaConv;
			valor = parseFloat(AQUtil.roundFieldValue(valor, "pedidosprov", "totaleuros"));
			break;
		}
		/** \C
		El --neto-- es la suma del pvp total de las l�neas de albar�n
		\end */
		case "neto": {
			valor = AQUtil.sqlSelect("lineaspedidosprov", "SUM(pvptotal)", "idpedido = " + cursor.valueBuffer("idpedido"),"lineaspedidosprov",cx);
			valor = parseFloat(AQUtil.roundFieldValue(valor, "pedidosprov", "neto"));
			break;
		}
		/** \C
		El --totaliva-- es la suma del iva correspondiente a las l�neas de albar�n
		\end */
		case "totaliva": {
			if (formfacturasprov.iface.pub_sinIVA(cursor, cx)) {
				valor = 0;
			} else {
				valor = AQUtil.sqlSelect("lineaspedidosprov", "SUM((pvptotal * iva) / 100)", "idpedido = " + cursor.valueBuffer("idpedido"),"lineaspedidosprov",cx);
			}
			valor = parseFloat(AQUtil.roundFieldValue(valor, "pedidosprov", "totaliva"));
			break;
		}
		/** \C
		El --totarecargo-- es la suma del recargo correspondiente a las l�neas de albar�n
		\end */
		case "totalrecargo": {
			if (formfacturasprov.iface.pub_sinIVA(cursor, cx)) {
				valor = 0;
			} else {
				valor = AQUtil.sqlSelect("lineaspedidosprov", "SUM((pvptotal * recargo) / 100)", "idpedido = " + cursor.valueBuffer("idpedido"),"lineaspedidosprov",cx);
			}
			valor = parseFloat(AQUtil.roundFieldValue(valor, "pedidosprov", "totalrecargo"));
			break;
		}
		/** \C
		El --irpf-- es el asociado al --codserie-- del albar�n
		\end */
		case "irpf": {
			valor = AQUtil.sqlSelect("series", "irpf", "codserie = '" + cursor.valueBuffer("codserie") + "'","series",cx);
			break;
		}
		/** \C
		El --totalirpf-- es el producto del --irpf-- por el --neto--
		\end */
		case "totalirpf": {
			valor = AQUtil.sqlSelect("lineaspedidosprov", "SUM((pvptotal * irpf) / 100)", "idpedido = " + cursor.valueBuffer("idpedido"),"lineaspedidosprov",cx);
			valor = parseFloat(AQUtil.roundFieldValue(valor, "pedidosprov", "totalirpf"));
			break;
		}
	}
	return valor;
}

/** \D
Copia las l�neas de un pedido como l�neas de su albar�n asociado
@param idPedido: Identificador del pedido
@param idAlbaran: Identificador del albar�n
@return VERDADERO si la copia se realiza correctamente. FALSO en otro caso
\end */
function oficial_copiaLineas(idPedido:Number, idAlbaran:Number):Boolean
{
	var cantidad:Number;
	var totalEnAlbaran:Number;
	var curLineaPedido:FLSqlCursor = new FLSqlCursor("lineaspedidosprov");
	curLineaPedido.select("idpedido = " + idPedido + " AND (cerrada = false or cerrada IS NULL)");
	while (curLineaPedido.next()) {
		curLineaPedido.setModeAccess(curLineaPedido.Browse);
		curLineaPedido.refreshBuffer();
		cantidad = parseFloat(curLineaPedido.valueBuffer("cantidad"));
		totalEnAlbaran = parseFloat(curLineaPedido.valueBuffer("totalenalbaran"));
		if (cantidad != totalEnAlbaran) { /// > cambiado por != para poder albaranar l�neas con cantidad negativa
			if (!this.iface.copiaLineaPedido(curLineaPedido, idAlbaran)) {
				return false;
			}
		}
	}
	return true;
}

/** \D
Copia una l�neas de un pedido en su albar�n asociado
@param curdPedido: Cursor posicionado en la l�nea de pedido a copiar
@param idAlbaran: Identificador del albar�n
@return identificador de la l�nea de albar�n creada si no hay error. FALSE en otro caso.
\end */
function oficial_copiaLineaPedido(curLineaPedido:FLSqlCursor, idAlbaran:Number):Number
{
	if (!this.iface.curLineaAlbaran)
		this.iface.curLineaAlbaran = new FLSqlCursor("lineasalbaranesprov");
	
	with (this.iface.curLineaAlbaran) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("idalbaran", idAlbaran);
		setValueBuffer("cantidad", 0);
	}
	
	if (!this.iface.datosLineaAlbaran(curLineaPedido)) {
		return false;
	}
	if (!flfactalma.iface.pub_consistenciaLinea(curLineaPedido)) {
		return false;
	}
	if (!this.iface.curLineaAlbaran.commitBuffer()) {
		return false;
	}
	return this.iface.curLineaAlbaran.valueBuffer("idlinea");
}

/** \D Copia los datos de una l�nea de pedido en una l�nea de albar�n
@param	curLineaPedido: Cursor que contiene los datos a incluir en la l�nea de albar�n
@return	True si la copia se realiza correctamente, false en caso contrario
\end */
function oficial_datosLineaAlbaran(curLineaPedido:FLSqlCursor):Boolean
{
	var _i = this.iface;
	
	var cantidad;
	if (_i.curLineaAlbaran.valueBuffer("cantidad") != 0) {
		cantidad = _i.curLineaAlbaran.valueBuffer("cantidad"); /// Hay extensiones que establecen previamente la cantidad (gene_albaranesp)
	} else {
		cantidad = parseFloat(curLineaPedido.valueBuffer("cantidad")) - parseFloat(curLineaPedido.valueBuffer("totalenalbaran"));
	}
	var pvpSinDto = parseFloat(curLineaPedido.valueBuffer("pvpsindto")) * cantidad / parseFloat(curLineaPedido.valueBuffer("cantidad"));
	pvpSinDto = AQUtil.roundFieldValue(pvpSinDto, "lineasalbaranesprov", "pvpsindto");
	var iva, recargo;
	var codImpuesto = curLineaPedido.valueBuffer("codimpuesto");
	
	with (_i.curLineaAlbaran) {
		setValueBuffer("idlineapedido", curLineaPedido.valueBuffer("idlinea"));
		setValueBuffer("idpedido", curLineaPedido.valueBuffer("idpedido"));
		setValueBuffer("referencia", curLineaPedido.valueBuffer("referencia"));
		setValueBuffer("descripcion", curLineaPedido.valueBuffer("descripcion"));
		setValueBuffer("pvpunitario", curLineaPedido.valueBuffer("pvpunitario"));
		setValueBuffer("cantidad", cantidad);
		setValueBuffer("codimpuesto", codImpuesto);
		if (curLineaPedido.isNull("iva")) {
			setNull("iva");
		} else {
			iva = curLineaPedido.valueBuffer("iva");
			if (iva != 0 && codImpuesto && codImpuesto != "") {
				iva = formRecordlineaspedidosprov.iface.pub_commonCalculateField("iva", this); /// Para cambio de IVA seg�n fechas
			}
			setValueBuffer("iva", iva);
		}
		if (curLineaPedido.isNull("recargo")) {
			setNull("recargo");
		} else {
			recargo = curLineaPedido.valueBuffer("recargo");
			if (recargo != 0 && codImpuesto && codImpuesto != "") {
				recargo = formRecordlineaspedidosprov.iface.pub_commonCalculateField("recargo", this); /// Para cambio de IVA seg�n fechas
			}
			setValueBuffer("recargo", recargo);
		}
		setValueBuffer("irpf", curLineaPedido.valueBuffer("irpf"));
		setValueBuffer("dtolineal", curLineaPedido.valueBuffer("dtolineal"));
		setValueBuffer("dtopor", curLineaPedido.valueBuffer("dtopor"));
		setValueBuffer("pvpsindto", pvpSinDto);
		setValueBuffer("pvptotal", formRecordlineaspedidosprov.iface.pub_commonCalculateField("pvptotal", this));
	}
	return true;
}

function oficial_tbnAbrirCerrar_clicked()
{
	var _i = this.iface;
	var cursor = this.cursor();
	if (!_i.abrirCerrarPedido(cursor)) {
		return;
	}
	_i.tdbRecords.refresh();
}

function oficial_abrirCerrarPedido(curId)
{
	var _i = this.iface;
	var util:FLUtil;
	var cursor;
	if (typeof(curId) == "string" || typeof(curId) == "number") {
		cursor = new FLSqlCursor("pedidosprov");
		cursor.select("idpedido = " + curId);
		if (!cursor.first()) {
			return false;
		}
	} else {
		cursor = curId;
	}

	var idPedido:Number = cursor.valueBuffer("idpedido");
	if(!idPedido) {
		MessageBox.warning(util.translate("scripts", "No hay ning�n registro seleccionado"), MessageBox.Ok, MessageBox.NoButton);
	}

	var cerrar:Boolean = true;
	var res:Number;
	if(util.sqlSelect("lineaspedidosprov","cerrada","idpedido = " + idPedido + " AND cerrada")) {
		cerrar = false;
		res = MessageBox.information(util.translate("scripts", "El pedido seleccionado tiene l�neas cerradas.\n�Seguro que desa abrirlas?"), MessageBox.Yes, MessageBox.No);
	} else {
		if (!cursor.valueBuffer("editable")) {
			MessageBox.warning(util.translate("scripts", "El pedido ya ha sido servido completamente."), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
		res = MessageBox.information(util.translate("scripts", "Se va a cerrar el pedido y no podr� terminar de servirse.\n�Desea continuar?"), MessageBox.Yes, MessageBox.No);
	}
	if (res != MessageBox.Yes) {
		return false;
	}
	if (!util.sqlUpdate("lineaspedidosprov","cerrada",cerrar,"idpedido = " + idPedido)) {
		return false;
	}
	if (!flfacturac.iface.pub_actualizarEstadoPedidoProv(idPedido)) {
		return false;
	}
	return true;
}

function oficial_filtrarTabla():Boolean
{
	var filtro = this.iface.filtroTabla();
	var cur = this.cursor();
	if (filtro != cur.mainFilter())
		cur.setMainFilter(filtro);
	return true;
}

function oficial_filtroTabla():String
{
	var filtro:String = "";
	var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
	if (codEjercicio) {
		filtro = "codejercicio='" + codEjercicio + "'";
	}
	return filtro;
}

function oficial_colorEstado(fN, fV, cursor, fT, sel)
{
	var _i = this.iface;
	if (fN != "servido") {
		return;
	}
	var color = "";
	switch (fV) {
		case "S�": {
			color = flfactppal.iface.pub_dameColor("fondo_verde");
			break;
		}
		case "Parcial": {
			color = flfactppal.iface.pub_dameColor("fondo_amarillo");
			break;
		}
		case "No": {
			color = flfactppal.iface.pub_dameColor("fondo_rojo");
			break;
		}
		default:{
			color = flfactppal.iface.pub_dameColor("fondo_blanco");
		}
	}
	if (color != "") {
		var a = [color, "#000000", "SolidPattern", "SolidPattern"];
		return a;
	}
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
