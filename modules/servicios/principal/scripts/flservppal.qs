/***************************************************************************
         flservppal.qs  -  description
               -------------------
  begin       : lun mar 12 2007
  copyright     : (C) 2007 by InfoSiAL S.L.
  email       : mail@infosial.com
 ***************************************************************************/

/***************************************************************************
 *                                               *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or   *
 *   (at your option) any later version.                   *
 *                                     *
 ***************************************************************************/

/** @file */

////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
class interna
{
  var ctx: Object;
  function interna(context)
  {
    this.ctx = context;
  }
  function init()
  {
    this.ctx.interna_init();
  }

  function beforeCommit_se_enviossw(curEnv: FLSqlCursor)
  {
    return this.ctx.interna_beforeCommit_se_enviossw(curEnv);
  }
  function beforeCommit_se_docespec(curDoc: FLSqlCursor)
  {
    return this.ctx.interna_beforeCommit_se_docespec(curDoc);
  }
  function beforeCommit_se_pactualizacion(curPA: FLSqlCursor)
  {
    return this.ctx.interna_beforeCommit_se_pactualizacion(curPA);
  }
  function beforeCommit_se_comunicaciones(curCom: FLSqlCursor)
  {
    return this.ctx.interna_beforeCommit_se_comunicaciones(curCom);
  }
  function beforeCommit_se_partners(curTab: FLSqlCursor)
  {
    return this.ctx.interna_beforeCommit_se_partners(curTab);
  }
  function beforeCommit_se_zonasporpartner(curTab: FLSqlCursor)
  {
    return this.ctx.interna_beforeCommit_se_zonasporpartner(curTab);
  }
  function beforeCommit_se_incidencias(curTab: FLSqlCursor)
  {
    return this.ctx.interna_beforeCommit_se_incidencias(curTab);
  }
  function beforeCommit_se_zonaspartners(curTab: FLSqlCursor)
  {
    return this.ctx.interna_beforeCommit_se_zonaspartners(curTab);
  }
  function afterCommit_se_incidencias(curInc: FLSqlCursor)
  {
    return this.ctx.interna_afterCommit_se_incidencias(curInc);
  }
  function afterCommit_se_historicos(curHis: FLSqlCursor)
  {
    return this.ctx.interna_afterCommit_se_historicos(curHis);
  }
  function afterCommit_se_partners(curTab: FLSqlCursor)
  {
    return this.ctx.interna_afterCommit_se_partners(curTab);
  }
  function afterCommit_se_zonaspartners(curTab: FLSqlCursor)
  {
    return this.ctx.interna_afterCommit_se_zonaspartners(curTab);
  }
  function afterCommit_se_zonasporpartner(curTab: FLSqlCursor)
  {
    return this.ctx.interna_afterCommit_se_zonasporpartner(curTab);
  }
  function afterCommit_se_facthoras(curHoras: FLSqlCursor)
  {
    return this.ctx.interna_afterCommit_se_facthoras(curHoras);
  }
  function afterCommit_se_horastrabajadas(curHoras: FLSqlCursor)
  {
    return this.ctx.interna_afterCommit_se_horastrabajadas(curHoras);
  }
  function afterCommit_se_proyectos(curProyecto)
  {
    return this.ctx.interna_afterCommit_se_proyectos(curProyecto);
  }
  function afterCommit_se_proyectos(curProyecto)
  {
    return this.ctx.interna_afterCommit_se_proyectos(curProyecto);
  }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna
{
  const ftSTRING_ = 3;
  const ftUINT_ = 17;
  const ftDOUBLE_ = 19;
  const ftDATE_ = 26;
  const ftSERIAL_ = 100;
  const ftUNLOCK_ = 200;

  var valoresCom: Array;
  function oficial(context)
  {
    interna(context);
  }
  function ejecutarComando(comando: String)
  {
    return this.ctx.oficial_ejecutarComando(comando);
  }
  function getValoresCom()
  {
    return this.ctx.oficial_getValoresCom(valoresCom);
  }
  function calcularSaldoCliente(codCliente: String)
  {
    return this.ctx.oficial_calcularSaldoCliente(codCliente);
  }
  function totalizarCreditosPorIncidencia(curInc: FLSqlCursor)
  {
    return this.ctx.oficial_totalizarCreditosPorIncidencia(curInc)
  }
         function siguienteSecuencia(tabla: String, nombreCodigo: String, longCampo: Number)
  {
    return this.ctx.oficial_siguienteSecuencia(tabla, nombreCodigo, longCampo);
  }
  function comprobarClienteCreditos(curIncidencia: FLSqlCursor)
  {
    return this.ctx.oficial_comprobarClienteCreditos(curIncidencia);
  }
  function componerCorreo(destinatario: String, asunto: String, cuerpo: String, adjuntos: String)
  {
    return this.ctx.oficial_componerCorreo(destinatario, asunto, cuerpo, adjuntos);
  }
  function sincronizarProcesoIncidencia(curInc: FLSqlCursor)
  {
    return this.ctx.oficial_sincronizarProcesoIncidencia(curInc);
  }
  function crearProcesoIncidencia(curInc: FLSqlCursor)
  {
    return this.ctx.oficial_crearProcesoIncidencia(curInc);
  }
  function sincronizarFechaRevision(curIncidencia: FLSqlCursor)
  {
    return this.ctx.oficial_sincronizarFechaRevision(curIncidencia);
  }
  function dameDialogoD()
  {
    return this.ctx.oficial_dameDialogoD();
  }
  function dameGroupBoxD(titulo: String)
  {
    return this.ctx.oficial_dameGroupBoxD(titulo);
  }
  function dameRadioButtonD(texto: String, seleccionado: Boolean)
  {
    return this.ctx.oficial_dameRadioButtonD(texto, seleccionado);
  }
  function dameLineEditD(etiqueta: String, texto: String)
  {
    return this.ctx.oficial_dameLineEditD(etiqueta, texto);
  }
  function dameCheckBoxD(texto: String, seleccionado: Boolean)
  {
    return this.ctx.oficial_dameCheckBoxD(texto, seleccionado);
  }
  function reasignacionIncidencia(curIncidencia: FLSqlCursor)
  {
    return this.ctx.oficial_reasignacionIncidencia(curIncidencia);
  }
  function totalizarHorasTrab(curHorasTrab: FLSqlCursor)
  {
    return this.ctx.oficial_totalizarHorasTrab(curHorasTrab);
  }
  function totalizarHorasTrabIncidencia(codIncidencia: String)
  {
    return this.ctx.oficial_totalizarHorasTrabIncidencia(codIncidencia);
  }
  function totalizarHorasTrabSubproyecto(codSubproyecto: String)
  {
    return this.ctx.oficial_totalizarHorasTrabSubproyecto(codSubproyecto);
  }
  function totalizarHorasTrabProyecto(codProyecto: String)
  {
    return this.ctx.oficial_totalizarHorasTrabProyecto(codProyecto);
  }
  function totalizarHorasTrabCliente(codCliente: String)
  {
    return this.ctx.oficial_totalizarHorasTrabCliente(codCliente);
  }
  function sincronizarProyectoSCoste(curProyecto)
  {
    return this.ctx.oficial_sincronizarProyectoSCoste(curProyecto);
  }
  function mtdImportarMail(curId, tabla)
  {
    return this.ctx.oficial_mtdImportarMail(curId, tabla);
  }
  function dameCursor(curId, tabla)
  {
    return this.ctx.oficial_dameCursor(curId, tabla);
  }
  function mtdEnviarMail(curId, tabla)
  {
    return this.ctx.oficial_mtdEnviarMail(curId, tabla);
  }
  function mtdEnviarSW(curId, tabla)
  {
    return this.ctx.oficial_mtdEnviarSW(curId, tabla);
  }
  function mtdCrearIncidencia(curId, tabla)
  {
    return this.ctx.oficial_mtdCrearIncidencia(curId, tabla);
  }
  function accionesAutomaticas(miForm)
  {
    return this.ctx.oficial_accionesAutomaticas(miForm);
  }
  function realizarAccionAutomatica(accion, miForm)
  {
    return this.ctx.oficial_realizarAccionAutomatica(accion, miForm);
  }
  function mtdAsignaHoras(curId)
  {
    return this.ctx.oficial_mtdAsignaHoras(curId)
  }
         function dameIdObjeto(curId)
  {
    return this.ctx.oficial_dameIdObjeto(curId)
  }
}
       //// OFICIAL /////////////////////////////////////////////////////
       //////////////////////////////////////////////////////////////////

