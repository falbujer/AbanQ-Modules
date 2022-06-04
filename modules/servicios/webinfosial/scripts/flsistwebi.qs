/***************************************************************************
                 flsistwebi.qs  -  description
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

	function afterCommit_wi_historicosped(curHis:FLSqlCursor) {
		return this.ctx.interna_afterCommit_wi_historicosped(curHis);
	}	

	function beforeCommit_wi_apartados(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_wi_apartados(cursor);
	}

	function beforeCommit_wi_categoriasenlaces(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_wi_categoriasenlaces(cursor);
	}

	function beforeCommit_wi_consultas(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_wi_consultas(cursor);
	}

	function beforeCommit_wi_enlaces(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_wi_enlaces(cursor);
	}

	function beforeCommit_wi_idiomas(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_wi_idiomas(cursor);
	}

	function beforeCommit_wi_menuitems(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_wi_menuitems(cursor);
	}

	function beforeCommit_wi_modulosart(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_wi_modulosart(cursor);
	}

	function beforeCommit_wi_modulosfam(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_wi_modulosfam(cursor);
	}

	function beforeCommit_wi_modulosweb(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_wi_modulosweb(cursor);
	}

	function beforeCommit_wi_noticias(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_wi_noticias(cursor);
	}

	function beforeCommit_wi_secciones(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_wi_secciones(cursor);
	}

	function beforeCommit_wi_traducciones(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_wi_traducciones(cursor);
	}

	function beforeCommit_wi_usuarios(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_wi_usuarios(cursor);
	}

	function beforeCommit_wi_ramasusuarios(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_wi_ramasusuarios(cursor);
	}
	
	function beforeCommit_wi_docprivadausuarios(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_wi_docprivadausuarios(cursor);
	}

	function beforeCommit_wi_faqs(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_wi_faqs(cursor);
	}


	function afterCommit_wi_apartados(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_wi_apartados(cursor);
	}

	function afterCommit_wi_categoriasenlaces(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_wi_categoriasenlaces(cursor);
	}

	function afterCommit_wi_consultas(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_wi_consultas(cursor);
	}

	function afterCommit_wi_enlaces(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_wi_enlaces(cursor);
	}

	function afterCommit_wi_idiomas(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_wi_idiomas(cursor);
	}

	function afterCommit_wi_menuitems(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_wi_menuitems(cursor);
	}

	function afterCommit_wi_modulosart(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_wi_modulosart(cursor);
	}

	function afterCommit_wi_modulosfam(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_wi_modulosfam(cursor);
	}

	function afterCommit_wi_modulosweb(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_wi_modulosweb(cursor);
	}

	function afterCommit_wi_noticias(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_wi_noticias(cursor);
	}

	function afterCommit_wi_secciones(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_wi_secciones(cursor);
	}

	function afterCommit_wi_traducciones(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_wi_traducciones(cursor);
	}

	function afterCommit_wi_usuarios(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_wi_usuarios(cursor);
	}

	function afterCommit_wi_ramasusuarios(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_wi_ramasusuarios(cursor);
	}

	function afterCommit_wi_docprivadausuarios(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_wi_docprivadausuarios(cursor);
	}

	function afterCommit_wi_faqs(cursor:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_wi_faqs(cursor);
	}

}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	function oficial( context ) { interna( context ); } 
	function ejecutarComando(comando:String):Array {
		return this.ctx.oficial_ejecutarComando(comando);
	}
	function setModificado(cursor:FLSqlCursor)  {
		return this.ctx.interna_setModificado(cursor);
	}
	function setBorrado(cursor:FLSqlCursor, campoClave:String)  {
		return this.ctx.interna_setBorrado(cursor, campoClave);
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
	function pub_ejecutarComando(comando:String):Array {
		return this.ejecutarComando(comando);
	}
	function pub_setModificado(cursor:FLSqlCursor)  {
		return this.setModificado(cursor);
	}
	function pub_setBorrado(cursor:FLSqlCursor, campoClave:String)  {
		return this.setBorrado(cursor, campoClave);
	}
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
}

function interna_beforeCommit_wi_apartados(cursor:FLSqlCursor):Boolean {
	this.iface.setModificado(cursor);
}

function interna_beforeCommit_wi_categoriasenlaces(cursor:FLSqlCursor):Boolean {
	this.iface.setModificado(cursor);
}

function interna_beforeCommit_wi_consultas(cursor:FLSqlCursor):Boolean {
	this.iface.setModificado(cursor);
}

function interna_beforeCommit_wi_enlaces(cursor:FLSqlCursor):Boolean {
	this.iface.setModificado(cursor);
}

function interna_beforeCommit_wi_idiomas(cursor:FLSqlCursor):Boolean {
	this.iface.setModificado(cursor);
}

function interna_beforeCommit_wi_menuitems(cursor:FLSqlCursor):Boolean {
	this.iface.setModificado(cursor);
}

function interna_beforeCommit_wi_modulosart(cursor:FLSqlCursor):Boolean {
	this.iface.setModificado(cursor);
}

function interna_beforeCommit_wi_modulosfam(cursor:FLSqlCursor):Boolean {
	this.iface.setModificado(cursor);
}

function interna_beforeCommit_wi_modulosweb(cursor:FLSqlCursor):Boolean {
	this.iface.setModificado(cursor);
}

function interna_beforeCommit_wi_noticias(cursor:FLSqlCursor):Boolean {
	this.iface.setModificado(cursor);
}

function interna_beforeCommit_wi_opciones(cursor:FLSqlCursor):Boolean {
	this.iface.setModificado(cursor);
}

function interna_beforeCommit_wi_secciones(cursor:FLSqlCursor):Boolean {
	this.iface.setModificado(cursor);
}

function interna_beforeCommit_wi_traducciones(cursor:FLSqlCursor):Boolean {
	this.iface.setModificado(cursor);
}

function interna_beforeCommit_wi_usuarios(cursor:FLSqlCursor):Boolean {
	this.iface.setModificado(cursor);
}

function interna_beforeCommit_wi_ramasusuarios(cursor:FLSqlCursor):Boolean {
	this.iface.setModificado(cursor);
}

function interna_beforeCommit_wi_docprivadausuarios(cursor:FLSqlCursor):Boolean {
	this.iface.setModificado(cursor);
}

function interna_beforeCommit_wi_faqs(cursor:FLSqlCursor):Boolean {
	this.iface.setModificado(cursor);
}



function interna_afterCommit_wi_apartados(cursor:FLSqlCursor):Boolean {
	this.iface.setBorrado(cursor);
}

function interna_afterCommit_wi_categoriasenlaces(cursor:FLSqlCursor):Boolean {
	this.iface.setBorrado(cursor);
}

function interna_afterCommit_wi_consultas(cursor:FLSqlCursor):Boolean {
	this.iface.setBorrado(cursor);
}

function interna_afterCommit_wi_enlaces(cursor:FLSqlCursor):Boolean {
	this.iface.setBorrado(cursor);
}

function interna_afterCommit_wi_idiomas(cursor:FLSqlCursor):Boolean {
	this.iface.setBorrado(cursor);
}

function interna_afterCommit_wi_menuitems(cursor:FLSqlCursor):Boolean {
	this.iface.setBorrado(cursor);
}

function interna_afterCommit_wi_modulosart(cursor:FLSqlCursor):Boolean {
	this.iface.setBorrado(cursor);
}

function interna_afterCommit_wi_modulosfam(cursor:FLSqlCursor):Boolean {
	this.iface.setBorrado(cursor);
}

function interna_afterCommit_wi_modulosweb(cursor:FLSqlCursor):Boolean {
	this.iface.setBorrado(cursor);
}

function interna_afterCommit_wi_noticias(cursor:FLSqlCursor):Boolean {
	this.iface.setBorrado(cursor);
}

function interna_afterCommit_wi_opciones(cursor:FLSqlCursor):Boolean {
	this.iface.setBorrado(cursor);
}

function interna_afterCommit_wi_secciones(cursor:FLSqlCursor):Boolean {
	this.iface.setBorrado(cursor);
}

function interna_afterCommit_wi_traducciones(cursor:FLSqlCursor):Boolean {
	this.iface.setBorrado(cursor);
}

function interna_afterCommit_wi_usuarios(cursor:FLSqlCursor):Boolean {
	this.iface.setModificado(cursor);
}

function interna_afterCommit_wi_ramasusuarios(cursor:FLSqlCursor):Boolean {
	this.iface.setModificado(cursor);
}

function interna_afterCommit_wi_docprivadausuarios(cursor:FLSqlCursor):Boolean {
	this.iface.setModificado(cursor);
}

function interna_afterCommit_wi_faqs(cursor:FLSqlCursor):Boolean {
	this.iface.setModificado(cursor);
}



/** \C Se establece el estado del subproyecto como el estado resultante
del histórico
\end */
function interna_afterCommit_wi_historicosped(curHis:FLSqlCursor)
{
	var util:FLUtil = new FLUtil();
	
	switch (curHis.modeAccess()) {
		case curHis.Insert:
		case curHis.Edit: {
			if (curHis.valueBuffer("estado") != curHis.valueBufferCopy("estado")) {
				var estado:String = util.sqlSelect("wi_historicosped", "estado", "idpedido = '" + curHis.valueBuffer("idpedido") + "' order by fecha desc, id desc");
				if (!curHis.cursorRelation())
					return false;
				curHis.cursorRelation().setValueBuffer("estado", estado);
			}
			break;
		}
	}
	
	return true;
}	

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

