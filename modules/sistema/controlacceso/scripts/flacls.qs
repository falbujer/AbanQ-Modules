/***************************************************************************
                                 flacls.qs
                            -------------------
   begin                : mie ene 18 2006
   copyright            : (C) 2004-2006 by InfoSiAL S.L.
   email                : mail@infosial.com
***************************************************************************/
/***************************************************************************
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; version 2 of the License.               *
 ***************************************************************************/
/***************************************************************************
   Este  programa es software libre. Puede redistribuirlo y/o modificarlo
   bajo  los  terminos  de  la  Licencia  Pï¿?blica General de GNU   en  su
   versiï¿?n 2, publicada  por  la  Free  Software Foundation.
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
	function validateForm() { return this.ctx.interna_validateForm(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
  
  var areas_, modulos_, acciones_, accionesUsr_;
  var ultMod_, ultArea_, idAc_;
  var cA_ID_, cA_DES_, cA_READ_, cA_WRITE_;
  var cM_ID_, cM_DES_, cM_READ_, cM_WRITE_;
  var cO_ID_, cO_DES_, cO_READ_, cO_WRITE_;
  var curAcos_;

	var C_USGR:Number;
	var C_AREA:Number;
	var C_MODU:Number;
	var C_NOAC:Number;
	var C_LECT:Number;
	var C_LEES:Number;
	var C_PRIO:Number;
	var C_IDAR:Number;
	var C_IDMO:Number;
	var C_MODI:Number;

	var colorBlanco_;
	var colorRojo_;
	var colorVerde_;
	var colorAzul_;

	var tbnUp:Object;
	var tbnDown:Object;
	var tdbAcs:Object;
	var pbnRecargarListaGrupos:Object;
	var pbnGuardarListaGrupos:Object;
	var tblListasGrupos:QTable;
	var pbnRecargarListaUsuarios:Object;
	var pbnGuardarListaUsuarios:Object;
	var tblListasUsuarios:QTable;
	var tbwReglas:Object;

	function oficial( context ) { interna( context ); }
	function tbnUp_clicked() {
		this.ctx.oficial_tbnUp_clicked();
	}
	function tbnDown_clicked() {
		this.ctx.oficial_tbnDown_clicked();
	}
	function recargarListaGrupos() {
		this.ctx.oficial_recargarListaGrupos();
	}
	function guardarListaGrupos() {
		this.ctx.oficial_guardarListaGrupos();
	}
	function recargarListaUsuarios() {
		this.ctx.oficial_recargarListaUsuarios();
	}
	function guardarListaUsuarios() {
		this.ctx.oficial_guardarListaUsuarios();
	}
	function moveStep( direction:Number ) {
		this.ctx.oficial_moveStep( direction );
	}
	function clickedListaGrupos(fil:Number, col:Number) {
		return this.ctx.oficial_clickedListaGrupos(fil, col); 
	}
	function clickedListaUsuarios(fil:Number, col:Number) {
		return this.ctx.oficial_clickedListaUsuarios(fil, col); 
	}
	function crearTablas() {
		return this.ctx.oficial_crearTablas();
	}
  function colores() {
    return this.ctx.oficial_colores();
  }
  function cargaTabPpal() {
    return this.ctx.oficial_cargaTabPpal();
  }
  function cargaAreas() {
    return this.ctx.oficial_cargaAreas();
  }
  function muestraAreas() {
    return this.ctx.oficial_muestraAreas();
  }
  function cargaModulos() {
    return this.ctx.oficial_cargaModulos();
  }
  function muestraModulos() {
    return this.ctx.oficial_muestraModulos();
  }
  function muestraAcciones() {
    return this.ctx.oficial_muestraAcciones();
  }
  function tblAreas_currentChanged(f, c) {
    return this.ctx.oficial_tblAreas_currentChanged(f, c);
  }
  function tblModulos_currentChanged(f, c) {
    return this.ctx.oficial_tblModulos_currentChanged(f, c);
  }
  function cargaAreasExtra() {
    return this.ctx.oficial_cargaAreasExtra();
  }
  function cargaAcciones() {
    return this.ctx.oficial_cargaAcciones();
  }
  function procesaTextoAlias(alias) {
    return this.ctx.oficial_procesaTextoAlias(alias);
  }
  function cargaAccionesUsuario() {
    return this.ctx.oficial_cargaAccionesUsuario();
  }
  function tblModulos_doubleClicked(f, c) {
    return this.ctx.oficial_tblModulos_doubleClicked(f, c);
  }
  function tblAreas_doubleClicked(f, c) {
    return this.ctx.oficial_tblAreas_doubleClicked(f, c);
  }
  function tblAcciones_doubleClicked(f, c) {
    return this.ctx.oficial_tblAcciones_doubleClicked(f, c);
  }
  function actualizaPermisoArea(idArea, p) {
    return this.ctx.oficial_actualizaPermisoArea(idArea, p);
  }
  function actualizaPermisoModulo(idModulo, p) {
    return this.ctx.oficial_actualizaPermisoModulo(idModulo, p);
  }
  function actualizaPermisoAcos(nombre, p) {
    return this.ctx.oficial_actualizaPermisoAcos(nombre, p);
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
/** \C 
\end */
function interna_init()
{
	this.iface.tdbAcs = this.child( "tdbAcs" );
	this.iface.tbnUp = this.child( "tbnUp" );
	this.iface.tbnDown = this.child( "tbnDown" );
	this.iface.pbnRecargarListaGrupos = this.child( "pbnRecargarListaGrupos" );
	this.iface.pbnGuardarListaGrupos = this.child("pbnGuardarListaGrupos");
	this.iface.tblListasGrupos = this.child("tblListasGrupos");
	this.iface.pbnRecargarListaUsuarios = this.child( "pbnRecargarListaUsuarios" );
	this.iface.pbnGuardarListaUsuarios = this.child("pbnGuardarListaUsuarios");
	this.iface.tblListasUsuarios = this.child("tblListasUsuarios");
	this.iface.tbwReglas = this.child("tbwReglas");

	this.iface.pbnGuardarListaGrupos.setDisabled(true);
	this.iface.pbnGuardarListaUsuarios.setDisabled(true);

	connect ( this.iface.tbnUp, "clicked()", this, "iface.tbnUp_clicked" );
	connect ( this.iface.tbnDown, "clicked()", this, "iface.tbnDown_clicked" );
	
	connect ( this.iface.pbnRecargarListaGrupos, "clicked()", this, "iface.recargarListaGrupos" );
	connect ( this.iface.pbnGuardarListaGrupos, "clicked()", this, "iface.guardarListaGrupos" );
 	connect ( this.iface.tblListasGrupos, "clicked(int,int)", this, "iface.clickedListaGrupos");
	connect ( this.iface.pbnRecargarListaUsuarios, "clicked()", this, "iface.recargarListaUsuarios" );
	connect ( this.iface.pbnGuardarListaUsuarios, "clicked()", this, "iface.guardarListaUsuarios" );
 	connect ( this.iface.tblListasUsuarios, "clicked(int,int)", this, "iface.clickedListaUsuarios");
 	

	this.iface.crearTablas();
	this.iface.colores();
// 	for (numC = 0; numC < this.iface.tblListasGrupos.numCols(); numC++)
// 		this.iface.tblListasGrupos.setColumnReadOnly(numC, true);
// 	this.iface.tblListasGrupos.hideColumn(4);
// 	this.iface.tblListasGrupos.setColumnReadOnly(6, false);
	
// 	for (numC = 0; numC < this.iface.tblListasUsuarios.numCols(); numC++)
// 		this.iface.tblListasUsuarios.setColumnReadOnly(numC, true);
// 	this.iface.tblListasUsuarios.hideColumn(4);
// 	this.iface.tblListasUsuarios.setColumnReadOnly(6, false);
	
	if (this.cursor().modeAccess() ==  this.cursor().Edit) {
		this.iface.recargarListaGrupos();
		this.iface.recargarListaUsuarios();
	}
  var _i = this.iface;
  _i.cargaTabPpal();
}

