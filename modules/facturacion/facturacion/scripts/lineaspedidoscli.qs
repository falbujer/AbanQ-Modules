/***************************************************************************
                 lineaspedidoscli.qs  -  description
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
    var ctx;
    function interna( context ) { this.ctx = context; }
    function init() { this.ctx.interna_init(); }
	function calculateField(fN) { return this.ctx.interna_calculateField(fN); }
	function validateForm():Boolean { return this.ctx.interna_validateForm(); }
	function acceptedForm() { return this.ctx.interna_acceptedForm(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
    function oficial( context ) { interna( context ); } 
	function desconectar() {
		return this.ctx.oficial_desconectar();
	}
	function bufferChanged(fN) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function commonBufferChanged(fN, miForm) {
		return this.ctx.oficial_commonBufferChanged(fN, miForm);
	}
	function calculaPrecio(miForm) {
		return this.ctx.oficial_calculaPrecio(miForm);
	}
	function commonCalculateField(fN, cursor) {
		return this.ctx.oficial_commonCalculateField(fN, cursor);
	}
	function obtenerTarifa(codCliente, cursor) {
		return this.ctx.oficial_obtenerTarifa(codCliente, cursor);
	}
	function datosTablaPadre(cursor) {
		return this.ctx.oficial_datosTablaPadre(cursor);
	}
	function datosWhereTablaPadre(cursor) {
		return this.ctx.oficial_datosWhereTablaPadre(cursor);
	}
	function camposTablaPadre(cursor) {
		return this.ctx.oficial_camposTablaPadre(cursor);
	}
	function valoresDefectoTablaPadre(cursor) {
		return this.ctx.oficial_valoresDefectoTablaPadre(cursor);
	}
	function dameFiltroReferencia() {
		return this.ctx.oficial_dameFiltroReferencia();
	}
	function commonInit(miForm) {
		return this.ctx.oficial_commonInit(miForm);
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
	function pub_commonBufferChanged(fN, miForm) {
		return this.commonBufferChanged(fN, miForm);
	}
	function pub_commonCalculateField(fN, cursor) {
		return this.commonCalculateField(fN, cursor);
	}
	function pub_commonInit(miForm) {
		return this.commonInit(miForm);
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
Este formulario realiza la gestión de las líneas de pedidos a clientes.
\end */
function interna_init()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	connect(cursor, "bufferChanged(QString)", _i, "bufferChanged");
	connect(form, "closed()", _i, "desconectar");
	
	var codSerie = "";
	var porComision = 0;
	var codAgente = "";
	var codCliente = "";
	
	if(cursor.cursorRelation()) {
		codSerie = cursor.cursorRelation().valueBuffer("codserie");
		porComision = cursor.cursorRelation().valueBuffer("porcomision");
		codAgente = cursor.cursorRelation().valueBuffer("codagente");
		codCliente = cursor.cursorRelation().valueBuffer("codcliente");
	}	else {
		var idPedido = cursor.valueBuffer("idpedido");
		if(idPedido) {
			codSerie = AQUtil.sqlSelect("pedidoscli", "codserie", "idpedido = " + idPedido);
			porComision = AQUtil.sqlSelect("pedidoscli", "porcomision", "idpedido = " + idPedido);
			codAgente = AQUtil.sqlSelect("pedidoscli", "codagente", "idpedido = " + idPedido);
			codCliente = AQUtil.sqlSelect("pedidoscli", "codcliente", "idpedido = " + idPedido);
		}
	}

	var irpf = 0;
	if (codSerie && codSerie != "") {
		irpf = AQUtil.sqlSelect("series", "irpf", "codserie = '" + codSerie + "'");
	}
	if (!irpf) {
		irpf = 0;
	}

	if (cursor.modeAccess() == cursor.Insert) {
		var opcionIvaRec = flfacturac.iface.pub_tieneIvaDocCliente(cursor.cursorRelation().valueBuffer("codserie"), cursor.cursorRelation().valueBuffer("codcliente"));
		switch (opcionIvaRec) {
			case 0: {
				this.child("fdbCodImpuesto").setValue("");
				this.child("fdbIva").setValue(0);
			}
			case 1: {
				this.child("fdbRecargo").setValue(0);
				break;
			}
		}
		this.child("fdbIRPF").setValue(irpf);
		this.child("fdbDtoPor").setValue(_i.calculateField("dtopor"));
		if (porComision) {
			this.child("fdbPorComision").setDisabled(true);
		} else {
			if (!codAgente || codAgente == "") {
				this.child("fdbPorComision").setDisabled(true);
			} else {
				if (cursor.modeAccess() == cursor.Insert) {
					this.child("fdbPorComision").setValue(_i.calculateField("porcomision"));
				}
			}
		}
	}

	if (porComision) {
		this.child("fdbPorComision").setDisabled(true);
	}

	this.child("lblComision").setText(_i.calculateField("lblComision"));
	this.child("lblDtoPor").setText(_i.calculateField("lbldtopor"));
	
	var filtroReferencia = _i.dameFiltroReferencia();
	this.child("fdbReferencia").setFilter(filtroReferencia);
	
	_i.commonInit(this);
}