/** \D Marca el registro como modificado. Se utiliza para actualizar los datos en
la base de datos remota
*/
function interna_setModificado(cursor:FLSqlCursor) 
{
	if (!cursor.isModifiedBuffer())
		return;
	
	if (!cursor.valueBuffer("publico") && (cursor.valueBufferCopy("publico") == cursor.valueBuffer("publico")))
		return;
	
	var curMod:FLSqlCursor = new FLSqlCursor("wi_modificados");
	curMod.select("tabla = '" + cursor.table() + "' AND clave = '" + cursor.valueBuffer(cursor.primaryKey()) + "'")
	
	if (!curMod.first()) {
		curMod.setModeAccess(curMod.Insert);
		curMod.refreshBuffer();
		curMod.setValueBuffer("tabla", cursor.table());
		curMod.setValueBuffer("clave", cursor.valueBuffer(cursor.primaryKey()));
		curMod.setValueBuffer("modificado", true);
		curMod.setValueBuffer("borrado", false);
		curMod.commitBuffer();
	}
}

/** \D Marca el registro como borrado. Se utiliza para actualizar los datos en
la base de datos remota
*/
function interna_setBorrado(cursor:FLSqlCursor, campoClave:String)
{
	if (cursor.modeAccess() != cursor.Del)
		return;
		
	if (!campoClave)
		campoClave = cursor.primaryKey();
		
	var curMod:FLSqlCursor = new FLSqlCursor("wi_modificados");
	curMod.select("tabla = '" + cursor.table() + "' AND clave = '" + cursor.valueBuffer(campoClave) + "'")
	
	if (curMod.first()) {
		curMod.setModeAccess(curMod.Edit);
		curMod.refreshBuffer();
		curMod.setValueBuffer("borrado", true);
		curMod.commitBuffer();
	}
	
	else {
		curMod.setModeAccess(curMod.Insert);
		curMod.refreshBuffer();
		curMod.setValueBuffer("tabla", cursor.table());
		curMod.setValueBuffer("clave", cursor.valueBuffer(campoClave));
		curMod.setValueBuffer("modificado", true);
		curMod.setValueBuffer("borrado", true);
		curMod.commitBuffer();
	}
}

function oficial_ejecutarComando(comando:String):Array
{
	var res:Array = [];
	Process.execute(comando);
	if (Process.stderr != "") {
		res["ok"] = false;
		res["salida"] = Process.stderr;
	} else {
		res["ok"] = true;
		res["salida"] = Process.stdout;
	}

	return res;
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
