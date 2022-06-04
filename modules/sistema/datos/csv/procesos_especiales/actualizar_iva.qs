function progLog(s, ts, lp)
{
  var por = s / ts;
  var p = parseInt(por * 50);
 
  if (!p || p == lp)
    return p;
  
  var s = "";
  for (var i = 0; i < p; ++i)
    s += "#"
  
  por = Math.floor(por*100);
  s += " " + por.toString() + "%";
  debug(s);
  sys.processEvents();
  
  return p;
}

function actualizarIVA(tipoTabla, codEjercicio) 
{
  var tabla = "facturas" + tipoTabla;
  var qry = new FLSqlQuery;
  
  qry.setForwardOnly(true);
  qry.setTablesList(tabla);
  qry.setSelect("idfactura");
  qry.setFrom(tabla);
  qry.setWhere("codejercicio = '" + codEjercicio + "'");
  qry.exec();
  
  var steps = qry.size();
  var step = 0, p = 0;
  
  var curLineaIva = new FLSqlCursor("lineasivafact" + tipoTabla);
  var curLineasFactura = new FLSqlCursor("lineasfacturas" + tipoTabla);
  
  curLineaIva.setActivatedCommitActions(false);
  curLineaIva.setActivatedCheckIntegrity(false);
  
  curLineasFactura.setActivatedCommitActions(false);
  curLineasFactura.setActivatedCheckIntegrity(false);

  while (qry.next()) {
    sys.actualizarLineasIva(tipoTabla, qry.value(0), curLineaIva, curLineasFactura);
    p = sys.progLog(++step, steps, p);
  }
  sys.progLog(steps, steps, p);
}

function actualizarLineasIva(tipoTabla, idFactura, curLineaIva, curLineasFactura) 
{
  var util = formRecorddat_procesos_lotes.iface.util;
  
  util.quickSqlDelete("lineasivafact" + tipoTabla, "idfactura=" + idFactura);
  curLineasFactura.select("idfactura = " + idFactura + " ORDER BY iva");
  
  var ivaAnt = 0;
  var iva;
  var codImpuesto = "";
  var recargo;
  var totalNeto = 0;
  var totalIva = 0;
  var totalRecargo = 0;
  var totalLinea = 0;
  
  while (curLineasFactura.next()) {
    iva = curLineasFactura.valueBuffer("iva");
    if (ivaAnt != iva) {
      totalIva = (ivaAnt * totalNeto) / 100;
      totalRecargo = (recargo * totalNeto) / 100;
      totalLinea = totalNeto + parseFloat(totalIva) + parseFloat(totalRecargo);

      codImpuesto = util.quickSqlSelect("impuestos", "codimpuesto", "iva=" + ivaAnt);

      curLineaIva.setModeAccess(curLineaIva.Insert);
      curLineaIva.refreshBuffer();
      curLineaIva.setValueBuffer("idfactura", idFactura);
      curLineaIva.setValueBuffer("iva", ivaAnt);
      
      if (codImpuesto) 
        curLineaIva.setValueBuffer("codimpuesto", codImpuesto);
      
      curLineaIva.setValueBuffer("recargo", recargo);
      curLineaIva.setValueBuffer("neto", totalNeto);
      curLineaIva.setValueBuffer("totaliva", totalIva);
      curLineaIva.setValueBuffer("totalrecargo", totalRecargo);
      curLineaIva.setValueBuffer("totallinea", totalLinea);
      curLineaIva.commitBuffer();

      totalNeto = 0;
    }
    
    ivaAnt = iva;
    iva = parseFloat(curLineasFactura.valueBuffer("iva"));
    recargo = parseFloat(curLineasFactura.valueBuffer("recargo"));
    totalNeto += parseFloat(curLineasFactura.valueBuffer("pvptotal"));
  }

  if (totalNeto != 0) {
    totalIva = util.roundFieldValue((iva * totalNeto) / 100, "lineasivafact" + tipoTabla, "totaliva");
    totalRecargo = util.roundFieldValue((recargo * totalNeto) / 100, "lineasivafact" + tipoTabla, "totalrecargo");
    totalLinea = totalNeto + parseFloat(totalIva) + parseFloat(totalRecargo);

    with(curLineaIva) {
      setModeAccess(Insert);
      refreshBuffer();
      setValueBuffer("idfactura", idFactura);
      setValueBuffer("iva", iva);
      setValueBuffer("recargo", recargo);
      setValueBuffer("neto", totalNeto);
      setValueBuffer("totaliva", totalIva);
      setValueBuffer("totalrecargo", totalRecargo);
      setValueBuffer("totallinea", totalLinea);
      commitBuffer();
    }
  }
}

function actualizar_iva()
{
  var args = cmdargs.split(':');
  sys.actualizarIVA(args[0], args[1]);
}
