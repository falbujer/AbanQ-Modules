/***************************************************************************
                 tpv_seleccionlineasregalo.qs  -  description
                             -------------------
    begin                : mar ago 22 2012
    copyright            : (C) 2012 by InfoSiAL S.L.
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
	var colLin, colSel, colRef, colDes, colPre, colReg;
	var blanco, verde;
	var idTpv_;
	function oficial( context ) { interna( context );}
	function aceptar() {
		return this.ctx.oficial_aceptar();
	}
	function tbnDelFiltro_clicked() {
		return this.ctx.oficial_tbnDelFiltro_clicked();
	}
	function tbnTodas_clicked() {
		return this.ctx.oficial_tbnTodas_clicked();
	}
	function comprobarCantidadRegalo(fila, canLinea, canRegalo) {
		return this.ctx.oficial_comprobarCantidadRegalo(fila, canLinea, canRegalo);
	}
	function construirTabla() {
		return this.ctx.oficial_construirTabla();
	}
	function cargarTabla() {
		return this.ctx.oficial_cargarTabla();
	}
	function tblLineas_clicked(f, c) {
		return this.ctx.oficial_tblLineas_clicked(f, c);
	}
	function tblLineas_valueChanged(f, c) {
		return this.ctx.oficial_tblLineas_valueChanged(f, c);
	}
	function dameValorDefectoSel() {
		return this.ctx.oficial_dameValorDefectoSel();
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
function interna_init()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	_i.idTpv_ = formRecordtpv_comandas.iface.pub_dameIdTpv();
	if (!_i.idTpv_) {
		MessageBox.warning(sys.translate("Error al cargar las líneas."), MessageBox.Ok, MessageBox.NoButton);
		this.close();
		return;
	}
		
	disconnect(this.child("pushButtonAccept"), "clicked()", this.obj(), "accept()");
	connect(this.child("pushButtonAccept"), "clicked()", _i, "aceptar()");
	connect(this.child("tbnDelFiltro"), "clicked()", _i, "tbnDelFiltro_clicked()");
	connect(this.child("tbnTodas"), "clicked()", _i, "tbnTodas_clicked()");
	
	connect(this.child("tblLineas"), "clicked(int, int)", _i, "tblLineas_clicked()");
	connect(this.child("tblLineas"), "valueChanged(int, int)", _i, "tblLineas_valueChanged()");
	
	_i.construirTabla();
	_i.cargarTabla();
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_tblLineas_clicked(f, c)
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	if (c != _i.colSel) {
		return;
	}
	var tblLineas = this.child("tblLineas");
	var s = tblLineas.text(f, _i.colSel);
	var cantidad;
	if (s == "X") {
		cantidad = 0;
	} else {
		cantidad = tblLineas.text(f, _i.colPre);
	}
	tblLineas.setText(f, _i.colReg, cantidad);
	_i.tblLineas_valueChanged(f, _i.colReg);
}

function oficial_tblLineas_valueChanged(f, c)
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	if (c != _i.colReg) {
		return;
	}
	var tblLineas = this.child("tblLineas");
	var v = tblLineas.text(f, _i.colReg);
	v = !v || isNaN(v) ? 0 : v;
	
	tblLineas.setText(f, _i.colReg, v);
	if (v == 0) {
		tblLineas.setText(f, _i.colSel, " ");
		tblLineas.setCellBackgroundColor(f, _i.colSel, _i.blanco);
	} else {
		tblLineas.setText(f, _i.colSel, "X");
		tblLineas.setCellBackgroundColor(f, _i.colSel, _i.verde);
		var canLinea = tblLineas.text(f, _i.colPre);
		if(!_i.comprobarCantidadRegalo(f, canLinea, v)){
			MessageBox.warning(sys.translate("La cantidad para el ticket regalo no puede ser superior a la de la compra."), MessageBox.Ok, MessageBox.NoButton);
			tblLineas.setText(f, _i.colReg, canLinea);
		}
	}
}

function oficial_comprobarCantidadRegalo(fila, canLinea, canRegalo)
{
	var _i = this.iface;
	var cursor = this.cursor();

	canLinea = parseFloat(canLinea);
	canRegalo = parseFloat(canRegalo);
	
	if(canRegalo > canLinea){
		return false;
	}
	return true;
}

function oficial_construirTabla()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var cabecera = "";
	var _i = this.iface;
	var c = 0;
	_i.colLin = c++;
	cabecera += sys.translate("Línea") + "/";
	_i.colSel = c++;
	cabecera += sys.translate("Sel.") + "/";
	_i.colRef = c++;
	cabecera += sys.translate("Artículo") + "/"; 
	_i.colDes = c++;
	cabecera += sys.translate("Descripción") + "/";
	_i.colPre = c++;
	cabecera += sys.translate("C. Línea") + "/";
	_i.colReg = c++;
	cabecera += sys.translate("C. Regalo");
	
	var tblLineas = this.child("tblLineas");
	tblLineas.setNumCols(c);
	tblLineas.hideColumn(_i.colLin);
	tblLineas.setColumnWidth(_i.colSel, 50);
	tblLineas.setColumnReadOnly(_i.colSel, true);
	tblLineas.setColumnWidth(_i.colRef, 120);
	tblLineas.setColumnReadOnly(_i.colRef, true);
	tblLineas.setColumnWidth(_i.colDes, 250);
	tblLineas.setColumnReadOnly(_i.colDes, true);
	tblLineas.setColumnWidth(_i.colPre, 100);
	tblLineas.setColumnReadOnly(_i.colPre, true);
	tblLineas.setColumnWidth(_i.colReg, 100);
	tblLineas.setColumnLabels("/", cabecera);
	
	_i.blanco = new Color(250, 250, 250);
	_i.verde = new Color(50, 200, 50);
}

function oficial_dameValorDefectoSel()
{
	return "X";
}

function oficial_cargarTabla()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var tblLineas = this.child("tblLineas");
	tblLineas.setNumRows(0);
	
	var valorDefectoSel = _i.dameValorDefectoSel();
	
	var q = new FLSqlQuery;
	q.setSelect("idtpv_linea, referencia, cantidad, descripcion");
	q.setFrom("tpv_lineascomanda");
	q.setWhere("idtpv_comanda = " + _i.idTpv_ + " ORDER BY referencia");
		
	q.setForwardOnly(true);
	if (!q.exec()) {
		return;
	}
	var f = 0;
	while (q.next()) {
		tblLineas.insertRows(f, 1);
		tblLineas.setRowHeight(f, 28);
		tblLineas.setText(f, _i.colLin, q.value("idtpv_linea"));
		tblLineas.setText(f, _i.colSel, valorDefectoSel);
		tblLineas.setCellBackgroundColor(f, _i.colSel, valorDefectoSel == "X" ? _i.verde : _i.blanco);
		tblLineas.setText(f, _i.colRef, q.value("referencia"));
		tblLineas.setText(f, _i.colDes, q.value("descripcion"));
		tblLineas.setText(f, _i.colPre, q.value("cantidad"));
		tblLineas.setText(f, _i.colReg, q.value("cantidad"));
		f++;
	}
	tblLineas.repaintContents();
}

function oficial_aceptar()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var tblLineas = this.child("tblLineas");
	var tF = tblLineas.numRows();
	
	var aValores = [];
	var i = 0;
	for (var f = 0; f < tF; f++) {
		if (tblLineas.text(f, _i.colSel) != "X") {
			continue;
		}
		aValores[i] = new Object;
		aValores[i]["idlinea"] = tblLineas.text(f, _i.colLin);
		aValores[i]["canregalo"] = tblLineas.text(f, _i.colReg);
		i++;
	}
	
	formRecordtpv_comandas.iface.pub_ponCantidadRegalo(aValores);
	
	this.accept();
}

function oficial_tbnDelFiltro_clicked()
{
	var _i = this.iface;
	var tblLineas = this.child("tblLineas");
	var tF = tblLineas.numRows();
	for (var f = 0; f < tF; f++) {
		tblLineas.setText(f, _i.colReg, 0)
		_i.tblLineas_valueChanged(f, _i.colReg);
	}
	
}

function oficial_tbnTodas_clicked()
{
	var _i = this.iface;
	var tblLineas = this.child("tblLineas");
	var tF = tblLineas.numRows();
	for (var f = 0; f < tF; f++) {
		tblLineas.setText(f, _i.colReg, tblLineas.text(f, _i.colPre))
		_i.tblLineas_valueChanged(f, _i.colReg);
	}
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
