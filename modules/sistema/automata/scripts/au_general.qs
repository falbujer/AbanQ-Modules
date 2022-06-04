/***************************************************************************
                 au_general.qs  -  description
                             -------------------
    begin                : mar may 21 2013
    copyright            : (C) 2013 by InfoSiAL S.L.
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
	var ctx;
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
	function oficial( context ) { interna( context ); }
	function seleccionarDirectorio() {
		this.ctx.oficial_seleccionarDirectorio();
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
	var f = new FLFormSearchDB("au_general");
	var cursor = f.cursor();

	cursor.select();
	if (!cursor.first())
	{
		cursor.setModeAccess(cursor.Insert);
	}
	else
	{
		cursor.setModeAccess(cursor.Edit);
	}

	f.setMainWidget();
	if (cursor.modeAccess() == cursor.Insert)
	{
		f.child("pushButtonCancel").setDisabled(true);
	}
	cursor.refreshBuffer();

	var commitOk = false;
	var acpt;
	cursor.transaction(false);

	while (!commitOk)
	{
		acpt = false;
		f.exec("id");
		acpt = f.accepted();
		if (!acpt)
		{
			if (cursor.rollback())
			{
				commitOk = true;
			}
		}
		else
		{
			if (cursor.commitBuffer())
			{
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

	connect (this.child("pbnDirectorio"), "clicked()", _i, "seleccionarDirectorio");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_seleccionarDirectorio()
{
	var _i = this.iface;
	var cursor = this.cursor();

	var directorio = FileDialog.getExistingDirectory("", "Directorio de log");
	if (!directorio)
	{
		sys.warnMsgBox(sys.translate("No existe el directorio seleccionado."));
	}
	else
	{
		cursor.setValueBuffer("directoriolog", directorio);
	}
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
