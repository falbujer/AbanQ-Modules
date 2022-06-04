/***************************************************************************
                 evolucioncuenta.qs  -  description
                             -------------------
    begin                : lun 11 marzo 2013
    copyright            : (C) 2013 by InfoSiAL S.L.
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
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	
	var tblResultados_;
	var cabecera_;
	var aDatos_, saldo_;
	var cFECHA_, cCONCEP_, cINGRESO_, cGASTO_, cSALDO_;
	var bloqueoSaldo_;
	
	function oficial( context ) { interna( context ); } 
	function bufferChanged(fN) { this.ctx.oficial_bufferChanged(fN); }
	
	function calcularSaldoInicial() {
		return this.ctx.oficial_calcularSaldoInicial();
	}
	function construirTabla() {
		return this.ctx.oficial_construirTabla();
	}
	function tbnBuscar_clicked() {
		return this.ctx.oficial_tbnBuscar_clicked();
	}
	function comprobarFiltros() {
		return this.ctx.oficial_comprobarFiltros();
	}
	function ordenaArray(a, b) { 
		return this.ctx.oficial_ordenaArray(a, b);
	}
	function cargaEvolCuenta(codCuentaBancaria, fechaD, fechaH) {
		return this.ctx.oficial_cargaEvolCuenta(codCuentaBancaria, fechaD, fechaH);
	}
	function cargaEvolRecibosCli(codCuentaBancaria, fechaD, fechaH) {
		return this.ctx.oficial_cargaEvolRecibosCli(codCuentaBancaria, fechaD, fechaH);
	}
	function cargarTabla() {
		return this.ctx.oficial_cargarTabla();
	}
	function dameSelect(tabla, codCuentaBancaria, fechaD, fechaH) {
		return this.ctx.oficial_dameSelect(tabla, codCuentaBancaria, fechaD, fechaH);
	}
	function dameFrom(tabla, codCuentaBancaria, fechaD, fechaH) {
		return this.ctx.oficial_dameFrom(tabla, codCuentaBancaria, fechaD, fechaH);
	}
	function dameWhere(tabla, codCuentaBancaria, fechaD, fechaH) {
		return this.ctx.oficial_dameWhere(tabla, codCuentaBancaria, fechaD, fechaH);
	}
	function borrarTabla() {
		return this.ctx.oficial_borrarTabla();
	}
	function tbnExportExcel_clicked () {
		return this.ctx.oficial_tbnExportExcel_clicked();
	}
	function dameParamExcel() {
		return this.ctx.oficial_dameParamExcel();
	}
	function dameObjetoRecibo() {
		return this.ctx.oficial_dameObjetoRecibo();
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
	
	_i.tblResultados_ = this.child("tblResultados");
	
	connect(cursor, "bufferChanged(QString)", _i, "bufferChanged");
	connect(this.child("tbnBuscar"),"clicked()",_i, "tbnBuscar_clicked()");
	connect(this.child("tbnBorrar"),"clicked()",_i, "borrarTabla()");
	
	connect(this.child("tbnExportExcel"), "clicked()", _i, "tbnExportExcel_clicked()");

	_i.construirTabla();
  _i.aDatos_ = [];
	_i.bloqueoSaldo_ = false;
		
	if(cursor.modeAccess() == cursor.Edit){
		if(!_i.bloqueoSaldo_){
			_i.bloqueoSaldo_ = true;
			_i.saldo_ = parseFloat(_i.calcularSaldoInicial());
			sys.setObjText(this, "fdbSaldo", _i.saldo_);
			_i.bloqueoSaldo_ = false;
		}
	}
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
		/** \C Si cambia el intervalo se recalculan las fechas.
		\end */
		case "codintervalo":{
			var intervalo = [];
			if(cursor.valueBuffer("codintervalo")){
				intervalo = flfactppal.iface.pub_calcularIntervalo(cursor.valueBuffer("codintervalo"));
				cursor.setValueBuffer("fechadesde",intervalo.desde);
				cursor.setValueBuffer("fechahasta",intervalo.hasta);
			}
			break;
		}
		case "codcuentabancaria":{
			if(!_i.bloqueoSaldo_){
				_i.bloqueoSaldo_ = true;
				_i.saldo_ = _i.calcularSaldoInicial();
				sys.setObjText(this, "fdbSaldo", _i.saldo_);
				_i.bloqueoSaldo_ = false;
			}
			break;
		}
		case "saldo":{
			if(!_i.bloqueoSaldo_){
				_i.bloqueoSaldo_ = true;
				if(_i.tblResultados_.numRows() > 0){
					_i.borrarTabla();
				}
				_i.saldo_ = cursor.valueBuffer("saldo");
				_i.bloqueoSaldo_ = false;
			}
			break;
		}
	}
}

