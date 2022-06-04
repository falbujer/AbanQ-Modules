/***************************************************************************
                 co_modelo390.qs  -  description
                             -------------------
    begin                : mon may 16 2005
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
	function init() { this.ctx.interna_init(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var numPagina_:Number;

	function oficial( context ) { interna( context ); }
	function listaAsientosReg():String {
		return this.ctx.oficial_listaAsientosReg();
	}
	function lanzar(cursor:FLSqlCursor, nombreInforme:String, masWhere:String, nombreReport:String) {
		return this.ctx.oficial_lanzar(cursor, nombreInforme, masWhere, nombreReport);
	}
	function obtenerSigno(s:String):String {
		return this.ctx.oficial_obtenerSigno(s);
	}
	function fieldName(s:String):String {
		return this.ctx.oficial_fieldName(s);
	}
	function valorDefectoDatosFiscales(fN:String):String {
		return this.ctx.oficial_valorDefectoDatosFiscales(fN);
	}
	function valoresIniciales(){
		this.ctx.oficial_valoresIniciales();
	}
	function informarTiposVia() {
		this.ctx.oficial_informarTiposVia();
	}
	function verificarDato(valor:String, requerido:Boolean, nombre:String, maxLon:Number):Boolean {
		return this.ctx.oficial_verificarDato(valor, requerido, nombre, maxLon);
	}
	function formatoNumero(valor, enteros, decimales) {
		return this.ctx.oficial_formatoNumero(valor, enteros, decimales);
	}
	function formatoNumeroAbs(valor, enteros, decimales) {
		return this.ctx.oficial_formatoNumeroAbs(valor, enteros, decimales);
	}
	function mesPorIndice(indice:Number):String {
		return this.ctx.oficial_mesPorIndice(indice);
	}
	function iniciarPagina(nodo:FLDomNode,campo:String):String {
		return this.ctx.oficial_iniciarPagina(nodo, campo);
	}
	function numPagina(nodo:FLDomNode,campo:String):String {
		return this.ctx.oficial_numPagina(nodo, campo);
	}
	function controlCaracteres(valor:String):String {
		return this.ctx.oficial_controlCaracteres(valor);
	}
	function formatearTexto(texto:String):String {
		return this.ctx.oficial_formatearTexto(texto);
	}
	function limpiarCifNif(cifNif:String):String {
		return this.ctx.oficial_limpiarCifNif(cifNif); 
	}
	function cuentasMetalico() {
		return this.ctx.oficial_cuentasMetalico(); 
	}
	function informaSituInmuebles() {
		return this.ctx.oficial_informaSituInmuebles();
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
	function pub_listaAsientosReg():String {
		return this.listaAsientosReg();
	}
	function pub_lanzar(cursor:FLSqlCursor, nombreInforme:String, masWhere:String, nombreReport:String) {
		return this.lanzar(cursor, nombreInforme, masWhere, nombreReport);
	}
	function pub_valorDefectoDatosFiscales(fN:String):String {
		return this.valorDefectoDatosFiscales(fN);
	}
	function pub_verificarDato(valor:String, requerido:Boolean, nombre:String, maxLon:Number):Boolean {
		return this.verificarDato(valor, requerido, nombre, maxLon);
	}
	function pub_formatoNumero(valor, enteros, decimales) {
		return this.formatoNumero(valor, enteros, decimales);
	}
	function pub_formatoNumeroAbs(valor, enteros, decimales) {
		return this.formatoNumeroAbs(valor, enteros, decimales);
	}
	function pub_mesPorIndice(indice:Number):String {
		return this.mesPorIndice(indice);
	}
	function pub_numPagina(nodo:FLDomNode,campo:String):String {
		return this.numPagina(nodo, campo);
	}
	function pub_iniciarPagina(nodo:FLDomNode,campo:String):String {
		return this.iniciarPagina(nodo, campo);
	}
	function pub_controlCaracteres(valor:String):String {
		return this.controlCaracteres(valor);
	}
	function pub_formatearTexto(texto:String):String {
		return this.formatearTexto(texto);
	}
	function pub_limpiarCifNif(cifNif:String):String {
		return this.limpiarCifNif(cifNif);
	}
	function pub_cuentasMetalico() {
		return this.cuentasMetalico();
	}
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
function interna_init()
{
	var _i = this.iface;
	debug("Cuentas met�lico");
	debug(_i.pub_cuentasMetalico());
	var util:FLUtil = new FLUtil();
	if (!util.sqlSelect("co_tiposvia", "codtipovia", "1 = 1"))
		this.iface.informarTiposVia();
	
	var cursor:FLSqlCursor = new FLSqlCursor("co_datosfiscales");
	cursor.select();
	if (!cursor.first()) {
			MessageBox.information(util.translate("scripts",
					"Se insertar�n algunos datos fiscales para empezar a trabajar."),
					MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			this.iface.valoresIniciales();
			this.execMainScript("co_datosfiscales");
	}
	_i.informaSituInmuebles();
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D Lanza un informe basado en unos determinados criterios de b�squeda

@param	cursor: Cursor posicionado en un registro de criterios de b�squeda
@param	nombreInforme: Nombre del informe a lanzar
@param	masWhere: Parte a a�adir a la cl�usula where
\end */
function oficial_lanzar(cursor:FLSqlCursor, nombreInforme:String, masWhere:String, nombreReport:String)
{
	var util:FLUtil = new FLUtil;
	var q:FLSqlQuery = new FLSqlQuery(nombreInforme);

	if (!nombreReport)
		nombreReport = nombreInforme;

	var fieldList:String = util.nombreCampos(cursor.table());
	var cuenta:Number = parseFloat(fieldList[0]);

	var signo:String;
	var fN:String;
	var valor:String;
	var primerCriterio:Boolean = false;
	var where:String = "";
	for (var i:Number = 1; i <= cuenta; i++) {
		if (cursor.isNull(fieldList[i]))
			continue;
		signo = this.iface.obtenerSigno(fieldList[i]);
		if (signo != "") {
			fN = this.iface.fieldName(fieldList[i]);
			valor = cursor.valueBuffer(fieldList[i]);
			if (valor == "S�")
				valor = 1;
			if (valor == "No")
				valor = 0;
			if (valor == "Todos")
				valor = "";
			if (!valor.toString().isEmpty()) {
				if (primerCriterio == true)
					where += "AND ";
				where += fN + " " + signo + " '" + valor + "' ";
				primerCriterio = true;
			}
		}
	}

	if ( masWhere && !masWhere.isEmpty() )
		where += masWhere;
	q.setWhere(where);
debug(q.sql())
	if (q.exec() == false) {
		MessageBox.critical(util.translate("scripts", "Fall� la consulta"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return;
	} else {
		if (q.first() == false) {
			MessageBox.warning(util.translate("scripts", "No hay registros que cumplan los criterios de b�squeda establecidos"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return;
		}
	}

	var rptViewer:FLReportViewer = new FLReportViewer();
	rptViewer.setReportTemplate(nombreReport);
	rptViewer.setReportData(q);
	rptViewer.renderReport();
	rptViewer.exec();
}

/** \D Construye una lista separada por comas con los idasientos de los asientos de regularizaci�n de iva
\end */
function oficial_listaAsientosReg():String
{
	var lista:String = "";
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("co_regiva");
	q.setSelect("idasiento");
	q.setFrom("co_regiva");
	if (!q.exec()) return lista;
	while (q.next()) {
		lista += q.value(0) + ",";
	}
	lista = lista.left(lista.length - 1);
	if (!lista) lista = "-1";
	return lista;
}

/** \D
Obtiene el operador l�gico a aplicar en la cl�usula where de la consulta a partir de los primeros caracteres del par�metro
@param	s: Nombre del campo que contiene un criterio de b�squeda
@return	Operador l�gico a aplicar
\end */
function oficial_obtenerSigno(s:String):String
{
	if (s.toString().charAt(1) == "_") {
		switch(s.toString().charAt(0)) {
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

/** \D Convierte el nombre de un campo de una tabla de informe en un nombre de tabla m�s un nombre de campo separados por un punto. Se utiliza en campos que definen condiciones l�gicas en la consulta del informe como 'igual a', 'mayor o igual que' o 'menor o igual que'. Ejemplo: d_co__asientos_numero como entrada dar�a como resultado co_asientos.numero

Sustituye '_' por '.'; dos '_' seguidos indica que realmente es '_'

@param s Nombre del campo en la tabla del informe
@return Nombre de campo.Nombre de tabla
\end */
function oficial_fieldName(s:String):String
{
	var fN:String = "";
	var c:String;
	for (var i:Number = 2; (s.toString().charAt(i)); i++) {
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

function oficial_valorDefectoDatosFiscales(fN:String):String
{
	var cursorDatosFiscales:FLSqlCursor = new FLSqlCursor("co_datosfiscales");
	cursorDatosFiscales.select();
	if (cursorDatosFiscales.first())
		return cursorDatosFiscales.valueBuffer(fN);
}

function oficial_valoresIniciales()
{
	var q:FLSqlQuery= new FLSqlQuery();
	var cursor:FLSqlCursor = new FLSqlCursor("co_datosfiscales");

	q.setSelect("nombre,cifnif,codpostal,ciudad,provincia,telefono,administrador,idprovincia");
	q.setFrom("empresa");
	q.setTablesList("empresa");

	q.exec();
	if (!q.first()) return;

	var temp:String;
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		temp = q.value(0);
		if (temp && temp != "")
			temp = temp.left(30);
		setValueBuffer("apellidosrs", temp);
		
		temp = q.value(1);
		if (temp && temp != "")
			temp = temp.left(9);
		setValueBuffer("cifnif", temp);
		
		temp = q.value(2);
		if (temp && temp != "")
			temp = temp.left(5);
		setValueBuffer("codpos", temp);
		
		temp = q.value(3);
		if (temp && temp != "")
			temp = temp.left(20);
		setValueBuffer("municipio", temp);
		
		temp = q.value(4);
		if (temp && temp != "")
			temp = temp.left(15);
		setValueBuffer("provincia", temp);
		
		temp = q.value(5);
		if (temp && temp != "")
			temp = temp.left(9);
		setValueBuffer("telefono", temp);
		
		temp = q.value(6);
		if (temp && temp != "")
			temp = temp.left(15);
		setValueBuffer("nombre", temp);
		
		temp = q.value(7);
		if (temp == 0)
			setNull("idprovincia");
		else
			setValueBuffer("idprovincia", temp);
		
		commitBuffer();
	}
}

function oficial_informarTiposVia()
{
	var curTipoVia:FLSqlCursor = new FLSqlCursor("co_tiposvia");
	var valores:Array = [
	["AL", "Alameda, aldea"],
	["AP", "Apartamento"],
	["AV", "Avenida"],
	["BL", "Bloque"],
	["BO", "Barrio"],
	["CH", "Chalet"],
	["CL", "Calle"],
	["CM", "Camino"],
	["CO", "Colonia"],
	["CR", "Carretera"],
	["CS", "Caser�o"],
	["CT", "Cuesta"],
	["ED", "Edificio"],
	["GL", "Glorieta"],
	["GR", "Grupo"],
	["LU", "Lugar"],
	["ME", "Mercado"],
	["MU", "Municipio"],
	["MZ", "Manzana"],
	["PB", "Poblado"],
	["PG", "Pol�gono"],
	["PJ", "Pasaje"],
	["PQ", "Parque"],
	["PZ", "Plaza"],
	["PR", "Prolongaci�n"],
	["PS", "Paseo"],
	["RB", "Rambla"],
	["RD", "Ronda"],
	["TR", "Traves�a"],
	["UR", "Urbanizaci�n"]];
	
	for (var i:Number = 0; i < valores.length; i++) {
		with (curTipoVia) {
			setModeAccess(Insert);
			refreshBuffer();
			setValueBuffer("codtipovia", valores[i][0]);
			setValueBuffer("descripcion", valores[i][1]);
			commitBuffer();
		}
	}
}

/** \D Comprueba que si un campo es requerido est� informado, y si lo est�, que tenga una longitud inferior al m�ximo establecido
@param	valor: Valor a comprobar
@param	requerido: Indica si el campo es requerido o no
@param	nombre: Nombre del campo para mostrar en caso de error
@param	maxLon: Longitud m�xima del campo
@return	true si la comprobaci�n es correcta, false en caso contrario
\end */
function oficial_verificarDato(valor:String, requerido:Boolean, nombre:String, maxLon:Number):Boolean
{
	var util:FLUtil = new FLUtil;
	if (!valor || valor == "") {
		if (!requerido)
			return true;
		MessageBox.warning(util.translate("scripts", "Debe establecer el valor del siguiente campo: ") + nombre, MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	valor = sys.fromUnicode(valor, "ISO-8859-1");
	
	if (valor.toString().length > maxLon) {
		MessageBox.warning(util.translate("scripts", "La longitud del dato excede su longitud m�xima: ") + nombre + " - " + maxLon, MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	return true;
}

/** \D Sustituye ciertos caracteres por caracteres v�lidos
@param	valor: Valor a comprobar
@return	valor revisado
\end */
function oficial_controlCaracteres(valor:String):String
{
	var valorRevisado:String = valor;
	if (!valorRevisado || valorRevisado == "")
		return valorRevisado;

	valorRevisado = valorRevisado.toUpperCase();

	var caracteres:Array = [["�", "C"], ["[�,�,�]", "A"], ["[�,�,�]", "E"], ["[�,�,�]", "I"], ["[�,�,�]", "O"], ["[�,�,�]", "U"]];
	var regExpTemp:RegExp;
	for (var i:Number = 0; i < caracteres.length; i++) {
		regExpTemp = new RegExp(caracteres[i][0]);
		while (valorRevisado.find(regExpTemp) > -1)
			valorRevisado = valorRevisado.replace(regExpTemp, caracteres[i][1]);
	}
	return valorRevisado;
}

/** \D Formatea un n�mero de acuerdo con los par�metros establecidos
@param	valor: Valor a formatear
@param	enteros: N�mero de cifras enteras
@param	decimales: N�mero de cifras decimales
@return	n�mero formateado
\end */
function oficial_formatoNumero(valor:Number, enteros:Number, decimales:Number):String
{
	for (var i:Number = 0; i < decimales; i++)
		valor *= 10;

	valor = Math.round(valor);
		
	var resultado:String = flfactppal.iface.pub_cerosIzquierda(valor, (enteros + decimales));
	return resultado;
}

/** \d Formatea en valor absoluto
\end */
function oficial_formatoNumeroAbs(valor:Number, enteros:Number, decimales:Number):String
{
	for (var i:Number = 0; i < decimales; i++)
		valor *= 10;

	valor = Math.round(valor);
	valor = Math.abs(valor);
		
	var resultado:String = flfactppal.iface.pub_cerosIzquierda(valor, (enteros + decimales));
	return resultado;
}

/** \D Obtiene el nombre del mes a partir de su n�mero
@param	indice: N�mero del mes
@return	Nombre del mes
\end */
function oficial_mesPorIndice(indice:Number):String
{
	var meses:Array = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"];
	return meses[indice - 1];
}

/** \D Inicia a 1 el contador de p�ginas
\end */
function oficial_iniciarPagina(nodo:FLDomNode,campo:String):String
{
	this.iface.numPagina_ = 1;
}

/** \D Devuelve el valor del contador de p�ginas
\end */
function oficial_numPagina(nodo:FLDomNode,campo:String):String
{
	return this.iface.numPagina_++;
}

/** \C Pasa un texto a may�sculas y elimina las tildes
@param texto: Texto a formatear
@return Texto formateado
\end */
function oficial_formatearTexto(texto:String):String
{
	if (!texto || texto == "") {
		return texto;
	}
	var textoMay:String = texto.toUpperCase();
	var resultado:String;
	for (var i:Number = 0; i < textoMay.length; i++) {
		switch (textoMay.charAt(i)) {
			case "�": 
			case "�": { 
				resultado += "A"; 
				break; 
			}
			case "�": 
			case "�": { 
				resultado += "E"; 
				break; 
			}
			case "�": 
			case "�": { 
				resultado += "I"; 
				break; 
			}
			case "�": 
			case "�": { 
				resultado += "O"; 
				break; 
			}
			case "�":
			case "�": { 
				resultado += "U"; 
				break; 
			}
			default: { 
				resultado += textoMay.charAt(i); 
				break; 
			}
		}
	}
	return resultado;
}

/** \C Elimina caracteres inv�lidos de un CIF o NIF (".", "-", etc.)
@param CIF o NIF a limpiar
@return CIF o NIF limpio
\end */
function oficial_limpiarCifNif(cifNif:String):String
{
	var cifLimpio:String = "";
	if (cifNif && cifNif != "") {
		var caracter:String;
		for (var i:Number = 0; i < cifNif.length; i++) {
			caracter = cifNif.charAt(i);
			switch (caracter) {
				case ".":
				case " ":
				case "-": {
					break;
				}
				default: {
					cifLimpio += caracter;
				}
			}
		}
	}
	return cifLimpio;
}

function oficial_cuentasMetalico()
{
	var q = new FLSqlQuery;
	q.setSelect("codcuenta");
	q.setFrom("cuentasbanco");
	q.setWhere("metalico");
	q.setForwardOnly(true);
	if (!q.exec()) {
		return false;
	}
	var cuentas = "";
	while (q.next()) {
		cuentas += cuentas != "" ? ", " : "";
		cuentas += "'" + q.value("codcuenta") + "'";
	}
	return cuentas;
}

function oficial_informaSituInmuebles()
{
	if (!AQUtil.sqlSelect("co_situinmueble340", "codsituinmueble", "1 = 1")) {
		var cursor = new FLSqlCursor("co_situinmueble340");
		var aSitu = [["1", "Inmueble con referencia catastral situado en Espa�a, excepto Pa�s Vasco y Navarra"], ["2", "Inmueble situado en Pa�s Vasco o Navarra."], ["3", "Inmueble en cualquiera de las situaciones anteriores pero sin referencia catastral"], ["4", "Inmueble situado en el extranjero"]];
		for (var i = 0; i < aSitu.length; i++) {
			with(cursor) {
				setModeAccess(cursor.Insert);
				refreshBuffer();
				setValueBuffer("codsituinmueble", aSitu[i][0]);
				setValueBuffer("descripcion", aSitu[i][1]);
				commitBuffer();
			}
		}
	}
	return true;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
