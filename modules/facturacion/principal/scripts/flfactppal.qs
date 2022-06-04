/***************************************************************************
                 flfactppal.qs  -  description
                             -------------------
    begin                : lun abr 26 2004
    copyright            : (C) 2004-2006 by InfoSiAL S.L.
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
	function beforeCommit_dirclientes(curDirCli) {
		return this.ctx.interna_beforeCommit_dirclientes(curDirCli);
	}
	function afterCommit_dirclientes(curDirCli:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_dirclientes(curDirCli);
	}
	function afterCommit_dirproveedores(curDirProv:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_dirproveedores(curDirProv);
	}
	function afterCommit_clientes(curCliente:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_clientes(curCliente);
	}
	function beforeCommit_clientes(curCliente:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_clientes(curCliente);
	}
	function afterCommit_proveedores(curProveedor:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_proveedores(curProveedor);
	}
	function beforeCommit_proveedores(curProveedor:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_proveedores(curProveedor);
	}
	function afterCommit_empresa(curEmpresa:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_empresa(curEmpresa);
	}
	function beforeCommit_cuentasbcocli(curCuenta:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_cuentasbcocli(curCuenta);
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var logFiles_;
	var dialogEst_;
	var textLog_;
	function oficial( context ) { interna( context ); }
	function msgNoDisponible(nombreModulo:String) {
		return this.ctx.oficial_msgNoDisponible(nombreModulo);
	}
	function ejecutarQry(tabla:String, campos:String, where:String, listaTablas:String):Array {
		return this.ctx.oficial_ejecutarQry(tabla, campos, where, listaTablas);
	}
	function valorDefectoEmpresa(fN, idEmpresa){
		return this.ctx.oficial_valorDefectoEmpresa(fN, idEmpresa);
	}
	function cerosIzquierda(numero:String, totalCifras:Number):String {
		return this.ctx.oficial_cerosIzquierda(numero, totalCifras);
	}
	function espaciosDerecha(texto:String, totalLongitud:Number):String {
		return this.ctx.oficial_espaciosDerecha(texto, totalLongitud);
	}
	function valoresIniciales() {
		return this.ctx.oficial_valoresIniciales();
	}
	function valorQuery(tablas:String, select:String, from:String, where:String):Array {
		return this.ctx.oficial_valorQuery(tablas, select, from, where);
	}
	function crearSubcuenta(codSubcuenta:String, descripcion:String, idCuentaEsp:String, codEjercicio:String):Number {
		return this.ctx.oficial_crearSubcuenta(codSubcuenta, descripcion, idCuentaEsp, codEjercicio);
	}
	function borrarSubcuenta(idSubcuenta:String):Boolean {
		return this.ctx.oficial_borrarSubcuenta(idSubcuenta);
	}
	function ejercicioActual():String {
		return this.ctx.oficial_ejercicioActual();
	}
	function cambiarEjercicioActual(codEjercicio:String):Boolean {
		return this.ctx.oficial_cambiarEjercicioActual(codEjercicio);
	}
	function datosCtaCliente(codCliente:String, valoresDefecto:Array):Array {
		return this.ctx.oficial_datosCtaCliente(codCliente, valoresDefecto);
	}
	function datosCtaProveedor(codProveedor:String, valoresDefecto:Array):Array {
		return this.ctx.oficial_datosCtaProveedor(codProveedor, valoresDefecto);
	}
	function calcularIntervalo(codIntervalo:String):Array {
		return this.ctx.oficial_calcularIntervalo(codIntervalo);
	}
	function crearSubcuentaCli(codSubcuenta:String, idSubcuenta:Number, codCliente:String, codEjercicio:String):Boolean {
		return this.ctx.oficial_crearSubcuentaCli(codSubcuenta, idSubcuenta, codCliente, codEjercicio);
	}
	function rellenarSubcuentasCli(codCliente:String, codSubcuenta:String, nombre:String):Boolean {
		return this.ctx.oficial_rellenarSubcuentasCli(codCliente, codSubcuenta, nombre);
	}
	function crearSubcuentaProv(codSubcuenta:String, idSubcuenta:Number, codProveedor:String, codEjercicio:String):Boolean {
		return this.ctx.oficial_crearSubcuentaProv(codSubcuenta, idSubcuenta, codProveedor, codEjercicio);
	}
	function rellenarSubcuentasProv(codProveedor:String, codSubcuenta:String, nombre:String):Boolean {
		return this.ctx.oficial_rellenarSubcuentasProv(codProveedor, codSubcuenta, nombre);
	}
	function automataActivado():Boolean {
		return this.ctx.oficial_automataActivado();
	}
	function clienteActivo(codCliente:String, fecha:String):Boolean {
		return this.ctx.oficial_clienteActivo(codCliente, fecha);
	}
	function obtenerProvincia(formulario:Object, campoId:String, campoProvincia:String, campoPais:String) {
		return this.ctx.oficial_obtenerProvincia(formulario, campoId, campoProvincia, campoPais);
	}
	function actualizarContactos20070525():Boolean {
		return this.ctx.oficial_actualizarContactos20070525();
	}
	function lanzarEvento(cursor:FLSqlCursor, evento:String):Boolean {
		return this.ctx.oficial_lanzarEvento(cursor, evento);
	}
	function actualizarContactosDeAgenda20070525(codCliente:String,codContacto:String,nombreCon:String,cargoCon:String,telefonoCon:String,faxCon:String,emailCon:String,idAgenda:Number):String {
		return this.ctx.oficial_actualizarContactosDeAgenda20070525(codCliente,codContacto,nombreCon,cargoCon,telefonoCon,faxCon,emailCon,idAgenda)
	}
	function actualizarContactosProv20070702():Boolean {
		return this.ctx.oficial_actualizarContactosProv20070702();
	}
	function actualizarContactosDeAgendaProv20070702(codProveedor:String,codContacto:String,nombreCon:String,cargoCon:String,telefonoCon:String,faxCon:String,emailCon:String,idAgenda:Number):String {
		return this.ctx.oficial_actualizarContactosDeAgendaProv20070702(codProveedor,codContacto,nombreCon,cargoCon,telefonoCon,faxCon,emailCon,idAgenda)
	}
	function elegirOpcion(opciones:Array, titulo:String):Number {
		return this.ctx.oficial_elegirOpcion(opciones, titulo);
	}
	function crearProvinciasEsp(codPais:String) {
		return this.ctx.oficial_crearProvinciasEsp(codPais);
	}
	function textoFecha(fecha:String):String {
		return this.ctx.oficial_textoFecha(fecha);
	}
	function validarNifIva(nifIva:String):String {
		return this.ctx.oficial_validarNifIva(nifIva);
	}
	function ejecutarComandoAsincrono(comando:String):Array {
		return this.ctx.oficial_ejecutarComandoAsincrono(comando);
	}
	function globalInit() {
		return this.ctx.oficial_globalInit();
	}
	function existeEnvioMail():Boolean {
		return this.ctx.oficial_existeEnvioMail();
	}
	function validarProvincia(cursor:FLSqlCursor, mtd:Array):Boolean {
		return this.ctx.oficial_validarProvincia(cursor, mtd);
	}
	function simplify(str) {
		return this.ctx.oficial_simplify(str);
	}
	function escapeQuote(str) {
		return this.ctx.oficial_escapeQuote(str);
	}
	function valorDefecto(fN:String):String {
		return this.ctx.oficial_valorDefecto(fN);
	}
	function estableceGlobalInit() {
		return this.ctx.oficial_estableceGlobalInit();
	}
	function siguienteSecuenciaEjercicio(codEjercicio, fN) {
		return this.ctx.oficial_siguienteSecuenciaEjercicio(codEjercicio, fN);
	}
	function extension(nE) {
		return this.ctx.oficial_extension(nE);
	}
	function exportarTablaExcel(oParam) {
		return this.ctx.oficial_exportarTablaExcel(oParam);
	}
	function exportarArrayExcel(oParam) {
		return this.ctx.oficial_exportarArrayExcel(oParam);
	}
	function exportarConsultaExcel(oParam) {
		return this.ctx.oficial_exportarConsultaExcel(oParam);
	}
  function dameParamExcel(){
    return this.ctx.oficial_dameParamExcel();
  }
  function dameColor (nombre){
    return this.ctx.oficial_dameColor(nombre);
  }
  function creaDialogoProgreso(mensaje, tamano) {
    return this.ctx.oficial_creaDialogoProgreso(mensaje, tamano);
  }
  function abreLogFile(logName, fileName) {
		return this.ctx.oficial_abreLogFile(logName, fileName);
	}
	function appendTextToLogFile(logName, txt) {
		return this.ctx.oficial_appendTextToLogFile(logName, txt);
	}
	function appendTextToFile(fileName, txt) {
		return this.ctx.oficial_appendTextToFile(fileName, txt);
	}
	function creaDialogoEstado(oParam) {
		return this.ctx.oficial_creaDialogoEstado(oParam);
	}
	function ponLogDialogo(msg) {
		return this.ctx.oficial_ponLogDialogo(msg);
	}
	function destruyeDialogoEstado() {
		return this.ctx.oficial_destruyeDialogoEstado();
	}
	function controlDatosMod(curT) {
		return this.ctx.oficial_controlDatosMod(curT);
	}
	function registrarCambioCursor(curT) {
		return this.ctx.oficial_registrarCambioCursor(curT);
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
	function pub_msgNoDisponible(modulo:String) {
		return this.msgNoDisponible(modulo);
	}
	function pub_ejecutarQry(tabla:String, campos:String, where:String, listaTablas:String):Array {
		return this.ejecutarQry(tabla, campos, where, listaTablas);
	}
	function pub_valorDefectoEmpresa(fN, idEmpresa) {
		return this.valorDefectoEmpresa(fN, idEmpresa);
	}
	function pub_valorQuery(tablas:String, select:String, from:String, where:String):String {
		return this.valorQuery(tablas, select, from, where);
	}
	function pub_cerosIzquierda(numero:String, totalCifras:Number):String {
		return this.cerosIzquierda(numero, totalCifras);
	}
	function pub_espaciosDerecha(texto:String, totalLongitud:Number):String {
		return this.espaciosDerecha(texto, totalLongitud);
	}
	function pub_ejercicioActual():String {
		return this.ejercicioActual();
	}
	function pub_cambiarEjercicioActual(codEjercicio:String):Boolean {
		return this.cambiarEjercicioActual(codEjercicio);
	}
	function pub_datosCtaCliente(codCliente:String, valoresDefecto:Array):Array {
		return this.datosCtaCliente(codCliente, valoresDefecto);
	}
	function pub_datosCtaProveedor(codProveedor:String, valoresDefecto:Array):Array {
		return this.datosCtaProveedor(codProveedor, valoresDefecto);
	}
	function pub_calcularIntervalo(codIntervalo:String):Array {
		return this.calcularIntervalo(codIntervalo);
	}
	function pub_crearSubcuenta(codSubcuenta:String, descripcion:String, idCuentaEsp:String, codEjercicio:String):Number {
		return this.crearSubcuenta(codSubcuenta, descripcion, idCuentaEsp, codEjercicio);
	}
	function pub_crearSubcuentaCli(codSubcuenta:String, idSubcuenta:Number, codCliente:String, codEjercicio:String):Boolean {
		return this.crearSubcuentaCli(codSubcuenta, idSubcuenta, codCliente, codEjercicio);
	}
	function pub_crearSubcuentaProv(codSubcuenta:String, idSubcuenta:Number, codProveedor:String, codEjercicio:String):Boolean {
		return this.crearSubcuentaProv(codSubcuenta, idSubcuenta, codProveedor, codEjercicio);
	}
	function pub_rellenarSubcuentasCli(codCliente:String, codSubcuenta:String, nombre:String):Boolean {
		return this.rellenarSubcuentasCli(codCliente, codSubcuenta, nombre);
	}
	function pub_rellenarSubcuentasProv(codProveedor:String, codSubcuenta:String, nombre:String):Boolean {
		return this.rellenarSubcuentasProv(codProveedor, codSubcuenta, nombre);
	}
	function pub_automataActivado():Boolean {
		return this.automataActivado();
	}
	function pub_clienteActivo(codCliente:String, fecha:String):Boolean {
		return this.clienteActivo(codCliente, fecha);
	}
	function pub_obtenerProvincia(formulario:Object, campoId:String, campoProvincia:String, campoPais:String) {
		return this.obtenerProvincia(formulario, campoId, campoProvincia, campoPais);
	}
	function pub_lanzarEvento(cursor:FLSqlCursor, evento:String):Boolean {
		return this.lanzarEvento(cursor, evento);
	}
	function pub_elegirOpcion(opciones:Array, titulo:String):Number {
		return this.elegirOpcion(opciones, titulo);
	}
	function pub_textoFecha(fecha:String):String {
		return this.textoFecha(fecha);
	}
	function pub_validarNifIva(nifIva:String):String {
		return this.validarNifIva(nifIva);
	}
	function pub_ejecutarComandoAsincrono(comando:String):Array {
		return this.ejecutarComandoAsincrono(comando);
	}
	function pub_globalInit() {
		return this.globalInit();
	}
	function pub_existeEnvioMail():Boolean {
		return this.existeEnvioMail();
	}
	function pub_crearProvinciasEsp(codPais) {
		return this.crearProvinciasEsp(codPais);
	}
	function pub_validarProvincia(cursor, mtd) {
		return this.validarProvincia(cursor, mtd);
	}
	function pub_simplify(str) {
		return this.simplify(str);
	}
	function pub_escapeQuote(str) {
		return this.escapeQuote(str);
	}
	function pub_valorDefecto(fN) {
		return this.valorDefecto(fN);
	}
	function pub_siguienteSecuenciaEjercicio(codEjercicio, fN) {
		return this.siguienteSecuenciaEjercicio(codEjercicio, fN);
	}
	function pub_extension(nE) {
		return this.extension(nE);
	}
	function pub_exportarTablaExcel(oParam) {
		return this.exportarTablaExcel(oParam);
	}
	function pub_exportarConsultaExcel(oParam) {
		return this.exportarConsultaExcel(oParam);
	}
	function pub_exportarArrayExcel(oParam) {
		return this.exportarArrayExcel(oParam);
	}
  function pub_dameParamExcel() {
    return this.dameParamExcel();
  }
  function pub_dameColor(nombre) {
    return this.dameColor(nombre);
  }
  function pub_creaDialogoProgreso(mensaje, tamano) {
    return this.creaDialogoProgreso(mensaje, tamano);
  }
  function pub_abreLogFile(logName, fileName) {
		return this.abreLogFile(logName, fileName);
	}
	function pub_appendTextToLogFile(logName, txt) {
		return this.appendTextToLogFile(logName, txt);
	}
	function pub_appendTextToFile(fileName, txt) {
		return this.appendTextToFile(fileName, txt);
	}
	function pub_creaDialogoEstado(oParam) {
		return this.creaDialogoEstado(oParam);
	}
	function pub_ponLogDialogo(msg) {
		return this.ponLogDialogo(msg);
	}
	function pub_destruyeDialogoEstado() {
		return this.destruyeDialogoEstado();
	}
	function pub_controlDatosMod(curT) {
		return this.controlDatosMod(curT);
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
	var util:FLUtil = new FLUtil();

// -------------------------------- 20070525 -------------------------------------
// 	var condicion:String = util.sqlSelect("clientes", "codcliente", "(codcontacto = '' OR codcontacto IS NULL) AND (contacto <> '' AND contacto IS NOT NULL)");
// 	var condicionProv:String = util.sqlSelect("proveedores", "codproveedor", "(codcontacto = '' OR codcontacto IS NULL) AND (contacto <> '' AND contacto IS NOT NULL)");
//
// 	if (condicion) {
// 		var cursor:FLSqlCursor = new FLSqlCursor("clientes");
// 		cursor.transaction(false);
// 		try {
// 			if (this.iface.actualizarContactos20070525()) {
// 				cursor.commit();
// 			} else {
// 				cursor.rollback();
// 			}
// 		}
// 		catch (e) {
// 			cursor.rollback();
// 			MessageBox.warning(sys.translate("Hubo un error al actualizar los datos de contactos del módulo de Facturación:\n" + e), MessageBox.Ok, MessageBox.NoButton);
// 		}
// 	}
//
// 	if (condicionProv) {
// 		var cursor:FLSqlCursor = new FLSqlCursor("proveedores");
// 		cursor.transaction(false);
// 		try {
// 			if (this.iface.actualizarContactosProv20070702()) {
// 				cursor.commit();
// 			} else {
// 				cursor.rollback();
// 			}
// 		}
// 		catch (e) {
// 			cursor.rollback();
// 			MessageBox.warning(sys.translate("Hubo un error al actualizar los datos de contactos del módulo de Facturación:\n" + e), MessageBox.Ok, MessageBox.NoButton);
// 		}
// 	}
//-------------------------------- 20070525 -------------------------------------

	this.iface.estableceGlobalInit();

	if (util.sqlSelect("empresa", "id", "1 = 1"))
		return;

	var cursor:FLSqlCursor = new FLSqlCursor("empresa");
	cursor.select();
	if (!cursor.first()) {
		sys.infoMsgBox(sys.translate("Se insertará una empresa por defecto y algunos valores iniciales para empezar a trabajar."));
		this.iface.valoresIniciales();
		this.execMainScript("empresa");
	}
}

function interna_beforeCommit_dirclientes(curDirCli)
{
	var _i = this.iface;

	if (!_i.controlDatosMod(curDirCli)) {
		return false;
	}

	return true;
}

function interna_afterCommit_dirclientes(curDirCli:FLSqlCursor):Boolean
{
	if (curDirCli.modeAccess() == curDirCli.Del) {
		var domFact:String = curDirCli.valueBuffer("domfacturacion");
		var domEnv:String = curDirCli.valueBuffer("domenvio");
		if (domFact == true || domEnv == true) {
			var cursor:FLSqlCursor = new FLSqlCursor("dirclientes");
			cursor.select("codcliente = '" + curDirCli.valueBuffer("codcliente") + "' AND id <> " + curDirCli.valueBuffer("id"));
			if (cursor.first()) {
				cursor.setModeAccess(cursor.Edit);
				cursor.refreshBuffer();
				if (domFact == true)
					cursor.setValueBuffer("domfacturacion", domFact);
				if (domEnv == true)
					cursor.setValueBuffer("domenvio", domEnv);
				cursor.commitBuffer();
			}
		}
	}
	return true;
}

function interna_afterCommit_dirproveedores(curDirProv:FLSqlCursor):Boolean
{
	if (curDirProv.modeAccess() == curDirProv.Del) {
		var dirPpal:String = curDirProv.valueBuffer("direccionppal");
		if (dirPpal == true) {
			var cursor:FLSqlCursor = new FLSqlCursor("dirproveedores");
			cursor.select("codproveedor = '" + curDirProv.valueBuffer("codproveedor") + "' AND id <> " + curDirProv.valueBuffer("id"));
			if (cursor.first()) {
				cursor.setModeAccess(cursor.Edit);
				cursor.refreshBuffer();
				cursor.setValueBuffer("direccionppal", dirPpal);
				cursor.commitBuffer();
			}
		}
	}
	return true;
}

function interna_afterCommit_clientes(curCliente:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	if (!sys.isLoadedModule("flcontppal"))
		return true;

	var codSubcuenta:String = curCliente.valueBuffer("codsubcuenta");
	var idSubcuenta:Number = parseFloat(curCliente.valueBuffer("idsubcuenta"));
	var codCliente:String = curCliente.valueBuffer("codcliente");
	var idSubcuentaPrevia:Number = parseFloat(curCliente.valueBufferCopy("idsubcuenta"));

	switch(curCliente.modeAccess()) {
	/** \C Cuando el cliente se crea, se generan automáticamente las subcuentas para dicho cliente asociadas a los ejercicios con plan general contable creado.
	\end */
		case curCliente.Insert: {
			if (!this.iface.rellenarSubcuentasCli(codCliente, codSubcuenta, curCliente.valueBuffer("nombre")))
				return false;
			break;
		}
		/*
		case curCliente.Del: {
			if (!curCliente.isNull("idsubcuenta")) {
				if (!util.sqlSelect("clientes", "idsubcuenta", "idsubcuenta = " + idSubcuentaPrevia + " AND codcliente <> '" + codCliente + "'")) {
					if (!this.iface.borrarSubcuenta(idSubcuenta))
						return false;
				}
			}
			break;
		}
		*/
	}
	return true;
}

