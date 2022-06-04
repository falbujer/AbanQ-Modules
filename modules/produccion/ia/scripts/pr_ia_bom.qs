/***************************************************************************
                              pr_ia_bom.qs
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
  function main()                                     { this.ctx.interna_main(); }
  function init()                                     { this.ctx.interna_init(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
    var pbXml, pbBom;
    var lblBom, fdbXml, tdbObjetivos; 
    function oficial( context )                       { interna( context ); }
    
    function cargarXml()                              { this.ctx.oficial_cargarXml(); }
    function dibujarBom()                             { this.ctx.oficial_dibujarBom(); }
    function dibujarBomNodo( pic, nodo, objetivos, rleft, rtop, anchoFila, anchoColumna, contenidoTabla )
      { return this.ctx.oficial_dibujarBomNodo( pic, nodo, objetivos, rleft, rtop, anchoFila, anchoColumna, contenidoTabla ); }
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
  this.iface.pbXml = this.child( "pbXml" );
  this.iface.pbBom = this.child( "pbBom" );
  this.iface.lblBom = this.child( "lblBom" );
  this.iface.fdbXml = this.child( "fdbXml" );
  this.iface.tdbObjetivos = this.child( "tdbObjetivos" );
  
  connect( this.iface.pbXml, "clicked()", this, "iface.cargarXml()" );
  connect( this.iface.pbBom, "clicked()", this, "iface.dibujarBom()" );
}

function interna_main() {
  var f = new FLFormSearchDB( "pr_ia_bom" );
  var cursor = f.cursor();

  cursor.select();
  if ( !cursor.first() )
      cursor.setModeAccess( cursor.Insert );
  else
      cursor.setModeAccess( cursor.Edit );

  f.setMainWidget();
  if ( cursor.modeAccess() == cursor.Insert )
      f.child( "pushButtonCancel" ).setDisabled( true );
  cursor.refreshBuffer();
  var commitOk = false;
  var acp;
  cursor.transaction( false );
  while ( !commitOk ) {
    acpt = false;
    f.obj().showMaximized();
    f.exec( "idbom" );
    acpt = f.accepted();
    if ( !acpt ) {
      if ( cursor.rollback() )
        commitOk = true;
    } else {
      if ( cursor.commitBuffer() ) {
        cursor.commit();
        commitOk = true;
      }
    }
  }
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_cargarXml() {
  var fileName = FileDialog.getOpenFileName( "*.xml", "Seleccionar" ); 
  if ( fileName )
    this.iface.fdbXml.setValue( File.read( fileName ) );
}

function oficial_dibujarBom() {
  var cur = this.cursor();

  if ( cur.commitBuffer() ) {
    var idObjetivos = this.iface.tdbObjetivos.primarysKeysChecked();
    var count = ( idObjetivos == undefined ? 0 : idObjetivos.length );
    var util = new FLUtil();
    
    if ( !count ) {
      MessageBox.critical( util.translate( "scripts", "Hay que seleccionar al menos un objetivo" ), MessageBox.Ok, MessageBox.NoButton );
      return;
    }
    
    var dom = new FLDomDocument();
    dom.setContent( cur.valueBuffer( "xml" ) );
    
    var nodo = dom.createElement( "CromosomaXY" );
    nodo.appendChild( dom.firstChild().toElement() );

     if ( nodo.firstChild().isNull() )
      return;
     
    nodo = nodo.firstChild();
    
    flprodia.iface.pub_establecerNecesidadesNetas( nodo );
    flprodia.iface.pub_establecerCostesTiemposTotales( nodo );
    flprodia.iface.pub_establecerCostesTotales( nodo );
    flprodia.iface.pub_establecerCostesTiemposIndividuales( nodo );
    
    var objetivos = new Array( count );
    var labelObjetivos = new Array( count );
    for ( var i = 0; i < count; ++i ) {
      objetivos[i] = util.sqlSelect( "pr_ia_objetivos", "codobj", "idobj=" + idObjetivos[i] );
      labelObjetivos[i] = util.sqlSelect( "pr_ia_objetivos", "descripcion", "idobj=" + idObjetivos[i] );
    }
      
    var pic = new Picture();
    var font = new Font();
    
    pic.begin();
    
    font.pointSize = 7;
    font.family = "Sans";
  
    pic.setFont( font );
    
    var despX = 80;
    var despY = 10;
    var pix = new Pixmap();
    var clr = new Color();
    var devSize = this.iface.lblBom.size;
    var devRect = this.iface.lblBom.rect;
    var retRect = new Rect( despX, despY, devRect.width - despX - 10, devRect.height - despY - 10 );
    var tramos = Math.ceil( parseFloat( nodo.attribute( "tramo" ) ) + 1 );
    var anchoFila = retRect.height / count;
    var anchoColumna = retRect.width / tramos;
    
    clr.setRgb( 0, 0, 0 );
    pic.setPen( clr, 1 );
    
    for ( var i = 0; i < count; ++i )
      pic.drawText( 1, ( i * anchoFila ) + ( anchoFila / 2 ) + despY, labelObjetivos[i] );
    for ( var i = 0; i < tramos; ++i )
      pic.drawText( ( i * anchoColumna ) + ( anchoColumna / 2 ) + despX, count * anchoFila + despY + 10, "Dia " + i.toString() );
      
    clr.setRgb( 200, 200, 200 );
    pic.setPen( clr, 1 );
    
    pic.drawRect( retRect );

    for ( var i = 1; i < count; ++i )
      pic.drawLine( retRect.left, ( i * anchoFila ) + despY, retRect.right, ( i * anchoFila ) + despY );
    for ( var i = 1; i < tramos; ++i )
      pic.drawLine( ( i * anchoColumna ) + despX, retRect.top, ( i * anchoColumna ) + despX, retRect.bottom );
    
    var contenidoTabla = new Array( 2 );
    for( var i = 0; i < 2; ++i ) {
      contenidoTabla[i] = new Array( count );
      for ( var j = 0; j < count; ++j ) {
        contenidoTabla[i][j] = new Array( tramos );
        for( var k = 0; k < tramos; ++k )
          contenidoTabla[i][j][k] = "";
      }
    }
    
    clr.setRgb( 0, 0, 0 );
    pic.setPen( clr, 1 );
    
    this.iface.dibujarBomNodo( pic, nodo, objetivos, retRect.left, retRect.top, anchoFila, anchoColumna, contenidoTabla );
      
    pix.resize( devSize );
    clr.setRgb( 255, 255, 255 );
    pix.fill( clr );
    
    pix = pic.playOnPixmap( pix );
    this.iface.lblBom.pixmap = pix;
  
    pic.end();
  }
}

function oficial_dibujarBomNodo( pic, nodo, objetivos, rleft, rtop, anchoFila, anchoColumna, contenidoTabla ) {
  if ( nodo ) {
    var hijos = nodo.childNodes(), hijo;
    var count = ( hijos ? hijos.count() : 0 );
    var tramo, necNeta, producido, txt = "", x, y;
    
    for ( var i = 0; i < count; ++i ) {
      hijo = hijos.item( i ).toElement();
      contenidoTabla = this.iface.dibujarBomNodo( pic, hijo, objetivos, rleft, rtop, anchoFila, anchoColumna, contenidoTabla );

      if ( hijo.nodeName() == "Objetivo" ) {
        var idx, nombre = hijo.attribute( "nombre" ).upper();
        for( var j = 0; j < objetivos.length; ++j )
          if ( objetivos[j].upper() == nombre )
            idx = j;
        if ( idx != undefined ) {
          necNeta = parseFloat( hijo.attribute( "necNeta" ) );
          tramo = Math.floor( parseFloat( hijo.attribute( "tramo" ) ) );
          if ( tramo < 0 )
              continue;

          txt = contenidoTabla[0][idx][tramo];
          if ( !txt.isEmpty() )
            txt += "+";
          contenidoTabla[0][idx][tramo] = txt + necNeta.toString();
          txt = "NB:" + parseInt( hijo.attribute( "necBruta" ) ).toString();
          x = rleft + tramo * anchoColumna;
          y = rtop + idx * anchoFila;
          pic.eraseRect( x + 2, y + 1, anchoColumna - 3, anchoFila * 0.5 - 1 );
          pic.drawText( x + 2, y + 10, txt );
          txt = "NN:" + contenidoTabla[0][idx][tramo];
          pic.drawText( x + 2, y + 25, txt );
        }
      }
      
      if ( hijo.nodeName() == "Tarea" ) {
        var idx, nombre = hijo.attribute( "objetivo" ).upper();
        for( var j = 0; j < objetivos.length; ++j )
        if ( objetivos[j].upper() == nombre )
          idx = j;
        if ( idx != undefined ) {
          var costeI = parseFloat( hijo.attribute( "costeTiempoIndividual" ) );
          if ( costeI > 0 ) {
            tramo = Math.floor( parseFloat( hijo.attribute( "tramo" ) ) );
            if ( tramo < 0 )
              continue;
            producido = parseFloat( hijo.attribute( "producido" ) );

            if ( contenidoTabla )
              txt = contenidoTabla[1][idx][tramo];
            if ( !txt.isEmpty() )
              txt += "+";
            contenidoTabla[1][idx][tramo] = txt + producido.toString();
            txt = hijo.attribute( "nombre" ) + ":" + contenidoTabla[1][idx][tramo];
            x = rleft + tramo * anchoColumna;
            y = rtop + idx * anchoFila + anchoFila * 0.5;
            pic.eraseRect( x + 2, y + 1, anchoColumna - 3, anchoFila * 0.5 - 1 );
            pic.drawText( x + 2, y + 12, txt );
          }
        }
      }
    }
  }
  
  return contenidoTabla;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
