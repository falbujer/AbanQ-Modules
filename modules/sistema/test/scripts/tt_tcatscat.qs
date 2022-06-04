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
	function calculateCounter(fN:String):Number {
		return this.ctx.interna_calculateCounter(fN); 
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var tbnParameters:Object;
	function oficial( context ) { interna( context ); } 
	function setParameters() {
		return this.ctx.oficial_setParameters();
	}
	function calculateField(fN:String):String {
		return this.ctx.oficial_calculateField(fN);
	}
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
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
/** \C Al asociar una nueva prueba a la sesión, los valores por defecto de --codsessioncat-- y --description-- serán los de la sesión seleccionada. El valor por defecto de --idfuncional-- será el de la funcionalidad actual
\end */
function interna_init()
{
	var cursor:FLSqlCursor = this.cursor();
	this.iface.tbnParameters = this.child("tbnParameters");
	
	connect(this.cursor(), "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this.iface.tbnParameters, "clicked()", this, "iface.setParameters");
	
	this.child("fdbCodSessionCat").setDisabled(true);
	if (cursor.modeAccess() == cursor.Insert) {
		cursor.setValueBuffer("idfuncional", cursor.cursorRelation().valueBuffer("idfuncional"));
		cursor.setValueBuffer("codsessioncat", cursor.cursorRelation().valueBuffer("codsessioncat"));
		cursor.setValueBuffer("description", cursor.cursorRelation().valueBuffer("description"));
	}
}

/** \D Calcula el número de prueba (testnumber) como el número máximo más uno para la sesión actual

@param	fN: Nombre del campo
@return: Valor para testnumber
*/
 function interna_calculateCounter(fN:String):Number
 {
 	var util:FLUtil = new FLUtil;
 	if (fN == "testnumber") {
 		var cursor:FLSqlCursor = form.cursor();
 		var idSessionCat:String = cursor.cursorRelation().valueBuffer("id");
 		var testNumber = util.sqlSelect("tt_tcatscat", "testnumber",
 			"idsessioncat = '" + idSessionCat + "' ORDER BY testnumber DESC");
 		if (!testNumber)
 			return 1;
 		else
 			return ++testNumber;
 	}
 }
 
/** \D Calcula el valor de un campo

@param	fN: Nombre del campo
@return: Valor calculado
*/
function interna_calculateField(fN:String):String
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var res:String = "";
	
	switch(fN) {
		case "description": {
			res = util.sqlSelect("tt_testcat", "description", "codtestcat = '" + cursor.valueBuffer("codtestcat") + "' AND idfuncional = '" + cursor.valueBuffer("idfuncional") + "'");
			break;
		}
	}
	return res;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_setParameters()
{
debug("PP");
	var f:Object = new FLFormSearchDB("tt_assignation");
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var curAssignation:FLSqlCursor = f.cursor();
	curAssignation.select();
	if (!curAssignation.first())
		curAssignation.setModeAccess(curAssignation.Insert);
	else
		curAssignation.setModeAccess(curAssignation.Edit);
		
	var xmlTest:FLDomDocument = new FLDomDocument;
	var xmlAssignation:FLDomDocument = new FLDomDocument;
	var testParameters:String = util.sqlSelect("tt_testcat", "parameters", "id = " + cursor.valueBuffer("idtestcat"));
	if (testParameters && xmlTest.setContent(testParameters)) {
		if (!xmlAssignation.setContent(cursor.valueBuffer("parameters")))
			xmlAssignation.setContent("<FLTest:Assignation />");
		var listaParam:FLDomNodeList = xmlTest.elementsByTagName("FLTest:Parameter");
		var listaAssignation:FLDomNodeList = xmlAssignation.elementsByTagName("FLTest:AssignationElement");
		var param:String;
		var container:String;
		var defValue:String;
		var totalAsig:Number;
		if (listaAssignation)
			totalAsig = listaAssignation.length();
		else
			totalAsig = 0;
		var j:Number;
		for (var i:Number = 0; i < listaParam.length(); i++) {
			param = listaParam.item(i).toElement().attribute("name");
			defValue = listaParam.item(i).toElement().attribute("default");
			container = listaParam.item(i).toElement().attribute("container");
			if (!defValue)
				defValue = "";
			var encontrado:Boolean = false;
			for (j = 0; j < totalAsig; j++) {
				if (listaAssignation.item(j).toElement().attribute("var") == param) {
					encontrado = true;
					break;
				}
			}
			if (encontrado) {
				listaAssignation.item(j).toElement().setAttribute("container", container);
				listaAssignation.item(j).toElement().setAttribute("default", defValue);
			} else {
				var element:FLDomElement = xmlAssignation.createElement("FLTest:AssignationElement");
				element.setAttribute("var", param);
				element.setAttribute("value", "");
				element.setAttribute("container", container);
				element.setAttribute("default", defValue);
				xmlAssignation.firstChild().appendChild(element);
			}
		}
	}
	
	f.setMainWidget();
	curAssignation.refreshBuffer();
	curAssignation.setValueBuffer("xml", xmlAssignation.toString(4));
	var xmlContent:String = f.exec("xml");
	if (xmlContent) 
		this.child("fdbParameters").setValue(xmlContent);
}

function oficial_bufferChanged(fN:String)
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil;

	switch(fN) {
/** \C El valor del campo --descripcion-- será el nombre de la prueba más los parámetros que se pasan
\end */
		case "parameters":
		case "description":
			this.child("fdbDescription").setValue(this.iface.calculateField("description"));
		break;
	}
}

function oficial_calculateField(fN:String):String
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil;
	var res:String;
	switch (fN) {
		case "description": {
			var xmlTest:FLDomDocument = new FLDomDocument;
			res = util.sqlSelect("tt_testcat", "description", "id = " + cursor.valueBuffer("idtestcat"));
			if (xmlTest.setContent(cursor.valueBuffer("parameters"))) {
				var l:FLDomNodeList = xmlTest.elementsByTagName("FLTest:AssignationElement");
				for (var i:Number = 0; i < l.length(); i++) {
					res += " " + l.item(i).toElement().attribute("var") + " = " + l.item(i).toElement().attribute("value");
				}
			}
			break;
		}
	}
	return res;
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
