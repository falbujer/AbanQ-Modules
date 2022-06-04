/***************************************************************************
                 fldocuppal.qs  -  description
                             -------------------
    begin                : fri oct 22 2004
    copyright            : (C) 2004 by InfoSiAL S.L.
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


// Ejecuta la query especificada y devuelve un array con los
// datos de los campos seleccionados
// Devuelve un campo extra 'result' que es 1 = Ok, 0 = Error, -1 No encontrado
function ejecutarQry(tabla, campos, where, listaTablas)
{
		var util = new FLUtil;
		var campo = campos.split(",");
		var valor = [];
		valor["result"] = 1;
		var query = new FLSqlQuery();
		if (listaTablas)
				query.setTablesList(listaTablas);
		else
				query.setTablesList(tabla);
		query.setSelect(campo);
		query.setFrom(tabla);
		query.setWhere(where + ";");
		if (query.exec()) {
				if (query.next()) {
						for (var i = 0; i < campo.length; i++) {
								valor[campo[i]] = query.value(i);
						}
				} else {
						valor.result = -1;
				}
		} else {
				MessageBox.critical
						(util.translate("scripts", "Falló la consulta") + query.sql(),
						MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
				valor.result = 0;
		}

		return valor;
}