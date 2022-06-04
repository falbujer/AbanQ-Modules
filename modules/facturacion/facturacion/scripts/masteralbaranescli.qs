/***************************************************************************
                 masteralbaranescli.qs  -  description
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
  function preloadMainFilter()
  {
    return this.ctx.interna_preloadMainFilter();
  }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna
{
  /** \D @var pbnAAlbaran Bot�n de asociar a albar�n \end */
  var pbnAAlbaran: Object;
  var pbnGFactura: Object;
  var tdbRecords: FLTableDB;
  var tbnImprimir: Object;
  var tbnAbrirCerrar: Object;
  var curFactura: FLSqlCursor;
  var curLineaFactura: FLSqlCursor;

  function oficial(context)
  {
    interna(context);
  }
  function imprimir(codAlbaran)
  {
    return this.ctx.oficial_imprimir(codAlbaran);
  }
  function dameParamInforme(idAlbaran)
  {
    return this.ctx.oficial_dameParamInforme(idAlbaran);
  }
  function procesarEstado()
  {
    return this.ctx.oficial_procesarEstado();
  }
  function pbnGenerarFactura_clicked()
  {
    return this.ctx.oficial_pbnGenerarFactura_clicked();
  }
  function generarFactura(where: String, curAlbaran: FLSqlCursor, datosAgrupacion): Number {
    return this.ctx.oficial_generarFactura(where, curAlbaran, datosAgrupacion);
  }
  function copiaLineasAlbaran(idAlbaran: Number, idFactura: Number): Boolean {
    return this.ctx.oficial_copiaLineasAlbaran(idAlbaran, idFactura);
  }
  function dameSelectLineasAlbaran(idAlbaran, idFactura) {
    return this.ctx.oficial_dameSelectLineasAlbaran(idAlbaran, idFactura);
  }
  function commonCalculateField(fN: String, cursor: FLSqlCursor): String {
    return this.ctx.oficial_commonCalculateField(fN, cursor);
  }
  function restarCantidad(idLineaPedido: Number, idLineaAlbaran: Number)
  {
    return this.ctx.oficial_restarCantidad(idLineaPedido, idLineaAlbaran);
  }
  function asociarAAlbaran()
  {
    return this.ctx.oficial_asociarAAlbaran();
  }
  function whereAgrupacion(curAgrupar: FLSqlCursor): String {
    return this.ctx.oficial_whereAgrupacion(curAgrupar);
  }
  function copiaLineaAlbaran(curLineaAlbaran: FLSqlCursor, idFactura: Number): Number {
    return this.ctx.oficial_copiaLineaAlbaran(curLineaAlbaran, idFactura);
  }
  function totalesFactura(): Boolean {
    return this.ctx.oficial_totalesFactura();
  }
  function datosFactura(curAlbaran, where, datosAgrupacion)
  {
    return this.ctx.oficial_datosFactura(curAlbaran, where, datosAgrupacion);
  }
  function datosDirFactura(curAlbaran, where, datosAgrupacion)
  {
    return this.ctx.oficial_datosDirFactura(curAlbaran, where, datosAgrupacion);
  }
  function datosLineaFactura(curLineaAlbaran: FLSqlCursor): Boolean {
    return this.ctx.oficial_datosLineaFactura(curLineaAlbaran);
  }
  function dameDatosAgrupacionPedidos(curAgruparPedidos: FLSqlCursor): Array {
    return this.ctx.oficial_dameDatosAgrupacionPedidos(curAgruparPedidos);
  }
  function validarFactura(idFactura: String): Boolean {
    return this.ctx.oficial_validarFactura(idFactura);
  }
  function filtrarTabla() {
    return this.ctx.oficial_filtrarTabla();
  }
  function filtroTabla() {
    return this.ctx.oficial_filtroTabla();
  }
  function tbnAbrirCerrar_clicked()
  {
    return this.ctx.oficial_tbnAbrirCerrar_clicked();
  }
  function damePorDtoCabecera(cursor) {
		return 0; /// Funci�n a sobrecargar
	}
	function groupByAgrupacion(cursor) {
		return this.ctx.oficial_groupByAgrupacion(cursor);
	}
	function selectAgrupacion(cursor) {
		return this.ctx.oficial_selectAgrupacion(cursor);
	}
	function masWhereAlbaran(qryAgruparPedidos) {
		return this.ctx.oficial_masWhereAlbaran(qryAgruparPedidos);
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
  function pub_whereAgrupacion(curAgrupar: FLSqlCursor): String {
    return this.whereAgrupacion(curAgrupar);
  }
  function pub_generarFactura(where: String, curAlbaran: FLSqlCursor, datosAgrupacion: Array): Number {
    return this.generarFactura(where, curAlbaran, datosAgrupacion);
  }
  function pub_commonCalculateField(fN: String, cursor: FLSqlCursor): String {
    return this.commonCalculateField(fN, cursor);
  }
  function pub_restarCantidad(idLineaPedido: Number, idLineaAlbaran: Number)
  {
    return this.restarCantidad(idLineaPedido, idLineaAlbaran);
  }
  function pub_imprimir(codAlbaran: String)
  {
    return this.imprimir(codAlbaran);
  }
}

