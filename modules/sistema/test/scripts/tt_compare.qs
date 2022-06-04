/***************************************************************************
                 tt_compare.qs  -  description
                             -------------------
    begin                : lun abr 18 2004 
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
	var tbnMore1:Object;
	var tbnMore2:Object;
    function oficial( context ) { interna( context ); } 
	function construirXml() {
		return this.ctx.oficial_construirXml();
	}
	function mostrarDatos() {
		return this.ctx.oficial_mostrarDatos();
	}
	function tbnMore1_clicked() {
		return this.ctx.oficial_tbnMore1_clicked();
	}
	function tbnMore2_clicked() {
		return this.ctx.oficial_tbnMore2_clicked();
	}
	function tbnMore_clicked(itemType:String, currentValue:String):String {
		return this.ctx.oficial_tbnMore_clicked(itemType, currentValue);
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

/** \C Presenta los datos de comparación de valores contenidos en el nodo XML
\end */
function interna_init()
{
	this.iface.tbnMore1 = this.child("tbnMore1");
	this.iface.tbnMore2 = this.child("tbnMore2");
	
	var cursor:FLSqlCursor = this.cursor();
	connect(this.child("pushButtonAccept"), "clicked()", this, "iface.construirXml");
	connect(this.iface.tbnMore1, "clicked()", this, "iface.tbnMore1_clicked");
	connect(this.iface.tbnMore2, "clicked()", this, "iface.tbnMore2_clicked");
	
	this.iface.mostrarDatos();
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D Actualiza el valor de los atributos del nodo FLTest:Compare y guarda su contenido en el campo --xml--
\end */ 
function oficial_construirXml()
{
	var cursor:FLSqlCursor = this.cursor();
	var xmlAux:FLDomDocument = new FLDomDocument();
	if (this.iface.docXml)
		delete this.iface.docXml;
		
	this.iface.docXml = new FLDomDocument();
	this.iface.docXml.setContent("<FLTest:Compare />"); 
	var nodo:FLDomNode= this.iface.docXml.firstChild();
	
	nodo.toElement().setAttribute("type", cursor.valueBuffer("tipocomp"));
	nodo.toElement().setAttribute("action", cursor.valueBuffer("accion"));
	if (!xmlAux.setContent("<FLTest:CompareElement type=\"" + cursor.valueBuffer("tipo1") + "\">" + cursor.valueBuffer("valor1") + "</FLTest:CompareElement>")) {
		MessageBox.critical(util.translate("scripts", "Error al elaborar el nodo xml correspondiente al primer elemento"), MessageBox.Ok. MessageBox.NoButton);
		return;
	}
	nodo.appendChild(xmlAux.firstChild());
		
	if (!xmlAux.setContent("<FLTest:CompareElement type=\"" + cursor.valueBuffer("tipo2") + "\">" + cursor.valueBuffer("valor2") + "</FLTest:CompareElement>")) {
		MessageBox.critical(util.translate("scripts", "Error al elaborar el nodo xml correspondiente al segundo elemento"), MessageBox.Ok. MessageBox.NoButton);
		return;
	}
	nodo.appendChild(xmlAux.firstChild());

	cursor.setValueBuffer("xml", this.iface.docXml.toString(4));
}

/** \D Extrae los atributos del nodo FLTest:Compare y los muestra en el formulario
\end */ 
function oficial_mostrarDatos()
{
	var cursor:FLSqlCursor = this.cursor();
	var itemType:String;
	var xmlAux:FLDomDocument = new FLDomDocument();
	xmlAux.setContent("");
			
	if (this.iface.docXml)
		delete this.iface.docXml;
		
	this.iface.docXml = new FLDomDocument();
	if (cursor.valueBuffer("xml") != "")
		this.iface.docXml.setContent(cursor.valueBuffer("xml"));
	else
		this.iface.docXml.setContent("<FLTest:Compare type=\"Distintos\" action=\"Error\"> <FLTest:CompareElement type=\"Query\"/> <FLTest:CompareElement type=\"Valor\"/> </FLTest:Compare>");
	
	var nodo:FLDomNode = this.iface.docXml.firstChild();
	cursor.setValueBuffer("tipocomp", nodo.toElement().attribute("type"));
	cursor.setValueBuffer("accion", nodo.toElement().attribute("action"));
	
	nodo = nodo.firstChild();
	itemType = nodo.toElement().attribute("type");
	cursor.setValueBuffer("tipo1", itemType);
	switch (itemType) {
	case "Valor":
	case "Campo":
		this.child("fdbValor1").setValue(nodo.toElement().text());
		break;
	case "Query":
		var nodoAux:FLDomNode = nodo.firstChild();
		if (nodoAux){
			xmlAux.appendChild(nodoAux.cloneNode());
			this.child("fdbValor1").setValue(xmlAux.toString(4));
			debug(xmlAux.toString(4));
		}
		break;
	}
	
	delete xmlAux;
	xmlAux = new FLDomDocument;
	xmlAux.setContent("");
			
	nodo = nodo.nextSibling();
	itemType = nodo.toElement().attribute("type");
	cursor.setValueBuffer("tipo2", itemType);
	switch (itemType) {
	case "Valor":
	case "Campo":
		this.child("fdbValor2").setValue(nodo.toElement().text());
		break;
	case "Query":
		var nodoAux:FLDomNode = nodo.firstChild();
		if (nodoAux){
			xmlAux.appendChild(nodoAux.cloneNode());
			this.child("fdbValor2").setValue(xmlAux.toString(4));
		}
		break;
	}
}

/** \D Llama a la función tbnMore_clicked pasando por parámetros los datos relativos al primer elemento de la comparación
\end */
function oficial_tbnMore1_clicked()
{
	var cursor:FLSqlCursor = this.cursor();
	var valor:String = this.iface.tbnMore_clicked(cursor.valueBuffer("tipo1"), cursor.valueBuffer("valor1"));
	if (valor)
		this.child("fdbValor1").setValue(valor);
}

/** \D Llama a la función tbnMore_clicked pasando por parámetros los datos relativos al segundo elemento de la comparación
\end */
function oficial_tbnMore2_clicked()
{
	var cursor:FLSqlCursor = this.cursor();
	var valor:String = this.iface.tbnMore_clicked(cursor.valueBuffer("tipo2"), cursor.valueBuffer("valor2"));
	if (valor)
		this.child("fdbValor2").setValue(valor);
}

/** \D Obtiene un valor complejo (Query) para uno de los elementos de la comparación

@param	itemType: Tipo de valor a obtener
@return	Valor obtenido
\end */
function oficial_tbnMore_clicked(itemType:String, currentValue:String):String
{
	var res:String = "";
	switch (itemType) {
		case "Query": {
			var f:Object = new FLFormSearchDB("tt_query");
			var curQuery:FLSqlCursor = f.cursor();
		
			curQuery.select();
			if (!curQuery.first())
				curQuery.setModeAccess(curQuery.Insert);
			else
				curQuery.setModeAccess(curQuery.Edit);
		
			f.setMainWidget();
			curQuery.refreshBuffer();
			curQuery.setValueBuffer("xml", currentValue);
			res = f.exec("xml");
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
