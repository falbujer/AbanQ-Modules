/***************************************************************************
                 tt_importar.qs  -  description
                             -------------------
    begin                : jue abr 9 2005
    copyright            : (C) 2005 by InfoSiAL S.L.
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
	function main() { this.ctx.interna_main(); }
	function init() { this.ctx.interna_init(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var sep:String = "ÏÏ";
	var eol:String = "Ö";
	var pathLocal:String;
	var bloqueo:Boolean;
    var myUtil:FLUtil = new FLUtil();
	var lineasImportadas:Number;
	
    function oficial( context ) {interna( context ); } 
	function establecerFicheroPB() {
		return this.ctx.oficial_establecerFicheroPB();
	}
	function establecerFicheroFun() {
		return this.ctx.oficial_establecerFicheroFun();
	}
	function importarTabla(tabla:String, fichero:String):Number {
		return this.ctx.oficial_importarTabla(tabla, fichero);
	}
	function leerLinea(file:String):String {
		return this.ctx.oficial_leerLinea(file);
	}
	function preprocesarFichero(file:File):Array {
		return this.ctx.oficial_preprocesarFichero(file);
	}
	function crearProgress(label:String, numPasos:Number) {
		return this.ctx.oficial_crearProgress(label, numPasos);
	}
	function setProgress(valor:Number) {
		return this.ctx.oficial_setProgress(valor);
	}
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function importarPruebas(ruta:String):Number {
		return this.ctx.oficial_importarPruebas(ruta);
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

/** @class_declaration ifaceCtx*/
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
    function ifaceCtx( context ) { head( context ); }
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
/** \C Establece el campo --idfuncional-- con el valor de la funcionalidad actual
\end */
function interna_init()
{
	this.iface.pathLocal = fltestppal.iface.pub_obtenerPathLocal();
	this.iface.bloqueo = false;
	connect( this.child( "pbExaminarFun" ), "clicked()", this, "iface.establecerFicheroFun" );
	connect( this.child( "pbExaminarPB" ), "clicked()", this, "iface.establecerFicheroPB" );
	connect( this.cursor(), "bufferChanged(QString)", this, "iface.bufferChanged" );
	
	this.child("fdbIdFuncional").setValue(fltestppal.iface.pub_obtenerIdFuncional());
}

