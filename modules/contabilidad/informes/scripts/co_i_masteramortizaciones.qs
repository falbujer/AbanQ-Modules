/***************************************************************************
                 co_i_masteramortizaciones.qs  -  description
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
    function init() { return this.ctx.interna_init(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var fechaInicio_, fechaFin_, fechaFinAnt_, asientosCierre_, asientosCierreAnt_, asientoApertura_, datosAmor_;
	var total_, totalGrupo_;

	function oficial( context ) { interna( context ); } 
	function lanzar() {
		return this.ctx.oficial_lanzar();
	}
	function obtenerParamInforme() {
		return this.ctx.oficial_obtenerParamInforme();
	}
	function iniciaTotalGrupo(nodo, campo) {
		return this.ctx.oficial_iniciaTotalGrupo(nodo, campo);
	}
	function iniciaTotal() {
		return this.ctx.oficial_iniciaTotal();
	}
	function valorInforme(nodo, campo) {
		return this.ctx.oficial_valorInforme(nodo, campo);
	}
	function dameCampos() {
		return this.ctx.oficial_dameCampos();
	}
	function desInforme(nodo, campo) {
		return this.ctx.oficial_desInforme(nodo, campo);
	}
	function cargaDatosAmor(nodo) {
		return this.ctx.oficial_cargaDatosAmor(nodo);
	}
	function calculaCampo(nodo, campo) {
		return this.ctx.oficial_calculaCampo(nodo, campo);
	}
	function dameSaldo(codSubcuenta, codAmortizacion, fechaSaldo, asientosCierre) {
		return this.ctx.oficial_dameSaldo(codSubcuenta, codAmortizacion, fechaSaldo, asientosCierre);
	}
	function asientosCierre(codEjercicio) {
		return this.ctx.oficial_asientosCierre(codEjercicio);
	}
	function asientoApertura(codEjercicio) {
		return this.ctx.oficial_asientoApertura(codEjercicio);
	}
	function totalGrupo(nodo, campo) {
		return this.ctx.oficial_totalGrupo(nodo, campo);
	}
	function totalInfo(nodo, campo) {
		return this.ctx.oficial_totalInfo(nodo, campo);
	}
	function dameCampos() {
		return this.ctx.oficial_dameCampos();
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

/** \C El botón de impresión lanza el informe
\end */
function interna_init()
{ 
	connect(this.child("toolButtonPrint"), "clicked()", this, "iface.lanzar()");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_lanzar()
{
	var cursor = this.cursor();
	var pI = this.iface.obtenerParamInforme();
	if (!pI) {
		return;
	}

	flfactinfo.iface.pub_lanzaInforme(cursor, pI);
}

function oficial_obtenerParamInforme()
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	var seleccion = cursor.valueBuffer("id");
	if (!seleccion) {
		return false;
	}
	var codEjercicio = cursor.valueBuffer("codejercicio");
	
	_i.fechaInicio_ = AQUtil.sqlSelect("ejercicios", "fechainicio", "codejercicio = '" + codEjercicio + "'");
	_i.fechaFin_ = AQUtil.sqlSelect("ejercicios", "fechafin", "codejercicio = '" + codEjercicio + "'");
	_i.fechaFinAnt_ = AQUtil.addDays(_i.fechaInicio_, -1);
	
	_i.fechaInicio_ = _i.fechaInicio_.toString().left(10);
	_i.fechaFin_ = _i.fechaFin_.toString().left(10);
	_i.fechaFinAnt_ = _i.fechaFinAnt_.toString().left(10);
	
debug("_i.fechaInicio_ " + _i.fechaInicio_);
debug("_i.fechaFin_ " + _i.fechaFin_);
debug("_i.fechaFinAnt_ " + _i.fechaFinAnt_);
	_i.asientosCierre_ = _i.asientosCierre(codEjercicio);
	_i.asientoApertura_ = _i.asientoApertura(codEjercicio);
	var codEjercicioAnt = AQUtil.sqlSelect("ejercicios", "codejercicio", "fechafin = '" + _i.fechaFinAnt_ + "'");
	_i.asientosCierreAnt_ = codEjercicioAnt ? _i.asientosCierre(codEjercicioAnt) : "-1";
	
	_i.datosAmor_ = undefined;
	
	_i.iniciaTotal()
	_i.iniciaTotalGrupo()
	
	var paramInforme = flfactinfo.iface.pub_dameParamInforme();
	paramInforme.nombreInforme = "co_i_amortizaciones";
	paramInforme.whereFijo = "co_subcuentas.codejercicio = '" + codEjercicio + "' AND co_amortizaciones.fecha <= '" + _i.fechaFin_ + "' AND NOT (estado = 'Cerrada' AND fechacierre < '" + _i.fechaInicio_ + "')";
	
	return paramInforme;
}

