#!/bin/bash

ABANQ="/opt/AbanQ/bin/fllite"
WORKDIR="$PWD"
RUTADATOS="$WORKDIR/csv"
SUFIX_DATE="$(/bin/date +%Y_%m_%d_%H:%M)"
LOGFILE="$WORKDIR/logs/$SUFIX_DATE.log"

if [ "$3" == "backup" ]
then
  BACKUP_DIR="/home/backup"
  OUTDUMP=dumpall-$SUFIX_DATE
  vacuumdb -faz 2>>$LOGFILE
  if [ "$?" != "0" ]; then echo "### ERROR CONEXION ABANQ ####" >> $LOGFILE; fi 
  pg_dumpall -O -v > $BACKUP_DIR/$OUTDUMP 2>>$LOGFILE
  if [ "$?" != "0" ]; then echo "### ERROR SERVIDOR BACKUP NO DISPONIBLE ####" >> $LOGFILE; fi
  bzip2 -v $BACKUP_DIR/$OUTDUMP 2>>$LOGFILE
  if [ "$?" != "0" ]; then echo "### ERROR SERVIDOR BACKUP NO DISPONIBLE ####" >> $LOGFILE; fi
fi

if [ "$1" == "" -o "$2" == "" ]
then
  echo ""
  echo "Hay que indicar el ejercicio a importar y la cadena de conexión" 
  echo "Ej: $0 2010 base_datos:usuario:PostgreSQL:localhost:5432:password"
  echo ""
  exit 1;
fi

PROCIMP="$RUTADATOS/proceso_importacion.sh"

if [ ! -x $PROCIMP ]
then
  echo ""
  echo "No se ha definido o no es ejecutable el script para importar el ejercicio $1"
  echo "Se a intentado ejecutar: $PROCIMP"
  echo ""
  exit 1;
fi

echo "" >> $LOGFILE
echo "INICIO $SUFIX_DATE Ejercicio $1" >> $LOGFILE
if [ -x /usr/informix/bin/sqlcmd ]
then
  cd $RUTADATOS
  echo "$PROCIMP" >> $LOGFILE
  $PROCIMP $1 2>>$LOGFILE
  cd $WORKDIR
  echo "" >> $LOGFILE
fi

