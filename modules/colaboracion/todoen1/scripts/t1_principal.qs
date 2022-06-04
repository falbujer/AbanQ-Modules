/***************************************************************************
                 t1_principal.qs  -  description
                             -------------------
    begin                : lun sep 13 2010
    copyright            : (C) 2010 by InfoSiAL S.L.
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
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var Ctrl_K:Number;
	var Ctrl_O:Number;
	var CB_TIPO:Number;
	var CB_CLAVE:Number;
	var CB_DESC:Number;
	var CR_TIPO:Number;
	var CR_CARD:Number;
	var CR_ICONO:Number;
	var CR_DESC:Number;
	var CR_CLAVEREL:Number;
	var CER_TIPO:Number;
	var CER_CLAVE:Number;
	var CER_ICONO:Number;
	var CER_DES:Number;
	var ftSTRING_ = 3;
	var ftUINT_ = 17;
	var ftDOUBLE_ = 19;
	var ftDATE_ = 26;
	var ftSERIAL_ = 100;
	var ftUNLOCK_ = 200;
	var tblElementosBus_:FLTable;
	var tblAcciones_:FLTable;
	var tblRelaciones_:FLTable;
	var tblElementosRel_:FLTable;
	var xAcciones_:Number; /// Número de acciones que caben en una fila de la tabla acciones
	var aAcciones_:Number; /// Array con las acciones asociadas al elemento actual
	var aRelaciones_:Number; /// Array con las relaciones asociadas al elemento actual
	/// var aElementosRel_:Number; /// Array con los elementos de la relación seleccionada
	var aHistorialElementos_:Array;
	var iElementoHistorial_:Number;
	var xmlElemento_:FLDomElement;
	var picElemento_:Picture;
	var curObjeto_:FLSqlCursor;
	var buscarCambiado_:Boolean;
	var aElementos_:Array; /// Array que almacena los datos asociados a los tipos de elementos (icono, xml de su picture, etc).
	var aIndiceElementos_:Array; /// Array ordenado para recorrer la lista de elementos.
	var aDatosElemento_:Array; /// Array que almacena los datos del elemento actual
	var aIndiceDE_:Array; /// Array ordenado para recorrer la lista de datos de elemento actual.
	function oficial( context ) { interna( context ); }
	function iniciarTablas() {
		return this.ctx.oficial_iniciarTablas();
	}
	function accelActivated(iAccel) {
		return this.ctx.oficial_accelActivated(iAccel);
	}
	function revisarBD() {
		return this.ctx.oficial_revisarBD();
	}
	function iniciarTblElementosBus() {
		return this.ctx.oficial_iniciarTblElementosBus();
	}
	function iniciarTblAcciones() {
		return this.ctx.oficial_iniciarTblAcciones();
	}
	function iniciarTblRelaciones() {
		return this.ctx.oficial_iniciarTblRelaciones();
	}
	function iniciarTblElementosRel() {
		return this.ctx.oficial_iniciarTblElementosRel();
	}
	function tbnBuscar_clicked() {
		return this.ctx.oficial_tbnBuscar_clicked();
	}
	function buscarElementos(cadena:String):Boolean {
		return this.ctx.oficial_buscarElementos(cadena);
	}
	function buscarClientes(cadena:String):Boolean {
		return this.ctx.oficial_buscarClientes(cadena);
	}
	function buscarAgentes(cadena:String):Boolean {
		return this.ctx.oficial_buscarAgentes(cadena);
	}
	function muestraElementoActual():Boolean {
		return this.ctx.oficial_muestraElementoActual();
	}
	function actualizaDatosForm():Boolean {
		return this.ctx.oficial_actualizaDatosForm();
	}
	function muestraAcciones():Boolean {
		return this.ctx.oficial_muestraAcciones();
	}
	function muestraRelaciones():Boolean {
		return this.ctx.oficial_muestraRelaciones();
	}
	function dameDatosRelacion(tipo:String, clave:String, nombreRel:String):Array {
		return this.ctx.oficial_dameDatosRelacion(tipo, clave, nombreRel);
	}
	function cargaAcciones():Boolean {
		return this.ctx.oficial_cargaAcciones();
	}
	function cargaRelaciones():Boolean {
		return this.ctx.oficial_cargaRelaciones();
	}
	function eliminarAccels():Boolean {
		return this.ctx.oficial_eliminarAccels();
	}
	function ponElementoActual(tipo:String, clave:String):Boolean {
		return this.ctx.oficial_ponElementoActual(tipo, clave);
	}
	function tblElementosBus_clicked(fil:Number, col:Number) {
		return this.ctx.oficial_tblElementosBus_clicked(fil, col);
	}
	function tblAcciones_clicked(fila:Number, col:Number) {
		return this.ctx.oficial_tblAcciones_clicked(fila, col);
	}
	function lanzaAccion(indice:Number):Boolean {
		return this.ctx.oficial_lanzaAccion(indice);
	}
	function tblRelaciones_clicked(fila:Number, col:Number) {
		return this.ctx.oficial_tblRelaciones_clicked(fila, col);
	}
	function tblElementosRel_clicked(fila:Number, col:Number) {
		return this.ctx.oficial_tblElementosRel_clicked(fila, col);
	}
	function mostrarElementosRel(tipo:String, clave:String, relacion:String):Boolean {
		return this.ctx.oficial_mostrarElementosRel(tipo, clave, relacion);
	}
	function cargaDatosElemento(tipo:String, clave:String):Boolean {
		return this.ctx.oficial_cargaDatosElemento(tipo, clave);
	}
	function cargaCampoArrayDE(campo:String, valor):Boolean {
		return this.ctx.oficial_cargaCampoArrayDE(campo, valor);
	}
	function cargaValorCamposTabla(tabla:String, where:String):Array {
		return this.ctx.oficial_cargaValorCamposTabla(tabla, where);
	}
	function cargaSvgElemento(tipo:String, aDatos:Array):Boolean {
		return this.ctx.oficial_cargaSvgElemento(tipo, aDatos);
	}
	function dibujaTextoSvg(x:Number, y:Number, texto:String, idEstilo:String):Boolean {
		return this.ctx.oficial_dibujaTextoSvg(x, y, texto, idEstilo);
	}
	function generarFacturaCli(tipo:String, clave:String):Boolean {
		return this.ctx.oficial_generarFacturaCli(tipo, clave);
	}
	function generarPresupuestoCli(tipo:String, clave:String):Boolean {
		return this.ctx.oficial_generarPresupuestoCli(tipo, clave);
	}
	function generarPedidoCli(tipo:String, clave:String):Boolean {
		return this.ctx.oficial_generarPedidoCli(tipo, clave);
	}
	function generarAlbaranCli(tipo:String, clave:String):Boolean {
		return this.ctx.oficial_generarAlbaranCli(tipo, clave);
	}
	function tbnElementoSiguiente_clicked() {
		return this.ctx.oficial_tbnElementoSiguiente_clicked();
	}
	function tbnElementoPrevio_clicked() {
		return this.ctx.oficial_tbnElementoPrevio_clicked();
	}
	function dibujarIconoTabla(tabla:String, fila:Number, col:Number, tipo:String):Boolean {
		return this.ctx.oficial_dibujarIconoTabla(tabla, fila, col, tipo);
	}
	function dibujaPixmapRel(tabla:FLTable, fila:Number, col:Number, aDatos:Array, iRel:Number):Boolean {
		return this.ctx.oficial_dibujaPixmapRel(tabla, fila, col, aDatos, iRel);
	}
	function dibujaElemento(tipo:String, clave:String):Picture {
		return this.ctx.oficial_dibujaElemento(tipo, clave);
	}
// 	function cargaPicElemento(pic:Picture, tipo:String):Boolean {
// 		return this.ctx.oficial_cargaPicElemento(pic, tipo);
// 	}
	function dibujaPicture(pic:Picture, xmlPic:FLDomDocument, pixSize:Size, aDatos:Array):Boolean {
		return this.ctx.oficial_dibujaPicture(pic, xmlPic, pixSize, aDatos);
	}
	function damePicElementoDefecto(tipo:String):FLDomDocument {
		return this.ctx.oficial_damePicElementoDefecto(tipo);
	}
	function damePicRelacionDefecto(iRel:Number):FLDomDocument {
		return this.ctx.oficial_damePicRelacionDefecto(iRel);
	}
	function dibujaTextoPic(r:Rect, texto:String, estilo:String, pic:Picture, alineacion:Number):Boolean {
		return this.ctx.oficial_dibujaTextoPic(r, texto, estilo, pic, alineacion);
	}
// 	function cargaXMLElemento(tipo:String, clave:String):Boolean {
// 		return this.ctx.oficial_cargaXMLElemento(tipo, clave);
// 	}
	function muestraElemento(tipo:String, clave:String):Boolean {
		return this.ctx.oficial_muestraElemento(tipo, clave);
	}
	function refrescarRelacion(nombre:String) {
		return this.ctx.oficial_refrescarRelacion(nombre);
	}
	function dameIndiceRelacion(nombre:String):Number {
		return this.ctx.oficial_dameIndiceRelacion(nombre);
	}
	function dameFuente(family:String, size:Number):Font {
		return this.ctx.oficial_dameFuente(family, size);
	}
	function dameColor(color:String):Color {
		return this.ctx.oficial_dameColor(color);
	}
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function editarElementoSel() {
		return this.ctx.oficial_editarElementoSel();
	}
	function editarElemento(tipo:String, clave:String) {
		return this.ctx.oficial_editarElemento(tipo, clave);
	}
	function cargaElementos():Boolean {
		return this.ctx.oficial_cargaElementos();
	}
	function tbnEditaPicElemento_clicked() {
		return this.ctx.oficial_tbnEditaPicElemento_clicked();
	}
	function recargaPicElementos() {
		return this.ctx.oficial_recargaPicElementos();
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
	var util:FLUtil = new FLUtil;

	var cursor:FLSqlCursor = this.cursor();
	cursor.setModeAccess(cursor.Insert);
	cursor.refreshBuffer();

	this.iface.revisarBD();
	this.iface.iniciarTablas();
	//this.iface.pathImagenes = "/home/arodriguez/imagenes/icons";
	var fdbBuscar:FLFieldDB = this.child( "fdbBuscar" );
	this.iface.buscarCambiado_ = false;

//	this.iface.Ctrl_K = fdbBuscar.insertAccel( "Ctrl+K" );
//	this.iface.Ctrl_O = fdbBuscar.insertAccel( "Ctrl+O" );
	connect( fdbBuscar, "activatedAccel( int )", this,  "iface.accelActivated()" );
	connect( cursor, "bufferChanged(String)", this,  "iface.bufferChanged()" );

	this.iface.aHistorialElementos_ = [];
	this.iface.iElementoHistorial_ = -1;

	connect(this.child("tbnBuscar"), "clicked()", this, "iface.tbnBuscar_clicked");
	connect(this.child("tbnElementoPrevio"), "clicked()", this, "iface.tbnElementoPrevio_clicked");
	connect(this.child("tbnElementoSiguiente"), "clicked()", this, "iface.tbnElementoSiguiente_clicked");
	connect(this.child("tbnCargarIconos"), "clicked()", this, "iface.tbnCargarIconos_clicked");
	connect(this.child("tbnEditaPicElemento"), "clicked()", this, "iface.tbnEditaPicElemento_clicked");
	
	
	connect(this.iface.tblElementosBus_, "clicked(int, int)", this, "iface.tblElementosBus_clicked");
	connect(this.iface.tblAcciones_, "clicked(int, int)", this, "iface.tblAcciones_clicked");
	connect(this.iface.tblRelaciones_, "clicked(int, int)", this, "iface.tblRelaciones_clicked");
	connect(this.iface.tblElementosRel_, "clicked(int, int)", this, "iface.tblElementosRel_clicked");
	
	this.iface.cargaElementos();
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_iniciarTablas()
{
	this.iface.iniciarTblElementosBus();
	this.iface.iniciarTblAcciones();
	this.iface.iniciarTblRelaciones();
	this.iface.iniciarTblElementosRel();
}

function oficial_accelActivated(iAccel)
{
	var i:Number;
	for (i = 0; i < this.iface.aAcciones_.length; i++) {
		if (this.iface.aAcciones_[i]["accel"] == iAccel) {
			break;
		}
	}
	if (i < this.iface.aAcciones_.length) {
		if (!this.iface.lanzaAccion(i)) {
			return false;
		}
	}
}

function oficial_iniciarTblRelaciones()
{
	var util:FLUtil = new FLUtil;

	this.iface.tblRelaciones_ = this.child("tblRelaciones");
	try {
		this.iface.tblRelaciones_.setLeftMargin(0);
		this.iface.tblRelaciones_.setTopMargin(0);
	} catch (e) {}
	this.iface.CR_TIPO = 0;
	this.iface.CR_CARD = 1;
	this.iface.CR_CLAVEREL = 2;
	this.iface.CR_ICONO = 3;
	this.iface.CR_DESC = 4;

	this.iface.tblRelaciones_.setNumCols(5);
	var cL:String = util.translate("scripts", " ") + "*" + util.translate("scripts", " ") + "*" + util.translate("scripts", " ") + "*" + util.translate("scripts", " ") + "*" + util.translate("scripts", " ");
	this.iface.tblRelaciones_.setColumnLabels("*", cL);
	this.iface.tblRelaciones_.hideColumn(this.iface.CR_TIPO);
	this.iface.tblRelaciones_.hideColumn(this.iface.CR_CARD);
	this.iface.tblRelaciones_.hideColumn(this.iface.CR_CLAVEREL);
	this.iface.tblRelaciones_.setColumnWidth(this.iface.CR_ICONO, 40);
	this.iface.tblRelaciones_.setColumnWidth(this.iface.CR_DESC, 200);
}

function oficial_iniciarTblElementosRel()
{
	var util:FLUtil = new FLUtil;

	this.iface.tblElementosRel_ = this.child("tblElementosRel");
	try {
		this.iface.tblElementosRel_.setLeftMargin(0);
		this.iface.tblElementosRel_.setTopMargin(0);
	} catch (e) {}
	this.iface.CER_TIPO = 0;
	this.iface.CER_CLAVE = 1;
	this.iface.CER_ICONO = 2;
	this.iface.CER_DES = 3;

	this.iface.tblElementosRel_.setNumCols(4);
	var cL:String = util.translate("scripts", "Tipo") + "*" + util.translate("scripts", "Clave") + "*" + util.translate("scripts", " ") + "*" + util.translate("scripts", " ");
	this.iface.tblElementosRel_.setColumnLabels("*", cL);
	this.iface.tblElementosRel_.hideColumn(this.iface.CER_TIPO);
	this.iface.tblElementosRel_.hideColumn(this.iface.CER_CLAVE);
	this.iface.tblElementosRel_.setColumnWidth(this.iface.CER_ICONO, 40);
	this.iface.tblElementosRel_.setColumnWidth(this.iface.CER_DES, 200);
}

function oficial_iniciarTblAcciones()
{
	var util:FLUtil = new FLUtil;

	this.iface.tblAcciones_ = this.child("tblAcciones");
	try {
		this.iface.tblAcciones_.setLeftMargin(0);
		this.iface.tblAcciones_.setTopMargin(0);
	} catch (e) {}
	this.iface.xAcciones_ = 6;
	var numCols:Number = this.iface.xAcciones_;
	var colWidth:Number = 60;
	var cL:String = "";
	for (var i:Number = 0; i < numCols; i++) {
		cL += (i == 0 ? " " : "* ");
	}
	this.iface.tblAcciones_.setNumCols(numCols);
	this.iface.tblAcciones_.setColumnLabels("*", cL);
	for (var i:Number = 0; i < numCols; i++) {
		this.iface.tblAcciones_.setColumnWidth(i, colWidth);
	}
}

function oficial_iniciarTblElementosBus()
{
	var util:FLUtil = new FLUtil;

	this.iface.tblElementosBus_ = this.child("tblElementosBus");

	this.iface.CB_TIPO = 0;
	this.iface.CB_CLAVE = 1;
	this.iface.CB_DESC = 2;

	this.iface.tblElementosBus_.setNumCols(3);
	var cL:String = util.translate("scripts", "Tipo") + "*" + util.translate("scripts", "Clave") + "*" + util.translate("scripts", "Elemento");
	this.iface.tblElementosBus_.setColumnLabels("*", cL);
	this.iface.tblElementosBus_.hideColumn(this.iface.CB_TIPO);
	this.iface.tblElementosBus_.hideColumn(this.iface.CB_CLAVE);
	this.iface.tblElementosBus_.setColumnWidth(this.iface.CB_DESC, 200);
}

function oficial_tbnBuscar_clicked()
{
	this.child("fdbBuscar").setFocus();
	
	if (!this.iface.buscarCambiado_) {
		this.iface.editarElementoSel();
		return;
	}
	this.iface.buscarCambiado_ = false;
	var cadena:String = this.child("fdbBuscar").value();
	if (!cadena || cadena == "") {
		return false;
	}
	cadena = cadena.toUpperCase();
	
	this.iface.tblElementosBus_.setNumRows(0);
	if (!this.iface.buscarElementos(cadena)) {
		return false;
	}
	var totalFilas:Number = this.iface.tblElementosBus_.numRows();
	switch (totalFilas) {
		case 0: {
			return;
		}
		case 1: {
			this.iface.tblElementosBus_clicked(0);
			break;
		}
		default: {
			this.child("tbwElementos").showPage("busqueda");
		}
	}
}

function oficial_buscarElementos(cadena:String):Boolean
{
	if (!this.iface.buscarClientes(cadena)) {
		return false;
	}
	if (!this.iface.buscarAgentes(cadena)) {
		return false;
	}
	return true;
}

function oficial_buscarClientes(cadena:String):Boolean
{
	var util:FLUtil = new FLUtil;
	var fila:Number = this.iface.tblElementosBus_.numRows();

	var qryClientes:FLSqlQuery = new FLSqlQuery;
	qryClientes.setTablesList("clientes");
	qryClientes.setSelect("codcliente, nombre");
	qryClientes.setFrom("clientes");
	qryClientes.setWhere("UPPER(nombre) LIKE '%" + cadena + "%'");
	qryClientes.setForwardOnly(true);
	if (!qryClientes.exec()) {
		return false;
	}
	while (qryClientes.next()) {
		this.iface.tblElementosBus_.insertRows(fila);
		this.iface.tblElementosBus_.setText(fila, this.iface.CB_TIPO, "clientes");
		this.iface.tblElementosBus_.setText(fila, this.iface.CB_CLAVE, qryClientes.value("codcliente"));
		this.iface.tblElementosBus_.setText(fila, this.iface.CB_DESC, qryClientes.value("nombre"));
		fila++;
	}

	return true;
}

function oficial_buscarAgentes(cadena:String):Boolean
{
	var util:FLUtil = new FLUtil;
	var fila:Number = this.iface.tblElementosBus_.numRows();

	var qryClientes:FLSqlQuery = new FLSqlQuery;
	qryClientes.setTablesList("agentes");
	qryClientes.setSelect("codagente, nombreap");
	qryClientes.setFrom("agentes");
	qryClientes.setWhere("UPPER(nombreap) LIKE '%" + cadena + "%'");
	qryClientes.setForwardOnly(true);
	if (!qryClientes.exec()) {
		return false;
	}
	while (qryClientes.next()) {
		this.iface.tblElementosBus_.insertRows(fila);
		this.iface.tblElementosBus_.setText(fila, this.iface.CB_TIPO, "agentes");
		this.iface.tblElementosBus_.setText(fila, this.iface.CB_CLAVE, qryClientes.value("codagente"));
		this.iface.tblElementosBus_.setText(fila, this.iface.CB_DESC, qryClientes.value("nombreap"));
		fila++;
	}

	return true;
}

function oficial_tblElementosBus_clicked(fila:Number, col:Number)
{
	if (fila < 0) {
		return false;
	}
	var tipo:String = this.iface.tblElementosBus_.text(fila, this.iface.CB_TIPO);
	var clave:String = this.iface.tblElementosBus_.text(fila, this.iface.CB_CLAVE);
	if (!this.iface.ponElementoActual(tipo, clave)) {
		return false;
	}
}

function oficial_tblAcciones_clicked(fila:Number, col:Number)
{
	if (fila < 0) {
		return false;
	}
	if (!this.iface.aAcciones_) {
		return false;
	}
	var indice:Number = (fila * this.iface.xAcciones_) + col;
	if (indice >= this.iface.aAcciones_.length) {
		return false;
	}
	if (!this.iface.lanzaAccion(indice)) {
		return false;
	}
}

function oficial_lanzaAccion(indice:Number):Boolean
{
	var aElemento:Array = this.iface.aHistorialElementos_[this.iface.iElementoHistorial_];
	var funcion:String = this.iface.aAcciones_[indice]["funcion"];
	var llamada:String = "return formt1_principal.iface." + funcion + "(tipo, clave);";
	var f:Function = new Function("tipo", "clave", llamada);
	if (!(f(aElemento.tipo, aElemento.clave))) {
		return false;
	}
	
	return true;
}

function oficial_tblRelaciones_clicked(fila:Number, col:Number)
{
	if (fila < 0) {
		return false;
	}
	if (!this.iface.aRelaciones_) {
		return false;
	}
	var indice:Number = fila;
	if (indice >= this.iface.aRelaciones_.length) {
		return false;
	}
	
	var aElemento:Array = this.iface.aHistorialElementos_[this.iface.iElementoHistorial_];
	var relacion:String = this.iface.aRelaciones_[indice]["nombre"];
	var card:String = this.iface.aRelaciones_[indice]["card"];
	if (card == "1M") {
		if (!this.iface.mostrarElementosRel(aElemento.tipo, aElemento.clave, relacion)) {
			return false;
		}
	} else {
		var claveRel:String = this.iface.tblRelaciones_.text(indice, this.iface.CR_CLAVEREL);
		if (claveRel != "") {
			if (col == this.iface.CR_ICONO) {
				if (!this.iface.editarElemento(relacion, claveRel)) {
					return false;
				}
			} else {
				if (!this.iface.ponElementoActual(relacion, claveRel)) {
					return false;
				}
			}
		}
	}	
	
	return true;
}

function oficial_tblElementosRel_clicked(fila:Number, col:Number)
{
	if (fila < 0) {
		return false;
	}
	var tipo:String = this.iface.tblElementosRel_.text(fila, this.iface.CER_TIPO);
	var clave:String = this.iface.tblElementosRel_.text(fila, this.iface.CER_CLAVE);
	
	if (col == this.iface.CER_ICONO) {
		if (!this.iface.editarElemento(tipo, clave)) {
			return false;
		}
	} else {
		if (!this.iface.ponElementoActual(tipo, clave)) {
			return false;
		}
	}
	
	return true;
}

function oficial_dibujaPixmapRel(tabla:FLTable, fila:Number, col:Number, aDatos:Array, iRel:Number):Boolean
{
debug("oficial_dibujaPixmapRel");
	var util:FLUtil = new FLUtil;
// 	var icono:String = util.sqlSelect("t1_elementos", "icono", "elemento = '" + tipo + "'");
// 	if (!icono) {
// 		return false;
// 	}
	var pixSize = new Size(tabla.columnWidth(col), 32);
	
	var xmlPic:FLDomDocument = this.iface.aRelaciones_[iRel]["xmlPic"];
	if (!xmlPic) {
debug("No hay xmlPic en tabla");
		xmlPic = this.iface.damePicRelacionDefecto(iRel);
		if (!xmlPic) {
debug("!oficial_dibujaPixmapRel");
			return false;
		}
	}
debug(xmlPic.toString());
	
	var pic:Picture = new Picture;
	pic.begin();
	if (!this.iface.dibujaPicture(pic, xmlPic, pixSize, aDatos)) {
debug("!!!oficial_dibujaPixmapRel");
		return false;
	}
	
	var pixNew = new Pixmap;
	var clr = new Color;
	clr.setRgb(255,255,255);
	
	pixNew.resize(pixSize);
	pixNew.fill(clr);
	
	
// 	pic.begin();
// 	pic.drawPixmap(0, 0, pixNew);
	pixNew = pic.playOnPixmap(pixNew);
	pic.end();
	
	tabla.setPixmap(fila, col, pixNew);
	return true;
}

function oficial_dibujarIconoTabla(tabla:FLTable, fila:Number, col:Number, tipo:String):Boolean
{
	var util:FLUtil = new FLUtil;
// 	var icono:String = util.sqlSelect("t1_elementos", "icono", "elemento = '" + tipo + "'");
// 	if (!icono) {
// 		return false;
// 	}
	var pic = new Picture;
	var pixNew = new Pixmap;
	var clr = new Color;
	clr.setRgb(255,255,255);
	
// 	var pixIcono = sys.toPixmap(icono);
	var pixIcono = this.iface.aElementos_[tipo]["icono"];
	var pixSize = pixIcono.size;
	pixNew.resize(pixSize);
	pixNew.fill(clr);
	
	
	pic.begin();
	pic.drawPixmap(0, 0, pixNew);
	pic.drawPixmap(0, 0, pixIcono);
	pixNew = pic.playOnPixmap(pixNew);
	pic.end();
	
	tabla.setPixmap(fila, col, pixNew);
	return true;
}

function oficial_muestraElemento(tipo:String, clave:String):Boolean
{
	var util:FLUtil = new FLUtil;

	var pic = this.iface.dibujaElemento(tipo, clave);
	if (!pic) {
		return false;
	}
	var pixNew = new Pixmap;
	var clr = new Color;
	clr.setRgb(255,255,255);
// 	clr.setRgb(57,57,57);
	
	var pixSize = this.child("lblElemento").size;
	pixNew.resize(pixSize);
	pixNew.fill(clr);
	
//	pic.drawPixmap(0, 0, pixNew);
//	pic.drawPixmap(0, 0, pixIcono);
	pixNew = pic.playOnPixmap(pixNew);
	pic.end();
	
	this.child("lblElemento").pixmap = pixNew;
	return true;
}

function oficial_dibujaElemento(tipo:String, clave:String):Picture
{
	var util:FLUtil = new FLUtil;
	var pixSize = this.child("lblElemento").size;
	
	if (!this.iface.cargaDatosElemento(tipo, clave)) {
		return false;
	}
	
	var xmlPic:FLDomDocument = this.iface.aElementos_[tipo]["xmlPic"];
	if (!xmlPic) {
		xmlPic = this.iface.damePicElementoDefecto(tipo);
		if (!xmlPic) {
			return false;
		}
	}
	
	var pic:Picture = new Picture;
	pic.begin();
	if (!this.iface.dibujaPicture(pic, xmlPic, pixSize, this.iface.aDatosElemento_)) {
		return false;
	}
	return pic;
}

// function oficial_cargaPicElemento(pic:Picture, tipo:String):Boolean
// {
// 	var util:FLUtil = new FLUtil;
// 	var pixSize = this.child("lblElemento").size;
// /*
// 	if (this.iface.picElemento_) {
// 		this.iface.picElemento_.end();
// 		delete this.iface.picElemento_;
// 	}
// */
// debug("oficial_cargaPicElemento " + tipo);
// 	var r:Rect = new Rect(0, 0, pixSize.width, pixSize.height);
// 	var ancho:Number = pixSize.width;
// 	var alto:Number = pixSize.height;
// 
// 	switch (tipo) {
// 		case "clientes": {
// 			r.height = 30;
// 			this.iface.dibujaTextoPic(r, aDatos["c.nombre"], "titulo", pic, pic.AlignCenter);
// 
// 			var telefono1:String = aDatos["c.telefono1"];
// 			var telefono2:String = aDatos["c.telefono2"];
// 			var email:String = aDatos["c.email"];
// 			var tel:String = "";
// 			if (telefono1 && telefono1 != "") {
// 				tel = util.translate("scripts", "Tel. %1").arg(telefono1);
// 			}
// 			if (telefono2 && telefono2 != "") {
// 				tel += tel == "" ? "" : " - ";
// 				tel += telefono2;
// 			}
// 			r.x = 30; r.y = 30; r.height = 20;
// 			this.iface.dibujaTextoPic(r, tel, "normal", pic, pic.AlignLeft);
// 
// 			if (email && email != "") {
// 				email = util.translate("scripts", "e-Mail %1").arg(email);
// 			}
// 			r.y = 50; r.height = 20;
// 			this.iface.dibujaTextoPic(r, email, "normal", pic, pic.AlignLeft);
// 			break;
// 		}
// 		case "agentes": {
// 			r.height = 30;
// 			this.iface.dibujaTextoPic(r, aDatos["a.nombreap"], "titulo", pic, pic.AlignCenter);
// 			
// 			var telefono1:String = aDatos["a.telefono"];
// 			var email:String = aDatos["a.email"];
// 			var tel:String = "";
// 			if (telefono1 && telefono1 != "") {
// 				tel = util.translate("scripts", "Tel. %1").arg(telefono1);
// 			}
// 			r.y = 50; r.x = 30; r.height = 20;
// 			this.iface.dibujaTextoPic(r, tel, "normal", pic, pic.AlignLeft);
// 			
// 			if (email && email != "") {
// 				email = util.translate("scripts", "e-Mail %1").arg(email);
// 			}
// 			r.y = 70; r.height = 20;
// 			this.iface.dibujaTextoPic(r, email, "normal", pic, pic.AlignLeft);
// 			
// 			r.y = 90; r.height = 20;
// 			var porComision:String = util.translate("scripts", "Comisión: %1").arg(util.roundFieldValue(aDatos["a.porcomision"], "agentes", "porcomision") + "%");
// 			this.iface.dibujaTextoPic(r, porComision, "normal", pic, pic.AlignLeft);
// 			break;
// 		}
// 		case "facturascli": {
// 			var texto:String = aDatos["f.codigo"];
// 			r.height = 20;
// 			this.iface.dibujaTextoPic(r, texto, "normal", pic, pic.AlignLeft);
// 			
// 			texto = util.dateAMDtoDMA(aDatos["f.fecha"]);
// 			this.iface.dibujaTextoPic(r, texto, "normal", pic, pic.AlignRight);
// 			
// 			r.y = 20; r.height = 30;
// 			texto = util.roundFieldValue(aDatos["f.total"], "facturascli", "total");
// 			this.iface.dibujaTextoPic(r, texto, "titulo", pic, pic.AlignCenter);
// 			
// 			r.y = 50; r.height = 30;
// 			texto = aDatos["f.editable"] ? util.translate("scripts", "Pendiente") : util.translate("scripts", "Pagada")
// 			this.iface.dibujaTextoPic(r, texto, "titulo", pic, pic.AlignCenter);
// 			break;
// 		}
// 		case "albaranescli": {
// 			var texto:String = aDatos["a.codigo"];
// 			r.height = 20;
// 			this.iface.dibujaTextoPic(r, texto, "normal", pic, pic.AlignLeft);
// 			
// 			texto = util.dateAMDtoDMA(aDatos["a.fecha"]);
// 			this.iface.dibujaTextoPic(r, texto, "normal", pic, pic.AlignRight);
// 			
// 			r.y = 20; r.height = 30;
// 			texto = util.roundFieldValue(aDatos["a.total"], "albaranescli", "total");
// 			this.iface.dibujaTextoPic(r, texto, "titulo", pic, pic.AlignCenter);
// 			
// 			r.y = 50; r.height = 30;
// 			texto = aDatos["a.ptefactura"] ? util.translate("scripts", "Pte. Factura") : util.translate("scripts", "Facturado")
// 			this.iface.dibujaTextoPic(r, texto, "titulo", pic, pic.AlignCenter);
// 			break;
// 		}
// 		case "pedidoscli": {
// 			var texto:String = aDatos["p.codigo"];
// 			r.height = 20;
// 			this.iface.dibujaTextoPic(r, texto, "normal", pic, pic.AlignLeft);
// 			
// 			texto = util.dateAMDtoDMA(aDatos["p.fecha"]);
// 			this.iface.dibujaTextoPic(r, texto, "normal", pic, pic.AlignRight);
// 			
// 			r.y = 20; r.height = 30;
// 			texto = util.roundFieldValue(aDatos["p.total"], "pedidoscli", "total");
// 			this.iface.dibujaTextoPic(r, texto, "titulo", pic, pic.AlignCenter);
// 			
// 			r.y = 50; r.height = 30;
// 			switch (aDatos["f.servido"]) {
// 				case "Sí": { texto = util.translate("scripts", "Servido"); break; }
// 				case "No": { texto = util.translate("scripts", "Por Servir"); break; }
// 				case "Parcial": { texto = util.translate("scripts", "Parcialmente servido"); break; }
// 				default: { texto = "";}
// 			}
// 			this.iface.dibujaTextoPic(r, texto, "titulo", pic, pic.AlignCenter);
// 			break;
// 		}
// 		case "presupuestoscli": {
// 			this.iface.dibujaPicture(pic, tipo, aDatos);
// 			break;
// 		}
// 		default: {
// 			var texto:String = util.translate("scripts", "Formato no definido para %1").arg(tipo);
// 			this.iface.dibujaTextoPic(r, texto, "normal", pic, pic.AlignCenter);
// 		}
// 	}
// 	
// 	
// debug(this.iface.xmlElemento_.toString(4));
// 	return true;
// }

