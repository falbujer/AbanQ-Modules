/***************************************************************************
                              dat_procesos.qs
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
   bajo  los  términos  de  la  Licencia  Pública General de GNU   en  su
   versión 2, publicada  por  la  Free  Software Foundation.
 ***************************************************************************/

/** @File */

////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
/** @class_declaration interna */
//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
class interna
{
  var ctx;
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
  var sep = 'ð';
  var rutaDatos = "";
  var fichero = "";
  var nuevosAimportar = 0;
  var camposPublico = [];
  var valores = [];

  function oficial(context)
  {
    interna(context);
  }
  function establecerFichero()
  {
    return this.ctx.oficial_establecerFichero();
  }
  function actualizarControles()
  {
    return this.ctx.oficial_actualizarControles();
  }
  function actualizarFichero()
  {
    return this.ctx.oficial_actualizarFichero();
  }
  function actualizarTabla()
  {
    return this.ctx.oficial_actualizarTabla();
  }
  function importar_clicked()
  {
    return this.ctx.oficial_importar_clicked();
  }
  function importar(cursor, fichero)
  {
    return this.ctx.oficial_importar(cursor, fichero);
  }
  function pbnVaciar_clicked()
  {
    return this.ctx.oficial_pbnVaciar_clicked();
  }
  function consultarNulo(campo, registro)
  {
    return this.ctx.oficial_consultarNulo(campo, registro);
  }
  function crearValoresDefecto()
  {
    return this.ctx.oficial_crearValoresDefecto();
  }
  function bufferChanged(fN)
  {
    return this.ctx.oficial_bufferChanged(fN);
  }
  function preprocesarFichero(tabla, file, indicePK, tipos,
                              camposFichero, posiciones, camposTabla)
  {
    return this.ctx.oficial_preprocesarFichero(tabla, file, indicePK, tipos,
                                               camposFichero, posiciones, camposTabla);
  }
  function leerLinea(file, numCampos)
  {
    return this.ctx.oficial_leerLinea(file, numCampos);
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
  function pub_importar(cursor, fichero)
  {
    return this.importar(cursor, fichero);
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
function init()
{
  this.iface.init();
}

function interna_init()
{
  var util: FLUtil = new FLUtil();
  var tdbTabla: FLTableDB = this.child("tdbTabla");

  tdbTabla.setReadOnly(true);

  var cursor: FLSqlCursor = this.cursor();
  this.iface.fichero = "";
  this.iface.rutaDatos = util.sqlSelect("dat_opciones", "rutaDatos", "");
  if (cursor.valueBuffer("ficherocsv") && this.iface.rutaDatos) {
    this.iface.fichero = this.iface.rutaDatos + cursor.valueBuffer("ficherocsv");
    this.iface.actualizarTabla();
    this.iface.actualizarFichero();
  }

  this.iface.actualizarControles();

  connect(this.child("pbExaminar"), "clicked()", this, "iface.establecerFichero");
  connect(this.child("pbnImportar"), "clicked()", this, "iface.importar_clicked");
  connect(this.child("pbnVaciar"), "clicked()", this, "iface.pbnVaciar_clicked");
  connect(this.cursor(), "bufferChanged(QString)", this, "iface.bufferChanged");

  this.child("fdbFicheroCSV").setDisabled(true);
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_establecerFichero()
{
  var util: FLUtil = new FLUtil();

  this.iface.rutaDatos = util.sqlSelect("dat_opciones", "rutaDatos", "");
  if (!File.isDir(this.iface.rutaDatos)) {
    MessageBox.warning(util.translate("scripts",
                                      "La ruta de datos no ha sido establecida\nPuedes hacerlo en el formulario de ficheros"),
                       MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
    return 0;
  }

  var rutaFich: String = FileDialog.getOpenFileName(util.translate("scripts", "Texto CSV (*.txt;*.csv;)"),
                                                    util.translate("scripts", "Elegir Fichero"));
  var F = new File(rutaFich);

  if (F.path + "/" != this.iface.rutaDatos) {
    MessageBox.warning(util.translate("scripts", "Sólo es posible seleccionar ficheros de la ruta de datos:\n\n") +
                       this.iface.rutaDatos,
                       MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
    return 0;
  }

  this.child("fdbFicheroCSV").setValue(F.name);

  this.iface.fichero = F.fullName;
  this.iface.actualizarFichero();
  this.iface.actualizarControles();
}

function oficial_actualizarControles()
{
  var tblFichero: FLTableDB = this.child("tblFichero");
  var pbnImportar: Object = this.child("pbnImportar");
  var pbnVaciar: Object = this.child("pbnVaciar");
  var curTabla: FLSqlCursor = this.child("tdbTabla").cursor();

  if (curTabla.size() == 0) pbnVaciar.enabled = false;
  else pbnVaciar.enabled = true;

  if (tblFichero.currentRow() < 0) pbnImportar.enabled = false;
  else pbnImportar.enabled = true;
}

function oficial_actualizarFichero()
{
  var util: FLUtil = new FLUtil();

  var cursor: FLSqlCursor = this.cursor();
  var codEsquema: String = cursor.valueBuffer("codesquema");

  if (!this.iface.fichero || !codEsquema) return;

  var curEsquema: FLSqlCursor = new FLSqlCursor("dat_esquemas");
  curEsquema.select("codesquema = '" + codEsquema + "'");
  if (!curEsquema.first()) return;

  var numCampos: Number = util.sqlSelect("dat_correspondencias", "COUNT(*)", "codesquema = '" + codEsquema + "'");
  if (numCampos == false) numCampos = 0;

  var tblFichero: FLTableDB = this.child("tblFichero");
  var i: Number;

  while (tblFichero.numRows() > 0)
    tblFichero.removeRow(0);
  tblFichero.setNumCols(0);
  tblFichero.setNumCols(numCampos);
  for (i = 0; i < numCampos; i++)
    tblFichero.setColumnWidth(i, 100);

  var qryCor: FLSqlQuery = new FLSqlQuery();
  qryCor.setTablesList("dat_correspondencias");
  qryCor.setSelect("campotabla, campofichero, posicion, tipo");
  qryCor.setFrom("dat_correspondencias");
  qryCor.setWhere("codesquema = '" + codEsquema + "' ORDER BY tipo, posicion, id ASC");/// Se ordena primero por tipo porque los CAMPOS son los del fichero y su posición debe coincidir con la real en el fichero. Luego se ordena por FUNCION y VALOR, que da igual donde vayan.

  if (!qryCor.exec()) return;

  if (!qryCor.first()) return;

  var codTabla: String = curEsquema.valueBuffer("codtabla");
  var regExp: RegExp = new RegExp(this.iface.sep);
  regExp.global = true;
  var labels: String = util.fieldNameToAlias(qryCor.value(0), codTabla).replace(regExp, "-");
  var posiciones: Array = [];
  var camposFichero: Array = [];
  var tipos: Array = [];

  i = 0;
  camposFichero[i] = qryCor.value(1);
  posiciones[i] = qryCor.value(2);
  tipos[i++] = qryCor.value(3);
  while (qryCor.next()) {
    labels += " " + this.iface.sep + util.fieldNameToAlias(qryCor.value(0), codTabla).replace(regExp, "-");
    camposFichero[i] = qryCor.value(1);
    posiciones[i] = qryCor.value(2);
    tipos[i++] = qryCor.value(3);
  }
  tblFichero.setColumnLabels(this.iface.sep, labels);

  var j: Number = 0;
  var filaCampos: Boolean = util.sqlSelect("dat_ficheros", "filacampos", "codfichero = '" + curEsquema.valueBuffer("codfichero") + "'");
  if (filaCampos) j = 1;
  var lineas: Array = formRecorddat_ficheros.iface.pub_leerLineas(this.iface.fichero, j, j + 5);
  var linea: Array = [];

  var paso = 0;
  for (i = 0; i < lineas.length; i++) {
    paso++;
    tblFichero.insertRows(i);
    linea = lineas[i].split(this.iface.sep);
    for (j = 0; j < numCampos; j++) {
      if (posiciones[j] < linea.length) {
        var valor = fldatosppal.iface.pub_datoCampo(tipos[j], camposFichero[j], linea[posiciones[j]], linea)
                    tblFichero.setText(i, j, valor);
      } else tblFichero.setText(i, j, "** POSICION DEL CAMPO FUERA DE RANGO");
    }
  }
}

function oficial_actualizarTabla()
{
  var cursor: FLSqlCursor = this.cursor();
  var codEsquema: String = cursor.valueBuffer("codesquema");
  var tdbTabla: FLTableDB = this.child("tdbTabla");
  if (!codEsquema) {
    tdbTabla.setTableName("dat_void");
    tdbTabla.refresh(true, true);
    return;
  }

  var curEsquema: FLSqlCursor = new FLSqlCursor("dat_esquemas");
  curEsquema.select("codesquema = '" + codEsquema + "'");
  if (!curEsquema.first()) {
    tdbTabla.setTableName("dat_void");
    tdbTabla.refresh(true, true);
    return;
  }

  tdbTabla.setTableName(curEsquema.valueBuffer("codtabla"));
  tdbTabla.refresh(true, true);
}

function oficial_importar_clicked()
{
  var cursor: FLSqlCursor = this.cursor();
  this.setDisabled(true);

  if (!this.iface.importar(cursor, this.iface.fichero)) {
    this.setDisabled(false);
    return false;
  }

  this.child("tdbTabla").refresh();
  this.setDisabled(false);
  this.iface.actualizarControles();
}

function oficial_importar(cursor: FLSqlCursor, fichero: String): Boolean {
  var util: FLUtil = new FLUtil;
  var codEsquema: String = cursor.valueBuffer("codesquema");

  if (cursor.inTransaction())
  {
    cursor.rollback();
    cursor.transaction(false);
  }

  if (!fichero || fichero == "" || !codEsquema || codEsquema == "")
  {
    return false;
  }
  var curEsquema: FLSqlCursor = new FLSqlCursor("dat_esquemas");
  curEsquema.select("codesquema = '" + codEsquema + "'");
  if (!curEsquema.first())
  {
    return false;
  }

  var curTabla: FLSqlCursor = new FLSqlCursor(curEsquema.valueBuffer("codtabla"));

  // Obtener el campo clave
  var pk: String = curTabla.primaryKey();
  var indicePK: Number = 0;

  curTabla.setActivatedCommitActions(false);
  curTabla.setActivatedCheckIntegrity(true);
  if (cursor.valueBuffer("nocheckintegridad"))
  {
    curTabla.setActivatedCheckIntegrity(false);
  }
  if (cursor.valueBuffer("commitacciones"))
  {
    curTabla.setActivatedCommitActions(true);
  }
  var totalSteps: Number = formRecorddat_ficheros.iface.pub_numeroLineas(fichero);

  if (totalSteps > 0)
  {
    var qryCor: FLSqlQuery = new FLSqlQuery();
    qryCor.setTablesList("dat_correspondencias");
    qryCor.setSelect("campotabla, campofichero, posicion, tipo");
    qryCor.setFrom("dat_correspondencias");
    qryCor.setWhere("codesquema = '" + codEsquema + "' ORDER BY tipo,posicion,id ASC");/// Se ordena primero por tipo porque los CAMPOS son los del fichero y su posición debe coincidir con la real en el fichero. Luego se ordena por FUNCION y VALOR, que da igual donde vayan.

    if (!qryCor.exec()) {
      return false;
    }
    if (!qryCor.first()) {
      return false;
    }
    var regExp: RegExp = new RegExp(this.iface.sep);
    regExp.global = true;
    var camposTabla: String = qryCor.value(0).replace(regExp, "-");
    var posiciones: Array = [];
    var camposFichero: Array = [];
    this.iface.camposPublico = [];
    var tipos: Array = [];

    var i = 0;
    if (qryCor.value(0) == pk) indicePK = qryCor.value(2);
    camposFichero[i] = qryCor.value(1);
    this.iface.camposPublico[i] = qryCor.value(0).replace(regExp, "-");
    posiciones[i] = qryCor.value(2);
    tipos[i++] = qryCor.value(3);
    while (qryCor.next()) {

      if (qryCor.value(0) == pk) indicePK = qryCor.value(2);

      camposTabla += this.iface.sep + qryCor.value(0).replace(regExp, "-");
      this.iface.camposPublico[i] = qryCor.value(0).replace(regExp, "-");
      camposFichero[i] = qryCor.value(1);
      posiciones[i] = qryCor.value(2);
      tipos[i++] = qryCor.value(3);
    }

    this.iface.crearValoresDefecto();

    // Cargamos las líneas desde el fichero
    var linea: Array = [];
    var campos: Array = [];
    campos = camposTabla.split(this.iface.sep);
    var codTabla: String = curEsquema.valueBuffer("codtabla");
    var longitud: Number;
    var permiteNulo: Boolean;
    var valor;
    var ignorarRegistro: Boolean;
    var endNow = false;

    this.iface.nuevosAimportar = 0;
    var lineas = this.iface.preprocesarFichero(codTabla, fichero, indicePK, tipos, camposFichero, posiciones, campos);
    var actSobre: Boolean = cursor.valueBuffer("actsobre");

    if (this.iface.nuevosAimportar > 0) {
      totalSteps = this.iface.nuevosAimportar;
    }
    util.createProgressDialog(util.translate("scripts", "Importando datos..."), totalSteps);
    var paso = 0;
    var lblInfo = util.translate("scripts", "Importando datos. Registro %1 de %2");
    var alongs = new Array(campos.length);
    var anulls = new Array(campos.length);
    for (var j = 0; j < campos.length; ++j) {
      alongs[j] = util.fieldLength(campos[j], codTabla);
      anulls[j] = util.fieldAllowNull(campos[j], codTabla);
    }
    for (var ii = 0; ii < lineas.length; ++ii) {
      ++paso;
      ignorarRegistro = false;

      linea = lineas[ii].split(this.iface.sep);
      if (actSobre) {
        var valPk = fldatosppal.iface.pub_datoCampo(tipos[indicePK], camposFichero[indicePK], linea[indicePK], linea);
        if (valPk == "ignorar")
          continue;
        curTabla.setModeAccess(curTabla.Edit);
        curTabla.select(pk + "='" + valPk + "'");
        if (!curTabla.first()) {
          continue;
        }
      } else {
        curTabla.setModeAccess(curTabla.Insert);
      }
      curTabla.refreshBuffer();


      for (var j = 0; j < campos.length; ++j) {
        if (actSobre && campos[j] == pk) {
          continue;
        }
        if (posiciones[j] < linea.length) {
          valor = fldatosppal.iface.pub_datoCampo(tipos[j], camposFichero[j], linea[posiciones[j]], linea);
          longitud = alongs[j];
          permiteNulo = anulls[j];

          if (!permiteNulo && valor == "") {
            do {
              valor = this.iface.consultarNulo(campos[j], paso);
              if (this.iface.valores[campos[j]]["ignorar"]) {
                ignorarRegistro = true;
                break;
              }
              if ((!valor || valor == "") && MessageBox.Yes == MessageBox.critical(
                    util.translate("scripts", "El valor especificado no es válido\n¿Desea cancelar el proceso?"),
                    MessageBox.No, MessageBox.Yes, MessageBox.NoButton)) {
                endNow = true;
                break;
              }
            } while (!valor || valor == "");
          }

          if (endNow) {
            break;
          }
          if (!ignorarRegistro && valor == "ignorar") {
            ignorarRegistro = true;
          }
          if (ignorarRegistro) {
            break;
          }
          if (!valor) {
            continue;
          }
          if (longitud > 0 && valor.toString().length > longitud) {
            curTabla.setValueBuffer(campos[j], valor.left(longitud));
          } else {
            curTabla.setValueBuffer(campos[j], valor);
          }
        }
      }

      if (endNow) {
        break;
      }
      if (!ignorarRegistro) {
        if (!curTabla.commitBuffer()) {
          var res = MessageBox.critical(util.translate("scripts", "Se produjo un error en la importación\n¿Desea continuar?"),
                                        MessageBox.No, MessageBox.Yes);
          if (res != MessageBox.Yes) {
            break;
          }
        }
      }

      util.setLabelText(lblInfo.arg(paso).arg(lineas.length));
      util.setProgress(paso);
    }

    util.setProgress(totalSteps);
    util.destroyProgressDialog();
  }

  //curTabla.setActivatedCommitActions(false);
  return true;
}

function oficial_pbnVaciar_clicked()
{
  var util: FLUtil = new FLUtil();
  var res =
    MessageBox.critical(
      util.translate("scripts",
                     "Esta acción es peligrosa, se va a proceder a eliminar\ntodos los registros de la tabla.\n\n¿Está realmente seguro?"),
      MessageBox.No, MessageBox.Yes, MessageBox.NoButton
    );

  if (res != MessageBox.Yes) return;

  var codEsquema: String = this.cursor().valueBuffer("codesquema");

  var curEsquema: FLSqlCursor = new FLSqlCursor("dat_esquemas");
  curEsquema.select("codesquema = '" + codEsquema + "'");
  if (!curEsquema.first()) return;

  this.setDisabled(true);

  var curTabla: FLSqlCursor = new FLSqlCursor(curEsquema.valueBuffer("codtabla"));
  var step: Number = 0;

  curTabla.select();
  var totalSteps: Number = curTabla.size();
  util.createProgressDialog(util.translate("scripts", "Eliminando registros..."), totalSteps);
  while (curTabla.next()) {
    curTabla.setModeAccess(curTabla.Del);
    curTabla.refreshBuffer();
    if (!curTabla.commitBuffer()) break;
    util.setProgress(step++);
  }
  util.setProgress(totalSteps);
  util.destroyProgressDialog();

  this.child("tdbTabla").refresh();
  this.setDisabled(false);
  this.iface.actualizarControles();
}

function oficial_consultarNulo(campo, registro) : String {
  if (this.iface.valores[campo]["ignorar"]) return false;

  if (this.iface.valores[campo]["valor"] != "") return this.iface.valores[campo]["valor"];

  var util: FLUtil = new FLUtil();
  var dialog = new Dialog;
  dialog.caption = "Valores nulos";
  dialog.okButtonText = "Continuar"
  dialog.cancelButtonText = "Cancelar";

  var texto = new Label;

  texto.text = util.translate("scripts", "Algunos registros del fichero origen para el campo [%1]" + "\ncontienen valores vacíos.").arg(campo);
  texto.text += util.translate("scripts", " Se detectó el fallo en el registro nº %1" + "\n\nEscoja una opción:\n\n").arg(registro);
  dialog.add(texto);

  var valorD = new LineEdit;
  valorD.label = util.translate("scripts", "1. Introduzca el valor que tomará este campo para los valores vacíos");
  dialog.add(valorD);

  var ignorar = new CheckBox;
  ignorar.text = util.translate("scripts", "2. Ignorar todos registros con este campo vacío");
  dialog.add(ignorar);

  var texto2 = new Label;
  texto2.text = util.translate("scripts", "3. Pulse Cancelar para detener el proceso\n\n");
  dialog.add(texto2);

  if (dialog.exec())
  {
    if (ignorar.checked) {
      this.iface.valores[campo]["ignorar"] = true;
      return false;
    }
  }

  var valorDefecto: String = valorD.text;
  this.iface.valores[campo]["valor"] = valorDefecto;
  return valorDefecto;
}

function oficial_crearValoresDefecto()
{
  this.iface.valores = [];
  for (kj = 0; kj < this.iface.camposPublico.length; kj++) {
    this.iface.valores[this.iface.camposPublico[kj]] = new Array(2);
    this.iface.valores[this.iface.camposPublico[kj]]["valor"] = "";
    this.iface.valores[this.iface.camposPublico[kj]]["ignorar"] = false;
  }
}

function oficial_bufferChanged(fN)
{
  switch (fN) {
    case "codesquema":
      this.iface.actualizarFichero();
      this.iface.actualizarTabla();
      this.iface.actualizarControles();
      break;
    case "ficherocsv":
      this.iface.actualizarFichero();
      this.iface.actualizarTabla();
      this.iface.actualizarControles();
      break;
  }
}

/** Recorre el fichero buscando registros existentes y devuelve un
array con los registros nuevos
@param indicePK Es el índice (posición del campo clave en la tabla)
*/
function oficial_preprocesarFichero(tabla, fichero, indicePK, tipos, camposFichero, posiciones, camposTabla)
{
  var util = new FLUtil;
  var arrayLineas = [];

  if (!File.exists(fichero)) {
    MessageBox.warning(util.translate("scripts", "%1\n\nEl fichero no existe.").arg(fichero),
                       MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton)
    return arrayLineas;
  }

  if (!File.isFile(fichero)) {
    MessageBox.warning(util.translate("scripts", "%1\n\nNo es un fichero.").arg(fichero),
                       MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
    return arrayLineas;
  }

  var file = new File(fichero);

  if (!file.readable) {
    MessageBox.warning(util.translate("scripts", "%1\n\nAcceso de lectura denegado.").arg(fichero),
                       MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
    return arrayLineas;
  }

  var i = 0;
  var j = 0;
  var bufferLinea = "";
  var totalBuffer = [];

  file.open(File.ReadOnly);

  var linea = file.readLine();
  var campos = linea.split(this.iface.sep);
  var numCampos = campos.length;
  var numLineas = 0;
  var totalSteps = formRecorddat_ficheros.iface.pub_numeroLineas(fichero);
  var step = 0;

  // Todas las líneas
  if (!this.cursor().valueBuffer("noexistentes")) {
    AQUtil.createProgressDialog(sys.translate("Cargando fichero..."), totalSteps);
    while (!file.eof) {
      AQUtil.setProgress(++step);
      arrayLineas[numLineas++] = this.iface.leerLinea(file, numCampos);
    }
    AQUtil.setProgress(totalSteps);
    AQUtil.destroyProgressDialog();
    return arrayLineas;
  }

  // Sólo las nuevas
  var curTabla = new FLSqlCursor(tabla);
  //var pk:String = curTabla.primaryKey();
  // Para evitar duplicados
  var registrosActuales = this.iface.sep;
  var util = new FLUtil();
  var valor;
  var buscando;
  var newIndicePk = Input.getNumber(
                      util.translate("scripts",
                                     "Introduzca la posicion del campo en el fichero\na utilizar como clave para buscar duplicados"), 0);

  var pk = curTabla.primaryKey();//camposTabla[indicePK];
  //   var pkType = util.fieldType(pk, tabla);
  var q = new FLSqlQuery();

  q.setTablesList(tabla);
  q.setFrom(tabla);
  q.setSelect(pk);

  var registrosEnTabla = this.iface.sep ;
  q.exec();

  while (q.next())
    registrosEnTabla += q.value(0) + this.iface.sep;
	
	registrosEnTabla = registrosEnTabla.toUpperCase();

  step = 0;
  util.createProgressDialog(util.translate("scripts", "Buscando duplicados..."), totalSteps);

  while (!file.eof) {
    util.setProgress(++step);
    linea = this.iface.leerLinea(file, numCampos);
    campos = linea.split(this.iface.sep);
    valor = fldatosppal.iface.pub_datoCampo(tipos[newIndicePk], camposFichero[newIndicePk], campos[newIndicePk], campos);
    util.setLabelText(util.translate("scripts", "Buscando duplicado para : ") + valor);
debug("valor " + valor);
    buscando = this.iface.sep + campos[newIndicePk] + this.iface.sep;
		buscando = buscando.toUpperCase();
    ///     if (registrosEnTabla.search(campos[indicePK]) == -1) {
    ///       if (registrosActuales.search(campos[indicePK]) == -1) {
    if (registrosEnTabla.search(buscando) == -1) {
			debug("buscando " + buscando + " NO");
      if (registrosActuales.search(buscando) == -1) {
        arrayLineas[numLineas++] = linea;
      }
    } else {
			debug("buscando " + buscando + " SI");
		}
    /*
      q.setWhere(pk + " = '" + valor + "'");
      if ( !q.exec() ){
          util.destroyProgressDialog();
          break;
      }
      if (!q.first() && registrosActuales.search(campos[indicePK]) == -1)
        arrayLineas[numLineas++] = linea;*/

    /// registrosActuales += this.iface.sep + campos[indicePK];
    registrosActuales += (campos[newIndicePk] + this.iface.sep).toUpperCase();
  }
  util.setProgress(totalSteps);
  util.destroyProgressDialog();

  MessageBox.information(
    util.translate("scripts", "Se encontraron %0 nuevos registros para importar. Pulse Aceptar para continuar").arg(numLineas),
    MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);

  this.iface.nuevosAimportar = numLineas;
  return arrayLineas;
}

// Algunos registros contienen saltos de línea y ocupan
// varias líneas en el fichero csv
function oficial_leerLinea(file, numCampos) : String {
  var regExp = new RegExp("\"");
  regExp.global = true;
  var contCampos = 0;
  var linea = "";

  while (contCampos < numCampos)
  {
    var bufferLinea = file.readLine().replace(regExp, "");
    if (bufferLinea.left(1) == "#")
      continue;
    linea += bufferLinea;
    var totalBuffer = linea.split(this.iface.sep);
    contCampos = totalBuffer.length;
  }

  if (linea.charCodeAt(linea.length - 1) == 10)
    return linea.left(linea.length - 1);
  return linea;
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

