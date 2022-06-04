var pic				= new Picture();
var clr 			= new Color();
var devSize 		= new Size( 1200, 650 );
var devRect 		= new Rect( 0, 0, 1200, 650 );
var grid			= 25;
var workdir			= "/home/falbujer/essa/pruebas/";
var extObjetivo		= ".tgt";
var extProceso		= ".pro";
var extActor		= ".act";
var coordOrigX		= 40;
var coordOrigY		= -600;
var defDeltaY		= -1;
var constMaxTramo	= 365;
var util 			= new FLUtil();

function debugNodo( nodo, ctx ) {
	var log = ""; 
	/*log += ctx + " DEBUG ************";
	log += "isElement " + nodo.isElement();
	log +="Name " + nodo.nodeName();
	log +="Nombre " + nodo.attribute( "nombre" );
	log +="x " + nodo.attribute( "x" );
	log +="y " + nodo.attribute( "y" );
	log +="cantidad " + parseFloat( nodo.attribute( "cantidad" ) );*/
	var doc = new FLDomDocument();
	doc.appendChild( nodo.cloneNode() );
	//log += " xml \n"; 
	log += doc.toString( 1 );
	//log +=ctx + " /DEBUG ***********";
	File.write( "/home/falbujer/essa/pruebas/log.xml", log );
	
	return log;
}

function guardarSolucion( nodo, prefijo ) {
	var doc = new FLDomDocument();
	var d = new Date();
    var timeStamp = d.toString() + d.getSeconds() + d.getMilliseconds();
    var fileName = "/home/falbujer/essa/pruebas/soluciones/" + prefijo + "-" + timeStamp + ".xml";
    
	doc.appendChild( nodo.cloneNode() );
	File.write( fileName, doc.toString( 1 ) );
	
	return fileName;
}

function nodoPoint( nodo ) {
	if ( nodo )
		return new Point( nodo.attribute( "x" ), nodo.attribute( "y" ) );
	return new Point();
}

function setNodoPoint( nodo, point ) {
	if ( nodo ) {
		nodo.setAttribute( "x", point.x.toString() );
		nodo.setAttribute( "y", point.y.toString() );
	}
}

function nodoCoord( nodo, origX, origY ) {
	if ( nodo && nodo.isElement() ) {
		var x = origX, y = origY, maxX = origX;
		var elTete = nodo.previousSibling();
		if ( elTete ) {
			elTete = elTete.toElement();
			if ( elTete.nodeName() == "Proceso" || elTete.nodeName() == "Tarea" )
				maxX = nodoCoord( elTete, x, y );
			else
				maxX = nodoCoord( elTete, maxX, y );
			x = maxX + ( grid * 2 );
		}
		var elPeque = nodo.lastChild();
		if ( elPeque ) {
			elPeque = elPeque.toElement();
			if ( elPeque.nodeName() == "Proceso" || elPeque.nodeName() == "Tarea" )
				maxX = nodoCoord( elPeque, x, y  + ( grid * 1.3 ) );
			else 
				maxX = nodoCoord( elPeque, x, y  + ( grid * 2 ) );
			var elPequeCoord = nodoPoint( elPeque );
			x += ( ( maxX - x ) / 2 );
		}
		setNodoPoint( nodo, new Point( x, y ) );
		return ( x > maxX ? x : maxX );
	}
}

function dibujarEnlaceBottom( padre, hijo ) {
	var orig = new Point( nodoPoint( padre ).x + ( grid / 2 ), nodoPoint( padre ).y + grid );
	var dest = new Point( nodoPoint( hijo ).x + ( grid / 2 ), nodoPoint( hijo ).y );
	clr.setRgb( 10, 155, 10 );
  	pic.setPen( clr, 1 );
	pic.drawLine( orig, dest );
	if ( dest.x < orig.x ) {
		var rect = new Rect( dest.x - grid , dest.y - grid, grid, grid + 1 );
		pic.drawText( rect, 0x0002 | 0x0020, hijo.attribute( "cantidad" ) );
	} else {
		var rect = new Rect( dest.x , dest.y - grid, grid, grid + 1 );
		pic.drawText( rect, 0x0001 | 0x0020, hijo.attribute( "cantidad" ) );
	}
}

function dibujarEnlaceTop( padre, hijo ) {
	var orig = new Point( nodoPoint( padre ).x + ( grid / 2 ), -nodoPoint( padre ).y );
	var dest = new Point( nodoPoint( hijo ).x + ( grid / 2 ), -nodoPoint( hijo ).y + grid );
	clr.setRgb( 10, 155, 10 );
  	pic.setPen( clr, 1 );
	pic.drawLine( orig, dest );
	if ( dest.x < orig.x ) {
		var rect = new Rect( dest.x - grid , dest.y, grid, grid + 1 );
		pic.drawText( rect, 0x0002 | 0x0010, hijo.attribute( "cantidad" ) );
	} else {
		var rect = new Rect( dest.x , dest.y, grid, grid + 1 );
		pic.drawText( rect, 0x0001 | 0x0010, hijo.attribute( "cantidad" ) );
	}
}

function dibujarNodo( nodo, deltaY ) {
	if ( nodo  ) {
		var hijos = nodo.childNodes(), hijo;
		var count = ( hijos ? hijos.count() : 0 ), i;

		for( i = 0; i < count; ++i ) {
			hijo = hijos.item( i ).toElement();
			dibujarNodo( hijo, deltaY )
			if ( deltaY == -1 )
				dibujarEnlaceTop( nodo, hijo );
			else
				dibujarEnlaceBottom( nodo, hijo );
		}
				
		var coord = nodoPoint( nodo );
  		var rect = new Rect( coord.x, deltaY * coord.y, grid, grid );
  		
  		clr.setRgb( 155, 10, 10 );
  		pic.setPen( clr, 1 );
  			
  		if ( nodo.nodeName() == "Objetivo" ) {
  			pic.drawRoundRect( rect );
  		} else if ( nodo.nodeName() == "Tarea" ) {
  			clr.setRgb( 10, 10, 155 );
  			pic.setPen( clr, 1 );
  			pic.drawEllipse( rect );
  		} else if ( nodo.nodeName() == "Proceso" ) {
  			clr.setRgb( 0, 0, 0 );
  			pic.setPen( clr, 2 );
  			pic.drawEllipse( rect );
  		} else
  			pic.drawEllipse( rect );
  		
  		if ( nodo.nodeName() == "Proceso" ) {
  			var costeTotal = parseFloat( nodo.attribute( "costeTotal" ) );
			if ( isNaN( costeTotal ) )
				costeTotal = 0;
			var round = "%1";
	  		pic.drawText( rect, 0x0004 | 0x0040, round.argDec( costeTotal, 6, "f", 3 ) );
  		}
  		
  		rect.moveBy( 0, 3 );
  		pic.drawText( rect, 0x0004 | 0x0010, nodo.attribute( "nombre" ) );
  		
  		if ( nodo.nodeName() == "Objetivo" || nodo.nodeName() == "Tarea" ) {
  			var tramo = parseFloat( nodo.attribute( "tramo" ) );
			if ( isNaN( tramo ) )
				tramo = 0;
			rect.moveBy( 0, grid / 2 - 3 );	
	  		pic.drawText( rect, 0x0004 | 0x0010, tramo );
	  		
	  		rect = new Rect( coord.x,  deltaY * coord.y, grid / 1.2, grid / 2 );
	  		rect.moveBy( -( grid / 1.2 ), 0 );
			pic.drawRoundRect( rect );
			var cu = parseFloat( nodo.attribute( "costeTiempoUnidad" ) );
			if ( isNaN( cu ) )
				cu = 0;
			pic.drawText( rect, 0x0004 | 0x0040, cu );
			
			rect.moveBy( 0, grid / 2 );
			pic.drawEllipse( rect );
			var cf = parseFloat( nodo.attribute( "costeTiempoFijo" ) );
			if ( isNaN( cf ) )
				cf = 0;
	  		pic.drawText( rect, 0x0004 | 0x0040, cf );
	
			pic.drawLine( coord.x,  deltaY * coord.y + grid / 2.2, coord.x + grid, deltaY * coord.y + grid / 2.2 );
  		}
	}
}

