/***************************************************************************
                             dat_esquemas.qs
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
   bajo  los  t�rminos  de  la  Licencia  P�blica General de GNU   en  su
   versi�n 2, publicada  por  la  Free  Software Foundation.
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
  var sep: String = "�";
  var rutaDatos: String;
  function oficial(context) {
    interna(context);
  }
  function establecerFichero() {
    return this.ctx.oficial_establecerFichero();
  }
  function agregarCorrespondencia() {
    return this.ctx.oficial_agregarCorrespondencia();
  }
  function quitarCorrespondencia() {
    return this.ctx.oficial_quitarCorrespondencia();
  }
  function enCorrespondencia(campo, valorCampo) : Boolean {
    return this.ctx.oficial_enCorrespondencia(campo, valorCampo);
  }
  function actualizarCamposFichero() {
    return this.ctx.oficial_actualizarCamposFichero();
  }
  function actualizarCamposTabla() {
    return this.ctx.oficial_actualizarCamposTabla();
  }
  function actualizarControles() {
    return this.ctx.oficial_actualizarControles();
  }
  function actualizarMuestra() {
    return this.ctx.oficial_actualizarMuestra();
  }
  function borrarFuncion() {
    return this.ctx.oficial_borrarFuncion();
  }
  function borrarValorFijo() {
    return this.ctx.oficial_borrarValorFijo();
  }
  function bufferChanged(fN) {
    return this.ctx.oficial_bufferChanged();
  }
  function cambiarCalculado() {
    this.ctx.oficial_cambiarCalculado();
  }
  function cambiarJoinKey() {
    this.ctx.oficial_cambiarJoinKey();
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
Cuando se crea un nuevo esquema, en primer lugar se escogen el fichero de 
origen de los datos y la tabla FacturaLUX destino de los mismos.  A continuaci�n 
se acepta el formulario y se vuelve a abrir. De este modo aparecer�n los listados
de campos tanto en el fichero como en la tabla

El proceso de establecer correspondencias consiste en seleccionar parejas de campos
de fichero/tabla y pulsar el bot�n a�adir correspondencia.

Por defecto se realizar� un volcado directo del valor del campo del fichero al
campo de la tabla

Si se rellena la casilla "Valor Fijo" y a continuaci�n se pulsa el bot�n de a�adir
correspondencia, el valor rellenado pasar� al campo de la tabla seleccionado para
todos los registros, tal como se aprecia en la vista previa.

Si se rellena la casilla "Funci�n" y a continuaci�n se pulsa el bot�n de a�adir
correspondencia, el resultado de la funci�n pasar� al campo de la tabla seleccionado 
para cada registro, tal como se aprecia en la vista previa.

En el listado de correspondencias el valor de la columna "Tipo" indica si se trata
de un campo copiado literalmente, de una funci�n o de un valor fijo.
\end */
function interna_init() {
  var tblCF: FLTableDB = this.child("tblCamposFichero");
  var tblCT: FLTableDB = this.child("tblCamposTabla");
  var tdbCor: FLTableDB = this.child("tdbCor");

  tblCF.setNumCols(2);
  tblCF.setColumnWidth(0, 100);
  tblCF.setColumnWidth(1, 40);
  tblCF.setColumnLabels(this.iface.sep, "Nombre" + this.iface.sep + "Pos.");
  tblCF.hideColumn(1);

  tblCT.setNumCols(1);
  tblCT.setColumnWidth(1, 140);
  tblCT.setColumnLabels(this.iface.sep, "Nombre");

  tdbCor.setReadOnly(true);

  this.iface.actualizarCamposFichero();
  this.iface.actualizarCamposTabla();
  this.iface.actualizarControles();
  this.iface.actualizarMuestra();

  this.child("fdbIdFuncion").setValue("");
  this.child("fdbDescFuncion").setValue("");

  connect(this.child("pbExaminar"), "clicked()", this, "iface.establecerFichero");
  connect(this.child("pbnAgregar"), "clicked()", this, "iface.agregarCorrespondencia");
  connect(this.child("pbnQuitar"), "clicked()", this, "iface.quitarCorrespondencia");
  connect(this.child("pbnCalculado"), "clicked()", this, "iface.cambiarCalculado");
  connect(this.child("pbnJoinKey"), "clicked()", this, "iface.cambiarJoinKey");
  connect(this.cursor(), "bufferChanged(QString)", this, "iface.bufferChanged");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D Establece la ruta al fichero de datos y lanza una actualizaci�n de la muestra
\end */
function oficial_establecerFichero() {
  var util: FLUtil = new FLUtil();

  this.iface.rutaDatos = util.sqlSelect("dat_opciones", "rutaDatos", "");
  if (!File.isDir(this.iface.rutaDatos)) {
    MessageBox.warning(util.translate("scripts", "La ruta de datos no ha sido establecida\nPuedes hacerlo en el formulario de ficheros"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
    return 0;
  }

  var nomFichero: String = util.sqlSelect("dat_ficheros", "ficherodatos", "codfichero = '" + this.cursor().valueBuffer("codfichero") + "'");

  this.child("leFichero").text = this.iface.rutaDatos + nomFichero + ".csv";
  this.iface.actualizarMuestra();
}

/** \D Agrega al listado de correspondencias el par campo fichero / campo tabla seleccionado en ese momento
y actualiza los listados de ambos
\end */
function oficial_agregarCorrespondencia() {
  var curCor: FLSqlCursor = this.child("tdbCor").cursor();
  var tblCF: FLTableDB = this.child("tblCamposFichero");
  var tblCT: FLTableDB = this.child("tblCamposTabla");

  curCor.setModeAccess(curCor.Insert);
  curCor.refreshBuffer();
  curCor.setValueBuffer("campofichero", tblCF.text(tblCF.currentRow(), 0));
  curCor.setValueBuffer("campotabla", tblCT.text(tblCT.currentRow(), 0));
  curCor.setValueBuffer("posicion", tblCF.text(tblCF.currentRow(), 1));

  if (this.child("leValorFijo").text != "") {
    curCor.setValueBuffer("campofichero", this.child("leValorFijo").text);
    curCor.setValueBuffer("tipo", "valor");
    this.iface.borrarValorFijo();
  } else if (this.child("fdbIdFuncion").value() != "") {
    curCor.setValueBuffer("campofichero", this.child("fdbIdFuncion").value());
    curCor.setValueBuffer("tipo", "funcion");
    this.iface.borrarFuncion();
  }

  curCor.commitBuffer();

  this.iface.actualizarCamposFichero();
  this.iface.actualizarCamposTabla();
  this.iface.actualizarControles();
  this.iface.actualizarMuestra();
}

/** \D Elimina la correspondencia seleccionada y restituye los campos implicados
\end */
function oficial_quitarCorrespondencia() {
  var curCor: FLSqlCursor = this.child("tdbCor").cursor();

  curCor.setModeAccess(curCor.Del);
  curCor.refreshBuffer();
  curCor.commitBuffer();

  this.iface.actualizarCamposFichero();
  this.iface.actualizarCamposTabla();
  this.iface.actualizarControles();
  this.iface.actualizarMuestra();
}

/** \D Indica si un campo tiene ya asociada una correspondencia
@return true si el campo tiene correspondencia, false en otro caso
\end */
function oficial_enCorrespondencia(campo, valorCampo) : Boolean {
  if (!campo || campo == "" || !valorCampo || valorCampo == "") return false;

  if (this.child("tdbCor").cursor().size() == 0) return false;

  var codEsquema: String = this.cursor().valueBuffer("codesquema");
  if (!codEsquema || codEsquema == "") return false;

  var qryCor: FLSqlQuery = new FLSqlQuery();
  qryCor.setTablesList("dat_correspondencias");
  qryCor.setSelect(campo);
  qryCor.setFrom("dat_correspondencias");
  qryCor.setWhere(campo + " = '" + valorCampo + "' AND codesquema = '" + codEsquema + "'");

  if (qryCor.exec()) if (qryCor.next()) return true;

  return false;
}

/** \D Actualiza el listado de campos de fichero con todos salvo aquellos que ya tienen correspondencia
\end */
function oficial_actualizarCamposFichero() {
  var tblCF: FLTableDB = this.child("tblCamposFichero");
  var codFichero: String = this.cursor().valueBuffer("codfichero");

  this.setDisabled(true);

  while (tblCF.numRows() > 0)
  tblCF.removeRow(0);

  if (!codFichero || codFichero == "") {
    this.setDisabled(false);
    return;
  }

  var qryCampos: FLSqlQuery = new FLSqlQuery();
  qryCampos.setTablesList("dat_campos");
  qryCampos.setSelect("nombre,posicion");
  qryCampos.setFrom("dat_campos");
  qryCampos.setWhere("upper(codfichero) = '" + codFichero.upper() + "' ORDER BY posicion DESC");

  if (qryCampos.exec()) {
    while (qryCampos.next()) {
      if (!this.iface.enCorrespondencia("campofichero", qryCampos.value(0))) {
        tblCF.insertRows(0);
        tblCF.setText(0, 0, qryCampos.value(0));
        tblCF.setText(0, 1, qryCampos.value(1));
      }
    }
    tblCF.selectRow(0);
  }

  this.setDisabled(false);
}

/** \D Actualiza el listado de campos de tabla con todos salvo aquellos que ya tienen correspondencia
\end */
function oficial_actualizarCamposTabla() {
  var util: FLUtil = new FLUtil();
  var tblCT: FLTableDB = this.child("tblCamposTabla");
  var codTabla: String = this.cursor().valueBuffer("codtabla");

  this.setDisabled(true);

  while (tblCT.numRows() > 0)
  tblCT.removeRow(0);

  if (!codTabla || codTabla == "") {
    this.setDisabled(false);
    return;
  }

  var campos = util.nombreCampos(codTabla.lower());

  if (campos.length == 0) {
    this.setDisabled(false);
    return;
  }

  var numCampos: Number = parseInt(campos[0]);
  var i: Number;
  var j: Number = 0;

  if (numCampos > 0) {
    for (i = 1; i <= numCampos; i++) {
      if (!this.iface.enCorrespondencia("campotabla", campos[i])) {
        tblCT.insertRows(j);
        tblCT.setText(j, 0, campos[i]);
        j++;
      }
    }
    tblCT.selectRow(0);
  }

  this.setDisabled(false);
}

/** \D Actualizaci�n general de los controles del formulario: listados de campos de tabla y fichero, y botones
\end */
function oficial_actualizarControles() {
  var tblCF: FLTableDB = this.child("tblCamposFichero");
  var tblCT: FLTableDB = this.child("tblCamposTabla");
  var pbnAgregar: Object = this.child("pbnAgregar");
  var pbnQuitar: Object = this.child("pbnQuitar");
  var fdbCF: String = this.child("fdbCodFichero");
  var fdbCT: String = this.child("fdbCodTabla");
  var curCor: FLTableDB = this.child("tdbCor").cursor();

  // 	if ( !curCor.isValid() ) {
  // 		fdbCF.setDisabled( false );
  // 		fdbCT.setDisabled( false );
  // 		pbnQuitar.enabled = false;
  // 	} else {
  // 		fdbCF.setDisabled( true );
  // 		fdbCT.setDisabled( true );
  // 		pbnQuitar.enabled = true;
  // 	}
  
  if (tblCF.currentRow() < 0 || tblCT.currentRow() < 0) 
    pbnAgregar.enabled = false;
  else 
    pbnAgregar.enabled = true;
}

/** \D Lee el fichero de datos y actualiza la tabla de muestra con los datos que aparecen seg�n el esquema actual
\end */
function oficial_actualizarMuestra()
{
	fldatosppal.iface.pub_borrarCacheFunciones();
	
  var fichero: String = this.child("leFichero").text;
  if (fichero == "") return;

  var cursor: FLSqlCursor = this.cursor();
  var numCampos: Number = this.child("tdbCor").cursor().size();
  var tblMuestra: Object = this.child("tblMuestra");

  while (tblMuestra.numRows() > 0)
  tblMuestra.removeRow(0);
  tblMuestra.setNumCols(0);
  tblMuestra.setNumCols(numCampos);
  for (var i = 0; i < numCampos; i++)
  tblMuestra.setColumnWidth(i, 100);

  var qryCampos: FLSqlQuery = new FLSqlQuery();
  qryCampos.setTablesList("dat_correspondencias");
  qryCampos.setSelect("campotabla, campofichero, posicion, tipo");
  qryCampos.setFrom("dat_correspondencias");
  qryCampos.setWhere("codesquema = '" + cursor.valueBuffer("codesquema") + "' ORDER BY posicion");

  if (!qryCampos.exec()) return;

  if (!qryCampos.first()) return;

  var util: FLUtil = new FLUtil();
  var codTabla: String = cursor.valueBuffer("codtabla");
  var regExp: RegExp = new RegExp(this.iface.sep);
  regExp.global = true;

  var labels: String = util.fieldNameToAlias(qryCampos.value(0), codTabla).replace(regExp, "-");
  var posiciones: Array = [];
  var camposFichero: Array = [];
  var tipos: Array = [];

  var i: Number = 0;
  camposFichero[i] = qryCampos.value(1);
  posiciones[i] = qryCampos.value(2);
  tipos[i++] = qryCampos.value(3);

  while (qryCampos.next()) {
    labels += " " + this.iface.sep + util.fieldNameToAlias(qryCampos.value(0), codTabla).replace(regExp, "-");
    camposFichero[i] = qryCampos.value(1);
    posiciones[i] = qryCampos.value(2);
    tipos[i++] = qryCampos.value(3);
  }
  tblMuestra.setColumnLabels(this.iface.sep, labels);

  var j: String = 0;
  var filaCampos: Boolean = util.sqlSelect("dat_ficheros", "filacampos", "codfichero = '" + cursor.valueBuffer("codfichero") + "'");
  if (filaCampos) j = 1;
  var lineas: Array = formRecorddat_ficheros.iface.pub_leerLineas(fichero, j, j + 5);
  var linea: Array = [];

  var paso: Number = 0;
  var valor: String;
  for (i = 0; i < lineas.length; i++) {
    paso++;
    tblMuestra.insertRows(i);
    linea = lineas[i].split(this.iface.sep);
    for (j = 0; j < numCampos; j++) {
      if (posiciones[j] < linea.length) {
        valor = fldatosppal.iface.pub_datoCampo(tipos[j], camposFichero[j], linea[posiciones[j]], linea)
        tblMuestra.setText(i, j, valor);
      } else tblMuestra.setText(i, j, "** POSICION DEL CAMPO FUERA DE RANGO");
    }
  }
}

function oficial_bufferChanged(fN) {
  switch (fN) {
  case "codfichero":
    this.iface.actualizarCamposFichero();
    this.iface.actualizarControles();
    this.iface.actualizarMuestra();
    break;
  case "codtabla":
    this.iface.actualizarCamposTabla();
    this.iface.actualizarControles();
    this.iface.actualizarMuestra();
    break;
  case "idfuncion":
    this.iface.borrarValorFijo();
    break;
  }
}

/** \D Elimina el contenido del cuadro de valor fijo.
\end */
function oficial_borrarValorFijo() {
  this.child("leValorFijo").text = "";
}

/** \D Elimina el contenido del campo de funci�n.
\end */
function oficial_borrarFuncion() {
  this.child("fdbIdFuncion").setValue("");
}

function oficial_cambiarCalculado() {
  var curCor = this.child("tdbCor").cursor();
  if (curCor.isValid()) {
    var calculado = curCor.valueBuffer("calculado");
    curCor.setModeAccess(curCor.Edit);
    curCor.refreshBuffer();
    curCor.setValueBuffer("calculado", !calculado);
    curCor.commitBuffer();
  }
}

function oficial_cambiarJoinKey() {
  var curCor = this.child("tdbCor").cursor();
  if (curCor.isValid()) {
    var joinkey = curCor.valueBuffer("joinkey");
    curCor.setModeAccess(curCor.Edit);
    curCor.refreshBuffer();
    curCor.setValueBuffer("joinkey", !joinkey);
    curCor.commitBuffer();
  }
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

