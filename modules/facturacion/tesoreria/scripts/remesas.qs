/***************************************************************************
                      remesas.qs  -  description
                             -------------------
    begin                : lun may 31 2004
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
	function calculateField(fN:String) { return this.ctx.interna_calculateField(fN); }
	function calculateCounter() { return this.ctx.interna_calculateCounter(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var ejercicioActual:String;
	var bloqueoSubcuenta:Boolean;
	var contabActivada:Boolean;
	var longSubcuenta:Number;
	var posActualPuntoSubcuenta:Number;
	var tblResAsientos:QTable;
	var curPagosDev:FLSqlCursor;
	var pagoIndirecto_:Boolean;
  var pagoDiferido_;
	
    function oficial( context ) { interna( context ); } 
	function actualizarTotal() {
		return this.ctx.oficial_actualizarTotal();
	}
	function agregarRecibo() {
		return this.ctx.oficial_agregarRecibo();
	}
	function eliminarRecibo() {
		return this.ctx.oficial_eliminarRecibo();
	}
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function asientoAcumulado() {
		return this.ctx.oficial_asientoAcumulado();
	}
	function asociarReciboRemesa(idRecibo:String, curRemesa:FLSqlCursor) {
		return this.ctx.oficial_asociarReciboRemesa(idRecibo, curRemesa);
	}
	function excluirReciboRemesa(idRecibo:String, idRemesa:String) {
		return this.ctx.oficial_excluirReciboRemesa(idRecibo, idRemesa);
	}
	function datosPagosDev(idRecibo:String, curRemesa:FLSqlCursor) {
		return this.ctx.oficial_datosPagosDev(idRecibo, curRemesa);
	}
	function cambiarEstado() {
		return this.ctx.oficial_cambiarEstado();
	}
	function filtroRecibosCli() {
		return this.ctx.oficial_filtroRecibosCli();
	}
	function habilitarPorRecibos() {
		return this.ctx.oficial_habilitarPorRecibos();
	}
	function validaReciboEnRemesa(curRecibo) {
		return this.ctx.oficial_validaReciboEnRemesa(curRecibo);
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
	function pub_asociarReciboRemesa(idRecibo:String, curRemesa:FLSqlCursor) {
		return this.asociarReciboRemesa(idRecibo, curRemesa);
	}
	function pub_excluirReciboRemesa(idRecibo:String, idRemesa:String) {
		return this.excluirReciboRemesa(idRecibo, idRemesa);
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
/** \C Los campos de contabilidad sólo aparecen cuando se trabaja con contabilidad integrada
\end */
function interna_init()
{
  var _i = this.iface;
	var cursor= this.cursor();
	var util= new FLUtil;

	this.iface.contabActivada = sys.isLoadedModule("flcontppal") && util.sqlSelect("empresa", "contintegrada", "1 = 1");
	if (this.iface.contabActivada) {
		this.iface.tblResAsientos = this.child("tblResAsientos");
		this.iface.tblResAsientos.setNumCols(4);
		this.iface.tblResAsientos.setColumnWidth(0, 100);
		this.iface.tblResAsientos.setColumnWidth(1, 200);
		this.iface.tblResAsientos.setColumnWidth(2, 100);
		this.iface.tblResAsientos.setColumnWidth(3, 100);
		this.iface.tblResAsientos.setColumnLabels("/", util.translate("scripts", "Subcuenta") + "/" + util.translate("scripts", "Descripción") + "/" +  util.translate("scripts", "Debe") + "/" + util.translate("scripts", "Haber"));
		this.iface.tblResAsientos.readOnly = true;
	
		this.iface.ejercicioActual = flfactppal.iface.pub_ejercicioActual();
		this.iface.longSubcuenta = util.sqlSelect("ejercicios", "longsubcuenta", "codejercicio = '" + this.iface.ejercicioActual + "'");
		this.child("fdbIdSubcuenta").setFilter("codejercicio = '" + this.iface.ejercicioActual + "'");
		this.iface.posActualPuntoSubcuenta = -1;
		this.child("lblResAsientos").text = util.translate("scripts", "Existe un asiento por pago o devolución de recibo. A continuación se muestra un acumulado de las partidas de todos los asientos asociados a los recibos de la remesa.");

		this.iface.pagoIndirecto_ = flfactteso.iface.pub_valorDefectoTesoreria("pagoindirecto");
    _i.pagoDiferido_ = flfactteso.iface.pub_valorDefectoTesoreria("pagodiferido");
		if (!_i.pagoDiferido_) {
			this.child("tbwRecibos").setTabEnabled("pagos", false);
		}
	} else {
		this.child("tbwRemesa").setTabEnabled("contabilidad", false);
		this.child("tbwRecibos").setTabEnabled("pagos", false);
		this.iface.pagoIndirecto_ = false;
    _i.pagoDiferido_ = false;
	}

	connect(this.child("tbInsert"), "clicked()", this, "iface.agregarRecibo");
	connect(this.child("tbDelete"), "clicked()", this, "iface.eliminarRecibo");
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this.child("tdbPagosDevolRem").cursor(), "bufferCommited()", this, "iface.cambiarEstado");
	this.iface.bufferChanged("estado");
		
