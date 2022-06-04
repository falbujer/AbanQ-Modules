/***************************************************************************
                 flfactinfo.qs  -  description
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
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna
{
  var visor_: FLReportViewer;
  var variosIvas_: Boolean;
  var acumulados = []; // Acumulados de valores numéricos en el informe
  var cuentaAcum = []; // Almacena cuántos valores se han acumulado en cada índice del array acumulados
  var ultIdDocPagina: String;
  var paginaActual: Number;
	var diaInv_;
	var esProforma_;
  function oficial(context)
  {
    interna(context);
  }
  function datosPieFactura(nodo: FLDomNode, campo: String)
  {
    return this.ctx.oficial_datosPieFactura(nodo, campo);
  }
  function crearInforme(nombreInforme: String)
  {
    return this.ctx.oficial_crearInforme(nombreInforme);
  }
  function activaProforma(activar) {
		return this.ctx.oficial_activaProforma(activar);
	}
	function labelProforma(nodo, campo) {
		return this.ctx.oficial_labelProforma(nodo, campo);
	}
  function lanzarInforme(cursor: FLSqlCursor, nombreInforme: String, orderBy: String, groupBy: String,
                         etiquetas: Boolean, impDirecta: Boolean, whereFijo: String, nombreReport: String,
                         numCopias: Number, impresora: String, pdf: Boolean)
  {
    return this.ctx.oficial_lanzarInforme(cursor, nombreInforme, orderBy, groupBy, etiquetas, impDirecta, whereFijo, nombreReport, numCopias, impresora, pdf);
  }
  function lanzaInforme(cursor, oParams)
  {
    return this.ctx.oficial_lanzaInforme(cursor, oParams);
  }
  function ejecutarInformeJasper(q, params, e)
  {
    return this.ctx.oficial_ejecutarInformeJasper(q, params, e);
  }
  function dameParamInforme()
  {
    return this.ctx.oficial_dameParamInforme();
  }
  function seleccionEtiquetaInicial()
  {
    return this.ctx.oficial_seleccionEtiquetaInicial();
  }
  function establecerConsulta(cursor, nombreConsulta, orderBy, groupBy, whereFijo)
  {
    return this.ctx.oficial_establecerConsulta(cursor, nombreConsulta, orderBy, groupBy, whereFijo);
  }
  function estableceConsulta(cursor, oParam)
  {
    return this.ctx.oficial_estableceConsulta(cursor, oParam);
  }
  function obtenerSigno(s: String)
  {
    return this.ctx.oficial_obtenerSigno(s);
  }
  function fieldName(s: String)
  {
    return this.ctx.oficial_fieldName(s);
  }
  function obtenerAcumulado(nodo: FLDomNode, campo: String)
  {
    return this.ctx.oficial_obtenerAcumulado(nodo, campo);
  }
  function acumularValor(nodo: FLDomNode, campo: String)
  {
    return this.ctx.oficial_acumularValor(nodo, campo);
  }
  function restaurarAcumulado(nodo: FLDomNode, campo: String)
  {
    return this.ctx.oficial_restaurarAcumulado(nodo, campo);
  }
  function logo(nodo: FLDomNode, campo: String)
  {
    return this.ctx.oficial_logo(nodo, campo);
  }
  function porIVA(nodo: FLDomNode, campo: String)
  {
    return this.ctx.oficial_porIVA(nodo, campo);
  }
  function porRecargo(nodo, campo)
  {
    return this.ctx.oficial_porRecargo(nodo, campo);
  }
  function desgloseIva(nodo: FLDomNode, campo: String)
  {
    return this.ctx.oficial_desgloseIva(nodo, campo);
  }
  function desgloseBaseImponible(nodo: FLDomNode, campo: String)
  {
    return this.ctx.oficial_desgloseBaseImponible(nodo, campo);
  }
  function desgloseRecargo(nodo: FLDomNode, campo: String)
  {
    return this.ctx.oficial_desgloseRecargo(nodo, campo);
  }
  function desgloseTotal(nodo: FLDomNode, campo: String)
  {
    return this.ctx.oficial_desgloseTotal(nodo, campo);
  }
  function vencimiento(nodo: FLDomNode, campo: String)
  {
    return this.ctx.oficial_vencimiento(nodo, campo);
  }
  function reemplazar(cadena: String, patronOrigen: String, patronDestino: String)
  {
    return this.ctx.oficial_reemplazar(cadena, patronOrigen, patronDestino);
  }
  function cuentaFacturaCli(nodo: FLDomNode, campo: String)
  {
    return this.ctx.oficial_cuentaFacturaCli(nodo, campo);
  }
  function valorIRPF(nodo: FLDomNode, campo: String)
  {
    return this.ctx.oficial_valorIRPF(nodo, campo);
  }
  function numPagina(nodo: FLDomNode, campo: String)
  {
    return this.ctx.oficial_numPagina(nodo, campo);
  }
  function aplicarCriterio(tabla: String, campo: String, valor: String, signo: String)
  {
    return this.ctx.oficial_aplicarCriterio(tabla, campo, valor, signo);
  }
  function ampliarWhere(nombreConsulta: String)
  {
    return this.ctx.oficial_ampliarWhere(nombreConsulta);
  }
  function dibujarGrafico(xmlDatos: FLDomDocument): Picture {
    return this.ctx.oficial_dibujarGrafico(xmlDatos);
  }
  function dibujarGrafico2DBarras(xmlDatos: FLDomDocument): Picture {
    return this.ctx.oficial_dibujarGrafico2DBarras(xmlDatos);
  }
  function dibujarGrafico2DMapaProvEs(xmlDatos: FLDomDocument): Picture {
    return this.ctx.oficial_dibujarGrafico2DMapaProvEs(xmlDatos);
  }
  function dibujarGrafico2DMapaPaisesEu(xmlDatos: FLDomDocument): Picture {
    return this.ctx.oficial_dibujarGrafico2DMapaPaisesEu(xmlDatos);
  }
  function formatearValor(valor: String, formatValor: String)
  {
    return this.ctx.oficial_formatearValor(valor, formatValor);
  }
  function dameColor(color: String): Color {
    return this.ctx.oficial_dameColor(color);
  }
  function dameFuente(family: String, size: Number): Font {
    return this.ctx.oficial_dameFuente(family, size);
  }
  function mostrarInformeVisor(visor: FLReportViewer)
  {
    return this.ctx.oficial_mostrarInformeVisor(visor);
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
  function pub_lanzarInforme(cursor: FLSqlCursor, nombreInforme: String, orderBy: String,
                             groupBy: String, etiquetas: Boolean, impDirecta: Boolean, whereFijo: String,
                             nombreReport: String, numCopias: Number, impresora: String, pdf: Boolean)
  {
    return this.lanzarInforme(cursor, nombreInforme, orderBy, groupBy, etiquetas, impDirecta,
                              whereFijo, nombreReport, numCopias, impresora, pdf);
  }
  function pub_datosPieFactura(nodo: FLDomNode, campo: String)
  {
    return this.datosPieFactura(nodo, campo);
  }
  function pub_logo(nodo: FLDomNode, campo: String)
  {
    return this.logo(nodo, campo);
  }
  function pub_porIVA(nodo: FLDomNode, campo: String)
  {
    return this.porIVA(nodo, campo);
  }
  function pub_desgloseIva(nodo: FLDomNode, campo: String)
  {
    return this.desgloseIva(nodo, campo);
  }
  function pub_desgloseBaseImponible(nodo: FLDomNode, campo: String)
  {
    return this.desgloseBaseImponible(nodo, campo);
  }
  function pub_desgloseRecargo(nodo: FLDomNode, campo: String)
  {
    return this.desgloseRecargo(nodo, campo);
  }
  function pub_desgloseTotal(nodo: FLDomNode, campo: String)
  {
    return this.desgloseTotal(nodo, campo);
  }
  function pub_valorIRPF(nodo: FLDomNode, campo: String)
  {
    return this.valorIRPF(nodo, campo);
  }
  function pub_establecerConsulta(cursor, nombreConsulta, orderBy, groupBy, whereFijo)
  {
    return this.establecerConsulta(cursor, nombreConsulta, orderBy, groupBy, whereFijo);
  }
  function pub_dibujarGrafico(xmlDatos: FLDomDocument): Picture {
    return this.dibujarGrafico(xmlDatos);
  }
  function pub_mostrarInformeVisor(visor: FLReportViewer)
  {
    return this.mostrarInformeVisor(visor);
  }
  function pub_lanzaInforme(cursor, oParams)
  {
    return this.lanzaInforme(cursor, oParams);
  }
  function pub_dameParamInforme()
  {
    return this.dameParamInforme();
  }
  function pub_activaProforma(activar) {
		return this.activaProforma(activar);
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
function interna_init()
{
  var util = new FLUtil;
  AQUtil.writeSettingEntry("kugar/banner", "");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D
Obtiene los datos de totalización de pie de factura
@param  nodo: Nodo XML con los datos de la línea que se va a mostrar en el informe
@param  campo: Campo a mostrar
@return Valor del campo
\end */
function oficial_datosPieFactura(nodo: FLDomNode, campo: String)
{
  var util = new FLUtil();
  var sCampo = campo.toString();
  var tablaFacturas: String;
  var tablaIva: String;
  if (sCampo.charAt(0) == "P"
      && sCampo.charAt(1) == "_") {
    tablaFacturas = "facturasprov";
    tablaIva = "lineasivafactprov";
    campo = "";
    for (var i = 2; i < sCampo.length; i++)
      campo += sCampo.charAt(i);
  } else {
    tablaFacturas = "facturascli";
    tablaIva = "lineasivafactcli";
  }

  var idFactura = nodo.attributeValue(tablaFacturas + ".idfactura");
  var util = new FLUtil;
  var res: Number;
  if (campo == "BI4") {
    res = AQUtil.sqlSelect(tablaIva, "neto", "idfactura = " + idFactura + " AND iva = 4");
  } else if (campo == "BI7") {
    res = AQUtil.sqlSelect(tablaIva, "neto", "idfactura = " + idFactura + " AND (iva = 7 OR iva = 8)");
  } else if (campo == "BI16") {
    res = AQUtil.sqlSelect(tablaIva, "neto", "idfactura = " + idFactura + " AND (iva = 16 OR iva = 18)");
  } else if (campo == "IVA4") {
    res = AQUtil.sqlSelect(tablaIva, "totaliva", "idfactura = " + idFactura + " AND iva = 4");
  } else if (campo == "IVA7") {
    res = AQUtil.sqlSelect(tablaIva, "totaliva", "idfactura = " + idFactura + " AND (iva = 7 OR iva = 8)");
  } else if (campo == "IVA16") {
    res = AQUtil.sqlSelect(tablaIva, "totaliva", "idfactura = " + idFactura + " AND (iva = 16 OR iva = 18)");
  } else if (campo == "POR_RE4") {
    res = AQUtil.sqlSelect(tablaIva, "recargo", "idfactura = " + idFactura + " AND iva = 4");
    if (res && parseFloat(res) != 0)
      res += "%";
  } else if (campo == "POR_RE7") {
    res = AQUtil.sqlSelect(tablaIva, "recargo", "idfactura = " + idFactura + " AND (iva = 7 OR iva = 8)");
    if (res && parseFloat(res) != 0)
      res += "%";
  } else if (campo == "POR_RE16") {
    res = AQUtil.sqlSelect(tablaIva, "recargo", "idfactura = " + idFactura + " AND (iva = 16 OR iva = 18)");
    if (res && parseFloat(res) != 0)
      res += "%";
  } else if (campo == "RE4") {
    res = AQUtil.sqlSelect(tablaIva, "totalrecargo", "idfactura = " + idFactura + " AND iva = 4");
    if (parseFloat(res) != 0)
      res = AQUtil.buildNumber(res, "f", 2);
  } else if (campo == "RE7") {
    res = AQUtil.sqlSelect(tablaIva, "totalrecargo", "idfactura = " + idFactura + " AND (iva = 7 OR iva = 8)");
    if (parseFloat(res) != 0)
      res = AQUtil.buildNumber(res, "f", 2);
  } else if (campo == "RE16") {
    res = AQUtil.sqlSelect(tablaIva, "totalrecargo", "idfactura = " + idFactura + " AND (iva = 16 OR iva = 18)");
    if (parseFloat(res) != 0)
      res = AQUtil.buildNumber(res, "f", 2);
  } else if (campo == "T4") {
    res = AQUtil.sqlSelect(tablaIva, "totallinea", "idfactura = " + idFactura + " AND iva = 4");
  } else if (campo == "T7") {
    res = AQUtil.sqlSelect(tablaIva, "totallinea", "idfactura = " + idFactura + " AND (iva = 7 OR iva = 8)");
  } else if (campo == "T16") {
    res = AQUtil.sqlSelect(tablaIva, "totallinea", "idfactura = " + idFactura + " AND (iva = 16 OR iva = 18)");
  }
  if (parseFloat(res) == 0 || !res)
    res = "";
  return res;
}