function interna_afterCommit_proveedores(curProveedor:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	if (!sys.isLoadedModule("flcontppal"))
		return true;

	var codSubcuenta:String = curProveedor.valueBuffer("codsubcuenta");
	var idSubcuenta:Number = parseFloat(curProveedor.valueBuffer("idsubcuenta"));
	var codProveedor:String = curProveedor.valueBuffer("codproveedor");
	var idSubcuentaPrevia:Number = parseFloat(curProveedor.valueBufferCopy("idsubcuenta"));

	switch(curProveedor.modeAccess()) {
		/** \C Cuando el proveedor se crea, se generan automáticamente las subcuentas para dicho proveedor asociadas a los ejercicios con plan general contable creado.
		\end */
		case curProveedor.Insert: {
			if (!this.iface.rellenarSubcuentasProv(codProveedor, codSubcuenta, curProveedor.valueBuffer("nombre")))
				return false;
			break;
		}
		/*
		case curProveedor.Del: {
			if (!curProveedor.isNull("idsubcuenta")) {
				if (!util.sqlSelect("proveedores", "idsubcuenta", "idsubcuenta = " + idSubcuentaPrevia + " AND codcliente <> '" + codProveedor + "'")) {
					if (!this.iface.borrarSubcuenta(idSubcuenta))
						return false;
				}
			}
			break;
		}
		*/
	}
	return true;
}

function interna_beforeCommit_proveedores(curProveedor:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	if (!sys.isLoadedModule("flcontppal"))
		return true;

	switch(curProveedor.modeAccess()) {
		/** \C Cuando el proveedor se borra, se borran las subcuentas asociadas si éstas no tienen partidas asociadas ni están vinculadas con otro proveedor
		\end */
		case curProveedor.Del: {
			var qrySubcuentas:FLSqlQuery = new FLSqlQuery();
			qrySubcuentas.setTablesList("co_subcuentasprov,co_subcuentas");
			qrySubcuentas.setSelect("s.codsubcuenta,s.descripcion,s.codejercicio,s.saldo,s.idsubcuenta");
			qrySubcuentas.setFrom("co_subcuentasprov sp INNER JOIN co_subcuentas s ON sp.idsubcuenta = s.idsubcuenta")
			qrySubcuentas.setWhere("sp.codproveedor = '" + curProveedor.valueBuffer("codproveedor") + "'");
			try { qrySubcuentas.setForwardOnly( true ); } catch (e) {}
			if (!qrySubcuentas.exec())
				return false;

			var idSubcuenta:String;
			while (qrySubcuentas.next()) {
				idSubcuenta = qrySubcuentas.value("s.idsubcuenta");
				if (parseFloat(qrySubcuentas.value("s.saldo")) != 0)
					continue;
				if (util.sqlSelect("co_partidas", "idpartida", "idsubcuenta = " + idSubcuenta))
					continue;
				if (util.sqlSelect("co_subcuentasprov", "idsubcuenta", "idsubcuenta = " + idSubcuenta + " AND codproveedor <> '" + curProveedor.valueBuffer("codproveedor") + "'"))
					continue;
				if (!util.sqlDelete("co_subcuentas", "idsubcuenta = " + idSubcuenta))
					return false;
			}
		}
	}
	return true;
}

function interna_beforeCommit_clientes(curCliente:FLSqlCursor):Boolean
{
	var _i = this.iface;
	
	var util:FLUtil = new FLUtil();
	if (!sys.isLoadedModule("flcontppal"))
		return true;

	switch(curCliente.modeAccess()) {
		/** \C Cuando el cliente se borra, se borran las subcuentas asociadas si éstas no tienen partidas asociadas ni están vinculadas con otro cliente
		\end */
		case curCliente.Del: {
			var qrySubcuentas:FLSqlQuery = new FLSqlQuery();
			qrySubcuentas.setTablesList("co_subcuentascli,co_subcuentas");
			qrySubcuentas.setSelect("s.codsubcuenta,s.descripcion,s.codejercicio,s.saldo,s.idsubcuenta");
			qrySubcuentas.setFrom("co_subcuentascli sc INNER JOIN co_subcuentas s ON sc.idsubcuenta = s.idsubcuenta")
			qrySubcuentas.setWhere("sc.codcliente = '" + curCliente.valueBuffer("codcliente") + "'");
			try { qrySubcuentas.setForwardOnly( true ); } catch (e) {}
			if (!qrySubcuentas.exec())
				return false;

			var idSubcuenta:String;
			while (qrySubcuentas.next()) {
				idSubcuenta = qrySubcuentas.value("s.idsubcuenta");
				if (parseFloat(qrySubcuentas.value("s.saldo")) != 0)
					continue;
				if (util.sqlSelect("co_partidas", "idpartida", "idsubcuenta = " + idSubcuenta))
					continue;
				if (util.sqlSelect("co_subcuentascli", "idsubcuenta", "idsubcuenta = " + idSubcuenta + " AND codcliente <> '" + curCliente.valueBuffer("codcliente") + "'"))
					continue;
				if (!util.sqlDelete("co_subcuentas", "idsubcuenta = " + idSubcuenta))
					return false;
			}
		}
	}

	if (!_i.controlDatosMod(curCliente)) {
		return false;
	}

	return true;
}

/** \C Cuando cambia el ejercicio actual se establece el título de las ventanas principales con
el nombre del ejercicio seleccionado
\end */
/** \D Cuando cambia el ejercicio actual se establece una variable global (ver FLVar) con el código
del ejercicio seleccionado. El nombre de esta variable está fomado por el literal "ejerUsr_" seguido
del nombre del usuario actual obtenido con la función sys.nameUser(). Esto significa que por cada usuario
se almacena el ejercicio en el que se encuentra.
\end */
function interna_afterCommit_empresa(curEmpresa:FLSqlCursor):Boolean {
	/*
	var util:FLUtil = new FLUtil();
	var codejercicio:String = curEmpresa.valueBuffer( "codejercicio" );
	var nombreEjercicio:String = util.sqlSelect( "ejercicios", "nombre", "codejercicio='" + codejercicio + "'" );
	sys.setCaptionMainWidget( nombreEjercicio );

	var ejerUsr:FLVar = new FLVar();
	var idVar:String = "ejerUsr_" + sys.nameUser();
	ejerUsr.set( idVar, codejercicio );
	*/
}

