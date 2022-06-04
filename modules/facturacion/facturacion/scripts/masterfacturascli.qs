/***************************************************************************
                 masterfacturascli.qs  -  description
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
  function calculateField(fN: String)
  {
    this.ctx.interna_calculateField(fN);
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
  var pbnAFactura: Object;
  var tbnImprimir: Object;
  var tdbRecords: FLTableDB;
  var curFactura: FLSqlCursor;
  var curLineaFactura: FLSqlCursor;

  function oficial(context)
  {
    interna(context);
  }
  function imprimir(codFactura)
  {
    return this.ctx.oficial_imprimir(codFactura);
  }
  function dameParamInforme(idFactura)
  {
    return this.ctx.oficial_dameParamInforme(idFactura);
  }
  function commonCalculateField(fN: String, cursor: FLSqlCursor)
  {
    return this.ctx.oficial_commonCalculateField(fN, cursor);
  }
  function asociarAFactura()
  {
    return this.ctx.oficial_asociarAFactura();
  }
  function whereAgrupacion(curAgrupar: FLSqlCursor)
  {
    return this.ctx.oficial_whereAgrupacion(curAgrupar);
  }
  function copiarFactura_clicked()
  {
    return this.ctx.oficial_copiarFactura_clicked();
  }
  function copiarFactura(curFactura: FLSqlCursor)
  {
    return this.ctx.oficial_copiarFactura(curFactura);
  }
  function copiadatosFactura(curFactura: FLSqlCursor)
  {
    return this.ctx.oficial_copiadatosFactura(curFactura);
  }
  function copiaCampoFactura(nombreCampo, cursor, campoInformado)
  {
    return this.ctx.oficial_copiaCampoFactura(nombreCampo, cursor, campoInformado);
  }
  function copiaLineasFactura(idFacturaOrigen: Number, idFacturaDestino: Number)
  {
    return this.ctx.oficial_copiaLineasFactura(idFacturaOrigen, idFacturaDestino);
  }
  function copiaHijosFactura(idFacturaOrigen, idFacturaDestino)
  {
    return this.ctx.oficial_copiaHijosFactura(idFacturaOrigen, idFacturaDestino);
  }
  function copiaLineaFactura(curLineaFactura: FLSqlCursor, idFactura: Number)
  {
    return this.ctx.oficial_copiaLineaFactura(curLineaFactura, idFactura);
  }
  function copiaCampoLineaFactura(nombreCampo, cursor, campoInformado)
  {
    return this.ctx.oficial_copiaCampoLineaFactura(nombreCampo, cursor, campoInformado);
  }
  function totalesFactura()
  {
    return this.ctx.oficial_totalesFactura();
  }
  //  function copiadatosLineaFactura(curLineaFactura:FLSqlCursor) {
  //    return this.ctx.oficial_copiadatosLineaFactura(curLineaFactura);
  //  }
  function dameDatosAgrupacionAlbaranes(curAgruparAlbaranes: FLSqlCursor)
  {
    return this.ctx.oficial_dameDatosAgrupacionAlbaranes(curAgruparAlbaranes);
  }
  function filtrarTabla()
  {
    return this.ctx.oficial_filtrarTabla();
  }
  function filtroTabla()
  {
    return this.ctx.oficial_filtroTabla();
  }
  function damePorDtoCabecera(cursor) {
		return 0; /// Función a sobrecargar
}
	function groupByAgrupacion(cursor) {
		return this.ctx.oficial_groupByAgrupacion(cursor);
  }
	function selectAgrupacion(cursor) {
		return this.ctx.oficial_selectAgrupacion(cursor);
  }
	function masWhereFactura(qryAgruparAlbaranes) {
		return this.ctx.oficial_masWhereFactura(qryAgruparAlbaranes);
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
  function pub_whereAgrupacion(curAgrupar: FLSqlCursor)
  {
    return this.whereAgrupacion(curAgrupar);
  }
  function pub_commonCalculateField(fN: String, cursor: FLSqlCursor)
  {
    return this.commonCalculateField(fN, cursor);
  }
  function pub_imprimir(codFactura: String)
  {
    return this.imprimir(codFactura);
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
Este es el formulario maestro de facturas a cliente.
\end */
function interna_init()
{
  this.iface.pbnAFactura = this.child("pbnAsociarAFactura");
  this.iface.tbnImprimir = this.child("toolButtonPrint");
  this.iface.tdbRecords = this.child("tableDBRecords");

  connect(this.iface.tbnImprimir, "clicked()", this, "iface.imprimir");
  connect(this.iface.pbnAFactura, "clicked()", this, "iface.asociarAFactura()");
  connect(this.child("toolButtonCopy"), "clicked()", this, "iface.copiarFactura_clicked()");

}