function interna_calculateField(fN)
{
	var _i = this.iface;
	var cursor = this.cursor();
	return _i.commonCalculateField(fN, cursor);
		/** \C
		El --pvpunitario-- será el correspondiente al artículo según la tarifa asociada al cliente. Si no se ha especificado este dato, se tomará el pvp asociado al artículo.
		\end */
		/** \C
		El --pvpsindto-- será el producto del campo --cantidad-- por el campo --pvpunitario--
		\end */
		/** \C
		El --iva-- será el correspondiente al --codimpuesto-- en la tabla de impuestos
		\end */
		/** \C
		El --pvptotal-- será el --pvpsindto-- menos el --dtopor-- y menos el --dtolineal--
		\end */
		/** \C
		El --dtopor-- será el descuento asociado al cliente
		\end */
		/** \C
		El --recargo-- será el correspondiente al --codimpuesto-- en la tabla de impuestos en el caso de que el cliente tenga activado el campo Aplicar recargo de equivalencia en su correspondiente formulario.
		\end */
}

function interna_validateForm():Boolean
{
	var cursor = this.cursor();

	/** \C
	La cantidad de artículos especificada será mayor o igual que la del --totalenalbaran--
	\end */
	if (parseFloat(cursor.valueBuffer("cantidad")) < parseFloat(cursor.valueBuffer("totalenalbaran"))) {
			
			MessageBox.critical(sys.translate("La cantidad especificada no puede ser menor que la servida."),
					MessageBox.Ok, MessageBox.NoButton,MessageBox.NoButton);
			return false;
	}
	return true;
}

function interna_acceptedForm()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	disconnect(cursor, "bufferChanged(QString)", _i, "bufferChanged");
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_desconectar()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	disconnect(cursor, "bufferChanged(QString)", _i, "bufferChanged");
}

function oficial_bufferChanged(fN)
{
	var _i = this.iface;
	
	_i.commonBufferChanged(fN, form);
	/** \C
	Al cambiar la --referencia-- se mostrarán los valores asociados de --pvpvunitario-- y --codimpuesto--
	\end */
	/** \C
	Al cambiar el --codimpuesto-- se mostrarán los valores asociados de --iva-- y --recargo--
	\end */
	/** \C
	Al cambiar la --cantidad-- o el --pvpunitario-- se mostrará el valor asociado de --pvpsindto--
	\end */
	/** \C
	Al cambiar el --pvpsindto--, el --dtopor-- o el --dtolineal-- se mostrará el valor asociado de --pvptotal--
	\end */
}

function oficial_commonBufferChanged(fN, miForm)
{
	var _i = this.iface;
	var cursor = miForm.cursor();
	
  if (miForm == undefined || cursor == undefined) {
    debug(sys.translate("Formulario o cursor no válido"));
    return;
  }
    
  var miFormChild = function(childName) {
    var formChild = miForm.child(childName);
    if (formChild != undefined && 
       ((typeof formChild.setValue) == "function" || 
       (typeof formChild.setText) == "function"))
      return formChild;
        
    if (formChild == undefined) {
      debug(sys.translate("El formulario %1 no tiene un hijo llamado %2").arg(miForm.name).arg(childName));
    }
    
    var fakeChild = {
      setValue: function(value) {
          debug(sys.translate("No se puede invocar a miForm.child(%1).setValue(%2)").arg(childName).arg(value));
      },
      setText: function(value) {
           debug(sys.translate("No se puede invocar a miForm.child(%1).setText(%2)").arg(childName).arg(value));
      }
    }
    return fakeChild;
  }
  
	switch (fN) {
		case "referencia": {
			_i.calculaPrecio(miForm);
			break;
		}
		case "codimpuesto":{
			miFormChild("fdbIva").setValue(_i.commonCalculateField("iva", cursor));
			miFormChild("fdbRecargo").setValue(_i.commonCalculateField("recargo", cursor));
			break;
		}
		case "cantidad":
		case "pvpunitario":{
			miFormChild("fdbPvpSinDto").setValue(_i.commonCalculateField("pvpsindto", cursor));
			break;
		}
		case "pvpsindto":
		case "dtopor":{
			miFormChild("lblDtoPor").setText(_i.commonCalculateField("lbldtopor", cursor));
		}
		case "dtolineal":{
			miFormChild("fdbPvpTotal").setValue(_i.commonCalculateField("pvptotal", cursor));
			break;
		}
		case "pvptotal":
		case "porcomision": {
			var tabla = cursor.table();
			switch (tabla) {
				case "lineaspresupuestoscli":
				case "lineaspedidoscli":
				case "lineasalbaranescli":
				case "lineasfacturascli": {
					miFormChild("lblComision").setText(_i.commonCalculateField("lblComision", cursor));
					break;
				}
			}
			break;
		}
	}
}

