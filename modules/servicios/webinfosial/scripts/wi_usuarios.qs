/***************************************************************************
                 wi_usuarios.qs  -  description
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
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna
{
  var rutaSer, adjuntos: String;
  var proceso, procesoMail: FLProcess;
  var codFuncionalActual: String;
  var tbnBajarFun: Object;
  var tbnProbarFun: Object;
  function oficial(context)
  {
    interna(context);
  }
  function cambiarPassword()
  {
    this.ctx.oficial_cambiarPassword();
  }
  function imprimirSaldoCredito()
  {
    this.ctx.oficial_imprimirSaldoCredito();
  }
  function enviarMail()
  {
    return this.ctx.oficial_enviarMail();
  }

  function bajarFun(codFuncional: String)
  {
    return this.ctx.oficial_bajarFun(codFuncional);
  }
  function bajarFunUsuario()
  {
    return this.ctx.oficial_bajarFunUsuario();
  }
  function bajarFunRamaUsuario()
  {
    return this.ctx.oficial_bajarFunRamaUsuario();
  }

  function crearPaquetesUsuario()
  {
    return this.ctx.oficial_crearPaquetesUsuario();
  }
  function crearPaquetesRamaUsuario()
  {
    return this.ctx.oficial_crearPaquetesRamaUsuario();
  }
  function crearPaquetes(codFuncional: String)
  {
    return this.ctx.oficial_crearPaquetes(codFuncional);
  }

  function mailEnviado()
  {
    return this.ctx.oficial_mailEnviado();
  }

  function crearPruebas(codFuncional: String)
  {
    return this.ctx.oficial_crearPruebas(codFuncional);
  }
  function crearPruebasUsuario()
  {
    return this.ctx.oficial_crearPruebasUsuario();
  }
  function crearPruebasRamaUsuario()
  {
    return this.ctx.oficial_crearPruebasRamaUsuario();
  }


  function responderMail()
  {
    return this.ctx.oficial_responderMail();
  }
  function crearRemitente()
  {
    return this.ctx.oficial_crearRemitente();
  }

  function refrescarResumenExt()
  {
    return this.ctx.oficial_refrescarResumenExt();
  }
  function imprimirExtensiones()
  {
    return this.ctx.oficial_imprimirExtensiones();
  }
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends oficial
{
  function head(context)
  {
    oficial(context);
  }
  function lanzarLog(accion: String, codFuncional: String)
  {
    return this.ctx.head_lanzarLog(accion, codFuncional);
  }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head
{
  function ifaceCtx(context)
  {
    head(context);
  }
}

const iface = new ifaceCtx(this);
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
  this.iface.tbnBajarFun = this.child("tbnBajarFun");
  this.iface.tbnProbarFun = this.child("tbnProbarFun");
  connect(this.child("pbnCambiarPassword"), "clicked()", this, "iface.cambiarPassword");
  connect(this.child("pbnImprimirSaldoCreditos"), "clicked()", this, "iface.imprimirSaldoCredito");

  connect(this.child("tbnCrearPaquetes"), "clicked()", this, "iface.crearPaquetesUsuario()");
  connect(this.iface.tbnBajarFun, "clicked()", this, "iface.bajarFunUsuario()");
  connect(this.iface.tbnProbarFun, "clicked()", this, "iface.crearPruebasUsuario()");

  connect(this.child("tbnCrearPaquetesR"), "clicked()", this, "iface.crearPaquetesRamaUsuario()");
  connect(this.child("tbnBajarFunR"), "clicked()", this, "iface.bajarFunRamaUsuario()");
  connect(this.child("tbnProbarFunR"), "clicked()", this, "iface.crearPruebasRamaUsuario()");

  connect(this.child("pbnResponder"), "clicked()", this, "iface.responderMail");
  connect(this.child("pbnRefrescarResumen"), "clicked()", this, "iface.refrescarResumenExt");
  connect(this.child("pbnImprimirExtensiones"), "clicked()", this, "iface.imprimirExtensiones");


  this.child("fdbPassword").setDisabled(true);

  /*  if (!this.cursor().valueBuffer("codcliente"))
      this.child("gbxIncidencias").setDisabled(true);
    else*/
  this.child("tdbIncidencias").cursor().setMainFilter("codcliente = '" + this.cursor().valueBuffer("codcliente") + "' AND (enbolsa = true)");
}



