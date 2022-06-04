/***************************************************************************
                             pr_ia_procesos.qs
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
    var pbGrafica, fdbXml, lblGrafica;
    var pbEjecutar, tdbActores;
    function oficial( context )                       { interna( context ); }
    
    function dibujarGrafica()                         { this.ctx.oficial_dibujarGrafica(); }
    function ejecutarActores()                        { this.ctx.oficial_ejecutarActores(); }
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
  this.iface.pbGrafica = this.child( "pbGrafica" );
  this.iface.fdbXml = this.child( "fdbXml" );
  this.iface.lblGrafica = this.child( "lblGrafica" );
  this.iface.pbEjecutar = this.child( "pbEjecutar" );
  this.iface.tdbActores = this.child( "tdbActores" );
  
  connect( this.iface.pbGrafica, "clicked()", this, "iface.dibujarGrafica()" );
  connect( this.iface.pbEjecutar, "clicked()", this, "iface.ejecutarActores()" );
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_dibujarGrafica() {
  var cur = this.cursor();

  if ( cur.commitBuffer() ) {
    var pic = new Picture();
    var devSize = this.iface.lblGrafica.size;
    var font = new Font();
    
    flprodia.iface.pub_setGrid( 30 );
    flprodia.iface.pub_setOrig( 50, -devSize.height, -1 );
    flprodia.iface.pub_setPic( pic );
    
    pic.begin();

    font.pointSize = 7;
    font.family = "Sans";
  
    pic.setFont( font );
    
    flprodia.iface.pub_dibujarProceso( cur.valueBuffer( "codproc" ) );

    var pix = new Pixmap();
    var clr = new Color();
  
    pix.resize( devSize );
    clr.setRgb( 255, 255, 255 );
    pix.fill( clr );
    
    pix = pic.playOnPixmap( pix );
    this.iface.lblGrafica.pixmap = pix;
  
    pic.end();
  }
}

function oficial_ejecutarActores() {
  var cur = this.cursor();

  if ( cur.commitBuffer() ) {
    var arbCostes = flprodia.iface.pub_arbolProceso( cur.valueBuffer( "codproc" ) );
    var actores = this.iface.tdbActores.primarysKeysChecked();
    var util = new FLUtil();
    
    for ( var i = 0; i < actores.length; ++i )
      arbCostes = flprodia.iface.pub_arbolCostes( arbCostes, util.sqlSelect( "pr_ia_actores", "codact", "idact=" + actores[i] ) );
      
    var pic = new Picture();
    var devSize = this.iface.lblGrafica.size;
    var font = new Font();
    
    flprodia.iface.pub_setGrid( 30 );
    flprodia.iface.pub_setOrig( 50, 30 - devSize.height, -1 );
    flprodia.iface.pub_setPic( pic );
    
    pic.begin();

    font.pointSize = 7;
    font.family = "Sans";
  
    pic.setFont( font );

    flprodia.iface.pub_dibujarArbol( arbCostes );
     
    var pix = new Pixmap();
    var clr = new Color();
  
    pix.resize( devSize );
    clr.setRgb( 255, 255, 255 );
    pix.fill( clr );
    
    pix = pic.playOnPixmap( pix );
    this.iface.lblGrafica.pixmap = pix;
  
    pic.end();
  }
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