function calcularTramoEfectivo( nodo ) {
	var tramo = parseFloat( nodo.attribute( "tramo" ) );
	var idNodoAnclado = nodo.attribute( "idNodoAnclado" );
	if ( !idNodoAnclado.isEmpty() ) {
		var nodoAnclado = nodo.nodeFromIdNode( idNodoAnclado );
		if ( nodoAnclado )
			tramo = parseFloat( nodoAnclado.attribute( "tramo" ) );
	}
	return tramo;
}

function compararTramosEfectivos( nodoA, nodoB ) {
	var tramoA = calcularTramoEfectivo( nodoA );
	var tramoB = calcularTramoEfectivo( nodoB );
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

function compararTramos( nodoA, nodoB ) {
	var tramoA = parseFloat( nodoA.attribute( "tramo" ) );
	var tramoB = parseFloat( nodoB.attribute( "tramo" ) );	
	return tramoA < tramoB ? -1 : tramoA > tramoB ? 1 : 0;
} 

function calcularAlcanceEfectivo( nodo ) {
	if ( nodo.attribute( "anclado" ) == "true" ) {
		var nodoAnclaje = nodo.nodeFromIdNode( nodo.attribute( "idNodoAnclaje" ) );
		if ( nodoAnclaje )
			return parseFloat( nodoAnclaje.attribute( "alcance" ) );
	}
	return parseFloat( nodo.attribute( "alcance" ) );
}

function compararAlcancesEfectivos( nodoA, nodoB ) {
	var alcanceA = calcularAlcanceEfectivo( nodoA );
	var alcanceB = calcularAlcanceEfectivo( nodoB );
	if ( alcanceA == alcanceB )
		return compararTramosEfectivos( nodoA, nodoB );
	return alcanceA < alcanceB ? -1 : 1;
}

function listaTareasOrdenadasPorAlcanceEfectivo( nodo ) {
	var lista;
	var hijos = nodo.elementsByTagName( "Tarea" );
	var count = ( hijos ? hijos.count() : 0 );
	if ( count ) {
		lista = new Array( count );
		for ( var i = 0; i < count; ++i )
				lista[ i ] = hijos.item( i ).toElement();
			lista.sort( compararAlcancesEfectivos );
	}
	return lista;
}

function listaTareasOrdenadasPorTramo( nodo ) {
	var lista;
	if ( nodo ) {
		var hijos = nodo.elementsByTagName( "Tarea" );
		var count = ( hijos ? hijos.count() : 0 ), i;
		
		if ( count ) {
			lista = new Array( count );
			for ( i = 0; i < count; ++i )
				lista[ i ] = hijos.item( i ).toElement();
			lista.sort( compararTramos );
		}
	}
	return lista;
}

function listaObjetivosOrdenadosPorTramo( nodo ) {
	var lista;
	if ( nodo ) {
		var hijos = nodo.elementsByTagName( "Objetivo" );
		var count = ( hijos ? hijos.count() : 0 ), i;
		
		if ( count ) {
			lista = new Array( count );
			for ( i = 0; i < count; ++i )
				lista[ i ] = hijos.item( i ).toElement();
			lista.sort( compararTramos );
		}
	}
	return lista;
}

function listaNodosOrdenadosPorTramo( nodo ) {
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
			lista.sort( compararTramos );
		}
	}
	return lista;
}

function indiceDeLiteral( vector, literal ) {
	var ret = -1;
	for( var i = 0; i < vector.length; ++i )
		if ( vector[i] == literal )
			return i;
	return ret;	
}

function tareasPrimerNivel( nodo, ignorarActual ) {
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
		idNodo = tareasPrimerNivel( hijo, false );
		if ( !idNodo.isEmpty() ) {
			if ( idsNodos.isEmpty() )
				idsNodos += idNodo;
			else
				idsNodos += "#" + idNodo;
		}
	}	
	return idsNodos;
}

