/***************************************************************************
                             pr_ia_genetico.qs
                             -------------------
    begin                : vie may 23 2008
    copyright            : (C) 2008 by InfoSiAL S.L.
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
  function interna( context )                         { this.ctx = context; }
  function init()                                     { this.ctx.interna_init(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
    var pbWorkDir, pbEjecutar; 
    var tdbActores, fdbWorkDir;
    function oficial( context )                       { interna( context ); }
    
    function getWorkDir()                             { this.ctx.oficial_getWorkDir(); }
    function evolucionar()                            { this.ctx.oficial_evolucionar(); }
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
  this.iface.pbWorkDir = this.child( "pbWorkDir" );
  this.iface.pbEjecutar = this.child( "pbEjecutar" );
  this.iface.tdbActores = this.child( "tdbActores" );
  this.iface.fdbWorkDir = this.child( "fdbWorkDir" );
  
  connect( this.iface.pbWorkDir, "clicked()", this, "iface.getWorkDir()" );
  connect( this.iface.pbEjecutar, "clicked()", this, "iface.evolucionar()" );
  
  this.iface.tdbActores.cursor().setMainFilter( "director='true'" );
  this.iface.tdbActores.refresh();
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_getWorkDir() {
  var workDir = this.iface.fdbWorkDir.value();
  workDir = FileDialog.getExistingDirectory( workDir, "Seleccionar" );
  if ( workDir )
    this.iface.fdbWorkDir.setValue( workDir );
}

function oficial_evolucionar() {
  var cur = this.cursor();

  if ( cur.commitBuffer() ) {
    var idActores = this.iface.tdbActores.primarysKeysChecked();
    var count = ( idActores == undefined ? 0 : idActores.length );
    var util = new FLUtil();
    
    if ( !count ) {
      MessageBox.critical( util.translate( "scripts", "Hay que seleccionar al menos un actor" ), MessageBox.Ok, MessageBox.NoButton );
      return;
    }
    
    var actores = new Array( count );
    for ( var i = 0; i < count; ++i )
      actores[i] = util.sqlSelect( "pr_ia_actores", "codact", "idact=" + idActores[i] );
      
    flprodia.iface.pub_setWorkDir( cur.valueBuffer( "workdir" ) );
    flprodia.iface.pub_genetico( cur.valueBuffer( "codproc" ), cur.valueBuffer( "iteraciones" ),
                                 cur.valueBuffer( "individuos" ), actores );
       
    MessageBox.information( util.translate( "scripts", "Cálculo finalizado" ), MessageBox.Ok );
  }
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
