/***************************************************************************
                 wi_capturas.qs  -  description
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

/** @file */

/** @class_declaration interna */
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

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	function oficial( context ) { interna( context ); } 
	function nextCodigo() {
		return this.ctx.oficial_nextCodigo();
	}
	function seleccionarImagen() {
		return this.ctx.oficial_seleccionarImagen();
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends oficial {
    function head( context ) { oficial ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
    function ifaceCtx( context ) { head( context ); }
}

const iface = new ifaceCtx( this );
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition interna */
////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////

function interna_init()
{
	var cursor:FLSqlCursor = this.cursor();
	
	connect(this.child("pbnImagen"), "clicked()", this, "iface.seleccionarImagen");
	if (cursor.modeAccess() == cursor.Insert)
		this.iface.nextCodigo();
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_nextCodigo()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	var referencia = cursor.valueBuffer("referencia");
	
	var maxCodigo:String = util.sqlSelect("wi_capturas", "max(codigo)", "referencia = '" + referencia + "'");
	if (!maxCodigo)
		maxCodigo = 0;
	var nextCodigo:Number = parseFloat(maxCodigo);
	nextCodigo++;
	
	maxCodigo = nextCodigo.toString();
	for ( var i:Number = 0; i < (2 - nextCodigo.toString().length); i++)
		maxCodigo = "0" + maxCodigo;
			
	cursor.setValueBuffer("codigo", maxCodigo);
}

function oficial_seleccionarImagen()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	var archivo:String = FileDialog.getOpenFileName("*.jpg;*.png;*.gif", util.translate("scripts","Elegir Fichero"));
			
	if (!archivo)
		return;
		
	var file = new File( archivo );
	var extension:String = file.extension;

	var rutaDestino:String = util.sqlSelect("wi_opciones", "rutaweb", "1 = 1");
	rutaDestino += "images/capturas/" + cursor.valueBuffer("referencia") + "_" + cursor.valueBuffer("codigo") + "." + extension;

	var comando:String = "cp " + archivo + " " + rutaDestino;
	flsistwebi.iface.pub_ejecutarComando(comando);
	
	if (File.exists(rutaDestino)) {
		MessageBox.information(util.translate("scripts", "Se copió correctamente la imagen en la página web"), MessageBox.Ok, MessageBox.NoButton);
	}
	else {
		MessageBox.warning(util.translate("scripts", "No se pudo copiar la imagen en la página web"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	
	return true;	
}

//// OFICIAL /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
//////////////////////////////////////////////////////////////