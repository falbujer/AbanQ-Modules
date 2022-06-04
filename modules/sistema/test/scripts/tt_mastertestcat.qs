/***************************************************************************
                 tt_mastertestcat.qs  -  description
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
    function init() { this.ctx.interna_init(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var tbnCopy:Object;
	var tdbRecords:FLTableDB;

    function oficial( context ) { interna( context ); } 
	function tbnCopy_clicked() {
		return this.ctx.oficial_tbnCopy_clicked();
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

function interna_init()
{
	this.iface.tbnCopy = this.child("toolButtonCopy");
	this.iface.tdbRecords = this.child("tableDBRecords");
	connect (this.iface.tbnCopy, "clicked()", this, "iface.tbnCopy_clicked");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D Copia la prueba seleccionada
\end */
function oficial_tbnCopy_clicked()
{
	var cursor:FLSqlCursor = form.cursor();

	var previousIdTestCat:String = cursor.valueBuffer("id");
	var util:FLUtil = new FLUtil();
	var codTestCat:String = util.nextCounter("codtestcat", cursor);

	var funcional:String = fltestppal.iface.pub_obtenerIdFuncional();
	funcional = Input.getText(util.translate("scripts", "Funcionalidad de la copia"), funcional);
	if (!funcional)
		return;
		
	var curTest:FLSqlCursor = new FLSqlCursor("tt_testcat");
	curTest.transaction(false);
	with(curTest) {
		setModeAccess(curTest.Insert);
		refreshBuffer();
		setValueBuffer("codtestcat", codTestCat);
		setValueBuffer("description", cursor.valueBuffer("description"));
		setValueBuffer("idfuncional", funcional);
		setValueBuffer("parameters", cursor.valueBuffer("parameters"));
		setValueBuffer("longdesc", cursor.valueBuffer("longdesc"));
	}
	if (!curTest.commitBuffer()) {
		curTest.rollback();
		return;
	}
	var idTestCat:String = curTest.valueBuffer("id");

	var qryStep:FLSqlQuery = new FLSqlQuery();
	qryStep.setTablesList("tt_stepcat");
	qryStep.setSelect("stepnumber, description, container, idobjecttype, objectname, idaction, parameters,  idarea, idmodule, formtype, pbaccept");
	qryStep.setFrom("tt_stepcat");
	qryStep.setWhere("idtestcat = '" + previousIdTestCat + "';");
	if (!qryStep.exec()) {
		curTest.rollback();
		return;
	}

	var curStep:FLSqlCursor = new FLSqlCursor("tt_stepcat");
	while(qryStep.next()) {
		with(curStep) {
			setModeAccess(curStep.Insert);
			refreshBuffer();
			setValueBuffer("idtestcat", idTestCat);
			setValueBuffer("stepnumber", qryStep.value(0));
			setValueBuffer("description", qryStep.value(1));
			setValueBuffer("container", qryStep.value(2));
			setValueBuffer("idobjecttype", qryStep.value(3));
			setValueBuffer("objectname", qryStep.value(4));
			setValueBuffer("idaction", qryStep.value(5));
			setValueBuffer("parameters", qryStep.value(6));
			setValueBuffer("idarea", qryStep.value(7));
			setValueBuffer("idmodule", qryStep.value(8));
			setValueBuffer("formtype", qryStep.value(9));
			setValueBuffer("pbaccept", qryStep.value(10));
		}
		if (!curStep.commitBuffer()) {
			curTest.rollback();
			return;
		}
	}
	curTest.commit();
	this.iface.tdbRecords.refresh();
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
