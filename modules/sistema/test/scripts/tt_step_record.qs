/***************************************************************************
                 tt_steprecord.qs  -  description
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
	var tbnContainer:Object;
	var flactions:Array;
	var xmlAcciones:FLDomDocument;

	function oficial( context ) { interna( context ); } 
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function setContainer() {
		return this.ctx.oficial_setContainer();
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
/** \C Este formulario puede ser llamado desde la acción Abrir formulario de edición o desde la acción Cerrar formulario de edición. Si se abre desde esta última, los controles correspondientes a los campos --mode-- y --parameters-- son ocultados
\end */
function interna_init()
{
	var cursor:FLSqlCursor = this.cursor();
	this.iface.tbnContainer = this.child("tbnContainer");
	
	connect(this.iface.tbnContainer, "clicked()", this, "iface.setContainer");
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	
	if (cursor.action() == "tt_step_closerecord") {
		this.child("fdbMode").close();
		this.child("fdbParameters").close();
	}
	this.iface.bufferChanged("idmodule");
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_bufferChanged(fN:String)
{
	var cursor:FLSqlCursor = form.cursor();
	var util:FLUtil = new FLUtil;

	switch(fN) {
		/** \C La lista de acciones es la correspondiente al valor del campo --idmodule--
		*/
		case "idmodule":
			this.iface.flactions = [];
			var contenido:String = util.sqlSelect("flfiles", "contenido", 
				"nombre = '" + cursor.valueBuffer("idmodule") + ".xml'")
			if (!contenido) 
				return;
			this.iface.xmlAcciones = new FLDomDocument();
			this.iface.xmlAcciones.setContent(contenido);
			var listaAcciones:FLDomNodeList = this.iface.xmlAcciones.elementsByTagName("action");
			for (var i = 0; i < listaAcciones.length(); i++) {
				this.iface.flactions[i] = listaAcciones.item(i).namedItem("name").toElement().text();
			}
		break;
	}
}

/** \D Establece una lista de opciones con todas las acciones disponibles para el módulo seleccionado
*/
function oficial_setContainer()
{
	var util:FLUtil = new FLUtil;
	var accion:String = Input.getItem(util.translate("scripts", "Selecciona la acción"), this.iface.flactions, "", false, "");
	this.child("fdbContainer").setValue(accion);
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
