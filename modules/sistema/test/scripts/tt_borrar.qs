/***************************************************************************
                 tt_importar.qs  -  description
                             -------------------
    begin                : jue abr 9 2005
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

/** @class_declaration interna */
////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

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
	var myUtil:FLUtil = new FLUtil();
	var bloqueo:Boolean;
	
	function oficial( context ) { interna( context ); }
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function borrarTabla(tabla:String, where:String):Boolean {
		return this.ctx.oficial_borrarTabla(tabla, where);
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

/** @class_declaration ifaceCtx*/
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

/** \C Borra las pruebas asociadasa a la funcionalidad indicada por el usuario
\end */
function interna_main()
{
	var util:FLUtil = new FLUtil();

	var f:Object = new FLFormSearchDB("tt_borrar");
	var cursor:FLSqlCursor = f.cursor();
	 
	cursor.select();
	if (!cursor.first())
		cursor.setModeAccess(cursor.Insert);
	else
		cursor.setModeAccess(cursor.Edit);
	f.setMainWidget();
	cursor.refreshBuffer();
	var idFuncional:String = f.exec("idfuncional");
	if (!f.accepted())
		return;
	
	var where:String = "";
	var resp:Number;
	if (!idFuncional || idFuncional == "") {
		if (!cursor.valueBuffer("todas"))
			return;
		resp = MessageBox.warning(this.iface.myUtil.translate( "scripts", "Va a borrar las pruebas de TODAS las funcionalidades de la base de datos.\n ¿está seguro?"), MessageBox.Yes, MessageBox.No);
	} else {
		where = "idfuncional= '" + idFuncional + "'";
		if (!this.iface.myUtil.sqlSelect("tt_testcat", "id", where)) {
			MessageBox.warning( idFuncional + this.iface.myUtil.translate( "scripts", " - Esta funcionalidad no existe en la base de datos"), MessageBox.Ok);
			return;
		}
		resp = MessageBox.warning( idFuncional + this.iface.myUtil.translate( "scripts", " - Va a borrar las pruebas asociadas a esta funcionalidad.\n ¿está seguro?"), MessageBox.Yes, MessageBox.No);
	}
	if (resp != MessageBox.Yes)
		return;

	f.close(); 

	var curTransaccion:FLSqlCursor = new FLSqlCursor("tt_testcat");
	curTransaccion.transaction(false);
	
	if (!this.iface.borrarTabla("tt_tcatscat", where)) {
		curTransaccion.rollback();
		return;
	}
	if (!this.iface.borrarTabla("tt_sessioncat", where)){
		curTransaccion.rollback();
		return;
	}
	if (!this.iface.borrarTabla("tt_testcat", where)){
		curTransaccion.rollback();
		return;
	}
	curTransaccion.commit();
	
	if (idFuncional)
		MessageBox.information(idFuncional + this.iface.myUtil.translate( "scripts"," - Las pruebas de esta funcionalidad han sido borradas correctamente" ), MessageBox.Ok);
	else
		MessageBox.information(this.iface.myUtil.translate( "scripts","Las pruebas han sido borradas correctamente" ), MessageBox.Ok);
}

/** \D Borra los registros de una tabla que cumplan una determinada condición

@param	tabla: Nombre de la tabla a borrar
@where	where: Cláusula WHERE que deben cumplir los registros borrados
@return	true si no hay error, false en caso contrario
\end */
function oficial_borrarTabla(tabla:String, where:String):Boolean
{
	var util:FLUtil = new FLUtil;
	var paso:Number = 0;
	var acumPaso:Number = 0;
	var numRegistros:Number;
	
	var cursor:FLSqlCursor = new FLSqlCursor(tabla);
	cursor.setActivatedCheckIntegrity(false);
	cursor.select(where);
	numRegistros = cursor.size();
	
	util.createProgressDialog( util.translate( "scripts", "Borrando tabla " ) + tabla, numRegistros );
	util.setProgress(1);
	
	while (cursor.next()) {
		cursor.setModeAccess(cursor.Del);
		cursor.refreshBuffer();
		if (!cursor.commitBuffer()) {
			cursor.setActivatedCheckIntegrity(true);
			return false;
		}
		if (++paso == 25) {
			acumPaso += paso;
			paso = 0;
			util.setProgress(acumPaso);
		}
	}
	util.setProgress( numRegistros );
	util.destroyProgressDialog();
	
	cursor.setActivatedCheckIntegrity(true);
	return true;
}

/** \C Establece el campo de funcionalidad con el valor de la funcionalidad actual
\end */
function interna_init()
{
	connect(this.cursor(), "bufferChanged(QString)", this, "iface.bufferChanged");
	this.iface.bloqueo = false;
	this.child("fdbIdFuncional").setValue(fltestppal.iface.pub_obtenerIdFuncional());
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \C Si el valor del campo --idfuncional-- está informado, el indicador --todas-- debe estar inactivo. De la misma forma, al activar el indicador --todas--, el valor del campo --idfuncional-- será borrado
\end */
function oficial_bufferChanged(fN:String)
{
	var cursor:FLSqlCursor = this.cursor();
	switch (fN) {
		case "idfuncional": {
			if (this.iface.bloqueo)
				return;
			var idFuncional:String = cursor.valueBuffer("idfuncional");
			this.iface.bloqueo = true;
			if (!idFuncional || !idFuncional.isEmpty())
				form.child("fdbTodas").setValue(false);
			this.iface.bloqueo = false;
			break;
		}
		case "todas": {
			if (this.iface.bloqueo)
				return;
			this.iface.bloqueo = true;
			if (cursor.valueBuffer("todas") == true)
				form.child("fdbIdFuncional").setValue("");
			this.iface.bloqueo = false;
			break;
		}
	}
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
