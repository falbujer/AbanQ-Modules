/***************************************************************************
                 tt_assignation.qs  -  description
                             -------------------
    begin                : mar jun 07 2004
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
	var docXml:FLDomDocument;
	var tblXML:QTable;
    function oficial( context ) { interna( context ); } 
	function construirXml() {
		return this.ctx.oficial_construirXml();
	}
	function mostrarDatos() {
		return this.ctx.oficial_mostrarDatos();
	}
	function pbnMas_clicked() {
		return this.ctx.oficial_pbnMas_clicked();
	}
	function tbnFieldList_clicked() {
		return this.ctx.oficial_tbnFieldList_clicked();
	}
	function currentChanged(fila:Number, col:Number) {
		return this.ctx.oficial_currentChanged(fila, col);
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

/** \C Presenta los datos de variables y valores asignados contenidos en el nodo XML
\end */
function interna_init()
{
debug("m1");
	var util:FLUtil = new FLUtil;
	
	this.iface.tblXML = this.child("tblXML");
	this.iface.tblXML.setNumCols(4);
	this.iface.tblXML.setColumnWidth(0, 200);
	this.iface.tblXML.setColumnWidth(1, 200);
	this.iface.tblXML.setColumnWidth(2, 200);
	this.iface.tblXML.setColumnWidth(3, 200);
	//this.iface.tblXML.hideColumn(3);
	this.iface.tblXML.setColumnLabels("/", util.translate("scripts", "Variable") + "/" + util.translate("scripts", "Valor") + "/" + util.translate("scripts", "Valor por defecto"));
	this.iface.tblXML.setColumnReadOnly(2, true);
	
	connect(this.child("pbnMas"), "clicked()", this, "iface.pbnMas_clicked");
	connect(this.child("tbnFieldList"), "clicked()", this, "iface.tbnFieldList_clicked");
	connect(this.child("pushButtonAccept"), "clicked()", this, "iface.construirXml");
	connect(this.iface.tblXML, "currentChanged(int, int)", this, "iface.currentChanged");
	
	this.iface.mostrarDatos();
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D Actualiza el valor de los atributos del nodo FLTest:Assignation y guarda su contenido en el campo --xml--
\end */ 
function oficial_construirXml()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var xmlAux:FLDomDocument = new FLDomDocument();
	if (this.iface.docXml)
		delete this.iface.docXml;
		
	this.iface.docXml = new FLDomDocument();
	this.iface.docXml.setContent("<FLTest:Assignation />"); 
	var nodo:FLDomNode= this.iface.docXml.firstChild();
	
	var totalFilas:Number = this.iface.tblXML.numRows();
	var contentAux:String;
	var value:String;
	var name:String;
	var container:String;
	for (var fila:Number = 0; fila < totalFilas; fila++) {
		value = this.iface.tblXML.text(fila, 1);
		name = this.iface.tblXML.text(fila, 0);
		container = this.iface.tblXML.text(fila, 3);
		if (name == "" || value == "")
			continue;
		if (container)
			contentAux = "<FLTest:AssignationElement var=\"" + name + "\" value=\"__child_node__\">" + value + "</FLTest:AssignationElement>";
		else
			contentAux= "<FLTest:AssignationElement var=\"" + name + "\" value=\"" + value + "\"/>";
		if (!xmlAux.setContent(contentAux)) {
			MessageBox.critical(util.translate("scripts", "Error al elaborar el nodo xml correspondiente al elemento ") + fila, MessageBox.Ok, MessageBox.NoButton);
			debug(contentAux);
			return;
		}
		nodo.appendChild(xmlAux.firstChild());
	}
	cursor.setValueBuffer("xml", this.iface.docXml.toString(4));
}