function interna_beforeCommit_cuentasbcocli(curCuenta:FLSqlCursor):Boolean
{
	/** \C No se permite borrar la cuenta de un cliente si tiene recibos pendientes de pago asociados a dicha cuenta
	\end */
	switch(curCuenta.modeAccess()) {

		case curCuenta.Del:
			var util:FLUtil = new FLUtil;
			var codRecibo:String = util.sqlSelect("reciboscli", "codigo", "codcliente = '" + curCuenta.valueBuffer("codcliente") + "' AND codcuenta = '" + curCuenta.valueBuffer("codcuenta") + "' AND estado <> 'Pagado'");
			if (codRecibo && codRecibo != "") {
				sys.warnMsgBox(sys.translate("No puede eliminar la cuenta del cliente porque hay al menos un recibo (%1) pendiente de pago asociado a esta cuenta.\nDebe cambiar la cuenta de los recibos pendientes de este cliente antes de borrarla.").arg(codRecibo));
				return false;
			}
		break;
	}
	return true;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_msgNoDisponible(nombreModulo:String)
{
	var util:FLUtil = new FLUtil();
	sys.infoMsgBox(sys.translate("El módulo '") +
		nombreModulo + sys.translate("' sólo está disponible a través de suscripción.\n\nSi ha probado AbanQ y considera que puede serle útil, tiene\nla opción de suscribirse mediante una pequeña aportación para tener\nacceso a la zona de descargas (www.abanq.org), además de a un\nforo de soporte.\n\nCon su suscripción obtiene una aplicación estable\ny dispone del soporte de InfoSiAL (www.infosial.com), al tiempo\nque ayuda a seguir desarrollando y mejorando este software libre."));
}

/** \D Ejecuta la query especificada y devuelve un array con los datos de los campos seleccionados. Devuelve un campo extra 'result' que es 1 = Ok, 0 = Error, -1 No encontrado
@param	tabla: Nombre de la tabla
@param	campos: Nombre de los campos, separados por comas
@param	where: Cláusula where
@param	listaTablas: Lista de las tablas empleadas en la consulta. Este parámetro es opcional y se usa si la consulta afecta a más de una tabla.
@return	Array con los valores de los campos solicitados, más el campo result.
\end */
function oficial_ejecutarQry(tabla, campos, where, listaTablas)
{
	var util:FLUtil = new FLUtil;
	var campo:Array = campos.split(",");
	var valor:Array = [];
	valor["result"] = 1;
	var query:FLSqlQuery = new FLSqlQuery();
	if (listaTablas)
		query.setTablesList(listaTablas);
	else
		query.setTablesList(tabla);
	try { query.setForwardOnly( true ); } catch (e) {}
	query.setSelect(campo);
	query.setFrom(tabla);
	query.setWhere(where);
	if (query.exec()) {
		if (query.next()) {
			for (var i:Number = 0; i < campo.length; i++) {
				valor[campo[i]] = query.value(i);
			}
		} else {
			valor.result = -1;
		}
	} else {
		sys.errorMsgBox(sys.translate("Falló la consulta") + query.sql());
		valor.result = 0;
	}

	return valor;
}

function oficial_valorDefectoEmpresa(fN, idEmpresa)
{
	var query:FLSqlQuery = new FLSqlQuery();

	query.setTablesList( "empresa" );
	try { query.setForwardOnly( true ); } catch (e) {}
	query.setSelect( fN );
	query.setFrom( "empresa" );
	if ( query.exec() )
		if ( query.next() )
			return query.value( 0 );

	return "";
}

/** \D Devuelve el ejercicio actual para el usuario conectado
@return	codEjercicio: Código del ejercicio actual
\end */
function oficial_ejercicioActual():String
{
	var util:FLUtil = new FLUtil;
	var codEjercicio:String
	try {
		var settingKey:String = "ejerUsr_" + sys.nameUser();
		codEjercicio = util.readDBSettingEntry(settingKey);
		/*if (!codEjercicio)
			codEjercicio = this.iface.cambiarEjercicioActual(this.iface.valorDefectoEmpresa("codejercicio"));*/
	}
	catch ( e ) {}

	if (!codEjercicio)
		codEjercicio = this.iface.valorDefectoEmpresa("codejercicio");

	return codEjercicio;
}

/** \D Establece el ejercicio actual para el usuario conectado
Cuando cambia el ejercicio actual se establece un setting de base de datos (tabla flsettings) con el código
del ejercicio seleccionado. El nombre de esta variable está fomado por el literal "ejerUsr_" seguido
del nombre del usuario actual obtenido con la función sys.nameUser(). Esto significa que por cada usuario
se almacena el ejercicio en el que se encuentra.

@param	codEjercicio: Código del ejercicio actual
@return	true si la asignación del ejercicio se realizó correctamente, false en caso contrario
\end */
function oficial_cambiarEjercicioActual(codEjercicio:String):Boolean
{
	var util:FLUtil = new FLUtil();
	var ok:Boolean = false;

	try {
		var settingKey:String = "ejerUsr_" + sys.nameUser();
		ok = util.writeDBSettingEntry(settingKey, codEjercicio);
	}
	catch (e) {}

	return ok;
}

function oficial_cerosIzquierda(numero:String, totalCifras:Number):String
{
	var ret:String = numero.toString();
	var numCeros:Number = totalCifras - ret.length;
	for ( ; numCeros > 0 ; --numCeros)
		ret = "0" + ret;
	return ret;
}

function oficial_espaciosDerecha(texto:String, totalLongitud:Number):String
{
	var ret:String = texto.toString();
	var numEspacios:Number = totalLongitud - ret.length;
	for ( ; numEspacios > 0 ; --numEspacios)
		ret += " ";
	return ret;
}

function oficial_valoresIniciales()
{
	var cursor:FLSqlCursor = new FLSqlCursor("bancos");
	var bancos:Array =
		[["0030", "BANESTO"],["0112", "BANCO URQUIJO"],
		["2085", "IBERCAJA"],["0093", "BANCO DE VALENCIA"],
		["2059", "CAIXA SABADELL"],["2073", "CAIXA TARRAGONA"],
		["2038", "CAJA MADRID"],["2091", "CAIXA GALICIA"],
		["0019", "DEUTSCHE BANK"],["0081", "BANCO DE SABADELL"],
		["0049", "BANCO SANTANDER CENTRAL HISPANO"],["0072", "BANCO PASTOR"],
		["0075", "BANCO POPULAR"],["0182","BANCO BILBAO VIZCAYA ARGENTARIA"],
		["0128", "BANKINTER"],["2090", "C.A.M."],["2100", "LA CAIXA"],
		["2077", "BANCAJA"],["0008", "BANCO ATLANTICO"],
		["0061", "BANCA MARCH"],["0065", "BARCLAYS BANK"],
		["0073", "PATAGON INTERNET BANK"],["0103", "BANCO ZARAGOZANO"],
		["2013", "CAIXA CATALUNYA"],["2043","CAJA MURCIA"],
		["2103", "UNICAJA"],["2105", "CAJA DE CASTILLA LA MANCHA"],
		["0042", "BANCO GUIPUZCOANO"],["0138", "BANKOA"],
		["3056", "CAJA RURAL DE ALBACETE"]];
	for (var i:Number = 0; i < bancos.length; i++) {
		with(cursor) {
			setModeAccess(cursor.Insert);
			refreshBuffer();
			setValueBuffer("entidad", bancos[i][0]);
			setValueBuffer("nombre", bancos[i][1]);
			commitBuffer();
		}
	}
	delete cursor;

	cursor = new FLSqlCursor("impuestos");
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codimpuesto", "GEN");
		setValueBuffer("descripcion", "I.V.A. General");
		setValueBuffer("iva", "21");
		setValueBuffer("recargo", "5.2");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codimpuesto", "RED");
		setValueBuffer("descripcion", "I.V.A. Reducido");
		setValueBuffer("iva", "10");
		setValueBuffer("recargo", "1.4");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codimpuesto", "SRED");
		setValueBuffer("descripcion", "I.V.A. Superreducido");
		setValueBuffer("iva", "4");
		setValueBuffer("recargo", "0.5");
		commitBuffer();
	}
	delete cursor;

	cursor = new FLSqlCursor("paises");
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codpais", "ES");
		setValueBuffer("nombre", "ESPAÑA");
		setValueBuffer("bandera", "/* XPM */\nstatic char * esp_xpm[] = {\n\"30 16 16 1\",\n\"	c #6C1E04\",\n\".	c #B78B19\",\n\"+	c #E4D31A\",\n\"@	c #8E4F09\",\n\"#	c #FBFC05\",\n\"$	c #EF0406\",\n\"%	c #F9978D\",\n\"&	c #FCFA36\",\n\"*	c #FC595C\",\n\"=	c #E1B025\",\n\"-	c #FB3634\",\n\";	c #E67559\",\n\">	c #A26E13\",\n\",	c #FCACAC\",\n\"'	c #B29F19\",\n\")	c #9D0204\",\n\",,%%%%%%%%%%%%%%%%%%%%%%%%%%;$\",\n\";;**************************$)\",\n\"--$$$$$$$$$$$$$$$$$$$$$$$$$$$)\",\n\"--$$$$$$$$$$$$$$$$$$$$$$$$$$$)\",\n\"&&####&#&++&################+'\",\"&&####&=.>..&###############+'\",\n\"&&####@=@@@=>=##############+'\",\n\"&&####='>;>%=+&#############+'\",\n\"&&####@@@ @>>.##############+'\",\n\"&&####.=>@;;#;##############+'\",\"&&+###>..>..>=##############+'\",\n\"&&####.+===+.+&#############+.\",\n\"--$$$$$$$$$$$$$$$$$$$$$$$$$$$)\",\n\"--$$$$$$$$$$$$$$$$$$$$$$$$$$$)\",\n\"$$$)$)$)$))$)$)$)$)$)$)$)$)$))\",\n\"))))))))))))))))))))))))))))))\"};\n");
		setValueBuffer("codiso", "ES");
		commitBuffer();
	}

	var paises:Array =
		[["AF","AFGANISTÁN","AF"],
		["SI","ESLOVENIA","SI"],
		["AL","ALBANIA","AL"],
		["DE","ALEMANIA","DE"],
		["AD","ANDORRA","AD"],
		["EE","ESTONIA","EE"],
		["AO","ANGOLA","AO"],
		["AI","ANGUILA","AI"],
		["FO","ISLAS FEROE","FO"],
		["AQ","ANTÁRTIDA","AQ"],
		["PH","FILIPINAS","PH"],
		["AG","ANTIGUA Y BARBUDA","AG"],
		["FI","FINLANDIA","FI"],
		["AN","ANTILLAS NEERLANDESAS","AN"],
		["FJ","FIYI","FJ"],
		["SA","ARABIA SAUDÍ","SA"],
		["DZ","ARGELIA","DZ"],
		["GA","GABÓN","GA"],
		["AR","ARGENTINA","AR"],
		["GM","GAMBIA","GM"],
		["AM","ARMENIA","AM"],
		["GE","GEORGIA","GE"],
		["AW","ARUBA","AW"],
		["GS","GEORGIA DEL SUR Y LAS ISLAS SANDWICH DEL SUR","GS"],
		["AU","AUSTRALIA","AU"],
		["GH","GHANA","GH"],
		["AT","AUSTRIA","AT"],
		["GI","GIBRALTAR","GI"],
		["AZ","AZERBAIYÁN","AZ"],
		["GD","GRANADA","GD"],
		["BS","BAHAMAS","BS"],
		["GR","GRECIA","GR"],
		["BH","BAHRÉIN","BH"],
		["GL","GROENLANDIA","GL"],
		["BD","BANGLADESH","BD"],
		["GU","GUAM","GU"],
		["BB","BARBADOS","BB"],
		["GT","GUATEMALA","GT"],
		["BE","BÉLGICA","BE"],
		["GG","GUERNESEY","GG"],
		["BZ","BELICE","BZ"],
		["GN","GUINEA","GN"],
		["BJ","BENÍN","BJ"],
		["GQ","GUINEA ECUATORIAL","GQ"],
		["BM","BERMUDAS","BM"],
		["GW","GUINEA-BISSAU","GW"],
		["BY","BIELORRUSIA (BELARÚS)","BY"],
		["GY","GUYANA","GY"],
		["BO","BOLIVIA","BO"],
		["HT","HAITÍ","HT"],
		["BA","BOSNIA-HERZEGOVINA","BA"],
		["HM","ISLAS HEARD Y MCDONALD","HM"],
		["BW","BOTSUANA","BW"],
		["HN","HONDURAS","HN"],
		["BV","ISLA BOUVET","BV"],
		["HK","HONG-KONG","HK"],
		["BR","BRASIL","BR"],
		["HU","HUNGRÍA","HU"],
		["BN","BRUNÉI(BRUNÉI DARUSSALAM)","BN"],
		["IN","INDIA","IN"],
		["BG","BULGARIA","BG"],
		["ID","INDONESIA","ID"],
		["BF","BURKINA FASO","BF"],
		["IR","IRÁN","IR"],
		["BI","BURUNDI","BI"],
		["IQ","IRAQ","IQ"],
		["BT","BUTÁN","BT"],
		["IE","IRLANDA","IE"],
		["CV","REPÚBLICA DE CABO VERDE","CV"],
		["IM","ISLA DE MAN","IM"],
		["KY","ISLAS CAIMÁN","KY"],
		["IS","ISLANDIA","IS"],
		["KH","CAMBOYA","KH"],
		["IL","ISRAEL","IL"],
		["CM","CAMERÚN","CM"],
		["IT","ITALIA","IT"],
		["CA","CANADÁ","CA"],
		["JM","JAMAICA","JM"],
		["CF","REPÚBLICA CENTROAFRICANA","CF"],
		["JP","JAPÓN","JP"],
		["CC","ISLA DE COCOS (KEELING)","CC"],
		["JE","JERSEY","JE"],
		["CO","COLOMBIA","CO"],
		["JO","JORDANIA","JO"],
		["KM","COMORAS","KM"],
		["KZ","KAZAJSTÁN","KZ"],
		["CG","CONGO","CG"],
		["KE","KENIA","KE"],
		["CD","REPÚBLICA DEMOCRÁTICA DEL CONGO (Zaire)","CD"],
		["KG","KIRGUISTÁN","KG"],
		["CK","ISLAS COOK","CK"],
		["KI","KIRIBATI","KI"],
		["KP","COREA DEL NORTE","KP"],
		["KW","KUWAIT","KW"],
		["KR","COREA DEL SUR","KR"],
		["LA","LAOS","LA"],
		["CI","COSTA DE MARFIL","CI"],
		["LS","LESOTHO","LS"],
		["CR","COSTA RICA","CR"],
		["LV","LETONIA","LV"],
		["HR","CROACIA","HR"],
		["LB","LÍBANO","LB"],
		["CU","CUBA","CU"],
		["LR","LIBERIA","LR"],
		["TD","CHAD","TD"],
		["LY","LIBIA","LY"],
		["CZ","REPÚBLICA CHECA","CZ"],
		["LI","LIECHTENSTEIN","LI"],
		["CL","CHILE","CL"],
		["LT","LITUANIA","LT"],
		["CN","CHINA","CN"],
		["LU","LUXEMBURGO","LU"],
		["CY","CHIPRE","CY"],
		["DK","DINAMARCA","DK"],
		["DM","DOMINICA","DM"],
		["DO","REPÚBLICA DOMINICANA","DO"],
		["MO","MACAO","MO"],
		["EC","ECUADOR","EC"],
		["MK","MACEDONIA","MK"],
		["EG","EGIPTO","EG"],
		["MG","MADAGASCAR","MG"],
		["AE","EMIRATOS ÁRABES UNIDOS","AE"],
		["MY","MALASIA","MY"],
		["ER","ERITREA","ER"],
		["MW","MALAWI","MW"],
		["SK","ESLOVAQUIA","SK"],
		["MV","MALDIVAS","MV"],
		["ML","MALI","ML"],
		["PM","SAN PEDRO Y MIQUELÓN","PM"],
		["MT","MALTA","MT"],
		["VC","SAN VICENTE Y LAS GRANADINAS","VC"],
		["FK","ISLAS MALVINAS (FALKLANDS)","FK"],
		["SH","SANTA ELENA","SH"],
		["MP","ISLAS MARIANAS DEL NORTE","MP"],
		["MA","MARRUECOS","MA"],
		["LC","SANTA LUCÍA","LC"],
		["MH","ISLAS MARSHALL","MH"],
		["ST","SANTO TOMÉ Y PRÍNCIPE","ST"],
		["MU","MAURICIO","MU"],
		["SN","SENEGAL","SN"],
		["CS","SERBIA Y MONTENEGRO","CS"],
		["MR","MAURITANIA","MR"],
		["SC","SEYCHELLES","SC"],
		["YT","MAYOTTE","YT"],
		["UM","ISLAS MENORES ALEJADAS DE LOS EE.UU","UM"],
		["MX","MÉXICO","MX"],
		["SL","SIERRA LEONA","SL"],
		["FM","FEDERACIÓN DE ESTADOS DE MICRONESIA","FM"],
		["SG","SINGAPUR","SG"],
		["SY","SIRIA","SY"],
		["MD","MOLDAVIA","MD"],
		["SO","SOMALIA","SO"],
		["MC","MÓNACO","MC"],
		["LK","SRI LANKA","LK"],
		["MN","MONGOLIA","MN"],
		["SZ","SUAZILANDIA","SZ"],
		["MS","MONTSERRAT","MS"],
		["ZA","SUDÁFRICA","ZA"],
		["MZ","MOZAMBIQUE","MZ"],
		["SD","SUDÁN","SD"],
		["MM","MYANMAR","MM"],
		["SE","SUECIA","SE"],
		["NA","NAMIBIA","NA"],
		["CH","SUIZA","CH"],
		["NR","NAURU","NR"],
		["CX","ISLA NAVIDAD","CX"],
		["SR","SURINAM","SR"],
		["NP","NEPAL","NP"],
		["TH","TAILANDIA","TH"],
		["NI","NICARAGUA","NI"],
		["TW","TAIWÁN","TW"],
		["NE","NÍGER","NE"],
		["TZ","TANZANIA","TZ"],
		["NG","NIGERIA","NG"],
		["NU","ISLA NIUE","NU"],
		["TJ","TAYIKISTÁN","TJ"],
		["NF","ISLA NORFOLK","NF"],
		["NO","NORUEGA","NO"],
		["NC","NUEVA CALEDONIA","NC"],
		["NZ","NUEVA ZELANDA","NZ"],
		["TG","TOGO","TG"],
		["TK","ISLAS TOKELAU","TK"],
		["TO","TONGA","TO"],
		["OM","OMÁN","OM"],
		["TT","TRINIDAD Y TOBAGO","TT"],
		["NL","PAÍSES BAJOS","NL"],
		["TN","TÚNEZ","TN"],
		["PK","PAKISTÁN","PK"],
		["TC","ISLAS TURCAS Y CAICOS","TC"],
		["PW","PALAU","PW"],
		["TM","TURKMENISTÁN","TM"],
		["PA","PANAMÁ","PA"],
		["TR","TURQUÍA","TR"],
		["PG","PAPÚA NUEVA GUINEA","PG"],
		["TV","TUVALU","TV"],
		["UA","UCRANIA","UA"],
		["UG","UGANDA","UG"],
		["UY","URUGUAY","UY"],
		["UZ","UZBEKISTÁN","UZ"],
		["PY","PARAGUAY","PY"],
		["VU","VANUATU","VU"],
		["PE","PERÚ","PE"],
		["VA","CIUDAD DEL VATICANO","VA"],
		["PN","PITCAIRN","PN"],
		["VE","VENEZUELA","VE"],
		["PF","POLINESIA FRANCESA","PF"],
		["VN","VIETNAM","VN"],
		["VG","ISLAS VÍRGENES BRITÁNICAS","VG"],
		["VI","ISLAS VÍRGENES DE LOS EE.UU","VI"],
		["PL","POLONIA","PL"],
		["WF","ISLAS WALLIS Y FUTUNA","WF"],
		["PT","PORTUGAL","PT"],
		["YE","YEMEN","YE"],
		["DJ","YIBUTI","DJ"],
		["PR","PUERTO RICO","PR"],
		["ZM","ZAMBIA","ZM"],
		["QA","QATAR","QA"],
		["ZW","ZIMBABUE","ZW"],
		["GB","REINO UNIDO","GB"],
		["RW","RUANDA","RW"],
		["RO","RUMANÍA","RO"],
		["RU","RUSIA","RU"],
		["SB","ISLAS SALOMÓN","SB"],
		["SV","EL SALVADOR","SV"],
		["WS","SAMOA","WS"],
		["AS","SAMOA AMERICANA","AS"],
		["KN","SAN CRISTÓBAL Y NIEVES","KN"],
		["SM","SAN MARINO","SM"],
		["FR","FRANCIA","FR"]];

	for (var i:Number = 0; i < paises.length; i++) {
		with(cursor) {
			setModeAccess(cursor.Insert);
			refreshBuffer();
			cursor.setValueBuffer("codpais", paises[i][0]);
			cursor.setValueBuffer("nombre", paises[i][1]);
			setValueBuffer("codiso", paises[i][2]);
			commitBuffer();
		}
	}

	delete cursor;

	cursor = new FLSqlCursor("divisas");
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("coddivisa", "EUR");
		setValueBuffer("descripcion", "EUROS");
		setValueBuffer("tasaconv", "1");
		setValueBuffer("codiso", "978");
		setValueBuffer("monedabillete", "b500,b200,b100,b50,b20,b10,b5,m2,m1,m0.50,m0.20,m0.10,m0.05,m0.02,m0.01");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("coddivisa", "USD");
		setValueBuffer("descripcion", "DÓLARES USA");
		setValueBuffer("tasaconv", "0.845");
		setValueBuffer("codiso", "849");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("coddivisa", "GBP");
		setValueBuffer("descripcion", "LIBRAS ESTERLINAS");
		setValueBuffer("tasaconv", "1.48");
		setValueBuffer("codiso", "826");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("coddivisa", "CHF");
		setValueBuffer("descripcion", "FRANCOS SUIZOS");
		setValueBuffer("tasaconv", "0.648");
		setValueBuffer("codiso", "756");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("coddivisa", "SEK");
		setValueBuffer("descripcion", "CORONAS SUECAS");
		setValueBuffer("tasaconv", "0.106");
		setValueBuffer("codiso", "752");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("coddivisa", "NOK");
		setValueBuffer("descripcion", "CORONAS NORUEGAS");
		setValueBuffer("tasaconv", "0.126");
		setValueBuffer("codiso", "578");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("coddivisa", "NZD");
		setValueBuffer("descripcion", "DÓLARES NEOZELANDESES");
		setValueBuffer("tasaconv", "0.608");
		setValueBuffer("codiso", "554");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("coddivisa", "JPY");
		setValueBuffer("descripcion", "YENES JAPONESES");
		setValueBuffer("tasaconv", "0.007");
		setValueBuffer("codiso", "392");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("coddivisa", "DKK");
		setValueBuffer("descripcion", "CORONAS DANESAS");
		setValueBuffer("tasaconv", "0.134");
		setValueBuffer("codiso", "208");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("coddivisa", "CAD");
		setValueBuffer("descripcion", "DÓLARES CANADIENSES");
		setValueBuffer("tasaconv", "0.735");
		setValueBuffer("codiso", "124");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("coddivisa", "AUD");
		setValueBuffer("descripcion", "DÓLARES AUSTRALIANOS");
		setValueBuffer("tasaconv", "0.639");
		setValueBuffer("codiso", "036");
		commitBuffer();
	}
	delete cursor;

	cursor = new FLSqlCursor("formaspago");
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codpago", "CONT");
		setValueBuffer("descripcion", "CONTADO");
		commitBuffer();
	}
	delete cursor;

	cursor = new FLSqlCursor("plazos");
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codpago", "CONT");
		setValueBuffer("dias", "0");
		setValueBuffer("aplazado", "100");
		commitBuffer();
	}
	delete cursor;

	cursor = new FLSqlCursor("ejercicios");
	var hoy:Date = new Date()
	var fechaInicio:Date = new Date(hoy.getYear(), 1, 1);
	var fechaFin:Date = new Date(hoy.getYear(), 12, 31);
	var codEjercicio:String = hoy.getYear();
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codejercicio", codEjercicio);
		setValueBuffer("nombre", "EJERCICIO " + codEjercicio);
		setValueBuffer("fechainicio", fechaInicio);
		setValueBuffer("fechafin", fechaFin);
		setValueBuffer("estado", "ABIERTO");
		commitBuffer();
	}
	delete cursor;

	this.iface.cambiarEjercicioActual( codEjercicio );

	cursor = new FLSqlCursor("series");
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codserie", "A");
		setValueBuffer("descripcion", "SERIE A");
		commitBuffer();
	}
	delete cursor;

	cursor = new FLSqlCursor("secuenciasejercicios");
	var idSec:Number;
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codserie", "A");
		setValueBuffer("codejercicio", codEjercicio);
		idSec = valueBuffer( "id" );
		commitBuffer();
	}
	delete cursor;

	cursor = new FLSqlCursor("secuencias");
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("id", idSec);
		setValueBuffer("nombre", "nfacturacli");
		setValueBuffer("valor", 1);
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("id", idSec);
		setValueBuffer("nombre", "nfacturaprov");
		setValueBuffer("valor", 1);
		commitBuffer();
	}
	delete cursor;

	cursor = new FLSqlCursor("empresa");
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("nombre", "InfoSiAL, S.L. - Creadores de AbanQ - http://www.infosial.com");
		setValueBuffer("cifnif", "B02352961");
		setValueBuffer("administrador", "FEDERICO ALBUJER ZORNOZA");
		setValueBuffer("direccion", "C/. SAN ANTONIO, 88");
		setValueBuffer("codejercicio", codEjercicio);
		setValueBuffer("coddivisa", "EUR");
		setValueBuffer("codpago", "CONT");
		setValueBuffer("codserie", "A");
		setValueBuffer("codpostal", "02640");
		setValueBuffer("ciudad", "ALMANSA");
		setValueBuffer("provincia", "ALBACETE");
		setValueBuffer("telefono", "967 345 174");
		setValueBuffer("email", "mail@infosial.com");
		setValueBuffer("codpais", "ES");
		setValueBuffer("logo", "/* XPM */\n static char * minilogoinfosial_xpm[] = {\n \"125 43 392 2\",\n \"  	c None\",\n \". 	c #5172B6\",\n \"+ 	c #5D7CBB\",\n \"@ 	c #8CA2CF\",\n \"# 	c #93A7D2\",\n \"$ 	c #BAC7E2\",\n \"% 	c #FDFDFE\",\n \"& 	c #FCFCFE\",\n \"* 	c #FBFCFD\",\n \"= 	c #FCFDFE\",\n \"- 	c #FFFFFF\",\n \"; 	c #FEFEFE\",\n \"> 	c #CED7EA\",\n \", 	c #AABADB\",\n \"' 	c #5676B8\",\n \") 	c #6381BE\",\n \"! 	c #E1E7F2\",\n \"~ 	c #748FC5\",\n \"{ 	c #B9C6E1\",\n \"] 	c #738DC4\",\n \"^ 	c #B7C5E1\",\n \"/ 	c #F7F1ED\",\n \"( 	c #E1CABB\",\n \"_ 	c #E4CFC2\",\n \": 	c #FCFAF8\",\n \"< 	c #F1E6DE\",\n \"[ 	c #A76135\",\n \"} 	c #923C05\",\n \"| 	c #933E08\",\n \"1 	c #B57A55\",\n \"2 	c #FBF8F6\",\n \"3 	c #F2E8E1\",\n \"4 	c #D1AC95\",\n \"5 	c #D7B7A3\",\n \"6 	c #FAF6F4\",\n \"7 	c #B7C4E0\",\n \"8 	c #BC8866\",\n \"9 	c #903800\",\n \"0 	c #913A03\",\n \"a 	c #D5B49F\",\n \"b 	c #F5EDE8\",\n \"c 	c #A15627\",\n \"d 	c #903801\",\n \"e 	c #913902\",\n \"f 	c #B67C57\",\n \"g 	c #B5C1DC\",\n \"h 	c #AF6F47\",\n \"i 	c #C79A7E\",\n \"j 	c #D9BCA9\",\n \"k 	c #CCA48A\",\n \"l 	c #913A02\",\n \"m 	c #95400B\",\n \"n 	c #E2CBBC\",\n \"o 	c #E7D3C7\",\n \"p 	c #933E07\",\n \"q 	c #9C4E1C\",\n \"r 	c #556FAC\",\n \"s 	c #636182\",\n \"t 	c #64617F\",\n \"u 	c #576DA5\",\n \"v 	c #F9F5F2\",\n \"w 	c #C59779\",\n \"x 	c #A25829\",\n \"y 	c #A55E31\",\n \"z 	c #D4B29D\",\n \"A 	c #FEFDFC\",\n \"B 	c #FDFCFB\",\n \"C 	c #A45C2E\",\n \"D 	c #A9653A\",\n \"E 	c #E0C8B8\",\n \"F 	c #586BA1\",\n \"G 	c #834424\",\n \"H 	c #8F3903\",\n \"I 	c #8F3902\",\n \"J 	c #874019\",\n \"K 	c #5F658D\",\n \"L 	c #FEFDFD\",\n \"M 	c #F8F2EF\",\n \"N 	c #F9F4F1\",\n \"O 	c #FBF7F5\",\n \"P 	c #E8D5CA\",\n \"Q 	c #5370AF\",\n \"R 	c #616388\",\n \"S 	c #6E5863\",\n \"T 	c #715458\",\n \"U 	c #6A5B6E\",\n \"V 	c #566DA8\",\n \"W 	c #794D42\",\n \"X 	c #834426\",\n \"Y 	c #5271B2\",\n \"Z 	c #F4F6FB\",\n \"` 	c #DBE2F0\",\n \" .	c #CBD4E9\",\n \"..	c #C1CDE5\",\n \"+.	c #E0E6F2\",\n \"@.	c #F7F8FB\",\n \"#.	c #FDFEFE\",\n \"$.	c #E1C8B9\",\n \"%.	c #9B4C19\",\n \"&.	c #923B04\",\n \"*.	c #A3592B\",\n \"=.	c #EFE2DA\",\n \"-.	c #F4F6FA\",\n \";.	c #F6F8FB\",\n \">.	c #F5F7FB\",\n \",.	c #5271B3\",\n \"'.	c #5F658E\",\n \").	c #626284\",\n \"!.	c #616387\",\n \"~.	c #546FAD\",\n \"{.	c #5D6794\",\n \"].	c #824528\",\n \"^.	c #8E3905\",\n \"/.	c #626385\",\n \"(.	c #5470AE\",\n \"_.	c #E7ECF5\",\n \":.	c #95A9D3\",\n \"<.	c #5F7DBC\",\n \"[.	c #617FBD\",\n \"}.	c #A5B6DA\",\n \"|.	c #FCFAF9\",\n \"1.	c #AD6D44\",\n \"2.	c #C29273\",\n \"3.	c #C4CFE6\",\n \"4.	c #B1C0DF\",\n \"5.	c #758FC5\",\n \"6.	c #5B7ABA\",\n \"7.	c #546FAC\",\n \"8.	c #844322\",\n \"9.	c #8D3B09\",\n \"0.	c #5C6896\",\n \"a.	c #556EAA\",\n \"b.	c #87411B\",\n \"c.	c #8E3A07\",\n \"d.	c #7D4936\",\n \"e.	c #5370B1\",\n \"f.	c #D3DBEC\",\n \"g.	c #6582BE\",\n \"h.	c #5374B7\",\n \"i.	c #6B87C1\",\n \"j.	c #7C95C8\",\n \"k.	c #7D96C8\",\n \"l.	c #7992C7\",\n \"m.	c #6683BF\",\n \"n.	c #5273B7\",\n \"o.	c #A2B4D8\",\n \"p.	c #FEFEFF\",\n \"q.	c #AE6F46\",\n \"r.	c #C39375\",\n \"s.	c #8299CA\",\n \"t.	c #F9FAFC\",\n \"u.	c #6C5967\",\n \"v.	c #8D3A08\",\n \"w.	c #7D4A38\",\n \"x.	c #7A4C3F\",\n \"y.	c #5A6A9D\",\n \"z.	c #5D6792\",\n \"A.	c #8A3E12\",\n \"B.	c #8C3C0B\",\n \"C.	c #675E78\",\n \"D.	c #F0F3F9\",\n \"E.	c #708BC3\",\n \"F.	c #5978B9\",\n \"G.	c #B5C3E0\",\n \"H.	c #F1F4F9\",\n \"I.	c #ECF0F7\",\n \"J.	c #C6D1E7\",\n \"K.	c #E6EBF5\",\n \"L.	c #E2CABC\",\n \"M.	c #F0E4DD\",\n \"N.	c #E5EAF4\",\n \"O.	c #5273B6\",\n \"P.	c #5373B7\",\n \"Q.	c #D6DEEE\",\n \"R.	c #80472E\",\n \"S.	c #6B5A6C\",\n \"T.	c #5271B4\",\n \"U.	c #5172B5\",\n \"V.	c #596B9E\",\n \"W.	c #6C5968\",\n \"X.	c #5C6895\",\n \"Y.	c #C4D0E6\",\n \"Z.	c #9AADD4\",\n \"`.	c #FFFEFE\",\n \" +	c #F6EEEA\",\n \".+	c #ECDDD4\",\n \"++	c #F9F3F0\",\n \"@+	c #A7B8DA\",\n \"#+	c #5C7BBB\",\n \"$+	c #C5D0E7\",\n \"%+	c #5777B9\",\n \"&+	c #97AAD3\",\n \"*+	c #8C3C0C\",\n \"=+	c #596B9F\",\n \"-+	c #B6C4E0\",\n \";+	c #C0CCE4\",\n \">+	c #6C88C1\",\n \",+	c #7B94C8\",\n \"'+	c #F8F9FC\",\n \")+	c #7791C6\",\n \"!+	c #F7F8FC\",\n \"~+	c #6A5A6C\",\n \"{+	c #655F7C\",\n \"]+	c #576DA6\",\n \"^+	c #76504B\",\n \"/+	c #75504D\",\n \"(+	c #685D74\",\n \"_+	c #556EA9\",\n \":+	c #626386\",\n \"<+	c #8E3A06\",\n \"[+	c #8D3B08\",\n \"}+	c #6F565F\",\n \"|+	c #6B5A6A\",\n \"1+	c #794D43\",\n \"2+	c #725355\",\n \"3+	c #566EA9\",\n \"4+	c #BFCBE4\",\n \"5+	c #5272B6\",\n \"6+	c #8DA2CF\",\n \"7+	c #8199CA\",\n \"8+	c #6A86C1\",\n \"9+	c #CAD4E9\",\n \"0+	c #5575B8\",\n \"a+	c #B9C6E2\",\n \"b+	c #ACBCDC\",\n \"c+	c #774F49\",\n \"d+	c #636181\",\n \"e+	c #86411E\",\n \"f+	c #745150\",\n \"g+	c #774F48\",\n \"h+	c #8F3904\",\n \"i+	c #864525\",\n \"j+	c #814B35\",\n \"k+	c #874421\",\n \"l+	c #844321\",\n \"m+	c #64607E\",\n \"n+	c #E9EDF6\",\n \"o+	c #5475B7\",\n \"p+	c #9AADD5\",\n \"q+	c #EAEEF6\",\n \"r+	c #FEFFFF\",\n \"s+	c #8DA3CF\",\n \"t+	c #E4E9F4\",\n \"u+	c #75514F\",\n \"v+	c #8C3B0B\",\n \"w+	c #8B3D10\",\n \"x+	c #7D4A37\",\n \"y+	c #80472F\",\n \"z+	c #8D3C0B\",\n \"A+	c #6D667D\",\n \"B+	c #5E7AB6\",\n \"C+	c #5B7EC0\",\n \"D+	c #5E79B3\",\n \"E+	c #745D67\",\n \"F+	c #8C3B0A\",\n \"G+	c #665F7A\",\n \"H+	c #CBD5E9\",\n \"I+	c #6482BE\",\n \"J+	c #98ACD4\",\n \"K+	c #D4DCED\",\n \"L+	c #FBFCFE\",\n \"M+	c #8EA4D0\",\n \"N+	c #89A0CE\",\n \"O+	c #5877B9\",\n \"P+	c #DBE1F0\",\n \"Q+	c #893E14\",\n \"R+	c #7A4C3E\",\n \"S+	c #87401A\",\n \"T+	c #675E76\",\n \"U+	c #735354\",\n \"V+	c #8E3A05\",\n \"W+	c #76504A\",\n \"X+	c #64607F\",\n \"Y+	c #725458\",\n \"Z+	c #735F6A\",\n \"`+	c #5C7DBD\",\n \" @	c #7B544C\",\n \".@	c #883F17\",\n \"+@	c #576CA4\",\n \"@@	c #DAE0EF\",\n \"#@	c #BBC8E3\",\n \"$@	c #B0BFDE\",\n \"%@	c #D2DBEC\",\n \"&@	c #C9D3E8\",\n \"*@	c #5474B7\",\n \"=@	c #9DB0D6\",\n \"-@	c #85421F\",\n \";@	c #576CA5\",\n \">@	c #566EA8\",\n \",@	c #6A5B6F\",\n \"'@	c #8B3C0D\",\n \")@	c #596BA0\",\n \"!@	c #586CA2\",\n \"~@	c #5F78B1\",\n \"{@	c #666F97\",\n \"]@	c #6B5A6B\",\n \"^@	c #8FA4D0\",\n \"/@	c #6280BD\",\n \"(@	c #7891C6\",\n \"_@	c #E2E8F3\",\n \":@	c #FAFBFD\",\n \"<@	c #F0F2F9\",\n \"[@	c #6F5660\",\n \"}@	c #71555A\",\n \"|@	c #616489\",\n \"1@	c #65719C\",\n \"2@	c #7B4B3D\",\n \"3@	c #5272B4\",\n \"4@	c #F2F4F9\",\n \"5@	c #BAC8E2\",\n \"6@	c #EFF2F8\",\n \"7@	c #D4DDED\",\n \"8@	c #718CC3\",\n \"9@	c #A1B3D7\",\n \"0@	c #A1B3D8\",\n \"a@	c #6F8BC3\",\n \"b@	c #C0CCE5\",\n \"c@	c #6C5969\",\n \"d@	c #6E5761\",\n \"e@	c #725357\",\n \"f@	c #695C70\",\n \"g@	c #6D667F\",\n \"h@	c #5B7EBF\",\n \"i@	c #745E67\",\n \"j@	c #EDF0F7\",\n \"k@	c #829ACB\",\n \"l@	c #894119\",\n \"m@	c #65719D\",\n \"n@	c #696C8E\",\n \"o@	c #8C3D0F\",\n \"p@	c #824529\",\n \"q@	c #D0D9EB\",\n \"r@	c #F3F5FA\",\n \"s@	c #BCC9E3\",\n \"t@	c #BCC8E3\",\n \"u@	c #6885C0\",\n \"v@	c #636283\",\n \"w@	c #8D3C0C\",\n \"x@	c #7E5042\",\n \"y@	c #77595B\",\n \"z@	c #804E3B\",\n \"A@	c #8BA2CF\",\n \"B@	c #ABBBDC\",\n \"C@	c #A4B5D9\",\n \"D@	c #596A9E\",\n \"E@	c #8B3D0E\",\n \"F@	c #B3C2DF\",\n \"G@	c #A9BADB\",\n \"H@	c #E3E8F3\",\n \"I@	c #5878B9\",\n \"J@	c #6B88C1\",\n \"K@	c #784E46\",\n \"L@	c #CDD6EA\",\n \"M@	c #DAE1EF\",\n \"N@	c #F3F6FA\",\n \"O@	c #5E7CBB\",\n \"P@	c #607EBC\",\n \"Q@	c #E8ECF5\",\n \"R@	c #DCE3F0\",\n \"S@	c #859CCC\",\n \"T@	c #889ECD\",\n \"U@	c #5979BA\",\n \"V@	c #ECEFF7\",\n \"W@	c #8AA0CE\",\n \"X@	c #6D89C2\",\n \"Y@	c #7D96C9\",\n \"Z@	c #889FCD\",\n \"`@	c #839ACB\",\n \" #	c #5A699B\",\n \".#	c #7F4730\",\n \"+#	c #646181\",\n \"@#	c #5A7ABA\",\n \"##	c #DDE3F1\",\n \"$#	c #6481BE\",\n \"%#	c #F1F3F9\",\n \"&#	c #6A5B6D\",\n \"*#	c #70555C\",\n \"=#	c #6F5761\",\n \"-#	c #566DA6\",\n \";#	c #5E6690\",\n \">#	c #60658C\",\n \",#	c #6E5763\",\n \"'#	c #556FAB\",\n \")#	c #735353\",\n \"!#	c #7C4A39\",\n \"~#	c #7E4934\",\n \"{#	c #76504C\",\n \"]#	c #D3DCED\",\n \"^#	c #F9FAFD\",\n \"/#	c #F8FAFC\",\n \"(#	c #869DCC\",\n \"_#	c #E2E7F3\",\n \". . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . \",\n \". . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . \",\n \". . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . \",\n \". . + @ # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # @ + . . \",\n \". . $ % & * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * = - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ; $ . . \",\n \". . > , ' . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ) ! - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - > . . \",\n \". . > ~ . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ^ - / ( _ : - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ^ < [ } | 1 2 - - - - 3 4 5 6 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 7 8 9 9 9 0 a - - - b c d e f ; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . g h 9 9 9 9 i - - - j 9 9 9 d / - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ^ k l 9 9 m n - - - o p 9 9 q : - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . r s t u . . ^ v w x y z A - - - B k C D E - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . F G H I J K . ^ - L M v - - - - - - ; N O - - - - / P 2 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . Q R S T U V . . . . . . . W 9 9 9 9 X Y ^ - - - - ; Z `  ...> +.@.#.- - - $.%.&.*.=.- - - - - - - - % -.-.-.& - - - - - - - - - ;.-.>.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . ,.'.).).!.~.. . . . . . . . . . . . . . . . . . . {.].9 9 9 ^./.. . . . . . . J 9 9 9 9 H (.^ - - - _.:.<.. . . . . [.}.& - |.1.9 9 9 2.- - - - - - - - 3.. . . 4.- - - - - - - - - 5.. 6.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . . . . . . . . . . . . . . . . . a.b.9 9 9 9 c.K . . . . . . . d.9 9 9 9 b.e.^ - - f.g.. h.i.j.k.l.m.n.o.p.- : q.9 9 9 r.- - - - - - - - s.. . . 5.t.- - - - - - - - 5.. 6.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . . . . . . . . . . . . . . . . . u.9 9 9 v.w.x.y.. . . . . . . z.A.9 9 B.C.. ^ - D.E.. F.G.H.p.- = I.J.K.- - - L.q 9 C M.- - - - - - - N.F.O.5.. P.Q.- - - - - - - - 5.. 6.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . . . . . . . . . . . . . . . . . R.9 9 9 S.T.T.U.. . . . . . . . V.W.S X.U.. ^ - Y.P.. Z.; - - - - - - - - - - `. +.+++- - - - - - - - @+. #+$+%+. &+- - - - - - - - 5.. 6.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . . . . . . . . . . . . . . . . . A.9 9 *+=+. . . . . . . . . . . . . . . . . ^ - -+. O.;+- - - - - - - - - - - - ;.-.>.- - - - - - - ;.>+. ,+'+)+. F.!+- - - - - - - 5.. 6.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . ).~+~+{+,.]+U ^+/+(+_+. . . :+~+<+9 9 [+}+~+K . . . T.0.|+^+1+2+t 3+. . . . ^ - 4+5+. 6+* - - - - - - - - - - - 7+[.8+- - - - - - - 9+0+5+a+- b+. . $ - - - - - - - 5.. 6.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . c+9 9 8.d+e+9 9 9 9 X =+. . x.9 9 9 9 9 9 9 f+. . ]+g+9.h+i+j+k+d l+m+T.. . ^ - n+m.. o+p+q+r+- - - - - - - - - 5.. 6.- - - - - - % s+. 6.D.- t+<.. l.% - - - - - - 5.. 6.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . u+9 9 v+w+9 9 9 9 9 9 x+. . x.9 9 9 9 9 9 9 f+. V y+d z+A+B+C+D+E+H F+G+. . ^ - - H+6.. O.I+J+K+L+- - - - - - - 5.. 6.- - - - - - K.<.. M+- - p.N+. O+P+- - - - - - 5.. 6.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . u+9 9 9 9 Q+R+S+9 9 9 <+0.. T+U+V+9 9 <+W+U+X+. Y+d 9 Z+C+C+C+C+`+ @9 .@+@. ^ - - - @@)+O.. . ' E.#@t.- - - - - 5.. 6.- - - - - - $@. . %@- - - &@*@. =@- - - - - - 5.. 6.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . u+9 9 9 -@;@. >@8.9 9 9 ,@. . . v+9 9 '@)@. . !@Q+9 9 ~@C+C+C+C+C+{@9 9 ]@. ^ - - - - % %@^@/@P.. . (@_@- - - - 5.. 6.- - - - - @.5.. E.t.- - - :@8+. m.<@- - - - - 5.. 6.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . u+9 9 9 [@. . . 2+9 9 9 }@. . . v+9 9 '@)@. . |@9 9 9 B+C+C+C+C+C+1@9 9 2@3@^ - - - - - - - 4@5@>+. . E.6@- - - 5.. 6.- - - - - 7@h.. 8@9@0@0@0@0@a@. n.b@- - - - - 5.. 6.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . u+9 9 9 c@. . . d@9 9 9 e@. . . v+9 9 '@)@. . f@9 9 9 g@C+C+C+C+h@i@9 9 ].Y ^ - - - - - - - - - j@j.. . $@- - - 5.. 6.- - - - p.:.. . . . . . . . . . . k@:@- - - - 5.. 6.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . u+9 9 9 c@. . . d@9 9 9 e@. . . v+9 9 '@)@. . ]@9 9 9 l@m@C+C+C+n@o@9 9 p@Y ^ - - - - - - - - - - q@. . s+- - - 5.. 6.- - - - r@6.. >+a+s@s@s@s@s@t@u@. 6.! - - - - 5.. 6.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . u+9 9 9 c@. . . d@9 9 9 e@. . . v+9 9 '@)@. . v@9 9 9 9 w@x@y@z@<+9 9 9 x.U.^ - - - - - - - - - - _@' . A@- - - 5.. 6.- - - - { . . b+- - - - - - - B@. . C@- - - - 5.. 6.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . u+9 9 9 c@. . . d@9 9 9 e@. . . v+9 9 '@)@. . D@E@9 9 9 9 9 9 9 9 9 9 9 f@. ^ - #.p.- - - - - - p.F@. . G@- - - 5.. 6.- - - p.)+. + H@- - - - - - - n+I@. J@-.- - - 5.. 6.- - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . u+9 9 9 c@. . . d@9 9 9 e@. . . v+9 9 '@)@. . ,.K@9 9 9 9 9 9 9 9 9 9 J +@. ^ - L@=@M@N@- - - D.$ O@. P@Q@- - - 5.. 6.- - - R@0+. S@= - - - - - - - & T@. . &@- - - 5.. U@V@V@V@V@V@V@V@V@6@p.- - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . u+9 9 9 c@. . . d@9 9 9 e@. . . v+9 9 '@)@. . . D@e+9 9 9 9 9 9 9 9 [+G+. . ^ #.W@. %+X@Y@6+7+8+O.. O@3.p.- - - 5.. 6.- - - =@. h...- - - - - - - - - J.O.. Z@p.- - 5.. O.g.g.g.g.g.g.g.g.`@:@- - > . . \",\n \". . > ] . . . . . . . . . . . . . 7.8.9 9 9.0.. . u+9 9 9 c@. . . d@9 9 9 e@. . . v+9 9 '@)@. . . .  #.#9 9 9 9 9 9 S++#T.. . ^ #.s@l.o+. . . . . @#6+##p.- - - - 5.. 6.- - 4@m.. $#H.- - - - - - - - - %#i.. 0+I.- - 5.. . . . . . . . . . ] t.- - > . . \",\n \". . > ] . . . . . . . . . . . . . e.&#*#*#=#-#. . v@*#*#*#;#. . . >#*#*#*#!.. . . d@*#*#,#'#. . . . . ,.!.)#!#~#{#G+~.. . . . ^ - - & D.]#;+s@b@Q.-.#.- - - - - - ^#'+'+- - p./#'+t.- - - - - - - - - - - ^#'+'+#.- - ^#'+'+'+'+'+'+'+'+'+'+^#- - - > . . \",\n \". . > ] . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ^ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ^ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - > . . \",\n \". . > ] . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ^ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - > . . \",\n \". . > 5.. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . a+- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - > . . \",\n \". . H+G./@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@O@E._.- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - H+. . \",\n \". . (#P+_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#P+(#. . \",\n \". . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . \",\n \". . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . \",\n \". . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . \"};\n ");
		commitBuffer();
	}
	this.iface.crearProvinciasEsp();
}

