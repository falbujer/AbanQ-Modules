/***************************************************************************
                 tt_testcat.qs  -  description
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
	var tbnUp:Object;
	var tbnDown:Object;
	var tbnCopy:Object;
	var tbnAuto:Object;
	var tbnPruebas:Object;
	var tbnParameters:Object;
	var tdbSteps:FLTableDB;
	var tblPruebasInc:QTable;

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
	function tbnCopy_clicked() {
		return this.ctx.oficial_tbnCopy_clicked();
	}
	function tbnAuto_clicked() {
		return this.ctx.oficial_tbnAuto_clicked();
	}
	function tbnPruebas_clicked() {
		return this.ctx.oficial_tbnPruebas_clicked();
	}
	function predefinido_afe() {
		return this.ctx.oficial_predefinido_afe();
	}
	function predefinido_cfe() {
		return this.ctx.oficial_predefinido_cfe();
	}
	function predefinido_are() {
		return this.ctx.oficial_predefinido_are();
	}
	function predefinido_cre() {
		return this.ctx.oficial_predefinido_cre();
	}
	function setParameters() {
		return this.ctx.oficial_setParameters();
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
/** \C Al crear una nueva prueba, el valor por defecto de --idfuncional-- será el de la funcionalidad actual
\end */
function interna_init()
{
	this.iface.tbnUp = this.child("toolButtonUp");
	this.iface.tbnDown = this.child("toolButtonDown");
	this.iface.tbnCopy = this.child("toolButtonCopy");
	this.iface.tdbSteps = this.child("tdbSteps");
	this.iface.tbnAuto = this.child("tbnAuto");
	this.iface.tbnPruebas = this.child("tbnPruebas");
	this.iface.tblPruebasInc = this.child("tblPruebasInc");
	this.iface.tbnParameters = this.child("tbnParameters");
	
	connect(this.iface.tbnParameters, "clicked()", this, "iface.setParameters");
	connect (this.iface.tbnUp, "clicked()", this, "iface.tbnUp_clicked");
	connect (this.iface.tbnDown, "clicked()", this, "iface.tbnDown_clicked");
	connect (this.iface.tbnCopy, "clicked()", this, "iface.tbnCopy_clicked");
	connect (this.iface.tbnAuto, "clicked()", this, "iface.tbnAuto_clicked");
	connect (this.iface.tbnPruebas, "clicked()", this, "iface.tbnPruebas_clicked");
	
	this.iface.tblPruebasInc.setNumCols(3);
	this.iface.tblPruebasInc.setColumnWidth(0, 80);
	this.iface.tblPruebasInc.setColumnWidth(1, 60);
	this.iface.tblPruebasInc.setColumnWidth(2, 600);
	this.iface.tblPruebasInc.setColumnLabels("/", "Funcional/Id/Descripción");
	
	var cursor:FLSqlCursor = this.cursor();
	if (cursor.modeAccess() == cursor.Insert)
		this.child("fdbIdFuncional").setValue(fltestppal.iface.pub_obtenerIdFuncional());
	else
		this.iface.tbnPruebas_clicked();
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D Mueve el paso seleccionado hacia arriba (antes) en el orden de ejecución
\end */
function oficial_tbnUp_clicked()
{
	this.iface.moveStep(-1);
}

/** \D Mueve el paso seleccionado hacia abajo (después) en el orden de ejecución
\end */
function oficial_tbnDown_clicked()
{
	this.iface.moveStep(1);
}

/** \D Mueve el paso seleccionado hacia arriba o hacia abajo en función de la dirección

@param	direction: Indica la dirección en la que hay que mover el paso. Valores:
	1: Hacia abajo
	-1: Hacia arriba
\end */
function oficial_moveStep(direction:Number)
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.iface.tdbSteps.cursor();
	var idTestCat:String = cursor.valueBuffer("idtestcat");
	var stepNumber:Number = cursor.valueBuffer("stepnumber");
	var stepNumber2:Number;
	var row:Number = this.iface.tdbSteps.currentRow();

	if (direction == -1)
			stepNumber2 = util.sqlSelect("tt_stepcat", "stepnumber",
				"idtestcat = '" + idTestCat + "' AND stepnumber < " + stepNumber +
				" ORDER BY stepnumber DESC");
	else
			stepNumber2 = util.sqlSelect("tt_stepcat", "stepnumber",
				"idtestcat = '" + idTestCat + "' AND stepnumber > " + stepNumber +
				" ORDER BY stepnumber");

	if (!stepNumber2)
			return;

	var curStep:FLSqlCursor = new FLSqlCursor("tt_stepcat");
	curStep.select("stepnumber = '" + stepNumber2
			+ "' AND idtestcat = '" + idTestCat + "'");
	if (!curStep.first())
			return;

	curStep.setModeAccess(curStep.Edit);
	curStep.refreshBuffer();
	curStep.setValueBuffer("stepnumber", "-1");
	curStep.commitBuffer();

	cursor.setModeAccess(cursor.Edit);
	cursor.refreshBuffer();
	cursor.setValueBuffer("stepnumber", stepNumber2);
	cursor.commitBuffer();

	curStep.setModeAccess(curStep.Edit);
	curStep.refreshBuffer();
	curStep.setValueBuffer("stepnumber", stepNumber);
	curStep.commitBuffer();

	this.iface.tdbSteps.refresh();
	row += direction;
	this.iface.tdbSteps.setCurrentRow(row);
}