function oficial_damePicElementoDefecto(tipo:String):FLDomDocument
{
	var util:FLUtil = new FLUtil;
	var pixSize = this.child("lblElemento").size;
	var r:Rect = new Rect(0, 0, pixSize.width, pixSize.height);
	var ancho:Number = pixSize.width;
	var alto:Number = pixSize.height;
	
	var contenido:String = "";
	switch (tipo) {
		case "presupuestoscli": {
			contenido = "<Picture>" + "\n\t";
			contenido += "<Text x='0' y='0' width='100%' height='20%' style='normal' halignment='AlignLeft'>presupuestoscli.codigo</Text>" + "\n\t";
			contenido += "<Text x='0' y='0' width='100%' height='20%' style='normal' halignment='AlignRight'>presupuestoscli.fecha</Text>" + "\n\t";
			contenido += "<Text x='0' y='20%' width='100%' height='30%' style='titulo' halignment='AlignCenter'>presupuestoscli.total</Text>" + "\n\t";
			contenido += "<Text x='0' y='50%' width='100%' height='30%' style='titulo' halignment='AlignCenter'>aprobado</Text>" + "\n";
			contenido += "</Picture>";
			break;
		}
		case "clientes": {
			contenido = "<Picture>" + "\n\t";
			contenido += "<Text x='0' y='0' width='100%' height='30%' style='titulo' halignment='AlignCenter'>clientes.nombre</Text>" + "\n\t";
			contenido += "<Text x='0' y='30%' width='100%' height='20%' style='normal' halignment='AlignLeft'>clientes.telefono1</Text>" + "\n\t";
			contenido += "<Text x='0' y='50%' width='100%' height='20%' style='normal' halignment='AlignLeft'>clientes.email</Text>" + "\n\t";
			contenido += "</Picture>";
			break;
		}
		default: {
			return false;
		}
		
		
// 		case "agentes": {
// 			r.height = 30;
// 			this.iface.dibujaTextoPic(r, aDatos["a.nombreap"], "titulo", pic, pic.AlignCenter);
// 			
// 			var telefono1:String = aDatos["a.telefono"];
// 			var email:String = aDatos["a.email"];
// 			var tel:String = "";
// 			if (telefono1 && telefono1 != "") {
// 				tel = util.translate("scripts", "Tel. %1").arg(telefono1);
// 			}
// 			r.y = 50; r.x = 30; r.height = 20;
// 			this.iface.dibujaTextoPic(r, tel, "normal", pic, pic.AlignLeft);
// 			
// 			if (email && email != "") {
// 				email = util.translate("scripts", "e-Mail %1").arg(email);
// 			}
// 			r.y = 70; r.height = 20;
// 			this.iface.dibujaTextoPic(r, email, "normal", pic, pic.AlignLeft);
// 			
// 			r.y = 90; r.height = 20;
// 			var porComision:String = util.translate("scripts", "Comisión: %1").arg(util.roundFieldValue(aDatos["a.porcomision"], "agentes", "porcomision") + "%");
// 			this.iface.dibujaTextoPic(r, porComision, "normal", pic, pic.AlignLeft);
// 			break;
// 		}
// 		case "facturascli": {
// 			var texto:String = aDatos["f.codigo"];
// 			r.height = 20;
// 			this.iface.dibujaTextoPic(r, texto, "normal", pic, pic.AlignLeft);
// 			
// 			texto = util.dateAMDtoDMA(aDatos["f.fecha"]);
// 			this.iface.dibujaTextoPic(r, texto, "normal", pic, pic.AlignRight);
// 			
// 			r.y = 20; r.height = 30;
// 			texto = util.roundFieldValue(aDatos["f.total"], "facturascli", "total");
// 			this.iface.dibujaTextoPic(r, texto, "titulo", pic, pic.AlignCenter);
// 			
// 			r.y = 50; r.height = 30;
// 			texto = aDatos["f.editable"] ? util.translate("scripts", "Pendiente") : util.translate("scripts", "Pagada")
// 			this.iface.dibujaTextoPic(r, texto, "titulo", pic, pic.AlignCenter);
// 			break;
// 		}
// 		case "albaranescli": {
// 			var texto:String = aDatos["a.codigo"];
// 			r.height = 20;
// 			this.iface.dibujaTextoPic(r, texto, "normal", pic, pic.AlignLeft);
// 			
// 			texto = util.dateAMDtoDMA(aDatos["a.fecha"]);
// 			this.iface.dibujaTextoPic(r, texto, "normal", pic, pic.AlignRight);
// 			
// 			r.y = 20; r.height = 30;
// 			texto = util.roundFieldValue(aDatos["a.total"], "albaranescli", "total");
// 			this.iface.dibujaTextoPic(r, texto, "titulo", pic, pic.AlignCenter);
// 			
// 			r.y = 50; r.height = 30;
// 			texto = aDatos["a.ptefactura"] ? util.translate("scripts", "Pte. Factura") : util.translate("scripts", "Facturado")
// 			this.iface.dibujaTextoPic(r, texto, "titulo", pic, pic.AlignCenter);
// 			break;
// 		}
// 		case "pedidoscli": {
// 			var texto:String = aDatos["p.codigo"];
// 			r.height = 20;
// 			this.iface.dibujaTextoPic(r, texto, "normal", pic, pic.AlignLeft);
// 			
// 			texto = util.dateAMDtoDMA(aDatos["p.fecha"]);
// 			this.iface.dibujaTextoPic(r, texto, "normal", pic, pic.AlignRight);
// 			
// 			r.y = 20; r.height = 30;
// 			texto = util.roundFieldValue(aDatos["p.total"], "pedidoscli", "total");
// 			this.iface.dibujaTextoPic(r, texto, "titulo", pic, pic.AlignCenter);
// 			
// 			r.y = 50; r.height = 30;
// 			switch (aDatos["f.servido"]) {
// 				case "Sí": { texto = util.translate("scripts", "Servido"); break; }
// 				case "No": { texto = util.translate("scripts", "Por Servir"); break; }
// 				case "Parcial": { texto = util.translate("scripts", "Parcialmente servido"); break; }
// 				default: { texto = "";}
// 			}
// 			this.iface.dibujaTextoPic(r, texto, "titulo", pic, pic.AlignCenter);
// 			break;
// 		}
		
		
		
	}
	if (contenido == "") {
		return false;
	}
	if (!util.sqlUpdate("t1_elementos", "xmlpic", contenido, "elemento = '" + tipo + "'")) {
		return false;
	}
	var xmlDoc:FLDomDocument;
	if (!xmlDoc.setContent(contenido)) {
		return false;
	}
	return xmlDoc;
}

