/***************************************************************************
                 tpv_cantidadpago.qs  -  description
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
	function calculateField(fN){
    return this.ctx.interna_calculateField(fN);
  }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var returnImp_, introImp_, returnEfe_, introEfe_;
	var vCOD, vSAP, vIMP, vSAN, vELI;
	function oficial( context ) { interna( context ); }
	function aceptarPago(accel) {
		return this.ctx.oficial_aceptarPago(accel);
	}
	function aceptarPagoEfectivo(accel) {
		return this.ctx.oficial_aceptarPagoEfectivo(accel);
	}
  function bufferChanged(fN){
    return this.ctx.oficial_bufferChanged(fN);
  }
  function creaTablaVales() {
    return this.ctx.oficial_creaTablaVales();
  }
  function nuevaLineaVale() {
    return this.ctx.oficial_nuevaLineaVale();
  }
  function recalculaVales() {
    return this.ctx.oficial_recalculaVales();
  }
  function tblVales_valueChanged(f, c) {
    return this.ctx.oficial_tblVales_valueChanged(f, c);
  }
  function borraVale(f, c) {
    return this.ctx.oficial_borraVale(f, c);
  }
  function cargaVale(f, c) {
    return this.ctx.oficial_cargaVale(f, c);
  }
  function tblVales_clicked(f, c) {
		return this.ctx.oficial_tblVales_clicked(f, c);
	}
	function cargaDatosVales() {
		return this.ctx.oficial_cargaDatosVales();
	}
	function aceptarFormulario() {
		return this.ctx.oficial_aceptarFormulario();
	}
	function valeYaEnTabla(refVale, fVale) {
		return this.ctx.oficial_valeYaEnTabla(refVale, fVale);
	}
	function validarCantidades() {
		return this.ctx.oficial_validarCantidades();
	}
	function dameCanNoEfectivo() {
		return this.ctx.oficial_dameCanNoEfectivo();
	}
	function cargaAQSButtonGroup(parent, name, oParam) {
		return this.ctx.oficial_cargaAQSButtonGroup(parent, name, oParam);
	}
	function cargaTarjetas() {
		return this.ctx.oficial_cargaTarjetas();
	}
	function cargaParamTarjetas(oParam) {
		return this.ctx.oficial_cargaParamTarjetas(oParam);
	}
	function bgpTarjetas_clicked(codTarjetaPago) {
		return this.ctx.oficial_bgpTarjetas_clicked(codTarjetaPago);
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
/** \C Se muestra el importe pendiente de pago seleccionado. Al pulsar Intro o Return el formulario se cerrará con el importe que el usuario haya establecido.
*/
function interna_init()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	this.child("fdbImporteEfectivo").editor().selectAll();
	var accel;
	var fdbImporte = this.child("fdbImporte");
	var fdbImporteEfectivo = this.child("fdbImporteEfectivo");
	
	disconnect(this.child("pushButtonAccept"), "clicked()", this.obj(), "accept()");
  
	connect(cursor, "bufferChanged(QString)", _i, "bufferChanged");
	connect(this.child("pushButtonAccept"), "clicked()", _i, "aceptarFormulario()");
	
	
	cursor.setValueBuffer("importeefectivo", 0);
	cursor.setValueBuffer("importetarjeta", 0);
	
	_i.returnEfe_ = fdbImporteEfectivo.insertAccel("Return");
	_i.introEfe_ = fdbImporteEfectivo.insertAccel("Enter");
	connect(fdbImporteEfectivo, "activatedAccel(int)", _i, "aceptarPagoEfectivo");
// 	
// 	_i.returnImp_ = fdbImporte.insertAccel("Return");
// 	_i.introImp_ = fdbImporte.insertAccel("Enter");
// 	connect(fdbImporte, "activatedAccel(int)", _i, "aceptarPago");
	
	connect(this.child("tblVales"), "valueChanged(int, int)", _i, "tblVales_valueChanged");
	connect(this.child("tblVales"), "clicked(int, int)", _i, "tblVales_clicked");
	
	_i.creaTablaVales();
	_i.nuevaLineaVale();
	this.child("gbxMasPag").close();
	
	_i.cargaTarjetas();
	sys.setObjText(this, "fdbPendiente", cursor.valueBuffer("importe"));
}