/** \D
Crea el informe especificado
@param  nombreinforme: Nombre del informe a crear
\end */
function oficial_crearInforme(nombreInforme: String)
{
  if (this.iface.establecerCriteriosBusqueda(nombreInforme) == true);
  this.iface.lanzarInforme(nombreInforme);
}

/** \D Establece la fila y columna de la primera etiqueta a imprimir para los informes de etiquetas
\end */
function oficial_seleccionEtiquetaInicial()
{
  var etiquetaInicial = [];
  etiquetaInicial["fila"] = 0;
  etiquetaInicial["col"] = 0;
  var util = new FLUtil;
  var dialog = new Dialog;
  dialog.caption = sys.translate("Elegir fila y columna a imprimir");
  dialog.okButtonText = sys.translate("Aceptar");
  dialog.cancelButtonText = sys.translate("Cancelar");

  var text = new Label;
  text.text = sys.translate("Ha seleccionado un informe de etiquetas,\nelija la fila y la columna a imprimir:");
  dialog.add(text);

  var spbNumColum = new SpinBox;
  spbNumColum.label = sys.translate("Columnas");
  spbNumColum.minimum = 1;
  spbNumColum.maximum = 30;
  dialog.add(spbNumColum);

  var spbNumFila = new SpinBox;
  spbNumFila.label = sys.translate("Filas");
  spbNumFila.minimum = 1;
  spbNumFila.maximum = 30;
  dialog.add(spbNumFila);

  if (!dialog.exec()) {
		return false;
	}
	etiquetaInicial["fila"] = spbNumFila.value;
	etiquetaInicial["col"] = spbNumColum.value;
  
  return etiquetaInicial;
}

/** \D Establece la consulta del informe, creando el where a partir de los campos del cursor
@param  cursor: Cursor posicionado en un registro de criterios de búsqueda
@param  nombreConsulta: Nombre del fichero con la descripción de la consulta
@param  orderBy: Cláusula Order By
@param  groupBy: Cláusula Group By
@param  whereFijo: Cláusula Where que se añade al construido a partir de los campos del cursor
@return consulta o false si hay error
\end */
function oficial_establecerConsulta(cursor: FLSqlCursor, nombreConsulta: String, orderBy: String, groupBy: String, whereFijo: String)
{
  var util = new FLUtil();
  var q = new FLSqlQuery(nombreConsulta);
  var fieldList = AQUtil.nombreCampos(cursor.table());
  var cuenta = parseFloat(fieldList[0]);

  var signo: String;
  var fN: String;
  var valor: String;
  var primerCriterio = false;
  var where = "";
  var criterio: String;
  for (var i = 1; i <= cuenta; i++) {
    if (cursor.isNull(fieldList[i])) {
      continue;
    }
    signo = this.iface.obtenerSigno(fieldList[i]);
    if (signo != "") {
      fN = this.iface.fieldName(fieldList[i]);
      valor = cursor.valueBuffer(fieldList[i]);
      criterio = this.iface.aplicarCriterio(cursor.table(), fN, valor, signo);
      if (criterio && criterio != "") {
        if (primerCriterio == true) {
          where += " AND ";
        }
        where += criterio;
        primerCriterio = true;
      }
    }
  }

  if (whereFijo && whereFijo != "") {
    if (where == "")
      where = whereFijo;
    else
      where = whereFijo + " AND (" + where + ")";
  }

  var ampliarWhere = this.iface.ampliarWhere(nombreConsulta);
  if (ampliarWhere)
    if (where)
      where += " AND " + ampliarWhere;
    else
      where += ampliarWhere;

  if (groupBy && groupBy != "") {
    if (where == "")
      where = "1 = 1";
    where += " GROUP BY " + groupBy;
  }

  q.setWhere(where);

  if (orderBy)
    q.setOrderBy(orderBy);

  return q;
}

function oficial_estableceConsulta(cursor, oParams)
{
	var nombreInforme = oParams.nombreInforme;
  var orderBy = oParams.orderBy;
  var groupBy = oParams.groupBy;
  var etiquetas = oParams.etiquetas;
  var impDirecta = oParams.impDirecta;
  var whereFijo = oParams.whereFijo;
  var nombreReport = oParams.nombreReport;
  var numCopias = oParams.numCopias;
  var datosPdf = oParams.datosPdf;
	var limit = oParams.limit;
	var nombreCx = oParams.nombreCx;

	var nombreConsulta = nombreInforme;
	
  var util = new FLUtil();
  var q = new FLSqlQuery(nombreConsulta, nombreCx);
  var fieldList = AQUtil.nombreCampos(cursor.table());
  var cuenta = parseFloat(fieldList[0]);

  var signo: String;
  var fN: String;
  var valor: String;
  var primerCriterio = false;
  var where = "";
  var criterio: String;
  for (var i = 1; i <= cuenta; i++) {
    if (cursor.isNull(fieldList[i])) {
      continue;
    }
    signo = this.iface.obtenerSigno(fieldList[i]);
    if (signo != "") {
      fN = this.iface.fieldName(fieldList[i]);
      valor = cursor.valueBuffer(fieldList[i]);
      criterio = this.iface.aplicarCriterio(cursor.table(), fN, valor, signo);
      if (criterio && criterio != "") {
        if (primerCriterio == true) {
          where += " AND ";
        }
        where += criterio;
        primerCriterio = true;
      }
    }
  }

  if (whereFijo && whereFijo != "") {
    if (where == "")
      where = whereFijo;
    else
      where = whereFijo + " AND (" + where + ")";
  }

  var ampliarWhere = this.iface.ampliarWhere(nombreConsulta);
  if (ampliarWhere)
    if (where)
      where += " AND " + ampliarWhere;
    else
      where += ampliarWhere;

	where = where == "" ? "1 = 1" : where;

	if (groupBy && groupBy != "") {
    where += " GROUP BY " + groupBy;
  }
  
  var hayLimit = (limit && !isNaN(limit) && limit > 0);
	if (orderBy && orderBy != "") {
		if (hayLimit) {
			where += " ORDER BY " + orderBy;
		} else {
			q.setOrderBy(orderBy);
		}
  }
  if (hayLimit) {
    where += " LIMIT " + limit;
  }
  q.setWhere(where);
	
	return q;
}