function oficial_damePicRelacionDefecto(iRel:Number):FLDomDocument
{
	var util:FLUtil = new FLUtil;
	var contenido:String = "";
	var aElemento:Array = this.iface.aHistorialElementos_[this.iface.iElementoHistorial_];
	var tipo:String = aElemento["tipo"];
	var nombreRel:String = this.iface.aRelaciones_[iRel]["nombre"];
	switch (tipo) {
		case "clientes": {
			switch (nombreRel) {
				case "facturascli": {
					contenido = "<Picture>" + "\n\t";
					contenido += "<Text x='0' y='0' width='100%' height='50%' style='normal' halignment='AlignLeft'>numFacturas</Text>" + "\n\t";
					contenido += "<Text x='0' y='50%' width='100%' height='50%' style='normal' halignment='AlignRight'>total</Text>" + "\n\t";
					contenido += "</Picture>";
					break;
				}
				default: {
					return false;
				}
			}
			break;
		}
		default: {
			return false;
		}
	}
	if (contenido == "") {
		return false;
	}
	if (!util.sqlUpdate("t1_relacioneselemento", "xmlpic", contenido, "idrelacionelemento = " + this.iface.aRelaciones_[iRel]["id"])) {
		return false;
	}
	var xmlDoc:FLDomDocument;
	if (!xmlDoc.setContent(contenido)) {
		return false;
	}
	return xmlDoc;
}

