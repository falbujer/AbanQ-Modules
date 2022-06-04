/***************************************************************************
                 tpv_datosgenerales.qs  -  description
                             -------------------
    begin                : mie nov 23 2005
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
	function main() {
		this.ctx.interna_main();
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
	var ejercicioActual;
	var longSubcuenta;
	var contabilidadCargada;
	var posActualPuntoSubcuentaCaja;
	var bloqueoSubcuentaCaja;
	var posActualPuntoSubcuentaDifPos;
	var bloqueoSubcuentaDifPos;
	var posActualPuntoSubcuentaDifNeg;
	var bloqueoSubcuentaDifNeg;
	var posActualPuntoSubcuentaAnt;
	var bloqueoSubcuenta;

	function oficial( context ) { interna( context ); }
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
/**
\C Los datos generales son únicos, por tanto formulario de no presenta los botones de navegación por registros.
\end

\D La gestión del formulario se hace de forma manual mediante el objeto f (FLFormSearchDB)
\end
\end */
function interna_main()
{
	var f:Object = new FLFormSearchDB("tpv_datosgenerales");
	var cursor:FLSqlCursor = f.cursor();

	cursor.select();
	if (!cursor.first())
			cursor.setModeAccess(cursor.Insert);
	else
			cursor.setModeAccess(cursor.Edit);

	f.setMainWidget();
	if (cursor.modeAccess() == cursor.Insert)
			f.child("pushButtonCancel").setDisabled(true);
	cursor.refreshBuffer();
	var commitOk:Boolean = false;
	var acpt:Boolean;
	cursor.transaction(false);
	while (!commitOk) {
		acpt = false;
		f.exec("nombre");
		acpt = f.accepted();
		if (!acpt) {
			if (cursor.rollback())
				commitOk = true;
		} else {
			if (cursor.commitBuffer()) {
				cursor.commit();
				commitOk = true;
			}
		}
		f.close();
	}
}