/** Construye un criterio de búsqueda para la consulta
@param  Tabla: Tabla de criterios
@param  Campo: Campo de criterios
@param  Valor: Valor del criterio
@param  Signo: Signo del criterio
@return Criterio (típicamente tabla.campo signo criterio. Ej facturascli.codcliente = '000001')
\end */
function oficial_aplicarCriterio(tabla: String, campo: String, valor: String, signo: String)
{
  var criterio = "";
  switch (tabla) {
    case "i_reciboscli": {
      switch (campo) {
        case "reciboscli.estado": {
          switch (valor) {
            case "Pendiente": {
              criterio = "reciboscli.estado IN ('Emitido', 'Devuelto')";
              break;
            }
          }
          break;
        }
      }
      break;
    }
    case "i_pedidoscli": {
      switch (campo) {
        case "pedidoscli.servido": {
          switch (valor) {
            case "Pendiente": {
              criterio = "pedidoscli.servido IN ('No','Parcial')";
            }
          }
          break;
        }
      }
      break;
    }
    case "i_pedidosprov": {
      switch (campo) {
        case "pedidosprov.servido": {
          switch (valor) {
            case "Pendiente": {
              criterio = "pedidosprov.servido IN ('No','Parcial')";
            }
          }
          break;
        }
      }
      break;
    }
  }

  if (criterio == "") {
    if (valor == "Sí")
      valor = 1;
    if (valor == "No")
      valor = 0;
    if (valor == "Todos")
      valor = "";
    if (!valor.toString().isEmpty()) {
      criterio = campo + " " + signo + " '" + valor + "' ";
    }
  }
  return criterio;
}
/** \D
Lanza un informe
@param  cursor: Cursor con los criterios de búsqueda para la consulta base del informe
@param  nombreinforme: Nombre del informe
@param  orderBy: Cláusula ORDER BY de la consulta base
@param  groupBy: Cláusula GROUP BY de la consulta base
@param  etiquetas: Indicador de si se trata de un informe de etiquetas
@param  impDirecta: Indicador para imprimir directaemnte el informe, sin previsualización
@param  whereFijo: Sentencia where que debe preceder a la sentencia where calculada por la función
\end */
function oficial_lanzarInforme(cursor: FLSqlCursor, nombreInforme: String, orderBy: String,
                               groupBy: String, etiquetas: Boolean, impDirecta: Boolean,
                               whereFijo: String, nombreReport: String, numCopias: Number,
                               datosPdf: Array)
{
  var oParam = this.iface.dameParamInforme();
  oParam.nombreInforme = nombreInforme;
  oParam.orderBy = orderBy;
  oParam.groupBy = groupBy;
  oParam.etiquetas = etiquetas;
  oParam.impDirecta = impDirecta;
  oParam.whereFijo = whereFijo;
  oParam.nombreReport = nombreReport;
  oParam.numCopias = numCopias;
	if (datosPdf && typeof(datosPdf) == "string") { 
		oParam.datosPdf = new Object;
		oParam.datosPdf.pdf = true;
		oParam.datosPdf.ruta = datosPdf;
	} else {
		oParam.datosPdf = datosPdf;
	}


  this.iface.lanzaInforme(cursor, oParam);
}

function oficial_dameParamInforme()
{
  var oParam = new Object();
  oParam.nombreInforme = undefined;
  oParam.orderBy = undefined;
  oParam.groupBy = undefined;
	oParam.limit = undefined;
  oParam.etiquetas = undefined;
  oParam.impDirecta = undefined;
  oParam.whereFijo = undefined;
  oParam.nombreReport = undefined;
  oParam.numCopias = undefined;
  oParam.datosPdf = undefined;
  oParam.codIdioma = undefined;
	oParam.kutPrevio = undefined;
	oParam.append = false;
	oParam.display = true;
	oParam.pageBreak = false;
	oParam.rptViewer = undefined;
	oParam.printerName = undefined;
	oParam.colorMode = undefined;
	oParam.nombreCx = undefined;
	
  return oParam;
}

function oficial_lanzaInforme(cursor, oParams)
{
  var nombreInforme = oParams.nombreInforme;
  var orderBy = oParams.orderBy;
  var groupBy = oParams.groupBy;
  var etiquetas = oParams.etiquetas;
  var impDirecta = oParams.impDirecta;
  var whereFijo = oParams.whereFijo;
  var nombreReport = oParams.nombreReport;
  var numCopias = oParams.numCopias;
  var datosPdf = oParams.datosPdf;
	var limit = oParams.limit;

  var _i = this.iface;
  var etiquetaInicial = [];
  if (etiquetas == true) {
    etiquetaInicial = _i.seleccionEtiquetaInicial();
		if(!etiquetaInicial){
			sys.warnMsgBox(sys.translate("La impresión ha sido cancelada por el usuario."));
			return false;
		}
  } else {
    etiquetaInicial["fila"] = 0;
    etiquetaInicial["col"] = 0;
  }

  _i.ultIdDocPagina = "";
  var q = _i.estableceConsulta(cursor, oParams);
  debug("------ CONSULTA ------- " + q.sql());
  if (!q.exec()) {
		sys.errorMsgBox(sys.translate("Falló la consulta"));
    return false;
  } else {
    if (!q.first()) {
      sys.warnMsgBox(sys.translate("No hay registros que cumplan los criterios de búsqueda establecidos"));
      return false;
    }
  }

  var tipoReport = "";
  if (!nombreReport || nombreReport == "") {
    nombreReport = nombreInforme;
  }

  var pos = nombreReport.findRev(".");
  var extension = "";
  if (pos && pos != 0) {
    extension = nombreReport.right(nombreReport.length - pos - 1);
    nombreReport = nombreReport.left(pos);
    oParams.nombreReport = nombreReport;
  }
  if (oParams.codIdioma != undefined) {
    sys.setMultiLang(true, oParams.codIdioma);
  }

  if (extension == "jxml" || extension == "jrxml") {
    _i.ejecutarInformeJasper(q, oParams, etiquetaInicial);
  } else {
		var rptViewer = oParams.rptViewer ? oParams.rptViewer : new FLReportViewer();
		var flags = (oParams.display ? rptViewer.Display : 0) | (oParams.append ? rptViewer.Append : 0) | (oParams.pageBreak ? rptViewer.PageBreak : 0);
    rptViewer.setReportData(q);
    rptViewer.setReportTemplate(nombreReport);
    rptViewer.renderReport(etiquetaInicial.fila, etiquetaInicial.col, flags);
		if (!oParams.display) {
			return true;
		}
		if (oParams.colorMode) {
			if (oParams.colorMode == AQS.PrintGrayScale) {
				rptViewer.setColorMode(rpt.PrintGrayScale);
			} else if (oParams.colorMode == AQS.PrintColor) {
				rptViewer.setColorMode(rpt.PrintColor);
			}
		}
		if (oParams.printerName) {
			rptViewer.setPrinterName(oParams.printerName);
		}
    if (datosPdf && datosPdf.pdf == true) {
      rptViewer.printReportToPDF(datosPdf.ruta);
    } else {
      if (numCopias)
        rptViewer.setNumCopies(numCopias);
      if (impDirecta)
        rptViewer.printReport();
      else
        rptViewer.exec();
    }
  }
  if (oParams.codIdioma != undefined) {
    sys.setMultiLang(false);
  }
  return true;
}

function oficial_ejecutarInformeJasper(q, params, e)
{
  var n = params.nombreInforme;
  var datosPdf = params.datosPdf;

  var jpEngine = new FLJasperEngine;
	var nodo;
	if (params.kutPrevio) {
		var kuEngine = new FLReportEngine;
		kuEngine.setReportData(q);             
		kuEngine.setReportTemplate(n + "_jasper");
		kuEngine.renderReport(0, 0, true).deleteLater();      
		nodo = kuEngine.reportData();
	} else {
		nodo = sys.toXmlReportData(q);
	}

	//File.write(System.getenv("HOME") + "/tmp/" + n + "_q.xml",
	//           sys.fromUnicode(nodo.toString(0), "utf8"));
	
	jpEngine.setReportData(nodo);
	jpEngine.setReportTemplate(n);

  if (datosPdf && datosPdf.pdf) {
    jpEngine.exportReportToFile(datosPdf.ruta, "PDF");
    return;
  }

  var kuViewer = new FLReportViewer;
  kuViewer.setReportPages(jpEngine.printReportToPages());
  kuViewer.setCurrentPage(0);
  kuViewer.updateDisplay();
  kuViewer.disableSlotsPrintExports();

  connect(kuViewer, "requestUpdateReport()", jpEngine, "updateReportPages()");
  connect(kuViewer.child("export_PDF"), "activated()", jpEngine, "exportReportToPdf()");
  connect(kuViewer.child("export_CSV"), "activated()", jpEngine, "exportReportToCsv()");

  if (AQUtil.getOS() == "MACX") {
    sys.AQGlobalFunctions.set("printReportMac",  function() {
      var diag = new Dialog;
      diag.title = AQUtil.translate("scripts", "Imprimir informe");
      diag.okButtonText = AQUtil.translate("scripts", "Imprimir");
      diag.cancelButtonText = AQUtil.translate("scripts", "Cancelar");
      diag.width = 300;

      var printers = new ComboBox;
      printers.label = AQUtil.translate("scripts", "Impresoras");
      printers.editable = false;
      printers.itemList = jpEngine.printServiceNames();
      diag.add(printers);

      var copies = new SpinBox;
      copies.label = AQUtil.translate("scripts", "Copias");
      copies.value = 1;
      diag.add(copies);

      if (diag.exec())
        jpEngine.printReport(printers.currentItem, copies.value);
    });
    sys.AQGlobalFunctions.mapConnect(kuViewer.child("imprimir"), "activated()", "printReportMac");
  } else {
    connect(kuViewer.child("imprimir"), "activated()", jpEngine, "printReport()");
  }

  //File.write(System.getenv("HOME") + "/tmp/" + n + ".xml",
  //           sys.fromUnicode(jpEngine.reportData().toString(0), "utf8"));

  this.iface.mostrarInformeVisor(kuViewer);
}