//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_cambiarPassword()
{
  var util: FLUtil = new FLUtil;

  var res = MessageBox.information(util.translate("scripts", "Esta acción no podrá deshacerse. ¿Está seguro?"), MessageBox.Yes, MessageBox.No);
  if (res != MessageBox.Yes)
    return;

  var password: String = Input.getText("Nuevo password:");

  if (!password)
    return;

  if (password.length < 6) {
    MessageBox.critical(util.translate("scripts", "El password debe tener al menos 6 dígitos"), MessageBox.Ok);
    return;
  }

  password = util.sha1(password);
  this.cursor().setValueBuffer("password", password.toLowerCase());
}

function oficial_imprimirSaldoCredito()
{
  var codCliente: String = this.cursor().valueBuffer("codcliente");

  if (codCliente)
    formse_clientes.iface.pub_informeSaldo(codCliente, 100);
}

function oficial_crearPaquetesUsuario()
{
  var curTab: FLSqlCursor = this.cursor();
  if (!curTab.isValid())
    return;

  this.iface.codFuncionalActual = "";
  return this.iface.crearPaquetes(curTab.valueBuffer("codfuncional"));
}

function oficial_crearPaquetesRamaUsuario()
{
  var curTab: FLSqlCursor = this.child("tdbRamasUsuarios").cursor();
  if (!curTab.isValid())
    return;

  this.iface.codFuncionalActual = curTab.valueBuffer("codfuncional");
  return this.iface.crearPaquetes(curTab.valueBuffer("codfuncional"));
}

function oficial_crearPaquetes(codFuncional: String)
{
  var util = new FLUtil();
  var rutaModulos = util.readSettingEntry("scripts/flservppal/dirMantVer");
  var dirModulos = codFuncional;

  var rutaRevision = "";
  if (File.exists(rutaModulos + dirModulos + "/modulos/")) {
    rutaRevision = rutaModulos + dirModulos + "/temp";
    rutaModulos = rutaModulos + dirModulos + "/modulos/";
  } else {
    rutaRevision = rutaModulos + dirModulos + "/" + dirModulos;
    rutaModulos = rutaModulos + dirModulos + "/prueba/";
  }

  if (!File.isDir(rutaModulos)) {
    MessageBox.critical(
      util.translate("scripts", "La ruta a los módulos no es correcta:\nDebes bajar la rama y generar la prueba"),
      MessageBox.Ok, MessageBox.Cancel, MessageBox.NoButton);
    return false;
  }

  var tgz = !(util.sqlSelect("mv_funcional", "usarpackager",
                             "codfuncional = '" + codFuncional + "'"));
  var rutaPack = rutaModulos + dirModulos;
  var rutaAttach = formRecordse_enviossw.iface.pub_empaquetarModulos(
                     rutaModulos, rutaPack,
                     rutaRevision, tgz
                   );
  if (!rutaAttach)
    return false;
  this.iface.adjuntos = " --attach " + rutaAttach;

  this.iface.rutaSer = util.readSettingEntry("scripts/flservppal/dirServicios");
  this.iface.enviarMail();
}