function oficial_calcularSaldoInicial()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var codCuentaBancaria = cursor.valueBuffer("codcuentabancaria");
	var codEjercicio = flfactppal.iface.pub_ejercicioActual();
	
	var saldo = AQUtil.sqlSelect("co_subcuentas cs INNER JOIN cuentasbanco cb ON cs.codsubcuenta = cb.codsubcuenta INNER JOIN evolucioncuenta ec ON ec.codcuentabancaria = cb.codcuenta", "cs.saldo", "ec.codcuentabancaria = '" + codCuentaBancaria + "' AND cs.codejercicio = '" + codEjercicio + "'", "co_subcuentas,cuentasbanco,evolucioncuenta");
	
	if(!saldo || isNaN(saldo)){
		saldo = 0;
	}
	
	return saldo;
}

function oficial_construirTabla()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var cabecera = "";
	var c = 0;
	
	_i.cFECHA_ = c++;
	cabecera += sys.translate( "Fecha") + "/";
	_i.cCONCEP_ = c++;
	cabecera += sys.translate( "Concepto") + "/";
	_i.cINGRESO_ = c++;
	cabecera += sys.translate( "Ingresos") + "/";
	_i.cGASTO_  = c++;
	cabecera += sys.translate( "Gastos") + "/";
	_i.cSALDO_ = c++;
	cabecera += sys.translate( "Saldo") + "/";
	
	
	_i.tblResultados_.setNumCols(c);
	
	_i.tblResultados_.setColumnWidth(_i.cFECHA_, 80);
	_i.tblResultados_.setColumnWidth(_i.cCONCEP_, 350);
	_i.tblResultados_.setColumnWidth(_i.cINGRESO_, 80);
	_i.tblResultados_.setColumnWidth(_i.cGASTO_, 80);
	_i.tblResultados_.setColumnWidth(_i.cSALDO_, 100);
	
	
	_i.tblResultados_.setColumnReadOnly(_i.cFECHA_, true);
	_i.tblResultados_.setColumnReadOnly(_i.cCONCEP_, true);
	_i.tblResultados_.setColumnReadOnly(_i.cINGRESO_, true);
	_i.tblResultados_.setColumnReadOnly(_i.cGASTO_, true);
	_i.tblResultados_.setColumnReadOnly(_i.cSALDO_, true);
	
	_i.tblResultados_.setColumnLabels("/", cabecera);
	_i.cabecera_ = cabecera.split("/");
}

function oficial_tbnBuscar_clicked()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var codCuentaBancaria = cursor.valueBuffer("codcuentabancaria");
	var fechaD = cursor.valueBuffer("fechadesde");
	var fechaH = cursor.valueBuffer("fechahasta");
	
	if(!_i.comprobarFiltros()){
		return;
	}
	
	if(_i.tblResultados_.numRows() > 0){
		_i.borrarTabla();
	}
	
	if(!_i.cargaEvolCuenta(codCuentaBancaria, fechaD, fechaH)){
		sys.infoMsgBox("NO se han podido cargar las previsiones de evolución de la cuenta.");
		return;
	}
	
	if(_i.aDatos_.length > 0){
		_i.cargarTabla();
	}
	else{
		sys.infoMsgBox("NO hay registros que coincidan con los filtros establecidos.");
	}
}

function oficial_comprobarFiltros()
{
	var _i = this.iface;
	var cursor = this.cursor();

	var codCuentaBancaria = cursor.valueBuffer("codcuentabancaria");
	var fechaH = cursor.valueBuffer("fechahasta");
	var fechaD = cursor.valueBuffer("fechadesde");
	
	if(!codCuentaBancaria || codCuentaBancaria == 0 || !fechaH || fechaH == 0){
		sys.infoMsgBox("Debe rellenar los campos del formulario para poder realizar la búsqueda de datos.");
		return false;
	}
	var hoy = new Date;
	
	if (AQUtil.daysTo(hoy,fechaD) != 0){
		sys.infoMsgBox("La fecha desde debe de ser el día de hoy para sacar una previsión.");
		sys.setObjText(this, "fdbFechaDesde", hoy);
		return false;
	}
	return true;
}

