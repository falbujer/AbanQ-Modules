/***************************************************************************
                              pr_ia_gantt.qs
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
    var pbXml, pbGantt;
    var lblGantt, fdbXml, tdbActores; 
    function oficial( context )                       { interna( context ); }
    
    function cargarXml()                              { this.ctx.oficial_cargarXml(); }
    function dibujarGantt()                           { this.ctx.oficial_dibujarGantt(); }
    function dibujarGanttNodo( pic, nodo, actores, rectBase, tramos )
                                                  { this.ctx.oficial_dibujarGanttNodo( pic, nodo, actores, rectBase, tramos ); }
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
  this.iface.pbGantt = this.child( "pbGantt" );
  this.iface.lblGantt = this.child( "lblGantt" );
  this.iface.fdbXml = this.child( "fdbXml" );
  this.iface.tdbActores = this.child( "tdbActores" );
  
  connect( this.iface.pbXml, "clicked()", this, "iface.cargarXml()" );
  connect( this.iface.pbGantt, "clicked()", this, "iface.dibujarGantt()" );
  
  var curActores =  this.iface.tdbActores.cursor();
  var pkCurActores = curActores.primaryKey();
  
  curActores.setMainFilter( "director<>'true'" );
  curActores.first( false );
  do {
      this.iface.tdbActores.setPrimaryKeyChecked( curActores.valueBuffer( pkCurActores ), true );
  } while( curActores.next( false ) );
  
  this.iface.tdbActores.refresh();
}

function interna_main() {
  var f = new FLFormSearchDB( "pr_ia_gantt" );
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
    f.exec( "idgantt" );
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

function oficial_dibujarGantt() {
  var cur = this.cursor();

  if ( cur.commitBuffer() ) {
    var idActores = this.iface.tdbActores.primarysKeysChecked();
    var count = ( idActores == undefined ? 0 : idActores.length );
    var util = new FLUtil();
    
    if ( !count ) {
      MessageBox.critical( util.translate( "scripts", "Hay que seleccionar al menos un actor" ), MessageBox.Ok, MessageBox.NoButton );
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
  
    var actores = new Array( count );
    var labelActores = new Array( count );
    for ( var i = 0; i < count; ++i ) {
      actores[i] = util.sqlSelect( "pr_ia_actores", "codact", "idact=" + idActores[i] );
      labelActores[i] = util.sqlSelect( "pr_ia_actores", "descripcion", "idact=" + idActores[i] );
    }
      
    var pic = new Picture();
    var font = new Font();
    
    pic.begin();
    
    font.pointSize = 8;
    font.family = "Sans";
  
    pic.setFont( font );
    
    var despX = 60;
    var despY = 10;
    var pix = new Pixmap();
    var clr = new Color();
    var devSize = this.iface.lblGantt.size;
    var devRect = this.iface.lblGantt.rect;
    var retRect = new Rect( despX, despY, devRect.width - despX - 10, devRect.height - despY - 10 );
    var tramos = Math.ceil( parseFloat( nodo.attribute( "tramo" ) ) + 1 );
    var anchoFila = retRect.height / count;
    var anchoColumna = retRect.width / tramos;
    
    clr.setRgb( 0, 0, 0 );
    pic.setPen( clr, 1 );
    
    pic.drawText( 1, retRect.top, "COSTE:" );
    pic.drawText( 1, retRect.top + 18, nodo.attribute( "costeTotal" ) );
    
    for ( var i = 0; i < count; ++i )
      pic.drawText( 1, ( i * anchoFila ) + ( anchoFila / 2 ) + despY, labelActores[i] );
    for ( var i = 0; i < tramos; ++i )
      pic.drawText( ( i * anchoColumna ) + ( anchoColumna / 2 ) + despX, count * anchoFila + despY + 10, "Dia " + i.toString() );
      
    clr.setRgb( 200, 200, 200 );
    pic.setPen( clr, 1 );
    
    pic.drawRect( retRect );

    for ( var i = 1; i < count; ++i )
      pic.drawLine( retRect.left, ( i * anchoFila ) + despY, retRect.right, ( i * anchoFila ) + despY );
    for ( var i = 1; i < tramos; ++i )
      pic.drawLine( ( i * anchoColumna ) + despX, retRect.top, ( i * anchoColumna ) + despX, retRect.bottom );
      
    this.iface.dibujarGanttNodo( pic, nodo, actores, retRect, tramos );
      
    pix.resize( devSize );
    clr.setRgb( 255, 255, 255 );
    pix.fill( clr );
    
    pix = pic.playOnPixmap( pix );
    this.iface.lblGantt.pixmap = pix;
  
    pic.end();
  }
}

function oficial_dibujarGanttNodo( pic, nodo, actores, rectBase, tramos ) {
  if ( nodo  ) {
    if ( nodo.nodeName() == "Tarea" ) {
      var costeI = parseFloat( nodo.attribute( "costeTiempoIndividual" ) );
      if ( costeI < 0 )
        return;
      
      var clr = new Color();
      var tramo = parseFloat( nodo.attribute( "tramo" ) );
      var idx, actor = nodo.attribute( "actor" ).upper();

      for( var i = 0; i < actores.length; ++i )
        if ( actores[i].upper() == actor )
          idx = i;

      if ( idx == undefined )
        return;
      
      var anchoFila = rectBase.height / actores.length;
      var anchoColumna = rectBase.width / tramos;
      var tramoFloor = Math.floor( tramo );
      var deltaY = tramo - tramoFloor;
      
      var round = "%1", txt;
      var x = rectBase.left + tramoFloor * anchoColumna;
      var rtop = rectBase.top + idx * anchoFila;
      var y = rtop + deltaY * anchoFila;
      var rect, font = new Font(), porcionesDibujadas = 0;
        
      font.pointSize = 8;
      pic.setFont( font );
      clr.setRgb( 10, 10, 170 );
      pic.setPen( clr, 1 );
      
      while ( costeI > 0 ) {
        if ( porcionesDibujadas ) {
          pic.setPen( clr, 3, 3 );
          pic.drawLine( rect.left, rect.bottom, rect.right, rect.bottom );
          clr.setRgb( 170, 10, 10 );
          pic.setPen( clr, 1 );
        }
        costeI = costeI + deltaY - 1;
        if ( costeI >= 0 ) {
          rect = new Rect( x + 1, y + 1, anchoColumna - 1, anchoFila * ( 1 - deltaY ) - 1 );
          x += anchoColumna;
          deltaY = 0;
          y = rtop;
        } else
          rect = new Rect( x + 1, y + 1, anchoColumna - 1, anchoFila * ( 1 - deltaY + costeI ) - 1 );
        pic.drawRect( rect );
        txt = nodo.attribute( "nombre" ) + ": " + nodo.attribute( "objetivo" );
        pic.drawText( rect, 0x0001 | 0x0020, txt );
        pic.drawText( rect, 0x0002 | 0x0010, "LOTE: " + nodo.attribute( "producido" ) );
        /*if ( rect.height > 17 ) {
          txt = "T:" + round.argDec( tramo, 4, "f", 2 );
          pic.drawText( rect, 0x0001 | 0x0080, txt );
          txt = "TI:" + round.argDec( calcularCosteTiempoIndividual( nodo ), 4, "f", 2 );
          txt += ", TF:" + round.argDec( parseFloat( nodo.attribute( "costeTiempoFijo" ) ), 4, "f", 2 );
          pic.drawText( rect, 0x0002 | 0x0010, txt );
        }*/
        if ( porcionesDibujadas ) {
          pic.setPen( clr, 3, 3 );
          pic.drawLine( rect.left, rect.top, rect.right, rect.top ); 
        }
        ++porcionesDibujadas;
      }
    }
    var hijos = nodo.childNodes();
    if ( hijos ) {
      var hijo, i;
      for( i = 0; i < hijos.count(); ++i ) {
        hijo = hijos.item( i ).toElement();
        this.iface.dibujarGanttNodo( pic, hijo, actores, rectBase, tramos );
      } 
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
