/***************************************************************************
                 tt_scriptdialog.qs  -  description
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
    function oficial( context ) { interna( context ); } 
	function construirXml() {
		return this.ctx.oficial_construirXml();
	}
	function mostrarDatos() {
		return this.ctx.oficial_mostrarDatos();
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
/** \C Muestra los datos de variables y valores asignados
\end */
function interna_init()
{
	var cursor:FLSqlCursor = this.cursor();
	connect(this.child("pushButtonAccept"), "clicked()", this, "iface.construirXml");
	
	this.iface.mostrarDatos();
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D Actualiza el valor de los atributos del nodo FLTest:ScriptDialog y guarda su contenido en el campo --xml--
\end */ 
function oficial_construirXml()
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();
	var xmlAux:FLDomDocument = new FLDomDocument();
	if (this.iface.docXml)
		delete this.iface.docXml;
		
	this.iface.docXml = new FLDomDocument();
	this.iface.docXml.setContent("<FLTest:ScriptDialog event=\"" + cursor.valueBuffer("event") + "\" object=\"" + cursor.valueBuffer("object") + "\"/>"); 
	var nodo:FLDomNode= this.iface.docXml.firstChild();
	
	var iCadena:String;
	for (var i:Number = 1; i <= 10; i++) {
		iCadena = i.toString();
		if (this.child("fdbName" + iCadena).value() == "")
			continue;
		if (!xmlAux.setContent("<FLTest:DialogObject type=\"" + cursor.valueBuffer("type" + iCadena) + "\" name=\"" + cursor.valueBuffer("name" + iCadena) + "\" value=\"" + cursor.valueBuffer("value" + iCadena) + "\"/>")) {
			MessageBox.critical(util.translate("scripts", "Error al elaborar el nodo xml correspondiente al elemento ") + iCadena, MessageBox.Ok. MessageBox.NoButton);
			return;
		}
		nodo.appendChild(xmlAux.firstChild());
	}
		
	cursor.setValueBuffer("xml", this.iface.docXml.toString(4));
}

/** \D Extrae los atributos del nodo FLTest:Query y los muestra en el formulario
\end */ 
function oficial_mostrarDatos()
{
	var cursor:FLSqlCursor = this.cursor();
	if (this.iface.docXml)
		delete this.iface.docXml;
		
	this.iface.docXml = new FLDomDocument();
	if (cursor.valueBuffer("xml") != "")
		this.iface.docXml.setContent(cursor.valueBuffer("xml"));
	else{
		this.child("fdbEvent").setValue("SCRIPT_FINISHED");
		this.iface.docXml.setContent("<FLTest:ScriptDialog event=\"SCRIPT_FINISHED\" object=\"\"/>");
		cursor.setValueBuffer("xml","<FLTest:ScriptDialog event=\"SCRIPT_FINISHED\" object=\"\"/>");
	}
	var nodos:FLDomNodeList = this.iface.docXml.elementsByTagName("FLTest:DialogObject");
	if (!nodos)
		return;
	
	var nodo:FLDomElement = this.iface.docXml.firstChild().toElement();
	cursor.setValueBuffer("event", nodo.attribute("event"));
	this.child("fdbObject").setValue(nodo.attribute("object"));
		
	var iCadena:String;
	for (var i:Number = 1; i <= nodos.length() && 1 <= 10; i++) {
		iCadena = i.toString();
		this.cursor().setValueBuffer("type" + iCadena, nodos.item(i - 1).toElement().attribute("type"));
		this.child("fdbName" + iCadena).setValue(nodos.item(i - 1).toElement().attribute("name"));
		this.child("fdbValue" + iCadena).setValue(nodos.item(i - 1).toElement().attribute("value"));
	}
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