/** \D Importa las pruebas asociadasa a la funcionalidad indicada por el usuario
\end */
function interna_main()
{
	var util:FLUtil = new FLUtil();

	var f:Object = new FLFormSearchDB("tt_importar");
	var cursor:FLSqlCursor = f.cursor();
	
	cursor.select();
	if (!cursor.first())
		cursor.setModeAccess(cursor.Insert);
	else
		cursor.setModeAccess(cursor.Edit);
		
	f.setMainWidget();
	cursor.refreshBuffer();
	
	f.exec("dircsvpb");
	if (!f.accepted())
		return;
		
	var numPruebas:Number = 0;
	cursor.transaction(false);
	if (cursor.valueBuffer("incpb") && cursor.valueBuffer("dircsvpb")) {
		numPruebas = this.iface.importarPruebas(cursor.valueBuffer("dircsvpb"));
		if (numPruebas < 0) {
			cursor.rollback();
			return false;
		}
	}
	if (cursor.valueBuffer("incfun") && cursor.valueBuffer("dircsvfun")) {
		var numPruebasFun:Number = this.iface.importarPruebas(cursor.valueBuffer("dircsvfun"));
		if (numPruebasFun < 0) {
			cursor.rollback();
			return false;
		}
		numPruebas += numPruebasFun;
	}
	cursor.commit();
	MessageBox.information(this.iface.myUtil.translate( "scripts", "Proceso finalizado. Pruebas importadas: ") + numPruebas, MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
}

/** \D Importa las pruebas almacenadas en un determinado directorio

@param	ruta: Ruta al directorio de pruebas
@return	Número de pruebas importadas, -1 si hay error
\end */
function oficial_importarPruebas(ruta:String):Number
{
	if (!ruta)
		return -1;
		
	var resultImport:Number = 0;
	var numPruebas:Number = 0;
	
	var tabla:String = "tt_testcat";
	var fichero:String = ruta + "/" + tabla + ".csv";
	numPruebas = this.iface.importarTabla(tabla, fichero);
	if (numPruebas < 0) {
		MessageBox.warning(tabla + this.iface.myUtil.translate( "scripts", " - La tabla no se importó correctamente"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return -1;
	}

	tabla = "tt_stepcat";
	fichero = ruta + "/" + tabla + ".csv";
	resultImport = this.iface.importarTabla(tabla, fichero);
	if (resultImport < 0) {
		MessageBox.warning(tabla + this.iface.myUtil.translate( "scripts", " - La tabla no se importó correctamente"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return -1;
	}
	
	tabla = "tt_sessioncat";
	fichero = ruta + "/" + tabla + ".csv";
	resultImport = this.iface.importarTabla(tabla, fichero);
	if (resultImport < 0) {
		MessageBox.warning(tabla + this.iface.myUtil.translate( "scripts", " - La tabla no se importó correctamente"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return -1;
	}
	
	tabla = "tt_tcatscat";
	fichero = ruta + "/" + tabla + ".csv";
	resultImport = this.iface.importarTabla(tabla, fichero);
	if (resultImport < 0) {
		MessageBox.warning(tabla + this.iface.myUtil.translate( "scripts", " - La tabla no se importó correctamente"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return -1;
	}

	return numPruebas;
}


//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D
Importa los datos de una tabla de test
@param	tabla: Nombre de la tabla
@param	fichero: Ruta y nombre del fichero csv que contiene los datos a importar
@return	Número de registros importados, -1 si hay error
\end */
function oficial_importarTabla(tabla:String, fichero:String):Number
{
	if (!File.exists(fichero)) {
		MessageBox.warning( fichero + this.iface.myUtil.translate( "scripts", " - El fichero no existe. Compruebe la ruta especificada."), MessageBox.Ok, MessageBox.NoButton );
		return -1;
	}
	
	var util:FLUtil = new FLUtil;
	var file = new File( fichero );
	var arrayLineas = this.iface.preprocesarFichero(file);
	
	var listaCampos:Array = this.iface.myUtil.nombreCampos(tabla);
	if (listaCampos.length == 0) {
		MessageBox.warning( this.iface.myUtil.translate( "scripts", "La tabla ") + tabla.toUpperCase() + this.iface.myUtil.translate( "scripts", " no ha sido cargada\n. Cargue el módulo que contiene esta tabla y repita la importación"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return -1;
	}
	
	var numCampos:Number = parseFloat(listaCampos[0]);
	var campos:String = ""
	var linea:String = "";
	var resFallo:Boolean = false;
	
	var curTabla:FLSqlCursor = new FLSqlCursor(tabla);
	curTabla.setActivatedCheckIntegrity(false);
	
	this.iface.myUtil.setLabelText(this.iface.myUtil.translate( "scripts", "Importando tabla ") + tabla.toUpperCase() + this.iface.myUtil.translate( "scripts", "\n\nProgreso total:"));
	
	var paso:Number = 0;
	var acumPaso:Number = 0;
	var numLineas:Number = arrayLineas.length;
	var error:Boolean = false;
	var desError:String = "";
	util.createProgressDialog( util.translate( "scripts", "Importando tabla " ) + tabla, numLineas );
	util.setProgress(1);
	
	var primero:Boolean = true;
	for (var j = 0; j < arrayLineas.length; j++) {
		
		linea = arrayLineas[j];
			
		campos = linea.split(this.iface.sep);
		
		curTabla.setModeAccess(curTabla.Insert);
		curTabla.refreshBuffer();
		
		for (i = 0; i < (numCampos - 1); i++) {
		
			if (i == 0 && tabla == "tt_stepcat") {
				campos[i] = this.iface.myUtil.sqlSelect("tt_testcat", "id", "idfuncional = '" + campos[13] + "' AND codtestcat = '" + campos[12] + "'");
				if (!campos[i]) {
					desError = "Paso: No se encontró la prueba con:\nFuncionalidad\t" + campos[13] + "\nCódigo\t" + campos[12] + "\n";
					error = true;
				}
			}
			if (i == 2 && tabla == "tt_tcatscat"){
				campos[i] = this.iface.myUtil.sqlSelect("tt_testcat", "id", "idfuncional = '" + campos[7] + "' AND codtestcat = '" + campos[1] + "'");
				if (!campos[i]) {
					desError = "Pruebas por sesión: No se encontró la prueba con:\nFuncionalidad\t" + campos[7] + "\nCódigo\t" + campos[1] + "\n";
					error = true;
				}
			}
			if (i == 3 && tabla == "tt_tcatscat") {
				campos[i] = this.iface.myUtil.sqlSelect("tt_sessioncat", "id", "idfuncional = '" + campos[9] + "' AND codsessioncat = '" + campos[4] + "'");	
				if (!campos[i]) {
					desError = "Pruebas por sesión: No se encontró la sesión con:\nFuncionalidad\t" + campos[9] + "\nCódigo\t" + campos[4] + "\n";
					error = true;
				}
			}
			if ( i < campos.length ) {
				if (campos[i]) {
					curTabla.setValueBuffer(listaCampos[i+2], campos[i]);
				}
			}
		}
		if (!curTabla.commitBuffer())
			error = true;
		if (error && !resFallo)  {
		debug(linea);
			var res = MessageBox.critical( this.iface.myUtil.translate( "scripts", "Hubo un problema en la importación de la tabla ") + tabla.toUpperCase() + ":\n" + desError + this.iface.myUtil.translate( "scripts", "\n¿Desea continuar importando esta tabla?\n\nEste mensaje no se repetirá para esta tabla." ), MessageBox.No, MessageBox.Yes );

			if ( res != MessageBox.Yes ) {
				util.destroyProgressDialog();
				return -1;
			}
			error = false;
			resFallo = true;
		}
		if (++paso == 25) {
			acumPaso += paso;
			paso = 0;
			util.setProgress(acumPaso);
		}
	}
	
	file.close();
	
	util.setProgress( numLineas );
	util.destroyProgressDialog();
	curTabla.setActivatedCheckIntegrity(true);
	
	return numLineas;
}

/** \D Establece la ruta al directorio de importación de pruebas base
\end */
function oficial_establecerFicheroPB() 
{
	var util:FLUtil = new FLUtil();
	this.child("fdbDirPB" ).setValue(FileDialog.getExistingDirectory(util.translate( "scripts", "Texto CSV (*.csv)" ), util.translate( "scripts", "Elegir Fichero")));
}

/** \D Establece la ruta al directorio de importación de pruebas de la funcionalidad en desarrollo
\end */
function oficial_establecerFicheroFun() 
{
	var util:FLUtil = new FLUtil();
	this.child("fdbDirFun" ).setValue(FileDialog.getExistingDirectory(util.translate( "scripts", "Texto CSV (*.csv)" ), util.translate( "scripts", "Elegir Fichero")));
}

/** \D Pone el contador de líneas importadas a cero y crea el progressDialog
\end */
function oficial_crearProgress(label:String, numPasos:Number)
{
	this.iface.myUtil.createProgressDialog( label, numPasos );
	this.iface.lineasImportadas = 0;
}

/** \D Lee un fichero y devuelve un array compuesto por todas sus líneas

@param	file: Nombre del fichero
@return	Array con las líneas del fichero o false si hay un error de lectura
\end */
function oficial_preprocesarFichero(file:File):Array
{
	try {
		file.open( File.ReadOnly );
	}
	catch (e) {
		return false;
	}
	
	var arrayLineas:Array;
	var numLineas:Number = 0;

	while (!file.eof)
		arrayLineas[numLineas++] = this.iface.leerLinea(file);

	return arrayLineas;
}

/** \D Lee una línea de fichero

@param	file: Fichero a leer
@return	Línea leída
*/
function oficial_leerLinea(file:File):String
{
	var finLinea:Boolean = false;
	var linea:String = "";
	var lineaBuffer:String = "";
	
	while (!finLinea && !file.eof) {
		lineaBuffer = file.readLine();
		linea += lineaBuffer;
		if (lineaBuffer.charAt(lineaBuffer.length - 2) == this.iface.eol) finLinea = true;
	}
	return linea;
}

/** \D Establece el grado de progreso del cuadro de progreso
@param	valor: Grado de progreso
*/
function oficial_setProgress(valor:Number)
{
	this.iface.myUtil.setProgress( valor );
}

function oficial_bufferChanged(fN:String)
{
	var cursor:FLSqlCursor = this.cursor();
	switch (fN) {
/** \C Si la funcionalidad cambia, establece la ruta a los directorios de importación de pruebas básicas y de las pruebas de la funcionalidad. Dichas rutas son 

Pruebas básicas: Directorio de trabajo / funcionalidad / test
Pruebas funcionalidad: Directorio de trabajo / funcionalidad / funcionalidad / test
\end */
		case "idfuncional": {
			var idFuncional:String = cursor.valueBuffer("idfuncional");
			form.child("fdbDirFun").setValue(this.iface.pathLocal + idFuncional + "/" + idFuncional + "/test");
			form.child("fdbDirPB").setValue(this.iface.pathLocal + idFuncional + "/test");
			break;
		}
		case "incpb": {
/** \C Si se desactiva el campo --incpb--, el valor del campo --dircsvpb-- se borrará
\end */
			if (this.iface.bloqueo)
				return;
			this.iface.bloqueo = true;
			if (!cursor.valueBuffer("incpb"))
				form.child("fdbDirPB").setValue("");
			this.iface.bloqueo = false;
			break;
		}
/** \C El campo --incpb-- estará activado siempre que el campo --dircsvpb-- no esté vacío
\end */
		case "dircsvpb": {
			if (this.iface.bloqueo)
				return;
			var dirCsvPB:String = cursor.valueBuffer("dircsvpb");
			this.iface.bloqueo = true;
			if (dirCsvPB && !dirCsvPB.isEmpty())
				form.child("fdbIncPB").setValue(true);
			else
				form.child("fdbIncPB").setValue(false);
			this.iface.bloqueo = false;
			break;
		}
/** \C Si se desactiva el campo --incfun--, el valor del campo --dircsvfun-- se borrará
\end */
		case "incfun": {
			if (this.iface.bloqueo)
				return;
			this.iface.bloqueo = true;
			if (!cursor.valueBuffer("incfun"))
				form.child("fdbDirFun").setValue("");
			this.iface.bloqueo = false;
			break;
		}
/** \C El campo --incfun-- estará activado siempre que el campo --dircsvfun-- no esté vacío
\end */
		case "dircsvfun": {
			if (this.iface.bloqueo)
				return;
			var dirCsvFun:String = cursor.valueBuffer("dircsvfun");
			this.iface.bloqueo = true;
			if (dirCsvFun && !dirCsvFun.isEmpty())
				form.child("fdbIncFun").setValue(true);
			else
				form.child("fdbIncFun").setValue(false);
			this.iface.bloqueo = false;
			break;
		}
	}
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