/** \D Copia el paso seleccionado
\end */
function oficial_tbnCopy_clicked()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.iface.tdbSteps.cursor();
	if (!cursor.valueBuffer("idstepcat"))
		return;

	var curStep:FLSqlCursor = new FLSqlCursor("tt_stepcat");
	curStep.transaction(false);

	var idTestCat:String = cursor.valueBuffer("idtestcat");
	var stepNumber:Number = util.sqlSelect("tt_stepcat", "stepnumber", "idtestcat = '" + idTestCat + "' ORDER BY stepnumber DESC");
	if (!stepNumber)
		return 0;
	else
		++stepNumber;

	with(curStep) {
		setModeAccess(curStep.Insert);
		refreshBuffer();
		setValueBuffer("idtestcat", idTestCat);
		setValueBuffer("stepnumber", stepNumber);
		setValueBuffer("description", cursor.valueBuffer("description"));
		setValueBuffer("container", cursor.valueBuffer("container"));
		setValueBuffer("idobjecttype", cursor.valueBuffer("idobjecttype"));
		setValueBuffer("objectname", cursor.valueBuffer("objectname"));
		setValueBuffer("idaction", cursor.valueBuffer("idaction"));
		setValueBuffer("parameters", cursor.valueBuffer("parameters"));
		setValueBuffer("idarea", cursor.valueBuffer("idarea"));
		setValueBuffer("idmodule", cursor.valueBuffer("idmodule")); 
		setValueBuffer("formtype", cursor.valueBuffer("formtype"));
		setValueBuffer("pbaccept", cursor.valueBuffer("pbaccept")); 
	}
	if (!curStep.commitBuffer()) {
		curStep.rollback();
		return;
	}
	curStep.commit();
	this.iface.tdbSteps.refresh();
}

/** \D Muestra una lista de los conjuntos de pasos establecidos, para que el usuario seleccione el que desee, y abre el formulario para crear el conjunto seleccionado.
\end */
function oficial_tbnAuto_clicked()
{
	var util:FLUtil = new FLUtil;
	
	if (!this.cursor().commitBuffer())
		return;
	var autos:Array = ["Abrir formulario de edición", "Cerrar formulario de edición","Abrir registro en modo edición","Cerrar registro en modo edición"];
	var name:String = Input.getItem(util.translate("scripts", "Elegir pasos predefinidos"), autos, "Abrir formulario de edición", false, "");
	switch (name) {
		case "Abrir formulario de edición": {
			this.iface.predefinido_afe();
			break;
		}
		case "Cerrar formulario de edición": {
			this.iface.predefinido_cfe();
			break;
		}
		case "Abrir registro en modo edición": {
			this.iface.predefinido_are();
			break;
		}
		case "Cerrar registro en modo edición": {
			this.iface.predefinido_cre();
			break;
		}
	}
}

