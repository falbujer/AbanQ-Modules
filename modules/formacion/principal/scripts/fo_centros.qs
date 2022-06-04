/***************************************************************************
                 fo_centros.qs  -  description
                             -------------------
    begin                : vie sep 9 2011
    copyright            : (C) 2004-2011 by InfoSiAL S.L.
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
	function init() {
		return this.ctx.interna_init();
	}
	function validateForm():Boolean {
		return this.ctx.interna_validateForm();
	}
	function calculateField(fN:String):String {
		return this.ctx.interna_calculateField(fN);
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	function oficial( context ) { interna( context ); }
	function tbnCalcularDias_clicked() {
		return this.ctx.oficial_tbnCalcularDias_clicked();
	}
	function regenerarDiasCalendario(fechaInicial, fechaFinal) {
		return this.ctx.oficial_regenerarDiasCalendario(fechaInicial, fechaFinal);
	}
	function crearDia(fecha) {
		return this.ctx.oficial_crearDia(fecha);
	}
	function iniciaFiltroDias() {
		return this.ctx.oficial_iniciaFiltroDias();
	}
	function filtraDias() {
		return this.ctx.oficial_filtraDias();
	}
	function bufferChanged(fN) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function tbnLectivo_clicked() {
		return this.ctx.oficial_tbnLectivo_clicked();
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

/** @class_definition interna */
////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
function interna_init()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	connect(this.child("tbnCalcularDias"), "clicked()", this, "iface.tbnCalcularDias_clicked");
	connect(this.child("tbnLectivo"), "clicked()", this, "iface.tbnLectivo_clicked");
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	
	_i.iniciaFiltroDias();
}

function interna_validateForm():Boolean
{
	return true;
}