/** Calcula el precio y los impuestos según la referencia */
function oficial_calculaPrecio(miForm)
{
	var _i = this.iface;
	var cursor = miForm.cursor();
	
	miForm.child("fdbPvpUnitario").setValue(_i.commonCalculateField("pvpunitario", cursor));
	miForm.child("fdbCodImpuesto").setValue(_i.commonCalculateField("codimpuesto", cursor));
	if (miForm.child("fdbCosteUnitario")) {
		miForm.child("fdbCosteUnitario").setValue(_i.commonCalculateField("costeunitario", cursor));
	}
}


/** \D Obtiene la tarifa asociada a un cliente
@param codCliente: código del cliente
@param cursor: Cursor del documento que busca la tarifa. Para sobreescribir
@return Código de la tarifa asociada o false si no tiene ninguna tarifa asociada
\end */
function oficial_obtenerTarifa(codCliente, cursor)
{
	var _i = this.iface;
	
	var codTarifa;
	switch (cursor.table()) {
		case "tpv_lineascomanda": {
			var curRel = cursor.cursorRelation();
			if (curRel && curRel.table() == "tpv_comandas") {
				codTarifa = curRel.valueBuffer("codtarifa");
			} else {
				codTarifa = AQUtil.sqlSelect("tpv_comandas", "codtarifa", "idtpv_comanda = " + cursor.valueBuffer("idtpv_comanda"));
			}
			break;
		}
		default: {
			codTarifa = AQUtil.sqlSelect("clientes c INNER JOIN gruposclientes gc ON c.codgrupo = gc.codgrupo", "gc.codtarifa", "codcliente = '" + codCliente + "'", "clientes,gruposclientes");
		}
	}
	return codTarifa;
}