function oficial_crearProvinciasEsp(codPais:String)
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = new FLSqlCursor("provincias");
	var provincias:Array =
			[["ALAVA", "ES", "01"], ["ALBACETE", "ES", "02"], ["ALICANTE", "ES", "03"], ["ALMERIA", "ES", "04"], ["ASTURIAS", "ES", "33"], ["AVILA", "ES", "05"], ["BADAJOZ", "ES", "06"], ["BALEARES", "ES", "07"], ["BARCELONA", "ES", "08"], ["BURGOS", "ES", "09"], ["CACERES", "ES", "10"], ["CADIZ", "ES", "11"], ["CANTABRIA", "ES", "39"], ["CASTELLON", "ES", "12"], ["CIUDAD REAL", "ES", "12"], ["CIUDAD REAL", "ES", "13"], ["CORDOBA", "ES", "14"], ["LA CORUÑA", "ES", "15"], ["CUENCA", "ES", "16"], ["GERONA", "ES", "17"], ["GRANADA", "ES", "18"], ["GUADALAJARA", "ES", "19"], ["GUIPUZCOA", "ES", "20"], ["HUELVA", "ES", "21"], ["HUESCA", "ES", "22"], ["JAEN", "ES", "23"], ["LEON", "ES", "24"], ["LERIDA", "ES", "25"], ["LUGO", "ES", "27"], ["MADRID", "ES", "28"], ["MALAGA", "ES", "29"], ["MURCIA", "ES", "30"], ["NAVARRA", "ES", "31"], ["ORENSE", "ES", "32"], ["PALENCIA", "ES", "34"], ["LAS PALMAS", "ES", "35"], ["PONTEVEDRA", "ES", "36"], ["LA RIOJA", "ES", "26"], ["SALAMANCA", "ES", "37"], ["SEGOVIA", "ES", "40"],["SEVILLA", "ES", "41"], ["SORIA", "ES", "42"], ["TARRAGONA", "ES", "43"], ["SANTA CRUZ DE TENERIFE", "ES", "38"], ["TERUEL", "ES", "44"], ["TOLEDO", "ES", "45"], ["VALENCIA", "ES", "46"], ["VALLADOLID", "ES", "47"], ["VIZCAYA", "ES", "48"], ["ZAMORA", "ES", "49"], ["ZARAGOZA", "ES", "50"]];

	var codPaisProvincia:String;
	for (var i:Number = 0; i < provincias.length; i++) {
		codPaisProvincia = (codPais ? codPais : provincias[i][1]);
		if (util.sqlSelect("provincias", "idprovincia", "codpais = '" + codPaisProvincia + "' AND (UPPER(provincia) = '" + provincias[i][0] + "' OR codigo = '" + provincias[i][2] + "')"  )) {
			continue;
		}
		with(cursor) {
			setModeAccess(cursor.Insert);
			refreshBuffer();
			setValueBuffer("provincia", provincias[i][0]);
			setValueBuffer("codpais", codPaisProvincia);
			setValueBuffer("codigo", provincias[i][2]);
			commitBuffer();
		}
	}
}

