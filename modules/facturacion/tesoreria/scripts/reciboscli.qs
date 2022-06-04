/***************************************************************************
                 reciboscli.qs  -  description
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
	function validateForm() { return this.ctx.interna_validateForm(); }
	function acceptedForm() { return this.ctx.interna_acceptedForm(); }
	function calculateField(fN:String) { return this.ctx.interna_calculateField(fN); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var importeInicial;
	var curReciboDiv;
	var aRecibosGrupo_;
	function oficial( context ) { interna( context ); } 
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function commonBufferChanged(fN, miForm) {
		return this.ctx.oficial_commonBufferChanged(fN, miForm);
	}
	function cambiarEstado() {
		return this.ctx.oficial_cambiarEstado();
	}
	function obtenerEstado(idRecibo:String) {
		return this.ctx.oficial_obtenerEstado(idRecibo);
	}
	function divisionRecibo(cursor, importeInicial) {
		return this.ctx.oficial_divisionRecibo(cursor, importeInicial);
	}
	function copiarCampoReciboDiv(nombreCampo, cursor, campoInformado) {
		return this.ctx.oficial_copiarCampoReciboDiv(nombreCampo, cursor, campoInformado);
	}
	function validarCuentaBancaria(cursor) {
		return this.ctx.oficial_validarCuentaBancaria(cursor);
	}
	function commonCalculateField(fN:String, cursor:FLSqlCursor) {
		return this.ctx.oficial_commonCalculateField(fN, cursor);
	}
	function tdbReciboscli_bufferCommited() {
		return this.ctx.oficial_tdbReciboscli_bufferCommited();
	}
	function commonValidateForm(cursor) {
		return this.ctx.oficial_commonValidateForm(cursor);
	}
	function validaVencimiento(cursor) {
		return this.ctx.oficial_validaVencimiento(cursor);
	}
	function tbnPonRecibo_clicked() {
		return this.ctx.oficial_tbnPonRecibo_clicked();
	}
	function tbnQuitaRecibo_clicked() {
		return this.ctx.oficial_tbnQuitaRecibo_clicked();
	}
	function actualizaTotalesGrupo() {
		return this.ctx.oficial_actualizaTotalesGrupo();
	}
	function ponListaRecibosGrupo(l) {
		return this.ctx.oficial_ponListaRecibosGrupo(l);
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
	function pub_obtenerEstado(idRecibo:String) {
		return this.obtenerEstado(idRecibo);
	}
	function pub_commonCalculateField(fN:String, cursor:FLSqlCursor) {
		return this.commonCalculateField(fN, cursor);
	}
	function pub_divisionRecibo(cursor, importeInicial) {
		return this.divisionRecibo(cursor, importeInicial);
	}
	function pub_commonValidateForm(cursor) {
		return this.commonValidateForm(cursor);
	}
	function pub_commonBufferChanged(fN, miForm) {
		return this.commonBufferChanged(fN, miForm);
	}
	function pub_ponListaRecibosGrupo(l) {
		return this.ponListaRecibosGrupo(l);
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
/** 
\D Se almacena el valor del importe inicial del recibo
\end
\C Los campos --fechav--, --importe--, --codcuenta-- y --coddir-- estarán deshabilitados.
\end
\end */
function interna_init()
{
	var _i = this.iface;
	
	var cursor= this.cursor();
	if (cursor.modeAccess() == cursor.Edit)
		this.iface.importeInicial = parseFloat(cursor.valueBuffer("importe"));
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this.child("tdbPagosDevolCli").cursor(), "cursorUpdated()", this, "iface.tdbReciboscli_bufferCommited");
	connect(this.child("tbnPonRecibo"), "clicked()", _i, "tbnPonRecibo_clicked");
	connect(this.child("tbnQuitaRecibo"), "clicked()", _i, "tbnQuitaRecibo_clicked");
	
	if (cursor.modeAccess() == cursor.Edit) {
		this.child("pushButtonAcceptContinue").close();
		if (cursor.isNull("idfactura")) {
			this.child("tabWidget24").showPage("recibos");
		}
	}
	this.child("fdbTexto").setValue(this.iface.calculateField("texto"));

	this.iface.bufferChanged("codcuenta");
	this.iface.cambiarEstado();
}
/** \C
El importe del recibo debe ser menor o igual del que tenía anteriormente. Si es menor el recibo se fraccionará.
La fecha de vencimiento debe ser siempre igual o posterior a la fecha de emisión del recibo.
\end */
function interna_validateForm()
{
	var _i = this.iface;
	var cursor= this.cursor();

	if (!_i.commonValidateForm(cursor)) {
		return false;
	}
	return true;
}