function explosionarComposicion( objetivo ) {
	var fileName = workdir + objetivo + extObjetivo;
	var nodo = new FLDomElement();
	
	if ( File.exists( fileName ) ) {
		var dom = new FLDomDocument();
		dom.setContent( File.read( fileName ) );
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
				newHijo = explosionarComposicion( hijo.attribute( "nombre" ) );
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

function explosionarTareas( nodoObjetivo ) {
	if ( nodoObjetivo ) {
		var ct = parseFloat( nodoObjetivo.attribute( "cantidad" ) );
		if ( ct < 0 )
		  return nodoObjetivo;
		  
		var hijos = nodoObjetivo.childNodes();
		var objetivo = nodoObjetivo.attribute( "nombre" );
		var fileName = workdir + objetivo + extProceso;
		var nodoProc = new FLDomElement();
		
		if ( File.exists( fileName ) ) {
			var dom = new FLDomDocument();
			dom.setContent( File.read( fileName ) );
			nodoProc = dom.firstChild().toElement();
		}
		
		if ( hijos ) {
			var hijo, newHijo, i;
			for( i = 0; i < hijos.count(); ++i ) {
				hijo = hijos.item( i ).toElement();
				newHijo = explosionarTareas( hijo );
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

function borrarObjetivosCero( nodo ) {
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
				borrarObjetivosCero( hijo );
			hijo = hijo.nextSibling();
		}
	}
}

function balancearProceso( nodo ) {
	if ( nodo ) {
		var hijos = nodo.childNodes();
		var hijo, i, count = ( hijos ? hijos.count() : 0 );
		if ( hijos ) {
			for( i = 0; i < count; ++i ) {
				hijo = hijos.item( i ).toElement();
				balancearProceso( hijo );
			}
		} else if ( nodo.nodeName() == "Objetivo" ) {
			var ct = parseFloat( nodo.attribute( "cantidad" ) );
			if ( isNaN( ct ) ) {
				nodo.setAttribute( "cantidad", "1" );
				ct = 1;
			}
			if ( ct < 0 )
				return;

			explosionarTareas( nodo );
			balancearProceso( nodo );
			
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
		
		borrarObjetivosCero( nodo );
	}
}

function explosionarProceso( proceso ) {
	var fileName = workdir + proceso + extProceso;
	var nodo = new FLDomElement();
	
	if ( File.exists( fileName ) ) {
		var dom = new FLDomDocument();
		dom.setContent( File.read( fileName ) );
		var nodoProc = dom.firstChild().toElement();
		var objetivo = nodoProc.attribute( "objetivo" );
		
		var tramo = parseFloat( nodoProc.attribute( "tramo" ) );
		nodo = dom.createElement( "Proceso" );
		if ( !isNaN( tramo ) )
			nodo.setAttribute( "tramo", ( tramo > 0 ? tramo : 0 ) );
		nodo.setAttribute( "objetivo", objetivo );
		nodo.appendChild( explosionarTareas( explosionarComposicion ( objetivo ) ) );
		
		balancearProceso( nodo );
	}
	
	return nodo;
}

function procesarTarea( estados, estadoActual, nodoCostes ) {
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

function ejecutarTarea( tareas, indice, actor, inicializar ) {
	var countT = ( ( tareas == undefined || indice < 0 ) ? 0 : tareas.length );
	var tareaModificada = false;
	
	if ( countT && !actor.isEmpty() ) {
		var fileName = workdir + actor + extActor;
		
		if ( File.exists( fileName ) ) {
			var dom = new FLDomDocument();
			dom.setContent( File.read( fileName ) );
			
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
							tareaModificada = procesarTarea( estados, estadoActual, itTarea );
						} else
							tareaModificada = procesarTarea( tareas, indice, itTarea );
							
						return tareaModificada;
					}	
				}
				var extActor = itProc.attribute( "actor" );
				if ( !extActor.isEmpty() )
					tareaModificada = ejecutarTarea( tareas, indice, extActor, inicializar );
			}
		}
	}
	
	return tareaModificada;
}

function ejecutarProceso( nodoProc, actor ) {
	if ( nodoProc ) {	
		var tareas = listaTareasOrdenadasPorTramo( nodoProc );
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
			
			ejecutarTarea( tareas, i, actor, true );
		}
	}
	
	return nodoProc;
}

function calcularNecesidadBruta( nodo ) {
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

function calcularCantidadTarea( nodo ) {
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

function obtenerNecesidadBruta( nodo ) {
	var necBruta;
	if ( nodo && ( nodo.nodeName() == "Tarea" || nodo.nodeName() == "Objetivo" ) ) {
		necBruta = parseFloat( nodo.attribute( "necBruta" ) );
		if ( isNaN( necBruta ) ) necBruta = calcularNecesidadBruta( nodo );
	} else
		necBruta = 1;
	return necBruta;
}

function establecerNecesidadesBrutas( nodo ) {
	if ( nodo ) {
		var round = "%1";
		var hijos = nodo.elementsByTagName( "Tarea" ), hijo;
		var count = ( hijos ? hijos.count() : 0 ), i;
		for ( i = 0; i < count; ++i ) {
			hijo = hijos.item( i ).toElement();
			hijo.setAttribute( "necBruta", round.argDec( calcularNecesidadBruta( hijo ), 6, "f", 3 ) );
		}
		hijos = nodo.elementsByTagName( "Objetivo" );
		count = ( hijos ? hijos.count() : 0 );
		for ( i = 0; i < count; ++i ) {
			hijo = hijos.item( i ).toElement();
			hijo.setAttribute( "necBruta", round.argDec( calcularNecesidadBruta( hijo ), 6, "f", 3 ) );
		}
	}
}

function calcularCosteTiempoIndividual( nodo ) {
	var costeI = 0;
	if ( nodo && ( nodo.nodeName() == "Tarea" || nodo.nodeName() == "Objetivo" ) ) {		
		var producido = parseFloat( nodo.attribute( "producido" ) );
		if ( isNaN( producido ) ) {
				producido = parseFloat( nodo.attribute( "necNeta" ) );
				if ( isNaN( producido ) )
					producido = obtenerNecesidadBruta( nodo );
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

function establecerCostesTiemposIndividuales( nodo ) {
	if ( nodo ) {
		var round = "%1";
		var hijos = nodo.elementsByTagName( "Tarea" ), hijo;
		var count = ( hijos ? hijos.count() : 0 ), i;
		for ( i = 0; i < count; ++i ) {
			hijo = hijos.item( i ).toElement();
			hijo.setAttribute( "costeTiempoIndividual", round.argDec( calcularCosteTiempoIndividual( hijo ), 6, "f", 3 ) );
		}
		hijos = nodo.elementsByTagName( "Objetivo" );
		count = ( hijos ? hijos.count() : 0 );
		for ( i = 0; i < count; ++i ) {
			hijo = hijos.item( i ).toElement();
			hijo.setAttribute( "costeTiempoIndividual", round.argDec( calcularCosteTiempoIndividual( hijo ), 6, "f", 3 ) );
		}
	}
}

function calcularCosteTiempoTotal( nodo ) {
	var costeT = 0;
	if ( nodo ) {
		var costeI = calcularCosteTiempoIndividual( nodo );
		var hijos = nodo.childNodes(), hijo;
		var count = ( hijos ? hijos.count() : 0 ), i;
		var maxCosteT = 0, costeTH;
		for ( i = 0; i < count; ++i ) {
			hijo = hijos.item( i ).toElement();
			costeTH = calcularCosteTiempoTotal( hijo );
			if ( costeTH > maxCosteT )
				maxCosteT = costeTH;
		}	
		costeT = costeI + maxCosteT;
	}
	return costeT;
}
 
function establecerCostesTiemposTotales( nodo ) {
	if ( nodo ) {
		var round = "%1";
		
		if ( nodo.nodeName() == "Proceso" )
			nodo.setAttribute( "costeTiempoTotal", round.argDec( calcularCosteTiempoTotal( nodo ), 6, "f", 3 ) );
		
		var hijos = nodo.elementsByTagName( "Proceso" ), hijo;
		var count = ( hijos ? hijos.count() : 0 ), i;
		for ( i = 0; i < count; ++i ) {
			hijo = hijos.item( i ).toElement();
			hijo.setAttribute( "costeTiempoTotal", round.argDec( calcularCosteTiempoTotal( hijo ), 6, "f", 3 ) );
		}
	}
}

function calcularCosteTotal( nodo ) {
	var costeTotal = 0;
	if ( nodo ) {
		var tareas = listaNodosOrdenadosPorTramo( nodo );
		var count = ( tareas == undefined ? 0 : tareas.length ), i;
		var sumDistancias = 0, nodoN, nodoNmenos1, distN, distNmenos1;
		var tramo = parseFloat( nodo.attribute( "tramo" ) );
		var costeI;
		
		if ( count )
			costeTotal = calcularCosteTiempoIndividual( tareas[ 0 ] );
		
		for ( i = count - 1; i >= 1; --i ) {
			nodoN = tareas[ i ];
			nodoNmenos1 = tareas[ i - 1 ];
			distN = parseFloat( nodoN.attribute( "tramo" ) );
			costeI = calcularCosteTiempoIndividual( nodoNmenos1 );
			distNmenos1 = parseFloat( nodoNmenos1.attribute( "tramo" ) ) + costeI;
			sumDistancias += distNmenos1 - distN;
			costeI = calcularCosteTiempoIndividual( nodoN );
			costeTotal += costeI;
		}
		if ( sumDistancias ) 
			costeTotal += sumDistancias / count;
	}
	return ( costeTotal > 0 ? costeTotal : 0 );
}


function establecerCostesTotales( nodo ) {
	if ( nodo ) {
		var round = "%1";	
		if ( nodo.nodeName() == "Proceso" )
			nodo.setAttribute( "costeTotal", round.argDec( calcularCosteTotal( nodo ), 6, "f", 3 ) );
		var hijos = nodo.elementsByTagName( "Proceso" ), hijo;
		var count = ( hijos ? hijos.count() : 0 ), i;
		for ( i = 0; i < count; ++i ) {
			hijo = hijos.item( i ).toElement();
			hijo.setAttribute( "costeTotal", round.argDec( calcularCosteTotal( hijo ), 6, "f", 3 ) );
		}
	}
}

function calcularTramoSinCapacidad( nodo ) {
	var tramo = constMaxTramo;
	
	if ( nodo ) {
		tramo = parseFloat( nodo.attribute( "tramo" ) );
		if ( isNaN( tramo ) ) tramo = constMaxTramo;
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
					if ( isNaN( tramoAnterior ) ) tramoAnterior = calcularTramoSinCapacidad( it );
					break;
				} else {
					tramoAnterior = parseFloat( it.attribute( "tramo" ) );
					if ( isNaN( tramoAnterior ) ) tramoAnterior = parseFloat( it.attribute( "tramoFijo" ) );
					if ( isNaN( tramoAnterior ) ) tramoAnterior = constMaxTramo;
				}
			}
			tramo = tramoAnterior - calcularCosteTiempoIndividual( nodo );
		}
	}
	
	return tramo;
}

function establecerTramosSinCapacidad( nodo ) {
	if ( nodo ) {
		var round = "%1";
		var hijos = nodo.elementsByTagName( "Tarea" ), hijo;
		var count = ( hijos ? hijos.count() : 0 ), i;
		for ( i = 0; i < count; ++i ) {
			hijo = hijos.item( i ).toElement();
			hijo.setAttribute( "tramo", round.argDec( calcularTramoSinCapacidad( hijo ), 6, "f", 3 ) );
		}
		hijos = nodo.elementsByTagName( "Objetivo" );
		count = ( hijos ? hijos.count() : 0 );
		for ( i = 0; i < count; ++i ) {
			hijo = hijos.item( i ).toElement();
			hijo.setAttribute( "tramo", round.argDec( calcularTramoSinCapacidad( hijo ), 6, "f", 3 ) );
		}
	}
}

function establecerAnclaje( nodo, nodoPadre ) {
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
		establecerAnclaje( hijo, nodoP );
	}
}

function establecerAnclajes( nodo ) {
	if ( nodo )
		establecerAnclaje( nodo, nodo );
}

function obtenerTramoSinCapacidad( nodo ) {
	var tramo = constMaxTramo;
	
	if ( nodo ) {
		tramo = parseFloat( nodo.attribute( "tramo" ) );
		if ( isNaN( tramo ) ) tramo = constMaxTramo;
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
					if ( isNaN( tramoAnterior ) ) tramoAnterior = obtenerTramoSinCapacidad( it );
					if ( nodo.attribute( "anclado" ) == "true" ) 
						anclado = true;
					break;
				} else {
					tramoAnterior = parseFloat( it.attribute( "tramo" ) );
					if ( isNaN( tramoAnterior ) ) tramoAnterior = parseFloat( it.attribute( "tramoFijo" ) );
					if ( isNaN( tramoAnterior ) ) tramoAnterior = constMaxTramo;
				}
			}
			var costeI = calcularCosteTiempoIndividual( nodo );
			if ( anclado )
				tramo = tramoAnterior - costeI;
			else if ( tramo + costeI > tramoAnterior ) 
					tramo = tramoAnterior - costeI;
		}
	}
	
	return tramo;
}

