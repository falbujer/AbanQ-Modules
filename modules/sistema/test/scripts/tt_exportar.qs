/***************************************************************************
                 tt_exportar.qs  -  description
                             -------------------
    begin                : mie abr 8 2005
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
    function oficial( context ) { interna( context ); } 
	function exportar (tabla:String, fichero:String, idFuncional:String) {
		this.ctx.oficial_exportar (tabla, fichero, idFuncional);
	}
	function establecerFicheroFun() { 
		return this.ctx.oficial_establecerFicheroFun();
	}
	function exportarTabla(tabla:String, fichero:String, idFuncional:String):Number {
		return this.ctx.oficial_exportarTabla(tabla, fichero, idFuncional);
	}
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
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
	connect( this.child( "pbExaminarFun" ), "clicked()", this, "iface.establecerFicheroFun" );
	connect( this.cursor(), "bufferChanged(QString)", this, "iface.bufferChanged" );
	
	this.child("fdbIdFuncional").setValue(fltestppal.iface.pub_obtenerIdFuncional());
}

/** \D Exporta las pruebas asociadasa a la funcionalidad indicada por el usuario
\end */
function interna_main()
{
	var util:FLUtil = new FLUtil();

	var f:Object = new FLFormSearchDB("tt_exportar");
	var cursor:FLSqlCursor = f.cursor();
	
	cursor.select();
	if (!cursor.first())
		cursor.setModeAccess(cursor.Insert);
	else
		cursor.setModeAccess(cursor.Edit);
	
	cursor.refreshBuffer();
	f.setMainWidget();
	var idFuncional = f.exec("idfuncional");
	
	var ruta:String = cursor.valueBuffer("dircsvfun");
	
	if (!idFuncional || idFuncional == "") 
		return;
	
	if (!File.exists(ruta)) {
		MessageBox.warning(util.translate( "scripts", "La ruta especificada no es válida"), MessageBox.Ok, MessageBox.NoButton );
		return;
	}
	
	if (this.iface.exportarTabla("tt_sessioncat", ruta, idFuncional) < 0)
		return;
	
	if (this.iface.exportarTabla("tt_tcatscat", ruta, idFuncional) < 0)
		return;
	
	var numPruebas:Number = this.iface.exportarTabla("tt_testcat", ruta, idFuncional);
	if (numPruebas < 0)
		return;
	
	if (this.iface.exportarTabla("tt_stepcat", ruta, idFuncional) < 0)
		return;

	MessageBox.information(util.translate( "scripts", "Proceso finalizado. Pruebas exportadas: ") + numPruebas, MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
	
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D Exporta la información relativa a una determinada funcionaliad de una tabla a un fichero

@param	tabla: Nombre de la tabla
@param	ruta: Ruta donde guardar el fichero
@param	idFuncional: Nombre de la funcionalidad a exportar
@return	Verdadero si la exportación se realiza correctamente, falso en caso contrario
*/
function oficial_exportarTabla(tabla:String, ruta:String, idFuncional:String):Number
{
	var fichero:String = ruta + "/" + tabla + ".csv";
	var util:FLUtil = new FLUtil();
	var file = new File( fichero );

	try {
		file.open( File.WriteOnly );
	}
	catch (e) {
		MessageBox.warning( util.translate( "scripts", "Imposible abrir el fichero ") + file.name + util.translate( "scripts", " para escritura\nCompruebe que la ruta es válida y que los permisos de escritura son correctos"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return -1;
	}
	
	var listaCampos:Array = util.nombreCampos(tabla);
	if (listaCampos.length == 0) {
		MessageBox.warning( util.translate( "scripts", "La tabla ") + tabla + util.translate( "scripts", " no tiene estructura. No se exportará"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return -1;
	}
	
	var numCampos:Number = parseFloat(listaCampos[0]);
	var linea:String = "";
	var campoLinea:String;
	var select:String = listaCampos[2];
	var i:Number;
	for (i = 3; i <= numCampos; i++)
		select += ", " + listaCampos[i];
	var where:String = "idfuncional = '" + idFuncional + "'";
	var tablesList:String = tabla;
	var from:String = tabla;

	var q:FLSqlQuery = new FLSqlQuery();
	switch (tabla) {
		case "tt_stepcat": {
			select = "s." + listaCampos[2];
			for (i = 3; i <= numCampos; i++)
				select += ", s." + listaCampos[i];
			select += ", t.codtestcat, t.idfuncional";
			numCampos += 2;
			tablesList = "tt_stepcat,tt_testcat";
			from = "tt_testcat t INNER JOIN tt_stepcat s ON t.id = s.idtestcat";
			where += " ORDER BY idtestcat";
			break;
		}
		case "tt_tcatscat": {
			select = "t." + listaCampos[2];
			for (i = 3; i <= numCampos; i++)
				select += ", t." + listaCampos[i];
			select += ", s.idfuncional";
			numCampos += 1;
			tablesList = "tt_tcatscat,tt_sessioncat";
			from = "tt_tcatscat t INNER JOIN tt_sessioncat s ON t.idsessioncat = s.id";
			where = "s.idfuncional = '" + idFuncional + "'";
			break;
		}
		case "tt_testcat": {
			where += " ORDER BY id";
			break;
		}
	}
	q.setTablesList(tabla);
	q.setSelect(select);
	q.setFrom(from);
	q.setWhere(where);
	
	var paso:Number = 0;
	var acumPaso:Number = 0;
	var numRegistros:Number;
	
	if (!q.exec()) {
		MessageBox.critical(util.translate( "scripts", "Error al leer los datos de la tabla ") + tabla, MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return -1;
	}
	numRegistros = q.size();
	util.createProgressDialog( util.translate( "scripts", "Exportando tabla..." ), numRegistros );
	util.setProgress(1);
	
	while ( q.next() ) {
		util.setProgress( paso++ );
		linea = "";
 		for (i = 0; i < (numCampos - 1); i++) {
			campoLinea = "";
			if (!q.isNull(i)) campoLinea = q.value(i);
			linea += campoLinea + this.iface.sep;
		}
		if (++paso == 25) {
			acumPaso += paso;
			paso = 0;
			util.setProgress(acumPaso);
		}
		linea += this.iface.eol;
		file.writeLine(linea);
	}
	
	file.close();
	
	util.setProgress( numRegistros );
	util.destroyProgressDialog();
	
	return numRegistros;
}


/** \D Establece la ruta al directorio de exportación de pruebas de la funcionalidad en desarrollo
\end */
function oficial_establecerFicheroFun() 
{
	var util:FLUtil = new FLUtil();
	this.child( "fdbDirFun" ).setValue( FileDialog.getExistingDirectory( util.translate( "scripts", "Texto CSV (*.csv)" ), util.translate( "scripts", "Elegir Fichero" ) ) );
}

/** \C Establece la ruta al directorio de exportación de pruebas de la funcionalidad a partir del valor de la funcionalidad. Dicha ruta es: 

Directorio de trabajo / funcionalidad / funcionalidad / test
\end */
function oficial_bufferChanged(fN:String)
{
	var cursor:FLSqlCursor = this.cursor();
	switch (fN) {
		case "idfuncional": {
			var idFuncional:String = cursor.valueBuffer("idfuncional");
			form.child("fdbDirFun").setValue(this.iface.pathLocal + idFuncional + "/" + idFuncional + "/test");
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