/** \D Introduce los pasos necesarios para abrir un formulario de edición
*/
function oficial_predefinido_afe()
{
	var util:FLUtil = new FLUtil;
	var idTestCat:Number = this.cursor().valueBuffer("id");
	var stepNumber:Number = 0;
	if (!idTestCat)
		return;
	
	var f:Object = new FLFormSearchDB("tt_step_record");
	var cursor:FLSqlCursor = f.cursor();
	cursor.select();
	if (!cursor.first())
		cursor.setModeAccess(cursor.Insert);
	else
		cursor.setModeAccess(cursor.Edit);
	f.setMainWidget();
	cursor.refreshBuffer();
	
	var curStep:FLSqlCursor = new FLSqlCursor("tt_stepcat");
	curStep.select("idtestcat = " + idTestCat + " ORDER BY stepnumber DESC");
	if (curStep.first()) {
		cursor.setValueBuffer("idarea", curStep.valueBuffer("idarea"));
		cursor.setValueBuffer("idmodule", curStep.valueBuffer("idmodule"));
		stepNumber = parseFloat(curStep.valueBuffer("stepnumber"));
	}
	
	var id:String = f.exec("id");
	if (!id) 
		return;
	
	f.child("gbxVariable").close();
	
	var container:String = cursor.valueBuffer("container");
	var objectName:String = "";
	
	curStep.setModeAccess(curStep.Insert);
	curStep.refreshBuffer();
	curStep.setValueBuffer("idtestcat", idTestCat);
	curStep.setValueBuffer("stepnumber", ++stepNumber);
	curStep.setValueBuffer("description", util.translate("scripts", "Abrir formulario ") + container);
	curStep.setValueBuffer("container", container);
	curStep.setValueBuffer("idobjecttype", "FLFormDB");
	curStep.setValueBuffer("objectname", container);
	curStep.setValueBuffer("idaction", "open");
	curStep.setValueBuffer("idarea", cursor.valueBuffer("idarea"));
	curStep.setValueBuffer("idmodule", cursor.valueBuffer("idmodule"));
	curStep.setValueBuffer("formtype", "form");
	if (!curStep.commitBuffer())
		return;
		
	if (cursor.valueBuffer("mode") != "Insert") {
		curStep.setModeAccess(curStep.Insert);
		curStep.refreshBuffer();
		curStep.setValueBuffer("idtestcat", idTestCat);
		curStep.setValueBuffer("stepnumber", ++stepNumber);
		var llamada:String = fltestppal.getWidgetList("form" + container, "FLTableDB");
		var a:Array = llamada.split("*");
		var name:String = a[0];
		if (!name)
			return;
		objectName = "";
		for (var i:Number = 0; (name.toString().charAt(i) != "/"); i++) {
			objectName += name.toString().charAt(i);
		}
		curStep.setValueBuffer("description", util.translate("scripts", "Seleccionar registro ") + objectName);
		curStep.setValueBuffer("container", container);
		curStep.setValueBuffer("idobjecttype", "FLTableDB");
		curStep.setValueBuffer("objectname", objectName);
		curStep.setValueBuffer("idaction", "selectRow");
		curStep.setValueBuffer("parameters", cursor.valueBuffer("parameters"));
		curStep.setValueBuffer("idarea", cursor.valueBuffer("idarea"));
		curStep.setValueBuffer("idmodule", cursor.valueBuffer("idmodule"));
		curStep.setValueBuffer("formtype", "form");
		if (!curStep.commitBuffer())
			return;
	}
	
	switch(cursor.valueBuffer("mode")) {
		case "Insert": {
			objectName = "toolButtonInsert";
			break;
		}
		case "Edit": {
			objectName = "toolButtonEdit";
			break;
		}
		case "Browse": {
			objectName = "toolButtonZoom";
			break;
		}
		case "Del": {
			objectName = "toolButtonDelete";
			break;
		}
		default: {
			return;
		}
	}
	curStep.setModeAccess(curStep.Insert);
	curStep.refreshBuffer();
	curStep.setValueBuffer("idtestcat", idTestCat);
	curStep.setValueBuffer("stepnumber", ++stepNumber);
	curStep.setValueBuffer("description", util.translate("scripts", "Pulsar botón ") + objectName);
	curStep.setValueBuffer("container", container);
	curStep.setValueBuffer("idobjecttype", "Button");
	curStep.setValueBuffer("objectname", objectName);
	curStep.setValueBuffer("idaction", "animateClick");
	curStep.setValueBuffer("idarea", cursor.valueBuffer("idarea"));
	curStep.setValueBuffer("idmodule", cursor.valueBuffer("idmodule"));
	curStep.setValueBuffer("formtype", "form");
	if (!curStep.commitBuffer())
		return;
	
	if(cursor.valueBuffer("mode") == "Del"){
		curStep.setModeAccess(curStep.Insert);
		curStep.refreshBuffer();
		curStep.setValueBuffer("idtestcat", idTestCat);
		curStep.setValueBuffer("stepnumber", ++stepNumber);
		curStep.setValueBuffer("description", util.translate("scripts", "MessageBox - Pulsar Sí "));
		curStep.setValueBuffer("container", container);
		curStep.setValueBuffer("idobjecttype", "MessageBox");
		curStep.setValueBuffer("objectname", "");
		curStep.setValueBuffer("idaction", "pushYes");
		curStep.setValueBuffer("parameters", "<FLTest:Condition event=\"RECORD_DELETED\" object=\"\" />");
		curStep.setValueBuffer("idarea", cursor.valueBuffer("idarea"));
		curStep.setValueBuffer("idmodule", cursor.valueBuffer("idmodule"));
		curStep.setValueBuffer("formtype", "formRecord");
		if (!curStep.commitBuffer())
			return;
			
		curStep.setModeAccess(curStep.Insert);
		curStep.refreshBuffer();
		curStep.setValueBuffer("idtestcat", idTestCat);
		curStep.setValueBuffer("stepnumber", ++stepNumber);
		curStep.setValueBuffer("description", util.translate("scripts", "Cerrar formulario ") + container);
		curStep.setValueBuffer("container", container);
		curStep.setValueBuffer("idobjecttype", "FLFormDB");
		curStep.setValueBuffer("objectname", container);
		curStep.setValueBuffer("idaction", "close");
		curStep.setValueBuffer("idarea", cursor.valueBuffer("idarea"));
		curStep.setValueBuffer("idmodule", cursor.valueBuffer("idmodule"));
		curStep.setValueBuffer("formtype", "form");
		if (!curStep.commitBuffer())
			return;
	}
	
	this.iface.tdbSteps.refresh();
}

