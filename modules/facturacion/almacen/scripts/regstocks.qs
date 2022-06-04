/***************************************************************************
                 regstocks.qs  -  description
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
	function calculateField(fN:String):String {
		return this.ctx.interna_calculateField(fN);
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
    function oficial( context ) { interna( context ); }
	function calcularCantidad() {
		return this.ctx.oficial_calcularCantidad();
	}
	function calcularValoresUltReg() {
		return this.ctx.oficial_calcularValoresUltReg();
	}
	function commonCalculateField(fN, cursor, oParam) {
		return this.ctx.oficial_commonCalculateField(fN, cursor, oParam);
	}
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function dameWhereStock(cursor, campoAlmacen, campoFecha, fechaMax) {
		return this.ctx.oficial_dameWhereStock(cursor, campoAlmacen, campoFecha, fechaMax);
	}
	function dameParamStock() {
		return this.ctx.oficial_dameParamStock();
	}
	//function cambiarCantidad(cantidadNueva:Number) { return this.ctx.oficial_cambiarCantidad(cantidadNueva); }
	//function deshabilitarCantidad() { return this.ctx.oficial_deshabilitarCantidad(); }
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
	function pub_cambiarCantidad(cantidad) {
		return this.cambiarCantidad(cantidad);
	}
	function pub_commonCalculateField(fN, cursor, oParam) {
		return this.commonCalculateField(fN, cursor, oParam);
	}
	function pub_dameParamStock() {
		return this.dameParamStock();
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
/** \C La cantidad está deshabilitada

El valor del stock de un artículo se modificará de forma automática cuando haya modificación de:

- Lineas de albarán de proveedor (incrementan el stock)

- Lineas de factura de proveedor no automáticas (incrementan el stock)

- Lineas de pedido de cliente (decrementan el stock)

- Lineas de albarán de cliente no provenientes de un pedido (decrementan el stock)

- Lineas de factura de cliente no automáticas (decrementan el stock)

El valor del stock de un artículo se puede modificar de forma manual desde la ventana de regularizaciones de stock

\end */
function interna_init()
{
	var cursor:FLSqlCursor = this.cursor();
	//this.iface.deshabilitarCantidad();
	//connect(this.child("tdbLineasRegStocks").cursor(), "newBuffer()", this, "iface.deshabilitarCantidad");
	connect(this.child("tdbLineasRegStocks").cursor(), "bufferCommited()", this, "iface.calcularCantidad");
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	switch (cursor.modeAccess()) {
		case cursor.Edit: {
			if (this.child("pushButtonAcceptContinue")) {
				this.child("pushButtonAcceptContinue").close();
			}
			this.child("fdbReferencia").setDisabled(true);
			this.child("fdbCodAlmacen").setDisabled(true);
			this.child("fdbNombre").setDisabled(true);
			break;
		}
	}
}

