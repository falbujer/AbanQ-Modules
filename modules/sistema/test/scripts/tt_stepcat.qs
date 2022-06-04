/***************************************************************************
                 tt_stepcat.qs  -  description
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
////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
class interna {
    var ctx:Object;
    function interna( context ) { this.ctx = context; }
    function init() { this.ctx.interna_init(); }
	function calculateCounter(fN:String):Number {
		return this.ctx.interna_calculateCounter(fN);
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var tbnParameters:Object;
	var tbnObjectName:Object;
	var tbnContainer:Object;
	var fdbContainer:FLFieldDB;
	var flactions:Array;
	var xmlAcciones:FLDomDocument;
	var aliasObject:String;

    function oficial( context ) { interna( context ); } 
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function setParameters() {
		return this.ctx.oficial_setParameters();
	}
	function setObjectName() {
		return this.ctx.oficial_setObjectName();
	}
	function setContainer() {
		return this.ctx.oficial_setContainer();
	}
	function flActionData(nodeName:String):String {
		return this.ctx.oficial_flActionData(nodeName);
	}
	function guessValues() {
		return this.ctx.oficial_guessValues();
	}
	function valuesForType() {
		return this.ctx.oficial_valuesForType();
	}
	function calculateField(fN:String):String {
		return this.ctx.oficial_calculateField(fN);
	}
	function desconectar() {
		return this.ctx.oficial_desconectar();
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends oficial {
	function head( context ) { oficial ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

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

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////

/** \C Al establecer los parámetros hemos de tener en cuenta que contamos con las siguientes posibilidades:
$valor será sustiuido por el valor de la variable de sesión 'valor'
$_S será sustiuido por el valor del identificador de la sesión actual
$_YEAR será sustiuido por el valor del año actual
*/
function interna_init()
{
	this.iface.tbnParameters = this.child("tbnParameters");
	this.iface.tbnObjectName = this.child("tbnObjectName");
	this.iface.tbnContainer = this.child("tbnContainer");
	this.iface.fdbContainer = this.child("fdbContainer");
	this.iface.aliasObject = "";
	
	connect(this.cursor(), "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this.iface.tbnParameters, "clicked()", this, "iface.setParameters");
	connect(this.iface.tbnObjectName, "clicked()", this, "iface.setObjectName");
	connect(this.iface.tbnContainer, "clicked()", this, "iface.setContainer");
	connect(this, "closed()", this, "iface.desconectar");
		
	var cursor:FLSqlCursor = this.cursor();
	if (cursor.modeAccess() == cursor.Edit) 
		this.iface.bufferChanged("idmodule");

	if (cursor.modeAccess() == cursor.Insert) {
		this.iface.guessValues();
		if (this.child("fdbIdObjectType").value() != "") 
			this.child("fdbObjectName").setFocus();
	}
}

/** \D Calcula el valor de un campo

@param	fN: Nombre del campo a calcular
@return	Valor del campo
*/
function interna_calculateCounter(fN:String):Number
{
	var util:FLUtil = new FLUtil;
	if (fN == "stepnumber") {
/** \D El campo --stepnumber-. será el siguiente valor al último paso creado para la prueba actual
*/
		var cursor:FLSqlCursor = this.cursor();
		var cursorRel:FLSqlCursor = cursor.cursorRelation();
		if (!cursorRel)
			return 0;
		var idTestCat:String = cursorRel.valueBuffer("id");
		var stepNumber:Number = util.sqlSelect("tt_stepcat", "stepnumber",
			"idtestcat = '" + idTestCat + "' ORDER BY stepnumber DESC");
		if (!stepNumber)
			return 0;
		else
			return ++stepNumber;
	}
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_desconectar()
{
	disconnect(this.cursor(), "bufferChanged(QString)", this, "iface.bufferChanged");
	disconnect(this.iface.tbnParameters, "clicked()", this, "iface.setParameters");
	disconnect(this.iface.tbnObjectName, "clicked()", this, "iface.setObjectName");
	disconnect(this.iface.tbnContainer, "clicked()", this, "iface.setContainer");
}
function oficial_bufferChanged(fN:String)
{
	var cursor:FLSqlCursor = form.cursor();
	var util:FLUtil = new FLUtil;

	switch(fN) {
/** \C Al establecer el --idobjecttype--, se mostrará su acción por defecto
\end */
		case "idobjecttype":
			var idObjectType:String = cursor.valueBuffer("idobjecttype");
			var idAction:String = util.sqlSelect("tt_action", "idaction",
				"idobjecttype = '" + idObjectType + "' AND isdefault = 'true'");
			if (idAction)
				form.child("fdbIdAction").setValue(idAction);
			this.iface.valuesForType();
		break;
/** \C El valor del campo --descripcion-- será: valor de --idaction-- + valor de --objectname--. Ejemplo: Pulsar botón + Insertar
\end */
		case "idaction":
		case "objectname":
		case "parameters":
			this.child("fdbDescription").setValue(this.iface.calculateField("description"));
		break;
/** \C La lista de contenedores corresponderá a las acciones asociadas al módulo establecido en --idmodule--
\end */
		case "idmodule":
			this.iface.flactions = [];
			var contenido:String = util.sqlSelect("flfiles", "contenido", 
				"nombre = '" + cursor.valueBuffer("idmodule") + ".xml'")
			if (!contenido) 
				return;
			this.iface.xmlAcciones = new FLDomDocument();
			this.iface.xmlAcciones.setContent(contenido);
			var listaAcciones:FLDomNodeList = this.iface.xmlAcciones.elementsByTagName("action");
			for (var i = 0; i < listaAcciones.length(); i++) {
				this.iface.flactions[i] = listaAcciones.item(i).namedItem("name").toElement().text();
			}
		break;
/** \C Para pulsar los botones que aparecen en la parte inferior derecha de los formularios de edición, estableceremos el valor del campo --pbaccept--
\end */
		case "pbaccept":
			switch (cursor.valueBuffer("pbaccept")) {
				case util.translate("scripts", "Aceptar"): {
					cursor.setValueBuffer("objectname", "pushButtonAccept");
					break;
				}
				case util.translate("scripts", "Cancelar"): {
					cursor.setValueBuffer("objectname", "pushButtonCancel");
					break;
				}
				case util.translate("scripts", "Aceptar y continuar"): {
					cursor.setValueBuffer("objectname", "pushButtonAcceptContinue");
					break;
				}
				default: {
					cursor.setValueBuffer("objectname", "");
					break;
				}
			}
		break;
	}
}

/** \D Llama a las acciones o funciones encargadas de elaborar los parámetros, en función del tipo de objeto a parametrizar
*/
function oficial_setParameters()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = form.cursor();
	var idObjecttype:String = cursor.valueBuffer("idobjecttype");
	cursor.select();
	switch (idObjecttype) {
		case "Query": {
			var f:Object = new FLFormSearchDB("tt_query");
			var curQuery:FLSqlCursor = f.cursor();
		
			curQuery.select();
			if (!curQuery.first())
				curQuery.setModeAccess(curQuery.Insert);
			else
				curQuery.setModeAccess(curQuery.Edit);
		
			f.setMainWidget();
			curQuery.refreshBuffer();
			curQuery.setValueBuffer("xml", cursor.valueBuffer("parameters"));
			var xmlContent:String = f.exec("xml");
			if (xmlContent) 
				this.child("fdbParameters").setValue(xmlContent);
			break;
		}
		case "Compare": {
			var f:Object = new FLFormSearchDB("tt_compare");
			var curCompare:FLSqlCursor = f.cursor();
		
			curCompare.select();
			if (!curCompare.first())
				curCompare.setModeAccess(curCompare.Insert);
			else
				curCompare.setModeAccess(curCompare.Edit);
			
			f.setMainWidget();
			
			curCompare.refreshBuffer();
			curCompare.setValueBuffer("xml", cursor.valueBuffer("parameters"));
			var xmlContent:String = f.exec("xml");
			if (xmlContent) 
				this.child("fdbParameters").setValue(xmlContent);
			break;
		}
		case "Test": {
			var f:Object = new FLFormSearchDB("tt_assignation");
			var curAssignation:FLSqlCursor = f.cursor();
			curAssignation.select();
			if (!curAssignation.first())
				curAssignation.setModeAccess(curAssignation.Insert);
			else
				curAssignation.setModeAccess(curAssignation.Edit);
			
			var xmlTest:FLDomDocument = new FLDomDocument;
			var xmlAssignation:FLDomDocument = new FLDomDocument;
			if (xmlTest.setContent(cursor.valueBuffer("objectname"))) {
				var testParameters:String = util.sqlSelect("tt_testcat", "parameters", "codtestcat = '" + xmlTest.firstChild().toElement().attribute("codtest") + "' AND idfuncional = '" + xmlTest.firstChild().toElement().attribute("idfuncional") + "'");
				if (testParameters && xmlTest.setContent(testParameters)) {
					if (!xmlAssignation.setContent(cursor.valueBuffer("parameters")))
						xmlAssignation.setContent("<FLTest:Assignation />");
					var listaParam:FLDomNodeList = xmlTest.elementsByTagName("FLTest:Parameter");
					var listaAssignation:FLDomNodeList = xmlAssignation.elementsByTagName("FLTest:AssignationElement");
					var param:String;
					var container:String;
					var defValue:String;
					var totalAsig:Number = listaAssignation.length();
					var j:Number;
					for (var i:Number = 0; i < listaParam.length(); i++) {
						param = listaParam.item(i).toElement().attribute("name");
						defValue = listaParam.item(i).toElement().attribute("default");
						container = listaParam.item(i).toElement().attribute("container");
						if (!defValue)
							defValue = "";
						var encontrado:Boolean = false;
						for (j = 0; j < totalAsig; j++) {
							if (listaAssignation.item(j).toElement().attribute("var") == param) {
								encontrado = true;
								break;
							}
						}
						if (encontrado) {
							listaAssignation.item(j).toElement().setAttribute("container", container);
							listaAssignation.item(j).toElement().setAttribute("default", defValue);
						} else {
							var element:FLDomElement = xmlAssignation.createElement("FLTest:AssignationElement");
							element.setAttribute("var", param);
							element.setAttribute("value", "");
							element.setAttribute("container", container);
							element.setAttribute("default", defValue);
							xmlAssignation.firstChild().appendChild(element);
						}
					}
				}
			}
			f.setMainWidget();
			curAssignation.refreshBuffer();
			curAssignation.setValueBuffer("xml", xmlAssignation.toString(4));
			var xmlContent:String = f.exec("xml");
			if (xmlContent) 
				this.child("fdbParameters").setValue(xmlContent);
			break;
		}
		case "Assignation": {
			var f:Object = new FLFormSearchDB("tt_assignation");
			var curCompare:FLSqlCursor = f.cursor();
		
			curCompare.select();
			if (!curCompare.first())
				curCompare.setModeAccess(curCompare.Insert);
			else
				curCompare.setModeAccess(curCompare.Edit);
		
			f.setMainWidget();
			curCompare.refreshBuffer();
			curCompare.setValueBuffer("xml", cursor.valueBuffer("parameters"));
			var xmlContent:String = f.exec("xml");
			if (xmlContent) 
				this.child("fdbParameters").setValue(xmlContent);
			break;
		}
		case "ScriptDialog": {
			var f:Object = new FLFormSearchDB("tt_scriptdialog");
			var curCompare:FLSqlCursor = f.cursor();
		
			curCompare.select();
			if (!curCompare.first())
				curCompare.setModeAccess(curCompare.Insert);
			else
				curCompare.setModeAccess(curCompare.Edit);
		
			f.setMainWidget();
			curCompare.refreshBuffer();
			curCompare.setValueBuffer("xml", cursor.valueBuffer("parameters"));
			var xmlContent:String = f.exec("xml");
			if (xmlContent) 
				this.child("fdbParameters").setValue(xmlContent);
			break;
		}
		case "Button":
		case "MessageBox": {
			var f:Object = new FLFormSearchDB("tt_condition");
			var curCondition:FLSqlCursor = f.cursor();
			
			curCondition.select();
			if (!curCondition.first())
				curCondition.setModeAccess(curCondition.Insert);
			else
				curCondition.setModeAccess(curCondition.Edit);
			
			f.setMainWidget();
			curCondition.refreshBuffer();
			curCondition.setValueBuffer("xml", cursor.valueBuffer("parameters"));
			var xmlContent:String = f.exec("xml");
			if (xmlContent) 
				this.child("fdbParameters").setValue(xmlContent);
			break;
		}
		case "QTabWidget": {
			var formName:String = cursor.valueBuffer("formtype") + cursor.valueBuffer("container");
			var llamada:String = fltestppal.getTabWidgetPages(formName, cursor.valueBuffer("objectName"));
			var a:Array = llamada.split("*");
			var name:String = Input.getItem(util.translate("scripts", "Seleccione pestaña"), a, false, "opcion");
			if (!name)
				return;
			var valor:Array = name.split("/");
			this.child("fdbParameters").setValue(valor[0]);
			break;
		}
		case "FLFieldDB":
		case "FLFormDB": {
			var xmlParam:FLDomDocument = new FLDomDocument;
			if (xmlParam.setContent(cursor.cursorRelation().valueBuffer("parameters"))) {
				var listaParam:FLDomNodeList = xmlParam.elementsByTagName("FLTest:Parameter");
				var lista:Array;
				for (var i:Number = 0; i < listaParam.length(); i++) 
					lista.push("||" + listaParam.item(i).toElement().attribute("name") + "||");
				lista.sort();
				var name:String = Input.getItem(util.translate("scripts", "Seleccione parámetro"), lista, false, "opcion");
				if (!name)
					return;
				this.child("fdbParameters").setValue(name);
			}
			break;
		}
	}
	if (idObjecttype == "FLTableDB") {
		var flcolumns:Array = [];
		var nombreTabla:String = flActionData("table");
		var contenido:String = util.sqlSelect("flfiles", "contenido", "nombre = '" + nombreTabla + ".mtd'")
		if (!contenido) {
			MessageBox.warning(util.translate("scripts", "No se han encontrado los metadatos correspondientes a la tabla ") + nombreTabla, MessageBox.Ok);
			return;
		}
		var xmlColumnas:FLDomDocument = new FLDomDocument();
		xmlColumnas.setContent(contenido);
		var nodo:FLDomNode = xmlColumnas.firstChild().firstChild();
		var i:Number = 0;
		while (nodo) {
			if (nodo.nodeName() == "field") 
				flcolumns[i++] = nodo.namedItem("name").toElement().text();
			nodo = nodo.nextSibling();
		}
		
		var dialog:Object = new Dialog;
		dialog.caption = util.translate("scripts","Consulta");
		dialog.okButtonText = util.translate("scripts","Aceptar");
		dialog.cancelButtonText = util.translate("scripts","Salir");

		var primero:Object = new ComboBox;
		primero.label = "Filtrar columna: ";
		primero.itemList = flcolumns;
		dialog.add(primero);

		var segundo:Object = new LineEdit;
		segundo.label = "Por el valor: ";
		dialog.add(segundo);

		var query:FLSqlQuery = form.child("fdbParameters").value();
		if (query != "") {
		var a:Array = query.split("/");
			if(a.length = 2) {
				primero.currentItem = a[0];
				segundo.text = a[1];
			}
		}
			
		if (dialog.exec()) {
			var valor:String = (primero.currentItem + "/" + segundo.text);
			if (valor == "/")
				valor = "";
			form.child("fdbParameters").setValue(valor);
		}
	}
}

/** \D Ayuda a establecer el nombre del objeto proponiendo una lista de los posibles candidatos. El contenido de la lista varía en función del tipo del objeto a especificar.
*/
function oficial_setObjectName()
{
	var idPrueba:Array = new Array();
	var curTest:FLSqlCursor = new FLSqlCursor("tt_testcat");
	var curTabla:FLSqlCursor = new FLSqlCursor("flfiles");
	var cursor:FLSqlCursor = this.cursor();
	var idObjecttype:String = cursor.valueBuffer("idobjecttype");
	var idTestcat:String = cursor.valueBuffer("idtestcat");
	var util:FLUtil = new FLUtil;
	
	this.iface.aliasObject = "";
	switch(idObjecttype) {
		case "Test": {
			var f:Object = new FLFormSearchDB("tt_testcat");
			var curTest:FLSqlCursor = f.cursor();
		
			f.setMainWidget();
			curTest.refreshBuffer();
			curTest.setValueBuffer("xml", cursor.valueBuffer("parameters"));
			var id:String = f.exec("id");
			if (id) {
				this.iface.aliasObject = f.cursor().valueBuffer("description");
				var xml:String = "<FLTest:Test codtest=\"" + curTest.valueBuffer("codtestcat") + "\" idfuncional=\"" + curTest.valueBuffer("idfuncional") + "\"/>";
				this.child("fdbObjectName").setValue(xml);
			}
			break;
		}
		case "Table": {
			curTabla.select("nombre LIKE '%.mtd'");
			var i:Number = 0;
			while (curTabla.next()){
				with(curTabla) {
					setModeAccess(curTabla.Browse);
					refreshBuffer();
				}
				idPrueba[i++] = curTabla.valueBuffer("nombre");
			}
			var name:String = Input.getItem(util.translate("scripts", "Elegir tabla"), idPrueba, false, "opcion");
			var valor:String = "";
			for (i = 0; (name.toString().charAt(i) != "."); i++) {
				valor += name.toString().charAt(i);
			}
			this.child("fdbObjectName").setValue(valor);
			break;
		}
		case "Button":
		case "FLFieldDB":
		case "FLTableDB":
		case "QTabWidget": {
			var formName:String = cursor.valueBuffer("formtype") + cursor.valueBuffer("container");
			var llamada:String = fltestppal.getWidgetList(formName, idObjecttype);
			var a:Array = llamada.split("*");
			var name:String = Input.getItem(util.translate("scripts", "Elegir opcion"), a, false, "opcion");
			if (!name)
				return;

			var valor:Array = name.split("/");
			this.iface.aliasObject = valor[1];
			this.child("fdbObjectName").setValue(valor[0]);
			break;
		}
	}
}

/** \D Muestra la lista de acciones al usuario para que éste seleccione una de ellas, y establece el valor en el campo --container--
\end */
function oficial_setContainer()
{
	var util:FLUtil = new FLUtil;
	var accion:String = Input.getItem(util.translate("scripts", "Selecciona la acción"), this.iface.flactions, "", false, "");
	this.iface.fdbContainer.setValue(accion);
}

/** \D
Devuelve el valor del nodo action en el fichero xml de acciones correspondiente al valor seleccionada por el usuario en el campo --container--

@param	nodeName: Nombre del nodo hijo de la acción cuyo valor se busca
@return	valor del nodo correspondiente a la acción seleccionada
\end */
function oficial_flActionData(nodeName:String):String {
	var cursor:FLSqlCursor = form.cursor();
	var nodoAccion:FLDomNode;
	var listaAcciones:FLDomNodeList = this.iface.xmlAcciones.elementsByTagName("action");
	for (var i:Number = 0; i < listaAcciones.length(); i++) {
		if (listaAcciones.item(i).namedItem("name").toElement().text() == cursor.valueBuffer("container"))
			nodoAccion = listaAcciones.item(i);
	}
	if (!nodoAccion) {
		MessageBox.warning(util.translate("scripts", 
			"No se ha encontrado los datos correspondientes a la acción ") + cursor.valueBuffer("container"),
			MessageBox.Ok);
		return "";
	}
	return nodoAccion.namedItem(nodeName).toElement().text();
}

/** \D Establece unos valores para el nuevo paso en función de los del paso anterior, con objeto de agilizar su inserción
\end */
function oficial_guessValues()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var cursorAnt:FLSqlCursor = new FLSqlCursor("tt_stepcat");
	
	var numPaso:Number = util.sqlSelect("tt_stepcat", "MAX(stepnumber)", "idtestcat = " + cursor.valueBuffer("idtestcat"));
	if (!numPaso) {
		this.child("fdbStepNumber").setValue(1);
		return;
	}
		
	cursorAnt.select("idtestcat = " + cursor.valueBuffer("idtestcat") + " AND stepnumber = " + numPaso);
	if (!cursorAnt.first())
		return;
		
	numPaso++;
	
	this.child("fdbStepNumber").setValue(numPaso);
	this.child("fdbIdArea").setValue(cursorAnt.valueBuffer("idarea"));
	this.child("fdbIdModulo").setValue(cursorAnt.valueBuffer("idmodule"));
	this.child("fdbContainer").setValue(cursorAnt.valueBuffer("container"));
	cursor.setValueBuffer("formtype", cursorAnt.valueBuffer("formtype"));
	this.child("fdbIdObjectType").setValue(cursorAnt.valueBuffer("idobjecttype"));
	
	/** \D Cuando se pulse un botón en un formulario maestro, el siguiente paso será rellenar un campo en el formulario de edición
	*/
	if (cursorAnt.valueBuffer("idobjecttype") == "Button" && cursorAnt.valueBuffer("formtype") == "form") {
		cursor.setValueBuffer("formtype", "formRecord");
		this.child("fdbIdObjectType").setValue("FLFieldDB");
	}
}

