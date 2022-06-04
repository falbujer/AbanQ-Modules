/***************************************************************************
                 i_masteralbaranescli.qs  -  description
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
	function obtenerOrden(nivel:Number, cursor:FLSqlCursor, tabla:String) {
		return this.ctx.oficial_obtenerOrden(nivel, cursor, tabla);
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
		function pub_obtenerOrden(nivel:Number, cursor:FLSqlCursor, tabla:String) {
				return this.obtenerOrden(nivel, cursor, tabla);
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

/** \D Obtiene un array con los par�metros necesarios para establecer el informe
@return	array de par�metros o false si hay error
\end */
function oficial_obtenerParamInforme()
{
	var cursor= this.cursor();
	var seleccion= cursor.valueBuffer("id");
	if (!seleccion) {
		return false;
	}
	var paramInforme = flfactinfo.iface.pub_dameParamInforme();
	paramInforme.nombreInforme = cursor.action();
	paramInforme.orderBy = "";
	var o= "";
	for (var i= 1; i < 3; i++) {
		o = formi_albaranescli.iface.pub_obtenerOrden(i, cursor, "albaranescli");
		if (o) {
			if (paramInforme.orderBy == "")
				paramInforme.orderBy = o;
			else
				paramInforme.orderBy += ", " + o;
		}
	}
	
	var intervalo= [];
	if (cursor.valueBuffer("codintervalo")) {
		intervalo = flfactppal.iface.pub_calcularIntervalo(cursor.valueBuffer("codintervalo"));
		cursor.setValueBuffer("d_albaranescli_fecha",intervalo.desde);
		cursor.setValueBuffer("h_albaranescli_fecha",intervalo.hasta);
	}
	
	return paramInforme;
}

function oficial_obtenerOrden(nivel:Number, cursor:FLSqlCursor, tabla:String)
{
	var ret= "";
	var orden= cursor.valueBuffer("orden" + nivel.toString());
	switch(nivel) {
		case 1:
		case 2: {
			switch(orden) {
				case "C�digo": {
					ret += tabla + ".codigo";
					break;
				}
				case "Cod.Cliente": {
					ret += tabla + ".codcliente";
					break;
				}
				case "Cliente": {
					ret += tabla + ".nombrecliente";
					break;
				}
				case "Fecha": {
					ret += tabla + ".fecha";
					break;
				}
				case "Total": {
					ret += tabla + ".total";
					break;
				}
			}
			break;
		}
		break;
	}
// 	if (ret != "") {
// 		var tipoOrden= cursor.valueBuffer("tipoorden" + nivel.toString());
// 		switch(tipoOrden) {
// 			case "Descendente": {
// 				ret += " DESC";
// 				break;
// 			}
// 			default: {
// 				ret += " ASC";
// 				break;
// 			}
// 		}
// 	}

	if (nivel == 2 && cursor.valueBuffer("orden1") != "C�digo" && cursor.valueBuffer("orden2") != "C�digo") {
		if (ret == "") {
// 			ret += tabla + ".codigo ASC";
			ret += tabla + ".codigo";
		} else {
// 			ret += ", " + tabla + ".codigo ASC";
			ret += ", " + tabla + ".codigo";
		}
	}

	return ret;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