/** \D
Obtiene el operador lógico a aplicar en la cláusula where de la consulta a partir de los primeros caracteres del parámetro
@param  s: Nombre del campo que contiene un criterio de búsqueda
@return Operador lógico a aplicar
\end */
function oficial_obtenerSigno(s: String)
{
  if (s.toString().charAt(1) == "_") {
    switch (s.toString().charAt(0)) {
      case "d": {
        return ">=";
      }
      case "h": {
        return "<=";
      }
      case "i": {
        return "=";
      }
    }
  }
  return  "";
}

/** \D
Obtiene el nombre del campo de la cadena s desde su segunda posición. Sustituye '_' por '.', dos '_" seguidos indica que realmente es '_"
@param  s: Nombre del campo que contiene un criterio de búsqueda
@return Nombre procesado
\end */
function oficial_fieldName(s: String)
{
  var fN = "";
  var c: String;
  for (var i = 2; (s.toString().charAt(i)); i++) {
    c = s.toString().charAt(i);
    if (c == "_")
      if (s.toString().charAt(i + 1) == "_") {
        fN += "_";
        i++;
      } else
        fN += "."
              else
                fN += s.toString().charAt(i);
  }
  return fN;
}

/** \D Devuelve el valor del acumulado para el la variable indicada
@param  campo: Identificador del acumulado a devolver
*/
function oficial_obtenerAcumulado(nodo: FLDomNode, campo: String)
{
  return this.iface.acumulados[campo];
}

/** \D Acumula el valor del registro actual del informe
@param  campo: String con dos valores separados por '/':
  1. Identificador del acumulado a devolver
  2. Nombre del campo de la consulta del informe cuyo valor hay que acumular
*/
function oficial_acumularValor(nodo: FLDomNode, campo: String)
{
  var campos = campo.split("/");
  var valor = parseFloat(campos[1]);
  if (isNaN(valor))
    valor = parseFloat(nodo.attributeValue(campos[1]));

  if (!this.iface.acumulados[campos[0]]) {
    this.iface.acumulados[campos[0]] = valor;
    this.iface.cuentaAcum[campos[0]] = 1;
  } else {
    this.iface.acumulados[campos[0]] += valor;
    this.iface.cuentaAcum[campos[0]]++;
  }
  return "0";
}

/** \D Restaura la variable del acumulado
@param  campo: Identificador del acumulado a restaurar
*/
function oficial_restaurarAcumulado(nodo: FLDomNode, campo: String)
{
  this.iface.acumulados[campo] = 0;
  this.iface.cuentaAcum[campo] = 0;

  return "0";
}

/** \D
Obtiene el xpm del logo de la empresa
@return xpm del logo
*/
function oficial_logo(nodo: FLDomNode, campo: String)
{
  var util = new FLUtil;
  return AQUtil.sqlSelect("empresa", "logo", "1 = 1");
}

function oficial_porIVA(nodo: FLDomNode, campo: String)
{
  var util = new FLUtil;
  var idDocumento: String;
  var tablaPadre: String;
  var tabla: String;
  var campoClave: String;
  var porIva: String;
  switch (campo) {
    case "facturacli": {
      tablaPadre = "facturascli";
      tabla = "lineasfacturascli";
      campoClave = "idfactura";
      break;
    }
    case "albarancli": {
      tablaPadre = "albaranescli";
      tabla = "lineasalbaranescli";
      campoClave = "idalbaran";
      break;
    }
    case "pedidocli": {
      tablaPadre = "pedidoscli";
      tabla = "lineaspedidoscli";
      campoClave = "idpedido";
      break;
    }
    case "presupuestocli": {
      tablaPadre = "presupuestoscli";
      tabla = "lineaspresupuestoscli";
      campoClave = "idpresupuesto";
      break;
    }
    case "facturaprov": {
      tablaPadre = "facturasprov";
      tabla = "lineasfacturasprov";
      campoClave = "idfactura";
      break;
    }
    case "albaranprov": {
      tablaPadre = "albaranesprov";
      tabla = "lineasalbaranesprov";
      campoClave = "idalbaran";
      break;
    }
    case "pedidoprov": {
      tablaPadre = "pedidosprov";
      tabla = "lineaspedidosprov";
      campoClave = "idpedido";
      break;
    }
    default: {
      return "I.V.A.";
    }

  }
  idDocumento = nodo.attributeValue(tablaPadre + "." + campoClave);
  this.iface.variosIvas_ = false;
  porIva = parseFloat(AQUtil.sqlSelect(tabla, "iva", campoClave + " = " + idDocumento));
  if (!porIva)
    porIva = 0;

  if (AQUtil.sqlSelect(tabla, campoClave, campoClave + " = " + idDocumento + " AND iva <> " + porIva)) {
    this.iface.variosIvas_ = true;
    porIva = 0;
  }

  if (porIva.toString() == "0") {
    return "I.V.A.";
  } else {
    return "I.V.A. " + porIva.toString() + "%";
  }
}

function oficial_porRecargo(nodo, campo)
{
debug("oficial_porRecargo");
  var util = new FLUtil;
  var idDocumento: String;
  var tablaPadre: String;
  var tabla: String;
  var campoClave: String;
  var porIva: String;
  switch (campo) {
    case "facturacli": {
      tablaPadre = "facturascli";
      tabla = "lineasfacturascli";
      campoClave = "idfactura";
      break;
    }
    case "albarancli": {
      tablaPadre = "albaranescli";
      tabla = "lineasalbaranescli";
      campoClave = "idalbaran";
      break;
    }
    case "pedidocli": {
      tablaPadre = "pedidoscli";
      tabla = "lineaspedidoscli";
      campoClave = "idpedido";
      break;
    }
    case "presupuestocli": {
      tablaPadre = "presupuestoscli";
      tabla = "lineaspresupuestoscli";
      campoClave = "idpresupuesto";
      break;
    }
    case "facturaprov": {
      tablaPadre = "facturasprov";
      tabla = "lineasfacturasprov";
      campoClave = "idfactura";
      break;
    }
    case "albaranprov": {
      tablaPadre = "albaranesprov";
      tabla = "lineasalbaranesprov";
      campoClave = "idalbaran";
      break;
    }
    case "pedidoprov": {
      tablaPadre = "pedidosprov";
      tabla = "lineaspedidosprov";
      campoClave = "idpedido";
      break;
    }
    default: {
      return "R.E.";
    }

  }
  idDocumento = nodo.attributeValue(tablaPadre + "." + campoClave);
  porIva = parseFloat(AQUtil.sqlSelect(tabla, "recargo", campoClave + " = " + idDocumento));
  if (!porIva)
    porIva = 0;

  if (AQUtil.sqlSelect(tabla, campoClave, campoClave + " = " + idDocumento + " AND recargo <> " + porIva)) {
    porIva = 0;
  }

  if (porIva.toString() == "0") {
    return "R.E.";
  } else {
    return "R.E. " + porIva.toString() + "%";
  }
}

function oficial_desgloseIva(nodo: FLDomNode, campo: String)
{
  if (!this.iface.variosIvas_)
    return "";

  var util = new FLUtil;
  var idDocumento: String;
  var tabla: String;
  var campoClave: String;
  switch (campo) {
    case "facturacli": {
      tablaPadre = "facturascli";
      tabla = "lineasivafactcli";
      campoClave = "idfactura";
      break;
    }
    case "facturaprov": {
      tablaPadre = "facturasprov";
      tabla = "lineasivafactprov";
      campoClave = "idfactura";
      break;
    }
  }
  idDocumento = nodo.attributeValue(tablaPadre + "." + campoClave);

  var qryIvas = new FLSqlQuery();
  with(qryIvas) {
    setTablesList(tabla);
    setSelect("totaliva");
    setFrom(tabla);
    setWhere(campoClave + " = " + idDocumento + " ORDER BY iva");
  }
  if (!qryIvas.exec())
    return false;
  var listaIvas = "";
  while (qryIvas.next()) {
    if (listaIvas != "")
      listaIvas += "\n";
    listaIvas += AQUtil.roundFieldValue(qryIvas.value("totaliva"), tabla, "totaliva");
  }
  return listaIvas;
}

function oficial_desgloseBaseImponible(nodo: FLDomNode, campo: String)
{
  if (!this.iface.variosIvas_)
    return "";

  var util = new FLUtil;
  var idDocumento: String;
  var tabla: String;
  var campoClave: String;
  switch (campo) {
    case "facturacli": {
      tablaPadre = "facturascli";
      tabla = "lineasivafactcli";
      campoClave = "idfactura";
      break;
    }
    case "facturaprov": {
      tablaPadre = "facturasprov";
      tabla = "lineasivafactprov";
      campoClave = "idfactura";
      break;
    }
  }
  idDocumento = nodo.attributeValue(tablaPadre + "." + campoClave);

  var qryIvas = new FLSqlQuery();
  with(qryIvas) {
    setTablesList(tabla);
    setSelect("iva, neto");
    setFrom(tabla);
    setWhere(campoClave + " = " + idDocumento + " ORDER BY iva");
  }
  if (!qryIvas.exec())
    return false;
  var listaBases = "";
  while (qryIvas.next()) {
    if (listaBases != "")
      listaBases += "\n";
    listaBases += "I.V.A. " + qryIvas.value("iva") + "%: " + AQUtil.roundFieldValue(qryIvas.value("neto"), tabla, "neto");
  }
  return listaBases;
}