function interna_calculateField(fN:String):String
{
	var valor:String;
	switch (fN) {
		case "x": {
			break;
		}
	}
	return valor;s
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_iniciaFiltroDias()
{
	var _i = this.iface;
	var hoy = new Date;
	this.child("fdbDiasDesde").setValue(hoy);
	_i.filtraDias();
}

function oficial_bufferChanged(fN)
{
	var _i = this.iface;
	switch(fN) {
		case "diasdesde": {
			_i.filtraDias();
			break;
		}
	}
}

function oficial_filtraDias()
{
	var cursor = this.cursor();
	var diasDesde = cursor.valueBuffer("diasdesde")
	var filtro = "fecha >= '" + diasDesde + "'";
	this.child("tdbCalendario").setFilter(filtro);
	this.child("tdbCalendario").refresh();
}

function oficial_tbnCalcularDias_clicked()
{
	var util = new FLUtil;
	var _i = this.iface;
	var hoy = new Date;
	var cursor = this.cursor();
	if (cursor.modeAccess() == cursor.Insert) {
		if (!this.child("tdbCalendario").cursor().commitBufferCursorRelation()) {
			return false;
		}
	}
	var dialog = new Dialog;
	dialog.caption = "Intervalo de Fechas";
	dialog.okButtonText = "Calcular"
	dialog.cancelButtonText = "Cancelar";
	
	var fecha1 = new DateEdit;
	fecha1.label = "Fecha Inicial: ";
	fecha1.date = hoy;
	dialog.add( fecha1 );

	var fecha2 = new DateEdit;
	fecha2.label = "Fecha Final: ";
	dialog.add( fecha2 );
	
	if (!dialog.exec())
		return false;

	var fechaInicial:Date = fecha1.date;
	var fechaFinal:Date = fecha2.date;
	if (!fechaInicial || fechaInicial == "" || !fechaFinal ||fechaFinal == "") {
		MessageBox.warning(util.translate("scripts", "Debe establecer las fechas inicial y final"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
// 	if (util.daysTo(fechaInicial,hoy) > 0) {
	var anyoActual:Number = hoy.getYear();
	if (fechaInicial.getYear < anyoActual) {
		MessageBox.warning(util.translate("scripts", "La fecha inicial no puede ser anterior al año actual"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	var curT:FLSqlCursor = new FLSqlCursor("factppal_general");
	curT.transaction(false);
	try {
		if (_i.regenerarDiasCalendario(fechaInicial, fechaFinal)) {
			curT.commit();
		} else {
			curT.rollback();
			MessageBox.critical(util.translate("scripts", "Error al regenerar el calendario laboral"), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
	} catch (e) {
		curT.rollback();
		MessageBox.critical(util.translate("scripts", "Error al regenerar el calendario laboral: ") + e, MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	this.child("tdbCalendario").refresh();
}

function oficial_regenerarDiasCalendario(fechaInicial, fechaFinal)
{
	var util = new FLUtil;
	var _i = this.iface;
	var fechaCalculada = fechaInicial;
 	var dias = util.daysTo(fechaCalculada, fechaFinal);

	util.createProgressDialog(util.translate("scripts", "Regenerando Calendario"), dias);
	util.setProgress(0);
	var i = 0;

	while (util.daysTo(fechaCalculada,fechaFinal) >= 0) {
		if(!this.iface.crearDia(fechaCalculada)) {
			util.destroyProgressDialog();
			return false;
		}
		fechaCalculada = util.addDays(fechaCalculada,1);
		util.setProgress(i++);
	}
	util.setProgress(dias);
	util.destroyProgressDialog();
	return true;
}

function oficial_crearDia(fecha)
{
	var util = new FLUtil;
	var _i = this.iface;
	var cursor = this.cursor();
	
	var diaSemana = fecha.getDay();
	var horaInicioManana = "";
	var horaFimManana = "";
	var horaInicioTarde = "";
	var horaFinTarde = "";
	var totalhoras = 0;

	var horarioLaboral = cursor.valueBuffer("codhorariodl");
	var horarioSabado = cursor.valueBuffer("codhorariosab");
	var horarioDomingo = cursor.valueBuffer("codhorariodom");
	var horario:String = "";
	if (!horarioLaboral || horarioLaboral == "") {
		MessageBox.warning(util.translate("scripts", "Debe establecer un tipo de horario para los días lectivos"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	switch (diaSemana) {
		case 1:
		case 2:
		case 3:
		case 4:
		case 5:
			horaInicioManana = util.sqlSelect("horarioslab","horaentradamanana","codhorario = '" + horarioLaboral + "'");
			horaFinManana = util.sqlSelect("horarioslab","horasalidamanana","codhorario = '" + horarioLaboral + "'");
			horaInicioTarde = util.sqlSelect("horarioslab","horaentradatarde","codhorario = '" + horarioLaboral + "'");
			horaFinTarde = util.sqlSelect("horarioslab","horasalidatarde","codhorario = '" + horarioLaboral + "'");
			totalhoras = util.sqlSelect("horarioslab","totalhoras","codhorario = '" + horarioLaboral + "'");
			horario = horarioLaboral;
			
			break;
		case 6:
			if (horarioSabado && horarioSabado != "") {
				horaInicioManana = util.sqlSelect("horarioslab","horaentradamanana","codhorario = '" + horarioSabado + "'");
				horaFinManana = util.sqlSelect("horarioslab","horasalidamanana","codhorario = '" + horarioSabado + "'");
				horaInicioTarde = util.sqlSelect("horarioslab","horaentradatarde","codhorario = '" + horarioSabado + "'");
				horaFinTarde = util.sqlSelect("horarioslab","horasalidatarde","codhorario = '" + horarioSabado + "'");
				totalhoras = util.sqlSelect("horarioslab","totalhoras","codhorario = '" + horarioSabado + "'");
			}
			else {
				horaInicioManana = "";
				horaFinManana = "";
				horaInicioTarde = "";
				horaFinTarde = "";
				horarioSabado = "";
				totalhoras = 0;
			}
			horario = horarioSabado;
			break;
		case 7:
			if (horarioDomingo && horarioDomingo != "") {
				horaInicioManana = util.sqlSelect("horarioslab","horaentradamanana","codhorario = '" + horarioDomingo + "'");
				horaFinManana = util.sqlSelect("horarioslab","horasalidamanana","codhorario = '" + horarioDomingo + "'");
				horaInicioTarde = util.sqlSelect("horarioslab","horaentradatarde","codhorario = '" + horarioDomingo + "'");
				horaFinTarde = util.sqlSelect("horarioslab","horasalidatarde","codhorario = '" + horarioDomingo + "'");
				totalhoras = util.sqlSelect("horarioslab","totalhoras","codhorario = '" + horarioDomingo + "'");
			}
			else {
				horaInicioManana = "";
				horaFinManana = "";
				horaInicioTarde = "";
				horaFinTarde = "";
				horarioDomingo = "";
				totalhoras = 0;
			}
			horario = horarioDomingo;
			break;
		default:
			return false;
	}

	var curCalendario:FLSqlCursor = new FLSqlCursor("calendariolab");
//debug("Buscando fecha " + fecha);
	if (util.sqlSelect("calendariolab", "fecha", "fecha = '" + fecha + "' AND codcentroesc = '" + cursor.valueBuffer("codcentro") + "'")) {
		curCalendario.select("fecha = '" + fecha + "'");
		curCalendario.setModeAccess(curCalendario.Edit);
		if (!curCalendario.first()) {
			return false;
		}
		curCalendario.refreshBuffer();
	} else {
		curCalendario.setModeAccess(curCalendario.Insert);
		curCalendario.refreshBuffer();
		curCalendario.setValueBuffer("fecha", fecha);
	}

	var semana = [ util.translate("scripts", "Lunes"),util.translate("scripts", "Martes"),util.translate("scripts", "Miércoles"),util.translate("scripts", "Jueves"),util.translate("scripts", "Viernes"),util.translate("scripts", "Sábado"),util.translate("scripts", "Domingo")];

	curCalendario.setValueBuffer("codcentroesc", cursor.valueBuffer("codcentro"));
	curCalendario.setValueBuffer("codhorario", horario);
	curCalendario.setValueBuffer("descripcion", semana[diaSemana - 1]);
	curCalendario.setValueBuffer("horaentradamanana", horaInicioManana);
	curCalendario.setValueBuffer("horasalidamanana", horaFinManana);
	curCalendario.setValueBuffer("horaentradatarde",horaInicioTarde);
	curCalendario.setValueBuffer("horasalidatarde", horaFinTarde);
	curCalendario.setValueBuffer("totalhoras", totalhoras);

	if (!curCalendario.commitBuffer()) {
		return false;
	}
	return true;
}

function oficial_tbnLectivo_clicked()
{
	var util = new FLUtil();
	var cursor = this.cursor();
	var codigoHorario;
	var codHorarioLab = cursor.valueBuffer("codhorariodl");
	var codHorarioDom = cursor.valueBuffer("codhorariodom");
	var curHorario = this.child("tdbCalendario").cursor();

	if (curHorario.valueBuffer("codhorario") == codHorarioLab) {
		codigoHorario = codHorarioDom;
	} else {
		codigoHorario = codHorarioLab;
	}
	
	var curCal = new FLSqlCursor("calendariolab");
	curCal.select("fecha = '" + curHorario.valueBuffer("fecha") + "' AND codcentroesc = '" + cursor.valueBuffer("codcentro") + "'");
	if (!curCal.first()) {
		return false;
	}
	curCal.setModeAccess(curCal.Edit);
	curCal.refreshBuffer();
	curCal.setValueBuffer("codhorario", codigoHorario);
	curCal.setValueBuffer("horaentradamanana", util.sqlSelect("horarioslab","horaentradamanana","codhorario = '" + codigoHorario + "'"));
	curCal.setValueBuffer("horasalidamanana", util.sqlSelect("horarioslab","horasalidamanana","codhorario = '" + codigoHorario + "'"));
	curCal.setValueBuffer("horaentradatarde", util.sqlSelect("horarioslab","horaentradatarde","codhorario = '" + codigoHorario + "'"));
	curCal.setValueBuffer("horasalidatarde", util.sqlSelect("horarioslab","horasalidatarde","codhorario = '" + codigoHorario + "'"));
	curCal.setValueBuffer("totalhoras", util.sqlSelect("horarioslab","totalhoras","codhorario = '" + codigoHorario + "'"));
	if (!curCal.commitBuffer()) {
		return false;
	}
	
	this.child("tdbCalendario").refresh();
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
