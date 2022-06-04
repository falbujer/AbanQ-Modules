/***************************************************************************
                          mt_masterprocesos.qs
                            -------------------
   begin                : jue ene 20 2005
   copyright            : (C) 2005 by InfoSiAL S.L.
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

/** @file */ 

////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/** @class_declaration interna */
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
	var funciones:Array;
	var sep = "ð";
	var sep2 = "|";
	var relaciones:Array = [];
    function oficial( context ) { interna( context ); } 
	function ejecutarFuncion() { return this.ctx.oficial_ejecutarFuncion(); }
	function recargarFunciones() { return this.ctx.oficial_recargarFunciones(); }
	function actualizarSaldos() { return this.ctx.oficial_actualizarSaldos();}
	function consolidarNumeracion() { return this.ctx.oficial_consolidarNumeracion();}
	function subcuentasDuplicadas() { return this.ctx.oficial_subcuentasDuplicadas();}
	function resolverDuplicidad(codSubcuenta:String, codEjercicio:String, utilProg:FLUtil, mensaje:String) { return this.ctx.oficial_resolverDuplicidad(codSubcuenta, codEjercicio, utilProg, mensaje);}
	function obtenerRelaciones(tabla) { return this.ctx.oficial_obtenerRelaciones(tabla) ;}
	function asientosFacturacionProv() { return this.ctx.oficial_asientosFacturacionProv() ;}
	function asientosFacturacionCli() { return this.ctx.oficial_asientosFacturacionCli() ;}
	function recibosCliQueFaltan() { return this.ctx.oficial_recibosCliQueFaltan() ;}
	function reubicarPartidasPagos() { return this.ctx.oficial_reubicarPartidasPagos() ;}
	function repararPagares() { return this.ctx.oficial_repararPagares() ;}
	function actualizarContabilidadRemesas() { return this.ctx.oficial_actualizarContabilidadRemesas() ;}
	function consolidarStocks() { return this.ctx.oficial_consolidarStocks() ;}
	function subcuentasClientes() { return this.ctx.oficial_subcuentasClientes() ;}
	function consolidarSubcuentasClientes() { return this.ctx.oficial_consolidarSubcuentasClientes() ;}
	function repararAsientosMultiejercicio() { return this.ctx.oficial_repararAsientosMultiejercicio() ;}
	function repararPartidasIVA() { return this.ctx.oficial_repararPartidasIVA() ;}
	function eliminarContabilidadSerie() { return this.ctx.oficial_eliminarContabilidadSerie() ;}
	function subcuentasProv() { return this.ctx.oficial_subcuentasProv() ;}
	function partidasCC() { return this.ctx.oficial_partidasCC() ;}
	function subcuentasCliProv() { return this.ctx.oficial_subcuentasCliProv() ;}
	function stocksFromStockFis() { return this.ctx.oficial_stocksFromStockFis() ;}
	function completarCopiaSubcuentas() { return this.ctx.oficial_completarCopiaSubcuentas() ;}
	function actualizarCodigosBalanceCuenta() { return this.ctx.oficial_actualizarCodigosBalanceCuenta() ;}
	function plazosPago() { return this.ctx.oficial_plazosPago() ;}
	function emparejarSubcuentasClientes() { return this.ctx.oficial_emparejarSubcuentasClientes() ;}
	function actualizarDescripcionesSubctasCli() { return this.ctx.oficial_actualizarDescripcionesSubctasCli() ;}
	function revisaRecibosCli(oParam) { return this.ctx.oficial_revisaRecibosCli(oParam);}
	

	function traspasoSubcta(idSubctaOri:Number, idSubctaDes:Number, codSubctaOri:Number, codSubctaDes:Number) {
		return this.ctx.oficial_traspasoSubcta(idSubctaOri, idSubctaDes, codSubctaOri, codSubctaDes);
	}
	function revisaAsientoPagoRecibosCli(oParam) {
		return this.ctx.oficial_revisaAsientoPagoRecibosCli(oParam);
	}
	function revisaAsientoPagoRemesas(oParam) {
		return this.ctx.oficial_revisaAsientoPagoRemesas(oParam);
	}
	function procesaStocksPtes(oParam) {
		return this.ctx.oficial_procesaStocksPtes(oParam);
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

////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/** @class_definition interna */
//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////

function init() {
    this.iface.init();
}

/** \C 
\end */
function interna_init() 
{
	


	connect( this.child( "pbnEjecutar" ), "clicked()", this, "iface.ejecutarFuncion" );
	connect( this.child( "pbnRecargarFunciones" ), "clicked()", this, "iface.recargarFunciones" );
	
	var nf:Number = 0;
	
	this.iface.funciones =
			[["actualizarSaldos","Recalcula y actualiza los saldos de las subcuentas"],
			["consolidarNumeracion","Busca huecos y resuelve incoherencias en la numeración de los documentos de facturación"],
			["subcuentasDuplicadas","Busca y elimina subcuentas duplicadas en el Plan General Contable"],
			["asientosFacturacionProv","Regenera los asientos de la facturación de proveedores"],
			["asientosFacturacionCli","Regenera los asientos de la facturación de clientes"],
			["recibosCliQueFaltan","Completa los recibos de cliente en las facturas sin recibo"],
			["reubicarPartidasPagos", "Reubica las partidas contables de pagos inter-ejercicios"],
			["repararPagares", "Repara los pagarés y recibos de proveedor"],
			["actualizarContabilidadRemesas", "Prepara los movimientos contables de las remesas para las devoluciones"],
			["consolidarStocks", "Consolida las líneas de stock a partir de los valores de stock físico"],
			["subcuentasClientes", "Migra los movimientos de la cuenta 4300000 a la cuenta propia de cada cliente"],
			["repararAsientosMultiejercicio", "Repara asientos con partidas en más de un ejercicio"],
			["repararPartidasIVA", "Repara las partidas de IVA con datos de serie, base imponible, etc"],			
			["eliminarContabilidadSerie", "Elimina los movimientos contables de una serie determinada"],
			["subcuentasProv", "Subcuentas de proveedor a 40000"],
			["subcuentasCliProv", "Completar subcuentas de clientes y proveedor"],
			["partidasCC", "Partidas por centro de coste"],
			["stocksFromStockFis", "Stocks desde stock físico"],
			["completarCopiaSubcuentas", "Completar la copia de subcuentas"],
			["actualizarCodigosBalanceCuenta", "Actualizar los códigos de balance"],
			["plazosPago", "Completa los plazos de pago"],
			["emparejarSubcuentasClientes", "Asocia a cada cliente la subcuenta 43 que ya debe existir"],
			["actualizarDescripcionesSubctasCli", "Actualiza la descripcion de las subcuentas del cliente con el nombre del mismo"],
			["revisaRecibosCli", "Revisa el estado de los recibos de cliente"],
			["revisaAsientoPagoRecibosCli", "Regenera los asiento de todos los recibos del ejercicio. Sólo el último pago de cada recibo."],
			["revisaAsientoPagoRemesas", "Regenera los asiento de todas las remesas del ejercicio. Sólo el último pago de cada remesa."],
			["procesaStocksPtes", "Procesa stocks pendientes de totalizar OFICIAL"]];
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////


/** \D Lanza la ejecución de la función cuyo registro está seleccionado en el
formulario maestro
\end */
function oficial_ejecutarFuncion()
{
	var util:FLUtil = new FLUtil();
	var funcion:String = this.cursor().valueBuffer( "funcion" ).toString();
	
	var res:Object = MessageBox.information(util.translate("scripts",  "¿Seguro que desea ejecutar esta función?"), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
	if (res != MessageBox.Yes)
		return;
	
	switch ( funcion ) {

		case "actualizarSaldos": {
				this.iface.actualizarSaldos();
				break;
		}
		case "consolidarNumeracion": {
				this.iface.consolidarNumeracion();
				break;
		}
		case "subcuentasDuplicadas": {
				this.iface.subcuentasDuplicadas();
				break;
		}
		case "asientosFacturacionProv": {
				this.iface.asientosFacturacionProv();
				break;
		}
		case "asientosFacturacionCli": {
				this.iface.asientosFacturacionCli();
				break;
		}
		case "recibosCliQueFaltan": {
				this.iface.recibosCliQueFaltan();
				break;
		}
		case "plazosPago": {
				this.iface.plazosPago();
				break;
		}
		case "reubicarPartidasPagos": {
				this.iface.reubicarPartidasPagos();
				break;
		}
		case "repararPagares": {
				this.iface.repararPagares();
				break;
		}
		case "actualizarContabilidadRemesas": {
				this.iface.actualizarContabilidadRemesas();
				break;
		}
		case "consolidarStocks": {
				this.iface.consolidarStocks();
				break;
		}
		case "subcuentasClientes": {
				this.iface.subcuentasClientes();
				break;
		}
		case "repararAsientosMultiejercicio": {
				this.iface.repararAsientosMultiejercicio();
				break;
		}
		case "repararPartidasIVA": {
				this.iface.repararPartidasIVA();
				break;
		}
		case "eliminarContabilidadSerie": {
				this.iface.eliminarContabilidadSerie();
				break;
		}
		case "subcuentasProv": {
				this.iface.subcuentasProv();
				break;
		}
		case "subcuentasCliProv": {
				this.iface.subcuentasCliProv();
				break;
		}
		case "partidasCC": {
				this.iface.partidasCC();
				break;
		}
		case "stocksFromStockFis": {
				this.iface.stocksFromStockFis();
				break;
		}
		case "completarCopiaSubcuentas": {
				this.iface.completarCopiaSubcuentas();
				break;
		}
		case "actualizarCodigosBalanceCuenta": {
				this.iface.actualizarCodigosBalanceCuenta();
				break;
		}
		case "emparejarSubcuentasClientes": {
				this.iface.emparejarSubcuentasClientes();
				break;
		}
		case "actualizarDescripcionesSubctasCli": {
				this.iface.actualizarDescripcionesSubctasCli();
				break;
		}
		default: {
			/// Se envuelve en una transacción, la función recibue un objeto oParam, donde puede especificarse el posible error
			var oParam = new Object;
			oParam.errorMsg = sys.translate("Error en la función %1").arg(funcion);
			var f = new Function("oParam", "return formmt_procesos.iface." + funcion + "(oParam)");
			if (!sys.runTransaction(f, oParam)) {
				return false;
			}
			MessageBox.information(sys.translate("Proceso terminado correctamente"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
		}
	}
}

/** \D Recarga los registros con las funciones disponibles
\end */
function oficial_recargarFunciones()
{
	var util:FLUtil = new FLUtil();
	
	var res:Object = MessageBox.information(util.translate("scripts",  "¿Desea recargar la lista de funciones?"), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
	if (res != MessageBox.Yes)
		return;
	
	var curPro:FLSqlCursor = new FLSqlCursor("mt_procesos");
	for (i = 0; i < this.iface.funciones.length; i++) {
		curPro.select("funcion = '" + this.iface.funciones[i][0] + "'");
		if (curPro.first())
			continue;
		curPro.setModeAccess(curPro.Insert);
		curPro.refreshBuffer();
		curPro.setValueBuffer("funcion", this.iface.funciones[i][0]);
		curPro.setValueBuffer("descripcion", this.iface.funciones[i][1]);
		curPro.commitBuffer();
	} 
}


/** \D Recalcula los saldos de todas las subcuentas
*/
function oficial_actualizarSaldos()
{
	var util:FLUtil = new FLUtil();
	
	if (!sys.isLoadedModule("flcontppal")) {
		MessageBox.warning(util.translate("scripts", "No se puede ejecutar esta función. El módulo principal de contabilidad no ha sido cargado"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return;
	}
	
	var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
	var numSubcuentas:Number = util.sqlSelect("co_subcuentas", "count(idsubcuenta)", "codejercicio = '" + codEjercicio + "'");
	var paso:Number = 0;
	
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("co_subcuentas");
	q.setFrom("co_subcuentas");
	q.setSelect("idsubcuenta");
	q.setWhere("codejercicio = '" + codEjercicio + "'")
	
	if (!q.exec()) { 
		MessageBox.warning( util.translate( "scripts", "Se produjo un error en la consulta"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return false;
	}
	
	util.createProgressDialog( util.translate( "scripts",
							"Calculando saldos de las Subcuentas..." ), numSubcuentas );
	
	while(q.next()) {
		flcontppal.iface.pub_calcularSaldo(q.value(0));
		util.setProgress(paso++);
	}

	util.destroyProgressDialog();

	MessageBox.information ( util.translate( "scripts", "Proceso finalizado. Subcuentas actualizadas: " + paso), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
}



/** \D Consolida la numeración de las facturas actualizando los huecos 
*/
function oficial_consolidarNumeracion()
{
	var util:FLUtil = new FLUtil();
	
	var paso:Number = 0;
	
	var numHuecos:Number = util.sqlSelect("huecos", "count(id)", "");
	util.createProgressDialog( util.translate( "scripts",
							"Calculando saldos de las Subcuentas..." ), numHuecos );
	
	var nomTabla:String;						
	var codigo:String;
	var numero:String;
	var codSerie:String;
	var codEjercicio:String;
	var codigosLiberados:String;
	
	var curHuecos:FLSqlCursor = new FLSqlCursor("huecos");
	curHuecos.select();
	
	while(curHuecos.next()) {
	
		codSerie = curHuecos.valueBuffer("codserie");
		codEjercicio = curHuecos.valueBuffer("codejercicio");
		numero = curHuecos.valueBuffer("numero");
	
		codigo = flfacturac.iface.pub_construirCodigo(codSerie, codEjercicio, numero);
		debug(codigo);
		
		switch(curHuecos.valueBuffer("tipo")) {
			case "FC":
				nomTabla = "facturascli";
				break;
			case "FP":
				nomTabla = "facturasprov";
				break;
		}
	
		// Si existe un registro y un hueco referido al mismo, se elimina el hueco
		if (util.sqlSelect(nomTabla, "codigo", "codigo = '" + codigo + "'")) {
			curHuecos.setModeAccess(curHuecos.Del);
			curHuecos.refreshBuffer();
			if (!curHuecos.commitBuffer())
				debug("Error al eliminar el hueco para el código " + codigo + " de " + nomTabla);
			codigosLiberados += codigo + "  ";
		}
		
		util.setProgress(paso++);
	}

	util.destroyProgressDialog();
	
	var mensaje:String;
	if (codigosLiberados)
	 	mensaje = util.translate( "scripts", "Proceso finalizado. Códigos liberados de facturas:\n") + codigosLiberados;
	else
	 	mensaje = util.translate( "scripts", "Proceso finalizado. No se encontraron incoherencias");
		
	MessageBox.information (mensaje, MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
}

/** Busca y elimina subcuentas duplicadas
*/
function oficial_subcuentasDuplicadas()
{
	var util:FLUtil = new FLUtil();
	var arrayEjer:Array = [];
	var ejActual:String = flfactppal.iface.pub_ejercicioActual();
			
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("ejercicios");
	q.setFrom("ejercicios");
	q.setSelect("codejercicio,nombre");
	if (!q.exec()) return false;
	
	var dialog = new Dialog(util.translate ( "scripts", "Selecciona el ejercicio" ), 0);
	dialog.caption = "Selecciona el ejercicio";
	dialog.OKButtonText = util.translate ( "scripts", "Aceptar" );
	dialog.cancelButtonText = util.translate ( "scripts", "Cancelar" );
	
	var bgroup:GroupBox = new GroupBox;
	dialog.add( bgroup );
	var cB:Array = [];
	var nEjer:Number = 0;	
	
	while (q.next())  {
		cB[nEjer] = new CheckBox;
		cB[nEjer].text = q.value(1);
 		arrayEjer[nEjer] = q.value(0);
		if (q.value(0) == ejActual)
			cB[nEjer].checked = true;
		else
			cB[nEjer].checked = false;
		bgroup.add( cB[nEjer] );
		nEjer++;
	}
	
	var lista:String = "";
	
	if (nEjer > 0){
		nEjer --;
		if(dialog.exec()) {
			for (var i:Number = 0; i <= nEjer; i++)
				if (cB[i].checked == true)
					lista += arrayEjer[i] + this.iface.sep;
		}
		else
			return;
		lista = lista.left(lista.length -1)
		if (lista == "")
			return;
	}
	
	arrayEjer = [];
	arrayEjer = lista.split(this.iface.sep);
	
	this.iface.obtenerRelaciones("co_subcuentas");
	
	var codEjercicio:String, mensaje:String;
	var numSubcuentas:Number, paso:Number;
	var totalSubcuentas:Number = 0;
	
	for (i = 1; i <= arrayEjer.length; i++) {
		
		codEjercicio = arrayEjer[i - 1];
		
		mensaje = util.translate( "scripts", "Procesando subcuentas del ejercicio ") + codEjercicio + " (" + i + "/" + arrayEjer.length + ")";
		numSubcuentas = util.sqlSelect("co_subcuentas", "count(idsubcuenta)", "codejercicio = '" + codEjercicio + "'")
		util.createProgressDialog( mensaje, numSubcuentas);
		
		q.setTablesList("co_subcuentas");
		q.setFrom("co_subcuentas");
		q.setSelect("codsubcuenta, count(codsubcuenta)");
		q.setWhere("codejercicio='" + codEjercicio + "' group by codsubcuenta");
		if (!q.exec()) return false;
		
		paso = 0;
		while (q.next()) {
			util.setProgress(paso++);
			if (q.value(1) == 1)
				continue;
				util.setLabelText(mensaje + "\nSubcuenta duplicada: " + q.value(0));
				this.iface.resolverDuplicidad(q.value(0), codEjercicio, util, mensaje + "\nSubcuenta duplicada: " + q.value(0));
				totalSubcuentas++;
		}
	
		util.destroyProgressDialog();
	}

	MessageBox.information(util.translate("scripts",  "Proceso finalizado.\n%0 subcuentas duplicadas procesadas").arg(totalSubcuentas), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);}


/** Consolida dos subcuentas duplicadas
*/
function oficial_resolverDuplicidad(codSubcuenta:String, codEjercicio:String, utilProg:FLUtil, mensaje:String)
{
	var idSub:Array = [];
	var paso:Number = 0;
	
	// Obtenemos los idsubcuenta
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("co_subcuentas");
	q.setFrom("co_subcuentas");
	q.setSelect("idsubcuenta");
	q.setWhere("codejercicio='" + codEjercicio + "' AND codsubcuenta = '" + codSubcuenta + "'");
	if (!q.exec()) return false;
	
	while (q.next())
		idSub[paso++] = q.value(0);
		
	var idSubDestino:Number = idSub[idSub.length - 1];
	var curTab:FLSqlCursor;
	var tabla:String, campo:String;
	
	// Pasamos por todas las tablas relacionadas
	for (k = 0; k < this.iface.relaciones.length - 1; k++) {
		
		tabla = this.iface.relaciones[k]["table"];
		campo = this.iface.relaciones[k]["field"];
		debug("TABLA " + tabla + " - CAMPO " + campo);
		
		curTab = new FLSqlCursor(tabla);
		
		// Consolidamos todas en la última
		for (i = 0; i < idSub.length - 1; i++) {
			debug("Consolidando " + idSub[i] + " en " + idSubDestino);		
			curTab.select(campo + " = " + idSub[i]);
			while(curTab.next()) {
				debug("      Partida " + curTab.valueBuffer("idpartida"));
				curTab.setModeAccess(curTab.Edit);
				curTab.refreshBuffer();
				curTab.setValueBuffer(campo, idSubDestino);
				curTab.commitBuffer();
			}
		}
		
	}
	
	// Se eliminan las subcuentas
	curTab = new FLSqlCursor("co_subcuentas");
	for (i = 0; i < idSub.length - 1; i++) {
		curTab.select("idsubcuenta = " + idSub[i]);
		debug("Eliminando " + idSub[i]);
		if (curTab.first()) {
			curTab.setModeAccess(curTab.Del);
			curTab.refreshBuffer();
 			curTab.commitBuffer();
		}
	}
	
}

/** Obtiene las relaciones de una tabla. Usado para las subcuentas duplicadas
*/
function oficial_obtenerRelaciones(tabla)
{
	var util:FLUtil = new FLUtil();
	var stringRelaciones:String = "";
	
	var contenido:String = util.sqlSelect( "flfiles", "contenido", "nombre = '" + tabla + ".mtd'" );
	var nomTablaRel:String;

	xmlTabla = new FLDomDocument();
	xmlTabla.setContent(contenido);
	
	
	var listaRelaciones = xmlTabla.elementsByTagName("relation");
	if (!listaRelaciones) return "";

	var numRel:Number = 0;
	for (var i = 0; i < listaRelaciones.length(); i++) {
		
		nodoRelacion = listaRelaciones.item(i);
		if (nodoRelacion.namedItem("card")) {
			if (nodoRelacion.namedItem("card").toElement().text() == "1M") {
				this.iface.relaciones[numRel] = new Array(2);
				this.iface.relaciones[numRel]["table"] = nodoRelacion.namedItem("table").toElement().text();
				this.iface.relaciones[numRel]["field"] = nodoRelacion.namedItem("field").toElement().text();
				debug(this.iface.relaciones[numRel]["table"] + " - " + this.iface.relaciones[numRel]["field"]);
				numRel++;
			}
		}
	}
}

function oficial_asientosFacturacionProv() 
{
	var util:FLUtil = new FLUtil();
	var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
	
	var numFacturas:Number = util.sqlSelect("facturasprov", "count(idfactura)", "codejercicio = '" + codEjercicio + "'");
	var paso:Number = 0;
	
	var curTab:FLSqlCursor = new FLSqlCursor("facturasprov");
	
	curTab.select("codejercicio = '" + codEjercicio + "'")
	util.createProgressDialog( util.translate( "scripts", "Regenerando asientos de las facturas de %1..." ).arg(codEjercicio), numFacturas);
	var idFactura;
	var curF = new FLSqlCursor("facturasprov");
	while(curTab.next()) {
		util.setProgress(paso++);
// 		if (curTab.valueBuffer("nogenerarasiento")) continue;
		idFactura = curTab.valueBuffer("idfactura");
		var e = curTab.valueBuffer("editable");
		if (!e) {
			if (!AQUtil.execSql("UPDATE facturasprov SET editable = true WHERE idfactura = " + idFactura)) {
				return false;
			}
		}
		curF.select("idfactura = " + idFactura);
		if (!curF.first()) {
			return false;
		}
		curF.setModeAccess(curF.Edit);
		curF.refreshBuffer();
		if (!curF.commitBuffer()) {
			return false;
		}
		if (!AQUtil.execSql("UPDATE facturasprov SET editable = false WHERE idfactura = " + idFactura)) {
			return false;
		}
	}
	util.destroyProgressDialog();	
}

function oficial_asientosFacturacionCli() 
{
	var util:FLUtil = new FLUtil();
	var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
	
	var numFacturas:Number = util.sqlSelect("facturascli", "count(idfactura)", "codejercicio = '" + codEjercicio + "'");
	var paso:Number = 0;
	
	var curTab:FLSqlCursor = new FLSqlCursor("facturascli");
	
	curTab.select("codejercicio = '" + codEjercicio + "'")
	util.createProgressDialog( util.translate( "scripts", "Regenerando asientos de las facturas de %1..." ).arg(codEjercicio), numFacturas);
	var idFactura;
	var curF = new FLSqlCursor("facturascli");
	while(curTab.next()) {
		util.setProgress(paso++);
// 		if (curTab.valueBuffer("nogenerarasiento")) continue;
		idFactura = curTab.valueBuffer("idfactura");
		var e = curTab.valueBuffer("editable");
		if (!e) {
			if (!AQUtil.execSql("UPDATE facturascli SET editable = true WHERE idfactura = " + idFactura)) {
				return false;
			}
		}
		curF.select("idfactura = " + idFactura);
		if (!curF.first()) {
			return false;
		}
		curF.setModeAccess(curF.Edit);
		curF.refreshBuffer();
		if (!curF.commitBuffer()) {
			return false;
		}
		if (!e) {
			if (!AQUtil.execSql("UPDATE facturascli SET editable = false WHERE idfactura = " + idFactura)) {
				return false;
			}
		}
	}
	util.destroyProgressDialog();	
}

function oficial_recibosCliQueFaltan() 
{
	var util:FLUtil = new FLUtil();
	var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
	
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("reciboscli,facturascli");
	q.setFrom("facturascli f left join reciboscli r on f.idfactura = r.idfactura");
	q.setSelect("f.idfactura");
	q.setWhere("r.idfactura is null");
	
	var curF:FLSqlCursor = new FLSqlCursor("facturascli");
	
	q.exec();
	
	util.createProgressDialog( util.translate( "scripts", "Generando recibos las facturas..." ), q.size());
	var paso:Number = 0;
	
	while(q.next()) {
		util.setProgress(paso++);
		curF.select("idfactura = " + q.value(0));
		if (curF.first()) {
			debug("Recibos de " + curF.valueBuffer("codigo"));
			flfactteso.iface.pub_regenerarRecibosCli(curF, "Emitido");
		}
	}
	
	util.destroyProgressDialog();	
}

function oficial_reubicarPartidasPagos()
{
	var util:FLUtil = new FLUtil();
	
	var ejercicio1:String = Input.getText( "Primer ejercicio: " );
	if (!ejercicio1)
		return;
	
	var ejercicio2:String = Input.getText( "Segundo ejercicio: " );
	if (!ejercicio2)
		return;
	
	var fechaInicio:String = util.sqlSelect("ejercicios", "fechainicio", "codejercicio = '" + ejercicio2 + "'")
	var fechaFin:String = util.sqlSelect("ejercicios", "fechafin", "codejercicio = '" + ejercicio2 + "'")
	
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("co_subcuentas,co_asientos,co_partidas");
	q.setFrom("co_asientos a inner join co_partidas p on a.idasiento=p.idasiento inner join co_subcuentas s on p.idsubcuenta=s.idsubcuenta");
	q.setSelect("p.idpartida, p.codsubcuenta");
	q.setWhere("s.codejercicio='" + ejercicio1 + "' AND a.fecha >= '" + fechaInicio + "' AND  a.fecha <= '" + fechaFin + "'");
	
	debug(q.sql());
	if(!q.exec())
		return;
		
	var curTab:FLSqlCursor = new FLSqlCursor("co_partidas");
	var idSubcuenta:Number;
	var paso:Number = 0;
	util.createProgressDialog( util.translate( "scripts", "Reubicando partidas..." ), q.size());
	
	while(q.next()) {
		curTab.select("idpartida = " + q.value(0));
		util.setProgress(paso++);
		if (curTab.first()) {
			idSubcuenta = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + q.value(1) + "' AND codejercicio = '" + ejercicio2 + "'");
			debug(paso + " Actualizando partida " + q.value(0) + " - subcuenta " + q.value(1) + " a " + idSubcuenta);
			curTab.setModeAccess(curTab.Edit);
			curTab.refreshBuffer();
			curTab.setValueBuffer("idsubcuenta", idSubcuenta);
			curTab.commitBuffer();
		}
	}
	
	util.destroyProgressDialog();	
}

/** \D
Busca facturas de proveedor asociadas a un pagaré que no existe
*/
function oficial_repararPagares()
{
	var util:FLUtil = new FLUtil();
	var paso:Number = 0;
	
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("facturasprov,recibosprov");
	q.setFrom("facturasprov f left outer join recibosprov r on f.idpagare=r.idrecibo");
	q.setSelect("f.idfactura, f.codigo");
	q.setWhere("(f.idpagare is not null AND f.idpagare>0) and (r.idrecibo is null OR r.idrecibo = 0)");
	
	debug(q.sql());
	if(!q.exec())
		return;
		
	var curTab:FLSqlCursor = new FLSqlCursor("facturasprov");
	util.createProgressDialog( util.translate( "scripts", "Reparando facturas..." ), q.size());
	
	while(q.next()) {
		curTab.select("idfactura = " + q.value(0));
		util.setProgress(paso++);
		if (curTab.first()) {
			debug(paso + " Actualizando factura " + q.value(1));
			curTab.setUnLock("editable", true);
			curTab.setModeAccess(curTab.Edit);
			curTab.refreshBuffer();
			curTab.setValueBuffer("idpagare", 0);
			curTab.commitBuffer();
		}
	}
	
	util.destroyProgressDialog();	

	q.setFrom("facturasprov f left outer join recibosprov r on f.idfactura=r.idfactura");
	q.setWhere("r.idrecibo is null and f.idpagare is null");
	debug(q.sql());
	if(!q.exec())
		return;
		
	util.createProgressDialog( util.translate( "scripts", "Reparando facturas..." ), q.size());
	
	while(q.next()) {
		curTab.select("idfactura = " + q.value(0));
		util.setProgress(paso++);
		if (curTab.first()) {
			debug(paso + " Actualizando factura " + q.value(1));
			curTab.setUnLock("editable", true);
			curTab.setModeAccess(curTab.Edit);
			curTab.refreshBuffer();
			curTab.setValueBuffer("idpagare", 0);
			curTab.commitBuffer();
		}
	}
	util.destroyProgressDialog();	
}

/** Establece el idpartida de los pagos de una remesa, si no los tiene
*/
function oficial_actualizarContabilidadRemesas()
{
	var util:FLUtil = new FLUtil();
	
	var idRemesa:String = Input.getText( "Remesa nº: " );
	if (!idRemesa)
		return;
	if (!util.sqlSelect("remesas", "idremesa", "idremesa = " + idRemesa))
		return;
	
	var paso:Number = 0;
	var idPartida:Number;
	
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("reciboscli,pagosdevolcli");
	q.setFrom("reciboscli r inner join pagosdevolcli p on r.idrecibo=p.idrecibo");
	q.setSelect("p.idpagodevol, r.codigo, p.idasiento");
	q.setWhere("p.idremesa = " + idRemesa);
	
	debug(q.sql());
	if(!q.exec())
		return;
		
	var curTab:FLSqlCursor = new FLSqlCursor("pagosdevolcli");
	util.createProgressDialog( util.translate( "scripts", "Actualizando pagos..." ), q.size());
	
	while(q.next()) {
		curTab.select("idpagodevol = " + q.value(0));
		util.setProgress(paso++);
		if (curTab.first()) {
			curTab.setActivatedCommitActions(false);
			idPartida = util.sqlSelect("co_partidas", "idpartida", "idasiento=" + q.value(2) + " and concepto like '%" + q.value(1) + "%';")
// 			curTab.setUnLock("editable", true);
			curTab.setModeAccess(curTab.Edit);
			curTab.refreshBuffer();
			curTab.setValueBuffer("idpartida", idPartida);
 			curTab.commitBuffer();
		}
	}
	
	util.destroyProgressDialog();	
}



function oficial_consolidarStocks()
{
	var util:FLUtil = new FLUtil();
	
	var paso:Number = 0;
	var numStocks:Number = 0;
	
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("articulos,stocks");
	q.setFrom("articulos a left outer join stocks s on a.referencia = s.referencia");
	q.setSelect("a.stockfis, a.referencia, s.idstock");
	q.setWhere("a.stockfis > 0");
	
	debug(q.sql());
	if(!q.exec())
		return;
		
	var curTab:FLSqlCursor = new FLSqlCursor("stocks");
	var codAlmacen:String = flfactppal.iface.pub_valorDefectoEmpresa("codalmacen");
	util.createProgressDialog( util.translate( "scripts", "Actualizando stocks..." ), q.size());
	
	while(q.next()) {
	
		util.setProgress(paso++);
		debug(q.value(0) + " " + q.value(1) + " " + q.value(2));
		
		if (q.value(2))
			continue;
	
		curTab.setModeAccess(curTab.Insert);
		curTab.refreshBuffer();
		curTab.setValueBuffer("cantidad", q.value(0));
		curTab.setValueBuffer("referencia", q.value(1));
		curTab.setValueBuffer("codalmacen", codAlmacen);
		
		debug("Insertando " + q.value(0) + " " + q.value(1));
		numStocks++;
 		curTab.commitBuffer();
	}
	
	util.destroyProgressDialog();	
	MessageBox.information(util.translate("scripts",  "Proceso finalizado.\n%0 stocks actualizados").arg(numStocks), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
}



/** Crea las subcuentas propias de los clientes que tienen por subcuenta la 43.0
*/
function oficial_subcuentasClientes()
{
	var util:FLUtil = new FLUtil();		
	var paso:Number = 0;
	var numClientes:Number = 0;

	var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
	var longSubcuenta:Number = util.sqlSelect("ejercicios", "longsubcuenta", "codejercicio = '" + codEjercicio + "'");
	var sctaClientes = flfacturac.iface.pub_datosCtaEspecial("CLIENT", codEjercicio);
	
	if (sctaClientes.error != 0) {
		MessageBox.warning(util.translate("scripts", "No tiene ninguna cuenta contable marcada como cuenta especial\nCLIENT.\nDebe asociar la cuenta a la cuenta especial en el módulo Principal del área Financiera"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
	
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("clientes,facturascli");
	q.setFrom("facturascli f inner join clientes c on f.codcliente=c.codcliente");
	q.setSelect("f.idasiento, f.codigo, c.codcliente, c.nombre");
	q.setWhere("c.codsubcuenta='" + sctaClientes.codsubcuenta + "' ORDER BY c.codcliente");
	
	debug(q.sql());
	if(!q.exec())
		return;
	
	var numCeros:Number;
	var idSubcuenta:Number;
	var codSubcuenta:String;
	var codCliente:String;
	
	util.createProgressDialog( util.translate( "scripts", "Actualizando subcuentas de cliente..." ), q.size());
	
	while(q.next()) {
	
		codCliente = q.value(2);
		codSubcuenta = "43";
		numCeros = longSubcuenta - codSubcuenta.length - codCliente.length;
		for (var i:Number = 0; i < numCeros; i++)
			codSubcuenta += "0";
	
		if (codSubcuenta.length + codCliente.length > longSubcuenta)
			codCliente = codCliente.right(longSubcuenta - codSubcuenta.length);
	
		codSubcuenta += codCliente;
		debug(codSubcuenta);
	
		// Actualizar clientes a la nueva subcuenta
		util.sqlUpdate("clientes", "codsubcuenta", codSubcuenta, "codcliente = '" + codCliente + "'");
		
		// Borrar registros de subcuentascli de la subcuenta estádar
		util.sqlDelete("co_subcuentascli", "codcliente = '" + codCliente + "' AND codejercicio = '" + codEjercicio + "' AND codSubcuenta = '" + sctaClientes.codsubcuenta + "'");
		
		idSubcuenta = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + codSubcuenta + "' AND codejercicio = '" + codEjercicio + "'");
		if (!idSubcuenta) {
			idSubcuenta = flfactppal.iface.pub_crearSubcuenta(codSubcuenta, q.value(3), "CLIENT", codEjercicio);
			flfactppal.iface.pub_crearSubcuentaCli(codSubcuenta, idSubcuenta, codCliente, codEjercicio);
			numClientes++;
		}
			
		util.setProgress(paso++);
	}
	
	util.destroyProgressDialog();	
	MessageBox.information(util.translate("scripts",  "Proceso finalizado.\n%0 clientes actualizados").arg(numClientes), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);

	this.iface.consolidarSubcuentasClientes();
}

/**
Migra los asientos de las facturas de dichos clientes a la subcuentas propias recien creadas
*/
function oficial_consolidarSubcuentasClientes()
{
	var util:FLUtil = new FLUtil();	
	var paso:Number = 0;
	var numClientes:Number = 0;

	var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
	var longSubcuenta:Number = util.sqlSelect("ejercicios", "longsubcuenta", "codejercicio = '" + codEjercicio + "'");
	var sctaClientes = flfacturac.iface.pub_datosCtaEspecial("CLIENT", codEjercicio);
	
	if (sctaClientes.error != 0) {
		MessageBox.warning(util.translate("scripts", "No tiene ninguna cuenta contable marcada como cuenta especial\nCLIENT.\nDebe asociar la cuenta a la cuenta especial en el módulo Principal del área Financiera"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
	
	var curTab:FLSqlCursor = new FLSqlCursor("co_partidas");
	
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("co_partidas,co_asientos");
	q.setFrom("co_partidas p inner join co_asientos a on p.idasiento = a.idasiento");
	q.setSelect("p.idpartida,p.idasiento,a.numero");
	q.setWhere("p.idsubcuenta = '" + sctaClientes.idsubcuenta + "' AND a.codejercicio='" + codEjercicio + "' ORDER BY a.numero");
	q.exec();
	
	util.createProgressDialog( util.translate( "scripts", "Actualizando movimientos..." ), q.size());
	
	while(q.next())	{
	
		util.setProgress(paso++);
		
		idPartida = q.value(0);
		idAsiento = q.value(1);
	
		// Es de factura?
		codSubcuenta = util.sqlSelect("facturascli f inner join clientes c on f.codcliente = c.codcliente", "c.codsubcuenta", "idasiento = " + idAsiento, "facturascli,clientes");
		
		// Es de pago/dev?
		if (!codSubcuenta)
			codSubcuenta = util.sqlSelect("pagosdevolcli p inner join reciboscli r on p.idrecibo = r.idrecibo inner join clientes c on r.codcliente = c.codcliente", "c.codsubcuenta", "idasiento = " + idAsiento, "facturascli,clientes");
			
		if (!codSubcuenta)
			continue;
			
		if (codSubcuenta == sctaClientes.codsubcuenta) {
			debug("Subcuenta de cliente no encontrada para el asiento " + q.value(2));
			continue;
		}
	
		idSubcuenta = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + codSubcuenta + "' and codejercicio = '" + codEjercicio + "'");
		if (!idSubcuenta)
			continue;
			
		debug("Asiento " + q.value(2));
		util.sqlUpdate("co_partidas", "idsubcuenta,codsubcuenta", idSubcuenta + "," + codSubcuenta, "idpartida = " + idPartida);
	}
	
	util.destroyProgressDialog();
	
	return;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("clientes,facturascli,reciboscli,pagosdevolcli");
	q.setFrom("pagosdevolcli p INNER JOIN reciboscli r ON p.idrecibo = r.idrecibo INNER JOIN facturascli f ON r.idfactura = f.idfactura INNER JOIN clientes c ON f.codcliente = c.codcliente");
	q.setSelect("f.idasiento, p.idasiento, c.codsubcuenta, f.codigo, r.codigo, c.codcliente");
	q.setWhere("f.codejercicio='" + codEjercicio + "' ORDER BY c.codcliente");
	
	debug(q.sql())
	
	if(!q.exec())
		return;
	
	var idSubcuenta:Number;
	var codSubcuenta:String;
	var codCliente:String;
	
	util.createProgressDialog( util.translate( "scripts", "Actualizando movimientos..." ), q.size());
	
	while(q.next()) {
	
		util.setProgress(paso++);
		util.setLabelText("Actualizando cliente " + q.value(5));
	
		codSubcuenta = q.value(2);
		idSubcuenta = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + codSubcuenta + "' AND codejercicio = '" + codEjercicio + "'");
		
		debug(idSubcuenta)
		
		if (idSubcuenta) {
			// Asiento de la factura
   			util.sqlUpdate("co_partidas", "idsubcuenta,codsubcuenta", idSubcuenta + "," + codSubcuenta, "idasiento = " + q.value(0) + " AND codsubcuenta = '" + sctaClientes.codsubcuenta + "'");
  			debug("actualizando asiento " + q.value(0) + " de factura " + q.value(3));
  			
			// Asiento(s) del (de los) recibo(s)
   			debug("idsubcuenta,codsubcuenta    " +  idSubcuenta + "," + codSubcuenta + "      idasiento = " + q.value(1) + " AND codsubcuenta = '" + sctaClientes.codsubcuenta + "'");
   			debug(util.sqlUpdate("co_partidas", "idsubcuenta,codsubcuenta", idSubcuenta + "," + codSubcuenta, "idasiento = " + q.value(1) + " AND codsubcuenta = '" + sctaClientes.codsubcuenta + "'"));
  			debug("actualizando asiento " + q.value(1) + " de recibo " + q.value(4));
		}
			
	}
	
	util.destroyProgressDialog();	
	
	MessageBox.information(util.translate("scripts",  "Proceso finalizado"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
}


/**
Busca y repara los asientos que tienen partidas en más de un ejercicio
*/
function oficial_repararAsientosMultiejercicio()
{
	var util:FLUtil = new FLUtil();	
	var paso:Number = 0;
	
	var q:FLSqlQuery = new FLSqlQuery();
	
	q.setSelect("a.codejercicio,s.codsubcuenta,p.idpartida,a.numero");
	q.setTablesList("co_subcuentas,co_partidas,co_asientos");
	q.setFrom("co_partidas p inner join co_asientos a on p.idasiento = a.idasiento inner join co_subcuentas s on p.idsubcuenta = s.idsubcuenta");
	q.setWhere("a.codejercicio <> s.codejercicio order by a.codejercicio, a.numero");
	
	if (!q.exec())
		return;
	
	var codEjercicio:String, codSubcuenta:String, idPartida:Number, idSubcuenta:Number;
	var curTab:FLSqlCursor = new FLSqlCursor("co_partidas");
	
	util.createProgressDialog( util.translate( "scripts", "Actualizando movimientos..." ), q.size());
	
	while(q.next()) {
		
		util.setProgress(paso++);
		util.setLabelText("Reparando el asiento " + q.value(3) + " del ejercicio " + q.value(0));
		
		codEjercicio = q.value(0);
		codSubcuenta = q.value(1);
		idPartida = q.value(2);
		
		idSubcuenta = util.sqlSelect("co_subcuentas", "idsubcuenta", "codejercicio = '" + codEjercicio + "' AND codsubcuenta = '" + codSubcuenta + "'");
		if (!idSubcuenta)
			continue;
	
		curTab.select("idpartida = " + idPartida);
		if (!curTab.first())
			continue;
			
		curTab.setModeAccess(curTab.Edit);
		curTab.refreshBuffer();
		curTab.setValueBuffer("idsubcuenta", idSubcuenta);
 		curTab.commitBuffer();

		debug("Reparando asiento " + q.value(3));
	}
	
	util.destroyProgressDialog();	
	
	var mensaje:String;
	if (paso)
		mensaje = util.translate("scripts", "Proceso finalizado. Asientos reparados: ") + paso;
	else
		mensaje = util.translate("scripts", "No se encontraron asientos para reparar") ;
		
	MessageBox.information(mensaje, MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
}



function oficial_repararPartidasIVA()
{
	var util:FLUtil = new FLUtil();	
	var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
	
	var paso:Number = 0, numAsientos:Number = 0;	
	var error:String = "";
	var idPartida:Number, idAsiento:Number, idPartidaProv:Number, idPartidaCompra:Number;
	var valorIVA:Number, valorBI:Number, valorTotal:Number;
	
	var q:FLSqlQuery = new FLSqlQuery();
	
	q.setSelect("p.idpartida,p.debe,a.idasiento,p.idsubcuenta,a.numero,p.concepto");
	q.setTablesList("co_subcuentas,co_partidas,co_asientos");
	q.setFrom("co_partidas p inner join co_asientos a on p.idasiento = a.idasiento inner join co_subcuentas s on p.idsubcuenta = s.idsubcuenta");
	q.setWhere("p.codsubcuenta LIKE '472%' AND (p.idcontrapartida = 0 OR p.idcontrapartida IS NULL) AND a.codejercicio = '" + codEjercicio + "' order by a.numero");
	
	if (!q.exec())
		return;
	
	var curTab:FLSqlCursor = new FLSqlCursor("co_partidas");
	
	util.createProgressDialog( util.translate( "scripts", "Actualizando partidas de I.V.A." ), q.size());
	
	while(q.next()) {
		
		util.setProgress(paso++);
		
		idPartida = q.value(0);
		valorIVA = q.value(1);
		idAsiento = q.value(2);
		concepto = q.value(5);
		
		valorBI = parseFloat(valorIVA / 0.16);
		valorTotal = parseFloat(valorBI) + parseFloat(valorIVA);
		
		debug(valorIVA + " " + valorBI + " " + valorTotal);
		
		idContrapartida = util.sqlSelect("co_partidas", "idsubcuenta", "idasiento=" + idAsiento + " AND (codsubcuenta like '40%' OR codsubcuenta like '41%') AND round(haber) = " + Math.round(valorTotal));
		debug("idasiento=" + idAsiento + " AND (codsubcuenta like '40%' OR codsubcuenta like '41%') AND round(haber) = " + Math.round(valorTotal));
		
		// Si no se busca una con base imponible igual a total
		if (!idContrapartida) {
			idContrapartida = util.sqlSelect("co_partidas", "idsubcuenta", "idasiento=" + idAsiento + " AND (codsubcuenta like '40%' OR codsubcuenta like '41%') AND round(haber) = " + Math.round(valorBI));
			debug("idasiento=" + idAsiento + " AND (codsubcuenta like '40%' OR codsubcuenta like '41%') AND round(haber) = " + Math.round(valorBI));
			if (!idContrapartida) {
				error += "\nAsiento " + q.value(4) + " con IVA " + valorIVA + " y concepto: " + concepto;
				continue;
			}
		}
		
		codContrapartida = util.sqlSelect("co_subcuentas", "codsubcuenta", "idsubcuenta = " + idContrapartida);
		iva = 16;
		codSerie = "A";
				
/*		idPartidaCompra = util.sqlSelect("co_partidas", "idpartida", "idasiento=" + idAsiento + " AND codsubcuenta like '4%' AND debe = " + valorBI);
		if (!idPartidaCompra) {
			error += "\nAsiento " + idAsiento + " con IVA " + valorIVA;
			continue;
		}*/
			
		curTab.select("idpartida = " + idPartida);
		if (!curTab.first())
			continue;
			
		curTab.setModeAccess(curTab.Edit);
		curTab.refreshBuffer();
		curTab.setValueBuffer("baseimponible", valorBI);
		curTab.setValueBuffer("idcontrapartida", idContrapartida);
		curTab.setValueBuffer("codcontrapartida", codContrapartida);
		curTab.setValueBuffer("iva", iva);
		curTab.setValueBuffer("codserie", codSerie);

		debug("baseimponible"+ " " +  valorBI);
		debug("idcontrapartida"+ " " +  idContrapartida);
		debug("codcontrapartida"+ " " +  codContrapartida);
		debug("iva"+ " " +  iva);
		debug("codserie " + codSerie);

  		curTab.commitBuffer();

		numAsientos++;

	}
	
	util.destroyProgressDialog();	
	
	var mensaje:String;
	if (error)
		mensaje = util.translate("scripts", "Proceso finalizado. Se repararon %0 asientos.\nNo se puedieron reparar los asientos siguientes:\n").arg(numAsientos) + error;
	else
		mensaje = util.translate("scripts", "Se repararon %0 asientos").arg(paso) ;
		
	MessageBox.information(mensaje, MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
}


function oficial_eliminarContabilidadSerie()
{
	var util:FLUtil = new FLUtil();	
	
	var codEjercicio:String = Input.getText( "Ejercicio: " );
	if (!codEjercicio)
		return;
	if (!util.sqlSelect("ejercicios", "codejercicio", "codejercicio = '" + codEjercicio + "'")) {
		MessageBox.information("No existe este ejercicio", MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return;
	}
	
	var codSerie:String = Input.getText( "Serie " );
	if (!codSerie)
		return;
	if (!util.sqlSelect("series", "codserie", "codserie = '" + codSerie + "'")) {
		MessageBox.information("No existe esta serie", MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return;
	}
	
	var paso:Number = 0, numAsientos:Number = 0;	
	var error:String = "";
	var idAsiento:Number;
	
	var curA:FLSqlCursor = new FLSqlCursor("co_asientos");
	curA.setActivatedCheckIntegrity(false);
	
	// 1. Facturas de cliente	
	var curTab:FLSqlCursor = new FLSqlCursor("facturascli");
	var curTab2:FLSqlCursor = new FLSqlCursor("facturascli");
	curTab.setActivatedCheckIntegrity(false);
	curTab2.setActivatedCheckIntegrity(false);
	curTab.select("codserie = '" + codSerie + "' AND codejercicio = '" + codEjercicio + "' order by codigo");
	
	util.createProgressDialog( util.translate( "scripts", "Eliminando asientos de factura de cliente" ), curTab.size());
	
	while(curTab.next()) {
		
		util.setProgress(paso++);
		
		idAsiento = curTab.valueBuffer("idasiento");
		if (!idAsiento)
			continue;
		
		curTab2.select("idfactura = " + curTab.valueBuffer("idfactura"));
		curTab2.first();
		curTab2.setUnLock("editable", true);
		
		curTab.setModeAccess(curTab.Edit);
		curTab.refreshBuffer();
		curTab.setValueBuffer("nogenerarasiento", true);
		curTab.setNull("idasiento");
		curTab.commitBuffer();
		
		curA.select("idasiento = " + idAsiento);
		
		if (curA.first()) {
			curA.setUnLock("editable", true);
			curA.setModeAccess(curA.Del);
			curA.refreshBuffer();
			if (!curA.commitBuffer()) {
				util.destroyProgressDialog();	
				return false;
			}
		}
	}
	
	
	
	// 2. Facturas de proveedor	
	var curTab:FLSqlCursor = new FLSqlCursor("facturasprov");
	var curTab2:FLSqlCursor = new FLSqlCursor("facturasprov");
	curTab.setActivatedCheckIntegrity(false);
	curTab2.setActivatedCheckIntegrity(false);
	curTab.select("codserie = '" + codSerie + "' AND codejercicio = '" + codEjercicio + "' order by codigo");
	
	util.createProgressDialog( util.translate( "scripts", "Eliminando asientos de factura de proveedor" ), curTab.size());
	
	while(curTab.next()) {
		
		util.setProgress(paso++);
		
		idAsiento = curTab.valueBuffer("idasiento");
		if (!idAsiento)
			continue;
		
		curTab2.select("idfactura = " + curTab.valueBuffer("idfactura"));
		curTab2.first();
		curTab2.setUnLock("editable", true);
		
		curTab.setModeAccess(curTab.Edit);
		curTab.refreshBuffer();
		curTab.setValueBuffer("nogenerarasiento", true);
		curTab.setNull("idasiento");
		curTab.commitBuffer();
		
		curA.select("idasiento = " + idAsiento);
		
		if (curA.first()) {
			curA.setUnLock("editable", true);
			curA.setModeAccess(curA.Del);
			curA.refreshBuffer();
			if (!curA.commitBuffer()) {
				util.destroyProgressDialog();	
				return false;
			}
		}
	}
	
	util.destroyProgressDialog();
	
	
	// 2. PAgos y devoluciones de cliente
	var curTab:FLSqlCursor = new FLSqlCursor("pagosdevolcli");
	var curTab2:FLSqlCursor = new FLSqlCursor("pagosdevolcli");
	curTab.setActivatedCheckIntegrity(false);
	curTab2.setActivatedCheckIntegrity(false);
	curTab.select("codserie = '" + codSerie + "' AND codejercicio = '" + codEjercicio + "' order by codigo");
	
	util.createProgressDialog( util.translate( "scripts", "Eliminando asientos de factura de proveedor" ), curTab.size());
	
	while(curTab.next()) {
		
		util.setProgress(paso++);
		
		idAsiento = curTab.valueBuffer("idasiento");
		if (!idAsiento)
			continue;
		
		curTab2.select("idfactura = " + curTab.valueBuffer("idfactura"));
		curTab2.first();
		curTab2.setUnLock("editable", true);
		
		curTab.setModeAccess(curTab.Edit);
		curTab.refreshBuffer();
		curTab.setValueBuffer("nogenerarasiento", true);
		curTab.setNull("idasiento");
		curTab.commitBuffer();
		
		curA.select("idasiento = " + idAsiento);
		
		if (curA.first()) {
			curA.setUnLock("editable", true);
			curA.setModeAccess(curA.Del);
			curA.refreshBuffer();
			if (!curA.commitBuffer()) {
				util.destroyProgressDialog();	
				return false;
			}
		}
	}
	
	var mensaje:String = util.translate("scripts", "Se eliminaron %0 asientos").arg(paso) ;
		
	MessageBox.information(mensaje, MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
}

function oficial_subcuentasProv()
{
	var util:FLUtil = new FLUtil();	
	var codSubcuentaNew:Number = 4000000001;
	codEjercicio = "2008";
	var codCuentaProv:String = "4000";
	var idCuentaProv:Number = util.sqlSelect("co_cuentas", "idcuenta", "codejercicio = '" + codEjercicio + "' AND codcuenta = '4000'");
	debug("IIIIIIIIIIII");
	debug(idCuentaProv);
	
	var curTab:FLSqlCursor = new FLSqlCursor("proveedores");
	var curTabS:FLSqlCursor = new FLSqlCursor("co_subcuentas");
	
	curTab.setActivatedCommitActions(false);
	curTabS.setActivatedCommitActions(false);
	
	curTab.select("codsubcuenta like '40004%' OR codsubcuenta like '40005%' order by codsubcuenta");
	
	util.createProgressDialog( util.translate( "scripts", "Reparando..." ), curTab.size() );
	var paso:Number = 0;
	
	while(curTab.next()) {
		codProveedor = curTab.valueBuffer("codproveedor");
		idSubcuentaAnt = curTab.valueBuffer("idsubcuenta");
		codSubcuentaAnt = curTab.valueBuffer("codsubcuenta");
		while (util.sqlSelect("co_subcuentas", "codsubcuenta", "codejercicio = '" + codEjercicio + "' AND codsubcuenta = '" + codSubcuentaNew + "'"))
			codSubcuentaNew++;
			
		debug(codProveedor);
		debug(codSubcuentaAnt + " --> " + codSubcuentaNew);
			
		// Crear la cuenta
		curTabS.setModeAccess(curTabS.Insert);
		curTabS.refreshBuffer();
		curTabS.setValueBuffer("idcuenta", idCuentaProv);
		curTabS.setValueBuffer("codcuenta", codCuentaProv);
		curTabS.setValueBuffer("codsubcuenta", codSubcuentaNew);
		curTabS.setValueBuffer("descripcion", curTab.valueBuffer("nombre"));
		curTabS.setValueBuffer("codejercicio", codEjercicio);
		curTabS.setValueBuffer("debe", 0);
		curTabS.setValueBuffer("haber", 0);
		curTabS.setValueBuffer("saldo", 0);
		curTabS.setValueBuffer("recargo", 0);
		curTabS.setValueBuffer("iva", 0);
		curTabS.setValueBuffer("coddivisa", "EUR");
  		curTabS.commitBuffer();
		
		// Actualizar subcuentasprov
		idSubcuentaNew = util.sqlSelect("co_subcuentas", "idsubcuenta", "codejercicio = '" + codEjercicio + "' AND codsubcuenta = '" + codSubcuentaNew + "'");
 		util.sqlUpdate("co_subcuentasprov", "idsubcuenta,codsubcuenta", idSubcuentaNew + "," + codSubcuentaNew, "codejercicio = '" + codEjercicio + "' AND codproveedor = '" + codProveedor + "'");
		
		debug(idSubcuentaNew + "," + codSubcuentaNew + "  codejercicio = '" + codEjercicio + "' AND codproveedor = '" + codProveedor + "'");
		
		// Movimientos
//  		this.iface.traspasoSubcta(idSubcuentaAnt, idSubcuentaNew, codSubcuentaAnt, codSubcuentaNew);
		debug(idSubcuentaAnt + " " + idSubcuentaNew + " " + codSubcuentaAnt + " " + codSubcuentaNew);
		
		curTab.setModeAccess(curTab.Edit);
		curTab.refreshBuffer();
		curTab.setValueBuffer("codsubcuenta", codSubcuentaNew);
		curTab.setValueBuffer("idsubcuenta", idSubcuentaNew);
		curTab.commitBuffer();
		
		
		util.setProgress(paso++);		
	}
	util.destroyProgressDialog();	
	var mensaje:String = util.translate("scripts", "Proceso finalizado");
	MessageBox.information(mensaje, MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
}

function oficial_traspasoSubcta(idSubctaOri:Number, idSubctaDes:Number, codSubctaOri:Number, codSubctaDes:Number)
{
	var util:FLUtil = new FLUtil();
	
	codEjercicio = "2008";
	if (!util.sqlSelect("co_subcuentas", "idsubcuenta", "idsubcuenta = " + idSubctaOri) || !util.sqlSelect("co_subcuentas", "idsubcuenta", "idsubcuenta = " + idSubctaDes)) {
		MessageBox.warning( util.translate( "scripts", "Las subcuentas de origen y/o destino no son válidas"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return;
	}
		
	if (idSubctaOri != util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = " + codSubctaOri + " AND codejercicio = '" + codEjercicio + "'")
			|| idSubctaDes != util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = " + codSubctaDes + " AND codejercicio = '" + codEjercicio + "'")) {
		MessageBox.warning( util.translate( "scripts", "Las subcuentas de origen y/o destino no son válidas"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return;
	}
		
	var res:Object = MessageBox.information(util.translate("scripts", "A continuación todos los apuntes contables de la subcuenta origen pasarán a la subcuenta destino\npara el ejercicio %0\n\n¿Continuar?").arg(codEjercicio), MessageBox.No, MessageBox.Yes, MessageBox.NoButton);
	if (res != MessageBox.Yes)
		return;
	
	res = util.sqlUpdate("co_partidas", "idsubcuenta,codsubcuenta", idSubctaDes + "," + codSubctaDes, "idsubcuenta = " + idSubctaOri);
	if (!res) {
		MessageBox.warning( util.translate( "scripts", "Hubo un problema en la actualización"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return;
	}
	
	flcontppal.iface.pub_calcularSaldo(idSubctaOri);
	flcontppal.iface.pub_calcularSaldo(idSubctaDes);
}

function oficial_partidasCC()
{
	var util:FLUtil = new FLUtil();
	
	var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
	
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("facturascli,lineasfacturascli");
	q.setFrom("facturascli f inner join lineasfacturascli l on f.idfactura = l.idfactura");
	q.setWhere("f.codejercicio = '" + codEjercicio + "' AND f.codcentro IS NOT NULL AND f.codcentro <> '' AND (l.codcentro IS NULL OR l.codcentro = '') GROUP BY f.codigo,f.idfactura,f.codcentro,f.codsubcentro");
	q.setSelect("f.codigo,f.idfactura,f.codcentro,f.codsubcentro");
	
	if (!q.exec())
		return;
		
	var curF:FLSqlCursor = new FLSqlCursor("facturascli");
		
	util.createProgressDialog( util.translate( "scripts", "Eliminando asientos de factura de proveedor" ), q.size());
	var paso:Number = 0;
	
	while (q.next()) {
	
		util.setProgress(paso++);
		util.setLabelText("Generando partidas CC para la factura " + q.value(0));
		
		util.sqlUpdate("lineasfacturascli", "codcentro,codsubcentro", q.value(2) + "," + q.value(3), "idfactura = " + q.value(1));
		 
		curF.select("idfactura = " + q.value(1));
		if (curF.first())
			flfacturac.iface.crearPartidasCC(curF);
	
		debug(q.value(0) + " " + q.value(1) + " " + q.value(2) + " " + q.value(3));
	}

	util.destroyProgressDialog();

	var mensaje:String = util.translate("scripts", "Proceso finalizado. Facturas actualizadas " + paso);
	MessageBox.information(mensaje, MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
}

function oficial_subcuentasCliProv()
{
	var util:FLUtil = new FLUtil;
	var i:Number = 0;
	
	var qryClientes:FLSqlQuery = new FLSqlQuery();
	qryClientes.setTablesList("clientes");
	qryClientes.setSelect("codcliente, codsubcuenta, nombre");
	qryClientes.setFrom("clientes");
	qryClientes.setWhere("codsubcuenta IS NOT NULL AND codsubcuenta <> ''");debug(qryClientes.sql());
	if (!qryClientes.exec())
		return;
	util.createProgressDialog(util.translate("scripts", "Creando subcuentas por cliente"), qryClientes.size());
	util.setProgress(0);
	while (qryClientes.next()) {
		flfactppal.iface.pub_rellenarSubcuentasCli(qryClientes.value(0), qryClientes.value(1), qryClientes.value(2));
		util.setProgress(i++);
	}
	util.setProgress(qryClientes.size());
	util.destroyProgressDialog();
	
	var numC:Number = i;
	i = 0;
		
	var qryProveedores:FLSqlQuery = new FLSqlQuery();
	qryProveedores.setTablesList("proveedores");
	qryProveedores.setSelect("codproveedor, codsubcuenta, nombre");
	qryProveedores.setFrom("proveedores");
	qryProveedores.setWhere("codsubcuenta IS NOT NULL AND codsubcuenta <> ''");
	if (!qryProveedores.exec())
		return;
	util.createProgressDialog(util.translate("scripts", "Creando subcuentas por proveedor"), qryProveedores.size());
	util.setProgress(0);
	while (qryProveedores.next()) {
		flfactppal.iface.pub_rellenarSubcuentasProv(qryProveedores.value(0), qryProveedores.value(1), qryProveedores.value(2));
		util.setProgress(i++);
	}
	util.setProgress(qryProveedores.size());
	util.destroyProgressDialog();
	
	var numP:Number = i;
	
	MessageBox.information(util.translate("scripts",  "Proceso finalizado. Se comprobaron %0 subcuentas por cliente y %0 subcuentas por proveedor").arg(numC).arg(numP), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
}

function oficial_stocksFromStockFis()
{
	var util:FLUtil = new FLUtil();
	
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("articulos,stocks");
	q.setFrom("articulos a left join stocks s on a.referencia=s.referencia");
	q.setWhere("a.stockfis > 0 and (s.codalmacen is null OR s.codalmacen = '')");
	q.setSelect("a.referencia,a.stockfis");
	
	if (!q.exec())
		return;
		
	var curTab:FLSqlCursor = new FLSqlCursor("stocks");
		
	util.createProgressDialog( util.translate( "scripts", "Creando stocks" ), q.size());
	var paso:Number = 0;
	
	while (q.next()) {
	
		util.setProgress(paso++);
		util.setLabelText("Generando stock para " + q.value(0));
		
		curTab.setModeAccess(curTab.Insert);
		curTab.refreshBuffer();
		curTab.setValueBuffer("codalmacen", "ALG");
		curTab.setValueBuffer("nombre", "Almacen general");
		curTab.setValueBuffer("referencia", q.value(0));
		curTab.setValueBuffer("cantidad", q.value(1));
		curTab.commitBuffer();
	}

	util.destroyProgressDialog();

	var mensaje:String = util.translate("scripts", "Proceso finalizado. Stocks creados " + paso);
	MessageBox.information(mensaje, MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
}

function oficial_completarCopiaSubcuentas()
{
	var util:FLUtil = new FLUtil;	
	
	var ejercicioAnt:String = Input.getText( "Ejercicio origen: " );
	if (!ejercicioAnt || !util.sqlSelect("ejercicios", "codejercicio", "codejercicio = '" + ejercicioAnt + "'")) {
		MessageBox.warning(util.translate("scripts",  "El ejercicio origen no es válido"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return;
	}
	
	var ejercicioAct:String = Input.getText( "Ejercicio destino: " );
	if (!ejercicioAct || !util.sqlSelect("ejercicios", "codejercicio", "codejercicio = '" + ejercicioAct + "'")) {
		MessageBox.warning(util.translate("scripts",  "El ejercicio destino no es válido"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return;
	}

	if (ejercicioAct == ejercicioAnt) {
		MessageBox.warning(util.translate("scripts",  "El ejercicio destino no puede ser igual al origen"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return;
	}

	var longSubcuenta:Number = util.sqlSelect("ejercicios", "longsubcuenta", "codejercicio = '" + ejercicioAct + "'");
	var planContableAnt = util.sqlSelect("ejercicios", "plancontable", "codejercicio = '" + ejercicioAnt + "'");
	var paso:Number = 0;	
	var numNuevas:Number = 0;	
	var numCuentasPerdidas = 0;	
	
	var qrySubCuentas:FLSqlQuery = new FLSqlQuery;			
	qrySubCuentas.setTablesList ("co_subcuentas");
	qrySubCuentas.setSelect("codsubcuenta,codcuenta,descripcion,coddivisa,codimpuesto,iva,recargo,saldo");
	qrySubCuentas.setFrom("co_subcuentas");
	qrySubCuentas.setWhere("codejercicio = '" + ejercicioAnt + "' order by codsubcuenta");
	
	if (!qrySubCuentas.exec())
		return;

	util.createProgressDialog(util.translate("scripts", "Copiando Subcuentas"), qrySubCuentas.size());
	
	var curSubCuentas:FLSqlCursor = new FLSqlCursor ("co_subcuentas");
	curSubCuentas.setActivatedCommitActions(false);

	var cuentasPerdidas:String = "";
	var subcuentasPerdidas:String = "";
	
	while(qrySubCuentas.next()) {
	
		util.setProgress(paso++);
	
		// Caso 1: de 90 a 08
		if (planContableAnt != "08") {
			// A qué cuenta 08 corresponde esta cuenta 90?
			codCuenta08 = flcontppal.iface.convertirCodCuenta(qrySubCuentas.value(1));
			idCuenta08 = util.sqlSelect("co_cuentas", "idcuenta", "codcuenta = '" + codCuenta08 + "' and codejercicio = '" + ejercicioAct + "'");
			
			if (!idCuenta08) {
				//Si no hay saldo, se ignora
				if (parseFloat(qrySubCuentas.value(7)))
					subcuentasPerdidas += "\n" + qrySubCuentas.value(1) + " " + qrySubCuentas.value(0);
				continue;
			}
			
			codSubcuenta08 = flcontppal.iface.convertirCodSubcuenta(ejercicioAnt, qrySubCuentas.value(0));
		}
		
		// Caso 2: de 08 a 08
		else {
			codCuenta08 = qrySubCuentas.value(1);
			idCuenta08 = util.sqlSelect("co_cuentas", "idcuenta", "codcuenta = '" + codCuenta08 + "' and codejercicio = '" + ejercicioAct + "'");
			codSubcuenta08 = qrySubCuentas.value(0);
			codCuentaAviso = codCuenta08;
			if (!idCuenta08) {

				// Si es de 3, comprobamos si existe una de 4 con un cero más
				if(codCuenta08.length == 3)
					codCuenta08 += "0";

				idCuenta08 = util.sqlSelect("co_cuentas", "idcuenta", "codcuenta = '" + codCuenta08 + "' and codejercicio = '" + ejercicioAct + "'");
				if (!idCuenta08) {
					if (cuentasPerdidas.search(codCuentaAviso) == -1) {

						if (cuentasPerdidas)
							cuentasPerdidas += ", ";

						if (numCuentasPerdidas++ == 10) {
							cuentasPerdidas += "\n";
							numCuentasPerdidas = 0;
						}

						cuentasPerdidas += codCuentaAviso;

					}
					debug(codCuenta08 + " " + codSubcuenta08);
					continue;
				}
			}
		}
		
		// Existe ya?
		curSubCuentas.select("codsubcuenta = '" + codSubcuenta08 + "' AND codejercicio = '" + ejercicioAct + "'");
		if (curSubCuentas.first())
			continue;
			
		// La descripcion no debe tener ya el código antes. "225. Otras instalaciones" -> "Otras instalaciones"
		descripcion = qrySubCuentas.value(2);
		
		curSubCuentas.setModeAccess (curSubCuentas.Insert);
		curSubCuentas.refreshBuffer();
		curSubCuentas.setValueBuffer("codejercicio",ejercicioAct);
		curSubCuentas.setValueBuffer("codsubcuenta",codSubcuenta08);
		curSubCuentas.setValueBuffer("idcuenta",idCuenta08);
		curSubCuentas.setValueBuffer("codcuenta",codCuenta08);
		curSubCuentas.setValueBuffer("descripcion",descripcion);
		curSubCuentas.setValueBuffer("coddivisa",qrySubCuentas.value(3));
		curSubCuentas.setValueBuffer("codimpuesto",qrySubCuentas.value(4));
		curSubCuentas.setValueBuffer("iva",qrySubCuentas.value(5));
		if (!curSubCuentas.commitBuffer())
			return;

		numNuevas++;
	}
	
	util.destroyProgressDialog();
	
	// Genera las subcuentas del nuevo PGC que no existen en el ejercicio anterior
	flcontppal.iface.generarSubcuentas(ejercicioAct, longSubcuenta);
	
// 	if (!formRecordejercicios.iface.copiarSubcuentasCliProv(ejercicioAnt, ejercicioAct))
// 		return false;
	
	if (!this.iface.subcuentasCliProv(ejercicioAnt, ejercicioAct))

	if (cuentasPerdidas)
		MessageBox.information(util.translate("scripts", "Las subcuentas de las siguientes cuentas no se pudieron copiar\nporque las cuentas no existen en el ejercicio destino.\n Deberá crear las cuentas y repetir el proceso") + "\n\n" + cuentasPerdidas,
				 MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);

	if (subcuentasPerdidas)
		MessageBox.information(util.translate("scripts", "Las siguientes cuentas/subcuentas con saldo no se pudieron copiar\nporque no existe una correspondencia con el nuevo plan contable\nDeberá migrar su saldo a otras cuentas antes de cerrar el ejercicio:") + "\n" + subcuentasPerdidas,
				 MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);

	MessageBox.information(util.translate("scripts", "Proceso finalizado. Se crearon %0 nuevas subcuentas").arg(numNuevas),
			 MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
}

function oficial_actualizarCodigosBalanceCuenta()
{
	var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
	var util:FLUtil = new FLUtil();
		
	var datos =	[["1","1. FINANCIACION BASICA","EPI","1","","1","",""],
				["2","10. CAPITAL","EPI","10","1","10","",""],
				["1","100. Capital social","CUE","100","2","10","","P-A-I"],
				["2","1000. Capital ordinario","CUE","1000","2","10","","P-A-I"],
				["3","1001. Capital privilegiado","CUE","1001","2","10","","P-A-I"],
				["4","1002. Capital sin derecho a voto","CUE","1002","2","10","","P-A-I"],
				["5","1003. Capital con derechos restringidos","CUE","1003","2","10","","P-A-I"],
				["6","101. Fondo social","CUE","101","2","10","","P-A-I"],
				["7","102. Capital","CUE","102","2","10","","P-A-I"],
				["3","11. RESERVAS","EPI","11","1","11","",""],
				["8","110. Prima de emision de acciones","CUE","110","3","11","","P-A-II"],
				["9","111. Reservas de revalorización","CUE","111","3","11","","P-A-III"],
				["10","112. Reserva legal","CUE","112","3","11","","P-A-IV-1"],
				["11","113. Reservas especiales","CUE","113","3","11","","P-A-IV-5"],
				["12","114. Reservas para acciones de la sociedad dominante","CUE","114","3","11","","P-A-IV-3"],
				["13","115. Reservas para acciones propias","CUE","115","3","11","","P-A-IV-2"],
				["14","116. Reservas estatutarias","CUE","116","3","11","","P-A-IV-4"],
				["15","117. Reservas voluntarias","CUE","117","3","11","","P-A-IV-5"],
				["16","118. Reserva por capital amortizado","CUE","118","3","11","","P-A-IV-5"],
				["17","119. Diferencias por ajuste del capital a euros","CUE","119","3","11","","P-A-IV-5"],
				["4","12. RESULTADOS PENDIENTES DE APLICACION","EPI","12","1","12","",""],
				["18","120. Remanente","CUE","120","4","12","PREVIO","P-A-V-1"],
				["19","121. Resultados negativos de ejercicios anteriores","CUE","121","4","12","PREVIO","P-A-V-2"],
				["20","122. Aportaciones de socios para compensación de pérdidas","CUE","122","4","12","","P-A-V-3"],
				["21","129. Pérdidas y Ganancias","CUE","129","4","12","PYG","P-A-VI"],
				["5","13. INGRESOS A DISTRIBUIR EN VARIOS EJERCICIOS","EPI","13","1","13","",""],
				["22","130. Subvenciones oficiales de capital","CUE","130","5","13","","P-B-I"],
				["23","1300. Subvenciones del Estado","CUE","1300","5","13","","P-B-I"],
				["24","1301. Subvenciones de otras Administraciones Públicas","CUE","1301","5","13","","P-B-I"],
				["25","131. Subvenciones de capital","CUE","131","5","13","","P-B-I"],
				["26","135. Ingresos por intereses diferidos","CUE","135","5","13","","P-B-III"],
				["27","136. Diferencias positivas en moneda extranjera","CUE","136","5","13","DIVPOS","P-B-II"],
				["28","137. Ingresos fiscales por diferencias permantes a distribuir en varios ejercicios","CUE","137","5","13","","P-B-IV"],
				["29","138. Ingresos fiscales por deducciones y bonificaciones fiscales a distribuir en varios ejercicios","CUE","138","5","13","","P-B-IV"],
				["6","14. PROVISIONES PARA RIESGOS Y GASTOS","EPI","14","1","14","",""],
				["30","140. Provisión para pensiones y obligaciones similares","CUE","140","6","14","","P-C-I"],
				["31","141. Provisión para impuestos","CUE","141","6","14","","P-C-II"],
				["32","142. Provisión para responsabilidades","CUE","142","6","14","","P-C-III"],
				["33","143. Provisión para grandes reparaciones","CUE","143","6","14","","P-C-III"],
				["34","144. Fondo de reversión","CUE","144","6","14","","P-C-IV"],
				["7","15. EMPRESTITOS Y OTRAS EMISIONES ANALOGAS","EPI","15","1","15","",""],
				["35","150. Obligaciones y bonos","CUE","150","7","15","","P-D-I-1"],
				["36","1500. Obligaciones y bonos simples","CUE","1500","7","15","","P-D-I-1"],
				["37","1501. Obligaciones y bonos garantizados","CUE","1501","7","15","","P-D-I-1"],
				["38","1502. Obligaciones y bonos subordinados","CUE","1502","7","15","","P-D-I-1"],
				["39","1503. Obligaciones y bonos cupón cero","CUE","1503","7","15","","P-D-I-1"],
				["40","1504. Obligaciones y bonos con opción de adquisición de acciones","CUE","1504","7","15","","P-D-I-1"],
				["41","1505. Obligaciones y bonos con participación en beneficios","CUE","1505","7","15","","P-D-I-1"],
				["42","151. Obligaciones y bonos convertibles","CUE","151","7","15","","P-D-I-2"],
				["43","155. Deudas representadas en otros valores negociables","CUE","155","7","15","","P-D-I-3"],
				["8","16. DEUDAS LARGO PLAZO CON EMPRESAS DEL GRUPO Y ASOCIADAS","EPI","16","1","16","",""],
				["44","160. Deudas a largo plazo con empresas del grupo","CUE","160","8","16","","P-D-III-1"],
				["45","1600. Préstamos a largo plazo de empresas del grupo","CUE","1600","8","16","","P-D-III-1"],
				["46","1608. Deudas a l/p con empresas del grupo por efecto impositivo","CUE","1608","8","16","","P-D-III-1"],
				["47","1609. Otras deudas a largo plazo con empresas del grupo","CUE","1609","8","16","","P-D-III-1"],
				["48","161. Deudas a largo plazo con empresas asociadas","CUE","161","8","16","","P-D-III-2"],
				["49","162. Deudas a l/p con entidades de crédito del grupo","CUE","162","8","16","","P-D-III-1"],
				["50","163. Deudas a l/p con entidades de crédito asociadas","CUE","163","8","16","","P-D-III-2"],
				["51","164. Proveedores de inmovilizado a l/p, empresas grupo","CUE","164","8","16","","P-D-III-1"],
				["52","165. Proveedores de inmovilizado l/p, empresas asociadas","CUE","165","8","16","","P-D-III-2"],
				["9","17. DEUDAS A LARGO PLAZO POR PRESTAMOS RECIBIDOS Y OTROS CONCEPTOS","EPI","17","1","17","",""],
				["53","170. Deudas a largo plazo con entidades de crédito","CUE","170","9","17","","P-D-II-1"],
				["54","1700. Préstamos a largo plazo de entidades de crédito","CUE","1700","9","17","","P-D-II-1"],
				["55","1709. Otras deudas a largo plazo con entidades de crédito","CUE","1709","9","17","","P-D-II-1"],
				["56","171. Deudas a largo plazo","CUE","171","9","17","","P-D-IV-2"],
				["57","172. Deudas a largo plazo transformables en subvenciones","CUE","172","9","17","","P-D-IV-2"],
				["58","173. Proveedores de inmovilizado a largo plazo","CUE","173","9","17","","P-D-IV-2"],
				["59","174. Efectos a pagar a largo plazo","CUE","174","9","17","","P-D-IV-1"],
				["10","18. FIANZAS Y DEPOSITOS RECIBIDOS A LARGO PLAZO","EPI","18","1","18","",""],
				["60","180. Fianzas recibidas a largo plazo","CUE","180","10","18","","P-D-IV-3"],
				["61","185. Depósitos recibidos a largo plazo","CUE","185","10","18","","P-D-IV-3"],
				["11","19. SITUACIONES TRANSITORIAS DE FINANCIACION","EPI","19","1","19","",""],
				["62","190. Accionistas por desembolsos no exigidos","CUE","190","11","19","","A-A"],
				["63","191. Accionistas por desembolsos no exigidos, empresas del grupo","CUE","191","11","19","","A-A"],
				["64","192. Accionistas por desembolsos no exigidos, empresas asociadas","CUE","192","11","19","","A-A"],
				["65","193. Accionistas por aportaciones no dinerarias pendientes","CUE","193","11","19","","A-A"],
				["66","194. Accionistas por aportaciones no dinerarias pendientes, empresas del grupo","CUE","194","11","19","","A-A"],
				["67","195. Accionistas por aportaciones no dinerarias pendientes, empresas asociadas","CUE","195","11","19","","A-A"],
				["68","196. Socios, parte no desembolsada","CUE","196","11","19","","A-A"],
				["69","198. Acciones propias en situaciones especiales","CUE","198","11","19","","A-B-V"],
				["70","199. Acciones propias para reducción de capital","CUE","199","11","19","","P-A-VIII"],
				["12","2. INMOVILIZADO","EPI","2","","2","",""],
				["13","20. GASTOS DE ESTABLECIMIENTO","EPI","20","12","20","",""],
				["71","200. Gastos de constitución","CUE","200","13","20","","A-B-I"],
				["72","201. Gastos de primer establecimiento","CUE","201","13","20","","A-B-I"],
				["73","202. Gastos de ampliación de capital","CUE","202","13","20","","A-B-I"],
				["14","21. INMOVILIZACIONES INMATERIALES","EPI","21","12","21","",""],
				["74","210. Gastos de investigación y desarrollo","CUE","210","14","21","","A-B-II-1"],
				["75","2100. Gastos de I+D en proyectos no terminados","CUE","2100","14","21","","A-B-II-1"],
				["76","2101. Gastos de I+D en proyectos terminados","CUE","2101","14","21","","A-B-II-1"],
				["77","211. Concesiones administrativas","CUE","211","14","21","","A-B-II-2"],
				["78","212. Propiedad industrial","CUE","212","14","21","","A-B-II-2"],
				["79","213. Fondo de comercio","CUE","213","14","21","","A-B-II-3"],
				["80","214. Derechos de traspaso","CUE","214","14","21","","A-B-II-4"],
				["81","215. Aplicaciones informáticas","CUE","215","14","21","","A-B-II-5"],
				["82","217. Derechos sobre bienes en régimen de arrendamiento financiero","CUE","217","14","21","","A-B-II-6"],
				["83","219. Anticipos para inmovilizaciones inmateriales","CUE","219","14","21","","A-B-II-7"],
				["15","22. INMOVILIZACIONES MATERIALES","EPI","22","12","22","",""],
				["84","220. Terrenos y bienes naturales","CUE","220","15","22","","A-B-III-1"],
				["85","221. Construcciones","CUE","221","15","22","","A-B-III-1"],
				["86","222. Instalaciones técnicas","CUE","222","15","22","","A-B-III-2"],
				["87","223. Maquinaria","CUE","223","15","22","","A-B-III-2"],
				["88","224. Utillaje","CUE","224","15","22","","A-B-III-3"],
				["89","225. Otras instalaciones","CUE","225","15","22","","A-B-III-3"],
				["90","226. Mobiliario","CUE","226","15","22","","A-B-III-3"],
				["91","227. Equipos para procesos de información","CUE","227","15","22","","A-B-III-5"],
				["92","228. Elementos de transporte","CUE","228","15","22","","A-B-III-5"],
				["93","229. Otro inmovilizado material","CUE","229","15","22","","A-B-III-5"],
				["16","23. INMOVILIZACIONES MATERIALES EN CURSO","EPI","23","12","23","",""],
				["94","230. Adaptación de terrenos y de bienes naturales","CUE","230","16","23","","A-B-III-4"],
				["95","231. Construcciones en curso","CUE","231","16","23","","A-B-III-4"],
				["96","232. Instalaciones técnicas en montaje","CUE","232","16","23","","A-B-III-4"],
				["97","233. Maquinaria en montaje","CUE","233","16","23","","A-B-III-4"],
				["98","237. Equipos para procesos de información en montaje","CUE","237","16","23","","A-B-III-4"],
				["99","239. Anticipos para inmovilizaciones materiales","CUE","239","16","23","","A-B-III-4"],
				["17","24. INVERSIONES FINANCIERAS EN EMPRESAS DEL GRUPO Y ASOCIADAS","EPI","24","12","24","",""],
				["100","240. Participaciones en empresas del grupo","CUE","240","17","24","","A-B-IV-1"],
				["101","241. Participaciones en empresas asociadas","CUE","241","17","24","","A-B-IV-3"],
				["102","242. Valores de renta fija de empresas del grupo","CUE","242","17","24","","A-B-IV-2"],
				["103","243. Valores de renta fija de empresas asociadas","CUE","243","17","24","","A-B-IV-4"],
				["104","244. Créditos a largo plazo a empresas del grupo","CUE","244","17","24","","A-B-IV-2"],
				["105","2448. Créditos a l/p con empresas del grupo por efecto impositivo","CUE","2448","17","24","","A-B-IV-2"],
				["106","245. Créditos a largo plazo a empresas asociadas","CUE","245","17","24","","A-B-IV-4"],
				["107","246. Intereses a l/p de inversiones financieras en empresas del grupo","CUE","246","17","24","","A-B-IV-2"],
				["108","247. Intereses a l/p de inversiones financieras en empresas asociadas","CUE","247","17","24","","A-B-IV-4"],
				["109","248. Desembolsos pendientes sobre acciones de empresas del grupo","CUE","248","17","24","","P-D-V-1"],
				["110","249. Desembolsos pendientes sobre acciones de empresas asociadas","CUE","249","17","24","","P-D-V-2"],
				["18","25. OTRAS INVERSIONES FINANCIERAS PERMANENTES","EPI","25","12","25","",""],
				["111","250. Inversiones financieras permanentes en capital","CUE","250","18","25","","A-B-IV-5"],
				["112","2500. Inversiones financieras permantes en acciones con cotización en mercado secundario organizado","CUE","2500","18","25","","A-B-IV-5"],
				["113","2501. Inversiones financieras permantes en acciones sin cotización en mercado secundario organizado","CUE","2501","18","25","","A-B-IV-5"],
				["114","2502. Otras inversiones financieras en capital","CUE","2502","18","25","","A-B-IV-5"],
				["115","251. Valores de renta fija","CUE","251","18","25","","A-B-IV-5"],
				["116","2158. Participación en Fondos de Inversión en Activos del Mercado Monetario a l/p","CUE","2158","14","21","","A-B-IV-5"],
				["117","252. Créditos a largo plazo","CUE","252","18","25","","A-B-IV-6"],
				["118","253. Créditos a l/p por enajenación de inmovilizado","CUE","253","18","25","","A-B-IV-6"],
				["119","254. Creditos a largo plazo al personal","CUE","254","18","25","","A-B-IV-6"],
				["120","256. Intereses a largo plazo de valores de renta fija","CUE","256","18","25","","A-B-IV-5"],
				["121","257. Intereses a largo plazo de créditos","CUE","257","18","25","","A-B-IV-6"],
				["122","258. Imposiciones a largo plazo","CUE","258","18","25","","A-B-IV-6"],
				["123","259. Desembolsos pendientes sobre acciones","CUE","259","18","25","","P-D-V-3"],
				["19","26. FIANZAS Y DEPOSITOS CONSTITUIDOS A LARGO PLAZO","EPI","26","12","26","",""],
				["124","260. Fianzas constituidas a largo plazo","CUE","260","19","26","","A-B-IV-7"],
				["125","265. Depositos constituidos a largo plazo","CUE","265","19","26","","A-B-IV-7"],
				["20","27. GASTOS A DISTRIBUIR EN VARIOS EJERCICIOS","EPI","27","12","27","",""],
				["126","270. Gastos de formalización de deudas","CUE","270","20","27","","A-C"],
				["127","271. Gastos por intereses diferidos de valores negociables","CUE","271","20","27","","A-C"],
				["128","272. Gastos por intereses diferidos","CUE","272","20","27","","A-C"],
				["21","28. AMORTIZACION ACUMULADA DEL INMOVILIZADO","EPI","28","12","28","",""],
				["129","281. Amortización acumulada del inmovilizado inmaterial","CUE","281","21","28","","A-B-II-9"],
				["130","2810. Amortización acumulada de gastos de I+D","CUE","2810","21","28","","A-B-II-9"],
				["131","2811. Amortización acumulada de concesiones administrativas","CUE","2811","21","28","","A-B-II-9"],
				["132","2812. Amortización acumulada de propiedad industrial","CUE","2812","21","28","","A-B-II-9"],
				["133","2813. Amortización acumulada de fondo de comercio","CUE","2813","21","28","","A-B-II-9"],
				["134","2814. Amortización acumulada de derechos de traspaso","CUE","2814","21","28","","A-B-II-9"],
				["135","2815. Amortización acumulada de aplicaciones informáticas","CUE","2815","21","28","","A-B-II-9"],
				["136","2817. Amortización acumulada de derechos sobre bienes en régimen de arrendamiento financiero","CUE","2817","21","28","","A-B-II-9"],
				["137","282. Amortización acumulada del inmovilizado material","CUE","282","21","28","","A-B-III-7"],
				["138","2821. Amortización acumulada de construcciones","CUE","2821","21","28","","A-B-III-7"],
				["139","2822. Amortización acumulada de instalaciones técnicas","CUE","2822","21","28","","A-B-III-7"],
				["140","2823. Amortización acumulada de maquinaria","CUE","2823","21","28","","A-B-III-7"],
				["141","2824. Amortización acumulada de utillaje","CUE","2824","21","28","","A-B-III-7"],
				["142","2825. Amortización acumulada de otras instalaciones","CUE","2825","21","28","","A-B-III-7"],
				["143","2826. Amortización acumulada de mobiliario","CUE","2826","21","28","","A-B-III-7"],
				["144","2827. Amortización acumulada de equipos para procesos informáticos","CUE","2827","21","28","","A-B-III-7"],
				["145","2828. Amortización acumulada de elementos de transporte","CUE","2828","21","28","","A-B-III-7"],
				["146","2829. Amortización acumulada de otro inmovilizado material","CUE","2829","21","28","","A-B-III-7"],
				["22","29. PROVISIONES DE INMOVILIZADO","EPI","29","12","29","",""],
				["147","291. Provisión por depreciación inmovilizado inmaterial","CUE","291","22","29","","A-B-II-8"],
				["148","292. Provisión por depreciación inmovilizado material","CUE","292","22","29","","A-B-III-6"],
				["149","293. Provisión por depreciación valores negociables l/p de empresas del grupo","CUE","293","22","29","","A-B-IV-8"],
				["150","2930. Provisión por depreciación participaciones en capital l/p de empresas del grupo","CUE","2930","22","29","","A-B-IV-8"],
				["151","2935. Provisión por depreciación valores renta fija l/p de empresas del grupo","CUE","2935","22","29","","A-B-IV-8"],
				["152","294. Provisión por depreciación valores negociables l/p de empresas asociadas","CUE","294","22","29","","A-B-IV-8"],
				["153","2941. Provisión por depreciación participaciones en capital l/p de empresas asociadas","CUE","2941","22","29","","A-B-IV-8"],
				["154","2946. Provisión por depreciación valores renta fija l/p de empresas asociadas","CUE","2946","22","29","","A-B-IV-8"],
				["155","295. Provisión para insolvencias de creditos l/p a empresas del grupo","CUE","295","22","29","","A-B-IV-8"],
				["156","296. Provisión para insolvencias de creditos l/p a empresasa asociadas","CUE","296","22","29","","A-B-IV-8"],
				["157","297. Provisión por depreciación de valores negociables l/p","CUE","297","22","29","","A-B-IV-8"],
				["158","298. Provisión para insolvencias de créditos a l/p","CUE","298","22","29","","A-B-IV-8"],
				["23","3. EXISTENCIAS","EPI","3","","3","",""],
				["24","30. COMERCIALES","EPI","30","23","30","",""],
				["159","300. Mercaderias A","CUE","300","24","30","","A-D-II-1"],
				["160","301. Mercaderias B","CUE","301","24","30","","A-D-II-1"],
				["25","31. MATERIAS PRIMAS","EPI","31","23","31","",""],
				["161","310. Materias primas A","CUE","310","25","31","","A-D-II-2"],
				["162","311. Materias primas B","CUE","311","25","31","","A-D-II-2"],
				["26","32. OTROS APROVISIONAMIENTOS","EPI","32","23","32","",""],
				["163","320. Elementos y conjuntos incorporables","CUE","320","26","32","","A-D-II-2"],
				["164","321. Combustibles","CUE","321","26","32","","A-D-II-2"],
				["165","322. Repuestos","CUE","322","26","32","","A-D-II-2"],
				["166","325. Materiales diversos","CUE","325","26","32","","A-D-II-2"],
				["167","326. Embalajes","CUE","326","26","32","","A-D-II-2"],
				["168","327. Envases","CUE","327","26","32","","A-D-II-2"],
				["169","328. Material de oficina","CUE","328","26","32","","A-D-II-2"],
				["27","33. PRODUCTOS EN CURSO","EPI","33","23","33","",""],
				["170","330. Productos en curso A","CUE","330","27","33","","A-D-II-3"],
				["171","331. Productos en curso B","CUE","331","27","33","","A-D-II-3"],
				["28","34. PRODUCTOS SEMITERMINADOS","EPI","34","23","34","",""],
				["172","340. Productos semiterminados A","CUE","340","28","34","","A-D-II-3"],
				["173","341. Productos semiterminados B","CUE","341","28","34","","A-D-II-3"],
				["29","35. PRODUCTOS TERMINADOS","EPI","35","23","35","",""],
				["174","350. Productos terminados A","CUE","350","29","35","","A-D-II-4"],
				["175","351. Productos terminados B","CUE","351","29","35","","A-D-II-4"],
				["30","36. SUBPRODUCTOS, RESIDUOS Y MATERIALES RECUPERADOS","EPI","36","23","36","",""],
				["176","360. Subproductos A","CUE","360","30","36","","A-D-II-5"],
				["177","361. Subproductos B","CUE","361","30","36","","A-D-II-5"],
				["178","365. Residuos A","CUE","365","30","36","","A-D-II-5"],
				["179","366. Residuos B","CUE","366","30","36","","A-D-II-5"],
				["180","368. Materiales recuperados A","CUE","368","30","36","","A-D-II-5"],
				["181","369. Materiales recuperados B","CUE","369","30","36","","A-D-II-5"],
				["31","39. PROVISIONES POR DEPRECIACION DE EXISTENCIAS","EPI","39","23","39","",""],
				["182","390. Provisión por depreciación de mercaderías","CUE","390","31","39","","A-D-II-7"],
				["183","391. Provisión por depreciación de materias primas","CUE","391","31","39","","A-D-II-7"],
				["184","392. Provisión por depreciación de otros aprovisionamientos","CUE","392","31","39","","A-D-II-7"],
				["185","393. Provisión por depreciación de productos en curso","CUE","393","31","39","","A-D-II-7"],
				["186","394. Provisión por depreciación de productos semiterminados","CUE","394","31","39","","A-D-II-7"],
				["187","395. Provisión por depreciación de productos terminado","CUE","395","31","39","","A-D-II-7"],
				["188","396. Provisión por depreciación de subproductos,residuos y materiales recuperados","CUE","396","31","39","","A-D-II-7"],
				["32","4. ACREEDORES Y DEUDORES POR OPERACIONES DE TRAFICO","EPI","4","","4","",""],
				["33","40. PROVEEDORES","EPI","40","32","40","",""],
				["189","400. Proveedores","CUE","400","33","40","PROVEE","P-E-IV-2"],
				["191","4004. Proveedores (moneda extranjera)","CUE","4004","33","40","PROVEE","P-E-IV-2"],
				["192","4009. Proveedores facturas pendientes de recibir o formalizar","CUE","4009","33","40","PROVEE","P-E-IV-2"],
				["193","401. Proveedores, efectos comerciales a pagar","CUE","401","33","40","PROVEE","P-E-IV-3"],
				["194","402. Proveedores, empresas del grupo","CUE","402","33","40","PROVEE","P-E-III-1"],
				["195","4020. Proveedores, empresas del grupo (euros)","CUE","4020","33","40","PROVEE","P-E-III-1"],
				["196","4021. Efectos comerciales a pagar, empresas del grupo","CUE","4021","33","40","PROVEE","P-E-III-1"],
				["197","4024. Proveedores, empresas del grupo (moneda extranjera","CUE","4024","33","40","PROVEE","P-E-III-1"],
				["198","4026. Envases y embalajes a devolver a proveedores, empresas del grupo","CUE","4026","33","40","PROVEE","P-E-III-1"],
				["199","4029. Proveedores, empresas del grupo,facturas pendientes de recibir o formalizar","CUE","4029","33","40","PROVEE","P-E-III-1"],
				["200","403. Proveedores, empresas asociadas","CUE","403","33","40","PROVEE","P-E-III-2"],
				["201","406. Envases y embalajes a devolver a proveedores","CUE","406","33","40","PROVEE","P-E-IV-2"],
				["202","407. Anticipos a proveedores","CUE","407","33","40","PROVEE","A-D-II-6"],
				["34","41. ACREEDORES VARIOS","EPI","41","32","41","",""],
				["203","410. Acreedores por prestaciones de servicios","CUE","410","34","41","PROVEE","P-E-IV-2"],
				["204","4100. Acreedores por prestaciones de servicios (euros)","CUE","4100","34","41","PROVEE","P-E-IV-2"],
				["205","4104. Acreedores por prestaciones de servicios (moneda extranjera)","CUE","4104","34","41","PROVEE","P-E-IV-2"],
				["206","4109. Acreedores por prestaciones de servicios,facturas pendientes de recibir o formalizar","CUE","4109","34","41","PROVEE","P-E-IV-2"],
				["207","411. Acreedores, efectos comerciales a pagar","CUE","411","34","41","PROVEE","P-E-IV-3"],
				["208","419. Acreedores por operaciones en común","CUE","419","34","41","PROVEE","P-E-IV-2"],
				["35","43. CLIENTES","EPI","43","32","43","",""],
				["209","430. Clientes","CUE","430","35","43","CLIENT","A-D-III-1"],
				["211","4304. Clientes (moneda extranjera)","CUE","4304","35","43","CLIENT","A-D-III-1"],
				["212","4309. Clientes, facturas pendientes de formalizar","CUE","4309","35","43","CLIENT","A-D-III-1"],
				["213","431. Clientes, efectos comerciales a cobrar","CUE","431","35","43","CLIENT","A-D-III-1"],
				["214","4310. Efectos comerciales en cartera","CUE","4310","35","43","CLIENT","A-D-III-1"],
				["215","4311. Efectos comerciales descontados","CUE","4311","35","43","CLIENT","A-D-III-1"],
				["216","4312. Efectos comerciales en gestión de cobro","CUE","4312","35","43","CLIENT","A-D-III-1"],
				["217","4315. Efectos comerciales impagados","CUE","4315","35","43","CLIENT","A-D-III-1"],
				["218","432. Clientes, empresas del grupo","CUE","432","35","43","CLIENT","A-D-III-2"],
				["219","4320. Clientes, empresas del grupo (euros)","CUE","4320","35","43","CLIENT","A-D-III-2"],
				["220","4321. Efectos comerciales a cobrar, empresas del grupo","CUE","4321","35","43","CLIENT","A-D-III-2"],
				["221","4324. Clientes, empresas del grupo (moneda extranjera)","CUE","4324","35","43","CLIENT","A-D-III-2"],
				["222","4326. Envases y embalajes a devolver a clientes, empresas del grupo","CUE","4326","35","43","CLIENT","A-D-III-2"],
				["223","4329. Clientes, empresas del grupo, facturas pendientes formalizar","CUE","4329","35","43","CLIENT","A-D-III-2"],
				["224","433. Clientes, empresas asociadas","CUE","433","35","43","CLIENT","A-D-III-3"],
				["225","435. Clientes de dudoso cobro","CUE","435","35","43","CLIENT","A-D-III-1"],
				["226","436. Envases y embalajes a devolver por clientes","CUE","436","35","43","CLIENT","A-D-III-1"],
				["227","437. Anticipos de clientes","CUE","437","35","43","CLIENT","P-E-IV-1"],
				["36","44. DEUDORES VARIOS","EPI","44","32","44","",""],
				["228","440. Deudores","CUE","440","36","44","CLIENT","A-D-III-4"],
				["229","4400. Deudores (euros)","CUE","4400","36","44","CLIENT","A-D-III-4"],
				["230","4404. Deudores (moneda extranjera)","CUE","4404","36","44","CLIENT","A-D-III-4"],
				["231","4409. Deudores, facturas pendientes de formalizar","CUE","4409","36","44","CLIENT","A-D-III-4"],
				["232","441. Deudores, efectos comerciales a cobrar","CUE","441","36","44","CLIENT","A-D-III-4"],
				["233","4410. Deudores, efectos comerciales en cartera","CUE","4410","36","44","CLIENT","A-D-III-4"],
				["234","4411. Deudores, efectos comerciales descontados","CUE","4411","36","44","CLIENT","A-D-III-4"],
				["235","4412. Deudores, efectos comerciales en gestión de cobro","CUE","4412","36","44","CLIENT","A-D-III-4"],
				["236","4415. Deudores, efectos comerciales impagados","CUE","4415","36","44","CLIENT","A-D-III-4"],
				["237","445. Deudores de dudoso cobro","CUE","445","36","44","CLIENT","A-D-III-4"],
				["238","449. Deudores por operaciones en común","CUE","449","36","44","CLIENT","A-D-III-4"],
				["37","46. PERSONAL","EPI","46","32","46","",""],
				["239","460. Anticipos de remuneraciones","CUE","460","37","46","","A-D-III-5"],
				["240","465. Remuneraciones pendientes de pago","CUE","465","37","46","","P-E-V-4"],
				["38","47. ADMINISTRACIONES PUBLICAS","EPI","47","32","47","",""],
				["241","470. Hacienda Pública, deudor por diversos conceptos","CUE","470","38","47","IVADEU","A-D-III-6"],
				["242","4700. Hacienda Pública, deudor por IVA","CUE","4700","38","47","IVADEU","A-D-III-6"],
				["243","4707. Hacienda Pública, deudor por IGIC","CUE","4707","38","47","","A-D-III-6"],
				["244","47070. Hacienda Pública, deudor por IGIC","CUE","47070","38","47","","A-D-III-6"],
				["245","47071. Hacienda Pública, deudor por IGIC régimen transitorio, circulante","CUE","47071","38","47","","A-D-III-6"],
				["246","47072. Hacienda Pública, deudor por IGIC régimen transitorio, inversión","CUE","47072","38","47","","A-D-III-6"],
				["247","4708. Hacienda Pública, deudor por subvenciones concedidas","CUE","4708","38","47","","A-D-III-6"],
				["248","4709. Hacienda Pública, deudor por devolución impuestos","CUE","4709","38","47","","A-D-III-6"],
				["249","471. Organismos de la Seguridad Social, deudores","CUE","471","38","47","","A-D-III-6"],
				["250","472. Hacienda Publica, IVA soportado","CUE","472","38","47","IVASOP","A-D-III-6"],
				["251","4720. IVA soportado","CUE","4720","38","47","IVASOP","A-D-III-6"],
				["252","4727. IGIC soportado","CUE","4727","38","47","","A-D-III-6"],
				["253","473. Hacienda Pública, retenciones y pagos a cuenta","CUE","473","38","47","","P-E-V-1"],
				["254","4732. Hacienda Pública, retenciones y pagos a cuenta","CUE","4732","38","47","","P-E-V-1"],
				["255","474. Impuesto sobre beneficios anticipado y compensación de pérdidas","CUE","474","38","47","","A-D-III-6"],
				["256","4740. Impuesto sobre beneficios anticipado","CUE","4740","38","47","","A-D-III-6"],
				["257","4741. Impuestos sobre beneficios anticipado a l/p","CUE","4741","38","47","","A-D-III-6"],
				["258","4745. Crédito por pérdidas a compensar del ejercicio....","CUE","4745","38","47","","A-D-III-6"],
				["259","4746. Crédito por pérdidas a compensar del ejercicio..a l/p","CUE","4746","38","47","","A-D-III-6"],
				["260","4748. Impuesto sobre beneficios anticipado por operaciones intra-grupo","CUE","4748","38","47","","A-D-III-6"],
				["261","4749. Crédito por perdidas a compensar en régimen de declaración consolidada del ejercicio...","CUE","4749","38","47","","A-D-III-6"],
				["262","475. Hacienda Pública, acreedor por conceptos fiscales","CUE","475","38","47","IVAACR","P-E-V-1"],
				["263","4750. Hacienda Pública, acreedor por IVA","CUE","4750","38","47","IVAACR","P-E-V-1"],
				["264","4751. Hacienda Pública, acreedor por retenciones practicadas","CUE","4751","38","47","IRPFPR","P-E-V-1"],
				["265","4752. Hacienda Pública, acreedor por impuesto sobre sociedades","CUE","4752","38","47","","P-E-V-1"],
				["266","4757. Hacienda Pública, acreedor por IGIC","CUE","4757","38","47","","P-E-V-1"],
				["267","4758. Hacienda Pública, acreedor por subvenciones a reintegrar","CUE","4758","38","47","","P-E-V-1"],
				["268","476. Organismos de la Seguridad Social, acreedores","CUE","476","38","47","","P-E-V-1"],
				["269","477. Hacienda Pública, IVA repercutido","CUE","477","38","47","IVAREP","P-E-V-1"],
				["270","4770. IVA repercutido","CUE","4770","38","47","IVAREP","P-E-V-1"],
				["271","4777. IGIC repercutido","CUE","4777","38","47","","P-E-V-1"],
				["272","479. Impuesto sobre beneficios diferido","CUE","479","38","47","","P-E-V-1"],
				["273","4791. Impuesto sobre beneficios diferido a l/p","CUE","4791","38","47","","P-E-V-1"],
				["274","4798. Impuesto sobre beneficios diferido por operaciones intra-grupo","CUE","4798","38","47","","P-E-V-1"],
				["39","48. AJUSTES POR PERIODIFICACION","EPI","48","32","48","",""],
				["275","480. Gastos anticipados","CUE","480","39","48","","A-D-VII"],
				["276","485. Ingresos anticipados","CUE","485","39","48","","P-E-VII"],
				["40","49. PROVISIONES POR OPERACIONES DE TRAFICO","EPI","49","32","49","",""],
				["277","490. Provisión para insolvencias de tráfico","CUE","490","40","49","","A-D-III-7"],
				["278","493. Provisión para insolvencias de tráfico de empresas del grupo","CUE","493","40","49","","A-D-III-7"],
				["279","494. Provisión para insolvencias de tráfico de empresas asociadas","CUE","494","40","49","","A-D-III-7"],
				["280","499. Provisión para otras operaciones de tráfico","CUE","499","40","49","","P-E-VI"],
				["41","5. CUENTAS FINANCIERAS","EPI","5","","5","",""],
				["42","50. EMPRESTITOS Y OTRAS EMISIONES ANALOGAS A CORTO PLAZO","EPI","50","41","50","",""],
				["281","500. Obligaciones y bonos a corto plazo","CUE","500","42","50","","P-E-I-1"],
				["282","501. Obligaciones y bonos convertibles a corto plazo","CUE","501","42","50","","P-E-I-2"],
				["283","505. Deudas representadas otros valores negociables c/p","CUE","505","42","50","","P-E-I-3"],
				["284","506. Intereses de empréstitos y otras emisiones análogas","CUE","506","42","50","","P-E-I-4"],
				["285","509. Valores negociables amortizados","CUE","509","42","50","","P-E-V-3"],
				["286","5090. Obligaciones y bonos amortizados","CUE","5090","42","50","","P-E-V-3"],
				["287","5091. Obligaciones y bonos convertibles amortizados","CUE","5091","42","50","","P-E-V-3"],
				["288","5095. Otros valores negociables amortizados","CUE","5095","42","50","","P-E-V-3"],
				["43","51. DEUDAS A CORTO PLAZO CON EMPRESAS DEL GRUPO Y ASOCIADAS","EPI","51","41","51","",""],
				["289","510. Deudas a corto plazo con empresas del grupo","CUE","510","43","51","","P-E-III-1"],
				["290","5100. Préstamos a corto plazo de empresas del grupo","CUE","5100","43","51","","P-E-III-1"],
				["291","5108. Deudas a c/p con empresas del grupo por efectos impositivos","CUE","5108","43","51","","P-E-III-1"],
				["292","5109. Otras deudas a corto plazo con empresas del grupo","CUE","5109","43","51","","P-E-III-1"],
				["293","511. Deudas a corto plazo con empresas asociadas","CUE","511","43","51","","P-E-III-2"],
				["294","512. Deudas a c/p con entidades de crédito del grupo","CUE","512","43","51","","P-E-III-1"],
				["295","5120. Préstamos a c/p de entidades de crédito del grupo","CUE","5120","43","51","","P-E-III-1"],
				["296","5128. Deudas por efectos descontados en entididades de crédito del grupo","CUE","5128","43","51","","P-E-III-1"],
				["297","5129. Otras deudas c/p con entidades de crédito del grupo","CUE","5129","43","51","","P-E-III-1"],
				["298","513. Deudas a c/p con entidades de credito asociadas","CUE","513","43","51","","P-E-III-2"],
				["299","514. Proveedores de inmovilizado a c/p, empresas del grupo","CUE","514","43","51","","P-E-III-1"],
				["300","515. Proveedores de inmovilizado a c/p, empresas asociadas","CUE","515","43","51","","P-E-III-2"],
				["301","516. Intereses a c/p de deudas con empresas del grupo","CUE","516","43","51","","P-E-III-1"],
				["302","517. Intereses a c/p de deudas con empresas asociadas","CUE","517","43","51","","P-E-III-2"],
				["44","52. DEUDAS A CORTO PLAZO POR PRESTAMOS RECIBIDOS Y OTROS CONCEPTOS","EPI","52","41","52","",""],
				["303","520. Deudas a corto plazo con entidades de crédito","CUE","520","44","52","","P-E-II-1"],
				["304","5200. Préstamos a corto plazo de entidades de crédito","CUE","5200","44","52","","P-E-II-1"],
				["305","5201. Deudas a corto plazo por crédito dispuesto","CUE","5201","44","52","","P-E-II-1"],
				["306","5208. Deudas por efectos descontados","CUE","5208","44","52","","P-E-II-1"],
				["307","521. Deudas a corto plazo","CUE","521","44","52","","P-E-V-3"],
				["308","523. Proveedores de inmovilizado a corto plazo","CUE","523","44","52","","P-E-V-3"],
				["309","524. Efectos a pagar a corto plazo","CUE","524","44","52","","P-E-V-2"],
				["310","525. Dividendo activo a pagar","CUE","525","44","52","","P-E-V-3"],
				["311","526. Intereses a c/p de deudas con entidades de crédito","CUE","526","44","52","","P-E-II-2"],
				["312","527. Intereses a corto plazo de deudas","CUE","527","44","52","","P-E-V-3"],
				["45","53. INVERSIONES FINANCIERAS A CORTO PLAZO EN EMPRESAS DEL GRUPO Y ASOCIADAS","EPI","53","41","53","",""],
				["313","530. Participaciones a c/p en empresas del grupo","CUE","530","45","53","","A-D-IV-1"],
				["314","531. Participaciones a c/p en empresas asociadas","CUE","531","45","53","","A-D-IV-3"],
				["315","532. Valores de renta fija a c/p de empresas del grupo","CUE","532","45","53","","A-D-IV-2"],
				["316","533. Valores de renta fija a c/p de empresas asociadas","CUE","533","45","53","","A-D-IV-4"],
				["317","534. Créditos a corto plazo a empresas del grupo","CUE","534","45","53","","A-D-IV-2"],
				["318","5348. Créditos a c/p con empresas del grupo por efecto impositivo","CUE","5348","45","53","","A-D-IV-2"],
				["319","535. Créditos a corto plazo a empresas asociadas","CUE","535","45","53","","A-D-IV-4"],
				["320","536. Intereses a c/p de inversiones financieras en empresas del grupo","CUE","536","45","53","","A-D-IV-2"],
				["321","5360. Intereses c/p valores renta fija de empresas del grupo","CUE","5360","45","53","","A-D-IV-2"],
				["322","5361. Intereses c/p de créditos a empresas del grupo","CUE","5361","45","53","","A-D-IV-2"],
				["323","537. Intereses a c/p de inversiones financieras en empresas asociadas","CUE","537","45","53","","A-D-IV-4"],
				["324","538. Desembolsos pendientes sobre acciones a c/p de empresas del grupo","CUE","538","45","53","","A-D-IV-1"],
				["325","539. Desembolsos pendientes sobre acciones a c/p de empresas asociadas","CUE","539","45","53","","A-D-IV-3"],
				["46","54. OTRAS INVERSIONES FINANCIERAS TEMPORALES","EPI","54","41","54","",""],
				["326","540. Inversiones financieras temporales en capital","CUE","540","46","54","","A-D-IV-5"],
				["327","5400. Inversiones financieras temporales en acciones con cotización en mercado secundario organizado","CUE","5400","46","54","","A-D-IV-5"],
				["328","5401. Inversiones financieras temporales en acciones sin cotización en mercado secundario organizado","CUE","5401","46","54","","A-D-IV-5"],
				["329","5409. Otras inversiones financieras temporales en capital","CUE","5409","46","54","","A-D-IV-5"],
				["330","541. Valores de renta fija a corto plazo","CUE","541","46","54","","A-D-IV-5"],
				["331","5418. Participaciones en Fondos de Inversión en Activos del Mercado Monetario a c/p","CUE","5418","46","54","","A-D-IV-5"],
				["332","542. Créditos a corto plazo","CUE","542","46","54","","A-D-IV-6"],
				["333","543. Creditos a c/p por enajenación de inmovilizado","CUE","543","46","54","","A-D-IV-6"],
				["334","544. Créditos a corto plazo al personal","CUE","544","46","54","","A-D-III-5"],
				["335","545. Dividendo a cobrar","CUE","545","46","54","","A-D-IV-6"],
				["336","546. Intereses a corto plazo de valores de renta fija","CUE","546","46","54","","A-D-IV-5"],
				["337","547. Intereses a corto plazo de créditos","CUE","547","46","54","","A-D-IV-6"],
				["338","548. Imposiciones a corto plazo","CUE","548","46","54","","A-D-IV-6"],
				["339","549. Desembolsos pendientes sobre acciones a corto plazo","CUE","549","46","54","","A-D-IV-5"],
				["47","55. OTRAS CUENTAS NO BANCARIAS","EPI","55","41","55","",""],
				["340","550. Titular de la explotación","CUE","550","47","55","","P-E-V-3"],
				["341","551. Cuenta corriente con empresas del grupo","CUE","551","47","55","","A-D-III-2"],
				["342","552. Cuenta corriente con empresas asociadas","CUE","552","47","55","","P-E-III-2"],
				["343","553. Cuenta corriente con socios y administradores","CUE","553","47","55","","A-D-III-4"],
				["344","555. Partidas pendientes de aplicación","CUE","555","47","55","","A-D-III-4"],
				["345","556. Desembolsos exigidos sobre acciones","CUE","556","47","55","","P-E-V-3"],
				["346","5560. Desembolsos exigidos sobre acciones de empresas del grupo","CUE","5560","47","55","","P-E-V-3"],
				["347","5561. Desembolsos exigidos sobre acciones de empresas asociadas","CUE","5561","47","55","","P-E-V-3"],
				["348","5562. Desembolsos exigidos sobre acciones de otras empresas","CUE","5562","47","55","","P-E-V-3"],
				["349","557. Dividendo activo a cuenta","CUE","557","47","55","","P-A-VII"],
				["350","558. Accionistas por desembolsos exigidos","CUE","558","47","55","","A-D-I"],
				["48","56. FIANZAS Y DEPOSITOS RECIBIDOS Y CONSTITUIDOS A CORTO PLAZO","EPI","56","41","56","",""],
				["351","560. Fianzas recibidas a corto plazo","CUE","560","48","56","","P-E-V-5"],
				["352","561. Depósitos recibidos a corto plazo","CUE","561","48","56","","P-E-V-5"],
				["353","565. Fianzas constituidas a corto plazo","CUE","565","48","56","","A-D-IV-7"],
				["354","566. Depósitos constituidos a corto plazo","CUE","566","48","56","","A-D-IV-7"],
				["49","57. TESORERIA","EPI","57","41","57","",""],
				["355","570. Caja, euros","CUE","570","49","57","CAJA","A-D-VI"],
				["356","571. Caja, moneda extranjera","CUE","571","49","57","","A-D-VI"],
				["357","572. Bancos e instituciones de crédito c/c. vista, euros","CUE","572","49","57","","A-D-VI"],
				["358","573. Bancos e instituciones de crédito c/c. vista, moneda extranjera","CUE","573","49","57","","A-D-VI"],
				["359","574. Bancos e instituciones de crédito, cuentas de ahorro, euros","CUE","574","49","57","","A-D-VI"],
				["360","575. Bancos e instituciones de crédito, cuentas de ahorro, moneda extranjera","CUE","575","49","57","","A-D-VI"],
				["50","58. AJUSTES POR PERIODIFICACION","EPI","58","41","58","",""],
				["361","580. Intereses pagados por anticipado","CUE","580","50","58","","A-D-VII"],
				["362","585. Intereses cobrados por anticipado","CUE","585","50","58","","P-E-VII"],
				["51","59. PROVISIONES FINANCIERAS","EPI","59","41","59","",""],
				["363","593. Provisión por depreciación de valores negociables a c/p de empresas del grupo","CUE","593","51","59","","A-D-IV-8"],
				["364","594. Provisión por depreciación de valores negociables a c/p de empresas asociadas","CUE","594","51","59","","A-D-IV-8"],
				["365","595. Provisión para insolvencias de créditos a c/p a empresas del grupo","CUE","595","51","59","","A-D-IV-8"],
				["366","596. Provisión para insolvencias de créditos a c/p a empresas asociadas","CUE","596","51","59","","A-D-IV-8"],
				["367","597. Provisión por depreciación de valores negociables a c/p","CUE","597","51","59","","A-D-IV-8"],
				["368","598. Provisión para insolvencias de créditos a c/p","CUE","598","51","59","","A-D-IV-8"],
				["52","6. COMPRAS Y GASTOS","EPI","6","","6","",""],
				["53","60. COMPRAS","EPI","60","52","60","",""],
				["369","600. Compras de mercaderías","CUE","600","53","60","COMPRA","D-A-2-a"],
				["370","601. Compras de materias primas","CUE","601","53","60","","D-A-2-b"],
				["371","602. Compras de otros aprovisionamientos","CUE","602","53","60","","D-A-2-b"],
				["372","607. Trabajos realizados por otras empresas","CUE","607","53","60","","D-A-2-c"],
				["373","608. Devoluciones de compras y operaciones similares","CUE","608","53","60","DEVCOM","D-A-2-a"],
				["374","6080. Devoluciones de compras de mercaderías","CUE","6080","53","60","","D-A-2-a"],
				["375","6081. Devoluciones de compras de materias primas","CUE","6081","53","60","","D-A-2-b"],
				["376","6082. Devoluciones de compras de otros aprovisionamients","CUE","6082","53","60","","D-A-2-b"],
				["377","609. Rappels por compras","CUE","609","53","60","","D-A-2-a"],
				["378","6090. Rappels por compras de mercaderías","CUE","6090","53","60","","D-A-2-a"],
				["379","6091. Rapels por compras de materias primas","CUE","6091","53","60","","D-A-2-b"],
				["380","6092. Rappels por compras de otros aprovisionamientos","CUE","6092","53","60","","D-A-2-b"],
				["54","61. VARIACION DE EXISTENCIAS","EPI","61","52","61","",""],
				["381","610. Variación de existencias de mercaderías","CUE","610","54","61","","D-A-2-a"],
				["382","611. Variación de existencias de materias primas","CUE","611","54","61","","D-A-2-b"],
				["383","612. Variación de existencias de otros aprovisionamientos","CUE","612","54","61","","D-A-2-b"],
				["55","62. SERVICIOS EXTERIORES","EPI","62","52","62","",""],
				["384","620. Gastos en investigación y desarrollo del ejercicio","CUE","620","55","62","","D-A-6-a"],
				["385","621. Arrendamientos y cánones","CUE","621","55","62","","D-A-6-a"],
				["386","622. Reparaciones y conservación","CUE","622","55","62","","D-A-6-a"],
				["387","623. Servicios de profesionales independientes","CUE","623","55","62","","D-A-6-a"],
				["388","624. Transportes","CUE","624","55","62","","D-A-6-a"],
				["389","625. Primas de seguros","CUE","625","55","62","","D-A-6-a"],
				["390","626. Servicios bancarios y similares","CUE","626","55","62","","D-A-6-a"],
				["391","627. Publicidad, propaganda y relaciones públicas","CUE","627","55","62","","D-A-6-a"],
				["392","628. Suministros","CUE","628","55","62","","D-A-6-a"],
				["393","629. Otros servicios","CUE","629","55","62","","D-A-6-a"],
				["56","63. TRIBUTOS","EPI","63","52","63","",""],
				["394","630. Impuesto sobre beneficios","CUE","630","56","63","","D-V-5"],
				["395","631. Otros tributos","CUE","631","56","63","","D-A-6-b"],
				["396","632. Sociedades transparentes, efecto impositivo","CUE","632","56","63","","D-V-5"],
				["397","6320. Importes a cuenta no recuperables por entidades transparentes","CUE","6320","56","63","","D-V-6"],
				["398","6321. Importes a cuenta no recuperables por agrupaciones de interés económico","CUE","6321","56","63","","D-V-5"],
				["399","6323. Ajustes negativos en la imposición en sociedades transparentes","CUE","6323","56","63","","D-V-5"],
				["400","6328. Ajustes positivos en la imposición en sociedades transparentes","CUE","6328","56","63","","D-V-5"],
				["401","633. Ajustes negativos en imposicion sobre beneficios","CUE","633","56","63","","D-V-5"],
				["402","634. Ajustes negativos en la imposicion indirecta","CUE","634","56","63","","D-A-6-b"],
				["403","6341. Ajustes negativos en IVA de circulante","CUE","6341","56","63","","D-A-6-b"],
				["404","6342. Ajustes negativos en IVA de inversiones","CUE","6342","56","63","","D-A-6-b"],
				["405","6343. Ajustes negativos en IGIC, de circulante","CUE","6343","56","63","","D-A-6-b"],
				["406","6344. Ajustes negativos en IGIC, de inversión","CUE","6344","56","63","","D-A-6-b"],
				["407","635. Impuesto sobre beneficios extranjero","CUE","635","56","63","","D-V-6"],
				["408","636. Devolución de impuestos","CUE","636","56","63","","D-A-6-b"],
				["409","637. Imposición indirecta, regímenes especiales","CUE","637","56","63","","D-V-6"],
				["410","6371. Régimen simplificado, IVA","CUE","6371","56","63","","D-V-6"],
				["411","6372. Régimen simplificado, IGIC","CUE","6372","56","63","","D-V-6"],
				["412","6373. Régimen de la agricultura,ganadería y pesca, IVA","CUE","6373","56","63","","D-V-6"],
				["413","6374. Régimen de la agricultura y ganadería, IGIC","CUE","6374","56","63","","D-V-6"],
				["414","638. Ajustes positivos en imposicion sobre beneficios","CUE","638","56","63","","D-V-5"],
				["415","639. Ajustes positivos en la imposicion indirecta","CUE","639","56","63","","D-A-6-b"],
				["416","6391. Ajustes positivos en IVA de circulante","CUE","6391","56","63","","D-A-6-b"],
				["417","6392. Ajustes positivos en IVA de inversiones","CUE","6392","56","63","","D-A-6-b"],
				["418","6393. Ajustes positivos en IGIC de circulante","CUE","6393","56","63","","D-A-6-b"],
				["419","6394. Ajustes positivos en IGIC de inversión","CUE","6394","56","63","","D-A-6-b"],
				["57","64. GASTOS DE PERSONAL","EPI","64","52","64","",""],
				["420","640. Sueldos y salarios","CUE","640","57","64","","D-A-3-a"],
				["421","641. Indemnizaciones","CUE","641","57","64","","D-A-3-a"],
				["422","642. Seguridad Social a cargo de la empresa","CUE","642","57","64","","D-A-3-b"],
				["423","643. Aportaciones a sistemas complementarios pensiones","CUE","643","57","64","","D-A-3-b"],
				["424","649. Otros gastos sociales","CUE","649","57","64","","D-A-3-b"],
				["58","65. OTROS GASTOS DE GESTION","EPI","65","52","65","",""],
				["425","650. Pérdidas de créditos comerciales incobrables","CUE","650","58","65","","D-A-5-b"],
				["426","651. Resultados de operaciones en común","CUE","651","58","65","","D-A-6-c"],
				["427","6510. Beneficio transferido (gestor)","CUE","6510","58","65","","D-A-6-c"],
				["428","6511. Pérdida soportada (partícipe o asociado no gestor)","CUE","6511","58","65","","D-A-6-c"],
				["429","659. Otras pérdidas en gestión corriente","CUE","659","58","65","","D-A-6-c"],
				["59","66. GASTOS FINANCIEROS","EPI","66","52","66","",""],
				["430","661. Intereses de obligaciones y bonos","CUE","661","59","66","","D-I-7-a"],
				["431","6610. Intereses de obligaciones y bonos l/p en empresas del grupo","CUE","6610","59","66","","D-I-7-a"],
				["432","6611. Intereses de obligaciones y bonos l/p en empresas asociadas","CUE","6611","59","66","","D-I-7-b"],
				["433","6613. Intereses de obligaciones y bonos l/p en otras empresas","CUE","6613","59","66","","D-I-7-c"],
				["434","6615. Intereses de obligaciones y bonos c/p en empresas del grupo","CUE","6615","59","66","","D-I-7-a"],
				["435","6616. Intereses de obligaciones y bonos c/p en empresas asociadas","CUE","6616","59","66","","D-I-7-b"],
				["436","6618. Intereses de obligaciones y bonos c/p en otras empresas","CUE","6618","59","66","","D-I-7-c"],
				["437","662. Intereses de deudas a largo plazo","CUE","662","59","66","","D-I-7-a"],
				["438","6620. Intereses de deudas a l/p con empresas del grupo","CUE","6620","59","66","","D-I-7-a"],
				["439","6621. Intereses de deudas a l/p con empresas asociadas","CUE","6621","59","66","","D-I-7-b"],
				["440","6622. Intereses de deudas a l/p con entidades de crédito","CUE","6622","59","66","","D-I-7-c"],
				["441","6623. Intereses de deudas a l/p con otras empresas","CUE","6623","59","66","","D-I-7-c"],
				["442","663. Intereses de deudas a corto plazo","CUE","663","59","66","","D-I-7-a"],
				["443","6630. Intereses de deudas a c/p con empresas del grupo","CUE","6630","59","66","","D-I-7-a"],
				["444","6631. Intereses de deudas a c/p con empresas asociadas","CUE","6631","59","66","","D-I-7-b"],
				["445","6632. Intereses de deudas a c/p con entidades de crédito","CUE","6632","59","66","","D-I-7-c"],
				["446","6633. Intereses de deudas a c/p con otras empresas","CUE","6633","59","66","","D-I-7-c"],
				["447","664. Intereses por descuento de efectos","CUE","664","59","66","","D-I-7-a"],
				["448","6640. Intereses por descuento de efectos en entidades de crédito del grupo","CUE","6640","59","66","","D-I-7-a"],
				["449","6641. Intereses por descuento de efectos en entidades de crédito asociadas","CUE","6641","59","66","","D-I-7-b"],
				["450","6643. Intereses por descuento de efectos en otras entidades de crédito","CUE","6643","59","66","","D-I-7-c"],
				["451","665. Descuentos sobre ventas por pronto pago","CUE","665","59","66","","D-I-7-a"],
				["452","6650. Descuentos sobre ventas por pronto pago a empresas del grupo","CUE","6650","59","66","","D-I-7-a"],
				["453","6651. Descuentos sobre ventas por pronto pago a empresas asociadas","CUE","6651","59","66","","D-I-7-b"],
				["454","6653. Descuentos sobre ventas por pronto pago a otras empresas","CUE","6653","59","66","","D-I-7-c"],
				["455","666. Pérdidas en valores negociables","CUE","666","59","66","","D-I-7-d"],
				["456","6660. Pérdidas en valores negociables a l/p de empresas del grupo","CUE","6660","59","66","","D-I-7-d"],
				["457","6661. Pérdidas en valores negociables a l/p de empresas asociadas","CUE","6661","59","66","","D-I-7-d"],
				["458","6663. Pérdidas en valores negociables a l/p de otras empresas","CUE","6663","59","66","","D-I-7-d"],
				["459","6665. Pérdidas en valores negociables a c/p de empresas del grupo","CUE","6665","59","66","","D-I-7-d"],
				["460","6666. Pérdidas en valores negociables a c/p de empresas asociadas","CUE","6666","59","66","","D-I-7-d"],
				["461","6668. Pérdidas en valores negociables a c/p de otras empresas","CUE","6668","59","66","","D-I-7-d"],
				["462","667. Pérdidas de créditos","CUE","667","59","66","","D-I-7-d"],
				["463","6670. Pérdidas de créditos a l/p a empresas del grupo","CUE","6670","59","66","","D-I-7-d"],
				["464","6671. Pérdidas de créditos a l/p a empresas asociadas","CUE","6671","59","66","","D-I-7-d"],
				["465","6673. Pérdidas de créditos a l/p a otras empresas","CUE","6673","59","66","","D-I-7-d"],
				["466","6675. Pérdidas de créditos a c/p a empresas del grupo","CUE","6675","59","66","","D-I-7-d"],
				["467","6676. Pérdidas de créditos a c/p a empresas asociadas","CUE","6676","59","66","","D-I-7-d"],
				["468","6678. Pérdidas de créditos a c/p a otras empresas","CUE","6678","59","66","","D-I-7-d"],
				["469","668. Diferencias negativas de cambio","CUE","668","59","66","CAMNEG","D-I-9"],
				["470","6680. Diferencias negativas de cambio por la introducción del euro","CUE","6680","59","66","EURNEG","D-I-9"],
				["471","6681. Diferencias negativas de cambio","CUE","6681","59","66","","D-I-9"],
				["472","669. Otros gastos financieros","CUE","669","59","66","","D-I-7-c"],
				["473","6690. Gastos por diferencias derivadas del redondeo del euro","CUE","6690","59","66","","D-I-7-c"],
				["474","6691. Otros gastos financieros","CUE","6691","59","66","","D-I-7-c"],
				["60","67. PERDIDAS PROCEDENTES DEL INMOVILIZADO Y GASTOS EXCEPCIONALES","EPI","67","52","67","",""],
				["475","670. Pérdidas procedentes de inmovilizado inmaterial","CUE","670","60","67","","D-III-1"],
				["476","671. Pérdidas procedentes de inmovilizado material","CUE","671","60","67","","D-III-1"],
				["477","672. Pérdidas procedentes de participaciones en capital a l/p de empresas del grupo","CUE","672","60","67","","D-III-1"],
				["478","673. Pérdidas procedentes de participaciones en capital a l/p de empresas asociadas","CUE","673","60","67","","D-III-1"],
				["479","674. Pérdidas por operaciones con acciones y obligaciones propias","CUE","674","60","67","","D-III-2"],
				["480","676. Donaciones del inmovilizado material","CUE","676","60","67","","D-III-1"],
				["481","678. Gastos extraordinarios","CUE","678","60","67","","D-III-3"],
				["482","6780. Gastos producidos por la introducción del euro","CUE","6780","60","67","","D-III-3"],
				["483","6781. Otros gastos extraordinarios","CUE","6781","60","67","","D-III-3"],
				["484","679. Gastos y pérdidas de ejercicios anteriores","CUE","679","60","67","","D-III-4"],
				["61","68. DOTACIONES PARA AMORTIZACIONES","EPI","68","52","68","",""],
				["485","680. Amortización de gastos de establecimiento","CUE","680","61","68","","D-A-4"],
				["486","681. Amortización del inmovilizado inmaterial","CUE","681","61","68","","D-A-4"],
				["487","682. Amortización del inmovilizado material","CUE","682","61","68","","D-A-4"],
				["62","69. DOTACIONES A LAS PROVISIONES","EPI","69","52","69","",""],
				["488","690. Dotación al fondo de reversión","CUE","690","62","69","","D-A-6-d"],
				["489","691. Dotación a la provisión de inmovilizado inmaterial","CUE","691","62","69","","D-III-0"],
				["490","692. Dotación a la provisión del inmovilizado material","CUE","692","62","69","","D-III-0"],
				["491","693. Dotación a la provisión de existencias","CUE","693","62","69","","D-A-5-a"],
				["492","694. Dotación a la provisión para insolvencias de tráfico","CUE","694","62","69","","D-A-5-b"],
				["493","695. Dotación a la provisión para otras operaciones de tráfico","CUE","695","62","69","","D-A-5-c"],
				["494","696. Dotación a la provisión para valores negociables a l/p","CUE","696","62","69","","D-I-8"],
				["495","6960. Dotación a la provisión para participaciones en capital a l/p de empresas del grupo","CUE","6960","62","69","","D-III-0"],
				["496","6961. Dotación a la provisión para participaciones en capital a l/p de empresas asociadas","CUE","6961","62","69","","D-III-0"],
				["497","6963. Dotación a la provisión para participaciones en capital a l/p de otras empresas","CUE","6963","62","69","","D-I-8"],
				["498","6965. Dotación a la provisión para valores de renta fija a l/p de empresas del grupo","CUE","6965","62","69","","D-I-8"],
				["499","6966. Dotación a la provisión para valores de renta fija a l/p de empresas asociadas","CUE","6966","62","69","","D-I-8"],
				["500","697. Dotación a la provisión para insolvencias de créditos a l/p","CUE","697","62","69","","D-I-8"],
				["501","6970. Dotación a la provisión para insolvencias de créditos a l/p a empresas del grupo","CUE","6970","62","69","","D-I-8"],
				["502","6971. Dotación a la provisión para insolvencias de créditos a l/p a empresas asociadas","CUE","6971","62","69","","D-I-8"],
				["503","6973. Dotación a la provisión para insolvencias de créditos a l/p a otras empresas","CUE","6973","62","69","","D-I-8"],
				["504","698. Dotacion a la provisión para valores negociables a c/p","CUE","698","62","69","","D-I-8"],
				["505","6980. Dotacion a la provisión para valores negociables a c/p de empresas del grupo","CUE","6980","62","69","","D-I-8"],
				["506","6981. Dotacion a la provisión para valores negociables a c/p de empresas asociadas","CUE","6981","62","69","","D-I-8"],
				["507","6983. Dotacion a la provisión para valores negociables a c/p de otras empresas","CUE","6983","62","69","","D-I-8"],
				["508","699. Dotación a la provisión para insolvencias de créditos a c/p","CUE","699","62","69","","D-I-8"],
				["509","6990. Dotación a la provisión para insolvencias de créditos a c/p a empresas del grupo","CUE","6990","62","69","","D-I-8"],
				["510","6991. Dotación a la provisión para insolvencias de créditos a c/p a empresas asociadas","CUE","6991","62","69","","D-I-8"],
				["511","6993. Dotación a la provisión para insolvencias de créditos a c/p a otras empresas","CUE","6993","62","69","","D-I-8"],
				["63","7. VENTAS E INGRESOS","EPI","7","","7","",""],
				["64","70. VENTAS DE MERCADERIAS,DE PRODUCCION PROPIA,DE SERVICIOS, ETC.","EPI","70","63","70","",""],
				["512","700. Ventas de mercaderías","CUE","700","64","70","VENTAS","H-B-1-a"],
				["513","701. Ventas de productos terminados","CUE","701","64","70","VENTAS","H-B-1-a"],
				["514","702. Ventas de productos semiterminados","CUE","702","64","70","VENTAS","H-B-1-a"],
				["515","703. Ventas de subproductos y residuos","CUE","703","64","70","VENTAS","H-B-1-a"],
				["516","704. Ventas de envases y embalajes","CUE","704","64","70","VENTAS","H-B-1-a"],
				["517","705. Prestaciones de servicios","CUE","705","64","70","VENTAS","H-B-1-b"],
				["518","708. Devoluciones de ventas y operaciones similares","CUE","708","64","70","DEVVEN","H-B-1-c"],
				["519","7080. Devoluciones de ventas de mercaderías","CUE","7080","64","70","","H-B-1-c"],
				["520","7081. Devoluciones de ventas de productos terminados","CUE","7081","64","70","","H-B-1-c"],
				["521","7082. Devoluciones de ventas de productos semiterminados","CUE","7082","64","70","","H-B-1-c"],
				["522","7083. Devoluciones de ventas de subproductos y residuos","CUE","7083","64","70","","H-B-1-c"],
				["523","7084. Devoluciones de ventas de envases y embalajes","CUE","7084","64","70","","H-B-1-c"],
				["524","709. Rappels sobre ventas","CUE","709","64","70","","H-B-1-c"],
				["525","7090. Rappels sobre ventas de mercaderías","CUE","7090","64","70","","H-B-1-c"],
				["526","7091. Rappels sobre ventas de productos terminados","CUE","7091","64","70","","H-B-1-c"],
				["527","7092. Rappels sobre ventas de productos semiterminados","CUE","7092","64","70","","H-B-1-c"],
				["528","7093. Rappels sobre ventas de subproductos y residuos","CUE","7093","64","70","","H-B-1-c"],
				["529","7094. Rappels sobre ventas de envases y embalajes","CUE","7094","64","70","","H-B-1-c"],
				["65","71. VARIACION DE EXISTENCIAS","EPI","71","63","71","",""],
				["530","710. Variación de existencias de productos en curso","CUE","710","65","71","","D-A-1"],
				["531","711. Variación de existencias de productos semiterminados","CUE","711","65","71","","H-B-2"],
				["532","712. Variación de existencias de productos terminados","CUE","712","65","71","","H-B-2"],
				["533","713. Variación de existencias de subproductos, residuos y materiales recuperados","CUE","713","65","71","","H-B-2"],
				["66","73. TRABAJOS REALIZADOS PARA LA EMPRESA","EPI","73","63","73","",""],
				["534","730. Incorporación al activo de gastos de establecimiento","CUE","730","66","73","","H-B-3"],
				["535","731. Trabajos realizados para inmovilizado inmaterial","CUE","731","66","73","","H-B-3"],
				["536","732. Trabajos realizados para inmovilizado material","CUE","732","66","73","","H-B-3"],
				["537","733. Trabajos realizados para inmovilizado material en curso","CUE","733","66","73","","H-B-3"],
				["538","737. Incorporación al activo de gastos de formalización de deudas","CUE","737","66","73","","H-B-3"],
				["67","74. SUBVENCIONES A LA EXPLOTACION","EPI","74","63","74","",""],
				["539","740. Subvenciones oficiales a la explotación","CUE","740","67","74","","H-B-4-b"],
				["540","741. Otras subvenciones a la explotación","CUE","741","67","74","","H-B-4-b"],
				["68","75. OTROS INGRESOS DE GESTION","EPI","75","63","75","",""],
				["541","751. Resultados de operaciones en común","CUE","751","68","75","","H-B-4-a"],
				["542","7510. Pérdida transferida (gestor)","CUE","7510","68","75","","H-B-4-a"],
				["543","7511. Beneficio atribuido (partícipe o asociado no gestor)","CUE","7511","68","75","","H-B-4-a"],
				["544","752. Ingresos por arrendamientos","CUE","752","68","75","","H-B-4-a"],
				["545","753. Ingresos de propiedad industrial cedida en explotación","CUE","753","68","75","","H-B-4-a"],
				["546","754. Ingresos por comisiones","CUE","754","68","75","","H-B-4-a"],
				["547","755. Ingresos por servicios al personal","CUE","755","68","75","","H-B-4-a"],
				["548","759. Ingresos por servicios diversos","CUE","759","68","75","","H-B-4-a"],
				["69","76. INGRESOS FINANCIEROS","EPI","76","63","76","",""],
				["549","760. Ingresos de participaciones en capital","CUE","760","69","76","","H-I-5-a"],
				["550","7600. Ingresos de participaciones en capital de empresas del grupo","CUE","7600","69","76","","H-I-5-a"],
				["551","7601. Ingresos de participaciones en capital de empresas asociadas","CUE","7601","69","76","","H-I-5-b"],
				["552","7603. Ingresos de participaciones en capital de otras empresas","CUE","7603","69","76","","H-I-5-c"],
				["553","761. Ingresos de valores de renta fija","CUE","761","69","76","","H-I-6-a"],
				["554","7610. Ingresos de valores renta fija de empresas del grupo","CUE","7610","69","76","","H-I-6-a"],
				["555","7611. Ingresos de valores renta fija de empresas asociadas","CUE","7611","69","76","","H-I-6-b"],
				["556","7613. Ingresos de valores renta fija de otras empresas","CUE","7613","69","76","","H-I-6-c"],
				["557","7618. Ingresos de participaciones en Fondos de Inversión en Activos del Mercado Monetario","CUE","7618","69","76","","H-I-6-c"],
				["558","762. Ingresos de créditos a largo plazo","CUE","762","69","76","","H-I-6-a"],
				["559","7620. Ingresos de créditos a l/p a empresas del grupo","CUE","7620","69","76","","H-I-6-a"],
				["560","7621. Ingresos de créditos a l/p a empresas asociadas","CUE","7621","69","76","","H-I-6-b"],
				["561","7623. Ingresos de créditos a l/p a otras empresas","CUE","7623","69","76","","H-I-6-c"],
				["562","763. Ingresos de créditos a corto plazo","CUE","763","69","76","","H-I-7-a"],
				["563","7630. Ingresos de créditos a c/p a empresas del grupo","CUE","7630","69","76","","H-I-7-a"],
				["564","7631. Ingresos de créditos a c/p a empresas asociadas","CUE","7631","69","76","","H-I-7-b"],
				["565","7633. Ingresos de créditos a c/p a otras empresas","CUE","7633","69","76","","H-I-7-c"],
				["566","765. Descuentos sobre compras por pronto pago","CUE","765","69","76","","H-I-7-a"],
				["567","7650. Descuentos sobre compras por pronto pago de empresas del grupo","CUE","7650","69","76","","H-I-7-a"],
				["568","7651. Descuentos sobre compras por pronto pago de empresas asociadas","CUE","7651","69","76","","H-I-7-b"],
				["569","7653. Descuentos sobre compras por pronto pago de otras empresas","CUE","7653","69","76","","H-I-7-c"],
				["570","766. Beneficios en valores negociables","CUE","766","69","76","","H-I-7-d"],
				["571","7660. Beneficios en valores negociables a l/p de empresas del grupo","CUE","7660","69","76","","H-I-7-d"],
				["572","7661. Beneficios en valores negociables a l/p de empresas asociadas","CUE","7661","69","76","","H-I-7-d"],
				["573","7663. Beneficios en valores negociables a l/p de otras empresas","CUE","7663","69","76","","H-I-7-d"],
				["574","7665. Beneficios en valores negociables a c/p de empresas del grupo","CUE","7665","69","76","","H-I-7-d"],
				["575","7666. Beneficios en valores negociables a c/p de empresas asociadas","CUE","7666","69","76","","H-I-7-d"],
				["576","7668. Beneficios en valores negociables a c/p de otras empresas","CUE","7668","69","76","","H-I-7-d"],
				["577","768. Diferencias positivas de cambio","CUE","768","69","76","CAMPOS","H-I-8"],
				["578","7680. Diferencias positivas de cambio por la introducción del euro","CUE","7680","69","76","EURPOS","H-I-8"],
				["579","7681. Diferencias positivas de cambio","CUE","7681","69","76","","H-I-8"],
				["580","769. Otros ingresos financieros","CUE","769","69","76","","H-I-7-c"],
				["581","7690. Ingresos por diferencias derivadas del redondeo del euro","CUE","7690","69","76","","H-I-7-c"],
				["582","7691. Otros ingresos financieros","CUE","7691","69","76","","H-I-7-c"],
				["70","77. BENEFICIOS PROCEDENTES DEL INMOVILIZADO E INGRESOS EXCEPCIONALES","EPI","77","63","77","",""],
				["583","770. Beneficios procedentes de inmovilizado inmaterial","CUE","770","70","77","","H-III-A"],
				["584","771. Beneficios procedentes de inmovilizado material","CUE","771","70","77","","H-III-A"],
				["585","772. Beneficios procedentes de participaciones en capital a l/p de empresas del grupo","CUE","772","70","77","","H-III-A"],
				["586","773. Beneficios procedentes de participaciones en capital a l/p de empresas asociadas","CUE","773","70","77","","H-III-A"],
				["587","774. Beneficios por operaciones con acciones y obligaciones propias","CUE","774","70","77","","H-III-B"],
				["588","775. Subvenciones de capital traspasadas al resultado del ejercicio","CUE","775","70","77","","H-III-C"],
				["589","778. Ingresos extraordinarios","CUE","778","70","77","","H-III-D"],
				["590","779. Ingresos y beneficios de ejercicios anteriores","CUE","779","70","77","","H-III-E"],
				["71","79. EXCESOS Y APLICACIONES DE PROVISIONES","EPI","79","63","79","",""],
				["591","790. Exceso de provisión para riesgos y gastos","CUE","790","71","79","","H-B-4-c"],
				["592","791. Exceso de provisión del inmovilizado inmaterial","CUE","791","71","79","","D-III-0"],
				["593","792. Exceso de provisión del inmovilizado material","CUE","792","71","79","","D-III-0"],
				["594","793. Provisión de existencias aplicada","CUE","793","71","79","","D-A-5-a"],
				["595","794. Provisión para insolvencias de tráfico aplicada","CUE","794","71","79","","D-A-5-b"],
				["596","795. Provisión para otras operaciones de tráfico aplicada","CUE","795","71","79","","D-A-5-c"],
				["597","796. Exceso de provisión para valores negociables a l/p","CUE","796","71","79","","D-III-1"],
				["598","7960. Exceso de provisión para participaciones en capital a l/p de empresas del grupo","CUE","7960","71","79","","D-III-0"],
				["599","7961. Exceso de provisión para participaciones en capital a l/p de empresas asociadas","CUE","7961","71","79","","D-III-0"],
				["600","7963. Exceso de provisión para valores negociables a l/p de otras empresas","CUE","7963","71","79","","D-I-8"],
				["601","7965. Exceso de provisión para valores de renta fija a l/p de empresas del grupo","CUE","7965","71","79","","D-I-8"],
				["602","7966. Exceso de provisión para valores de renta fija a l/p de empresas asociadas","CUE","7966","71","79","","D-I-8"],
				["603","797. Exceso de provisión para insolvencias de créditos a l/p","CUE","797","71","79","","D-I-8"],
				["604","7970. Exceso de provisión para insolvencias de créditos a l/p de empresas del grupo","CUE","7970","71","79","","D-I-8"],
				["605","7971. Exceso de provisión para insolvencias de créditos a l/p de empresas asociadas","CUE","7971","71","79","","D-I-8"],
				["606","7973. Exceso de provisión para insolvencias de créditos a l/p de otras empresas","CUE","7973","71","79","","D-I-8"],
				["607","798. Exceso de provisión para valores negociables a c/p","CUE","798","71","79","","D-I-8"],
				["608","7980. Exceso de provisión para valores negociables a c/p de empresas del grupo","CUE","7980","71","79","","D-I-8"],
				["609","7981. Exceso de provisión para valores negociables a c/p de empresas asociadas","CUE","7981","71","79","","D-I-8"],
				["610","7983. Exceso de provisión para valores negociables a c/p de otras empresas","CUE","7983","71","79","","D-I-8"],
				["611","799. Exceso de provisión para insolvencias de créditos a c/p","CUE","799","71","79","","D-I-8"],
				["612","7990. Exceso de provisión para insolvencias de créditos a c/p de empresas del grupo","CUE","7990","71","79","","D-I-8"],
				["613","7991. Exceso de provisión para insolvencias de créditos a c/p de empresas asociadas","CUE","7991","71","79","","D-I-8"],
				["614","7993. Exceso de provisión para insolvencias de créditos a c/p de otras empresas","CUE","7993","71","79","","D-I-8"]];

		var curTab:FLSqlCursor = new FLSqlCursor("co_cuentas");
		util.createProgressDialog(util.translate("scripts", "Actualizando códigos de balance"),	datos.length);
		var paso:Number = 0;
		for (i = 0; i < datos.length; i++) {

			util.setProgress(paso++);

			if (datos[i][2] == "EPI")
				continue;

			curTab.select("codcuenta = '" + datos[i][0] + "' and codejercicio = '" + codEjercicio + "'");
			if (curTab.first()) {
				debug("Actualizando cuenta " + datos[i][0]);
				curTab.setModeAccess(curTab.Edit);
				curTab.refreshBuffer();
				curTab.setValueBuffer("codbalance", datos[i][7]);
				curTab.commitBuffer();
			}
		}
		util.destroyProgressDialog();

		MessageBox.information(util.translate("scripts",  "Proceso finalizado"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
}


/** Asocia a cada cliente la subcuenta 43 que ya debe existir
*/
function oficial_emparejarSubcuentasClientes()
{
	var util:FLUtil = new FLUtil();		
	var paso:Number = 0;
	var numClientes:Number = 0;

	var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
	var longSubcuenta:Number = util.sqlSelect("ejercicios", "longsubcuenta", "codejercicio = '" + codEjercicio + "'");
	var sctaClientes = flfacturac.iface.pub_datosCtaEspecial("CLIENT", codEjercicio);
	
	if (sctaClientes.error != 0) {
		MessageBox.warning(util.translate("scripts", "No tiene ninguna cuenta contable marcada como cuenta especial\nCLIENT.\nDebe asociar la cuenta a la cuenta especial en el módulo Principal del área Financiera"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
	
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("clientes");
	q.setFrom("clientes");
	q.setSelect("codcliente,nombre");
	q.setWhere("idsubcuenta is null or codsubcuenta is null or codsubcuenta = '' order by codcliente");
	debug(q.sql());
	if(!q.exec())
		return;
	
	var numCeros:Number;
	var idSubcuenta:Number;
	var codSubcuenta:String;
	var codCliente:String;
	var datosScta:Array;
	
	util.createProgressDialog( util.translate( "scripts", "Asociando subcuentas de cliente..." ), q.size());
	
	while(q.next()) {
	
		util.setProgress(paso++);
		
		codCliente = q.value(0);
		codSubcuenta = "43";
		numCeros = longSubcuenta - codSubcuenta.length - codCliente.length;
		for (var i:Number = 0; i < numCeros; i++)
			codSubcuenta += "0";
	
		if (codSubcuenta.length + codCliente.length > longSubcuenta)
			codCliente = codCliente.right(longSubcuenta - codSubcuenta.length);
	
		codSubcuenta += codCliente;
		idSubcuenta = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + codSubcuenta + "' AND codejercicio = '" + codEjercicio + "'");
	
		if (!idSubcuenta) {
			datosScta = flfactppal.iface.pub_ejecutarQry("co_subcuentas", "codsubcuenta,idsubcuenta", "descripcion = '" + q.value(1) + "'");
			if (datosScta.result < 1) {

				for (i=0; i<=9; i++) {
					codCliente = q.value(0);
					codSubcuenta = "430" + i + codCliente.right(4);
					debug(codSubcuenta);
					idSubcuenta = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + codSubcuenta + "' AND codejercicio = '" + codEjercicio + "'");
					if (idSubcuenta)
						i=20;
				}
				if (!idSubcuenta)
					continue;
			}
			else {
				idSubcuenta = datosScta.idsubcuenta;
				codSubcuenta = datosScta.codsubcuenta;
			}
			debug(q.value(1) + " " + idSubcuenta + " " + codSubcuenta );
		}

		numClientes++;

		util.sqlUpdate("clientes", "idsubcuenta,codsubcuenta", idSubcuenta + "," + codSubcuenta, "codcliente = '" + codCliente + "'");
	}
	
	util.destroyProgressDialog();	
	MessageBox.information(util.translate("scripts",  "Proceso finalizado.\n%0 clientes actualizados").arg(numClientes), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
}


function oficial_plazosPago() 
{
	var util:FLUtil = new FLUtil();
	var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
	
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("formaspago,plazos");
	q.setFrom("formaspago f left join plazos p on f.codpago = p.codpago");
	q.setSelect("f.codpago");
	q.setWhere("p.codpago is null");
	
	var curP:FLSqlCursor = new FLSqlCursor("plazos");
	
	q.exec();
	
	util.createProgressDialog( util.translate( "scripts", "Generando plazos de pago..." ), q.size());
	var paso:Number = 0;
	
	while(q.next()) {
		util.setProgress(paso++);
		curP.setModeAccess(curP.Insert);
		curP.refreshBuffer();
		curP.setValueBuffer("codpago", q.value(0));
		curP.setValueBuffer("dias", 0);
		curP.setValueBuffer("aplazado", 100);
		curP.commitBuffer();
	}
	
	util.destroyProgressDialog();	
}

function oficial_actualizarDescripcionesSubctasCli()
{
	var util:FLUtil = new FLUtil();
	var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
	
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("clientes,co_subcuentascli,co_subcuentas");
	q.setFrom("clientes c inner join co_subcuentascli sc on c.codcliente=sc.codcliente inner join co_subcuentas s on sc.idsubcuenta=s.idsubcuenta");
	q.setSelect("s.idsubcuenta,c.nombre,c.codcliente");
	q.setWhere("c.nombre <> s.descripcion");
	
	var curTab:FLSqlCursor = new FLSqlCursor("co_subcuentas");
	
	q.exec();
	
	util.createProgressDialog( util.translate( "scripts", "Actualizando descripciones de subcuentas..." ), q.size());
	var paso:Number = 0;
	
	while(q.next()) {
		
		curTab.select("idsubcuenta = " + q.value(0));
		if (!curTab.first())
			continue;
		
		curTab.setModeAccess(curTab.Edit);
		curTab.refreshBuffer();
		curTab.setValueBuffer("descripcion", q.value(1));
		curTab.commitBuffer();
		
		util.setProgress(paso++);
	}
	
	util.destroyProgressDialog();	
	
	MessageBox.information ( util.translate( "scripts", "Proceso finalizado. Subcuentas actualizadas: " + paso), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
}

function oficial_revisaRecibosCli(oParam)
{
// 	var _i = this.iface;
	var codEjercicio = flfactppal.iface.pub_ejercicioActual();
	var res = MessageBox.warning(sys.translate("Va a revisar el estado de los recibos de cliente en %1\n¿Está seguro?").arg(codEjercicio), MessageBox.Yes, MessageBox.No, MessageBox.NoButton, "AbanQ");
	if (res != MessageBox.Yes) {
		return false;
	}
	if (!flfactteso.iface.curReciboCli) {
		flfactteso.iface.curReciboCli = new FLSqlCursor("reciboscli");
	}
	var curReciboCli = flfactteso.iface.curReciboCli;
	curReciboCli.select("codigo LIKE '" + codEjercicio + "%'");
	var idRecibo;
	AQUtil.createProgressDialog(sys.translate("Revisando recibos"), curReciboCli.size());
	var p = 0;
	var curPD = new FLSqlCursor("pagosdevolcli");
	curPD.setActivatedCommitActions(false);
	curPD.setActivatedCheckIntegrity(false);
	while (curReciboCli.next()) {
		AQUtil.setProgress(p++);
		curReciboCli.setModeAccess(curReciboCli.Edit);
		curReciboCli.refreshBuffer();
		idRecibo = curReciboCli.valueBuffer("idrecibo");
		curReciboCli.setValueBuffer("estado", formRecordreciboscli.iface.pub_obtenerEstado(idRecibo));
		if (!flfactteso.iface.totalesReciboCli()) {
			AQUtil.destroyProgressDialog();
			oParam.errorMsg = sys.translate("Error al calcular los datos del recibo %1").arg(curReciboCli.valueBuffer("codigo"))
			return false;
		}
		if (!curReciboCli.commitBuffer()) {
			oParam.errorMsg = sys.translate("Error al guardar recibo %1").arg(curReciboCli.valueBuffer("codigo"))
			AQUtil.destroyProgressDialog();
			return false;
		}
		/// Comprueba que el último registro de pago es editable
		curPD.select("idrecibo = " + idRecibo + " ORDER BY fecha DESC, idpagodevol DESC");
		if (curPD.first()) {
			if (!curPD.valueBuffer("editable")) {
				curPD.setUnLock("editable", true);
			}
		}
	}
	AQUtil.destroyProgressDialog();
	return true;
}


function oficial_revisaAsientoPagoRecibosCli(oParam)
{
// 	var _i = this.iface;
	var codEjercicio = flfactppal.iface.pub_ejercicioActual();
	var res = MessageBox.warning(sys.translate("Va a revisar los asientos de pago de los recibos de cliente en %1\n¿Está seguro?").arg(codEjercicio), MessageBox.Yes, MessageBox.No, MessageBox.NoButton, "AbanQ");
	if (res != MessageBox.Yes) {
		return false;
	}
	var curReciboCli = new FLSqlCursor("reciboscli");;
	curReciboCli.select("codigo LIKE '" + codEjercicio + "%'");
// 	curReciboCli.select("codigo = '20120A000161-01'");
	var idRecibo, idPagoDevol;
	AQUtil.createProgressDialog(sys.translate("Revisando recibos"), curReciboCli.size());
	var p = 0, idAsiento;
	var curPD = new FLSqlCursor("pagosdevolcli");
	curPD.setActivatedCommitActions(false);
	curPD.setActivatedCheckIntegrity(false);
	while (curReciboCli.next()) {
		AQUtil.setProgress(p++);
		curReciboCli.setModeAccess(curReciboCli.Browse);
		curReciboCli.refreshBuffer();
		idRecibo = curReciboCli.valueBuffer("idrecibo");
		curPD.select("idrecibo = " + idRecibo + " ORDER BY fecha DESC, idpagodevol DESC");
		if (curPD.first()) {
			curPD.setModeAccess(curPD.Edit);
			curPD.refreshBuffer();
			
			idAsiento = curPD.valueBuffer("idasiento");
			if (idAsiento && idAsiento != 0) {
				if (!AQUtil.sqlSelect("co_asientos", "idasiento", "idasiento = " + idAsiento)) {
					debug("va a nulo");
					curPD.setNull("idasiento");
				}
			}
			if (!flfactteso.iface.generarAsientoPagoDevolCli(curPD)) {
				AQUtil.destroyProgressDialog();
				return false;
			}
			if (!curPD.commitBuffer()) {
				AQUtil.destroyProgressDialog();
				return false;
			}
		}
	}
	AQUtil.destroyProgressDialog();
	return true;
}

function oficial_revisaAsientoPagoRemesas(oParam)
{
// 	var _i = this.iface;
	var codEjercicio = flfactppal.iface.pub_ejercicioActual();
	var fechaD = AQUtil.sqlSelect("ejercicios", "fechainicio", "codejercicio = '" + codEjercicio + "'");
	var fechaH = AQUtil.sqlSelect("ejercicios", "fechafin", "codejercicio = '" + codEjercicio + "'");
	
	var res = MessageBox.warning(sys.translate("Va a revisar los asientos de pago de las remesas de cliente desde %1 hasta %2\n¿Está seguro?").arg(AQUtil.dateAMDtoDMA(fechaD)).arg(AQUtil.dateAMDtoDMA(fechaH)), MessageBox.Yes, MessageBox.No, MessageBox.NoButton, "AbanQ");
	if (res != MessageBox.Yes) {
		return false;
	}
	var curRemesa = new FLSqlCursor("remesas");;
	curRemesa.select("fecha BETWEEN '" + fechaD + "' AND '" + fechaH + "'");
	var idRemesa;
	AQUtil.createProgressDialog(sys.translate("Revisando remesas"), curRemesa.size());
	var p = 0, idAsiento;
	var curPD = new FLSqlCursor("pagosdevolrem");
	curPD.setActivatedCommitActions(false);
	curPD.setActivatedCheckIntegrity(false);
	while (curRemesa.next()) {
		AQUtil.setProgress(p++);
		curRemesa.setModeAccess(curRemesa.Browse);
		curRemesa.refreshBuffer();
		idRemesa = curRemesa.valueBuffer("idremesa");
		curPD.select("idremesa = " + idRemesa + " ORDER BY fecha DESC, idpagorem DESC");
		if (curPD.first()) {
			curPD.setModeAccess(curPD.Edit);
			curPD.refreshBuffer();
			
			idAsiento = curPD.valueBuffer("idasiento");
			if (idAsiento && idAsiento != 0) {
				if (!AQUtil.sqlSelect("co_asientos", "idasiento", "idasiento = " + idAsiento)) {
					debug("va a nulo");
					curPD.setNull("idasiento");
				}
			}
			if (!flfactteso.iface.generarAsientoPagoRemesa(curPD)) {
				AQUtil.destroyProgressDialog();
				return false;
			}
			if (!curPD.commitBuffer()) {
				AQUtil.destroyProgressDialog();
				return false;
			}
		}
	}
	AQUtil.destroyProgressDialog();
	return true;
}

function oficial_procesaStocksPtes(oParam)
{
	var q = new FLSqlQuery;
	q.setSelect("idusuario");
	q.setFrom("stocksptes");
	q.setWhere("1 = 1 GROUP BY idusuario");
	if (!q.exec()) {
		return false;
	}
	flfactppal.iface.pub_creaDialogoProgreso(sys.translate("Procesando stocks"), q.size());
	var p = 0;
	while (q.next()) {
		AQUtil.setProgress(p++);
		if (!flfactalma.iface.procesaStocks(q.value("idusuario"))) {
			AQUtil.destroyProgressDialog();
			return false;
		}
	}
	AQUtil.destroyProgressDialog();

	return true;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////