function interna_init()
{
	var _i = this.iface;
	var cursor = this.cursor();

	if (cursor.isNull("integracionfac"))
		cursor.setValueBuffer("integracionfac", true);

	if (sys.isLoadedModule("flcontppal")) {
		_i.contabilidadCargada = true;
		_i.ejercicioActual = flfactppal.iface.pub_ejercicioActual();
		_i.longSubcuenta = AQUtil.sqlSelect("ejercicios", "longsubcuenta", "codejercicio = '" + _i.ejercicioActual + "'");
		_i.bloqueoSubcuentaCaja = false;
		_i.posActualPuntoSubcuentaCaja = -1;
		this.child("fdbIdSubcuentaCaja").setFilter("codejercicio = '" + _i.ejercicioActual + "'");
		_i.bloqueoSubcuentaDifPos = false;
		_i.posActualPuntoSubcuentaDifPos = -1;
		this.child("fdbIdSubcuentaDifPos").setFilter("codejercicio = '" + _i.ejercicioActual + "'");
		_i.bloqueoSubcuentaDifNeg = false;
		_i.posActualPuntoSubcuentaDifNeg = -1;
		this.child("fdbIdSubcuentaDifNeg").setFilter("codejercicio = '" + _i.ejercicioActual + "'");
		_i.bloqueoSubcuenta = false;
		_i.posActualPuntoSubcuentaAnt = -1;
		this.child("fdbIdSubcuentaAnticipo").setFilter("codejercicio = '" + _i.ejercicioActual + "'");
		this.child("fdbIdSubcuentaTar").setFilter("codejercicio = '" + _i.ejercicioActual + "'");
		this.child("fdbIdSubcuentaVale").setFilter("codejercicio = '" + _i.ejercicioActual + "'");
	} else {
		this.child("tbwDatosGenerales").setTabEnabled("contabilidad", false);
	}

	connect (cursor, "bufferChanged(QString)", _i, "bufferChanged");
	
	this.child("fdbDiasValidezVale").close();
	
	_i.bufferChanged("integracionfac");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_bufferChanged(fN:String)
{
	var _i = this.iface;
	var cursor = this.cursor();
	
	switch (fN) {
		case "integracionfac": {
			var msg:String;
			if (cursor.valueBuffer("integracionfac") == true || cursor.isNull("integracionfac")) {
				msg = sys.translate("Cada venta da lugar a una factura de cliente de forma inmediata.");
			} else {
				msg = sys.translate("Las facturas asociadas a las ventas se generan cuando se cierra el arqueo correspondiente. Esta opción no se aplica para ventas pendientes de pago o a cuenta.");
			}
			this.child("lblDesIntegracionFac").text = msg;
			break;
		}
		case "codsubcuentacaja": {
			if (!_i.bloqueoSubcuentaCaja) {
				_i.bloqueoSubcuentaCaja = true;
				_i.posActualPuntoSubcuentaCaja = flcontppal.iface.pub_formatearCodSubcta(this, "fdbCodSubcuentaCaja", _i.longSubcuenta, _i.posActualPuntoSubcuentaCaja);
				_i.bloqueoSubcuentaCaja = false;
			}
			break;
		}
		case "codsubcuentadifpos": {
			if (!_i.bloqueoSubcuentaDifPos) {
				_i.bloqueoSubcuentaDifPos = true;
				_i.posActualPuntoSubcuentaDifPos = flcontppal.iface.pub_formatearCodSubcta(this, "fdbCodSubcuentaDifPos", _i.longSubcuenta, _i.posActualPuntoSubcuentaDifPos);
				_i.bloqueoSubcuentaDifPos = false;
			}
			break;
		}
		case "codsubcuentadifneg": {
			if (!_i.bloqueoSubcuentaDifNeg) {
				_i.bloqueoSubcuentaDifNeg = true;
				_i.posActualPuntoSubcuentaDifNeg = flcontppal.iface.pub_formatearCodSubcta(this, "fdbCodSubcuentaDifNeg", _i.longSubcuenta, _i.posActualPuntoSubcuentaDifNeg);
				_i.bloqueoSubcuentaDifNeg = false;
			}
			break;
		}
		case "codsubcuentaanticipo": {
			if (!_i.bloqueoSubcuenta) {
				_i.bloqueoSubcuenta = true;
				_i.posActualPuntoSubcuentaAnt = flcontppal.iface.pub_formatearCodSubcta(this, "fdbCodSubcuentaAnticipo", _i.longSubcuenta, _i.posActualPuntoSubcuentaAnt);
				_i.bloqueoSubcuenta = false;
			}
			break;
		}
		case "codsubcuentaven": {
			if (!_i.bloqueoSubcuenta) {
				_i.bloqueoSubcuenta = true;
				_i.posActualPuntoSubcuentaAnt = flcontppal.iface.pub_formatearCodSubcta(this, "fdbCodSubcuentaVen", _i.longSubcuenta, _i.posActualPuntoSubcuentaAnt);
				_i.bloqueoSubcuenta = false;
			}
			break;
		}
		case "codsubcuentatar": {
			if (!_i.bloqueoSubcuenta) {
				_i.bloqueoSubcuenta = true;
				_i.posActualPuntoSubcuentaAnt = flcontppal.iface.pub_formatearCodSubcta(this, "fdbCodSubcuentaTar", _i.longSubcuenta, _i.posActualPuntoSubcuentaAnt);
				_i.bloqueoSubcuenta = false;
			}
			break;
		}
		case "codsubcuentavale": {
			if (!_i.bloqueoSubcuenta) {
				_i.bloqueoSubcuenta = true;
				_i.posActualPuntoSubcuentaAnt = flcontppal.iface.pub_formatearCodSubcta(this, "fdbCodSubcuentaVale", _i.longSubcuenta, _i.posActualPuntoSubcuentaAnt);
				_i.bloqueoSubcuenta = false;
			}
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
