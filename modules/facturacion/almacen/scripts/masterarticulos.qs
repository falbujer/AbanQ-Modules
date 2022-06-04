/***************************************************************************
                 masterarticulos.qs  -  description
                             -------------------
    begin                : jue jun 28 2007
    copyright            : (C) 2007 by InfoSiAL S.L.
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
	var curArticulo;
	var curTarifa;
	var curArticuloProv;
	var curArticuloAgen;
	var tdbRecords;
	var toolButtonCopy:Object;
	function oficial( context ) { interna( context ); }
	function copiarArticulo_clicked() {
		return this.ctx.oficial_copiarArticulo_clicked();
	}
	function dameReferenciaCopia() {
		return this.ctx.oficial_dameReferenciaCopia();
	}
	function copiarArticulo(refOriginal) {
		return this.ctx.oficial_copiarArticulo(refOriginal);
	}
	function copiarAnexosArticulo(refOriginal, refNueva) {
		return this.ctx.oficial_copiarAnexosArticulo(refOriginal, refNueva);
	}
	function copiarTablaTarifas(refOriginal, refNueva) {
		return this.ctx.oficial_copiarTablaTarifas(refOriginal, refNueva);
	}
	function copiarTablaArticulosProv(refOriginal, refNueva) {
		return this.ctx.oficial_copiarTablaArticulosProv(refOriginal, refNueva);
	}
	function copiarTablaArticulosAgen(refOrigen, refNueva) {
		return this.ctx.oficial_copiarTablaArticulosAgen(refOrigen, refNueva);
	}
	function datosArticuloAgen(cursor, campo) {
		return this.ctx.oficial_datosArticuloAgen(cursor, campo);
	}
	function datosArticulo(cursor, campo) {
		return this.ctx.oficial_datosArticulo(cursor, campo);
	}
	function datosTarifa(cursor, campo) {
		return this.ctx.oficial_datosTarifa(cursor, campo);
	}
	function datosArticuloProv(cursor, campo) {
		return this.ctx.oficial_datosArticuloProv(cursor, campo);
	}
	function copiarAnexosArticuloProv(idArtProvOrigen, idArtProvNuevo) {
		return this.ctx.oficial_copiarAnexosArticuloProv(idArtProvOrigen, idArtProvNuevo);
	}
	/// Quitar luego
	function exportar() {
		return this.ctx.oficial_exportar();
	}
	function dameParamExcel() {
		return this.ctx.oficial_dameParamExcel();
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
/** \C El Al copiar un artículo se copian también sus tarifas y sus precios por proveedor.
\end */
function interna_init()
{
	var _i = this.iface;
	_i.tdbRecords = this.child("tableDBRecords");
	_i.toolButtonCopy = this.child("toolButtonCopy");
	connect(_i.toolButtonCopy, "clicked()", _i, "copiarArticulo_clicked()");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_copiarArticulo_clicked()
{
  var util: FLUtil;
  var cursor = this.cursor();

  if (!cursor.isValid()) {
    return;
  }
  //  var referencia = this.iface.curArticulo.valueBuffer("referencia");
  var referencia = cursor.valueBuffer("referencia");
  var curTransaccion = new FLSqlCursor("empresa");
  curTransaccion.transaction(false);

  if (!referencia) {
    MessageBox.information(util.translate("scripts", "No hay ningún registro seleccionado"), MessageBox.Ok, MessageBox.NoButton);
    return;
  }

  // Esto es para insertar en este cursor
  this.iface.curArticulo = this.cursor();
	disconnect(this.iface.curArticulo, "bufferChanged(QString)", formRecordarticulos.iface, "bufferChanged");
	
  var nRef;
  try {
    nRef = this.iface.copiarArticulo(referencia);
    if (nRef) {
      curTransaccion.commit();
    } else {
      curTransaccion.rollback();
      MessageBox.warning(util.translate("scripts", "Hubo un error al copiar el artículo %1").arg(referencia), MessageBox.Ok, MessageBox.NoButton);
      return;
    }
  } catch (e) {
    curTransaccion.rollback();
    MessageBox.critical(util.translate("scripts", "Hubo un error al copiar el artículo %1").arg(referencia) + ":\n" + e, MessageBox.Ok, MessageBox.NoButton);
    return;
  }

  var curA = this.cursor();
  //** Con esto bastaría, al hacer antes this.iface.curArticulo = this.cursor()
  //** debe estar posicionado correctamente
  curA.editRecord();
  //** Pero tambien se puede buscar la posicion así
  //curA.setModeAccess(curA.Browse);
  //curA.setValueBuffer("referencia", nRef);
  //var pos = curA.atFrom();
  //if (curA.seek(pos, false, true)) {
  //  curA.editRecord();
  //}

  //this.iface.tdbRecords.refresh();
  
  //var curA = new FLSqlCursor("articulos"); /// Un nuevo cursor porque si el FLTable tiene un filtro con el cursor del FLTable no va bien el select
  //curA.setAction(cursor.action());
  //curA.select("referencia = '" + nRef + "'");
  //if (curA.first()) {
  //  curA.editRecord();
  //}

  return true;
}

function oficial_dameReferenciaCopia()
{
  return Input.getText(sys.translate("Introduzca la nueva referencia:"), "", sys.translate("Copiar artículo"));
}

function oficial_copiarArticulo(refOriginal)
{
  var util: FLUtil;
  var _i = this.iface;

  var nuevaReferencia = _i.dameReferenciaCopia();

  if (!nuevaReferencia || nuevaReferencia == "") {
    MessageBox.warning(util.translate("scripts", "Debe introducir una referencia para crear el nuevo artículo."), MessageBox.Ok, MessageBox.NoButton);
    return false;
  }

  if (util.sqlSelect("articulos", "referencia", "referencia = '" + nuevaReferencia + "'")) {
    MessageBox.warning(util.translate("scripts", "Ya existe un artículo con esa referencia"), MessageBox.Ok, MessageBox.NoButton);
    return false;
  }

  var curArticuloOrigen = new FLSqlCursor("articulos");
  curArticuloOrigen.select("referencia = '" + refOriginal + "'");
  if (!curArticuloOrigen.first()) {
    return false;
  }
  curArticuloOrigen.setModeAccess(curArticuloOrigen.Browse);
  curArticuloOrigen.refreshBuffer();

  if (!this.iface.curArticulo) {
    this.iface.curArticulo = new FLSqlCursor("articulos");
  }
  this.iface.curArticulo.setModeAccess(this.iface.curArticulo.Insert);
  this.iface.curArticulo.refreshBuffer();
  this.iface.curArticulo.setValueBuffer("referencia", nuevaReferencia);

  var campos: Array = util.nombreCampos("articulos");
  var totalCampos: Number = campos[0];
  for (var i: Number = 1; i <= totalCampos; i++) {
    if (!this.iface.datosArticulo(curArticuloOrigen, campos[i])) {
      return false;
    }
  }

  if (!this.iface.curArticulo.commitBuffer()) {
    return false;
  }

  if (!this.iface.copiarAnexosArticulo(refOriginal, nuevaReferencia)) {
    return false;
  }

  return nuevaReferencia;
}

function oficial_datosArticulo(cursor, campo) 
{
	if (!campo || campo == "") {
		return false;
	}
	switch (campo) {
		case "referencia": {
			return true;
			break;
		}
		case "stockfis": {
			this.iface.curArticulo.setValueBuffer(campo, 0);
			break;
		}
		default: {
			if (cursor.isNull(campo)) {
				this.iface.curArticulo.setNull(campo);
			} else {
				this.iface.curArticulo.setValueBuffer(campo, cursor.valueBuffer(campo));
			}
		}
	}
	return true;
}

function oficial_copiarAnexosArticulo(refOriginal, refNueva)
{
	if (!this.iface.copiarTablaTarifas(refOriginal, refNueva)) {
		return false;
	}
	if (!this.iface.copiarTablaArticulosProv(refOriginal, refNueva)) {
		return false;
	}
	if (!this.iface.copiarTablaArticulosAgen(refOriginal, refNueva)) {
		return false;
	}
	return true;
}

function oficial_copiarTablaTarifas(refOriginal, nuevaReferencia)
{
	var util:FLUtil;

	if (!this.iface.curTarifa) {
		this.iface.curTarifa = new FLSqlCursor("articulostarifas");
	}
	
	var campos:Array = util.nombreCampos("articulostarifas");
	var totalCampos:Number = campos[0];

	var curTarifaOrigen = new FLSqlCursor("articulostarifas");
	curTarifaOrigen.select("referencia = '" + refOriginal + "'");
	while (curTarifaOrigen.next()) {
		this.iface.curTarifa.setModeAccess(this.iface.curTarifa.Insert);
		this.iface.curTarifa.refreshBuffer();
		this.iface.curTarifa.setValueBuffer("referencia", nuevaReferencia);
	
		for (var i:Number = 1; i <= totalCampos; i++) {
			if (!this.iface.datosTarifa(curTarifaOrigen, campos[i])) {
				return false;
			}
		}

		if (!this.iface.curTarifa.commitBuffer()) {
			return false;
		}
	}

	return true;
}

function oficial_copiarTablaArticulosProv(refOriginal, nuevaReferencia)
{
	var util:FLUtil;

	if (!this.iface.curArticuloProv) {
 		this.iface.curArticuloProv = new FLSqlCursor("articulosprov");
	}
	
	var campos:Array = util.nombreCampos("articulosprov");
	var totalCampos:Number = campos[0];

	var idArtProvNuevo, idArtProvOrigen;
	var curArticuloProvOrigen = new FLSqlCursor("articulosprov");
	curArticuloProvOrigen.select("referencia = '" + refOriginal + "'");
	while (curArticuloProvOrigen.next()) {
		this.iface.curArticuloProv.setModeAccess(this.iface.curArticuloProv.Insert);
		this.iface.curArticuloProv.refreshBuffer();
		this.iface.curArticuloProv.setValueBuffer("referencia", nuevaReferencia);
	
		for (var i:Number = 1; i <= totalCampos; i++) {
			if (!this.iface.datosArticuloProv(curArticuloProvOrigen, campos[i])) {
				return false;
			}
		}

		if (!this.iface.curArticuloProv.commitBuffer()) {
			return false;
		}
		idArtProvOrigen = curArticuloProvOrigen.valueBuffer("id");
		idArtProvNuevo = this.iface.curArticuloProv.valueBuffer("id");
		if (!this.iface.copiarAnexosArticuloProv(idArtProvOrigen, idArtProvNuevo)) {
			return false;
		}
	}

	return true;
}

function oficial_copiarAnexosArticuloProv(idArtProvOrigen, idArtProvNuevo)
{
	return true;
}

function oficial_copiarTablaArticulosAgen(refOrigen, nuevaReferencia)
{
	var util:FLUtil;

	if (!this.iface.curArticuloAgen) {
		this.iface.curArticuloAgen = new FLSqlCursor("articulosagen");
	}
	
	var campos:Array = util.nombreCampos("articulosagen");
	var totalCampos:Number = campos[0];

	var curArticuloAgenOrigen = new FLSqlCursor("articulosagen");
	curArticuloAgenOrigen.select("referencia = '" + refOrigen + "'");
	while (curArticuloAgenOrigen.next()) {
		this.iface.curArticuloAgen.setModeAccess(this.iface.curArticuloAgen.Insert);
		this.iface.curArticuloAgen.refreshBuffer();
		this.iface.curArticuloAgen.setValueBuffer("referencia", nuevaReferencia);
	
		for (var i:Number = 1; i <= totalCampos; i++) {
			if (!this.iface.datosArticuloAgen(curArticuloAgenOrigen, campos[i])) {
				return false;
			}
		}

		if (!this.iface.curArticuloAgen.commitBuffer()) {
			return false;
		}
	}

	return true;
}

function oficial_datosTarifa(cursorOrigen, campo)
{
	if (!campo || campo == "") {
		return false;
	}
	switch (campo) {
		case "id":
		case "referencia": {
			return true;
			break;
		}
		default: {
			if (cursorOrigen.isNull(campo)) {
				this.iface.curTarifa.setNull(campo);
			} else {
				this.iface.curTarifa.setValueBuffer(campo, cursorOrigen.valueBuffer(campo));
			}
		}
	}
	return true;
}

function oficial_datosArticuloAgen(cursorOrigen,campo)
{
	if (!campo || campo == "") {
		return false;
	}
	switch (campo) {
		case "id":
		case "referencia": {
			return true;
			break;
		}
		default: {
			if (cursorOrigen.isNull(campo)) {
				this.iface.curArticuloAgen.setNull(campo);
			} else {
				this.iface.curArticuloAgen.setValueBuffer(campo, cursorOrigen.valueBuffer(campo));
			}
		}
	}
	return true;
}

function oficial_datosArticuloProv(cursorOrigen,campo)
{
	if (!campo || campo == "") {
		return false;
	}
	switch (campo) {
		case "id":
		case "referencia": {
			return true;
			break;
		}
		default: {
			if (cursorOrigen.isNull(campo)) {
				this.iface.curArticuloProv.setNull(campo);
			} else {
				this.iface.curArticuloProv.setValueBuffer(campo, cursorOrigen.valueBuffer(campo));
			}
		}
	}
	return true;
}

/// Quitar luego
function oficial_exportar()
{
	var _i = this.iface;
	
	var oParam = _i.dameParamExcel();
	flfactppal.iface.pub_exportarConsultaExcel(oParam);
}

function oficial_dameParamExcel()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
  var oParam = flfactppal.iface.pub_dameParamExcel();
	
	var fecha = new Date();
	var dia = fecha.getDate().toString();
	if(dia.length < 2){
		dia = "0" + dia;
	}
	var mes = fecha.getMonth().toString();
	if(mes.length < 2){
		mes = "0" + mes;
	}
	var anyo = fecha.getYear().toString();
	
	fecha = dia + "/" + mes + "/" + anyo;
	
	var select = "referencia,descripcion,pvp,fechaalta,fechamod";
	var tipo = "string,string,double,date,date";
	
	var q = new FLSqlQuery();
	q.setSelect(select);
	q.setFrom("articulos");
	q.setWhere("referencia = '123'");
	
  oParam.nombreFichero = "articulos";
  oParam.consulta = q;
	oParam.nombreColumnas = select.split(",");
  oParam.tipoColumna = tipo.split(",");
  oParam.titulo = "ARTICULOS PRUEBA (" + fecha + ")";
  return oParam;
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
