/***************************************************************************
                 seleccionlineasrec.qs  -  description
                             -------------------
    begin                : mar sep 29 2009
    copyright            : (C) 2009 by InfoSiAL S.L.
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
	var colLin, colSel, colRef, colDes, colPre, colRec;
	var blanco, verde;
	var aDatosFR;
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
	var util:FLUtil = new FLUtil;
	
	this.iface.aDatosFR = flfacturac.iface.pub_dameDatosFacturaRec();
	if (!this.iface.aDatosFR) {
		MessageBox.warning(util.translate("scripts", "Error al cargar los datos de líneasdel documento"), MessageBox.Ok, MessageBox.NoButton);
		this.close();
		return;
	}
// 	var tdbSeleccion = this.child("tdbSeleccion");
	this.child("lblCabecera").text = this.iface.aDatosFR.signo == "+"
		? util.translate("scripts", "Seleccione las líneas y cantidades a incluir")
		: util.translate("scripts", "Seleccione las líneas y cantidades a devolver");
		
	disconnect(this.child("pushButtonAccept"), "clicked()", this.obj(), "accept()");
	connect(this.child("pushButtonAccept"), "clicked()", this, "iface.aceptar()");
	connect(this.child("tbnDelFiltro"), "clicked()", this, "iface.tbnDelFiltro_clicked()");
	connect(this.child("tbnTodas"), "clicked()", this, "iface.tbnTodas_clicked()");
	
	connect(this.child("tblLineas"), "clicked(int, int)", this, "iface.tblLineas_clicked()");
	connect(this.child("tblLineas"), "valueChanged(int, int)", this, "iface.tblLineas_valueChanged()");
	
	this.iface.construirTabla();
	this.iface.cargarTabla();
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_tblLineas_clicked(f, c)
{
	var _i = this.iface;
	if (c != _i.colSel) {
		return;
	}
	var tblLineas = this.child("tblLineas");
	var s = tblLineas.text(f, _i.colSel);
	var cantidad;
	if (s == "X") {
// 		tblLineas.setText(f, _i.colSel, " ");
// 		tblLineas.setCellBackgroundColor(f, _i.colSel, _i.blanco);
// 		tblLineas.setText(f, _i.colRec, "0");
		cantidad = 0;
	} else {
/*		tblLineas.setText(f, _i.colSel, "X");
		tblLineas.setCellBackgroundColor(f, _i.colSel, _i.verde);*/
		cantidad = tblLineas.text(f, _i.colPre);
// 		tblLineas.setText(f, _i.colRec, cantidad);
	}
	tblLineas.setText(f, _i.colRec, cantidad);
	this.iface.tblLineas_valueChanged(f, _i.colRec);
}

function oficial_tblLineas_valueChanged(f, c)
{
debug("oficial_tblLineas_valueChanged c " + c)
	var _i = this.iface;
	if (c != _i.colRec) {
		return;
	}
	var tblLineas = this.child("tblLineas");
	var v = tblLineas.text(f, _i.colRec);
	v = !v || isNaN(v) ? 0 : v;
	
	tblLineas.setText(f, _i.colRec, v);
	if (v == 0) {
		tblLineas.setText(f, _i.colSel, " ");
		tblLineas.setCellBackgroundColor(f, _i.colSel, _i.blanco);
	} else {
		tblLineas.setText(f, _i.colSel, "X");
		tblLineas.setCellBackgroundColor(f, _i.colSel, _i.verde);
	}
}

