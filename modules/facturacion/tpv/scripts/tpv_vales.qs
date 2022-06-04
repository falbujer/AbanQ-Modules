/***************************************************************************
                 tpv_vales.qs  -  description
                             -------------------
    begin                : mie nov 15 2006
    copyright            : Por ahora (C) 2006 by InfoSiAL S.L.
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
	function refrescarTablas() {
		return this.ctx.oficial_refrescarTablas();
	}
  function devolverLinea() {
    return this.ctx.oficial_devolverLinea();
  }
  function devolverParcial() {
    return this.ctx.oficial_devolverParcial();
  }
  function anularLinea() {
    return this.ctx.oficial_anularLinea();
  }
  function copiarDatosLinea(curLineaPadre,cantidad) {
    return this.ctx.oficial_copiarDatosLinea(curLineaPadre,cantidad);
  }
  function incluirDatosLinea(curLinea,curLineaPadre) {
    return this.ctx.oficial_incluirDatosLinea(curLinea,curLineaPadre);
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
	connect(this.child("pbnDevuelveLinea"), "clicked()", _i, "devolverLinea");
	connect(this.child("pbnDevuelveParcial"), "clicked()", _i, "devolverParcial");
  connect(this.child("pbnAnula"), "clicked()", _i, "anularLinea");
	
	///this.child("pushButtonCancel").close();
	
	this.child("tdbLineasDevueltas").setReadOnly(true);
	this.child("tdbLineasComanda").setReadOnly(true);
	
	_i.refrescarTablas();
}

function interna_calculateField(fN)
{
	var _i = this.iface;
	var cursor = this.cursor();

	var valor;
	
		
	switch (fN) {
		case "total": {
			if(cursor.valueBuffer("idtpv_comanda") && cursor.valueBuffer("idtpv_comanda") != 0)
				valor = AQUtil.sqlSelect("tpv_lineascomanda", "SUM(pvptotal)", "idtpv_comanda = " + cursor.valueBuffer("idtpv_comanda"));
			else
				valor = 0;
			
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
					this.child("tdbLineasComanda").cursor().setMainFilter("idtpv_comanda = " + idComanda);
					this.child("tdbLineasComanda").refresh();
				}
			}
			break;
		}
	}
}

function oficial_refrescarTablas()
{
  var _i = this.iface;
  var cursor = this.cursor();
	
	var idComanda = cursor.valueBuffer("idtpv_comanda");
	if(idComanda){
		var idLinea = AQUtil.sqlSelect("tpv_lineascomanda", "idtpv_comanda", "idtpv_comanda = " + idComanda);
		if(idLinea){
			this.child("tdbLineasDevueltas").cursor().setMainFilter("idtpv_comanda = " + idComanda);
		}
		else{
			this.child("tdbLineasDevueltas").cursor().setMainFilter("1 = 2");
		}
	}
	else{
		this.child("tdbLineasDevueltas").cursor().setMainFilter("1 = 2");
	}
	this.child("tdbLineasDevueltas").refresh();
	
	if (!cursor.valueBuffer("codigo") || cursor.valueBuffer("codigo") == ""){
		this.child("tdbLineasComanda").cursor().setMainFilter("1 = 2");
		this.child("tdbLineasComanda").refresh();
	}
	else{
		_i.bufferChanged("codigo");
	}
	
	sys.setObjText(this, "fdbTotal", _i.calculateField("total"));
}

function oficial_devolverLinea()
{
	var _i = this.iface;
  var cursor = this.cursor();
	
	var lineas = this.child("tdbLineasComanda").cursor().size();
	
	if(lineas > 0){
		var curLineaPadre = this.child("tdbLineasComanda").cursor();
		var cantidad = curLineaPadre.valueBuffer("cantidad");

		_i.copiarDatosLinea(curLineaPadre,cantidad);
		_i.refrescarTablas();
	}
}

function oficial_devolverParcial()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var lineas = this.child("tdbLineasComanda").cursor().size();
	
	if(lineas > 0){
		var curLineaPadre = this.child("tdbLineasComanda").cursor();
		
		var dialog = new Dialog;
		
		dialog.caption = "Seleccione cantidad a devolver:";
		dialog.okButtonText = "Aceptar"
		dialog.cancelButtonText = "Cancelar";
		
		var cantidad = new NumberEdit;
		cantidad.value = curLineaPadre.valueBuffer("cantidad");
		cantidad.label = sys.translate("Cantidad:");
		cantidad.maximum = curLineaPadre.valueBuffer("cantidad");
		cantidad.decimals = 2;
		dialog.add(cantidad);

		if(!dialog.exec()) {
			return;
		}
		
		if(parseFloat(cantidad.value) > parseFloat(curLineaPadre.valueBuffer("cantidad"))){
			sys.infoMsgBox("No puede devolver una cantidad mayor a la comprada.");
			return ;
		}
		_i.copiarDatosLinea(curLineaPadre,cantidad.value);
		_i.refrescarTablas();
	}
}

function oficial_copiarDatosLinea(curLineaPadre,cantidad)
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var curLinea = new FLSqlCursor("tpv_lineascomanda");
	curLinea.setModeAccess(curLinea.Insert);
	curLinea.refreshBuffer();
	var dtoLineal = parseFloat(curLineaPadre.valueBuffer("dtolineal"))*-1
	with(curLinea){
		setValueBuffer("idtpv_comanda", cursor.valueBuffer("idtpv_comanda"));
		setValueBuffer("referencia", curLineaPadre.valueBuffer("referencia"));
		setValueBuffer("descripcion", curLineaPadre.valueBuffer("descripcion"));
		setValueBuffer("pvpunitario", curLineaPadre.valueBuffer("pvpunitario"));
		setValueBuffer("cantidad", cantidad*(-1));
		setValueBuffer("codimpuesto", curLineaPadre.valueBuffer("codimpuesto"));
		setValueBuffer("iva", curLineaPadre.valueBuffer("iva"));
		setValueBuffer("dtolineal", dtoLineal);
		setValueBuffer("dtopor", curLineaPadre.valueBuffer("dtopor"));
		setValueBuffer("recargo", curLineaPadre.valueBuffer("recargo"));
		setValueBuffer("irpf", curLineaPadre.valueBuffer("irpf"));
		setValueBuffer("porcomision", curLineaPadre.valueBuffer("porcomision"));
		setValueBuffer("costeunitario", curLineaPadre.valueBuffer("costeunitario"));
		setValueBuffer("pvpsindto", formRecordlineaspedidoscli.iface.pub_commonCalculateField("pvpsindto", this)*-1);
		setValueBuffer("pvptotal", formRecordlineaspedidoscli.iface.pub_commonCalculateField("pvptotal", this)*-1);
		setValueBuffer("codigovale", cursor.valueBuffer("codigo"));
	}
	if(!_i.incluirDatosLinea(curLinea,curLineaPadre)){
		return false;
	}
	if(!curLinea.commitBuffer()){
		MessageBox.warning(sys.translate("Problema al devolver la línea."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
		return;
	}
}

/// Para sobrecargar en extensiones con más datos en las líneas de comanda.
function oficial_incluirDatosLinea(curLinea,curLineaPadre)
{
	return true;
}

function oficial_anularLinea()
{
	var _i = this.iface;
  var cursor = this.cursor();
	
	var idLinea = this.child("tdbLineasDevueltas").cursor().valueBuffer("idtpv_linea");
	if (idLinea && idLinea != "") {
		if (!AQUtil.sqlDelete("tpv_lineascomanda", "idtpv_linea = " + idLinea)) {
			return false;
		}
	}
	
	_i.refrescarTablas();
	
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////