/***************************************************************************
                 do_mastergenerardoc.qs  -  description
                             -------------------
    begin                : lun sep 21 2004
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

////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/** @class_declaration interna */
//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
class interna {
    var ctx:Object;
    function interna( context ) { this.ctx = context; }
    function init() { this.ctx.interna_init(); } 
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {

	var util = new FLUtil();

	/** \D @var htmlArea String que contiene el código html de la página del área procesada en un momento dado \end */
	var htmlArea:String;
	
	/** \D @var nomAreaActual Nombre del área que está siendo procesada en un momento dado \end */
	var nomAreaActual:String;
	/** \D @var aliasAreaActual Alias del área que está siendo procesada en un momento dado \end */
	var aliasAreaActual:String;
	/** \D @var nomModuloActual Nombre del módulo que está siendo procesado en un momento dado \end */
	var nomModuloActual:String;
	/** \D @var aliasModuloActual Alias del módulo que está siendo procesado en un momento dado \end */
	var aliasModuloActual:String;
	
	/** \D @var tipoDoc Tipo de documentación: D (desarrollo) o U (usuario) \end */
	var tipoDoc:String;
	/** \D @var tipoDoc Indica si se realizan las capturas de formularios \end */
	var capturarForms:Boolean;
	
	/** \D @var listaAreas Datos de las áreas (nombre, alias y código) \end */
	var listaAreas:Array = [];
	
	/** \D @var listaCamposTab Listado de campos de la tabla que está siendo procesada. Se utiliza para crear enlaces desde el texto de los formularios a los campos de la tabla \end */
	var listaCamposTab:Array;
	
	/** \D @var ruta Ruta absoluta al directorio de los módulos \end */
	var ruta:String; 
	
	/** \D @var rutaSis Ruta absoluta al directorio del módulo de sistema \end */
	var rutaSis:String;
	
	/** \D @var rutaDestino Ruta absoluta al directorio donde se guardarán los archivos generados \end */
	var rutaDestino:String;
	
	/** \D @var rutaImg Ruta absoluta al directorio de las imágenes usadas (capturas de formularios, etc) \end */
	var rutaImg:String;
	/** \D @var dirImg Ruta relativa al directorio de las imágenes usadas \end */
	var dirImg:String;
	
	/** \D @var rutaDox Ruta absoluta al directorio 'doxygen' del módulo ppal de documentación \end */
	var rutaDox:String;
	/** \D @var rutaDoc Ruta absoluta al directorio donde se volcarán los html resultantes del proceso \end */
	var rutaDoc:String;
	/** \D @var rutaPDF Ruta absoluta al directorio donde se volcarán los pdf resultantes del proceso \end */
	var rutaPDF:String;
	/** \D @var rutaIncludes Ruta absoluta al directorio con los ficheros auxiliares: hojas de estilos, licencia, etc \end */
	var rutaIncludes:String;
	
	/** \D @var proceso Proceso de shell utilizado. Se usa para llamar a doxygen y a la creación del pdf (html2ps y ps2pdf) \end */
	var proceso:FLProcess;
	/** \D @var enProceso Indica que se está ejecutando un proceso en segundo plano. Utilizado para las barras de progreso \end */
	var enProceso:Boolean;
	
	var xmlScriptPpal:FLDomDocument;
	/** \D @var xmlScriptPpal Guarda el contenido xml del script principal del módulo procesado, por motivos de rendimiento \end */
    
	var xmlAux:FLDomDocument = new FLDomDocument();
	/** \D @var xmlAux Guarda el contenido de un nodo xml de descripción para poder extraer el texto con etiquetas \end */
	
	var listaTablas:Array
	/** \D @var listaTablas Array con los nombres y descripciones de las tablas del módulo procesado. Se usa para elaborar la página de Modelo de Datos \end */
	
	function oficial( context ) { interna( context ); } 
	
	function preprocesar() { return this.ctx.oficial_preprocesar() ;}
	function doxygen() { return this.ctx.oficial_doxygen() ;}
	function postprocesar() { return this.ctx.oficial_postprocesar() ;}
	function generarDoc() { return this.ctx.oficial_generarDoc() ;}
	function procesarArea() { return this.ctx.oficial_procesarArea() ;}
	function procesarModulo(rutaArea, dirModulo, nomFicheroMod) { return this.ctx.oficial_procesarModulo(rutaArea, dirModulo, nomFicheroMod) ;}
	function procesarAccion(nomPagina,nomAccion,nodo,rutaArea,dirModulo) { return this.ctx.oficial_procesarAccion(nomPagina,nomAccion,nodo,rutaArea,dirModulo) ;}
	function procesarTabla(rutaT, nomAccion, titAccion, nomTabla) { return this.ctx.oficial_procesarTabla(rutaT, nomAccion, titAccion, nomTabla) ;}
	function procesarScript(nomScript, nomTabla) { return this.ctx.oficial_procesarScript(nomScript, nomTabla) ;}
	function procesarForm(rutaArea, dirModulo, accion, tabla, fR, fM) { return this.ctx.oficial_procesarForm(rutaArea, dirModulo, accion, tabla, fR, fM) ;}
	function datosArea(rutaXML):Boolean { return this.ctx.oficial_datosArea(rutaXML) ;}
	function actualizarLista() { return this.ctx.oficial_actualizarLista() ;}
	function cambiarEstado() { return this.ctx.oficial_cambiarEstado() ;}
	function actualizarFecha(area, modulo) { return this.ctx.oficial_actualizarFecha(area, modulo) ;}
	function modulosParaDocumentar():Boolean { return this.ctx.oficial_modulosParaDocumentar() ;}
	function procesarDoxyfile() { return this.ctx.oficial_procesarDoxyfile() ;}
	function sustituyeString(texto, cadena1, cadena2):String { return this.ctx.oficial_sustituyeString(texto, cadena1, cadena2) ;}
	function agregarContenidos(tipo, accion, pagina) { return this.ctx.oficial_agregarContenidos(tipo, accion, pagina) ;}
	function generarContenidos() { return this.ctx.oficial_generarContenidos() ;}
	function infoModulo(nomModulo) { return this.ctx.oficial_infoModulo(nomModulo) ;}
	function leerFooter():String { return this.ctx.oficial_leerFooter() ;}
	function crearCabecera(nomModulo, nomAccion, titAccion, pagFinal):String { return this.ctx.oficial_crearCabecera(nomModulo, nomAccion, titAccion, pagFinal) ;}
	function obtenerAlias(cadena):String { return this.ctx.oficial_obtenerAlias(cadena) ;}
	function escribirFichero(nombre, contenido, tipo) { return this.ctx.oficial_escribirFichero(nombre, contenido, tipo) ;}
	function obtenerFuncionDox(nomFuncion, nomFichero):String { return this.ctx.oficial_obtenerFuncionDox(nomFuncion, nomFichero) ;}
	function generarPDF() { return this.ctx.oficial_generarPDF() ;}
	function inicializar():Boolean { return this.ctx.oficial_inicializar() ;}
	function finalizar() { return this.ctx.oficial_finalizar() ;}
	function finalizarPDF() { return this.ctx.oficial_finalizarPDF() ;}
	function limpiarDoxygen() { return this.ctx.oficial_limpiarDoxygen() ;}
	function crearZip() { return this.ctx.oficial_crearZip() ;}
	function generarLicencia() { return this.ctx.oficial_generarLicencia() ;}
	function obtenerArrayFunciones(nomFichero:String):Array {
		return this.ctx.oficial_obtenerArrayFunciones(nomFichero);
	}
	function obtenerScriptPpal() {
		return this.ctx.oficial_obtenerScriptPpal();
	}
	function obtenerFuncionScriptPpal(nomFuncion):String {
		return this.ctx.oficial_obtenerFuncionScriptPpal(nomFuncion);
	}
	function modeloDatos() {
		return this.ctx.oficial_modeloDatos();
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
}

const iface = new ifaceCtx( this );
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
Toda la generación de la documentación se hace desde este  formulario. Se crea una serie de ficheros html que se van generando en las distintas funciones. Los html creados responden a la jerarquia de FacturaLUX: Indice general,	Area,	Módulo,	Funcionalidad (acción),	Tabla de Datos, Código de script (sólo en documentación de desarrollo)

Para los nuevos registros el botón 'actualizar lista' está inhabilitado. Para actualizar o crear la lista de módulos hay que aceptar el formulario y reabrirlo
\end */
function interna_init() 
{		
	var cursor:FLSqlCursor = this.cursor();
	
	connect(this.child("pbnActualizarLista"), "clicked()", this, "iface.actualizarLista");
	connect(this.child("pbnCambiarEstado"), "clicked()", this, "iface.cambiarEstado");
	connect(this.child("pbnGenerarDoc"), "clicked()", this, "iface.preprocesar");
	connect(this.child("pbnGenerarPDF"), "clicked()", this, "iface.generarPDF");
	
	this.child("lblDirModulos").text = this.iface.util.readSettingEntry("scripts/fldocuppal/dirModulos");
 	
	if (cursor.modeAccess() == cursor.Insert) {
		this.child("pbnCambiarEstado").setDisabled(true);
		this.child("pbnActualizarLista").setDisabled(true);
		this.child("fdbTitulo").setValue(txTitDocumentacion);
	}
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////


const sepTOC = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";

const txAlAceptar = this.iface.util.translate("scripts", "Al aceptar el formulario");
const txAntesBorrar = this.iface.util.translate("scripts", "Antes de borrar un registro");
const txAntesGuardar = this.iface.util.translate("scripts", "Antes de guardar los datos");
const txBorradoCascada = this.iface.util.translate("scripts", "Borrado en cascada");
const txBoton = this.iface.util.translate("scripts","Botón");
const txCampo = this.iface.util.translate("scripts", "Campo");
const txCampoCalc = this.iface.util.translate("scripts", "Campo calculado:");
const txCamposCalculados = this.iface.util.translate("scripts", "Campos calculados");
const txCamposTabla = this.iface.util.translate("scripts", "Campos de la tabla:");
const txClaveCompuesta = this.iface.util.translate("scripts", "Clave compuesta:");
const txClavePrimaria = this.iface.util.translate("scripts", "Clave primaria:");
const txCodArea = this.iface.util.translate("scripts","Código de Area");
const txCodFuente = this.iface.util.translate("scripts", "Código fuente de");
const txComportamientoForm = this.iface.util.translate("scripts", "Comportamiento del formulario");
const txCondicionesPDF = this.iface.util.translate("scripts", "A continuación se generará un documento en formato pdf\na partir de la documentación previamente generada en html\n\nEs imprescindible que su sistema disponga de las\nfuncionalidades html2ps y ps2pdf\n\n¿Desea continuar?");
const txCont = this.iface.util.translate("scripts", "Contador:");
const txContCampo = this.iface.util.translate("scripts", "Contenido del campo:");
const txContenidos = this.iface.util.translate("scripts", "Contenidos:");
const txDependencias = this.iface.util.translate("scripts", "Dependencias:");
const txDespuesBorrar = this.iface.util.translate("scripts", "Después de borrar un registro");
const txDespuesGuardar = this.iface.util.translate("scripts", "Después de guardar los datos");
const txDocumentandoMod = this.iface.util.translate("scripts", "Documentando módulo");
const txEditable = this.iface.util.translate("scripts", "Editable:");
const txFinalizadaDoc = this.iface.util.translate("scripts", "Finalizada la generación de Documentación en el directorio\n\n");
const txFinalizadaPDF = this.iface.util.translate("scripts", "Se crearon los ficheros PDF de documentación en \n\n");
const txFormEdicion = this.iface.util.translate("scripts", "Formulario de Edición");
const txFormMaestro = this.iface.util.translate("scripts", "Formulario Maestro");
const txFuncionalidades = this.iface.util.translate("scripts", "Funcionalidades:");
const txModeloDatos = this.iface.util.translate("scripts", "Modelo de Datos");
const txGenerandoPDF = this.iface.util.translate("scripts", "Generando PDF (puede tardar unos minutos...)");
const txIndice = this.iface.util.translate("scripts", "Indice:");
const txInfoGeneral = this.iface.util.translate("scripts", "Información general y valores iniciales");
const txLicencia = this.iface.util.translate("scripts","Licencia completa");
const txListaContenidos = this.iface.util.translate("scripts","Contenidos Extendidos");
const txListaOpciones = this.iface.util.translate("scripts", "Lista de opciones:");
const txLongMaxima = this.iface.util.translate("scripts", "Longitud máxima:");
const txModCampo = this.iface.util.translate("scripts", "Modificación del valor del campo antes de guardar:");
const txModNoCargado = this.iface.util.translate("scripts"," no ha sido cargado\nEste módulo no será documentado\n(Sólamente es posible documentar los módulos actualmente cargados)");
const txModulo = this.iface.util.translate("scripts", "Módulo");
const txNo = this.iface.util.translate("scripts","No");
const txNoHayModuloHTML = this.iface.util.translate("scripts","Para generar el archivo PDF de este módulo es necesario que\npreviamente sea documentado de forma individual");
const txParteDecimal = this.iface.util.translate("scripts", "Parte Decimal");
const txParteEntera = this.iface.util.translate("scripts", "Parte Entera:");
const txPreparandoDoc = this.iface.util.translate("scripts",	"Preparando documentación...");
const txPuedeNulo = this.iface.util.translate("scripts", "Puede ser nulo:");
const txRelacionTabla = this.iface.util.translate("scripts", "Relacion con otra tabla (referencias internas)");
const txResumenContenidos = this.iface.util.translate("scripts","Resumen de Contenidos");
const txScriptPpal = this.iface.util.translate("scripts","Script principal del módulo");
const txSi = this.iface.util.translate("scripts","Sí");
const txTabla = this.iface.util.translate("scripts","Tabla");
const txTablaDatos = this.iface.util.translate("scripts", "Tabla de Datos");
const txTablaRelacionada = this.iface.util.translate("scripts", "Tabla con la que se relaciona:");
const txTerminos = this.iface.util.translate("scripts", "Términos");
const txTipoDato = this.iface.util.translate("scripts", "Tipo de dato:");
const txTipoRelacion = this.iface.util.translate("scripts", "Tipo de relación");
const txTitBotones = this.iface.util.translate("scripts","Controles adicionales del formulario");
const txTitIndice = this.iface.util.translate("scripts","Indice");
const txTitDocumentacion = this.iface.util.translate("scripts","Guía de Módulos FacturaLUX");
const txToc = this.iface.util.translate("scripts","Tabla de Contenidos");
const txValidaciones = this.iface.util.translate("scripts", "Validaciones");
const txValorDefecto = this.iface.util.translate("scripts", "Valor por defecto:");
const txValorUnico = this.iface.util.translate("scripts", "Valor único:");
const txVersion = this.iface.util.translate("scripts", "Versión:");
const txVisible = this.iface.util.translate("scripts", "Visible:");
const txVisibleGrid = this.iface.util.translate("scripts", "Visible en formulario y tabla:");

/** \D
Da comienzo al proceso de generación de documentación de los módulos seleccionados en la tabla.
\end */
function oficial_preprocesar()
{
	if (!this.iface.modulosParaDocumentar()) return;

	this.iface.inicializar();
	
	this.iface.util.createProgressDialog(txPreparandoDoc, 10);
	this.iface.util.setProgress(1);

/** \D
Copia los ficheros de los scripts (.qs) de todos los modulos que hay en disco al directorio doxygen del presente módulo
\end */
	var q:FLSqlQuery = new FLSqlQuery();
	
	q.setTablesList("do_modulosdoc");
	q.setFrom("do_modulosdoc");
	q.setSelect("area, modulo");
	q.setWhere("documentar = 'true' AND idgenerardoc = " + this.cursor().valueBuffer("id"));
	q.setOrderBy("area, modulo");

	if (!q.exec()) {
		MessageBox.critical(this.iface.util.
												translate("scripts", "Falló la consulta"),
												MessageBox.Ok, MessageBox.NoButton,
												MessageBox.NoButton);
		return false;
	}
	
	var area:String;
	var modulo:String;
	var rutaScripts:String;
	var dirScripts:String;
	var scripts;
	var contScript:String;
	
	while (q.next()) {
			area = q.value(0);
			modulo = q.value(1);
			rutaScripts = this.iface.ruta + area + "/" + modulo + "/scripts/";
			dirScripts = new Dir(rutaScripts);
			
			scripts = dirScripts.entryList("*.qs", Dir.Files);
			for (var k = 0; k < scripts.length; k++) {
					
					fich = new File(rutaScripts + scripts[k]);
					fich.open(File.ReadOnly);
					contScript = fich.read();
					fich.close();

					fich = new File(this.iface.rutaDox + "codigo/" + scripts[k]);
					fich.open(File.WriteOnly);
					fich.write(contScript);
					fich.close();
			}
  	}
	this.iface.util.setProgress(1);
	this.iface.doxygen();
}

/** \D
Crea un fichero que se ejecutará sobre la consola y será el que se posicione en el directorio 'doxygen' del presente módulo y ejecute Doxygen sobre los ficheros de código de los scripts (.qs) previamente copiados. La configuración de Doxygen permanece en el fichero 'doxyfile' del directorio 'doxygen' del presente módulo. Se generaran ficheros html y xml.

Se conecta la señal de fin del proceso (exited) con la función 'postprocesar' y arranca el proceso.
\end */
function oficial_doxygen()
{
	var scriptDox:String =  
			"cd " + this.iface.rutaDox + ";" +
			"for i in $(ls codigo/*.qs); do " +
 				"grep -v @class_declaration $i | grep -v @class_definition > tmp;" +
 				"cat tmp > $i;" +
				"cp -f $i .;" +
				"doxygen doxyfile;" +
				"rm -f *.qs;" +
			"done;" +
			"rm -f tmp;";

	var f = new File(this.iface.rutaDox + "dox");
	f.open(File.WriteOnly);
	f.write(scriptDox);
	f.close();

	this.iface.procesarDoxyfile();
	this.iface.proceso = new FLProcess(this.iface.rutaDox + "dox");
	connect(this.iface.proceso, "exited()", this, "iface.postprocesar");
	this.iface.proceso.start();
}

/** \D
Procesa los nombres de los ficheros generados por Doxygen para eliminar ciertos caracteres. Copia los ficheros de código de scripts al directorio 'codigo' del presente módulo
\end */
function oficial_postprocesar()
{
	// Procesar los nombres de los ficheros xml procedentes de doxygen
	this.iface.util.setProgress(5);
	var dirXML:Dir = new Dir(this.iface.rutaDox + "xml");
	var xmls = dirXML.entryList("*.xml", Dir.Files);
	var contScript:String;
	var nombreFich:String;
	var fich;
	
	for (var i = 0; i < xmls.length; i++) {
		nombreFich = xmls[i];
		
		fich = new File(this.iface.rutaDox + "xml/" + nombreFich);
		fich.open(File.ReadOnly);
		contScript = fich.read();
		fich.close();
		fich.remove();
		
		nombreFich = this.iface.sustituyeString(nombreFich, "__", "_");
		nombreFich = this.iface.sustituyeString(nombreFich, "_8qs", "");
		
		fich = new File(this.iface.rutaDox + "xml/" + nombreFich);
		fich.open(File.WriteOnly);
		fich.write(contScript);
		fich.close();
	}
			
	this.iface.util.setProgress(7);
	// Procesar los nombres de los ficheros html procedentes de doxygen
	var dirHTML:Dir = new Dir(this.iface.rutaDox + "html");		
	var htmls = dirHTML.entryList("*.html",Dir.Files);
	
	for (var i = 0; i < htmls.length; i++) {
		nombreFich = htmls[i];
		
		fich = new File(this.iface.rutaDox + "html/" + nombreFich);
		fich.open(File.ReadOnly);
		contScript = fich.read();
		fich.close();
		fich.remove();
		
		nombreFich = this.iface.sustituyeString(nombreFich, "__", "_");
		nombreFich = this.iface.sustituyeString(nombreFich, "_8qs", "");
		
		fich = new File(this.iface.rutaDox + "html/" + nombreFich);
		fich.open(File.WriteOnly);
		fich.write(contScript);
		fich.close();
	}
			
	this.iface.util.setProgress(8);
	// Mover los qs al directorio codigo
	var dirDox:Dir = new Dir(this.iface.rutaDox);		
	var qss = dirDox.entryList("*.qs", Dir.Files);
	for (var i = 0; i < qss.length; i++) {
			
		nombreFich = qss[i];
		
		fich = new File(this.iface.rutaDox + nombreFich);
		fich.open(File.ReadOnly);
		contScript = fich.read();
		fich.close();
		fich.remove();
		
		fich = new File(this.iface.rutaDox + "codigo/" + nombreFich);
		fich.open(File.WriteOnly);
		fich.write(contScript);
		fich.close();
	}
	
	this.iface.util.setProgress(9);
	this.iface.generarDoc();
}

/** \D
Arranca la generación de la documentación a partir de los ficheros html y xml previamente creados por Doxygen.

Lee la tabla de datos para obtener un listado de las área que contienen módulos a documentar y llama a la función 'procesarArea' para cada una de ellas.
\end */
function oficial_generarDoc()
{
	this.iface.htmlArea = "";
	
	var q:FLSqlQuery = new FLSqlQuery();

	q.setTablesList("do_modulosdoc");
	q.setFrom("do_modulosdoc");
	q.setSelect("area");
	q.setWhere("documentar = 'true' AND idgenerardoc = " + this.cursor().valueBuffer("id") + " GROUP BY area");
	if (!q.exec()) {
		MessageBox.critical(this.iface.util.
												translate("scripts", "Falló la consulta"),
												MessageBox.Ok, MessageBox.NoButton,
												MessageBox.NoButton);
		return false;
	}
	
	while (q.next()) {
		this.iface.nomAreaActual = q.value(0);
		this.iface.procesarArea();
	}
	
	this.iface.generarContenidos();
	
	this.iface.finalizar();
	
}

/** \D
Obtiene de la tabla los módulos a documentar de un área. Del fichero xml del área obtiene el título, la descripción y el código. Para cada módulo llama a la función 'procesarModulo'
\end */
function oficial_procesarArea()
{
	debug("Procesando area " + this.iface.nomAreaActual);

	var noRegistros:Boolean = true;
	var q:FLSqlQuery = new FLSqlQuery();
	
	q.setTablesList("do_modulosdoc");
	q.setFrom("do_modulosdoc");
	q.setSelect("modulo");
	q.setWhere("documentar = 'true' AND area = '" + this.iface.nomAreaActual + "' AND idgenerardoc = " + this.cursor().valueBuffer("id"));

	if (!q.exec()) {
		MessageBox.critical(this.iface.util.
												translate("scripts", "Se produjo un error en la consulta del listado de módulos"),
												MessageBox.Ok, MessageBox.NoButton,
												MessageBox.NoButton);
		return;
	}
	
	var rutaArea:String = this.iface.ruta + this.iface.nomAreaActual + "/";
	var dirArea:Dir = new Dir(rutaArea);
	var dirModulos = dirArea.entryList("*", Dir.Dirs);
	var codArea:String = "";
	var nomFicheroMod:String;
	
	if (!this.iface.datosArea(rutaArea + "/" + this.iface.nomAreaActual + ".xml")) {
		MessageBox.critical(this.iface.util.
								translate("scripts", "Error al obtener los datos del fichero " + this.iface.nomAreaActual + ".xml"),
								MessageBox.Ok, MessageBox.NoButton,
								MessageBox.NoButton);
		return;
	}
	
	this.iface.aliasAreaActual = this.iface.listaAreas[this.iface.nomAreaActual]["alias"];
	this.iface.htmlArea = "\n<span class=\"descripcion_doc\">" + this.iface.listaAreas[this.iface.nomAreaActual]["texto"] + "</span>";
	this.iface.htmlArea += "\n<br>&nbsp;<br><span class=\"textogris_doc\">" + txCodArea + ": </span>";  
	this.iface.htmlArea += "<b>" + this.iface.listaAreas[this.iface.nomAreaActual]["codigo"] + "</b>";
		
		
/** \D Busca el fichero .mod correspondiente a cada módulo del área
\end */
	var modulo:String;
	
	while (q.next()) {
		modulo = q.value(0);
			
		try { dirArea.cd(modulo); }
		catch (e) {	
				MessageBox.critical(this.iface.util.
					translate("scripts", "Se produjo un error al acceder al directorio" +
							rutaArea + modulo),
					MessageBox.Ok, MessageBox.NoButton,
					MessageBox.NoButton);
		}		
					
		nomFicheroMod = dirArea.entryList("*.mod", Dir.Files);
		if (nomFicheroMod.length != 1) {
				dirArea.cdUp();
				continue;
		}
		// Llamada al procesado del módulo
		if (!this.iface.procesarModulo(rutaArea, modulo, nomFicheroMod[0])) continue;
		this.iface.actualizarFecha(this.iface.nomAreaActual, modulo);
		dirArea.cdUp();
		noRegistros = false;		
  	}		
		
	if (noRegistros) {
			MessageBox.critical(this.iface.util.
							translate("scripts", "No se encontraron registros para procesar"),
												MessageBox.Ok, MessageBox.NoButton,
												MessageBox.NoButton);
			return;
	}
		
/** \D Después de procesar los módulos completa la elaboración del html del área con los datos de versión, dependencias, etc
\end */
	var q:FLSqlQuery = new FLSqlQuery();
	
	q.setTablesList("do_modulos");
	q.setFrom("do_modulos");
	q.setSelect("modulo, aliasmodulo, dependencias, version");
	q.setOrderBy("modulo");
	q.setWhere("area = '" + this.iface.nomAreaActual + "'");
	
	if (!q.exec()) {
		MessageBox.critical(this.iface.util.
												translate("scripts", "Error al ejecutar la consulta de generación de módulos"),
												MessageBox.Ok, MessageBox.NoButton,
												MessageBox.NoButton);
		return false;
	}
	
	while (q.next()) {
		this.iface.htmlArea += "<br>&nbsp;<br><a href=\"" + q.value(0) + "/" + q.value(0) + ".html\">";
		this.iface.htmlArea += txModulo + " " + q.value(1) + "</a>";
		this.iface.htmlArea += "<br>\t&nbsp;&nbsp;&nbsp;" + q.value(2) + "<br>\t&nbsp;&nbsp;&nbsp;" + q.value(3);
	}		
	
	var cabecera:String = this.iface.crearCabecera();
	this.iface.htmlArea = cabecera + this.iface.htmlArea;	
	this.iface.escribirFichero(this.iface.nomAreaActual + ".html", this.iface.htmlArea, "area");

}

/** \D
Procesa un módulo

Obtiene del fichero '.mod' nombre, título, descripción, área y dependencias del módulo. Lee el fichero xml de acciones del módulo y obtiene un listado de acciones. Para cada una de ellas hace una llamada a la función 'procesarAccion'. 

@param	rutaArea Ruta en disco al directorio del área
@param	dirMódulo Nombre del directorio que contiene el módulo
@param	nomFicheroMod Nombre del fichero '.mod' del módulo
\end */
function oficial_procesarModulo(rutaArea, dirModulo, nomFicheroMod)
{
	debug("Procesando módulo " + nomFicheroMod);

	var fichModulo = new File(rutaArea + "/" + dirModulo + "/" + nomFicheroMod);
	fichModulo.open(File.ReadOnly);

	var xmlModulo:FLDomDocument = new FLDomDocument();
	xmlModulo.setContent(fichModulo.read());
	fichModulo.close();
	var listaModulo = xmlModulo.elementsByTagName("MODULE");
	var aliasArea:String = "";
	var dependencia:String;
	var version:String = "<span class=\"textogris_doc\">" + txVersion + "</span> ";
	var dependencias:String = "";
	var descModulo:String = "";
	
	// Se establecen las variables globales de alias y nombre del módulo
	if (listaModulo.item(0).namedItem("name")) 
			this.iface.nomModuloActual = listaModulo.item(0).namedItem("name").toElement().text();		
	if (listaModulo.item(0).namedItem("alias"))
			this.iface.aliasModuloActual = this.iface.obtenerAlias(listaModulo.item(0).namedItem("alias").toElement().text());
	if (listaModulo.item(0).namedItem("version"))
			version += listaModulo.item(0).namedItem("version").toElement().text();
	if (listaModulo.item(0).namedItem("areaname"))
		aliasArea = this.iface.obtenerAlias(listaModulo.item(0).namedItem("areaname").toElement().text());
	if (listaModulo.item(0).namedItem("description")) {
		this.iface.xmlAux.setContent("test");
		this.iface.xmlAux.appendChild(listaModulo.item(0).namedItem("description"));
		descModulo = this.iface.xmlAux.toString();
	}
	
	this.iface.obtenerScriptPpal();
/** \D Se comprueba que el módulo está cargado
\end */		
	if (!sys.isLoadedModule(this.iface.nomModuloActual)) {
		MessageBox.information(this.iface.aliasModuloActual + " | " + aliasArea + 
				txModNoCargado, MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
	
	// Se obtiene el listado de dependencias
	if (listaModulo.item(0).namedItem("dependencies")) {
		var listaDepend = listaModulo.item(0).namedItem("dependencies").toElement().childNodes();				
		var areaYmodulo:Array;
				
		dependencias = "<span class=\"textogris_doc\">";
		dependencias += txDependencias + "</span> ";
		
		for(var i = 0; i < listaDepend.length(); i++) {
			if (listaDepend.item(i))
				areaYmodulo = this.iface.infoModulo(listaDepend.item(i).toElement().text());
			if (areaYmodulo) {
				dependencias += txModulo;
				dependencias += " " + areaYmodulo["modulo"] + " - ";
				dependencias += areaYmodulo["area"] + "\n";
				dependencias += "&nbsp;&nbsp;&nbsp;"; 
			}
		}
	}
	
	var htmlModulo:String = "\n<span class=\"descripcion_doc\">" + descModulo + "</span>";
	htmlModulo += "\n<br>&nbsp;<br>" + version + "\n<br>" + dependencias;
	if (this.iface.tipoDoc == "guia_desarrollo")
		htmlModulo += "\n\t<br>&nbsp;<br><a href=\"modelodatos.html\">" + txModeloDatos + "</a>";
	htmlModulo += "\n\t<br>&nbsp;<br><span class=\"cabecera_menu_doc\">";
	htmlModulo += txFuncionalidades + "</span>";
	htmlModulo += "\n<br><ul class=\"menu_doc\">\n";
	
	// Procesado del fichero xml del módulo para obtener la lista de acciones
	var fichAcciones = new File(rutaArea + "/" + dirModulo + "/" + this.iface.nomModuloActual + ".xml");
	fichAcciones.open(File.ReadOnly);
	var xmlAcciones = new FLDomDocument();
	xmlAcciones.setContent(fichAcciones.read());
	fichAcciones.close();
	
	var listaAcciones:FLDomNodeList;
	listaAcciones= xmlAcciones.elementsByTagName("action");
	var nomAccion:String;
	var nomTabla:String;
	var aliasAccion:String;
	var nodoAccion;
	this.iface.listaTablas = [];
	this.iface.util.setProgress(0);		
	this.iface.util.setLabelText(txDocumentandoMod + " " + this.iface.aliasModuloActual + " - " + aliasArea);
	this.iface.util.setTotalSteps(listaAcciones.length());
	
	// arrayAcciones almacena el listado de las acciones para luego ordenarlas alfabéticamente
	var arrayAcciones:Array = [];
	for(var i = 0; i < listaAcciones.length(); i++) {
			
		nomAccion = listaAcciones.item(i).namedItem("name").toElement().text();
		aliasAccion = nomAccion;
		if (listaAcciones.item(i).namedItem("alias")) {
			aliasAccion = listaAcciones.item(i).namedItem("alias").toElement().text();
			aliasAccion = this.iface.obtenerAlias(aliasAccion);
		}
		arrayAcciones[i] = aliasAccion + "--__--" + nomAccion;
		// Se procesa cada una de las acciones
		nodoAccion = listaAcciones.item(i);
		nomPagina = ("xml_" + nomAccion); 
		this.iface.procesarAccion(nomPagina,nomAccion,nodoAccion,rutaArea,dirModulo);
		this.iface.util.setProgress(i);
	}
	
	// Se ordenan las acciones
	arrayAcciones.sort();
	for(i = 0; i < arrayAcciones.length; i++) {
		aliasYnombre = arrayAcciones[i];
		aliasYnombre = aliasYnombre.split("--__--");
		htmlModulo += "\t<li><a href=\"xml_" + aliasYnombre[1] + ".html\">" + aliasYnombre[0] + "</a>\n";
	}
		
/** \D Si el tipo de documentación es de desarrollador, hay que incluir el script ppal del módulo y el modelo de datos
\end */
	if (this.iface.tipoDoc == "guia_desarrollo") {
		htmlsScript = new Array(2);
		htmlsScript = this.iface.procesarScript();

		if (htmlsScript) {
			cabecera = this.iface.crearCabecera(this.iface.nomModuloActual, "_paginafinal", "", txScriptPpal + " " + this.iface.aliasModuloActual);
			htmlScriptPpal = cabecera;
			htmlScriptPpal += htmlsScript[1];
			htmlModulo += "\t<li><a href\"" + this.iface.nomModuloActual + "_script.html\">[" + txScriptPpal + "]</a>\n";
			this.iface.escribirFichero(this.iface.nomModuloActual + "_script.html", htmlScriptPpal);
		}
		this.iface.modeloDatos();
	}				
	this.iface.util.setProgress(listaAcciones.length());
	htmlModulo += "</ul>";
	
	var cabecera:String = this.iface.crearCabecera(this.iface.nomModuloActual);
	htmlModulo = cabecera + htmlModulo;			
	this.iface.escribirFichero(this.iface.nomModuloActual + ".html", htmlModulo);
	
		

/** \D Las dependencias del módulo y la versión se guardan en la tabla de contenidos para elaborar después el html del área
\end */				
	var cursor:FLSqlCursor = new FLSqlCursor("do_modulos");
	cursor.select("modulo = '" + this.iface.nomModuloActual + "'");
	if (!cursor.first()) {
		cursor.setModeAccess(cursor.Insert);
		cursor.refreshBuffer();
		cursor.setValueBuffer("area", this.iface.nomAreaActual);
		cursor.setValueBuffer("modulo", this.iface.nomModuloActual);
		cursor.setValueBuffer("aliasmodulo", this.iface.aliasModuloActual);
		cursor.setValueBuffer("dependencias", dependencias);
		cursor.setValueBuffer("version", version);
		cursor.commitBuffer();
	}
	return true;
}


/** \D
Muestra un listado con las tablas del módulo actual

\end */
function oficial_modeloDatos()
{
	var htmlModeloDatos:String;
	var tabla:Array;
	var nombreAnterior:String;
	this.iface.listaTablas.sort();
	htmlModeloDatos += "<br/>Modelo de Datos\n";
	htmlModeloDatos += "<ul>\n";
	for(var i = 0; i < this.iface.listaTablas.length; i++) {
		tabla = this.iface.listaTablas[i];
		if (nombreAnterior == tabla["nombre"])
			continue;
		htmlModeloDatos += "\t<li><a href=\"mtd_" + tabla["nombre"] + ".html\">" + tabla["nombre"] + ": " + tabla["descripcion"] + "</a>\n";
		nombreAnterior = tabla["nombre"];
	}
	htmlModeloDatos += "</ul>\n";
	var cabecera:String = this.iface.crearCabecera(this.iface.nomModuloActual);
	htmlModeloDatos = cabecera + htmlModeloDatos;
	this.iface.escribirFichero("modelodatos.html", htmlModeloDatos);
}

/** \D
Procesa una acción

Recibe como parámetro el nodo xml que contiene la acción. Del nodo obtiene los datos de la tabla, script del formulario maestro y script del formulario de edición, si existen. Para la tabla hace una llamada a la función 'procesarTabla', y para los scripts crea el código html de la página de acción.

@param	nomPagina Nombre del html de la acción en la documentación
@param	nomAccion Nombre de la acción
@param	nodo Nodo o nivel de agrupamiento xml obtenido del fichero xml de acciones.
@param	rutaArea Ruta en disco al área de la acción
@param	dirModulo Nombre del directorio del módulo que contiene la acción
\end */

function oficial_procesarAccion(nomPagina,nomAccion,nodo,rutaArea,dirModulo)
{
	debug("Procesando accion " + nomAccion);

	var titAccion:String = nomAccion;
	
	var alias = nodo.namedItem("alias");
	if (alias) titAccion = this.iface.obtenerAlias(alias.toElement().text());

	this.iface.agregarContenidos("accion", titAccion, nomPagina + ".html");
	
	tabla = nodo.namedItem("table");
	var htmlTabla:String;
	if(tabla) {
		var nomTabla:String = tabla.toElement().text();
		var pagTabla:String = "mtd_" + nomTabla;
		htmlTabla = "&nbsp;<li><a href=\"" + pagTabla + ".html\">";
		htmlTabla += txTablaDatos + "</a>\n";
		this.iface.procesarTabla(rutaArea + "/" + dirModulo, nomAccion, titAccion, nomTabla);
	}
	// htmlMenuAccion almacena el html del menú que aparece primero en la página
	// htmlContenidosAccion almacena el contenido principal de la página
	var htmlMenuAccion:String = "";
	var htmlContenidosAccion:String = "";
	// htmlsScripts almacena el html del procasado del script
	// htmlBotones almacena el html de los botones de los formularios
	var htmlsScript:String;
	var htmlBotones:String;
	
	var descripcion = nodo.namedItem("description");
	if (descripcion) {
		htmlMenuAccion += "<span class=\"descripcion_doc\">";
		this.iface.xmlAux.setContent("test");
		this.iface.xmlAux.appendChild(descripcion);
		htmlMenuAccion += this.iface.obtenerAlias(this.iface.xmlAux.toString()) + "</span><br>&nbsp;<br>\n";
	}
	htmlMenuAccion += "\n<span class=\"cabecera_menu_doc\">";
	htmlMenuAccion += txContenidos + "</span>";
	htmlMenuAccion += "\n<ul class=\"menu_doc\">";
	
	var auxNomTabla:String;
			
	var mostrarFormMaster:Boolean = false;
	var scriptForm = nodo.namedItem("scriptform");
	if (scriptForm) nomScriptForm = scriptForm.toElement().text();		
	
	var scriptFormRecord = nodo.namedItem("scriptformrecord");
	if (scriptFormRecord) nomScriptFormRecord = scriptFormRecord.toElement().text();
	
	var formMaster = nodo.namedItem("form");
	if (formMaster) nomFormMaster = formMaster.toElement().text();		
	
	var formRecord = nodo.namedItem("formrecord");
	if (formRecord) nomFormRecord = formRecord.toElement().text();		
	
	var hayFormMaster:Boolean = false;
	/** \D La documentación del formulario maestro debe mostrarse sólamente cuando el formulario sea distinto del master genérico o cuando haya un script asociado al formulario maestro
	\end */
	if ((formMaster && nomFormMaster != "master" && nomFormMaster != "FLWidgetMasterTable" ) || (scriptForm && scriptForm != scriptFormRecord)) {
		hayFormMaster = true;
		htmlMenuAccion += "\t<li><a href=\"#form\">" + txFormMaestro + "</a>\n";
		
		htmlContenidosAccion += "<br><p><a name=\"form\"></a>\n";
		htmlContenidosAccion += "<h2><u>" + txFormMaestro; 
		htmlContenidosAccion += "</u></h2></p>\n";
	}		

	if (formMaster) {
		
		if (tabla) auxNomTabla = tabla.toElement().text();
		
		var htmlBotones = this.iface.procesarForm(rutaArea, dirModulo, nomAccion, auxNomTabla, nomFormRecord, nomFormMaster);
		if (htmlBotones) {
			imgFile = this.iface.rutaImg + nomFormMaster + ".png";	
			htmlContenidosAccion +=	"<img class=\"imagen_doc\" src=" +  this.iface.dirImg + nomFormMaster + ".png><br>&nbsp;<br>\n";
			htmlContenidosAccion += htmlBotones;
		}
	}
	if (scriptForm) {
		if (!scriptFormRecord || (scriptFormRecord && nomScriptForm != nomScriptFormRecord)) {
				
			if (tabla) auxNomTabla = tabla.toElement().text();
									
			htmlsScript = new Array(2);		
			htmlsScript = this.iface.procesarScript(nomScriptForm, auxNomTabla);
			
			if (htmlsScript) {
				htmlMenuAccion += htmlsScript[0];
				htmlContenidosAccion += htmlsScript[1];
			}
		}
	}
	
	if (formRecord) {
			
		if (nomFormRecord != nomFormMaster) {
		
			htmlContenidosAccion += "<br><p><a name=\"formrecord\"></a>\n";
			htmlContenidosAccion += "<h2><u>" + txFormEdicion;
			htmlContenidosAccion += "</u></h2></p>\n";
			
			if (tabla) auxNomTabla = tabla.toElement().text();
			var htmlBotones = this.iface.procesarForm(rutaArea, dirModulo, nomAccion, auxNomTabla, nomFormRecord);

			if (htmlBotones) {
				imgFile = this.iface.rutaImg + nomFormRecord +".png";
				htmlContenidosAccion +=	"<img class=\"imagen_doc\" src=" + this.iface.dirImg + nomFormRecord + ".png><br>&nbsp;<br>\n";
				htmlContenidosAccion += htmlBotones;
			}

			if (hayFormMaster) htmlMenuAccion += "&nbsp;";
			htmlMenuAccion += "\t<li><a href=\"#formrecord\">" + txFormEdicion + "</a>\n";
					
			if(scriptFormRecord) {
				
				if (tabla) auxNomTabla = tabla.toElement().text();
				
				htmlsScript = new Array(2);
				htmlsScript = this.iface.procesarScript(nomScriptFormRecord, auxNomTabla);
				if (htmlsScript) {
					htmlMenuAccion += htmlsScript[0];
					htmlContenidosAccion += htmlsScript[1];
				}
			}
		}
	}
	if (tabla) htmlMenuAccion += htmlTabla;		
			
	htmlMenuAccion += "\n</ul>\n";
	
	var cabecera = this.iface.crearCabecera(this.iface.nomModuloActual, nomAccion, titAccion);	
	htmlAccion = cabecera + htmlMenuAccion + htmlContenidosAccion;		
	this.iface.escribirFichero(nomPagina + ".html", htmlAccion);
}

/** \D
Procesa el fichero xml de una tabla (.mtd)

Obtiene un listado completo de los campos de la tabla y de todas sus propiedades, además de las relaciones con otras tablas, si existen.

@param this.iface.ruta Ruta al fichero \e mtd de la tabla
@param	nomAccion Nombre interno de la acción
@param	titAccion Título o nombre público de la acción
@param	nomTabla Nombre de la tabla
\end */
function oficial_procesarTabla(ruta, nomAccion, titAccion, nomTabla)
{
		debug("Procesando tabla " + nomTabla);

		rutaTabla = ruta + "/tables/" + nomTabla + ".mtd";
		if(!File.exists(rutaTabla)) return;
 		
		var fichTabla = new File(rutaTabla);
		fichTabla.open(File.ReadOnly);
		
		var xmlTabla = new FLDomDocument();
 		xmlTabla.setContent(fichTabla.read());
		fichTabla.close();
		var listaTabla = xmlTabla.elementsByTagName("alias");
		aliasTabla = this.iface.obtenerAlias(listaTabla.item(0).toElement().text());
		
		listaTabla = xmlTabla.elementsByTagName("TMD");
		commentTabla = this.iface.obtenerAlias(listaTabla.item(0).toElement().comment());
		
		var htmlContenidosTabla = "";
		var htmlMenuTabla:String = "";
		if (this.iface.tipoDoc == "guia_desarrollo") {
			htmlMenuTabla = "\t<span class=\"descripcion_doc\">" + nomTabla + " (" + commentTabla + ") " + "</span>\n";
			var arrayTabla:Array = [];
			arrayTabla["nombre"] = nomTabla;
			arrayTabla["descripcion"] = commentTabla;
			this.iface.listaTablas.push(arrayTabla);
		} else
			htmlMenuTabla = "\t<span class=\"descripcion_doc\">" + commentTabla + "</span>\n";
		htmlMenuTabla += "\t<br>&nbsp;<br><span class=\"cabecera_menu_doc\">";
		htmlMenuTabla += txCamposTabla + "</span>\n";
		
		var listaCampos = xmlTabla.elementsByTagName("field");
		var nombreCampo, aliasCampo;
		var nodoPadre;
		var nodoCampo;
 		this.iface.listaCamposTab = [];
		var numCampos = 1;
		var comentario = "";
		
		htmlMenuTabla += "<ul class=\"menu_doc\">\n";
		
		for (var i = 0; i < listaCampos.length(); i++) {
		
				nodoCampo = listaCampos.item(i);
 				if (nodoCampo.parentNode().nodeName() != "TMD") continue;
				
				nombreCampo = nodoCampo.namedItem("name").toElement().text();
				aliasCampo = this.iface.obtenerAlias(nodoCampo.namedItem("alias").toElement().text());
				if (!aliasCampo) aliasCampo = nombreCampo;
				
				comentario = nodoCampo.comment(); 
										
				if (this.iface.tipoDoc == "guia_desarrollo")
					htmlMenuTabla += "\t<li><a href=\"#" + nombreCampo + "\"> " + nombreCampo + " (" + aliasCampo + ") " + "</a>";
				else
					htmlMenuTabla += "\t<li><a href=\"#" + nombreCampo + "\"> " + aliasCampo + "</a>";
				htmlMenuTabla += "&nbsp;<span class=\"textogris_doc\">" + comentario + "</span>\n";

				htmlContenidosTabla += "\n\t<br>&nbsp;<br><p><a name = \"" + nombreCampo + "\"></a>";
				if (this.iface.tipoDoc == "guia_desarrollo")
					htmlContenidosTabla += "<h2>" + nombreCampo + " (" + aliasCampo + ") " + "</h2>\n";
				else
					htmlContenidosTabla += "<h2>" + aliasCampo + "</h2>\n";
				htmlContenidosTabla += "\t&nbsp;<span class=\"textogris_doc\">" + comentario + "</span>\n";
				
				htmlContenidosTabla += "</p>\n";
				htmlContenidosTabla += "<div class=\"bloque_campo_doc\">\n";
				
				this.iface.listaCamposTab[numCampos] = new Array(2);
				this.iface.listaCamposTab[numCampos]["nombre"] = nombreCampo;
				this.iface.listaCamposTab[numCampos]["alias"] = aliasCampo;
				numCampos++;
				
				nulo = nodoCampo.namedItem("null");
				
				if (nulo){
						var etiquetaNulo = nulo.toElement().text();
						var valorN = etiquetaNulo;
						htmlContenidosTabla += "\t" + txPuedeNulo + " " + valorN + "\n";
				}

				pk = nodoCampo.namedItem("pk");
				if (pk){
						var etiquetaPk = pk.toElement().text();
						var valorPk = etiquetaPk;
						htmlContenidosTabla += "\t<br>" +
								"<a href=\"../../includes/terminos.html#pk\">" + txClavePrimaria + "</a> " + valorPk + "\n";
				}

				ck = nodoCampo.namedItem("ck");
				if (null){
						var etiquetaCk = ck.toElement().text();
						var valorCk = etiquetaCk;
						htmlContenidosTabla += "\t<br>" +
								"<a href=\"../../includes/terminos.html#ck\">" + txClaveCompuesta + "</a> " + valorCk + "\n";
				}

				tipo = nodoCampo.namedItem("type");
				if (tipo){
						var etiquetaTipo = tipo.toElement().text();
						htmlContenidosTabla += "\t<br>" +
								"<a href=\"../../includes/terminos.html#type\">" + txTipoDato + "</a> " + etiquetaTipo + "\n";
				}

				longitud = nodoCampo.namedItem("length");
				if (longitud){
						var etiquetaLongitud = longitud.toElement().text();
						htmlContenidosTabla += "\t<br>" + txLongMaxima + " " + etiquetaLongitud + "\n";
				}

				primeraParte = nodoCampo.namedItem("partI");
				if (primeraParte){
						var etiquetaPrimeraParte= primeraParte.toElement().text();
						htmlContenidosTabla += "\t<br>" + txParteEntera + " " + etiquetaPrimeraParte + "\n";
				}

				segundaParte = nodoCampo.namedItem("partD");
				if (segundaParte){
						var etiquetaSegundaParte = segundaParte.toElement().text();
						htmlContenidosTabla += "\t<br>" + txParteDecimal + " " + etiquetaSegundaParte + "\n";
				}

				if (this.iface.tipoDoc == "guia_desarrollo") {
				
						contador = nodoCampo.namedItem("counter");
						if (contador){
								var etiquetaContador = contador.toElement().text();
								var valorCont = etiquetaContador;
								htmlContenidosTabla += "\t<br>" + txCont + " " + valorCont + "\n";
						}
		
						calculado = nodoCampo.namedItem("calculated");
						if (calculado){
								var etiquetaCalculado = calculado.toElement().text();
								var valorCal = etiquetaCalculado;
								htmlContenidosTabla += "\t<br>" + txCampoCalc + " " + valorCal + "\n";
						}
				}

// 				lista = nodoCampo.namedItem("optionslist");
// 				if (lista){
// 						var etiquetaLista = lista.toElement().text();
// 						htmlContenidosTabla += "\t<br>" + txListaOpciones + " " + etiquetaLista + "\n";
// 				}

				defecto = nodoCampo.namedItem("default");
				if (defecto){
						var etiquetaDefecto = this.iface.obtenerAlias(defecto.toElement().text());
						htmlContenidosTabla += "\t<br>" + txValorDefecto + " " + etiquetaDefecto + "\n";
				}
			
				visible = nodoCampo.namedItem("visible");
				if (visible){
						var etiquetaVisible = visible.toElement().text();
						var valorVi = etiquetaVisible;
						htmlContenidosTabla += "\t<br>" + txVisible + " " + valorVi + "\n";
				}
		
				if (this.iface.tipoDoc == "guia_desarrollo") {
				
						editable = nodoCampo.namedItem("editable");
						if (editable){
								var etiquetaEditable = editable.toElement().text();
								var valorEdi = etiquetaEditable;
								htmlContenidosTabla += "\t<br>" + txEditable + " " + valorEdi + "\n";
						}
		
						visibleg = nodoCampo.namedItem("visiblegrid");
						if (visibleg){
								var etiquetaVisibleg = visibleg.toElement().text();
								var valorVig = etiquetaVisibleg;
								htmlContenidosTabla += "\t<br>" + txVisibleGrid + " " + valorVig + "\n";
						}
		
						indice = nodoCampo.namedItem("index");
						if (indice){
								var etiquetaIndice = indice.toElement().text();
								var valorIn = etiquetaIndice;
								htmlContenidosTabla += "\t<br>" + txIndice + " " + valorIn + "\n";
						}
		
						unica = nodoCampo.namedItem("unique");
						if (unica){
								var etiquetaUnica = unica.toElement().text();
								var valorUn = etiquetaUnica;
								htmlContenidosTabla += "\t<br>" + txValorUnico + " " + valorUn + "\n";
						}
		
						reg= nodoCampo.namedItem("regexp");
						if (reg){
								var etiquetaReg = reg.toElement().text();
								htmlContenidosTabla += "\t<br>" + txContCampo + " " + etiquetaReg + "\n";
						}
		
						transaccion = nodoCampo.namedItem("outtransaction");
						if (transaccion){
								var etiquetaTransaccion = transaccion.toElement().text();
								var valorTra = etiquetaTransaccion;
								htmlContenidosTabla += "\t<br>" + txModCampo + " " + valorTra + "\n";
						}
				}

				listaRelaciones = nodoCampo.toElement().childNodes();
				
				for(k = 0; k < listaRelaciones.length(); k++) {						
						relacion = listaRelaciones.item(k);
						if (relacion.nodeName() == "relation") {
								htmlContenidosTabla += "\t<blockquote><i>" + txRelacionTabla + "</i>";
								tablaR = relacion.namedItem("table");
								if (tablaR){
										var etiquetaTablaR = tablaR.toElement().text();
										htmlContenidosTabla += "\t<br>" + txTabla + " " + etiquetaTablaR + "\n";
								}
		
								campoR = relacion.namedItem("field");
								if (campoR){
										var etiquetaCampoR = campoR.toElement().text();
										htmlContenidosTabla += "\t<br>" + txCampo + " " + etiquetaCampoR + "\n";
								}
		
								cardinalidad = relacion.namedItem("card");
								if (cardinalidad){
										var etiquetaCardinalidad = cardinalidad.toElement().text();
										htmlContenidosTabla += "\t<br><a href=\"../../includes/terminos.html#tipos_relacion\">";
										htmlContenidosTabla += txTipoRelacion + "</a> " + etiquetaCardinalidad + "\n";
								}
		
								borrado = relacion.namedItem("delC");
								if (borrado){
										var etiquetaBorrado = borrado.toElement().text();
										var valorBo = etiquetaBorrado;
										htmlContenidosTabla += "\t<br>" + "<a href=\"../../includes/terminos.html#delC\">";
										htmlContenidosTabla += txBorradoCascada + "</a>: " + valorBo + "\n";
								}
								htmlContenidosTabla += "\t</blockquote>\n";
						}
				}
				htmlContenidosTabla += "</div>\n";
				htmlContenidosTabla += "<p><a href=\"#inicio\">[inicio]</a></p>\n";
		}
		htmlMenuTabla += "</ul>\n";
 		
		var cabecera:String;
		if (this.iface.tipoDoc == "guia_desarrollo") 
			 cabecera = this.iface.crearCabecera(this.iface.nomModuloActual, "_paginafinal", "", txTabla + " " + nomTabla + " (" + aliasTabla + ")");
		else
			cabecera = this.iface.crearCabecera(this.iface.nomModuloActual, "_paginafinal", "", txTabla + " " + aliasTabla);
 		var htmlTabla = cabecera + htmlMenuTabla + htmlContenidosTabla;
		this.iface.escribirFichero("mtd_" + nomTabla + ".html", htmlTabla);
}

/** \D
Obtiene el documento xml correspondiente al script principal del módulo actual. Esta acción se realiza por razones de rendimiento
\end */
function oficial_obtenerScriptPpal()
{
	var ppal_rutaXML:String = this.iface.rutaSis + "sistema/documentacion/doxygen/xml/" + this.iface.nomModuloActual + ".xml";
	if (!File.exists(ppal_rutaXML)) {
		if (this.iface.xmlScriptPpal) {
			delete this.iface.xmlScriptPpal;
			this.iface.xmlScriptPpal = false;
		}
		return;
	}
	var fichero = new File (ppal_rutaXML);
	
	fichero.open(File.ReadOnly);
	this.iface.xmlScriptPpal = new FLDomDocument();
	this.iface.xmlScriptPpal.setContent(fichero.read());
	fichero.close();
}

/** \D
Procesa el codigo de un script de formulario de adición o maestro

Documentación de desarrollador. Lee el html obtenido por doxygen y lo adapta al formato del resto de la documentación. Genera el html con el código del script a partir del fichero .qs
	
Documentación de usuario. Lee el xml obtenido por doxygen y lo adapta al formato del resto de la documentación. Busca la documentación de las algunas funciones dentro del código del propio script, y la documentación de \e beforeCommit y \e afterCommit en el script principal del módulo. Con estas funciones se describe el comportamiento de un formulario para el usuario

@param	nomScript Nombre del script
@param	nomTabla Nombre de la tabla sobre la que actúa el script
\end */

function oficial_procesarScript(nomScript, nomTabla)
{
	debug("Procesando script " + nomScript);

	var ppal_rutaXML:String = this.iface.rutaSis + "sistema/documentacion/doxygen/xml/" + this.iface.nomModuloActual + ".xml"
	
	var htmlMenuScript:String = "";
	var htmlContenidoScript:String = "<div class=\"bloque_formulario\">";
	
	if (!nomScript) return false;	
	var primero:Number = 0;
	
	// Documentación de Desarrollador
	if (this.iface.tipoDoc == "guia_desarrollo") {
		var rutaHTML:String = this.iface.rutaSis + "sistema/documentacion/doxygen/html/" + nomScript + ".html"
		if(!File.exists(rutaHTML)) {
				return;
		}
		var fichCodigo:String = "codigo_" + nomScript + ".html";
		var regexpF = /function /;
		
		F = new File(rutaHTML);
		F.open(File.ReadOnly);
		var htmlDoxygen:String = F.read();
		F.close();
		// Se procesa el html obtenido por Doxygen para adaptarlo al formato del resto de la documentación
		htmlDoxygen = htmlDoxygen.split("</h1>");
		htmlDoxygen = htmlDoxygen[1];
		htmlDoxygen = htmlDoxygen.split("</body>");
		htmlDoxygen = htmlDoxygen[0];
		
		htmlDoxygen = this.iface.sustituyeString(htmlDoxygen, "__", "_");
		htmlDoxygen = this.iface.sustituyeString(htmlDoxygen, "_8qs", "");
		htmlDoxygen = this.iface.sustituyeString(htmlDoxygen, "<hr>", "<br>");
		htmlDoxygen = this.iface.sustituyeString(htmlDoxygen, "<h2>", "<h2>");
		htmlDoxygen = this.iface.sustituyeString(htmlDoxygen, "</h2>", "</h2>");
		htmlDoxygen = this.iface.sustituyeString(htmlDoxygen, "<h2>Descripción detallada</h2>", "");
		htmlDoxygen = this.iface.sustituyeString(htmlDoxygen, nomScript + ".html#", "#");
		// El html se procesa por líneas debido a las sustituciones previas
		var lineas:Array = htmlDoxygen.split("\n");
		htmlDoxygen = "";
			
		for (i = 0; i < lineas.length; i++) {
			linea = lineas[i];
			if (linea.match(regexpF)) {
				nomFuncion = linea.split("function");
				nomFuncion = nomFuncion[1];
				nomFuncion = nomFuncion.split(" ");
				nomFuncion = nomFuncion[1];
				
				linea += "<br><a href=\"" + fichCodigo + "#" + nomFuncion + "\">";
				linea += "[código]</a>";
			}								
			htmlDoxygen += linea + "\n";
		}

		// Se incluye el codigo del script como HTML
		var rutaQS:String = this.iface.rutaDox + "codigo/" + nomScript + ".qs";
		if(File.exists(rutaQS)) {
		
			var htmlCodigo:String = "";
									
			F = new File(rutaQS);
			F.open(File.ReadOnly)
			// Se buscan las líneas que contienen función para marcar los enlaces a las funciones que se colocarán en la página de la acción hacia la página del código
			while (true)	{
				if (F.eof) break;
				linea = F.readLine();
				if (linea.match(regexpF)) {
					nomFuncion = linea.split("(");
					nomFuncion = nomFuncion[0];
					nomFuncion = nomFuncion.split(" ");
					nomFuncion = nomFuncion[1];
					
					linea = "<p><a name=\"" + nomFuncion + "\"></a></p>" + linea;
				}								
				htmlCodigo += linea + "<br>";
			}
			F.close();

			htmlCodigo = this.iface.sustituyeString(htmlCodigo, "\t", "\t&nbsp;&nbsp;");
			
			var cabecera:String = this.iface.crearCabecera(this.iface.nomModuloActual, "_paginafinal", "", 
						txCodFuente + " " + nomScript);
			htmlCodigo = cabecera + htmlCodigo;
			this.iface.escribirFichero(fichCodigo, htmlCodigo);
		}
		htmlContenidoScript += htmlDoxygen;
		
		var htmlCommits:String = this.iface.obtenerFuncionDox("function interna_beforeCommit_" + nomScript, ppal_rutaXML);
		if (htmlCommits)
			htmlContenidoScript += "<br><h2>function beforeCommit( )</h2>\n" + htmlCommits;
		
		htmlCommits = this.iface.obtenerFuncionDox("function interna_afterCommit_" + nomScript, ppal_rutaXML);
		if (htmlCommits)
			htmlContenidoScript += "<br><h2>function afterCommit( )</h2>\n" + htmlCommits;
	}
	// Documentación de Usuario		
	
	var rutaXML = this.iface.rutaSis + "sistema/documentacion/doxygen/xml/" + nomScript + ".xml";
	if(!File.exists(rutaXML)) {
			return;
	}
	
	if (this.iface.tipoDoc == "guia_usuario") {
				
		// Se buscan las funciones que documentan el funcionamiento del formulario/script
		var contenidos:Array = this.iface.obtenerArrayFunciones(rutaXML);
		/*
		new Array(2);
		var k:Number = 0;
		
		contenidos[k] = new Array(2);
		contenidos[k]["titulo"] = txInfoGeneral;
		contenidos[k]["texto"] = this.iface.obtenerFuncionDox("_init", rutaXML);
		k++;
					
		contenidos[k] = new Array(2);
		contenidos[k]["titulo"] = txComportamientoForm;
		contenidos[k]["texto"] = this.iface.obtenerFuncionDox("_bufferChanged", rutaXML);
		k++;
		
		contenidos[k] = new Array(2);		
		contenidos[k]["titulo"] = txValidaciones;
		contenidos[k]["texto"] = this.iface.obtenerFuncionDox("_validateForm", rutaXML);
		k++;

		contenidos[k] = new Array(2);
		contenidos[k]["titulo"] = txDespuesBorrar;
		// para eliminar la cadena "master" del nombre  cuando esta en un form master			
		contenidos[k]["texto"] = 
				this.iface.obtenerFuncionDox("_recordDelAfter" + nomScript.right(nomScript.length-5), rutaXML);
		k++;
		
		contenidos[k] = new Array(2);
		contenidos[k]["titulo"] = txAntesBorrar;
		// para eliminar la cadena "master" del nombre  cuando esta en un form master			
		contenidos[k]["texto"] = 
				this.iface.obtenerFuncionDox("_recordDelBefore" + nomScript.right(nomScript.length-5), rutaXML);
		k++;
		
		// Unir acceptedForm y beforeCommit
		contenidos[k] = new Array(2);
		contenidos[k]["titulo"] = txAntesGuardar;
		contenidos[k]["texto"] = this.iface.obtenerFuncionDox("_beforeCommit_" + nomScript, ppal_rutaXML);
		contenidosTexto2 = this.iface.obtenerFuncionDox("_acceptedForm", rutaXML);
		contenidos[k]["texto"] = contenidos[k]["texto"] + contenidosTexto2;
		k++;
		
		contenidos[k] = new Array(2);		
		contenidos[k]["titulo"] = txDespuesGuardar;
		contenidos[k]["texto"] = this.iface.obtenerFuncionDox("_afterCommit_" + nomScript, ppal_rutaXML);
		*/
		
		var k:Number = contenidos.length;
		
		contenidos[k] = new Array(2);
		contenidos[k]["titulo"] = txAntesGuardar;
		contenidos[k]["texto"] = this.iface.obtenerFuncionScriptPpal("_beforeCommit_" + nomScript);
		k++;
		
		contenidos[k] = new Array(2);
		contenidos[k]["titulo"] = txDespuesGuardar;
		contenidos[k]["texto"] = this.iface.obtenerFuncionScriptPpal("_afterCommit_" + nomScript);

		htmlMenuScript = "<div class=\"menu_doc\">\n";
		htmlContenidosScript = "<br>&nbsp;<br><br><br>\n";
		for (i = 0; i < contenidos.length; i++) {
			if (contenidos[i]["texto"] && contenidos[i]["titulo"]) {
				htmlMenuScript += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"#contenidos" + i + "\">";
				htmlMenuScript += contenidos[i]["titulo"] + "</a><br>\n";
				
				if (primero++ > 0) htmlContenidoScript += "<br>";
				htmlContenidoScript += "<p><h2>\n";
				htmlContenidoScript += "<a name = \"contenidos" + i + "\"></a>\n";
				htmlContenidoScript += contenidos[i]["titulo"] + "</h2></p>\n";
				htmlContenidoScript += contenidos[i]["texto"] + "\n";								
			}
		}
		htmlMenuScript += "</div>\n";
	}

	if (htmlContenidoScript == "<div class=\"bloque_formulario\">") {
			return false;
	}
												
	var nombre:String;
	var alias:String;
	
	// Se busca el nombre de los campos de la tabla en el texto obtenido del script para sustituirlos por el alias del campo y un enlace a la página de la tabla
	for (i = 1; i < this.iface.listaCamposTab.length; i++)
	{
		nombre = this.iface.listaCamposTab[i]["nombre"];
		alias = this.iface.obtenerAlias(this.iface.listaCamposTab[i]["alias"]);
		if (alias == "") alias = nombre;
		
		alias = alias.toLowerCase();
		if (nomTabla) link = "<a href=\"mtd_" + nomTabla + ".html#" + nombre + "\">" + alias + "</a>";
		
		htmlContenidoScript = this.iface.sustituyeString(htmlContenidoScript, "--" + nombre + "--", link);
	}
	
	htmlContenidoScript += "</div>\n";
	
	var result:Array = new Array(htmlMenuScript, htmlContenidoScript);
	return result;
}

/** \D Realiza la captura del gráfico del formulario y procesa el fichero .ui del mismo buscando botones, de los que obtiene las propiedades que describen su comportamiento

@return Array con los datos de todos los botones del formulario
\end */
function oficial_procesarForm(rutaArea, dirModulo, accion, tabla, fR, fM)
{
	debug("Procesando formulario " + fR + " " + fM);

	var fdb;
	
	this.iface.rutaImg = this.iface.rutaDoc + this.iface.nomAreaActual + "/" + this.iface.nomModuloActual;
	var dirRutaImg = new Dir(this.iface.rutaImg);
	var rutaForm:String;
	var nomForm:String;
	var esOtroMaster:Boolean = false;
	
	/** Se comprueba si existe el directorio de imágenes; si no, se crea
	*/		
	if (!dirRutaImg.fileExists("images"))	dirRutaImg.mkdir("images");
	this.iface.rutaImg += "/images/";
	// Form master
	if (fM) {
		rutaForm = rutaArea + "/" + dirModulo + "/forms/" + fM + ".ui";
		
		if (!File.exists(rutaForm)) {
			if (fM == "master") {
				if (File.exists(this.iface.rutaImg + fM + ".png"))
					esOtroMaster = true;
			} else
				return false;
		}
		if (this.iface.capturarForms && !esOtroMaster) {
			fdb = new FLFormDB(accion, 0, 0);
			fdb.setMainWidget();
			fdb.showForDocument();
			fdb.saveSnapShot(this.iface.rutaImg + fM + ".png");
			fdb.close();
		}
		if (fM == "master") 
			return "<nada></nada>";
		
		nomForm = fM;
	}		
	// Form record
	else {				
		rutaForm = rutaArea + "/" + dirModulo + "/forms/" + fR + ".ui";
		if (!File.exists(rutaForm)) return false;
		if (this.iface.capturarForms) {
			var cursor = new FLSqlCursor(tabla);
			cursor.select();
			cursor.setModeAccess(cursor.Edit);
			cursor.first();
			
			fdb = new FLFormRecordDB(cursor, accion, 0, false);	 
			fdb.setMainWidget();
			fdb.showForDocument();
			if (fR == "pr_cortes") MessageBox.information("hola");
			fdb.saveSnapShot(this.iface.rutaImg + fR + ".png");
			fdb.close();
		}
		nomForm = fR;
	}
		
/** \D Para obtener los datos de los botones del formulario se buscan los nodos de boton (QPushButton) y de radio (QRadioButton) y se extraen las propiedades whatsThis y toolTip
\end */
	var botonesForm:Array = new Array(2);
	var iconosForm:Array = new Array(2);
	
	var fichForm = new File(rutaForm);
	fichForm.open(File.ReadOnly);
	var xmlForm = new FLDomDocument();
	xmlForm.setContent(fichForm.read());		
	fichForm.close();
	var listaBotones = xmlForm.elementsByTagName("widget");
	var numBotones:Number = 0;
	
	for (var i = 0; i < listaBotones.length(); i++) {
			
		clase = listaBotones.item(i).attributeValue("class");
		if (clase == "QPushButton" || clase == "QRadioButton" || clase == "QToolButton") {
			botonesForm[numBotones] = new Array(2);
			botonesForm[numBotones]["name"] = "";
			botonesForm[numBotones]["text"] = "";
			botonesForm[numBotones]["toolTip"] = "";
			botonesForm[numBotones]["whatsThis"] = "";
			botonesForm[numBotones]["pixmap"] = "";
			botonesForm[numBotones]["iconSet"] = "";
			listaPropiedades = listaBotones.item(i).toElement().childNodes();
			for(var j = 0; j < listaPropiedades.length(); j++) {
					propiedad = listaPropiedades.item(j).attributeValue("name");
					if (propiedad == "name" ||
							propiedad == "text" ||
							propiedad == "toolTip" ||
							propiedad == "whatsThis" ||
							propiedad == "pixmap" ||
							propiedad == "iconSet") {
							botonesForm[numBotones][propiedad] = listaPropiedades.item(j).firstChild().toElement().text();
					}
			}
			if (botonesForm[numBotones]["name"].startsWith("tool"))
				continue;
			numBotones++;
		}
	}
	// Se obtienen las imagenes de los iconos
	if (this.iface.capturarForms) {
		var listaImagenes = xmlForm.elementsByTagName("image");
		var numImagenes:Number = 0;
		if (listaImagenes) {
			for (var i = 0; i < listaImagenes.length(); i++) {			
				nombreImagen = listaImagenes.item(i).attributeValue("name");
				datosImagen = listaImagenes.item(i).namedItem("data").toElement().text();
				this.iface.util.saveIconFile(datosImagen, this.iface.rutaImg + nomForm + "_bot_" + nombreImagen + ".png");
			}
		}
	}
	
	// Se obtienen y procesan los textos de los botones del formulario
	var htmlBotones:String = "<nada></nada>";
			
	if (numBotones > 0) {
		htmlBotones += "<div class=\"botones_doc\">\n";
		htmlBotones += "<h2>" + txTitBotones + "</h2>\n";
		htmlBotones += "<div class=\"lista_contenidos_doc\">\n";

		for (var i = 0; i < numBotones; i++) {
			htmlBotones += "<li>";						
			
			if (this.iface.capturarForms && botonesForm[i]["iconSet"]) {
					nomImgIcono = nomForm + "_bot_" + botonesForm[i]["iconSet"] + ".png";
					htmlBotones += "<img valign=\"middle\" width=\"22\" height=\"22\" src=\"images/" + nomImgIcono + "\">&nbsp;&nbsp;";
			}
			
			if (this.iface.capturarForms && botonesForm[i]["pixmap"]) {
					nomImgIcono = nomForm + "_bot_" + botonesForm[i]["pixmap"] + ".png";
					htmlBotones += "<img valign=\"middle\" width=\"22\" height=\"22\" src=\"images/" + nomImgIcono + "\">&nbsp;&nbsp;";
			}
			
			if (botonesForm[i]["text"])
					htmlBotones += "<i>" + this.iface.sustituyeString(botonesForm[i]["text"], "&", "") + "</i> - ";						
			if (botonesForm[i]["toolTip"])
					htmlBotones += botonesForm[i]["toolTip"] + "&nbsp;&nbsp;&nbsp;";
			if (botonesForm[i]["whatsThis"])
					htmlBotones += botonesForm[i]["whatsThis"];
			
			htmlBotones += "</li>"
		}
		htmlBotones += "</div></div>";
	}
	return htmlBotones;
}

/** \D Obtiene los datos del área desde el fichero xml

@param	nomAreaActual Nombre del área
@param	rutaXML Ruta al fichero xml del área
\end */
function oficial_datosArea(rutaXML):Boolean
{
	if (!File.exists(rutaXML)) return;
	
	var fichDesxml = new File(rutaXML);
	fichDesxml.open(File.ReadOnly);
	var xmlArea = new FLDomDocument();
	xmlArea.setContent(fichDesxml.read());
	fichDesxml.close();
	
	var listaArea = xmlArea.elementsByTagName("AREA");
	
	var aliasA:String = "";
	var texA:String = "";
	var codA:String = "";
	
	for(var i = 0; i< listaArea.length(); i++){
			
			nodo = listaArea.item(i).namedItem("alias");
			if (nodo) {
				aliasA = nodo.toElement().text();
				aliasA = this.iface.obtenerAlias(aliasA);
			}
			
			nodo = listaArea.item(i).namedItem("description");
			if (nodo) texA = nodo.toElement().text();
			
			nodo = listaArea.item(i).namedItem("code");
			if (nodo) codA = nodo.toElement().text();
			
	}
	
	this.iface.listaAreas[this.iface.nomAreaActual] = new Array(2);
	this.iface.listaAreas[this.iface.nomAreaActual]["alias"] = aliasA;
	this.iface.listaAreas[this.iface.nomAreaActual]["texto"] = texA;
	this.iface.listaAreas[this.iface.nomAreaActual]["codigo"] = codA;

	return true;
}

/** \D Actualiza la lista de módulos que hay en disco y los introduce en la tabla de datos. Hace una pasada por los directorios desde el directorio de los módulos
\end */
function oficial_actualizarLista()
{
	if (!this.iface.inicializar()) return;
	
	var dirAreas = new Dir(this.iface.ruta);
	var areas = dirAreas.entryList("*", Dir.Dirs);
	var modulos;
	var nomFicheroMod:String;
	var idGenerarDoc = this.cursor().valueBuffer("id");
							
	// borrar la tabla				
	var cursor:FLSqlCursor = new FLSqlCursor("do_modulosdoc");
	cursor.select("idgenerardoc = " + this.cursor().valueBuffer("id")) ;
	while (cursor.next()) {
		cursor.setModeAccess(cursor.Del);
		cursor.refreshBuffer();
		cursor.commitBuffer();
	}
						
	for (var i = 0; i < areas.length; i++){
			
		if (areas[i] == "." || areas[i] == "..") continue;
		
		var rutaArea:String = this.iface.ruta + areas[i];
		var dirArea = new Dir(rutaArea);
		
		modulos = dirArea.entryList("*", Dir.Dirs);
		for (var j = 0; j < modulos.length; j++) {
			if (modulos[j] == "." || modulos[j] == ".." || modulos[j].right(4) == ".xml") continue;
			
			try {	dirArea.cd(modulos[j]);	}
			catch (e) {	
				MessageBox.critical(this.iface.util.
					translate("scripts", "Se produjo un error al acceder al directorio" +
							rutaArea + modulos[j]),
					MessageBox.Ok, MessageBox.NoButton,
					MessageBox.NoButton);
			}		
			
			nomFicheroMod = dirArea.entryList("*.mod", Dir.Files);
			if (nomFicheroMod.length != 1) {
				dirArea.cdUp();
				continue;
			}						
			
			nomFicheroMod = nomFicheroMod[0];
			nomModulo = nomFicheroMod.left(nomFicheroMod.length - 4);
			
			cursor.setModeAccess(cursor.Insert);
			cursor.refreshBuffer();
			cursor.setValueBuffer("modulo", modulos[j]);
			cursor.setValueBuffer("area", areas[i]);
			cursor.setValueBuffer("codigomodulo", nomModulo);
			cursor.setValueBuffer("documentar", false);
			cursor.setValueBuffer("idgenerardoc", idGenerarDoc);
			cursor.commitBuffer();
			
			dirArea.cdUp();
		}
  	}
	this.child("tdbModulosDoc").refresh();
}

/** \C Cambia el estado del campo Documentar del registro seleccionado la tabla de datos
\end */
function oficial_cambiarEstado()
{
	var idmodulo:Number = this.child("tdbModulosDoc").cursor().valueBuffer("idmodulo");
	
	if (!idmodulo) return;

	var cursor:FLSqlCursor = new FLSqlCursor("do_modulosdoc");
	cursor.select("idmodulo = " + idmodulo);
	if (cursor.first()) {
		cursor.setModeAccess(cursor.Edit);
		cursor.refreshBuffer();
		documentar = cursor.valueBuffer("documentar");		
		cursor.setValueBuffer("documentar", true);
		if (documentar) cursor.setValueBuffer("documentar", false);
		cursor.commitBuffer();
	}

	this.child("tdbModulosDoc").refresh();
}

/** \D Actualiza la fecha de última generación de documentación para un módulo

@param	area Area del módulo
@param	modulo Módulo
\end */
function oficial_actualizarFecha(area, modulo)
{
	var fecha:Date = new Date();
	var cursor:FLSqlCursor = new FLSqlCursor("do_modulosdoc");
	cursor.select("area = '" + area + "' AND modulo = '" + modulo + "' AND idgenerardoc = " + this.cursor().valueBuffer("id"));
	
	var nomCampo:String = "fechau";
	if (this.iface.tipoDoc == "guia_desarrollo")
			nomCampo = "fechad";
	
	if (cursor.first()) {
		cursor.setModeAccess(cursor.Edit);
		cursor.refreshBuffer();
		cursor.setValueBuffer(nomCampo, fecha.toString());
		cursor.commitBuffer();
	}

	this.child("tdbModulosDoc").refresh();
}

/** \D Comprueba si hay módulos en la tabla marcados para ser documentados

@return True si los hay, False en caso contrario
\end */
function oficial_modulosParaDocumentar():Boolean
{
	var faltan:String = "";
	var hayModulos:Boolean = false;

	var cursor:FLSqlCursor = new FLSqlCursor("do_modulosdoc");
	
	cursor.select("documentar = true AND idgenerardoc = " + this.cursor().valueBuffer("id"));
		
	while (cursor.next()) {
		
		cursor.setModeAccess(cursor.Browse);
		if (!sys.isLoadedModule(cursor.valueBuffer("codigomodulo")))
			faltan += "\nMódulo " + cursor.valueBuffer("modulo") + ", área " + cursor.valueBuffer("area");
			
		hayModulos = true;
	}
	
	if (faltan) {
		MessageBox.critical(this.iface.util.
				translate("scripts", "Para documentar previamente hay que cargar los módulos siguientes:\n") + faltan,
				MessageBox.Ok, MessageBox.NoButton,
				MessageBox.NoButton);
		return false;
	}
	
	if (!hayModulos) {
		MessageBox.critical(this.iface.util.
				translate("scripts", "No hay módulos seleccionados en la tabla"),
				MessageBox.Ok, MessageBox.NoButton,
				MessageBox.NoButton);
		return false;
	}
	
	return true;
}

/** \D Procesa el fichero doxyfile para habilitar las secciones correspondientes al tipo de documentación en el proceso doxygen (desarrollo/usuario)

\end */
function oficial_procesarDoxyfile() 
{ 
	var fichDF = new File(this.iface.rutaDox + "doxyfile");
	fichDF.open(File.ReadOnly);
	var contenido = fichDF.read();
	fichDF.close();

	contenido = contenido.split("secciones_facturalux");
	var enabledSections:String = "ENABLED_SECTIONS = c";
		
    switch(this.iface.tipoDoc) {  
		case "guia_usuario": 
			enabledSections += " u";
			break 

		case "guia_desarrollo": 
			enabledSections += " d";
			break 
	}
	
	contenido = contenido[0] + "secciones_facturalux\n" + enabledSections
	
	fichDF.open(File.WriteOnly);
	fichDF.write(contenido);
	fichDF.close();
} 


/** \D Sustituye una cadena por otra en un texto. Utilizada para procesar ficheros de texto

@param	texto Texto original
@param	cadena1 Cadena buscada
@param	cadena2 Cadena de sustitución
@return	Texto modificado
\end */
function oficial_sustituyeString(texto, cadena1, cadena2):String
{
	var patternRE:RegExp = new RegExp(cadena1);
	patternRE.global = true;
	return texto.replace(patternRE, cadena2);	
}

/** \D Añade entradas al fichero html de la tabla de contenidos (índice general de la documentación)

@param	tipo Tipo de enlace (area, módulo, acción, tabla o formulario)
@param	texto Texto del enlace
@param	link Página html destino
\end */
function oficial_agregarContenidos(tipo, accion, pagina)
{
	var cursor:FLSqlCursor = new FLSqlCursor("do_contenidos");
	cursor.select("area = '" + this.iface.nomAreaActual + "' AND " + 
			"modulo = '" + this.iface.nomModuloActual + "' AND " + 
			"accion = '" + accion + "'");
	if (!cursor.first()) {
		cursor.setModeAccess(cursor.Insert);
		cursor.refreshBuffer();
		cursor.setValueBuffer("area", this.iface.nomAreaActual);
		cursor.setValueBuffer("aliasarea", this.iface.aliasAreaActual);
		cursor.setValueBuffer("modulo", this.iface.nomModuloActual);
		cursor.setValueBuffer("aliasmodulo", this.iface.aliasModuloActual);
		cursor.setValueBuffer("accion", accion);
		cursor.setValueBuffer("pagina", pagina);
		cursor.commitBuffer();
	}
}

/** \D Añade entradas al fichero html de la tabla de contenidos (índice general de la documentación). Obtiene las entradas de la tabla do_contenidos

\end */
function oficial_generarContenidos()
{
	var q:FLSqlQuery = new FLSqlQuery();
	
	q.setTablesList("do_contenidos");
	q.setFrom("do_contenidos");
	q.setSelect("area, aliasarea, modulo, aliasmodulo, accion, pagina");
	q.setOrderBy("area, modulo, accion");
	
	if (!q.exec()) {
			MessageBox.critical(this.iface.util.
													translate("scripts", "Error al ejecutar la consulta de generación de contenidos"),
													MessageBox.Ok, MessageBox.NoButton,
													MessageBox.NoButton);
			return false;
	}
	
	var htmlIndiceAreas:String = "<b><u>" + txResumenContenidos + "</b></u><br>&nbsp;<br>";
	var htmlIndice:String = "<br>&nbsp;<br>&nbsp;<br><b><u>" + txListaContenidos + "</b></u><br>&nbsp;<br>";
	var areaQ:String = "";
	var moduloQ:String = "";
	
	while (q.next()) {
	
		if (q.value(0) != areaQ) {
		
			if (areaQ != "") htmlIndiceAreas += "<br>&nbsp;<br>";
			htmlIndiceAreas += "<a href=\"" + q.value(0) + "/" + q.value(0) + ".html\">";
			htmlIndiceAreas += "<b>" + q.value(1) + "</b></a>";
			
			if (areaQ != "") htmlIndice += "<br>&nbsp;<br>";
			htmlIndice += "<a href=\"" + q.value(0) + "/" + q.value(0) + ".html\">";
			htmlIndice += "<b>" + q.value(1) + "</b></a>";						
			
			areaQ = q.value(0);
		}
				
		if (q.value(2) != moduloQ) {
			htmlIndiceAreas += "<br>" + sepTOC + "<a href=\"" + q.value(0) + "/" + q.value(2) + "/" + q.value(2) + ".html\">";
			htmlIndiceAreas += q.value(3) + "</a>";
			
			htmlIndice += "<br>&nbsp;<br>" + sepTOC;
			htmlIndice += "<span class=\"toc_modulo_doc\">\n";
			htmlIndice += "<a href=\"" + q.value(0) + "/" + q.value(2) + "/" + q.value(2) + ".html\">"; 
			htmlIndice += "<b>" + txModulo + " " + q.value(3) + "</b></a></span>";
			
			moduloQ = q.value(2);
		}
				
		htmlIndice += "<br>" + sepTOC + sepTOC;
		htmlIndice += "<span class=\"toc_accion_doc\">\n";
		htmlIndice += "<a href=\"" + q.value(0) + "/" + q.value(2) + "/" + q.value(5) + "\">";
		htmlIndice += q.value(4) + "</a></span>";
	}		

	/** \D Al final de la tabla de contenidos se añade un enlace a la página de términos
	\end */		
	htmlIndice += "<br>&nbsp;<br>&nbsp;<br>";
	htmlIndice += "<span class=\"toc_accion_doc\">\n";
	htmlIndice += "<a href=\"includes/terminos.html\">";
	htmlIndice += txTerminos + "</a></span>";
	
	htmlIndice += this.iface.generarLicencia();
	
	var cabecera:String = this.iface.crearCabecera("", "_indice", "", "");
	
	htmlIndiceAreas = "<div class = \"toc_menuresumen_doc\">" + htmlIndiceAreas + "</div>";
	htmlIndice = "<div class = \"toc_menucompleto_doc\">" + htmlIndice + "</div>";
	
	htmlIndice = cabecera + htmlIndiceAreas + htmlIndice;
	
	this.iface.escribirFichero("index.html", htmlIndice, "indice");
}


/** \D Busca el archivo .xml del módulo nomModuloActual y devuelve el alias del módulo y el alias del área. Utilizado para obtener las dependencias entre módulos

@return Array de dos dimensiones con el título del módulo y nombre del área
\end */
function oficial_infoModulo(nomModulo):String
{
	var rutaPpal = this.iface.ruta; 
	var dirPpal = new Dir(rutaPpal);
	var areas = dirPpal.entryList("*", Dir.Dirs);
	
	var rutaArea:String;
	var dirArea:String;
	var modulos:String;
	var nomArea:String;
	var aliasModulo:String;

	var fichMod:String;

	var result:Array = new Array(2);

	for (var i = 0; i < areas.length; i++) {
		if (areas[i] == "." || areas[i] == "..") continue;

		rutaArea = rutaPpal + "/" + areas[i];
		dirArea = new Dir(rutaArea);
		modulos = dirArea.entryList("*", Dir.Dirs);
		
		for (var j = 0; j < modulos.length; j++) {
			if (modulos[j] == "." || modulos[j] == "..") continue;
			
			rutaFichMod = rutaArea + "/" + modulos[j];								
					
			if (File.exists(rutaFichMod + "/" + nomModulo + ".mod")) {
				var fichModulo = new File(rutaFichMod + "/" + nomModulo + ".mod");
				fichModulo.open(File.ReadOnly);								
				var xmlModulo = new FLDomDocument();
				xmlModulo.setContent(fichModulo.read());
				fichModulo.close();
				
				var listaModulo = xmlModulo.elementsByTagName("MODULE");
				nomArea = "";
				aliasModulo = "";
				
				if (listaModulo.item(0).namedItem("alias"))
					aliasModulo = this.iface.obtenerAlias(listaModulo.item(0).namedItem("alias").toElement().text());
				if (listaModulo.item(0).namedItem("areaname"))
					aliasArea = this.iface.obtenerAlias(listaModulo.item(0).namedItem("areaname").toElement().text());
				
				result["modulo"] = aliasModulo;
				result["area"] = aliasArea;
				return result;
			}
		}													
	}
	return "";
}

/** \D Carga al archivo footer.html como pie de página

@return	Código html del pie de página
\end */
function oficial_leerFooter():String
{
	var rutaDes:String = this.iface.rutaDoc + "../footer.html";
	
	var f = new File(rutaDes);
	f.open(File.ReadOnly);
	var contenido:String = f.read();
	f.close();
	
	return contenido;
}

/** \D Crea la cabecera de las páginas del manual formada por título, línea horizontal y barra de navegación

@param	nomModulo Nombre del módulo
@param	nomAccion Nombre interno de la acción
@param	titAccion Título o nombre público de la acción
@param	pagFinal Título de la página de tabla de datos o script de código, en su caso
@return	Código html con la cabecera
\end */ 
function oficial_crearCabecera(nomModulo, nomAccion, titAccion, pagFinal):String
{
	var rastro:String;
	var titulo:String;
	var sep:String = "&nbsp;&nbsp;<font color=\"#555555\">|</font>&nbsp;&nbsp;";		
	var linea:String = "&nbsp;&nbsp;<font color=\"#555555\">";
		
	rastro = rastro = "<a href=\"../index.html\">" + txTitIndice + "</a>";
	rastro += sep + this.iface.aliasAreaActual;
	titulo = this.iface.aliasAreaActual;
	
	// El rastro es el listado de enlaces. Se sobreescribe según sea el tipo de página
	if (nomModulo) {
		rastro = "<a href=\"../../index.html\">" + txTitIndice + "</a>";
		rastro += sep + "<a href=\"../" + this.iface.nomAreaActual + ".html\">" + this.iface.aliasAreaActual + "</a>";
		rastro += sep + txModulo + " " + this.iface.aliasModuloActual;
		titulo = txModulo + " " + this.iface.aliasModuloActual;
	}
			
	if (nomAccion) {
		rastro = "<a href=\"../../index.html\">" + txTitIndice + "</a>";
		rastro += sep + "<a href=\"../" + this.iface.nomAreaActual + ".html\">" + this.iface.aliasAreaActual + "</a>";
		rastro += sep + "<a href=\"" + nomModulo + ".html\">" + txModulo + " " + this.iface.aliasModuloActual + "</a>";
		rastro += sep + titAccion;
		titulo = titAccion;
	}
	
	if (pagFinal) {
		rastro = "<a href=\"../../index.html\">" + txTitIndice + "</a>";
		rastro += sep + "<a href=\"../../" + this.iface.nomAreaActual + ".html\">" + this.iface.aliasAreaActual + "</a>";
		rastro += sep + "<a href=\"../" + nomModulo + ".html\">" + txModulo + " " + this.iface.aliasModuloActual + "</a>";
		rastro += sep + "<a href=\"xml_" + nomAccion + ".html\">" + titAccion + "</a>";
		rastro += sep + pagFinal;
		titulo = pagFinal;
	}

	if (nomAccion == "_paginafinal") {
		rastro = "<a href=\"../../index.html\">" + txTitIndice + "</a>";
		rastro += sep + "<a href=\"../" + this.iface.nomAreaActual + ".html\">" + this.iface.aliasAreaActual + "</a>";
		rastro += sep + "<a href=\"" + nomModulo + ".html\">" + txModulo + " " + this.iface.aliasModuloActual + "</a>";
		rastro += sep + pagFinal;
		titulo = pagFinal;
	}
				
	if (nomAccion == "_indice") {
		rastro = txTitIndice + " - " + txToc;
		titulo = this.cursor().valueBuffer("titulo");
	}
	
	var result:String = "\n<h1>" + titulo + "</h1>" +
		"<hr size=1>\n" + rastro +
		"\n<div class=\"contenidos_doc\"><br>&nbsp;<br>";
				
	return result;
}

/** \D Obtiene el alias de una cadena del tipo QT_TRANSLATE_NOOP("MetaData","alias") y a su vez devuelve la traducción

@param	cadena Texto a traducir
@return	Traducción
\end */
function oficial_obtenerAlias(cadena):String
{

	var contexto;
	if (cadena.find("QT_TRANSLATE_NOOP") == -1) return cadena;
	
	var partes:Array = cadena.toString().split("\"");
	if (partes.length > 3) {
		contexto = partes[1];
		return this.iface.util.translate(contexto, partes[3]);
	}
	
	var partes:Array = cadena.toString().split("&quot;");
	if (partes.length > 3) {
		contexto = partes[1];
		return this.iface.util.translate(contexto, partes[3]);
	}
	return cadena;
}

/** \D Vuelca un string en un fichero html, al que añade las etiquetas html de cabecera y pie comunes a la documentación

@param	nombre Nombre del fichero
@param	contenido String con el contenido html del fichero
@param	tipo Tipo jerárquico del fichero: indice, area, modulo, submodulo
\end */
function oficial_escribirFichero(nombre, contenido, tipo)
{	
	var dirRutaDoc = new Dir(this.iface.rutaDoc);
	var nivelEstilos:String;
	var rutaDes:String; 
	
	/** Se comprueba si existen los directorios de tipo, área y módulo; si no, se crean
	\end */		
	if (!dirRutaDoc.fileExists(this.iface.nomAreaActual))
			dirRutaDoc.mkdir(this.iface.nomAreaActual);
			
	if (!dirRutaDoc.fileExists(this.iface.nomAreaActual + "/" + this.iface.nomModuloActual))
			dirRutaDoc.mkdir(this.iface.nomAreaActual + "/" + this.iface.nomModuloActual);
	
	switch (tipo) {
	
		case "indice":
				nivelEstilos = "includes/";
				rutaDes = this.iface.rutaDoc + nombre;
				break;		
		case "area":
				nivelEstilos = "../includes/";
				rutaDes = this.iface.rutaDoc + this.iface.nomAreaActual + "/" + nombre;
				break;
		default:
				nivelEstilos = "../../includes/";
				rutaDes = this.iface.rutaDoc + this.iface.nomAreaActual + "/" + this.iface.nomModuloActual + "/" + nombre;
				break;
	}
					
	var encabezado:String = "<html><head>\n";
	encabezado += "<title>" + this.cursor().valueBuffer("titulo") + "</title>\n";
	encabezado += "<link rel=\"StyleSheet\" href=\"" + nivelEstilos + "estilos.css\" type=\"text/css\">\n";
	encabezado += "<link rel=\"StyleSheet\" href=\"" + nivelEstilos + this.iface.tipoDoc + ".css\" type=\"text/css\">\n";
	encabezado += "</head>\n<body>\n";
	encabezado += "<br>\n";
	encabezado += "<a name=\"inicio\"></a>\n";
			
	var pie:String = "</div></body></html>";
	
	contenido = encabezado + contenido + pie;
	
	var f = new File(rutaDes);
	f.open(File.WriteOnly);
	f.write(contenido);
	f.close();	
}

/** \D
Compone el array con la documentación de las principales funciones de un script, a partir del fichero .xml creado previemente por Doxygen.

@param	nomFichero Nombre del fichero xml
@return	Texto de la función o cadena vacía si no se encuentra
\end */
function oficial_obtenerArrayFunciones(nomFichero:String):Array
{
	const FN_INIT = 0;
	const FN_BCH = 1;
	const FN_VF = 2;
	const FN_RDA = 3;
	const FN_RDB = 4;
	const FN_CF = 5;
	
	var contenidos:Array  = new Array(6);
	for (var i:Number = 0; i < 6; i++) {
		contenidos[i] = new Array(2);
		contenidos[i]["titulo"] = false;
		contenidos[i]["texto"] = "";
	}
	
	if (!File.exists(nomFichero)) return "";
	var fichero = new File (nomFichero);
	
	fichero.open(File.ReadOnly);
	var xmlComentario = new FLDomDocument();
	xmlComentario.setContent(fichero.read());
	fichero.close();
	var listaEtiquetas = xmlComentario.elementsByTagName("memberdef");
	var funcion:String;
	var lblLink:RegExp = new RegExp("link_");
	var listaIniciada:Array = new Array(6);
	for (var k:Number = 0; k < 6; k++)
		listaIniciada[k] = false;;
	var nomFuncion:String;
	var indice:Number = 0;
	for(var i = 0; i< listaEtiquetas.length();i++){
	
		funcion = listaEtiquetas.item(i).namedItem("definition").toElement().text();
		// Obtener la parte derecha de la función
		var idxGuion = funcion.find("_");
		if (idxGuion == -1) continue;
		nomFuncion = funcion.right(funcion.length - idxGuion);
		
		if (nomFuncion == "_init") {
			indice = FN_INIT;
			contenidos[indice]["titulo"] = txInfoGeneral;
			
		} else if (nomFuncion == "_bufferChanged") {
			indice = FN_BCH;
			contenidos[FN_BCH]["titulo"] = txComportamientoForm;
			
		} else if (nomFuncion == "_validateForm") {
			indice = FN_VF;
			contenidos[FN_VF]["titulo"] = txValidaciones;
			
		} else if (nomFuncion.startsWith("_recordDelAfter")) {
			indice = FN_RDA;
			contenidos[FN_RDA]["titulo"] = txDespuesBorrar;
			
		} else if (nomFuncion.startsWith("_recordDelBefore")) {
			indice = FN_RDB;
			contenidos[FN_RDB]["titulo"] = txAntesBorrar;
			
		} else if (nomFuncion.startsWith("_calculateField")) {
			indice = FN_CF;
			contenidos[FN_CF]["titulo"] = txCamposCalculados;
			
		} else continue;
		
		elemDD = listaEtiquetas.item(i).namedItem("detaileddescription").toElement();
		if (elemDD.hasChildNodes()) {
			listaDD = elemDD.childNodes();
			listaIniciada[indice] = false;
			
			for(var j = 0; j< listaDD.length(); j++) {
				switch (listaDD.item(j).nodeName()) {
						
					case "para": 
						para = listaDD.item(j).toElement().text();
						if (!listaIniciada[indice]) {
							contenidos[indice]["texto"] += "<div class=\"lista_contenidos_doc\">\n";
							listaIniciada[indice] = true;
						}
						contenidos[indice]["texto"] += "<li>" + para + "</li>\n";
					break;
				}
			}
		}
		elemDD = listaEtiquetas.item(i).namedItem("inbodydescription").toElement();
		if (elemDD.hasChildNodes()) {
			listaDD = elemDD.childNodes();
			
			for(var j = 0; j< listaDD.length(); j++) {
			
				switch (listaDD.item(j).nodeName()) {
						
					case "para": 
						para = listaDD.item(j).toElement().text();
						if (!listaIniciada[indice]) {
							contenidos[indice]["texto"] += "<div class=\"lista_contenidos_doc\">\n";
							listaIniciada[indice] = true;
						}
						contenidos[indice]["texto"] += "<li>" + para + "</li>\n";
					
					break;
				}
			}
		}
		if (listaIniciada[indice])
			contenidos[indice]["texto"] += "</div>\n";

	}
	return contenidos;
}

/** \D
Busca el texto descriptivo de una funcion que se encuentra en el fichero .xml correspondiente al script principal del módulo

@param	nomFunción Nombre de la función
@return	Texto de la función o cadena vacía si no se encuentra
\end */
function oficial_obtenerFuncionScriptPpal(nomFuncion):String
{
	if (!this.iface.xmlScriptPpal)
		return "";
	
	var listaEtiquetas = this.iface.xmlScriptPpal.elementsByTagName("memberdef");
	var funcion:String;
	var comentario:String = "";
	var lblLink:RegExp = new RegExp("link_");
	var listaIniciada:Boolean;
	
	for(var i = 0; i< listaEtiquetas.length();i++) {	
		funcion = listaEtiquetas.item(i).namedItem("definition").toElement().text();
		// Obtener la parte derecha de la función
		var lonNomFuncion:Number = nomFuncion.length;
		
		if(funcion.right(lonNomFuncion) == nomFuncion) {
			
			elemDD = listaEtiquetas.item(i).namedItem("detaileddescription").toElement();						
			
			if (!elemDD.hasChildNodes())
				continue;
			
			listaDD = elemDD.childNodes();
			listaIniciada = false;
			
			for(var j = 0; j< listaDD.length(); j++) {
			
				switch (listaDD.item(j).nodeName()) {
						
					case "para": 
						para = listaDD.item(j).toElement().text();
						if (!listaIniciada) {
								comentario += "<div class=\"lista_contenidos_doc\">\n";
								listaIniciada = true;
						}
						comentario += "<li>" + para + "</li>\n";
					
					break;
				}
			}
			
/*			try {
				elemDD = listaEtiquetas.item(i).namedItem("inbodydescription").toElement();						
				listaDD = elemDD.childNodes();
			}
			catch (e) {
				debug(e);
			}
			
			debug(listaDD.length());
			for(var j = 0; j< listaDD.length(); j++) {
			
				switch (listaDD.item(j).nodeName()) {
						
					case "para": 
						para = listaDD.item(j).toElement().text();
						if (!listaIniciada) {
								comentario += "<div class=\"lista_contenidos_doc\">\n";
								listaIniciada = true;
						}					
						comentario += "<li>" + para + "</li>\n";
					
					break;
				}																
			}		
			debug(listaDD.length());*/
			
			if (listaIniciada) comentario += "</div>\n";
		}
	}
	return comentario;
}

/** \D
Busca el texto descriptivo de una funcion que se encuentra dentro de un fichero .xml creado previamente por Doxygen

@param	nomFunción Nombre de la función
@param	nomFichero Nombre del fichero xml
@return	Texto de la función o cadena vacía si no se encuentra
\end */
function oficial_obtenerFuncionDox(nomFuncion, nomFichero):String
{
	if (!File.exists(nomFichero)) return "";
	
	var fichero = new File (nomFichero);
	
	fichero.open(File.ReadOnly);
	var xmlComentario = new FLDomDocument();
	xmlComentario.setContent(fichero.read());
	fichero.close();
	
	var listaEtiquetas = xmlComentario.elementsByTagName("memberdef");
	var funcion:String;
	var comentario:String = "";
	var lblLink:RegExp = new RegExp("link_");
	var listaIniciada:Boolean;
	
	for(var i = 0; i< listaEtiquetas.length();i++){
		funcion = listaEtiquetas.item(i).namedItem("definition").toElement().text();
		// Obtener la parte derecha de la función
		var lonNomFuncion:Number = nomFuncion.length;
		
		if(funcion.right(lonNomFuncion) == nomFuncion) {
			
			elemDD = listaEtiquetas.item(i).namedItem("detaileddescription").toElement();						
			listaDD = elemDD.childNodes();
			listaIniciada = false;

			if ( listaDD ) {
				for(var j = 0; j< listaDD.length(); j++) {
				
					switch (listaDD.item(j).nodeName()) {
							
						case "para": 
							para = listaDD.item(j).toElement().text();
							if (!listaIniciada) {
									comentario += "<div class=\"lista_contenidos_doc\">\n";
									listaIniciada = true;
							}
							comentario += "<li>" + para + "</li>\n";
						
						break;
					}
				}
			}
			
			elemDD = listaEtiquetas.item(i).namedItem("inbodydescription").toElement();						
			listaDD = elemDD.childNodes();

			if ( listaDD ) {
				for(var j = 0; j< listaDD.length(); j++) {
				
					switch (listaDD.item(j).nodeName()) {
							
						case "para": 
							para = listaDD.item(j).toElement().text();
							if (!listaIniciada) {
									comentario += "<div class=\"lista_contenidos_doc\">\n";
									listaIniciada = true;
							}					
							comentario += "<li>" + para + "</li>\n";
						
						break;
					}
				}
			}

			if (listaIniciada) comentario += "</div>\n";
		}
	}
	return comentario;
}

/** \D Genera un documento en formato pdf con toda la documentación.

Llama a los procesos html2ps y ps2pdf, que deben estar instalados en el sistema. Se utiliza la opción -W en html2ps para que se sigan los enlaces de index.html y así genere toda la documentación con todas las páginas
\end */
function oficial_generarPDF()
{
	var yaGenerado = fldocuppal.ejecutarQry("do_contenidos", "area", "1 = 1", "do_contenidos");
	if (yaGenerado.result == -1) {
			MessageBox.critical(this.iface.util.
					translate("scripts", "Para generar la documentación en PDF previamente debe ser generada en HTML"),
					MessageBox.Ok, MessageBox.NoButton,
					MessageBox.NoButton);
			return;
	}
	
	res = MessageBox.information(this.iface.util.translate("scripts", txCondicionesPDF),
			MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
	if (res != MessageBox.Yes) return;

	if (!this.iface.inicializar()) return;
			
	var dirRutaPDF = new Dir(this.iface.rutaPDF);
	if (!File.exists(this.iface.rutaPDF)) dirRutaPDF.mkdir();
	
	fich = new File(this.iface.rutaSis + "sistema/documentacion/docs/pdf/html2ps.css");
	fich.open(File.ReadOnly);
	var contFich:String = fich.read();
	fich.close();
	fich = new File(this.iface.rutaPDF + "html2ps.css");
	fich.open(File.WriteOnly);
	fich.write(contFich);
	fich.close();
		
	var scriptPDF:String = "";

	// Por módulos
	if (this.child("fdbFormatoPDF").value() == 1) {
	
		if (!this.iface.modulosParaDocumentar()) {
			this.iface.util.destroyProgressDialog();
			return;
		}

		var q:FLSqlQuery = new FLSqlQuery();

		q.setTablesList("do_modulosdoc");
		q.setFrom("do_modulosdoc");
		q.setSelect("area, modulo, codigomodulo");
		q.setWhere("documentar = 'true' AND idgenerardoc = " + this.cursor().valueBuffer("id"));

		if (!q.exec()) {
			MessageBox.critical(this.iface.util.
													translate("scripts", "Falló la consulta"),
													MessageBox.Ok, MessageBox.NoButton,
													MessageBox.NoButton);
			return false;
		}
		
		while (q.next()) {
			rutaDocPDF = this.iface.rutaDoc + q.value(0) + "/" + q.value(2);
			
			if (!File.exists(rutaDocPDF)) {
					MessageBox.critical(this.iface.util.
															translate("scripts", txModulo + " " + q.value(1) + " | " + q.value(0) +
																		"\n\n" + txNoHayModuloHTML),
															MessageBox.Ok, MessageBox.NoButton,
															MessageBox.NoButton);
					this.iface.util.destroyProgressDialog();
					return;
			}
			
			scriptPDF += "cd " + rutaDocPDF + "\n";
			scriptPDF += "html2ps -n -W b -u -f ../../../pdf/html2ps.css -o ../../../pdf/tmp.ps " + q.value(2) + ".html\n";
			scriptPDF += "cd ../../../pdf\n";
			scriptPDF += "ps2pdf -dMaxSubsetPct=100 -dCompatibilityLevel=1.3 -dSubsetFonts=true -dEmbedAllFonts=true -dAutoFilterColorImages=false -dAutoFilterGrayImages=false -dColorImageFilter=/FlateEncode -dGrayImageFilter=/FlateEncode -dMonoImageFilter=/FlateEncode tmp.ps " + q.value(0) + "_" + q.value(1) + ".pdf\n";
			scriptPDF += "rm -f tmp.ps\n";
		}
		
	}
	// Completa
	else {
		scriptPDF = "cd " + this.iface.rutaDoc + "\n";
		scriptPDF += "html2ps -n -W r -u -f ../pdf/html2ps.css -o ../pdf/tmp.ps index.html\n";
		scriptPDF += "cd ../pdf\n";
		scriptPDF += "ps2pdf -dMaxSubsetPct=100 -dCompatibilityLevel=1.3 -dSubsetFonts=true -dEmbedAllFonts=true -dAutoFilterColorImages=false -dAutoFilterGrayImages=false -dColorImageFilter=/FlateEncode -dGrayImageFilter=/FlateEncode -dMonoImageFilter=/FlateEncode tmp.ps FacturaLUX_" + this.iface.tipoDoc + ".pdf\n";
		scriptPDF += "rm -f tmp.ps\n";								
	}		
	
	var f = new File(this.iface.rutaPDF + "generarPDF");
	f.open(File.WriteOnly);
	f.write(scriptPDF);
	f.close();

	if (!f.executable) {		
		MessageBox.critical(this.iface.util.
						translate("scripts", "Este fichero debe ser ejecutable, modifica sus propiedades:\n") + this.iface.rutaPDF + "generarPDF",
						MessageBox.Ok, MessageBox.NoButton,
						MessageBox.NoButton);
		return false;
	}

	this.iface.util.createProgressDialog(txGenerandoPDF, 100);
	this.iface.enProceso = true;
	this.iface.util.setProgress(20);
	
	this.iface.proceso = new FLProcess(this.iface.rutaPDF + "generarPDF");
	connect(this.iface.proceso, "exited()", this, "iface.finalizarPDF");
	this.iface.proceso.start();
	
}

function oficial_generarLicencia()
{
	if (!File.exists(this.iface.rutaIncludes + "licencia_corta.html")) {
		MessageBox.information(this.iface.util.
				translate("scripts", "No se ha encontrado el fichero licencia_corta.html en los ficheros auxiliares\nNo se incluirá licencia en la documentación"),
				MessageBox.Ok, MessageBox.NoButton,
				MessageBox.NoButton);
		return "";
	}
	
	fich = new File(this.iface.rutaIncludes + "licencia_corta.html");
	fich.open(File.ReadOnly);
	var licenciaCorta:String = fich.read();
	fich.close();
	
	licenciaCorta = "<p><br>" + licenciaCorta;
	licenciaCorta += "<p><a href=\"includes/licencia.html\">" + txLicencia + "</a>";
	
	return licenciaCorta;	
}

/** \D Lee los parámetros generales del formulario que se usarán en la documentación. Busca en la tabla de opciones generales 'do_opciones' la this.iface.ruta a los módulos y comprueba que es correcta
\end */
function oficial_inicializar():Boolean
{
	var util:FLUtil = new FLUtil();	

	this.iface.tipoDoc = "guia_usuario";
	if (this.child("fdbTipoDoc").value() == 1) 
		this.iface.tipoDoc = "guia_desarrollo";
	else if (this.child("fdbTipoDoc").value() == 2)
		this.iface.tipoDoc = "modelo_datos";
	
	this.iface.capturarForms = this.child("fdbCapturarForms").value();

	this.iface.ruta = util.readSettingEntry("scripts/fldocuppal/dirModulos");
	this.iface.rutaSis = util.readSettingEntry("scripts/fldocuppal/dirSistema");
	this.iface.rutaDestino = util.readSettingEntry("scripts/fldocuppal/dirDestino");
	
	// las rutas deben finalizar en '/'
	if (this.iface.ruta.right(1) != "/") {
		this.iface.ruta += "/";
	}
	
	if (this.iface.rutaSis.right(1) != "/") {
		this.iface.rutaSis += "/";
	}
	
	if (this.iface.rutaDestino.right(1) != "/") {
		this.iface.rutaDestino += "/";
	}
	
	// Se comprueba la existencia de las rutas
	if (!File.exists(this.iface.ruta)) {
		MessageBox.critical(this.iface.util.
												translate("scripts", "La ruta de módulos especificada no existe"),
												MessageBox.Ok, MessageBox.NoButton,
												MessageBox.NoButton);
		return false;
	}
	
	if (!File.exists(this.iface.rutaSis)) {
		MessageBox.critical(this.iface.util.
												translate("scripts", "La ruta de sistema especificada no existe"),
												MessageBox.Ok, MessageBox.NoButton,
												MessageBox.NoButton);
		return false;
	}
	
	if (!File.exists(this.iface.rutaDestino)) {
		MessageBox.critical(this.iface.util.
												translate("scripts", "La ruta de destino especificada no existe"),
												MessageBox.Ok, MessageBox.NoButton,
												MessageBox.NoButton);
		return false;
	}
	
	
	this.iface.rutaDoc = this.iface.rutaDestino + this.iface.tipoDoc + "/";
	this.iface.rutaIncludes = this.iface.rutaDoc + "includes/";
	
	// Verifica que existe la ruta principal
	var dirRutaDoc = new Dir(this.iface.rutaDoc);
	if (!File.exists(this.iface.rutaDoc))
			dirRutaDoc.mkdir();
			
	// Verifica que existe la ruta de includes
	var dirRutaIncludes = new Dir(this.iface.rutaIncludes);
	if (!File.exists(this.iface.rutaIncludes))
			dirRutaIncludes.mkdir();
			
	
	this.iface.rutaImg = this.iface.rutaDestino + "images/";
	this.iface.dirImg = "images/";
	this.iface.rutaDox = this.iface.rutaSis + "sistema/documentacion/doxygen/"
	this.iface.rutaPDF = this.iface.rutaDestino + "pdf/";

	// Se copian algunos ficheros auxiliares: estilos.css, terminos.html, footer.html ...
	dirFichAux = new Dir(this.iface.rutaSis + "sistema/documentacion/docs/");
	fichAux = dirFichAux.entryList("*", Dir.Files);
	for (var k = 0; k < fichAux.length; k++) {
			
		fich = new File(this.iface.rutaSis + "sistema/documentacion/docs/" + fichAux[k]);
		fich.open(File.ReadOnly);
		contFich = fich.read();
		fich.close();

		fich = new File(this.iface.rutaIncludes + fichAux[k]);
		fich.open(File.WriteOnly);
		fich.write(contFich);
		fich.close();
	}
	
	return true;	
}

function oficial_limpiarDoxygen()
{
// 	dirDoxy = new Dir(this.iface.rutaDox + "codigo");
// 	fichs = dirDoxy.entryList("*.qs", Dir.Files);
// 	for (var k = 0; k < fichs.length; k++) {
// 		fich = new File(this.iface.rutaDox + "codigo/" + fichs[k]);
//  		fich.remove();
// 	}
  
// 	dirDoxy = new Dir(this.iface.rutaDox + "html");
// 	fichs = dirDoxy.entryList("*.html", Dir.Files);
// 	for (var k = 0; k < fichs.length; k++) {
// 		fich = new File(this.iface.rutaDox + "html/" + fichs[k]);
// 		fich.remove();
// 	}
// 	
// 	dirDoxy = new Dir(this.iface.rutaDox + "xml");
// 	fichs = dirDoxy.entryList("*.xml", Dir.Files);
// 	for (var k = 0; k < fichs.length; k++) {
// 		fich = new File(this.iface.rutaDox + "xml/" + fichs[k]);
// 		fich.remove();
// 	}
}

/** \D Muestra el mensaje de finalización normal
\end */
function oficial_finalizar() 
{
	this.iface.limpiarDoxygen();
	this.iface.util.destroyProgressDialog();
	MessageBox.information(txFinalizadaDoc + this.iface.rutaDoc, MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
}

/** \D Muestra el mensaje de finalización normal de la generación del documento pdf
\end */
function oficial_finalizarPDF() 
{
	this.iface.enProceso = false;
	this.iface.util.destroyProgressDialog();			
	MessageBox.information(txFinalizadaPDF + this.iface.rutaPDF, MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////



/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////

//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////