/** \D Introduce los pasos necesarios para aceptar un formulario de edición
*/
function oficial_predefinido_cfe()
{
	var util:FLUtil = new FLUtil;
	var idTestCat:Number = this.cursor().valueBuffer("id");
	var stepNumber:Number = 0;
	if (!idTestCat)
		return;
	
	var f:Object = new FLFormSearchDB("tt_step_closerecord");
	var cursor:FLSqlCursor = f.cursor();
	cursor.select();
	if (!cursor.first())
		cursor.setModeAccess(cursor.Insert);
	else
		cursor.setModeAccess(cursor.Edit);
	f.setMainWidget();
	cursor.refreshBuffer();
	
	var curStep:FLSqlCursor = new FLSqlCursor("tt_stepcat");
	curStep.select("idtestcat = " + idTestCat + " ORDER BY stepnumber DESC");
	if (curStep.first()) {
		cursor.setValueBuffer("idarea", curStep.valueBuffer("idarea"));
		cursor.setValueBuffer("idmodule", curStep.valueBuffer("idmodule"));
		cursor.setValueBuffer("container", curStep.valueBuffer("container"));
		stepNumber = parseFloat(curStep.valueBuffer("stepnumber"));
	}
	
	var id:String = f.exec("id");
	if (!id) 
		return;
	
	f.child("gbxVariable").close();
	
	var container:String = cursor.valueBuffer("container");
	var objectName:String = "";
	
	curStep.setModeAccess(curStep.Insert);
	curStep.refreshBuffer();
	curStep.setValueBuffer("idtestcat", idTestCat);
	curStep.setValueBuffer("stepnumber", ++stepNumber);
	curStep.setValueBuffer("description", util.translate("scripts", "Pulsar botón pushButtonAccept"));
	curStep.setValueBuffer("container", container);
	curStep.setValueBuffer("idobjecttype", "Button");
	curStep.setValueBuffer("objectname", "pushButtonAccept"); 
	curStep.setValueBuffer("idaction", "animateClick");
	curStep.setValueBuffer("idarea", cursor.valueBuffer("idarea"));
	curStep.setValueBuffer("idmodule", cursor.valueBuffer("idmodule"));
	curStep.setValueBuffer("formtype", "formRecord");
	curStep.setValueBuffer("pbaccept", util.translate("scripts", "Aceptar"));
	if (!curStep.commitBuffer())
		return;
		
	curStep.setModeAccess(curStep.Insert);
	curStep.refreshBuffer();
	curStep.setValueBuffer("idtestcat", idTestCat);
	curStep.setValueBuffer("stepnumber", ++stepNumber);
	curStep.setValueBuffer("description", util.translate("scripts", "Cerrar formulario ") + container);
	curStep.setValueBuffer("container", container);
	curStep.setValueBuffer("idobjecttype", "FLFormDB");
	curStep.setValueBuffer("objectname", container);
	curStep.setValueBuffer("idaction", "close");
	curStep.setValueBuffer("idarea", cursor.valueBuffer("idarea"));
	curStep.setValueBuffer("idmodule", cursor.valueBuffer("idmodule"));
	curStep.setValueBuffer("formtype", "form");
	if (!curStep.commitBuffer())
		return;
	
	this.iface.tdbSteps.refresh();
}

