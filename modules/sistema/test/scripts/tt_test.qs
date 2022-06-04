/***************************************************************************
                 tt_test.qs  -  description
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
////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
class interna {
    var ctx:Object;
    function interna( context ) { this.ctx = context; }
	function init() {
		return this.ctx.interna_init(); 
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var tblPasos:QTable;
	
	function oficial( context ) { interna( context ); } 
	function buscar() { 
		return this.ctx.oficial_buscar();
	} 
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends oficial {
    function head( context ) { oficial ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
    function ifaceCtx( context ) { head( context ); }
}

const iface = new ifaceCtx( this );
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
/** \C El formulario muestra un resumen de los pasos que se realizaron para la prueba seleccionada, mostrando el estado de cada uno de ellos
\end */
function interna_init()
{
	this.iface.tblPasos = this.child("tblPasos");
	
	var util:FLUtil = new FLUtil();
	
	this.iface.tblPasos.setNumCols(6);
	this.iface.tblPasos.setColumnWidth(0, 60);
	this.iface.tblPasos.setColumnWidth(1, 130);
	this.iface.tblPasos.setColumnWidth(2, 60);
	this.iface.tblPasos.setColumnWidth(3, 130);
	this.iface.tblPasos.setColumnWidth(4, 80);
	this.iface.tblPasos.setColumnWidth(5, 100);
	this.iface.tblPasos.setColumnLabels("/", "Prueba/Descripción/Paso/Descripción/Estado/Descripcion");
	
	this.iface.buscar();
}

/** \D Busca los datos de los pasos correspondientes a la prueba seleccionada
*/
function oficial_buscar()
{
	var cursor:FLSqlCursor = this.cursor();

	var q:FLSqlQuery = new FLSqlQuery;
	q.setTablesList("tt_step,tt_test,tt_stepcat,tt_testcat");
	q.setSelect("tc.codtestcat, tc.description, sc.stepnumber, sc.description, s.status,s.errordescription");
	q.setFrom("tt_test t INNER JOIN tt_step s on t.idtest = s.idtest INNER JOIN tt_stepcat sc ON s.idstepcat = sc.idstepcat INNER JOIN tt_testcat tc ON sc.idtestcat = tc.id");
	q.setWhere("t.idtest = " + cursor.valueBuffer("idtest") + " ORDER BY s.idstep");
	if (!q.exec())
		return;
	var numFila:Number;
	while (q.next()) {
		numFila = this.iface.tblPasos.numRows();
		with(this.iface.tblPasos) {
			insertRows(numFila);
			setText(numFila, 0, q.value(0));
			setText(numFila, 1, q.value(1));
			setText(numFila, 2, q.value(2));
			setText(numFila, 3, q.value(3));
			setText(numFila, 4, q.value(4));
			setText(numFila, 5, q.value(5));
		}
	}
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////

//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