function oficial_dibujaPicture(pic:Picture, xmlPic:FLDomDocument, pixSize:Size, aDatos:Array):Boolean
{
	
// debug(xmlPic.toString(4));
// 	var pixSize = this.child("lblElemento").size;
debug("Dibujando en " + pixSize.width + " x " + pixSize.height);

	var r:Rect = new Rect(0, 0, pixSize.width, pixSize.height);
	var fAncho:Number = pixSize.width / 100;
	var fAlto:Number = pixSize.height / 100;
			
	var nodoPic:FLDomNode = xmlPic.firstChild();
	var nodos:FLDomNodeList = nodoPic.childNodes();
	if (!nodos) {
		return false;
	}

	var canNodos:Number = nodos.length();
	var eNodo:FLDomElement;
	var sX:String, sY:String, sAlto:String, sAncho:String;
	var x:Number, y:Number, alto:Number, ancho:Number;
	var r:Rect, align:Number, texto:String, estilo:String, campo:String;
	for (var i:Number = 0; i < canNodos; i++) {
		eNodo = nodos.item(i).toElement();
		switch (eNodo.nodeName()) {
			case "Text": {
				campo = eNodo.firstChild().nodeValue();
// 				texto = this.iface.aDatosElemento_[campo];
				texto = aDatos[campo];
debug(campo + " = " + texto);
				estilo = eNodo.attribute("style");
				sX = eNodo.attribute("x");
				x = sX.toString().endsWith("%") ? parseInt(parseInt(sX.left(sX.length - 1)) * fAncho) : parseInt(sX);
				sY = eNodo.attribute("y");
				y = sY.toString().endsWith("%") ? parseInt(parseInt(sY.left(sY.length - 1)) * fAlto) : parseInt(sY);
				sAncho = eNodo.attribute("width");
				ancho = sAncho.toString().endsWith("%") ? parseInt(parseInt(sAncho.left(sAncho.length - 1)) * fAncho) : parseInt(sAncho);
				sAlto = eNodo.attribute("height");
				alto = sAlto.toString().endsWith("%") ? parseInt(parseInt(sAlto.left(sAlto.length - 1)) * fAlto) : parseInt(sAlto);
debug("S " + sX + ", " + sY + ", " + sAncho + ", " + sAlto);
debug("V " + x + ", " + y + ", " + ancho + ", " + alto);
				r = new Rect(x, y, ancho, alto);
				align = 0;
				switch (eNodo.attribute("halignment")) {
					case "AlignLeft": {
						align = pic.AlignLeft;
						break;
					}
					case "AlignRight": {
						align = pic.AlignRight;
						break;
					}
					case "AlignCenter":
					case "AlignHCenter":{
						align = pic.AlignHCenter;
						break;
					}
					default: {
						if (isNaN(texto)) {
							align = pic.AlignLeft;
						} else {
							align = pic.AlignRight;
						}
						break;
					}
				}
				switch (eNodo.attribute("valignment")) {
					case "AlignTop": {
						align = align | pic.AlignLeft;
						break;
					}
					case "AlignBottom": {
						align = align | pic.AlignBottom;
						break;
					}
					case "AlignCenter":
					case "AlignVCenter":
					default: {
						align = align | pic.AlignVCenter;
					}
				}
				switch (estilo) {
					case "titulo": {
						var clr = new Color(0, 0, 255);
						var fnt = this.iface.dameFuente("verdana", 18);
						pic.setPen(clr, 1);
						pic.setFont(fnt);
						break;
					}
					case "normal": {
						var clr = new Color(0, 50, 0);
						var fnt = this.iface.dameFuente("verdana", 10);
						pic.setPen(clr, 1);
						pic.setFont(fnt);
						break;
					}
				}
				pic.drawText(r, align, texto, -1);
				break;
			}
		}
	}
	debug("Grabando");
	pic.save("/home/arodriguez/prueba.svg", "svg");
	return true;
}

function oficial_dibujaTextoPic(r:Rect, texto:String, estilo:String, pic:Picture, alineacion:Number):Boolean
{
debug(r.x + ", " + r.y + ", " + r.width + ", " + r.height);
	var pixSize = this.child("lblElemento").size;
	switch (estilo) {
		case "titulo": {
			var clr = new Color(0, 0, 255);
			var fnt = this.iface.dameFuente("verdana", 18);
			pic.setPen(clr, 1);
			pic.setFont(fnt);
			break;
		}
		case "normal": {
			var clr = new Color(0, 50, 0);
			var fnt = this.iface.dameFuente("verdana", 10);
			pic.setPen(clr, 1);
			pic.setFont(fnt);
			break;
		}
	}
	pic.drawText(r, alineacion, texto, -1);
	return true;
}


function oficial_dameColor(color:String):Color
{
	var rgb:Array = new Array;
	if (!color || color == "") {
		rgb = [220, 220, 220];
	} else {
		rgb = color.split(",");
	}

	if (!rgb || rgb.length != 3) {
		debug("Error al obtener color " + color);
		rgb = [220, 220, 220];
	}

	var clr = new Color(); 
	clr.setRgb(rgb[0],rgb[1],rgb[2]);

	return clr;
}

function oficial_dameFuente(family:String, size:Number):Font
{
	var clf = new Font(); 
	if (!family || family == "") {
		family = "Arial";
	}
	if (!size || size == "") {
		size = 10;
	}
  
	clf.pointSize = size;
	clf.family = family;

	return clf;
}



// function oficial_cargaXMLElemento(tipo:String, clave:String):Boolean
// {
// 	var util:FLUtil = new FLUtil;
// 
// 	var aDatos:Array = this.iface.cargaDatosElemento(tipo, clave);
// 	if (!aDatos) {
// 		return false;
// 	}
// 
// 	if (!this.iface.cargaSvgElemento(tipo, aDatos)) {
// 		return false;
// 	}
// 
// 	return true;
// }

function oficial_cargaSvgElemento(tipo:String, aDatos:Array):Boolean
{
	var util:FLUtil = new FLUtil;
	var pixSize = this.child("lblElemento").size;
	
	if (this.iface.picElemento_) {
		this.iface.picElemento_.end();
		delete this.iface.picElemento_;
	}
	delete this.iface.xmlElemento_;
	this.iface.xmlElemento_ = new FLDomDocument;
	this.iface.xmlElemento_.setContent("<svg width='100%' height='100%' ><image width='20' x='20' xlink:href='/home/arodriguez/imagenes/map_usa.jpeg' y='20' height='20' /></svg>");
	var eSvg:FLDomElement = this.iface.xmlElemento_.firstChild().toElement();
	var eG:FLDomElement = this.iface.xmlElemento_.createElement("g");
	eSvg.appendChild(eG);

	switch (tipo) {
		case "clientes": {
			this.iface.dibujaTextoSvg(pixSize.width / 2, 30, aDatos["c.nombre"], "titulo");
			var telefono1:String = aDatos["c.telefono1"];
			var telefono2:String = aDatos["c.telefono2"];
			var email:String = aDatos["c.email"];
			var tel:String = "";
			if (telefono1 && telefono1 != "") {
				tel = util.translate("scripts", "Tel. %1").arg(telefono1);
			}
			if (telefono2 && telefono2 != "") {
				tel += tel == "" ? "" : " - ";
				tel += telefono2;
			}
			if (email && email != "") {
				tel += tel == "" ? "" : " - ";
				tel += util.translate("scripts", "e-Mail %1").arg(email);
			}
			this.iface.dibujaTextoSvg(30, 50, tel, "normal");
			break;
		}
		case "agentes": {
			this.iface.dibujaTextoSvg(pixSize.width / 2, 30, aDatos["a.nombreap"], "titulo");
			var telefono1:String = aDatos["a.telefono"];
			var email:String = aDatos["a.email"];
			var tel:String = "";
			if (telefono1 && telefono1 != "") {
				tel = util.translate("scripts", "Tel. %1").arg(telefono1);
			}
			if (email && email != "") {
				tel += tel == "" ? "" : " - ";
				tel += util.translate("scripts", "e-Mail %1").arg(email);
			}
			this.iface.dibujaTextoSvg(30, 50, tel, "normal");
			var porComision:String = util.translate("scripts", "Comisión: %1").arg(util.roundFieldValue(aDatos["a.porcomision"], "agentes", "porcomision") + "%");
			this.iface.dibujaTextoSvg(30, 70, porComision, "normal");
			break;
		}
	}
debug(this.iface.xmlElemento_.toString(4));
	return true;
}