function oficial_valorQuery(tablas:String, select:String, from:String, where:String):String
{
	var qry:FLSqlQuery = new FLSqlQuery();
	try { qry.setForwardOnly( true ); } catch (e) {}
	qry.setTablesList(tablas);
	qry.setSelect(select);
	qry.setFrom(from);
	qry.setWhere(where);
	qry.exec();
	if (qry.next())
		return qry.value(0);
	else
		return "";
}

/** \D
Crea una subcuenta contable, si no existe ya la combinación Código de subcuenta - Ejercicio actual
@param	codSubcuenta: Código de la subcuenta a crear
@param	descripcion: Descripción de la subcuenta a crear
@param	idCuentaEsp: Indicador del tipo de cuenta especial (CLIENT = cliente, PROVEE = proveedor)
@param	codEjercicio: Código del ejercicio en el que se va a crear la subcuenta
@return	id de la subcuenta creada o ya existente.
\end */
function oficial_crearSubcuenta(codSubcuenta:String, descripcion:String, idCuentaEsp:String, codEjercicio:String):Number
{
	var util:FLUtil = new FLUtil();

	var datosEmpresa:Array;
	if (!codEjercicio) {
		datosEmpresa["codejercicio"] = this.iface.ejercicioActual();
	} else {
		datosEmpresa["codejercicio"] = codEjercicio;
	}
	datosEmpresa["coddivisa"] = this.iface.valorDefectoEmpresa("coddivisa");

	var longSubcuenta = AQUtil.sqlSelect("ejercicios","longsubcuenta","codejercicio = '" +  datosEmpresa.codejercicio + "'");

	var idSubcuenta:String = util.sqlSelect("co_subcuentas", "idsubcuenta","codsubcuenta = '" + codSubcuenta + "' AND codejercicio = '" + datosEmpresa.codejercicio + "'");
	if (idSubcuenta) {
		return idSubcuenta;
	}

	var codCuenta3:String = codSubcuenta.left(3);
	var codCuenta4:String = codSubcuenta.left(4);
	var cuentaDefecto, otraCuenta;
	if(longSubcuenta >= 10) {
		cuentaDefecto = codCuenta4;
		otraCuenta = codCuenta3;
	}
	else {
		cuentaDefecto = codCuenta3;
		otraCuenta = codCuenta4;
	}

	var datosCuenta:Array = this.iface.ejecutarQry("co_cuentas", "codcuenta,idcuenta",
		"idcuentaesp = '" + idCuentaEsp + "'" +
		" AND codcuenta = '" + cuentaDefecto + "'" +
		" AND codejercicio = '" + datosEmpresa.codejercicio + "' ORDER BY codcuenta");

	if (datosCuenta.result == -1) {
		datosCuenta = this.iface.ejecutarQry("co_cuentas", "codcuenta,idcuenta", "idcuentaesp = '" + idCuentaEsp + "'" + " AND codcuenta = '" + otraCuenta + "'" + " AND codejercicio = '" + datosEmpresa.codejercicio + "' ORDER BY codcuenta");
		if (datosCuenta.result == -1)  {
			return true;
		}
	}

	var curSubcuenta:FLSqlCursor = new FLSqlCursor("co_subcuentas");
	with (curSubcuenta) {
		setModeAccess(curSubcuenta.Insert);
		refreshBuffer();
		setValueBuffer("codsubcuenta", codSubcuenta);
		setValueBuffer("descripcion", descripcion);
		setValueBuffer("idcuenta", datosCuenta.idcuenta);
		setValueBuffer("codcuenta", datosCuenta.codcuenta);
		setValueBuffer("coddivisa", datosEmpresa.coddivisa);
		setValueBuffer("codejercicio", datosEmpresa.codejercicio);
	}
	if (!curSubcuenta.commitBuffer()) {
		return false;
	}

	return curSubcuenta.valueBuffer("idsubcuenta");
}

/** \D Borra una subcuenta contable en el caso de que no existan partidas asociadas
@param	idSubcuenta: Identificador de la subcuenta a borrar
@return	True si no hay error, False en otro caso
\end */
function oficial_borrarSubcuenta(idSubcuenta:Number):Boolean
{
	var util:FLUtil = new FLUtil();
	if (!util.sqlSelect("co_partidas", "idpartida",
		"idsubcuenta = " + idSubcuenta)) {
		var curSubcuenta:FLSqlCursor = new FLSqlCursor("co_subcuentas");
		curSubcuenta.select("idsubcuenta = " + idSubcuenta);
		curSubcuenta.first();
		curSubcuenta.setModeAccess(curSubcuenta.Del);
		curSubcuenta.refreshBuffer();
		if (!curSubcuenta.commitBuffer()) {
			return false;
		}
	}
	return true;
}

/* \D Devuelve el código e id de la subcuenta de cliente según su código
@param codCliente: Código del cliente
@param valoresDefecto: Array con los datos de ejercicio y divisa actuales
@return Los datos componen un vector de tres valores:
error: 0.Sin error 1.Datos no encontrados 2.Error al ejecutar la query
idsubcuenta: Identificador de la subcuenta
codsubcuenta: Código de la subcuenta
\end */
function oficial_datosCtaCliente(codCliente:String, valoresDefecto:Array):Array
{
	/* \C En caso de que el código de cliente sea vacío, la subcuenta de clientes será la primera que depende de la cuenta especial de clientes (generalmente 430...0)
	\end */
	if ( !codCliente || codCliente == "" )
		return flfacturac.iface.pub_datosCtaEspecial("CLIENT", valoresDefecto.codejercicio);

	var util:FLUtil = new FLUtil();
	var ctaCliente:Array = [];
	ctaCliente["codsubcuenta"] = "";
	ctaCliente["idsubcuenta"] = "";
	if (!codCliente.toString().isEmpty()) {
		var qrySubcuenta:FLSqlQuery = new FLSqlQuery();
		try { qrySubcuenta.setForwardOnly( true ); } catch (e) {}
		qrySubcuenta.setTablesList("co_subcuentascli");
		qrySubcuenta.setSelect("idsubcuenta, codsubcuenta");
		qrySubcuenta.setFrom("co_subcuentascli");
		qrySubcuenta.setWhere("codcliente = '" + codCliente + "' AND codejercicio = '" + valoresDefecto.codejercicio + "'");
		if (!qrySubcuenta.exec()) {
			ctaCliente.error = 2;
			return ctaCliente;
		}
		if (!qrySubcuenta.first()) {
			sys.errorMsgBox(sys.translate("No hay ninguna subcuenta asociada al cliente ") + codCliente + sys.translate(" para el ejercicio ") + valoresDefecto.codejercicio + ".\n" + sys.translate("Debe crear la subcuenta en el formulario de clientes."));
			ctaCliente.error = 1;
			return ctaCliente;
		}
		ctaCliente.idsubcuenta = qrySubcuenta.value(0);
		ctaCliente.codsubcuenta = qrySubcuenta.value(1);
	}
	ctaCliente.error = 0;
	return ctaCliente;
}

/* \D Devuelve el código e id de la subcuenta de proveedor según su código
@param codProveedor: Código del proveedor
@param valoresDefecto: Array con los datos de ejercicio y divisa actuales
@return Los datos componen un vector de tres valores:
error: 0.Sin error 1.Datos no encontrados 2.Error al ejecutar la query
idsubcuenta: Identificador de la subcuenta
codsubcuenta: Código de la subcuenta
\end */
function oficial_datosCtaProveedor(codProveedor:String, valoresDefecto:Array):Array
{
	/* \C En caso de que el código de proveedor sea vacío, la subcuenta de proveedores será la primera que depende de la cuenta especial de proveedores (generalmente 400...0)
	\end */
	if ( !codProveedor || codProveedor == "" )
		return flfacturac.iface.pub_datosCtaEspecial("PROVEE", valoresDefecto.codejercicio);

	var util:FLUtil = new FLUtil();
	var ctaProveedor:Array = [];
	ctaProveedor["codsubcuenta"] = "";
	ctaProveedor["idsubcuenta"] = "";
	if (!codProveedor.toString().isEmpty()) {
		var qrySubcuenta:FLSqlQuery = new FLSqlQuery();
		qrySubcuenta.setTablesList("co_subcuentasprov");
		qrySubcuenta.setSelect("idsubcuenta, codsubcuenta");
		qrySubcuenta.setFrom("co_subcuentasprov");
		qrySubcuenta.setWhere("codproveedor = '" + codProveedor + "' AND codejercicio = '" + valoresDefecto.codejercicio + "'");
		if (!qrySubcuenta.exec()) {
			ctaProveedor.error = 1;
			return ctaProveedor;
		}
		if (!qrySubcuenta.first()) {
			sys.errorMsgBox(sys.translate("No hay ninguna subcuenta asociada al proveedor ") + codProveedor + sys.translate(" para el ejercicio ") + valoresDefecto.codejercicio + ".\n" + sys.translate("Debe crear la subcuenta en el formulario de proveedores."));
			ctaProveedor.error = 1;
			return ctaProveedor;
		}
		ctaProveedor.idsubcuenta = qrySubcuenta.value(0);
		ctaProveedor.codsubcuenta = qrySubcuenta.value(1);
	}
	ctaProveedor.error = 0;
	return ctaProveedor;
}

/** \D Calcula la fecha inicial y la fecha final del intervalo
@param	codIntervalo: código del intervalo.
@return	 intervalo: array con las fechas inicial y final del intervalo
\end */
function oficial_calcularIntervalo(codIntervalo:String):Array
{
	var util:FLUtil = new FLUtil();
	var intervalo:Array = [];

	var textoFun = util.sqlSelect("intervalos", "funcionintervalo", "codigo = '" + codIntervalo + "'");
	if (textoFun) {
		try {
			var funcionVal = new Function(textoFun);
			var resultado = funcionVal();
			if (resultado) {
				return resultado;
			}
		} catch(e) {
			sys.warnMsgBox(sys.translate("Error en la función de intervalo %1: ").arg(codIntervalo) + e);
			return false;
		}
	}

	intervalo["desde"] = false;
	intervalo["hasta"] = false;

	var fechaDesde:Date = new Date();
	var fechaHasta:Date = new Date();
	var mes:Number;
	var anio:Number;

	switch(codIntervalo) {
		case "000001": {
			intervalo.desde = fechaDesde;
			intervalo.hasta = fechaHasta;
			break;
		}

		case "000002": {
			intervalo.desde = util.addDays(fechaDesde,-1);
			intervalo.hasta = util.addDays(fechaHasta,-1);
			break;
		}

		case "000003": {
			var dias:Number = fechaDesde.getDay() -1;
			dias = dias * -1;
			intervalo.desde = util.addDays(fechaDesde, dias);
			intervalo.hasta = util.addDays(intervalo.desde,6);
			break;
		}

		case "000004": {
			var dias:Number = fechaHasta.getDay() -1;
			dias = dias * -1;
			intervalo.hasta = util.addDays(fechaHasta, dias -1);
			intervalo.desde = util.addDays(intervalo.hasta,-6);
			break;
		}

		case "000005": {
			mes = fechaDesde.getMonth();
			fechaDesde.setDate(1);
			intervalo.desde = fechaDesde;
			fechaHasta.setDate(1);
			fechaHasta = util.addMonths(fechaHasta, 1);;
			fechaHasta = util.addDays(fechaHasta,-1);
			intervalo.hasta = fechaHasta;
			break;
		}

		case "000006": {
			fechaDesde.setDate(1);
			fechaDesde = util.addMonths(fechaDesde, -1);
			intervalo.desde = fechaDesde;
			fechaHasta.setDate(1);
			fechaHasta = util.addDays(fechaHasta,-1);
			intervalo.hasta = fechaHasta;
			break;
		}

		case "000007": {
			fechaDesde.setDate(1);
			fechaDesde.setMonth(1);
			intervalo.desde = fechaDesde;
			fechaHasta.setMonth(12)
			fechaHasta.setDate(31);
			intervalo.hasta = fechaHasta;
			break;
		}

		case "000008": {
			anio = fechaDesde.getYear() - 1;
			fechaDesde.setDate(1);
			fechaDesde.setMonth(1);
			fechaDesde.setYear(anio);
			intervalo.desde = fechaDesde;
			fechaHasta.setMonth(12);
			fechaHasta.setDate(31);
			fechaHasta.setYear(anio);
			intervalo.hasta = fechaHasta;
			break;
		}

		case "000009": {
			intervalo.desde = "1970-01-01";
			intervalo.hasta = "3000-01-01";
			break;
		}

		case "000010": {
			intervalo.desde = "1970-01-01";
			intervalo.hasta = fechaHasta;
			break;
		}
	}
	return intervalo;
}

/** \D
Crea una subcuenta contable, si no existe ya la combinación Código de subcuenta - Ejercicio actual
@param	codSubcuenta: Código de la subcuenta a crear
@param	idSubcuenta: Identificador de la subcuenta a crear
@param	codCliente: Cliente para el que se crea la subcuenta
@param	codEjercicio: Código del ejercicio en el que se va a crear la subcuenta
@return	Verdadero si no hay error, Falso en otro caso
\end */
function oficial_crearSubcuentaCli(codSubcuenta:String, idSubcuenta:Number, codCliente:String, codEjercicio:String):Boolean
{
	var curSubcuentaCli:FLSqlCursor = new FLSqlCursor("co_subcuentascli");
	with (curSubcuentaCli) {
		setModeAccess(curSubcuentaCli.Insert);
		refreshBuffer();
		setValueBuffer("codsubcuenta", codSubcuenta);
		setValueBuffer("idSubcuenta", idSubcuenta);
		setValueBuffer("codcliente", codCliente);
		setValueBuffer("codejercicio", codEjercicio);
	}
	if (!curSubcuentaCli.commitBuffer())
		return false;

	return true;
}

/** \D
Crea una subcuenta contable, si no existe ya la combinación Código de subcuenta - Ejercicio actual
@param	codSubcuenta: Código de la subcuenta a crear
@param	idSubcuenta: Identificador de la subcuenta a crear
@param	codProveedor: Proveedor para el que se crea la subcuenta
@param	codEjercicio: Código del ejercicio en el que se va a crear la subcuenta
@return	Verdadero si no hay error, Falso en otro caso
\end */
function oficial_crearSubcuentaProv(codSubcuenta:String, idSubcuenta:Number, codProveedor:String, codEjercicio:String):Boolean
{
	var curSubcuentaProv:FLSqlCursor = new FLSqlCursor("co_subcuentasprov");
	with (curSubcuentaProv) {
		setModeAccess(curSubcuentaProv.Insert);
		refreshBuffer();
		setValueBuffer("codsubcuenta", codSubcuenta);
		setValueBuffer("idSubcuenta", idSubcuenta);
		setValueBuffer("codproveedor", codProveedor);
		setValueBuffer("codejercicio", codEjercicio);
	}
	if (!curSubcuentaProv.commitBuffer())
		return false;

	return true;
}