function oficial_desgloseRecargo(nodo: FLDomNode, campo: String)
{
  if (!this.iface.variosIvas_)
    return "";

  var util = new FLUtil;
  var idDocumento: String;
  var tabla: String;
  var campoClave: String;
  switch (campo) {
    case "facturacli": {
      tablaPadre = "facturascli";
      tabla = "lineasivafactcli";
      campoClave = "idfactura";
      break;
    }
    case "facturaprov": {
      tablaPadre = "facturasprov";
      tabla = "lineasivafactprov";
      campoClave = "idfactura";
      break;
    }
  }
  idDocumento = nodo.attributeValue(tablaPadre + "." + campoClave);

  var qryIvas = new FLSqlQuery();
  with(qryIvas) {
    setTablesList(tabla);
    setSelect("totalrecargo");
    setFrom(tabla);
    setWhere(campoClave + " = " + idDocumento + " ORDER BY iva");
  }
  if (!qryIvas.exec())
    return false;
  var listaRecargo = "";
  while (qryIvas.next()) {
    if (listaRecargo != "")
      listaRecargo += "\n";
    if (qryIvas.value("totalrecargo") == 0)
      listaRecargo += " ";
    else
      listaRecargo += AQUtil.roundFieldValue(qryIvas.value("totalrecargo"), tabla, "totalrecargo");
  }
  return listaRecargo;
}
function oficial_desgloseTotal(nodo: FLDomNode, campo: String)
{
  if (!this.iface.variosIvas_)
    return "";

  var util = new FLUtil;
  var idDocumento: String;
  var tabla: String;
  var campoClave: String;
  switch (campo) {
    case "facturacli": {
      tablaPadre = "facturascli";
      tabla = "lineasivafactcli";
      campoClave = "idfactura";
      break;
    }
    case "facturaprov": {
      tablaPadre = "facturasprov";
      tabla = "lineasivafactprov";
      campoClave = "idfactura";
      break;
    }
  }
  idDocumento = nodo.attributeValue(tablaPadre + "." + campoClave);

  var qryIvas = new FLSqlQuery();
  with(qryIvas) {
    setTablesList(tabla);
    setSelect("totallinea");
    setFrom(tabla);
    setWhere(campoClave + " = " + idDocumento + " ORDER BY iva");
  }
  if (!qryIvas.exec())
    return false;
  var listaTotal = "";
  while (qryIvas.next()) {
    if (listaTotal != "")
      listaTotal += "\n";
    listaTotal += AQUtil.roundFieldValue(qryIvas.value("totallinea"), tabla, "totallinea");
  }
  return listaTotal;
}

/** \D
Función para campos calculados que obtiene los vencimientos de una factura de cliente
*/
function oficial_vencimiento(nodo: FLDomNode, campo: String)
{
  var util = new FLUtil();
  if (!sys.isLoadedModule("flfactteso")) {
    var codPago: String;
    var fecha: String;
    if (campo == "reciboscli") {
      codPago = nodo.attributeValue("facturascli.codpago");
      fecha = nodo.attributeValue("facturascli.fecha");
    } else if (campo == "recibosprov") {
      codPago = nodo.attributeValue("facturasprov.codpago");
      fecha = nodo.attributeValue("facturasprov.fecha");
    }

    var qryDias = new FLSqlQuery();
    var vencimientos = "";
    with(qryDias) {
      setTablesList("plazos");
      setSelect("dias");
      setFrom("plazos");
      setWhere("codpago = '" + codPago + "' ORDER BY dias");
    }
    if (!qryDias.exec())
      return "";

    while (qryDias.next()) {
      if (vencimientos != "")
        vencimientos += ", ";
      vencimientos += AQUtil.dateAMDtoDMA(AQUtil.addDays(fecha, qryDias.value(0)));
    }
    var res = this.iface.reemplazar(vencimientos, '-', '/')
              return res;
  }

  var tabla: String;
  var idFactura: FLDomNode;

  if (campo == "reciboscli") {
    tabla = "reciboscli";
    idFactura = nodo.attributeValue("facturascli.idfactura");
  } else if (campo == "recibosprov") {
    tabla = "recibosprov";
    idFactura = nodo.attributeValue("facturasprov.idfactura");
  }

  var qryRecibos = new FLSqlQuery();
  var vencimientos = "";
  with(qryRecibos) {
    setTablesList(tabla);
    setSelect("fechav, importe");
    setFrom(tabla);
    setWhere("idfactura = '" + idFactura + "' ORDER BY fechav");
  }
  if (!qryRecibos.exec())
    return "";

  var fecha: String;
  while (qryRecibos.next()) {
    fecha = AQUtil.dateAMDtoDMA(qryRecibos.value(0));
    if (vencimientos != "")
      vencimientos += "\n";
    vencimientos += this.iface.reemplazar(fecha.substring(0, 10), '-', '/');
    vencimientos += ": " + AQUtil.formatoMiles(AQUtil.roundFieldValue(qryRecibos.value("importe"), "reciboscli", "importe"));
  }
  //var res= this.iface.reemplazar(vencimientos, '-', '/')
  //res = this.iface.reemplazar(res, '.', ',')
  return vencimientos;
}

/** \D
Función para campos calculados que obtiene el número de cuenta corriente de la factura.
En primer lugar se busca si la forma de pago es domiciliada o no.
Si lo es, se busca la cuenta de domiciliación del cliente.
Si no lo es o no se encuentra la del cliente, se busca una cuenta de la forma de pago
*/
function oficial_cuentaFacturaCli(nodo: FLDomNode, campo: String)
{
  var util = new FLUtil;
  var datosCuenta: String;
  var ret: String;
  var codCliente = nodo.attributeValue("facturascli.codcliente");
  var codPago = nodo.attributeValue("facturascli.codpago");
  var domiciliado = AQUtil.sqlSelect("formaspago", "domiciliado", "codpago = '" + codPago + "'");
  var codCuenta: String

  var tipoCuenta: String;

  // Si no hay cliente, se busca la forma de pago
  if (!codCliente)
    tipoCuenta = "formaPago";

  else if (domiciliado)
    tipoCuenta = "domiciliado";
  else
    tipoCuenta = "formaPago";
  if (tipoCuenta == "domiciliado") {
    codCuenta = AQUtil.sqlSelect("clientes", "codcuentadom", "codcliente = '" + codCliente + "'");
    if (codCuenta)
      datosCuenta = flfactppal.iface.pub_ejecutarQry("cuentasbcocli", "ctaentidad,ctaagencia,cuenta", "codcuenta = '" + codCuenta + "'");
  }

  if (!codCuenta) {
    codCuenta = AQUtil.sqlSelect("formaspago", "codcuenta", "codpago = '" + codPago + "'");
    if (!codCuenta)
      return "";
    datosCuenta = flfactppal.iface.pub_ejecutarQry("cuentasbanco", "ctaentidad,ctaagencia,cuenta", "codcuenta = '" + codCuenta + "'");
  }

  if (datosCuenta.result != 1)
    return "";
  var dc = AQUtil.calcularDC(datosCuenta.ctaentidad + datosCuenta.ctaagencia) + AQUtil.calcularDC(datosCuenta.cuenta);
  ret = datosCuenta.ctaentidad + " " + datosCuenta.ctaagencia + " " + dc + " " + datosCuenta.cuenta;
  return ret;
  // Si no hay cliente, se busca la forma de pago
  if (!codCliente) {
    codCuenta = AQUtil.sqlSelect("formaspago", "codcuenta", "codpago = '" + codPago + "'");
    if (!codCuenta)
      return "";
    datosCuenta = flfactppal.iface.pub_ejecutarQry("cuentasbanco", "ctaentidad,ctaagencia,cuenta", "codcuenta = '" + codCuenta + "'");
  }

  else {

    if (domiciliado) {
      codCuenta = AQUtil.sqlSelect("clientes", "codcuentadom", "codcliente = '" + codCliente + "'");
      if (codCuenta)
        datosCuenta = flfactppal.iface.pub_ejecutarQry("cuentasbcocli", "ctaentidad,ctaagencia,cuenta", "codcuenta = '" + codCuenta + "'");
      else {
        codCuenta = AQUtil.sqlSelect("formaspago", "codcuenta", "codpago = '" + codPago + "'");
        if (!codCuenta)
          return "";
        datosCuenta = flfactppal.iface.pub_ejecutarQry("cuentasbcocli", "ctaentidad,ctaagencia,cuenta", "codcuenta = '" + codCuenta + "'");
      }
    }

    else {
      codCuenta = AQUtil.sqlSelect("formaspago", "codcuenta", "codpago = '" + codPago + "'");
      if (!codCuenta)
        return "";
      datosCuenta = flfactppal.iface.pub_ejecutarQry("cuentasbcocli", "ctaentidad,ctaagencia,cuenta", "codcuenta = '" + codCuenta + "'");
    }

  }
  var codCuenta = AQUtil.sqlSelect("clientes", "codcuentadom", "codcliente = '" + codCliente + "'");
  if (codCuenta) {
    datosCuenta = flfactppal.iface.pub_ejecutarQry("cuentasbcocli", "ctaentidad,ctaagencia,cuenta", "codcuenta = '" + codCuenta + "'");
  } else {
    codCuenta = AQUtil.sqlSelect("clientes", "codcuentarem", "codcliente = '" + codCliente + "'");
    if (!codCuenta)
      codCuenta = AQUtil.sqlSelect("formaspago", "codcuenta", "codpago = '" + codPago + "'");
    if (!codCuenta)
      return "";

    datosCuenta = flfactppal.iface.pub_ejecutarQry("cuentasbanco", "ctaentidad,ctaagencia,cuenta", "codcuenta = '" + codCuenta + "'");
  }
  if (datosCuenta.result != 1)
    return "";
  var dc = AQUtil.calcularDC(datosCuenta.ctaentidad + datosCuenta.ctaagencia) + AQUtil.calcularDC(datosCuenta.cuenta);
  ret = datosCuenta.ctaentidad + " " + datosCuenta.ctaagencia + " " + dc + " " + datosCuenta.cuenta;
  return ret;
}
function oficial_valorIRPF(nodo: FLDomNode, campo: String)
{
  var util = new FLUtil();
  debug(campo);

  var partesCampo = campo.split(".");
  if (!partesCampo.length)
    return "";

  var tabla = partesCampo[0];
  var campoClave = partesCampo[1];

  var q = new FLSqlQuery();
  with(q) {
    setTablesList("lineas" + tabla);
    setSelect("distinct irpf");
    setFrom("lineas" + tabla);
    setWhere(campoClave + " = " + nodo.attributeValue(campo));
  }
  if (!q.exec())
    return "";

  if (!q.size())
    return "";

  var valor = nodo.attributeValue(tabla + ".totalirpf");
  valor = AQUtil.formatoMiles(AQUtil.buildNumber(valor, "f", 2));
  if (valor == "0,00")
    return valor;

  if (q.size() > 1)
    return valor;

  q.first();
  return q.value(0) + "%  " + valor;
}
/** Devuelve el número de página, usado en informes de detalle de
facturación para establecer números por documento, no por páginas totales
del informe
*/
function oficial_numPagina(nodo: FLDomNode, campo: String)
{
  var codigo = nodo.attributeValue(campo);

  if (codigo != this.iface.ultIdDocPagina)
    this.iface.paginaActual = 1;
  else
    this.iface.paginaActual++;

  this.iface.ultIdDocPagina = codigo;
  return this.iface.paginaActual;
}
/** \D
Reemplaza en una cadena un carácter por otro
@param  cadena: Cadena a tratar
@param  patronOrigen: Caracter a reemplazar
@param  patronDestino: Caracter que sustituye al origen
@return Cadena tratada
*/
function oficial_reemplazar(cadena: String, patronOrigen: String, patronDestino: String)
{
  var res = "";
  if (cadena != "") {
    for (var i = 0; i < cadena.length; i++) {
      if (cadena.charAt(i) == patronOrigen)
        res += patronDestino;
      else
        res += cadena.charAt(i);
    }
  }
  return res;
}