function oficial_tbnPruebas_clicked()
{
	var cursor:FLSqlCursor = this.cursor();
	var qryPruebas:FLSqlQuery = new FLSqlQuery;
	qryPruebas.setTablesList("tt_testcat,tt_stepcat");
	qryPruebas.setSelect("t.idfuncional, t.codtestcat, t.description");
	qryPruebas.setFrom("tt_stepcat s INNER JOIN tt_testcat t ON s.idtestcat = t.id");
	qryPruebas.setWhere("s.objectname = '<FLTest:Test codtest=\"" + cursor.valueBuffer("codtestcat") + "\" idfuncional=\"" + cursor.valueBuffer("idfuncional") + "\"/>'");
	if (!qryPruebas.exec())
		return;
		
	var numFilas:Number = this.iface.tblPruebasInc.numRows();
	var fila:Number;
	
	for (fila = (numFilas - 1); fila >= 0; fila--)
		this.iface.tblPruebasInc.removeRow(fila);
	
	fila = 0;
	while (qryPruebas.next()) {
		with (this.iface.tblPruebasInc) {
			insertRows(fila);
			setText(fila, 0, qryPruebas.value("t.idfuncional"));
			setText(fila, 1, qryPruebas.value("t.codtestcat"));
			setText(fila, 2, qryPruebas.value("t.description"));
		}
		fila++;
	}
}