/** \D Crea las subcuentas  asociadas a un cliente que todavía no existen en los ejercicios con plan general contable
@param codCliente: Código de cliente
@param codSubcuenta: Código de subcuenta
@param nombre: Nombre del cliente
@return True si la generación de subcuentas finaliza correctamente, falso en caso contrario
*/
function oficial_rellenarSubcuentasCli(codCliente:String, codSubcuenta:String, nombre:String):Boolean
{
	if (!sys.isLoadedModule("flcontppal"))
		return true;
	if (!codSubcuenta)
		return true;

	var util:FLUtil = new FLUtil;
	var qry:FLSqlQuery = new FLSqlQuery();
	qry.setTablesList("ejercicios,co_subcuentascli");
	qry.setSelect("e.codejercicio");
	qry.setFrom("ejercicios e LEFT OUTER JOIN co_subcuentascli s ON e.codejercicio = s.codejercicio AND s.codcliente = '" + codCliente + "'");
	qry.setWhere("s.id IS NULL AND e.estado = 'ABIERTO'");
	if (!qry.exec())
		return false;

	var idSubcuenta:Number;
	var codEjercicio:String;
	while (qry.next()) {
		codEjercicio = qry.value(0);
		if (!util.sqlSelect("co_epigrafes", "codepigrafe", "codejercicio = '" + codEjercicio + "'"))
			continue;
		idSubcuenta = this.iface.crearSubcuenta(codSubcuenta, nombre, "CLIENT", codEjercicio);
		if (!idSubcuenta)
			return false;

		if (idSubcuenta == true)
			continue;

		if (!this.iface.crearSubcuentaCli(codSubcuenta, idSubcuenta, codCliente, codEjercicio))
			return false;
	}

	return true;
}

/** \D Crea las subcuentas  asociadas a un proveedor que todavía no existen en los ejercicios con plan general contable
@param codProveedor: Código de proveedor
@param codSubcuenta: Código de subcuenta
@param nombre: Nombre del proveedor
@return True si la generación de subcuentas finaliza correctamente, falso en caso contrario
*/
function oficial_rellenarSubcuentasProv(codProveedor:String, codSubcuenta:String, nombre:String):Boolean
{
	if (!sys.isLoadedModule("flcontppal")) {
		return;
	}

	var util:FLUtil = new FLUtil;
	var qry:FLSqlQuery = new FLSqlQuery();
	qry.setTablesList("ejercicios,co_subcuentasprov");
	qry.setSelect("e.codejercicio");
	qry.setFrom("ejercicios e LEFT OUTER JOIN co_subcuentasprov s ON e.codejercicio = s.codejercicio AND s.codproveedor = '" + codProveedor + "'");
	qry.setWhere("s.id IS NULL AND e.estado = 'ABIERTO'");
	if (!qry.exec())
		return false;

	var idSubcuenta:Number;
	var codEjercicio:String;
	while (qry.next()) {
		codEjercicio = qry.value(0);
		if (!util.sqlSelect("co_epigrafes", "codepigrafe", "codejercicio = '" + codEjercicio + "'"))
			continue;
		idSubcuenta = this.iface.crearSubcuenta(codSubcuenta, nombre, "PROVEE", codEjercicio);
		if (!idSubcuenta)
			return false;

		if (idSubcuenta == true)
			continue;

		if (!this.iface.crearSubcuentaProv(codSubcuenta, idSubcuenta, codProveedor, codEjercicio))
			return false;
	}

	return true;
}

/** \D Indica si el módulo de autómata está instalado y activado
@return	true si está activado, false en caso contrario
\end */
function oficial_automataActivado():Boolean
{
	if (!sys.isLoadedModule("flautomata"))
		return false;

	if (formau_automata.iface.pub_activado())
		return true;

	return false;
}


/** \D Indica si el cliente está activo (no está de baja) para la fecha especificada
@param	codCliente: Código de cliente
@param	fecha: Fecha a considerar
@return	true si está activo, false en caso contrario o si hay error
\end */
function oficial_clienteActivo(codCliente:String, fecha:String):Boolean
{
	var util:FLUtil = new FLUtil;
	if (!codCliente || codCliente == "")
		return true;

	var qryBaja:FLSqlQuery = new FLSqlQuery();
	qryBaja.setTablesList("clientes");
	qryBaja.setSelect("debaja, fechabaja");
	qryBaja.setFrom("clientes");
	qryBaja.setWhere("codcliente = '" + codCliente + "'");
	qryBaja.setForwardOnly(true);
	if (!qryBaja.exec())
		return false;

	if (!qryBaja.first())
		return false;

	if (!qryBaja.value("debaja"))
		return true;

	if (util.daysTo(fecha, qryBaja.value("fechabaja")) <= 0) {
		if (!this.iface.automataActivado()) {
			var fechaDdMmAaaa:String = util.dateAMDtoDMA(fecha);
			sys.warnMsgBox(sys.translate("El cliente está de baja para la fecha especificada (%1)").arg(fechaDdMmAaaa));
		}
		return false;
	}
	return true;
}

/** \D Autocompleta la provincia cuando el usuario pulsa . u ofrece la lista de provincias que comienzan por el valor actual del campo para que el usuario elija
@param	formulario	Formulario que contiene el campo de provincia
@param	campoId Campo del id de provincia en base de datos
@param	campoProvincia Campo del valor de la provincia en base de datos
@param	campoPais Campo del código de país en base de datos
\end */
function oficial_obtenerProvincia(formulario:Object, campoId:String, campoProvincia:String, campoPais:String)
{
	var util:FLUtil = new FLUtil;
	if (!campoId)
		campoId = "idprovincia";

	if (!campoProvincia)
		campoProvincia = "provincia";

	if (!campoPais)
		campoPais = "codpais";

	var provincia:String = formulario.cursor().valueBuffer(campoProvincia);
	if (!provincia || provincia == "") {
		return;
	}
	if (provincia.endsWith(".")) {
		formulario.cursor().setNull(campoId);
		//provincia = util.utf8(provincia);

		provincia = provincia.left(provincia.length - 1);
		provincia = provincia.toUpperCase();

		var where:String = "UPPER(provincia) LIKE '" + provincia + "%'";
		var codPais:String = formulario.cursor().valueBuffer(campoPais);
		if (codPais && codPais != "")
			where += " AND codpais = '" + codPais + "'";

		var qryProvincia:FLSqlQuery = new FLSqlQuery;
		with (qryProvincia) {
			setTablesList("provincias");
			setSelect("idprovincia");
			setFrom("provincias");
			setForwardOnly(true);
		}
		qryProvincia.setWhere(where);

		if (!qryProvincia.exec())
			return false;

		switch (qryProvincia.size()) {
			case 0: {
				return;
			}
			case 1: {
				if (!qryProvincia.first()) {
					return false;
				}
				formulario.cursor().setValueBuffer(campoId, qryProvincia.value("idprovincia"));
				break;
			}
			default: {
				var listaProvincias:String = "";
				while (qryProvincia.next()) {
					if (listaProvincias != "")
						listaProvincias += ", ";
					listaProvincias += qryProvincia.value("idprovincia");
				}
				var f:Object = new FLFormSearchDB("provincias");
				var curProvincias:FLSqlCursor = f.cursor();
				curProvincias.setMainFilter("idprovincia IN (" + listaProvincias + ")");

				f.setMainWidget();
				var idProvincia:String = f.exec("idprovincia");

				if (idProvincia)
					formulario.cursor().setValueBuffer(campoId, idProvincia);
				break;
			}
		}
	}
}


function oficial_actualizarContactos20070525():Boolean
{
	var util:FLUtil;

	var qryClientes:FLSqlQuery = new FLSqlQuery();
	qryClientes.setTablesList("clientes");
	qryClientes.setFrom("clientes");
	qryClientes.setSelect("codcliente,codcontacto,contacto");
	qryClientes.setWhere("");
	if (!qryClientes.exec())
		return false;

	_i.creaDialogoProgreso(sys.translate("Reorganizando Contactos"), qryClientes.size());
	util.setProgress(0);

	var cont:Number = 1;

	while (qryClientes.next()) {
		util.setProgress(cont);
		cont += 1;
		var codCliente:String = qryClientes.value("codcliente");

		if(!codCliente) {
			util.destroyProgressDialog();
			return false;
		}

		var qryAgenda:FLSqlQuery = new FLSqlQuery();
		qryAgenda.setTablesList("contactosclientes");
		qryAgenda.setFrom("contactosclientes");
		qryAgenda.setSelect("contacto,cargo,telefono,fax,email,id,codcliente");
		qryAgenda.setWhere("codcliente = '" + codCliente + "'");
		if (!qryAgenda.exec()) {
			util.destroyProgressDialog();
			return false;
		}

		if (sys.isLoadedModule("flcrm_ppal")) {
			var qryClientesContactos:FLSqlQuery = new FLSqlQuery();
			qryClientesContactos.setTablesList("crm_clientescontactos");
			qryClientesContactos.setFrom("crm_clientescontactos");
			qryClientesContactos.setSelect("codcontacto");
			qryClientesContactos.setWhere("codcliente = '" + codCliente + "' AND codcontacto NOT IN(SELECT codcontacto FROM contactosclientes WHERE codcliente = '" + codCliente + "')");
			if (!qryClientesContactos.exec()) {
				util.destroyProgressDialog();
				return false;
			}


			while (qryClientesContactos.next())
				this.iface.actualizarContactosDeAgenda20070525(codCliente,qryClientesContactos.value("codcontacto"));
		}

		while (qryAgenda.next()) {
			var nombreCon:String = qryAgenda.value("contacto");
			var cargoCon:String = qryAgenda.value("cargo");
			var telefonoCon:String = qryAgenda.value("telefono");
			var faxCon:String = qryAgenda.value("fax");
			var emailCon:String = qryAgenda.value("email");
			var idAgenda:Number = qryAgenda.value("id");
			if (!idAgenda || idAgenda == 0) {
				util.destroyProgressDialog();
				return false;
			}

			var qryContactos:FLSqlQuery = new FLSqlQuery();
			qryContactos.setTablesList("crm_contactos,contactosclientes");
			qryContactos.setFrom("crm_contactos INNER JOIN contactosclientes ON crm_contactos.codcontacto = contactosclientes.codcontacto");
			qryContactos.setSelect("crm_contactos.codcontacto");
			qryContactos.setWhere("crm_contactos.nombre = '" + nombreCon + "' AND (contactosclientes.codcliente = '" + codCliente + "' AND (crm_contactos.email = '" + emailCon + "' AND crm_contactos.telefono1 = '" + telefonoCon + "'))");
			if (!qryContactos.exec()) {
				util.destroyProgressDialog();
				return false;
			}

			var codContacto:String = "";

			if (qryContactos.first())
				codContacto = qryContactos.value("crm_contactos.codcontacto");

			if(!this.iface.actualizarContactosDeAgenda20070525(codCliente,codContacto,nombreCon,cargoCon,telefonoCon,faxCon,emailCon,idAgenda)) {
				util.destroyProgressDialog();
				return false;
			}
		}

		if ((qryClientes.value("contacto") && qryClientes.value("contacto") != "") && (!qryClientes.value("codcontacto") || qryClientes.value("codcontacto") == "")) {
				codContacto = util.sqlSelect("crm_contactos", "codcontacto", "nombre = '" +  this.iface.escapeQuote(qryClientes.value("contacto")) + "'");
				if (codContacto)
					this.iface.actualizarContactosDeAgenda20070525(codCliente,codContacto,qryClientes.value("contacto"));
				else
					codContacto = this.iface.actualizarContactosDeAgenda20070525(codCliente,"",qryClientes.value("contacto"));

				if(!codContacto) {
					util.destroyProgressDialog();
					return false;
				}

				var curCliente:FLSqlCursor = new FLSqlCursor("clientes");
				curCliente.select("codcliente = '" + codCliente + "'");
				curCliente.setModeAccess(curCliente.Edit);
				if (!curCliente.first()) {
					util.destroyProgressDialog();
					return false;
				}
				curCliente.refreshBuffer();
				curCliente.setValueBuffer("codcontacto", codContacto);

				if (!curCliente.commitBuffer()) {
					util.destroyProgressDialog();
					return false;
				}
		}
	}
	util.setProgress(qryClientes.size());
	util.destroyProgressDialog();
	return true;
}

function oficial_actualizarContactosProv20070702():Boolean
{
	var util:FLUtil;

	var qryProveedores:FLSqlQuery = new FLSqlQuery();
	qryProveedores.setTablesList("proveedores");
	qryProveedores.setFrom("proveedores");
	qryProveedores.setSelect("codproveedor,codcontacto,contacto");
	qryProveedores.setWhere("");
	if (!qryProveedores.exec())
		return false;

	_i.creaDialogoProgreso(sys.translate("Reorganizando Contactos"), qryProveedores.size());
	util.setProgress(0);

	var cont:Number = 1;

	while (qryProveedores.next()) {
		util.setProgress(cont);
		cont += 1;
		var codProveedor:String = qryProveedores.value("codproveedor");

		if(!codProveedor) {
			util.destroyProgressDialog();
			return false;
		}

		var qryAgenda:FLSqlQuery = new FLSqlQuery();
		qryAgenda.setTablesList("contactosproveedores");
		qryAgenda.setFrom("contactosproveedores");
		qryAgenda.setSelect("contacto,cargo,telefono,fax,email,id,codproveedor");
		qryAgenda.setWhere("codproveedor = '" + codProveedor + "'");
		if (!qryAgenda.exec()) {
			util.destroyProgressDialog();
			return false;
		}

		while (qryAgenda.next()) {
			var nombreCon:String = qryAgenda.value("contacto");
			var cargoCon:String = qryAgenda.value("cargo");
			var telefonoCon:String = qryAgenda.value("telefono");
			var faxCon:String = qryAgenda.value("fax");
			var emailCon:String = qryAgenda.value("email");
			var idAgenda:Number = qryAgenda.value("id");
			if (!idAgenda || idAgenda == 0) {
				util.destroyProgressDialog();
				return false;
			}

			var qryContactos:FLSqlQuery = new FLSqlQuery();
			qryContactos.setTablesList("crm_contactos,contactosproveedores");
			qryContactos.setFrom("crm_contactos INNER JOIN contactosproveedores ON crm_contactos.codcontacto = contactosproveedores.codcontacto");
			qryContactos.setSelect("crm_contactos.codcontacto");
			qryContactos.setWhere("crm_contactos.nombre = '" + nombreCon + "' AND (contactosproveedores.codproveedor = '" + codProveedor + "' AND (crm_contactos.email = '" + emailCon + "' AND crm_contactos.telefono1 = '" + telefonoCon + "'))");
			if (!qryContactos.exec()) {
				util.destroyProgressDialog();
				return false;
			}

			var codContacto:String = "";

			if (qryContactos.first())
				codContacto = qryContactos.value("crm_contactos.codcontacto");

			if(!this.iface.actualizarContactosDeAgendaProv20070702(codProveedor,codContacto,nombreCon,cargoCon,telefonoCon,faxCon,emailCon,idAgenda)) {
				util.destroyProgressDialog();
				return false;
			}
		}

		if ((qryProveedores.value("contacto") && qryProveedores.value("contacto") != "") && (!qryProveedores.value("codcontacto") || qryProveedores.value("codcontacto") == "")) {
				codContacto = util.sqlSelect("crm_contactos", "codcontacto", "nombre = '" + qryProveedores.value("contacto") + "'");
				if (codContacto)
					this.iface.actualizarContactosDeAgendaProv20070702(codProveedor,codContacto,qryProveedores.value("contacto"));
				else
					codContacto = this.iface.actualizarContactosDeAgendaProv20070702(codProveedor,"",qryProveedores.value("contacto"));

				if(!codContacto) {
					util.destroyProgressDialog();
					return false;
				}

				var curProveedor:FLSqlCursor = new FLSqlCursor("proveedores");
				curProveedor.select("codproveedor = '" + codProveedor + "'");
				curProveedor.setModeAccess(curProveedor.Edit);
				if (!curProveedor.first()) {
					util.destroyProgressDialog();
					return false;
				}
				curProveedor.refreshBuffer();
				curProveedor.setValueBuffer("codcontacto", codContacto);

				if (!curProveedor.commitBuffer()) {
					util.destroyProgressDialog();
					return false;
				}
		}
	}
	util.setProgress(qryProveedores.size());
	util.destroyProgressDialog();
	return true;
}

function oficial_actualizarContactosDeAgenda20070525(codCliente:String,codContacto:String,nombreCon:String,cargoCon:String,telefonoCon:String,faxCon:String,emailCon:String,idAgenda:Number):String {

	var util:FLUtil;
	var curContactos:FLSqlCursor = new FLSqlCursor("crm_contactos");
	var curAgenda:FLSqlCursor = new FLSqlCursor("contactosclientes");

	if (codContacto && codContacto != "") {
		curContactos.select("codcontacto = '" + codContacto + "'");
		if (!curContactos.first())
			return false;
		curContactos.setModeAccess(curContactos.Edit);
		curContactos.refreshBuffer();
		if (!curContactos.valueBuffer("cargo") || curContactos.valueBuffer("cargo") == "") {
			curContactos.setValueBuffer("cargo", cargoCon);
		}

		if (!curContactos.valueBuffer("telefono1") || curContactos.valueBuffer("telefono1") == "") {
			curContactos.setValueBuffer("telefono1", telefonoCon);
		}
		else {
			if (!curContactos.valueBuffer("telefono2") || 		curContactos.valueBuffer("telefono2") == "") {
				curContactos.setValueBuffer("telefono2", telefonoCon);
			}
		}
		if (!curContactos.valueBuffer("fax") || curContactos.valueBuffer("fax") == "") {
			curContactos.setValueBuffer("fax", faxCon);
		}
		if (!curContactos.valueBuffer("email") || curContactos.valueBuffer("email") == "") {
			curContactos.setValueBuffer("email", emailCon);
		}
	}
	else {
		with (curContactos) {
			setModeAccess(Insert);
			refreshBuffer();
			setValueBuffer("codcontacto", util.nextCounter("codcontacto", this));
			setValueBuffer("nombre",nombreCon);
			setValueBuffer("email",emailCon);
			setValueBuffer("telefono1",telefonoCon);
			setValueBuffer("cargo",cargoCon);
			setValueBuffer("fax",faxCon);
		}

		if (!curContactos.commitBuffer())
			return false;

		codContacto = curContactos.valueBuffer("codcontacto");
		if(!codContacto)
			return false;
	}
	if (!idAgenda || idAgenda == 0) {
		if (!util.sqlSelect("contactosclientes","id","codcontacto = '" + codContacto + "' AND codcliente = '" + codCliente + "'")) {
			curAgenda.setModeAccess(curAgenda.Insert);
			curAgenda.refreshBuffer();
			curAgenda.setValueBuffer("codcliente",codCliente);
			curAgenda.setValueBuffer("codcontacto",codContacto);
			if (!curAgenda.commitBuffer())
				return false;
		}
	}
	else {
		curAgenda.select("id = " + idAgenda);
		if (!curAgenda.first())
			return false;
		curAgenda.setModeAccess(curAgenda.Edit);
		curAgenda.refreshBuffer();
		curAgenda.setValueBuffer("codcontacto",codContacto);
		if (!curAgenda.commitBuffer())
			return false;
	}



	return codContacto;
}