/** \D Establece ciertas habilitaciones y valores iniciales en el formulario en función del tipo de objeto seleccionado para el paso
\end */
function oficial_valuesForType()
{
	this.child("fdbPBAccept").setDisabled(true);
	switch(this.child("fdbIdObjectType").value()) {
		case "Query":
			this.child("fdbContainer").setValue("");
			this.child("fdbFormType").setValue("");	
			this.child("fdbObjectName").setValue("");	
			break;
		case "Button":
			this.child("fdbPBAccept").setDisabled(false);
			break;
		case "FLFormDB":
			this.child("fdbObjectName").setValue(this.child("fdbContainer").value());
			break;
	}
}

function oficial_calculateField(fN:String):String
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil;
	var res:String;
	switch (fN) {
		case "description": {
			switch (cursor.valueBuffer("idobjecttype")) {
				case "Assignation": {
					var xml:FLDomDocument = new FLDomDocument();
					if (!xml.setContent(cursor.valueBuffer("parameters")))
						break;
					var asignaciones:FLDomNodeList = xml.elementsByTagName("FLTest:AssignationElement");
					for (var i = 0; i < asignaciones.length(); i++) {
						if (!res.isEmpty())
							res += ", ";
						res += asignaciones.item(i).toElement().attribute("var") + " = " + asignaciones.item(i).toElement().attribute("value");
					}
					break;
				}
				case "Query": {
					var xml:FLDomDocument = new FLDomDocument();
					if (!xml.setContent(cursor.valueBuffer("parameters")))
						break;
					var consulta:FLDomNode = xml.namedItem("FLTest:Query");
					res = util.translate("scripts", "Guardar") + " " + consulta.toElement().attribute("savein");
					break;
				}
				case "FLTableDB": {
					res = util.translate("scripts", "Seleccionar") + " " + cursor.valueBuffer("parameters");
					break;
				}
				case "Test": {
					var xmlTest:FLDomDocument = new FLDomDocument;
					if (!this.iface.aliasObject) {
						if (xmlTest.setContent(cursor.valueBuffer("objectname"))) {
							this.iface.aliasObject = util.sqlSelect("tt_testcat", "description", "codtestcat = '" + xmlTest.firstChild().toElement().attribute("codtest") + "' AND idfuncional = '" + xmlTest.firstChild().toElement().attribute("idfuncional") + "'");
						}
					}
					res = this.iface.aliasObject;
					if (xmlTest.setContent(cursor.valueBuffer("parameters"))) {
						var l:FLDomNodeList = xmlTest.elementsByTagName("FLTest:AssignationElement");
						for (var i:Number = 0; i < l.length(); i++) {
							res += " " + l.item(i).toElement().attribute("var") + " = " + l.item(i).toElement().attribute("value");
						}
					}
					break;
				}
				case "Compare": {
					res = cursor.valueBuffer("description");
					break;
				}
				case "QTabWidget": {
					res = cursor.valueBuffer("objectname") + ": " + util.translate("scripts", "Seleccionar la pestaña") + " " + cursor.valueBuffer("parameters");
					break;
				}
				case "FLFieldDB": {
					switch (cursor.valueBuffer("idaction")) {
						case "setValue": {
							if (this.iface.aliasObject.isEmpty())
								res = cursor.valueBuffer("objectname") + " = " + cursor.valueBuffer("parameters");
							else
								res = this.iface.aliasObject + " = " + cursor.valueBuffer("parameters");
							break;
						}
						case "saveValue": {
							if (this.iface.aliasObject.isEmpty())
								res = cursor.valueBuffer("parameters") + " = " + cursor.valueBuffer("objectname");
							else
								res = cursor.valueBuffer("parameters") + " = " + this.iface.aliasObject;
							break;
						}
						default: {
							res = actionDesc + " " + this.iface.aliasObject;
						}
					}
					break;
				}
				default: {
					var actionDesc:String = util.sqlSelect("tt_action", "description", "idAction = '" + cursor.valueBuffer("idAction")+ "'");
					if (this.iface.aliasObject.isEmpty())
						res = actionDesc + " " + cursor.valueBuffer("objectname");
					else
						res = actionDesc + " " + this.iface.aliasObject;
					break;
				}
			}
		}
	}
	return res;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
