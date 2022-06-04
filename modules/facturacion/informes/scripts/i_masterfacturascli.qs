/***************************************************************************
                 i_masterfacturascli.qs  -  description
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
    function oficial( context ) { interna( context ); } 
	function lanzar() {
		return this.ctx.oficial_lanzar();
	}
	function obtenerParamInforme() {
		return this.ctx.oficial_obtenerParamInforme();
	}
	function facturaRectificada(nodo:FLDomNode, campo:String) {
		return this.ctx.oficial_facturaRectificada(nodo,campo);
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
	function pub_facturaRectificada(nodo:FLDomNode, campo:String) {
		return this.facturaRectificada(nodo, campo);
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
	var cursor= this.cursor();
	var pI = this.iface.obtenerParamInforme();
	if (!pI) {
		return;
	}

	flfactinfo.iface.pub_lanzaInforme(cursor, pI);
}

/** \D Obtiene un array con los parámetros necesarios para establecer el informe
@return	array de parámetros o false si hay error
\end */
function oficial_obtenerParamInforme()
{
	var cursor= this.cursor();
	var seleccion= cursor.valueBuffer("id");
	if (!seleccion) {
		return false;
	}
	var paramInforme = flfactinfo.iface.pub_dameParamInforme();
	
	if (cursor.valueBuffer("acumulado")) {
		paramInforme.nombreInforme = "i_acufacturascli";
		paramInforme.orderBy = cursor.valueBuffer("ordenacu") == "ASC" ? "SUM(facturascli.neto*facturascli.tasaconv) ASC" : "SUM(facturascli.neto*facturascli.tasaconv) DESC";
		paramInforme.groupBy = "facturascli.codcliente, clientes.nombre, empresa.nombre, empresa.cifnif, empresa.direccion, empresa.codpostal, empresa.ciudad, empresa.provincia, empresa.apartado, empresa.codpais, empresa.coddivisa";
		if (!cursor.isNull("limiteacu")) {
			paramInforme.limit = cursor.valueBuffer("limiteacu");
		}
	} else {
		paramInforme.nombreInforme = cursor.action();
		paramInforme.orderBy = "";
		var o= "";
		for (var i= 1; i < 3; i++) {
			o = formi_albaranescli.iface.pub_obtenerOrden(i, cursor, "facturascli");
			if (o) {
				if (paramInforme.orderBy == "")
					paramInforme.orderBy = o;
				else
					paramInforme.orderBy += ", " + o;
			}
		}
	}
	
	if (paramInforme.nombreInforme == "i_facturascli" || paramInforme.nombreInforme == "i_facturascli_auto") {
		if (paramInforme.orderBy) {
			paramInforme.orderBy += ",";
		}
		paramInforme.orderBy += " lineasfacturascli.idalbaran, lineasfacturascli.referencia, lineasfacturascli.idlinea";
	}
	
	if (cursor.valueBuffer("codintervalo")) {
		var intervalo= [];
		intervalo = flfactppal.iface.pub_calcularIntervalo(cursor.valueBuffer("codintervalo"));
		cursor.setValueBuffer("d_facturascli_fecha", intervalo.desde);
		cursor.setValueBuffer("h_facturascli_fecha", intervalo.hasta);
	}

	var where= "";
	if (cursor.valueBuffer("deabono")) {
		where = "facturascli.deabono";
	}
	if (cursor.valueBuffer("filtrarimportes")) {
		if (!cursor.isNull("desdeimporte")) {
			if (where != "") {
				where += " AND ";
			}
			where += "facturascli.total >= " + cursor.valueBuffer("desdeimporte");
		}
		if (!cursor.isNull("hastaimporte")) {
			if (where != "") {
				where += " AND ";
			}
			where += "facturascli.total <= " + cursor.valueBuffer("hastaimporte");
		}
	}
	paramInforme.whereFijo = where;
	
	return paramInforme;
}

function oficial_facturaRectificada(nodo:FLDomNode, campo:String)
{
	var util= new FLUtil;
	var idFacturaRect= nodo.attributeValue("facturascli.idfacturarect");
	var coFacturaRect= util.sqlSelect("facturascli", "codigo", "idfactura = " + idFacturaRect);
	if (coFacturaRect)
		return util.translate("scripts", "**** Rectifica a la factura %1 ****").arg(coFacturaRect);
	else
		return "";
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
