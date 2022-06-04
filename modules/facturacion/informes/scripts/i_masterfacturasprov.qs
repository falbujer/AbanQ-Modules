/***************************************************************************
                 i_masterfacturasprov.qs  -  description
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
    function oficial( context ) { interna( context ); } 
	function lanzar() {
		return this.ctx.oficial_lanzar();
	}
	function obtenerParamInforme() {
		return this.ctx.oficial_obtenerParamInforme();
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
	if (!pI)
		return;

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
		paramInforme.nombreInforme = "i_acufacturasprov";
		paramInforme.orderBy = cursor.valueBuffer("ordenacu") == "ASC" ? "SUM(facturasprov.neto*facturasprov.tasaconv) ASC" : "SUM(facturasprov.neto*facturasprov.tasaconv) DESC";
		paramInforme.groupBy = "facturasprov.codproveedor, proveedores.nombre, empresa.nombre, empresa.cifnif, empresa.direccion, empresa.codpostal, empresa.ciudad, empresa.provincia, empresa.apartado, empresa.codpais, empresa.coddivisa";
		if (!cursor.isNull("limiteacu")) {
			paramInforme.limit = cursor.valueBuffer("limiteacu");
		}
	} else {
		paramInforme.nombreInforme = cursor.action();

		if(paramInforme.nombreInforme == "i_resfacturasprov") {
			switch(cursor.valueBuffer("tipoinforme")) {
				case "Euros": {
					paramInforme.nombreInforme = "i_resfacturasproveuros";
					break;
				}
				case "Moneda original y euros": {
					paramInforme.nombreInforme = "i_resfacturasprovtotaleuros";
					break;
				}
			}
		}

		paramInforme.orderBy = "";
		var o= "";
		for (var i= 1; i < 3; i++) {
			o = formi_albaranesprov.iface.pub_obtenerOrden(i, cursor, "facturasprov");
			if (o) {
				if (paramInforme.orderBy == "")
					paramInforme.orderBy = o;
				else
					paramInforme.orderBy += ", " + o;
			}
		}
	}
		
	
	var intervalo= [];
	if(cursor.valueBuffer("codintervalo")){
		intervalo = flfactppal.iface.pub_calcularIntervalo(cursor.valueBuffer("codintervalo"));
		cursor.setValueBuffer("d_facturasprov_fecha",intervalo.desde);
		cursor.setValueBuffer("h_facturasprov_fecha",intervalo.hasta);
	}
		
	var where= "";
	if (cursor.valueBuffer("deabono")) {
		where = "facturasprov.deabono";
	}
	if (cursor.valueBuffer("filtrarimportes")) {
		if (!cursor.isNull("desdeimporte")) {
			if (where != "") {
				where += " AND ";
			}
			where += "facturasprov.total >= " + cursor.valueBuffer("desdeimporte");
		}
		if (!cursor.isNull("hastaimporte")) {
			if (where != "") {
				where += " AND ";
			}
			where += "facturasprov.total <= " + cursor.valueBuffer("hastaimporte");
		}
	}
	paramInforme.whereFijo = where;
	
	return paramInforme;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