function interna_acceptedForm()
{
	var util = new FLUtil();
	var cursor = this.cursor();
	/** \C
	Actualiza el riesgo del cliente, si existe
	\end */
	var codCliente = cursor.valueBuffer("codcliente");
	if (codCliente) {
		flfactteso.iface.pub_actualizarRiesgoCliente(codCliente);
	}

	this.iface.divisionRecibo(cursor, this.iface.importeInicial);
}

function interna_calculateField(fN:String)
{
	var cursor= this.cursor();
	valor = this.iface.commonCalculateField(fN, cursor);
	return valor;
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_bufferChanged(fN)
{
	var _i = this.iface;
	switch (fN) {
		case "importe": {
		/** \C
		El cambio del --importe-- bloquea pagos y devoluciones
		\end */
			this.child("fdbTexto").setValue(this.iface.calculateField("texto"));
			this.child("gbxPagDev").setDisabled(true);
			break;
		}
		default: {
			_i.commonBufferChanged(fN, this);
		}
	}
}

function oficial_commonBufferChanged(fN, miForm)
{
	var _i = this.iface;
	var cursor = miForm.cursor();
	switch(fN) {
		case "codcuenta":
		case "ctaentidad":
		case "ctaagencia":
		case "cuenta": {
			miForm.child("fdbDc").setValue(_i.commonCalculateField("dc", cursor));
			break;
		}
// 		case "codpago": { /// Habría que vaciar los datos de cuenta si codcuenta está vacío.
// 			miForm.child("fdbCodCuenta").setValue(_i.commonCalculateField("codcuenta", cursor));
// 			break;
// 		}
	}
}

function oficial_tdbReciboscli_bufferCommited()
{
	var _i = this.iface;
	this.child("fdbFechaPago").setValue(_i.calculateField("fechapago"));
	this.child("fdbCodCuentaPagoCli").setValue(_i.calculateField("codcuentapagocli"));
	this.child("fdbSituacion").setValue(_i.calculateField("situacion"));
	this.child("fdbEstado").setValue(_i.calculateField("estado"));
	_i.cambiarEstado();
}

/** \D
Cambia el valor del estado del recibo entre Emitido, Cobrado y Devuelto
\end */
function oficial_cambiarEstado()
{
	var util = new FLUtil;
	var cursor = this.cursor();
	var estado = cursor.valueBuffer("estado");
	
	if ( estado != "Emitido" || !cursor.isNull("idgrupo") || cursor.isNull("idfactura"))
		this.child("fdbImporte").setDisabled(true);
	else
		this.child("fdbImporte").setDisabled(false);
	
	if (util.sqlSelect("pagosdevolcli", "idremesa", "idrecibo = " + cursor.valueBuffer("idrecibo") + " ORDER BY fecha DESC, idpagodevol DESC") != 0) {
		this.child("lblRemesado").text = "REMESADO";
		this.child("fdbFechav").setDisabled(true);
		this.child("fdbImporte").setDisabled(true);
		this.child("fdbCodCuenta").setDisabled(true);
		this.child("coddir").setDisabled(true);
		this.child("tdbPagosDevolCli").setInsertOnly(true);
		this.child("pushButtonNext").close();
		this.child("pushButtonPrevious").close();
		this.child("pushButtonFirst").close();
		this.child("pushButtonLast").close();
	}
	switch (estado) {
		case "Remesado": {
			this.child("gbxPagDev").enabled = false;
			break;
		}
		case "Agrupado": {
			this.child("gbxPagDev").enabled = false;
			var codR = AQUtil.sqlSelect("reciboscli", "codigo", "idrecibo = " + cursor.valueBuffer("idgrupo"));
			if (codR) {
				this.child("lblRemesado").text = sys.translate("AGRUPADO en\n%1".arg(codR));
			}
			break;
		}
		default: {
			this.child("gbxPagDev").enabled = true,
		}
	}
}

/** \D
Calcula el estado en función de los pagos y devoluciones asociados a un recibo
@param	idRecibo: Identificador del recibo cuyo estado se desea calcular
@return	Estado del recibo
\end */
function oficial_obtenerEstado(idRecibo)
{
	/// Obsoleta. Se usa commoncalculatefield
	var _i = this.iface;
	var cursor = new FLSqlCursor("reciboscli");
	cursor.select("idrecibo = " + idRecibo);
	if (!cursor.first()) {
		return false;
	}
	cursor.setModeAccess(cursor.Edit);
	cursor.refresh();
	var valor = _i.commonCalculateField("estado", cursor);
	return valor;
}

function oficial_divisionRecibo(cursor, importeInicial)
{
	var util= new FLUtil();
	
	if (cursor.isNull("idfactura")) { /// Recibo agrupado
		return true;
	}
	
	/** \C
	Si el importe ha disminuido, genera un recibo complementario por la diferencia
	\end */
	var importeActual = parseFloat(cursor.valueBuffer("importe"));
	if (importeActual != importeInicial) {
		var tasaConv = parseFloat(util.sqlSelect("facturascli", "tasaconv", "idfactura = " + cursor.valueBuffer("idfactura")));
		
		cursor.setValueBuffer("importeeuros", importeActual * tasaConv);

		if (!this.iface.curReciboDiv) {
			this.iface.curReciboDiv = new FLSqlCursor("reciboscli");
		}
		this.iface.curReciboDiv.setModeAccess(this.iface.curReciboDiv.Insert);
		this.iface.curReciboDiv.refreshBuffer();

		var camposRecibo= util.nombreCampos("reciboscli");
		var totalCampos= camposRecibo[0];

		var campoInformado= [];
		for (var i= 1; i <= totalCampos; i++) {
			campoInformado[camposRecibo[i]] = false;
		}
		this.iface.curReciboDiv.setValueBuffer("importe", importeInicial - parseFloat(cursor.valueBuffer("importe")));
		campoInformado["importe"] = true;
		for (var i= 1; i <= totalCampos; i++) {
			if (!this.iface.copiarCampoReciboDiv(camposRecibo[i], cursor, campoInformado)) {
				return false;
			}
		}
		if (!this.iface.curReciboDiv.commitBuffer()) {
			return false;
		}
	}
	return true;
}

function oficial_copiarCampoReciboDiv(nombreCampo, cursor, campoInformado)
{
	var util= new FLUtil;

	if (campoInformado[nombreCampo]) {
		return true;
	}
	var nulo=false;

	switch (nombreCampo) {
		case "idrecibo": {
			return true;
			break;
		}
		case "numero": {
			valor = parseInt(util.sqlSelect("reciboscli", "numero", "idfactura = " + cursor.valueBuffer("idfactura") + " ORDER BY numero DESC")) + 1;
			break;
		}
		case "importeeuros": {
			if (!campoInformado["importe"]) {
				if (!this.iface.copiarCampoReciboDiv("importe", cursor, campoInformado)) {
					return false;
				}
			}
			var tasaConv= parseFloat(util.sqlSelect("facturascli", "tasaconv", "idfactura = " + cursor.valueBuffer("idfactura")));
			valor = this.iface.curReciboDiv.valueBuffer("importe") * tasaConv;
			break;
		}
		case "codigo": {
			var codFactura= util.sqlSelect("facturascli", "codigo", "idfactura = " + cursor.valueBuffer("idfactura"));
			if (!campoInformado["numero"]) {
				if (!this.iface.copiarCampoReciboDiv("numero", cursor, campoInformado)) {
					return false;
				}
			}
			valor = codFactura + "-" + flfacturac.iface.pub_cerosIzquierda(this.iface.curReciboDiv.valueBuffer("numero"), 2);
			break;
		}
		case "estado": {
			valor = "Emitido";
			break;
		}
		case "texto": {
			if (!campoInformado["coddivisa"]) {
				if (!this.iface.copiarCampoReciboDiv("coddivisa", cursor, campoInformado)) {
					return false;
				}
			}
			if (!campoInformado["importe"]) {
				if (!this.iface.copiarCampoReciboDiv("importe", cursor, campoInformado)) {
					return false;
				}
			}
			var moneda = util.sqlSelect("divisas", "descripcion", "coddivisa = '" + cursor.valueBuffer("coddivisa") + "'");
			valor = util.enLetraMoneda(this.iface.curReciboDiv.valueBuffer("importe"), moneda);
			break;
		}
		default: {
			if (cursor.isNull(nombreCampo)) {
				nulo = true;
			} else {
				valor = cursor.valueBuffer(nombreCampo);
			}
		}
	}
	if (nulo) {
		this.iface.curReciboDiv.setNull(nombreCampo);
	} else {
		this.iface.curReciboDiv.setValueBuffer(nombreCampo, valor);
	}
	campoInformado[nombreCampo] = true;
	
	return true;
}

function oficial_validarCuentaBancaria(cursor)
{
	var _i = this.iface;
	
	var codCliente = cursor.valueBuffer("codcliente");
	if(!codCliente || codCliente == "")
		return true;
	
	var codCuenta = cursor.valueBuffer("codcuenta");
	if(codCuenta && codCuenta != "") {
		if(!AQUtil.sqlSelect("cuentasbcocli","codcuenta","codcuenta = '" + codCuenta + "' AND codcliente = '" + codCliente + "'")) {
			MessageBox.warning(sys.translate("La cuenta bancaria asociada al recibo no existe para el cliente.\nAntes de guardar el recibo debe cambiarla en la pestaña de Domiciliación Bancaria."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
			return false;
		}
	}
	
	var entidad= cursor.valueBuffer("ctaentidad");
	var agencia= cursor.valueBuffer("ctaagencia");
	var cuenta= cursor.valueBuffer("cuenta");
	var dc= cursor.valueBuffer("dc");
	if ((entidad && entidad != "") || (agencia && agencia != "") || (cuenta && cuenta != "") || (dc && dc != "")) {
		if (!dc || dc == "" || dc != _i.commonCalculateField("dc", cursor)) {
			MessageBox.warning(sys.translate("El dígito de control de la cuenta bancaria no es correcto"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
			return false;
		}
	}
	return true;
}

function oficial_commonCalculateField(fN, cursor)
{
	var util= new FLUtil();
	var valor:String;
	switch (fN) {
		case "estado": {
			if (cursor.valueBuffer("idgrupo")) {
				valor = "Agrupado";
				break;
			}
			valor = cursor.valueBuffer("importe") == 0 ? "Pagado" : "Emitido";
			var curPagosDevol = new FLSqlCursor("pagosdevolcli");
			curPagosDevol.select("idrecibo = " + cursor.valueBuffer("idrecibo") + " ORDER BY fecha DESC, idpagodevol DESC");
			if (curPagosDevol.first()) {
				curPagosDevol.setModeAccess(curPagosDevol.Browse);
				curPagosDevol.refreshBuffer();
				switch (curPagosDevol.valueBuffer("tipo")) {
					case "Pago": {
						valor = "Pagado";
						break;
					}
					case "Remesado": {
						valor = "Remesado";
						break;
					}
					default: {
						valor = "Devuelto";
						break;
					}
				}
			}
			break;
		}
		case "texto": {
			var importe = parseFloat(cursor.valueBuffer("importe"));
			var moneda = util.sqlSelect("divisas", "descripcion", "coddivisa = '" + cursor.valueBuffer("coddivisa") + "'");
			valor = util.enLetraMoneda(importe, moneda);
			break;
		}
		case "dc": {
			var entidad = cursor.valueBuffer("ctaentidad");
			var agencia = cursor.valueBuffer("ctaagencia");
			var cuenta = cursor.valueBuffer("cuenta");
		
			if (!entidad) entidad = "";
			if (!agencia) agencia = "";
			if (!cuenta) cuenta = "";
		
			if ( !entidad.isEmpty() && !agencia.isEmpty() && ! cuenta.isEmpty() && entidad.length == 4 && agencia.length == 4 && cuenta.length == 10 ) {
				var dc1= util.calcularDC(entidad + agencia);
				var dc2= util.calcularDC(cuenta);
				valor = dc1 + dc2;
			}
			break;
		}
	case "fechapago": {
			valor = util.sqlSelect("pagosdevolcli", "fecha", "idrecibo = " + cursor.valueBuffer("idrecibo") + " ORDER by idpagodevol DESC");
			if (!valor) valor = "NULL";
			break;
		}
	case "codcuentapagocli": {
		if(cursor.valueBuffer("estado") != "Emitido"){
			valor = util.sqlSelect("pagosdevolcli", "codcuenta", "idrecibo = " + cursor.valueBuffer("idrecibo") + " ORDER by idpagodevol DESC");
		}
		else{
			valor = AQUtil.sqlSelect("formaspago", "codcuenta", "codpago = '" + cursor.valueBuffer("codpago") + "'");
		}
		if(!valor){
			valor = "";
		}
		break;
	}
	case "situacion": {
      var q = new FLSqlQuery;
      q.setSelect("idremesa");
      q.setFrom("pagosdevolcli");
      q.setWhere("idrecibo = " + cursor.valueBuffer("idrecibo") + " ORDER BY fecha DESC, idpagodevol DESC");
      q.setForwardOnly(true);
      if (!q.exec()) {
        return false;
      }
      if (q.first()) {
        if (q.value("idremesa") != 0) {
          valor = "En remesa";
        } else {
          valor = "En cartera";
        }
      } else {
        valor = "En cartera";
      }
      break;
    }
		case "codcuenta": {
			if (AQUtil.sqlSelect("formaspago", "domiciliado", "codpago = '" + cursor.valueBuffer("codpago") + "'")) {
				valor = AQUtil.sqlSelect("codcuentadom", "clientes", "codcliente = '" + cursor.valueBuffer("codcliente") + "'");
				valor = valor ? valor : "";
			} else {
				valor = "";
			}
			break;
		}
		case "importegrupo": {
			valor = AQUtil.sqlSelect("reciboscli", "SUM(importe)", "idgrupo = " + cursor.valueBuffer("idrecibo"));
			valor = isNaN(valor) ? 0 : valor;
			valor = AQUtil.roundFieldValue(valor, "reciboscli", "importe");
			break;
		}
		case "importeeurosgrupo": {
			valor = AQUtil.sqlSelect("reciboscli", "SUM(importeeuros)", "idgrupo = " + cursor.valueBuffer("idrecibo"));
			valor = isNaN(valor) ? 0 : valor;
			valor = AQUtil.roundFieldValue(valor, "reciboscli", "importeeuros");
			break;
		}
  }

	return valor;
}

function oficial_commonValidateForm(cursor)
{
	var _i = this.iface;
	
	if (!_i.validaVencimiento(cursor)) {
		return false;
	}
	if (!_i.validarCuentaBancaria(cursor)) {
		return false;
	}

	return true;
}

function oficial_validaVencimiento(cursor)
{
	if (AQUtil.daysTo(cursor.valueBuffer("fecha"), cursor.valueBuffer("fechav")) < 0) {
		MessageBox.warning(sys.translate("La fecha de vencimiento debe ser siempre igual o posterior\na la fecha de emisión del recibo."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
		return false;
	}
	return true;
}

function oficial_tbnPonRecibo_clicked()
{
  var _i = this.iface;
  var cursor = this.cursor();
  
	if (cursor.modeAccess() == cursor.Insert) {
		if (!this.child("tdbRecibos").cursor().commitBufferCursorRelation()){
			return false;
		}
	}
	
  var f = new FLFormSearchDB("seleccionrecibosgrupocli");
  curF = f.cursor();
  curF.setMainFilter("codcliente = '" + cursor.valueBuffer("codcliente") + "' AND coddivisa = '" + cursor.valueBuffer("coddivisa") + "' AND estado IN ('Emitido', 'Devuelto') AND idrecibo <> " + cursor.valueBuffer("idrecibo"));
  f.setMainWidget();
  f.exec();
  if (!f.accepted()) {
    return false;
  }

  if (!_i.aRecibosGrupo_) {
		return;
	}
  var curR = new FLSqlCursor("reciboscli");
	var numRecibos = 0;
	var idGrupo = cursor.valueBuffer("idrecibo");

	for (var i = 0; i < _i.aRecibosGrupo_.length; i++) {
		curR.select("idrecibo = " + _i.aRecibosGrupo_[i]);
		if (!curR.first()) {
			return false;
		}
		if (!flfactteso.iface.pub_ponGrupoReciboCli(curR, idGrupo, false)) {
			return false;
		}
		_i.actualizaTotalesGrupo();
		numRecibos++;
	}
	
	MessageBox.information(sys.translate("Se han añadido %1 recibos al grupo.").arg(numRecibos), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
	this.child("tdbRecibos").refresh();
}

function oficial_ponListaRecibosGrupo(l)
{
	var _i = this.iface;
	_i.aRecibosGrupo_ = l;
}

function oficial_actualizaTotalesGrupo()
{
	var _i = this.iface;
	
	sys.setObjText(this, "fdbImporte", _i.calculateField("importegrupo"));
	sys.setObjText(this, "fdbImporteEuros", _i.calculateField("importeeurosgrupo"));
	sys.setObjText(this, "fdbEstado", _i.calculateField("estado"));
}

function oficial_tbnQuitaRecibo_clicked()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var curR = this.child("tdbRecibos").cursor();
	var idRecibo = curR.valueBuffer("idrecibo");
	if (!idRecibo) {
		return;
	}
	if (!flfactteso.iface.pub_quitaGrupoReciboCli(curR, false)) {
		return false;
	}
	_i.actualizaTotalesGrupo();
	this.child("tdbRecibos").refresh();
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
