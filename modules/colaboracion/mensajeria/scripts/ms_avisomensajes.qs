/***************************************************************************
                 ms_avisomensajes.qs  -  description
                             -------------------
    begin                : lun mar 22 2010
    copyright            : (C) 2010 by InfoSiAL S.L.
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
	function init() {
		this.ctx.interna_init();
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	function oficial( context ) { interna( context ); }
	function mostrarMensaje() {
		return this.ctx.oficial_mostrarMensaje();
	}
	function abrirMensajes() {
		return this.ctx.oficial_abrirMensajes();
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

////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/** @class_definition interna */
//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
function interna_init()
{
	var util:FLUtil = new FLUtil();

	connect(this.child("tdbMensajes"),"currentChanged()", this, "iface.mostrarMensaje");
	connect(this.child("tbnMensajes"), "clicked()", this, "abrirMensajes");

	var filtro:String = "propietario = '" + sys.nameUser() + "' AND avisar";
	this.child("tdbMensajes").cursor().setMainFilter(filtro);
	this.child("tdbMensajes").refresh();

	var cursor:FLSqlCursor = new FLSqlCursor("empresa");
	if(cursor.transactionLevel() != 0)
		this.child("tbnMensajes").setDisabled(true);

// 	util.sqlUpdate("ms_mensajes","avisar",false,"propietario = '" + sys.nameUser() + "'");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_mostrarMensaje()
{
	var util:FLUtil;

	var idMensaje:Number = this.cursor().valueBuffer("idmensaje");
	if(!idMensaje) {
		this.child("tlbDetallesMensaje").text = ""
		this.child("tlbMensaje").text = "";
		return;
	}

	var curMS:FLSqlCursor = (flcolamens.iface.conexion_ ? new FLSqlCursor("ms_mensajes",flcolamens.iface.conexion_) : new FLSqlCursor("ms_mensajes"));
	curMS.select("idmensaje = " + idMensaje);
	curMS.first();
	curMS.setModeAccess(curMS.Edit);
	curMS.refreshBuffer();

	var destino:String = curMS.valueBuffer("grupodestino");
	if(!destino || destino == "")
		destino = curMS.valueBuffer("usuariodestino");
	
	var detalles:String = "<b>De: </b>" + curMS.valueBuffer("origen") + "<b>  Para: </b>" + destino + "<b>  Fecha: </b>  " + util.dateAMDtoDMA(curMS.valueBuffer("fecha")) + "<b>  Hora: </b> " + curMS.valueBuffer("hora").toString().right(8) + "<br><b>Asunto: </b>" + curMS.valueBuffer("asunto");

	this.child("tlbDetallesMensaje").text = detalles;
	this.child("tlbMensaje").text = curMS.valueBuffer("contenido");
}

function abrirMensajes()
{
	if (flcolamens.iface.fMensajes_) {
		try {
			flcolamens.iface.fMensajes_.close();
			flcolamens.iface.fMensajes_ = false;
		} catch (e) {}
	}
	
	var formInbox = new FLFormDB( "ms_mensajes", 0, 1 );
	formInbox.setMainWidget();
	formInbox.show();

// 	if(!formms_mensajes.iface.pub_formularioAbierto()) {
// 		var formInbox = new FLFormDB( "ms_mensajes", 0, 1 );
// 		formInbox.setMainWidget();
// 		formInbox.show();
// 	}
	this.close();
	
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////