function oficial_cargaEvolCuenta(codCuentaBancaria, fechaD, fechaH)
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	if(!_i.aDatos_){
		_i.aDatos_ = [];
	}
	
	if(!_i.cargaEvolRecibosCli(codCuentaBancaria, fechaD, fechaH)){
		return false;
	}
	
	if(_i.aDatos_.length > 1){
		_i.aDatos_.sort(_i.ordenaArray);
	}
	return true;
}

function oficial_ordenaArray(a, b)
{
	if (a["fecha"] < b["fecha"]) {
		return -1;
	}
	if (a["fecha"] > b["fecha"]) {
		return 1;
	}
	return 0;
}

function oficial_cargaEvolRecibosCli(codCuentaBancaria, fechaD, fechaH)
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var select = _i.dameSelect("reciboscli", codCuentaBancaria, fechaD, fechaH);
	var from = _i.dameFrom("reciboscli", codCuentaBancaria, fechaD, fechaH);
	var where = _i.dameWhere("reciboscli", codCuentaBancaria, fechaD, fechaH);
	
	 var q = new FLSqlQuery;
	q.setSelect(select);
	q.setFrom(from);
	q.setWhere(where);
	
	q.setForwardOnly(true);
	if (!q.exec()) {
		return;
	}
	
	var p = 0;
	AQUtil.createProgressDialog(sys.translate("Buscando recibos de clientes..."), q.size());
	AQUtil.setProgress(1);

  var evLoop = aqApp.eventLoop();
  sys.AQTimer.singleShot(10, evLoop.exitLoop);
  evLoop.enterLoop();
	
	var i = _i.aDatos_.length;
	
	while (q.next()) {
		_i.aDatos_[i] = _i.dameObjetoRecibo();
		_i.aDatos_[i]["tabla"] = "reciboscli";
		_i.aDatos_[i]["clave"] = q.value("idrecibo");
		_i.aDatos_[i]["fecha"] = q.value("fecha");
		_i.aDatos_[i]["concepto"] = "Recibo " + q.value("codigo") + " del cliente " + q.value("codcliente");
		_i.aDatos_[i]["importe"] = q.value("importe");
		_i.aDatos_[i]["esIngreso"] = true;
		i++;
	}
	sys.AQTimer.singleShot(0, AQUtil.destroyProgressDialog);
	return true;
}

function oficial_cargarTabla()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	if(_i.aDatos_.length > 100){
		var res = MessageBox.warning(sys.translate("La búsqueda que va a lanzar ha encontrado %1 registros.\n¿Desea continuar?").arg(_i.aDatos_.length),MessageBox.Yes, MessageBox.No, MessageBox.NoButton,"AbanQ");
		if(res != MessageBox.Yes) {
			return;
		}
	}
	
	var p = 0;
	AQUtil.createProgressDialog(sys.translate("Insertando registros en la tabla..."), _i.aDatos_.length);
	AQUtil.setProgress(1);

  var evLoop = aqApp.eventLoop();
  sys.AQTimer.singleShot(10, evLoop.exitLoop);
  evLoop.enterLoop();
	
	var f = 0;
	var fecha,dia,mes,anyo;
	
	for(i = 0; i < _i.aDatos_.length; i++){
		AQUtil.setProgress(p++);
		_i.tblResultados_.insertRows(f, 1);
		
		fecha = _i.aDatos_[i]["fecha"];
		dia = fecha.getDate().toString();
		if(dia.length < 2){
			dia = "0" + dia;
		}
		mes = fecha.getMonth().toString();
		if(mes.length < 2){
			mes = "0" + mes;
		}
		anyo = fecha.getYear().toString();
		
		fecha = dia + "/" + mes + "/" + anyo;
		
		_i.tblResultados_.setText(f, _i.cFECHA_, fecha);
		_i.tblResultados_.setText(f, _i.cCONCEP_, _i.aDatos_[i]["concepto"]);
		/**
		_i.tblResultados_.setCellAlignment(f, _i.cINGRESO_, _i.tblResultados_.AlignRight);
		_i.tblResultados_.setCellAlignment(f, _i.cGASTO_, _i.tblResultados_.AlignRight);
		_i.tblResultados_.setCellAlignment(f, _i.cSALDO_, _i.tblResultados_.AlignRight);*/
		
		if(_i.aDatos_[i]["esIngreso"]){
			_i.tblResultados_.setText(f, _i.cINGRESO_, AQUtil.formatoMiles(AQUtil.roundFieldValue(_i.aDatos_[i]["importe"], "reciboscli", "importe")) + " ");
			_i.tblResultados_.setText(f, _i.cGASTO_, "0,00 ");
			_i.saldo_ += parseFloat(_i.aDatos_[i]["importe"]);
		}
		else{
			_i.tblResultados_.setText(f, _i.cINGRESO_, "0,00 ");
			_i.tblResultados_.setText(f, _i.cGASTO_, AQUtil.formatoMiles(AQUtil.roundFieldValue(_i.aDatos_[i]["importe"], "reciboscli", "importe")) + " ");
			_i.saldo_ -= parseFloat(_i.aDatos_[i]["importe"]);
		}
		_i.aDatos_[i]["saldo"] = _i.saldo_;
		_i.tblResultados_.setText(f, _i.cSALDO_, AQUtil.formatoMiles(AQUtil.roundFieldValue(_i.aDatos_[i]["saldo"], "reciboscli", "importe")) + " ");
		
		f++;
	}
	sys.AQTimer.singleShot(0, AQUtil.destroyProgressDialog);
}

