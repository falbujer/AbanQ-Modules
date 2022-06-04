# Preproceso para crear ficheros CSV a partir de la exportación
# de clientes que realiza el software TAPIZ

# TAPIZ exporta un fichero ASCII en binario los clientes;
# *.CLI. Hay que convertir la codificación de caracteres 
# con el comando iconv

ENTRADA="EXPORT01.CLI"
FICHERO="$ENTRADA.txt"
SEP="ğ"

iconv --silent -c -f 850 $ENTRADA | sed  "s/~/$SEP/g" > $FICHERO

# El fichero generado es binario se debe abrir con un editor
# de texto y guardarlo como texto. Kwrite lo hace perfecto.

# El formato del fichero de exportación consta de lineas de
# texto cuyos campos son separados por el carácter ~
# Para cada cliente se pueden crear varias lineas cuyos primeros
# campos determinan el tipo de registro, ejemplo:

#CLI~00038~MONTSERRAT MILLAN DELGADO     ~CTRA.ALMANSA, S/N.            ~MONTEALEGRE                   ~02650~A    Ó    ~          ~     4SSÓd~1002800165~                    ~                              ~Bh~FP4~Bh~FP0~S~n}d   ~C~N~         ~         ~E~V0000038~B1~C000038~Z200038~ES00038~   ~ ~          ~1~1~N~HKE  N~   1022093~  -2890684~-29055428
#CAX~0003800~ETAPIZADOS BONSAI              ~CTRA.ALMANSA, S/N.            ~MONTEALEGRE                   ~02650~          ~          ~                 Z2 ~T00
#CAX~00038õõ~D                              ~967-336180                    ~                              ~     ~      Bh  ~          ~74512343-W          ~   
#DOM~00038 ~CAJA RURAL                    ~-                             ~-                             ~-----~2029652324~3056034020~                    ~

# Se han identificado estos tipos de registro:

# CLI : Datos generales
# CAX~..NN~E... : Direcciones de envio ( donde NN son nuemros que identifican cada direccion 00,01,02...etc)
# CAX~..õõ~D... : Telefonos y CIF/NIF
# DOM : Datos de domiciliación bancaria


# Campos significativos de cada tipo de registro (entre corchetes valore fijos):

# CLI
# TIPO~CODIGO~NOMBRE~DIRECCION~POBLACION~CODIGO_POSTAL

# CAX~..NN~E...
# TIPO~CODIGO[NN]~[E]NOMBRE~DIRECCION~POBLACION~CODIGO_POSTAL

# CAX~..õõ~D...
# TIPO~CODIGO[õõ]~[D]??~TELEFONO1~FAX~??~??~??~CIF_NIF

# DOM
# TIPO~CODIGO~BANCO~DIRECCION~POBLACION~??~CUENTA~ENTIDAD_AGENCIA_DC

# Creación de ficheros CSV para el módulo de datos:
# clientes.csv con los datos generales
# clientes_dire.csv con las direcciones de envio
# clientes_dat.csv con los telefonos y cif
# clientes_dom.csv con los datos de domiciliacion bancaria


cat $FICHERO | grep -a "CLI$SEP" | sed "s/CLI$SEP\(.*\)$SEP\(.*\)$SEP\(.*\)$SEP\(.*\)$SEP\(.*\)$SEP.*$SEP.*$SEP.*$SEP.*$SEP.*$SEP.*$SEP.*$SEP.*$SEP.*$SEP.*$SEP.*$SEP.*$SEP.*$SEP.*$SEP.*$SEP.*$SEP.*$SEP.*$SEP.*$SEP.*$SEP.*$SEP.*$SEP.*$SEP.*$SEP.*$SEP.*$SEP.*$SEP.*$SEP.*$SEP.*$SEP.*$SEP.*/\1$SEP\2$SEP\3$SEP\4$SEP\5/" > clientes.csv
cat $FICHERO | grep -a "CAX${SEP}.*${SEP}E.*${SEP}.*${SEP}.*${SEP}.*${SEP}.*${SEP}.*${SEP}.*${SEP}" | sed "s/CAX${SEP}\(.*\)${SEP}E\(.*\)${SEP}\(.*\)${SEP}\(.*\)${SEP}\(.*\)${SEP}.*${SEP}.*${SEP}.*${SEP}.*/\1${SEP}\2${SEP}\3${SEP}\4${SEP}\5/" > clientes_dire.csv
cat $FICHERO | grep -a "CAX${SEP}.*${SEP}D.*${SEP}.*${SEP}.*${SEP}.*${SEP}.*${SEP}.*${SEP}.*${SEP}" | sed "s/CAX${SEP}\(.*\)${SEP}D.*${SEP}\(.*\)${SEP}\(.*\)${SEP}.*${SEP}.*${SEP}.*${SEP}\(.*\)${SEP}.*/\1${SEP}\2${SEP}\3${SEP}\4/" > clientes_dat.csv
cat $FICHERO | grep -a "DOM${SEP}" | sed "s/DOM${SEP}\(.*\)${SEP}\(.*\)${SEP}\(.*\)${SEP}\(.*\)${SEP}.*${SEP}\(.*\)${SEP}\(.*\)${SEP}.*${SEP}.*/\1${SEP}\2${SEP}\3${SEP}\4${SEP}\5${SEP}\6/" > clientes_dom.csv