function actualizarTramoSinCapacidad( nodo, tramoPadre ) {
	var tramoFijo = parseFloat( nodo.attribute( "tramoFijo" ) );
	var tramo = tramoPadre;
	var round = "%1";
	
	if ( isNaN( tramoFijo ) ) {
		if ( nodo.nodeName() == "Tarea"  ||  nodo.nodeName() == "Objetivo" ) {
			var costeI = calcularCosteTiempoIndividual( nodo );
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
		actualizarTramoSinCapacidad( hijo, tramo );
	}
}

function actualizarTramosSinCapacidad( nodo ) {
	if ( nodo ) {
		var tramo = parseFloat( nodo.attribute( "tramo" ) );
		if ( isNaN( tramo ) ) tramo = constMaxTramo;
		actualizarTramoSinCapacidad( nodo, tramo );
	}
}

function calcularNecesidadNeta( nodo ) {
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

function establecerNecesidadesNetas( nodo ) {
	if ( nodo ) {
		var round = "%1";
		var hijos = nodo.elementsByTagName( "Objetivo" ), hijo;
		var count = ( hijos ? hijos.count() : 0 ), i;
		for ( i = 0; i < count; ++i ) {
			hijo = hijos.item( i ).toElement();
			hijo.setAttribute( "necNeta", round.argDec( calcularNecesidadNeta( hijo ), 6, "f", 3 ) );
		}
	}
}

function calcularDimLote( nodo ) {
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
			necNeta = calcularNecesidadNeta( it );
		}
		
		var dimLoteAtt = parseFloat( nodo.attribute( "dimLote" ) );
		if ( isNaN( dimLoteAtt ) ) dimLoteAtt = 0;
		
		while( it && it.nodeName() != "Tarea" ) {
				it = it.toElement();
				it = it.parentNode();
		}
		dimLote = calcularDimLote( it ) * ct;
		
		if ( dimLote < dimLoteAtt )
			dimLote = dimLoteAtt;
					
		if ( necNeta > dimLote )
			dimLote = necNeta;
		if ( necNeta <= 0 )
			dimLote = 0;
	}
	
	return dimLote;
}

