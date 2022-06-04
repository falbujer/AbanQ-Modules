/***************************************************************************
                 tt_config.qs  -  description
                             -------------------
    begin                : mar jul 04 2005
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
    function main() { this.ctx.interna_main(); }
	function init() { this.ctx.interna_init(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
    function oficial( context ) { interna( context ); }
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends oficial {
	var pathLocal:String;
	var idFuncional:String;
	function head( context ) { oficial ( context ); }
	function main() {
		return this.ctx.head_main();
	}
	function init() {
		return this.ctx.head_init();
	}
	function cambiarDirLocal_clicked() {
		return this.ctx.head_cambiarDirLocal_clicked();
	}
	function cambiarIdFuncional_clicked() {
		return this.ctx.head_cambiarIdFuncional_clicked();
	}
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

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
/** \C Muestra los valores actuales para los parámetros de configuración del módulo de pruebas
\end */
function head_init()
{
	this.iface.pathLocal = fltestppal.iface.pub_obtenerPathLocal();
	this.iface.idFuncional = fltestppal.iface.pub_obtenerIdFuncional();
	this.child("lblValorDirLocal").text = this.iface.pathLocal;
	this.child("lblValorIdFuncional").text = this.iface.idFuncional;
	connect(this.child("pbnCambiarDirLocal"), "clicked()", this, "iface.cambiarDirLocal_clicked()");
	connect(this.child("pbnCambiarIdFuncional"), "clicked()", this, "iface.cambiarIdFuncional_clicked()");
}

/** \D Llama a la función de cambio del directorio de trabajo del script principal
\end */
function head_cambiarDirLocal_clicked()
{
	fltestppal.iface.pub_cambiarPathLocal(this.iface.pathLocal);
	this.iface.pathLocal = fltestppal.iface.pub_obtenerPathLocal();
	this.child("lblValorDirLocal").text = this.iface.pathLocal;
}

/** \D Llama a la función de cambio de la funcionalidad de trabajo del script principal
\end */
function head_cambiarIdFuncional_clicked()
{
	fltestppal.iface.pub_cambiarIdFuncional(this.iface.idFuncional);
	this.iface.idFuncional = fltestppal.iface.pub_obtenerIdFuncional();
	this.child("lblValorIdFuncional").text = this.iface.idFuncional;
}

/** \D Lanza un formulario de búsqueda que muestra los datos de los parámetros de configuración del módulo de pruebas
*/
function head_main()
{
	var f:Object = new FLFormSearchDB("tt_config");
	var cursor:FLSqlCursor = f.cursor();

	cursor.select();
	if (!cursor.first())
		cursor.setModeAccess(cursor.Insert);
	else
		cursor.setModeAccess(cursor.Edit);
	f.setMainWidget();
	if (cursor.modeAccess() == cursor.Insert)
		f.child("pushButtonCancel").setDisabled(true);
	cursor.refreshBuffer();
	var commitOk:Boolean = false;
	var acpt:Boolean;
	cursor.transaction(false);
	while (!commitOk) {
		acpt = false;
		f.exec("idconfig");
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

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////