function oficial_dameSelect(tabla, codCuentaBancaria, fechaD, fechaH)
{
	var _i = this.iface;
	var cursor = this.cursor();

	var select = "";
	
	switch (tabla){
		case "reciboscli":{
			select = "idrecibo,codigo,importe,fecha,codcliente";
			break;
		}
	}
	return select;
}

function oficial_dameFrom(tabla, codCuentaBancaria, fechaD, fechaH)
{
	var _i = this.iface;
	var cursor = this.cursor();

	var from = "";
	
	switch (tabla){
		case "reciboscli":{
			from = tabla;
			break;
		}
	}
	return from;
}

function oficial_dameWhere(tabla, codCuentaBancaria, fechaD, fechaH)
{
	var _i = this.iface;
	var cursor = this.cursor();

	var where = "";
	
	switch (tabla){
		case "reciboscli":{
			where = "fechav BETWEEN '" + fechaD + "' AND '" + fechaH + "' AND codcuentapagocli = '" + codCuentaBancaria + "' AND estado IN ('Emitido', 'Devuelto', 'Remesado')" ;
			break;
		}
	}
	return where;
}

function oficial_tbnExportExcel_clicked()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var oParam = _i.dameParamExcel();
	flfactppal.iface.pub_exportarTablaExcel(oParam);
}

function oficial_dameParamExcel()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
  var oParam = flfactppal.iface.pub_dameParamExcel();
	
	var fechaD = cursor.valueBuffer("fechadesde");
	if(fechaD && fechaD != 0){
		var dia = fechaD.getDate().toString();
		if(dia.length < 2){
			dia = "0" + dia;
		}
		var mes = fechaD.getMonth().toString();
		if(mes.length < 2){
			mes = "0" + mes;
		}
		var anyo = fechaD.getYear().toString();
		
		fechaD = dia + "/" + mes + "/" + anyo;
	}
	
	var fechaH = cursor.valueBuffer("fechahasta");
	var dia = fechaH.getDate().toString();
	if(dia.length < 2){
		dia = "0" + dia;
	}
	var mes = fechaH.getMonth().toString();
	if(mes.length < 2){
		mes = "0" + mes;
	}
	var anyo = fechaH.getYear().toString();
	
	fechaH = dia + "/" + mes + "/" + anyo;
	
	var fecha = "";
	
	if(fechaD){
		fecha += fechaD + " - ";
	}
	fecha += fechaH;
	
  oParam.nombreFichero = "prevision";
  oParam.tabla = _i.tblResultados_;
  oParam.nombreColumnas = _i.cabecera_;
  oParam.titulo = "PREVISIÓN EVOLUCIÓN CUENTA " + cursor.valueBuffer("codcuentabancaria") + " (" + fecha + ")";
  return oParam;
}

function oficial_dameObjetoRecibo()
{
	var o = new Object();
	o.fecha = "";
	o.importe = "";
	o.concepto = "";
	o.saldo = "";
	o.tabla = "";
	o.clave = "";
	o.esIngreso = false;
	
	return o;
}

function oficial_borrarTabla()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	_i.tblResultados_.clear();
	_i.aDatos_ = [];
	if(!_i.bloqueoSaldo_){
		_i.bloqueoSaldo_ = true;
		_i.saldo_ = cursor.valueBuffer("saldo");
		_i.bloqueoSaldo_ = false;
	}
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
