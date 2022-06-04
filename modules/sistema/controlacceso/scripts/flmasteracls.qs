/***************************************************************************
                                 flmasteracls.qs
                            -------------------
   begin                : sab oct 09 2005
   copyright            : (C) 2004-2005 by InfoSiAL S.L.
   email                : mail@infosial.com
***************************************************************************/
/***************************************************************************
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; version 2 of the License.               *
 ***************************************************************************/
/***************************************************************************
   Este  programa es software libre. Puede redistribuirlo y/o modificarlo
   bajo  los  términos  de  la  Licencia  Pública General de GNU   en  su
   versión 2, publicada  por  la  Free  Software Foundation.
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
  var acciones_;
  function oficial( context ) { interna( context ); } 
  function instalar() {
    return this.ctx.oficial_instalar();
  }
  function reglasAutoAcl(cursor) {
    return this.ctx.oficial_reglasAutoAcl(cursor);
  }
  function reglasAutoAcs(qAcs) {
    return this.ctx.oficial_reglasAutoAcs(qAcs);
  }
  function creaReglaAutoForms(qAcs, qAcos) {
    return this.ctx.oficial_creaReglaAutoForms(qAcs, qAcos);
  }
  function cargaAcciones() {
    return this.ctx.oficial_cargaAcciones();
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
/** \C Al pulsar el botón instalar, se aplican las reglas contenidas en la lista de acceso seleccionada.
\end */
function interna_init() {
	connect( this.child( "pbInstalar" ), "clicked()", this, "iface.instalar" );
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_instalar() 
{
  var _i = this.iface;
  var cursor = this.cursor();
  var idAcl = cursor.valueBuffer( "idacl" );
  
  if (!_i.reglasAutoAcl(cursor)) {
    sys.warnMsgBox(sys.translate("Error al generar las reglas automáticas asociadas a la lista seleccionada"));
    return;
  }
	sys.installACL( idAcl );

	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();
	var curLista:FLSqlCursor = new FLSqlCursor("flacls");
	curLista.select("1 = 1");
	while (curLista.next()) {
		curLista.setModeAccess(curLista.Edit);
		curLista.refreshBuffer();
		curLista.setValueBuffer("instalada",false);
		if ( curLista.valueBuffer("idacl") == cursor.valueBuffer("idacl") ) {
			curLista.setValueBuffer("instalada",true);
		}
		if (!curLista.commitBuffer()) 
			return;
	}
	MessageBox.information(util.translate("scripts","La lista se ha instalado correctamente."), MessageBox.Ok, MessageBox.NoButton);
}

function oficial_reglasAutoAcl(cursor)
{
  var _i = this.iface;
  _i.cargaAcciones();
  var idAcl = cursor.valueBuffer("idacl");
  
  if (!AQUtil.execSql("DELETE FROM  flacs WHERE idacl = '" + idAcl + "' AND auto")) {
    return false;
  }
  
  var qAcs = new AQSqlQuery;
  qAcs.setSelect("prioridad, tipo, iduser, idgroup, permiso, degrupo, idac, idacl");
  qAcs.setFrom("flacs");
  qAcs.setWhere("idacl = '" + idAcl + "' AND tipo = 'mainwindow' AND nombre = 'container'");
  if (!qAcs.exec()) {
    return false;
  }
  while (qAcs.next()) {
    if (!_i.reglasAutoAcs(qAcs)) {
      return false;
    }
  }
  return true;
}

function oficial_reglasAutoAcs(qAcs)
{
  var _i = this.iface;
  var idAc = qAcs.value("idac");
  
  var qAcos = new AQSqlQuery;
  qAcos.setSelect("nombre, permiso");
  qAcos.setFrom("flacos");
  qAcos.setWhere("idac = " + idAc);
  if (!qAcos.exec()) {
    return false;
  }
  while (qAcos.next()) {
    if (!_i.creaReglaAutoForms(qAcs, qAcos)) {
      return false;
    }
  }
  return true;
}

function oficial_creaReglaAutoForms(qAcs, qAcos)
{
  var _i = this.iface;
  
  var nombre = qAcos.value("nombre");
  if (!(nombre in _i.acciones_)) {
    return true;
  }
  
  var curAcs = new FLSqlCursor("flacs");
  var aF = ["form", "formRecord"];
  for (var f = 0; f  < aF.length; f++) {
    curAcs.setModeAccess(curAcs.Insert);
    curAcs.refreshBuffer();
    curAcs.setValueBuffer("prioridad", qAcs.value("prioridad"));
    curAcs.setValueBuffer("tipo", "form");
    curAcs.setValueBuffer("nombre", aF[f] + nombre);
    curAcs.setValueBuffer("iduser", qAcs.value("iduser"));
    curAcs.setValueBuffer("idgroup", qAcs.value("idgroup"));
    curAcs.setValueBuffer("permiso", qAcos.value("permiso"));
    curAcs.setValueBuffer("idacl", qAcs.value("idacl"));
    curAcs.setValueBuffer("degrupo", qAcs.value("degrupo"));
    curAcs.setValueBuffer("tipoform", "Maestro");
    curAcs.setValueBuffer("auto", true);
    if (!curAcs.commitBuffer()) {
      return false;
    }
  }
  return true;
}

function oficial_cargaAcciones()
{
  var _i = this.iface;
  if (_i.acciones_) {
    _i.acciones_ = undefined;
  }
  _i.acciones_ = [];
  
  var qA = new AQSqlQuery;
  qA.setSelect("contenido, nombre");
  qA.setFrom("flfiles");
  qA.setWhere("nombre LIKE '%.xml'");
  if (!qA.exec()) {
    return false;
  }
  var contenido;
  var xmlDoc, acciones, nombre;
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
        if (nombre in _i.acciones_) {
          continue;
        }
        debug("Cargando " + nombre);
        _i.acciones_[nombre] = true;
      }
    }
  }
  return true;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

