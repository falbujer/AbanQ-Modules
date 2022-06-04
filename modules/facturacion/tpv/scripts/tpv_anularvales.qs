/***************************************************************************
                 tpv_anularvales.qs  -  description
                             -------------------
    begin                : mie nov 14 2012
    copyright            : Por ahora (C) 2012 by InfoSiAL S.L.
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
    function init() { 
		this.ctx.interna_init();
	}
	function calculateField(fN) {
		return this.ctx.interna_calculateField(fN);
	}
	function validateForm() {
		return this.ctx.interna_validateForm();
	}
}

//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	
	function oficial( context ) { interna( context ); } 
	function bufferChanged(fN) {
		return this.ctx.oficial_bufferChanged(fN);
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

function interna_init()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	connect(cursor, "bufferChanged(QString)", _i, "bufferChanged");
	
}

function interna_calculateField(fN)
{
	var _i = this.iface;
	var cursor = this.cursor();

	var valor;

	switch (fN) {
		case "total": {
			valor = AQUtil.sqlSelect("tpv_comandas", "total", "codigo = '" + cursor.valueBuffer("codigo") + "'");
			valor = parseFloat(valor) * (-1);
			valor =  AQUtil.roundFieldValue(valor, "tpv_vales", "total");
			break;
		}
		case "saldo": {
			valor = AQUtil.sqlSelect("tpv_comandas", "saldopendiente", "codigo = '" + cursor.valueBuffer("codigo") + "'");
			valor =  AQUtil.roundFieldValue(valor, "tpv_vales", "total");
			break;
		}
		case "gastado": {
			var total = this.child("fdbTotal").value();
			var saldo = this.child("fdbSaldo").value();
			valor = parseFloat(total) - parseFloat(saldo);
			valor =  AQUtil.roundFieldValue(valor, "tpv_vales", "total");
			break;
		}
	}
	return valor;
}

function interna_validateForm()
{
	var _i = this.iface;

	return true;
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_bufferChanged(fN)
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	switch (fN) {
		case "codigo":{
			if (this.child("fdbCodigo").value().length == 12){
				var idComanda = AQUtil.sqlSelect("tpv_comandas", "idtpv_comanda", "codigo = '" + cursor.valueBuffer("codigo") + "'");
				if(idComanda){
					sys.setObjText(this, "fdbTotal", _i.calculateField("total"));
				}
			}
			break;
		}
		case "total":{
			sys.setObjText(this, "fdbSaldo", _i.calculateField("saldo"));
			break;
		}
		case "saldo":{
			sys.setObjText(this, "fdbGastado", _i.calculateField("gastado"));
			break;
		}
	}
}


//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////