function oficial_ampliarWhere(nombreConsulta: String)
{
  var where = "";

  switch (nombreConsulta) {

    case "i_pedidosprov":
    case "i_albaranesprov":
    case "i_facturasprov":
      where += "(dirproveedores.direccionppal = true OR dirproveedores.direccion IS NULL)";
      break;
  }

  return where;
}

/** \D
Formato de xmlDatos:
@param  xmlDatos: Xml con los datos necesarios para la generación del gráfico.
@return Picture del gráfico creado
*/

// FORMATO DE xmlDatos:
//
//  <Grafico Tipo='2d_barras' Informe='1' Alto='' Ancho='' MargenDerecho='0' MargenInferior='0' MargenIzquierdo='0' MargenSuperior='0'>
//    <EjeX Min='0' Max='' MarcarCada='1' MargenLabels = '30' MarcarLabels='0'/>
//    <EjeY Min='0' Max='' MarcarCada='1' MargenLabels = '20' MarcarLabels='1'/>
//    <Valores Color='220,220,220'>
//      <Valor x='x1' y='y1' LabelX='Valor1' LabelY=''/>
//      <Valor x='x2' y='y2' LabelX='Valor2' LabelY=''/>
//      <Valor ...

//    </Valores>
//  </Grafico>
function oficial_dibujarGrafico(xmlDatos: FLDomDocument): Picture {
  var pic: Picture;
  var eGrafico = xmlDatos.firstChild().toElement();
  var tipoGrafico = eGrafico.attribute("Tipo");
  switch (tipoGrafico)
  {
    case "2d_barras": {
      pic = this.iface.dibujarGrafico2DBarras(xmlDatos);
      break;
    }
    case "2d_mapaproves": {
      pic = this.iface.dibujarGrafico2DMapaProvEs(xmlDatos);
      break;
    }
    case "2d_mapapaiseseu": {
      pic = this.iface.dibujarGrafico2DMapaPaisesEu(xmlDatos);
      break;
    }
  }
  return pic;
}

function oficial_dameColor(color: String): Color {
  var rgb = new Array;
  if (!color || color == "")
  {
    rgb[0] = 220;
    rgb[1] = 220;
    rgb[2] = 220;
  } else {
    rgb = color.split(",");
  }

  var clr = new Color();
  clr.setRgb(rgb[0], rgb[1], rgb[2]);

  return clr;
}

function oficial_dameFuente(family: String, size: Number): Font {
  var clf = new Font();
  if (!family || family == "")
  {
    family = "Arial";
  }
  if (!size || size == "")
  {
    size = 10;
  }

  clf.pointSize = size;
  clf.family = family;

  return clf;
}

function oficial_dibujarGrafico2DBarras(xmlDatos: FLDomDocument): Picture {
  debug("oficial_dibujarGrafico2DBarras");
  var pic: Picture = new Picture;
  var clr = new Color();
  var clf = new Font();
  pic.begin();

  var eGrafico = xmlDatos.firstChild().toElement();

  var tipoGrafico = eGrafico.attribute("Tipo");
  var esInforme = eGrafico.attribute("Informe");
  var ancho = parseInt(eGrafico.attribute("Ancho"));
  var alto = parseInt(eGrafico.attribute("Alto"));

  var margenSuperior = parseInt(eGrafico.attribute("MargenSuperior"));
  if (isNaN(margenSuperior))
  {
    margenSuperior = 0;
  }
  var margenInferior = parseInt(eGrafico.attribute("MargenInferior"));
  if (isNaN(margenInferior))
  {
    margenInferior = 0;
  }
  var margenIzquierdo = parseInt(eGrafico.attribute("MargenIzquierdo"));
  if (isNaN(margenIzquierdo))
  {
    margenIzquierdo = 0;
  }
  var margenDerecho = parseInt(eGrafico.attribute("MargenDerecho"));
  if (isNaN(margenDerecho))
  {
    margenDerecho = 0;
  }

  var x = [];
  var y = [];

  var family = eGrafico.attribute("FontFamily");
  var size = eGrafico.attribute("FontSize");
  var clf = this.iface.dameFuente(family, size); // FUENTE DE LAS ETIQUETAS EN LOS EJES
  pic.setFont(clf);

  var eEjeX = eGrafico.namedItem("EjeX").toElement();
  var minX = parseFloat(eEjeX.attribute("Min"));
  if (isNaN(minX))
  {
    minX = 0;
  }
  var maxX = parseFloat(eEjeX.attribute("Max"));
  var margenLabelsX = parseFloat(eEjeX.attribute("MargenLabels"));
  if (isNaN(margenLabelsX))
  {
    margenLabelsX = 0;
  }
  var anguloLabelX = parseFloat(eEjeX.attribute("AnguloLabel"));
  if (isNaN(anguloLabelX))
  {
    anguloLabelX = 0;
  }

  var marcarLabelsX = false;
  if (eEjeX.attribute("MarcarLabels") == "true" || eEjeX.attribute("MarcarLabels") == "1")
  {
    marcarLabelsX = true;
  }

  var eEjeY = eGrafico.namedItem("EjeY").toElement();
  var minY = parseFloat(eEjeY.attribute("Min"));
  if (isNaN(minY))
  {
    minY = 0;
  }

  var maxY = parseFloat(eEjeY.attribute("Max"));
  var margenLabelsY = parseFloat(eEjeY.attribute("MargenLabels"));
  if (isNaN(margenLabelsY))
  {
    margenLabelsY = 0;
  }

  var marcarLabelsY = false;
  if (eEjeY.attribute("MarcarLabels") == "true" || eEjeY.attribute("MarcarLabels") == "1")
    marcarLabelsY = true;

  var factorX = (ancho - margenIzquierdo - margenDerecho - margenLabelsY) / (maxX - minX);
  var offGraficoX = margenIzquierdo + margenLabelsY;

  var factorY = (alto - margenSuperior - margenInferior - margenLabelsX) / (maxY - minY);
  var offGraficoY = margenSuperior;

  var fMaxX = ((maxX - minX) * factorX);
  var fMaxY = (maxY - minY) * factorY;

  clr.setRgb(0, 0, 0);
  pic.setPen(clr, 1);  // pic.DotLine );

  pic.drawLine(offGraficoX, parseInt(offGraficoY) + parseInt(fMaxY), parseInt(offGraficoX) + parseInt(fMaxX), parseInt(offGraficoY) + parseInt(fMaxY));
  pic.drawLine(offGraficoX, parseInt(offGraficoY) + parseInt(fMaxY), offGraficoX, offGraficoY);

  // PINTANDO EJE X
  var marcarCadaX = parseFloat(eEjeX.attribute("MarcarCada"));
  if (!isNaN(marcarCadaX) && marcarCadaX > 0)
  {
    var fMarcarCadaX = marcarCadaX * factorX;
    var fX: Number;
    for (var x = minX; x <= maxX; x += marcarCadaX) {
      fX = (x * factorX);
      fX = fX - (minX * factorX);
      pic.drawLine(parseInt(offGraficoX) + parseInt(fX), parseInt(offGraficoY) + parseInt(fMaxY), parseInt(offGraficoX) + parseInt(fX), parseInt(offGraficoY) + parseInt(fMaxY) + 5);
      if (marcarLabelsX) {
        pic.drawText(parseInt(offGraficoX) + parseInt(fX), parseFloat(fMaxY) + parseFloat(margenLabelsX), parseInt(x).toString());
      }
    }
  }

  // PINTANDO EJE Y
  var marcarCadaY = parseFloat(eEjeY.attribute("MarcarCada"));
  var colorLineaMarcaY = eEjeY.attribute("ColorLineaMarca");
  var estiloLineaMarcaY = parseInt(eEjeY.attribute("EstiloLineaMarca"));
  if (!estiloLineaMarcaY || isNaN(estiloLineaMarcaY))
  {
    estiloLineaMarcaY = 1;
  }
  var clrLineaMarcaY: Color;
  if (colorLineaMarcaY && colorLineaMarcaY != "")
  {
    clrLineaMarcaY = this.iface.dameColor(colorLineaMarcaY);
  } else {
    clrLineaMarcaY = false;
  }
  if (!isNaN(marcarCadaY) && marcarCadaY > 0)
  {
    var fMarcarCadaY = marcarCadaY * factorY;
    var fY: Number;
    var totalMarcas = Math.ceil((maxY - minY) / marcarCadaY);
    for (var y = minY; y < (maxY + marcarCadaY); y += marcarCadaY) {
      fY = y * factorY - 1;
      fY = parseFloat(fMaxY) - fY + (minY * factorY);
      pic.drawLine(parseInt(offGraficoX), parseInt(offGraficoY) + parseInt(fY), parseInt(offGraficoX) - 5, parseInt(offGraficoY) + parseInt(fY));
      if (clrLineaMarcaY && y > minY) {
        pic.setPen(clrLineaMarcaY, 1, estiloLineaMarcaY);
        pic.drawLine(parseInt(offGraficoX), parseInt(offGraficoY) + parseInt(fY), parseInt(offGraficoX) + parseInt(fMaxX), parseInt(offGraficoY) + parseInt(fY));
        pic.setPen(clr, 1, 1);
      }
      if (marcarLabelsY) {
        pic.drawText(parseInt(margenIzquierdo), parseInt(offGraficoY) + parseInt(fY), parseInt(y).toString());
      }
    }
  }

  // PINTAR BARRAS
  var valores = eGrafico.namedItem("Valores").toElement();

  var separacion = factorX * 5 / 100 // SEPARACION ENTRE BARRAS
                   var colorBarras = valores.attribute("Color");
  var clrBarras = this.iface.dameColor(colorBarras); // COLOR BARRAS
  var nodos = valores.toElement().elementsByTagName("Valor");
  var valor: FLDomElement;
  for (var i = 0; i < nodos.length(); i++)
  {
    valor = nodos.item(i).toElement();
    var x = (parseFloat(offGraficoX) + (parseFloat(valor.attribute("X")) * parseFloat(factorX)) + 1) - (minX * factorX);
    var anchoRect = (factorX - separacion);
    var y = ((parseFloat(fMaxY) - (parseFloat(valor.attribute("Y")) * parseFloat(factorY))) + parseFloat(offGraficoY)) + (minY * factorY);
    var labelX = valor.attribute("LabelX");
    var labelY = valor.attribute("LabelY");
    var altoRect = (parseFloat(valor.attribute("Y")) * parseFloat(factorY));
    pic.fillRect(x, y, anchoRect, altoRect, clrBarras);

    if (labelX && labelX != "") {
      debug("Rotando1 " + parseInt(x).toString());
      if (anguloLabelX != 0) {
        //        pic.savePainter();
        //        pic.translate(x - (factorX / 2) - margenLabelsX, parseFloat(fMaxY) + parseFloat(margenLabelsX));
        //        pic.rotate(anguloLabelX * -1);
        //        var r = new Rect(0, 0, margenLabelsX, margenLabelsX);
        //        var maxLetras= 10;
        //        pic.drawText(r, 0, labelX, maxLetras);
        //        pic.restorePainter();
        //        pic.drawLine((x + (factorX / 2)), parseFloat(fMaxY) + parseFloat(offGraficoY), (x + (factorX / 2) - margenLabelsX), parseFloat(fMaxY) + parseFloat(offGraficoY) + parseFloat(margenLabelsX));
        pic.savePainter();
        pic.translate(x + factorX, parseFloat(fMaxY) + parseFloat(offGraficoY));
        pic.rotate(anguloLabelX);
        var r = new Rect(0, 0, -margenLabelsX, margenLabelsX);
        var maxLetras = 10;
        //        pic.drawText(r, 0, labelX, maxLetras);
        pic.drawText((-1 * margenLabelsX), 0, labelX, maxLetras);
        pic.drawLine(0, 0, -margenLabelsX, 0)
        pic.restorePainter();
      } else {
        pic.drawText(x, parseFloat(fMaxY) + parseFloat(margenLabelsX), labelX);
      }
    }

    if (labelY && labelY != "") {
      pic.drawText(parseInt(margenIzquierdo), y, labelY);
    }
  }

  //pic.save("/home/lorena/picture.svg","svg");
  return pic;
}