function oficial_iniciaTotal()
{
	var _i = this.iface;
	if (!_i.total_) {
		_i.total_ = new Object;
	}
	var campos = _i.dameCampos()
	for (var c = 0; c < campos.length; c++) {
		_i.total_[campos[c]] = 0;
	}
}

function oficial_iniciaTotalGrupo(nodo, campo)
{
	var _i = this.iface;
	if (!_i.totalGrupo_) {
		_i.totalGrupo_ = new Object;
	}
	var campos = _i.dameCampos()
	for (var c = 0; c < campos.length; c++) {
		_i.totalGrupo_[campos[c]] = 0;
	}
}

function oficial_totalGrupo(nodo, campo)
{
	var _i = this.iface;
	
	var v;
	if (campo in _i.totalGrupo_) {
		v = _i.totalGrupo_[campo];
		_i.totalGrupo_[campo] = 0;
	} else {
		v = 0;
	}
	return v;
}

function oficial_totalInfo(nodo, campo)
{
	var _i = this.iface;
	
	var v;
	if (campo in _i.total_) {
		v = _i.total_[campo];
		_i.total_[campo] = 0;
	} else {
		debug("no existe");
		v = 0;
	}
debug("oficial_totalInfo " + campo + " = " + v);
	return v;
}

function oficial_desInforme(nodo, campo)
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	return cursor.valueBuffer("descripcion");
}

function oficial_valorInforme(nodo, campo)
{
	var _i = this.iface;
	var valor;
	
	var codAmortizacion = nodo.attributeValue("co_amortizaciones.codamortizacion");
	if (!_i.datosAmor_ || _i.datosAmor_["codamortizacion"] != codAmortizacion) {
		if (!_i.cargaDatosAmor(nodo)) {
			return false;
		}
	}
	return _i.datosAmor_[campo];
}

function oficial_dameCampos()
{
	return ["costeInicio", "amorInicio", "adicion", "venta", "ventaPeriodo", "costeFin", "amorPeriodo", "ventaAmorPeriodo", "amorFin", "valorInicio", "valorFin"];
}

function oficial_cargaDatosAmor(nodo)
{
	var _i = this.iface;
	
	if (!_i.datosAmor_) {
		_i.datosAmor_ = new Object;
	}
	_i.datosAmor_["codamortizacion"] = nodo.attributeValue("co_amortizaciones.codamortizacion");
	var campos = _i.dameCampos();
	var v;
	for (var c = 0; c < campos.length; c++) {
		v = _i.calculaCampo(nodo, campos[c]);
		_i.datosAmor_[campos[c]] = v;
		v = isNaN(v) ? 0 : v;
		v = (v) ? v : 0;
		_i.total_[campos[c]] += parseFloat(v);
		if (campos[c] == "costeInicio") {
			debug("_i.total_[costeinicio] = " + _i.total_["costeInicio"] + " (+" + v + ")")
		}
		_i.totalGrupo_[campos[c]] += parseFloat(v);
	}
	return true;
}