function oficial_construirTabla()
{
	var util = new FLUtil;
	var cabecera = "";
	var _i = this.iface;
	var c = 0;
	_i.colLin = c++;
	cabecera += util.translate("scripts", "Línea") + "/";
	_i.colSel = c++;
	cabecera += util.translate("scripts", "Sel.") + "/";
	_i.colRef = c++;
	cabecera += util.translate("scripts", "Referencia") + "/"; 
	_i.colDes = c++;
	cabecera += util.translate("scripts", "Artículo") + "/";
	_i.colPre = c++;
	cabecera += util.translate("scripts", "F.Anterior") + "/";
	_i.colRec = c++;
	cabecera += util.translate("scripts", "F.Actual");
	
	var tblLineas = this.child("tblLineas");
	tblLineas.setNumCols(c);
	tblLineas.hideColumn(_i.colLin);
	tblLineas.setColumnWidth(_i.colSel, 50);
	tblLineas.setColumnReadOnly(_i.colSel, true);
	tblLineas.setColumnWidth(_i.colRef, 120);
	tblLineas.setColumnReadOnly(_i.colRef, true);
	tblLineas.setColumnWidth(_i.colDes, 250);
	tblLineas.setColumnReadOnly(_i.colDes, true);
	tblLineas.setColumnWidth(_i.colPre, 50);
	tblLineas.setColumnReadOnly(_i.colPre, true);
	tblLineas.setColumnWidth(_i.colRec, 50);
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
	var util = new FLUtil;
	var _i = this.iface;
	var tblLineas = this.child("tblLineas");
	tblLineas.setNumRows(0);
	
	var valorDefectoSel = _i.dameValorDefectoSel();
	
	var q = new FLSqlQuery;
	q.setTablesList(_i.aDatosFR.tabla);
	q.setSelect("idlinea, referencia, cantidad, descripcion");
	q.setFrom(_i.aDatosFR.tabla);
	switch(_i.aDatosFR.tabla) {
		case "lineasfacturascli":
		case "lineasfacturasprov": {
			q.setWhere("idfactura = " + _i.aDatosFR.idfactura + " ORDER BY referencia");
			break;
		}
		case "lineasalbaranescli":
		case "lineasalbaranesprov": {
			q.setWhere("idalbaran = " + _i.aDatosFR.idalbaran+ " ORDER BY referencia");
			break;
		}
		case "lineaspedidoscli":
		case "lineaspedidosprov": {
			q.setWhere("idpedido = " + _i.aDatosFR.idpedido + " ORDER BY referencia");
			break;
		}
		case "lineaspresupuestoscli": {
			q.setWhere("idpresupuesto = " + _i.aDatosFR.idpresupuesto+ " ORDER BY referencia");
			break;
		}
	}
	q.setForwardOnly(true);
	if (!q.exec()) {
		return;
	}
	var f = 0;
	while (q.next()) {
		tblLineas.insertRows(f, 1);
		tblLineas.setText(f, _i.colLin, q.value("idlinea"));
		tblLineas.setText(f, _i.colSel, valorDefectoSel);
		tblLineas.setCellAlignment(f, _i.colSel, tblLineas.AlignHCenter);
		tblLineas.setCellBackgroundColor(f, _i.colSel, valorDefectoSel == "X" ? _i.verde : _i.blanco);
		tblLineas.setText(f, _i.colRef, q.value("referencia"));
		tblLineas.setCellAlignment(f, _i.colRef, tblLineas.AlignLeft);
		tblLineas.setText(f, _i.colDes, q.value("descripcion"));
		tblLineas.setText(f, _i.colPre, q.value("cantidad"));
		tblLineas.setText(f, _i.colRec, q.value("cantidad"));
		tblLineas.setCellAlignment(f, _i.colRec, tblLineas.AlignRight);
		f++;
	}
	tblLineas.repaintContents();
}

function oficial_aceptar()
{
	var _i = this.iface;
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
		aValores[i]["cantidad"] = tblLineas.text(f, _i.colRec) * (_i.aDatosFR.signo == "+" ? 1 : -1);
		i++;
	}
	
// 	var tdbSeleccion = this.child("tdbSeleccion");
// 	var arrayValores:Array = tdbSeleccion.primarysKeysChecked();
// 	var valores:String;
// 	if (arrayValores && arrayValores.length > 0) {
// 		valores = arrayValores.join(", ");
// 	} else {
// 		valores = false;
// 	}
	flfacturac.iface.pub_ponSeleccionLineas(aValores);
	switch(this.iface.aDatosFR.tabla) {
		case "lineasfacturascli": {
			formRecordfacturascli.iface.pub_ponSeleccionValores(aValores);
			break;
		}
		case "lineasfacturasprov": {
			formRecordfacturasprov.iface.pub_ponSeleccionValores(aValores);
			break;
		}
	}
	this.accept();
}

function oficial_tbnDelFiltro_clicked()
{
	var _i = this.iface;
	var tblLineas = this.child("tblLineas");
	var tF = tblLineas.numRows();
	for (var f = 0; f < tF; f++) {
		tblLineas.setText(f, _i.colRec, 0)
		this.iface.tblLineas_valueChanged(f, _i.colRec);
	}
	
// 	var tdbSeleccion:FLTableDB = this.child("tdbSeleccion");
// 	tdbSeleccion.clearChecked();
// 	tdbSeleccion.refresh();
}

function oficial_tbnTodas_clicked()
{
	var _i = this.iface;
	var tblLineas = this.child("tblLineas");
	var tF = tblLineas.numRows();
	for (var f = 0; f < tF; f++) {
		tblLineas.setText(f, _i.colRec, tblLineas.text(f, _i.colPre))
		this.iface.tblLineas_valueChanged(f, _i.colRec);
	}
// 	var tdbSeleccion:FLTableDB = this.child("tdbSeleccion");
// 	var cursor:FLSqlCursor = this.cursor();
// 	var tabla:String = cursor.table();
// 	cursor.select();
// 	while (cursor.next()) {
// 		tdbSeleccion.setPrimaryKeyChecked(cursor.valueBuffer(cursor.primaryKey()), true);
// 	}
// 	tdbSeleccion.refresh();
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