function interna_calculateField(fN)
{
	var _i = this.iface;
	var cursor = this.cursor();
	var valor;
	
	switch (fN) {
//     case "importe": {
//       valor = cursor.valueBuffer("importeefectivo") + cursor.valueBuffer("importetarjeta");
//       break;
//     }
		case "importetarjeta": {
			var val = parseFloat(cursor.valueBuffer("importevales"));
			val = isNaN(val) ? 0 : val;
			var ef = parseFloat(cursor.valueBuffer("importeefectivo"));
			ef = isNaN(ef) ? 0 : ef;
			var importe = parseFloat(cursor.valueBuffer("importe"));
			importe -= importe >= val ? val : 0
			valor = importe > ef ? importe - ef : "";
			break;
		}
		case "cambioefectivo": {
			var canNoEfectivo = _i.dameCanNoEfectivo();
			canNoEfectivo = parseFloat(canNoEfectivo);
			
			var ef = parseFloat(cursor.valueBuffer("importeefectivo"));
			ef = isNaN(ef) ? 0 : ef;
			
			var importe = parseFloat(cursor.valueBuffer("importe"));
			valor = ef - (importe - canNoEfectivo);
			
			if(importe > 0){
				if(valor < 0) {
					valor = 0;
				}
			}
			else{
				if(valor > 0){
					valor = 0;
				}
			}
			
			break;
		}
		case "pendiente": {
			if(parseFloat(cursor.valueBuffer("cambioefectivo")) > 0){
				valor = 0;
			}
			else{
				var importeTarjeta = parseFloat(cursor.valueBuffer("importetarjeta"));
				var restoImporte = _i.calculateField("importetarjeta");
				valor = restoImporte - importeTarjeta;
				if(valor < 0){
					valor = 0;
				}
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
function oficial_bufferChanged(fN)
{
  var _i = this.iface;
	var cursor = this.cursor();
	
	switch(fN){
		case "importeefectivo": {
			if(parseFloat(cursor.valueBuffer("importe")) > 0){
				sys.setObjText(this, "fdbImporteTarjeta", _i.calculateField("importetarjeta"));
			}
			sys.setObjText(this, "fdbCambioEfectivo", _i.calculateField("cambioefectivo"));
			sys.setObjText(this, "fdbPendiente", _i.calculateField("pendiente"));
			break;
		}
		case "importetarjeta":{
			sys.setObjText(this, "fdbCambioEfectivo", _i.calculateField("cambioefectivo"));
			sys.setObjText(this, "fdbPendiente", _i.calculateField("pendiente"));
			break;
		}
			case "importevales":{
			sys.setObjText(this, "fdbCambioEfectivo", _i.calculateField("cambioefectivo"));
			sys.setObjText(this, "fdbPendiente", _i.calculateField("pendiente"));
			break;
		}
	}
}

function oficial_aceptarPagoEfectivo(accel)
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	sys.setObjText(this, "fdbImporteTarjeta", _i.calculateField("importetarjeta"));
	sys.setObjText(this, "fdbCambioEfectivo", _i.calculateField("cambioefectivo"));
}

function oficial_aceptarPago(accel)
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var efectivo = cursor.valueBuffer("importeefectivo");
	efectivo = isNaN(efectivo) ? 0 : efectivo;
	var importe = cursor.valueBuffer("importe");
	importe = isNaN(importe) ? 0 : importe;
debug("accel " + accel);
debug("_i.returnEfe_ " + _i.returnEfe_);
	switch (accel) {
		case _i.returnEfe_:
		case _i.introEfe_: {
			if (importe > efectivo) {
				this.child("fdbImporteTarjeta").setValue(importe - efectivo);
			} else {
				this.accept();
			}
			break;
		}
	}
	if (!_i.cargaDatosVales()) {
		return false;
	}
	//this.child("pushButtonAccept").animateClick();
}

function oficial_cargaDatosVales()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var t = this.child("tblVales");

debug("oficial_cargaDatosVales");

	var importeVales = cursor.valueBuffer("importevales");
	importeVales = isNaN(importeVales) ? 0 : importeVales;
	if (importeVales == 0) {
		return true;
	}
	var datosVale = "", refVale;
	for (var f = 0; f < t.numRows(); f++) {
		refVale = t.text(f, _i.vCOD);
		debug("refVale " + refVale);
		if (refVale == "") {
			continue;
		}
		datosVale += refVale + "*" + t.text(f, _i.vIMP) + "\n";
		debug("datosVale " + datosVale);
	}
	cursor.setValueBuffer("datosvales", datosVale);
	return true;
}

function oficial_creaTablaVales()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var t = this.child("tblVales");
	var c = 0, cab = "", sep = "*";
	_i.vCOD = c++;
	cab += sys.translate("Nº Vale") + sep;
	_i.vSAP = c++;
	cab += sys.translate("Saldo") + sep;
	_i.vIMP = c++;
	cab += sys.translate("Importe") + sep;
	_i.vSAN = c++;
	cab += sys.translate("Nuevo S.") + sep;
	_i.vELI = c++;
	cab += sys.translate(" X ");
	
	t.setNumCols(c);
	t.setColumnWidth(_i.vCOD, 100);
	t.setColumnWidth(_i.vSAP, 60);
	t.setColumnWidth(_i.vIMP, 60);
	t.setColumnWidth(_i.vSAN, 60);
	t.setColumnWidth(_i.vELI, 30);
	t.setColumnReadOnly(_i.vSAP, true);
	t.setColumnReadOnly(_i.vIMP, true);
	t.setColumnReadOnly(_i.vSAN, true);
	t.setColumnReadOnly(_i.vELI, true);
	t.setColumnLabels(sep, cab);
}