function oficial_commonCalculateField(fN, cursor)
{
	var _i = this.iface;
	
	var datosTP = _i.datosTablaPadre(cursor);
	if (!datosTP){
		return false;
	}
	var wherePadre = datosTP.where;
	var tablaPadre = datosTP.tabla;
	
	var valor;
	switch (fN) {
		case "pvpunitario":{
			var codCliente = datosTP["codcliente"];
			var referencia = cursor.valueBuffer("referencia");
			var codTarifa = _i.obtenerTarifa(codCliente, cursor);
			if (codTarifa) {
				valor = AQUtil.sqlSelect("articulostarifas", "pvp", "referencia = '" + referencia + "' AND codtarifa = '" + codTarifa + "'");
			}
			if (!valor) {
				valor = AQUtil.sqlSelect("articulos", "pvp", "referencia = '" + referencia + "'");
			}
			var tasaConv = datosTP["tasaconv"];
			valor = parseFloat(valor) / tasaConv;
			break;
		}
		case "pvpsindto":{
			valor = parseFloat(cursor.valueBuffer("pvpunitario")) * parseFloat(cursor.valueBuffer("cantidad"));
			valor = AQUtil.roundFieldValue(valor, "lineaspedidoscli", "pvpsindto");
			break;
		}
		case "iva": {
			valor = flfacturac.iface.pub_campoImpuesto("iva", cursor.valueBuffer("codimpuesto"), datosTP["fecha"], "cli");
			if (isNaN(valor)) {
				valor = "";
			}
			break;
		}
		case "lbldtopor":{
			valor = (cursor.valueBuffer("pvpsindto") * cursor.valueBuffer("dtopor")) / 100;
			valor = AQUtil.roundFieldValue(valor, "lineaspedidoscli", "pvpsindto");
			break;
		}
		case "pvptotal":{
			var dtoPor = (cursor.valueBuffer("pvpsindto") * cursor.valueBuffer("dtopor")) / 100;
			dtoPor = AQUtil.roundFieldValue(dtoPor, "lineaspedidoscli", "pvpsindto");
			valor = cursor.valueBuffer("pvpsindto") - parseFloat(dtoPor) - cursor.valueBuffer("dtolineal");
			valor = AQUtil.roundFieldValue(valor, cursor.table(), "pvptotal");
			break;
		}
		case "dtopor":{
			var codCliente = datosTP["codcliente"];
			valor = flfactppal.iface.pub_valorQuery("descuentosclientes,descuentos", "SUM(d.dto)", "descuentosclientes dc INNER JOIN descuentos d ON dc.coddescuento = d.coddescuento", "dc.codcliente = '" + codCliente + "';");
			break;
		}
		case "recargo": {
			var codCliente = datosTP["codcliente"];;
			var aplicarRecEq = AQUtil.sqlSelect("clientes", "recargo", "codcliente = '" + codCliente + "'");
			if (aplicarRecEq == true) {
				valor = flfacturac.iface.pub_campoImpuesto("recargo", cursor.valueBuffer("codimpuesto"), datosTP["fecha"], "cli");
			} else {
				valor = "";
			}
			if (isNaN(valor)) {
				valor = "";
			}
			break;
		}
		case "codimpuesto": {
			var codCliente = datosTP["codcliente"];;
			var codSerie = datosTP["codserie"];;
			if (flfacturac.iface.pub_tieneIvaDocCliente(codSerie, codCliente)) {
				valor = AQUtil.sqlSelect("articulos", "codimpuesto", "referencia = '" + cursor.valueBuffer("referencia") + "'");
			} else {
				valor = "";
			}
			break;
		}
		case "porcomision": {
			var porComisionPadre = datosTP["porcomision"];
			if (porComisionPadre) {
				valor = "";
				break;
			}
			var codAgente = datosTP["codagente"];
			if (!codAgente || codAgente == "") {
				valor = "";
				break;
			}
			var comisionAgente = flfacturac.iface.pub_calcularComisionLinea(codAgente,cursor.valueBuffer("referencia"));
			comisionAgente = AQUtil.roundFieldValue(comisionAgente, cursor.table(), "porcomision");
			valor = comisionAgente.toString();
			break;
		}
		case "lblComision": {
			var porComision = parseFloat(cursor.valueBuffer("porcomision"));
			if (!porComision) {
				break;
			}
			var pvpTotal = parseFloat(cursor.valueBuffer("pvptotal"));
			var comision = (porComision * pvpTotal) / 100;
			comision = AQUtil.roundFieldValue(comision, cursor.table(), "pvptotal");
			valor = comision.toString();
			break;
		}
		case "costeunitario": {
			var qryCoste = new FLSqlQuery;
			qryCoste.setTablesList("articulosprov");
			qryCoste.setSelect("coste, dto");
			qryCoste.setFrom("articulosprov");
			qryCoste.setWhere("referencia = '" + cursor.valueBuffer("referencia") + "' AND pordefecto = true");
			qryCoste.setForwardOnly(true);
			if (!qryCoste.exec()) {
				return false;
			}
			if (qryCoste.first()) {
				var dto = qryCoste.value("dto");
				dto = isNaN(dto) ? 0 : dto;
				valor = qryCoste.value("coste") * (100 - dto) / 100;
				valor = AQUtil.roundFieldValue(valor, "articulosprov", "coste");
			} else {
				valor = 0;
			}
			
			break;
		}
	}
	return valor;
}