function interna_calculateField(fN: String)
{
  return this.iface.commonCalculateField(fN, this.cursor());
  /** \C
  El --código-- se construye como la concatenación de --codserie--, --codejercicio-- y --numero--
  \end */
  /** \C
  El --total-- es el --neto-- menos el --totalirpf-- más el --totaliva-- más el --totalrecargo-- más el --recfinanciero--
  \end */
  /** \C
  El --totaleuros-- es el producto del --total-- por la --tasaconv--
  \end */
  /** \C
  El --neto-- es la suma del pvp total de las líneas de factura
  \end */
  /** \C
  El --totaliva-- es la suma del iva correspondiente a las líneas de factura
  \end */
  /** \C
  El --totarecargo-- es la suma del recargo correspondiente a las líneas de factura
  \end */
  /** \C
  El --coddir-- corresponde a la dirección del cliente marcada como dirección de facturación
  \end */
  /** \C
  El --irpf-- es el asociado al --codserie-- del albarán
  \end */
  /** \C
  El --totalirpf-- es el producto del --irpf-- por el --neto--
  \end */
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
Al pulsar el botón imprimir se lanzará el informe correspondiente a la factura seleccionada (en caso de que el módulo de informes esté cargado)
\end */
function oficial_imprimir(codFactura)
{
  var util = new FLUtil;
  if (sys.isLoadedModule("flfactinfo")) {
    var idFactura, codigo;
    if (codFactura) {
      codigo = codFactura;
      idFactura = util.sqlSelect("facturascli", "idfactura", "codigo = '" + codigo + "'");
    } else {
      var cursor = this.cursor();
      if (!cursor.isValid()) {
        return;
      }
      codigo = this.cursor().valueBuffer("codigo");
      idFactura = this.cursor().valueBuffer("idfactura");
    }
    if (!idFactura) {
      return;
    }

    var oParam = this.iface.dameParamInforme(idFactura);
    if (!oParam) {
      return;
    }
    var curImprimir = new FLSqlCursor("i_facturascli");
    curImprimir.setModeAccess(curImprimir.Insert);
    curImprimir.refreshBuffer();
    curImprimir.setValueBuffer("descripcion", "temp");
    curImprimir.setValueBuffer("d_facturascli_codigo", codigo);
    curImprimir.setValueBuffer("h_facturascli_codigo", codigo);
    flfactinfo.iface.pub_lanzaInforme(curImprimir, oParam);
  } else {
    flfactppal.iface.pub_msgNoDisponible("Informes");
  }
}

function oficial_dameParamInforme(idFactura)
{
  var util = new FLUtil;
  var oParam = flfactinfo.iface.pub_dameParamInforme();
  oParam.nombreInforme = "i_facturascli";

  // Descomentar para ver ejemplo JasperReports
  // Necesario plugin AQReports
  // oParam.nombreInforme = "i_facturascli_jasper";
  // oParam.nombreReport = "i_facturascli_jasper.jrxml";

  var numCopias = util.sqlSelect("facturascli f INNER JOIN clientes c ON c.codcliente = f.codcliente",
                                 "c.copiasfactura", "f.idfactura = " + idFactura, "facturascli,clientes");
  oParam.numCopias = numCopias ? numCopias : 1;
  return oParam;
}

function oficial_commonCalculateField(fN: String, cursor: FLSqlCursor)
{
	var _i = this.iface;
  var util = new FLUtil();
  var valor;

  if (fN == "codigo")
    valor = flfacturac.iface.pub_construirCodigo(cursor.valueBuffer("codserie"), cursor.valueBuffer("codejercicio"), cursor.valueBuffer("numero"));

  switch (fN) {
    case "total": {
      var neto = parseFloat(cursor.valueBuffer("neto"));
      var totalIrpf = parseFloat(cursor.valueBuffer("totalirpf"));
      var totalIva = parseFloat(cursor.valueBuffer("totaliva"));
      var totalRecargo = parseFloat(cursor.valueBuffer("totalrecargo"));
      var recFinanciero = (parseFloat(cursor.valueBuffer("recfinanciero")) * neto) / 100;
      recFinanciero = parseFloat(util.roundFieldValue(recFinanciero, "facturascli", "total"));
      valor = neto - totalIrpf + totalIva + totalRecargo + recFinanciero;
      valor = parseFloat(util.roundFieldValue(valor, "facturascli", "total"));
      break;
    }
    case "lblComision": {
      valor = (parseFloat(cursor.valueBuffer("porcomision")) * (parseFloat(cursor.valueBuffer("neto")))) / 100;
      valor = parseFloat(util.roundFieldValue(valor, "facturascli", "total"));
      break;
    }
    case "lblRecFinanciero": {
      valor = (parseFloat(cursor.valueBuffer("recfinanciero")) * (parseFloat(cursor.valueBuffer("neto")))) / 100;
      valor = parseFloat(util.roundFieldValue(valor, "facturascli", "total"));
      break;
    }
    case "totaleuros": {
      var total = parseFloat(cursor.valueBuffer("total"));
      var tasaConv = parseFloat(cursor.valueBuffer("tasaconv"));
      valor = total * tasaConv;
      valor = parseFloat(util.roundFieldValue(valor, "facturascli", "totaleuros"));
      valor = parseFloat(util.roundFieldValue(valor, "facturascli", "totaleuros"));
      break;
    }
    case "neto": {
      valor = util.sqlSelect("lineasfacturascli", "SUM(pvptotal)", "idfactura = " + cursor.valueBuffer("idfactura"));
      valor = parseFloat(util.roundFieldValue(valor, "facturascli", "neto"));
      break;
    }
    case "totaliva": {
      var porDto = _i.damePorDtoCabecera(cursor);
      var codCli = cursor.valueBuffer("codcliente");
      var regIva = flfacturac.iface.pub_regimenIVACliente(cursor);
      if (regIva == "U.E." || regIva == "Exento" || regIva == "Exportaciones") {
        valor = 0;
        break;
      }
      valor = util.sqlSelect("lineasfacturascli", "SUM((pvptotal * iva * (100 - " + porDto + ")) / 100 / 100)", "idfactura = " + cursor.valueBuffer("idfactura"));
      valor = parseFloat(util.roundFieldValue(valor, "facturascli", "totaliva"));
      break;
    }
    case "totalrecargo": {
      var porDto = _i.damePorDtoCabecera(cursor);
      var codCli = cursor.valueBuffer("codcliente");
      var regIva = flfacturac.iface.pub_regimenIVACliente(cursor);
      if (regIva == "U.E." || regIva == "Exento" || regIva == "Exportaciones") {
        valor = 0;
        break;
      }
      valor = util.sqlSelect("lineasfacturascli", "SUM((pvptotal * recargo * (100 - " + porDto + ")) / 100 / 100)", "idfactura = " + cursor.valueBuffer("idfactura"));
      valor = parseFloat(util.roundFieldValue(valor, "facturascli", "totalrecargo"));
      break;
    }
    case "coddir": {
      valor = util.sqlSelect("dirclientes", "id", "codcliente = '" + cursor.valueBuffer("codcliente") +  "' AND domfacturacion = 'true'");
      if (!valor) {
        valor = "";
      }
      break;
    }
    case "irpf": {
      valor = util.sqlSelect("series", "irpf", "codserie = '" + cursor.valueBuffer("codserie") + "'");
      break;
    }
    case "totalirpf": {
      valor = util.sqlSelect("lineasfacturascli", "SUM((pvptotal * irpf) / 100)", "idfactura = " + cursor.valueBuffer("idfactura"));
      //      valor = (parseFloat(cursor.valueBuffer("irpf")) * (parseFloat(cursor.valueBuffer("neto")))) / 100;
      valor = parseFloat(util.roundFieldValue(valor, "facturascli", "totalirpf"));
      break;
    }
    case "provincia": {
      valor = util.sqlSelect("dirclientes", "provincia", "id = " + cursor.valueBuffer("coddir"));
      if (!valor)
        valor = cursor.valueBuffer("provincia");
      break;
    }
    case "codpais": {
      valor = util.sqlSelect("dirclientes", "codpais", "id = " + cursor.valueBuffer("coddir"));
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

function oficial_masWhereFactura(qryAgruparAlbaranes)
{
	var where = "";

    var codCliente = qryAgruparAlbaranes.value(0);
    var codAlmacen = qryAgruparAlbaranes.value(1);
      
    if (codCliente && codCliente != "")
       where += " AND codcliente = '" + codCliente + "'";
    if (codAlmacen && codAlmacen != "")
       where += " AND codalmacen = '" + codAlmacen + "'";

	return where;
}

/** \C
Al pulsar el botón de asociar a factura se abre la ventana de agrupar albaranes de cliente
\end */
function oficial_asociarAFactura()
{
  debug("oficial_asociarAFactura");
  var util = new FLUtil;
	var _i = this.iface;
  var f = new FLFormSearchDB("agruparalbaranescli");
  var cursor = f.cursor();
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
  var acpt = f.exec("codejercicio");
  debug("acpt " + acpt);
  if (acpt) {
    cursor.commitBuffer();
    var curAgruparAlbaranes = new FLSqlCursor("agruparalbaranescli");
    curAgruparAlbaranes.select();
    if (curAgruparAlbaranes.first()) {
      where = this.iface.whereAgrupacion(curAgruparAlbaranes);
			groupBy = _i.groupByAgrupacion(curAgruparAlbaranes);
			select = _i.selectAgrupacion(curAgruparAlbaranes);
      var excepciones = curAgruparAlbaranes.valueBuffer("excepciones");
      if (!excepciones.isEmpty())
        where += " AND idalbaran NOT IN (" + excepciones + ")";

      var qryAgruparAlbaranes = new FLSqlQuery;
      qryAgruparAlbaranes.setTablesList("albaranescli");
      qryAgruparAlbaranes.setSelect("codcliente,codalmacen" + select);
      qryAgruparAlbaranes.setFrom("albaranescli");
      qryAgruparAlbaranes.setWhere(where + " AND codcliente IS NOT NULL AND codalmacen IS NOT NULL GROUP BY codcliente,codalmacen" + groupBy);
      qryAgruparAlbaranes.setForwardOnly(true);

      if (!qryAgruparAlbaranes.exec())
        return;
      debug(qryAgruparAlbaranes.sql());
      var totalClientes = qryAgruparAlbaranes.size();
      util.createProgressDialog(util.translate("scripts", "Generando facturas"), totalClientes);
      util.setProgress(1);
      var j = 0;

      var curAlbaran = new FLSqlCursor("albaranescli");
      var whereFactura: String;
      var datosAgrupacion = [];
      while (qryAgruparAlbaranes.next()) {

        whereFactura = where + _i.masWhereFactura(qryAgruparAlbaranes);

        curAlbaran.transaction(false);
        try {
          curAlbaran.select(whereFactura);
          if (!curAlbaran.first()) {
            curAlbaran.rollback();
            util.destroyProgressDialog();
            debug("return 1");
            return;
          }

          datosAgrupacion = this.iface.dameDatosAgrupacionAlbaranes(curAgruparAlbaranes);
          if (formalbaranescli.iface.pub_generarFactura(whereFactura, curAlbaran, datosAgrupacion)) {
            curAlbaran.commit();
          } else {
            MessageBox.warning(util.translate("scripts", "Falló la inserción de la factura correspondiente al cliente: ") + codCliente, MessageBox.Ok, MessageBox.NoButton);
            curAlbaran.rollback();
            util.destroyProgressDialog();
            return;
          }
        } catch (e) {
          curAlbaran.rollback();
          MessageBox.critical(util.translate("scripts", "Error al generar la factura:") + e, MessageBox.Ok, MessageBox.NoButton);
        }
        util.setProgress(++j);
      }
      util.setProgress(totalClientes);
      util.destroyProgressDialog();
    }

    f.close();
    this.iface.tdbRecords.refresh();
  }
  debug("FIN");
}

/** \D
Construye un array con los datos de la factura a generar especificados en el formulario de agrupación de albaranes
@param curAgruparAlbaranes: Cursor de la tabla agruparalbaranescli que contiene los valores
@return Array
\end */
function oficial_dameDatosAgrupacionAlbaranes(curAgruparAlbaranes: FLSqlCursor)
{
  var res = [];
  res["fecha"] = curAgruparAlbaranes.valueBuffer("fecha");
  res["hora"] = curAgruparAlbaranes.valueBuffer("hora");
  return res;
}

/** \D
Construye la sentencia WHERE de la consulta que buscará los albaranes a agrupar
@param curAgrupar: Cursor de la tabla agruparalbaranescli que contiene los valores de los criterios de búsqueda
@return Sentencia where
\end */
function oficial_whereAgrupacion(curAgrupar: FLSqlCursor)
{
  var codCliente = curAgrupar.valueBuffer("codcliente");
  var nombreCliente = curAgrupar.valueBuffer("nombrecliente");
  var cifNif = curAgrupar.valueBuffer("cifnif");
  var codAlmacen = curAgrupar.valueBuffer("codalmacen");
  var codPago = curAgrupar.valueBuffer("codpago");
  var codDivisa = curAgrupar.valueBuffer("coddivisa");
  var codSerie = curAgrupar.valueBuffer("codserie");
  var codEjercicio = curAgrupar.valueBuffer("codejercicio");
  var fechaDesde = curAgrupar.valueBuffer("fechadesde");
  var fechaHasta = curAgrupar.valueBuffer("fechahasta");
  var where = "albaranescli.ptefactura = 'true'";
  if (codCliente && !codCliente.isEmpty())
    where += " AND albaranescli.codcliente = '" + codCliente + "'";
  if (cifNif && !cifNif.isEmpty())
    where += " AND albaranescli.cifnif = '" + cifNif + "'";
  if (codAlmacen && !codAlmacen.isEmpty())
    where = where + " AND albaranescli.codalmacen = '" + codAlmacen + "'";
  where = where + " AND albaranescli.fecha >= '" + fechaDesde + "'";
  where = where + " AND albaranescli.fecha <= '" + fechaHasta + "'";
  if (codPago && !codPago.isEmpty())
    where = where + " AND albaranescli.codpago = '" + codPago + "'";
  if (codDivisa && !codDivisa.isEmpty())
    where = where + " AND albaranescli.coddivisa = '" + codDivisa + "'";
  if (codSerie && !codSerie.isEmpty())
    where = where + " AND albaranescli.codserie = '" + codSerie + "'";
  if (codEjercicio && !codEjercicio.isEmpty())
    where = where + " AND albaranescli.codejercicio = '" + codEjercicio + "'";
  return where;
}

function oficial_copiarFactura_clicked()
{
  var util = new FLUtil;
  var cursor = this.cursor();

  var idFactura;
  cursor.transaction(false);
  try {
    idFactura = this.iface.copiarFactura(cursor);
    if (idFactura) {
      cursor.commit();
    } else {
      cursor.rollback();
      return
    }
  } catch (e) {
    cursor.rollback();
    MessageBox.critical(util.translate("scripts", "Hubo un error en la copia de la factura:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
    return;
  }
  this.iface.tdbRecords.refresh();

  var codFactura = util.sqlSelect("facturascli", "codigo", "idfactura = " + idFactura);
  MessageBox.information(util.translate("scripts", "Se ha generado la factura %1").arg(codFactura), MessageBox.Ok, MessageBox.NoButton);
}
function oficial_copiarFactura(curFactura: FLSqlCursor)
{
  var util = new FLUtil();

  if (!this.iface.curFactura)
    this.iface.curFactura = new FLSqlCursor("facturascli");

  util.createProgressDialog(util.translate("scripts", "Copiando Factura...."), 3);
  var progreso = 0;

  this.iface.curFactura.setModeAccess(this.iface.curFactura.Insert);
  this.iface.curFactura.refreshBuffer();

  progreso = 1;
  util.setProgress(progreso);

  if (!this.iface.copiadatosFactura(curFactura)) {
    util.destroyProgressDialog();
    return false;
  }

  if (!this.iface.curFactura.commitBuffer()) {
    util.destroyProgressDialog();
    return false;
  }

  var idFactura = this.iface.curFactura.valueBuffer("idfactura");

  progreso = 2;
  util.setProgress(progreso);

  if (!this.iface.copiaLineasFactura(curFactura.valueBuffer("idfactura"), idFactura)) {
    util.destroyProgressDialog();
    return false;
  }

  this.iface.curFactura.select("idfactura = " + idFactura);
  if (this.iface.curFactura.first()) {
    this.iface.curFactura.setModeAccess(this.iface.curFactura.Edit);
    this.iface.curFactura.refreshBuffer();

    progreso = 3;
    util.setProgress(progreso);

    if (!this.iface.totalesFactura()) {
      util.destroyProgressDialog();
      return false;
    }
    if (this.iface.curFactura.commitBuffer() == false) {
      util.destroyProgressDialog();
      return false;
    }
  }
  util.destroyProgressDialog();
  return idFactura;
}

// function oficial_copiadatosFactura(curFactura:FLSqlCursor)
// {
//  var util= new FLUtil();
//  var fecha:String;
//  var hora:String;
//  if (curFactura.action() == "facturascli") {
//    var hoy= new Date();
//    fecha = hoy.toString();
//    hora = hoy.toString().right(8);
//  } else {
//    fecha = curFactura.valueBuffer("fecha");
//    hora = curFactura.valueBuffer("hora");
//  }
//  var codEjercicio= curFactura.valueBuffer("codejercicio");
//  var datosDoc= flfacturac.iface.pub_datosDocFacturacion(fecha, codEjercicio, "facturascli");
//  if (!datosDoc.ok)
//    return false;
//  if (datosDoc.modificaciones == true) {
//    codEjercicio = datosDoc.codEjercicio;
//    fecha = datosDoc.fecha;
//  }
//
//  var codDir= util.sqlSelect("dirclientes", "id", "codcliente = '" + curFactura.valueBuffer("codcliente") + "' AND domfacturacion = 'true'");
//  with (this.iface.curFactura) {
//    setValueBuffer("codserie", curFactura.valueBuffer("codserie"));
//    setValueBuffer("codejercicio", codEjercicio);
//    setValueBuffer("irpf", curFactura.valueBuffer("irpf"));
//    setValueBuffer("fecha", fecha);
//    setValueBuffer("hora", hora);
//    setValueBuffer("codagente", curFactura.valueBuffer("codagente"));
//    setValueBuffer("porcomision", curFactura.valueBuffer("porcomision"));
//    setValueBuffer("codalmacen", curFactura.valueBuffer("codalmacen"));
//    setValueBuffer("codpago", curFactura.valueBuffer("codpago"));
//    setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
//    setValueBuffer("tasaconv", curFactura.valueBuffer("tasaconv"));
//    setValueBuffer("codcliente", curFactura.valueBuffer("codcliente"));
//    setValueBuffer("cifnif", curFactura.valueBuffer("cifnif"));
//    setValueBuffer("nombrecliente", curFactura.valueBuffer("nombrecliente"));
//    if (!codDir) {
//      codDir = curFactura.valueBuffer("coddir")
//      if (codDir == 0) {
//        this.setNull("coddir");
//      } else
//        setValueBuffer("coddir", curFactura.valueBuffer("coddir"));
//        setValueBuffer("direccion", curFactura.valueBuffer("direccion"));
//        setValueBuffer("codpostal", curFactura.valueBuffer("codpostal"));
//        setValueBuffer("ciudad", curFactura.valueBuffer("ciudad"));
//        setValueBuffer("provincia", curFactura.valueBuffer("provincia"));
//        setValueBuffer("apartado", curFactura.valueBuffer("apartado"));
//        setValueBuffer("codpais", curFactura.valueBuffer("codpais"));
//    } else {
//      setValueBuffer("coddir", codDir);
//      setValueBuffer("direccion", util.sqlSelect("dirclientes","direccion","id = " + codDir));
//      setValueBuffer("codpostal", util.sqlSelect("dirclientes","codpostal","id = " + codDir));
//      setValueBuffer("ciudad", util.sqlSelect("dirclientes","ciudad","id = " + codDir));
//      setValueBuffer("provincia", util.sqlSelect("dirclientes","provincia","id = " + codDir));
//      setValueBuffer("apartado", util.sqlSelect("dirclientes","apartado","id = " + codDir));
//      setValueBuffer("codpais", util.sqlSelect("dirclientes","codpais","id = " + codDir));
//    }
//    setValueBuffer("recfinanciero", curFactura.valueBuffer("recfinanciero"));
//    setValueBuffer("automatica", false);
//    setValueBuffer("observaciones", curFactura.valueBuffer("observaciones"));
//    setValueBuffer("editable", true);
//    setValueBuffer("nogenerarasiento", curFactura.valueBuffer("nogenerarasiento"));
//    setNull("idasiento");
//    setValueBuffer("deabono", curFactura.valueBuffer("deabono"));
//    setValueBuffer("idfacturarect", curFactura.valueBuffer("idfacturarect"));
//    setValueBuffer("codigorect", curFactura.valueBuffer("codigorect"));
//    setValueBuffer("tpv", false);
//    if (curFactura.valueBuffer("idpagodevol") != 0)
//      setValueBuffer("idpagodevol", curFactura.valueBuffer("idpagodevol"));
//  }
//  return true;
// }

function oficial_copiadatosFactura(curFactura)
{
  var util = new FLUtil();
  var fecha: String;
  var hora: String;
  if (curFactura.action() == "facturascli") {
    var hoy = new Date();
    fecha = hoy.toString();
    hora = hoy.toString().right(8);
  } else {
    fecha = curFactura.valueBuffer("fecha");
    hora = curFactura.valueBuffer("hora");
  }

  var codEjercicio = curFactura.valueBuffer("codejercicio");
  var datosDoc = flfacturac.iface.pub_datosDocFacturacion(fecha, codEjercicio, "facturascli");
  if (!datosDoc.ok)
    return false;
  if (datosDoc.modificaciones == true) {
    codEjercicio = datosDoc.codEjercicio;
    fecha = datosDoc.fecha;
  }

  with(this.iface.curFactura) {
    setValueBuffer("codejercicio", codEjercicio);
    setValueBuffer("fecha", fecha);
    setValueBuffer("hora", hora);
  }

  var aCamposLinea = util.nombreCampos("facturascli");
  var totalCampos = aCamposLinea[0];

  var campoInformado = [];
  for (var i = 1; i <= totalCampos; i++) {
    campoInformado[aCamposLinea[i]] = false;
  }
  for (var i = 1; i <= totalCampos; i++) {
    if (!this.iface.copiaCampoFactura(aCamposLinea[i], curFactura, campoInformado)) {
      util.destroyProgressDialog();
      return false;
    }
  }

  return true;
}

function oficial_copiaCampoFactura(nombreCampo, cursor, campoInformado)
{
  if (campoInformado[nombreCampo]) {
    return true;
  }
  var nulo = false;

  switch (nombreCampo) {
    case "idfactura":
    case "codejercicio":
    case "fecha":
    case "hora":
    case "numero":
    case "codigo":
    case "editable":
    case "automatica":
    case "tpv": {
      return true;
      break;
    }
    /// Estos valores se totalizan al final de la copia
    case "neto":
    case "total":
    case "totaleuros":
    case "totaliva":
    case "totalrecargo":
    case "totalirpf": {
      valor = 0;
      break;
    }
    case "idasiento": {
      nulo = true;
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
    this.iface.curFactura.setNull(nombreCampo);
  } else {
    this.iface.curFactura.setValueBuffer(nombreCampo, valor);
  }
  campoInformado[nombreCampo] = true;

  return true;
}

function oficial_copiaHijosFactura(idFacturaOrigen, idFacturaDestino)
{
  if (!this.iface.copiaLineasFactura(idFacturaOrigen, idFacturaDestino)) {
    return false;
  }
  return true;
}

function oficial_copiaLineaFactura(curLineaFactura, idFactura)
{
  var util = new FLUtil;
  if (!this.iface.curLineaFactura) {
    this.iface.curLineaFactura = new FLSqlCursor("lineasfacturascli");
  }
  with(this.iface.curLineaFactura) {
    setModeAccess(Insert);
    refreshBuffer();
    setValueBuffer("idfactura", idFactura);
  }

  var aCamposLinea = util.nombreCampos("lineasfacturascli");
  var totalCampos = aCamposLinea[0];

  var campoInformado = [];
  for (var i = 1; i <= totalCampos; i++) {
    campoInformado[aCamposLinea[i]] = false;
  }
  for (var i = 1; i <= totalCampos; i++) {
    if (!this.iface.copiaCampoLineaFactura(aCamposLinea[i], curLineaFactura, campoInformado)) {
      return false;
    }
  }

  //  if (!this.iface.copiadatosLineaFactura(curLineaFactura))
  //    return false;

  if (!this.iface.curLineaFactura.commitBuffer()) {
    return false;
  }

  return this.iface.curLineaFactura.valueBuffer("idlinea");
}

function oficial_copiaCampoLineaFactura(nombreCampo, cursor, campoInformado)
{
  if (campoInformado[nombreCampo]) {
    return true;
  }
  var nulo = false;

  switch (nombreCampo) {
    case "idfactura":
    case "idlinea":
    case "idalbaran": {
      return true;
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
    this.iface.curLineaFactura.setNull(nombreCampo);
  } else {
    this.iface.curLineaFactura.setValueBuffer(nombreCampo, valor);
  }
  campoInformado[nombreCampo] = true;

  return true;
}

function oficial_copiaLineasFactura(idFacturaOrigen: Number, idFacturaDestino: Number)
{
  var curLineaFactura = new FLSqlCursor("lineasfacturascli");
  curLineaFactura.select("idfactura = " + idFacturaOrigen);

  while (curLineaFactura.next()) {
    curLineaFactura.setModeAccess(curLineaFactura.Browse);
    curLineaFactura.refreshBuffer();
    if (!this.iface.copiaLineaFactura(curLineaFactura, idFacturaDestino))
      return false;
  }
  return true;
}

// function oficial_copiaLineaFactura(curLineaFactura:FLSqlCursor, idFactura:Number)
// {
//  if (!this.iface.curLineaFactura)
//    this.iface.curLineaFactura = new FLSqlCursor("lineasfacturascli");
//
//  with (this.iface.curLineaFactura) {
//    setModeAccess(Insert);
//    refreshBuffer();
//    setValueBuffer("idfactura", idFactura);
//  }
//
//  if (!this.iface.copiadatosLineaFactura(curLineaFactura))
//    return false;
//
//  if (!this.iface.curLineaFactura.commitBuffer())
//      return false;
//
//  return this.iface.curLineaFactura.valueBuffer("idlinea");
// }

// function oficial_copiadatosLineaFactura(curLineaFactura:FLSqlCursor)
// {
//  with (this.iface.curLineaFactura) {
//    setValueBuffer("referencia", curLineaFactura.valueBuffer("referencia"));
//    setValueBuffer("descripcion", curLineaFactura.valueBuffer("descripcion"));
//    setValueBuffer("pvpunitario", curLineaFactura.valueBuffer("pvpunitario"));
//    setValueBuffer("pvpsindto", curLineaFactura.valueBuffer("pvpsindto"));
//    setValueBuffer("cantidad", curLineaFactura.valueBuffer("cantidad"));
//    setValueBuffer("pvptotal", curLineaFactura.valueBuffer("pvptotal"));
//    setValueBuffer("codimpuesto", curLineaFactura.valueBuffer("codimpuesto"));
//    setValueBuffer("irpf", curLineaFactura.valueBuffer("irpf"));
//    setValueBuffer("iva", curLineaFactura.valueBuffer("iva"));
//    setValueBuffer("recargo", curLineaFactura.valueBuffer("recargo"));
//    setValueBuffer("dtolineal", curLineaFactura.valueBuffer("dtolineal"));
//    setValueBuffer("dtopor", curLineaFactura.valueBuffer("dtopor"));
//  }
//  return true;
// }

function oficial_totalesFactura()
{
  with(this.iface.curFactura) {
    setValueBuffer("neto", formfacturascli.iface.pub_commonCalculateField("neto", this));
    setValueBuffer("totaliva", formfacturascli.iface.pub_commonCalculateField("totaliva", this));
    setValueBuffer("totalrecargo", formfacturascli.iface.pub_commonCalculateField("totalrecargo", this));
    setValueBuffer("totalirpf", formfacturascli.iface.pub_commonCalculateField("totalirpf", this));
    setValueBuffer("total", formfacturascli.iface.pub_commonCalculateField("total", this));
    setValueBuffer("totaleuros", formfacturascli.iface.pub_commonCalculateField("totaleuros", this));
  }
  return true;
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
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
