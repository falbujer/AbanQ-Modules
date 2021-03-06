/***************************************************************************
                             dat_ficheros.qs
                            -------------------
   begin                : lun dic 13 2004
   copyright            : (C) 2004-2005 by InfoSiAL S.L.
   email                : mail@infosial.com
***************************************************************************/
/***************************************************************************
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; version 2 of the License.               *
 ***************************************************************************/
/***************************************************************************
   Este  programa es software libre. Puede redistribuirlo y/o modificarlo
   bajo  los  t?rminos  de  la  Licencia  P?blica General de GNU   en  su
   versi?n 2, publicada  por  la  Free  Software Foundation.
 ***************************************************************************/

/** @file */

////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
/** @class_declaration interna */
//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
class interna {
  var ctx: Object;
  function interna(context) {
    this.ctx = context;
  }
  function init() {
    this.ctx.interna_init();
  }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
  var sep: String = "?";
  var ficheroCSV: String;
  var ficheroDBF: String;
  var rutaDatos: String;
  function oficial(context) {
    interna(context);
  }
  function establecerFichero() {
    return this.ctx.oficial_establecerFichero();
  }
  function dbf2csv() {
    return this.ctx.oficial_dbf2csv();
  }
  function numeroLineas(fichero) : Number {
    return this.ctx.oficial_numeroLineas(fichero);
  }
  function leerLineas(fichero, desde, hasta) : Array {
    return this.ctx.oficial_leerLineas(fichero, desde, hasta);
  }
  function actualizarMuestra() {
    return this.ctx.oficial_actualizarMuestra();
  }
  function actualizarCampos() {
    return this.ctx.oficial_actualizarCampos();
  }
  function bufferChanged(fN) {
    return this.ctx.oficial_bufferChanged(fN);
  }
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends oficial {
  function head(context) {
    oficial(context);
  }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
  function ifaceCtx(context) {
    head(context);
  }
  function pub_leerLineas(fichero, desde, hasta) : Array {
    return this.leerLineas(fichero, desde, hasta);
  }
  function pub_numeroLineas(fichero) : Number {
    return this.numeroLineas(fichero);
  }
}

const iface = new ifaceCtx(this);
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
El campo de fichero aparece inhabilitado, s?lo se puede seleccionar un fichero 
mediante el bot?n "Seleccionar Fichero"

Al seleccionar el fichero de disco, si el mismo tiene formato DBF se convertir? 
autom?ticamente a CSV. Si es CSV se tomar? directamente. 

\end */
function interna_init() {
  connect(this.child("pbExaminar"), "clicked()", this, "iface.establecerFichero");
  connect(this.cursor(), "bufferChanged(QString)", this, "iface.bufferChanged");
  connect(this.child("tdbCampos").cursor(), "bufferCommited()", this, "iface.actualizarMuestra");
  this.child("fdbFicheroDatos").setDisabled(true);
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D Abre el cuadro di di?logo para establecer el fichero de datos
de origen y actualiza la muestra. Si el fichero es de formato DBF lo convierte
a CSV
\end */
function oficial_establecerFichero() {
  var util: FLUtil = new FLUtil();

  this.iface.rutaDatos = util.sqlSelect("dat_opciones", "rutaDatos", "");
  if (!File.isDir(this.iface.rutaDatos)) {
    MessageBox.warning(util.translate("scripts", "La ruta de datos no ha sido establecida"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
    return 0;
  }

  var rutaFich: String = FileDialog.getOpenFileName(util.translate("scripts", "Texto CSV (*.txt;*.csv;*.dbf;*.DBF)"), util.translate("scripts", "Elegir Fichero"));

  if (rutaFich == "") return;

  var F = new File(rutaFich);
  if (F.path + "/" != this.iface.rutaDatos) {
    MessageBox.warning(util.translate("scripts", "S?lo es posible seleccionar ficheros de la ruta de datos:\n\n") + this.iface.rutaDatos, MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
    return 0;
  }

  this.child("fdbFicheroDatos").setValue(F.baseName);

  if (F.extension == "dbf" || F.extension == "DBF") {
    this.iface.ficheroDBF = F.fullName;
    this.iface.ficheroCSV = F.path + "/" + F.baseName + ".csv";
    this.iface.dbf2csv();
  }
  else {
    this.iface.ficheroCSV = F.fullName;
    this.iface.actualizarMuestra();
  }
}

/** \D Convierte un fichero DBF a CSV mediante una llamada al script 
de sistema dbf incluido en el directorio bin de la instalaci?n de
FacturaLUX. A continuaci?n actualiza la muestra de datos
\end */
function oficial_dbf2csv() {
  var util: FLUtil = new FLUtil();

  var arg0: String = sys.installPrefix() + "/bin/dbf";
  var arg1: String = " --csv " + this.iface.ficheroCSV;
  var arg2: String = " --separator " + this.iface.sep + " ";
  var arg3: String = this.iface.ficheroDBF;

  Process.execute(arg0 + arg1 + arg2 + arg3);

  if (!File.exists(this.iface.ficheroCSV)) {
    MessageBox.warning(util.translate("scripts", "No fue posible crear el fichero\n%1\na partir del DBF.\n\nAseg?rese de que los permisos de escritura son correctos").arg(this.iface.ficheroCSV), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
    return;
  }
  this.iface.actualizarMuestra();
}

/** \D Devuelve el n?mero de l?neas de un fichero. Se utiliza para crear
los cuadros de progreso
@return N?mero de l?neas del fichero
\end */
function oficial_numeroLineas(fichero) : Number {
  var util: FLUtil = new FLUtil();

  if (!File.exists(fichero)) {
    MessageBox.warning(util.translate("scripts", "%1\n\nEl fichero no existe.").arg(fichero), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
    return 0;
  }

  if (!File.isFile(fichero)) {
    MessageBox.warning(util.translate("scripts", "%1\n\nNo es un fichero.").arg(fichero), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
    return 0;
  }

  var file = new File(fichero);

  if (!file.readable) {
    MessageBox.warning(util.translate("scripts", "%1\n\nAcceso de lectura denegado.").arg(fichero), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
    return 0;
  }

  file.open(File.ReadOnly);
  var ret = file.readLines().length;
  file.close();

  return ret;
}

/** \D Lee el contenido de un fichero CSV e introduce cada l?nea como un elemento
de un array de strings. Ignora las l?neas que comienzan por '#'
@return Array con el contenido del fichero
\end */
function oficial_leerLineas(fichero, desde, hasta) : Array {
  var lineas: Array = [];

  if (desde < 0 || hasta < 0 || desde > hasta) return lineas;

  var util: FLUtil = new FLUtil();

  if (!File.exists(fichero)) {
    MessageBox.warning(util.translate("scripts", "%1\n\nEl fichero no existe.").arg(fichero), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
    return lineas;
  }

  if (!File.isFile(fichero)) {
    MessageBox.warning(util.translate("scripts", "%1\n\nNo es un fichero.").arg(fichero), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
    return lineas;
  }

  var file = new File(fichero);

  if (!file.readable) {
    MessageBox.warning(util.translate("scripts", "%1\n\nAcceso de lectura denegado.").arg(fichero), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
    return lineas;
  }

  var i: Number = 0;
  var j: Number = 0;
  var bufferLinea: String;
  var arrayBuffer = [];

  file.open(File.ReadOnly);
  bufferLinea = file.readLine();
  arrayLinea = bufferLinea.split(this.iface.sep);
  var numCampos: Number = arrayLinea.length;
  file.close();

  file.open(File.ReadOnly);

  for (i = 0; i < desde && !file.eof; i++)
  file.readLine();

  var regExp: RegExp = new RegExp("\"");
  regExp.global = true;
  while (!file.eof && i <= hasta) {

    contCampos = 0;
    lineas[j] = "";

    while (contCampos < numCampos) {
      bufferLinea = file.readLine().replace(regExp, "");
      if (bufferLinea.left(1) == "#") continue;
      lineas[j] += bufferLinea;
      arrayBuffer = bufferLinea.split(this.iface.sep);
      contCampos += arrayBuffer.length;
    }

    i++;
    j++;
    if (file.eof) continue;
  }

  file.close();
  return lineas;
}

/** \D Actualiza la muestra de datos con los contenidos del fichero CSV
\end */
function oficial_actualizarMuestra() {
  var fichero: String = this.iface.ficheroCSV;

  if (fichero == "") return;

  var cursor: FLSqlCursor = this.cursor();
  var numCampos: String = this.child("tdbCampos").cursor().size();
  var tblMuestra: FLTableDB = this.child("tblMuestra");

  while (tblMuestra.numRows() > 0)
  tblMuestra.removeRow(0);
  tblMuestra.setNumCols(0);
  tblMuestra.setNumCols(numCampos);
  for (var i = 0; i < numCampos; i++)
  tblMuestra.setColumnWidth(i, 100);

  var qryCampos: FLSqlQuery = new FLSqlQuery();
  qryCampos.setTablesList("dat_campos");
  qryCampos.setSelect("nombre, posicion");
  qryCampos.setFrom("dat_campos");
  qryCampos.setWhere("codfichero = '" + cursor.valueBuffer("codfichero") + "' ORDER BY posicion");

  if (!qryCampos.exec()) return;

  if (!qryCampos.first()) return;

  var regExp: RegExp = new RegExp(this.iface.sep);
  regExp.global = true;
  var labels: String = qryCampos.value(0).replace(regExp, "-");
  var posiciones: Array = [];
  var i: Number = 0;
  posiciones[i++] = qryCampos.value(1);
  while (qryCampos.next()) {
    labels += this.iface.sep + qryCampos.value(0).replace(regExp, "-");
    posiciones[i++] = qryCampos.value(1);
  }
  tblMuestra.setColumnLabels(this.iface.sep, labels);

  var j: Number = 0;
  if (cursor.valueBuffer("filacampos")) j = 1;
  var lineas: Array = this.iface.leerLineas(fichero, j, j + 5);
  var linea: Array = [];

  for (i = 0; i < lineas.length; i++) {
    tblMuestra.insertRows(i);
    linea = lineas[i].split(this.iface.sep);
    for (j = 0; j < numCampos; j++) {
      if (posiciones[j] < linea.length) tblMuestra.setText(i, j, linea[posiciones[j]]);
      else tblMuestra.setText(i, j, "** POSICION DEL CAMPO FUERA DE RANGO");
    }
  }
}

/** \D Actualiza el listado de los campos del fichero tras regenerarlos
\end */
function oficial_actualizarCampos() {
  var fichero: String = this.iface.ficheroCSV;
  var fdbFilaCampos: Boolean = this.child("fdbFilaCampos");

  if (fichero == "") {
    fdbFilaCampos.setValue(false);
    return;
  }

  var cursor: FLSqlCursor = this.cursor();
  var filaCampos: Boolean = cursor.valueBuffer("filacampos");

  if (filaCampos == false) {
    this.iface.actualizarMuestra();
    return;
  }

  var util: FLUtil = new FLUtil();
  var curTdbCampos: FLSqlCursor = this.child("tdbCampos").cursor();

  if (curTdbCampos.size() > 0) {
    var res = MessageBox.warning(util.translate("scripts", "Si activa esta opci?n la lista de campos actual ser? eliminada\ny se generar? una nueva con el contenido de la primera fila del fichero.\n\n?Desea continuar?"), MessageBox.No, MessageBox.Yes, MessageBox.NoButton);
    if (res != MessageBox.Yes) {
      fdbFilaCampos.setValue(false);
      return;
    }
  }

  this.setDisabled(true);

  var codFichero: String = cursor.valueBuffer("codfichero");
  var curCampos: FLSqlCursor = new FLSqlCursor("dat_campos");
  curCampos.select("codfichero = '" + codFichero + "'");
  var totalSteps: Number = curCampos.size();

  if (totalSteps > 0) {
    util.createProgressDialog(util.translate("scripts", "Eliminando campos..."), totalSteps);
    var step: Number = 0;
    while (curCampos.next()) {
      curCampos.setModeAccess(curCampos.Del);
      curCampos.refreshBuffer();
      if (!curCampos.commitBuffer()) break;
      util.setProgress(step++);
    }
    util.setProgress(totalSteps);
    util.destroyProgressDialog();
  }

  var lineas: Array = this.iface.leerLineas(fichero, 0, 0);
  if (lineas.length == 0) {
    this.setDisabled(false);
    return;
  }

  var linea: Array = lineas[0].split(this.iface.sep);
  totalSteps = linea.length;

  if (totalSteps > 0) {
    util.createProgressDialog(util.translate("scripts", "Generando campos..."), totalSteps);
    step = 0;
    curTdbCampos.setModeAccess(curTdbCampos.Insert);
    curTdbCampos.refreshBuffer();
    curTdbCampos.setValueBuffer("posicion", 0);
    curTdbCampos.setValueBuffer("nombre", linea[0]);
    curTdbCampos.setValueBuffer("codfichero", codFichero);
    util.setProgress(step++);
    if (curTdbCampos.commitBuffer()) {
      for (i = 1; i < totalSteps - 1; i++) {
        curCampos.setModeAccess(curCampos.Insert);
        curCampos.refreshBuffer();
        curCampos.setValueBuffer("posicion", i);
        curCampos.setValueBuffer("nombre", linea[i]);
        curCampos.setValueBuffer("codfichero", codFichero);
        util.setProgress(step++);
        if (!curCampos.commitBuffer()) break;
      }
      curTdbCampos.setModeAccess(curTdbCampos.Insert);
      curTdbCampos.refreshBuffer();
      curTdbCampos.setValueBuffer("posicion", i);
      curTdbCampos.setValueBuffer("nombre", linea[i]);
      curTdbCampos.setValueBuffer("codfichero", codFichero);
      util.setProgress(step++);
      curTdbCampos.commitBuffer();
    } else fdbFilaCampos.setValue(false);
    util.setProgress(totalSteps);
    util.destroyProgressDialog();
  }

  this.setDisabled(false);
}

function oficial_bufferChanged(fN) {
  /** \C Cuando --filacampos-- est? marcado, se buscar? autom?ticamente dentro de la
primera fila de texto del fichero en disco los nombres de los campos y se crear?n los
registros de campos correspondientes
\end */
  switch (fN) {
  case "filacampos":
    if (this.child("fdbFicheroDatos").value() == "" && this.cursor().valueBuffer("filacampos") == true) {
      var util: FLUtil = new FLUtil();
      MessageBox.warning(util.translate("scripts", "Para activar esta opci?n, primero tiene\nque seleccionar un fichero de muestra.\n"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
      this.child("fdbFilaCampos").setValue(false);
      return;
    }
    this.iface.actualizarCampos();
    break;
  }
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