/** \D Devuelve la tabla padre de la tabla parámetro, así como la cláusula where necesaria para localizar el registro padre
@param	cursor: Cursor cuyo padre se busca
@return	Array formado por:
	* where: Cláusula where
	* tabla: Nombre de la tabla padre
o false si hay error
\end */
function oficial_datosTablaPadre(cursor)
{
	var _i = this.iface;
	var cx;
	
	try { 
		cx = cursor.connectionName();
	} 
	catch(e) { 
		cx = "default"; 
	}
	
	var datos = new Object;
	var datosWhereTP = _i.datosWhereTablaPadre(cursor);
	if (!datosWhereTP) {
		return false;
	}
	datos.where = datosWhereTP.where;
	datos.tabla = datosWhereTP.tabla;
	
	var camposTP = _i.camposTablaPadre(cursor);
	if (!camposTP) {
		return false;
	}
	var valoresDefectoTP = _i.valoresDefectoTablaPadre(cursor);
	if (!valoresDefectoTP) {
		return false;
	}

	var curRel = cursor.cursorRelation();
	if (curRel && curRel.table() == datos.tabla) {
		for (var i = 0; i < camposTP.length; i++) {
			datos[camposTP[i]] = curRel.valueBuffer(camposTP[i]);
		}
		for (var i = 0; i < valoresDefectoTP.length; i++) {
			datos[valoresDefectoTP[i][0]] = valoresDefectoTP[i][1];
		}
		
		/**switch (cursor.table()) {
			case "tpv_lineascomanda": {
				datos["tasaconv"] = 1;
				datos["codserie"] = false;
				datos["porcomision"] = 0;
				datos["codagente"] = false;
				break;
			}
			default: {
				datos["tasaconv"] = curRel.valueBuffer("tasaconv");
				datos["codserie"] = curRel.valueBuffer("codserie");
				datos["porcomision"] = curRel.valueBuffer("porcomision");
				datos["codagente"] = curRel.valueBuffer("codagente");
			}
		}
		datos["codcliente"] = curRel.valueBuffer("codcliente");
		datos["fecha"] = curRel.valueBuffer("fecha");
		*/
	} else {
		var qryDatos = new FLSqlQuery("", cx);
		qryDatos.setTablesList(datos.tabla);
		qryDatos.setSelect(camposTP.join(", "));
		/*
		switch (cursor.table()) {
			case "tpv_lineascomanda": {
				qryDatos.setSelect("codcliente, fecha");
				break;
			}
			default: {
				qryDatos.setSelect("tasaconv, codcliente, fecha, codserie, porcomision, codagente");
			}
		}*/
		
		qryDatos.setFrom(datos.tabla);
		qryDatos.setWhere(datos.where);
		qryDatos.setForwardOnly(true);
		if (!qryDatos.exec()) {
			return false;
		}
		if (!qryDatos.first()) {
			return false;
		}
		for (var i = 0; i < camposTP.length; i++) {
			datos[camposTP[i]] = qryDatos.value(camposTP[i]);
		}
		for (var i = 0; i < valoresDefectoTP.length; i++) {
			datos[valoresDefectoTP[i][0]] = valoresDefectoTP[i][1];
		}
		/*
		switch (cursor.table()) {
			case "tpv_lineascomanda": {
				datos["tasaconv"] = 1;
				datos["codserie"] = false;
				datos["porcomision"] = 0;
				datos["codagente"] = false;
				break;
			}
			default: {
				datos["tasaconv"] = qryDatos.value("tasaconv");
				datos["codserie"] = qryDatos.value("codserie");
				datos["porcomision"] = qryDatos.value("porcomision");
				datos["codagente"] = qryDatos.value("codagente");
			}
		}
		datos["codcliente"] = qryDatos.value("codcliente");
		datos["fecha"] = qryDatos.value("fecha");
		*/
	}
	return datos;
}

function oficial_datosWhereTablaPadre(cursor)
{
	var _i = this.iface;
	
	var datos = new Object;
	
	switch (cursor.table()) {
		case "lineaspresupuestoscli": {
			datos.where = "idpresupuesto = " + cursor.valueBuffer("idpresupuesto");
			datos.tabla = "presupuestoscli";
			break;
		}
		case "lineaspedidoscli": {
			datos.where = "idpedido = " + cursor.valueBuffer("idpedido");
			datos.tabla = "pedidoscli";
			break;
		}
		case "lineasalbaranescli": {
			datos.where = "idalbaran = " + cursor.valueBuffer("idalbaran");
			datos.tabla = "albaranescli";
			break;
		}
		case "lineasfacturascli": {
			datos.where = "idfactura = " + cursor.valueBuffer("idfactura");
			datos.tabla = "facturascli";
			break;
		}
		case "tpv_lineascomanda": {
			datos.where = "idtpv_comanda = " + cursor.valueBuffer("idtpv_comanda");
			datos.tabla = "tpv_comandas";
			break;
		}
	}
	return datos;
}

function oficial_camposTablaPadre(cursor)
{
	var _i = this.iface;
	
	var aCampos = new Array();
	
	switch(cursor.table()){
		case "tpv_lineascomanda":{
			aCampos = ["codcliente", "fecha"];
			break;
		}
		default:{
			aCampos = ["tasaconv", "codserie", "porcomision", "codagente", "codcliente", "fecha"];
			break;
		}
	}
	
	return aCampos;
}

function oficial_valoresDefectoTablaPadre(cursor)
{
	var _i = this.iface;
	
	var aValoresDef = new Array();
	
	switch(cursor.table()){
		case "tpv_lineascomanda":{
			aValoresDef = [["tasaconv", 1], ["codserie", false], ["porcomision", 0], ["codagente", false]];
			break;
		}
	}
	return aValoresDef;
}

function oficial_dameFiltroReferencia()
{
	return "sevende";
}

function oficial_commonInit(miForm)
{
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
