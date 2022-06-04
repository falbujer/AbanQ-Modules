/***************************************************************************
                 i_masterinventario.qs  -  description
                             -------------------
    begin                : lun abr 26 2004
    copyright            : (C) 2004 by InfoSiAL S.L.
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
	var totalAlmacen_, totalInforme_;
	var dia_, curStock_, cantidad_;
  function oficial( context ) { interna( context ); } 
	function lanzar() {
			return this.ctx.oficial_lanzar();
	}
	function obtenerOrden(nivel:Number, cursor:FLSqlCursor) {
			return this.ctx.oficial_obtenerOrden(nivel, cursor);
	}
	function costeArticulo(nodo:FLDomNode, campo:String) {
		return this.ctx.oficial_costeArticulo(nodo, campo);
	}
	function totalAlmacen(nodo:FLDomNode, campo:String) {
		return this.ctx.oficial_totalAlmacen(nodo, campo);
	}
	function totalInforme(nodo:FLDomNode, campo:String) {
		return this.ctx.oficial_totalInforme(nodo, campo);
	}
	function iniciarTotales(nodo:FLDomNode, campo:String) {
		return this.ctx.oficial_iniciarTotales(nodo, campo);
	}
	function obtenerParamInforme() {
		return this.ctx.oficial_obtenerParamInforme();
	}
	function dameCantidad(nodo, campo) {
		return this.ctx.oficial_dameCantidad(nodo, campo);
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
	function pub_lanzar() {
		return this.lanzar();
	}
	function pub_costeArticulo(nodo:FLDomNode, campo:String) {
		return this.costeArticulo(nodo, campo);
	}
	function pub_totalAlmacen(nodo:FLDomNode, campo:String) {
		return this.totalAlmacen(nodo, campo);
	}
	function pub_totalInforme(nodo:FLDomNode, campo:String) {
		return this.totalInforme(nodo, campo);
	}
	function pub_iniciarTotales(nodo:FLDomNode, campo:String) {
		return this.iniciarTotales(nodo, campo);
	}
	function pub_dameCantidad(nodo, campo) {
		return this.dameCantidad(nodo, campo);
	}
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
		connect (this.child("toolButtonPrint"), "clicked()", this, "iface.lanzar()");
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_lanzar()
{
	var _i = this.iface;
	_i.totalAlmacen_ = 0;
	_i.totalInforme_ = 0;
	var cursor = this.cursor();
	var seleccion= cursor.valueBuffer("id");
	if (!seleccion) {
		return;
	}

	var pI = _i.obtenerParamInforme();
	if (!pI) {
		return;
	}
	
  flfactinfo.iface.diaInv_ = false;
	if (!cursor.valueBuffer("actual") && !cursor.isNull("afecha")) {
		flfactinfo.iface.diaInv_ = cursor.valueBuffer("afecha").toString(); ///new Date (Date.parse(cursor.valueBuffer("afecha").toString()));
	}
debug("flfactinfo.iface.diaInv_ = " + this.iface.dia_ );

	flfactinfo.iface.pub_lanzaInforme(cursor, pI);
}

function oficial_obtenerOrden(nivel:Number, cursor:FLSqlCursor)
{
	var ret= "";
	var orden= cursor.valueBuffer("orden" + nivel.toString());
	switch(nivel) {
		case 1: {
			switch(orden) {
				case "Código": {
					ret += "almacenes.codalmacen";
					break;
				}
				case "Nombre": {
					ret += "almacenes.nombre";
					break;
				}
			}
			break;
		}
		break;
		case 2: {
			switch(orden) {
				case "Referencia": {
					ret += "stocks.referencia";
					break;
				}
				case "Descripción": {
					ret += "articulos.descripcion";
					break;
				}
			}
			break;
		}
		break;
	}
	if (ret != "") {
		var tipoOrden= cursor.valueBuffer("tipoorden" + nivel.toString());
		switch(tipoOrden) {
			case "Descendente": {
				ret += " DESC";
				break;
			}
		}
	}

	if (nivel == 1 && orden != 1) {
		if (ret == "") {
			ret += "almacenes.codalmacen";
		} else {
			ret += ", almacenes.codalmacen";
		}
	}

	return ret;
}

function oficial_costeArticulo(nodo:FLDomNode, campo:String)
{
	var _i = this.iface;
	var util= new FLUtil;
	var tipoValoracion= nodo.attributeValue("almacenes.tipovaloracion");
	var campoRed:String;
	var tablaRed:String;
debug("tipoValoracion " + tipoValoracion);
	var valor:Number;
	switch (tipoValoracion) {
		case "Coste medio": {
			valor = nodo.attributeValue("articulos.costemedio")
			tablaRed = "articulos";
			campoRed = "costemedio";
			break;
		}
		case "PVP": {
			var porPvp= parseFloat(nodo.attributeValue("almacenes.porpvp"));
			valor = parseFloat(nodo.attributeValue("articulos.pvp")) * porPvp / 100;
			tablaRed = "articulos";
			campoRed = "pvp";
			break;
		}
		case "Coste Prov.": {
			var c = parseFloat(nodo.attributeValue("articulosprov.coste"));
			c = isNaN(c) ? 0 : c;
			var d = parseFloat(nodo.attributeValue("articulosprov.dto"));
			d = isNaN(d) ? 0 : d;
			valor = c * (100 - d) / 100;
			tablaRed = "articulosprov";
			campoRed = "coste";
			break;
		}
	}
	if (campo == "total") {
		var cantidad = _i.cantidad_; //parseFloat(nodo.attributeValue("stocks.cantidad"));
		cantidad = isNaN(cantidad) ? 0 : cantidad;
debug("_i.cantidad_ = " + _i.cantidad_);
		valor = parseFloat(valor) * parseFloat(cantidad);
		if (isNaN(this.iface.totalAlmacen_)) {
			this.iface.totalAlmacen_ = 0;
		}
		this.iface.totalAlmacen_ += parseFloat(valor);
		
		if (isNaN(this.iface.totalInforme_)) {
			this.iface.totalInforme_ = 0;
		}
		this.iface.totalInforme_ += parseFloat(valor);
	}
	valor = util.roundFieldValue(valor, tablaRed, campoRed);

	return valor;
}

function oficial_totalAlmacen(nodo:FLDomNode, campo:String)
{
	var valor= this.iface.totalAlmacen_;
	if (campo == "reiniciar") {
		this.iface.totalAlmacen_ = 0;
	}
	return valor;
}

function oficial_totalInforme(nodo:FLDomNode, campo:String)
{
	var valor= this.iface.totalInforme_;
	return valor;
}

function oficial_iniciarTotales(nodo:FLDomNode, campo:String)
{
	this.iface.totalAlmacen_ = 0;
	this.iface.totalInforme_ = 0;
}

function oficial_dameCantidad(nodo, campo)
{
debug("oficial_dameCantidad");
	var _i = this.iface;
	var cantidad;
debug("DIA s = " + flfactinfo.iface.diaInv_);
	if (flfactinfo.iface.diaInv_) {
debug("fecha = s " + flfactinfo.iface.diaInv_);
		if (!_i.curStock_) {
			_i.curStock_ = new FLSqlCursor("stocks");
			_i.curStock_.setModeAccess(_i.curStock_.Insert);
			_i.curStock_.refreshBuffer();
		}
		_i.curStock_.setValueBuffer("referencia", nodo.attributeValue("stocks.referencia"));
		_i.curStock_.setValueBuffer("codalmacen", nodo.attributeValue("almacenes.codalmacen"));
		_i.curStock_.setValueBuffer("idstock", nodo.attributeValue("stocks.idstock"));
		var oP = formRecordregstocks.iface.pub_dameParamStock();
		oP.fechaMax = flfactinfo.iface.diaInv_;
		_i.cantidad_ = formRecordregstocks.iface.pub_commonCalculateField("cantidad", _i.curStock_, oP);
	} else {
		_i.cantidad_ = nodo.attributeValue("stocks.cantidad");
	}
	return _i.cantidad_;
}

/** \D Obtiene un array con los parámetros necesarios para establecer el informe
@return	array de parámetros o false si hay error
\end */
function oficial_obtenerParamInforme()
{
	var cursor= this.cursor();
	var seleccion= cursor.valueBuffer("id");
	if (!seleccion) {
		return;
	}
	var paramInforme = flfactinfo.iface.pub_dameParamInforme();
	paramInforme.nombreInforme = cursor.action();
	paramInforme.whereFijo = "articulos.nostock <> true";
	if (!cursor.valueBuffer("incluirsinstock")) {
		paramInforme.whereFijo += " AND stocks.cantidad <> 0";
	}
	paramInforme.orderBy = "";
	var o= "";
	for (var i= 1; i < 3; i++) {
		o = this.iface.obtenerOrden(i, cursor);
		if (o) {
			if (paramInforme.orderBy == "") {
				paramInforme.orderBy = o;
			} else {
				paramInforme.orderBy += ", " + o;
			}
		}
	}
	
	return paramInforme;
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