/** \D Introduce los pasos necesarios para abrir un registro en modo edit
*/
function oficial_predefinido_are()
{
	var util:FLUtil = new FLUtil;
	var idTestCat:Number = this.cursor().valueBuffer("id");
	var stepNumber:Number = 0;
	if (!idTestCat)
		return;
	
	var f:Object = new FLFormSearchDB("tt_step_record");
	var cursor:FLSqlCursor = f.cursor();
	cursor.select();
	if (!cursor.first())
		cursor.setModeAccess(cursor.Insert);
	else
		cursor.setModeAccess(cursor.Edit);
	f.setMainWidget();
	cursor.refreshBuffer();
	
	var curStep:FLSqlCursor = new FLSqlCursor("tt_stepcat");
	curStep.select("idtestcat = " + idTestCat + " ORDER BY stepnumber DESC");
	if (curStep.first()) {
		cursor.setValueBuffer("idarea", curStep.valueBuffer("idarea"));
		cursor.setValueBuffer("idmodule", curStep.valueBuffer("idmodule"));
		cursor.setValueBuffer("container", curStep.valueBuffer("container"));
		cursor.setValueBuffer("mode","Edit");
		stepNumber = parseFloat(curStep.valueBuffer("stepnumber"));
	}
	
	var id:String = f.exec("id");
	if (!id) 
		return;
	
	f.child("fdbMode").setDisabled(true);
	
	var container:String = cursor.valueBuffer("container");
	var variable:String = cursor.valueBuffer("variable");
	var objectName:String = "";
	
	curStep.setModeAccess(curStep.Insert);
	curStep.refreshBuffer();
	curStep.setValueBuffer("idtestcat", idTestCat);
	curStep.setValueBuffer("stepnumber", ++stepNumber);
	curStep.setValueBuffer("description", util.translate("scripts", "Saltar si ") + variable + util.translate("scripts"," no está definida "));
	curStep.setValueBuffer("container", container);
	curStep.setValueBuffer("idobjecttype", "Compare");
	curStep.setValueBuffer("objectname", container);
	curStep.setValueBuffer("idaction", "compareItems");
	curStep.setValueBuffer("parameters", "<FLTest:Compare action=\"Saltar\" type=\"Distintos\" >\n    <FLTest:CompareElement type=\"Valor\" >" + variable + "</FLTest:CompareElement>\n    <FLTest:CompareElement type=\"Valor\" >**UNDEFINED**</FLTest:CompareElement>\n</FLTest:Compare>");
	curStep.setValueBuffer("idarea", cursor.valueBuffer("idarea"));
	curStep.setValueBuffer("idmodule", cursor.valueBuffer("idmodule"));
	curStep.setValueBuffer("formtype", "form");
	if (!curStep.commitBuffer())
		return;
	
	curStep.setModeAccess(curStep.Insert);
	curStep.refreshBuffer();
	curStep.setValueBuffer("idtestcat", idTestCat);
	curStep.setValueBuffer("stepnumber", ++stepNumber);
	curStep.setValueBuffer("description", util.translate("scripts", "Abrir formulario ") + container);
	curStep.setValueBuffer("container", container);
	curStep.setValueBuffer("idobjecttype", "FLFormDB");
	curStep.setValueBuffer("objectname", container);
	curStep.setValueBuffer("idaction", "open");
	curStep.setValueBuffer("idarea", cursor.valueBuffer("idarea"));
	curStep.setValueBuffer("idmodule", cursor.valueBuffer("idmodule"));
	curStep.setValueBuffer("formtype", "form");
	if (!curStep.commitBuffer())
		return;
		
	curStep.setModeAccess(curStep.Insert);
	curStep.refreshBuffer();
	curStep.setValueBuffer("idtestcat", idTestCat);
	curStep.setValueBuffer("stepnumber", ++stepNumber);
	var llamada:String = fltestppal.getWidgetList("form" + container, "FLTableDB");
	var a:Array = llamada.split("*");
	var name:String = a[0];
	if (!name)
		return;
	objectName = "";
	for (var i:Number = 0; (name.toString().charAt(i) != "/"); i++) {
		objectName += name.toString().charAt(i);
	}
	curStep.setValueBuffer("description", util.translate("scripts", "Seleccionar registro ") + objectName);
	curStep.setValueBuffer("container", container);
	curStep.setValueBuffer("idobjecttype", "FLTableDB");
	curStep.setValueBuffer("objectname", objectName);
	curStep.setValueBuffer("idaction", "selectRow");
	curStep.setValueBuffer("parameters", cursor.valueBuffer("parameters"));
	curStep.setValueBuffer("idarea", cursor.valueBuffer("idarea"));
	curStep.setValueBuffer("idmodule", cursor.valueBuffer("idmodule"));
	curStep.setValueBuffer("formtype", "form");
	if (!curStep.commitBuffer())
		return;
	
	curStep.setModeAccess(curStep.Insert);
	curStep.refreshBuffer();
	curStep.setValueBuffer("idtestcat", idTestCat);
	curStep.setValueBuffer("stepnumber", ++stepNumber);
	curStep.setValueBuffer("description", util.translate("scripts", "Pulsar botón ") + "toolButtonEdit");
	curStep.setValueBuffer("container", container);
	curStep.setValueBuffer("idobjecttype", "Button");
	curStep.setValueBuffer("objectname", "toolButtonEdit");
	curStep.setValueBuffer("idaction", "animateClick");
	curStep.setValueBuffer("idarea", cursor.valueBuffer("idarea"));
	curStep.setValueBuffer("idmodule", cursor.valueBuffer("idmodule"));
	curStep.setValueBuffer("formtype", "form");
	if (!curStep.commitBuffer())
		return;
	
	this.iface.tdbSteps.refresh();
}