function oficial_nuevaLineaVale()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var t = this.child("tblVales");
	var f = t.numRows();
	t.insertRows(f);
	t.setRowHeight(f, 40);
}

function oficial_tblVales_valueChanged(f, c)
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var t = this.child("tblVales");
	switch (c) {
		case _i.vCOD: {
			_i.cargaVale(f, c);
			break;
		}
	}
}

function oficial_tblVales_clicked(f, c)
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var t = this.child("tblVales");
	switch (c) {
		case _i.vELI: {
			_i.borraVale(f, c);
			break;
		}
	}
}

function oficial_borraVale(f, c)
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var t = this.child("tblVales");
	if (t.numRows() <= 1) {
		return;
	}
	t.removeRow(f);
	_i.recalculaVales();
}

function oficial_cargaVale(f, c)
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var t = this.child("tblVales");
	var refVale = t.text(f, c);
	var q = new FLSqlQuery();
	q.setSelect("codigo, saldopendiente");/**, fechacaducidad"); Antes se hacía sobre la tabla tpv_vales y con la fecha de caducidad*/
	q.setFrom("tpv_comandas");
	q.setWhere("codigo = '" + refVale + "' AND saldopendiente > 0");
	q.setForwardOnly(true);
	if (!q.exec()) {
		return false;
	}
	if (!q.first()) {
		MessageBox.warning(sys.translate("El vale %1 no existe").arg(refVale), MessageBox.Ok, MessageBox.NoButton);
		t.setText(f, c, "");
		t.setText(f, _i.vSAP, "");
	} else if (_i.valeYaEnTabla(refVale, f)) {
		MessageBox.warning(sys.translate("El vale %1 ya se ha usado").arg(refVale), MessageBox.Ok, MessageBox.NoButton);
		t.setText(f, c, "");
		t.setText(f, _i.vSAP, "");
	} else {
		t.setText(f, _i.vSAP, AQUtil.roundFieldValue(q.value("saldopendiente"), "tpv_comandas", "saldopendiente"));
	}
	_i.recalculaVales();
}

function oficial_valeYaEnTabla(refVale, fVale)
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var t = this.child("tblVales");
	for (var f = 0; f < t.numRows(); f++) {
		if (f == fVale) {
			continue;
		}
		if (t.text(f, _i.vCOD) == refVale) {
			return true;
		}
	}
	return false;
}

function oficial_recalculaVales()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var aPagar = parseFloat(cursor.valueBuffer("importe"));
	var t = this.child("tblVales");
	var filas = t.numRows();
	var f, vales = 0, vale = 0, importe, saldo;
	for (f = 0; f < filas; f++) {
		vale = parseFloat(t.text(f, _i.vSAP));
		vale = isNaN(vale) ? 0 : vale;
		if (vale > aPagar) {
			importe = aPagar;
		} else {
			importe = vale;
		}
		saldo = vale - importe;
		t.setText(f, _i.vIMP, AQUtil.roundFieldValue(importe, "tpv_comandas", "saldopendiente"));
		t.setText(f, _i.vSAN, AQUtil.roundFieldValue(saldo, "tpv_comandas", "saldopendiente"));
		aPagar -= importe;
		vales += importe;
	}
	sys.setObjText(this, "fdbImporteVales", vales);
	sys.setObjText(this, "fdbImporteTarjeta", _i.calculateField("importetarjeta"));
	sys.setObjText(this, "fdbCambioEfectivo", _i.calculateField("cambioefectivo"));
	if (aPagar > 0 && vale != "") {
		_i.nuevaLineaVale();
	}
}

function oficial_aceptarFormulario()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	if (!_i.cargaDatosVales()) {
		return false;
	}
	
	if(!_i.validarCantidades()) {
		return false;
	}
	
	this.accept();
}