cat > import.qs <<EOF 
{
util = formRecorddat_procesos_lotes.iface.util;
util.quickSqlDelete("dat_opciones","");
util.sqlInsert("dat_opciones","rutadatos","$RUTADATOS/");

formRecorddat_procesos_lotes.iface.pub_cmdRunLote("000");

util.execSql("update presupuestoscli set editable='t' where codejercicio='$1'");
formRecorddat_procesos_lotes.iface.pub_cmdRunProceso("cab_presupuestos@codejercicio='$1'");
formRecorddat_procesos_lotes.iface.pub_cmdRunProceso("det_presupuestos@idpresupuesto in (select lp.idpresupuesto from lineaspresupuestoscli lp inner join presupuestoscli p on lp.idpresupuesto=p.idpresupuesto where p.codejercicio='$1')");
util.execSql("update presupuestoscli set editable='f' where codejercicio='$1'");

util.execSql("update pedidoscli set editable='t' where codejercicio='$1'");
formRecorddat_procesos_lotes.iface.pub_cmdRunProceso("cab_pedidoscli@codejercicio='$1'");
formRecorddat_procesos_lotes.iface.pub_cmdRunProceso("det_pedidoscli@idpedido in (select lp.idpedido from lineaspedidoscli lp inner join pedidoscli p on lp.idpedido=p.idpedido where p.codejercicio='$1')");
util.execSql("update pedidoscli set editable='f' where codejercicio='$1'");

util.execSql("update facturascli set editable='t' where codejercicio='$1'");
formRecorddat_procesos_lotes.iface.pub_cmdRunProceso("cab_facturascli@codejercicio='$1'");
formRecorddat_procesos_lotes.iface.pub_cmdRunProceso("det_facturascli@idfactura in (select lp.idfactura from lineasfacturascli lp inner join facturascli p on lp.idfactura=p.idfactura where p.codejercicio='$1')");
util.execSql("update facturascli set editable='f' where codejercicio='$1'");

sqlUpNetoD = "update %1scli set netosindtoesp=COALESCE((select sum(pvptotal) from lineas%1scli " +
             "where id%1=%1scli.id%1),0) where codejercicio='$1'";
sqlUpDto   = "update %1scli set dtoesp=netosindtoesp*pordtoesp/100 where codejercicio='$1'";
sqlUpNeto  = "update %1scli set neto=round((netosindtoesp-dtoesp)::numeric,2) where codejercicio='$1'";

sqlUpTiva  = "update %1scli set totaliva=COALESCE((select sum(pvptotal*iva/100) from " +
             "lineas%1scli where id%1=%1scli.id%1),0) where codejercicio='$1'";
sqlUpTivaD = "update %1scli set totaliva=round((totaliva-(totaliva*pordtoesp/100))::numeric,2) where codejercicio='$1'";
sqlUpTivaP = "update %1scli set totalivaportes=round((netoportes*ivaportes/100)::numeric,2) where codejercicio='$1'";
sqlUpTrec  = "update %1scli set totalrecargo=round((COALESCE((select sum(pvptotal*recargo/100) from " +
             "lineas%1scli where id%1=%1scli.id%1),0))::numeric,2) where codejercicio='$1'";

sqlUpTotP  = "update %1scli set totalportes=COALESCE(netoportes,0)+COALESCE(totalivaportes,0) where codejercicio='$1'";
sqlUpTot   = "update %1scli set total=neto+totaliva+totalrecargo+totalportes where codejercicio='$1'";
sqlUpTotE  = "update %1scli set totaleuros=total*tasaconv where codejercicio='$1'";

util.execSql(sqlUpNetoD.replace(/%1/g,"presupuesto"));
util.execSql(sqlUpDto.replace(/%1/g,"presupuesto"));
util.execSql(sqlUpNeto.replace(/%1/g,"presupuesto"));

util.execSql(sqlUpTiva.replace(/%1/g,"presupuesto"));
util.execSql(sqlUpTivaD.replace(/%1/g,"presupuesto"));
util.execSql(sqlUpTivaP.replace(/%1/g,"presupuesto"));
util.execSql(sqlUpTrec.replace(/%1/g,"presupuesto"));

util.execSql(sqlUpTotP.replace(/%1/g,"presupuesto"));
util.execSql(sqlUpTot.replace(/%1/g,"presupuesto"));
util.execSql(sqlUpTotE.replace(/%1/g,"presupuesto"));


util.execSql(sqlUpNetoD.replace(/%1/g,"pedido"));
util.execSql(sqlUpDto.replace(/%1/g,"pedido"));
util.execSql(sqlUpNeto.replace(/%1/g,"pedido"));

util.execSql(sqlUpTiva.replace(/%1/g,"pedido"));
util.execSql(sqlUpTivaD.replace(/%1/g,"pedido"));
util.execSql(sqlUpTivaP.replace(/%1/g,"pedido"));
util.execSql(sqlUpTrec.replace(/%1/g,"pedido"));

util.execSql(sqlUpTotP.replace(/%1/g,"pedido"));
util.execSql(sqlUpTot.replace(/%1/g,"pedido"));
util.execSql(sqlUpTotE.replace(/%1/g,"pedido"));


util.execSql(sqlUpNetoD.replace(/%1/g,"factura"));
util.execSql(sqlUpDto.replace(/%1/g,"factura"));
util.execSql(sqlUpNeto.replace(/%1/g,"factura"));

util.execSql(sqlUpTiva.replace(/%1/g,"factura"));
util.execSql(sqlUpTivaD.replace(/%1/g,"factura"));
util.execSql(sqlUpTivaP.replace(/%1/g,"factura"));
util.execSql(sqlUpTrec.replace(/%1/g,"factura"));

util.execSql(sqlUpTotP.replace(/%1/g,"factura"));
util.execSql(sqlUpTot.replace(/%1/g,"factura"));
util.execSql(sqlUpTotE.replace(/%1/g,"factura"));
}
EOF

$ABANQ	-silentconn "$2" -c "sys.execQSA" -a "$WORKDIR/import.qs" -q 2>>$LOGFILE

cd $WORKDIR/procs
echo "Actualizar IVA Facturas clientes $1" >> $LOGFILE
./exec_proceso_especial.sh actualizar_iva "cli:$1" "$2" 2>>$LOGFILE
cd $WORKDIR

cat > store_log.qs <<EOF
{
log = File.read('$LOGFILE');
res = ' OK';
if (log.indexOf('### ERROR') != -1) res = ' ERROR';
cur = new FLSqlCursor('dat_logs');
cur.setModeAccess(cur.Insert);
cur.refreshBuffer();
cur.setValueBuffer('descripcion', '$SUFIX_DATE' + res);
cur.setValueBuffer('contenido', log);
cur.commitBuffer();
}
EOF

$ABANQ  -silentconn "$2" -c "sys.execQSA" -a "$WORKDIR/store_log.qs" -q 2>>$LOGFILE

echo "FIN $(/bin/date +%Y%m%d%H%M) Ejercicio $1" >> $LOGFILE