function oficial_dibujarGrafico2DMapaProvEs(xmlDatos: FLDomDocument): Picture {
  var util = new FLUtil;
  var eGrafico = xmlDatos.firstChild().toElement();

  var mapa = new Picture();
  var pic = new Picture();
  var clr = new Color();
  var clrValor = new Color();

  pic.begin();

  //  var contenido= AQUtil.sqlSelect("i_ficheros", "contenido", "nombre = 'i_provincias_es.svg'");
  //  if (!contenido) {
  //    MessageBox.warning(sys.translate("No tiene cargado el fichero i_provincias_es.svg.\nEste fichero es necesario para representar el gráfico de provincias."), MessageBox.Ok, MessageBox.NoButton);
  //    return false;
  //  }
  //  File.write("i_provincias_es.svg", contenido);
  //  mapa.load( "i_provincias_es.svg", "svg" );
  //  mapa.load( "/home/arodriguez/tmp/maceflor/MapaProvincias4.svg", "svg" );

  var provincias = [];
  // [x,396-y]
  /* ALAVA*/
  provincias["01"] = [210, 43];
  /*ALBACETE*/
  provincias["02"] = [230, 230];
  /*ALICANTE*/
  provincias["03"] = [290, 250];
  /*ALMERIA*/
  provincias["04"] = [225, 315];
  /*ASTURIAS*/
  provincias["33"] = [91, 21];
  /*AVILA*/
  provincias["05"] = [125, 151];
  /*BADAJOZ*/
  provincias["06"] = [78, 240];
  /*BALEARES*/
  provincias["07"] = [415, 218];
  /*BARCELONA*/
  provincias["08"] = [380, 100];
  /*BURGOS*/
  provincias["09"] = [170, 71];
  /*CACERES*/
  provincias["10"] = [75, 187];
  /*CADIZ*/
  provincias["11"] = [85, 340];
  /*CANTABRIA*/
  provincias["39"] = [150, 27];
  /*CASTELLON*/
  provincias["12"] = [314, 165];
  /*CIUDAD REAL*/
  provincias["13"] = [153, 227];
  /*CORDOBA*/
  provincias["14"] = [121, 264];
  /*LA CORUÑA*/
  provincias["15"] = [0, 10];
  /*CUENCA*/
  provincias["16"] = [224, 181];
  /*GERONA*/
  provincias["17"] = [405, 64];
  /*GRANADA*/
  provincias["18"] = [177, 304];
  /*GUADALAJARA*/
  provincias["19"] = [210, 137];
  /*GUIPUZCOA*/
  provincias["20"] = [250, 20];
  /*HUELVA*/
  provincias["21"] = [45, 280];
  /*HUESCA*/
  provincias["22"] = [295, 75];
  /*JAEN*/
  provincias["23"] = [180, 266];
  /*LEON*/
  provincias["24"] = [83, 54];
  /*LERIDA*/
  provincias["25"] = [343, 75];
  /*LUGO*/
  provincias["27"] = [45, 33];
  /*MADRID*/
  provincias["28"] = [165, 153];
  /*MALAGA*/
  provincias["29"] = [137, 330];
  /*MURCIA*/
  provincias["30"] = [255, 278];
  /*NAVARRA*/
  provincias["31"] = [250, 52];
  /*ORENSE*/
  provincias["32"] = [32, 85];
  /*PALENCIA*/
  provincias["34"] = [125, 55];
  /*LAS PALMAS*/
  provincias["35"] = [400, 350];
  /*PONTEVEDRA*/
  provincias["36"] = [0, 60];
  /*LA RIOJA*/
  provincias["26"] = [217, 78];
  /*SALAMANCA*/
  provincias["37"] = [76, 133];
  /*SANTA CRUZ*/
  provincias["38"] = [300, 325];
  /*SEGOVIA*/
  provincias["40"] = [161, 125];
  /*SEVILLA*/
  provincias["41"] = [95, 296];
  /*SORIA*/
  provincias["42"] = [212, 105];
  /*TARRAGONA*/
  provincias["43"] = [335, 130];
  /*TERUEL*/
  provincias["44"] = [268, 150];
  /*TOLEDO*/
  provincias["45"] = [150, 185];
  /*VALENCIA*/
  provincias["46"] = [290, 205];
  /*VALLADOLID*/
  provincias["47"] = [130, 100];
  /*VIZCAYA*/
  provincias["48"] = [205, 11];
  /*ZAMORA*/
  provincias["49"] = [85, 95];
  /*ZARAGOZA*/
  provincias["50"] = [253, 104];
  // debug(File.read("/home/arodriguez/dib.svg"));
  //  pic.setWindow( devRect );
  //  pic.setViewport( devRect );
  pic.drawPicture(mapa);

  var family = eGrafico.attribute("FontFamily");
  if (!family || family == "")
  {
    family = "Arial";
  }
  var size = eGrafico.attribute("FontSize");
  if (!size || size == "")
  {
    size = "7";
  }
  var sizeValor = eGrafico.attribute("FontSizeValor");
  if (!sizeValor || sizeValor == "")
  {
    sizeValor = "10";
  }

  var formatValor = eGrafico.attribute("Format");
  if (!formatValor || formatValor == "")
  {
    formatValor = "KM";
  }

  var clf = this.iface.dameFuente(family, size); // FUENTE DE LAS ETIQUETAS EN LOS EJES
  var clfValor = this.iface.dameFuente(family, sizeValor); // FUENTE DE LAS ETIQUETAS EN LOS EJES

  var valores = eGrafico.namedItem("Valores").toElement();
  var eValor: FLDomElement;
  var idProvincia: String;
  var codProvincia: String;
  var provincia: String;
  clr.setRgb(100, 100, 100);
  clrValor.setRgb(0, 0, 255);

  var valor = "";
  var aProvincia = [];
  for (var nodoValor = valores.firstChild(); nodoValor; nodoValor = nodoValor.nextSibling())
  {
    eValor = nodoValor.toElement();
    valor = eValor.attribute("Valor");
    valor = this.iface.formatearValor(valor, formatValor);
    codProvincia = AQUtil.sqlSelect("provincias", "codigo", "idprovincia = " + eValor.attribute("Prov"));
    if (!codProvincia) {
      continue;
    }
    provincia = AQUtil.sqlSelect("provincias", "provincia", "idprovincia = " + eValor.attribute("Prov"));
    pic.setFont(clf);
    pic.setPen(clr, 1);
    try {
      aProvincia = provincias[codProvincia];
    } catch (e) {
      continue;
    }
    pic.drawText(aProvincia[0], aProvincia[1], provincia);
    pic.setFont(clfValor);
    pic.setPen(clrValor, 1);
    pic.drawText(aProvincia[0], aProvincia[1] + (parseInt(size) * 2), valor);
  }

  return pic;
}

