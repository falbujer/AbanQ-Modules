#!/bin/bash

ABANQ="/usr/local/facturalux-lite/bin/fllite"

if [ "$1" == "" -o "$2" == "" -o "$3" == "" ]
then
  echo ""
  echo "Hay que indicar el nombre del proceso a ejecutar, sus argumentos y la cadena de conexión" 
  echo "Ej: $0 actualizar_iva cli:2010 base_datos:usuario:PostgreSQL:localhost:5432:password"
  echo ""
  exit 1;
fi

cat > exec_proceso_especial.qs <<EOF
{
file = new File("$PWD/$1.qs");
try {
  file.open(File.ReadOnly);
} catch(e) {
  debug(e);
  return;
}
sys.addSysCode("var cmdargs = \"$2\";\n" + file.read());
}
EOF

$ABANQ -silentconn "$3" -c "sys.execQSA" -a "$PWD/exec_proceso_especial.qs" -q

cat > exec_proceso_especial.qs <<EOF
{
  sys.$1();
}
EOF

$ABANQ -silentconn "$3" -c "sys.execQSA" -a "$PWD/exec_proceso_especial.qs" -q