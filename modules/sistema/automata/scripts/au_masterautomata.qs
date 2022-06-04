/***************************************************************************
                 au_masterautomata.qs  -  description
                             -------------------
    begin                : mie mar 08 2006
    copyright            : (C) 2006 by InfoSiAL S.L.
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
    var ctx;
    function interna( context ) { this.ctx = context; }
    function init() { this.ctx.interna_init(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var timerId;
	var activado_;
	var intervalo_;
	var pbnActivar;
	var spbIntervalo;
	var lblEstado;
	var nombreLog_;
	var nombreLogFile_;
	function oficial( context ) { interna( context ); }
	function pbnActivar_clicked() {
		return this.ctx.oficial_pbnActivar_clicked();
	}
	function activar() {
		return this.ctx.oficial_activar();
	}
	function iniciarTablaLlamadas() {
		return this.ctx.oficial_iniciarTablaLlamadas();
	}
	function activarBackground(ms) {
		return this.ctx.oficial_activarBackground(ms);
	}
	function cerrar() {
		return this.ctx.oficial_cerrar();
	}
	function comprobarLlamadas() {
		return this.ctx.oficial_comprobarLlamadas();
	}
	function procesarLlamada(idLlamada) {
		return this.ctx.oficial_procesarLlamada(idLlamada);
	}
	function ejecutar(funcion, idLlamada) {
		return this.ctx.oficial_ejecutar(funcion, idLlamada);
	}
	function activado() {
		return this.ctx.oficial_activado();
	}
	function generarFactura(idLlamada) {
		return this.ctx.oficial_generarFactura(idLlamada);
	}
	function testFunction(param) {
		return this.ctx.oficial_testFunction(param);
	}
	function abreLog() {
		return this.ctx.oficial_abreLog();
	}
	function dameNombreLog(esquema) {
		return this.ctx.oficial_dameNombreLog(esquema);
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
  function pub_activado() {
  	return this.activado();
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
/** \C
Este formulario realiza la gestion de los albaranes a clientes.

Los albaranes pueden ser generados de forma manual o a partir de uno o mas pedidos.
\end */
function interna_init()
{
	var _i = this.iface;

	_i.activado_ = false;
	_i.pbnActivar = this.child("pbnActivar");
	_i.lblEstado = this.child("lblEstado");
	_i.spbIntervalo = this.child("spbIntervalo");

	_i.spbIntervalo.setValue(300);

	connect(_i.pbnActivar, "clicked()", _i, "pbnActivar_clicked()");
	connect(this, "closed()", _i, "cerrar()");
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_cerrar()
{
	var _i = this.iface;

	_i.activado_ = false;
	killTimer(_i.timerId);
}

/** \D Determina si el autómata está procesando acciones o no
@return	True si está ejecutando acciones, false en caso contrario
\end */
function oficial_activado()
{
	var _i = this.iface;

	return _i.activado_;
}

function oficial_pbnActivar_clicked()
{
	var _i = this.iface;

	if(!_i.iniciarTablaLlamadas()) {
		sys.warnMsgBox(sys.translate("No ha sido posible iniciar el autómata"));
		return false;
	}
	
	_i.activar();
}

function oficial_activar()
{
	var _i = this.iface;

	if (_i.activado_)
	{
		killTimer(_i.timerId);
		_i.activado_ = false;
		_i.pbnActivar.text = sys.translate("Activar");
		_i.lblEstado.text = "";
	}
	else {
		_i.activado_ = true;
		_i.pbnActivar.text = sys.translate("Desactivar");
		_i.intervalo_ = _i.spbIntervalo.value;
		_i.lblEstado.text = sys.translate("Esperando...");
		_i.abreLog();
		_i.timerId = startTimer(_i.intervalo_, _i.comprobarLlamadas);
	}
}

function oficial_activarBackground(ms)
{
	var _i = this.iface;

	if(!ms)
		ms = 300;
	var d1 = new Date, d2;
	var t1 = d1.getTime(), t2;

	_i.abreLog();

	if(!_i.iniciarTablaLlamadas()) {
		flfactppal.iface.pub_appendTextToLogFile(_i.nombreLog_, sys.translate("No ha sido posible iniciar el autómata"));
		return false;
	}
	
	while (true)
	{
		d2 = new Date;
		t2 = d2.getTime();
		if ((t2 - t1) > ms)
		{
			_i.comprobarLlamadas();
			d1 = new Date;
			t1 = d1.getTime();
		}
	}
}

/** \D Comprueba si se ha insertado alguna nueva llamada y la procesa
\end */
function oficial_comprobarLlamadas()
{
	var _i = this.iface;

	debug("oficial_comprobarLlamadas");
	var idLlamada = AQUtil.sqlSelect("au_llamadas", "idllamada", "(NOT procesada OR procesada IS NULL) ORDER BY idllamada");
	debug(idLlamada);
	killTimer(_i.timerId);
	_i.timerId = false;

	while (idLlamada)
	{
		if (sys.interactiveGUI())
		{
			_i.lblEstado.text = sys.translate("Procesando llamada %1").arg(idLlamada);
			_i.lblEstado.text = sys.translate("Esperando...");
		}
		_i.procesarLlamada(idLlamada);
		idLlamada = AQUtil.sqlSelect("au_llamadas", "idllamada", "(NOT procesada OR procesada IS NULL) ORDER BY idllamada");
	}
	if (!_i.timerId)
	{
		_i.timerId = startTimer(_i.intervalo_, _i.comprobarLlamadas);
	}
}

/** \D Abre una transacción y ejecuta la llamada. Si ésta termina con error, introduce un registro de resultado de nombre 'error' con la descripción del mismo
@param	idLlamada: Identificador de la llamada a ejecutar
@return	true si la llamada se ejecuta, false en caso contrario
\end */
function oficial_procesarLlamada(idLlamada)
{
	var _i = this.iface;

	var curLlamada = new FLSqlCursor("au_llamadas");
	curLlamada.select("idllamada = " + idLlamada);
	if (!curLlamada.first()) {
		return false;
	}

	var parametros = AQUtil.sqlSelect("au_llamadas","param","idllamada = '" + idLlamada + "'");
	var funcion = AQUtil.sqlSelect("au_llamadas","funcion","idllamada = '" + idLlamada + "'");

	flfactppal.iface.pub_appendTextToLogFile(_i.nombreLog_, sys.translate("Procesando llamada %1 con parámetros %2").arg(idLlamada).arg(parametros));

	var resultado = new Object;
	var oParam = new Object;
	oParam.curLlamada = curLlamada;
	oParam.errorMsg = sys.translate("<Response desc=\"Error al ejecutar la función %1\" />").arg(funcion);

	var f = new Function("oParam", "return formau_automata.iface.ejecutar(oParam)");

	if (sys.runTransaction(f, oParam)) {
		resultado = oParam.res;
	} else {
		resultado["codigo"] = -1;
		resultado["result"] = oParam.errorMsg;
	}

	curLlamada.setModeAccess(curLlamada.Edit);
	curLlamada.refreshBuffer();
	curLlamada.setValueBuffer("procesada", true);
	curLlamada.setValueBuffer("resultado", resultado.codigo);
	curLlamada.setValueBuffer("result", resultado.result);
	if (!curLlamada.commitBuffer()) {
		return false;
	}
	return true;
}

function oficial_ejecutar(oParam)
{
	var _i = this.iface;

	var curLlamada = oParam.curLlamada;
	var f = curLlamada.valueBuffer("funcion");
	var param = curLlamada.valueBuffer("param");

	var res = [];
	res["codigo"] = -1;
	res["result"] = sys.translate("La función %1 no está definida").arg(f);
	switch (f) {
		case "test": {
			res = _i.testFunction(param);
			break;
		}
		case "generarFactura": {
			res = _i.generarFactura(curLlamada.valueBuffer("param"));
			break;
		}
	}
	oParam.res = res;
	return res;
}

function oficial_testFunction(param)
{
	var _i = this.iface;

	var res = [];
	res["codigo"] = 0;
	res["error"] = "";
	res["result"] = "";

	var xP = new FLDomDocument;
	var xR = new FLDomDocument;
	if (!xP.setContent(param)) {
		return false;
	}
	xR.setContent("<Response/>");
	var eP = xP.firstChild().toElement();
	var eR = xR.firstChild().toElement();

	var s1 = eP.attribute("S1");
	var s2 = eP.attribute("S2");
	var r = "?";
	if (isNaN(s1)) {
		res["codigo"] = -1;
		eR.setAttribute("desc", sys.translate("El sumando 1 no es un número"));
	} else if (isNaN(s2)) {
		res["codigo"] = -1;
		eR.setAttribute("desc", sys.translate("El sumando 2 no es un número"));
	} else {
		r = parseFloat(s1) + parseFloat(s2);
		eR.setAttribute("desc", sys.translate("OK"));
	}
	eR.setAttribute("Value", r);
	res["result"] = xR.toString(4);

	var d1 = new Date;
	var d2 = new Date;
	var t1 = d1.getTime();
	var t2 = d2.getTime();
	while (t2 - t1 < 2000) {
		d2 = new Date;
		t2 = d2.getTime();
	}

	if (r && r != "?")
	{
		flfactppal.iface.pub_appendTextToLogFile(_i.nombreLog_, sys.translate("Resultado: %1, Valor: %2").arg(eR.attributeValue("desc")).arg(eR.attributeValue("Value")));
	}
	else
	{
		flfactppal.iface.pub_appendTextToLogFile(_i.nombreLog_, sys.translate("Resultado: %1").arg(eR.attributeValue("desc")));
	}

	return res;
}

function oficial_generarFactura(param)
{
	debug("oficial_generarFactura");
	var res = [];
	res["codigo"] = 0;
	res["error"] = "";
	res["result"] = "";

	var xP = new FLDomDocument;
	var xR = new FLDomDocument;
	if (!xP.setContent(param)) {
		return false;
	}
	xR.setContent("<Response/>");

	var idF = xP.firstChild().toElement().attribute("Numero");
	debug("idF " + idF);
	var eF = xR.createElement("Factura");
	xR.firstChild().appendChild(eF);
	eF.setAttribute("Numero", idF);
	res["result"] = xR.toString(4);
	debug("GF OK");
	return res;
}/*
var cursor:FLSqlCursor = new FLSqlCursor("albaranescli");
var idAlbaran:String = util.sqlSelect("au_param", "valor", "idllamada = " + idLlamada + " AND nombre = 'idAlbaran'");
if (!idAlbaran) {
	res["codigo"] = -2;
	res["error"] = util.translate("scripts", "El parámetro no está definido: ") + "idAlbaran";
	return res;
}
var where:String = "idalbaran = " + idAlbaran;
cursor.select(where);
if (!cursor.first()) {
	res["codigo"] = -3;
	res["error"] = util.translate("scripts", "El albarán no existe: ") + idAlbaran;
	return res;
}

if (cursor.valueBuffer("ptefactura") == false) {
	res["codigo"] = -4;
	res["error"] = util.translate("scripts", "El albarán ya está facturado: ") + idAlbaran;
	return res;
}
var idFactura:Number = formalbaranescli.iface.pub_generarFactura(where, cursor);
if (!idFactura) {
	res["codigo"] = -5;
	res["error"] = util.translate("scripts", "Error en la ejecución de la función");
	return res;
}
if (!util.sqlInsert("au_result", "idllamada,nombre,valor", idLlamada + ",idFactura," + idFactura)) {
	res["codigo"] = -6;
	res["error"] = util.translate("scripts", "Error en la escribir el resultado de la llamada");
	return res;
}
return res;
}*/

function oficial_abreLog()
{
	var _i = this.iface;

	var prefijo = "AUTOMATA";
	var nombreLog = _i.dameNombreLog(prefijo);
	_i.nombreLog_ = flfactalma.iface.pub_ponLogName(nombreLog);
	var dirLog = AQUtil.sqlSelect("au_general", "directoriolog", "1 = 1");;

	if(!dirLog || dirLog == "")
	{
		dirLog = Dir.home;
	}

	dirLog += dirLog.endsWith("/") ? "" : "/";
	_i.nombreLogFile_ = dirLog + nombreLog;

	if (!flfactppal.iface.pub_abreLogFile(_i.nombreLog_, _i.nombreLogFile_))
	{
		sys.infoMsgBox(sys.translate("No se ha creado el fichero del log de la sincronización."));
	}
	debug(_i.nombreLog_);
	debug(_i.nombreLogFile_);
}

function oficial_dameNombreLog(esquema)
{
	var _i = this.iface;

	var fecha = new Date();
	var dia = fecha.getDate().toString();
	if(dia.length < 2)
	{
		dia = "0" + dia;
	}
	var mes = fecha.getMonth().toString();
	if(mes.length < 2)
	{
		mes = "0" + mes;
	}
	var anyo = fecha.getYear().toString();
	var hora = fecha.getHours().toString();
	if(hora.length < 2)
	{
		hora = "0" + hora;
	}
	var minuto = fecha.getMinutes().toString();
	if(minuto.length < 2)
	{
		minuto = "0" + minuto;
	}
	var prefijo;
	if(esquema && esquema != "")
	{
		prefijo = esquema;
	}
	else
	{
		prefijo = "AUTOMATA";
	}

	var nombreFichero = prefijo + "_" + anyo + mes + dia + hora + minuto + ".log"

	return nombreFichero;
}

function oficial_iniciarTablaLlamadas()
{
	return true;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