function interna_calculateField(fN:String):String
{
	var cursor:FLSqlCursor = this.cursor();
	return this.iface.commonCalculateField(fN, cursor);
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/*
function oficial_cambiarCantidad(cantidadNueva:Number)
{
		this.child("fdbCantidad").setValue(cantidadNueva);
		this.iface.deshabilitarCantidad();
}

function oficial_deshabilitarCantidad()
{
		this.child("fdbCantidad").setDisabled(true);
}
*/
function oficial_bufferChanged(fN:String)
{
	var cursor:FLSqlCursor = this.cursor();
	switch (fN) {
		case "cantidad":
		case "reservada": {
			cursor.setValueBuffer("disponible", this.iface.calculateField("disponible"));
			break;
		}
	}
}

function oficial_dameParamStock()
{
	var oP = new Object;
	oP.fechaMax = false;
	return oP;
}

function oficial_commonCalculateField(fN, cursor, oParam)
{
	var _i = this.iface;
	var util:FLUtil = new FLUtil;
	var valor;
	var fechaMax = oParam ? oParam.fechaMax : false;
	switch (fN) {
		case "disponible": {
			var cantidad:Number = parseFloat(cursor.valueBuffer("cantidad"));
			var reservada:Number = parseFloat(cursor.valueBuffer("reservada"));
			valor = cantidad - reservada;
			break;
		}
		case "necesidad": {
			var disponible = parseFloat(cursor.valueBuffer("disponible"));
			disponible = isNaN(disponible) ? 0 : disponible;
			var pteRecibir = parseFloat(cursor.valueBuffer("pterecibir"));
			pteRecibir = isNaN(pteRecibir) ? 0 : pteRecibir;
			var stockMin = parseFloat(cursor.valueBuffer("stockmin"));
			stockMin = isNaN(stockMin) ? 0 : stockMin;
			valor = stockMin - (disponible + pteRecibir);
			valor = valor < 0 ? 0 : valor;
			break;
		}
		case "cantidadultreg": {
			if (fechaMax) {
				valor = util.sqlSelect("lineasregstocks", "cantidadfin", "idstock = " + cursor.valueBuffer("idstock") + " AND fecha <= '" + fechaMax + "' ORDER BY fecha DESC, hora DESC");
			} else {
				valor = util.sqlSelect("lineasregstocks", "cantidadfin", "idstock = " + cursor.valueBuffer("idstock") + " ORDER BY fecha DESC, hora DESC");
			}
			if (!valor || isNaN(valor)) {
				valor = 0;
			}
			break;
		}
		case "fechaultreg": {
			valor = util.sqlSelect("lineasregstocks", "fecha", "idstock = " + cursor.valueBuffer("idstock") + " ORDER BY fecha DESC, hora DESC");
			break;
		}
		case "horaultreg": {
			valor = util.sqlSelect("lineasregstocks", "hora", "idstock = " + cursor.valueBuffer("idstock") + " ORDER BY fecha DESC, hora DESC");
			break;
		}
		case "cantidad": {
			if (fechaMax) {
				valor = parseFloat(_i.commonCalculateField("cantidadultreg", cursor, oParam)) + parseFloat(_i.commonCalculateField("cantidadap", cursor, oParam)) +  + parseFloat(_i.commonCalculateField("cantidadfp", cursor, oParam)) - parseFloat(_i.commonCalculateField("cantidadac", cursor, oParam)) - parseFloat(_i.commonCalculateField("cantidadfc", cursor, oParam)) + parseFloat(_i.commonCalculateField("cantidadts", cursor, oParam)) - parseFloat(_i.commonCalculateField("cantidadtpv", cursor, oParam));
				//Antes se le sumaba también la cantidad de los vales pero se quita porque la tabla de vales ya no se usa, un vale es una comanda.
				//+ parseFloat(_i.commonCalculateField("cantidadval", cursor, oParam));
				
			} else {
				valor = this.iface.commonCalculateField("cantidadultreg", cursor);
			}
			break;
		}
		case "cantidadac": {
			var whereStock:String = this.iface.dameWhereStock(cursor, "d.codalmacen", false, fechaMax);
			valor = util.sqlSelect("lineasalbaranescli ld INNER JOIN albaranescli d ON ld.idalbaran = d.idalbaran", "SUM(ld.cantidad)", whereStock, "lineasalbaranescli,albaranescli");
			if (isNaN(valor)) {
				valor = 0;
			}
			break;
		}
		case "cantidadap": {
			var whereStock:String = this.iface.dameWhereStock(cursor, "d.codalmacen", false, fechaMax);
			valor = util.sqlSelect("lineasalbaranesprov ld INNER JOIN albaranesprov  d ON ld.idalbaran = d.idalbaran", "SUM(ld.cantidad)", whereStock, "lineasalbaranesprov,albaranesprov");
			if (isNaN(valor)) {
				valor = 0;
			}
			break;
		}
		case "cantidadfc": {
			var whereStock:String = this.iface.dameWhereStock(cursor, "d.codalmacen", false, fechaMax);
			valor = util.sqlSelect("lineasfacturascli ld INNER JOIN facturascli d ON ld.idfactura = d.idfactura", "SUM(ld.cantidad)", whereStock + " AND d.automatica <> true", "lineasfacturascli,facturascli");
			if (isNaN(valor)) {
				valor = 0;
			}
			break;
		}
		case "cantidadfp": {
			var whereStock:String = this.iface.dameWhereStock(cursor, "d.codalmacen", false, fechaMax);
			valor = util.sqlSelect("lineasfacturasprov ld INNER JOIN facturasprov d ON ld.idfactura = d.idfactura", "SUM(ld.cantidad)", whereStock + " AND d.automatica <> true", "lineasfacturasprov,facturasprov");
			if (isNaN(valor)) {
				valor = 0;
			}
			break;
		}
		case "cantidadtpv": {
			if (!sys.isLoadedModule("flfact_tpv")) {
				valor = 0;
				break;
			}
			var whereStock:String = this.iface.dameWhereStock(cursor, "d.codalmacen", false, fechaMax);
			valor = util.sqlSelect("tpv_lineascomanda ld INNER JOIN tpv_comandas d ON ld.idtpv_comanda = d.idtpv_comanda", "SUM(ld.cantidad)", whereStock, "tpv_lineascomanda,tpv_comandas");
			if (isNaN(valor)) {
				valor = 0;
			}
			break;
		}
		case "cantidadval": {
				valor = 0;
			// La tabla tpv_vales no se utiliza
			
// 			if (!sys.isLoadedModule("flfact_tpv")) {
// 				valor = 0;
// 				break;
// 			}
// 			var whereStock:String = this.iface.dameWhereStock(cursor, "ld.codalmacen", "d.fechaemision", fechaMax);
// 			valor = util.sqlSelect("tpv_lineasvale ld INNER JOIN tpv_vales d ON ld.refvale = d.referencia", "SUM(ld.cantidad)", whereStock, "tpv_lineasvale,/*tpv_vales*/");
// 			if (isNaN(valor)) {
// 				valor = 0;
// 			}
			break;
		}
		case "cantidadts": {
			var whereStockOrigen:String = this.iface.dameWhereStock(cursor, "d.codalmaorigen", false, fechaMax);
			var valorOrigen:Number = util.sqlSelect("lineastransstock ld INNER JOIN transstock d ON ld.idtrans = d.idtrans", "SUM(ld.cantidad)", whereStockOrigen, "lineastransstock,transstock");
			if (isNaN(valorOrigen)) {
				valorOrigen = 0;
			}
			var whereStockDestino:String = this.iface.dameWhereStock(cursor, "d.codalmadestino", false, fechaMax);
			var valorDestino:Number = util.sqlSelect("lineastransstock ld INNER JOIN transstock d ON ld.idtrans = d.idtrans", "SUM(ld.cantidad)", whereStockDestino, "lineastransstock,transstock");
			if (isNaN(valorDestino)) {
				valorDestino = 0;
			}
			valor = parseFloat(valorDestino) - parseFloat(valorOrigen);
			break;
		}
		case "reservada": {
			var idPedido = oParam ? oParam.idPedido : false;
			var codAlmacen = cursor.valueBuffer("codalmacen");
			var referencia = cursor.valueBuffer("referencia");
			var where:String = "p.codalmacen = '" + codAlmacen + "' AND lp.referencia = '" + referencia + "' AND (lp.cerrada IS NULL OR lp.cerrada = false)";
			if (idPedido && idPedido != "") {
				where += " AND (p.servido IN ('No', 'Parcial') OR p.idpedido = " + idPedido + ")";
			} else {
				where += " AND p.servido IN ('No', 'Parcial')";
			}
			valor = util.sqlSelect("lineaspedidoscli lp INNER JOIN pedidoscli p ON lp.idpedido = p.idpedido", "sum(lp.cantidad - lp.totalenalbaran)", where, "lineaspedidoscli,pedidoscli");
			if (isNaN(valor)) {
				valor = 0;
			}
			break;
		}
		case "pterecibir": {
			var idPedido = oParam ? oParam.idPedido : false;
			var codAlmacen = cursor.valueBuffer("codalmacen");
			var referencia = cursor.valueBuffer("referencia");
			var codAlmacen:String = cursor.valueBuffer("codalmacen");
			var referencia:String = cursor.valueBuffer("referencia");
			var where:String = "p.codalmacen = '" + codAlmacen + "' AND lp.referencia = '" + referencia + "' AND (lp.cerrada IS NULL OR lp.cerrada = false)";
			if (idPedido && idPedido != "") {
				where += " AND (p.servido IN ('No', 'Parcial') OR p.idpedido = " + idPedido + ")";
			} else {
				where += " AND p.servido IN ('No', 'Parcial')";
			}
			valor = util.sqlSelect("lineaspedidosprov lp INNER JOIN pedidosprov p ON lp.idpedido = p.idpedido", "sum(lp.cantidad - lp.totalenalbaran)", where, "lineaspedidosprov,pedidosprov");
			if (isNaN(valor)) {
				valor = 0;
			}
			break;
		}
	}
	return valor;
}

function oficial_dameWhereStock(cursor, campoAlmacen, campoFecha, fechaMax)
{
	if (!campoFecha) {
		campoFecha = "d.fecha";
	}
	var fUltReg;
	if (fechaMax) {
		fUltReg = AQUtil.sqlSelect("lineasregstocks", "fecha", "idstock = " + cursor.valueBuffer("idstock") + " AND fecha <= '" + fechaMax + "' ORDER BY fecha DESC, hora DESC");
	} else {
		fUltReg = cursor.isNull("fechaultreg") ? false : cursor.valueBuffer("fechaultreg");
	}
	var whereStock = campoAlmacen + " = '" + cursor.valueBuffer("codalmacen") + "' AND ld.referencia = '" + cursor.valueBuffer("referencia") + "'";
	if (fUltReg) {
		whereStock += " AND ((" + campoFecha + " > '" + fUltReg + "') OR (" + campoFecha + " = '" + fUltReg + "' AND d.hora > '" + fUltReg.toString().right(8) + "'))";
	}
	if (fechaMax) {
		whereStock += " AND " + campoFecha + " < '" + fechaMax + "'"
	}
	return whereStock;
}

function oficial_calcularCantidad()
{
	var cursor:FLSqlCursor = this.cursor();
	
	this.iface.calcularValoresUltReg();
	
	this.child("fdbCantidad").setValue(cursor.valueBuffer("cantidadultreg"));
}

function oficial_calcularValoresUltReg()
{
	var cursor:FLSqlCursor = this.cursor();
	var fechaUltReg:String = this.iface.calculateField("fechaultreg");
	if (fechaUltReg) {
		this.child("fdbFechaUltReg").setValue(fechaUltReg);
		this.child("fdbHoraUltReg").setValue(this.iface.calculateField("horaultreg"));
		this.child("fdbCantidadUltReg").setValue(this.iface.calculateField("cantidadultreg"));
	} else {
		cursor.setNull("fechaultreg");
		cursor.setNull("horaultreg");
		this.child("fdbCantidadUltReg").setValue(0);
	}
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
