/***************************************************************************
                 tt_tcatscat.qs  -  description
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
	var tbnUp:Object;
	var tbnDown:Object;
	var tdbTests:FLTableDB;
	
	function oficial( context ) { interna( context ); } 
	function tbnUp_clicked() {
		return this.ctx.oficial_tbnUp_clicked();
	}
	function tbnDown_clicked() {
		return this.ctx.oficial_tbnDown_clicked();
	}
	function moveStep(direction:Number) {
		return this.ctx.oficial_moveStep(direction);
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
/** \C Al crear una nueva sesión, el valor de la funcionalidad por defecto es el de la funcionalidad actual
\end */ 
function interna_init() 
{
	this.iface.tbnUp = this.child("toolButtonUp"); 
	this.iface.tbnDown = this.child("toolButtonDown");
	this.iface.tdbTests = this.child("tdbTests");
	
	connect (this.iface.tbnUp, "clicked()", this, "iface.tbnUp_clicked");
	connect (this.iface.tbnDown, "clicked()", this, "iface.tbnDown_clicked");
	
	var cursor:FLSqlCursor = this.cursor();
	if (cursor.modeAccess() == cursor.Insert)
		this.child("fdbIdFuncional").setValue(fltestppal.iface.pub_obtenerIdFuncional());
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D Desplaza la prueba seleccionada hacia arriba (antes) en el orden de ejecución
*/
function oficial_tbnUp_clicked()
{
	this.iface.moveStep(-1);
}

/** \D Desplaza la prueba seleccionada hacia abajo (después) en el orden de ejecución
*/
function oficial_tbnDown_clicked()
{
	this.iface.moveStep(1);
}

/** \D Mueve la prueba seleccionada una posición en el orden de ejecución

@param	direction: Sentido en el cual se mueve la prueba: -1 hacia arriba (antes), 1 hacia abajo (después)
*/
function oficial_moveStep(direction:Number)
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.iface.tdbTests.cursor();
	var idSessionCat:String = cursor.valueBuffer("idsessioncat");
	var testNumber:Number = cursor.valueBuffer("testnumber");
	var testNumber2:Number;
	var row:Number = this.iface.tdbTests.currentRow();

	if (direction == -1)
		testNumber2 = util.sqlSelect("tt_tcatscat", "testnumber", "idsessioncat = '" + idSessionCat + "' AND testnumber < " + testNumber + " ORDER BY testnumber DESC");
	else
		testNumber2 = util.sqlSelect("tt_tcatscat", "testnumber", "idsessioncat = '" + idSessionCat + "' AND testnumber > " + testNumber + " ORDER BY testnumber");

	if (!testNumber2)
		return;

	var curTest:FLSqlCursor = new FLSqlCursor("tt_tcatscat");
	curTest.select("testnumber = '" + testNumber2
			+ "' AND idsessioncat = '" + idSessionCat + "'");
	if (!curTest.first())
		return;

	curTest.setModeAccess(curTest.Edit);
	curTest.refreshBuffer();
	curTest.setValueBuffer("testnumber", "-1");
	curTest.commitBuffer();

	cursor.setModeAccess(cursor.Edit);
	cursor.refreshBuffer();
	cursor.setValueBuffer("testnumber", testNumber2);
	cursor.commitBuffer();

	curTest.setModeAccess(curTest.Edit);
	curTest.refreshBuffer();
	curTest.setValueBuffer("testnumber", testNumber);
	curTest.commitBuffer();

	this.iface.tdbTests.refresh();
	row += direction;
	this.iface.tdbTests.setCurrentRow(row);
}

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