function oficial_dibujaTextoSvg(x:Number, y:Number, texto:String, idEstilo:String):Boolean
{
	var eG:FLDomElement = this.iface.xmlElemento_.firstChild().namedItem("g").toElement();
	var estilo:String;
	var eText:FLDomElement = this.iface.xmlElemento_.createElement("text");
	eG.appendChild(eText);
	eText.setAttribute("id", "TextElement");
	eText.setAttribute("x", x);
	eText.setAttribute("y", y);
	switch (idEstilo) {
		case "titulo": {
			estilo = "font-family:Verdana;font-size:24;stroke:red";
			eText.setAttribute("text-anchor", "middle");
			break;
		}
		case "normal": {
			estilo = "font-family:Verdana;font-size:10";
			break;
		}
		default: {
			estilo = "font-family:Verdana;font-size:10";
		}
	}
	eText.setAttribute("style", estilo);
	var pixSize = this.child("lblElemento").size;
//eText.setAttribute("textLength", pixSize.width);
//eText.setAttribute("lengthAdjust", "spacingAndGlyphs");
	var tTexto:FLDomNode = this.iface.xmlElemento_.createTextNode(texto);
	eText.appendChild(tTexto);
/*
<g transform="translate(100,100)">
<text id="TextElement" x="0" y="0" style="font-family:Verdana;font-size:24"> It's SVG!
<animateMotion path="M 0 0 L 100 100" dur="5s" fill="freeze"/>
</text>
</g>
*/

	return true;
}

function oficial_cargaValorCamposTabla(tabla:String, clave:String):Boolean
{
	var util:FLUtil = new FLUtil;
	var aCampos:Array = util.nombreCampos(tabla);
	var numCampos:Number = aCampos.shift();
	var sCampos:String = aCampos.join(",");
	var cursor:FLSqlCursor = new FLSqlCursor(tabla);
	var campoPK:String = cursor.primaryKey();
	var tipoPK:Number = cursor.fieldType(campoPK);
	var where:String;
	switch (tipoPK) {
		case this.iface.ftSTRING_:
		case this.iface.ftDATE_: {
			where = campoPK + " = '" + clave + "'";
			break;
		}
		default: {
			where = campoPK + " = " + clave;
		}
	}
	cursor.select(where);
	if (!cursor.first()) {
		return false;
	}
	
	var valor:String, campo:String;
	var aDatos:Array = [];
	for (var i:Number = 0; i < numCampos; i++) {
		campo = aCampos[i];
		valor = cursor.valueBuffer(campo);
// debug("Campo " + campo + " = " + valor + " tipo " + cursor.fieldType(campo));
		switch (cursor.fieldType(campo)) {
			case this.iface.ftSTRING_: {
				break;
			}
			case this.iface.ftUINT_: {
				break;
			}
			case this.iface.ftDOUBLE_: {
				if (isNaN(valor)) {
					valor = 0;
				}
				valor = util.roundFieldValue(valor, tabla, campo);
				break;
			}
			case this.iface.ftDATE_: {
				if (valor) {
					valor = util.dateAMDtoDMA(valor);
				}
				break;
			}
			case this.iface.ftSERIAL_: {
				break;
			}
			case this.iface.ftUNLOCK_: {
				break;
			}
		}
		if (!this.iface.cargaCampoArrayDE(tabla + "." + campo, valor)) {
			return false;
		}
	}
	return aDatos;
}

/** \D Incluye un nuevo campo y su valor en los array de datos del elemento actual
\end */
function oficial_cargaCampoArrayDE(campo:String, valor):Boolean
{
	this.iface.aDatosElemento_[campo] = valor;
	this.iface.aIndiceDE_[this.iface.aIndiceDE_.length] = campo;
	return true;
}

function oficial_cargaDatosElemento(tipo:String, clave:String):Boolean
{
	var util:FLUtil = new FLUtil;
	var aDatos:Array = false;
	
	if (this.iface.aDatosElemento_) {
		delete this.iface.aDatosElemento_;
		delete this.iface.aIndiceDE_;
	}
	this.iface.aDatosElemento_ = [];
	this.iface.aIndiceDE_ = [];

	switch (tipo) {
		case "clientes": {
			if (!this.iface.cargaValorCamposTabla(tipo, clave)) {
				return false;
			}
// 			aDatos = flcolatoe1.iface.pub_ejecutarQry("clientes c LEFT OUTER JOIN dirclientes dc ON (c.codcliente = dc.codcliente AND dc.domfacturacion = true) LEFT OUTER JOIN paises p ON dc.codpais = p.codpais", "c.nombre,c.codcliente,c.cifnif,c.email,c.contacto,c.telefono1,c.telefono2,dc.direccion,dc.ciudad,dc.codpostal,dc.provincia,p.nombre", "c.codcliente = '" + clave + "'", "clientes,dirclientes,paises");
			break;
		}
		case "agentes": {
			if (!this.iface.cargaValorCamposTabla(tipo, clave)) {
				return false;
			}
			break;
		}
		case "presupuestoscli": {
			if (!this.iface.cargaValorCamposTabla(tipo, clave)) {
				return false;
			}
			var aprobado:String = this.iface.aDatosElemento_["presupuestoscli.editable"] ? util.translate("scripts", "Por aprobar") : util.translate("scripts", "Aprobado");
			if (!this.iface.cargaCampoArrayDE("aprobado", aprobado)) {
				return false;
			}
			break;
		}
		case "pedidoscli": {
			if (!this.iface.cargaValorCamposTabla(tipo, clave)) {
				return false;
			}
			break;
		}
		case "albaranescli": {
			if (!this.iface.cargaValorCamposTabla(tipo, clave)) {
				return false;
			}
			break;
		}
		case "facturascli": {
			if (!this.iface.cargaValorCamposTabla(tipo, clave)) {
				return false;
			}
			break;
		}
		case "reciboscli": {
			if (!this.iface.cargaValorCamposTabla(tipo, clave)) {
				return false;
			}
			break;
		}
		default: {
			if (!this.iface.cargaValorCamposTabla(tipo, clave)) {
				return false;
			}
		}
	}
	return true;
}

function oficial_mostrarElementosRel(tipo:String, clave:String, relacion:String):Boolean
{
	var util:FLUtil = new FLUtil;
	
	this.iface.tblElementosRel_.setNumRows(0);
	var qryRel:FLSqlQuery;
	switch (tipo) {
		case "clientes": {
			switch (relacion) {
				case "facturascli": {
					qryRel.setTablesList("facturascli");
					qryRel.setSelect("idfactura, codigo, fecha, total, editable");
					qryRel.setFrom("facturascli");
					qryRel.setWhere("codcliente = '" + clave + "'");
					qryRel.setForwardOnly(true);
					if (!qryRel.exec()) {
						return false;
					}
					var iFila:Number = 0;
					while (qryRel.next()) {
						this.iface.tblElementosRel_.insertRows(iFila);
						this.iface.tblElementosRel_.setRowHeight(iFila, 32);
						this.iface.tblElementosRel_.setText(iFila, this.iface.CER_TIPO, "facturascli");
						this.iface.tblElementosRel_.setText(iFila, this.iface.CER_CLAVE, qryRel.value("idfactura"));
						this.iface.tblElementosRel_.setText(iFila, this.iface.CER_DES, util.translate("scripts", "%1 - %2 - %3").arg(qryRel.value("codigo")).arg(util.dateAMDtoDMA(qryRel.value("fecha"))).arg(qryRel.value("total")))
						this.iface.dibujarIconoTabla(this.iface.tblElementosRel_, iFila, this.iface.CER_ICONO, "facturascli");
						iFila++;
					}
					break;
				}
				case "albaranescli": {
					qryRel.setTablesList("albaranescli");
					qryRel.setSelect("idalbaran, codigo, fecha, total, ptefactura");
					qryRel.setFrom("albaranescli");
					qryRel.setWhere("codcliente = '" + clave + "'");
					qryRel.setForwardOnly(true);
					if (!qryRel.exec()) {
						return false;
					}
					var iFila:Number = 0;
					while (qryRel.next()) {
						this.iface.tblElementosRel_.insertRows(iFila);
						this.iface.tblElementosRel_.setRowHeight(iFila, 32);
						this.iface.tblElementosRel_.setText(iFila, this.iface.CER_TIPO, "albaranescli");
						this.iface.tblElementosRel_.setText(iFila, this.iface.CER_CLAVE, qryRel.value("idalbaran"));
						this.iface.tblElementosRel_.setText(iFila, this.iface.CER_DES, util.translate("scripts", "%1 - %2 - %3").arg(qryRel.value("codigo")).arg(util.dateAMDtoDMA(qryRel.value("fecha"))).arg(qryRel.value("total")))
						this.iface.dibujarIconoTabla(this.iface.tblElementosRel_, iFila, this.iface.CER_ICONO, "albaranescli");
						iFila++;
					}
					break;
				}
				case "pedidoscli": {
					qryRel.setTablesList("pedidoscli");
					qryRel.setSelect("idpedido, codigo, fecha, total, editable");
					qryRel.setFrom("pedidoscli");
					qryRel.setWhere("codcliente = '" + clave + "'");
					qryRel.setForwardOnly(true);
					if (!qryRel.exec()) {
						return false;
					}
					var iFila:Number = 0;
					while (qryRel.next()) {
						this.iface.tblElementosRel_.insertRows(iFila);
						this.iface.tblElementosRel_.setRowHeight(iFila, 32);
						this.iface.tblElementosRel_.setText(iFila, this.iface.CER_TIPO, "pedidoscli");
						this.iface.tblElementosRel_.setText(iFila, this.iface.CER_CLAVE, qryRel.value("idpedido"));
						this.iface.tblElementosRel_.setText(iFila, this.iface.CER_DES, util.translate("scripts", "%1 - %2 - %3").arg(qryRel.value("codigo")).arg(util.dateAMDtoDMA(qryRel.value("fecha"))).arg(qryRel.value("total")))
						this.iface.dibujarIconoTabla(this.iface.tblElementosRel_, iFila, this.iface.CER_ICONO, "pedidoscli");
						iFila++;
					}
					break;
				}
				case "presupuestoscli": {
					qryRel.setTablesList("presupuestoscli");
					qryRel.setSelect("idpresupuesto, codigo, fecha, total, editable");
					qryRel.setFrom("presupuestoscli");
					qryRel.setWhere("codcliente = '" + clave + "'");
					qryRel.setForwardOnly(true);
					if (!qryRel.exec()) {
						return false;
					}
					var iFila:Number = 0;
					while (qryRel.next()) {
						this.iface.tblElementosRel_.insertRows(iFila);
						this.iface.tblElementosRel_.setRowHeight(iFila, 32);
						this.iface.tblElementosRel_.setText(iFila, this.iface.CER_TIPO, "presupuestoscli");
						this.iface.tblElementosRel_.setText(iFila, this.iface.CER_CLAVE, qryRel.value("idpresupuesto"));
						this.iface.tblElementosRel_.setText(iFila, this.iface.CER_DES, util.translate("scripts", "%1 - %2 - %3").arg(qryRel.value("codigo")).arg(util.dateAMDtoDMA(qryRel.value("fecha"))).arg(qryRel.value("total")))
						this.iface.dibujarIconoTabla(this.iface.tblElementosRel_, iFila, this.iface.CER_ICONO, "presupuestoscli");
						iFila++;
					}
					break;
				}
			}
			break;
		}
		case "facturascli": {
			switch (relacion) {
				case "reciboscli": {
					qryRel.setTablesList("reciboscli");
					qryRel.setSelect("idrecibo, codigo, fecha, importe, estado");
					qryRel.setFrom("reciboscli");
					qryRel.setWhere("idfactura = " + clave);
					qryRel.setForwardOnly(true);
					if (!qryRel.exec()) {
						return false;
					}
					var iFila:Number = 0;
					while (qryRel.next()) {
						this.iface.tblElementosRel_.insertRows(iFila);
						this.iface.tblElementosRel_.setRowHeight(iFila, 32);
						this.iface.tblElementosRel_.setText(iFila, this.iface.CER_TIPO, "reciboscli");
						this.iface.tblElementosRel_.setText(iFila, this.iface.CER_CLAVE, qryRel.value("idrecibo"));
						this.iface.tblElementosRel_.setText(iFila, this.iface.CER_DES, util.translate("scripts", "%1 - %2 - %3").arg(qryRel.value("codigo")).arg(util.dateAMDtoDMA(qryRel.value("fecha"))).arg(qryRel.value("importe")))
						iFila++;
					}
					break;
				}
			}
			break;
		}
		case "agentes": {
			switch (relacion) {
				case "clientes": {
					qryRel.setTablesList("clientes");
					qryRel.setSelect("codcliente, nombre");
					qryRel.setFrom("clientes");
					qryRel.setWhere("codagente = '" + clave + "'");
					qryRel.setForwardOnly(true);
					if (!qryRel.exec()) {
						return false;
					}
					var iFila:Number = 0;
					while (qryRel.next()) {
						this.iface.tblElementosRel_.insertRows(iFila);
						this.iface.tblElementosRel_.setRowHeight(iFila, 32);
						this.iface.tblElementosRel_.setText(iFila, this.iface.CER_TIPO, "clientes");
						this.iface.tblElementosRel_.setText(iFila, this.iface.CER_CLAVE, qryRel.value("codcliente"));
						this.iface.tblElementosRel_.setText(iFila, this.iface.CER_DES, util.translate("scripts", "%1 - %2").arg(qryRel.value("codcliente")).arg(qryRel.value("nombre")));
						this.iface.dibujarIconoTabla(this.iface.tblElementosRel_, iFila, this.iface.CER_ICONO, "clientes");
						iFila++;
					}
					break;
				}
			}
			break;
		}
	}
	return true;
}