/** \D Introduce los pasos necesarios para cerrar un registro abierto en modo edit
*/
function oficial_predefinido_cre()
{
	var util:FLUtil = new FLUtil;
	var idTestCat:Number = this.cursor().valueBuffer("id");
	var stepNumber:Number = 0;
	if (!idTestCat)
		return;
	
	var f:Object = new FLFormSearchDB("tt_step_record");
	var cursor:FLSqlCursor = f.cursor();
	cursor.select();
	if (!cursor.first())
		cursor.setModeAccess(cursor.Insert);
	else
		cursor.setModeAccess(cursor.Edit);
	f.setMainWidget();
	cursor.refreshBuffer();
	
	var curStep:FLSqlCursor = new FLSqlCursor("tt_stepcat");
	curStep.select("idtestcat = " + idTestCat + " ORDER BY stepnumber DESC");
	if (curStep.first()) {
		cursor.setValueBuffer("idarea", curStep.valueBuffer("idarea"));
		cursor.setValueBuffer("idmodule", curStep.valueBuffer("idmodule"));
		cursor.setValueBuffer("container", curStep.valueBuffer("container"));
		cursor.setValueBuffer("mode","Edit");
		stepNumber = parseFloat(curStep.valueBuffer("stepnumber"));
	}
	
	var id:String = f.exec("id");
	if (!id) 
		return;
	
	f.child("fdbMode").setDisabled(true);
	
	var container:String = cursor.valueBuffer("container");
	var variable:String = cursor.valueBuffer("variable");
	var objectName:String = "";
	
	curStep.setModeAccess(curStep.Insert);
	curStep.refreshBuffer();
	curStep.setValueBuffer("idtestcat", idTestCat);
	curStep.setValueBuffer("stepnumber", ++stepNumber);
	curStep.setValueBuffer("description", util.translate("scripts", "Saltar si ") + variable + util.translate("scripts"," no está definida "));
	curStep.setValueBuffer("container", container);
	curStep.setValueBuffer("idobjecttype", "Compare");
	curStep.setValueBuffer("objectname", container);
	curStep.setValueBuffer("idaction", "compareItems");
	curStep.setValueBuffer("parameters", "<FLTest:Compare action=\"Saltar\" type=\"Distintos\" >\n    <FLTest:CompareElement type=\"Valor\" >" + variable + "</FLTest:CompareElement>\n    <FLTest:CompareElement type=\"Valor\" >**UNDEFINED**</FLTest:CompareElement>\n</FLTest:Compare>");
	curStep.setValueBuffer("idarea", cursor.valueBuffer("idarea"));
	curStep.setValueBuffer("idmodule", cursor.valueBuffer("idmodule"));
	curStep.setValueBuffer("formtype", "formRecord");
	if (!curStep.commitBuffer())
		return;
	
	curStep.setModeAccess(curStep.Insert);
	curStep.refreshBuffer();
	curStep.setValueBuffer("idtestcat", idTestCat);
	curStep.setValueBuffer("stepnumber", ++stepNumber);
	curStep.setValueBuffer("description", util.translate("scripts", "Pulsar botón ") + "pushButtonAccept");
	curStep.setValueBuffer("container", container);
	curStep.setValueBuffer("idobjecttype", "Button");
	curStep.setValueBuffer("objectname", "pushButtonAccept");
	curStep.setValueBuffer("idaction", "animateClick");
	curStep.setValueBuffer("idarea", cursor.valueBuffer("idarea"));
	curStep.setValueBuffer("idmodule", cursor.valueBuffer("idmodule"));
	curStep.setValueBuffer("formtype", "formRecord");
	if (!curStep.commitBuffer())
		return;
		
	curStep.setModeAccess(curStep.Insert);
	curStep.refreshBuffer();
	curStep.setValueBuffer("idtestcat", idTestCat);
	curStep.setValueBuffer("stepnumber", ++stepNumber);
	curStep.setValueBuffer("description", util.translate("scripts", "Abrir formulario ") + container);
	curStep.setValueBuffer("container", container);
	curStep.setValueBuffer("idobjecttype", "FLFormDB");
	curStep.setValueBuffer("objectname", container);
	curStep.setValueBuffer("idaction", "close");
	curStep.setValueBuffer("idarea", cursor.valueBuffer("idarea"));
	curStep.setValueBuffer("idmodule", cursor.valueBuffer("idmodule"));
	curStep.setValueBuffer("formtype", "form");
	if (!curStep.commitBuffer())
		return;
	
	this.iface.tdbSteps.refresh();
}

/** \D Muestra el formulario de ayuda para describir los parámetros de la prueba
\end */
function oficial_setParameters()
{
	var cursor:FLSqlCursor = this.cursor();
	var f:Object = new FLFormSearchDB("tt_testparam");
	var curParameter:FLSqlCursor = f.cursor();
		
	curParameter.select();
	if (!curParameter.first())
		curParameter.setModeAccess(curParameter.Insert);
	else
		curParameter.setModeAccess(curParameter.Edit);
		
	f.setMainWidget();
	curParameter.refreshBuffer();
	curParameter.setValueBuffer("xml", cursor.valueBuffer("parameters"));
	var xmlContent:String = f.exec("xml");
	if (xmlContent) 
		this.child("fdbParameters").setValue(xmlContent);
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





