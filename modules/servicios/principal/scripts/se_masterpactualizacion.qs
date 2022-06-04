/***************************************************************************
                 se_masterpactualizacion.qs  -  description
                             -------------------
    begin                : lun jun 20 2005
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
	var tableDBRecords;
	var chkNoFacturados;
    function oficial( context ) { interna( context ); } 
    function generarPeriodos() { return this.ctx.oficial_generarPeriodos(); }
    function generarPActualizacion(codContrato, codCliente, dirlocal) { return this.ctx.oficial_generarPActualizacion(codContrato, codCliente, dirlocal); }
    function facturar() { return this.ctx.oficial_facturar(); }
    function facturarPeriodo() { return this.ctx.oficial_facturarPeriodo(); }
    function generarFactura(idPactualizacion:Number, codCliente:String, coste:Number, codContrato:String) { return this.ctx.oficial_generarFactura(idPactualizacion, codCliente, coste, codContrato); }
    function comprobarPagos(idPactualizacion, codCliente) { return this.ctx.oficial_comprobarPagos(idPactualizacion, codCliente); }
	function numMeses(periodo:String) { return this.ctx.oficial_numMeses(periodo); }
	function actualizarPactualizacion(idPactualizacion, idFactura) { return this.ctx.oficial_actualizarPactualizacion(idPactualizacion, idFactura); }
	function actualizarContrato(idPactualizacion) { return this.ctx.oficial_actualizarContrato(idPactualizacion); }
    function fechasFacturacion() { return this.ctx.oficial_fechasFacturacion(); }
	function cambioChkNoFacturados() {	return this.ctx.oficial_cambioChkNoFacturados(); }
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
function interna_init()
{
	this.iface.chkNoFacturados = this.child("chkNoFacturados");
	this.iface.tableDBRecords = this.child("tableDBRecords");
	connect( this.child("pbnFacturar"), "clicked()", this, "iface.facturar" );
	connect( this.child("pbnFacturarPeriodo"), "clicked()", this, "iface.facturarPeriodo" );
	connect( this.child("pbnGenerarPeriodos"), "clicked()", this, "iface.generarPeriodos" );
	connect(this.iface.chkNoFacturados, "clicked()", this, "iface.cambioChkNoFacturados");
	this.iface.chkNoFacturados.checked = false;
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D
Genera los períodos de actualización para el mes presente, con las fechas de inicio y 
fin del mes actual. Se genera un periodo por cada contrato vigente.
\end */
function oficial_generarPeriodos()
{
	var util= new FLUtil();
	var hoy = new Date();
	
	var q= new FLSqlQuery();
	q.setTablesList("se_contratosman");
	q.setFrom("se_contratosman");
	q.setSelect("codigo,codcliente,dirlocal");
	q.setWhere("estado = 'Vigente'");
	
	if (!q.exec()) return;
	
	var totalSteps= util.sqlSelect("se_contratosman", "count(codigo)", "estado = 'Vigente'");
	util.createProgressDialog( util.translate( "scripts", "Generando periodos" ), totalSteps * 100);
	var step= 0;
	util.setProgress(1);
	
	var clientesPeriodados= "";
	
	while(q.next()) {

		codContrato = q.value(0);
		codCliente = q.value(1);
		dirLocal = q.value(2);
		
		var ultimaFecha = util.sqlSelect("se_pactualizacion", "fechafin", "codcontrato ='" + codContrato + "' order by fechafin DESC")
		if (ultimaFecha < hoy) {
			this.iface.generarPActualizacion(codContrato, codCliente, dirLocal);
			clientesPeriodados += "\n- " + util.sqlSelect("clientes", "nombre", "codcliente = '" +  codCliente + "'");
		}
		
		util.setProgress( 100 * step );
		step++;
	}
	util.setProgress(totalSteps * 100);
	util.destroyProgressDialog();	
	
	if (clientesPeriodados)
		mensaje = util.translate("scripts", "Se generaron periodos para los clientes siguientes:\n") + clientesPeriodados;
	else
		mensaje = util.translate("scripts", "No se encontraron periodos pendientes de generar para el mes actual");
	
	MessageBox.information(mensaje, MessageBox.Ok, MessageBox.NoButton);
}
/** \D
Genera el registro correspondiente a un periodo de actualización
@param codContrato Código del contrato al que pertenece el periodo
@param codCliente Código del client al que pertenece el contrato
@dirlocal directorio local donde se encuentran los módulos del cliente
\end */
function oficial_generarPActualizacion(codContrato, codCliente, dirlocal) 
{
	var util= new FLUtil();
	
	var nomCliente= util.sqlSelect("clientes", "nombre",  "codcliente = '" + codCliente + "'" );
	
	var fechaInicio= new Date();
	fechaInicio.setDate(1);
	
	var ultimoDia= 31;
	var fechaFin= new Date();
	fechaFin.setDate(ultimoDia--);
	while (!fechaFin) {
		fechaFin = new Date();
		fechaFin.setDate(ultimoDia--);
	}
	
	var pesoParche= util.sqlSelect("se_pactualizacion", "pesoparche",  "codcontrato = '" + codContrato + "' order by fechafin desc" );
	if (!pesoParche) pesoParche = 0;

	var tipoContrato= util.sqlSelect("se_contratosman", "tipocontrato", "codigo = '"  + codContrato + "'");
	var coste:Number;
	if(tipoContrato == "Basico") {
		coste = util.sqlSelect("se_pactualizacion", "coste",  "codcontrato = '" + codContrato + "' order by fechafin desc" );
		if (!coste)
			coste = util.sqlSelect("se_tiposcontrato", "coste",  "nombre = 'Basico'" ) / this.iface.numMeses(util.sqlSelect("se_tiposcontrato", "periodopago",  "nombre = 'Basico'" ));
	}
	else
		coste = util.sqlSelect("se_cuotas", "coste", "tipocontrato = '" + tipoContrato + "' AND limitesuperior >= " + pesoParche + " and limiteinferior <=" + pesoParche)
	
	debug(coste);
		
	var totalIncidencias= util.sqlSelect("se_cuotas", "incidencias", "tipocontrato = '" + tipoContrato + "' AND limitesuperior >= " + pesoParche + " and limiteinferior <= " + pesoParche);
	if (!totalIncidencias) totalIncidencias = 0;
	
	var curPActualizacion= new FLSqlCursor("se_pactualizacion");
	with(curPActualizacion) {
		setModeAccess(Insert);
		refreshBuffer();
		
		setValueBuffer("codcontrato", codContrato);
		setValueBuffer("codcliente", codCliente);
		setValueBuffer("nomcliente", nomCliente);
		setValueBuffer("fechainicio", fechaInicio);
		setValueBuffer("fechafin", fechaFin);
		setValueBuffer("facturado", false);
		setValueBuffer("pesoparche", pesoParche);
		setValueBuffer("coste", coste);
		setValueBuffer("dirlocal", dirlocal);
		setValueBuffer("totalincidencias", totalIncidencias);
		setValueBuffer("incidencias", 0);		
		
		if (!commitBuffer()) return;
	}
}
/** \D
Genera las facturas del mes presente, una por cada período aún no facturado
\end */
function oficial_facturar()
{
	var util= new FLUtil();
	var hoy = new Date();
	
	var res = MessageBox.warning( util.translate( "scripts", "Se va a generar la facturación del mes actual.\n\n¿Continuar?" ), MessageBox.No, MessageBox.Yes, MessageBox.NoButton );
	if ( res != MessageBox.Yes ) return;
	
	if (!this.iface.fechasFacturacion()) {
		MessageBox.information(util.translate("scripts", "Sólo es posible facturar durante los 5 primeros días del mes"),
			 MessageBox.Ok, MessageBox.NoButton);
		return;
	}

	var q= new FLSqlQuery();
	q.setTablesList("se_pactualizacion");
	q.setFrom("se_pactualizacion");
	q.setSelect("id,codcliente,coste,codcontrato");
	q.setWhere("facturado = 'false' and fechainicio <= '" + hoy + "' and fechafin >= '" + hoy + "'");
	
	if (!q.exec()) return;

	var totalSteps= util.sqlSelect("se_pactualizacion", "count(codcliente)", "fechainicio < '" + hoy + "' and fechafin > '" + hoy + "'");
	util.createProgressDialog( util.translate( "scripts", "Generando facturas de cliente" ), totalSteps * 100);
	var step= 0;
	util.setProgress(1);
	
	var clientesFacturados= "";
	var clientesAntesPagados= "";
	
	while(q.next()) {

		idPactualizacion = q.value(0);
		codCliente = q.value(1);
		coste = q.value(2);
		codContrato = q.value(3);
			
		if (!coste) {
			MessageBox.information(util.translate("scripts", "El coste del período correspondiente a este cliente no se facturará. El coste del período no se ha establecido\nCliente " + codCliente),
				MessageBox.Ok, MessageBox.NoButton);
			continue;
		}
		
		var idFactura= this.iface.comprobarPagos(idPactualizacion, codCliente);
	
		if (!idFactura) {
			if(this.iface.generarFactura(idPactualizacion, codCliente, coste, codContrato)){
				clientesFacturados += "\n- " + util.sqlSelect("clientes", "nombre", "codcliente = '" +  codCliente + "'");
			}
			else continue;
		}
		else {
			this.iface.actualizarPactualizacion(idPactualizacion, idFactura);
			clientesAntesPagados += "\n- " + util.sqlSelect("clientes", "nombre", "codcliente = '" +  codCliente + "'");
		}

		util.setProgress( 100 * step );
		step++;
	}
	util.setProgress(totalSteps * 100);
	util.destroyProgressDialog();	
	
	var mensaje= "Resultados de la facturación:";
	
	if (clientesFacturados)
		mensaje += util.translate("scripts", "\n\nSe generaron nuevas facturas para los clientes siguientes:\n") + clientesFacturados;
	
	if (clientesAntesPagados)
		mensaje += "\n\n" + util.translate("scripts", "Los siguientes clientes pagaron con antelación este mes:\n") + clientesAntesPagados;
	
	if (step == 0)
		mensaje = util.translate("scripts", "No se encontraron clientes pendientes de facturar en el mes actual");
		
	if(clientesFacturados || clientesAntesPagados || step == 0)
		MessageBox.information(mensaje, MessageBox.Ok, MessageBox.NoButton);
}
/** \D
Genera las facturas del mes presente, para el periodo seleccionado en la tabla
\end */
function oficial_facturarPeriodo()
{
	var util= new FLUtil();
	var hoy = new Date();
	var cursor= this.cursor();
	var idPactualizacion= cursor.valueBuffer("id");
	
	var res = MessageBox.warning( util.translate( "scripts", "Se va a generar la facturación del periodo seleccionado.\n\n¿Continuar?" ), MessageBox.No, MessageBox.Yes, MessageBox.NoButton );
	if ( res != MessageBox.Yes ) return;
	
	if (!this.iface.fechasFacturacion()) {
		MessageBox.information(util.translate("scripts", "Sólo es posible facturar durante los 5 primeros días del mes"),
			 MessageBox.Ok, MessageBox.NoButton);
		return;
	}

	if (cursor.valueBuffer("facturado")) {
		MessageBox.information(util.translate("scripts", "Este periodo ya ha sido facturado"),
			 MessageBox.Ok, MessageBox.NoButton);
		return;
	}

	if ( (hoy < cursor.valueBuffer("fechainicio")) || (hoy > cursor.valueBuffer("fechafin")) ) {
		MessageBox.information(util.translate("scripts", "Este periodo no pertenece al mes actual"),
			 MessageBox.Ok, MessageBox.NoButton);
		return;
	}

	var clienteFacturado= "";
	var clienteAntesPagado= "";
	
	codCliente = cursor.valueBuffer("codcliente");
	coste = cursor.valueBuffer("coste");
	debug(coste);
	codContrato = cursor.valueBuffer("codcontrato");
		
	if (!coste) {
		MessageBox.information(util.translate("scripts", "El coste del período correspondiente a este cliente no se facturará. El coste del período no se ha establecido\nCliente " + codCliente),
			MessageBox.Ok, MessageBox.NoButton);
		return;
	}
	
	var idFactura= this.iface.comprobarPagos(idPactualizacion, codCliente);

	if (!idFactura) {
		if(this.iface.generarFactura(idPactualizacion, codCliente, coste, codContrato)){
			clienteFacturado += "\n- " + util.sqlSelect("clientes", "nombre", "codcliente = '" +  codCliente + "'");
		}
	}
	else {
		this.iface.actualizarPactualizacion(idPactualizacion, idFactura);
		clienteAntesPagado += "\n- " + util.sqlSelect("clientes", "nombre", "codcliente = '" +  codCliente + "'");
	}

	var mensaje= "Resultados de la facturación:";
	
	if (clienteFacturado)
		mensaje += util.translate("scripts", "\n\nSe generó la factura para el cliente:\n") + clienteFacturado;
	
	if (clienteAntesPagado)
		mensaje += "\n\n" + util.translate("scripts", "El cliente pagó con antelación este mes:\n") + clienteAntesPagado;
	if(clienteFacturado || clienteAntesPagado)
		MessageBox.information(mensaje, MessageBox.Ok, MessageBox.NoButton);
}
/** \D
Genera la factura correspondiente a un periodo de actualizacion. Si el periodo fue
pagado en una factura anterior por varios meses, busca el id de dicha factura y lo asocia
al periodo

@param idPactualizacion Identificador del periodo de actualizacion
@param codCliente Código del cliente al que se factura
@param coste Coste mensual del servicio
\end */
function oficial_generarFactura(idPactualizacion:Number, codCliente:String, coste:Number, codContrato:String)
{
	var util= new FLUtil();
	
	var tipoContrato= util.sqlSelect("se_contratosman","tipocontrato","codigo = '" + codContrato + "'");
	if(tipoContrato == "No Facturable") {
		MessageBox.warning(util.translate("scripts", "No se generará la factura para el cliente ") + codCliente + util.translate("scripts", ",\n el tipo de contrato es No Facturable"),
			MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	
	var hoy = new Date();
	
	var q= new FLSqlQuery();
	q.setTablesList("clientes");
	q.setFrom("clientes");
	q.setSelect("nombre,cifnif,coddivisa,codpago,codserie,codagente");
	q.setWhere("codcliente = '" + codCliente + "'");
	
	if (!q.exec()) return;
	if (!q.first()) {
		MessageBox.warning(util.translate("scripts", "Error al obtener los datos del cliente\nNo se generará la factura de este cliente: ") + codCliente,
			MessageBox.Ok, MessageBox.NoButton);
		return;
	}
	
	var qDir= new FLSqlQuery();
	qDir.setTablesList("dirclientes");
	qDir.setFrom("dirclientes");
	qDir.setSelect("id,direccion,codpostal,ciudad,provincia,apartado,codpais");
	qDir.setWhere("codcliente = '" + codCliente + "' and domfacturacion = '" + true + "'");
	
	if (!qDir.exec()) return;
	if (!qDir.first()) {
		MessageBox.warning(util.translate("scripts", "Error al obtener la dirección del cliente\nAsegúrate de que este cliente tiene una dirección de facturación\nNo se generará la factura de este cliente: ") + codCliente,
			MessageBox.Ok, MessageBox.NoButton);
		return;
	}
	
	var curFactura= new FLSqlCursor("facturascli");
	var numeroFactura= flfacturac.iface.pub_siguienteNumero(q.value(4),flfactppal.iface.pub_ejercicioActual(), "nfacturacli");
	var codEjercicio= flfactppal.iface.pub_ejercicioActual();
	var codPago = util.sqlSelect("se_contratosman", "codpago", "codigo = '" + codContrato + "'");

	with(curFactura) {
		setModeAccess(Insert);
		refreshBuffer();
		
		setValueBuffer("codigo", flfacturac.iface.pub_construirCodigo(q.value(4), codEjercicio, numeroFactura));
		setValueBuffer("numero", numeroFactura);
		setValueBuffer("irpf", util.sqlSelect("series", "irpf", "codserie = '" + q.value(4) + "'"));
		setValueBuffer("recfinanciero", 0);
		
		setValueBuffer("codcliente", codCliente);
		setValueBuffer("nombrecliente", q.value(0));
		setValueBuffer("cifnif", q.value(1));
		
		setValueBuffer("codejercicio", codEjercicio);
		setValueBuffer("coddivisa", q.value(2));
		setValueBuffer("codpago", codPago);
		setValueBuffer("codalmacen", flfactppal.iface.pub_valorDefectoEmpresa("codalmacen"));
		setValueBuffer("codserie", q.value(4));
		setValueBuffer("tasaconv", util.sqlSelect("divisas", "tasaconv", "coddivisa = '" + q.value(2) + "'"));
		setValueBuffer("fecha", hoy);
		
		setValueBuffer("codagente", q.value(5));
		setValueBuffer("porcomision", util.sqlSelect("agentes", "porcomision", "codagente = '" + q.value(5) + "'"));
				
		setValueBuffer("coddir", qDir.value(0));
		setValueBuffer("direccion", qDir.value(1));
		setValueBuffer("codpostal", qDir.value(2));
		setValueBuffer("ciudad", qDir.value(3));
		setValueBuffer("provincia", qDir.value(4));
		setValueBuffer("apartado", qDir.value(5));
		setValueBuffer("codpais", qDir.value(6));
	}
	
	if (!curFactura.commitBuffer()) {
		return false;
	}

	
	var codContrato= util.sqlSelect("se_pactualizacion", "codcontrato", "id = " + idPactualizacion);
	var periodoPago= util.sqlSelect("se_contratosman", "periodopago", "codigo = '" + codContrato + "'");
	var mesesPago= this.iface.numMeses(periodoPago);
	
	var idFactura= curFactura.valueBuffer("idfactura");
	var curLineaFactura= new FLSqlCursor("lineasfacturascli");

	debug(coste + " " + mesesPago);
	debug(coste*mesesPago);
	
	with(curLineaFactura) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("idfactura", idFactura);
		setValueBuffer("referencia", "");
		setValueBuffer("descripcion", "Serv. actualizaciones/manteniminento. Pago " + periodoPago + " desde : " + hoy.getMonth() + "/" + hoy.getYear());
		setValueBuffer("pvpunitario", coste);
		setValueBuffer("pvpsindto", coste * mesesPago);
		setValueBuffer("cantidad", mesesPago);
		setValueBuffer("pvptotal", coste * mesesPago);
		setValueBuffer("codimpuesto", "IVA16");
		setValueBuffer("iva", 16.00);
		setValueBuffer("recargo", 0);
		setValueBuffer("dtolineal", 0);
		setValueBuffer("dtopor", 0);
	}
	if (!curLineaFactura.commitBuffer())
		return false;
	
	curFactura.select("idfactura = " + idFactura);
	if (curFactura.first()) {
		if (!formRecordfacturascli.iface.pub_actualizarLineasIva(idFactura))
			return false;
		with(curFactura) {
			setModeAccess(Edit);
			refreshBuffer();
			setValueBuffer("neto", util.sqlSelect("lineasivafactcli", "SUM(neto)", "idfactura = " + idFactura));
			setValueBuffer("netosindtoesp", util.sqlSelect("lineasivafactcli", "SUM(neto)", "idfactura = " + idFactura));
			setValueBuffer("totaliva", formfacturascli.iface.pub_commonCalculateField("totaliva", curFactura));
			setValueBuffer("totalirpf", formfacturascli.iface.pub_commonCalculateField("totalirpf", curFactura));
			setValueBuffer("totalrecargo", formfacturascli.iface.pub_commonCalculateField("totalrecargo", curFactura));
			setValueBuffer("total", formfacturascli.iface.pub_commonCalculateField("total", curFactura));
			setValueBuffer("totaleuros", formfacturascli.iface.pub_commonCalculateField("totaleuros", curFactura));
			setValueBuffer("codigo", formfacturascli.iface.pub_commonCalculateField("codigo", curFactura));
		}
		if (!curFactura.commitBuffer())
			return false;
	}
	
	this.iface.actualizarPactualizacion(idPactualizacion, idFactura);
	this.iface.actualizarContrato(idPactualizacion);
	
	return true;
}
/** \D
Una vez realizada la factura, actualiza el periodo de actualización marcándolo
como facturado y registrando el número de factura

@param idPactualizacion Identificador del periodo de actualizacion
@param idFactura Identificador de la factura
\end */
function oficial_actualizarPactualizacion(idPactualizacion, idFactura)
{
	var curPactualizacion= new FLSqlCursor("se_pactualizacion");
	with(curPactualizacion) {
		select("id = "  + idPactualizacion);
		first();
		setModeAccess(Edit);
		refreshBuffer();
		setValueBuffer("facturado", true);
		setValueBuffer("idfactura", idFactura);
		commitBuffer();
	}
}

/** \D
Actualiza el contrato al que pertenece el período de actualización con la fecha 
de último pago.
@param idPactualizacion Identificador del periodo de actualizacion
\end */
function oficial_actualizarContrato(idPactualizacion)
{
	var util= new FLUtil();
	var codContrato= util.sqlSelect("se_pactualizacion", "codcontrato", "id = " + idPactualizacion);
	
	var hoy = new Date();
	var curContrato= new FLSqlCursor("se_contratosman");
	with(curContrato) {
		select("codigo = '" + codContrato + "'");
		first();
		setModeAccess(Edit);
		refreshBuffer();
		setValueBuffer("ultimopago", hoy);
		commitBuffer();
	}
}

/** \D
Comprueba si un determinado periodo de actualización ha sido ya facturado

@param idPactualizacion Identificador del periodo de actualizacion
@param codCliente Código del cliente
@return Identificador de la factura en caso de existir, cero en caso contrario
\end */
function oficial_comprobarPagos(idPactualizacion, codCliente)
{
	var util= new FLUtil();
	var codContrato= util.sqlSelect("se_pactualizacion", "codcontrato", "id = " + idPactualizacion);

	var q= new FLSqlQuery();
	q.setTablesList("se_contratosman");
	q.setFrom("se_contratosman");
	q.setSelect("periodopago,ultimopago");
	q.setWhere("codigo = '" + codContrato + "'");
	
	if (!q.exec()) return;
	if (!q.first()) {
		MessageBox.warning(util.translate("scripts", "la información del contrato para el cliente: ") + codCliente,
			MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	
	var periodoPago = q.value(0);
	var ultimoPago = q.value(1);
	
	if (!ultimoPago) return;
	
	var fechaLimite = util.addMonths(ultimoPago, this.iface.numMeses(periodoPago));	
	var hoy= new Date();
	
	var mesesHoy= hoy.getYear()*12 + hoy.getMonth();
	var mesesLimite= fechaLimite.getYear()*12 + fechaLimite.getMonth();
	
	if (hoy.getYear()*12 + hoy.getMonth() >= fechaLimite.getYear()*12 + fechaLimite.getMonth()) return;
	debug("id <> '" + idPactualizacion + "' AND codcontrato = '" + codContrato + "' order by fechafin desc");
	var idFactura = util.sqlSelect("se_pactualizacion", "idfactura", "id <> '" + idPactualizacion + "' AND codcontrato = '" + codContrato + "' order by fechafin desc" );
	return idFactura;
}

/** \D
Devuelve el número de meses de un período

@param periodo Tipo de cuota (mensual, semestral, etc)
@return Número de meses del período
\end */
function oficial_numMeses(periodo:String) 
{	
	var arrayMeses:Array;
	arrayMeses["Mensual"] = 1;
	arrayMeses["Bimestral"] = 2;
	arrayMeses["Trimestral"] = 3;
	arrayMeses["Semestral"] = 6;
	arrayMeses["Anual"] = 12;
	arrayMeses["Bienal"] = 24;

	return arrayMeses[periodo];
}

/** \D
Comprueba que la fecha actual está entre los 5 primeros días del mes

@return true si el día actual del mes es menor o igual de 5, false en caso contrario
\end */
function oficial_fechasFacturacion()
{
	var hoy = new Date();
	if (hoy.getDate() > 35) return false;
	return true;
}

/** \D Muestra sólo los períodos pendientes de facturar
\end */
function oficial_cambioChkNoFacturados()
{ 
		/// Temporal, eliminar
	var curCliente = new FLSqlCursor("clientes");
	curCliente.setActivatedCommitActions(false);
	curCliente.select();
	while (curCliente.next()) {
		curCliente.setModeAccess(curCliente.Edit);
		curCliente.refreshBuffer();
		curCliente.setValueBuffer("facturado2010", formRecordse_clientes.iface.pub_commonCalculateField("facturado2010", curCliente));
		curCliente.setValueBuffer("horastrab2010", formRecordse_clientes.iface.pub_commonCalculateField("horastrab2010", curCliente));		
		curCliente.setValueBuffer("brutohora2010", formRecordse_clientes.iface.pub_commonCalculateField("brutohora2010", curCliente));
		curCliente.commitBuffer();
	}
	var curProyecto = new FLSqlCursor("se_proyectos");
	curProyecto.select();
	while (curProyecto.next()) {
		curProyecto.setModeAccess(curProyecto.Edit);
		curProyecto.refreshBuffer();
		curProyecto.commitBuffer();
	}
		/// Temporal, eliminar (FIN)
	
	
	if(this.iface.chkNoFacturados.checked == true)
		this.iface.tableDBRecords.cursor().setMainFilter("facturado = 'false'");
	else
		this.iface.tableDBRecords.cursor().setMainFilter("");
	
	this.iface.tableDBRecords.refresh();
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