function oficial_refrescarRelacion(nombre:String)
{
//	this.child("fdbBuscar").setValue("Refrescar!");
	var fila:Number = this.iface.dameIndiceRelacion(nombre);
	if (fila < 0) {
		return false;
	}
	var aElemento:Array = this.iface.aHistorialElementos_[this.iface.iElementoHistorial_];
	
	var aDatosRel:Array = this.iface.dameDatosRelacion(aElemento["tipo"], aElemento["clave"], nombre);
	if (!aDatosRel) {
		return false;
	}
	this.iface.tblRelaciones_.setText(fila, this.iface.CR_DESC, aDatosRel["des"]);
	this.iface.tblRelaciones_.setText(fila, this.iface.CR_CLAVEREL, aDatosRel["claverel"]);
		
// 	this.iface.tblRelaciones_.setText(fila, this.iface.CR_DESC, this.iface.dameDatosRelacion(aElemento["tipo"], aElemento["clave"], nombre));
	this.child("tblRelaciones").selectRow(fila);
	this.iface.tblRelaciones_clicked(fila, 0);
}

function oficial_dameIndiceRelacion(nombre:String):Number
{
	if (!this.iface.aRelaciones_) {
		return -1;
	}
	for (var i:Number = 0; i < this.iface.aRelaciones_.length; i++) {
		if (this.iface.aRelaciones_[i]["nombre"] == nombre) {
			return i;
		}
	}
	return -1;
}

function oficial_generarFacturaCli(tipo:String, clave:String):Boolean
{
	var acciones:Array = [];
	acciones[0] = flcolaproc.iface.pub_arrayAccion("facturascli", "ponCliente");
	acciones[0]["codcliente"] = clave;
	acciones[1] = flcolaproc.iface.pub_arrayAccion("facturascli", "sal");
	acciones[2] = flcolaproc.iface.pub_arrayAccion("facturascli", "llamaFuncion");
	acciones[2]["funcion"] = "formt1_principal.iface.refrescarRelacion(\"facturascli\");";

	flcolaproc.iface.pub_setAccionesAuto(acciones);

	delete this.iface.curObjeto_;
	this.iface.curObjeto_ = new FLSqlCursor("facturascli");
	this.iface.curObjeto_.insertRecord();
	return true;
}

function oficial_generarAlbaranCli(tipo:String, clave:String):Boolean
{
	var acciones:Array = [];
	acciones[0] = flcolaproc.iface.pub_arrayAccion("albaranescli", "ponCliente");
	acciones[0]["codcliente"] = clave;
	acciones[1] = flcolaproc.iface.pub_arrayAccion("albaranescli", "sal");
	acciones[2] = flcolaproc.iface.pub_arrayAccion("albaranescli", "llamaFuncion");
	acciones[2]["funcion"] = "formt1_principal.iface.refrescarRelacion(\"albaranescli\");";

	flcolaproc.iface.pub_setAccionesAuto(acciones);

	delete this.iface.curObjeto_;
	this.iface.curObjeto_ = new FLSqlCursor("albaranescli");
	this.iface.curObjeto_.insertRecord();
	return true;
}

function oficial_generarPedidoCli(tipo:String, clave:String):Boolean
{
	var acciones:Array = [];
	acciones[0] = flcolaproc.iface.pub_arrayAccion("pedidoscli", "ponCliente");
	acciones[0]["codcliente"] = clave;
	acciones[1] = flcolaproc.iface.pub_arrayAccion("pedidoscli", "sal");
	acciones[2] = flcolaproc.iface.pub_arrayAccion("pedidoscli", "llamaFuncion");
	acciones[2]["funcion"] = "formt1_principal.iface.refrescarRelacion(\"pedidoscli\");";

	flcolaproc.iface.pub_setAccionesAuto(acciones);

	delete this.iface.curObjeto_;
	this.iface.curObjeto_ = new FLSqlCursor("pedidoscli");
	this.iface.curObjeto_.insertRecord();
	return true;
}

function oficial_generarPresupuestoCli(tipo:String, clave:String):Boolean
{
	var acciones:Array = [];
	acciones[0] = flcolaproc.iface.pub_arrayAccion("presupuestoscli", "ponCliente");
	acciones[0]["codcliente"] = clave;
	acciones[1] = flcolaproc.iface.pub_arrayAccion("presupuestoscli", "sal");
	acciones[2] = flcolaproc.iface.pub_arrayAccion("presupuestoscli", "llamaFuncion");
	acciones[2]["funcion"] = "formt1_principal.iface.refrescarRelacion(\"presupuestoscli\");";

	flcolaproc.iface.pub_setAccionesAuto(acciones);

	delete this.iface.curObjeto_;
	this.iface.curObjeto_ = new FLSqlCursor("presupuestoscli");
	this.iface.curObjeto_.insertRecord();
	return true;
}

function oficial_ponElementoActual(tipo:String, clave:String):Boolean
{
	var aElemento:Array = [];
	aElemento["tipo"] = tipo;
	aElemento["clave"] = clave;

	this.iface.iElementoHistorial_++;
	if (this.iface.aHistorialElementos_.length > this.iface.iElementoHistorial_) {
		var dif:Number = this.iface.aHistorialElementos_.length - this.iface.iElementoHistorial_;
		this.iface.aHistorialElementos_.splice(this.iface.iElementoHistorial_, dif);
	}
debug("this.iface.iElementoHistorial_ " + this.iface.iElementoHistorial_);
	this.iface.aHistorialElementos_[this.iface.iElementoHistorial_] = aElemento;
	if (!this.iface.actualizaDatosForm()) {
		return false;
	}
	return true;
}

function oficial_tbnElementoPrevio_clicked()
{
	if (this.iface.iElementoHistorial_ > 0) {
		this.iface.iElementoHistorial_--;
	}
	if (!this.iface.actualizaDatosForm()) {
		return false;
	}
}

function oficial_tbnElementoSiguiente_clicked()
{
	if ((this.iface.iElementoHistorial_ + 1) < this.iface.aHistorialElementos_.length) {
		this.iface.iElementoHistorial_++;
	}
	if (!this.iface.actualizaDatosForm()) {
		return false;
	}
}

function oficial_actualizaDatosForm():Boolean
{
	this.child("tbwElementos").showPage("elemento");
	if (!this.iface.muestraElementoActual()) {
		return false;
	}
	if (!this.iface.cargaAcciones()) {
		return false;
	}
	if (!this.iface.muestraAcciones()) {
		return false;
	}
	if (!this.iface.cargaRelaciones()) {
		return false;
	}
	if (!this.iface.muestraRelaciones()) {
		return false;
	}
	if (!this.iface.mostrarElementosRel("ninguno")) {
		return false;
	}
	return true;
}

function oficial_muestraElementoActual():Boolean
{
	var util:FLUtil = new FLUtil;
	var aElemento:Array = this.iface.aHistorialElementos_[this.iface.iElementoHistorial_];
	this.iface.muestraElemento(aElemento.tipo, aElemento.clave);
return true;
	var icono:String = util.sqlSelect("t1_elementos", "icono", "elemento = '" + aElemento.tipo + "'");
	if (icono) {
		var pic = new Picture;
		var pixNew = new Pixmap;
		var clr = new Color;
		clr.setRgb(255,255,255);
		
		var pixIcono = sys.toPixmap(icono);
		var pixSize = pixIcono.size;
		pixNew.resize(pixSize);
		pixNew.fill(clr);
		
		
		pic.begin();
		pic.drawPixmap(0, 0, pixNew);
		pic.drawPixmap(0, 0, pixIcono);
		pixNew = pic.playOnPixmap(pixNew);
		pic.end();
		this.child("lblElemento").pixmap = pixNew;
// 		this.child("lblElemento").text = aElemento["clave"];
	} else {
		this.child("lblElemento").text = aElemento["clave"];
	}
	return true;
}

function oficial_cargaAcciones():Boolean
{
	var aElemento:Array = this.iface.aHistorialElementos_[this.iface.iElementoHistorial_];
	
	var qryAcciones:FLSqlQuery = new FLSqlQuery;
	qryAcciones.setTablesList("t1_accioneselemento");
	qryAcciones.setSelect("accion, funcion, icono, tecla");
	qryAcciones.setFrom("t1_accioneselemento");
	qryAcciones.setWhere("elemento = '" + aElemento["tipo"] + "'");
	qryAcciones.setForwardOnly(true);
	if (!qryAcciones.exec()) {
		return false;
	}
	var iAccion:Number = 0;
	this.iface.eliminarAccels();
	delete this.iface.aAcciones_;
	this.iface.aAcciones_ = new Array(qryAcciones.size());
	var tecla:String;
	while (qryAcciones.next()) {
		tecla = qryAcciones.value("tecla");
		this.iface.aAcciones_[iAccion] = [];
		this.iface.aAcciones_[iAccion]["nombre"] = qryAcciones.value("accion");
		this.iface.aAcciones_[iAccion]["funcion"] = qryAcciones.value("funcion");
		this.iface.aAcciones_[iAccion]["icono"] = qryAcciones.value("icono");
		this.iface.aAcciones_[iAccion]["tecla"] = tecla;
debug("tecla = " + tecla);
		this.iface.aAcciones_[iAccion]["accel"] = (tecla && tecla != "") ? this.child("fdbBuscar").insertAccel("Ctrl+" + tecla) : 0;
		iAccion++;
	}
	return true;
}

function oficial_eliminarAccels():Boolean
{
	if (!this.iface.aAcciones_) {
		return true;
	}
	var iAccel:Number;
	for (var i:Number = 0; i < this.iface.aAcciones_.length; i++) {
		iAccel = this.iface.aAcciones_[i]["accel"];
		if (iAccel != 0) {
			this.child("fdbBuscar").removeAccel(iAccel);
		}
	}
}