/** \D Crea los textos de asunto, cuerpo y destino para llamar
al comando kmail y enviar el correo
\end */
function oficial_enviarMail()
{
  var util: FLUtil = new FLUtil();
  var codCliente: String = this.cursor().valueBuffer("codcliente");
  if (!codCliente || codCliente == "") {
    MessageBox.warning(util.translate("scripts", 
                                      "Debe establecer el código de cliente"), MessageBox.Ok, MessageBox.Cancel, MessageBox.NoButton);
    return false;
  }

  var extensiones: String = "";
  var asunto: String = "Servicio de actualizaciones de Abanq";
  var nomClienteUsuario: String = "";

  var codFuncional = this.cursor().valueBuffer("codfuncional");
  if (this.iface.codFuncionalActual) {
    codFuncional = this.iface.codFuncionalActual;
    nomClienteUsuario = " - Cliente " + util.sqlSelect("wi_ramasusuarios", "nombre",
                                                       "nick = '" + this.cursor().valueBuffer("nick") +
                                                       "' AND codfuncional = '" + codFuncional + "'");
  }

  var asunto = "\"" + asunto + nomClienteUsuario + "\"";

  var q: FLSqlQuery = new FLSqlQuery();
  q.setTablesList("mv_dependencias,mv_funcional");
  q.setFrom("mv_dependencias INNER JOIN mv_funcional ON mv_dependencias.codpadre = mv_funcional.codfuncional");
  q.setSelect("mv_funcional.codigo,mv_funcional.desccorta");
  q.setWhere("mv_dependencias.codhijo = '" + codFuncional + "'");

  if (!q.exec()) return;

  if (q.first())
    extensiones = "\n\n\n\n --------------------------\n\n  Lista de Extensiones " + nomClienteUsuario + "\n";

  do {
    extensiones += "\n    Extensión " + q.value("mv_funcional.codigo") + ": " + q.value("mv_funcional.desccorta");
  } while (q.next());

  var cuerpo: String = "\"Servicio de actualizaciones de Abanq" + extensiones + "\"";
  var destinatario: String = this.cursor().valueBuffer("email");

  var comando: String = flservppal.iface.pub_componerCorreo(destinatario, asunto, cuerpo, this.iface.adjuntos);

  var fichProceso = this.iface.rutaSer + "principal/packets/comandomail";
  var f = new File(fichProceso);
  f.open(File.WriteOnly);
  f.write(comando);
  f.close();

  this.iface.procesoMail = new FLProcess(fichProceso);
  connect(this.iface.procesoMail, "exited()", this, "iface.mailEnviado");
  this.iface.procesoMail.start();

  var util: FLUtil = new FLUtil();
  var res = MessageBox.information(util.translate("scripts", "Pulse \"Aceptar\" DESPUÉS de enviar el mensaje correctamente"),
                                   MessageBox.Ok, MessageBox.Cancel, MessageBox.NoButton);

  this.setDisabled(false);

  if (res == MessageBox.Ok) {

    var hoy = new Date();
    var ahora: String = hoy.toString().mid(11, 5);

    var curMail: FLSqlCursor = new FLSqlCursor("wi_comunicaciones");
    curMail.setModeAccess(curMail.Insert);
    curMail.refreshBuffer();
    curMail.setValueBuffer("codigo", util.nextCounter("codigo", curMail));
    curMail.setValueBuffer("asunto", asunto);
    curMail.setValueBuffer("enviadopor", this.iface.crearRemitente());
    curMail.setValueBuffer("para", destinatario);
    curMail.setValueBuffer("texto", cuerpo);
    curMail.setValueBuffer("fecha", hoy);
    curMail.setValueBuffer("hora", ahora);
    curMail.setValueBuffer("estado", "Enviado");
    curMail.setValueBuffer("nickusuario", this.cursor().valueBuffer("nick"));
    curMail.setValueBuffer("codcliente", codCliente);
    if (!curMail.commitBuffer())
      return false;
  }
}

function oficial_mailEnviado()
{
}



function oficial_bajarFun()
{
  this.iface.lanzarLog("FB");
}

function oficial_bajarFunUsuario()
{
  var curTab: FLSqlCursor = this.cursor();
  if (!curTab.isValid())
    return;

  this.iface.lanzarLog("FB", curTab.valueBuffer("codfuncional"));
}

function oficial_bajarFunRamaUsuario()
{
  var curTab: FLSqlCursor = this.child("tdbRamasUsuarios").cursor();
  if (!curTab.isValid())
    return;

  this.iface.lanzarLog("FB", curTab.valueBuffer("codfuncional"));
}