function oficial_calculaCampo(nodo, campo)
{
	var _i = this.iface;
	var valor;
	
	var codAmortizacion = nodo.attributeValue("co_amortizaciones.codamortizacion");
	var codSubcuenta = nodo.attributeValue("co_subcuentas.codsubcuenta");
	var codSubcuentaAmo = nodo.attributeValue("co_gruposcontablesamo.codsubcuentaamo");
	var fechaAdquisicion = nodo.attributeValue("co_amortizaciones.fecha");
	
	switch (campo) {
		case "costeInicio": {
			if (AQUtil.sqlSelect("co_asientos a INNER JOIN co_partidas p ON a.idasiento = p.idasiento", "a.idasiento", "a.fecha <= '" + _i.fechaFinAnt_ + "' AND p.codsubcuenta = '" + codSubcuenta + "' AND p.codactivo = '" + codAmortizacion + "' AND a.idasiento NOT IN (" + _i.asientosCierreAnt_ + ")", "co_asientos")) {
				valor = AQUtil.sqlSelect("co_asientos a INNER JOIN co_partidas p ON a.idasiento = p.idasiento", "SUM(p.debe-p.haber)", "a.fecha <= '" + _i.fechaFinAnt_ + "' AND p.codsubcuenta = '" + codSubcuenta + "' AND p.codactivo = '" + codAmortizacion + "' AND a.idasiento NOT IN (" + _i.asientosCierreAnt_ + ")", "co_asientos");
			} else {
				valor = AQUtil.sqlSelect("co_dotaciones", "acumulado + resto", "codamortizacion = '" + codAmortizacion + "' AND fechafin <= ' " + _i.fechaFinAnt_ + "' ORDER BY fechafin DESC");
				valor = isNaN(valor) ? "" : valor;
				if (valor == "") {
					if (AQUtil.daysTo(fechaAdquisicion, _i.fechaFinAnt_) >= 0) {
						valor = nodo.attributeValue("co_amortizaciones.valoramortizable");
					}
				}
			}
			valor = !valor || isNaN(valor) ? 0 : valor;
// 			valor = _i.dameSaldo(codSubcuenta, codAmortizacion, _i.fechaFinAnt_, _i.asientosCierreAnt_);
			break;
		}
		case "costeFin": {
// 			valor = _i.dameSaldo(codSubcuenta, codAmortizacion, _i.fechaFin_, _i.asientosCierre_);
// 			if (valor == "") {
			valor = parseFloat(_i.datosAmor_["costeInicio"]);
			valor = valor == "" || isNaN(valor) ? 0 : valor;
			valor += parseFloat(_i.datosAmor_["adicion"]) - parseFloat(_i.datosAmor_["ventaPeriodo"]);
// 			var amort = AQUtil.sqlSelect("co_dotaciones", "SUM(importe)", "codamortizacion = '" + codAmortizacion + "' AND fechainicio >= '" + _i.fechaInicio_ + "' AND fechafin <= ' " + _i.fechaFin_ + "'");
// 			amort = isNaN(amort) ? 0 : amort;
			
// 			valor += parseFloat(amort) + parseFloat(_i.datosAmor_["adicion"]) - parseFloat(_i.datosAmor_["ventaPeriodo"]);
			
// 			valor = AQUtil.sqlSelect("co_dotaciones", "acumulado + resto", "codamortizacion = '" + codAmortizacion + "' AND fechafin <= ' " + _i.fechaFin_ + "' ORDER BY fechafin DESC");
// 			if (valor == "") {
// 			if (AQUtil.daysTo(fechaAdquisicion, _i.fechaFin_) >= 0) {
// 					valor = nodo.attributeValue("co_amortizaciones.valoramortizable");
// 				}
// 			}
// 			}
			valor = !valor || isNaN(valor) ? 0 : valor;
debug("valor4" + valor);
			break;
		}
		case "amorInicio": {
// 			valor = _i.dameSaldo(codSubcuentaAmo, codAmortizacion, _i.fechaFinAnt_, _i.asientosCierre_);
// 			if (valor == "") {
				valor = AQUtil.sqlSelect("co_dotaciones", "SUM(importe)", "codamortizacion = '" + codAmortizacion + "' AND fechafin <= ' " + _i.fechaFinAnt_ + "'");
// 			}
			valor = !valor || isNaN(valor) ? 0 : valor;
			break;
		}
		case "amorPeriodo": {
			valor = AQUtil.sqlSelect("co_dotaciones", "SUM(importe)", "codamortizacion = '" + codAmortizacion + "' AND fechainicio >= '" + _i.fechaInicio_ + "' AND fechafin <= ' " + _i.fechaFin_ + "'");
// 			valor = _i.datosAmor_["amorFin"] - _i.datosAmor_["amorInicio"];
			valor = !valor || isNaN(valor) ? 0 : valor;
			break;
		}
		case "amorFin": {
// 			valor = _i.dameSaldo(codSubcuentaAmo, codAmortizacion, _i.fechaFin_, _i.asientosCierre_);
// 			if (valor == "") {
// 				valor = AQUtil.sqlSelect("co_dotaciones", "SUM(importe)", "codamortizacion = '" + codAmortizacion + "' AND fechafin <= '" + _i.fechaFin_ + "'");
// 			}
			valor = parseFloat(_i.datosAmor_["amorInicio"]) + parseFloat(_i.datosAmor_["amorPeriodo"]) + parseFloat(_i.datosAmor_["ventaAmorPeriodo"]);
			
			valor = !valor || isNaN(valor) ? 0 : valor;
			break;
		}
		case "adicion": {
			valor = AQUtil.sqlSelect("co_asientos a INNER JOIN co_partidas p ON a.idasiento = p.idasiento", "SUM(p.debe)", "a.fecha BETWEEN '" + _i.fechaInicio_ + "' AND '" + _i.fechaFin_ + "' AND p.codsubcuenta = '" + codSubcuenta + "' AND p.codactivo = '" + codAmortizacion + "' AND a.idasiento NOT IN (" + _i.asientosCierre_ + ", " + _i.asientoApertura_ + ")", "co_asientos");
// if (codAmortizacion == "000333") {
// 	debug("select SUM(p.debe), SUM(p.haber) FROM co_asientos a INNER JOIN co_partidas p ON a.idasiento = p.idasiento WHERE a.fecha BETWEEN '" + _i.fechaInicio_ + "' AND '" + _i.fechaFin_ + "' AND p.codsubcuenta = '" + codSubcuenta + "' AND p.codactivo = '" + codAmortizacion + "' AND a.idasiento NOT IN (" + _i.asientosCierre_ + ", " + _i.asientoApertura_ + ")");
// }
			valor = !valor || isNaN(valor) ? 0 : valor;
			break;
		}
		case "venta": {
			valor = AQUtil.sqlSelect("co_asientos a INNER JOIN co_partidas p ON a.idasiento = p.idasiento", "SUM(p.haber)", "a.fecha BETWEEN '" + _i.fechaInicio_ + "' AND '" + _i.fechaFin_ + "' AND p.codsubcuenta = '" + codSubcuenta + "' AND p.codactivo = '" + codAmortizacion + "' AND a.idasiento NOT IN (" + _i.asientosCierre_ + ", " + _i.asientoApertura_ + ")", "co_asientos");
			valor = !valor || isNaN(valor) ? 0 : valor;
			break;
		}
		case "ventaPeriodo": {
			valor = AQUtil.sqlSelect("co_asientos a INNER JOIN co_partidas p ON a.idasiento = p.idasiento", "SUM(p.haber)", "a.fecha BETWEEN '" + _i.fechaInicio_ + "' AND '" + _i.fechaFin_ + "' AND p.codsubcuenta = '" + codSubcuenta + "' AND p.codactivo = '" + codAmortizacion + "' AND a.idasiento NOT IN (" + _i.asientosCierre_ + ", " + _i.asientoApertura_ + ")", "co_asientos");
			valor = !valor || isNaN(valor) ? 0 : valor;
			break;
		}
		case "valorInicio": {
			valor = parseFloat(_i.datosAmor_["costeInicio"]) - parseFloat(_i.datosAmor_["amorInicio"]);
			valor = !valor || isNaN(valor) ? 0 : valor;
// 			debug("valorInicio = " + parseFloat(_i.datosAmor_["costeInicio"]) + " - " + parseFloat(_i.datosAmor_["amorInicio"]) + " = " + valor);
			break;
		}
		case "valorFin": {
// 			var fechaCierre = nodo.attributeValue("co_amortizaciones.fechacierre");
// 			if (fechaCierre && fechaCierre != "") {
// 				if (AQUtil.daysTo(fechaCierre, _i.fechaFin_) < 0 || AQUtil.daysTo(fechaCierre, _i.fechaInicio_) > 0) {
// 					valor = 0;
// 					break;
// 				}
// 			}
			valor = parseFloat(_i.datosAmor_["costeFin"]);
			if (valor == 0) {
				break;
			}
			valor -= parseFloat(_i.datosAmor_["amorFin"]);
			valor = !valor || isNaN(valor) ? 0 : valor;
			break;
		}
		case "ventaAmorPeriodo": {
			valor += parseFloat(_i.datosAmor_["adicion"]) - parseFloat(_i.datosAmor_["ventaPeriodo"]);
			var fechaCierre = nodo.attributeValue("co_amortizaciones.fechacierre");
			if (!fechaCierre || fechaCierre == "") {
				valor = 0;
				break;
			}
			if (AQUtil.daysTo(fechaCierre, _i.fechaFin_) < 0 || AQUtil.daysTo(fechaCierre, _i.fechaInicio_) > 0) {
				valor = 0;
				break;
			}
			valor = parseFloat(_i.datosAmor_["costeInicio"]);
			valor = valor == "" ? 0 : valor;
			
			valor -= (parseFloat(_i.datosAmor_["amorInicio"]) + parseFloat(_i.datosAmor_["amorPeriodo"]));
			valor = !valor || isNaN(valor) ? 0 : valor;
// 			var vA = parseFloat(nodo.attributeValue("co_amortizaciones.valoramortizable"));
// 			var a = AQUtil.sqlSelect("co_dotaciones", "SUM(importe)", "codamortizacion = '" + codAmortizacion + "' AND fechafin <= ' " + fechaCierre + "'");
// 			a = isNaN(a) ? 0 : a;
// 			valor = parseFloat(vA) - parseFloat(a);;
			break;
		}
	}
	return valor;
}

