/***************************************************************************
                 tpv_masterconsultastock.qs  -  description
                             -------------------
    begin                : lub nov 29 2010
    copyright            : Por ahora (C) 2010 by InfoSiAL S.L.
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
    function init() {
		this.ctx.interna_init();
	}
	function main() {
		this.ctx.interna_main();
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var tblStock_;
	var aAlmacenes_;
	var aAlmacenesI_;
	var COL_REF;
	var COL_DES;
	var colsIzquierda_;
	var filaSel;
	var colSel;
	var maxQuery_ = 1000;
	function oficial( context ) { interna( context ); } 
// 	function tbnArticulo_clicked() {
// 		return this.ctx.oficial_tbnArticulo_clicked()
// 	}
	function filtrarStock(referencia:String) {
		return this.ctx.oficial_filtrarStock(referencia);
	}
	function filtraAlmacenes() {
		return this.ctx.oficial_filtraAlmacenes();
	}
	function filtroAlmacenes() {
		return this.ctx.oficial_filtroAlmacenes();
	}
	function construirWhereStocks() {
		return this.ctx.oficial_construirWhereStocks();
	}
// 	function ledArticulo_returnPressed() {
// 		return this.ctx.oficial_ledArticulo_returnPressed();
// 	}
	function preparaTabla() {
		return this.ctx.oficial_preparaTabla();
	}
	function cargaAlmacenes():Boolean {
		return this.ctx.oficial_cargaAlmacenes();
	}
	function mostrarStock(fila, col) {
		return this.ctx.oficial_mostrarStock(fila, col);
	}
	function tdbAlmacenes_primaryKeyToggled() {
		return this.ctx.oficial_tdbAlmacenes_primaryKeyToggled();
	}
	function cambiarSeleccion(fila, col) {
		return this.ctx.oficial_cambiarSeleccion(fila, col);
	}
	function cambiarSeleccion(fila, col) {
		return this.ctx.oficial_cambiarSeleccion(fila, col);
	}
	function dameNuevaConsulta() {
		return this.ctx.oficial_dameNuevaConsulta();
	}
// 	function iniciaFiltro() {
// 		return this.ctx.oficial_iniciaFiltro();
// 	}
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
/** \C 
*/
function interna_init()
{
	var _i = this.iface;
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	
	this.iface.tblStock_ = this.child("tblStock");
// 	connect(this.child("tbnArticulo"), "clicked()", this, "iface.tbnArticulo_clicked");
// 	connect(this.child("ledArticulo"), "returnPressed()", this, "iface.ledArticulo_returnPressed");
	connect(this.child("tbnFiltrar"), "clicked()", this, "iface.filtrarStock");
	connect(this.child("tdbAlmacenes"), "primaryKeyToggled(QVariant, bool)", _i, "tdbAlmacenes_primaryKeyToggled");
	connect(this.child("toolButtonZoomStocks"), "clicked()", this, "iface.mostrarStock");
	connect(this.iface.tblStock_ , "doubleClicked(int, int)", this, "iface.mostrarStock");
	connect(this.iface.tblStock_ , "clicked(int, int)", this, "iface.cambiarSeleccion");
	
	_i.filtraAlmacenes();
	this.child("tdbAlmacenes").setReadOnly(true);
	
	this.iface.preparaTabla();
	
// 	this.iface.iniciaFiltro();
}