function establecerDimsLotes( nodo ) {
	if ( nodo ) {
		var round = "%1";
		var hijos = nodo.elementsByTagName( "Tarea" ), hijo;
		var count = ( hijos ? hijos.count() : 0 ), i;
		for ( i = 0; i < count; ++i ) {
			hijo = hijos.item( i ).toElement();
			hijo.setAttribute( "dimLote", round.argDec( calcularDimLote( hijo ), 6, "f", 3 ) );
		}
	}
}

function establecerProducidoObjetivo( nodo, producido, ignorarActual ) {
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
				establecerProducidoObjetivo( nodo.parentNode(), producido, false );
			else
				establecerConsumidoObjetivo( nodo, "", true );
		}
	}
}

function establecerConsumidoObjetivo( nodo, consumido, ignorarActual ) {
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
				establecerConsumidoObjetivo( hijo, consumido, false );
			}
		}
	}
}

function establecerProducidoTareas( idsNodos, recursivo ) {
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
	
	tareas.sort( compararTramos );
	
	for ( i = 0; i < count; ++i ) {
		nodoTarea = tareas[i];
		producido = round.argDec( calcularDimLote( nodoTarea ), 6, "f", 3 );
		nodoTarea.setAttribute( "producido", producido );
		establecerProducidoObjetivo( nodoTarea, producido, true );
		establecerConsumidoObjetivo( nodoTarea, producido, true );
		if ( recursivo ) {
			idNodo = tareasPrimerNivel( nodoTarea, true );
			if ( !idNodo.isEmpty() ) {
				if ( idsNodosH.isEmpty() )
					idsNodosH += idNodo;
				else
					idsNodosH += "#" + idNodo;
			}
		}
	}
	
	if ( recursivo )
		establecerProducidoTareas( idsNodosH, true );
}

function establecerProducidoTarea( nodoTarea ) {
	if ( nodoTarea ) {
		var round = "%1", producido;
		producido = round.argDec( calcularDimLote( nodoTarea ), 6, "f", 3 );
		nodoTarea.setAttribute( "producido", producido );
		establecerProducidoObjetivo( nodoTarea, producido, true );
		establecerConsumidoObjetivo( nodoTarea, producido, true );
	}
}

function desplazarTramos( nodo, desplazamiento ) {
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
		desplazarTramos( hijo, desplazamiento );
	}
}

function ajustarAlcancesTareas( nodoTareaAnt, nodoTarea ) {
	var tramoAnt = parseFloat( nodoTareaAnt.attribute( "tramo" ) );
	var alcance = parseFloat( nodoTarea.attribute( "alcance" ) );
	if ( alcance > tramoAnt ) {
		var round = "%1";
		var tramo = tramoAnt - parseFloat( nodoTarea.attribute( "costeTiempoIndividual" ) );
		nodoTarea.setAttribute( "alcance", round.argDec( tramoAnt, 6, "f", 3 ) );
		nodoTarea.setAttribute( "tramo", round.argDec( tramo, 6, "f", 3 ) );
	}
}

function ajustarCapacidadesTareas( tareas, indice, lastK, actor ) {
	var nodoTarea = tareas[indice];
	var nodoTareaAnt = ( indice > 0 ? tareas[indice-1] : 0 );
	var nodoTareaSig = ( indice < lastK ? tareas[indice+1] : 0 );
	
	if ( !nodoTareaSig ) {
		ejecutarTarea( tareas, indice, actor, false );

		var round = "%1";
		var alcance = parseFloat( nodoTarea.attribute( "alcance" ) );
		var costeI = calcularCosteTiempoIndividual( nodoTarea );
		var nTramoOriginal = parseFloat( nodoTarea.attribute( "tramoOriginal" ) );
		var tramoOriginal = round.argDec( nTramoOriginal, 6, "f", 3 );
		var nTramo = alcance - costeI;
		var tramo = round.argDec( nTramo, 6, "f", 3 );

		if ( tramo != tramoOriginal ) {
			nodoTarea.setAttribute( "alcance", round.argDec( alcance, 6, "f", 3 ) );
			nodoTarea.setAttribute( "costeTiempoIndividual", round.argDec( costeI, 6, "f", 3 ) );
			nodoTarea.setAttribute( "tramoOriginal", tramo );
			nodoTarea.setAttribute( "tramo", tramo );
			desplazarTramos( nodoTarea, nTramo - nTramoOriginal );
		}
		
		if ( nodoTareaAnt ) {
			ajustarAlcancesTareas( nodoTarea, nodoTareaAnt );
			var alcanceAnt = parseFloat( nodoTareaAnt.attribute( "alcance" ) );
			ajustarCapacidadesTareas( tareas, indice - 1, indice - 1, actor );
		}
	} else 
		ajustarCapacidadesTareas( tareas, indice + 1, lastK, actor );
}

function establecerTramosConCapacidad( nodo ) {		
	if ( nodo ) {
		var round = "%1";
		var idsNodos = tareasPrimerNivel( nodo, false ), idNodo;
		var idsTareas, nodoTarea;
		var count, i, j, k = 0;
		var tareas = new Array();
		var actor, costeI, alcance, tramoOriginal, lastK = 0;
		var tareasActor = new Array();
		
		establecerProducidoTareas( idsNodos, true );
		
		while( !idsNodos.isEmpty() ) {
			
			idsTareas = idsNodos.split( "#" );
			count = ( idsTareas == undefined ? 0 : idsTareas.length );

			for ( i = 0; i < count; ++i )
				tareas[i] = nodo.nodeFromIdNode( idsTareas[i] );
			tareas.sort( compararTramos );
			
			idsNodos = "";
			for ( i = 0; i < count; ++i ) {
				nodoTarea = tareas[i];
				idNodo = tareasPrimerNivel( nodoTarea, true );
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
							establecerProducidoTarea( nodoTarea );
					}
				}
	
				lastK = k -1;				
				for ( j = lastK; j >= 0; --j ) {
					nodoTarea = tareasActor[ j ];
					tramoOriginal = parseFloat( nodoTarea.attribute( "tramo" ) );
					costeI = calcularCosteTiempoIndividual( nodoTarea );
					alcance = tramoOriginal + costeI;						
					nodoTarea.setAttribute( "alcance", round.argDec( alcance, 6, "f", 3 ) );
					nodoTarea.setAttribute( "costeTiempoIndividual", round.argDec( costeI, 6, "f", 3 ) );
					nodoTarea.setAttribute( "tramoOriginal", round.argDec( tramoOriginal, 6, "f", 3 ) );
				}
				
				tareasActor.sort( compararAlcancesEfectivos );
								
				for ( j = lastK - 1; j >= 0; --j )
					ajustarAlcancesTareas( tareasActor[ j + 1 ], tareasActor[ j ] );
					
				ajustarCapacidadesTareas( tareasActor, 0, lastK, actor );
			}
		}
	}
}