/** \D Se muestran sólo los recibos de la remesa
\end */
	var tdbRecibos= this.child("tdbRecibos");
// 	tdbRecibos.cursor().setMainFilter("idremesa = " + cursor.valueBuffer("idremesa"));
/** \C La tabla de recibos se muestra en modo de sólo lectura
\end */
	tdbRecibos.setReadOnly(true);
	var mA = cursor.modeAccess();
	if (mA == cursor.Insert)
			this.child("fdbCodDivisa").setValue(flfactppal.iface.pub_valorDefectoEmpresa("coddivisa"));

  var idRemesa = cursor.valueBuffer("idremesa");
	tdbRecibos.cursor().setMainFilter("(idrecibo IN (SELECT idrecibo FROM pagosdevolcli WHERE idremesa = " + idRemesa + ") OR idremesa = " + idRemesa + ")");
	tdbRecibos.refresh();
	
	this.iface.habilitarPorRecibos();
}

function interna_validateForm()
{
	var util= new FLUtil;
	var cursor= this.cursor();

	/** \C La remesa debe tener al menos un recibo
	\end */
	if (!util.sqlSelect("pagosdevolcli", "idpagodevol", "idremesa = " + cursor.valueBuffer("idremesa"))) {
		MessageBox.warning(util.translate("scripts", "La remesa debe tener al menos un recibo."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
	
	/** \C La cuenta bancaria de los recibos incluidos en la remesa debe ser una cuenta del cliente válida
	\end 
	var qryRecibos= new qryRecibos();
	qryRecibos.setTablesList("pagosdevolcli,reciboscli,cuentasbcocli");
	qryRecibos.setSelect("r.codigo");
	qryRecibos.setFrom("pagosdevolcli pd INNER JOIN reciboscli r ON pd.idrecibo = r.idrecibo LEFT OUTER JOIN cuentasbcocli cc ON (r.codcliente = cc.codcliente AND r.codcuenta = cc.codcuenta)");
	qryRecibos.where("pd.idremesa = " + cursorvalueBuffer("remesa") + " AND cc.codcuenta IS NULL");
	qryRecibos.setForwardOnly(true);
	if (!qryRecibos.exec())
		return false;
		
	if (qryRecibos.first()) {
		MessageBox.warning(util.translate("scripts", "El recibo %1 está asociado a una cuenta bancaria que ha sido eliminada del cliente.\nDebe asociar el recibo a una cuenta válida antes de añadirlo a la remesa.").arg(qryRecibos.value("r.codigo")), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	*/
	return true;
}

function interna_calculateField(fN:String)
{
  var _i = this.iface;
	var util= new FLUtil();
	var cursor = this.cursor();

	var res:String;
	switch (fN) {
		/** \D La subcuenta contable por defecto dependerá de si se ha establecido o no la opción Cobro directo en el formulario de datos generales. Si la opción está establecida será la asociada a la cuenta bancaria. Si no lo está será la subcuenta de efectos comerciales de gestión de cobro asociada a la cuenta bancaria. Si ésta está vacía, será la subcuenta correspondienta a Caja
		\end */
		case "idsubcuentadefecto": {
			if (this.iface.contabActivada) {
				var codSubcuenta:String;
				if (this.iface.pagoIndirecto_) {
					codSubcuenta = util.sqlSelect("cuentasbanco", "codsubcuentaecgc", "codcuenta = '" + cursor. valueBuffer("codcuenta") + "'");
				} else {
					codSubcuenta = util.sqlSelect("cuentasbanco", "codsubcuenta", "codcuenta = '" + cursor. valueBuffer("codcuenta") + "'");
				}
				if (codSubcuenta != false) {
					res = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + codSubcuenta + "' AND codejercicio = '" + this.iface.ejercicioActual + "'");
				} else  {
					res = "";
				}
			}
			break;
		}
		case "idsubcuenta":
			var codSubcuenta= cursor.valueBuffer("codsubcuenta").toString();
			if (codSubcuenta.length == this.iface.longSubcuenta)
				res = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + codSubcuenta + "' AND codejercicio = '" + this.iface.ejercicioActual + "'");
			break;
		case "codsubcuenta":
			res = "";
			if (cursor.valueBuffer("idsubcuenta"))
					res = util.sqlSelect("co_subcuentas", "codsubcuenta", "idsubcuenta = '" + cursor.valueBuffer("idsubcuenta") + "' AND codejercicio = '" + this.iface.ejercicioActual + "'");
			break;
		case "total": {
			res = util.sqlSelect("reciboscli", "SUM(importe)", "idrecibo IN (SELECT idrecibo FROM pagosdevolcli WHERE idremesa = " + cursor.valueBuffer("idremesa") + ")");
			break;
		}
		case "estado": {
			if (this.iface.pagoIndirecto_ || _i.pagoDiferido_) { /// Por compatibilidad con versiones anteriores. Sólo debería comprobarse pagoDiferido_
				var tipo= util.sqlSelect("pagosdevolrem", "tipo", "idremesa = " + cursor.valueBuffer("idremesa"));
				if (!tipo || tipo == "")
					res = "Emitida";
				else
					res = "Pagada";
			} else {
				res = "Emitida";
			}
			break;
		}
	}
	return res;
}

/** \D Calcula un nuevo código de remesa
\end */
function interna_calculateCounter()
{
	var util= new FLUtil();
	var cadena= util.sqlSelect("remesas", "idremesa", "1 = 1 ORDER BY idremesa DESC");
	var valor:Number;
	if (!cadena)
		valor = 1;
	else
		valor = parseFloat(cadena) + 1;

	return valor;
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_actualizarTotal()
{
	this.child("total").setValue(this.iface.calculateField("total"));
	this.iface.habilitarPorRecibos();
}

function oficial_habilitarPorRecibos()
{
	var cursor = this.cursor();
	var _i = this.iface;
	var hayRecibos = this.child("tdbRecibos").cursor().size() > 0;
	if (_i.pagoDiferido_ && !_i.pagoIndirecto_) {
		/// Al no generarse asiento por recibo podemos mantener la cuenta habilitada hasta que la remesa se pague.
		this.child("fdbCodCuenta").setDisabled(cursor.valueBuffer("estado") != "Emitida");
		this.child("fdbCodSubcuenta").setDisabled(cursor.valueBuffer("estado") != "Emitida");
	} else {
		this.child("fdbCodCuenta").setDisabled(hayRecibos);
		this.child("fdbCodSubcuenta").setDisabled(hayRecibos);
	}
	this.child("fdbCodDivisa").setDisabled(hayRecibos);
	this.child("fdbFecha").setDisabled(hayRecibos);
	this.child("gbxContabilidad").setEnabled(hayRecibos);
	
	if (_i.contabActivada)
		_i.asientoAcumulado();
}

/** \D Se agrega un recibo a la remesa. Si la contabilidad está integrada se comprueba que se ha seleccionado una subcuenta
\end */
function oficial_agregarRecibo()
{
	var util= new FLUtil();
	var cursor= this.cursor();
	
	if (!cursor.valueBuffer("codcuenta")) {
		MessageBox.warning(util.translate("scripts", "Debe indicar una cuenta bancaria"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return;
	}
	
	if (cursor.modeAccess() == cursor.Insert) {
		if (!this.child("tdbPagosDevolRem").cursor().commitBufferCursorRelation()) {
			return false;
		}
	}
	
	if (sys.isLoadedModule("flcontppal") && util.sqlSelect("empresa", "contintegrada", "1 = 1") && !cursor.valueBuffer("nogenerarasiento") && !cursor.valueBuffer("codsubcuenta")) {
		if (this.iface.pagoIndirecto_) {
			if (!util.sqlSelect("cuentasbanco", "codsubcuentaecgc", "codcuenta = '" + cursor.valueBuffer("codcuenta") + "'")) {
				MessageBox.warning(util.translate("scripts", "La cuenta bancaria seleccionada no tiene asociada una subcuenta de Efectos comerciales de gestión de cobro.\nDebe asignar esta subcuenta o desactivar la opción de pago indirecto de remesas en Datos generales."), MessageBox.Ok, MessageBox.NoButton);
			} else {
				MessageBox.warning(util.translate("scripts", "Debe indicar una subcuenta contable"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			}
		} else {
			if (!util.sqlSelect("cuentasbanco", "codsubcuenta", "codcuenta = '" + cursor.valueBuffer("codcuenta") + "'")) {
				MessageBox.warning(util.translate("scripts", "La cuenta bancaria seleccionada no tiene asociada una subcuenta contable.\nDebe asignar esta subcuenta en el módulo principal de facturación (Cuentas bancarias)."), MessageBox.Ok, MessageBox.NoButton);
			} else {
				MessageBox.warning(util.translate("scripts", "Debe indicar una subcuenta contable"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			}
		}
		return;
	}
	
	var f= new FLFormSearchDB("seleccionreciboscli");
	var curRecibos= f.cursor();
	var fecha= cursor.valueBuffer("fecha");
		
	var noGenerarAsiento= cursor.valueBuffer("nogenerarasiento");

	if (cursor.modeAccess() != cursor.Browse)
		if (!cursor.checkIntegrity())
			return;

	if (this.iface.contabActivada && this.child("fdbCodSubcuenta").value().isEmpty()) {
		if (cursor.valueBuffer("nogenerarasiento") == false) {
			MessageBox.warning(util.translate("scripts", "Debe seleccionar una subcuenta a la que asignar el asiento de pago o devolución"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return false;
		}
	}

	curRecibos.select();
	if (!curRecibos.first())
		curRecibos.setModeAccess(curRecibos.Insert);
	else
		curRecibos.setModeAccess(curRecibos.Edit);
		
	f.setMainWidget();
	curRecibos.refreshBuffer();
	curRecibos.setValueBuffer("datos", "");
	curRecibos.setValueBuffer("filtro", this.iface.filtroRecibosCli());

	var ret = f.exec( "datos" );

	if ( !f.accepted() )
		return false;

	var datos= new String( ret );

	if ( datos.isEmpty() ) 
		return false;

	var recibos= datos.split(",");

	var cur= new FLSqlCursor("empresa");
  AQUtil.createProgressDialog(sys.translate("scripts", "Adjuntando recibos"), recibos.length);
	for (var i= 0; i < recibos.length; i++) {
    AQUtil.setProgress(i);
		cur.transaction(false);
		try {
			if (this.iface.asociarReciboRemesa(recibos[i], cursor)) {
				cur.commit();
			}
			else {
				cur.rollback();
			}
		}
		catch (e) {
			cur.rollback();
			MessageBox.critical(util.translate("scripts", "Hubo un error en la asociación del recibo a la remesa:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
		}
	}
  AQUtil.destroyProgressDialog();

	this.child("tdbRecibos").refresh();
	this.iface.actualizarTotal();
}

function oficial_filtroRecibosCli()
{
	var cursor= this.cursor();
	
	return "estado IN ('Emitido', 'Devuelto')";
}

/** \D Se elimina el recibo activo de la remesa. El pago asociado a la remesa debe ser el último asignado al recibo
\end */
function oficial_eliminarRecibo()
{
	if (!this.child("tdbRecibos").cursor().isValid())
		return;
	
	var recibo= this.child("tdbRecibos").cursor().valueBuffer("idrecibo");
	if (!this.iface.excluirReciboRemesa(recibo, this.cursor().valueBuffer("idremesa")))
		return 

	this.child("tdbRecibos").refresh();
	this.iface.actualizarTotal();
}

function oficial_excluirReciboRemesa(idRecibo:String, idRemesa:String)
{
	var util= new FLUtil;

	var cuentaValida= util.sqlSelect("reciboscli r LEFT OUTER JOIN cuentasbcocli c ON r.codcliente = c.codcliente", "r.idrecibo", "idrecibo = " + idRecibo + " AND (r.codcuenta = c.codcuenta OR r.codcuenta = '' OR r.codcuenta IS NULL)", "reciboscli,cuentasbcocli");
	if (!cuentaValida) {
		var codRecibo= util.sqlSelect("reciboscli", "codigo", "idrecibo = " + idRecibo);
		MessageBox.warning(util.translate("scripts", "La cuenta bancaria del recibo %1 no es una cuenta válida del cliente.\nCambie o borre la cuenta antes de excluir el recibo de la remesa.").arg(codRecibo), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	
	var curRecibos= new FLSqlCursor("reciboscli");
	var curPagosDev= new FLSqlCursor("pagosdevolcli");
	var curFactura= new FLSqlCursor("facturascli");
	var idfactura:Number;
	
	curRecibos.select("idrecibo = " + idRecibo);

	if (!curRecibos.first())
		return false;
	
	if (curRecibos.valueBuffer("estado") == "Devuelto") {
		MessageBox.warning(util.translate("scripts", "Para excluir el recibo %1 de la remesa debe eliminar antes la devolución que se produjo posteriormente").arg(curRecibos.valueBuffer("codigo")), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	
	curRecibos.setModeAccess(curRecibos.Edit);
	curRecibos.refreshBuffer();
	
	idfactura = curRecibos.valueBuffer("idfactura");

	curFactura.select("idfactura = " + idfactura);
	if (curFactura.first())
		curFactura.setUnLock("editable", true);
	
	curPagosDev.select("idrecibo = " + idRecibo + " ORDER BY fecha,idpagodevol");
	if (curPagosDev.last()) {
		curPagosDev.setModeAccess(curPagosDev.Del);
		curPagosDev.refreshBuffer();
		if (!curPagosDev.commitBuffer())
			return false;
	}
	curPagosDev.select("idrecibo = " + idRecibo + " ORDER BY fecha,idpagodevol");
	if (curPagosDev.last())
		curPagosDev.setUnLock("editable", true);
	if (curPagosDev.size() == 0)
		curRecibos.setValueBuffer("estado", "Emitido");
	else
		curRecibos.setValueBuffer("estado", "Devuelto");
	curRecibos.setNull("idremesa");
	
	if (!curRecibos.commitBuffer()) {
		return false;
	}
	
	if (!flfactteso.iface.pub_actualizarTotalesReciboCli(idRecibo)) {
		return false;
	}
	return true;
}

function oficial_bufferChanged(fN:String)
{
	var cursor= this.cursor();
	var util= new FLUtil();
	switch (fN) {
		/** \C En contabilidad integrada, si el usuario pulsa la tecla del punto '.', --codsubcuenta-- se informa automaticamente con el código de cuenta más tantos ceros como sea necesario para completar la longitud de subcuenta asociada al ejercicio actual.
			\end */
		case "codsubcuenta": {
			if (!this.iface.bloqueoSubcuenta) {
				this.iface.bloqueoSubcuenta = true;
				this.iface.posActualPuntoSubcuenta = flcontppal.iface.pub_formatearCodSubcta(this, "fdbCodSubcuenta", this.iface.longSubcuenta, this.iface.posActualPuntoSubcuenta);
				this.iface.bloqueoSubcuenta = false;
			}
			if (!this.iface.bloqueoSubcuenta && this.child("fdbCodSubcuenta").value().length == this.iface.longSubcuenta) {
				this.child("fdbIdSubcuenta").setValue(this.iface.calculateField("idsubcuenta"));
			}
			break;
		}
			/** \D Si el usuario selecciona una cuenta bancaria, se tomará su cuenta contable asociada como --codcuenta-- contable para el pago.
				\end */
		case "codcuenta": {
			this.child("fdbIdSubcuenta").setValue(this.iface.calculateField("idsubcuentadefecto"));
			break;
		}
		case "idsubcuenta": {
			this.child("fdbCodSubcuenta").setValue(this.iface.calculateField("codsubcuenta"));
			break;
		}
		case "nogenerarasiento": {
			if (cursor.valueBuffer("nogenerarasiento") == true) {
				this.child("fdbIdSubcuenta").setValue("");
				this.child("fdbCodSubcuenta").setValue("");
				this.child("fdbDesSubcuenta").setValue("");
				cursor.setNull("idsubcuenta");
				cursor.setNull("codsubcuenta");
				this.child("fdbIdSubcuenta").setDisabled(true);
				this.child("fdbCodSubcuenta").setDisabled(true);
			} else {
				this.child("fdbIdSubcuenta").setDisabled(false);
				this.child("fdbCodSubcuenta").setDisabled(false);
			}
			break;
		}
		case "estado": {
			if (cursor.valueBuffer("estado") == "Pagada") {
				this.child("tbInsert").setDisabled(true);
				this.child("tbDelete").setDisabled(true);
			} else {
				this.child("tbInsert").setDisabled(false);
				this.child("tbDelete").setDisabled(false);
			}
			break;
		}
	}
}

/** \D Rellena la tabla de asiento acumulado de la pestaña de Contabilidad con los datos de contabilidad asociados a los recibos de la remesa
\end */
function oficial_asientoAcumulado()
{
	var util= new FLUtil;
	var totalFilas= this.iface.tblResAsientos.numRows() - 1;
	var fila:Number;
	for (fila = totalFilas; fila >= 0; fila--)
		this.iface.tblResAsientos.removeRow(fila);
	
	var idRemesa = this.cursor().valueBuffer("idremesa");
	if (!idRemesa)
		return;
	var qryAsientos= new FLSqlQuery();
	qryAsientos.setTablesList("reciboscli,pagosdevolcli,co_partidas");
	qryAsientos.setSelect("p.codsubcuenta, SUM(p.debe), SUM(p.haber)");
	qryAsientos.setFrom("reciboscli r INNER JOIN pagosdevolcli pd ON r.idrecibo = pd.idrecibo INNER JOIN co_partidas p ON pd.idasiento = p.idasiento");
	qryAsientos.setWhere("pd.idremesa = " + idRemesa + " GROUP BY p.codsubcuenta");
	qryAsientos.setOrderBy("p.codsubcuenta");
	if (!qryAsientos.exec())
		return;
	
	fila = 0;
	while (qryAsientos.next()) {
		this.iface.tblResAsientos.insertRows(fila, 1);
		this.iface.tblResAsientos.setText(fila, 0, qryAsientos.value("p.codsubcuenta"));
		this.iface.tblResAsientos.setText(fila, 1, util.sqlSelect("co_subcuentas", "descripcion", "codsubcuenta = '" + qryAsientos.value("p.codsubcuenta") + "' AND codejercicio = '" + this.iface.ejercicioActual + "'"));
		this.iface.tblResAsientos.setText(fila, 2, util.roundFieldValue(qryAsientos.value("SUM(p.debe)"), "co_partidas", "debe"));
		this.iface.tblResAsientos.setText(fila, 3, util.roundFieldValue(qryAsientos.value("SUM(p.haber)"), "co_partidas", "haber"));
		fila++;
	}
}

/** \D Asocia un recibo a una remesa, marcándolo como Pagado
@param	idRecibo: Identificador del recibo
@param	curRemesa: Cursor posicionado en la remesa
@return	true si la asociación se realiza de forma correcta, false en caso contrario
\end */
function oficial_asociarReciboRemesa(idRecibo, curRemesa)
{
  var _i = this.iface;
  var util= new FLUtil;
  var idRemesa= curRemesa.valueBuffer("idremesa");
  var idFactura;
  var curRecibos= new FLSqlCursor("reciboscli");
  curRecibos.setActivatedCheckIntegrity(false);

	if (util.sqlSelect("reciboscli", "coddivisa", "idrecibo = " + idRecibo) != curRemesa.valueBuffer("coddivisa")) {
		MessageBox.warning(util.translate("scripts", "No es posible incluir el recibo.\nLa divisa del recibo y de la remesa deben ser la misma."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return;
  }

	var datosCuenta= flfactppal.iface.pub_ejecutarQry("cuentasbanco", "ctaentidad,ctaagencia,cuenta", "codcuenta = '" + curRemesa.valueBuffer("codcuenta") + "'");
	if (datosCuenta.result != 1)
		return false;
	var dc= util.calcularDC(datosCuenta.ctaentidad + datosCuenta.ctaagencia) + util.calcularDC(datosCuenta.cuenta);

	var curRecibos= new FLSqlCursor("reciboscli");

	var fecha= curRemesa.valueBuffer("fecha");
	if (!this.iface.curPagosDev)
		this.iface.curPagosDev = new FLSqlCursor("pagosdevolcli");
	this.iface.curPagosDev.select("idrecibo = " + idRecibo + " ORDER BY fecha,idpagodevol");
	if (this.iface.curPagosDev.last()) {
		if (util.daysTo(this.iface.curPagosDev.valueBuffer("fecha"), fecha) < 0) {
			var codRecibo= util.sqlSelect("reciboscli", "codigo", "idrecibo = " + idRecibo);
			MessageBox.warning(util.translate("scripts", "Existen pagos o devoluciones con fecha igual o porterior a la de la remesa para el recibo %1").arg(codRecibo), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
	}
  
  var tipoPD, estadoRecibo;
  if (_i.pagoDiferido_ && !_i.pagoIndirecto_) {
    tipoPD = "Remesado";
    estadoRecibo = "Remesado";
  } else {
    tipoPD = "Pago";
    estadoRecibo = "Pagado";
  }
	curRecibos.select("idrecibo = " + idRecibo);
	if (!curRecibos.first()) {
		return false;
	}
	curRecibos.setModeAccess(curRecibos.Edit);
	curRecibos.refreshBuffer();
	if (!_i.validaReciboEnRemesa(curRecibos)) {
		return false;
	}
	curRecibos.setValueBuffer("idremesa", idRemesa);
	curRecibos.setValueBuffer("estado", estadoRecibo);
	idFactura = curRecibos.valueBuffer("idfactura");
  var tipo = (_i.pagoDiferido_ && !_i.pagoIndirecto_) ? "Remesado" : "Pago";

	if (this.iface.curPagosDev.last()) {
		this.iface.curPagosDev.setUnLock("editable", false);
	}
	this.iface.curPagosDev.setModeAccess(this.iface.curPagosDev.Insert);
	this.iface.curPagosDev.refreshBuffer();
	this.iface.curPagosDev.setValueBuffer("idrecibo", idRecibo);
	this.iface.curPagosDev.setValueBuffer("fecha", fecha);
	this.iface.curPagosDev.setValueBuffer("tipo", tipoPD);
	this.iface.curPagosDev.setValueBuffer("codcuenta", curRemesa.valueBuffer("codcuenta"));
	this.iface.curPagosDev.setValueBuffer("ctaentidad", datosCuenta.ctaentidad);
	this.iface.curPagosDev.setValueBuffer("ctaagencia", datosCuenta.ctaagencia);
	this.iface.curPagosDev.setValueBuffer("dc", dc);
	this.iface.curPagosDev.setValueBuffer("cuenta", datosCuenta.cuenta);
	this.iface.curPagosDev.setValueBuffer("idremesa", idRemesa);
	this.iface.curPagosDev.setValueBuffer("nogenerarasiento", curRemesa.valueBuffer("nogenerarasiento"));
	if (parseFloat(curRemesa.valueBuffer("idsubcuenta")) == 0) {
		this.iface.curPagosDev.setNull("idsubcuenta");
		this.iface.curPagosDev.setNull("codsubcuenta");
	} else {
		this.iface.curPagosDev.setValueBuffer("idsubcuenta", curRemesa.valueBuffer("idsubcuenta"));
		this.iface.curPagosDev.setValueBuffer("codsubcuenta", curRemesa.valueBuffer("codsubcuenta"));
	}
	if (!this.iface.datosPagosDev(idRecibo, curRemesa)) {
		return false;
	}
	if (!this.iface.curPagosDev.commitBuffer()) {
		return false;
	}
	
	if (!curRecibos.commitBuffer()) {
		return false;
	}
	if (!flfactteso.iface.pub_actualizarTotalesReciboCli(idRecibo)) {
		return false;
	}
	return true;
}

function oficial_datosPagosDev(idRecibo:String, curRemesa:FLSqlCursor)
{
	return true;
}

function oficial_cambiarEstado()
{
	var _i = this.iface;
	this.child("fdbEstado").setValue(this.iface.calculateField("estado"));
	_i.habilitarPorRecibos();
}

function oficial_validaReciboEnRemesa(curRecibo)
{
	if (curRecibo.valueBuffer("estado") == "Pagado") {
		MessageBox.warning(sys.translate("No puede asociar a la remesa un recibo ya pagado (%1)").arg(curRecibo.valueBuffer("codigo")), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
		return false;
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
