/**************************************************************************
                 seleccionreciboscli.qs  -  description
                             -------------------
    begin                : mar feb 21 2006
    copyright            : (C) 2006 by InfoSiAL S.L.
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
	var tdbRecibos:Object;
	var tdbRecibosSel:Object;
	var listaDom;
	
    function oficial( context ) { interna( context ); } 
	function seleccionar() {
		return this.ctx.oficial_seleccionar();
	}
	function quitar() {
		return this.ctx.oficial_quitar();
	}
	function refrescarTablas() {
		return this.ctx.oficial_refrescarTablas();
	}
	function tbnTodos_clicked() {
		return this.ctx.oficial_tbnTodos_clicked();
	}
	function tbnNinguno_clicked() {
		return this.ctx.oficial_tbnNinguno_clicked();
	}
	function tbnTodosSel_clicked() {
		return this.ctx.oficial_tbnTodosSel_clicked();
	}
	function tbnNingunoSel_clicked() {
		return this.ctx.oficial_tbnNingunoSel_clicked();
	}
	function calcularTotal() {
		return this.ctx.oficial_calcularTotal();
	}
	function dameFiltro() {
		return this.ctx.oficial_dameFiltro();
	}
	function bufferChanged(fN){
		return this.ctx.oficial_bufferChanged(fN);
	}
	function dameDomiciliados(){
		return this.ctx.oficial_dameDomiciliados();
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
/** \C
Este formulario muestra una lista de recibos de cliente que cumplen un determinado filtro, y permite al usuario seleccionar uno o más recibos de la lista
\end */
function interna_init()
{
	var _i = this.iface;
	var util = new FLUtil();
	var cursor = this.cursor();
	
	this.iface.tdbRecibos = this.child("tdbRecibos");
	this.iface.tdbRecibosSel = this.child("tdbRecibosSel");
	
	this.iface.tdbRecibos.setReadOnly(true);
	this.iface.tdbRecibosSel.setReadOnly(true);
	
	_i.dameDomiciliados();
	this.iface.refrescarTablas();
	this.iface.calcularTotal();
	
	connect(this.iface.tdbRecibos.cursor(), "recordChoosed()", this, "iface.seleccionar()");
	connect(this.iface.tdbRecibosSel.cursor(), "recordChoosed()", this, "iface.quitar()");
	connect(this.child("tbnSeleccionar"), "clicked()", this, "iface.seleccionar()");
	connect(this.child("tbnQuitar"), "clicked()", this, "iface.quitar()");
	connect(this.child("tbnTodos"), "clicked()", this, "iface.tbnTodos_clicked()");
	connect(this.child("tbnNinguno"), "clicked()", this, "iface.tbnNinguno_clicked()");
	connect(this.child("tbnTodosSel"), "clicked()", this, "iface.tbnTodosSel_clicked()");
	connect(this.child("tbnNingunoSel"), "clicked()", this, "iface.tbnNingunoSel_clicked()");
	
  //connect(this.child("chkDomiciliados"), "clicked()", _i, "refrescarTablas()");
	//connect(cursor, "bufferChanged(QString)", _i, "bufferChanged");
	connect(this.child("tbnBuscar"), "clicked()", _i, "refrescarTablas");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_dameFiltro()
{
	var cursor = this.cursor();
	var _i = this.iface;
	var filtro = cursor.valueBuffer("filtro");
	
	var desde = this.child("dedDesde").date;
	var hasta = this.child("dedHasta").date;
	
	if (desde) {
		filtro += " AND fechav >= '" + desde + "'";
	}
	if (hasta) {
		filtro += " AND fechav <= '" + hasta + "'";
	}
	
	if (this.child("chkDomiciliados").checked) {
		if (_i.listaDom != "") {
			filtro += (filtro != "") ? " AND " : "";
			filtro += "codpago IN (" + _i.listaDom + ")";
		}
	}
	
	if (cursor.valueBuffer("codpago") && cursor.valueBuffer != ""){
		filtro += (filtro != "") ? " AND " : "";
		filtro += "codpago = '" + cursor.valueBuffer("codpago") + "'";
	}
	
	return filtro;
}

/** \D Refresca las tablas, en función del filtro y de los datos seleccionados hasta el momento
*/
function oficial_refrescarTablas()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var datos:String = this.cursor().valueBuffer("datos");
	var filtro:String = _i.dameFiltro(); 
	
	filtro += (filtro != "") ? " AND " : "";
	
	if (!datos || datos == "") {
		this.iface.tdbRecibos.cursor().setMainFilter(filtro + "1 = 1");
		this.iface.tdbRecibosSel.cursor().setMainFilter(filtro + "1 = 2");
	} else {
		this.iface.tdbRecibos.cursor().setMainFilter(filtro + "idrecibo NOT IN (" + datos + ")");
		this.iface.tdbRecibosSel.cursor().setMainFilter(filtro + "idrecibo IN (" + datos + ")");
	}
	this.iface.tdbRecibos.refresh();
	this.iface.tdbRecibosSel.refresh();
}

/** \D Incluye un recibo en la lista de datos
*/
function oficial_seleccionar()
{
	var cursor:FLSqlCursor = this.cursor();
	var datos:String = cursor.valueBuffer("datos");
	
	var aRecibos:Array = this.iface.tdbRecibos.primarysKeysChecked();
	if (aRecibos && aRecibos.length > 0) {
		var listaRecibos:String = aRecibos.join(",");
		if (!datos || datos == "") {
			datos = listaRecibos;
		} else {
			datos += "," + listaRecibos;
		}
		for (var i:Number = 0; i < aRecibos.length; i++) {
			this.iface.tdbRecibos.setPrimaryKeyChecked(aRecibos[i], false);
		}
	}
// 	var idRecibo:String = this.iface.tdbRecibos.cursor().valueBuffer("idRecibo");
// 	if (!idRecibo)
// 		return;
// 	if (!datos || datos == "")
// 		datos = idRecibo;
// 	else
// 		datos += "," + idRecibo;
		
	cursor.setValueBuffer("datos", datos);
	
	this.iface.refrescarTablas();
	this.iface.calcularTotal();
}

