/***************************************************************************
                 do_mastergenerardoc.qs  -  description
                             -------------------
    begin                : lun sep 21 2004
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

////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/** @class_declaration interna */
//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
class interna {
    var ctx:Object;
    function interna( context ) { this.ctx = context; }
    function init() { this.ctx.interna_init(); }
    function main() { this.ctx.interna_main(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
    function oficial( context ) { interna( context ); } 
	function cambiarDirModulos() { return this.ctx.oficial_cambiarDirModulos() ;}
	function cambiarDirSistema() { return this.ctx.oficial_cambiarDirSistema() ;}
	function cambiarDirDestino() { return this.ctx.oficial_cambiarDirDestino() ;}
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

////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/** @class_definition interna */
//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////

function init() {
    this.iface.init();
}

function main() {
    this.iface.main();
}

function interna_init() {
	
	var util:FLUtil = new FLUtil();
	
	this.child("lblDirModulos").text = util.readSettingEntry("scripts/fldocuppal/dirModulos");
	this.child("lblDirSistema").text = util.readSettingEntry("scripts/fldocuppal/dirSistema");
	this.child("lblDirDestino").text = util.readSettingEntry("scripts/fldocuppal/dirDestino");

	connect( this.child( "pbnCambiarDirModulos" ), "clicked()", this, "iface.cambiarDirModulos" );
	connect( this.child( "pbnCambiarDirSistema" ), "clicked()", this, "iface.cambiarDirSistema" );
	connect( this.child( "pbnCambiarDirDestino" ), "clicked()", this, "iface.cambiarDirDestino" );
}

function interna_main()
{
	var f = new FLFormSearchDB("do_opciones");
	var cursor:FLSqlCursor = f.cursor();

	cursor.select();
	if (!cursor.first())
			cursor.setModeAccess(cursor.Insert);
	else
			cursor.setModeAccess(cursor.Edit);

	f.setMainWidget();
	cursor.refreshBuffer();
	var commitOk:Boolean = false;
	var acpt:Boolean;
	cursor.transaction(false);
	while (!commitOk) {
		acpt = false;
		f.exec("rutamodulos");
		acpt = f.accepted();
		if (!acpt) {
			if (cursor.rollback())
					commitOk = true;
		} else {
			if (cursor.commitBuffer()) {
					cursor.commit();
					commitOk = true;
			}
		}
		f.close();
	}
}


//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_cambiarDirModulos()
{
	var util:FLUtil = new FLUtil();
	var ruta:String = FileDialog.getExistingDirectory( util.translate( "scripts", "" ), util.translate( "scripts", "RUTA A LOS MODULOS" ) );
	
	if ( !File.isDir( ruta ) ) {
		MessageBox.information( util.translate( "scripts", "Ruta errónea" ),
								MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return;
	}
	this.child("lblDirModulos").text = ruta;
	util.writeSettingEntry("scripts/fldocuppal/dirModulos", ruta);
}

function oficial_cambiarDirSistema()
{
	var util:FLUtil = new FLUtil();
	var ruta:String = FileDialog.getExistingDirectory( util.translate( "scripts", "" ), util.translate( "scripts", "RUTA AL MÓDULO DE SISTEMA" ) );
	
	if ( !File.isDir( ruta ) ) {
		MessageBox.information( util.translate( "scripts", "Ruta errónea" ),
								MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return;
	}
	this.child("lblDirSistema").text = ruta;
	util.writeSettingEntry("scripts/fldocuppal/dirSistema", ruta);
}

function oficial_cambiarDirDestino()
{
	var util:FLUtil = new FLUtil();
	var ruta:String = FileDialog.getExistingDirectory( util.translate( "scripts", "" ), util.translate( "scripts", "RUTA DE DESTINO" ) );
	
	if ( !File.isDir( ruta ) ) {
		MessageBox.information( util.translate( "scripts", "Ruta errónea" ),
								MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return;
	}
	this.child("lblDirDestino").text = ruta;
	util.writeSettingEntry("scripts/fldocuppal/dirDestino", ruta);
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