function oficial_lanzarEvento(cursor, evento)
{
	if (!sys.isLoadedModule("flcolaproc")) {
		return true;
	}
	var datosEvento:Array = [];
	datosEvento["tipoobjeto"] = cursor.table();
	datosEvento["idobjeto"] = cursor.valueBuffer(cursor.primaryKey());
	datosEvento["evento"] = evento;
	if (!flcolaproc.iface.pub_procesarEvento(datosEvento))
		return false;

	return true;
}

function oficial_actualizarContactosDeAgendaProv20070702(codProveedor:String,codContacto:String,nombreCon:String,cargoCon:String,telefonoCon:String,faxCon:String,emailCon:String,idAgenda:Number):String
{
	var util:FLUtil;
	var curContactos:FLSqlCursor = new FLSqlCursor("crm_contactos");
	var curAgenda:FLSqlCursor = new FLSqlCursor("contactosproveedores");

	if (codContacto && codContacto != "") {
		curContactos.select("codcontacto = '" + codContacto + "'");
		if (!curContactos.first())
			return false;
		curContactos.setModeAccess(curContactos.Edit);
		curContactos.refreshBuffer();
		if (!curContactos.valueBuffer("cargo") || curContactos.valueBuffer("cargo") == "") {
			curContactos.setValueBuffer("cargo", cargoCon);
		}

		if (!curContactos.valueBuffer("telefono1") || curContactos.valueBuffer("telefono1") == "") {
			curContactos.setValueBuffer("telefono1", telefonoCon);
		}
		else {
			if (!curContactos.valueBuffer("telefono2") || 		curContactos.valueBuffer("telefono2") == "") {
				curContactos.setValueBuffer("telefono2", telefonoCon);
			}
		}
		if (!curContactos.valueBuffer("fax") || curContactos.valueBuffer("fax") == "") {
			curContactos.setValueBuffer("fax", faxCon);
		}
		if (!curContactos.valueBuffer("email") || curContactos.valueBuffer("email") == "") {
			curContactos.setValueBuffer("email", emailCon);
		}
	}
	else {
		with (curContactos) {
			setModeAccess(Insert);
			refreshBuffer();
			setValueBuffer("codcontacto", util.nextCounter("codcontacto", this));
			setValueBuffer("nombre",nombreCon);
			setValueBuffer("email",emailCon);
			setValueBuffer("telefono1",telefonoCon);
			setValueBuffer("cargo",cargoCon);
			setValueBuffer("fax",faxCon);
		}

		if (!curContactos.commitBuffer())
			return false;

		codContacto = curContactos.valueBuffer("codcontacto");
		if(!codContacto)
			return false;
	}
	if (!idAgenda || idAgenda == 0) {
		if (!util.sqlSelect("contactosproveedores","id","codcontacto = '" + codContacto + "' AND codproveedor = '" + codProveedor + "'")) {
			curAgenda.setModeAccess(curAgenda.Insert);
			curAgenda.refreshBuffer();
			curAgenda.setValueBuffer("codproveedor",codProveedor);
			curAgenda.setValueBuffer("codcontacto",codContacto);
			if (!curAgenda.commitBuffer())
				return false;
		}
	}
	else {
		curAgenda.select("id = " + idAgenda);
		if (!curAgenda.first())
			return false;
		curAgenda.setModeAccess(curAgenda.Edit);
		curAgenda.refreshBuffer();
		curAgenda.setValueBuffer("codcontacto",codContacto);
		if (!curAgenda.commitBuffer())
			return false;
	}



	return codContacto;
}

/** \D
Da a elegir al usuario entre una serie de opciones
@param	opciones: Array con las n opciones a elegir
@return	El índice de la opción elegida si se pulsa Aceptar
		-1 si se pulsa Cancelar
		-2 si hay error
\end */
function oficial_elegirOpcion(opciones:Array, titulo:String):Number
{
	var util:FLUtil = new FLUtil();
	var dialog:Dialog = new Dialog;
	dialog.okButtonText = sys.translate("Aceptar");
	dialog.cancelButtonText = sys.translate("Cancelar");
	dialog.title = titulo;
	var bgroup:GroupBox = new GroupBox;
	dialog.add(bgroup);
	var rB:Array = [];
	for (var i:Number = 0; i < opciones.length; i++) {
		rB[i] = new RadioButton;
		bgroup.add(rB[i]);
		rB[i].text = opciones[i];
		if (i == 0) {
			rB[i].checked = true;
		} else {
			rB[i].checked = false;
		}
		if ((i + 1) % 25 == 0) {
			bgroup.newColumn();
		}
	}

	if (dialog.exec()) {
		for (var i:Number = 0; i < opciones.length; i++) {
			if (rB[i].checked == true) {
				return i;
			}
		}
	} else {
		return -1;
	}
}

/** \D Pasa a formato de texto una fecha
@param fecha: Fecha en formato en formato AAAA-MM-DD...
\end */
function oficial_textoFecha(fecha:String):String
{
	var util:FLUtil;
	if (!fecha || fecha == "") {
		return "";
	}
	var mes:String = fecha.mid(5, 2);
	var textoMes:String;
	switch (mes) {
		case "01": { textoMes = sys.translate("Enero"); break; }
		case "02": { textoMes = sys.translate("Febrero"); break; }
		case "03": { textoMes = sys.translate("Marzo"); break; }
		case "04": { textoMes = sys.translate("Abril"); break; }
		case "05": { textoMes = sys.translate("Mayo"); break; }
		case "06": { textoMes = sys.translate("Junio"); break; }
		case "07": { textoMes = sys.translate("Julio"); break; }
		case "08": { textoMes = sys.translate("Agosto"); break; }
		case "09": { textoMes = sys.translate("Septiembre"); break; }
		case "10": { textoMes = sys.translate("Octubre"); break; }
		case "11": { textoMes = sys.translate("Noviembre"); break; }
		case "12": { textoMes = sys.translate("Diciembre"); break; }
	}
	var dia:String = parseInt(fecha.mid(8, 2));
	var ano:String = parseInt(fecha.mid(0, 4));
	var texto:String = sys.translate("%1 de %2 de %3").arg(dia.toString()).arg(textoMes).arg(ano);
	return texto;
}

function oficial_validarNifIva(nifIva:String):String
{
	var util:FLUtil = new FLUtil;
	var error:String;
	if (!nifIva || nifIva == "") {
		error = sys.translate("No se ha establecido el NIF/IVA");
		return error;
	}
	var codPais:String = nifIva.left(2);
	var pais:String;
	var longPosibles:Array;
	switch (codPais) {
		case "DE": {
			longPosibles = [9];
			pais = sys.translate("Alemania");
			break;
		}
		case "AT": {
			longPosibles = [9];
			pais = sys.translate("Austria");
			break;
		}
		case "BE": {
			longPosibles = [9, 10];
			pais = sys.translate("Bélgica");
			break;
		}
		case "BG": {
			longPosibles = [9, 10];
			pais = sys.translate("Bulgaria");
			break;
		}
		case "CY": {
			longPosibles = [9];
			pais = sys.translate("Chipre");
			break;
		}
		case "CZ": {
			longPosibles = [9];
			pais = sys.translate("Chequia");
			break;
		}
		case "DK": {
			longPosibles = [8];
			pais = sys.translate("Dinamarca");
			break;
		}
		case "EE": {
			longPosibles = [9];
			pais = sys.translate("Estonia");
			break;
		}
		case "FI": {
			longPosibles = [8];
			pais = sys.translate("Finlandia");
			break;
		}
		case "FR": {
			longPosibles = [11];
			pais = sys.translate("Francia");
			break;
		}
		case "EL": {
			longPosibles = [9];
			pais = sys.translate("Grecia");
			break;
		}
		case "GB": {
			longPosibles = [5, 9, 12];
			pais = sys.translate("Gran Bretaña");
			break;
		}
		case "NL": {
			longPosibles = [12];
			pais = sys.translate("Holanda");
			break;
		}
		case "HU": {
			longPosibles = [8];
			pais = sys.translate("Hungría");
			break;
		}
		case "IT": {
			longPosibles = [11];
			pais = sys.translate("Gran Bretaña");
			break;
		}
		case "IE": {
			longPosibles = [8];
			pais = sys.translate("Irlanda");
			break;
		}
		case "LT": {
			longPosibles = [9, 12];
			pais = sys.translate("Lituania");
			break;
		}
		case "LU": {
			longPosibles = [8];
			pais = sys.translate("Luxemburgo");
			break;
		}
		case "PL": {
			longPosibles = [10];
			pais = sys.translate("Polonia");
			break;
		}
		case "PT": {
			longPosibles = [9];
			pais = sys.translate("Portugal");
			break;
		}
		case "RO": {
			longPosibles = [2, 3, 4, 5, 6, 7, 8, 9, 10];
			pais = sys.translate("Rumanía");
			break;
		}
		case "SE": {
			longPosibles = [12];
			pais = sys.translate("Suecia");
			break;
		}
		case "SI": {
			longPosibles = [8];
			pais = sys.translate("Eslovenia");
			break;
		}
		case "SK": {
			longPosibles = [10];
			pais = sys.translate("Eslovaquia");
			break;
		}
		case "MT": {
			longPosibles = [8];
			pais = sys.translate("Malta");
			break;
		}
		default: {
			error = sys.translate("El código de país %1 no es correcto").arg(codPais);
			return error;
		}
	}
	var longOk:Boolean = false;
	var longitud:Number = nifIva.length - 2;
	for (var i:Number = 0; i < longPosibles.length; i++) {
		if (longitud == longPosibles[i]) {
			longOk = true;
		}
	}
	if (!longOk) {
		var longTotales:Array = new Array(longPosibles.length);
		for (var i:Number = 0; i < longPosibles.length; i++) longTotales[i] = longPosibles[i] + 2;
		error = sys.translate("Error en la validación del NIF/IVA %1 para el país %2:\nLas longitudes admitidas son: %3").arg(nifIva).arg(pais).arg(longTotales.join(", "));
		return error;
	}
	return "OK";
}

/** \D
Ejecuta un comando externo de forma asíncrona
@param	comando: Comando a ejecutar
@return	Array con dos datos:
	ok: True si no hay error, false en caso contrario
	salida: Mensaje de stdout o stderr obtenido
\end */
function oficial_ejecutarComandoAsincrono(comando:String):Array
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

/** \D Función que se ejecuta al lanzarse la aplicación si está correctamente establecido el setting local application/callFunction
\end */
function oficial_globalInit()
{
	if (sys.isLoadedModule("flcolaproc")) {
		try {
			flcolaproc.iface.pub_globalInit();
		} catch (e) {}
	}

	if (sys.isLoadedModule("flcolamens")) {
		try {
			flcolamens.iface.pub_globalInit();
		} catch (e) {}
	}
}

function oficial_existeEnvioMail():Boolean
{
	return false;
}

/** \D si el país de la dirección indicada tiene activado el indicador de validación de sus provincias, se comprueba que la provincia y el país son válidos, informando si es necesario el campo idprovincia
@param cursor: Cursor de la tabla que contiene la dirección
@param mtd: Metadatos sobre los campos
@return False si la provincia no es correcta, true si lo es.
\end */
function oficial_validarProvincia(cursor:FLSqlCursor, mtd:Array):Boolean
{
	var util:FLUtil = new FLUtil();
	if (!mtd) {
		mtd = [];
		mtd["idprovincia"] = "idprovincia";
		mtd["provincia"] = "provincia";
		mtd["codpais"] = "codpais";
	}
	var idProvincia:String = cursor.valueBuffer(mtd["idprovincia"]);
	var provincia:String = cursor.valueBuffer(mtd["provincia"]);
	var codPais:String = cursor.valueBuffer(mtd["codpais"]);

	if (util.sqlSelect("paises", "validarprov", "codpais = '" + codPais + "'")) {
		if (!idProvincia || idProvincia == "") {
			idProvincia = false;
			if (provincia && provincia != "" && provincia != undefined) {
				idProvincia = util.sqlSelect("provincias", "idprovincia", "UPPER(provincia) = '" + provincia.toUpperCase() + "' AND codpais = '" + codPais + "'");
				if (idProvincia) {
					cursor.setValueBuffer(mtd["idprovincia"], idProvincia)
				}
			}
			if (!idProvincia) {
				sys.warnMsgBox(sys.translate("La provincia %1 no pertenece al país %2").arg(provincia).arg(codPais));
				return false;
			}
		} else {
			var idProvTabla:String = util.sqlSelect("provincias", "idprovincia", "UPPER(provincia) = '" + provincia.toUpperCase() + "' AND codpais = '" + codPais + "' AND idprovincia = " + idProvincia);
			if (!idProvTabla) {
				sys.warnMsgBox(sys.translate("La provincia %1 no pertenece al país %2").arg(provincia).arg(codPais));
				return false;
			}
		}
	}
	return true;
}

function oficial_simplify(str)
{
  var regExp = new RegExp("( |\n|\r|\t|\f)");
  regExp.global = true;
  str = str.replace(regExp, "");
  return str;
}

function oficial_escapeQuote(str)
{
  var regExp = new RegExp("'");
  regExp.global = true;
  str = str.replace(regExp, "''");
  return str;
}

function oficial_valorDefecto(fN:String):String
{
	var util:FLUtil = new FLUtil;
	var valor:String = util.sqlSelect("factppal_general", fN, "1 = 1");
	if (!valor) {
		return "";
	}
	return valor;
}

function oficial_estableceGlobalInit()
{
	var util:FLUtil = new FLUtil();
	/// Se elimina para facilitar uso de funciones silentconn. Sobrecargar en los casos necesarios
	//util.writeSettingEntry("application/callFunction", "flfactppal.pub_globalInit");
}

/** \D
Obtiene el siguiente número de la secuencia de documentos por ejercicio
@param codEjercicio: Código de ejercicio del documento
@param fN: Tipo de documento
@return Número correspondiente al siguiente documento o false si hay error
\end */
function oficial_siguienteSecuenciaEjercicio(codEjercicio, fN)
{
	var numero, siguienteNumero;
	var vOut;

	var util= new FLUtil;
	var cursorSecuencias= new FLSqlCursor("secuencias");
	cursorSecuencias.setContext(this);
	cursorSecuencias.setActivatedCheckIntegrity(false);
	cursorSecuencias.select("upper(codejercicio) = '" + codEjercicio + "' AND nombre = '" + fN + "'");
	if (cursorSecuencias.next()) {
		cursorSecuencias.setModeAccess( cursorSecuencias.Edit );
		cursorSecuencias.refreshBuffer();
		if ( !cursorSecuencias.isNull( "valorout" ) ) {
			vOut = true;
			numero = cursorSecuencias.valueBuffer( "valorout" );
		} else {
			vOut = false;
			numero = cursorSecuencias.valueBuffer( "valor" );
		}
		if (!numero) {
			numero = 1;
		}
		siguienteNumero = (parseFloat(numero) + 1);
		if (vOut) {
			cursorSecuencias.setValueBuffer( "valorout", siguienteNumero );
		} else {
			cursorSecuencias.setValueBuffer( "valor", siguienteNumero );
		}
		cursorSecuencias.commitBuffer();
	} else {
		sys.addDatabase("Aux");
		var curAux= new FLSqlCursor("secuencias", "Aux");
		numero = 1;
		siguienteNumero = parseFloat(numero) + 1;
		curAux.setModeAccess( curAux.Insert );
		curAux.refreshBuffer();
		curAux.setValueBuffer( "codejercicio", codEjercicio);
		curAux.setValueBuffer( "nombre", fN );
		curAux.setValueBuffer( "valorout",  siguienteNumero);
		curAux.commitBuffer();
	}
	cursorSecuencias.setActivatedCheckIntegrity(true);

	return numero;
}

/** Indica si la extensión está cargada o no en el sistema. Función a sobrecargar por cada extensión devolviendo true en caso de que el nE coincida con el de la extensión.
*/
function oficial_extension(nE)
{
	return false;
}

/** Se le pasa un objeto que contiene una tabla además de otros atributos para exportar dicha tabla a excel */

function oficial_exportarTablaExcel(oParam)
{
	var _i = this.iface;

	if(oParam.tabla == undefined){
		sys.warnMsgBox(sys.translate("No se ha podido crear el archivo excel porque no hay tabla."));
		return;
	}
	if(oParam.nombreFichero == ""){
		sys.warnMsgBox(sys.translate("No se ha podido crear el archivo excel porque falta el nombre del fichero."));
		return;
	}

	var totalRegistros = oParam.tabla.numRows();

	// Estilos para poner a las celdas
  var titleCellStyle = new AQOdsStyle(AQS.ODS_ALIGN_CENTER |
                                  AQS.ODS_TEXT_BOLD);
  var italic = new AQOdsStyle(AQS.ODS_TEXT_ITALIC);
  var tSep = new AQOdsStyle(AQS.ODS_BORDER_TOP);
  var bSep = new AQOdsStyle(AQS.ODS_BORDER_BOTTOM);
  var rSep = new AQOdsStyle(AQS.ODS_BORDER_RIGHT);
  var lSep = new AQOdsStyle(AQS.ODS_BORDER_LEFT);
  var lAlig = new AQOdsStyle(AQS.ODS_ALIGN_LEFT);
  var rAlig = new AQOdsStyle(AQS.ODS_ALIGN_RIGHT);
  var none = new AQOdsStyle(AQS.ODS_NONE);

	_i.creaDialogoProgreso(sys.translate("Creando fichero ..."), totalRegistros);

	// Creación del archivo ods.
	var odsGen = new AQOdsGenerator;
  var spreadsheet = new AQOdsSpreadSheet(odsGen);
  var sheet = new AQOdsSheet(spreadsheet, oParam.nombreFichero);

	//Cabecera del fichero
	if(oParam.titulo != ""){
		var row= new AQOdsRow(sheet);
		row.opIn(titleCellStyle).opIn(oParam.titulo,oParam.tabla.numCols());
		row.close();
	}

	// Para dejar varias filas de separación entre la cabecera y la tabla con los datos.
	for (var i = 0; i < 2; i++){
		var row= new AQOdsRow(sheet);
		row.close();
	}

	// Cabecera para las columnas.
  var row = new AQOdsRow(sheet);
  row.addBgColor(new AQOdsColor(225,223,223)); // color de fondo para toda la fila
  //row.addFgColor(new AQOdsColor(0xff0000));
	if(oParam.nombreColumnas && oParam.nombreColumnas.length > 0){
		var maxCol = oParam.nombreColumnas.length > oParam.tabla.numCols() ? oParam.tabla.numCols() : oParam.nombreColumnas.length;
		for(var col = 0; col < maxCol; col++){
			row.opIn(titleCellStyle).opIn(tSep).opIn(rSep).opIn(bSep).opIn(oParam.nombreColumnas[col]); // opIn(string, colSpan, rowSpan)
		}
	}
  row.close();

	// Una fila en el archivo para cada fila del array.
  for (var f = 0; f < totalRegistros; f++){
		AQUtil.setProgress(f);
    var row2 = new AQOdsRow(sheet);

		if ( f % 2 == 0){
			row2.addBgColor(new AQOdsColor(255,255,255));
		}
		else{
			row2.addBgColor(new AQOdsColor(228,228,228));
		}

		var col = 0;
		var texto;
		if( f == (totalRegistros - 1)){ // Para dibujar la línea de abajo de la última fila de celdas.
			texto = oParam.tabla.text(f, col);
			if(!texto || texto == ""){
				texto = " ";
			}
			row2.opIn(rSep).opIn(bSep).opIn(lAlig).opIn(texto);
			for(col = 1; col < oParam.tabla.numCols() ; col++){
				texto = oParam.tabla.text(f, col);
				if(!texto || texto == ""){
					texto = " ";
				}
				row2.opIn(rSep).opIn(bSep).opIn(lAlig).opIn(texto);
			}
		}
    else{
			texto = oParam.tabla.text(f, col);
			if(!texto || texto == ""){
				texto = " ";
			}
			row2.opIn(rSep).opIn(lAlig).opIn(texto);
			for(col = 1; col < oParam.tabla.numCols(); col++){
				texto = oParam.tabla.text(f, col);
				if(!texto || texto == ""){
					texto = " ";
				}
				row2.opIn(rSep).opIn(lAlig).opIn(texto);
			}
		}
    row2.close();
  }

	sys.AQTimer.singleShot(0, AQUtil.destroyProgressDialog);

  sheet.close();
  spreadsheet.close();

	//Nombre del archivo.
  var odsFileName = "";
	if(oParam.path == "home"){
		odsFileName = Dir.home + "/" + oParam.nombreFichero +".ods";
	}
	else{
		var dirDestino = FileDialog.getExistingDirectory("", "Directorio de archivos");
		if (!dirDestino) {
			sys.warnMsgBox(sys.translate("No existe el directorio seleccionado."));
		}
		odsFileName =  dirDestino + "/" + oParam.nombreFichero +".ods";
	}
  odsFileName = Dir.cleanDirPath(odsFileName);
  odsFileName = Dir.convertSeparators(odsFileName);
	// Función que crea "físicamente" el archivo con la configuración y datos introducidos anteriormente.
  odsGen.generateOds(odsFileName);
	sys.infoMsgBox(sys.translate("Fichero generado en %1").arg(odsFileName));
	// Abrir archivo.
  sys.openUrl("file://" + odsFileName);
}

