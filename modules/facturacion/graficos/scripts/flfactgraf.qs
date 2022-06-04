/***************************************************************************
                 flfactgraf.qs  -  description
                             -------------------
    begin                : jue oct 6 2005
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
////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/** @class_declaration interna */
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
	function lanzarGrafico( cursor:FLSqlCursor, nombreInforme:String, orderBy:String, groupBy:String ) {
		return this.ctx.oficial_lanzarGrafico(cursor, nombreInforme, orderBy, groupBy);
	}
	function prepararConsultaInforme( cursor:FLSqlCursor, nombreInforme:String, orderBy:String, groupBy:String ):FLSqlQuery {
		return this.ctx.oficial_prepararConsultaInforme(cursor, nombreInforme, orderBy, groupBy);
	}
	function sqlConsultaInforme( cursor:FLSqlCursor, nombreInforme:String, orderBy:String, groupBy:String ):String {
		return this.ctx.oficial_sqlConsultaInforme( cursor, nombreInforme, orderBy, groupBy );
	}
	function obtenerSigno(s:String):String {
		return this.ctx.oficial_obtenerSigno(s);
	}
	function fieldName(s:String):String {
		return this.ctx.oficial_fieldName(s);
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
	function pub_lanzarGrafico( cursor:FLSqlCursor, nombreInforme:String, orderBy:String, groupBy:String ) {
		return this.lanzarGrafico( cursor, nombreInforme, orderBy, groupBy );
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
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_lanzarGrafico( cursor:FLSqlCursor, nombreInforme:String, orderBy:String, groupBy:String )
{
	var q:FLSqlQuery = this.iface.prepararConsultaInforme(cursor, nombreInforme, orderBy);

	var campos:Array = q.select().split( "," );
	var util:FLUtil = new FLUtil();

	var coorX:String = Input.getItem( "Coordenada X", campos, campos[0], false, "Coordenada X" );
	if (!coorX)
		return;
	coorX = coorX.replace( " ", "" );
	var compX:Array = coorX.split( "." );
	var tipoX:Number = util.fieldType( compX[1], compX[0] );
	var esFechaX:Boolean = false;
	if ( tipoX == 26 )
		esFechaX = true;

	var coorY:String = Input.getItem( "Coordenada Y", campos, campos[0], false, "Coordenada Y" );
	if(!coorY)
		return;
	coorY = coorY.replace( " ", "" );
	var compY:Array = coorY.split( "." );
	var tipoY:Number = util.fieldType( compY[1], compY[0] );
	var esFechaY:Boolean = false;
	if ( tipoY == 26 )
		esFechaY = true;

	if ( q.exec() ) {
		if ( q.size() > 0 ) {
			var stdin:String, datos:String;
			var fechaInicioX:String, fechaFinX:String, fechaInicioY:String, fechaFinY:String;

			if ( esFechaX || esFechaY ) {
				q.first();

				if ( esFechaX )
					fechaInicioX = util.dateAMDtoDMA( q.value( coorX ) );
				else
					fechaInicioX = q.value( coorX );

				if ( esFechaY )
					fechaInicioY = util.dateAMDtoDMA( q.value( coorY ) );
				else
					fechaInicioY = q.value( coorY );

				datos = fechaInicioX + " " + fechaInicioY + "\n";

				q.last();

				if ( esFechaX )
					fechaFinX = util.dateAMDtoDMA( q.value( coorX ) );

				if ( esFechaY )
					fechaFinY = util.dateAMDtoDMA( q.value( coorY ) );

				q.first();
			}

			var tempX:String, tempY:String;
			while ( q.next() ) {
				if ( esFechaX )
					tempX = util.dateAMDtoDMA( q.value( coorX ) );
				else
					tempX = q.value( coorX );

				if ( esFechaY )
					tempY = util.dateAMDtoDMA( q.value( coorY ) );
				else
					tempY = q.value( coorY );

				datos += tempX + " " + tempY + "\n";
			}

			stdin =  "set title \"" + nombreInforme + "\"";
			if ( esFechaX ) {
				stdin += "\nset xdata time";
				stdin += "\nset timefmt \"\%d-\%m-\%Y\"";
				stdin += "\nset xrange [\"" + fechaInicioX + "\" : \"" + fechaFinX + "\"]";
				stdin += "\nset format x \"\%d-\%m\"";
			}
			if ( esFechaY ) {
				stdin += "\nset ydata time";
				stdin += "\nset timefmt \"\%d-\%m-\%Y\"";
				stdin += "\nset yrange [\"" + fechaInicioY + "\" : \"" + fechaFinY +"\"]";
				stdin += "\nset format y \"\%d-\%m\"";
			}
			stdin += "\nset xlabel \"" + coorX + "\"";
			stdin += "\nset ylabel \"" + coorY + "\"";
			stdin += "\nset grid";
			stdin += "\nplot '-' using 1:2 t '' with line smoot bezier, '-' using 1:2 t '' with impulses\n";
			stdin += datos;
			stdin += "\ne\n"
			stdin += datos;

			Process.execute( ["gnuplot","-persist"], stdin);
		}
	}
}

function oficial_prepararConsultaInforme( cursor:FLSqlCursor, nombreInforme:String, orderBy:String, groupBy:String ):FLSqlQuery
{
	var q:FLSqlQuery = new FLSqlQuery(nombreInforme);

	var util:FLUtil = new FLUtil();
	var fieldList:String = util.nombreCampos(cursor.table());
	var cuenta:Number = parseFloat(fieldList[0]);

	var signo:String;
	var fN:String;
	var valor:String;
	var primerCriterio:Boolean = false;
	var where:String = "";
	for (var i:Number = 1; i <= cuenta; i++) {
		if (cursor.isNull(fieldList[i]))
			continue;
		signo = this.iface.obtenerSigno(fieldList[i]);
		if (signo != "") {
			fN = this.iface.fieldName(fieldList[i]);
			valor = cursor.valueBuffer(fieldList[i]);
			if (valor == "Sí")
				valor = 1;
			if (valor == "No")
				valor = 0;
			if (valor == "Todos")
				valor = "";
			if (!valor.toString().isEmpty()) {
				if (primerCriterio == true)
					where += "AND ";
				where += fN + " " + signo + " '" + valor + "' ";
				primerCriterio = true;
			}
		}
	}

	q.setWhere(where);

	if (q.exec() == false) {
		MessageBox.critical(util.translate("scripts", "Falló la consulta"),
			MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return q;
	} else {
		if (q.first() == false) {
			MessageBox.warning(util.translate("scripts",
				"No hay registros que cumplan los criterios de búsqueda establecidos"),
				MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return q;
		}
	}

	if (orderBy)
		q.setOrderBy(orderBy);

	return q;
}

function oficial_sqlConsultaInforme( cursor:FLSqlCursor, nombreInforme:String, orderBy:String, groupBy:String ):String
{
	var q:FLSqlQuery = this.iface.prepararConsultaInforme(cursor, nombreInforme, orderBy);

	return q.sql();
}

/** \D
Obtiene el operador lógico a aplicar en la cláusula where de la consulta a partir de los primeros caracteres del parámetro
@param	s: Nombre del campo que contiene un criterio de búsqueda
@return	Operador lógico a aplicar
*/
function oficial_obtenerSigno(s:String):String
{
	if (s.toString().charAt(1) == "_") {
		switch(s.toString().charAt(0)) {
			case "d": {
				return ">=";
			}
			case "h": {
				return "<=";
			}
			case "i": {
				return "=";
			}
		}
	}
	return  "";
}

/** \D
Obtiene el nombre del campo de la cadena s desde su segunda posición. Sustituye '_' por '.', dos '_" seguidos indica que realmente es '_"
@param	s: Nombre del campo que contiene un criterio de búsqueda
@return	Nombre procesado
*/
function oficial_fieldName(s:String):String
{
	var fN:String = "";
	var c:String;
	for (var i:Number = 2; (s.toString().charAt(i)); i++) {
		c = s.toString().charAt(i);
		if (c == "_")
			if (s.toString().charAt(i + 1) == "_") {
				fN += "_";
				i++;
			} else
				fN += "."
		else
			fN += s.toString().charAt(i);
	}
	return fN;
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