/** \D Extrae los atributos del nodo FLTest:Assignation y los muestra en el formulario
\end */ 
function oficial_mostrarDatos()
{
debug("m2");
	var totalFilas:Number = this.iface.tblXML.numRows() - 1;
	for (var fila:Number = totalFilas; fila >= 0; fila--)
		this.iface.tblXML.removeRow(fila);
	
	var cursor:FLSqlCursor = this.cursor();
	if (this.iface.docXml)
		delete this.iface.docXml;
		
	this.iface.docXml = new FLDomDocument();
	if (cursor.valueBuffer("xml") != "")
		this.iface.docXml.setContent(cursor.valueBuffer("xml"));
	else
		this.iface.docXml.setContent("<FLTest:Assignation/>");
	debug("m3");
	var nodos:FLDomNodeList = this.iface.docXml.elementsByTagName("FLTest:AssignationElement");
	if (!nodos)
		return;
		
	var value:String;
	for (var i:Number = 0; i < nodos.length(); i++) {
		this.iface.tblXML.insertRows(i, 1);
		this.iface.tblXML.setText(i, 0, nodos.item(i).toElement().attribute("var"));
		value = nodos.item(i).toElement().attribute("value");
		if (value == "__child_node__") {
			var xmlAux:FLDomDocument = new FLDomDocument;
			var element:FLDomElement = xmlAux.createElement("pepe");
			var child:FLDomNode = nodos.item(i).firstChild();
			debug(child.nodeValue());
			if (child.nodeValue() != "") {
				debug("m44");
				debug(nodos.item(i).toElement().text());
				value = nodos.item(i).toElement().text();
			} else {
				debug("m5");
				element = child.cloneNode().toElement();
				xmlAux.appendChild(element);
				value = xmlAux.toString(4);
			}
		}
		debug("m5");
		this.iface.tblXML.setText(i, 1, value);
		this.iface.tblXML.setText(i, 2, nodos.item(i).toElement().attribute("default"));
		this.iface.tblXML.setText(i, 3, nodos.item(i).toElement().attribute("container"));
	}
	if (this.iface.tblXML.numRows() > 0)
		this.iface.currentChanged(0, 0);
}

/** \D Añade una fila a la tabla de valores
\end */
function oficial_pbnMas_clicked()
{
	this.iface.tblXML.insertRows(this.iface.tblXML.numRows(), 1);
}

/** \D Muestra la lista de campos de un formulario para establecer varios valores en un solo paso
\end */
function oficial_tbnFieldList_clicked()
{
	var util:FLUtil = new FLUtil;
	var xmlDoc:FLDomDocument = new FLDomDocument;
	var xmlFields:FLDomNodeList;
	var filaActual = this.iface.tblXML.currentRow();
	if (xmlDoc.setContent( this.iface.tblXML.text(filaActual, 1) ) ) 
		xmlFields = xmlDoc.elementsByTagName("FLTest:FieldDB");
	
	var formName:String = this.iface.tblXML.text(filaActual, 3);
	var llamada:String = fltestppal.getWidgetList(formName, "FLFieldDB");
	var controles:Array = llamada.split("*");
	controles.sort();
	var dialogo = new Dialog;
	dialogo.okButtonText = util.translate("scripts", "Aceptar");
	dialogo.cancelButtonText = util.translate("scripts", "Cancelar");
	
	var gBox = new GroupBox;
	gBox.title = util.translate("scripts", "Establecer valores de campos");
	
	
	var numControles:Number = controles.length - 1;
	var leField = new Array(numControles);
	var nomControl = new Array(numControles);
	
	var valor:String;
	var j:Number;
	var fila:Number = 0;
	for (var i:Number = 0; i < numControles; i++) {
		nomControl[i] = controles[i].left(controles[i].find("/"));
		leField[i] = new LineEdit;
		leField[i].label = controles[i];
		if (xmlFields) {
			for (j = 0; j < xmlFields.length(); j++) {
				if (xmlFields.item(j).toElement().attribute("name") == nomControl[i]) {
					leField[i].text = xmlFields.item(j).toElement().attribute("value");
				}
			}
		}
		if (fila++ == 16) {
			fila = 0;
			gBox.newColumn();
		}
		gBox.add(leField[i]);
	}
	dialogo.add(gBox);
	if (!dialogo.exec())
		return;
		
	var contentXML:String = "<FLTest:FieldDBList>";
	var nameDesc:Array;
	for (var i:Number = 0; i < numControles; i++) {
		valor = leField[i].text;
		if (valor)
			contentXML += "\n\t<FLTest:FieldDB name =\"" + nomControl[i] + "\" value=\"" + valor + "\"/>";
	}
	contentXML += "\n</FLTest:FieldDBList>";
	this.iface.tblXML.setText(filaActual, 1, contentXML);
}

function oficial_currentChanged(fila:Number, col:Number)
{
	var util:FLUtil = new FLUtil;
	var container:String = this.iface.tblXML.text(fila, 3);
	if (container) {
		this.child("lblFieldList").text = util.translate("scripts", "Valores para campos en ") + container;
		this.child("tbnFieldList").enabled = true;
	} else {
		this.child("lblFieldList").text = "";
		this.child("tbnFieldList").enabled = false;
	}
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