function oficial_dibujarGrafico2DMapaPaisesEu(xmlDatos: FLDomDocument): Picture {
  debug("oficial_dibujarGrafico2DMapaPaisesEu");
  var util = new FLUtil;
  var eGrafico = xmlDatos.firstChild().toElement();

  var mapa = new Picture();
  var pic = new Picture();
  var clr = new Color();
  var clrValor = new Color();

  pic.begin();

  //  var contenido= AQUtil.sqlSelect("i_ficheros", "contenido", "nombre = 'i_paises_eu.svg'");
  //  if (!contenido) {
  //    MessageBox.warning(sys.translate("No tiene cargado el fichero i_paises_eu.svg.\nEste fichero es necesario para representar el gráfico de paises."), MessageBox.Ok, MessageBox.NoButton);
  //    return false;
  //  }
  // debug("oficial_dibujarGrafico2DMapaPaisesEu2");
  //  File.write("i_paises_eu.svg", contenido);
  // debug("oficial_dibujarGrafico2DMapaPaisesEu3");
  //  mapa.load( "i_provincias_es.svg", "svg" );
  // debug("oficial_dibujarGrafico2DMapaPaisesEu4");

  var paises = [];
  /* ESPAÑA */
  paises["ES"] = [65, 348];
  /* FRANCIA */
  paises["FR"] = [125, 265];
  /* ITALIA */
  paises["IT"] = [225, 338];
  /* GRECIA */
  paises["GR"] = [331, 359];
  /* PORTUGAL */
  paises["PT"] = [8, 320];
  /* REINO UNIDO */
  paises["GB"] = [70, 117];
  /* IRLANDA */
  paises["IE"] = [47, 160];
  /* SUIZA */
  paises["CH"] = [182, 261];
  /* BÉLGICA */
  paises["BE"] = [150, 210];
  /* LUXEMBURGO */
  paises["LU"] = [152, 235];
  /* PAISES BAJOS */
  paises["NL"] = [155, 180];
  /* ALEMANIA */
  paises["DE"] = [196, 203];
  /* ISLANDIA */
  paises["IS"] = [40, 25];
  /* NORUEGA */
  paises["NO"] = [183, 69];
  /* SUECIA */
  paises["SE"] = [236, 86];
  /* FINLANDIA */
  paises["FI"] = [290, 43];
  /* DINAMARCA */
  paises["DK"] = [182, 137];
  /* ESTONIA */
  paises["EE"] = [299, 90];
  /* LETONIA */
  paises["LV"] = [302, 115];
  /* LITUANIA */
  paises["LT"] = [289, 136];
  /* RUSIA */
  paises["RU"] = [405, 103];
  /* AUSTRIA */
  paises["AT"] = [237, 240];
  /* REP. CHECA */
  paises["CZ"] = [234, 215];
  /* POLONIA */
  paises["PL"] = [270, 185];
  /* POLONIA */
  paises["PL"] = [270, 185];
  /* CROACIA */
  paises["HR"] = [267, 275];
  /* BOSNIA-HERZEGOVINA */
  paises["BA"] = [272, 301];
  /* ESLOVENIA */
  paises["SI"] = [225, 270];
  /* ALBANIA */
  paises["AL"] = [286, 328];
  /* MACEDONIA */
  paises["MK"] = [321, 323];
  /* BULGARIA */
  paises["BG"] = [346, 300];
  /* SERBIA */
  paises["CS"] = [311, 290];
  /* TURQUÍA */
  paises["TR"] = [412, 333];
  /* UCRANIA */
  paises["UA"] = [342, 200];
  /* MOLDAVIA */
  paises["MD"] = [365, 235];
  /* HUNGRÍA */
  paises["HU"] = [279, 252];
  /* ESLOVAQUIA */
  paises["SK"] = [283, 225];
  /* BIELORUSIA */
  paises["BY"] = [333, 155];
  /* RUMANÍA */
  paises["RO"] = [333, 265];
  /* ANDORRA */
  paises["AD"] = [118, 311];
  pic.drawPicture(mapa);
  debug("oficial_dibujarGrafico2DMapaPaisesEu4");
  var family = eGrafico.attribute("FontFamily");
  if (!family || family == "")
  {
    family = "Arial";
  }
  var size = eGrafico.attribute("FontSize");
  if (!size || size == "")
  {
    size = "7";
  }
  var sizeValor = eGrafico.attribute("FontSizeValor");
  if (!sizeValor || sizeValor == "")
  {
    sizeValor = "10";
  }

  var formatValor = eGrafico.attribute("Format");
  if (!formatValor || formatValor == "")
  {
    formatValor = "KM";
  }

  var clf = this.iface.dameFuente(family, size); // FUENTE DE LAS ETIQUETAS EN LOS EJES
  var clfValor = this.iface.dameFuente(family, sizeValor); // FUENTE DE LAS ETIQUETAS EN LOS EJES

  var valores = eGrafico.namedItem("Valores").toElement();
  var eValor: FLDomElement;
  var idPais: String;
  var codPais: String;
  var pais: String;
  clr.setRgb(100, 100, 100);
  clrValor.setRgb(0, 0, 255);

  var valor = "";
  var aPais = [];
  debug("oficial_dibujarGrafico2DMapaPaisesEu5");
  for (var nodoValor = valores.firstChild(); nodoValor; nodoValor = nodoValor.nextSibling())
  {
    debug("oficial_dibujarGrafico2DMapaPaisesEu4 " + eValor.attribute("Pais"));
    eValor = nodoValor.toElement();
    valor = eValor.attribute("Valor");
    valor = this.iface.formatearValor(valor, formatValor);
    codPais = AQUtil.sqlSelect("paises", "codiso", "codpais = '" + eValor.attribute("Pais") + "'");
    if (!codPais) {
      continue;
    }
    pais = AQUtil.sqlSelect("paises", "nombre", "codpais = '" + eValor.attribute("Pais") + "'");
    pic.setFont(clf);
    pic.setPen(clr, 1);
    try {
      aPais = paises[codPais];
    } catch (e) {
      continue;
    }
    pic.drawText(aPais[0], aPais[1], pais);
    pic.setFont(clfValor);
    pic.setPen(clrValor, 1);
    pic.drawText(aPais[0], aPais[1] + (parseInt(size) * 2), valor);
  }

  return pic;
}

function oficial_formatearValor(valor: String, formatValor: String)
{
  if (!valor || valor == "")
    return;

  var result = valor;

  var numero = parseFloat(valor);
  var n: Number;
  switch (formatValor) {
    case "KM": {
      if (numero >= 1000000) {
        n = numero / 1000000;
        result = n.toString().split(".")[0] + "." + n.toString().split(".")[1].left(1) + "M";
        break
      }
      if (numero >= 1000) {
        n = numero / 1000;
        result = n.toString().split(".")[0] + "K";
        break;
      }

      if (numero < 1000) {
        n = numero / 1000;
        result = n.toString().split(".")[0] + "." + n.toString().split(".")[1].left(1) + "K";
        break
      }
      break;
    }
    default: {
      break;
    }
  }

  return result;
}

function oficial_mostrarInformeVisor(visor)
{
  var ver = sys.version();
  var verBuild = parseInt(ver.mid(ver.lastIndexOf("Build") + 6));
  //  if (!isNaN(verBuild) && verBuild > 22230 && sys.multiLangEnabled()) {
  //    this.iface.visor_ = visor;
  //
  //    var view = new FLFormSearchDB("flvar");
  //    view.setMainWidget("multilangview.ui");
  //    view.child("pushButtonAccept").close();
  //    //view.child("cbxLang").currentText = sys.multiLangId();
  //    connect(view.child("cbxLang"),"activated(QString)", this, "iface.changeLang()");
  //    connect(visor, "destroyed()", view, "close()");
  //
  //    visor.reparent(view.child("viewSub"));
  //    visor.child("menubar").close();
  //    view.show();
  //  } else {
  this.iface.visor_ = visor;
  this.iface.visor_.exec();
  //  }
}

function oficial_activaProforma(activar)
{
	var _i = this.iface;
	_i.esProforma_ = activar;
}

function oficial_labelProforma(nodo, campo)
{
	var _i = this.iface;
	var valor = "";
debug("Es " + _i.esProforma_ + " campo " + campo);
	switch (campo) {
		case "titulo": {
			valor = " " + (_i.esProforma_ ? sys.translate("F. PROFORMA") : sys.translate("PRESUPUESTO"));
			break;
		}
		case "total": {
			valor = _i.esProforma_ ? sys.translate("Total factura") : sys.translate("Total presupuesto");
			break;
		}
	}
debug("valor " + valor);
	return valor;
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
