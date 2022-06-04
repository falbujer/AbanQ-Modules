#!/bin/bash

rm -f *.csv
rm -f *~

sqlcmd -D ð -v -d /home/af5/dat/afix4/dbs/apli01 -H -e "select * from act order by act" > actividades.csv
if [ "$?" != "0" ]; then echo "### ERROR AFIX ####"; fi

sqlcmd -D ð -v -d /home/af5/dat/afix4/dbs/apli01 -H -e "select * from prv order by prv" > provincias.csv
if [ "$?" != "0" ]; then echo "### ERROR AFIX ####"; fi

sqlcmd -D ð -v -d /home/af5/dat/afix4/dbs/apli01 -H -e "select * from pais order by pais" > paises.csv
if [ "$?" != "0" ]; then echo "### ERROR AFIX ####"; fi

sqlcmd -D ð -v -d /home/af5/dat/afix4/dbs/apli01 -H -e "select * from contacto order by num" > contactos.csv
if [ "$?" != "0" ]; then echo "### ERROR AFIX ####"; fi

sqlcmd -D ð -v -d /home/af5/dat/afix4/dbs/apli01 -H -e "select * from age order by age" > agentes.csv
if [ "$?" != "0" ]; then echo "### ERROR AFIX ####"; fi

sqlcmd -D ð -v -d /home/af5/dat/afix4/dbs/apli01 -H -e "select * from pob order by pob" > poblaciones.csv
if [ "$?" != "0" ]; then echo "### ERROR AFIX ####"; fi

sqlcmd -D ð -v -d /home/af5/dat/afix4/dbs/apli01 -H -e "select * from cli order by cli" > clientes.csv
sqlcmd -D ð -v -d /home/af5/dat/afix4/dbs/apli01 -H -e "select * from pro order by pro" > proveedores.csv
if [ "$?" != "0" ]; then echo "### ERROR AFIX ####"; fi

sqlcmd -D ð -v -d /home/af5/dat/afix4/dbs/apli01 -H -e "select * from dir" > dir_clientes.csv
sqlcmd -D ð -v -d /home/af5/dat/afix4/dbs/apli01  -H -e "select * from die" > dir_envio.csv
if [ "$?" != "0" ]; then echo "### ERROR AFIX ####"; fi

sqlcmd -D ð -v -d /home/af5/dat/afix4/dbs/apli01 -H -e "select * from fpg" > formas_pago.csv
if [ "$?" != "0" ]; then echo "### ERROR AFIX ####"; fi

sqlcmd -D ð -v -d /home/af5/dat/afix4/dbs/apli01 -H -e "select * from fam" > familias.csv
sqlcmd -D ð -v -d /home/af5/dat/afix4/dbs/apli01 -H -e "select * from art where anula='N'" > articulos.csv
sqlcmd -D ð -v -d /home/af5/dat/afix4/dbs/apli01 -H -e "select * from artcb" > articulos_cb.csv
if [ "$?" != "0" ]; then echo "### ERROR AFIX ####"; fi

sqlcmd -D ð -v -d /home/af5/dat/afix4/dbs/apli01 -H -e "select * from cfv where ejer='$1' and serie<>'97' order by fef" > cab_facturascli.csv
sqlcmd -D ð -v -d /home/af5/dat/afix4/dbs/apli01 -H -e "select * from dfv where ejer='$1' and serie<>'97' order by fac" > det_facturascli.csv
if [ "$?" != "0" ]; then echo "### ERROR AFIX ####"; fi

sqlcmd -D ð -v -d /home/af5/dat/afix4/dbs/apli01 -H -e "select * from cpv where ejer='$1' order by fep" > cab_pedidoscli.csv
sqlcmd -D ð -v -d /home/af5/dat/afix4/dbs/apli01 -H -e "select * from dpv where ejer='$1' order by ped" > det_pedidoscli.csv
if [ "$?" != "0" ]; then echo "### ERROR AFIX ####"; fi

sqlcmd -D ð -v -d /home/af5/dat/afix4/dbs/apli01 -H -e "select * from cabpre where ejer='$1' order by codpre" > cab_presupuestos.csv
sqlcmd -D ð -v -d /home/af5/dat/afix4/dbs/apli01 -H -e "select * from detpre where ejer='$1' order by codpre" > det_presupuestos.csv
if [ "$?" != "0" ]; then echo "### ERROR AFIX ####"; fi

#sqlcmd -D ð -v -d /home/af5/dat/afix4/dbs/apli01 -H -e "select * from cpc where ejer='$1' or ejer='2009'" > cab_pedidospro.csv
#sqlcmd -D ð -v -d /home/af5/dat/afix4/dbs/apli01 -H -e "select * from dpc where ejer='$1' or ejer='2009'" > det_pedidospro.csv

sqlcmd -D ð -v -d /home/af5/dat/afix4/dbs/apli01 -H -e "select * from efepag where ejer='$1' order by feclib" > efectos_pago.csv
sqlcmd -D ð -v -d /home/af5/dat/afix4/dbs/apli01 -H -e "select * from efecob where ejer='$1' order by feclib" > efectos_cob.csv
if [ "$?" != "0" ]; then echo "### ERROR AFIX ####"; fi

sqlcmd -D ð -v -d /home/af5/dat/afix4/dbs/apli01 -H -e "select dd.cli,dd.art,aa.des,dd.pvp from art aa, dca dd where aa.art=dd.art" > precios_netos.csv
if [ "$?" != "0" ]; then echo "### ERROR AFIX ####"; fi

for i in $(ls *.csv)
do
	cat $i | sed 's/¥/Ñ/g' > $i.temp
	mv -vf $i.temp $i
done