function dibujarGanttNodo( nodo, actores, rectBase, tramos ) {
	if ( nodo  ) {
		if ( nodo.nodeName() == "Tarea" ) {
			var costeI = calcularCosteTiempoIndividual( nodo );
			if ( costeI < 0 )
				return nodo;
				
			var tramo = parseFloat( nodo.attribute( "tramo" ) );
			var idx = actores[nodo.attribute( "actor" )];
			var anchoFila = rectBase.height / actores.length;
			var anchoColumna = rectBase.width / tramos;
			var tramoFloor = Math.floor( tramo );
			var deltaY = tramo - tramoFloor;
			
			var round = "%1", txt;
			var x = rectBase.left + tramoFloor * anchoColumna;
			var rtop = rectBase.top + idx * anchoFila;
			var y = rtop + deltaY * anchoFila;
			var rect, font = new Font(), porcionesDibujadas = 0;
  			
  			font.pointSize = 6;
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
				dibujarGanttNodo( hijo, actores, rectBase, tramos );
			}	
		}	
	}
}

function dibujarGanttPrevision( nodo, actores, labelActores ) {
	if ( nodo ) {
		var tramo = Math.ceil( parseFloat( nodo.attribute( "tramo" ) ) );
		var winRect = new Rect( 0, 0, ( tramo + 1.5 ) * 100, ( actores.length + 1.5 ) * 100 );
		var desp = 1.5;
		var escala = 95;
		
		pic.setViewport( devRect );
		pic.setWindow( winRect );
		
		for ( var i = 0; i < labelActores.length; ++i )
			pic.drawText( 50 * desp, ( i + 1.5 * desp ) * escala, labelActores[i] );
		for ( var i = 0; i < tramo; ++i )
			pic.drawText(  ( i + ( 1 * desp ) + 0.5 ) * escala, ( actores.length + 1.1 * desp ) * escala, "Dia " + i.toString() );
			
		clr.setRgb( 200, 200, 200 );
		pic.setPen( clr, 1 );
		
		var retRect = new Rect( escala * desp, escala * desp, tramo * escala, actores.length * escala );
		pic.drawRect( retRect );
				  			
		for ( var i = 1; i < tramo; ++i )
			pic.drawLine( ( i + 1 * desp ) * escala, escala * desp , ( i + 1 * desp ) * escala, ( actores.length + 1 * desp ) * escala );
		for ( var i = 1; i < actores.length; ++i )
			pic.drawLine( escala * desp, ( i + 1 * desp ) * escala, ( tramo + 1 * desp ) * escala, (  i + 1  * desp ) * escala );	

		
		dibujarGanttNodo( nodo, actores, retRect, tramo );
		
		return retRect;
	}
}