/** Se le pasa un objeto que contiene un array además de otros atributos para exportar dicha tabla a excel */

function oficial_exportarArrayExcel(oParam)
{
	var _i = this.iface;

	if(oParam.array == undefined){
		sys.warnMsgBox(sys.translate("No se ha podido crear el archivo excel porque no hay tabla."));
		return;
	}
	if(oParam.nombreFichero == ""){
		sys.warnMsgBox(sys.translate("No se ha podido crear el archivo excel porque falta el nombre del fichero."));
		return;
	}

	var totalRegistros = oParam.array.length;
	if (totalRegistros == 0) {
		sys.warnMsgBox(sys.translate("No hay datos que exportar"));
		return;
	}
	var numCols = oParam.array[0].length;
	// Estilos para poner a las celdas
  var titleCellStyle = new AQOdsStyle(AQS.ODS_ALIGN_CENTER |
                                  AQS.ODS_TEXT_BOLD);
  var italic = new AQOdsStyle(AQS.ODS_TEXT_ITALIC);
  var tSep = new AQOdsStyle(AQS.ODS_BORDER_TOP);
  var bSep = new AQOdsStyle(AQS.ODS_BORDER_BOTTOM);
  var rSep = new AQOdsStyle(AQS.ODS_BORDER_RIGHT);
  var lSep = new AQOdsStyle(AQS.ODS_BORDER_LEFT);
  var lAlig = new AQOdsStyle(AQS.ODS_ALIGN_LEFT);
  var rAlig = new AQOdsStyle(AQS.ODS_ALIGN_RIGHT);
  var none = new AQOdsStyle(AQS.ODS_NONE);

	_i.creaDialogoProgreso(sys.translate("Creando fichero ..."), totalRegistros);

	// Creación del archivo ods.
	var odsGen = new AQOdsGenerator;
  var spreadsheet = new AQOdsSpreadSheet(odsGen);
  var sheet = new AQOdsSheet(spreadsheet, oParam.nombreFichero);

	//Cabecera del fichero
	if(oParam.titulo != ""){
		var row= new AQOdsRow(sheet);
		row.opIn(titleCellStyle).opIn(oParam.titulo,numCols);
		row.close();
	}

	// Para dejar varias filas de separación entre la cabecera y la tabla con los datos.
	for (var i = 0; i < 2; i++){
		var row= new AQOdsRow(sheet);
		row.close();
	}

	// Cabecera para las columnas.
  var row = new AQOdsRow(sheet);
  row.addBgColor(new AQOdsColor(225,223,223)); // color de fondo para toda la fila
  //row.addFgColor(new AQOdsColor(0xff0000));
	if(oParam.nombreColumnas && oParam.nombreColumnas.length > 0){
		var maxCol = oParam.nombreColumnas.length > numCols ? numCols : oParam.nombreColumnas.length;
		for(var col = 0; col < maxCol; col++){
			row.opIn(titleCellStyle).opIn(tSep).opIn(rSep).opIn(bSep).opIn(oParam.nombreColumnas[col]); // opIn(string, colSpan, rowSpan)
		}
	}
  row.close();

	// Una fila en el archivo para cada fila del array.
  for (var f = 0; f < totalRegistros; f++){
		AQUtil.setProgress(f);
    var row2 = new AQOdsRow(sheet);

		if ( f % 2 == 0){
			row2.addBgColor(new AQOdsColor(255,255,255));
		}
		else{
			row2.addBgColor(new AQOdsColor(228,228,228));
		}

		var col = 0;
		var texto;
		if( f == (totalRegistros - 1)){ // Para dibujar la línea de abajo de la última fila de celdas.
			texto = oParam.array[f][col];
			if(!texto || texto == ""){
				texto = " ";
			}
			row2.opIn(rSep).opIn(bSep).opIn(lAlig).opIn(texto);
			for(col = 1; col < numCols ; col++){
				texto = oParam.array[f][col];
				if(!texto || texto == ""){
					texto = " ";
				}
				row2.opIn(rSep).opIn(bSep).opIn(lAlig).opIn(texto);
			}
		}
    else{
			texto = oParam.array[f][col];
			if(!texto || texto == ""){
				texto = " ";
			}
			row2.opIn(rSep).opIn(lAlig).opIn(texto);
			for(col = 1; col < numCols; col++){
				texto = oParam.array[f][col];
				if(!texto || texto == ""){
					texto = " ";
				}
				row2.opIn(rSep).opIn(lAlig).opIn(texto);
			}
		}
    row2.close();
  }

	sys.AQTimer.singleShot(0, AQUtil.destroyProgressDialog);

  sheet.close();
  spreadsheet.close();

	//Nombre del archivo.
  var odsFileName = "";
	if(oParam.path == "home"){
		odsFileName = Dir.home + "/" + oParam.nombreFichero +".ods";
	}
	else{
		var dirDestino = FileDialog.getExistingDirectory("", "Directorio de archivos");
		if (!dirDestino) {
			sys.warnMsgBox(sys.translate("No existe el directorio seleccionado."));
		}
		odsFileName =  dirDestino + "/" + oParam.nombreFichero +".ods";
	}
  odsFileName = Dir.cleanDirPath(odsFileName);
  odsFileName = Dir.convertSeparators(odsFileName);
	// Función que crea "físicamente" el archivo con la configuración y datos introducidos anteriormente.
  odsGen.generateOds(odsFileName);
	sys.infoMsgBox(sys.translate("Fichero generado en %1").arg(odsFileName));
	// Abrir archivo.
  sys.openUrl("file://" + odsFileName);
}

/** Se le pasa un objeto que contiene una consulta además de otros atributos para exportar dicha consulta a excel */

function oficial_exportarConsultaExcel(oParam)
{
	var _i = this.iface;

	if(oParam.consulta == undefined){
		sys.warnMsgBox(sys.translate("No se ha podido crear el archivo excel porque no hay consulta."));
		return;
	}
	if(oParam.nombreFichero == ""){
		sys.warnMsgBox(sys.translate("No se ha podido crear el archivo excel porque falta el nombre del fichero."));
		return;
	}

	var q = oParam.consulta;

	debug(q.sql());
	if(!q.exec()){
		sys.warnMsgBox(sys.translate("No se ha podido crear el archivo excel porque ha fallado la consulta SQL."));
		return;
	}

	var totalRegistros = q.size();
	var totalColumnas = oParam.nombreColumnas.length;

	// Estilos para poner a las celdas
  var titleCellStyle = new AQOdsStyle(AQS.ODS_ALIGN_CENTER |
                                  AQS.ODS_TEXT_BOLD);
  var italic = new AQOdsStyle(AQS.ODS_TEXT_ITALIC);
  var tSep = new AQOdsStyle(AQS.ODS_BORDER_TOP);
  var bSep = new AQOdsStyle(AQS.ODS_BORDER_BOTTOM);
  var rSep = new AQOdsStyle(AQS.ODS_BORDER_RIGHT);
  var lSep = new AQOdsStyle(AQS.ODS_BORDER_LEFT);
  var lAlig = new AQOdsStyle(AQS.ODS_ALIGN_LEFT);
  var rAlig = new AQOdsStyle(AQS.ODS_ALIGN_RIGHT);
  var none = new AQOdsStyle(AQS.ODS_NONE);

	_i.creaDialogoProgreso(sys.translate("Creando fichero ..."), totalRegistros);

	// Creación del archivo ods.
	var odsGen = new AQOdsGenerator;
  var spreadsheet = new AQOdsSpreadSheet(odsGen);
  var sheet = new AQOdsSheet(spreadsheet, oParam.nombreFichero);

	//Cabecera del fichero
	if(oParam.titulo != ""){
		var row= new AQOdsRow(sheet);
		row.opIn(titleCellStyle).opIn(oParam.titulo,totalColumnas);
		row.close();
	}

	// Para dejar varias filas de separación entre la cabecera y la tabla con los datos.
	for (var i = 0; i < 2; i++){
		var row= new AQOdsRow(sheet);
		row.close();
	}

	// Cabecera para las columnas.
  var row = new AQOdsRow(sheet);
  row.addBgColor(new AQOdsColor(225,223,223)); // color de fondo para toda la fila
  //row.addFgColor(new AQOdsColor(0xff0000));
	if(oParam.nombreColumnas && oParam.nombreColumnas.length > 0){
		var maxCol = oParam.nombreColumnas.length > totalColumnas ? totalColumnas : oParam.nombreColumnas.length;
		for(var col = 0; col < maxCol; col++){
			row.opIn(titleCellStyle).opIn(tSep).opIn(rSep).opIn(bSep).opIn(oParam.nombreColumnas[col]); // opIn(string, colSpan, rowSpan)
		}
	}
  row.close();

	var p = 0;
	// Una fila en el archivo para cada registro de la consulta.
  while (q.next()){
		AQUtil.setProgress(p);
    var row2 = new AQOdsRow(sheet);

		if ( p % 2 == 0){
			row2.addBgColor(new AQOdsColor(255,255,255));
		}
		else{
			row2.addBgColor(new AQOdsColor(228,228,228));
		}

		var col;
		var texto;

		// Para dibujar la línea de abajo de la última fila de celdas.

		for(col = 0; col < totalColumnas; col++){
			texto = q.value(col);
			if(!texto || texto == ""){
				texto = " ";
			}
			else{
				switch(oParam.tipoColumna[col]){
					case "int":{
						texto = parseInt(texto);
						break;
					}
					case "double":{
						texto = parseFloat(texto);
						break;
					}
					case "date":{
						var dia = texto.getDate().toString();
						if(dia.length < 2){
							dia = "0" + dia;
						}
						var mes = texto.getMonth().toString();
						if(mes.length < 2){
							mes = "0" + mes;
						}
						var anyo = texto.getYear().toString();

						texto = dia + "/" + mes + "/" + anyo;
						break;
					}
					case "function": {
						texto = oParam.funcion(q);
						break;
					}
					default:{
						break;
					}
				}
			}
			if( p == (totalRegistros - 1)){
				row2.opIn(rSep).opIn(bSep).opIn(lAlig).opIn(texto);
			}
			else{
			row2.opIn(rSep).opIn(lAlig).opIn(texto);
			}
		}
    row2.close();
		p++;
  }

	sys.AQTimer.singleShot(0, AQUtil.destroyProgressDialog);

  sheet.close();
  spreadsheet.close();

	//Nombre del archivo.
  var odsFileName = "";
	if(oParam.path == "home"){
		odsFileName = Dir.home + "/" + oParam.nombreFichero +".ods";
	}
	else{
		var dirDestino = FileDialog.getExistingDirectory("", "Directorio de archivos");
		if (!dirDestino) {
			sys.warnMsgBox(sys.translate("No existe el directorio seleccionado."));
		}
		odsFileName =  dirDestino + "/" + oParam.nombreFichero +".ods";
	}
  odsFileName = Dir.cleanDirPath(odsFileName);
  odsFileName = Dir.convertSeparators(odsFileName);
	// Función que crea "físicamente" el archivo con la configuración y datos introducidos anteriormente.
  odsGen.generateOds(odsFileName);
	sys.infoMsgBox(sys.translate("Fichero generado en %1").arg(odsFileName));
	// Abrir archivo.
  sys.openUrl("file://" + odsFileName);
}

function oficial_dameParamExcel()
{
	var oParam = new Object();
	oParam.nombreFichero = "";
	oParam.tabla = undefined;
	oParam.nombreColumnas = undefined;
	oParam.titulo = "";
	oParam.path = "home";
	oParam.consulta = undefined;
	oParam.array = undefined;
	oParam.tipoColumna = undefined;

  return oParam;
}

function oficial_dameColor(nombre)
{
	var color;
	switch (nombre) {
		case "fondo_amarillo": {
			color = "#FFF319";
			break;
		}
		case "fondo_rojo": {
			color = "#FF193F";
			break;
		}
		case "fondo_verde": {
			color = "#19FF34";
			break;
		}
		default:{
			color = "#FFFFFF";
		}
	}
	return color;
}

function oficial_creaDialogoProgreso(mensaje, tamano)
{
	AQUtil.createProgressDialog(mensaje, tamano);
	AQUtil.setProgress(1);

  var evLoop = aqApp.eventLoop();
  sys.AQTimer.singleShot(10, evLoop.exitLoop);
  evLoop.enterLoop();
}

function oficial_abreLogFile(logName, fileName)
{
	var _i = this.iface;

	if (!_i.logFiles_) {
		_i.logFiles_ = new Object;
	}
	if (!(logName in _i.logFiles_)) {
		var file = new QFile(fileName);
		if (!file.open(File.WriteOnly | File.Append)) {
			if (sys.interactiveGUI()) {
				var res = MessageBox.information(sys.translate("No se ha podido crear el fichero de log %1.\n¿Desea continuar de todas formas?").arg(fileName), MessageBox.Yes, MessageBox.No, "AbanQ");
				if (res == MessageBox.Yes) {
					_i.logFiles_[logName] = undefined;
				} else {
					return false;
				}
			} else {
				_i.logFiles_[logName] = undefined;
			}
		} else {
			_i.logFiles_[logName] = fileName;
		}
	}
	return true;
}

function oficial_appendTextToLogFile(logName, txt)
{
	var _i = this.iface;
	if (!_i.logFiles_) {
		return false;
	}
	if (!(logName in _i.logFiles_)) {
		return false;
	}
	var fileName = _i.logFiles_[logName];

	if (fileName == undefined)
	{
		return false;
	}

	var hoy = new Date;
	txt = hoy.toString() + ": " + txt;

	return _i.appendTextToFile(fileName, txt);
}

function oficial_appendTextToFile(fileName, txt)
{
  var file = new QFile(fileName);
  if (!file.open(File.WriteOnly | File.Append)) {
    sys.errorMsgBox(fileName + ":\n" + file.errorString());
    return false;
  }

  var ts = new QTextStream;
  ts.setDevice(file.ioDevice());
  ts.opIn(txt + "\n");
  file.close();
  return true;
}

/** \D Estructura de oParam:
oParam.caption default Dialogo de Estado
oParam.nombre default statusdialog
oParam.ancho default 250
oParam.alto default 300
\end */
function oficial_creaDialogoEstado(oParam)
{
	var _i = this.iface;

	var caption = "Diálogo de Estado";
	var nombre = "statusdialog";
	var ancho = 250;
	var alto = 300;

	if("caption" in oParam) {
		if(oParam.caption && oParam.caption != "")
			caption = oParam.caption;
	}

	if("nombre" in oParam) {
		if(oParam.nombre && oParam.nombre != "")
			nombre = oParam.nombre;
	}

	if("ancho" in oParam) {
		if(oParam.ancho && oParam.ancho != "")
			ancho = oParam.ancho;
	}

	if("alto" in oParam) {
		if(oParam.alto && oParam.alto != "")
			alto = oParam.alto;
	}

	_i.dialogEst_ = new QDialog;
	_i.dialogEst_.caption = caption;
	_i.dialogEst_.name = nombre;
	_i.dialogEst_.modal = true;

	var lay = new QVBoxLayout(_i.dialogEst_);
	_i.textLog_ = new QTextEdit(_i.dialogEst_);
	_i.textLog_.textFormat = LogText;
	_i.textLog_.alignment = AQS.AlignHCenter | AQS.AlignVCenter;
	lay.addWidget(_i.textLog_);

	_i.dialogEst_.resize(ancho, alto);

	_i.dialogEst_.show();
}

function oficial_ponLogDialogo(msg)
{
  var _i = this.iface;
  _i.textLog_.append(msg);

  var evLoop = aqApp.eventLoop();
  sys.AQTimer.singleShot(1, evLoop.exitLoop);
  evLoop.enterLoop();
}

function oficial_destruyeDialogoEstado()
{
  var _i = this.iface;
  _i.dialogEst_.close();
}

function oficial_controlDatosMod(curT)
{
 	var _i = this.iface;
	switch (curT.modeAccess()) {
		case curT.Insert: {
			var d = new Date;
			curT.setValueBuffer("idusuarioalta", sys.nameUser());
			curT.setValueBuffer("idusuariomod", sys.nameUser());
			curT.setValueBuffer("fechaalta", d.toString());
			curT.setValueBuffer("fechamod", d.toString());
			break;
		}
		case curT.Edit: {
			if (!_i.registrarCambioCursor(curT)) {
				break;
			}
			var d = new Date;
			curT.setValueBuffer("idusuariomod", sys.nameUser());
			curT.setValueBuffer("fechamod", d.toString());
			break;
		}
	}
	return true;
}

function oficial_registrarCambioCursor(curT)
{
	switch (curT.table()) {
		case "articulos": {
			return true;
		}
		default: {
			return true;
		}
	}
	return true;
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
