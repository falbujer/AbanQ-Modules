/***************************************************************************
                 tpv_pagoscomanda.qs  -  description
                             -------------------
    begin                : mar feb 07 2006
    copyright            : Por ahora (C) 2006 by InfoSiAL S.L.
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
class interna {
    var ctx:Object;
    function interna( context ) { this.ctx = context; }
    function init() { this.ctx.interna_init(); }
	function validateForm() {
		return this.ctx.interna_validateForm();
	}
	function calculateField(fN) {
		return this.ctx.interna_calculateField(fN);
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
    var lblPtoVenta:Object;
	var codPagoVales;
    function oficial( context ) { interna( context ); }
	function bufferChanged(fN) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function habilitarContabilidad() {
		return this.ctx.oficial_habilitarContabilidad();
	}
	function habilitarFormaPago() {
		return this.ctx.oficial_habilitarFormaPago();
	}
	function commonCalculateField(fN, cursor)
	{
		return this.ctx.oficial_commonCalculateField(fN, cursor);
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
El estado por defecto de los nuevos pagos es Pagado
*/
function interna_init()
{
	var _i = this.iface;
	var cursor= this.cursor();

	_i.codPagoVales = AQUtil.sqlSelect("tpv_datosgenerales", "pagovale", "1 = 1");

	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");

	switch (cursor.modeAccess()) {
		case cursor.Insert: {
			this.child("fdbEstado").setValue(sys.translate("Pagado"));
			this.child("fdbCodPago").setValue(cursor.cursorRelation().valueBuffer("codpago"));
			this.child("fdbCodPago").setValue(cursor.cursorRelation().valueBuffer("codpago"));
			var codTerminal = flfact_tpv.iface.pub_valorDefectoTPV("codterminal");
			if (codTerminal) {
				this.child("fdbCodTpvPuntoventa").setValue(codTerminal);
				this.child("fdbAgente").setValue(AQUtil.sqlSelect("tpv_puntosventa","codtpv_agente","codtpv_puntoventa ='" + codTerminal + "'"));
			}
			break;
		}
		case cursor.Edit: {
			this.child("fdbCodTpvPuntoventa").setDisabled(true);
			break;
		}
	}
	_i.habilitarContabilidad();
	_i.habilitarFormaPago();
}

function interna_validateForm()
{
	var _i = this.iface;
	var cursor= this.cursor();

  if (!flfact_tpv.iface.pub_controlDevolEfectivo(cursor)) {
    return false;
  }
	/** \C
	El pago debe producir un total inferior o igual al total de la comanda
	*/
	var totalComanda= parseFloat(cursor.cursorRelation().valueBuffer("total"));
	var totalPagos = parseFloat(AQUtil.sqlSelect("tpv_pagoscomanda", "SUM(importe)", "idtpv_comanda = " + cursor.valueBuffer("idtpv_comanda") + " AND idpago <> " + cursor.valueBuffer("idpago") + " AND estado = '" + sys.translate("Pagado") + "'"));
	if ((totalComanda - totalPagos) < parseFloat(cursor.valueBuffer("importe"))) {
		MessageBox.warning(sys.translate("El importe del pago hace que la suma de pagos sea superior al importe de la comanda"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	/** \C Si se ha pagado con un vale se comprueba que el importe sea igual o inferior al saldo del vale
	\end */
	var refVale= cursor.valueBuffer("refvale");
	if (refVale && refVale != "") {
		var importeVale = parseFloat(cursor.valueBuffer("importe"));
		var saldoPendiente = parseFloat(AQUtil.sqlSelect("tpv_comandas", "saldopendiente", "codigo = '" + refVale + "' AND tipodoc = 'DEVOLUCION'"));
		if(!saldoPendiente){
			MessageBox.warning(sys.translate("El código de vale introducido no es válido."), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
		if (importeVale > saldoPendiente) {
			MessageBox.warning(sys.translate("El importe indicado (%1) es superior al saldo del vale (%2)").arg(importeVale).arg(saldoPendiente), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
	}
	return true;
}

function interna_calculateField(fN)
{
	var_i = this.iface;
	var cursor= this.cursor();
	
	var valor;

	switch (fN) {
		/** \C
		El --importe--, cuando se ha establecido una referencia de vale, será el menor entre el pendiente por pagar y el saldo del vale
		*/
		case "importe": {
			var pendiente= parseFloat(cursor.cursorRelation().valueBuffer("pendiente"));
			var refVale= cursor.valueBuffer("refvale");
			if (refVale && refVale != "") {
				var saldoVale= AQUtil.sqlSelect("tpv_comandas", "saldopendiente", "codigo = '" + refVale + "'");
				if (saldoVale && parseFloat(saldoVale) < parseFloat(pendiente))
					pendiente = saldoVale;
			}
			valor = pendiente;
			break;
		}
		default: {
			valor = _i.commonCalculateField(fN, cursor);
		}
	}
	return valor;
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_bufferChanged(fN)
{
	var _i = this.iface;
	var cursor= this.cursor();
	switch (fN) {
		/** \C
		Si la forma de pago es la de vales se habilita el campo para incluir la referencia del vale 
		*/
		case "codpago": {
			/**var codPago= cursor.valueBuffer("codpago");
			if (codPago != "" && codPago == _i.codPagoVales)
				this.child("fdbRefVale").setDisabled(false);
			else {
				this.child("fdbRefVale").setValue("");
				this.child("fdbRefVale").setDisabled(true);
			}*/
			_i.habilitarFormaPago();
			break;
		}
		/** \C
		Cuando se establece la referencia del vale se avisa si éste ha caducado y se calcula el máximo importe que se puede obtener del vale
		*/
		case "refvale": {
			this.child("fdbImporte").setValue(_i.calculateField("importe"));
			break;
		}
	}
}

function oficial_habilitarContabilidad()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var soloVentas = AQUtil.sqlSelect("tpv_datosgenerales", "soloventas", "1 = 1");
	if(soloVentas){
		this.child("tbwPagoComanda").setTabEnabled("contabilidad", false);
	}
}

function oficial_habilitarFormaPago()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var codPago = cursor.valueBuffer("codpago");
	var contado = flfact_tpv.iface.pub_valorDefectoTPV("pagoefectivo");
	var tarjeta = flfact_tpv.iface.pub_valorDefectoTPV("pagotarjeta");
	var vale = flfact_tpv.iface.pub_valorDefectoTPV("pagovale");
	
	switch(codPago){
		case contado:{
			sys.setObjText(this, "fdbRefVale", "");
			sys.setObjText(this, "fdbCodTarjetaPago", "");
			this.child("fdbRefVale").setDisabled(true);
			this.child("fdbCodTarjetaPago").setDisabled(true);
			break;
		}
		case tarjeta:{
			sys.setObjText(this, "fdbRefVale", "");
			this.child("fdbRefVale").setDisabled(true);
			this.child("fdbCodTarjetaPago").setDisabled(false);
			break;
		}
		case vale:{
			sys.setObjText(this, "fdbCodTarjetaPago", "");
			this.child("fdbRefVale").setDisabled(false);
			this.child("fdbCodTarjetaPago").setDisabled(true);
			break;
		}
	}
}

function oficial_commonCalculateField(fN, cursor)
{
	
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
