/***************************************************************************
                 factteso_general.qs  -  description
                             -------------------
    begin                : mie nov 23 2005
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
	function main() {
		this.ctx.interna_main();
	}
	function init() {
		this.ctx.interna_init();
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
	function oficial( context ) { interna( context ); }
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function tbnActFechasCobro_clicked() {
		return this.ctx.oficial_tbnActFechasCobro_clicked();
	}
	function actualizarFechasCobroCli() {
		return this.ctx.oficial_actualizarFechasCobroCli();
	}
	function habilitaPorPagoRemesaCli() {
		return this.ctx.oficial_habilitaPorPagoRemesaCli();
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

/** @class_declaration ifaceCtx*/
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
	function ifaceCtx( context ) { head( context ); }
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
/**
\C Los datos generales son únicos, por tanto formulario de no presenta los botones de navegación por registros.
\end

\D La gestión del formulario se hace de forma manual mediante el objeto f (FLFormSearchDB)
\end
\end */
function interna_main()
{
	var f= new FLFormSearchDB("factteso_general");
	var cursor= f.cursor();

	cursor.select();
	if (!cursor.first())
		cursor.setModeAccess(cursor.Insert);
	else
		cursor.setModeAccess(cursor.Edit);

	f.setMainWidget();
	if (cursor.modeAccess() == cursor.Insert)
		f.child("pushButtonCancel").setDisabled(true);
	cursor.refreshBuffer();
	var commitOk= false;
	var acpt:Boolean;
	cursor.transaction(false);
	while (!commitOk) {
		acpt = false;
		f.exec("id");
		acpt = f.accepted();
		if (!acpt) {
			if (cursor.rollback())
				commitOk = true;
		} else {
			if (cursor.commitBuffer()) {
				cursor.commit();
				commitOk = true;
				flfactteso.iface.pub_cargaValoresDefecto();
			}
		}
		f.close();
	}
}

function interna_init()
{
	var _i = this.iface;
	debug("init!");
	var util= new FLUtil;
	var cursor= this.cursor();

	connect (cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect (this.child("tbnActFechasCobro"), "clicked()", this, "iface.tbnActFechasCobro_clicked");
	
	this.iface.bufferChanged("pagoindirecto");
	_i.habilitaPorPagoRemesaCli()
}

function interna_calculateField(fN)
{
	var _i = this.iface;
	var cursor = this.cursor();
	var valor;
	switch (fN) {
		case "pagodiferido": {
			if (cursor.valueBuffer("pagoindirecto")) {
				valor = true;
			} else {
				valor = cursor.valueBuffer("pagodiferido");
			}
			break;
		}
		case "pagoindirecto": {
			if (!cursor.valueBuffer("pagodiferido")) {
				valor = false;
			} else {
				valor = cursor.valueBuffer("pagoindirecto");
			}
			break;
		}
		case "despagoremesascli": {
			if (cursor.valueBuffer("pagoindirecto")) {
				valor = sys.translate("Al incluir un recibo de cliente en una remesa, el correspondiente asiento de pago se asigna a la subcuenta de Efectos comerciales de gestión de cobro (E.C.G.C.) asociada a la cuenta bancaria de la remesa. Cuando se recibe la confirmación del banco el usuario inserta un registro de pago para la remesa completa, que lleva las partidas de E.C.G.C. a la subcuenta de la cuenta bancaria.");
			} else if (cursor.valueBuffer("pagodiferido")) {
				valor = sys.translate("Al incluir un recibo de cliente en una remesa, el correspondiente asiento de pago no se realiza. Cuando se recibe la confirmación del banco el usuario inserta un registro de pago para la remesa completa, que generea con la fecha indicada los asientos de pago para cada recibo.");
			} else {
				valor = sys.translate("Al incluir un recibo de cliente en una remesa, el correspondiente asiento de pago se asigna directamente a la subcuenta de la cuenta bancaria indicada en la remesa.");
			}
			break;
		}
	}
	return valor;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_habilitaPorPagoRemesaCli()
{
	var cursor= this.cursor();
	if (cursor.valueBuffer("pagodiferido")) {
		this.child("fdbPagoIndirecto").setDisabled(false);
	} else {
		this.child("fdbPagoIndirecto").setDisabled(true);
	}
}

function oficial_bufferChanged(fN:String)
{
	var util= new FLUtil;
	var _i = this.iface;
	var cursor= this.cursor();
	switch (fN) {
		case "pagoindirecto": {
			this.child("fdbPagoDiferido").setValue(_i.calculateField("pagodiferido"));
			this.child("lblDesPagoIndirecto").text = _i.calculateField("despagoremesascli");
			break;
		}
		case "pagodiferido": {
			this.child("fdbPagoIndirecto").setValue(_i.calculateField("pagoindirecto"));
			this.child("lblDesPagoIndirecto").text = _i.calculateField("despagoremesascli");
			_i.habilitaPorPagoRemesaCli()
			break;
		}
	}
}

function oficial_tbnActFechasCobro_clicked()
{
	var util = new FLUtil;
	var res = MessageBox.warning(util.translate("scripts", "Va a actualizar los campos de fecha y cuenta de cobro de todos los recibos de cliente.\n¿Está seguro?"), MessageBox.Yes, MessageBox.No);
	if (res != MessageBox.Yes) {
		return;
	}
	var curT = new FLSqlCursor("empresa");
	curT.transaction(false);
	try {
		if (this.iface.actualizarFechasCobroCli()) {
			curT.commit();
		}
		else {
			curT.rollback();
			MessageBox.critical(util.translate("scripts", "Hubo un error en la actualización de fechas y cuentas de cobro"), MessageBox.Ok, MessageBox.NoButton);
			return;
		}
	} catch (e) {
		curT.rollback();
		MessageBox.critical(util.translate("scripts", "Hubo un error en la actualización de fechas y cuentas de cobro") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
		return;
	}
	MessageBox.information(util.translate("scripts", "Los recibos han sido actalizados correctamente"), MessageBox.Ok, MessageBox.NoButton);
}

function oficial_actualizarFechasCobroCli()
{
	var util = new FLUtil;
	flfactteso.iface.curReciboCli = new FLSqlCursor("reciboscli");
	var curRecibo = flfactteso.iface.curReciboCli;
	curRecibo.setActivatedCommitActions(false);
	curRecibo.setActivatedCheckIntegrity(false);	
	curRecibo.setForwardOnly(true);
	curRecibo.select();
	var totalRecibos = curRecibo.size();
	var paso = 0;
	util.createProgressDialog(util.translate("scripts", "Actualizando recibos"), totalRecibos);
	while (curRecibo.next()) {
		curRecibo.setModeAccess(curRecibo.Edit);
		curRecibo.refreshBuffer();
		if (!flfactteso.iface.totalesReciboCli()) {
			return false;
		}
// 		curRecibo.setValueBuffer("fechapago", formRecordreciboscli.iface.pub_commonCalculateField("fechapago", curRecibo));
// 		curRecibo.setValueBuffer("codcuentapago", formRecordreciboscli.iface.pub_commonCalculateField("codcuentapago", curRecibo));
		if (!curRecibo.commitBuffer()) {
			util.destroyProgressDialog();
			return false;
		}
		util.setProgress(++paso);
	}
	util.destroyProgressDialog();
	return true;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