function dibujarTablaNecNodo( nodo, objetivos, rleft, rtop, anchoFila, anchoColumna, contenidoTabla ) {
	if ( nodo ) {
		var hijos = nodo.childNodes(), hijo;
		var count = ( hijos ? hijos.count() : 0 ), i;
		var idx, tramo, necNeta, producido, txt, x, y;
		
		for ( i = 0; i < count; ++i ) {
			hijo = hijos.item( i ).toElement();
			contenidoTabla = dibujarTablaNecNodo( hijo, objetivos, rleft, rtop, anchoFila, anchoColumna, contenidoTabla );
			
			if ( hijo.nodeName() == "Objetivo" ) {
				idx = indiceDeLiteral( objetivos, hijo.attribute( "nombre" ) );
				if ( idx > -1 ) {
					necNeta = calcularNecesidadNeta( hijo );
					tramo = Math.floor( parseFloat( hijo.attribute( "tramo" ) ) );
					if ( tramo < 0 )
							continue;
					txt = contenidoTabla[0][idx][tramo];
					if ( !txt.isEmpty() )
						txt += "+";
					contenidoTabla[0][idx][tramo] = txt + necNeta.toString();
					txt = "NB:" + obtenerNecesidadBruta( hijo ).toString() + " NN:" + contenidoTabla[0][idx][tramo];
					x = rleft + tramo * anchoColumna;
					y = rtop + idx * anchoFila;
					pic.eraseRect( x + 2, y + 1, anchoColumna - 3, anchoFila * 0.5 - 1 );
					pic.drawText( x + 2, y + 10, txt );
				}
			}
			
			if ( hijo.nodeName() == "Tarea" ) {
				idx = indiceDeLiteral( objetivos, hijo.attribute( "objetivo" ) );
				if ( idx > -1 ) {
					var costeI = calcularCosteTiempoIndividual( hijo );
					if ( costeI > 0 ) {
						tramo = Math.floor( parseFloat( hijo.attribute( "tramo" ) ) );
						if ( tramo < 0 )
							continue;
						producido = parseFloat( hijo.attribute( "producido" ) );
						txt = contenidoTabla[1][idx][tramo];
						if ( !txt.isEmpty() )
							txt += "+";
						contenidoTabla[1][idx][tramo] = txt + hijo.attribute( "nombre" ) + ":" + producido.toString();
						txt = contenidoTabla[1][idx][tramo];
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

function dibujarTablaNecesidades( nodo, objetivos, rectGantt ) {
		var tramo = Math.ceil( parseFloat( nodo.attribute( "tramo" ) ) );
		var numObjetivos = objetivos.length;
		var rectTabla = new Rect( rectGantt.x, 25, rectGantt.width, rectGantt.y - 27 );
		var anchoFila = rectTabla.height / numObjetivos;
		var anchoColumna = rectTabla.width / tramo;
		
		clr.setRgb( 0, 0, 0 );
		pic.setPen( clr, 1 );
		
		for ( var i = 0; i < numObjetivos; ++i )
			pic.drawText( rectTabla.x - 20, rectTabla.top + i * anchoFila + anchoFila * 0.5, objetivos[i] );
			
		clr.setRgb( 200, 200, 200 );
		pic.setPen( clr, 1 );
		
		pic.drawRect( rectTabla );
				
		clr.setRgb( 200, 200, 200 );
		pic.setPen( clr, 1 );
		
		for ( var i = 1; i < tramo; ++i )
			pic.drawLine( rectTabla.x + i * anchoColumna, rectTabla.top, rectTabla.x + i * anchoColumna, rectTabla.bottom );
	
		for ( var i = 1; i < numObjetivos; ++i ) 
			pic.drawLine( rectTabla.x, rectTabla.top + i * anchoFila, rectTabla.right, rectTabla.top + i * anchoFila );
		
		clr.setRgb( 0, 0, 0 );
		pic.setPen( clr, 1 );
		
		var contenidoTabla = new Array( 2 );
		for( var i = 0; i < 2; ++i ) {
			contenidoTabla[i] = new Array( numObjetivos );
			for ( var j = 0; j < numObjetivos; ++j ) {
				contenidoTabla[i][j] = new Array( tramo );
				for( var k = 0; k < tramo; ++k )
					contenidoTabla[i][j][k] = "";
			}
		}
		dibujarTablaNecNodo( nodo, objetivos, rectTabla.left, rectTabla.top, anchoFila, anchoColumna, contenidoTabla );
}

function dibujarNecesidades( nodoInicio ) {
	var lblPix 	= formpicture.child( "pixLbl" );
	var pix 	= new Pixmap();
	var font 	= new Font();
	var round = "%1";
	
	pix.resize( devSize );
	clr.setRgb( 255, 255, 255 );
	pix.fill( clr );
	
	pic.begin();
	
	font.pointSize = 16;
	
	pic.setFont( font );
	pic.drawText( 25, 25, "COSTE " + round.argDec( calcularCosteTotal( nodoInicio ), 6, "f", 3 ) );
	font.pointSize = 7;
	font.family = "Sans";
	
	pic.setFont( font );
	
	var actores = new Array( 4 );
	var labelActores = new Array( "Compras", "Linea1", "Linea3", "Transporte" );
	
	actores[ "compras" ] = 0;
	actores[ "linea1" ] = 1;
	actores[ "linea3" ] = 2;
	actores[ "transporte" ] = 3;
	
	var rectGantt = dibujarGanttPrevision( nodoInicio, actores, labelActores );
	
	var objetivos = new Array( "f1", "b1", "f2", "b2" );
	
	dibujarTablaNecesidades( nodoInicio, objetivos, rectGantt );
	
	pix = pic.playOnPixmap( pix );
	lblPix.pixmap = pix;
	
	pic.end();
}

function mutarCromosoma( nodo, actor, iteraciones ) {	
	var costeTotal = calcularCosteTotal( nodo ), costeTotalCandidato = costeTotal;
	var hijos, hijo, hijoAux;
	var count, i, randLote;
	var loteTope, necBruta;
	var round = "%1", msg;
	var tramo = parseFloat( nodo.attribute( "tramo" ) );
	var ficheroSolucion;
	var solucion = new Array( 2 );
	
	ficheroSolucion = guardarSolucion( nodo, "mut-" + costeTotal.toString() );
	solucion[0] = costeTotal;
	solucion[1] = ficheroSolucion;
	
	util.setTotalSteps( iteraciones );
	
	while( iteraciones ) {
		util.setProgress( iteraciones );
		
		hijos = listaTareasOrdenadasPorTramo( nodo );
		count = ( hijos == undefined ? 0 : hijos.length );

		for ( i = 0; i < count; ++i ) {
			hijo = hijos[ i ];
			if ( ( hijo.attribute( "actor" ) != "linea1" && hijo.attribute( "actor" ) != "linea3" ) || hijo.attribute( "anclado" ) == "true" )
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
		
		establecerTramosConCapacidad( nodo );
		costeTotalCandidato = calcularCosteTotal( nodo );
		
		if ( costeTotalCandidato < costeTotal ) {
			costeTotal = costeTotalCandidato;
			if ( !ficheroSolucion.isEmpty() )
				File.remove( ficheroSolucion );
			ficheroSolucion = guardarSolucion( nodo, "mut-" + costeTotal.toString() );
			solucion[0] = costeTotal;
			solucion[1] = ficheroSolucion;
		}
		
		msg = "Mutando cromosoma...";
		msg += "\n Coste ultima mutación: " + round.argDec( costeTotalCandidato, 6, "f", 3 );
		msg += "\n Coste mejor mutación: " + round.argDec( costeTotal, 6, "f", 3 );
		msg += "\n";
		util.setLabelText( msg );
		sys.processEvents();
		
		--iteraciones;
	}
	
	return solucion;
}

function compararAptitudCromosomas( cromoA, cromoB ) {
	var costeCromoA = cromoA[0];
	var costeCromoB = cromoB[0];
	return cromoA < cromoB ? -1 : cromoA > cromoB ? 1 : 0;	
}

function cruzarCromosomas( cromoX, cromoY, cromoXY ) {
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
		cruzarCromosomas( hijoX, hijoY, newCromoXY );
	}	
}

function evolucionar( poblacion, actor, iteraciones ) {
	var lastCromo = ( poblacion == undefined ? 0 : poblacion.length ) - 1;
	var domX = new FLDomDocument(), domY = new FLDomDocument(), domXY = new FLDomDocument();
	var cromoXY, costeXY, costeP, costeX, costeY, i, j;
	var round = "%1", msg;
	var pareja, aleatorio = Math.floor( Math.random() * 31 );
	
	util.setTotalSteps( iteraciones );
	
	while ( iteraciones ) {
		util.setProgress( iteraciones );
		
		for ( i = 0; i < lastCromo; ++i) {
			pareja = Math.floor( Math.random() * lastCromo );
			if ( pareja == i )
				pareja = i + 1;
			domX.setContent( File.read( poblacion[i][1] ) );
			domY.setContent( File.read( poblacion[pareja][1] ) );
			cromoXY = domXY.createElement( "CromosomaXY" );
			
			cruzarCromosomas( domX.firstChild().toElement(), domY.firstChild().toElement(), cromoXY.toElement() );
			
			cromoXY = cromoXY.firstChild().toElement();
			
			actualizarTramosSinCapacidad( cromoXY );
			establecerAnclajes( cromoXY );
			establecerTramosConCapacidad( cromoXY );
			
			costeX = poblacion[i][0];
			costeY = poblacion[pareja][0];
			costeXY = calcularCosteTotal( cromoXY );
			
			for( j = 0; j <= lastCromo; ++j ) {
				costeP = poblacion[j][0];
				if ( costeP >= costeXY )
					break;
			}
			
			msg = "Cruzando cromosomas...";
			msg += "\n " + round.argDec( costeX, 6, "f", 3 ) + " x " + round.argDec( costeY, 6, "f", 3 );
			msg += "\n Resultado : " + round.argDec( costeXY, 6, "f", 3 );
			util.setLabelText( msg );
			sys.processEvents();
			
			if ( costeP != costeXY && j <= lastCromo ) {
				aleatorio = Math.floor( Math.random() * 31 );
				if ( aleatorio % 8 ) {
					poblacion[j][0] = costeXY;
					poblacion[j][1] = guardarSolucion( cromoXY, j.toString() + "-evo-" + iteraciones.toString() + "-" + costeXY.toString() + "-cromoXY" );
				} else
					poblacion[j] = mutarCromosoma( cromoXY, actor, iteraciones );
			}
		}
		
		--iteraciones;
	}
}

function mostrarSolucion() {	
	var fileName = FileDialog.getOpenFileName( "*.xml", "Seleccionar" );
	
	if ( fileName ) {
		var dom = new FLDomDocument();
		dom.setContent( File.read( fileName ) );
		var nodo = dom.createElement( "CromosomaXY" );
		nodo.appendChild( dom.firstChild().toElement() );
		dibujarNecesidades( nodo.firstChild() );
	}
}

function composicion( objetivo ) {
	print( "\n\n\n@@@@@@@@");

	var nodoInicio = explosionarComposicion( objetivo );
	debugNodo( nodoInicio );
	nodoCoord( nodoInicio, coordOrigX, coordOrigY + 50 );
	
	var lblPix 	= formpicture.child( "pixLbl" );
	var pix 	= new Pixmap();
	var font = new Font();
	
	pix.resize( devSize );
	clr.setRgb( 255, 255, 255 );
	pix.fill( clr );
	
	pic.begin();
	
	font.pointSize = 16;
	
	pic.setFont( font );
	pic.drawText( 25, 25, "LISTA DE MATERIALES" );
	font.pointSize = grid / 5;
	font.family = "Sans";
	
	pic.setFont( font );
	dibujarNodo( nodoInicio, defDeltaY );
	
	pix = pic.playOnPixmap( pix );
	lblPix.pixmap = pix;
	
	pic.end();
}

function proceso( proceso ) {
	print( "\n\n\n@@@@@@@@");

	var nodoInicio = explosionarProceso( proceso );

	nodoCoord( nodoInicio, coordOrigX, coordOrigY );
	
	var lblPix 	= formpicture.child( "pixLbl" );
	var pix 	= new Pixmap();
	var font = new Font();
	
	pix.resize( devSize );
	clr.setRgb( 255, 255, 255 );
	pix.fill( clr );
	
	pic.begin();
	
	font.pointSize = 16;
	
	pic.setFont( font );
	pic.drawText( 25, 25, "ÁRBOL DE PROCESO" );
	font.pointSize = grid / 5;
	font.family = "Sans";
	
	pic.setFont( font );
	dibujarNodo( nodoInicio.firstChild(), defDeltaY );
	
	pix = pic.playOnPixmap( pix );
	lblPix.pixmap = pix;
	
	pic.end();
}

function costes( proceso, actor ) {
	print( "\n\n\n@@@@@@@@");

	var nodoInicio = explosionarProceso( proceso );

	establecerNecesidadesBrutas( nodoInicio );
	establecerTramosSinCapacidad( nodoInicio );
	establecerProducidoTareas( tareasPrimerNivel( nodoInicio, false ), true );
	ejecutarProceso( nodoInicio, actor );

	actualizarTramosSinCapacidad( nodoInicio );
	establecerAnclajes( nodoInicio );
	
	establecerTramosConCapacidad( nodoInicio );
	establecerCostesTiemposTotales( nodoInicio );
	establecerCostesTotales( nodoInicio );
	
	
	debugNodo( nodoInicio );

	nodoCoord( nodoInicio, coordOrigX, coordOrigY );
	
	var lblPix 	= formpicture.child( "pixLbl" );
	var pix 	= new Pixmap();
	var font 	= new Font();
	
	pix.resize( devSize );
	clr.setRgb( 255, 255, 255 );
	pix.fill( clr );
	
	pic.begin();
	
	font.pointSize = 16;
	
	pic.setFont( font );
	pic.drawText( 25, 25, "ÁRBOL DE COSTES" );
	font.pointSize = grid / 5;
	font.family = "Sans";
	pic.setFont( font );

	dibujarNodo( nodoInicio.firstChild(), defDeltaY );
	
	pix = pic.playOnPixmap( pix );
	lblPix.pixmap = pix;
	
	pic.end();
}


function necesidades( proceso, actor ) {
	print( "\n\n\n@@@@@@@@");

	var nodoInicio = explosionarProceso( proceso );

	establecerNecesidadesBrutas( nodoInicio );
	establecerTramosSinCapacidad( nodoInicio );
	establecerProducidoTareas( tareasPrimerNivel( nodoInicio, false ), true );
	ejecutarProceso( nodoInicio, actor );

	actualizarTramosSinCapacidad( nodoInicio );
	establecerAnclajes( nodoInicio );
	
	establecerTramosConCapacidad( nodoInicio );

	dibujarNecesidades(  nodoInicio );
}

function genetico( proceso, actor, actor2 ) {
	print( "\n\n\n@@@@@@@@");

	var pbAux1 = formpicture.child( "pbAux1" );
	pbAux1.text = "Ver Sol.";
	connect( pbAux1, "clicked()", this, "mostrarSolucion()" );
	
	var nodoInicio = explosionarProceso( proceso );

	establecerNecesidadesBrutas( nodoInicio );
	establecerTramosSinCapacidad( nodoInicio );
	establecerProducidoTareas( tareasPrimerNivel( nodoInicio, false ), true );
	ejecutarProceso( nodoInicio, actor );

	actualizarTramosSinCapacidad( nodoInicio );
	establecerAnclajes( nodoInicio );
	
	establecerTramosConCapacidad( nodoInicio );

	dibujarNecesidades(  nodoInicio );

	var i, numCromosomas = 6;
	var iteraciones = 5;
	var poblacion = new Array( numCromosomas );
	
	util.createProgressDialog( "", iteraciones );
	
	for ( i = 0; i < numCromosomas; ++i ) {
		if ( i % 2 ) {
			ejecutarProceso( nodoInicio, actor );
			actualizarTramosSinCapacidad( nodoInicio );
			establecerAnclajes( nodoInicio );
			poblacion[i] = mutarCromosoma( nodoInicio, actor, iteraciones );
		} else {
			ejecutarProceso( nodoInicio, actor2 );
			actualizarTramosSinCapacidad( nodoInicio );
			establecerAnclajes( nodoInicio );
			poblacion[i] = mutarCromosoma( nodoInicio, actor2, iteraciones );
		}
	}
	
	poblacion.sort( compararAptitudCromosomas );
	
	evolucionar( poblacion, actor, iteraciones );
	
	util.destroyProgressDialog();
}

//composicion( "pt1" );

//proceso( "pt1" );

//costes( "pt1", "previsor" );

//necesidades( "pt1", "previsor" );

genetico( "pt1", "previsor", "previsor2" );