function oficial_cargaRelaciones():Boolean
{
	var aElemento:Array = this.iface.aHistorialElementos_[this.iface.iElementoHistorial_];
	
	var qryRelaciones:FLSqlQuery = new FLSqlQuery;
	qryRelaciones.setTablesList("t1_relacioneselemento");
	qryRelaciones.setSelect("idrelacionelemento, relacion, card, xmlpic");
	qryRelaciones.setFrom("t1_relacioneselemento");
	qryRelaciones.setWhere("elemento = '" + aElemento["tipo"] + "'");
	qryRelaciones.setForwardOnly(true);
	if (!qryRelaciones.exec()) {
		return false;
	}
	var iRel:Number = 0;
	delete this.iface.aRelaciones_ ;
	this.iface.aRelaciones_ = new Array(qryRelaciones.size());
	var xmlPic:String, xmlDocPic:FLDomDocument;
	while (qryRelaciones.next()) {
		this.iface.aRelaciones_[iRel] = [];
		this.iface.aRelaciones_[iRel]["id"] = qryRelaciones.value("idrelacionelemento");
		this.iface.aRelaciones_[iRel]["nombre"] = qryRelaciones.value("relacion");
		this.iface.aRelaciones_[iRel]["card"] = qryRelaciones.value("card");
		
		xmlPic = qryRelaciones.value("xmlpic");
		if (xmlPic && xmlPic != "") {
			xmlDocPic = new FLDomDocument;
			xmlDocPic.setContent(xmlPic);
		} else {
			xmlDocPic = false;
		}
		this.iface.aRelaciones_[iRel]["xmlPic"] = xmlDocPic;
		
		iRel++;
	}
	return true;
}

function oficial_muestraAcciones():Boolean
{
	this.iface.tblAcciones_.setNumRows(0);
	var totalAcciones:Number = this.iface.aAcciones_.length;
	var iFila:Number = 0, iCol:Number = 0;
	var numCols:Number = this.iface.xAcciones_;
debug("totalAcciones " + totalAcciones);
	for (var iAccion:Number = 0; iAccion < totalAcciones; iAccion++) {
		iFila = Math.floor(iAccion / numCols);
		iCol = iAccion % numCols;
		if (iCol == 0) {
			this.iface.tblAcciones_.insertRows(iFila);
			this.iface.tblAcciones_.setRowHeight(iFila, 32);
		}
//		this.iface.tblAcciones_.setText(iFila, iCol, this.iface.aAcciones_[iAccion]["nombre"]);
		var pixIcono = sys.toPixmap(this.iface.aAcciones_[iAccion]["icono"]);
//		this.iface.tblAcciones_.setCellAlignment(iFila, iCol, this.iface.tblAcciones_.AlignHCenter);
//		this.iface.tblAcciones_.setCellAlignment(iFila, iCol, this.iface.tblAcciones_.AlignRight);
		this.iface.tblAcciones_.setText(iFila, iCol, this.iface.aAcciones_[iAccion]["tecla"]);
		this.iface.tblAcciones_.setPixmap(iFila, iCol, pixIcono);
	}
	return true;
}

function oficial_muestraRelaciones():Boolean
{
	this.iface.tblRelaciones_.clear();
	var aElemento:Array = this.iface.aHistorialElementos_[this.iface.iElementoHistorial_];
	var totalRelaciones:Number = this.iface.aRelaciones_.length;
	var nombreRel:String, card:String;
	var aDatosRel:Array;
	var iFila:Number = 0;
	for (var iRel:Number = 0; iRel < totalRelaciones; iRel++) {
		nombreRel = this.iface.aRelaciones_[iRel]["nombre"];
		card = this.iface.aRelaciones_[iRel]["card"];
		aDatosRel = this.iface.dameDatosRelacion(aElemento["tipo"], aElemento["clave"], nombreRel);
		if (!aDatosRel) {
debug("Salta");
			continue;
		}
		this.iface.tblRelaciones_.insertRows(iFila);
		this.iface.tblRelaciones_.setRowHeight(iFila, 32);
		this.iface.tblRelaciones_.setText(iFila, this.iface.CR_TIPO, nombreRel);
		this.iface.tblRelaciones_.setText(iFila, this.iface.CR_CARD, card);
//		this.iface.tblRelaciones_.setText(iRel, this.iface.CR_ICONO, this.iface.aRelaciones_[iRel]["nombre"]);
		this.iface.dibujarIconoTabla(this.iface.tblRelaciones_, iFila, this.iface.CR_ICONO, this.iface.aRelaciones_[iRel]["nombre"]);
		
// 		aDatosRel = this.iface.dameDatosRelacion(aElemento["tipo"], aElemento["clave"], nombreRel);
// 		if (!aDatosRel) {
// 			return false;
// 		}
		if (!this.iface.dibujaPixmapRel(this.iface.tblRelaciones_, iFila, this.iface.CR_DESC, aDatosRel["c"], iRel)) {
			return false;
		}
// 		this.iface.tblRelaciones_.setText(iRel, this.iface.CR_DESC, aDatosRel["des"]);
		this.iface.tblRelaciones_.setText(iRel, this.iface.CR_CLAVEREL, aDatosRel["claverel"]);
		iFila++;
	}
	return true;
}

function oficial_dameDatosRelacion(tipo:String, clave:String, nombreRel:String):Array
{
debug("oficial_dameDatosRelacion " + tipo + " nombreRel = " + nombreRel);
	var util:FLUtil = new FLUtil;
	var des:String = "", claveRel = "";
	var aDatos:Array = [];
	aDatos["c"] = []; /// Array de campos
	aDatos["i"] = []; /// Array de índices
	aDatos["claverel"] = "";
	switch (tipo) {
		case "clientes": {
			switch (nombreRel) {
				case "facturascli": {
					var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
					var qry:FLSqlQuery = new FLSqlQuery;
					qry.setTablesList("facturascli");
					qry.setSelect("COUNT(*), SUM(total)");
					qry.setFrom("facturascli");
					qry.setWhere("codejercicio = '" + codEjercicio + "' AND codcliente = '" + clave + "'");
					qry.setForwardOnly(true);
					if (!qry.exec()) {
						break;
					}
					var numFacturas:Number = 0, total:Number = 0;
					if (qry.first()) {
						numFacturas = qry.value("COUNT(*)");
						total = qry.value("SUM(total)");
					}
					var i:Number = 0;
					aDatos["c"]["numFacturas"] = numFacturas;
					aDatos["i"][indice++] = "numFacturas";
					aDatos["c"]["total"] = total;
					aDatos["i"][indice++] = "total";
					break;
				}
				default: {
					return false;
				}
			}
			break;
		}
		default: {
			return false;
		}
	}
	
// 				case "albaranescli": {
// 					var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
// 					var qry:FLSqlQuery = new FLSqlQuery;
// 					qry.setTablesList("albaranescli");
// 					qry.setSelect("COUNT(*), SUM(total)");
// 					qry.setFrom("albaranescli");
// 					qry.setWhere("codejercicio = '" + codEjercicio + "' AND codcliente = '" + clave + "'");
// 					qry.setForwardOnly(true);
// 					if (!qry.exec()) {
// 						break;
// 					}
// 					var numFacturas:Number = 0, total:Number = 0;
// 					if (qry.first()) {
// 						numFacturas = qry.value("COUNT(*)");
// 						total = qry.value("SUM(total)");
// 					}
// 					des = numFacturas + " \n/ " + util.roundFieldValue(total, "albaranescli", "total") + "";
// 					break;
// 				}
// 				case "pedidoscli": {
// 					var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
// 					var qry:FLSqlQuery = new FLSqlQuery;
// 					qry.setTablesList("pedidoscli");
// 					qry.setSelect("COUNT(*), SUM(total)");
// 					qry.setFrom("pedidoscli");
// 					qry.setWhere("codejercicio = '" + codEjercicio + "' AND codcliente = '" + clave + "'");
// 					qry.setForwardOnly(true);
// 					if (!qry.exec()) {
// 						break;
// 					}
// 					var numFacturas:Number = 0, total:Number = 0;
// 					if (qry.first()) {
// 						numFacturas = qry.value("COUNT(*)");
// 						total = qry.value("SUM(total)");
// 					}
// 					des = numFacturas + " \n/ " + util.roundFieldValue(total, "pedidoscli", "total") + "";
// 					break;
// 				}
// 				case "presupuestoscli": {
// 					var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
// 					var qry:FLSqlQuery = new FLSqlQuery;
// 					qry.setTablesList("presupuestoscli");
// 					qry.setSelect("COUNT(*), SUM(total)");
// 					qry.setFrom("presupuestoscli");
// 					qry.setWhere("codejercicio = '" + codEjercicio + "' AND codcliente = '" + clave + "'");
// 					qry.setForwardOnly(true);
// 					if (!qry.exec()) {
// 						break;
// 					}
// 					var numFacturas:Number = 0, total:Number = 0;
// 					if (qry.first()) {
// 						numFacturas = qry.value("COUNT(*)");
// 						total = qry.value("SUM(total)");
// 					}
// 					des = numFacturas + " \n/ " + util.roundFieldValue(total, "presupuestoscli", "total") + "";
// 					break;
// 				}
// 				case "agentes": {
// 					var qry:FLSqlQuery = new FLSqlQuery;
// 					qry.setTablesList("clientes,agentes");
// 					qry.setSelect("a.nombre, a.apellidos, a.porcomision, a.codagente");
// 					qry.setFrom("clientes c INNER JOIN agentes a ON c.codagente = a.codagente");
// 					qry.setWhere("c.codcliente = '" + clave + "'");
// 					qry.setForwardOnly(true);
// 					if (!qry.exec()) {
// 						break;
// 					}
// 					if (qry.first()) {
// 						des = qry.value("a.apellidos") +  ", " + qry.value("a.nombre") + ", " + qry.value("a.porcomision") + "%";
// 						claveRel = qry.value("a.codagente");
// 					} else {
// 						des = util.translate("scripts", "(Sin agente)");
// 					}
// 					break;
// 				}
// 			}
// 			break;
// 		}
// 		case "presupuestoscli": {
// 			switch (nombreRel) {
// 				case "clientes": {
// 					var qry:FLSqlQuery = new FLSqlQuery;
// 					qry.setTablesList("clientes,presupuestoscli");
// 					qry.setSelect("c.nombre, c.codcliente");
// 					qry.setFrom("presupuestoscli p INNER JOIN clientes c ON p.codcliente = c.codcliente");
// 					qry.setWhere("p.idpresupuesto = " + clave);
// 					qry.setForwardOnly(true);
// 					if (!qry.exec()) {
// 						break;
// 					}
// 					if (qry.first()) {
// 						des = qry.value("c.nombre");
// 						claveRel = qry.value("c.codcliente");
// 					} else {
// 						des = util.translate("scripts", "(Sin cliente)");
// 					}
// 					break;
// 				}
// 			}
// 			break;
// 		}
// 		case "pedidoscli": {
// 			switch (nombreRel) {
// 				case "clientes": {
// 					var qry:FLSqlQuery = new FLSqlQuery;
// 					qry.setTablesList("clientes,pedidoscli");
// 					qry.setSelect("c.nombre, c.codcliente");
// 					qry.setFrom("pedidoscli p INNER JOIN clientes c ON p.codcliente = c.codcliente");
// 					qry.setWhere("p.idpedido = " + clave);
// 					qry.setForwardOnly(true);
// 					if (!qry.exec()) {
// 						break;
// 					}
// 					if (qry.first()) {
// 						des = qry.value("c.nombre");
// 						claveRel = qry.value("c.codcliente");
// 					} else {
// 						des = util.translate("scripts", "(Sin cliente)");
// 					}
// 					break;
// 				}
// 			}
// 			break;
// 		}
// 		case "albaranescli": {
// 			switch (nombreRel) {
// 				case "clientes": {
// 					var qry:FLSqlQuery = new FLSqlQuery;
// 					qry.setTablesList("clientes,albaranescli");
// 					qry.setSelect("c.nombre, c.codcliente");
// 					qry.setFrom("albaranescli a INNER JOIN clientes c ON a.codcliente = c.codcliente");
// 					qry.setWhere("a.idalbaran = " + clave);
// 					qry.setForwardOnly(true);
// 					if (!qry.exec()) {
// 						break;
// 					}
// 					if (qry.first()) {
// 						des = qry.value("c.nombre");
// 						claveRel = qry.value("c.codcliente");
// 					} else {
// 						des = util.translate("scripts", "(Sin cliente)");
// 					}
// 					break;
// 				}
// 			}
// 			break;
// 		}
// 		case "facturascli": {
// 			switch (nombreRel) {
// 				case "clientes": {
// 					var qry:FLSqlQuery = new FLSqlQuery;
// 					qry.setTablesList("clientes,facturascli");
// 					qry.setSelect("c.nombre, c.codcliente");
// 					qry.setFrom("facturascli f INNER JOIN clientes c ON f.codcliente = c.codcliente");
// 					qry.setWhere("f.idfactura = " + clave);
// 					qry.setForwardOnly(true);
// 					if (!qry.exec()) {
// 						break;
// 					}
// 					if (qry.first()) {
// 						des = qry.value("c.nombre");
// 						claveRel = qry.value("c.codcliente");
// 					} else {
// 						des = util.translate("scripts", "(Sin cliente)");
// 					}
// 					break;
// 				}
// 				case "reciboscli": {
// 					var qry:FLSqlQuery = new FLSqlQuery;
// 					qry.setTablesList("reciboscli,facturascli");
// 					qry.setSelect("COUNT(*), SUM(r.importe), r.estado");
// 					qry.setFrom("reciboscli r");
// 					qry.setWhere("r.idfactura = " + clave + "GROUP BY r.estado");
// 					qry.setForwardOnly(true);
// 					if (!qry.exec()) {
// 						break;
// 					}
// 					var importePte:Number = 0, importePagado:Number = 0, importeTotal:Number = 0;
// 					var numPte:Number = 0, numPagado:Number = 0, numTotal:Number = 0;
// 					while (qry.next()) {
// 						switch (qry.value("r.estado")) {
// 							case "Emitido":
// 							case "Devuelto": {
// 								numPte += parseInt(qry.value("COUNT(*)"));
// 								importePte += parseFloat(qry.value("SUM(r.importe)"));
// 								break;
// 							}
// 							case "Pagado": {
// 								numPagado += parseInt(qry.value("COUNT(*)"));
// 								importePagado += parseFloat(qry.value("SUM(r.importe)"))
// 								break;
// 							}
// 						}
// 						numTotal += parseInt(qry.value("COUNT(*)"));
// 						importeTotal += parseFloat(qry.value("SUM(r.importe)"))
// 					}
// 					des = util.translate("scripts", "%1 - %2 ¤\nPagado %3 - %4. Pte %5 - %6").arg(numTotal).arg(importeTotal).arg(numPagado).arg(importePagado).arg(numPte).arg(importePte);
// 					break;
// 				}
// 			}
// 			break;
// 		}
// 		case "agentes": {
// 			switch (nombreRel) {
// 				case "clientes": {
// 					var qry:FLSqlQuery = new FLSqlQuery;
// 					qry.setTablesList("clientes");
// 					qry.setSelect("COUNT(*)");
// 					qry.setFrom("clientes");
// 					qry.setWhere("codagente = '" + clave + "'");
// 					qry.setForwardOnly(true);
// 					if (!qry.exec()) {
// 						break;
// 					}
// 					if (qry.first()) {
// 						des = util.translate("scripts", "%1 Clientes").arg(qry.value("COUNT(*)"));
// 					} else {
// 						des = util.translate("scripts", "(Sin clientes)");
// 					}
// 					break;
// 				}
// 			}
// 		}
// 	}
// 	var aDatos:Array = [];
// 	aDatos["des"] = des;
// 	aDatos["claverel"] = claveRel;
// debug("des = " + des);
	return aDatos;
}