       /////////////////////////////////////////////////////////////////
       //// DESARROLLO /////////////////////////////////////////////////
       class head extends oficial
{
  function head(context)
  {
    oficial(context);
  }
}

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head
{
  function ifaceCtx(context)
  {
    head(context);
  }
  function pub_ejecutarComando(comando: String)
  {
    return this.ejecutarComando(comando);
  }
  function pub_getValoresCom()
  {
    return this.getValoresCom();
  }
  function pub_siguienteSecuencia(tabla: String, nombreCodigo: String, longCampo: Number)
  {
    return this.siguienteSecuencia(tabla, nombreCodigo, longCampo);
  }
  function pub_componerCorreo(destinatario: String, asunto: String, cuerpo: String, adjuntos: String)
  {
    return this.componerCorreo(destinatario, asunto, cuerpo, adjuntos);
  }
  function pub_calcularSaldoCliente(codCliente: String)
  {
    return this.calcularSaldoCliente(codCliente);
  }
  function pub_sincronizarProcesoIncidencia(curInc: FLSqlCursor)
  {
    return this.sincronizarProcesoIncidencia(curInc);
  }
  function pub_dameDialogoD()
  {
    return this.dameDialogoD();
  }
  function pub_dameGroupBoxD(titulo: String)
  {
    return this.dameGroupBoxD(titulo);
  }
  function pub_dameRadioButtonD(texto: String, seleccionado: Boolean)
  {
    return this.dameRadioButtonD(texto, seleccionado);
  }
  function pub_dameLineEditD(etiqueta: String, texto: String)
  {
    return this.dameLineEditD(etiqueta, texto);
  }
  function pub_dameCheckBoxD(texto: String, seleccionado: Boolean)
  {
    return this.dameCheckBoxD(texto, seleccionado);
  }
  function pub_mtdImportarMail(curId, tabla)
  {
    return this.mtdImportarMail(curId, tabla);
  }
  function pub_mtdEnviarMail(curId, tabla)
  {
    return this.mtdEnviarMail(curId, tabla);
  }
  function pub_mtdEnviarSW(curId, tabla)
  {
    return this.mtdEnviarSW(curId, tabla);
  }
  function pub_mtdCrearIncidencia(curId, tabla)
  {
    return this.mtdCrearIncidencia(curId, tabla);
  }
  function pub_accionesAutomaticas(miForm)
  {
    return this.accionesAutomaticas(miForm);
  }
  function pub_mtdAsignaHoras(curId)
  {
    return this.mtdAsignaHoras(curId);
  }
}

const iface = new ifaceCtx(this);
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////

function init()
{
}

function interna_init()
{
}

/** \C Al eliminar un envío de software se eliminará también
la comunicación asociada
\end */
function interna_beforeCommit_se_enviossw(curEnv)
{
  var util = new FLUtil();
  var curCom = new FLSqlCursor("se_comunicaciones");
  var codComunicacion = curEnv.valueBuffer("codcomunicacion");

  switch (curEnv.modeAccess()) {

    case curEnv.Del:
      curCom.select("codigo = '" + codComunicacion + "'");
      if (curCom.first()) {
        curCom.setModeAccess(curCom.Del);
        curCom.refreshBuffer();
        curCom.commitBuffer();
      }
      break;
  }

  return true;
}

/** \C Al eliminar un documento de especificación se eliminará también
la comunicación asociada
\end */
function interna_beforeCommit_se_docespec(curDoc)
{
  var util = new FLUtil();
  var curCom = new FLSqlCursor("se_comunicaciones");
  var codComunicacion = curDoc.valueBuffer("codcomunicacion");

  switch (curDoc.modeAccess()) {

    case curDoc.Del:
      curCom.select("codigo = '" + codComunicacion + "'");
      if (curCom.first()) {
        curCom.setModeAccess(curCom.Del);
        curCom.refreshBuffer();
        curCom.commitBuffer();
      }
      break;
  }

  return true;
}

/** \C Si un periodo de actualización ha sido facturado no se puede eliminar sin
eliminar antes la factura
\end */
function interna_beforeCommit_se_pactualizacion(curPA: FLSqlCursor)
{
  var util = new FLUtil();

  switch (curPA.modeAccess()) {

    case curPA.Del:
      var codFactura = util.sqlSelect("facturascli", "codigo", "idfactura = " + curPA.valueBuffer("idfactura"));
      if (codFactura) {
        MessageBox.warning(util.translate("scripts", "Antes de eliminar el período debería eliminar la Factura asociada: ") + codFactura , MessageBox.Ok, MessageBox.NoButton);
        return false;
      }
      break;
  }
  return true;
}
function interna_beforeCommit_se_comunicaciones(curCom: FLSqlCursor)
{
  debug("BC1");
  if (curCom.modeAccess() == curCom.Del) {
    var util = new FLUtil();
    util.sqlUpdate("se_historicos", "codcomunicacion", null, "codcomunicacion = '" + curCom.valueBuffer("codigo") + "'")
  }
  debug("BC2");
  return true;
}

function interna_afterCommit_se_facthoras(curHoras: FLSqlCursor)
{
  var saldo = 0;
  var saldo = this.iface.calcularSaldoCliente(curHoras.valueBuffer("codcliente"));
  if (isNaN(saldo))
    return false;

  curHoras.cursorRelation().setValueBuffer("saldocreditos", saldo);

  return true;
}

function interna_afterCommit_se_horastrabajadas(curHoras: FLSqlCursor)
{
  debug("interna_afterCommit_se_horastrabajadas");
  if (!this.iface.totalizarHorasTrab(curHoras)) {
    return false;
  }
  return true;
}

/** \C Si la incidencia corresponde a un período de actualización,
se recalcula el número de incidencias consumidas en el
actual período de actualización.
Se recalcula el saldo de horas del cliente descontando el valor de la incidencia
\end */
function interna_afterCommit_se_incidencias(curInc: FLSqlCursor)
{
  var util = new FLUtil();
  var idPActualizacion = curInc.valueBuffer("idpactualizacion");

  if (idPActualizacion) {
    formRecordse_pactualizacion.iface.pub_actualizarIncidencias();
  }
  if (!this.iface.totalizarCreditosPorIncidencia(curInc)) {
    return false;
  }

  if (curInc.valueBuffer("enbolsa")) {
    flsistwebi.iface.pub_setBorrado(curInc);
  }

  if (!this.iface.crearProcesoIncidencia(curInc)) {
    return false;
  }

  if (!this.iface.sincronizarFechaRevision(curInc)) {
    return false;
  }

  if (!this.iface.reasignacionIncidencia(curInc)) {
    return false;
  }
  return true;
}

function oficial_crearProcesoIncidencia(curInc: FLSqlCursor)
{
  var util = new FLUtil;
  var estado = curInc.valueBuffer("estado");
  switch (curInc.modeAccess()) {
    case curInc.Insert:
    case curInc.Edit: {
      switch (estado) {
        case "Pendiente": {
          if (!util.sqlSelect("pr_procesos", "idproceso", "idtipoproceso = 'SC_INCIDENCIA' AND idobjeto = '" + curInc.valueBuffer("codigo") + "'")) {
            var res = MessageBox.information(util.translate("scripts", "¿Quieres lanzar un proceso de indicencia?"), MessageBox.Yes, MessageBox.No);
            if (res == MessageBox.Yes) {
              var idProceso = flcolaproc.iface.pub_crearProceso("SC_INCIDENCIA", "se_incidencias", curInc.valueBuffer("codigo"));
              if (!idProceso) {
                return false;
              }
            }
          }
          break;
        }
      }
      break;
    }
  }
  return true;
}

/** \D Actualiza la fecha de activación de la tarea en función de la fecha de revisión de la incidencia asociada
@param  curIncidencia: Cursor de la incidencia
\end */
function oficial_sincronizarFechaRevision(curIncidencia: FLSqlCursor)
{
  var util = new FLUtil;
  switch (curIncidencia.modeAccess()) {
    case curIncidencia.Edit: {
      var estado = curIncidencia.valueBuffer("estado");
      switch (estado) {
        case "En pruebas":
        case "En espera": {
          var fechaRevision = curIncidencia.valueBuffer("fecharevision");
          if (fechaRevision != curIncidencia.valueBufferCopy("fecharevision")) {
            var curTarea = new FLSqlCursor("pr_tareas");
            curTarea.setActivatedCommitActions(false);
            curTarea.setActivatedCheckIntegrity(false);
            curTarea.select("tipoobjeto = 'se_incidencias' AND idobjeto = '" + curIncidencia.valueBuffer("codigo") + "' AND codtipotareapro = 'SC_INCIDENCIA_SC_RESOLVER'");
            if (curTarea.first()) {
              curTarea.setModeAccess(curTarea.Edit);
              curTarea.refreshBuffer();
              curTarea.setValueBuffer("fechaactivacion", fechaRevision);
              if (!curTarea.commitBuffer()) {
                return false;
              }
            }
          }
          break;
        }
      }
      break;
    }
  }
  return true;
}

/** \D Reasigna la tarea al nuevo usuario
@param  curIncidencia: Cursor de la incidencia
\end */
function oficial_reasignacionIncidencia(curIncidencia: FLSqlCursor)
{
  var util = new FLUtil;
  switch (curIncidencia.modeAccess()) {
    case curIncidencia.Edit: {
      var usuarioActual = curIncidencia.valueBuffer("codencargado");
      var usuarioAnterior = curIncidencia.valueBufferCopy("codencargado");
      if (usuarioAnterior != "" && usuarioActual != "" && usuarioAnterior != usuarioActual) {
        var curTarea = new FLSqlCursor("pr_tareas");
        curTarea.setActivatedCommitActions(false);
        curTarea.setActivatedCheckIntegrity(false);
        curTarea.select("tipoobjeto = 'se_incidencias' AND idobjeto = '" + curIncidencia.valueBuffer("codigo") + "' AND codtipotareapro = 'SC_INCIDENCIA_SC_RESOLVER'");
        if (curTarea.first()) {
          curTarea.setModeAccess(curTarea.Edit);
          curTarea.refreshBuffer();
          curTarea.setValueBuffer("iduser", usuarioActual);
          if (!curTarea.commitBuffer()) {
            return false;
          }
        }
      }
      break;
    }
  }
  return true;
}

/** \C Se establece el estado del subproyecto como el estado resultante
del histórico
\end */
function interna_afterCommit_se_historicos(curHis: FLSqlCursor)
{
  var util = new FLUtil();

  switch (curHis.modeAccess()) {
    case curHis.Insert:
    case curHis.Edit: {
      if (curHis.valueBuffer("estado") != curHis.valueBufferCopy("estado")) {
        var estado = util.sqlSelect("se_historicos", "estado", "codsubproyecto = '" + curHis.valueBuffer("codsubproyecto") + "' order by fecha desc, id desc");
        if (!curHis.cursorRelation())
          return false;
        curHis.cursorRelation().setValueBuffer("estado", estado);
      }
      break;
    }
  }

  return true;
}
function interna_beforeCommit_se_zonaspartners(cursor: FLSqlCursor)
{
  flsistwebi.iface.pub_setModificado(cursor);
  return true;
}
function interna_beforeCommit_se_partners(cursor: FLSqlCursor)
{
  flsistwebi.iface.pub_setModificado(cursor);
  return true;
}
function interna_beforeCommit_se_zonasporpartner(cursor: FLSqlCursor)
{
  flsistwebi.iface.pub_setModificado(cursor);
  return true;
}
function interna_beforeCommit_se_incidencias(curIncidencia: FLSqlCursor)
{

  switch (curIncidencia.modeAccess()) {
    case curIncidencia.Insert:
    case curIncidencia.Edit: {
      if (curIncidencia.valueBuffer("enbolsa")) {
        if (!this.iface.comprobarClienteCreditos(curIncidencia))
          return false;
      }
      break;
    }
  }
  if (curIncidencia.valueBuffer("enbolsa")) {
    flsistwebi.iface.pub_setModificado(curIncidencia);
  }
  return true;
}

function interna_afterCommit_se_zonaspartners(cursor: FLSqlCursor)
{
  flsistwebi.iface.pub_setBorrado(cursor);
  return true;
}
function interna_afterCommit_se_zonasporpartner(cursor: FLSqlCursor)
{
  flsistwebi.iface.pub_setBorrado(cursor);
  return true;
}
function interna_afterCommit_se_partners(cursor: FLSqlCursor)
{
  flsistwebi.iface.pub_setBorrado(cursor);
  return true;
}

function interna_afterCommit_se_proyectos(curProyecto)
{
  if (!this.iface.sincronizarProyectoSCoste(curProyecto)) {
    return false;
  }
  return true;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_sincronizarProyectoSCoste(curProyecto)
{

  var curSC = new FLSqlCursor("subcentroscoste");
  var codCentro = "CL" + curProyecto.valueBuffer("codcliente");
  var codSubcentro = "PR" + curProyecto.valueBuffer("codigo");
  switch (curProyecto.modeAccess()) {
    case curProyecto.Insert: {
      curSC.setModeAccess(curSC.Insert);
      curSC.refreshBuffer();
      curSC.setValueBuffer("codsubcentro", codSubcentro);
      curSC.setValueBuffer("codcentro", codCentro);
      curSC.setValueBuffer("descripcion", curProyecto.valueBuffer("descripcion"));
      if (curSC.commitBuffer()) {
        return false;
      }
      break;
    }
    case curProyecto.Edit: {
      curSC.select("codsubcentro = '" + codSubcentro + "'");
      if (curSC.first()) {
        curSC.setModeAccess(curSC.Edit);
        curSC.refreshBuffer();
      } else {
        curSC.setModeAccess(curSC.Insert);
        curSC.refreshBuffer();
        curSC.setValueBuffer("codcentro", codCentro);
        curSC.setValueBuffer("codsubcentro", codSubcentro);
      }
      curSC.setValueBuffer("descripcion", curProyecto.valueBuffer("descripcion"));
      if (!curSC.commitBuffer()) {
        return false;
      }
      break;
    }
    case curProyecto.Del: {
      curSC.select("codsubcentro = '" + codSubcentro + "'");
      if (curSC.first()) {
        curSC.setModeAccess(curSC.Del);
        curSC.refreshBuffer();
        if (curSC.commitBuffer()) {
          return false;
        }
      }
      break;
    }
  }
  return true;
}
/** Totaliza los créditos por cliente, proyecto y subproyecto en función de los créditos facturados en una incidencia
\end */
function oficial_totalizarCreditosPorIncidencia(curInc: FLSqlCursor)
{
  var util = new FLUtil();
  var cursorPadre = curInc.cursorRelation();

  var codCliente = curInc.valueBuffer("codcliente");
  if (codCliente && codCliente != "") {
    if (!(cursorPadre && cursorPadre.action() == "se_clientes")) {
      var curCliente = new FLSqlCursor("clientes");
      curCliente.setActivatedCommitActions(false);
      curCliente.select("codcliente = '" + codCliente + "'");
      if (!curCliente.first()) {
        MessageBox.warning(util.translate("scripts", "Error al actualizar el saldo del cliente asociado a la incidencia"), MessageBox.Ok, MessageBox.NoButton);
        return false;
      }
      curCliente.setModeAccess(curCliente.Edit);
      curCliente.refreshBuffer();
      curCliente.setValueBuffer("saldocreditos", formRecordse_clientes.iface.pub_commonCalculateField("saldocreditos", curCliente));
      curCliente.setValueBuffer("horasfact", formRecordse_clientes.iface.pub_commonCalculateField("horasfact", curCliente));
      curCliente.setValueBuffer("beneficiohora", formRecordse_clientes.iface.pub_commonCalculateField("beneficiohora", curCliente));
      if (!curCliente.commitBuffer()) {
        return false;
      }
    }
  }
  var codProyecto = curInc.valueBuffer("codproyecto");
  if (codProyecto && codProyecto != "") {
    if (!(cursorPadre && cursorPadre.action() == "se_proyectos")) {
      var curProyecto = new FLSqlCursor("se_proyectos");
      curProyecto.setActivatedCommitActions(false);
      curProyecto.select("codigo = '" + codProyecto + "'");
      if (!curProyecto.first()) {
        MessageBox.warning(util.translate("scripts", "Error al actualizar el saldo del proyecto asociado a la incidencia"), MessageBox.Ok, MessageBox.NoButton);
        return false;
      }
      curProyecto.setModeAccess(curProyecto.Edit);
      curProyecto.refreshBuffer();
      curProyecto.setValueBuffer("horasfact", formRecordse_proyectos.iface.pub_commonCalculateField("horasfact", curProyecto));
      curProyecto.setValueBuffer("beneficiohora", formRecordse_proyectos.iface.pub_commonCalculateField("beneficiohora", curProyecto));
      if (!curProyecto.commitBuffer()) {
        return false;
      }
    }
  }
  var codSubproyecto = curInc.valueBuffer("codsubproyecto");
  if (codSubproyecto && codSubproyecto != "") {
    if (!(cursorPadre && cursorPadre.action() == "se_subproyectos")) {
      var curSubproyecto = new FLSqlCursor("se_subproyectos");
      curSubproyecto.setActivatedCommitActions(false);
      curSubproyecto.select("codigo = '" + codSubproyecto + "'");
      if (!curSubproyecto.first()) {
        MessageBox.warning(util.translate("scripts", "Error al actualizar el saldo del subproyecto asociado a la incidencia"), MessageBox.Ok, MessageBox.NoButton);
        return false;
      }
      curSubproyecto.setModeAccess(curSubproyecto.Edit);
      curSubproyecto.refreshBuffer();
      curSubproyecto.setValueBuffer("horasfact", formRecordse_subproyectos.iface.pub_commonCalculateField("horasfact", curSubproyecto));
      curSubproyecto.setValueBuffer("beneficiohora", formRecordse_subproyectos.iface.pub_commonCalculateField("beneficiohora", curSubproyecto));
      if (!curSubproyecto.commitBuffer()) {
        return false;
      }
    }
  }
  return true;
}

function oficial_calcularSaldoCliente(codCliente: String)
{
  var saldo = 0;
  var precios = 0;

  var util = new FLUtil();
  //  var horas= util.sqlSelect("se_facthoras", "SUM(precio)", "codcliente = '" + codCliente + "' AND enbolsa = true");

  var q = new FLSqlQuery();
  q.setTablesList("se_incidencias");
  q.setFrom("se_incidencias");
  q.setSelect("precio");
  q.setWhere("codcliente = '" + codCliente + "' AND enbolsa = true");

  if (!q.exec())
    return false;
  while (q.next()) {
    precios += parseFloat(q.value("precio"));
  }

  saldo = parseFloat(precios);
  saldo = util.roundFieldValue(saldo, "clientes", "saldocreditos");
  return saldo;
}
/** \D
Ejecuta un comando externo
@param  comando: Comando a ejecutar
@return Array con dos datos:
  ok: True si no hay error, false en caso contrario
  salida: Mensaje de stdout o stderr obtenido
\end */
function oficial_ejecutarComando(comando: String)
{
  var res = [];
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

function oficial_siguienteSecuencia(tabla: String, nombreCodigo: String, longCampo: Number)
{
  var util: FLUtil;
  var valor = util.sqlSelect("se_secuencias", "valor", "nombre = '" + tabla + "'");

  var nuevoValor: Number;
  var curSecuencia = new FLSqlCursor("se_secuencias");
  if (!valor) {
    valor = parseFloat(util.sqlSelect(tabla, "MAX(" + nombreCodigo + ")", "1 = 1"));
    if (!valor || valor == "")
      valor = 0;

    valor += 1;
    nuevoValor = valor;

    with(curSecuencia) {
      setModeAccess(Insert);
      refreshBuffer();
      setValueBuffer("valor", nuevoValor);
      setValueBuffer("nombre", tabla);
      if (!commitBuffer())
        return false;
    }

  } else {
    curSecuencia.select("nombre = '" + tabla + "'");
    if (!curSecuencia.first())
      return false;
    valor += 1;
    nuevoValor = valor;

    curSecuencia.setModeAccess(curSecuencia.Edit);
    curSecuencia.refreshBuffer();
    curSecuencia.setValueBuffer("valor", nuevoValor);
    if (!curSecuencia.commitBuffer())
      return false;
  }
  return nuevoValor;
}

/** \D Comprueba que el cliente tiene marcado el indicador Créditos al asociársele una incidencia a cargar en la bolsa
@param  curIncidencia: Cursor de la incidencia
@return true si la comprobación es correcta
\end */
function oficial_comprobarClienteCreditos(curIncidencia: FLSqlCursor)
{
  var util = new FLUtil;

  var curRelation = curIncidencia.cursorRelation();
  var codCliente = curIncidencia.valueBuffer("codcliente");
  var creditos: Boolean;
  if (curRelation && curRelation.table() == "clientes") {
    creditos = curRelation.valueBuffer("creditos");
    if (!creditos) {
      MessageBox.warning(util.translate("scripts", "Debe marcar la casilla de créditos antes de asociar indidencias a la bolsa de créditos del cliente"), MessageBox.Ok, MessageBox.NoButton);
      return false;
    }
  } else {
    creditos = util.sqlSelect("clientes", "creditos", "codcliente = '" + codCliente + "'");
    if (!creditos) {
      var res = MessageBox.warning(util.translate("scripts", "Para guardar la incidencia es necesario que el cliente tenga activado el indicador de créditos.\n¿Desea activarlo ahora?"), MessageBox.Yes, MessageBox.No);
      if (res != MessageBox.Yes)
        return false;
      if (!util.sqlUpdate("clientes", "creditos", "true", "codcliente = '" + codCliente + "'"))
        return false;
    }
  }
  return true;
}

function oficial_componerCorreo(destinatario: String, asunto: String, cuerpo: String, adjuntos: String)
{
  var util = new FLUtil();
  var clienteCorreo = util.readSettingEntry("scripts/flservppal/clientecorreo");
  var comando: String;

  switch (clienteCorreo) {
    case "thunderbird":
      comando = "thunderbird -compose to='" + destinatario + "',subject=" + asunto + ",body='" + cuerpo + "'";
      break;

    case "evolution":
      adjuntos = adjuntos.replace("--attach", "");
      while(adjuntos.startsWith(" "))
        adjuntos = adjuntos.replace(" ", "");
      comando = "evolution -c mail mailto:" + destinatario + 
                "?subject=" + asunto +
                "\\&attach=\"" + adjuntos + "\"" +
                "\\&body=" + cuerpo;
      break;

    default:
      comando = "kmail " + destinatario + " -s " + asunto + " --body " + cuerpo + adjuntos;
  }

  return comando;
}

function oficial_sincronizarProcesoIncidencia(curInc: FLSqlCursor)
{
  var util = new FLUtil;
  var estado = curInc.valueBuffer("estado");
  var estadoAnt = curInc.valueBufferCopy("estado");
  switch (estado) {
    case "Resuelta": {
      var curTarea = new FLSqlCursor("pr_tareas");
      curTarea.select("tipoobjeto = 'se_incidencias' AND idobjeto = '" + curInc.valueBuffer("codigo") + "' AND codtipotareapro = 'SC_INCIDENCIA_SC_RESOLVER'");
      if (curTarea.first()) {
        if (estadoAnt == "Cancelada") {
          var idTarea = curTarea.valueBuffer("idtarea");
          var idProceso = curTarea.valueBuffer("idproceso");
          if (!flcolaproc.iface.pub_reanudarProceso(idProceso)) {
            return false;
          }
          curTarea.select("idtarea = '" + idTarea + "'");
          curTarea.first();
        }
        if (curTarea.valueBuffer("estado") != "TERMINADA") {
          var curTransaccion = new FLSqlCursor("empresa");
          curTransaccion.transaction(false);
          try {
            if (flcolaproc.iface.pub_terminarTareaPorEstado(curTarea)) {
              curTransaccion.commit();
            } else {
              curTransaccion.rollback();
              return false;
            }
          } catch (e) {
            curTransaccion.rollback();
            MessageBox.warning(util.translate("scripts", "Hubo un error al terminar la tarea %1:").arg(idTarea) + e, MessageBox.Ok, MessageBox.NoButton);
            return false;
          }
        }
        break;
      }
    }
    case "En espera":
    case "En pruebas": {
      var fechaRevision = curInc.valueBuffer("fecharevision");
      var curTarea = new FLSqlCursor("pr_tareas");
      curTarea.select("tipoobjeto = 'se_incidencias' AND idobjeto = '" + curInc.valueBuffer("codigo") + "' AND codtipotareapro = 'SC_INCIDENCIA_SC_RESOLVER'");
      if (curTarea.first()) {
        if (estadoAnt == "Cancelada") {
          var idTarea = curTarea.valueBuffer("idtarea");
          var idProceso = curTarea.valueBuffer("idproceso");
          if (!flcolaproc.iface.pub_reanudarProceso(idProceso)) {
            return false;
          }
          curTarea.select("idtarea = '" + idTarea + "'");
          curTarea.first();
        }
        if (curTarea.valueBuffer("estado") != "DORMIDA") {
          var curTransaccion = new FLSqlCursor("empresa");
          curTransaccion.transaction(false);
          try {
            if (flcolaproc.iface.pub_dormirTareaPorEstado(curTarea, fechaRevision)) {
              curTransaccion.commit();
            } else {
              curTransaccion.rollback();
              return false;
            }
          } catch (e) {
            curTransaccion.rollback();
            MessageBox.warning(util.translate("scripts", "Hubo un error al dormir la tarea %1:").arg(idTarea) + e, MessageBox.Ok, MessageBox.NoButton);
            return false;
          }
        }
      }
      break;
    }
    case "Pendiente":
    case "En desarrollo": {
      var curTarea = new FLSqlCursor("pr_tareas");
      curTarea.select("tipoobjeto = 'se_incidencias' AND idobjeto = '" + curInc.valueBuffer("codigo") + "' AND codtipotareapro = 'SC_INCIDENCIA_SC_RESOLVER'");
      if (curTarea.first()) {
        if (estadoAnt == "Cancelada") {
          var idTarea = curTarea.valueBuffer("idtarea");
          var idProceso = curTarea.valueBuffer("idproceso");
          if (!flcolaproc.iface.pub_reanudarProceso(idProceso)) {
            return false;
          }
          curTarea.select("idtarea = '" + idTarea + "'");
          curTarea.first();
        }
        if (curTarea.valueBuffer("estado") != "PTE" && curTarea.valueBuffer("estado") != "EN CURSO") {
          var curTransaccion = new FLSqlCursor("empresa");
          curTransaccion.transaction(false);
          try {
            if (flcolaproc.iface.pub_ponerTareaEnCursoPorEstado(curTarea)) {
              curTransaccion.commit();
            } else {
              curTransaccion.rollback();
              return false;
            }
          } catch (e) {
            curTransaccion.rollback();
            MessageBox.warning(util.translate("scripts", "Hubo un error al poner EN CURSO la tarea %1:").arg(curTarea.valueBuffer("idtarea")) + e, MessageBox.Ok, MessageBox.NoButton);
            return false;
          }
        }
      }
      break;
    }
    case "Cancelada": {
      var curTarea = new FLSqlCursor("pr_tareas");
      curTarea.select("tipoobjeto = 'se_incidencias' AND idobjeto = '" + curInc.valueBuffer("codigo") + "' AND codtipotareapro = 'SC_INCIDENCIA_SC_RESOLVER'");
      if (curTarea.first()) {
        if (curTarea.valueBuffer("estado") != "PTE") {
          var curTransaccion = new FLSqlCursor("empresa");
          curTransaccion.transaction(false);
          try {
            if (flcolaproc.iface.pub_ponerTareaPtePorEstado(curTarea)) {
              curTransaccion.commit();
            } else {
              curTransaccion.rollback();
              return false;
            }
          } catch (e) {
            curTransaccion.rollback();
            MessageBox.warning(util.translate("scripts", "Hubo un error al poner EN CURSO la tarea %1:").arg(curTarea.valueBuffer("idtarea")) + e, MessageBox.Ok, MessageBox.NoButton);
            return false;
          }
        }
        var idProceso = curTarea.valueBuffer("idproceso");
        if (!flcolaproc.iface.pub_cancelarProceso(idProceso)) {
          return false;
        }
      }
      break;
    }
  }
  return true;
}

function oficial_dameDialogoD()
{
  var util = new FLUtil;
  var dialogo = new Dialog;
  dialogo.okButtonText = util.translate("scripts", "Aceptar");
  dialogo.cancelButtonText = util.translate("scripts", "Cancelar");
  return dialogo;
}

function oficial_dameGroupBoxD(titulo: String)
{
  var util = new FLUtil;
  var gbx = new GroupBox;
  gbx.title = titulo;
  return gbx;
}

function oficial_dameRadioButtonD(texto: String, seleccionado: Boolean)
{
  var util = new FLUtil;
  var rbn: RadioButton = new RadioButton;
  rbn.text = texto;
  rbn.checked = seleccionado;
  return rbn;
}

function oficial_dameCheckBoxD(texto: String, seleccionado: Boolean)
{
  var util = new FLUtil;
  var chk: CheckBox = new CheckBox;
  chk.text = texto;
  chk.checked = seleccionado;
  return chk;
}

function oficial_dameLineEditD(etiqueta: String, texto: String)
{
  var util = new FLUtil;
  var led: LineEdit = new LineEdit;
  led.label = etiqueta;
  if (texto) {
    led.text = texto;
  }
  return led;
}

/** \D Totaliza las horas en la incidencia o incidencias  asociadas a un registro de horas trabajadas
@param  curHoras: Registro de horas trabajadas
\end */
function oficial_totalizarHorasTrab(curHorasTrab: FLSqlCursor)
{
  var codIncidencia = curHorasTrab.valueBuffer("codincidencia");
  if (!this.iface.totalizarHorasTrabIncidencia(codIncidencia)) {
    return false;
  }
  var codSubproyecto = curHorasTrab.valueBuffer("codsubproyecto");
  if (!this.iface.totalizarHorasTrabSubproyecto(codSubproyecto)) {
    return false;
  }
  var codProyecto = curHorasTrab.valueBuffer("codproyecto");
  if (!this.iface.totalizarHorasTrabProyecto(codProyecto)) {
    return false;
  }
  var codCliente = curHorasTrab.valueBuffer("codcliente");
  if (!this.iface.totalizarHorasTrabCliente(codCliente)) {
    return false;
  }
  if (curHorasTrab.modeAccess() == curHorasTrab.Edit) {
    var codIncidenciaPrevia = curHorasTrab.valueBufferCopy("codincidencia");
    if (codIncidenciaPrevia && codIncidenciaPrevia != "" && codIncidenciaPrevia != codIncidencia) {
      if (!this.iface.totalizarHorasTrabIncidencia(codIncidenciaPrevia)) {
        return false;
      }
    }
    var codSubproyectoPrevio = curHorasTrab.valueBufferCopy("codsubproyecto");
    if (codSubproyectoPrevio && codSubproyectoPrevio != "" && codSubproyectoPrevio != codSubproyecto) {
      if (!this.iface.totalizarHorasTrabSubproyecto(codSubproyectoPrevio)) {
        return false;
      }
    }
    var codProyectoPrevio = curHorasTrab.valueBufferCopy("codproyecto");
    if (codProyectoPrevio && codProyectoPrevio != "" && codProyectoPrevio != codSubproyecto) {
      if (!this.iface.totalizarHorasTrabProyecto(codProyectoPrevio)) {
        return false;
      }
    }
    var codClientePrevio = curHorasTrab.valueBufferCopy("codcliente");
    if (codClientePrevio && codClientePrevio != "" && codClientePrevio != codCliente) {
      if (!this.iface.totalizarHorasTrabCliente(codClientePrevio)) {
        return false;
      }
    }
  }
  return true;
}

/** \D Totaliza las horas trabajadas asociadas a una incidencia
@param  codIncidencia: Código de incidencia.
\end */
function oficial_totalizarHorasTrabIncidencia(codIncidencia: String)
{
  if (codIncidencia && codIncidencia != "") {
    var curIncidencia = new FLSqlCursor("se_incidencias");
    curIncidencia.select("codigo = '" + codIncidencia + "'");
    if (!curIncidencia.first()) {
      return false;
    }
    curIncidencia.setModeAccess(curIncidencia.Edit);
    curIncidencia.refreshBuffer();
    curIncidencia.setValueBuffer("horastrab", formRecordse_incidencias.iface.pub_commonCalculateField("horastrab", curIncidencia));
    curIncidencia.setValueBuffer("beneficiohora", formRecordse_incidencias.iface.pub_commonCalculateField("beneficiohora", curIncidencia));
    if (!curIncidencia.commitBuffer()) {
      return false;
    }
  }
  return true;
}

/** \D Totaliza las horas trabajadas asociadas a un subproyecto
@param  codSubproyecto: Código de subproyecto.
\end */
function oficial_totalizarHorasTrabSubproyecto(codSubproyecto: String)
{
  if (codSubproyecto && codSubproyecto != "") {
    var curSubproyecto = new FLSqlCursor("se_subproyectos");
    curSubproyecto.select("codigo = '" + codSubproyecto + "'");
    if (!curSubproyecto.first()) {
      return false;
    }
    curSubproyecto.setModeAccess(curSubproyecto.Edit);
    curSubproyecto.refreshBuffer();
    curSubproyecto.setValueBuffer("horastrab", formRecordse_subproyectos.iface.pub_commonCalculateField("horastrab", curSubproyecto));
    curSubproyecto.setValueBuffer("beneficiohora", formRecordse_subproyectos.iface.pub_commonCalculateField("beneficiohora", curSubproyecto));
    if (!curSubproyecto.commitBuffer()) {
      return false;
    }
  }
  return true;
}

/** \D Totaliza las horas trabajadas asociadas a un proyecto
@param  codProyecto: Código de proyecto.
\end */
function oficial_totalizarHorasTrabProyecto(codProyecto: String)
{
  if (codProyecto && codProyecto != "") {
    var curProyecto = new FLSqlCursor("se_proyectos");
    curProyecto.select("codigo = '" + codProyecto + "'");
    if (!curProyecto.first()) {
      return false;
    }
    curProyecto.setModeAccess(curProyecto.Edit);
    curProyecto.refreshBuffer();
    curProyecto.setValueBuffer("horastrab", formRecordse_proyectos.iface.pub_commonCalculateField("horastrab", curProyecto));
    curProyecto.setValueBuffer("beneficiohora", formRecordse_proyectos.iface.pub_commonCalculateField("beneficiohora", curProyecto));
    if (!curProyecto.commitBuffer()) {
      return false;
    }
  }
  return true;
}

/** \D Totaliza las horas trabajadas asociadas a un cliente
@param  codCliente: Código de cliente.
\end */
function oficial_totalizarHorasTrabCliente(codCliente)
{
  if (codCliente && codCliente != "") {
    var curCliente = new FLSqlCursor("clientes");
    curCliente.select("codcliente = '" + codCliente + "'");
    if (!curCliente.first()) {
      return false;
    }
    curCliente.setModeAccess(curCliente.Edit);
    curCliente.refreshBuffer();
    curCliente.setValueBuffer("horastrab", formRecordse_clientes.iface.pub_commonCalculateField("horastrab", curCliente));
    curCliente.setValueBuffer("beneficiohora", formRecordse_clientes.iface.pub_commonCalculateField("beneficiohora", curCliente));
    curCliente.setValueBuffer("horastrab2010", formRecordse_clientes.iface.pub_commonCalculateField("horastrab2010", curCliente));
    curCliente.setValueBuffer("brutohora2010", formRecordse_clientes.iface.pub_commonCalculateField("brutohora2010", curCliente));
    if (!curCliente.commitBuffer()) {
      return false;
    }
  }
  return true;
}

function oficial_mtdImportarMail(curId, tabla)
{
  var _i = this.iface;
  var curObjeto = _i.dameCursor(curId, tabla);
  if (!curObjeto) {
    return false;
  }
  switch (curObjeto.table()) {
    case "se_subproyectos": {
      var acciones: Array = [];
      acciones[0] = flcolaproc.iface.pub_arrayAccion("se_comunicaciones", "informar_campos");
      acciones[0].campos = ["codsubproyecto", "codproyecto", "codcliente"];
      acciones[0].valores = [curObjeto.valueBuffer("codigo"), curObjeto.valueBuffer("codproyecto"), curObjeto.valueBuffer("codcliente")];

      acciones[1] = flcolaproc.iface.pub_arrayAccion("se_comunicaciones", "importar_mail");
      flcolaproc.iface.pub_setAccionesAuto(acciones);
      break;
    }
    case "se_incidencias": {
      var acciones: Array = [];
      acciones[0] = flcolaproc.iface.pub_arrayAccion("se_comunicaciones", "informar_campos");
      acciones[0].campos = ["codincidencia", "codsubproyecto", "codproyecto", "codcliente"];
      acciones[0].valores = [curObjeto.valueBuffer("codigo"), curObjeto.valueBuffer("codsubproyecto"), curObjeto.valueBuffer("codproyecto"), curObjeto.valueBuffer("codcliente")];

      acciones[1] = flcolaproc.iface.pub_arrayAccion("se_comunicaciones", "importar_mail");
      flcolaproc.iface.pub_setAccionesAuto(acciones);
      break;
    }
  }
  var curCom = new FLSqlCursor("se_comunicaciones");
  curCom.insertRecord();
}

function oficial_mtdEnviarMail(curId, tabla)
{
  var _i = this.iface;
  var curObjeto = _i.dameCursor(curId, tabla);
  if (!curObjeto) {
    return false;
  }
  switch (curObjeto.table()) {
    case "se_subproyectos": {
      var acciones: Array = [];
      acciones[0] = flcolaproc.iface.pub_arrayAccion("se_comunicaciones", "informar_campos");
      acciones[0].campos = ["codsubproyecto", "codproyecto", "codcliente"];
      acciones[0].valores = [curObjeto.valueBuffer("codigo"), curObjeto.valueBuffer("codproyecto"), curObjeto.valueBuffer("codcliente")];

      flcolaproc.iface.pub_setAccionesAuto(acciones);
      break;
    }
  }
  var curCom = new FLSqlCursor("se_comunicaciones");
  curCom.insertRecord();
}

function oficial_accionesAutomaticas(miForm)
{
  var acciones: Array = flcolaproc.iface.pub_accionesAuto();
  if (!acciones) {
    return;
  }
  var i: Number = 0;
  while (i < acciones.length && acciones[i]["usada"]) {
    i++;
  }
  if (i == acciones.length) {
    return;
  }
  var cursor = miForm.cursor();
  debug("contexto " + acciones[i]["contexto"] + " = " + cursor.table());
  while (i < acciones.length && acciones[i]["contexto"] == cursor.table()) {
    if (!this.iface.realizarAccionAutomatica(acciones[i], miForm)) {
      break;
    }
    i++;
  }
}

/** \D Realizar una determinada acción.
@return: Se devuelve false si algo falla o si la acción implica que no debe realizarse ninguna acción subsiguiente en el contexto actual.
\end */
function oficial_realizarAccionAutomatica(accion, miForm)
{
  var util = new FLUtil;
  var cursor = miForm.cursor();

  switch (accion["accion"]) {
      /// Acciones generales
    case "informar_campos": {
      accion["usada"] = true;
      if ("campos" in accion && typeof(accion["campos"]) == "object") {
        for (var i = 0; i < accion["campos"].length; i++) {
          cursor.setValueBuffer(accion["campos"][i], accion["valores"][i]);
        }
      }
      break;
    }
    default: {
      /// Acciones dependientes del contexto
      switch (cursor.table()) {
        case "se_incidencias": {
          switch (accion["accion"]) {
            case "insertar_comunicacion": {
              accion["usada"] = true;
              var curComunicaciones: FLSqlCursor = this.child("tdbComunicaciones").cursor();
              curComunicaciones.insertRecord();
              break;
            }
            case "alta_automatica": {
              accion["usada"] = true;
              this.child("fdbDesccorta").setValue(accion["desccorta"]);
              break;
            }
            case "responder_comunicacion": {
              accion["usada"] = true;
              var opciones: Array = [util.translate("scripts", "No responder"),
                                     util.translate("scripts", "Pasar a EN ESPERA y responder"),
                                     util.translate("scripts", "Pasar a RESUELTA y responder"),
                                     util.translate("scripts", "Pasar a EN PRUEBAS y responder"),
                                     util.translate("scripts", "Pasar a EN DESARROLLO y responder")];
              var opcion: Number = flfactppal.iface.pub_elegirOpcion(opciones);
              if (opcion == -1) {
                break;
              }
              debug("opcion = " + opcion);
              var estado: String = "";
              switch (opcion) {
                case 0: {
                  break;
                }
                case 1: {
                  estado = "En espera";
                  break;
                }
                case 2: {
                  estado = "Resuelta";
                  break;
                }
                case 3: {
                  estado = "En pruebas";
                  break;
                }
                case 4: {
                  estado = "En desarrollo";
                  break;
                }
              }
              if (estado != "") {
                this.iface.bloqueoEstado_ = true;
                cursor.setValueBuffer("estado", estado);
                this.iface.bloqueoEstado_ = false;
                this.child("pbnResponder").animateClick();
              }
              break;
            }
          }
        }
      }
    }
  }
  return true;
}

function oficial_mtdEnviarSW(curId, tabla)
{
  var _i = this.iface;
  var curObjeto = _i.dameCursor(curId, tabla);
  if (!curObjeto) {
    return false;
  }
  switch (curObjeto.table()) {
    case "se_subproyectos": {
      var acciones: Array = [];
      acciones[0] = flcolaproc.iface.pub_arrayAccion("se_enviossw", "informar_campos");
      acciones[0].campos = ["codsubproyecto", "codproyecto", "codcliente"];
      acciones[0].valores = [curObjeto.valueBuffer("codigo"), curObjeto.valueBuffer("codproyecto"), curObjeto.valueBuffer("codcliente")];

      flcolaproc.iface.pub_setAccionesAuto(acciones);
      break;
    }
  }
  var curCom = new FLSqlCursor("se_enviossw");
  curCom.insertRecord();
}

function oficial_mtdCrearIncidencia(curId, tabla)
{
  var _i = this.iface;
  var curObjeto = _i.dameCursor(curId, tabla);
  if (!curObjeto) {
    return false;
  }
  switch (curObjeto.table()) {
    case "se_subproyectos": {
      var acciones: Array = [];
      acciones[0] = flcolaproc.iface.pub_arrayAccion("se_incidencias", "informar_campos");
      acciones[0].campos = ["codsubproyecto", "codproyecto", "codcliente"];
      acciones[0].valores = [curObjeto.valueBuffer("codigo"), curObjeto.valueBuffer("codproyecto"), curObjeto.valueBuffer("codcliente")];

      flcolaproc.iface.pub_setAccionesAuto(acciones);
      break;
    }
  }
  var curCom = new FLSqlCursor("se_incidencias");
  curCom.insertRecord();
}

function oficial_mtdAsignaHoras(curId)
{
  var _i = this.iface;
  var idUsuario = _i.dameIdObjeto(curId);
  if (!idUsuario) {
    return false;
  }
  var acciones: Array = [];
  acciones[0] = flcolaproc.iface.pub_arrayAccion("se_horastrabajadas", "informar_campos");
  acciones[0].campos = ["codusuario"];
  acciones[0].valores = [idUsuario];

  flcolaproc.iface.pub_setAccionesAuto(acciones);
  var curHT = new FLSqlCursor("se_horastrabajadas");
  curHT.insertRecord();
}

function oficial_dameCursor(curId, tabla)
{
  var _i = this.iface;
  var curObjeto;
  if (typeof(curId) == "string" || typeof(curId) == "number") {
    curObjeto = new FLSqlCursor(tabla);
    var campoClave = curObjeto.primaryKey();
    var tipoClave = curObjeto.fieldType(campoClave);
    switch (tipoClave) {
      case _i.ftSTRING_:
      case _i.ftDATE_: {
        curObjeto.select(campoClave + " = '" + curId + "'");
        break;
      }
      default: {
        curObjeto.select(campoClave + " = " + curId);
      }
    }
    if (!curObjeto.first()) {
      return false;
    }
  } else {
    curObjeto = curId;
  }
  return curObjeto;
}

function oficial_dameIdObjeto(curId)
{
  var _i = this.iface;
  var idObjeto;
  if (typeof(curId) == "string" || typeof(curId) == "number") {
    idObjeto = curId;
  } else {
    idObjeto = curId.valueBuffer(curId.primaryKey());
  }
  return idObjeto;
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
