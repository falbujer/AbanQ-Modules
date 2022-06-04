/***************************************************************************
                           dat_procesos_lotes.qs
                            -------------------
   begin                : lun 1 feb 2010
   copyright            : (C) 2003-2010 by InfoSiAL S.L.
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

/** @class_declaration interna */
////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
class interna
{  
  function  interna(context)  { this.ctx = context; }
  
  var       ctx;
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna 
{
  function  oficial(context)  { interna(context); }
  function  init()            { this.ctx.oficial_init(); }
  
  function  initTbProcesos()  { this.ctx.oficial_initTbProcesos(); }
  function  updateProcesos()  { this.ctx.oficial_updateProcesos(); }
  function  tbDblClick(r, c)  { this.ctx.oficial_tbDblClick(r, c); }
  function  tbUpClick()       { this.ctx.oficial_tbUpClick(); }
  function  tbDownClick()     { this.ctx.oficial_tbDownClick(); }

  function  cmdRunLote(codLote)
                              { this.ctx.oficial_cmdRunLote(codLote); }
  function  cmdRunProceso(proc)
                              { this.ctx.oficial_cmdRunProceso(proc); }

  function  runLote(cur)      { return this.ctx.oficial_runLote(cur); }
  function  runProceso(proc)
                              { return this.ctx.oficial_runProceso(proc); }
  
  function  loadCsvFile(fileCsv, corInfo, tabla, codFichero)
                              { return this.ctx.oficial_loadCsvFile(fileCsv, corInfo, tabla, codFichero); }
  function  importUpdated(dbRecord, corInfo, tabla, flags)
                              { return this.ctx.oficial_importUpdated(dbRecord, corInfo, tabla, flags); }
  function  deleteRemoved(dbRecord, tabla, filter, flags)
                              { return this.ctx.oficial_deleteRemoved(dbRecord, tabla, filter, flags); }                              
  function  importDbRecord(rec, corInfo, cur)
                              { return this.ctx.oficial_importDbRecord(rec, corInfo, cur); }
  function  sqlDbRecord(corInfo, tabla)
                              { return this.ctx.oficial_sqlDbRecord(corInfo, tabla); }
  function  csvRecordToDbRecord(line, corInfo, tabla)
                              { return this.ctx.oficial_csvRecordToDbRecord(line, corInfo, tabla); }
  function  readCsvRecord(file, nCampos)
                              { return this.ctx.oficial_readCsvRecord(file, nCampos); }
  function  corInfo(esquema, tabla)  
                              { return this.ctx.oficial_corInfo(esquema, tabla); }
  function  formatSqlDbField(cor)
                              { return this.ctx.oficial_formatSqlDbField(cor); }
  function  formatDatoCsv(dato, cor, tabla)
                              { return this.ctx.oficial_formatDatoCsv(dato, cor, tabla); }
  function  defaultValueNotNull(cor)
                              { return this.ctx.oficial_defaultValueNotNull(cor); }
  function  countCamposCsv(line)
                              { return this.ctx.oficial_countCamposCsv(line); }  
  function  simplify(str)     { return this.ctx.oficial_simplify(str); }
  function  escapeQuote(str)  { return this.ctx.oficial_escapeQuote(str); }
  function  delRightDecimalZeros(str)   
                              { return this.ctx.oficial_delRightDecimalZeros(str); }
  function  msgLog(msg)       { this.ctx.oficial_msgLog(msg); }
  function  progLog(s,ts,lp)  { return this.ctx.oficial_progLog(s, ts, lp); }
  function  setTedLog(ted)		{ this.ctx.oficial_setTedLog(ted); }
  
  function  datoCampo(tipo, datoValor, datoFichero, linea)
                              { return this.ctx.oficial_datoCampo(tipo, datoValor, datoFichero, linea); }
                              
  var cacheFunciones = new Array;
  var strFunciones = "";
  var util = new FLUtil;
  var tbProcesos;
  var tedLog;
  var pathCsv;
  const sepCsv = 'ð';
  const sepDb = '\u00b6';
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends oficial 
{
  function  head(context)     { oficial(context); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head 
{
  function  ifaceCtx(context) { head(context); }
  
  function  pub_setTedLog(ted){ this.setTedLog(ted); }
  function  pub_cmdRunLote(codLote)
                              { this.cmdRunLote(codLote); }
  function  pub_cmdRunProceso(proc)
                              { this.cmdRunProceso(proc); }
  function  pub_escapeQuote(str)
                              { return this.escapeQuote(str); }
  function  pub_simplify(str) { return this.simplify(str); }
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
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_init() 
{
  this.iface.tedLog = this.child("tedLog");
  this.iface.tbProcesos = this.child("tbProcesos");
  
  this.iface.initTbProcesos();
  
  connect(this.child("pbnUp"), "clicked()", this.iface, "tbUpClick()");
  connect(this.child("pbnDown"), "clicked()", this.iface, "tbDownClick()");
  connect(this.child("pbnRun"), "clicked()", this.iface, "runLote()");
}

function oficial_initTbProcesos()
{
  var tbp = this.iface.tbProcesos;    
  var curProcesos = new FLSqlCursor("dat_procesos");
  var codProceso;

  curProcesos.select();
  tbp.insertRows(0, curProcesos.size());
  
  var strProcs = this.cursor().valueBuffer("procesos").toString();
  var i = 0;
  
  if (!strProcs.isEmpty()) {
    var arrProcs = strProcs.split(';');
    var proc, a;
    for (; i < arrProcs.length; ++i) {
      proc = arrProcs[i];
      if (proc.search('@') == -1) {
        tbp.setText(i, 0, proc);
        tbp.setText(i, 2, "");
      } else {
        a = proc.split('@');
        tbp.setText(i, 0, a[0]);
        tbp.setText(i, 2, a[1]);
        strProcs = strProcs.replace('@' + a[1], '');
      }
      tbp.setText(i, 1, "#####");
    }
    strProcs = ';' + strProcs + ';';
  }
  
  while (curProcesos.next()) {
    codProceso = curProcesos.valueBuffer("codproceso").toString();
    if (strProcs.search(';' + codProceso + ';') == -1) {
      tbp.setText(i, 0, codProceso);
      tbp.setText(i, 1, "");
      tbp.setText(i, 2, "");
      ++i;
    }
  }
  
  tbp.setColumnLabels(",", "Proceso,Incluir,Filtro Borrado");
  tbp.setColumnReadOnly(0, true);
  tbp.setColumnReadOnly(1, true);
  tbp.setColumnReadOnly(2, false);
  tbp.adjustColumn(0);
  tbp.adjustColumn(1);
  tbp.adjustColumn(2);
  
  connect(tbp, "doubleClicked(int,int)", this.iface, "tbDblClick()");
  connect(tbp, "valueChanged(int,int)", this.iface, "updateProcesos()");
}

function oficial_updateProcesos()
{
  var tbp = this.iface.tbProcesos;
  var nRows = tbp.numRows();
  var procesos = "";
  
  for (var i = 0; i < nRows; ++i) {
    if (!tbp.text(i, 1).isEmpty()) {
      if (i)
        procesos += ";";
      procesos += tbp.text(i, 0);
      if (!tbp.text(i, 2).isEmpty())
        procesos += '@' + tbp.text(i, 2);
    } else
      break;
  }
  
  this.cursor().setValueBuffer("procesos", procesos);
  this.iface.msgLog(procesos);
}

function oficial_tbDblClick(row, col)
{
  if (col != 1)
    return;
  
  var tbp = this.iface.tbProcesos;
  var incluir = tbp.text(row, 1).isEmpty();
  
  if (incluir) {
    var itRow = row - 1;
    var tmpTxt;
    
    while (itRow >= 0 && tbp.text(itRow, 1).isEmpty()) {
      tmpTxt = tbp.text(itRow, 0);
      tbp.setText(itRow, 0, tbp.text(row, 0));
      tbp.setText(row, 0, tmpTxt);
      tmpTxt = tbp.text(itRow, 2);
      tbp.setText(itRow, 2, tbp.text(row, 2));
      tbp.setText(row, 2, tmpTxt);
      row = itRow--;
    }
  } else {
    var itRow = row + 1;
    var nRows = tbp.numRows();
    var tmpTxt;
    
    while (itRow < nRows && !tbp.text(itRow, 1).isEmpty()) {
      tmpTxt = tbp.text(itRow, 0);
      tbp.setText(itRow, 0, tbp.text(row, 0));
      tbp.setText(row, 0, tmpTxt);
      tmpTxt = tbp.text(itRow, 2);
      tbp.setText(itRow, 2, tbp.text(row, 2));
      tbp.setText(row, 2, tmpTxt);
      row = itRow++;
    }
  }
  
  tbp.setText(row, 1, incluir ? "#####" : "");
  tbp.selectRow(row);
  
  this.iface.updateProcesos();
}

function oficial_tbUpClick()
{
  var tbp = this.iface.tbProcesos;
  var row = tbp.currentRow();
  
  if (tbp.text(row, 1).isEmpty())
    return;
    
  var itRow = row - 1;
  
  if (itRow >= 0 && !tbp.text(itRow, 1).isEmpty()) {
    var tmpTxt = tbp.text(itRow, 0);
    tbp.setText(itRow, 0, tbp.text(row, 0));
    tbp.setText(row, 0, tmpTxt);
    var tmpTxt = tbp.text(itRow, 2);
    tbp.setText(itRow, 2, tbp.text(row, 2));
    tbp.setText(row, 2, tmpTxt);
    tbp.selectRow(itRow);
  }
  
  this.iface.updateProcesos();
}

function oficial_tbDownClick()
{
  var tbp = this.iface.tbProcesos;
  var row = tbp.currentRow();
  
  if (tbp.text(row, 1).isEmpty())
    return;
 
  var nRows = tbp.numRows();
  var itRow = row + 1;
  
  if (itRow < nRows && !tbp.text(itRow, 1).isEmpty()) {
    var tmpTxt = tbp.text(itRow, 0);
    tbp.setText(itRow, 0, tbp.text(row, 0));
    tbp.setText(row, 0, tmpTxt);
    var tmpTxt = tbp.text(itRow, 2);
    tbp.setText(itRow, 2, tbp.text(row, 2));
    tbp.setText(row, 2, tmpTxt);
    tbp.selectRow(itRow);
  }
  
  this.iface.updateProcesos();
}

function oficial_cmdRunLote(codLote)
{
  var cur = new FLSqlCursor("dat_procesos_lotes");
  cur.transaction(false);
  cur.select("codlote='" + codLote + "'");
  if (cur.size() && cur.next()) {
    if (!this.iface.runLote(cur)) {
      cur.rollback();
      return;
    }
  }
  cur.commit();
}

function oficial_cmdRunProceso(proc)
{
  this.iface.pathCsv = this.iface.util.quickSqlSelect("dat_opciones", "rutadatos", "");
  this.iface.msgLog("path csv: " + this.iface.pathCsv);
  
  var cur = new FLSqlCursor("dat_procesos_lotes");
  cur.transaction(false);
  if (!this.iface.runProceso(proc))
    cur.rollback();
  else
    cur.commit();
}

function oficial_runLote(cur)
{
  if (cur == undefined)
    cur = this.cursor();
  
  this.iface.pathCsv = this.iface.util.quickSqlSelect("dat_opciones", "rutadatos", "");
  this.iface.msgLog("path csv: " + this.iface.pathCsv);
  this.iface.msgLog("lote: " + cur.valueBuffer("codlote") + " " + cur.valueBuffer("descripcion"));
  
  var procs = cur.valueBuffer("procesos").toString().split(';');
  for (var i = 0; i < procs.length; ++i) {
    if (!this.iface.runProceso(procs[i]))
      return false;
  }
  return true;
}

function oficial_runProceso(proc)
{
  var aproc;
  if (proc.search('@') != -1) {
    aproc = proc.split('@');
    proc = aproc[0];
  }
  
  this.iface.msgLog("proceso: " + proc);
  
  var cur = new FLSqlCursor("dat_procesos");
  
  cur.select("codproceso='" + proc + "'");
  if (!cur.first()) {
    this.iface.msgLog(" #no existe el proceso: " + proc);
    return false;
  }  
  
  var fileCsv = this.iface.pathCsv + cur.valueBuffer("ficherocsv");
  this.iface.msgLog(" *fichero csv: " + fileCsv);
  var codEsquema = cur.valueBuffer("codesquema");
  this.iface.msgLog(" *esquema: " + codEsquema);
  var codTabla = this.iface.util.quickSqlSelect("dat_esquemas", "codtabla", "codesquema='" + codEsquema + "'");
  this.iface.msgLog(" *tabla: " + codTabla);
  var codFichero = this.iface.util.quickSqlSelect("dat_esquemas", "codfichero", "codesquema='" + codEsquema + "'");
  this.iface.msgLog(" *cod. fichero: " + codFichero);
  var corInfo = this.iface.corInfo(codEsquema, codTabla);
  
  if (!corInfo.length) {
    this.iface.msgLog(" #esquema vacio");
    return false;
  }
  
  var flags = {
    nocheckintegridad: cur.valueBuffer("nocheckintegridad"),
    commitacciones: cur.valueBuffer("commitacciones")
  }
  this.iface.msgLog(" *nocheckintegridad: " + flags.nocheckintegridad);
  this.iface.msgLog(" *commitacciones: " + flags.commitacciones);
  
  this.iface.msgLog(" *borrando tabla temporal...");
  this.iface.util.quickSqlDelete("dat_lotes_tmp", "");

  if (!this.iface.loadCsvFile(fileCsv, corInfo, codTabla, codFichero))
    return false;
    
  var dbRecord = this.iface.sqlDbRecord(corInfo, codTabla);
  if (dbRecord.isEmpty()) {
    this.iface.msgLog(" #esquema vacio");
    return false;
  }
  
  if (!this.iface.importUpdated(dbRecord, corInfo, codTabla, flags))
    return false;
    
  if (aproc) {
    if (!this.iface.deleteRemoved(dbRecord, codTabla, aproc[1], flags))
      return false;
  }
  
  return true;
}

function oficial_loadCsvFile(fileCsv, corInfo, tabla, codFichero)
{
  this.iface.msgLog("cargando fichero");
  
  var file = new File(fileCsv);
  
  try {
    file.open(File.ReadOnly);
  } catch(e) {
    this.iface.msgLog(" ### ERROR " + e);
    return false;
  }
  var steps = 0;
  while (!file.eof) {
    file.readLine();
    ++steps;
  }
  file.close();
  file.open(File.ReadOnly);
    
  var head = file.readLine();
  var rec;
  var step = 0, p = 0;
  var cur = new FLSqlCursor("dat_lotes_tmp");
  var nCampos = this.iface.util.sqlSelect("dat_campos", "count(*)", "codfichero='" + codFichero + "'");
  
  cur.setActivatedCommitActions(false);
  cur.setActivatedCheckIntegrity(false);
  
  while (!file.eof) {
    var line = this.iface.readCsvRecord(file, nCampos); 
    rec = this.iface.csvRecordToDbRecord(line, corInfo, tabla);
    
    cur.setModeAccess(cur.Insert);
    cur.refreshBuffer();
    cur.setValueBuffer("valor1", this.iface.simplify(rec.rec));    
    cur.setValueBuffer("valor2", rec.recAll);    
    cur.setValueBuffer("valor3", rec.whereKey);
    cur.setValueBuffer("linecsv", rec.line);
    cur.commitBuffer();
        
    p = this.iface.progLog(++step, steps, p); 
  }
  
  this.iface.progLog(steps, steps, p); 
  file.close();
  return true;
}

function oficial_importUpdated(dbRecord, corInfo, tabla, flags)
{
  this.iface.msgLog("importando registros");
  
  var curTmp = new FLSqlCursor("dat_lotes_tmp");
  curTmp.select();
  
  var steps = curTmp.size();
  if (!steps) {
    this.iface.msgLog(" #no hay registros a importar");
    return true;
  }
  var step = 0, p = 0;
  var rec;
  var qry = new FLSqlQuery;
    
  qry.setForwardOnly(true);
  qry.setTablesList(tabla);
  qry.setSelect("dbrec");
    
  var cur = new FLSqlCursor(tabla);
  cur.setActivatedCommitActions(flags.commitacciones);
  cur.setActivatedCheckIntegrity(false);
  
  while (curTmp.next()) {
    rec = new Object;
    rec.rec = curTmp.valueBuffer("valor1");
    rec.recAll = curTmp.valueBuffer("valor2");
    rec.whereKey = curTmp.valueBuffer("valor3");
    rec.line = curTmp.valueBuffer("linecsv");
    
    if (!rec.whereKey.isEmpty())
      qry.setFrom(dbRecord.arg("WHERE " + rec.whereKey));
    else
      qry.setFrom(dbRecord.arg(""));
    
    qry.setWhere("dbrec='" + this.iface.escapeQuote(rec.rec) + "'");
    
    if (!qry.exec()) {
      this.iface.msgLog(" #consulta errónea: " + qry.sql());
      return false;
    }
    // Sólo importamos registro si la consulta es vacia,
    // es decir, el registro que se quiere importar no existe ya con
    // el mismo contenido
    if (!qry.next()) {
      if (!this.iface.importDbRecord(rec, corInfo, cur))
        return false;
    }
    
    p = this.iface.progLog(++step, steps, p);
  }
  
  this.iface.progLog(steps, steps, p);
  return true;
}

function oficial_deleteRemoved(dbRecord, tabla, filter, flags)
{
  this.iface.msgLog("borrando registros eliminados: " + filter);
  
  var qry = new FLSqlQuery;
  var cur = new FLSqlCursor(tabla);
  var pk = cur.primaryKey();
  
  qry.setForwardOnly(true);
  qry.setTablesList(tabla);
  qry.setSelect("dbrec," + pk);
  
  if (!filter.isEmpty())
    qry.setFrom(dbRecord.arg("WHERE " + filter));
  else
    qry.setFrom(dbRecord.arg(""));
  
  if (!qry.exec()) {
    this.iface.msgLog(" #consulta errónea: " + qry.sql());
    return false;
  }
  
  cur.setActivatedCommitActions(flags.commitacciones);
  cur.setActivatedCheckIntegrity(false);
  
  var steps = qry.size();
  var step = 0, p = 0;
  var aux;
  
  while(qry.next()) {
    if (!this.iface.util.quickSqlSelect("dat_lotes_tmp", "valor1", 
                                        "valor1='" + this.iface.escapeQuote(qry.value(0)) + "'")) {
      aux = pk + "='" + qry.value(1) + "'";
      cur.select(aux);
      
      this.iface.msgLog("borrar: " + aux);
      
      if (!cur.next()) {
        this.iface.msgLog(" #resgitro no localizado: " + qry.value(0));
        continue;
      }   
      if (cur.isLocked()) {
        this.iface.msgLog(" *registro bloqueado: " + qry.value(0));
        continue;
      }
      
      cur.setModeAccess(cur.Del);
      cur.refreshBuffer();
      
      var msgCheck = cur.msgCheckIntegrity();
      if (!msgCheck.isEmpty()) {
        this.iface.msgLog(" #error: " + msgCheck.substring(1));
        return true;
      } else if (!cur.commitBuffer()) {
        this.iface.msgLog(" #error en commit");
        return false;
      }
    }
    p = this.iface.progLog(++step, steps, p);
  }
  
  this.iface.progLog(steps, steps, p);
  return true;
}

function oficial_importDbRecord(rec, corInfo, cur)
{  
  var valores = rec.recAll.split(this.iface.sepDb);

  cur.setModeAccess(cur.Insert);
  cur.refreshBuffer();
  
  for (var i = 0; i < corInfo.length; ++i) {
    if (corInfo[i].calculado) {
      var line = rec.line;
      var camposCsv = line.split(this.iface.sepCsv);
      var dato = this.iface.datoCampo(corInfo[i].tipoDato, corInfo[i].campofichero, 
                                      camposCsv[corInfo[i].posicion], line).toString();
      dato = this.iface.formatDatoCsv(dato, corInfo[i], corInfo[i].tabla).toString();
      valores[i] = dato;
    }
    if (!valores[i].isEmpty() && valores[i] == String("ignorar").left(corInfo[i].len)) {
        this.iface.msgLog(" *ignorando registro: " + rec.whereKey);
        return true;
    }
    if (corInfo[i].anull && valores[i].isEmpty()) {
      cur.setNull(corInfo[i].campotabla);
      continue;
    }
    cur.setValueBuffer(corInfo[i].campotabla, valores[i]);
  }
 
  this.iface.msgLog("importar: " + rec.whereKey + " " + valores.join(this.iface.sepDb));
    
  var msgCheck = cur.msgCheckIntegrity();
  if (!msgCheck.isEmpty()) {
    cur.select(rec.whereKey);
    if (cur.size() == 1) {
      cur.setModeAccess(cur.Edit);
      cur.first();
      
      if (cur.isLocked()) {
        this.iface.msgLog(" *registro bloqueado: " + rec.whereKey);
        return true;
      }
      
      for (var i = 0; i < corInfo.length; ++i) {
        if (corInfo[i].pk)
          continue;
        if (corInfo[i].anull && valores[i].isEmpty()) {
          cur.setNull(corInfo[i].campotabla);
          continue;
        }
        cur.setValueBuffer(corInfo[i].campotabla, valores[i]);
      }
        
      msgCheck = cur.msgCheckIntegrity();
    }
  }
  
  if (!msgCheck.isEmpty()) {
    this.iface.msgLog(" #error: " + msgCheck.substring(1));
    return true;
  } else if (!cur.commitBuffer()) {
    this.iface.msgLog(" #error en commit");
    return false;
  }
  
  return true;
}

function oficial_sqlDbRecord(corInfo, tabla)
{
  var cur = new FLSqlCursor(tabla);
  var pk = cur.primaryKey();
  var dbRecord = "";
  for (var i = 0; i < corInfo.length; ++i) {
    if(corInfo[i].calculado)
      continue;
    if (i) {
        if (!dbRecord.isEmpty())
          dbRecord += "||"; 
        dbRecord += "'" + this.iface.sepDb + "'||";
    }
    dbRecord += this.iface.formatSqlDbField(corInfo[i]);
  }
  dbRecord = "(SELECT " + pk +",replace(replace(btrim((" + dbRecord + 
             "), E' \\n\\r\\t\\f'), E'\\n',''), ' ','') as dbrec FROM " + 
             tabla + " %1) as dr";
  return dbRecord;
}

function oficial_csvRecordToDbRecord(line, corInfo, tabla)
{
  if (line.charCodeAt(line.length - 1) == 10)
    line = line.left(line.length - 1);
    
  var camposCsv = line.split(this.iface.sepCsv);
  var rec = new Object;
  var dato;
  var noCalc;
  
  rec.rec = "";
  rec.recAll = "";
  rec.whereKey = "";
  rec.line = line;
  
  for (var i = 0; i < corInfo.length; ++i) {
    noCalc = !corInfo[i].calculado;
    if (i) {
        if (noCalc)
          rec.rec += this.iface.sepDb;
        rec.recAll += this.iface.sepDb;
    }
    if (noCalc) {
      dato = this.iface.datoCampo(corInfo[i].tipoDato, corInfo[i].campofichero, 
                                  camposCsv[corInfo[i].posicion], line).toString();
      dato = this.iface.formatDatoCsv(dato, corInfo[i], tabla).toString();
    } else
      dato = "";
                                               
    if (noCalc)
      rec.rec += dato;
    rec.recAll += dato;
    
    if (noCalc && corInfo[i].tipoCampo != this.iface.util.Serial && (corInfo[i].pk || corInfo[i].ck)) {
      if (!rec.whereKey.isEmpty())
        rec.whereKey += " and ";
      rec.whereKey += corInfo[i].campotabla + "='" + dato + "'";
    }
  }
  
  return rec;
}

function oficial_readCsvRecord(file, nCampos) 
{
  var regExp = new RegExp("\"");
  regExp.global = true;
  var contCampos = 0;
  var csvRec = "";
  var buf = "";
  
  while (contCampos < nCampos) {
    buf = file.readLine();
    if (buf.left(1) == "#") 
      continue;
    csvRec += buf.replace(regExp, "");
    contCampos = this.iface.countCamposCsv(csvRec);
  }

  if (csvRec.charCodeAt(csvRec.length - 1) == 10)
    return csvRec.left(csvRec.length - 1);
  return csvRec;
}

function oficial_corInfo(esquema, tabla)
{
  var crs = new Array;
  var qryCor = new FLSqlQuery;
  
  qryCor.setForwardOnly(true);
  qryCor.setTablesList("dat_correspondencias");
  qryCor.setSelect("campotabla,campofichero,posicion,tipo,calculado,joinkey");
  qryCor.setFrom("dat_correspondencias");
  qryCor.setWhere("codesquema='" + esquema + "' order by posicion");

  if (!qryCor.exec() || qryCor.size() == 0) {
    this.iface.msgLog(" #consulta errónea o vacia: " + qryCor.sql());
    return crs;
  }
  
  while (qryCor.next()) {
    var cr = new Object;
    cr.campotabla = qryCor.value(0);
    cr.campofichero = qryCor.value(1);
    cr.posicion = qryCor.value(2);
    cr.tipoDato = qryCor.value(3);
    cr.calculado = qryCor.value(4);
    cr.joinkey = qryCor.value(5);
    cr.tipoCampo = this.iface.util.fieldType(cr.campotabla, tabla);
    cr.len = this.iface.util.fieldLength(cr.campotabla, tabla);
    cr.anull = this.iface.util.fieldAllowNull(cr.campotabla, tabla);
    cr.pk = this.iface.util.fieldIsPrimaryKey(cr.campotabla, tabla);
    cr.ck = (cr.joinkey || this.iface.util.fieldIsCompoundKey(cr.campotabla, tabla));
    cr.defVal = this.iface.util.fieldDefaultValue(cr.campotabla, tabla);
    cr.esquema = esquema;
    cr.tabla = tabla;
    crs.push(cr);
  }
  
  return crs;
}

function oficial_formatSqlDbField(cor)
{
  switch (cor.tipoCampo) {
    case this.iface.util.Unlock:
    case this.iface.util.Bool:
        if (cor.anull)
          return "(CASE WHEN " + cor.campotabla + " IS NULL THEN '' ELSE " +
                 "CASE WHEN " + cor.campotabla + " THEN 'true' ELSE 'false' END END)";
        else
          return "(CASE WHEN " + cor.campotabla + " IS NULL THEN '" + 
                 this.iface.defaultValueNotNull(cor) + "' ELSE " +
                 "CASE WHEN " + cor.campotabla + " THEN 'true' ELSE 'false' END END)";
    case this.iface.util.Serial:
    case this.iface.util.Int:
    case this.iface.util.UInt:
    case this.iface.util.Double:
        if (cor.anull)
          return "COALESCE(CAST(" + cor.campotabla + " AS text),'')";
        else
          return "COALESCE(" + cor.campotabla + "," + 
                 this.iface.defaultValueNotNull(cor) + ")";
    default:
        if (cor.anull)
          return "COALESCE(CAST(" + cor.campotabla + " AS text),'')";
        else
          return "COALESCE(" + cor.campotabla + ",'" + 
                 this.iface.defaultValueNotNull(cor) + "')";
  }
}

function oficial_formatDatoCsv(dato, cor, tabla)
{
  var datoIsNull = (!dato || dato.isEmpty() || dato == "??");
  
  if (datoIsNull && !cor.anull)
    return this.iface.defaultValueNotNull(cor);
  
  switch (cor.tipoCampo) {
    case this.iface.util.Date:
        if (dato.charAt(2) == "-" || dato.charAt(2) == "/") {
					return dato.mid(6, 4) + "-" + dato.mid(3, 2) + "-" + dato.mid(0, 2);
				} else {
					return dato.left(10);
				}
    case this.iface.util.Time:
        return dato.left(8);
    case this.iface.util.Double:
        return this.iface.delRightDecimalZeros(this.iface.util.roundFieldValue(dato, tabla, cor.campotabla));
		case this.iface.util.Bool:
        if (isNaN(dato)) {
					return (dato.toUpperCase() == "T" || dato.toUpperCase() == "TRUE");
				} else {
					return (dato != 0);
				}
    case this.iface.util.UInt:
		case this.iface.util.Int:
        return isNaN(dato) ? 0 : parseFloat(dato);
    default:
        return (cor.len > 0 ? dato.left(cor.len) : dato);
  }                        
}

function oficial_defaultValueNotNull(cor)
{
  if (cor.defVal)
    return cor.defVal;

  switch (cor.tipoCampo) {
    case this.iface.util.Unlock:
    case this.iface.util.Bool:
        return false;
    case this.iface.util.Date: 
        return "0001-01-01";
    case this.iface.util.Time:
        return "00:00:00";
    case this.iface.util.Serial:
    case this.iface.util.Int:
    case this.iface.util.UInt:
    case this.iface.util.Double:
        return 0;
    default:
        return "??";
  }
}

function oficial_countCamposCsv(line)
{
  var count = 0;
  for (var i = 0; i < line.length; ++i) {
    if (line.charAt(i) == this.iface.sepCsv)
      ++count;
  }
  return ++count;
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

function oficial_delRightDecimalZeros(str)
{
  for (var i = str.length - 1; i >= str.findRev('.') - 1; --i) {
    if (str.charAt(i) != '0' && str.charAt(i) != '.') {
      str = str.substring(0, i + 1);
      break;
    }
    if (str.charAt(i) == '.') {
      str = str.substring(0, i);
      break;
    }
  }
  return str;
}

function oficial_msgLog(msg)
{
  if (this.iface.tedLog != undefined )
    this.iface.tedLog.append("-> " + msg);
  else
    debug(msg); 
}

function oficial_progLog(s, ts, lp)
{
  var por = s / ts;
  var p = parseInt(por * 50);
  
  if (!p || p == lp)
    return p;
  
  var str = "";
  for (var i = 0; i < p; ++i)
    str += "#"
  
  por = Math.floor(por*100);
  str += " " + por.toString() + "%";
  this.iface.msgLog(str);
  sys.processEvents();
  
  return p;
}

function oficial_setTedLog(ted)
{
  this.iface.tedLog = ted;
}

function oficial_datoCampo(tipo, datoValor, datoFichero, linea) {
  switch (tipo) {
  case "valor":
    return datoValor;
  case "funcion":
    if (this.iface.strFunciones.find("#" + datoValor + "#") == -1) {
      var code = this.iface.util.quickSqlSelect("dat_funciones", "codigo", "id = '" + datoValor + "'");
      if (!code || code == undefined)
        return undefined;  
      code = code.replace("new FLUtil", "formRecorddat_procesos_lotes.iface.util");
      this.iface.cacheFunciones[datoValor] = new Function(code);
      this.iface.strFunciones += "#" + datoValor + "#";
    }
    return this.iface.cacheFunciones[datoValor](linea);
  default:
    return datoFichero;
  }
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