function oficial_dameSaldo(codSubcuenta, codAmortizacion, fechaSaldo, asientosCierre)
{
// debug("select SUM(p.debe-p.haber) from co_asientos a INNER JOIN co_partidas p ON a.idasiento = p.idasiento where a.fecha <= '" + fechaSaldo + "' AND p.codsubcuenta = '" + codSubcuenta + "' AND p.codactivo = '" + codAmortizacion + "' AND a.idasiento NOT IN (" + asientosCierre + ")");

	var valor = AQUtil.sqlSelect("co_asientos a INNER JOIN co_partidas p ON a.idasiento = p.idasiento", "SUM(p.debe-p.haber)", "a.fecha <= '" + fechaSaldo + "' AND p.codsubcuenta = '" + codSubcuenta + "' AND p.codactivo = '" + codAmortizacion + "' AND a.idasiento NOT IN (" + asientosCierre + ")", "co_asientos");
	valor = isNaN(valor) ? "" : valor;
	return valor;
}

function oficial_asientosCierre(codEjercicio)
{
	var _i = this.iface;

	var asientoPyG = AQUtil.sqlSelect("ejercicios", "idasientopyg", "codejercicio = '" + codEjercicio + "'");
	if (!asientoPyG) {
		asientoPyG = -1;
	}
	var asientoCierre = AQUtil.sqlSelect("ejercicios", "idasientocierre", "codejercicio = '" + codEjercicio + "'");
	if (!asientoCierre) {
		asientoCierre = -1;
	}
	var listaAsientos = asientoPyG + ", "	+ asientoCierre;
	
debug("listaAsientos " + codEjercicio + " = " + listaAsientos);
	return listaAsientos;
}

function oficial_asientoApertura(codEjercicio)
{
	var _i = this.iface;

	var asientoA = AQUtil.sqlSelect("ejercicios", "idasientoapertura", "codejercicio = '" + codEjercicio + "'");
	if (!asientoA) {
		asientoA = -1;
	}
	var listaAsientos = asientoA;
	
debug("listaAsientos " + codEjercicio + " = " + asientoA);
	return listaAsientos;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
