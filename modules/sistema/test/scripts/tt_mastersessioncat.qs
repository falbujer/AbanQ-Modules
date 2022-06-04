/***************************************************************************
                 tt_mastersessioncat.qs  -  description
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
	var tbnExec:Object;
	var tbnToTest:Object;
	var tdbRecords:FLTableDB;
	var idStep:Number;
	var idTest:Number;

    function oficial( context ) { interna( context ); } 
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends oficial {
    function head( context ) { oficial ( context ); }
	function tbnCopy_clicked() {
		return this.ctx.oficial_tbnCopy_clicked();
	}
	function tbnToTest_clicked() {
		return this.ctx.oficial_tbnToTest_clicked();
	}
	function tbnExec_clicked() {
		return this.ctx.oficial_tbnExec_clicked();
	}
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
	this.iface.tbnExec = form.child("toolButtonExec");
	this.iface.tbnCopy = form.child("toolButtonCopy");
	this.iface.tbnToTest = form.child("toolButtonToTest");
	this.iface.tdbRecords = form.child("tableDBRecords");

	this.iface.idStep = 0;
	this.iface.idTest = 0;

	connect (this.iface.tbnCopy, "clicked()", this, "iface.tbnCopy_clicked");
	connect (this.iface.tbnToTest, "clicked()", this, "iface.tbnToTest_clicked");
	connect (this.iface.tbnExec, "clicked()", this, "iface.tbnExec_clicked");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D Copia la sesión seleccionada
\end */
function oficial_tbnCopy_clicked()
{
	var util = new FLUtil();
	var cursor:FLSqlCursor = form.cursor();
	var previousIdSessionCat:String = cursor.valueBuffer("id");
	var codSessionCat:String = util.nextCounter("codsessioncat", cursor);

	var curSession:FLSqlCursor = new FLSqlCursor("tt_sessioncat");
	curSession.transaction(false);
	with(curSession) {
		setModeAccess(curSession.Insert);
		refreshBuffer();
		setValueBuffer("codsessioncat", codSessionCat);
		setValueBuffer("idfuncional", cursor.valueBuffer("idfuncional"));
		setValueBuffer("description", cursor.valueBuffer("description"));
	}
	if (!curSession.commitBuffer()) {
		curSession.rollback();
		return;
	}
	var idSessionCat:String = curSession.valueBuffer("id");

	var qryTest:FLSqlQuery = new FLSqlQuery();
	qryTest.setTablesList("tt_tcatscat");
	qryTest.setSelect("testnumber, idtestcat, codtestcat, codsessioncat, description, repeat, idfuncional, parameters");
	qryTest.setFrom("tt_tcatscat");
	qryTest.setWhere("idsessioncat = " + previousIdSessionCat);
	if (!qryTest.exec()) {
		curSession.rollback();
		return;
	}

	var curTest:FLSqlQuery = new FLSqlCursor("tt_tcatscat");
	while(qryTest.next()) {
		with(curTest) {
			setModeAccess(curTest.Insert);
			refreshBuffer();
			setValueBuffer("idsessioncat", idSessionCat);
			setValueBuffer("testnumber", qryTest.value(0));
			setValueBuffer("idtestcat", qryTest.value(1));
			setValueBuffer("codtestcat", qryTest.value(2));
			setValueBuffer("codsessioncat", qryTest.value(3));
			setValueBuffer("description", qryTest.value(4));
			setValueBuffer("repeat", qryTest.value(5));
			setValueBuffer("idfuncional", qryTest.value(6));
			setValueBuffer("parameters", qryTest.value(7));
		}
		if (!curTest.commitBuffer()) { 
			curSession.rollback();
			return;
		}
	}
	curSession.commit();
	this.iface.tdbRecords.refresh();
}

/** \D Convierte la sesión seleccionada en una prueba compuesta por pasos de tipo 'Ejecutar prueba'
\end */
function oficial_tbnToTest_clicked()
{
	var util = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	if (!cursor.isValid())
		return;
		
	var idSessionCat:String = cursor.valueBuffer("id");
	
	var funcional:String = fltestppal.iface.pub_obtenerIdFuncional();
	funcional = Input.getText(util.translate("scripts", "Funcionalidad de la prueba"), funcional);
	if (!funcional)
		return;
		
	var curTest:FLSqlCursor = new FLSqlCursor("tt_testcat");
	var codTestCat:String = util.nextCounter("codtestcat", curTest);

	curTest.transaction(false);
	with(curTest) {
		setModeAccess(curTest.Insert);
		refreshBuffer();
		setValueBuffer("codtestcat", codTestCat);
		setValueBuffer("idfuncional", funcional);
		setValueBuffer("description", cursor.valueBuffer("description"));
	}
	if (!curTest.commitBuffer()) {
		curTest.rollback();
		return;
	}
	var idTestCat:String = curTest.valueBuffer("id");

	var qrySessionTests:FLSqlQuery = new FLSqlQuery();
	qrySessionTests.setTablesList("tt_tcatscat");
	qrySessionTests.setSelect("codtestcat, idfuncional, description, parameters");
	qrySessionTests.setFrom("tt_tcatscat");
	qrySessionTests.setWhere("idsessioncat = " + idSessionCat + " ORDER BY testnumber");
	if (!qrySessionTests.exec()) {
		curTest.rollback();
		return;
	}

	var curStep:FLSqlQuery = new FLSqlCursor("tt_stepcat");
	var stepNumber:Number = 1;
	while(qrySessionTests.next()) {
		with(curStep) {
			setModeAccess(curStep.Insert);
			refreshBuffer();
			setValueBuffer("idtestcat", idTestCat);
			setValueBuffer("stepnumber", stepNumber++);
			setValueBuffer("codtestcat", codTestCat);
			setValueBuffer("description", qrySessionTests.value(2));
			setValueBuffer("idobjecttype", "Test");
			setValueBuffer("objectname", "<FLTest:Test codtest=\"" + qrySessionTests.value(0) + "\" idfuncional=\"" + qrySessionTests.value(1) + "\"/>");
			setValueBuffer("idaction", "execTest");
			setValueBuffer("parameters", qrySessionTests.value(3));
		}
		if (!curStep.commitBuffer()) {
			curTest.rollback();
			return;
		}
	}
	curTest.commit();
	this.iface.tdbRecords.refresh();
}

/** \D Ejecuta la sesión seleccionada
\end */
function oficial_tbnExec_clicked()
{
	var codSessionCat:String = this.cursor().valueBuffer("codsessioncat");
	if (!codSessionCat)
		return;
	var idFuncional:String = this.cursor().valueBuffer("idfuncional");
		
	sys.startTest(codSessionCat, idFuncional);
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