/** \D Quita un recibo de la lista de datos
*/
function oficial_quitar()
{
	var cursor = this.cursor();
	var datos = cursor.valueBuffer("datos");
	if (!datos || datos == "") {
		return;
	}
	var recibos:Array = datos.split(",");
	var aRecibos:Array = this.iface.tdbRecibosSel.primarysKeysChecked();
	if (!aRecibos || aRecibos.length == 0) {
		return;
	}
	var datosNuevos:String = "";
	
	var quitar:Boolean;
	for (var i:Number = 0; i < recibos.length; i++) {
		quitar = false;
		for (var iRecibo:Number = 0; iRecibo < aRecibos.length; iRecibo++) {
			if (recibos[i] == aRecibos[iRecibo]) {
				quitar = true;
				break;
			}
		}
		if (quitar) {
			this.iface.tdbRecibosSel.setPrimaryKeyChecked(recibos[i], false);
			continue;
		}
		if (datosNuevos == "") {
			datosNuevos = recibos[i];
		} else {
			datosNuevos += "," + recibos[i];
		}
	}
	cursor.setValueBuffer("datos", datosNuevos);

	this.iface.refrescarTablas();
	this.iface.calcularTotal();
}

/** \D Selecciona todos los recibos de la tabla superior
\end */
function oficial_tbnTodos_clicked()
{
	var _i = this.iface;
	
	var mF = this.child("tdbRecibos").cursor().mainFilter();
	var fF = this.child("tdbRecibos").findFilter();
	var f = this.child("tdbRecibos").filter();

	var filtro = mF;
	if (fF != "") {
		filtro += filtro != "" ? " AND " : "";
		filtro += fF;
	}
	if (f != "") {
		filtro += filtro != "" ? " AND " : "";
		filtro += f;
	}
	
	if (!filtro || filtro == "") {
		return;
	}
	var qryRecibos:FLSqlQuery = new FLSqlQuery();
	qryRecibos.setTablesList("reciboscli");
	qryRecibos.setSelect("idrecibo");
	qryRecibos.setFrom("reciboscli");
	qryRecibos.setWhere(filtro);
	qryRecibos.setForwardOnly(true);
	if (!qryRecibos.exec()) {
		return false;
	}
	while (qryRecibos.next()) {
		this.iface.tdbRecibos.setPrimaryKeyChecked(qryRecibos.value("idrecibo"), true);
	}
	this.iface.tdbRecibos.refresh();
}

/** \D Elimina la selección de todos los recibos de la tabla superior
\end */
function oficial_tbnNinguno_clicked()
{
	this.iface.tdbRecibos.clearChecked();
	this.iface.tdbRecibos.refresh();
}

/** \D Selecciona todos los recibos de la tabla inferior
\end */
function oficial_tbnTodosSel_clicked()
{
	var _i = this.iface;
	
	var mF = _i.tdbRecibosSel.cursor().mainFilter();
	var fF = _i.tdbRecibosSel.findFilter();
	var f = _i.tdbRecibosSel.filter();

	var filtro = mF;
	if (fF != "") {
		filtro += filtro != "" ? " AND " : "";
		filtro += fF;
	}
	if (f != "") {
		filtro += filtro != "" ? " AND " : "";
		filtro += f;
	}
	
	if (!filtro || filtro == "") {
		return;
	}
	var qryRecibos:FLSqlQuery = new FLSqlQuery();
	qryRecibos.setTablesList("reciboscli");
	qryRecibos.setSelect("idrecibo");
	qryRecibos.setFrom("reciboscli");
	qryRecibos.setWhere(filtro);
	qryRecibos.setForwardOnly(true);
	if (!qryRecibos.exec()) {
		return false;
	}
	while (qryRecibos.next()) {
		this.iface.tdbRecibosSel.setPrimaryKeyChecked(qryRecibos.value("idrecibo"), true);
	}
	this.iface.tdbRecibosSel.refresh();
}

/** \D Elimina la selección de todos los recibos de la tabla inferior
\end */
function oficial_tbnNingunoSel_clicked()
{
	this.iface.tdbRecibosSel.clearChecked();
	this.iface.tdbRecibosSel.refresh();
}

function oficial_calcularTotal()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var datos:String = cursor.valueBuffer("datos");
	var total:Number = 0;
	if (datos || datos != "") {
		total = parseFloat(util.sqlSelect("reciboscli", "SUM(importe)", "idrecibo IN (" + datos + ")"));
		if (!total || isNaN(total))
			total = 0;
	}
	this.child("lblImporte").text = util.translate("scripts", "Total seleccionado: %1").arg(util.roundFieldValue(total, "reciboscli", "importe"));
}

function oficial_bufferChanged(fN)
{
  var _i = this.iface;
  var util = new FLUtil();
  var cursor = this.cursor();  
  
	switch (fN) {
		case "codpago": {
			_i.refrescarTablas();
			break;
		}
	}
}

function oficial_dameDomiciliados(){
	var _i = this.iface;
	_i.listaDom = "";
	var q = new FLSqlQuery();
	q.setSelect("codpago");
	q.setFrom("formaspago");
	q.setWhere("domiciliado IS true");

	if(!q.exec()){
		return false;
	}
	
	while(q.next()){
		_i.listaDom += (_i.listaDom != "") ? ", " : "";
		_i.listaDom += "'" + q.value("codpago") + "'";
	}
	
	return true;

}
///// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
