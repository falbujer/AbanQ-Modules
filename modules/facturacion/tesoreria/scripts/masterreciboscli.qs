/***************************************************************************
                 masterreciboscli.qs  -  description
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
	function imprimir(codRecibo:String) {
		return this.ctx.oficial_imprimir(codRecibo)
	}
	function dameParamInforme(idRecibo) {
		return this.ctx.oficial_dameParamInforme(idRecibo);
	}
	function filtrarTabla() {
		return this.ctx.oficial_filtrarTabla();
	}
	function filtroTabla() {
		return this.ctx.oficial_filtroTabla();
	}
	function dameEstadosPtes() {
		return this.ctx.oficial_dameEstadosPtes();
	}
	function tbnGrupo_clicked() {
		return this.ctx.oficial_tbnGrupo_clicked();
	}
	function tbnQuitarGrupo_clicked() {
		return this.ctx.oficial_tbnQuitarGrupo_clicked();
	}
	function tbnMulti_clicked() {
		return this.ctx.oficial_tbnMulti_clicked();
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
	function pub_imprimir(codRecibo:String) {
		return this.imprimir(codRecibo);
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
	var _i = this.iface;
	this.child("tableDBRecords").setEditOnly(true);
	connect(this.child("toolButtonPrint"), "clicked()", _i, "imprimir");
	connect(this.child("chkPendientes"), "clicked()", _i, "filtrarTabla");
	connect(this.child("tbnGrupo"), "clicked()", _i, "tbnGrupo_clicked");
	connect(this.child("tbnQuitarGrupo"), "clicked()", _i, "tbnQuitarGrupo_clicked");
	connect(this.child("tbnMulti"), "clicked()", _i, "tbnMulti_clicked");
	
	_i.filtrarTabla()
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D
Crea un informe con el listado de registros de la remesa. Funciona cuando está cargado el módulo de informes
\end */
function oficial_imprimir(codRecibo)
{
	if (sys.isLoadedModule("flfactinfo")) {
		var idRecibo, codigo;
		if (codRecibo) {
			codigo = codRecibo;
			idRecibo = util.sqlSelect("reciboscli", "idrecibo","codigo = '" + codigo + "'");
		} else {
			var cursor = this.cursor();
			if (!cursor.isValid()) {
				return;
			}
			codigo = this.cursor().valueBuffer("codigo");
			idRecibo = this.cursor().valueBuffer("idrecibo");
		}
		if (!idRecibo) {
			return;
		}
		
		var oParam = this.iface.dameParamInforme(idRecibo);
		var curImprimir:FLSqlCursor = new FLSqlCursor("i_reciboscli");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("d_reciboscli_codigo", codigo);
		curImprimir.setValueBuffer("h_reciboscli_codigo", codigo);
		flfactinfo.iface.pub_lanzaInforme(curImprimir, oParam);
	} else {
		flfactppal.iface.pub_msgNoDisponible("Informes");
	}
}

function oficial_dameParamInforme(idRecibo)
{
	var util = new FLUtil;
	var oParam = flfactinfo.iface.pub_dameParamInforme();
	oParam.nombreInforme = "i_reciboscli";
	
	return oParam;
}

function oficial_filtrarTabla()
{
	var _i = this.iface;
  var filtro = _i.filtroTabla();
  this.cursor().setMainFilter(filtro);
	this.child("tableDBRecords").refresh();
  return true;
}

function oficial_filtroTabla()
{
  var _i = this.iface;
  var filtro = "";
	var ptes = this.child("chkPendientes").checked;
	if (ptes) {
    filtro = "estado IN (" + _i.dameEstadosPtes() + ")";
  }
  return filtro;
}

function oficial_dameEstadosPtes()
{
	return "'Emitido', 'Devuelto', 'Remesado'";
}

function oficial_tbnGrupo_clicked()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var oParam = new Object;
	oParam.errorMsg = sys.translate("Error al crear el grupo de recibos");
	
	var f;
	if (this.child("tbnMulti").on) {
		oParam.aRecibos = this.child("tableDBRecords").primarysKeysChecked();
		debug("oParam.aRecibos.length " + oParam.aRecibos.length);
		if (!oParam.aRecibos || oParam.aRecibos.length == 0) {
			return;
		}
		f = new Function("oParam", "return flfactteso.iface.pub_creaGrupoRecibosMultiCli(oParam)");
	} else {
		oParam.idRecibo = cursor.valueBuffer("idrecibo");
		if (!oParam.idRecibo) {
			return;
		}
		f = new Function("oParam", "return flfactteso.iface.pub_creaGrupoRecibosCli(oParam)");
	}
	if (!sys.runTransaction(f, oParam)) {
		return false;
	}
// 	if (!flfactteso.iface.pub_creaGrupoRecibosCli(oParam)) {
// 		return false;
// 	}
	this.child("tableDBRecords").clearChecked();
	this.child("tableDBRecords").refresh();
	var res = MessageBox.information(sys.translate("Se ha creado el grupo de recibos %1.\n¿Desea editarlo?").arg(oParam.codGrupo), MessageBox.Yes, MessageBox.No, MessageBox.NoButton, "AbanQ");
	if (res != MessageBox.Yes) {
		return false;
	}
	var curG = new FLSqlCursor("reciboscli");
	curG.select("idrecibo = " + oParam.idGrupo);
	if (!curG.first()) {
		return false;
	}
	curG.editRecord();
}

function oficial_tbnQuitarGrupo_clicked()
{
debug("oficial_tbnQuitarGrupo_clicked");
	var _i = this.iface;
	var cursor = this.cursor();
	
	var estado = cursor.valueBuffer("estado");
	if (estado != "Emitido") {
		MessageBox.warning(sys.translate("Sólo puede eliminar grupos de recibos en estado Emitido"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
		return false;
	}
	var idFactura = cursor.valueBuffer("idfactura");
	if (idFactura) {
		MessageBox.warning(sys.translate("El registro seleccionado no corresponde a un grupo de recibos"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
		return false;
	}
	
	var oParam = new Object;
	oParam.idGrupo = cursor.valueBuffer("idrecibo");
	if (!oParam.idGrupo) {
		return;
	}
	oParam.errorMsg = sys.translate("Error al eliminar el grupo de recibos");
	var f = new Function("oParam", "return flfactteso.iface.pub_quitaGrupoRecibosCli(oParam)");
	if (!sys.runTransaction(f, oParam)) {
		return false;
	}
// 	if (!flfactteso.iface.pub_quitaGrupoRecibosCli(oParam)) {
// 		return false;
// 	}
	var codGrupo = cursor.valueBuffer("codigo");
	MessageBox.information(sys.translate("Se ha eliminado el grupo de recibos %1").arg(codGrupo), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
	
	this.child("tableDBRecords").refresh();
}

function oficial_tbnMulti_clicked()
{
	if (this.child("tbnMulti").on) {
		this.child("tableDBRecords").setCheckColumnEnabled(true);
		this.child("tableDBRecords").setAliasCheckColumn("Sel");
	} else {
		this.child("tableDBRecords").clearChecked();
		this.child("tableDBRecords").setCheckColumnEnabled(false);
	}
	this.child("tableDBRecords").refresh(true, true);
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