function interna_validateForm()
{
	var cambioGrupos= false;
	var cambioUsuarios= false;

	for (numL = 0; numL < this.iface.tblListasGrupos.numRows(); numL++) {
		if (this.iface.tblListasGrupos.text(numL, this.iface.C_MODI)) {
			cambioGrupos = true;
		}
	}

	for (numL = 0; numL < this.iface.tblListasUsuarios.numRows(); numL++) {
		if (this.iface.tblListasUsuarios.text(numL, this.iface.C_MODI)) {
			cambioUsuarios = true;
		}
	}

	if (cambioUsuarios || cambioGrupos) {
		var util= new FLUtil();
		MessageBox.warning(util.translate("scripts", "Se han modificado algunos datos de grupos y/o usuarios.\nAntes de aceptar el formulario se deberán guardar los cambios"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	
	return true;
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_tbnUp_clicked()
{
	this.iface.moveStep( -1 );
}

function oficial_tbnDown_clicked()
{
	this.iface.moveStep( 1 );
}

function oficial_moveStep( direction:Number )
{
	var cursor= this.iface.tdbAcs.cursor();
	if (!cursor.isValid())
		return;

	var idacl= cursor.valueBuffer("idacl");
	if (!idacl)
		return;

	var prioridad= cursor.valueBuffer("prioridad");
	var prioridad2:Number;
	var row= this.iface.tdbAcs.currentRow();
	var util= new FLUtil();

	if (direction == -1)
		prioridad2 = util.sqlSelect("flacs", "prioridad",
		"idacl = '" + idacl + "' AND prioridad < " + prioridad +
		" ORDER BY prioridad DESC");
	else
		prioridad2 = util.sqlSelect("flacs", "prioridad",
		"idacl = '" + idacl + "' AND prioridad > " + prioridad +
		" ORDER BY prioridad");

	if (!prioridad2)
		return;

	var curAcs= new FLSqlCursor("flacs");
	curAcs.select("idacl = '" + idacl + "' AND prioridad = '" + prioridad2 + "'");
	if (!curAcs.first())
		return;

	curAcs.setModeAccess(curAcs.Edit);
	curAcs.refreshBuffer();
	curAcs.setValueBuffer("prioridad", "-1");
	curAcs.commitBuffer();

	cursor.setModeAccess(cursor.Edit);
	cursor.refreshBuffer();
	cursor.setValueBuffer("prioridad", prioridad2);
	cursor.commitBuffer();

	curAcs.select("idacl = '" + idacl + "' AND prioridad = -1");
	curAcs.first();
	curAcs.setModeAccess(curAcs.Edit);
	curAcs.refreshBuffer();
	curAcs.setValueBuffer("prioridad", prioridad);
	curAcs.commitBuffer();

	this.iface.tdbAcs.refresh();
	row += direction;
	this.iface.tdbAcs.setCurrentRow(row);
}

function oficial_recargarListaGrupos()
{
	var util= new FLUtil();
	
	if (this.iface.tblListasGrupos.numRows()) {
		res = MessageBox.information(util.translate("scripts", "A continuación se recargará la lista de reglas\nPerderá los cambios no guardados\n\n¿Continuar?"), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
		if (res != MessageBox.Yes)
			return;
	}
	
	var where= "1 = 1";
	var idAcl= this.cursor().valueBuffer("idacl");
	var prioridad;
	var prioridadDefecto= this.cursor().valueBuffer("prioridadgrupointro");
	var idGroupIntro= this.cursor().valueBuffer("idgroupintro");
	if (idGroupIntro)
		where = "idgroup = '" + idGroupIntro + "'";
	
	var fila= 0;
	var permiso= "";
	this.iface.tblListasGrupos.clear();
	
	var qG= new FLSqlQuery();
	qG.setTablesList("flgroups");
	qG.setFrom("flgroups");
	qG.setSelect("idgroup")
	qG.setWhere(where + " order by idgroup")
	
	var q= new FLSqlQuery();
	q.setTablesList("flareas,flmodules");
	q.setFrom("flareas a inner join flmodules m on a.idarea = m.idarea");
	q.setSelect("m.idarea,m.idmodulo,a.descripcion,m.descripcion")
	q.setWhere("1=1 order by a.descripcion,m.descripcion")
	
	qG.exec();
	while(qG.next()) {
		idGroupIntro = qG.value(0);
		q.exec();
		while(q.next()) {
		
			this.iface.tblListasGrupos.insertRows(fila, 1);		
	
			this.iface.tblListasGrupos.setText(fila, this.iface.C_USGR, idGroupIntro);
			this.iface.tblListasGrupos.setText(fila, this.iface.C_AREA, q.value(2));
			this.iface.tblListasGrupos.setText(fila, this.iface.C_MODU, q.value(3));
			this.iface.tblListasGrupos.setText(fila, this.iface.C_IDAR, q.value(0));
			this.iface.tblListasGrupos.setText(fila, this.iface.C_IDMO, q.value(1));
			
			permiso = util.sqlSelect("flacs a INNER JOIN flacos o ON a.idac = o.idac", "o.permiso", "a.idgroup = '" + idGroupIntro + "' AND degrupo = true AND a.idarea = 'sys' AND a.idmodule = 'sys' AND tipo = 'mainwindow' AND tipoform = 'Maestro' AND a.nombre = 'container' AND o.nombre = '" + q.value("m.idmodulo") + "'", "flacs,flacos");
			if (!permiso) {
				permiso = util.sqlSelect("flacs", "permiso", "idacl = '" + idAcl + "' AND idgroup = '" + idGroupIntro + "' AND degrupo = true and idmodule = '" + q.value("m.idmodulo") + "' AND tipo = 'mainwindow'");
			}
			var idModulo = q.value("m.idmodulo");
			switch(permiso) {
				case "--": {
					this.iface.tblListasGrupos.setText(fila, this.iface.C_NOAC, "XXX");
					this.iface.tblListasGrupos.setCellBackgroundColor(fila, this.iface.C_NOAC, this.iface.colorRojo_);
					this.iface.tblListasGrupos.setCellBackgroundColor(fila, this.iface.C_LECT, this.iface.colorBlanco_);
					this.iface.tblListasGrupos.setCellBackgroundColor(fila, this.iface.C_LEES, this.iface.colorBlanco_);
					break;
				}
				case "r-": {
					this.iface.tblListasGrupos.setText(fila, this.iface.C_LECT, "XXX");
					break;
				}
				default: {
					this.iface.tblListasGrupos.setText(fila, this.iface.C_LEES, "XXX");
					this.iface.tblListasGrupos.setCellBackgroundColor(fila, this.iface.C_LEES, this.iface.colorVerde_);
					this.iface.tblListasGrupos.setCellBackgroundColor(fila, this.iface.C_NOAC, this.iface.colorBlanco_);
					this.iface.tblListasGrupos.setCellBackgroundColor(fila, this.iface.C_LECT, this.iface.colorBlanco_);
				}
			}
			prioridad = util.sqlSelect("flacs a INNER JOIN flacos o ON a.idac = o.idac", "a.prioridad", "a.idgroup = '" + idGroupIntro + "' AND degrupo = true AND a.idarea = 'sys' AND a.idmodule = 'sys' AND tipo = 'mainwindow' AND tipoform = 'Maestro' AND a.nombre = 'container' AND o.nombre = '" + q.value("m.idmodulo") + "'", "flacs,flacos");
			if (!prioridad) {
				prioridad = parseFloat(util.sqlSelect("flacs", "prioridad", "idacl = '" + idAcl + "' AND idgroup = '" + idGroupIntro + "' AND degrupo = true and idmodule = '" + q.value("m.idmodulo") + "' AND tipo = 'mainwindow'"));
			}
			if (!prioridad) {
				prioridad = prioridadDefecto;
			}
			if (!prioridad) {
				prioridad = 1;
			}
			
			this.iface.tblListasGrupos.setText(fila, this.iface.C_PRIO, prioridad);
			this.iface.tblListasGrupos.setCellBackgroundColor(fila, this.iface.C_PRIO, this.iface.colorBlanco_);
			
			fila++;
		}
	
		this.iface.tblListasGrupos.insertRows(fila, 1);		
		fila++;
	}

	this.iface.pbnGuardarListaGrupos.setDisabled(false);
}

function oficial_guardarListaGrupos()
{
	var util= new FLUtil();
	var cursor= this.cursor();
	
	res = MessageBox.information(util.translate("scripts", "A continuación se crearán actualizarán todas las reglas de la lista\n\n¿Continuar?"), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
	if (res != MessageBox.Yes)
		return;
	
	if (this.cursor().modeAccess() == this.cursor().Insert) {
		var curAcs= this.iface.tdbAcs.cursor();
		curAcs.setModeAccess(curAcs.Insert);
		curAcs.commitBufferCursorRelation();
	}
	
	var idGroupIntro:String;
	var curAcs= new FLSqlCursor("flacs");
	var curAcos= new FLSqlCursor("flacos");
	var prioridad= 1;
	var permiso:String;
	var idAcl= this.cursor().valueBuffer("idacl");
	
	util.createProgressDialog( util.translate( "scripts", "Actualizando reglas..." ), this.iface.tblListasGrupos.numRows() );
	
	var idModulo:String;
	for (numL = 0; numL < this.iface.tblListasGrupos.numRows(); numL++) {
	
		util.setProgress(numL);
	
		// Saltar los separadores
		if (!this.iface.tblListasGrupos.text(numL, this.iface.C_USGR)) {
			continue;
		}
		idModulo = this.iface.tblListasGrupos.text(numL, this.iface.C_IDMO);
	
		idGroupIntro = this.iface.tblListasGrupos.text(numL, this.iface.C_USGR);
	
// 		curAcs.select("idacl = '" + idAcl + "' AND idgroup = '" + idGroupIntro + "' AND idmodule = '" + this.iface.tblListasGrupos.text(numL, 8) + "'");
		curAcs.select("idacl = '" + idAcl + "' AND idgroup = '" + idGroupIntro + "' AND degrupo = true AND idarea = 'sys' AND idmodule = 'sys' AND tipo = 'mainwindow' AND tipoform = 'Maestro' AND nombre = 'container'");
		var idAc:String;
		if (curAcs.first()) {
// 			curAcs.setModeAccess(curAcs.Edit);
// 			// Saltar los no modificados
// 			if (!this.iface.tblListasGrupos.text(numL, 8))
// 				continue;
		} else {
			curAcs.setModeAccess(curAcs.Insert);
			curAcs.refreshBuffer();
			curAcs.setValueBuffer("idacl", cursor.valueBuffer("idacl"));
			curAcs.setValueBuffer("idgroup", idGroupIntro);
			curAcs.setValueBuffer("degrupo", true);
			curAcs.setValueBuffer("idarea", "sys");
			curAcs.setValueBuffer("idmodule", "sys");
			curAcs.setValueBuffer("tipo", "mainwindow");
			curAcs.setValueBuffer("tipoform", "Maestro");
			curAcs.setValueBuffer("nombre", "container");
			curAcs.setValueBuffer("prioridad", cursor.valueBuffer("prioridadgrupointro"));
			curAcs.setValueBuffer("descripcion", util.translate("scripts", "Sistema:Administración:mainwindow:container"));
			if (!curAcs.commitBuffer()) {
				return false;
			}
		}
		idAc = curAcs.valueBuffer("idac");
		
// 		curAcs.refreshBuffer();
// 		curAcs.setValueBuffer("idgroup", this.iface.tblListasGrupos.text(numL, 0));
// 		curAcs.setValueBuffer("tipo", "mainwindow");
// 		curAcs.setValueBuffer("nombre", this.iface.tblListasGrupos.text(numL, 8));
		
		//Area de Facturación:Tesorería:mainwindow:Maestro:flfactteso
		permiso = "--";
		if (this.iface.tblListasGrupos.text(numL, this.iface.C_LECT)) {
 			permiso = "--";		
		}
		if (this.iface.tblListasGrupos.text(numL, this.iface.C_LEES)) {
 			permiso = "rw";
		}

		curAcos.select("idac = " + idAc + " AND nombre = '" + idModulo + "'");
		if (curAcos.first()) {
			if (permiso == "rw") {
				curAcos.setModeAccess(curAcos.Del);
				curAcos.refreshBuffer();
			} else {
				curAcos.setModeAccess(curAcos.Edit);
				curAcos.refreshBuffer();
				curAcos.setValueBuffer("permiso", permiso);
			}
			if (!curAcos.commitBuffer()) {
				return false;
			}
		} else {
			if (permiso != "rw") {
				curAcos.setModeAccess(curAcos.Insert);
				curAcos.refreshBuffer();
				curAcos.setValueBuffer("idac", idAc);
				curAcos.setValueBuffer("nombre", idModulo);
				curAcos.setValueBuffer("descripcion", this.iface.tblListasUsuarios.text(numL, this.iface.C_AREA) + ":" + this.iface.tblListasUsuarios.text(numL, this.iface.C_MODU));
				curAcos.setValueBuffer("permiso", permiso);
				if (!curAcos.commitBuffer()) {
					return false;
				}
			}
		}
// 		curAcs.setValueBuffer("permiso", permiso);
		
// 		curAcs.setValueBuffer("idacl", idAcl);
// 		curAcs.setValueBuffer("degrupo", true);
// 		curAcs.setValueBuffer("idarea", this.iface.tblListasGrupos.text(numL, 7));
// 		curAcs.setValueBuffer("idmodule", this.iface.tblListasGrupos.text(numL, 8));
// 		curAcs.setValueBuffer("tipoform", "Maestro");
// 		
// 		prioridad = parseFloat(this.iface.tblListasGrupos.text(numL, 6));
// 		if (!prioridad)
// 			prioridad = 1;
// 		curAcs.setValueBuffer("prioridad", prioridad);
// 		
// 		curAcs.commitBuffer();
	}
	
	util.destroyProgressDialog();
	MessageBox.information(util.translate("scripts", "Se guardaron los cambios. Recuerde que para que las modificaciones sean efectivas, debe aceptar el formulario.\nSi cancela el formulario las modificaciones no serán efectivas"), MessageBox.Ok, MessageBox.NoButton);
	
	for (numL = 0; numL < this.iface.tblListasGrupos.numRows(); numL++) {
		this.iface.tblListasGrupos.setText(numL, this.iface.C_MODI, "");
		this.iface.tblListasGrupos.setCellBackgroundColor(numL, this.iface.C_MODI, this.iface.colorBlanco_);
	}
}

function oficial_clickedListaGrupos(fil:Number, col:Number)
{
	if (col < this.iface.C_NOAC || col > this.iface.C_LEES) {
		return;
	}
	if (!this.iface.tblListasGrupos.text(fil, this.iface.C_USGR)) {
		return;
	}
	
	if (this.iface.tblListasGrupos.text(fil, col)) {
		return;
	}
	
	this.iface.tblListasGrupos.setText(fil, col, "XXX");
	var color = this.iface.colorBlanco_;
	switch (col) {
		case this.iface.C_NOAC: {
			color = this.iface.colorRojo_;
			break;
		}
		case this.iface.C_LEES: {
			color = this.iface.colorVerde_;
			break;
		}
	}
	this.iface.tblListasGrupos.setCellBackgroundColor(fil, col, color);

	switch (col) {
		case this.iface.C_NOAC: {
			this.iface.tblListasGrupos.setText(fil, this.iface.C_LECT, "");
			this.iface.tblListasGrupos.setText(fil, this.iface.C_LEES, "");
			this.iface.tblListasGrupos.setCellBackgroundColor(fil, this.iface.C_LECT, this.iface.colorBlanco_);
			this.iface.tblListasGrupos.setCellBackgroundColor(fil, this.iface.C_LEES, this.iface.colorBlanco_);
			break;
		}
		case this.iface.C_LECT: {
			this.iface.tblListasGrupos.setText(fil, this.iface.C_NOAC, "");
			this.iface.tblListasGrupos.setText(fil, this.iface.C_LEES, "");
			this.iface.tblListasGrupos.setCellBackgroundColor(fil, this.iface.C_NOAC, this.iface.colorBlanco_);
			this.iface.tblListasGrupos.setCellBackgroundColor(fil, this.iface.C_LEES, this.iface.colorBlanco_);
			break;
		}
		case this.iface.C_LEES: {
			this.iface.tblListasGrupos.setText(fil, this.iface.C_NOAC, "");
			this.iface.tblListasGrupos.setText(fil, this.iface.C_LECT, "");
			this.iface.tblListasGrupos.setCellBackgroundColor(fil, this.iface.C_NOAC, this.iface.colorBlanco_);
			this.iface.tblListasGrupos.setCellBackgroundColor(fil, this.iface.C_LECT, this.iface.colorBlanco_);
			break;
		}
	}
	
	this.iface.tblListasGrupos.setText(fil, this.iface.C_MODI, "XXX");
	this.iface.tblListasGrupos.setCellBackgroundColor(fil, this.iface.C_MODI, this.iface.colorAzul_);
// 	this.iface.tblListasGrupos.repaintContents();
}
function oficial_recargarListaUsuarios()
{
	var util= new FLUtil();
	
	if (this.iface.tblListasUsuarios.numRows()) {
		res = MessageBox.information(util.translate("scripts", "A continuación se recargará la lista de reglas\nPerderá los cambios no guardados\n\n¿Continuar?"), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
		if (res != MessageBox.Yes)
			return;
	}
	
	var where= "1 = 1";
	var idAcl= this.cursor().valueBuffer("idacl");
	var prioridad;
	var prioridadDefecto= this.cursor().valueBuffer("prioridadusuariointro");
	
	var idUserIntro= this.cursor().valueBuffer("iduserintro");
	if (idUserIntro)
		where += " AND iduser = '" + idUserIntro + "'";
	
	var idGroupIntro= this.cursor().valueBuffer("idgroupintro");
	if (idGroupIntro)
		where += " AND idgroup = '" + idGroupIntro + "'";
	
	
	var fila= 0;
	var permiso= "";
	this.iface.tblListasUsuarios.clear();
	
	var qG= new FLSqlQuery();
	qG.setTablesList("flusers");
	qG.setFrom("flusers");
	qG.setSelect("iduser")
	qG.setWhere(where + " order by iduser")
	
	var q= new FLSqlQuery();
	q.setTablesList("flareas,flmodules");
	q.setFrom("flareas a inner join flmodules m on a.idarea = m.idarea");
	q.setSelect("m.idarea,m.idmodulo,a.descripcion,m.descripcion")
	q.setWhere("1=1 order by a.descripcion,m.descripcion")
	
	qG.exec();
	while(qG.next()) {
		idUserIntro = qG.value(0);
		q.exec();
		while(q.next()) {
		
			this.iface.tblListasUsuarios.insertRows(fila, 1);		
	
			this.iface.tblListasUsuarios.setText(fila, this.iface.C_USGR, idUserIntro);
			this.iface.tblListasUsuarios.setText(fila, this.iface.C_AREA, q.value(2));
			this.iface.tblListasUsuarios.setText(fila, this.iface.C_MODU, q.value(3));
			this.iface.tblListasUsuarios.setText(fila, this.iface.C_IDAR, q.value(0));
			this.iface.tblListasUsuarios.setText(fila, this.iface.C_IDMO, q.value(1));
			
			permiso = util.sqlSelect("flacs a INNER JOIN flacos o ON a.idac = o.idac", "o.permiso", "a.iduser = '" + idUserIntro + "' AND degrupo = false AND a.idarea = 'sys' AND a.idmodule = 'sys' AND tipo = 'mainwindow' AND tipoform = 'Maestro' AND a.nombre = 'container' AND o.nombre = '" + q.value("m.idmodulo") + "'", "flacs,flacos");
			if (!permiso) {
				permiso = util.sqlSelect("flacs", "permiso", "idacl = '" + idAcl + "' AND iduser = '" + idUserIntro + "' AND degrupo = false and idmodule = '" + q.value("m.idmodulo") + "' AND tipo = 'mainwindow'");
			}
			switch(permiso) {
				case "--": {
					this.iface.tblListasUsuarios.setText(fila, this.iface.C_NOAC, "XXX");
					this.iface.tblListasUsuarios.setCellBackgroundColor(fila, this.iface.C_NOAC, this.iface.colorRojo_);
					this.iface.tblListasUsuarios.setCellBackgroundColor(fila, this.iface.C_LEES, this.iface.colorBlanco_);
					this.iface.tblListasUsuarios.setCellBackgroundColor(fila, this.iface.C_LECT, this.iface.colorBlanco_);
					break;
				}
				case "r-": {
					this.iface.tblListasUsuarios.setText(fila, this.iface.C_LECT, "XXX");
					break;
				}
				default: {
					this.iface.tblListasUsuarios.setText(fila, this.iface.C_LEES, "XXX");
					this.iface.tblListasUsuarios.setCellBackgroundColor(fila, this.iface.C_LEES, this.iface.colorVerde_);
					this.iface.tblListasUsuarios.setCellBackgroundColor(fila, this.iface.C_NOAC, this.iface.colorBlanco_);
					this.iface.tblListasUsuarios.setCellBackgroundColor(fila, this.iface.C_LECT, this.iface.colorBlanco_);
				}
			}
			
			prioridad = util.sqlSelect("flacs a INNER JOIN flacos o ON a.idac = o.idac", "a.prioridad", "a.iduser = '" + idUserIntro + "' AND degrupo = false AND a.idarea = 'sys' AND a.idmodule = 'sys' AND tipo = 'mainwindow' AND tipoform = 'Maestro' AND a.nombre = 'container' AND o.nombre = '" + q.value("m.idmodulo") + "'", "flacs,flacos");
			if (!prioridad) {
				prioridad = parseFloat(util.sqlSelect("flacs", "prioridad", "idacl = '" + idAcl + "' AND iduser = '" + idUserIntro + "' AND degrupo = false AND idmodule = '" + q.value("m.idmodulo") + "' AND tipo = 'mainwindow'"));
			}
			if (!prioridad)
				prioridad = prioridadDefecto;
			if (!prioridad)
				prioridad = 1;
			
			this.iface.tblListasUsuarios.setText(fila, this.iface.C_PRIO, prioridad);
			this.iface.tblListasUsuarios.setCellBackgroundColor(fila, this.iface.C_PRIO, this.iface.colorBlanco_);
			
			fila++;
		}
	
		this.iface.tblListasUsuarios.insertRows(fila, 1);		
		fila++;
	}

	this.iface.pbnGuardarListaUsuarios.setDisabled(false);
}

function oficial_guardarListaUsuarios()
{
	var util= new FLUtil();
	var cursor= this.cursor();

	res = MessageBox.information(util.translate("scripts", "A continuación se crearán actualizarán todas las reglas de la lista\n\n¿Continuar?"), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
	if (res != MessageBox.Yes)
		return;
	
	if (this.cursor().modeAccess() == this.cursor().Insert) {
		var curAcs= this.iface.tdbAcs.cursor();
		curAcs.setModeAccess(curAcs.Insert);
		curAcs.commitBufferCursorRelation();
	}
	
	var idUserIntro:String;
	var curAcs= new FLSqlCursor("flacs");
	var curAcos= new FLSqlCursor("flacos");
	var prioridad= 1;
	var permiso:String;
	var idAcl= this.cursor().valueBuffer("idacl");
	
	util.createProgressDialog( util.translate( "scripts", "Actualizando reglas..." ), this.iface.tblListasUsuarios.numRows() );
	
	var idModulo:String;
	for (numL = 0; numL < this.iface.tblListasUsuarios.numRows(); numL++) {

		util.setProgress(numL);
	
		// Saltar los separadores
		if (!this.iface.tblListasUsuarios.text(numL, this.iface.C_USGR)) {
			continue;
		}
		idModulo = this.iface.tblListasUsuarios.text(numL, this.iface.C_IDMO);
		idUserIntro = this.iface.tblListasUsuarios.text(numL, this.iface.C_USGR);
	
		curAcs.select("idacl = '" + idAcl + "' AND iduser = '" + idUserIntro + "' AND degrupo <> true AND idarea = 'sys' AND idmodule = 'sys' AND tipo = 'mainwindow' AND tipoform = 'Maestro' AND nombre = 'container'");
		var idAc:String;
		if (curAcs.first()) {
// 			curAcs.setModeAccess(curAcs.Edit);
// 			// Saltar los no modificados
// 			if (!this.iface.tblListasGrupos.text(numL, 8))
// 				continue;
		} else {
			curAcs.setModeAccess(curAcs.Insert);
			curAcs.refreshBuffer();
			curAcs.setValueBuffer("idacl", cursor.valueBuffer("idacl"));
			curAcs.setValueBuffer("iduser", idUserIntro);
			curAcs.setValueBuffer("degrupo", false);
			curAcs.setValueBuffer("idarea", "sys");
			curAcs.setValueBuffer("idmodule", "sys");
			curAcs.setValueBuffer("tipo", "mainwindow");
			curAcs.setValueBuffer("tipoform", "Maestro");
			curAcs.setValueBuffer("nombre", "container");
			curAcs.setValueBuffer("prioridad", cursor.valueBuffer("prioridadusuariointro"));
			curAcs.setValueBuffer("descripcion", util.translate("scripts", "Sistema:Administración:mainwindow:container"));
			if (!curAcs.commitBuffer()) {
				return false;
			}
		}
		idAc = curAcs.valueBuffer("idac");
		
// 		curAcs.refreshBuffer();
// 		curAcs.setValueBuffer("idgroup", this.iface.tblListasGrupos.text(numL, 0));
// 		curAcs.setValueBuffer("tipo", "mainwindow");
// 		curAcs.setValueBuffer("nombre", this.iface.tblListasGrupos.text(numL, 8));
		
		//Area de Facturación:Tesorería:mainwindow:Maestro:flfactteso
		permiso = "--";
		if (this.iface.tblListasUsuarios.text(numL, this.iface.C_LECT)) {
 			permiso = "--";
		}
		if (this.iface.tblListasUsuarios.text(numL, this.iface.C_LEES)) {
 			permiso = "rw";
		}

		curAcos.select("idac = " + idAc + " AND nombre = '" + idModulo + "'");
		if (curAcos.first()) {
			if (permiso == "rw") {
				curAcos.setModeAccess(curAcos.Del);
				curAcos.refreshBuffer();
			} else {
				curAcos.setModeAccess(curAcos.Edit);
				curAcos.refreshBuffer();
				curAcos.setValueBuffer("permiso", permiso);
			}
			if (!curAcos.commitBuffer()) {
				return false;
			}
		} else {
			if (permiso != "rw") {
				curAcos.setModeAccess(curAcos.Insert);
				curAcos.refreshBuffer();
				curAcos.setValueBuffer("idac", idAc);
				curAcos.setValueBuffer("nombre", idModulo);
				curAcos.setValueBuffer("descripcion", this.iface.tblListasUsuarios.text(numL, this.iface.C_AREA) + ":" + this.iface.tblListasUsuarios.text(numL, this.iface.C_MODU));
				curAcos.setValueBuffer("permiso", permiso);
				if (!curAcos.commitBuffer()) {
					return false;
				}
			}
		}

// 		curAcs.select("idacl = '" + idAcl + "' AND iduser = '" + idUserIntro + "' AND idmodule = '" + this.iface.tblListasUsuarios.text(numL, 8) + "'");
// 		if (curAcs.first()) {
// 			curAcs.setModeAccess(curAcs.Edit);
// 			// Saltar los no modificados
// 			if (!this.iface.tblListasUsuarios.text(numL, 8))
// 				continue;
// 		}
// 		else
// 			curAcs.setModeAccess(curAcs.Insert);
// 		
// 		curAcs.refreshBuffer();
// 		curAcs.setValueBuffer("iduser", this.iface.tblListasUsuarios.text(numL, 0));
// 		curAcs.setValueBuffer("tipo", "mainwindow");
// 		curAcs.setValueBuffer("nombre", this.iface.tblListasUsuarios.text(numL, 8));
// 		
// 		//Area de Facturación:Tesorería:mainwindow:Maestro:flfactteso
// 		curAcs.setValueBuffer("descripcion", this.iface.tblListasUsuarios.text(numL, 1) + ":" + this.iface.tblListasUsuarios.text(numL, 2) + "mainwindow:Maestro:" + this.iface.tblListasUsuarios.text(numL, 7));
// 		
// 		permiso = "--";
// 		if (this.iface.tblListasUsuarios.text(numL, 4))
//  			permiso = "r-";		
// 		if (this.iface.tblListasUsuarios.text(numL, 5))
//  			permiso = "rw";		
// 		curAcs.setValueBuffer("permiso", permiso);
// 		
// 		curAcs.setValueBuffer("idacl", idAcl);
// 		curAcs.setValueBuffer("deusuario", true);
// 		curAcs.setValueBuffer("idarea", this.iface.tblListasUsuarios.text(numL, 7));
// 		curAcs.setValueBuffer("idmodule", this.iface.tblListasUsuarios.text(numL, 8));
// 		curAcs.setValueBuffer("tipoform", "Maestro");
// 		
// 		prioridad = parseFloat(this.iface.tblListasUsuarios.text(numL, 6));
// 		if (!prioridad)
// 			prioridad = 1;
// 		curAcs.setValueBuffer("prioridad", prioridad);
// 		
// 		curAcs.commitBuffer();
	}
	
	util.destroyProgressDialog();
	MessageBox.information(util.translate("scripts", "Se guardaron los cambios. Recuerde que para que las modificaciones sean efectivas, debe aceptar el formulario.\nSi cancela el formulario las modificaciones no serán efectivas"), MessageBox.Ok, MessageBox.NoButton);
	
	for (numL = 0; numL < this.iface.tblListasUsuarios.numRows(); numL++) {
		this.iface.tblListasUsuarios.setText(numL, this.iface.C_MODI, "");
		this.iface.tblListasUsuarios.setCellBackgroundColor(numL, this.iface.C_MODI, this.iface.colorBlanco_);
	}
}

function oficial_clickedListaUsuarios(fil:Number, col:Number)
{
	if (col < this.iface.C_NOAC || col > this.iface.C_LEES) {
		return;
	}
	if (!this.iface.tblListasUsuarios.text(fil, this.iface.C_USGR)) {
		return;
	}
	
	if (this.iface.tblListasUsuarios.text(fil, col)) {
		return;
	}
	
	this.iface.tblListasUsuarios.setText(fil, col, "XXX");
	var color = this.iface.colorBlanco_;
	switch (col) {
		case this.iface.C_NOAC: {
			color = this.iface.colorRojo_;
			break;
		}
		case this.iface.C_LEES: {
			color = this.iface.colorVerde_;
			break;
		}
	}
	this.iface.tblListasUsuarios.setCellBackgroundColor(fil, col, color);

	switch (col) {
		case this.iface.C_NOAC: {
			this.iface.tblListasUsuarios.setText(fil, this.iface.C_LECT, "");
			this.iface.tblListasUsuarios.setText(fil, this.iface.C_LEES, "");
			this.iface.tblListasUsuarios.setCellBackgroundColor(fil, this.iface.C_LECT, this.iface.colorBlanco_);
			this.iface.tblListasUsuarios.setCellBackgroundColor(fil, this.iface.C_LEES, this.iface.colorBlanco_);
			break;
		}
		case this.iface.C_LECT: {
			this.iface.tblListasUsuarios.setText(fil, this.iface.C_NOAC, "");
			this.iface.tblListasUsuarios.setText(fil, this.iface.C_LEES, "");
			this.iface.tblListasUsuarios.setCellBackgroundColor(fil, this.iface.C_NOAC, this.iface.colorBlanco_);
			this.iface.tblListasUsuarios.setCellBackgroundColor(fil, this.iface.C_LEES, this.iface.colorBlanco_);
			break;
		}
		case this.iface.C_LEES: {
			this.iface.tblListasUsuarios.setText(fil, this.iface.C_NOAC, "");
			this.iface.tblListasUsuarios.setText(fil, this.iface.C_LECT, "");
			this.iface.tblListasUsuarios.setCellBackgroundColor(fil, this.iface.C_NOAC, this.iface.colorBlanco_);
			this.iface.tblListasUsuarios.setCellBackgroundColor(fil, this.iface.C_LECT, this.iface.colorBlanco_);
			break;
		}
	}
	
	this.iface.tblListasUsuarios.setText(fil, this.iface.C_MODI, "XXX");
	this.iface.tblListasUsuarios.setCellBackgroundColor(fil, this.iface.C_MODI, this.iface.colorAzul_);
// 	this.iface.tblListasUsuarios.repaintContents();

// 	if (col < 3 || col > 5)
// 		return;
// 	
// 	if (!this.iface.tblListasUsuarios.text(fil, 0))
// 		return;
// 	
// 	if (this.iface.tblListasUsuarios.text(fil, col))
// 		return;
// 	
// 	this.iface.tblListasUsuarios.setText(fil, col, "XXX");
// 	
// 	switch (col) {
// 		case 3:
// 			this.iface.tblListasUsuarios.setText(fil, 4, "");
// 			this.iface.tblListasUsuarios.setText(fil, 5, "");
// 		break;
// 		case 4:
// 			this.iface.tblListasUsuarios.setText(fil, 3, "");
// 			this.iface.tblListasUsuarios.setText(fil, 5, "");
// 		break;
// 		case 5:
// 			this.iface.tblListasUsuarios.setText(fil, 3, "");
// 			this.iface.tblListasUsuarios.setText(fil, 4, "");
// 		break;
// 	}
// 	
// 	this.iface.tblListasUsuarios.setText(fil, 9, "XXX");
}
function oficial_crearTablas()
{
	var util= new FLUtil;

	this.iface.C_USGR = 0;
	this.iface.C_AREA = 1;
	this.iface.C_MODU = 2;
	this.iface.C_NOAC = 3;
	this.iface.C_LECT = 4;
	this.iface.C_LEES = 5;
	this.iface.C_PRIO = 6;
	this.iface.C_IDAR = 7;
	this.iface.C_IDMO = 8;
	this.iface.C_MODI = 9;

	var tblGrupos = this.child("tblListasGrupos");
	tblGrupos.setNumCols(10);
	var aCols= [util.translate("scripts", "Grupo"), util.translate("scripts", "Área"), util.translate("scripts", "Módulo"), util.translate("scripts", "Sin acceso"), util.translate("scripts", "Sólo lectura"), util.translate("scripts", "Lect./Escr"), util.translate("scripts", "Prioridad"), "idarea", "idmodulo", util.translate("scripts", "Modificada")];
	tblGrupos.setColumnLabels("|", aCols.join("|"));
	tblGrupos.setNumRows(0);
	tblGrupos.setColumnWidth(this.iface.C_USGR, 100);
	tblGrupos.setColumnWidth(this.iface.C_AREA, 200);
	tblGrupos.setColumnWidth(this.iface.C_MODU, 150);
	tblGrupos.setColumnWidth(this.iface.C_NOAC, 80);
	tblGrupos.hideColumn(this.iface.C_LECT);
	tblGrupos.setColumnWidth(this.iface.C_LEES, 80);
	tblGrupos.hideColumn(this.iface.C_PRIO);
	tblGrupos.hideColumn(this.iface.C_IDAR);
	tblGrupos.hideColumn(this.iface.C_IDMO);
	tblGrupos.setColumnWidth(this.iface.C_MODI, 80);

	for (var numC= 0; numC < tblGrupos.numCols(); numC++) {
		tblGrupos.setColumnReadOnly(numC, true);
	}

	var tblUsuarios = this.child("tblListasUsuarios");
	tblUsuarios.setNumCols(10);
	var aCols= [util.translate("scripts", "Usuario"), util.translate("scripts", "Área"), util.translate("scripts", "Módulo"), util.translate("scripts", "Sin acceso"), util.translate("scripts", "Sólo lectura"), util.translate("scripts", "Lect./Escr"), util.translate("scripts", "Prioridad"), "idarea", "idmodulo", util.translate("scripts", "Modificada")];
	tblUsuarios.setColumnLabels("|", aCols.join("|"));
	tblUsuarios.setNumRows(0);
	tblUsuarios.setColumnWidth(this.iface.C_USGR, 100);
	tblUsuarios.setColumnWidth(this.iface.C_AREA, 200);
	tblUsuarios.setColumnWidth(this.iface.C_MODU, 150);
	tblUsuarios.setColumnWidth(this.iface.C_NOAC, 80);
	tblUsuarios.hideColumn(this.iface.C_LECT);
	tblUsuarios.setColumnWidth(this.iface.C_LEES, 80);
	tblUsuarios.hideColumn(this.iface.C_PRIO);
	tblUsuarios.hideColumn(this.iface.C_IDAR);
	tblUsuarios.hideColumn(this.iface.C_IDMO);
	tblUsuarios.setColumnWidth(this.iface.C_MODI, 80);

	for (var numC= 0; numC < tblGrupos.numCols(); numC++) {
		tblUsuarios.setColumnReadOnly(numC, true);
	}
}

function oficial_colores()
{
	this.iface.colorBlanco_ = new Color(255, 255, 255);
	this.iface.colorRojo_ = new Color(255, 200, 200);
	this.iface.colorVerde_ = new Color(200, 255, 200);
	this.iface.colorAzul_ = new Color(200, 200, 255);
}

function oficial_cargaTabPpal()
{
  var _i = this.iface;
  _i.cargaAreas();
  _i.cargaModulos();
  _i.cargaAcciones();
  _i.cargaAreasExtra();
  
  var tM = this.child("tblModulos");
  var tO = this.child("tblAcciones");
  var tA = this.child("tblAreas");
  connect(tA, "currentChanged(int, int)", _i, "tblAreas_currentChanged");
  connect(tM, "currentChanged(int, int)", _i, "tblModulos_currentChanged");
  connect(tA, "doubleClicked(int, int)", _i, "tblAreas_doubleClicked");
  connect(tM, "doubleClicked(int, int)", _i, "tblModulos_doubleClicked");
  connect(tO, "doubleClicked(int, int)", _i, "tblAcciones_doubleClicked");
  
  _i.cargaAccionesUsuario()
  
  _i.muestraAreas();
  _i.muestraModulos();
  _i.muestraAcciones();
}

function oficial_tblAcciones_doubleClicked(f, c)
{
  var _i = this.iface;
  var tA = this.child("tblAcciones");
  var idAccion = tA.text(f, _i.cA_ID_)
  if (c != _i.cA_READ_ && c != _i.cA_WRITE_) {
    return;
  }
  var p = "";
  if (c == _i.cA_READ_) {
    tA.setText(f, _i.cA_READ_, tA.text(f, _i.cA_READ_) == "R" ? "" : "R");
    tA.setText(f, _i.cA_WRITE_, tA.text(f, _i.cA_READ_) == "R" ? tA.text(f, _i.cA_WRITE_) : "");
  }
  if (c == _i.cA_WRITE_) {
    tA.setText(f, _i.cA_WRITE_, tA.text(f, _i.cA_WRITE_) == "W" ? "" : "W");
  }
  p+= tA.text(f, _i.cA_READ_) == "R" ? "r" : "-";
  p+= tA.text(f, _i.cA_WRITE_) == "W" ? "w" : "-";
  p = p == "-w" ? "--" : p;
  if (!_i.actualizaPermisoAcos(idAccion, p)) {
    return false;
  }
}

function oficial_tblModulos_doubleClicked(f, c)
{
  var _i = this.iface;
  var tM = this.child("tblModulos");
  var idModulo = tM.text(f, _i.cM_ID_)
  if (c != _i.cM_READ_ && c != _i.cM_WRITE_) {
    return;
  }
  var p = "";
  if (c == _i.cM_READ_) {
    tM.setText(f, _i.cM_READ_, tM.text(f, _i.cM_READ_) == "R" ? "" : "R");
    tM.setText(f, _i.cM_WRITE_, tM.text(f, _i.cM_READ_) == "R" ? tM.text(f, _i.cM_WRITE_) : "");
  }
  if (c == _i.cM_WRITE_) {
    tM.setText(f, _i.cM_WRITE_, tM.text(f, _i.cM_WRITE_) == "W" ? "" : "W");
  }
  p+= tM.text(f, _i.cM_READ_) == "R" ? "r" : "-";
  p+= tM.text(f, _i.cM_WRITE_) == "W" ? "w" : "-";
  p = p == "-w" ? "--" : p;
  if (!_i.actualizaPermisoModulo(idModulo, p)) {
    return false;
  }
  _i.cargaAccionesUsuario();
  _i.muestraAcciones();
}

function oficial_tblAreas_doubleClicked(f, c)
{
  var _i = this.iface;
  var tA = this.child("tblAreas");
  var idArea = tA.text(f, _i.cA_ID_)
  if (c != _i.cA_READ_ && c != _i.cA_WRITE_) {
    return;
  }
  var p = "";
  if (c == _i.cA_READ_) {
    tA.setText(f, _i.cA_READ_, tA.text(f, _i.cA_READ_) == "R" ? "" : "R");
    tA.setText(f, _i.cA_WRITE_, tA.text(f, _i.cA_READ_) == "R" ? tA.text(f, _i.cA_WRITE_) : "");
  }
  if (c == _i.cA_WRITE_) {
    tA.setText(f, _i.cA_WRITE_, tA.text(f, _i.cA_WRITE_) == "W" ? "" : "W");
  }
  p+= tA.text(f, _i.cA_READ_) == "R" ? "r" : "-";
  p+= tA.text(f, _i.cA_WRITE_) == "W" ? "w" : "-";
  p = p == "-w" ? "--" : p;
  if (!_i.actualizaPermisoArea(idArea, p)) {
    return false;
  }
  _i.cargaAccionesUsuario();
  _i.muestraModulos();
  _i.muestraAcciones();
}

function oficial_actualizaPermisoArea(idArea, p)
{
  var _i = this.iface;
  if (!_i.actualizaPermisoAcos(idArea, p)) {
    return false;
  }
  for (var m = 0; m < _i.modulos_.length; m++) {
    if (_i.modulos_[m]["idarea"] != idArea) {
      continue;
    }
    if (!_i.actualizaPermisoModulo(_i.modulos_[m]["id"] , p)) {
      return false;
    }
  }
  return true;
}

function oficial_actualizaPermisoModulo(idModulo, p)
{
  var _i = this.iface;
  if (!_i.actualizaPermisoAcos(idModulo, p)) {
    return false;
  }
  for (var a = 0; a < _i.acciones_.length; a++) {
    if (_i.acciones_[a]["idmodulo"] != idModulo) {
      continue;
    }
    if (!_i.actualizaPermisoAcos(_i.acciones_[a]["id"] , p)) {
      return false;
    }
  }
  return true;
}

function oficial_actualizaPermisoAcos(nombre, p)
{
  var _i = this.iface;
  if (!_i.curAcos_) {
    _i.curAcos_ = new FLSqlCursor("flacos");
  }
  _i.curAcos_.select("idac = " + _i.idAc_ + " AND nombre = '" + nombre + "'");
  if (_i.curAcos_.first()) {
    _i.curAcos_.setModeAccess(_i.curAcos_.Edit);
    _i.curAcos_.refreshBuffer();
  } else {
    _i.curAcos_.setModeAccess(_i.curAcos_.Insert);
    _i.curAcos_.refreshBuffer();
    _i.curAcos_.setValueBuffer("idac", _i.idAc_);
    _i.curAcos_.setValueBuffer("nombre", nombre);
  }
  _i.curAcos_.setValueBuffer("permiso", p);
  if (!_i.curAcos_.commitBuffer()) {
    return false;
  }
  return true;
}

function oficial_cargaAccionesUsuario()
{
  var _i = this.iface;
  var cursor = this.cursor();
  
  var idAcl = cursor.valueBuffer("idacl");
  _i.idAc_ = undefined;
  _i.accionesUsr_ = undefined;
  _i.accionesUsr_ = [];
  
  var q = new AQSqlQuery;
  q.setSelect("acos.nombre, acos.permiso, acs.idac");
  q.setFrom("flacs acs INNER JOIN flacos acos ON acs.idac = acos.idac");
  q.setWhere("acs.idacl = '" + idAcl + "' AND acs.tipo = 'mainwindow' AND acs.nombre = 'container' AND acs.iduser = 'lorena'");
  if (!q.exec()) {
    return false;
  }
  while (q.next()) {
    _i.idAc_ = q.value("acs.idac");
    _i.accionesUsr_[q.value("acos.nombre")] = q.value("acos.permiso");
  }
  return true;
}

function oficial_tblAreas_currentChanged(f, c)
{
  var _i = this.iface;
  var tA = this.child("tblAreas");
  if (f != _i.ultArea_ || _i.ultArea_ == undefined) {
    _i.muestraModulos();
    _i.muestraAcciones();
  }
  _i.ultArea_ = f;
}

function oficial_tblModulos_currentChanged(f, c)
{
  var _i = this.iface;
  var tM = this.child("tblModulos");
  if (f != _i.ultMod_ || _i.ultMod_ == undefined) {
    _i.muestraAcciones();
  }
  _i.ultMod_ = f;
}



function oficial_cargaAreas()
{
  var _i = this.iface;
  var q = new AQSqlQuery("flareas");
  q.setSelect("idarea, descripcion");
  q.setFrom("flareas");
  q.setWhere("1 = 1 ORDER BY idarea");
  if (!q.exec()) {
    return false;
  }
  _i.areas_ = [];
  var i = 0;
  while (q.next()) {
    _i.areas_[i] = new Object;
    _i.areas_[i]["id"] = q.value("idarea");
    _i.areas_[i]["descripcion"] = q.value("descripcion");
    i++;
  }
  var tA = this.child("tblAreas");
  var sep = "/", cab = "";
  var c = 0;
  _i.cA_ID_ = c;
  cab += sys.translate("Id") + sep;
  c++;
  _i.cA_DES_ = c;
  cab += sys.translate("Área") + sep;
  c++;
  _i.cA_READ_ = c;
  cab += sys.translate("Read") + sep;
  c++;
  _i.cA_WRITE_ = c;
  cab += sys.translate("Write") + sep;
  c++;
  tA.setNumCols(c);
  tA.setColumnWidth(_i.cA_ID_, 50);
  tA.setColumnWidth(_i.cA_DES_, 250);
  tA.setColumnWidth(_i.cA_READ_, 40);
  tA.setColumnWidth(_i.cA_WRITE_, 40);
  for (var cc = 0; cc < c; cc++) {
    tA.setColumnReadOnly(cc, true);
  }
  tA.setColumnLabels(sep, cab);
}

function oficial_cargaModulos()
{
  var _i = this.iface;
  var q = new AQSqlQuery("flmodules");
  q.setSelect("idarea, idmodulo, descripcion");
  q.setFrom("flmodules");
  q.setWhere("1 = 1 ORDER BY idarea, idmodulo");
  if (!q.exec()) {
    return false;
  }
  _i.modulos_ = [];
  var i = 0;
  while (q.next()) {
    _i.modulos_[i] = new Object;
    _i.modulos_[i]["id"] = q.value("idmodulo");
    _i.modulos_[i]["idarea"] = q.value("idarea");
    _i.modulos_[i]["descripcion"] = q.value("descripcion");
    i++;
  }
  
  var tM = this.child("tblModulos");
  var sep = "/", cab = "";
  var c = 0;
  _i.cM_ID_ = c;
  cab += sys.translate("Id") + sep;
  c++;
  _i.cM_DES_ = c;
  cab += sys.translate("Módulo") + sep;
  c++;
  _i.cM_READ_ = c;
  cab += sys.translate("Read") + sep;
  c++;
  _i.cM_WRITE_ = c;
  cab += sys.translate("Write") + sep;
  c++;
  tM.setNumCols(c);
  tM.setColumnWidth(_i.cA_ID_, 80);
  tM.setColumnWidth(_i.cA_DES_, 250);
  tM.setColumnWidth(_i.cA_READ_, 40);
  tM.setColumnWidth(_i.cA_WRITE_, 40);
  for (var cc = 0; cc < c; cc++) {
    tM.setColumnReadOnly(cc, true);
  }
  tM.setColumnLabels(sep, cab);
}

function oficial_cargaAcciones()
{
  var _i = this.iface;
  if (_i.acciones_) {
    _i.acciones_ = undefined;
  }
  _i.acciones_ = [];
  
  var qA = new AQSqlQuery;
  qA.setSelect("contenido, nombre, idmodulo");
  qA.setFrom("flfiles");
  qA.setWhere("nombre LIKE '%.xml'");
  if (!qA.exec()) {
    return false;
  }
  var contenido;
  var xmlDoc, acciones, nombre, alias, modulo;
  var a = 0, itemAlias;
  while (qA.next()) {
    contenido = qA.value("contenido");
    if (!contenido) {
      continue;
    }
    xmlDoc = undefined;
    xmlDoc = new FLDomDocument();
    xmlDoc.setContent(contenido);
//debug(qA.value("nombre") + contenido); 
    acciones = xmlDoc.firstChild().childNodes();
    if (!acciones) {
      continue;
    }
    for (var i = 0; i < acciones.length(); i++) {
      if (acciones.item(i).nodeName() == "action") {
        nombre = acciones.item(i).namedItem("name").toElement().text();
        itemAlias = acciones.item(i).namedItem("alias");
        alias = itemAlias ? itemAlias.toElement().text() : nombre;
        alias = _i.procesaTextoAlias(alias);
        debug("Cargando " + nombre);
        _i.acciones_[a] = new Object;
        _i.acciones_[a]["id"] = nombre;
        _i.acciones_[a]["descripcion"] = alias;
        _i.acciones_[a]["idmodulo"] = qA.value("idmodulo");
        a++;
      }
    }
  }
  debug("Acciones tiene " + _i.acciones_.length + " elementos");
  var tA = this.child("tblAcciones");
  var sep = "/", cab = "";
  var c = 0;
  _i.cO_ID_ = c;
  cab += sys.translate("Id") + sep;
  c++;
  _i.cO_DES_ = c;
  cab += sys.translate("Opción") + sep;
  c++;
  _i.cO_READ_ = c;
  cab += sys.translate("Read") + sep;
  c++;
  _i.cO_WRITE_ = c;
  cab += sys.translate("Write") + sep;
  c++;
  tA.setNumCols(c);
  tA.setColumnWidth(_i.cO_ID_, 80);
  tA.setColumnWidth(_i.cO_DES_, 250);
  tA.setColumnWidth(_i.cO_READ_, 40);
  tA.setColumnWidth(_i.cO_WRITE_, 40);
  for (var cc = 0; cc < c; cc++) {
    tA.setColumnReadOnly(cc, true);
  }
  tA.setColumnLabels(sep, cab);
}

function oficial_muestraAreas()
{
  var _i = this.iface;
  var tA = this.child("tblAreas");
  
  var idArea;
  for (var i = 0; i < _i.areas_.length; i++) {
    idArea = _i.areas_[i].id;
    tA.insertRows(i);
    tA.setText(i, _i.cA_ID_, idArea);
    tA.setText(i, _i.cA_DES_, _i.areas_[i].descripcion);
    permiso = idArea in _i.accionesUsr_ ? _i.accionesUsr_[idArea ] : "rw";
    if (permiso.find("r") >= 0) {
      tA.setText(i, _i.cA_READ_, "R");
    } else {
      tA.setText(i, _i.cA_READ_, "");
    }
    if (permiso.find("w") >= 0) {
      tA.setText(i, _i.cA_WRITE_, "W");
    } else {
      tA.setText(i, _i.cA_WRITE_, "");
    }
  }
}

function oficial_muestraModulos()
{
  var _i = this.iface;
  var tM = this.child("tblModulos");
  var tA = this.child("tblAreas");
  
  var idArea = tA.text(tA.currentRow(), 0);
  
  tM.clear();
  var f = 0, permiso, idModulo;
  for (var i = 0; i < _i.modulos_.length; i++) {
    idModulo = _i.modulos_[i].id;
    if (idArea != _i.modulos_[i]["idarea"]) {
      continue;
    }
    tM.insertRows(f);
    tM.setText(f, _i.cM_ID_, idModulo);
    tM.setText(f, _i.cM_DES_, _i.modulos_[i].descripcion);
    permiso = idModulo in _i.accionesUsr_ ? _i.accionesUsr_[idModulo] : "rw";
    if (permiso.find("r") >= 0) {
      tM.setText(f, _i.cM_READ_, "R");
    } else {
      tM.setText(f, _i.cM_READ_, "");
    }
    if (permiso.find("w") >= 0) {
      tM.setText(f, _i.cM_WRITE_, "W");
    } else {
      tM.setText(f, _i.cM_WRITE_, "");
    }
    f++;
  }
}

function oficial_muestraAcciones()
{
  debug("oficial_muestraAcciones()");
  var _i = this.iface;
  var tM = this.child("tblModulos");
  var tA = this.child("tblAcciones");
  
  var idModulo = tM.text(tM.currentRow(), _i.cM_ID_);
debug("oficial_muestraAcciones() " + idModulo);
  tA.clear();
  var f = 0, idAccion;
  for (var i = 0; i < _i.acciones_.length; i++) {
    idAccion = _i.acciones_[i]["id"];
    if (idModulo != _i.acciones_[i]["idmodulo"]) {
      continue;
    }
    tA.insertRows(f);
    tA.setText(f, _i.cO_ID_, _i.acciones_[i].id);
    tA.setText(f, _i.cO_DES_, _i.acciones_[i].descripcion);
    permiso = idAccion in _i.accionesUsr_ ? _i.accionesUsr_[idAccion] : "rw";
    if (permiso.find("r") >= 0) {
      tA.setText(f, _i.cO_READ_, "R");
    } else {
      tA.setText(f, _i.cO_READ_, "");
    }
    if (permiso.find("w") >= 0) {
      tA.setText(f, _i.cO_WRITE_, "W");
    } else {
      tA.setText(f, _i.cO_WRITE_, "");
    }
    f++;
  }
}

function oficial_cargaAreasExtra()
{
  var _i = this.iface;
  
  var aAreas = [];
  for (var a = 0; a < _i.areas_.length; a++) {
    aAreas[_i.areas_[a]["descripcion"]] = true;
  }
  var aModulos = [];
  for (var a = 0; a < _i.modulos_.length; a++) {
    aModulos[_i.modulos_[a]["id"]] = true;
  }
  var i = _i.areas_.length;
  _i.areas_[i] = new Object;
  _i.areas_[i]["id"] = "AQOtros";
  _i.areas_[i]["descripcion"] = sys.translate("Otras opciones");
  i = _i.modulos_.length;
                  
  var ver = sys.version();
  var verBuild = parseInt(ver.mid(ver.lastIndexOf("Build") + 6));
  var isContainer = false;
  if (verBuild >= 36032) {
    var list = new AQObjectQueryList(0, "QMainWindow", "container", true, true);
    var container = list.current();
    if (container != undefined) {
      list = new AQObjectQueryList(container, "QAction", "", true, true);
      if (list.isValid()) {
        isContainer = true;
        formRecordflacs.iface.flactions = [];
        var obj;
        while ((obj = list.current()) != undefined) {
          list.next();
          if (obj.name == "unnamed")
            continue;
          //debug("Incluyendo " + obj.name + " - " + obj.text + " - " + obj.menuText);
          if (!(obj.menuText in aAreas) && !(obj.name in aModulos)) {
            _i.modulos_[i] = new Object;
            _i.modulos_[i]["id"] = obj.name;
            _i.modulos_[i]["idarea"] = "AQOtros";
            _i.modulos_[i]["descripcion"] = obj.menuText;
            i++;
          }
        }
      }
    }
  } 
  return true;
}

function oficial_procesaTextoAlias(alias)
{
  if (alias == "") {
    return "";
  }
  
  var com2 = alias.findRev("\"");
  if (com2 < 0) {
    return alias;
  }
  var com1 = alias.findRev("\"", com2 - 1);
  if (com1 < 0) {
    return alias;
  }
  return alias.mid(com1 + 1, com2 - com1 - 1);
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
