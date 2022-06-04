/***************************************************************************
                 tt_condition.qs  -  description
                             -------------------
    begin                : lun oct 24 2005
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

/** \C Presenta los datos de configuración de la consulta contenidos en el nodo XML
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
/** \D Actualiza el valor de los atributos del nodo FLTest:Condition y guarda su contenido en el campo --xml--
\end */ 
function oficial_construirXml()
{
	var cursor:FLSqlCursor = this.cursor();
	var nodo:FLDomElement = this.iface.docXml.firstChild().toElement();
	nodo.setAttribute("event", cursor.valueBuffer("event"));
	nodo.setAttribute("object", cursor.valueBuffer("object"));
	cursor.setValueBuffer("xml", this.iface.docXml.toString(4));
}

/** \D Extrae los atributos del nodo FLTest:Condition y los muestra en el formulario
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
		this.iface.docXml.setContent("<FLTest:Condition event=\"SCRIPT_FINISHED\" object=\"\"/>");
		cursor.setValueBuffer("xml","<FLTest:Condition event=\"SCRIPT_FINISHED\" object=\"\"/>");
	}
	
	var nodo:FLDomElement = this.iface.docXml.firstChild().toElement();
	cursor.setValueBuffer("event", nodo.attribute("event"));
	this.child("fdbObject").setValue(nodo.attribute("object"));
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