function oficial_revisarBD()
{
	var aElementos:Array = ["clientes", "facturascli", "albaranescli", "pedidoscli", "presupuestoscli", "reciboscli", "agentes"];
	var cursor:FLSqlCursor = new FLSqlCursor("t1_elementos");
	for (var i:Number = 0; i < aElementos.length; i++) {
		cursor.select("elemento = '" + aElementos[i] + "'");
		if (!cursor.first()) {
			cursor.setModeAccess(cursor.Insert);
			cursor.refreshBuffer();
			cursor.setValueBuffer("elemento", aElementos[i]);
			if (!cursor.commitBuffer()) {
				return false;
			}
		}
	}

	var aAcciones:Array = [["clientes", "generarFactura", "generarFacturaCli", "F"],
	["clientes", "generarAlbaran", "generarAlbaranCli", "A"],
	["clientes", "generarPedido", "generarPedidoCli", "P"],
	["clientes", "generarPresupuesto", "generarPresupuestoCli", "R"],
	["reciboscli", "pagarRecibo", "pagarReciboCli"]];
	cursor = new FLSqlCursor("t1_accioneselemento");
	for (var i:Number = 0; i < aAcciones.length; i++) {
		cursor.select("elemento = '" + aAcciones[i][0] + "' AND accion = '" + aAcciones[i][1] + "'");
		if (!cursor.first()) {
			cursor.setModeAccess(cursor.Insert);
			cursor.refreshBuffer();
			cursor.setValueBuffer("elemento", aAcciones[i][0]);
			cursor.setValueBuffer("accion", aAcciones[i][1]);
			cursor.setValueBuffer("funcion", aAcciones[i][2]);
			cursor.setValueBuffer("tecla", aAcciones[i][3]);
			if (!cursor.commitBuffer()) {
				return false;
			}
		}
	}
	
	var aRelaciones:Array = [["clientes", "presupuestoscli"], ["clientes", "pedidoscli"], ["clientes", "albaranescli"], ["clientes", "facturascli"], ["agentes", "clientes"], ["facturascli", "reciboscli"], ["presupuestoscli", "pedidoscli", "11"], ["pedidoscli", "albaranescli", "MM"], ["facturascli", "albaranescli"]];
	cursor = new FLSqlCursor("t1_relacioneselemento");
	var card1:String; card2:String;
	for (var i:Number = 0; i < aRelaciones.length; i++) {
		cursor.select("elemento = '" + aRelaciones[i][0] + "' AND relacion = '" + aRelaciones[i][1] + "'");
		if (!cursor.first()) {
			cursor.setModeAccess(cursor.Insert);
			cursor.refreshBuffer();
			cursor.setValueBuffer("elemento", aRelaciones[i][0]);
			cursor.setValueBuffer("relacion", aRelaciones[i][1]);
			if (aRelaciones[i].length > 2) {
				card1 = aRelaciones[i][2];
				card2 = aRelaciones[i][2];
			} else {
				card1 = "1M";
				card2 = "M1";
			}
			cursor.setValueBuffer("card", card1);
			if (!cursor.commitBuffer()) {
				return false;
			}
			
			cursor.setModeAccess(cursor.Insert);
			cursor.refreshBuffer();
			cursor.setValueBuffer("elemento", aRelaciones[i][1]);
			cursor.setValueBuffer("relacion", aRelaciones[i][0]);
			cursor.setValueBuffer("card", card2);
			if (!cursor.commitBuffer()) {
				return false;
			}
		}
	}
}

function oficial_tbnCargarIconos_clicked()
{
	var util:FLUtil = new FLUtil;
	var directorio:String = FileDialog.getExistingDirectory("", util.translate("scripts", "Seleccione directorio de iconos"));
	if (!directorio) {
		return false;
	}
	var dDir = new Dir(directorio);
	var aIconos:Array = dDir.entryList("*", Dir.Files);
	var nombre:String, contenido:String;
	var fFichero;
	var curElemento:FLSqlCursor = new FLSqlCursor("t1_elementos");
	var curAccion:FLSqlCursor = new FLSqlCursor("t1_accioneselemento");
	for (var i:Number = 0; i < aIconos.length; i++) {
		fFichero = new File(aIconos[i]);
 		if (fFichero.extension != "xpm") {
 			continue;
 		}
		contenido = File.read(directorio + aIconos[i]);
		nombre = fFichero.baseName;
		prefijo = nombre.left(2);
		nombre = nombre.right(nombre.length - 2);
		switch (prefijo) {
			case "e_": {
				curElemento.select("elemento = '" + nombre + "'");
				if (curElemento.first()) {
					curElemento.setModeAccess(curElemento.Edit);
					curElemento.refreshBuffer();
					curElemento.setValueBuffer("icono", contenido);
					if (!curElemento.commitBuffer()) {
						return false;
					}
				}
				break;
			}
			case "a_": {
				curAccion.select("funcion = '" + nombre + "'");
				if (curAccion.first()) {
					curAccion.setModeAccess(curAccion.Edit);
					curAccion.refreshBuffer();
					curAccion.setValueBuffer("icono", contenido);
					if (!curAccion.commitBuffer()) {
						return false;
					}
				}
				break;
			}
		}

	}
	MessageBox.information(util.translate("scripts", "Iconos cargados correctamente"), MessageBox.Ok, MessageBox.NoButton);
	return true;
}

function oficial_bufferChanged(fN:String)
{
	switch (fN) {
		case "buscar": {
			this.iface.buscarCambiado_ = true;
			break;
		}
	}
}

function oficial_editarElementoSel()
{
	var aElemento:Array = this.iface.aHistorialElementos_[this.iface.iElementoHistorial_];
	if (!aElemento) {
		return false;
	}
	this.iface.editarElemento(aElemento["tipo"], aElemento["clave"]);
}

function oficial_editarElemento(tipo:String, clave:String)
{
	if (!this.iface.curObjeto_ || this.iface.curObjeto_.action() != tipo) {
		delete this.iface.curObjeto_;
		this.iface.curObjeto_ = new FLSqlCursor(tipo);
	}
	var campoClave:String = this.iface.curObjeto_.primaryKey();
	var tipoClave:Number = this.iface.curObjeto_.fieldType(campoClave);
	switch (tipoClave) {
		case 3: {
			this.iface.curObjeto_.select(campoClave + " = '" + clave + "'");
			break;
		}
		default: {
			this.iface.curObjeto_.select(campoClave + " = " + clave);
		}
	}
	if (!this.iface.curObjeto_.first()) {
		return false;
	}
	this.iface.curObjeto_.editRecord();
}

function oficial_cargaElementos():Boolean
{
	if (this.iface.aElementos_) {
		delete this.iface.aElementos_;
		delete this.iface.aIndiceElementos_;
	}
	this.iface.aElementos_ = [];
	this.iface.aIndiceElementos_ = [];
	
	var qryElementos:FLSqlQuery = new FLSqlQuery;
	qryElementos.setTablesList("t1_elementos");
	qryElementos.setSelect("elemento, icono, xmlpic");
	qryElementos.setFrom("t1_elementos");
	qryElementos.setWhere("1 = 1");
	qryElementos.setForwardOnly(true);
	if (!qryElementos.exec()) {
		return false;
	}
	var indice:Number = 0;
	var elemento:String, icono:String, xmlPic:String;
	var xmlDocPic:FLDomDocument, pixIcono:Pixmap;
	while (qryElementos.next()) {
		elemento = qryElementos.value("elemento");
		icono = qryElementos.value("icono");
		pixIcono = icono && icono != "" ? sys.toPixmap(icono) : false;
		xmlPic = qryElementos.value("xmlpic");
		if (xmlPic && xmlPic != "") {
			xmlDocPic = new FLDomDocument;
			xmlDocPic.setContent(xmlPic);
		} else {
			xmlDocPic = false;
		}
		this.iface.aElementos_[elemento] = [];
		this.iface.aElementos_[elemento]["icono"] = pixIcono;
		this.iface.aElementos_[elemento]["xmlPic"] = xmlDocPic;
		
		this.iface.aIndiceElementos_[indice++] = elemento;
	}
	return true;
}

function oficial_tbnEditaPicElemento_clicked()
{
	var aElemento:Array = this.iface.aHistorialElementos_[this.iface.iElementoHistorial_];
	if (!aElemento) {
		return false;
	}
	if (this.iface.curObjeto_) {
		delete this.iface.curObjeto_;
	}
	this.iface.curObjeto_ = new FLSqlCursor("t1_elementos");
	this.iface.curObjeto_.select("elemento = '" + aElemento["tipo"] + "'");
	if (!this.iface.curObjeto_.first()) {
		return false;
	}
	connect(this.iface.curObjeto_, "bufferCommited()", this, "iface.recargaPicElementos");
	this.iface.curObjeto_.editRecord();
}

function oficial_recargaPicElementos()
{
	this.iface.cargaElementos();
	var aElemento:Array = this.iface.aHistorialElementos_[this.iface.iElementoHistorial_];
	if (!aElemento) {
		return false;
	}
	this.iface.muestraElemento(aElemento["tipo"], aElemento["clave"]);
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