function interna_main()
{
	flfact_tpv.iface.pub_consultarStock("");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_dameNuevaConsulta()
{
	return new FLSqlQuery;
}

function oficial_cargaAlmacenes()
{
	var _i = this.iface;
	var where = "(1 = 1)";
	var arrayAlmacenes = this.child("tdbAlmacenes").primarysKeysChecked();
	var almacenes = "";
	for(var i=0;i<arrayAlmacenes.length;i++) {
		if(almacenes != "")
			almacenes += ",";
		almacenes += "'" + arrayAlmacenes[i] + "'";
	}
		
	if(almacenes && almacenes != "") {
		where = "codalmacen in (" + almacenes + ")";
	}
	
	var qryAlmacen = new FLSqlQuery;
	qryAlmacen.setTablesList("almacenes");
	qryAlmacen.setSelect("codalmacen, nombre");
	qryAlmacen.setFrom("almacenes");
	qryAlmacen.setWhere(where + " ORDER BY codalmacen");
	qryAlmacen.setForwardOnly(true);
	if (!qryAlmacen.exec()) {
		return false;
	}
	debug(qryAlmacen.sql());
	this.iface.aAlmacenesI_ = new Array;
	this.iface.aAlmacenes_ = new Array;
	var i:Number = 0, codAlmacen:String;
	while (qryAlmacen.next()) {
		codAlmacen = qryAlmacen.value("codalmacen");
		this.iface.aAlmacenesI_[i] = codAlmacen;
		this.iface.aAlmacenes_[codAlmacen] = [];
		this.iface.aAlmacenes_[codAlmacen]["nombre"] = qryAlmacen.value("nombre");
		this.iface.aAlmacenes_[codAlmacen]["col"] = 0;
		i++;
	}
	return true;
}

function oficial_preparaTabla()
{
	var util:FLUtil = new FLUtil;
	if (!this.iface.cargaAlmacenes()) {
		return false;
	}
	var numAlmacenes:Number = this.iface.aAlmacenesI_.length;
	
	this.iface.COL_REF = 0;
	this.iface.COL_DES = 1;
	this.iface.colsIzquierda_ = 2;
	var numCols:Number = this.iface.colsIzquierda_ + numAlmacenes;
	var sep:String = "*";
	var cabecera:String = util.translate("scripts", "Ref.") + sep + util.translate("scripts", "Artículo");

	this.iface.tblStock_.setNumCols(numCols);
	this.iface.tblStock_.setColumnWidth(this.iface.COL_REF, 80);
	this.iface.tblStock_.setColumnWidth(this.iface.COL_DES, 130);
	var codAlmacen:String, col:Number;
	for (var i:Number = 0 ; i < numAlmacenes; i++) {
		codAlmacen = this.iface.aAlmacenesI_[i];
		col = this.iface.colsIzquierda_ + i;
		this.iface.tblStock_.setColumnWidth(col, 100);
		cabecera += sep + this.iface.aAlmacenes_[codAlmacen]["nombre"];
		this.iface.aAlmacenes_[codAlmacen]["col"] = col;
	}
	this.iface.tblStock_.setColumnLabels(sep, cabecera);
}

function oficial_tdbAlmacenes_primaryKeyToggled()
{
	var _i = this.iface;
	_i.preparaTabla();
	_i.filtrarStock();
}

function oficial_mostrarStock(fila, col)
{
	var _i = this.iface;
	
	if(!fila)
		fila = _i.filaSel;
	
	if(!col)
		col = _i.colSel;
	debug("col " + col);
	var referencia = this.iface.tblStock_.text(fila,this.iface.COL_REF);
	if(!referencia || referencia == "")
		return;	
	
	var codAlmacen = "";
	var almacen;
	for(almacen in this.iface.aAlmacenes_) {
		if(this.iface.aAlmacenes_[almacen]["col"] == col) {
			codAlmacen = almacen;
			break
		}
	}
	debug("codAlmacen " + codAlmacen);
	if(!codAlmacen || codAlmacen == "")
		return;
	
	var idStock = AQUtil.sqlSelect("stocks","idstock","referencia = '" + referencia + "' AND codalmacen = '" + codAlmacen + "'");
	if(!idStock)
		return;
	
	var curStock = new FLSqlCursor("stocks");
	curStock.select("idstock = " + idStock);
	if(!curStock.first())
		return;
	curStock.browseRecord();
}

function oficial_cambiarSeleccion(fila, col)
{
	var _i = this.iface;
	_i.filaSel = fila;
	_i.colSel = col;
}
// function oficial_tbnArticulo_clicked()
// {
// 	var util:FLUtil = new FLUtil();
// 	var f:Object = new FLFormSearchDB("articulos");
// 	f.setMainWidget();
// 	
// 	var referencia:String = f.exec("referencia");
// 	if (!referencia) {
// 		return false;
// 	}
// 	this.child("ledArticulo").text = referencia;
// 	this.iface.ledArticulo_returnPressed();
// }

// function oficial_ledArticulo_returnPressed()
// {
// 	var referencia:String = this.child("ledArticulo").text;
// 	this.iface.filtrarStock(referencia);
// }

// function oficial_iniciaFiltro()
// {
// 	var oArticulo = flfact_tpv.iface.dameArtConsultaStock();
// 	if (!oArticulo) {
// 		return;
// 	}
// 	var referencia = oArticulo.referencia;
// 	if (!referencia || referencia == "") {
// 		return;
// 	}
// 	this.child("ledArticulo").text = referencia;
// 	this.iface.ledArticulo_returnPressed();
// }
function oficial_construirWhereStocks()
{
	var where = "1=1";
	var referenciaC = this.child("fdbReferencia").value();
	var codFamiliaC = this.child("fdbCodFamilia").value();
	
	var arrayAlmacenes = this.child("tdbAlmacenes").primarysKeysChecked();
	var almacenes = "";
	for(var i=0;i<arrayAlmacenes.length;i++) {
		if(almacenes != "")
			almacenes += ",";
		almacenes += "'" + arrayAlmacenes[i] + "'";
	}
		
	if(almacenes && almacenes != "") {
		if(where != "")
			where += " and ";
		where += "s.codalmacen in (" + almacenes + ")";
	}

	if(referenciaC && referenciaC != "") {
		if(where != "")
			where += " and ";
		where += "s.referencia = '" + referenciaC + "'";
	}
	
	if(codFamiliaC && codFamiliaC != "") {
		if(where != "")
			where += " and ";
		where += "a.codfamilia = '" + codFamiliaC + "'";
	}
	return where;
}
	
function oficial_filtrarStock()
{
	var _i = this.iface;
	var where = _i.construirWhereStocks();
	
	//var descripcion = cursor.valueBuffer("descarticulo");
// 	if (!descripcion) {
// 		descripcion = util.translate("scripts", "El artículo %1 no existe").arg(referencia);
// 		where = "1 = 2";
// 	} else {

// 	}
		
	//this.child("lblDesArticulo").text = descripcion;
	this.iface.tblStock_.setNumRows(0);
	var qryStock = _i.dameNuevaConsulta();
	if(!qryStock){
		MessageBox.warning(sys.translate("No se ha podido realizar la consulta a la base de datos."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
	qryStock.setTablesList("stocks,articulos");
	qryStock.setSelect("s.idstock,s.referencia, s.cantidad, s.codalmacen, a.descripcion");
	qryStock.setFrom("stocks s INNER JOIN articulos a ON s.referencia = a.referencia");
	qryStock.setWhere(where + " ORDER BY s.referencia");
	qryStock.setForwardOnly(true);
	if (!qryStock.exec()) {
		return false;
	}
	if (qryStock.size() > _i.maxQuery_) {
		var res = MessageBox.warning(sys.translate("La consulta devuelve %1 resultados. ¿Continuar?").arg(qryStock.size()), MessageBox.Yes, MessageBox.No, MessageBox.NoButton, "AbanQ");
		if (res != MessageBox.Yes) {
			return false;
		}
	}
	var refAnterior = "", referencia, codAlmacen, cantidad, fila = -1, col;
	while (qryStock.next()) {
		referencia = qryStock.value("s.referencia");
		codAlmacen = qryStock.value("s.codalmacen");
		cantidad = qryStock.value("s.cantidad");
		if (refAnterior == "" || refAnterior != referencia) {
			fila++;
			this.iface.tblStock_.insertRows(fila);
			this.iface.tblStock_.setText(fila, this.iface.COL_REF, referencia);
			this.iface.tblStock_.setText(fila, this.iface.COL_DES, qryStock.value("a.descripcion"));
		}
		col = this.iface.aAlmacenes_[codAlmacen]["col"];
		this.iface.tblStock_.setText(fila, col, cantidad);
		refAnterior = referencia;
	}
}

function oficial_filtraAlmacenes()
{
	var _i = this.iface;
	var t = this.child("tdbAlmacenes");
	t.cursor().setMainFilter(_i.filtroAlmacenes());
	t.refresh();
}

function oficial_filtroAlmacenes()
{
	return "";
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
