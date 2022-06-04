/***************************************************************************
                                flprodia.qs
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
	function interna( context )                          { this.ctx = context; }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
  var pic, clr, grid, workDir;
  var coordOrigX, coordOrigY, defDeltaY;
  var constMaxTramo, util;

  function oficial( context )                         { interna( context ); }
  function init()                                     { this.ctx.oficial_init(); }
    
  function setGrid( grid )                            { this.ctx.oficial_setGrid( grid ); }
  function setOrig( cx, cy, dy )                      { this.ctx.oficial_setOrig( cx, cy, dy ); }
  function setPic( pic )                              { this.ctx.oficial_setPic( pic ); }
  function setWorkDir( workDir )                      { this.ctx.oficial_setWorkDir( workDir ); }
  
  function xmlObjetivo( codObj )                      { return this.ctx.oficial_xmlObjetivo( codObj ); }
  function nodoPoint( nodo )                          { return this.ctx.oficial_nodoPoint( nodo ); }
  function setNodoPoint( nodo, point )                { this.ctx.oficial_setNodoPoint( nodo, point ); }
  function nodoCoord( nodo, origX, origY )            { return this.ctx.oficial_nodoCoord( nodo, origX, origY ); }
  
  function dibujarEnlaceBottom( padre, hijo )         { this.ctx.oficial_dibujarEnlaceBottom( padre, hijo ); }
  function dibujarEnlaceTop( padre, hijo )            { this.ctx.oficial_dibujarEnlaceTop( padre, hijo ); }
  function dibujarNodo( nodo, deltaY )                { this.ctx.oficial_dibujarNodo( nodo, deltaY ); }
  
  function explosionarComposicion( objetivo )         { return this.ctx.oficial_explosionarComposicion( objetivo ); }
  function dibujarComposicion( objetivo )             { this.ctx.oficial_dibujarComposicion( objetivo ); }
  
  function xmlProceso( codProc )                      { return this.ctx.oficial_xmlProceso( codProc ); }
  function xmlActor( codAct )                         { return this.ctx.oficial_xmlActor( codAct ); }
  
  function calcularTramoEfectivo( nodo )                  { return this.ctx.oficial_calcularTramoEfectivo( nodo ); }
  function compararTramosEfectivos( nodoA, nodoB )        { return this.ctx.oficial_compararTramosEfectivos( nodoA, nodoB ); }
  function compararTramos( nodoA, nodoB )                 { return this.ctx.oficial_compararTramos( nodoA, nodoB ); }
  function calcularAlcanceEfectivo( nodo )                { return this.ctx.oficial_calcularAlcanceEfectivo( nodo ); }
  function compararAlcancesEfectivos( nodoA, nodoB )      { return this.ctx.oficial_compararAlcancesEfectivos( nodoA, nodoB ); }
  function listaTareasOrdenadasPorAlcanceEfectivo( nodo ) { return this.ctx.oficial_listaTareasOrdenadasPorAlcanceEfectivo( nodo ); }
  function listaTareasOrdenadasPorTramo( nodo )           { return this.ctx.oficial_listaTareasOrdenadasPorTramo( nodo ); }
  function listaObjetivosOrdenadosPorTramo( nodo )        { return this.ctx.oficial_listaObjetivosOrdenadosPorTramo( nodo ); }
  function listaNodosOrdenadosPorTramo( nodo )            { return this.ctx.oficial_listaNodosOrdenadosPorTramo( nodo ); }
  function indiceDeLiteral( vector, literal )             { return this.ctx.oficial_indiceDeLiteral( vector, literal ); }
  function tareasPrimerNivel( nodo, ignorarActual )       { return this.ctx.oficial_tareasPrimerNivel( nodo, ignorarActual ); }
  function explosionarTareas( nodoObjetivo )              { return this.ctx.oficial_explosionarTareas( nodoObjetivo ); }
  function borrarObjetivosCero( nodo )                    { return this.ctx.oficial_borrarObjetivosCero( nodo ); }
  function balancearProceso( nodo )                       { return this.ctx.oficial_balancearProceso( nodo ); }
  function explosionarProceso( proceso )                  { return this.ctx.oficial_explosionarProceso( proceso ); }
  
  function procesarTarea( estados, estadoActual, nodoCostes ) 
                                                      { return this.ctx.oficial_procesarTarea( estados, estadoActual, nodoCostes ); }
  function ejecutarTarea( tareas, indice, actor, inicializar )
                                                      { return this.ctx.oficial_ejecutarTarea( tareas, indice, actor, inicializar ); }
                                                      
  function ejecutarProceso( nodoProc, actor )             { return this.ctx.oficial_ejecutarProceso( nodoProc, actor ); }
  function calcularNecesidadBruta( nodo )                 { return this.ctx.oficial_calcularNecesidadBruta( nodo ); }
  function calcularCantidadTarea( nodo )                  { return this.ctx.oficial_calcularCantidadTarea( nodo ); }
  function obtenerNecesidadBruta( nodo )                  { return this.ctx.oficial_obtenerNecesidadBruta( nodo ); }
  function establecerNecesidadesBrutas( nodo )            { return this.ctx.oficial_establecerNecesidadesBrutas( nodo ); }
  function calcularCosteTiempoIndividual( nodo )          { return this.ctx.oficial_calcularCosteTiempoIndividual( nodo ); }
  function establecerCostesTiemposIndividuales( nodo )    { return this.ctx.oficial_establecerCostesTiemposIndividuales( nodo ); }
  function calcularCosteTiempoTotal( nodo )               { return this.ctx.oficial_calcularCosteTiempoTotal( nodo ); }
  function establecerCostesTiemposTotales( nodo )         { return this.ctx.oficial_establecerCostesTiemposTotales( nodo ); }
  function calcularCosteTotal( nodo )                     { return this.ctx.oficial_calcularCosteTotal( nodo ); }
  function establecerCostesTotales( nodo )                { return this.ctx.oficial_establecerCostesTotales( nodo ); }
  function calcularTramoSinCapacidad( nodo )              { return this.ctx.oficial_calcularTramoSinCapacidad( nodo ); }
  function establecerTramosSinCapacidad( nodo )           { return this.ctx.oficial_establecerTramosSinCapacidad( nodo ); }
  function establecerAnclaje( nodo, nodoPadre )           { return this.ctx.oficial_establecerAnclaje( nodo, nodoPadre ); }
  function establecerAnclajes( nodo )                     { return this.ctx.oficial_establecerAnclajes( nodo ); }
  function obtenerTramoSinCapacidad( nodo )               { return this.ctx.oficial_obtenerTramoSinCapacidad( nodo ); }
  function actualizarTramoSinCapacidad( nodo, tramoPadre ){ return this.ctx.oficial_actualizarTramoSinCapacidad( nodo, tramoPadre ); }
  function actualizarTramosSinCapacidad( nodo )           { return this.ctx.oficial_actualizarTramosSinCapacidad( nodo ); }
  function calcularNecesidadNeta( nodo )                  { return this.ctx.oficial_calcularNecesidadNeta( nodo ); }
  function establecerNecesidadesNetas( nodo )             { return this.ctx.oficial_establecerNecesidadesNetas( nodo ); }
  function calcularDimLote( nodo )                        { return this.ctx.oficial_calcularDimLote( nodo ); }
  function establecerDimsLotes( nodo )                    { return this.ctx.oficial_establecerDimsLotes( nodo ); }
  
  function establecerProducidoObjetivo( nodo, producido, ignorarActual )
                                                      { return this.ctx.oficial_establecerProducidoObjetivo( nodo, producido, ignorarActual ); }
  function establecerConsumidoObjetivo( nodo, consumido, ignorarActual )
                                                      { return this.ctx.oficial_establecerConsumidoObjetivo( nodo, consumido, ignorarActual ); }
  function establecerProducidoTareas( idsNodos, recursivo )
                                                      { return this.ctx.oficial_establecerProducidoTareas( idsNodos, recursivo ); }
  function establecerProducidoTarea( nodoTarea )
                                                      { return this.ctx.oficial_establecerProducidoTarea( nodoTarea ); }
  function desplazarTramos( nodo, desplazamiento )
                                                      { return this.ctx.oficial_desplazarTramos( nodo, desplazamiento ); }
  function ajustarAlcancesTareas( nodoTareaAnt, nodoTarea )
                                                      { return this.ctx.oficial_ajustarAlcancesTareas( nodoTareaAnt, nodoTarea ); }
  function ajustarCapacidadesTareas( tareas, indice, lastK, actor )
                                                      { return this.ctx.oficial_ajustarCapacidadesTareas( tareas, indice, lastK, actor ); }
                                                      
  function establecerTramosConCapacidad( nodo )           { return this.ctx.oficial_establecerTramosConCapacidad( nodo ); }
  function mutarCromosoma( nodo, actor, iteraciones )     { return this.ctx.oficial_mutarCromosoma( nodo, actor, iteraciones ); }
  function compararAptitudCromosomas( cromoA, cromoB )    { return this.ctx.oficial_compararAptitudCromosomas( cromoA, cromoB ); }
  function cruzarCromosomas( cromoX, cromoY, cromoXY )    { return this.ctx.oficial_cruzarCromosomas( cromoX, cromoY, cromoXY ); }
  function evolucionar( poblacion, actor, iteraciones )   { return this.ctx.oficial_evolucionar( poblacion, actor, iteraciones ); }
  function guardarSolucion( nodo, prefijo )               { return this.ctx.oficial_guardarSolucion( nodo, prefijo ); }
  
  function dibujarProceso( proceso )                      { this.ctx.oficial_dibujarProceso( proceso ); }
  function dibujarArbol( nodo )                           { this.ctx.oficial_dibujarArbol( nodo ); }
  
  function arbolComposicion( objetivo )                   { return this.ctx.oficial_arbolComposicion( objetivo ); }
  function arbolProceso( proceso )                        { return this.ctx.oficial_arbolProceso( proceso ); }
  function arbolCostes( nodo, actor )                     { return this.ctx.oficial_arbolCostes( nodo, actor ); }
  
  function genetico( proceso, iteraciones, individuos, actores )
                                                  { this.ctx.oficial_genetico( proceso, iteraciones, individuos, actores ); }
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends oficial {
  function head( context )                            { oficial ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
  function ifaceCtx( context )                        { head( context ); }
    
  function pub_setGrid( grid )                        { this.setGrid( grid ); }
  function pub_setOrig( cx, cy, dy )                  { this.setOrig( cx, cy, dy ); }
  function pub_setPic( pic )                          { this.setPic( pic ); }
  function pub_setWorkDir( workDir )                  { this.setWorkDir( workDir ); }
  
  function pub_establecerNecesidadesNetas( nodo )           { this.establecerNecesidadesNetas( nodo ); }
  function pub_establecerCostesTiemposTotales( nodo )       { this.establecerCostesTiemposTotales( nodo ); }
  function pub_establecerCostesTotales( nodo )              { this.establecerCostesTotales( nodo ); }
  function pub_establecerCostesTiemposIndividuales( nodo )  { this.establecerCostesTiemposIndividuales( nodo ); }
  
  function pub_dibujarComposicion( objetivo )         { this.dibujarComposicion( objetivo ); }
  function pub_dibujarProceso( proceso )              { this.dibujarProceso( proceso ); }
  function pub_dibujarArbol( nodo )                   { this.dibujarArbol( nodo ); }
  
  function pub_arbolComposicion( objetivo )           { return this.arbolComposicion( objetivo ); }
  function pub_arbolProceso( proceso )                { return this.arbolProceso( proceso ); }
  function pub_arbolCostes( nodo, actor )             { return this.arbolCostes( nodo, actor ); }
  
  function pub_genetico( proceso, iteraciones, individuos, actores )
                                                      { this.genetico( proceso, iteraciones, individuos, actores ); }
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

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_init() {
  this.iface.clr            = new Color();
  this.iface.grid           = 25;
  this.iface.workDir        = "";
  this.iface.coordOrigX     = 40;
  this.iface.coordOrigY     = -600;
  this.iface.defDeltaY      = -1;
  this.iface.constMaxTramo  = 365;
  this.iface.util           = new FLUtil();
}

function oficial_setGrid( grid ) {
  this.iface.grid = grid;
}

function oficial_setOrig( cx, cy, dy ) {
  this.iface.coordOrigX = cx;
  this.iface.coordOrigY = cy;
  this.iface.defDeltaY  = dy;
}

function oficial_setPic( pic ) {
  this.iface.pic = pic;
}

function oficial_setWorkDir( workDir ) {
  this.iface.workDir = workDir;
}

function oficial_xmlObjetivo( codObj ) {
  return this.iface.util.sqlSelect( "pr_ia_objetivos", "xml", "codobj='" + codObj + "'" );
}

function oficial_nodoPoint( nodo ) {
  if ( nodo )
    return new Point( nodo.attribute( "x" ), nodo.attribute( "y" ) );
  return new Point();
}

function oficial_setNodoPoint( nodo, point ) {
  if ( nodo ) {
    nodo.setAttribute( "x", point.x.toString() );
    nodo.setAttribute( "y", point.y.toString() );
  }
}

function oficial_nodoCoord( nodo, origX, origY ) {
  if ( nodo && nodo.isElement() ) {
    var x = origX, y = origY, maxX = origX;
    var elTete = nodo.previousSibling();
    if ( elTete ) {
      elTete = elTete.toElement();
      if ( elTete.nodeName() == "Proceso" || elTete.nodeName() == "Tarea" )
        maxX = this.iface.nodoCoord( elTete, x, y );
      else
        maxX = this.iface.nodoCoord( elTete, maxX, y );
      x = maxX + ( this.iface.grid * 2 );
    }
    var elPeque = nodo.lastChild();
    if ( elPeque ) {
      elPeque = elPeque.toElement();
      if ( elPeque.nodeName() == "Proceso" || elPeque.nodeName() == "Tarea" )
        maxX = this.iface.nodoCoord( elPeque, x, y  + ( this.iface.grid * 1.3 ) );
      else 
        maxX = this.iface.nodoCoord( elPeque, x, y  + ( this.iface.grid * 2 ) );
      var elPequeCoord = this.iface.nodoPoint( elPeque );
      x += ( ( maxX - x ) / 2 );
    }
    this.iface.setNodoPoint( nodo, new Point( x, y ) );
    return ( x > maxX ? x : maxX );
  }
}

function oficial_dibujarEnlaceBottom( padre, hijo ) {
  var orig = new Point( this.iface.nodoPoint( padre ).x + ( this.iface.grid / 2 ), this.iface.nodoPoint( padre ).y + this.iface.grid );
  var dest = new Point( this.iface.nodoPoint( hijo ).x + ( this.iface.grid / 2 ), this.iface.nodoPoint( hijo ).y );
  this.iface.clr.setRgb( 10, 155, 10 );
  this.iface.pic.setPen( this.iface.clr, 1 );
  this.iface.pic.drawLine( orig, dest );
  if ( dest.x < orig.x ) {
    var rect = new Rect( dest.x - this.iface.grid , dest.y - this.iface.grid, this.iface.grid, this.iface.grid + 1 );
    this.iface.pic.drawText( rect, 0x0002 | 0x0020, hijo.attribute( "cantidad" ) );
  } else {
    var rect = new Rect( dest.x, dest.y - this.iface.grid, this.iface.grid, this.iface.grid + 1 );
    this.iface.pic.drawText( rect, 0x0001 | 0x0020, hijo.attribute( "cantidad" ) );
  }
}

function oficial_dibujarEnlaceTop( padre, hijo ) {
  var orig = new Point( this.iface.nodoPoint( padre ).x + ( this.iface.grid / 2 ), -( this.iface.nodoPoint( padre ).y ) );
  var dest = new Point( this.iface.nodoPoint( hijo ).x + ( this.iface.grid / 2 ), -( this.iface.nodoPoint( hijo ).y ) + this.iface.grid );
  this.iface.clr.setRgb( 10, 155, 10 );
  this.iface.pic.setPen( this.iface.clr, 1 );
  this.iface.pic.drawLine( orig, dest );
  if ( dest.x < orig.x ) {
    var rect = new Rect( dest.x - this.iface.grid , dest.y, this.iface.grid, this.iface.grid + 1 );
    this.iface.pic.drawText( rect, 0x0002 | 0x0010, hijo.attribute( "cantidad" ) );
  } else {
    var rect = new Rect( dest.x, dest.y, this.iface.grid, this.iface.grid + 1 );
    this.iface.pic.drawText( rect, 0x0001 | 0x0010, hijo.attribute( "cantidad" ) );
  }
}

function oficial_dibujarNodo( nodo, deltaY ) {
  if ( nodo  ) {
    var hijos = nodo.childNodes(), hijo;
    var count = ( hijos ? hijos.count() : 0 ), i;

    for( i = 0; i < count; ++i ) {
      hijo = hijos.item( i ).toElement();
      this.iface.dibujarNodo( hijo, deltaY )
      if ( deltaY == -1 )
        this.iface.dibujarEnlaceTop( nodo, hijo );
      else
        this.iface.dibujarEnlaceBottom( nodo, hijo );
    }
        
    var coord = this.iface.nodoPoint( nodo );
    var rect = new Rect( coord.x, deltaY * coord.y, this.iface.grid, this.iface.grid );
    
    this.iface.clr.setRgb( 155, 10, 10 );
    this.iface.pic.setPen( this.iface.clr, 1 );
      
    if ( nodo.nodeName() == "Objetivo" ) {
      this.iface.pic.drawRoundRect( rect );
    } else if ( nodo.nodeName() == "Tarea" ) {
      this.iface.clr.setRgb( 10, 10, 155 );
      this.iface.pic.setPen( this.iface.clr, 1 );
      this.iface.pic.drawEllipse( rect );
    } else if ( nodo.nodeName() == "Proceso" ) {
      this.iface.clr.setRgb( 0, 0, 0 );
      this.iface.pic.setPen( this.iface.clr, 2 );
      this.iface.pic.drawEllipse( rect );
    } else
      this.iface.pic.drawEllipse( rect );
    
    if ( nodo.nodeName() == "Proceso" ) {
      var costeTotal = parseFloat( nodo.attribute( "costeTiempoTotal" ) );
      if ( isNaN( costeTotal ) )
        costeTotal = 0;
      var round = "%1";
        this.iface.pic.drawText( rect, 0x0004 | 0x0040, round.argDec( costeTotal, 6, "f", 3 ) );
    }
      
    rect.moveBy( 0, 3 );
    this.iface.pic.drawText( rect, 0x0004 | 0x0010, nodo.attribute( "nombre" ) );
    
    if ( nodo.nodeName() == "Objetivo" || nodo.nodeName() == "Tarea" ) {
      var tramo = parseFloat( nodo.attribute( "tramo" ) );
      if ( isNaN( tramo ) )
        tramo = 0;
      rect.moveBy( 0, this.iface.grid / 2 - 3 ); 
      this.iface.pic.drawText( rect, 0x0004 | 0x0010, tramo );
        
      rect = new Rect( coord.x,  deltaY * coord.y, this.iface.grid / 1.2, this.iface.grid / 2 );
      rect.moveBy( -( this.iface.grid / 1.2 ), 0 );
      this.iface.pic.drawRoundRect( rect );
      var cu = parseFloat( nodo.attribute( "costeTiempoUnidad" ) );
      if ( isNaN( cu ) )
        cu = 0;
      this.iface.pic.drawText( rect, 0x0004 | 0x0040, cu );
      
      rect.moveBy( 0, this.iface.grid / 2 );
      this.iface.pic.drawEllipse( rect );
      var cf = parseFloat( nodo.attribute( "costeTiempoFijo" ) );
      if ( isNaN( cf ) )
        cf = 0;
      this.iface.pic.drawText( rect, 0x0004 | 0x0040, cf );
  
      this.iface.pic.drawLine( coord.x,  deltaY * coord.y + this.iface.grid / 2.2, coord.x + this.iface.grid, deltaY * coord.y + this.iface.grid / 2.2 );
    }
  }
}

function oficial_explosionarComposicion( objetivo ) {
  var nodo = new FLDomElement();
  var xml = this.iface.xmlObjetivo( objetivo );
  
  if ( xml ) {
    var dom = new FLDomDocument();
    dom.setContent( xml );
    nodo = dom.firstChild().toElement();

    var hijos = nodo.childNodes(), hijo;
    var count = ( hijos ? hijos.count() : 0 ), i;
    var newHijo;
      
    for( i = 0; i < count; ++i ) {
      hijo = hijos.item( i ).toElement();
      if ( hijo.nodeName() == "Objetivo" ) {
        var ct = parseFloat( hijo.attribute( "cantidad" ) );
        if ( isNaN( ct ) )
          hijo.setAttribute( "cantidad", "1" );
        if ( ct < 0 )
          continue;
        newHijo = this.iface.explosionarComposicion( hijo.attribute( "nombre" ) );
      }
      if ( newHijo && !newHijo.isNull() ) {
        var newHijos = newHijo.childNodes();
        if ( newHijos ) {
          var j;
          for( j = 0; j < newHijos.count(); ++j )
            hijo.appendChild( newHijos.item( j ).cloneNode() );
        }
      }
    } 
  }
  
  if ( nodo.nodeName() == "Objetivo" ) {
    var ct = parseFloat( nodo.attribute( "cantidad" ) );
    if ( isNaN( ct ) )
      nodo.setAttribute( "cantidad", "1" );
  }
  
  return nodo;
}

function oficial_dibujarComposicion( objetivo ) {
  var nodoInicio = this.iface.explosionarComposicion( objetivo );

  this.iface.nodoCoord( nodoInicio, this.iface.coordOrigX, this.iface.coordOrigY );
  this.iface.dibujarNodo( nodoInicio, this.iface.defDeltaY );
}

function oficial_xmlProceso( codProc ) {
  return this.iface.util.sqlSelect( "pr_ia_procesos", "xml", "codproc='" + codProc + "'" );
}

function oficial_xmlActor( codAct ) {
  return this.iface.util.sqlSelect( "pr_ia_actores", "xml", "codact='" + codAct + "'" );
}

function oficial_calcularTramoEfectivo( nodo ) {
  var tramo = parseFloat( nodo.attribute( "tramo" ) );
  var idNodoAnclado = nodo.attribute( "idNodoAnclado" );
  if ( !idNodoAnclado.isEmpty() ) {
    var nodoAnclado = nodo.nodeFromIdNode( idNodoAnclado );
    if ( nodoAnclado )
      tramo = parseFloat( nodoAnclado.attribute( "tramo" ) );
  }
  return tramo;
}

function oficial_compararTramosEfectivos( nodoA, nodoB ) {
  var tramoA = this.iface.calcularTramoEfectivo( nodoA );
  var tramoB = this.iface.calcularTramoEfectivo( nodoB );
  if ( tramoA == tramoB ) {
    var idNodoAnclaje = nodoA.attribute( "idNodoAnclaje" );
    if ( !idNodoAnclaje.isEmpty() )
      if ( idNodoAnclaje == nodoB.idNode() )
        return -1;
    idNodoAnclaje = nodoB.attribute( "idNodoAnclaje" );
    if ( !idNodoAnclaje.isEmpty() )
      if ( idNodoAnclaje == nodoA.idNode() )
        return 1;
  }
  return tramoA < tramoB ? -1 : tramoA > tramoB ? 1 : 0;
} 

function oficial_compararTramos( nodoA, nodoB ) {
  var tramoA = parseFloat( nodoA.attribute( "tramo" ) );
  var tramoB = parseFloat( nodoB.attribute( "tramo" ) );
  return tramoA < tramoB ? -1 : tramoA > tramoB ? 1 : 0;
} 

function oficial_calcularAlcanceEfectivo( nodo ) {
  if ( nodo.attribute( "anclado" ) == "true" ) {
    var nodoAnclaje = nodo.nodeFromIdNode( nodo.attribute( "idNodoAnclaje" ) );
    if ( nodoAnclaje )
      return parseFloat( nodoAnclaje.attribute( "alcance" ) );
  }
  return parseFloat( nodo.attribute( "alcance" ) );
}

function oficial_compararAlcancesEfectivos( nodoA, nodoB ) {
  var alcanceA = this.iface.calcularAlcanceEfectivo( nodoA );
  var alcanceB = this.iface.calcularAlcanceEfectivo( nodoB );
  if ( alcanceA == alcanceB )
    return this.iface.compararTramosEfectivos( nodoA, nodoB );
  return alcanceA < alcanceB ? -1 : 1;
}

function oficial_listaTareasOrdenadasPorAlcanceEfectivo( nodo ) {
  var lista;
  var hijos = nodo.elementsByTagName( "Tarea" );
  var count = ( hijos ? hijos.count() : 0 );
  if ( count ) {
    lista = new Array( count );
    for ( var i = 0; i < count; ++i )
        lista[ i ] = hijos.item( i ).toElement();
      lista.sort( this.iface.compararAlcancesEfectivos );
  }
  return lista;
}

function oficial_listaTareasOrdenadasPorTramo( nodo ) {
  var lista;
  if ( nodo ) {
    var hijos = nodo.elementsByTagName( "Tarea" );
    var count = ( hijos ? hijos.count() : 0 ), i;
    
    if ( count ) {
      lista = new Array( count );
      for ( i = 0; i < count; ++i )
        lista[ i ] = hijos.item( i ).toElement();
      lista.sort( this.iface.compararTramos );
    }
  }
  return lista;
}

function oficial_listaObjetivosOrdenadosPorTramo( nodo ) {
  var lista;
  if ( nodo ) {
    var hijos = nodo.elementsByTagName( "Objetivo" );
    var count = ( hijos ? hijos.count() : 0 ), i;
    
    if ( count ) {
      lista = new Array( count );
      for ( i = 0; i < count; ++i )
        lista[ i ] = hijos.item( i ).toElement();
      lista.sort( this.iface.compararTramos );
    }
  }
  return lista;
}

function oficial_listaNodosOrdenadosPorTramo( nodo ) {
  var lista;
  if ( nodo ) {
    var listaT = nodo.elementsByTagName( "Tarea" );
    var countT =( listaT ? listaT.count() : 0 );
    var listaO = nodo.elementsByTagName( "Objetivo" );
    var countO =( listaO ? listaO.count() : 0 );
    var count = countT + countO;

    if ( count ) {
      var i, j = 0;
      lista = new Array( count );

      for( i = 0; i < countO; ++i ) {
        lista[ j ] = listaO.item( i ).toElement();
        ++j;
      }
      for( i = 0; i < countT; ++i ) {
        lista[ j ] = listaT.item( i ).toElement();
        ++j;
      }
      lista.sort( this.iface.compararTramos );
    }
  }
  return lista;
}

function oficial_indiceDeLiteral( vector, literal ) {
  var ret = -1;
  for( var i = 0; i < vector.length; ++i )
    if ( vector[i] == literal )
      return i;
  return ret; 
}

function oficial_tareasPrimerNivel( nodo, ignorarActual ) {
  if ( !nodo )
    return "";
  
  var idsNodos = "", incluirAnclados = false;
  
  if ( !ignorarActual && nodo.nodeName() == "Tarea" ) {
    idsNodos = nodo.idNode();
    incluirAnclados = true;
  }

  var idNodo;
  var hijos = nodo.childNodes(), hijo;
  var count = ( hijos ? hijos.count() : 0 ), i;
  for ( i = 0; i < count; ++i ) {
    hijo = hijos.item( i ).toElement();
    if ( hijo.attribute( "anclado" ) != "true" ) {
      if ( incluirAnclados )
        continue;
    } else if ( !incluirAnclados && nodo.nodeName() == "Tarea" )
      continue;
    idNodo = this.iface.tareasPrimerNivel( hijo, false );
    if ( !idNodo.isEmpty() ) {
      if ( idsNodos.isEmpty() )
        idsNodos += idNodo;
      else
        idsNodos += "#" + idNodo;
    }
  } 
  return idsNodos;
}

function oficial_explosionarTareas( nodoObjetivo ) {
  if ( nodoObjetivo ) {
    var ct = parseFloat( nodoObjetivo.attribute( "cantidad" ) );
    if ( ct < 0 )
      return nodoObjetivo;
      
    var hijos = nodoObjetivo.childNodes();
    var objetivo = nodoObjetivo.attribute( "nombre" );
    var xml = this.iface.xmlProceso( objetivo );
    var nodoProc = new FLDomElement();
    
    if ( xml ) {
      var dom = new FLDomDocument();
      dom.setContent( xml );
      nodoProc = dom.firstChild().toElement();
    }
    
    if ( hijos ) {
      var hijo, newHijo, i;
      for( i = 0; i < hijos.count(); ++i ) {
        hijo = hijos.item( i ).toElement();
        newHijo = this.iface.explosionarTareas( hijo );
        if ( !nodoProc.isNull() )
          nodoProc.appendChild( newHijo.cloneNode() );
      }
      if ( !nodoProc.isNull() ) {
        while( hijos.count() )
          nodoObjetivo.removeChild( nodoObjetivo.firstChild() );
        nodoObjetivo.appendChild( nodoProc.cloneNode() );
      } 
    } else if ( !nodoProc.isNull() )
      nodoObjetivo.appendChild( nodoProc.cloneNode() );
  }
  
  return nodoObjetivo;
}

function oficial_borrarObjetivosCero( nodo ) {
  if ( nodo && !nodo.isNull() ) {
    var hijo = nodo.firstChild();
    while ( hijo && !hijo.isNull() ) {
      hijo = hijo.toElement();
      var ctH = 1;
      if ( hijo.nodeName() == "Objetivo" ) {
        ctH = parseFloat( hijo.attribute( "cantidad" ) );
        if ( isNaN( ctH ) ) ctH = 1;
      }
      if ( ctH == 0 )
        nodo.removeChild( hijo );
      else
        this.iface.borrarObjetivosCero( hijo );
      hijo = hijo.nextSibling();
    }
  }
}

function oficial_balancearProceso( nodo ) {
  if ( nodo ) {
    var hijos = nodo.childNodes();
    var hijo, i, count = ( hijos ? hijos.count() : 0 );
    if ( hijos ) {
      for( i = 0; i < count; ++i ) {
        hijo = hijos.item( i ).toElement();
        this.iface.balancearProceso( hijo );
      }
    } else if ( nodo.nodeName() == "Objetivo" ) {
      var ct = parseFloat( nodo.attribute( "cantidad" ) );
      if ( isNaN( ct ) ) {
        nodo.setAttribute( "cantidad", "1" );
        ct = 1;
      }
      if ( ct < 0 )
        return;

      this.iface.explosionarTareas( nodo );
      this.iface.balancearProceso( nodo );
      
      var nombre = nodo.attribute( "nombre" );    
      var itProc = nodo.parentNode();
      if ( itProc ) itProc = itProc.toElement();
      while( itProc && !itProc.isNull() && itProc.nodeName() != "Proceso" ) {
        itProc = itProc.toElement();
        itProc = itProc.parentNode();
      }
      if ( !itProc.isNull() ) {
        var hombreH, ctH;
        hijos = itProc.childNodes();
        count = ( hijos ? hijos.count() : 0 );
        for ( i = 0; i < count; ++i ) {
          hijo = hijos.item( i ).toElement();
          if ( hijo.nodeName() == "Objetivo") {
            nombreH = hijo.attribute( "nombre" );
            if ( nombre == nombreH ) {
              ctH = parseFloat( hijo.attribute( "cantidad" ) );
              if ( isNaN( ctH ) ) ctH = 0;
              ctH -= ct;  
              hijo.setAttribute( "cantidad", ctH.toString() );
            }
          }
        }
      }
    }
    
    this.iface.borrarObjetivosCero( nodo );
  }
}

function oficial_explosionarProceso( proceso ) {
  var xml = this.iface.xmlProceso( proceso );
  var nodo = new FLDomElement();
  
  if ( xml ) {
    var dom = new FLDomDocument();
    dom.setContent( xml );
    var nodoProc = dom.firstChild().toElement();
    var objetivo = nodoProc.attribute( "objetivo" );
    
    var tramo = parseFloat( nodoProc.attribute( "tramo" ) );
    nodo = dom.createElement( "Proceso" );
    if ( !isNaN( tramo ) )
      nodo.setAttribute( "tramo", ( tramo > 0 ? tramo : 0 ) );
    nodo.setAttribute( "objetivo", objetivo );
    nodo.appendChild( this.iface.explosionarTareas( this.iface.explosionarComposicion ( objetivo ) ) );
    
    this.iface.balancearProceso( nodo );
  }
  
  return nodo;
}

function oficial_procesarTarea( estados, estadoActual, nodoCostes ) {
  var countT = ( ( estados == undefined || estadoActual < 0 ) ? 0 : estados.length );
  
  if ( !countT )
    return false;
  
  var tareaModificada = false;  
  var nodoOrig = nodoCostes;
  var nodoDest = estados[ estadoActual ];
  
  var hijos = nodoOrig.elementsByTagName( "Si" );
  var count = ( hijos ? hijos.count() : 0 );
  
  if ( count ) {
    var estadoAnterior = ( estadoActual > 0 ? estadoActual - 1 : 0 );
    var estadoSiguiente = ( ( estadoActual < ( countT - 1 ) ) ? estadoActual + 1 : ( countT - 1 ) );
    var anterior = estados[ estadoAnterior ];
    var actual = estados[ estadoActual ];
    var siguiente = estados[ estadoSiguiente ]; 
    var actor = nodoDest.attribute( "actor" );
    var evaluar = "", i, hijo;
    
    while ( ( anterior.attribute( "anclado" ) == "true" || parseFloat( anterior.attribute( "producido" ) ) <= 0  ) && estadoAnterior > 0 )
      anterior = estados[ --estadoAnterior ];
    
    while ( ( siguiente.attribute( "anclado" ) == "true" || parseFloat( siguiente.attribute( "producido" ) ) <= 0 ) && estadoAnterior < ( countT - 1 ) )
      siguiente = estados[ ++estadoAnterior ];
      
    for ( i = 0; i < count; ++i ) {
      hijo = hijos.item( i ).toElement();
      evaluar = hijo.attribute( "evaluar" ).replace( /#/g, "\"");
      if ( eval( evaluar ) )
        nodoOrig = hijo.firstChild().toElement();
    }
  }
  
  var cuDest = parseFloat( nodoDest.attribute( "costeTiempoUnidad" ) );
  if ( isNaN( cuDest ) ) cuDest = 0;
  var cfDest = parseFloat( nodoDest.attribute( "costeTiempoFijo" ) );
  if ( isNaN( cfDest ) ) cfDest = 0;
  
  var cuOrig = parseFloat( nodoOrig.attribute( "costeTiempoUnidad" ) );
  if ( isNaN( cuOrig ) ) cuOrig = 0;
  var cfOrig = parseFloat( nodoOrig.attribute( "costeTiempoFijo" ) );
  if ( isNaN( cfOrig ) ) cfOrig = 0;
  
  if ( cuOrig == 0 || cuDest != cuOrig ) {
    nodoDest.setAttribute( "costeTiempoUnidad", cuOrig.toString() );
    tareaModificada = true;
  }
  
  if ( cfOrig == 0 || cfDest != cfOrig ) {
    nodoDest.setAttribute( "costeTiempoFijo", cfOrig.toString() );
    tareaModificada = true;
  }
  
  var dimLoteOrig = nodoOrig.attribute( "dimLote" );
  if ( !dimLoteOrig.isEmpty() ) {
    nodoDest.setAttribute( "dimLote", dimLoteOrig );
    tareaModificada = true;
  }
  
  return tareaModificada;
}

function oficial_ejecutarTarea( tareas, indice, actor, inicializar ) {
  var countT = ( ( tareas == undefined || indice < 0 ) ? 0 : tareas.length );
  var tareaModificada = false;
  
  if ( countT && !actor.isEmpty() ) {
    var xml = this.iface.xmlActor( actor );
    
    if ( xml ) {
      var dom = new FLDomDocument();
      dom.setContent( xml );
      
      var nodoAct = dom.firstChild().toElement();
      var hijos = nodoAct.elementsByTagName( "Proceso" );
      var count = ( hijos ? hijos.count() : 0 ), i;
      
      var nodoTarea = tareas[ indice ];
      var itTarea, itProc = new FLDomElement();
      var objetivo = nodoTarea.attribute( "objetivo" );
      
      for ( i = 0; i < count; ++i ) {
        itProc = hijos.item( i ).toElement();
        if ( itProc.attribute( "objetivo" ) == objetivo )
          break;
      }
      
      if ( !itProc.isNull() ) {
        hijos = itProc.elementsByTagName( "Tarea" );
        count = ( hijos ? hijos.count() : 0 );
        for ( i = 0; i < count; ++i ) {
          itTarea = hijos.item( i ).toElement();
          if ( itTarea.attribute( "nombre" ) == nodoTarea.attribute( "nombre") ) {
            if ( inicializar ) {
              nodoTarea.setAttribute( "actor", actor );
              var idNodo = nodoTarea.idNode();
              var estados = new Array();
              var it, j, k = 0, estadoActual = 0;
                  
              for ( j = 0; j < countT; ++j ) {
                it = tareas[ j ];
                if ( it.attribute( "actor" ) == actor ) {
                  if ( it.idNode() == idNodo )
                    estadoActual = k;
                  estados[k++] = it.toElement();
                }
              }
              tareaModificada = this.iface.procesarTarea( estados, estadoActual, itTarea );
            } else
              tareaModificada = this.iface.procesarTarea( tareas, indice, itTarea );
              
            return tareaModificada;
          } 
        }
        var extActor = itProc.attribute( "actor" );
        if ( !extActor.isEmpty() )
          tareaModificada = this.iface.ejecutarTarea( tareas, indice, extActor, inicializar );
      }
    }
  }
  
  return tareaModificada;
}

function oficial_ejecutarProceso( nodoProc, actor ) {
  if ( nodoProc ) { 
    var tareas = this.iface.listaTareasOrdenadasPorTramo( nodoProc );
    var count = ( tareas == undefined ? 0 : tareas.length ), i;
    var itTarea, objetivo, producido;
    
    for ( i = 0; i < count; ++i ) {
      itTarea = tareas[ i ];        
      
      objetivo = itTarea.attribute( "objetivo" );
      
      if ( objetivo.isEmpty() ) {
        var itProc = itTarea.parentNode();
        if ( itProc ) itProc = itProc.toElement();
        while( itProc && itProc.nodeName() != "Proceso" ) {
          itProc = itProc.toElement();
          itProc = itProc.parentNode();
        }
        if ( itProc && itProc.nodeName() == "Proceso" ) {
          objetivo =  itProc.attribute( "objetivo" );
          itTarea.setAttribute( "objetivo", objetivo );
        }
      }
      
      producido = parseFloat( itTarea.attribute( "producido" ) );
      if ( isNaN( producido ) ) itTarea.setAttribute( "producido", "0" );
      
      this.iface.ejecutarTarea( tareas, i, actor, true );
    }
  }
  
  return nodoProc;
}

function oficial_calcularNecesidadBruta( nodo ) {
  var necBruta = 1;
  if ( nodo && ( nodo.nodeName() == "Tarea" || nodo.nodeName() == "Objetivo" ) ) {
    var ct = 1;
    var it = nodo;
    while( it.parentNode() ) {
        it = it.toElement();
        if ( it.nodeName() == "Objetivo" ) {
          ct = parseFloat( it.attribute( "cantidad" ) );
          if ( isNaN( ct ) ) ct = 1;
          necBruta *= ct;
        }
        it = it.parentNode();
    }
  }
  return necBruta;
}

function oficial_calcularCantidadTarea( nodo ) {
  var ct = 1;
  if ( nodo && nodo.nodeName() == "Tarea" ) {
    var it = nodo;
    while( it.parentNode() ) {
        it = it.toElement();
        if ( it.nodeName() == "Objetivo" ) {
          ct = parseFloat( it.attribute( "cantidad" ) );
          if ( isNaN( ct ) ) ct = 1;
          break;
        }
        it = it.parentNode();
    }
  }
  return ct;
}

function oficial_obtenerNecesidadBruta( nodo ) {
  var necBruta;
  if ( nodo && ( nodo.nodeName() == "Tarea" || nodo.nodeName() == "Objetivo" ) ) {
    necBruta = parseFloat( nodo.attribute( "necBruta" ) );
    if ( isNaN( necBruta ) ) necBruta = this.iface.calcularNecesidadBruta( nodo );
  } else
    necBruta = 1;
  return necBruta;
}

function oficial_establecerNecesidadesBrutas( nodo ) {
  if ( nodo ) {
    var round = "%1";
    var hijos = nodo.elementsByTagName( "Tarea" ), hijo;
    var count = ( hijos ? hijos.count() : 0 ), i;
    for ( i = 0; i < count; ++i ) {
      hijo = hijos.item( i ).toElement();
      hijo.setAttribute( "necBruta", round.argDec( this.iface.calcularNecesidadBruta( hijo ), 6, "f", 3 ) );
    }
    hijos = nodo.elementsByTagName( "Objetivo" );
    count = ( hijos ? hijos.count() : 0 );
    for ( i = 0; i < count; ++i ) {
      hijo = hijos.item( i ).toElement();
      hijo.setAttribute( "necBruta", round.argDec( this.iface.calcularNecesidadBruta( hijo ), 6, "f", 3 ) );
    }
  }
}

function oficial_calcularCosteTiempoIndividual( nodo ) {
  var costeI = 0;
  if ( nodo && ( nodo.nodeName() == "Tarea" || nodo.nodeName() == "Objetivo" ) ) {    
    var producido = parseFloat( nodo.attribute( "producido" ) );
    if ( isNaN( producido ) ) {
        producido = parseFloat( nodo.attribute( "necNeta" ) );
        if ( isNaN( producido ) )
          producido = this.iface.obtenerNecesidadBruta( nodo );
    }
    if ( producido > 0 ) {
      var cu = parseFloat( nodo.attribute( "costeTiempoUnidad" ) );
      if ( isNaN( cu ) ) cu = 0;
      var cf = parseFloat( nodo.attribute( "costeTiempoFijo" ) );
      if ( isNaN( cf ) ) cf = 0;  
      costeI = cf + producido * cu;
    }
  }
  return costeI;
}

function oficial_establecerCostesTiemposIndividuales( nodo ) {
  if ( nodo ) {
    var round = "%1";
    var hijos = nodo.elementsByTagName( "Tarea" ), hijo;
    var count = ( hijos ? hijos.count() : 0 ), i;
    for ( i = 0; i < count; ++i ) {
      hijo = hijos.item( i ).toElement();
      hijo.setAttribute( "costeTiempoIndividual", round.argDec( this.iface.calcularCosteTiempoIndividual( hijo ), 6, "f", 3 ) );
    }
    hijos = nodo.elementsByTagName( "Objetivo" );
    count = ( hijos ? hijos.count() : 0 );
    for ( i = 0; i < count; ++i ) {
      hijo = hijos.item( i ).toElement();
      hijo.setAttribute( "costeTiempoIndividual", round.argDec( this.iface.calcularCosteTiempoIndividual( hijo ), 6, "f", 3 ) );
    }
  }
}

function oficial_calcularCosteTiempoTotal( nodo ) {
  var costeT = 0;
  if ( nodo ) {
    var costeI = this.iface.calcularCosteTiempoIndividual( nodo );
    var hijos = nodo.childNodes(), hijo;
    var count = ( hijos ? hijos.count() : 0 ), i;
    var maxCosteT = 0, costeTH;
    for ( i = 0; i < count; ++i ) {
      hijo = hijos.item( i ).toElement();
      costeTH = this.iface.calcularCosteTiempoTotal( hijo );
      if ( costeTH > maxCosteT )
        maxCosteT = costeTH;
    } 
    costeT = costeI + maxCosteT;
  }
  return costeT;
}
 
function oficial_establecerCostesTiemposTotales( nodo ) {
  if ( nodo ) {
    var round = "%1";
    
    if ( nodo.nodeName() == "Proceso" )
      nodo.setAttribute( "costeTiempoTotal", round.argDec( this.iface.calcularCosteTiempoTotal( nodo ), 6, "f", 3 ) );
    
    var hijos = nodo.elementsByTagName( "Proceso" ), hijo;
    var count = ( hijos ? hijos.count() : 0 ), i;
    for ( i = 0; i < count; ++i ) {
      hijo = hijos.item( i ).toElement();
      hijo.setAttribute( "costeTiempoTotal", round.argDec( this.iface.calcularCosteTiempoTotal( hijo ), 6, "f", 3 ) );
    }
  }
}

function oficial_calcularCosteTotal( nodo ) {
  var costeTotal = 0;
  if ( nodo ) {
    var tareas = this.iface.listaNodosOrdenadosPorTramo( nodo );
    var count = ( tareas == undefined ? 0 : tareas.length ), i;
    var sumDistancias = 0, nodoN, nodoNmenos1, distN, distNmenos1;
    var tramo = parseFloat( nodo.attribute( "tramo" ) );
    var costeI;
    
    if ( count )
      costeTotal = this.iface.calcularCosteTiempoIndividual( tareas[ 0 ] );
    
    for ( i = count - 1; i >= 1; --i ) {
      nodoN = tareas[ i ];
      nodoNmenos1 = tareas[ i - 1 ];
      distN = parseFloat( nodoN.attribute( "tramo" ) );
      costeI = this.iface.calcularCosteTiempoIndividual( nodoNmenos1 );
      distNmenos1 = parseFloat( nodoNmenos1.attribute( "tramo" ) ) + costeI;
      sumDistancias += distNmenos1 - distN;
      costeI = this.iface.calcularCosteTiempoIndividual( nodoN );
      costeTotal += costeI;
    }
    if ( sumDistancias ) 
      costeTotal += sumDistancias / count;
  }
  return ( costeTotal > 0 ? costeTotal : 0 );
}


function oficial_establecerCostesTotales( nodo ) {
  if ( nodo ) {
    var round = "%1"; 
    if ( nodo.nodeName() == "Proceso" )
      nodo.setAttribute( "costeTotal", round.argDec( this.iface.calcularCosteTotal( nodo ), 6, "f", 3 ) );
    var hijos = nodo.elementsByTagName( "Proceso" ), hijo;
    var count = ( hijos ? hijos.count() : 0 ), i;
    for ( i = 0; i < count; ++i ) {
      hijo = hijos.item( i ).toElement();
      hijo.setAttribute( "costeTotal", round.argDec( this.iface.calcularCosteTotal( hijo ), 6, "f", 3 ) );
    }
  }
}

function oficial_calcularTramoSinCapacidad( nodo ) {
  var tramo = this.iface.constMaxTramo;
  
  if ( nodo ) {
    tramo = parseFloat( nodo.attribute( "tramo" ) );
    if ( isNaN( tramo ) ) tramo = this.iface.constMaxTramo;
  }
  
  if ( nodo && ( nodo.nodeName() == "Tarea" || nodo.nodeName() == "Objetivo" ) ) {
    var tramoFijo = parseFloat( nodo.attribute( "tramoFijo" ) );
    if ( !isNaN( tramoFijo ) )
      return tramoFijo;
    
    if ( nodo.parentNode() ) {
      var it = nodo;
      var tramoAnterior;
      while( it.parentNode() ) {
        it = it.parentNode();
        it = it.toElement();
        if ( it.nodeName() == "Tarea"  ||  it.nodeName() == "Objetivo" ) {
          tramoAnterior = parseFloat( it.attribute( "tramoFijo" ) );
          if ( isNaN( tramoAnterior ) ) tramoAnterior = this.iface.calcularTramoSinCapacidad( it );
          break;
        } else {
          tramoAnterior = parseFloat( it.attribute( "tramo" ) );
          if ( isNaN( tramoAnterior ) ) tramoAnterior = parseFloat( it.attribute( "tramoFijo" ) );
          if ( isNaN( tramoAnterior ) ) tramoAnterior = this.iface.constMaxTramo;
        }
      }
      tramo = tramoAnterior - this.iface.calcularCosteTiempoIndividual( nodo );
    }
  }
  
  return tramo;
}

function oficial_establecerTramosSinCapacidad( nodo ) {
  if ( nodo ) {
    var round = "%1";
    var hijos = nodo.elementsByTagName( "Tarea" ), hijo;
    var count = ( hijos ? hijos.count() : 0 ), i;
    for ( i = 0; i < count; ++i ) {
      hijo = hijos.item( i ).toElement();
      hijo.setAttribute( "tramo", round.argDec( this.iface.calcularTramoSinCapacidad( hijo ), 6, "f", 3 ) );
    }
    hijos = nodo.elementsByTagName( "Objetivo" );
    count = ( hijos ? hijos.count() : 0 );
    for ( i = 0; i < count; ++i ) {
      hijo = hijos.item( i ).toElement();
      hijo.setAttribute( "tramo", round.argDec( this.iface.calcularTramoSinCapacidad( hijo ), 6, "f", 3 ) );
    }
  }
}

function oficial_establecerAnclaje( nodo, nodoPadre ) {
  var nodoP;
  
  if ( nodo.nodeName() == "Tarea" || nodo.nodeName() == "Objetivo" ) {
    nodoP = nodo;
    if ( nodo.attribute( "anclado" ) == "true" ) {
      var tramo = parseFloat( nodo.attribute( "tramo" ) );
      if ( nodoPadre.attribute( "anclado" ) == "true" )
          nodoPadre = nodo.nodeFromIdNode( nodoPadre.attribute( "idNodoAnclaje" ) );
      if ( nodoPadre ) {
        nodo.setAttribute( "idNodoAnclaje", nodoPadre.idNode() );
        if ( nodo.nodeName() == "Tarea" )
          nodo.setAttribute( "actor", nodoPadre.attribute( "actor") );
        var idNodoAnclado = nodoPadre.attribute( "idNodoAnclado" );
        if ( !idNodoAnclado.isEmpty() ) {
          var nodoAnclado = nodo.nodeFromIdNode( idNodoAnclado );
          var tramoAnclado;
          if ( nodoAnclado )
            tramoAnclado = parseFloat( nodoAnclado.attribute( "tramo" ) );
          else
            tramoAnclado = tramo;
          if ( tramoAnclado >= tramo )
            nodoPadre.setAttribute( "idNodoAnclado", nodo.idNode() );
        } else
          nodoPadre.setAttribute( "idNodoAnclado", nodo.idNode() );
      }
    }
  } else
    nodoP = nodoPadre;
  
  var hijos = nodo.childNodes(), hijo;
  var count = ( hijos ? hijos.count() : 0 ), i;
  for ( i = 0; i < count; ++i ) {
    hijo = hijos.item( i ).toElement();
    this.iface.establecerAnclaje( hijo, nodoP );
  }
}

function oficial_establecerAnclajes( nodo ) {
  if ( nodo )
    this.iface.establecerAnclaje( nodo, nodo );
}

function oficial_obtenerTramoSinCapacidad( nodo ) {
  var tramo = this.iface.constMaxTramo;
  
  if ( nodo ) {
    tramo = parseFloat( nodo.attribute( "tramo" ) );
    if ( isNaN( tramo ) ) tramo = this.iface.constMaxTramo;
  }
  
  if ( nodo && ( nodo.nodeName() == "Tarea" || nodo.nodeName() == "Objetivo" ) ) {
    var tramoFijo = parseFloat( nodo.attribute( "tramoFijo" ) );
    if ( !isNaN( tramoFijo ) )
      return tramoFijo;
  
    if ( nodo.parentNode() ) {
      var it = nodo;
      var tramoAnterior;
      var anclado = false;
      while( it.parentNode() ) {
        it = it.parentNode();
        it = it.toElement();
        if ( it.nodeName() == "Tarea"  ||  it.nodeName() == "Objetivo" ) {
          tramoAnterior = parseFloat( it.attribute( "tramoFijo" ) );
          if ( isNaN( tramoAnterior ) ) tramoAnterior = this.iface.obtenerTramoSinCapacidad( it );
          if ( nodo.attribute( "anclado" ) == "true" ) 
            anclado = true;
          break;
        } else {
          tramoAnterior = parseFloat( it.attribute( "tramo" ) );
          if ( isNaN( tramoAnterior ) ) tramoAnterior = parseFloat( it.attribute( "tramoFijo" ) );
          if ( isNaN( tramoAnterior ) ) tramoAnterior = this.iface.constMaxTramo;
        }
      }
      var costeI = this.iface.calcularCosteTiempoIndividual( nodo );
      if ( anclado )
        tramo = tramoAnterior - costeI;
      else if ( tramo + costeI > tramoAnterior ) 
          tramo = tramoAnterior - costeI;
    }
  }
  
  return tramo;
}

function oficial_actualizarTramoSinCapacidad( nodo, tramoPadre ) {
  var tramoFijo = parseFloat( nodo.attribute( "tramoFijo" ) );
  var tramo = tramoPadre;
  var round = "%1";
  
  if ( isNaN( tramoFijo ) ) {
    if ( nodo.nodeName() == "Tarea"  ||  nodo.nodeName() == "Objetivo" ) {
      var costeI = this.iface.calcularCosteTiempoIndividual( nodo );
      if ( nodo.attribute( "anclado" ) == "true" )
        tramo = tramoPadre - costeI;
      else if ( tramo + costeI > tramoPadre ) 
          tramo = tramoPadre - costeI;
    }
  } else
    tramo = tramoFijo;
  
  nodo.setAttribute( "tramo", round.argDec( tramo, 6, "f", 3 ) );
  
  var hijos = nodo.childNodes(), hijo;
  var count = ( hijos ? hijos.count() : 0 ), i;
  for ( i = 0; i < count; ++i ) {
    hijo = hijos.item( i ).toElement();
    this.iface.actualizarTramoSinCapacidad( hijo, tramo );
  }
}

function oficial_actualizarTramosSinCapacidad( nodo ) {
  if ( nodo ) {
    var tramo = parseFloat( nodo.attribute( "tramo" ) );
    if ( isNaN( tramo ) ) tramo = this.iface.constMaxTramo;
    this.iface.actualizarTramoSinCapacidad( nodo, tramo );
  }
}

function oficial_calcularNecesidadNeta( nodo ) {
  var necNeta = 0;
  if ( nodo && nodo.nodeName() == "Objetivo" ) {
    var objetivo = nodo.attribute( "nombre" );
    
    var nodoRaiz = nodo;
    while( nodoRaiz.parentNode() ) {
      nodoRaiz = nodoRaiz.parentNode();
      nodoRaiz = nodoRaiz.toElement();
    }
    
    var tramo = parseFloat( nodo.attribute( "tramo" ) );
    var idNodo = nodo.idNode();
    var hijos = nodoRaiz.elementsByTagName( "Objetivo" ), hijo;
    var count = ( hijos ? hijos.count() : 0 ), i;
    var objetivoH, tramoH = 0, consumidoH = 0, producidoH = 0;
    
    necNeta = parseFloat( nodo.attribute( "consumido" ) );
    if ( isNaN( necNeta ) )
      necNeta = parseFloat( nodo.attribute( "necBruta" ) );
    
    for ( i = 0; i < count; ++i ) {
      hijo = hijos.item( i ).toElement();
      if ( hijo.idNode() == idNodo )
        continue;
      objetivoH = hijo.attribute( "nombre" );
      if ( objetivoH == objetivo ) {
        tramoH = parseFloat( hijo.attribute( "tramo" ) );     
        if ( tramoH < tramo ) {
          consumidoH = parseFloat( hijo.attribute( "consumido" ) );
          if ( isNaN( consumidoH ) ) consumidoH = 0;
          producidoH = parseFloat( hijo.attribute( "producido" ) );
          if ( isNaN( producidoH ) ) producidoH = 0;
          necNeta = necNeta + consumidoH - producidoH;
        }
      }
    }
  }
  return necNeta;
}

function oficial_establecerNecesidadesNetas( nodo ) {
  if ( nodo ) {
    var round = "%1";
    var hijos = nodo.elementsByTagName( "Objetivo" ), hijo;
    var count = ( hijos ? hijos.count() : 0 ), i;
    for ( i = 0; i < count; ++i ) {
      hijo = hijos.item( i ).toElement();
      hijo.setAttribute( "necNeta", round.argDec( this.iface.calcularNecesidadNeta( hijo ), 6, "f", 3 ) );
    }
  }
}

function oficial_calcularDimLote( nodo ) {
  var dimLote = 0;
  
  if ( nodo && nodo.nodeName() == "Tarea" ) {
    var it = nodo.parentNode();
    if ( it ) it = it.toElement();
    while( it && it.nodeName() != "Objetivo" ) {
      it = it.toElement();
      it = it.parentNode();
    }
    
    var necNeta = 0;
    var ct = 1;
    if ( it ) {
      ct = parseFloat( it.attribute( "cantidad" ) );
      if ( isNaN( ct ) ) ct = 1;
      necNeta = this.iface.calcularNecesidadNeta( it );
    }
    
    var dimLoteAtt = parseFloat( nodo.attribute( "dimLote" ) );
    if ( isNaN( dimLoteAtt ) ) dimLoteAtt = 0;
    
    while( it && it.nodeName() != "Tarea" ) {
        it = it.toElement();
        it = it.parentNode();
    }
    dimLote = this.iface.calcularDimLote( it ) * ct;
    
    if ( dimLote < dimLoteAtt )
      dimLote = dimLoteAtt;
          
    if ( necNeta > dimLote )
      dimLote = necNeta;
    if ( necNeta <= 0 )
      dimLote = 0;
  }
  
  return dimLote;
}

function oficial_establecerDimsLotes( nodo ) {
  if ( nodo ) {
    var round = "%1";
    var hijos = nodo.elementsByTagName( "Tarea" ), hijo;
    var count = ( hijos ? hijos.count() : 0 ), i;
    for ( i = 0; i < count; ++i ) {
      hijo = hijos.item( i ).toElement();
      hijo.setAttribute( "dimLote", round.argDec( this.iface.calcularDimLote( hijo ), 6, "f", 3 ) );
    }
  }
}

function oficial_establecerProducidoObjetivo( nodo, producido, ignorarActual ) {
  if ( nodo ) {
    if ( !ignorarActual && nodo.nodeName() == "Objetivo" ) {
      if ( !producido.isEmpty() )
        nodo.setAttribute( "producido", producido );
      else
        nodo.setAttribute( "producido", nodo.attribute( "necBruta" ) );
      producido = "";
    }
    if ( ignorarActual || nodo.nodeName() != "Tarea" ) {
      if ( nodo.parentNode() )
        this.iface.establecerProducidoObjetivo( nodo.parentNode(), producido, false );
      else
        this.iface.establecerConsumidoObjetivo( nodo, "", true );
    }
  }
}

function oficial_establecerConsumidoObjetivo( nodo, consumido, ignorarActual ) {
  if ( nodo ) {
    var round = "%1";
    if ( !ignorarActual && nodo.nodeName() == "Objetivo" ) {
      if ( !consumido.isEmpty() )
        nodo.setAttribute( "consumido", round.argDec( parseFloat( consumido ) * parseFloat( nodo.attribute( "cantidad" ) ), 6, "f", 3 ) );
      else
        nodo.setAttribute( "consumido", nodo.attribute( "necBruta" ) );
      consumido = "";
    }
    if ( ignorarActual || nodo.nodeName() != "Tarea" ) {
      var hijos = nodo.childNodes(), hijo;
      var count = ( hijos ? hijos.count() : 0 ), i;
      for ( i = 0; i < count; ++i ) {
        hijo = hijos.item( i ).toElement();
        this.iface.establecerConsumidoObjetivo( hijo, consumido, false );
      }
    }
  }
}

function oficial_establecerProducidoTareas( idsNodos, recursivo ) {
  if ( idsNodos.isEmpty() )
    return;

  var idsTareas = idsNodos.split( "#" );
  var round = "%1";
  var count = ( idsTareas == undefined ? 0 : idsTareas.length ), i;
  var tareas = new Array();
  var nodoTarea = new FLDomElement();
  var producido, idNodo, idsNodosH = "";
  
  for ( i = 0; i < count; ++i )
    tareas[i] = nodoTarea.nodeFromIdNode( idsTareas[i] );
  
  tareas.sort( this.iface.compararTramos );
  
  for ( i = 0; i < count; ++i ) {
    nodoTarea = tareas[i];
    producido = round.argDec( this.iface.calcularDimLote( nodoTarea ), 6, "f", 3 );
    nodoTarea.setAttribute( "producido", producido );
    this.iface.establecerProducidoObjetivo( nodoTarea, producido, true );
    this.iface.establecerConsumidoObjetivo( nodoTarea, producido, true );
    if ( recursivo ) {
      idNodo = this.iface.tareasPrimerNivel( nodoTarea, true );
      if ( !idNodo.isEmpty() ) {
        if ( idsNodosH.isEmpty() )
          idsNodosH += idNodo;
        else
          idsNodosH += "#" + idNodo;
      }
    }
  }
  
  if ( recursivo )
    this.iface.establecerProducidoTareas( idsNodosH, true );
}

function oficial_establecerProducidoTarea( nodoTarea ) {
  if ( nodoTarea ) {
    var round = "%1", producido;
    producido = round.argDec( this.iface.calcularDimLote( nodoTarea ), 6, "f", 3 );
    nodoTarea.setAttribute( "producido", producido );
    this.iface.establecerProducidoObjetivo( nodoTarea, producido, true );
    this.iface.establecerConsumidoObjetivo( nodoTarea, producido, true );
  }
}

function oficial_desplazarTramos( nodo, desplazamiento ) {
  var hijos = nodo.childNodes(), hijo;
  var count = ( hijos ? hijos.count() : 0 ), i;
  var round = "%1", tramoH;
  for ( i = 0; i < count; ++i ) {
    hijo = hijos.item( i ).toElement();
    tramoH = parseFloat( hijo.attribute( "tramo" ) );
    if ( !isNaN( tramoH ) ) {
      tramoH += desplazamiento;
      hijo.setAttribute( "tramo", round.argDec( tramoH, 6, "f", 3 ) );
    }
    this.iface.desplazarTramos( hijo, desplazamiento );
  }
}

function oficial_ajustarAlcancesTareas( nodoTarea, nodoTareaAnt ) {
  var tramo = parseFloat( nodoTarea.attribute( "tramo" ) );
  var alcanceAnt = parseFloat( nodoTareaAnt.attribute( "alcance" ) );
  if ( alcanceAnt > tramo ) {
    var round = "%1";
    var tramoAnt = tramo - parseFloat( nodoTareaAnt.attribute( "costeTiempoIndividual" ) );
    nodoTareaAnt.setAttribute( "alcance", round.argDec( tramo, 6, "f", 3 ) );
    nodoTareaAnt.setAttribute( "tramo", round.argDec( tramoAnt, 6, "f", 3 ) );
  }
}

function oficial_ajustarCapacidadesTareas( tareas, indice, lastK, actor ) {
  var nodoTarea = tareas[indice];
  var nodoTareaAnt = ( indice > 0 ? tareas[indice-1] : 0 );
  var nodoTareaSig = ( indice < lastK ? tareas[indice+1] : 0 );
  
  if ( !nodoTareaSig ) {
    this.iface.ejecutarTarea( tareas, indice, actor, false );

    var round = "%1";
    var alcance = parseFloat( nodoTarea.attribute( "alcance" ) );
    var costeI = this.iface.calcularCosteTiempoIndividual( nodoTarea );
    var nTramoOriginal = parseFloat( nodoTarea.attribute( "tramoOriginal" ) );
    var tramoOriginal = round.argDec( nTramoOriginal, 6, "f", 3 );
    var nTramo = alcance - costeI;
    var tramo = round.argDec( nTramo, 6, "f", 3 );

    if ( tramo != tramoOriginal ) {
      nodoTarea.setAttribute( "alcance", round.argDec( alcance, 6, "f", 3 ) );
      nodoTarea.setAttribute( "costeTiempoIndividual", round.argDec( costeI, 6, "f", 3 ) );
      nodoTarea.setAttribute( "tramoOriginal", tramo );
      nodoTarea.setAttribute( "tramo", tramo );
      this.iface.desplazarTramos( nodoTarea, nTramo - nTramoOriginal );
    }
    
    if ( nodoTareaAnt ) {
      this.iface.ajustarAlcancesTareas( nodoTarea, nodoTareaAnt );
      this.iface.ajustarCapacidadesTareas( tareas, indice - 1, indice - 1, actor );
    }
  } else 
    this.iface.ajustarCapacidadesTareas( tareas, indice + 1, lastK, actor );
}

function oficial_establecerTramosConCapacidad( nodo ) {   
  if ( nodo ) {
    var round = "%1";
    var idsNodos = this.iface.tareasPrimerNivel( nodo, false ), idNodo;
    var idsTareas, nodoTarea;
    var count, i, j, k = 0;
    var tareas = new Array();
    var actor, costeI, alcance, tramoOriginal, lastK = 0;
    var tareasActor = new Array();
    
    this.iface.establecerProducidoTareas( idsNodos, true );
    
    while( !idsNodos.isEmpty() ) {
      
      idsTareas = idsNodos.split( "#" );
      count = ( idsTareas == undefined ? 0 : idsTareas.length );

      for ( i = 0; i < count; ++i )
        tareas[i] = nodo.nodeFromIdNode( idsTareas[i] );
      tareas.sort( this.iface.compararTramos );
      
      idsNodos = "";
      for ( i = 0; i < count; ++i ) {
        nodoTarea = tareas[i];
        idNodo = this.iface.tareasPrimerNivel( nodoTarea, true );
        if ( !idNodo.isEmpty() ) {
          if ( idsNodos.isEmpty() )
            idsNodos += idNodo;
          else
            idsNodos += "#" + idNodo;
        }
      }
      
      while ( count ) {

        if ( k ) {
          tareasActor.splice( 0, k );
          k = 0;
        }
      
        actor = tareas[ count - 1 ].attribute( "actor" );
        for ( j = 0; j < count; ++j ) {
          nodoTarea = tareas[ j ];
          if ( nodoTarea.attribute( "actor" ) == actor ) {
            tareasActor[k++] = nodoTarea;
            tareas.splice( j, 1 );
            --j;
            --count;
            if ( lastK )
              this.iface.establecerProducidoTarea( nodoTarea );
          }
        }
  
        lastK = k -1;       
        for ( j = lastK; j >= 0; --j ) {
          nodoTarea = tareasActor[ j ];
          tramoOriginal = parseFloat( nodoTarea.attribute( "tramo" ) );
          costeI = this.iface.calcularCosteTiempoIndividual( nodoTarea );
          alcance = tramoOriginal + costeI;           
          nodoTarea.setAttribute( "alcance", round.argDec( alcance, 6, "f", 3 ) );
          nodoTarea.setAttribute( "costeTiempoIndividual", round.argDec( costeI, 6, "f", 3 ) );
          nodoTarea.setAttribute( "tramoOriginal", round.argDec( tramoOriginal, 6, "f", 3 ) );
        }
        
        tareasActor.sort( this.iface.compararAlcancesEfectivos );
                
        for ( j = lastK - 1; j >= 0; --j )
          this.iface.ajustarAlcancesTareas( tareasActor[ j + 1 ], tareasActor[ j ] );
          
        this.iface.ajustarCapacidadesTareas( tareasActor, 0, lastK, actor );
      }
    }
  }
}

function oficial_mutarCromosoma( nodo, actor, iteraciones ) { 
  var costeTotal = this.iface.calcularCosteTotal( nodo ), costeTotalCandidato = costeTotal;
  var hijos, hijo, hijoAux;
  var count, i, randLote;
  var loteTope, necBruta;
  var round = "%1", msg;
  var ficheroSolucion;
  var solucion = new Array( 2 );
  
  ficheroSolucion = this.iface.guardarSolucion( nodo, "mut-" + costeTotal.toString() );
  solucion[0] = costeTotal;
  solucion[1] = ficheroSolucion;
  
  this.iface.util.setTotalSteps( iteraciones );
  
  hijos = this.iface.tareasPrimerNivel( nodo, false ).split( "#" );
  count = ( hijos == undefined ? 0 : hijos.length );
  
  while( iteraciones ) {
    this.iface.util.setProgress( iteraciones );

    for ( i = 0; i < count; ++i ) {
      hijo = nodo.nodeFromIdNode( hijos[ i ] );
      if ( hijo.attribute( "anclado" ) == "true" )
        continue;

      necBruta = parseFloat( hijo.attribute( "necBruta" ) );
      if ( Math.floor( Math.random() * i ) % 2 )
        loteTope = necBruta * 2.2;
      else
        loteTope = necBruta * 0.8;
      randLote = Math.random() * loteTope;
      if ( iteraciones % 2 )
        hijo.setAttribute( "dimLote", round.argDec( Math.ceil( randLote ), 4, "f", 0 ) );
      else
        hijo.setAttribute( "dimLote", round.argDec( Math.floor( randLote ), 4, "f", 0 ) );
    }
    
    this.iface.establecerProducidoTareas( this.iface.tareasPrimerNivel( nodo, false ), true );
    this.iface.ejecutarProceso( nodo, actor );  
    this.iface.actualizarTramosSinCapacidad( nodo );
    this.iface.establecerAnclajes( nodo );
    this.iface.establecerTramosConCapacidad( nodo );
    costeTotalCandidato = this.iface.calcularCosteTotal( nodo );
    
    if ( costeTotalCandidato < costeTotal ) {
      costeTotal = costeTotalCandidato;
      ficheroSolucion = this.iface.guardarSolucion( nodo, "mut-" + costeTotal.toString() );
      solucion[0] = costeTotal;
      solucion[1] = ficheroSolucion;
    }
    
    msg = "Mutando cromosoma...";
    msg += "\n Coste ultima mutación: " + round.argDec( costeTotalCandidato, 6, "f", 3 );
    msg += "\n Coste mejor mutación: " + round.argDec( costeTotal, 6, "f", 3 );
    msg += "\n";
    this.iface.util.setLabelText( msg );
    sys.processEvents();
    
    --iteraciones;
  }
  
  return solucion;
}

function oficial_compararAptitudCromosomas( cromoA, cromoB ) {
  var costeCromoA = cromoA[0];
  var costeCromoB = cromoB[0];
  return cromoA < cromoB ? -1 : cromoA > cromoB ? 1 : 0;  
}

function oficial_cruzarCromosomas( cromoX, cromoY, cromoXY ) {
  var aleatorio = Math.floor( Math.random() * 31 );
  var newCromoXY;
  
  cromoX.removeAttribute( "idNodoAnclado" );
  cromoX.removeAttribute( "idNodoAnclaje" );
  cromoX.removeAttribute( "tramoOriginal" );
  cromoX.removeAttribute( "alcance" );
  
  cromoY.removeAttribute( "idNodoAnclado" );
  cromoY.removeAttribute( "idNodoAnclaje" );
  cromoY.removeAttribute( "tramoOriginal" );
  cromoY.removeAttribute( "alcance" );
  
  if ( aleatorio % 2 )
    newCromoXY = cromoXY.appendChild( cromoX.cloneNode( false ) );
  else
    newCromoXY = cromoXY.appendChild( cromoY.cloneNode( false ) );
  
  newCromoXY = newCromoXY.toElement();
  
  var hijosX = cromoX.childNodes(), hijoX;
  var hijosY = cromoY.childNodes(), hijoY;
  var count = ( hijosX ? hijosX.count() : 0 ), i;

  for ( i = 0; i < count; ++i ) {
    hijoX = hijosX.item( i ).toElement();
    hijoY = hijosY.item( i ).toElement();
    this.iface.cruzarCromosomas( hijoX, hijoY, newCromoXY );
  } 
}

function oficial_evolucionar( poblacion, actor, iteraciones ) {
  var lastCromo = ( poblacion == undefined ? 0 : poblacion.length ) - 1;
  var domX = new FLDomDocument(), domY = new FLDomDocument(), domXY = new FLDomDocument();
  var cromoXY, costeXY, costeP, costeX, costeY, i, j;
  var round = "%1", msg;
  var pareja, aleatorio = Math.floor( Math.random() * 31 );
  
  this.iface.util.setTotalSteps( iteraciones );
  
  while ( iteraciones ) {
    this.iface.util.setProgress( iteraciones );
    
    for ( i = 0; i < lastCromo; ++i) {
      pareja = Math.floor( Math.random() * lastCromo );
      if ( pareja == i )
        pareja = i + 1;
      domX.setContent( File.read( poblacion[i][1] ) );
      domY.setContent( File.read( poblacion[pareja][1] ) );
      cromoXY = domXY.createElement( "CromosomaXY" );
      
      this.iface.cruzarCromosomas( domX.firstChild().toElement(), domY.firstChild().toElement(), cromoXY.toElement() );
      
      cromoXY = cromoXY.firstChild().toElement();
      
      this.iface.establecerProducidoTareas( this.iface.tareasPrimerNivel( cromoXY, false ), true );
      this.iface.actualizarTramosSinCapacidad( cromoXY );
      this.iface.establecerAnclajes( cromoXY );
      this.iface.establecerTramosConCapacidad( cromoXY );
      
      costeX = poblacion[i][0];
      costeY = poblacion[pareja][0];
      costeXY = this.iface.calcularCosteTotal( cromoXY );
      
      for( j = 0; j <= lastCromo; ++j ) {
        costeP = poblacion[j][0];
        if ( costeP >= costeXY )
          break;
      }
      
      msg = "Cruzando cromosomas...";
      msg += "\n " + round.argDec( costeX, 6, "f", 3 ) + " x " + round.argDec( costeY, 6, "f", 3 );
      msg += "\n Resultado : " + round.argDec( costeXY, 6, "f", 3 );
      this.iface.util.setLabelText( msg );
      sys.processEvents();
      
      if ( costeP != costeXY && j <= lastCromo ) {
        aleatorio = Math.floor( Math.random() * 31 );
        if ( aleatorio % 8 ) {
          poblacion[j][0] = costeXY;
          poblacion[j][1] = this.iface.guardarSolucion( cromoXY, j.toString() + "-evo-" + iteraciones.toString() + "-" + costeXY.toString() + "-cromoXY" );
        } else
          poblacion[j] = this.iface.mutarCromosoma( cromoXY, actor, iteraciones );
      }
    }
    
    --iteraciones;
  }
}

function oficial_guardarSolucion( nodo, prefijo ) {
  var doc = new FLDomDocument();
  var d = new Date();
  var timeStamp = d.toString() + d.getSeconds() + d.getMilliseconds();
  var temporal; 
  
  if ( this.iface.workDir.isEmpty() )
    temporal = sys.diskCacheAbsDirPath() + "/soluciones/";
  else
    temporal = this.iface.workDir;
  
  var dir = new Dir( temporal );
  dir.mkdirs();
  
  nodo.removeAttribute( "idNodoAnclado" );
  nodo.removeAttribute( "idNodoAnclaje" );
  nodo.removeAttribute( "tramoOriginal" );
  nodo.removeAttribute( "alcance" );
  
  var fileName = temporal + prefijo + "-" + timeStamp + ".xml";
  doc.appendChild( nodo.cloneNode() );
  File.write( fileName, doc.toString( 1 ) );
  
  return fileName;
}

function oficial_dibujarProceso( proceso ) {
  var nodoInicio = this.iface.explosionarProceso( proceso );

  this.iface.nodoCoord( nodoInicio, this.iface.coordOrigX, this.iface.coordOrigY );
  this.iface.dibujarNodo( nodoInicio.firstChild(), this.iface.defDeltaY );
}

function oficial_dibujarArbol( nodo ) {
  if ( nodo ) {
    this.iface.nodoCoord( nodo, this.iface.coordOrigX, this.iface.coordOrigY );
    this.iface.dibujarNodo( nodo.firstChild(), this.iface.defDeltaY );
  }
}

function oficial_arbolComposicion( objetivo ) {
  return explosionarComposicion( objetivo );
}

function oficial_arbolProceso( proceso ) {
  var nodoInicio = this.iface.explosionarProceso( proceso );
  this.iface.establecerNecesidadesBrutas( nodoInicio );
  this.iface.establecerTramosSinCapacidad( nodoInicio );
  this.iface.establecerProducidoTareas( this.iface.tareasPrimerNivel( nodoInicio, false ), true );
  return nodoInicio;
}

function oficial_arbolCostes( nodo, actor ) {
  if ( nodo ) {
    this.iface.ejecutarProceso( nodo, actor );
    this.iface.actualizarTramosSinCapacidad( nodo );
    this.iface.establecerAnclajes( nodo );
    this.iface.establecerTramosConCapacidad( nodo );
    this.iface.establecerCostesTiemposTotales( nodo );
    this.iface.establecerCostesTotales( nodo );
    this.iface.establecerCostesTiemposIndividuales( nodo );
  }
  return nodo;
}

function oficial_genetico( proceso, iteraciones, individuos, actores ) {
  var count = ( actores == undefined ? 0 : actores.length );
  if ( !count )
    return;
  
  var nodoInicio = this.iface.explosionarProceso( proceso );
  
  this.iface.establecerNecesidadesBrutas( nodoInicio );
  this.iface.establecerTramosSinCapacidad( nodoInicio );
  this.iface.establecerProducidoTareas( this.iface.tareasPrimerNivel( nodoInicio, false ), true );
  this.iface.ejecutarProceso( nodoInicio, actores[0] );

  this.iface.actualizarTramosSinCapacidad( nodoInicio );
  this.iface.establecerAnclajes( nodoInicio );
  this.iface.establecerTramosConCapacidad( nodoInicio );

  this.iface.guardarSolucion( nodoInicio, "mrp-clasico-" + this.iface.calcularCosteTotal( nodoInicio ).toString() );
  
  var poblacion = new Array( individuos );
  var aleatorio, i;
  
  this.iface.util.createProgressDialog( "", iteraciones );
  
  for ( i = 0; i < individuos; ++i ) {
	sys.processEvents();
    aleatorio = parseInt( Math.random() * count );
	if ( aleatorio > ( count - 1 ) )
		aleatorio = count - 1;
    poblacion[i] = this.iface.mutarCromosoma( nodoInicio, actores[aleatorio], iteraciones );
  }
  
  poblacion.sort( this.iface.compararAptitudCromosomas );
  
  this.iface.evolucionar( poblacion, actores[0], iteraciones );
  
  this.iface.util.destroyProgressDialog();
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