function oficial_validarCantidades()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var aPagar = parseFloat(cursor.valueBuffer("importe"));
	var canNoEfectivo = _i.dameCanNoEfectivo();
	canNoEfectivo = parseFloat(canNoEfectivo);
	if (canNoEfectivo != 0 && canNoEfectivo > aPagar) {
		MessageBox.warning(sys.translate("La cantidad total a pagar distinta de efectivo no puede ser mayor que el importe del pago"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	return true;
}

function oficial_dameCanNoEfectivo()
{
	var _i = this.iface;
	var cursor = this.cursor();
	var tarjeta = parseFloat(cursor.valueBuffer("importetarjeta"));
	tarjeta = isNaN(tarjeta) ? 0 : tarjeta;
	var vales = parseFloat(cursor.valueBuffer("importevales"));
	vales = isNaN(vales) ? 0 : vales;
	
	var cNE = parseFloat(tarjeta) + parseFloat(vales);
	cNE = AQUtil.roundFieldValue(cNE, "tpv_cantidadpago", "importe");
  return cNE;
}

function oficial_cargaAQSButtonGroup(parent, name, oParam)
{
	var o = new AQSButtonGroup(parent, name, oParam);
	return o;
}

class AQSButtonGroup
{
	var bG_, aB_, idActual_;
	var fClicked_;
	var mgr_;
	const tSTRING_ = 3, tDECIMAL_ = 19;
  
  function AQSButtonGroup(parent, name, oParam)
  {
		p_ = oParam;
		bG_ = new QHButtonGroup(parent, name);
		
		fClicked_ = oParam.fClicked ? new Function("cursor", "return " + oParam.fClicked + "(cursor)") : undefined;

		mgr_ = aqApp.db().manager();
		
		var vLay = new QVBoxLayout(parent);
		vLay.addWidget(bG_);

		iniciaButtonGroup();
  }

  function iniciaButtonGroup()
  {
		var tabla, label, campoId, filtro, valorDefecto;
		idActual_ = false;
		if ("table" in p_) {
		 tabla = p_.table;
		} else {
			return false;
		}
		mtd = mgr_.metadata(tabla)
		label = ("labelField" in p_) ? p_.labelField : mtd.primaryKey();
		campoId = ("idField" in p_) ? p_.idField : mtd.primaryKey();
		filtro = ("filter" in p_) ? p_.filter : "";
		valorDefecto = ("defaultValue" in p_) ? p_.defaultValue : undefined;
		
		bG_.exclusive = ("exclusive" in p_) ? p_.exclusive : false;
		
		var q = new AQSqlQuery;
		q.setSelect((label == campoId) ? label : (label + "," + campoId));
		q.setFrom(tabla);
		q.setWhere(filtro);
		q.setForwardOnly(true);
		if (!q.exec()) {
			return false;
		}
		aB_ = [];
		var idButton = 0;
		var btn, valorId;
		while (q.next()) {
			valorId = q.value(campoId);
			btn = new QPushButton(bG_, bG_.name + "_B" + idButton) ;
			btn.text = (q.value(label));
			if (bG_.exclusive) {
				btn.toggleButton = true;
debug("valorDefecto " + valorDefecto  + " == valorId " + valorId); 
				if (valorDefecto && valorDefecto == valorId) {
					idActual_ = valorId;
					btn.on = true;
				}
			}
			aB_[idButton] = valorId;
			idButton++;
		}
		connect(bG_, "clicked(int)", this, "bG_clicked");
		bG_.show();
	}
	
	function bG_clicked(b) 
	{
		if (bG_.exclusive) {
			idActual_ = aB_[b];
			if (fClicked_) {
				fClicked_(idActual_);
			}
		}
	}
}

function oficial_cargaTarjetas()
{
	var _i = this.iface;
	var oParam = new Object;
	
	var codTarjetaDefecto = AQUtil.sqlSelect("tpv_tarjetaspago", "codtarjetapago", "valordefecto");
	_i.bgpTarjetas_clicked(codTarjetaDefecto);
	oParam.defaultValue = codTarjetaDefecto;
	
	_i.cargaParamTarjetas(oParam);
	var bgpTarjetas = _i.cargaAQSButtonGroup(this.child("gbxTarjetas"), "bgpTarjetas", oParam)
	
}

function oficial_cargaParamTarjetas(oParam)
{
	var ver = sys.version();
  var verBuild = parseInt(ver.mid(ver.lastIndexOf("Build") + 6));
  if (!isNaN(verBuild) && verBuild > 34895) {
    oParam.fClicked = "formtpv_cantidadpago.iface.bgpTarjetas_clicked";
	} else {
    oParam.fClicked = "formSearchtpv_cantidadpago.iface.bgpTarjetas_clicked";
	}
	oParam.table = "tpv_tarjetaspago";
	oParam.exclusive = true;
	return oParam;
}

function oficial_bgpTarjetas_clicked(codTarjetaPago)
{
	debug("oficial_bgpTarjetas_clicked " + codTarjetaPago);
	var _i = this.iface;
	var cursor = this.cursor();
	if (codTarjetaPago) {
		cursor.setValueBuffer("codtarjetapago", codTarjetaPago);
	}
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