const iface = new ifaceCtx(this);
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition interna */
////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
/** \C
Este es el formulario maestro de albaranes a cliente.
\end */
function interna_init()
{
  this.iface.pbnAAlbaran = this.child("pbnAsociarAAlbaran");
  this.iface.pbnGFactura = this.child("pbnGenerarFactura");
  this.iface.tdbRecords = this.child("tableDBRecords");
  this.iface.tbnImprimir = this.child("toolButtonPrint");
  this.iface.tbnAbrirCerrar = this.child("tbnAbrirCerrar");

  connect(this.iface.pbnAAlbaran, "clicked()", this, "iface.asociarAAlbaran");
  connect(this.iface.pbnGFactura, "clicked()", this, "iface.pbnGenerarFactura_clicked");
  connect(this.iface.tdbRecords, "currentChanged()", this, "iface.procesarEstado");
  connect(this.iface.tbnImprimir, "clicked()", this, "iface.imprimir");
  connect(this.iface.tbnAbrirCerrar, "clicked()", this, "iface.tbnAbrirCerrar_clicked");

  this.iface.procesarEstado();
}

function interna_preloadMainFilter()
{
  return this.iface.filtroTabla();
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \C
Al pulsar el bot�n imprimir se lanzar� el informe correspondiente al albar�n seleccionado (en caso de que el m�dulo de informes est� cargado)
\end */
function oficial_imprimir(codAlbaran)
{
  var util: FLUtil;
  if (sys.isLoadedModule("flfactinfo")) {
    var idAlbaran, codigo;
    if (codAlbaran) {
      codigo = codAlbaran;
      idAlbaran = util.sqlSelect("albaranescli", "idalbaran", "codigo = '" + codigo + "'");
    } else {
      var cursor = this.cursor();
      if (!cursor.isValid()) {
        return;
      }
      codigo = this.cursor().valueBuffer("codigo");
      idAlbaran = this.cursor().valueBuffer("idalbaran");
    }
    if (!idAlbaran) {
      return;
    }

    var oParam = this.iface.dameParamInforme(idAlbaran);
    if (!oParam) {
      return;
    }
    var curImprimir: FLSqlCursor = new FLSqlCursor("i_albaranescli");
    curImprimir.setModeAccess(curImprimir.Insert);
    curImprimir.refreshBuffer();
    curImprimir.setValueBuffer("descripcion", "temp");
    curImprimir.setValueBuffer("d_albaranescli_codigo", codigo);
    curImprimir.setValueBuffer("h_albaranescli_codigo", codigo);
    flfactinfo.iface.pub_lanzaInforme(curImprimir, oParam);
  } else {
    flfactppal.iface.pub_msgNoDisponible("Informes");
  }
}

function oficial_dameParamInforme(idAlbaran)
{
  var oParam = flfactinfo.iface.pub_dameParamInforme();
  oParam.nombreInforme = "i_albaranescli";
  return oParam;
}

function oficial_procesarEstado()
{
  if (this.cursor().valueBuffer("ptefactura") == true) {
    this.iface.pbnGFactura.setDisabled(false);
  } else {
    this.iface.pbnGFactura.setDisabled(true);
  }
}

/** \C
Al pulsar el bot�n de generar factura se crear� la factura correspondiente al albar�n.
\end */
function oficial_pbnGenerarFactura_clicked()
{
  var util: FLUtil = new FLUtil;
  var cursor: FLSqlCursor = this.cursor();
  var where: String = "idalbaran = " + cursor.valueBuffer("idalbaran");

  if (cursor.valueBuffer("ptefactura") == false) {
    MessageBox.warning(util.translate("scripts", "Ya existe la factura correspondiente a este albar�n"), MessageBox.Ok, MessageBox.NoButton);
    this.iface.procesarEstado();
    return;
  }
  this.iface.pbnGFactura.setEnabled(false);

  cursor.transaction(false);
  try {
    if (this.iface.generarFactura(where, cursor))
      cursor.commit();
    else
      cursor.rollback();
  } catch (e) {
    cursor.rollback();
    MessageBox.critical(util.translate("scripts", "Hubo un error en la generaci�n de la factura:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
  }

  this.iface.tdbRecords.refresh();
  this.iface.procesarEstado();
}

/** \D
Genera la factura asociada a uno o m�s albaranes
@param where: Sentencia where para la consulta de b�squeda de los albaranes a agrupar
@param curAlbaran: Cursor con los datos principales que se copiar�n del albar�n a la factura
@param datosAgrupacion: Array con los datos indicados en el formulario de agrupaci�n de albaranes
@return True: Copia realizada con �xito, False: Error
\end */
function oficial_generarFactura(where: String, curAlbaran: FLSqlCursor, datosAgrupacion: Array): Number {
  if (!this.iface.curFactura)
    this.iface.curFactura = new FLSqlCursor("facturascli");

  this.iface.curFactura.setModeAccess(this.iface.curFactura.Insert);
  this.iface.curFactura.refreshBuffer();

  if (!this.iface.datosFactura(curAlbaran, where, datosAgrupacion))
  {
    return false;
  }

  if (!this.iface.curFactura.commitBuffer())
  {
    return false;
  }

  var idFactura: Number = this.iface.curFactura.valueBuffer("idfactura");

  var curAlbaranes: FLSqlCursor = new FLSqlCursor("albaranescli");
  curAlbaranes.select(where);
  var idAlbaran: Number;
  while (curAlbaranes.next())
  {
    curAlbaranes.setModeAccess(curAlbaranes.Browse);
    curAlbaranes.refreshBuffer();
    idAlbaran = curAlbaranes.valueBuffer("idalbaran");
    if (!this.iface.copiaLineasAlbaran(idAlbaran, idFactura)) {
      return false;
    }
  }
  

  this.iface.curFactura.select("idfactura = " + idFactura);
  if (this.iface.curFactura.first())
  {
    this.iface.curFactura.setModeAccess(this.iface.curFactura.Edit);
    this.iface.curFactura.refreshBuffer();

    if (!this.iface.totalesFactura())
      return false;

    if (this.iface.curFactura.commitBuffer() == false)
      return false;
  }
  if (!this.iface.validarFactura(idFactura))
  {
    return false;
  }
  
  curAlbaranes.select(where);
  while (curAlbaranes.next())
  {
    curAlbaranes.setModeAccess(curAlbaranes.Edit);
    curAlbaranes.refreshBuffer();
    if (!curAlbaranes.valueBuffer("ptefactura")) {
      var codFacturaAlb = AQUtil.sqlSelect("facturascli", "codigo", "idfactura = " + curAlbaranes.valueBuffer("idfactura"));
      MessageBox.warning(sys.translate("Error al facturar el albar�n %1. Este albar�n ya est� facturado en la factura %2").arg(curAlbaranes.valueBuffer("codigo")).arg(codFacturaAlb), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton, "AbanQ");
      return false;
    }
    curAlbaranes.setValueBuffer("idfactura", idFactura);
    curAlbaranes.setValueBuffer("ptefactura", false);
    if (!curAlbaranes.commitBuffer()) {
      return false;
    }
  }
  return idFactura;
}

function oficial_validarFactura(idFactura: String): Boolean {
  var util: FLUtil = new FLUtil;
  /// Comprobaci�n de R.E.
  var qryRecargo: FLSqlQuery = new FLSqlQuery;
  qryRecargo.setTablesList("facturascli,lineasfacturascli");
  qryRecargo.setSelect("f.codigo, f.nombrecliente");
  qryRecargo.setFrom("facturascli f inner join lineasfacturascli lf on f.idfactura = lf.idfactura inner join lineasfacturascli lf2 on f.idfactura = lf2.idfactura");
  qryRecargo.setWhere("f.idfactura = " + idFactura + " AND lf.recargo = 0 AND lf2.recargo <> 0");
  qryRecargo.setForwardOnly(true);
  if (!qryRecargo.exec())
  {
    return false;
  }
  if (qryRecargo.first())
  {
    var res: Number = MessageBox.warning(util.translate("scripts", "La factura %1 para %2 a generar tiene recargo de equivalencia s�lo en algunas de sus l�neas. �Desea continuar?").arg(qryRecargo.value("f.codigo")).arg(qryRecargo.value("f.nombrecliente")), MessageBox.Yes, MessageBox.No);
    if (res != MessageBox.Yes) {
      return false;
    }
  }
  return true;
}

/** \D Informa los datos de una factura a partir de los de uno o varios albaranes
@param  curAlbaran: Cursor que contiene los datos a incluir en la factura
@param where: Sentencia where para la consulta de b�squeda de los albaranes a agrupar
@param datosAgrupacion: Array con los datos indicados en el formulario de agrupaci�n de albaranes
@return True si el c�lculo se realiza correctamente, false en caso contrario
\end */
function oficial_datosFactura(curAlbaran, where, datosAgrupacion)
{
  var _i = this.iface;
  var util: FLUtil = new FLUtil();
  var fecha: String;
  var hora: String;
  if (datosAgrupacion) {
    fecha = datosAgrupacion["fecha"];
    hora = datosAgrupacion["hora"];
  } else {
    var hoy: Date = new Date();
    fecha = hoy.toString();
    hora = hoy.toString().right(8);
  }

  var codEjercicio: String = curAlbaran.valueBuffer("codejercicio");
  var datosDoc: Array = flfacturac.iface.pub_datosDocFacturacion(fecha, codEjercicio, "facturascli");
  if (!datosDoc.ok)
    return false;
  if (datosDoc.modificaciones == true) {
    codEjercicio = datosDoc.codEjercicio;
    fecha = datosDoc.fecha;
  }

  with(_i.curFactura) {
    setValueBuffer("codserie", curAlbaran.valueBuffer("codserie"));
    setValueBuffer("codejercicio", codEjercicio);
    setValueBuffer("irpf", curAlbaran.valueBuffer("irpf"));
    setValueBuffer("fecha", fecha);
    setValueBuffer("hora", hora);
    setValueBuffer("codagente", curAlbaran.valueBuffer("codagente"));
    setValueBuffer("porcomision", curAlbaran.valueBuffer("porcomision"));
    setValueBuffer("codalmacen", curAlbaran.valueBuffer("codalmacen"));
    setValueBuffer("codpago", curAlbaran.valueBuffer("codpago"));
    setValueBuffer("coddivisa", curAlbaran.valueBuffer("coddivisa"));
    setValueBuffer("tasaconv", curAlbaran.valueBuffer("tasaconv"));
    setValueBuffer("codcliente", curAlbaran.valueBuffer("codcliente"));
    setValueBuffer("cifnif", curAlbaran.valueBuffer("cifnif"));
    setValueBuffer("nombrecliente", curAlbaran.valueBuffer("nombrecliente"));
    setValueBuffer("observaciones", curAlbaran.valueBuffer("observaciones"));
    setValueBuffer("recfinanciero", curAlbaran.valueBuffer("recfinanciero"));
		setValueBuffer("deabono", curAlbaran.valueBuffer("deabono"));
		setValueBuffer("automatica", true);
  }
  if (!_i.datosDirFactura(curAlbaran, where, datosAgrupacion)) {
    return false;
  }
  return true;
}

function oficial_datosDirFactura(curAlbaran, where, datosAgrupacion)
{
  var _i = this.iface;
  var util = new FLUtil();

  var codCliente = curAlbaran.valueBuffer("codcliente");
  var codDir = util.sqlSelect("dirclientes", "id", "codcliente = '" + codCliente + "' AND domfacturacion");
  with(_i.curFactura) {
    if (codDir) {
      setValueBuffer("coddir", codDir);
      setValueBuffer("direccion", util.sqlSelect("dirclientes", "direccion", "id = " + codDir));
      setValueBuffer("codpostal", util.sqlSelect("dirclientes", "codpostal", "id = " + codDir));
      setValueBuffer("ciudad", util.sqlSelect("dirclientes", "ciudad", "id = " + codDir));
      setValueBuffer("provincia", util.sqlSelect("dirclientes", "provincia", "id = " + codDir));
      setValueBuffer("apartado", util.sqlSelect("dirclientes", "apartado", "id = " + codDir));
      setValueBuffer("codpais", util.sqlSelect("dirclientes", "codpais", "id = " + codDir));
    } else {
      codDir = curAlbaran.valueBuffer("coddir")
      if (codDir == 0) {
        this.setNull("coddir");
      } else {
        setValueBuffer("coddir", curAlbaran.valueBuffer("coddir"));
      }
      setValueBuffer("direccion", curAlbaran.valueBuffer("direccion"));
      setValueBuffer("codpostal", curAlbaran.valueBuffer("codpostal"));
      setValueBuffer("ciudad", curAlbaran.valueBuffer("ciudad"));
      setValueBuffer("provincia", curAlbaran.valueBuffer("provincia"));
      setValueBuffer("apartado", curAlbaran.valueBuffer("apartado"));
      setValueBuffer("codpais", curAlbaran.valueBuffer("codpais"));
    }
  }
  return true;
}

/** \D Copia los datos de una l�nea de albar�n en una l�nea de factura
@param  curLineaAlbaran: Cursor que contiene los datos a incluir en la l�nea de factura
@return True si la copia se realiza correctamente, false en caso contrario
\end */
function oficial_datosLineaFactura(curLineaAlbaran: FLSqlCursor): Boolean {
  var iva: Number, recargo: Number;
  var codImpuesto: String = curLineaAlbaran.valueBuffer("codimpuesto");

  with(this.iface.curLineaFactura)
  {
    setValueBuffer("referencia", curLineaAlbaran.valueBuffer("referencia"));
    setValueBuffer("descripcion", curLineaAlbaran.valueBuffer("descripcion"));
    setValueBuffer("pvpunitario", curLineaAlbaran.valueBuffer("pvpunitario"));
    setValueBuffer("pvpsindto", curLineaAlbaran.valueBuffer("pvpsindto"));
    setValueBuffer("cantidad", curLineaAlbaran.valueBuffer("cantidad"));
    setValueBuffer("pvptotal", curLineaAlbaran.valueBuffer("pvptotal"));
    setValueBuffer("codimpuesto", codImpuesto);
    if (curLineaAlbaran.isNull("iva")) {
      setNull("iva");
    } else {
      iva = curLineaAlbaran.valueBuffer("iva");
      if (iva != 0 && codImpuesto && codImpuesto != "") {
        iva = formRecordlineaspedidoscli.iface.pub_commonCalculateField("iva", this); /// Para cambio de IVA seg�n fechas
      }
      setValueBuffer("iva", iva);
    }
    if (curLineaAlbaran.isNull("recargo")) {
      setNull("recargo");
    } else {
      recargo = curLineaAlbaran.valueBuffer("recargo");
      if (recargo != 0 && codImpuesto && codImpuesto != "") {
        recargo = formRecordlineaspedidoscli.iface.pub_commonCalculateField("recargo", this); /// Para cambio de IVA seg�n fechas
      }
      setValueBuffer("recargo", recargo);
    }
    setValueBuffer("irpf", curLineaAlbaran.valueBuffer("irpf"));
    setValueBuffer("dtolineal", curLineaAlbaran.valueBuffer("dtolineal"));
    setValueBuffer("dtopor", curLineaAlbaran.valueBuffer("dtopor"));
    setValueBuffer("porcomision", curLineaAlbaran.valueBuffer("porcomision"));
    setValueBuffer("idalbaran", curLineaAlbaran.valueBuffer("idalbaran"));
  }
  return true;
}

/** \D Informa los datos de una factura referentes a totales (I.V.A., neto, etc.)
@return True si el c�lculo se realiza correctamente, false en caso contrario
\end */
function oficial_totalesFactura(): Boolean {
  with(this.iface.curFactura)
  {
    setValueBuffer("neto", formfacturascli.iface.pub_commonCalculateField("neto", this));
    setValueBuffer("totaliva", formfacturascli.iface.pub_commonCalculateField("totaliva", this));
    setValueBuffer("totalirpf", formfacturascli.iface.pub_commonCalculateField("totalirpf", this));
    setValueBuffer("totalrecargo", formfacturascli.iface.pub_commonCalculateField("totalrecargo", this));
    setValueBuffer("total", formfacturascli.iface.pub_commonCalculateField("total", this));
    setValueBuffer("totaleuros", formfacturascli.iface.pub_commonCalculateField("totaleuros", this));
  }
  return true;
}

/** \D
Copia las l�neas de un albar�n como l�neas de su factura asociada
@param idAlbaran: Identificador del albar�n
@param idFactura: Identificador de la factura
@return Verdadero si no hay error, falso en caso contrario
\end */
function oficial_copiaLineasAlbaran(idAlbaran, idFactura)
{
	var _i = this.iface;
  var curLineaAlbaran = new FLSqlCursor("lineasalbaranescli");
  curLineaAlbaran.select(_i.dameSelectLineasAlbaran(idAlbaran, idFactura));

  while (curLineaAlbaran.next()) {
    curLineaAlbaran.setModeAccess(curLineaAlbaran.Browse);
    if (!_i.copiaLineaAlbaran(curLineaAlbaran, idFactura))
      return false;
  }
  return true;
}

function oficial_dameSelectLineasAlbaran(idAlbaran, idFactura)
{
	var s = "idalbaran = " + idAlbaran; 
	return s;
}


/** \D
Copia una l�nea de albar�n en su factura asociada
@param curLineaAlbaran: Cursor posicionado en la l�nea de albar�n a copiar
@param idFactura: Identificador de la factura
@return Identificador de la l�nea de factura si no hay error, falso en caso contrario
\end */
function oficial_copiaLineaAlbaran(curLineaAlbaran: FLSqlCursor, idFactura: Number): Number {
  if (!this.iface.curLineaFactura)
    this.iface.curLineaFactura = new FLSqlCursor("lineasfacturascli");

  with(this.iface.curLineaFactura)
  {
    setModeAccess(Insert);
    refreshBuffer();
    setValueBuffer("idfactura", idFactura);
  }

  if (!this.iface.datosLineaFactura(curLineaAlbaran))
    return false;

  if (!this.iface.curLineaFactura.commitBuffer())
    return false;

  return this.iface.curLineaFactura.valueBuffer("idlinea");
}

function oficial_commonCalculateField(fN, cursor)
{
	var _i = this.iface;
	var cx; try { cx = cursor.connectionName();} catch(e) { cx = "default"; }
debug("cx " + cx);
  var util = new FLUtil();
  var valor;

  /** \C
  El --c�digo-- se construye como la concatenaci�n de --codserie--, --codejercicio-- y --numero--
  \end */
  if (fN == "codigo")
    valor = flfacturac.iface.pub_construirCodigo(cursor.valueBuffer("codserie"), cursor.valueBuffer("codejercicio"), cursor.valueBuffer("numero"));

  switch (fN)
  {
      /** \C
      El --total-- es el --neto-- menos el --totalirpf-- m�s el --totaliva-- m�s el --totalrecargo-- m�s el --recfinanciero--
      \end */
    case "total": {
      var neto: Number = parseFloat(cursor.valueBuffer("neto"));
      var totalIrpf: Number = parseFloat(cursor.valueBuffer("totalirpf"));
      var totalIva: Number = parseFloat(cursor.valueBuffer("totaliva"));
      var totalRecargo: Number = parseFloat(cursor.valueBuffer("totalrecargo"));
      var recFinanciero: Number = (parseFloat(cursor.valueBuffer("recfinanciero")) * neto) / 100;
      recFinanciero = parseFloat(util.roundFieldValue(recFinanciero, "albaranescli", "total"));
      valor = neto - totalIrpf + totalIva + totalRecargo + recFinanciero;
      valor = parseFloat(util.roundFieldValue(valor, "albaranescli", "total"));
      break;
    }
    case "lblComision": {
      valor = (parseFloat(cursor.valueBuffer("porcomision")) * (parseFloat(cursor.valueBuffer("neto")))) / 100;
      valor = parseFloat(util.roundFieldValue(valor, "albaranescli", "total"));
      break;
    }
    case "lblRecFinanciero": {
      valor = (parseFloat(cursor.valueBuffer("recfinanciero")) * (parseFloat(cursor.valueBuffer("neto")))) / 100;
      valor = parseFloat(util.roundFieldValue(valor, "albaranescli", "total"));
      break;
    }
    /** \C
    El --totaleuros-- es el producto del --total-- por la --tasaconv--
    \end */
    case "totaleuros": {
      var total: Number = parseFloat(cursor.valueBuffer("total"));
      var tasaConv: Number = parseFloat(cursor.valueBuffer("tasaconv"));
      valor = total * tasaConv;
      valor = parseFloat(util.roundFieldValue(valor, "albaranescli", "totaleuros"));
      break;
    }
    /** \C
    El --neto-- es la suma del pvp total de las l�neas de albar�n
    \end */
    case "neto": {
      valor = AQUtil.sqlSelect("lineasalbaranescli", "SUM(pvptotal)", "idalbaran = " + cursor.valueBuffer("idalbaran"), "lineasalbaranescli", cx);
      valor = parseFloat(AQUtil.roundFieldValue(valor, "albaranescli", "neto"));
      break;
    }
    /** \C
    El --totaliva-- es la suma del iva correspondiente a las l�neas de albar�n
    \end */
    case "totaliva": {
			var porDto = _i.damePorDtoCabecera(cursor);
      var codCli = cursor.valueBuffer("codcliente");
      var regIva = flfacturac.iface.pub_regimenIVACliente(cursor);
      if (regIva == "U.E." || regIva == "Exento" || regIva == "Exportaciones") {
        valor = 0;
        break;
      }
      valor = AQUtil.sqlSelect("lineasalbaranescli", "SUM((pvptotal * iva * (100 - " + porDto + ")) / 100 / 100)", "idalbaran = " + cursor.valueBuffer("idalbaran"), undefined, cx);
			valor = parseFloat(AQUtil.roundFieldValue(valor, "albaranescli", "totaliva"));
      break;
    }
    /** \C
    El --totarecargo-- es la suma del recargo correspondiente a las l�neas de albar�n
    \end */
    case "totalrecargo": {
      var porDto = _i.damePorDtoCabecera(cursor);
      var regIva: String = flfacturac.iface.pub_regimenIVACliente(cursor);
      if (regIva == "U.E." || regIva == "Exento" || regIva == "Exportaciones") {
        valor = 0;
        break;
      }
      valor = AQUtil.sqlSelect("lineasalbaranescli", "SUM((pvptotal * recargo * (100 - " + porDto + ")) / 100 / 100)", "idalbaran = " + cursor.valueBuffer("idalbaran"), "lineasalbaranescli", cx);
      valor = parseFloat(AQUtil.roundFieldValue(valor, "albaranescli", "totalrecargo"));
      break;
    }
    /** \C
    El --coddir-- corresponde a la direcci�n del cliente marcada como direcci�n de facturaci�n
    \end */
    case "coddir": {
      valor = AQUtil.sqlSelect("dirclientes", "id", "codcliente = '" + cursor.valueBuffer("codcliente") + "' AND domenvio = 'true'", "dirclientes", cx);
      if (!valor) {
        valor = "";
      }
      break;
    }
    /** \C
    El --irpf-- es el asociado a la --codserie-- del albar�n
    \end */
    case "irpf": {
      valor = AQUtil.sqlSelect("series", "irpf", "codserie = '" + cursor.valueBuffer("codserie") + "'", undefined, cx);
      break;
    }
    /** \C
    El --totalirpf-- es el producto del --irpf-- por el --neto--
    \end */
    case "totalirpf": {
      valor = AQUtil.sqlSelect("lineasalbaranescli", "SUM((pvptotal * irpf) / 100)", "idalbaran = " + cursor.valueBuffer("idalbaran"), undefined, cx);
      //      valor = (parseFloat(cursor.valueBuffer("irpf")) * (parseFloat(cursor.valueBuffer("neto")))) / 100;
      valor = parseFloat(util.roundFieldValue(valor, "albaranescli", "totalirpf"));
      break;
    }
    case "provincia": {
      valor = AQUtil.sqlSelect("dirclientes", "provincia", "id = " + cursor.valueBuffer("coddir"), undefined, cx);
      if (!valor)
        valor = cursor.valueBuffer("provincia");
      break;
    }
    case "codpais": {
      valor = AQUtil.sqlSelect("dirclientes", "codpais", "id = " + cursor.valueBuffer("coddir"), undefined, cx);
      if (!valor)
        valor = cursor.valueBuffer("codpais");
      break;
    }
  }
  return valor;
}

function oficial_groupByAgrupacion(cursor)
{
	return "";
}

function oficial_selectAgrupacion(cursor)
{
	return "";
}

function oficial_masWhereAlbaran(qryAgruparPedidos)
{
	var where = "";

	var codCliente = qryAgruparPedidos.value(0);
	var codAlmacen = qryAgruparPedidos.value(1);
	if (codCliente && codCliente != "")
		where += " AND codcliente = '" + codCliente + "'";
	if (codAlmacen && codAlmacen != "")
		where += " AND codalmacen = '" + codAlmacen + "'";

	return where;
}

/** \C
Al pulsar el bot�n de asociar a albar�n se abre la ventana de agrupar pedidos de cliente
\end */
function oficial_asociarAAlbaran()
{
  var util: FLUtil = new FLUtil;

	var _i = this.iface;
  var f: Object = new FLFormSearchDB("agruparpedidoscli");
  var cursor: FLSqlCursor = f.cursor();
  var where: String;
	var groupBy;
	var select;
  var codCliente: String;
  var codAlmacen: String;

  cursor.setActivatedCheckIntegrity(false);
  cursor.select();
  if (!cursor.first())
    cursor.setModeAccess(cursor.Insert);
  else
    cursor.setModeAccess(cursor.Edit);

  f.setMainWidget();
  cursor.refreshBuffer();
  var acpt: String = f.exec("codejercicio");

  if (acpt) {
    cursor.commitBuffer();
    var curAgruparPedidos: FLSqlCursor = new FLSqlCursor("agruparpedidoscli");
    curAgruparPedidos.select();
    if (curAgruparPedidos.first()) {
      where = _i.whereAgrupacion(curAgruparPedidos);
			groupBy = _i.groupByAgrupacion(curAgruparPedidos);
			select = _i.selectAgrupacion(curAgruparPedidos);
      var excepciones = curAgruparPedidos.valueBuffer("excepciones");
      if (!excepciones.isEmpty())
        where += " AND idpedido NOT IN (" + excepciones + ")";

      var qryAgruparPedidos = new FLSqlQuery;
      qryAgruparPedidos.setTablesList("pedidoscli");
      qryAgruparPedidos.setSelect("codcliente,codalmacen" + select);
      qryAgruparPedidos.setFrom("pedidoscli");
      qryAgruparPedidos.setWhere(where + " AND codcliente IS NOT NULL AND codalmacen IS NOT NULL GROUP BY codcliente,codalmacen" + groupBy);
      qryAgruparPedidos.setForwardOnly(true);
      if (!qryAgruparPedidos.exec())
        return;

      var totalClientes: Number = qryAgruparPedidos.size();
      util.createProgressDialog(util.translate("scripts", "Generando albaranes"), totalClientes);
      util.setProgress(1);
      var j: Number = 0;

      var curPedido : FLSqlCursor = new FLSqlCursor("pedidoscli");
      var whereAlbaran: String;
      var datosAgrupacion: Array = [];
      while (qryAgruparPedidos.next()) {
      
        whereAlbaran = where + _i.masWhereAlbaran(qryAgruparPedidos);

        curPedido.transaction(false);
        try {
          curPedido.select(whereAlbaran);
          if (!curPedido.first()) {
            curPedido.rollback();
            util.destroyProgressDialog();
            return;
          }

          datosAgrupacion = this.iface.dameDatosAgrupacionPedidos(curAgruparPedidos);
          if (formpedidoscli.iface.pub_generarAlbaran(whereAlbaran, curPedido, datosAgrupacion)) {
            curPedido.commit();
          } else {
            curPedido.rollback();
            util.destroyProgressDialog();
            return;

          }
        } catch (e) {
          curPedido.rollback();
          MessageBox.critical(util.translate("scripts", "Error al generar el albar�n:") + e, MessageBox.Ok, MessageBox.NoButton);
        }
        util.setProgress(++j);
      }
      util.setProgress(totalClientes);
      util.destroyProgressDialog();
    }
    f.close();
    this.iface.tdbRecords.refresh();
  }
}

/** \D
Construye un array con los datos del albar�n a generar especificados en el formulario de agrupaci�n de pedidos
@param curAgruparPedidos: Cursor de la tabla agruparpedidoscli que contiene los valores
@return Array
\end */
function oficial_dameDatosAgrupacionPedidos(curAgruparPedidos: FLSqlCursor): Array {
  var res: Array = [];
  res["fecha"] = curAgruparPedidos.valueBuffer("fecha");
  res["hora"] = curAgruparPedidos.valueBuffer("hora");
  return res;
}


/** \D
Construye la sentencia WHERE de la consulta que buscar� los pedidos a agrupar
@param curAgrupar: Cursor de la tabla agruparpedidoscli que contiene los valores de los criterios de b�squeda
@return Sentencia where
\end */
function oficial_whereAgrupacion(curAgrupar: FLSqlCursor): String {
  var codCliente: String = curAgrupar.valueBuffer("codcliente");
  var nombreCliente: String = curAgrupar.valueBuffer("nombrecliente");
  var cifNif: String = curAgrupar.valueBuffer("cifnif");
  var codAlmacen: String = curAgrupar.valueBuffer("codalmacen");
  var codPago: String = curAgrupar.valueBuffer("codpago");
  var codDivisa: String = curAgrupar.valueBuffer("coddivisa");
  var codSerie: String = curAgrupar.valueBuffer("codserie");
  var codEjercicio: String = curAgrupar.valueBuffer("codejercicio");
  var fechaDesde: String = curAgrupar.valueBuffer("fechadesde");
  var fechaHasta: String = curAgrupar.valueBuffer("fechahasta");
  var where: String = "servido <> 'S�'";
  if (codCliente && !codCliente.isEmpty())
    where += " AND codcliente = '" + codCliente + "'";
  if (cifNif && !cifNif.isEmpty())
    where += " AND cifnif = '" + cifNif + "'";
  if (codAlmacen && !codAlmacen.isEmpty())
    where = where + " AND codalmacen = '" + codAlmacen + "'";
  where = where + " AND fecha >= '" + fechaDesde + "'";
  where = where + " AND fecha <= '" + fechaHasta + "'";
  if (codPago && !codPago.isEmpty() != "")
    where = where + " AND codpago = '" + codPago + "'";
  if (codDivisa && !codDivisa.isEmpty())
    where = where + " AND coddivisa = '" + codDivisa + "'";
  if (codSerie && !codSerie.isEmpty())
    where = where + " AND codserie = '" + codSerie + "'";
  if (codEjercicio && !codEjercicio.isEmpty())
    where = where + " AND codejercicio = '" + codEjercicio + "'";
  return where;
}

function oficial_filtrarTabla()
{
  var filtro = this.iface.filtroTabla();
  var cur = this.cursor();
  if (filtro != cur.mainFilter())
    cur.setMainFilter(filtro);
  return true;
}

function oficial_filtroTabla()
{
  var filtro = "";
  var codEjercicio = flfactppal.iface.pub_ejercicioActual();
  if (codEjercicio) {
    filtro = "codejercicio='" + codEjercicio + "'";
  }
  return filtro;
}

function oficial_tbnAbrirCerrar_clicked()
{
  var util: FLUtil;
  var cursor: FLSqlCursor = this.cursor();

  var idAlbaran: Number = cursor.valueBuffer("idalbaran");
  if (!idAlbaran) {
    MessageBox.warning(util.translate("scripts", "No hay ning�n albar�n seleccionado"), MessageBox.Ok, MessageBox.NoButton);
    return;
  }
  var codAlbaran: String = cursor.valueBuffer("codigo");

  var cerrar: Boolean = true;
  var res: Number;
  if (!cursor.isNull("idfactura") && cursor.valueBuffer("idfactura")) {
    MessageBox.warning(util.translate("scripts", "El albar�n ya est� facturado"), MessageBox.Ok, MessageBox.NoButton);
    return;
  }
  var editable: Boolean = cursor.valueBuffer("ptefactura")
  if (editable) {
    res = MessageBox.information(util.translate("scripts", "Se va a cerrar el albar�n %1 y no podr� facturarse.\n�Desea continuar?").arg(codAlbaran), MessageBox.Yes, MessageBox.No);
    if (res != MessageBox.Yes) {
      return;
    }
  } else {
    res = MessageBox.information(util.translate("scripts", "Se va a reabrir el albar�n %1.\n�Desea continuar?").arg(codAlbaran), MessageBox.Yes, MessageBox.No);
    if (res != MessageBox.Yes) {
      return;
    }
  }
  cursor.setUnLock("ptefactura", !editable);
  this.iface.tdbRecords.refresh();
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
