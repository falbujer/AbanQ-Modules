/***************************************************************************
                 masterarticulos.qs  -  description
                             -------------------
    begin                : jue jun 21 2007
    copyright            : (C) 2007 by InfoSiAL S.L.
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
    var pbnTransferir:Object;
	function oficial( context ) { interna( context ); } 
	function pbnActualizar_clicked() {
		return this.ctx.oficial_pbnActualizar_clicked();
	}
	function actualizarPreciosTarifa(codTarifa) {
		return this.ctx.oficial_actualizarPreciosTarifa(codTarifa);
	}
	function pvpTarifa(q, curTarifa) {
		return this.ctx.oficial_pvpTarifa(q, curTarifa);
	}
	function dameWhereAPT(codTarifa) {
		return this.ctx.oficial_dameWhereAPT(codTarifa);
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
/** \C La tabla de regularizaciones de stocks se muestra en modo de sólo lectura
\end */
function interna_init()
{
	connect(this.child("pbnActualizar"), "clicked()", this, "iface.pbnActualizar_clicked()");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_pbnActualizar_clicked()
{
	var cursor = this.cursor();
	var codTarifa = cursor.valueBuffer("codtarifa"); 
	if (!codTarifa) {
		return;
	}
	
	var res = MessageBox.information(sys.translate("Se van a actualizar los precios de los articulos para la tarifa %1. \nEsto sobreescribirá cualquier precio que haya sido modificado manualmente.\n¿Desea continuar?").arg(codTarifa), MessageBox.Yes, MessageBox.No);
	if (res != MessageBox.Yes) {
		return false;
	}
	
	var oParam = new Object;
	oParam.errorMsg = sys.translate("Error al generar la tarifa %1").arg(codTarifa);
	oParam.codTarifa = codTarifa;
	var f = new Function("oParam", "return formtarifas.iface.actualizarPreciosTarifa(oParam)");
	if (!sys.runTransaction(f, oParam)) {
		return false;
	}
	
// 	var curCommit:FLSqlCursor = new FLSqlCursor("tarifas");
// 	var codTarifa:String = cursor.valueBuffer("codtarifa"); 
// 	
// 	
// 
// 	curCommit.transaction(false);
// 	try {
// 		if (this.iface.actualizarPreciosTarifa(codTarifa)) {
// 			curCommit.commit();
// 		} else {
// 			curCommit.rollback();
// 			return false;
// 		}
// 	} catch (e) {
// 		curCommit.rollback();
// 		MessageBox.critical(util.translate("scripts", "Hubo un error al actualizar los precios por tarifa: ") + e, MessageBox.Ok, MessageBox.NoButton);
// 		return false;
// 	}
	MessageBox.information(sys.translate("La tarifa %1 ha sido actualizada").arg(codTarifa), MessageBox.Ok, MessageBox.NoButton);
}

function oficial_dameWhereAPT(codTarifa)
{
	return "a.sevende";
}

function oficial_actualizarPreciosTarifa(oParam)
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var codTarifa = oParam.codTarifa;
	
	var w = _i.dameWhereAPT(codTarifa);
	
	var q = new FLSqlQuery;
	q.setSelect("a.referencia, a.pvp, at.id");
	q.setFrom("articulos a LEFT OUTER JOIN articulostarifas at ON (a.referencia = at.referencia AND at.codtarifa = '" + codTarifa + "')");
	q.setWhere(w);
	q.setForwardOnly(true);
	if (!q.exec()) {
		return false;
	}
	var curArt = new FLSqlCursor("articulostarifas");
	var id, referencia, p = 0;
	AQUtil.createProgressDialog(sys.translate("Actualizando tarifa..."), q.size());
	while (q.next()) {
		AQUtil.setProgress(p++)
		id = q.value("at.id");
		referencia = q.value("a.referencia");
		if (id) {
			curArt.select("id = " + id);
			if (!curArt.first()) {
				return false;
			}
			curArt.setModeAccess(curArt.Edit);
			curArt.refreshBuffer();
		} else {
			curArt.setModeAccess(curArt.Insert);
			curArt.refreshBuffer();
			curArt.setValueBuffer("referencia", referencia);
			curArt.setValueBuffer("codtarifa", codTarifa);
		}
		curArt.setValueBuffer("pvp", _i.pvpTarifa(q, cursor));
		if (!curArt.commitBuffer()) {
			sys.AQTimer.singleShot(0, AQUtil.destroyProgressDialog);
			return false;
		}
	}
	sys.AQTimer.singleShot(0, AQUtil.destroyProgressDialog);
	return true;
}

function oficial_pvpTarifa(q, curTarifa)
{
	var incLineal = parseFloat(curTarifa.valueBuffer("inclineal"));
	incLineal = isNaN(incLineal) ? 0 : incLineal;
	
	var incPorcentual = parseFloat(curTarifa.valueBuffer("incporcentual"));
	incPorcentual = isNaN(incPorcentual) ? 0 : incPorcentual;
	
	var pvp = q.value("a.pvp");
	pvp = isNaN(pvp) ? 0 : pvp;

	var pvpT = ((pvp * (100 + incPorcentual)) / 100) + incLineal;
	pvpT = AQUtil.roundFieldValue(pvpT, "articulostarifas", "pvp");
	return pvpT;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
