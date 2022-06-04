/***************************************************************************
                 tt_testparam.qs  -  description
                             -------------------
    begin                : mar nov 29 2005
    copyright            : (C) 2005 by InfoSiAL S.L.
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
/** \C Presenta los datos de parámetros y valores por defecto para su edición
\end */
function interna_init()
{
	var util:FLUtil = new FLUtil;
	
	this.iface.tblXML = this.child("tblXML");
	this.iface.tblXML.setNumCols(3);
	this.iface.tblXML.setColumnWidth(0, 200);
	this.iface.tblXML.setColumnWidth(1, 200);
	this.iface.tblXML.setColumnWidth(2, 200);
	this.iface.tblXML.setColumnLabels("/", util.translate("scripts", "Parámetro") + "/" + util.translate("scripts", "Valor por defecto") + "/" + util.translate("scripts", "Contenedor"));

	connect(this.child("pbnMas"), "clicked()", this, "iface.pbnMas_clicked");
	connect(this.child("pushButtonAccept"), "clicked()", this, "iface.construirXml");
	
	this.iface.mostrarDatos();
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D Actualiza el valor de los atributos del nodo FLTest:Parameters y guarda su contenido en el campo --xml--
\end */ 
function oficial_construirXml()
{
	var cursor:FLSqlCursor = this.cursor();
	var xmlAux:FLDomDocument = new FLDomDocument();
	if (this.iface.docXml)
		delete this.iface.docXml;
		
	this.iface.docXml = new FLDomDocument();
	this.iface.docXml.setContent("<FLTest:Parameters />"); 
	var nodo:FLDomNode= this.iface.docXml.firstChild();
	
	var totalFilas:Number = this.iface.tblXML.numRows();
	var content:String;
	for (var fila:Number = 0; fila < totalFilas; fila++) {
		if (this.iface.tblXML.text(fila, 0) == "")
			continue;
			
		content = "<FLTest:Parameter name=\"" + this.iface.tblXML.text(fila, 0) + "\" default=\"" + this.iface.tblXML.text(fila, 1) + "\"";
		if (this.iface.tblXML.text(fila, 2) != "")
			content += " container=\"" + this.iface.tblXML.text(fila, 2) + "\"";
		content += "/>";
			
		if (!xmlAux.setContent(content)) {
			MessageBox.critical(util.translate("scripts", "Error al elaborar el nodo xml correspondiente al elemento ") + fila, MessageBox.Ok. MessageBox.NoButton);
			return;
		}
		nodo.appendChild(xmlAux.firstChild());
	}
	cursor.setValueBuffer("xml", this.iface.docXml.toString(4));
}

/** \D Extrae los atributos del nodo FLTest:Parameter y los muestra en el formulario
\end */ 
function oficial_mostrarDatos()
{
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
		this.iface.docXml.setContent("<FLTest:Parameters/>");
	
	var nodos:FLDomNodeList = this.iface.docXml.elementsByTagName("FLTest:Parameter");
	if (!nodos)
		return;
		
	var container:String;
	for (var i:Number = 0; i < nodos.length(); i++) {
		this.iface.tblXML.insertRows(i, 1);
		this.iface.tblXML.setText(i, 0, nodos.item(i).toElement().attribute("name"));
		this.iface.tblXML.setText(i, 1, nodos.item(i).toElement().attribute("default"));
		container = nodos.item(i).toElement().attribute("container");
		if (container)
			this.iface.tblXML.setText(i, 2, nodos.item(i).toElement().attribute("container"));
	}
}

/** \D Añade una fila a la tabla de valores
\end */
function oficial_pbnMas_clicked()
{
	this.iface.tblXML.insertRows(this.iface.tblXML.numRows(), 1);
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