function oficial_crearPruebas(codFuncional: String)
{
  this.iface.lanzarLog("FP", codFuncional);
}

function oficial_crearPruebasUsuario()
{
  var curTab: FLSqlCursor = this.cursor();
  if (!curTab.isValid())
    return;

  this.iface.lanzarLog("FP", curTab.valueBuffer("codfuncional"));
}

function oficial_crearPruebasRamaUsuario()
{
  var curTab: FLSqlCursor = this.child("tdbRamasUsuarios").cursor();
  if (!curTab.isValid())
    return;

  this.iface.lanzarLog("FP", curTab.valueBuffer("codfuncional"));
}



/** \D Lanza la respuesta a una comunicación seleccionada en el formulario maestro.
El id de dicha comunicacion queda registrado en la variable codigoConResp, y a continuación
se abre el formulario de inserción de una nueva comunicación.
\end */
function oficial_responderMail()
{
  var util: FLUtil = new FLUtil();
  var curCom: FLSqlCursor = this.child("tdbComunicaciones").cursor();

  util.writeSettingEntry("scripts/flservppal/codigoComResp", curCom.valueBuffer("codigo"));

  this.child("toolButtomInsertCom").animateClick();
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
/** \D Lanza el formulario de log, estableciendo antes en una variable global el tipo de acción a realizar
\end */
function head_lanzarLog(accion: String, codFuncional: String)
{
  formmv_proyectos.iface.pathLocal = flmaveppal.iface.pub_obtenerPathLocal();
  formmv_proyectos.iface.urlRepositorioMod = flmaveppal.iface.pub_obtenerUrlRepositorioMod();
  formmv_proyectos.iface.urlRepositorioFun = flmaveppal.iface.pub_obtenerUrlRepositorioFun();
  flmaveppal.iface.pub_obtenerVersionTronco();
  //formmv_proyectos.iface.versionOficial = flmaveppal.iface.pub_obtenerVersionOficial();
  //formmv_proyectos.iface.util = new FLUtil;

  if (!codFuncional)
    return;

  var miVar: FLVar = new FLVar();
  miVar.set("ACCIONMV", accion);

  flmaveppal.iface.pub_log = new FLFormSearchDB("mv_log");
  var cursor: FLSqlCursor = flmaveppal.iface.pub_log.cursor();
  cursor.select("codfuncional = '" + codFuncional + "'");
  cursor.first();
  cursor.setModeAccess(cursor.Browse);
  flmaveppal.iface.pub_log.setMainWidget();
  cursor.refreshBuffer();
  flmaveppal.iface.pub_log.exec("codfuncional");
  flmaveppal.iface.pub_log.close();
}

/** \D Toma como remitente de la comunicación el usuario que esté establecido
en las preferencias del módulo
\end */
function oficial_crearRemitente(): String {
  var util: FLUtil = new FLUtil();

  var q: FLSqlQuery = new FLSqlQuery();
  q.setTablesList("se_usuarios");
  q.setFrom("se_usuarios");
  q.setSelect("nombre,email");
  q.setWhere("codigo = '" + util.readSettingEntry("scripts/flservppal/codusuario") + "'");

  if (!q.exec()) return;
  if (q.first())
    return q.value(0) + " <" + q.value(1) + ">";

  return "";
}

function oficial_refrescarResumenExt()
{
  var util: FLUtil = new FLUtil();
  var html: String = "";

  var listaExt: Array, listaExt: Array;
  var listaMod: Array;
  var numExt: Number = 0;
  var numMod: Number = 0;
  var tieneClientes: Boolean = false;

  var q: FLSqlQuery = new FLSqlQuery();
  q.setTablesList("mv_funcional,mv_dependencias");
  q.setFrom("mv_funcional f inner join mv_dependencias d on d.codpadre = f.codfuncional");
  q.setSelect("f.codfuncional,f.codigo,f.desccorta");
  q.setWhere("d.codhijo = '" + this.cursor().valueBuffer("codfuncional") + "' order by f.codigo");

  html += "<h2>Detalle de Extensiones y Módulos</h2>";
  html += "<h3>Extensiones de " + this.cursor().valueBuffer("nick") + "</h3>";

  if (!q.exec()) return;
  while (q.next()) {
    html += q.value(1) + " - " + q.value(2) + "<br>";
    listaExt[numExt++] = q.value(1) + " - " + q.value(2);
  }

  if (!q.size())
    html += "Sin extensiones<br>";

  var qMod: FLSqlQuery = new FLSqlQuery();
  qMod.setTablesList("mv_modulosfun,mv_modulos,mv_areas");
  qMod.setFrom("mv_areas a INNER JOIN mv_modulosfun mf ON a.idarea = mf.idarea INNER JOIN mv_modulos m ON mf.idmodulo = m.idmodulo");
  qMod.setSelect("mf.idseccion,mf.idarea,mf.idmodulo,a.descripcion,m.descripcion");
  qMod.setWhere("codfuncional = '" + this.cursor().valueBuffer("codfuncional") + "' order by a.descripcion, m.descripcion");

  html += "<h3>Módulos de " + this.cursor().valueBuffer("nick") + "</h3>";

  if (!qMod.exec()) return;
  while (qMod.next()) {
    html += qMod.value(3) + "  -  " + qMod.value(4) + "<br>";
    listaMod[numMod++] = qMod.value(3) + " - " + qMod.value(4);
  }

  if (!qMod.size())
    html += "Sin módulos<br>";

  var curTab: FLSqlCursor = new FLSqlCursor("wi_ramasusuarios");
  curTab.select("nick = '" + this.cursor().valueBuffer("nick") + "' order by nombre");
  if (curTab.size())
    tieneClientes = true;

  while (curTab.next()) {
    html += "<h3>Extensiones de " + curTab.valueBuffer("nombre") + "</h3>";
    q.setWhere("d.codhijo = '" + curTab.valueBuffer("codfuncional") + "' order by f.codigo");
    if (!q.exec()) continue;
    while (q.next()) {
      html += q.value(1) + "  -  " + q.value(2) + "<br>";
      listaExt[numExt++] = q.value(1) + " - " + q.value(2);
    }

    if (!q.size())
      html += "Sin extensiones<br>";

    qMod.setWhere("codfuncional = '" + curTab.valueBuffer("codfuncional") + "' order by a.descripcion, m.descripcion");

    html += "<h3>Módulos de " + curTab.valueBuffer("nombre") + "</h3>";

    if (!qMod.exec()) continue;
    while (qMod.next()) {
      html += qMod.value(3) + " - " + qMod.value(4) + "<br>";
      listaMod[numMod++] = qMod.value(3) + " - " + qMod.value(4);
    }

    if (!qMod.size())
      html += "Sin módulos<br>";
  }


  var htmlRes: String = "";

  htmlRes += "<h2>Resumen de Extensiones</h2>";

  listaExt.sort();
  var lastExt: String = "";
  for (i = 0; i < listaExt.length; i++)
    if (listaExt[i] != lastExt) {
      htmlRes += listaExt[i] + "<br>";
      lastExt = listaExt[i];
    }

  if (!listaExt.length)
    htmlRes += "Sin extensiones<br>";


  htmlRes += "<h2>Resumen de Módulos</h2>";

  listaMod.sort();
  var lastMod: String = "";
  for (i = 0; i < listaMod.length; i++)
    if (listaMod[i] != lastMod) {
      htmlRes += listaMod[i] + "<br>";
      lastMod = listaMod[i];
    }

  if (!listaMod.length)
    htmlRes += "Sin módulos<br>";

  if (tieneClientes)
    html = htmlRes + html;
  else
    html = htmlRes;

  var tedExtensiones = this.child("tedExtensiones");
  tedExtensiones.clear();
  tedExtensiones.append(html);
}

function oficial_imprimirExtensiones()
{
  var tedExtensiones = this.child("tedExtensiones");

  if (tedExtensiones.text.isEmpty())
    return;

  sys.printTextEdit(tedExtensiones);
}

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////

//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
