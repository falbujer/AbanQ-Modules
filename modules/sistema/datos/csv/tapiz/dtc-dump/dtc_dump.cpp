#include <QtGui>
#include <QDebug>

#include "dtc_dump.h"

dtc_dump::dtc_dump( QWidget *parent )
        : QMainWindow( parent ), recordLen( 0 ), numFields( 0 ), numRecs( 0 )
{
    ui.setupUi( this );

    mainWidget = new QWidget;
    vboxLayout = new QVBoxLayout( mainWidget );

    textEdit = new QTextEdit( mainWidget );
    textEdit->setReadOnly( true );
    textEdit->setFontFamily( "Monospace" );

    vboxLayout->addWidget( textEdit );

    tableView = new QTableWidget( mainWidget );

    vboxLayout->addWidget( tableView );

    setCentralWidget( mainWidget );
}

dtc_dump::~dtc_dump()
{}

void dtc_dump::on_actOpenFile_triggered()
{
    QFileInfo fileInfo( fileName );
    fileName = QFileDialog::getOpenFileName( this, QString(), fileInfo.absolutePath(), "*.dtc" );

    if ( !fileName.isEmpty() ) {
        log( "Procesar " + fileName );
        previewFile();
    }
}

void dtc_dump::on_actExit_triggered()
{
    dtcApp->quit();
}

void dtc_dump::on_actExportCSV_triggered()
{
    if ( fileName.isEmpty() )
        on_actOpenFile_triggered();

    QFileInfo fileInfo( fileName );
    QString fileNameCSV = QDir::cleanPath( fileInfo.absolutePath() + QDir::separator() +
                                           ".." + QDir::separator() + "csv" + QDir::separator() +
                                           fileInfo.completeBaseName().toLower() + ".csv" );

    fileNameCSV = QFileDialog::getSaveFileName( this, QString(), fileNameCSV, "*.csv" );

    if ( !fileNameCSV.isEmpty() ) {
        log( "\nExportar en " + fileNameCSV );
        log( "Exportando..." );
        exportToCSV( fileNameCSV );
    }
}

void dtc_dump::log( const QString & text )
{
    textEdit->setPlainText( textEdit->toPlainText() + "\n" + text );
    textEdit->moveCursor( QTextCursor::End );
}

bool dtc_dump::readHead()
{
    recordLen = 0;
    numFields = 0;
    numRecs = 0;

    QFile f( fileName );
    if ( !f.open( QIODevice::ReadOnly ) ) {
        log( "Error abriendo " + fileName );
        return false;
    }

    log( "Leyendo cabecera..." );

    dtcFieldInfo fieldInfo;
    quint8 byteIn;
    QDataStream in( &f );

    in.setByteOrder( QDataStream::LittleEndian );
    fieldsInfo.clear();
    recordLen = 1;

    in >> numRecs;

    log( "Numero de registros : " + QString::number( numRecs ) );

    in >> byteIn;
    log( "?? : " + QString::number( byteIn ) );
    in >> byteIn;
    log( "?? : " + QString::number( byteIn ) );
    in >> byteIn;
    log( "?? : " + QString::number( byteIn ) );

    in >> numFields;

    log( "Numero de campos : " + QString::number( numFields ) );

    for ( int i = 0; i < numFields; ++i ) {
        in >> byteIn; fieldInfo.type1 = byteIn;
        in >> byteIn; fieldInfo.len = byteIn;
        in >> byteIn; fieldInfo.type2 = byteIn;
        fieldsInfo << fieldInfo;

        if ( fieldInfo.type1 == 78 )
            recordLen += 8;
        else
            recordLen += fieldInfo.len + 1;
    }

    log( "Longitud de registro : " + QString::number( recordLen ) + " bytes" );

    for ( int i = 0; i < numFields; ++i ) {
        fieldInfo = fieldsInfo.at( i );
        log( QString( "%1 %2 %3 %4" )
             .arg( "Campo " + QString::number( i + 1 ) + ": ", -15 )
             .arg( QChar( fieldInfo.type1 ), 2 )
             .arg( fieldInfo.len, 4 )
             .arg( QChar( fieldInfo.type2 ), 2 ) );
    }

    f.close();
    return true;
}

bool dtc_dump::previewFile()
{
    if ( !readHead() )
        return false;

    if ( !recordLen || !numFields ) {
        log( "No hay campos" );
        return true;
    }

    QFile f( fileName );
    if ( !f.open( QIODevice::ReadOnly ) ) {
        log( "Error abriendo " + fileName );
        return false;
    }

    QDataStream in( &f );

    in.setByteOrder( QDataStream::LittleEndian );
    in.skipRawData( recordLen );

    dtcFieldInfo fieldInfo;
    int step = 1, steps = f.size() / recordLen, row = 0, col = 0;
    QChar sep = 240;
    QString record, strField;
    QTableWidgetItem * newItem;

    tableView->clear();
    tableView->setRowCount( steps - 2 );
    tableView->setColumnCount( numFields );

	log( QString( "Previsualizando; Filas: %1 Columnas: %2" ).arg( steps - 2 ).arg( numFields ) );
	
    QProgressDialog prog( QString(), 0, 1, steps, this );
    prog.setModal( true );
    prog.setAutoReset( false );
    prog.setAutoClose( false );
    prog.setWindowIcon( QIcon( ":/images/icon.png" ) );
    prog.setMinimumDuration( 0 );
    prog.setValue( step );
    prog.setLabelText( "Preparando previsualizacion.." );
    prog.show();
    dtcApp->processEvents();

    QStringList headerLabels;

    for ( int i = 0; i < numFields; ++i ) {
        fieldInfo = fieldsInfo.at( i );
        strField = QString( "%1%2%3%4" )
                   .arg( QString::number( i + 1 ) )
                   .arg( QChar( fieldInfo.type1 ) )
                   .arg( fieldInfo.len )
                   .arg( QChar( fieldInfo.type2 ) );
        headerLabels << strField;
    }

    tableView->setHorizontalHeaderLabels( headerLabels );

    QStringList values;

    while ( !f.atEnd() ) {
        record = readRecord( in );
        if ( record.isEmpty() )
            break;
        row = step - 1;
        if ( row > steps - 1 )
            tableView->insertRow( row );
        col = 0;
        values = record.split( sep, QString::SkipEmptyParts );
        for ( QStringList::const_iterator it = values.begin(); it != values.end(); ++it ) {
            newItem = new QTableWidgetItem( *it );
            newItem->setFlags( newItem->flags() ^ Qt::ItemIsEditable );
            tableView->setItem( row, col++, newItem );
        }
        ++step;
        prog.setValue( step );
    }

	tableView->resizeRowsToContents();
	tableView->resizeColumnsToContents();
	
	log( QString( "Previsualizadas; Filas: %1 Columnas: %2" ).arg( row ).arg( col ) );

    f.close();
    return true;
}

QString dtc_dump::readRecord( QDataStream & in )
{
    if ( in.status() != QDataStream::Ok ) {
        log( "Flujo de datos fuera de secuencia" );
        return QString();
    }

    dtcFieldInfo fieldInfo;
    QString record;
    QChar sep = 240;
    QChar charIn;
    QByteArray stringIn;
    quint8 byteIn;
    qreal wordIn;

    in >> byteIn;
    if ( byteIn == 255 ) {
        log( QString( "Final del fichero" ) );
        return QString();
    }
    if ( byteIn != 0 ) {
        log( QString( "Error leyendo byte de inicio de registro %1 != 0" ).arg( byteIn ) );
        return record;
    }

    QTextCodec * codec = QTextCodec::codecForName( "IBM 850" );

    for ( int i = 0; i < numFields; ++i ) {
        if ( in.status() != QDataStream::Ok ) {
            log( "Flujo de datos fuera de secuencia" );
            return record;
        }

        fieldInfo = fieldsInfo.at( i );
        charIn = 0;
        stringIn = QByteArray();
        byteIn = 0;
        wordIn = 0;

        if ( fieldInfo.type1 == 78 ) {
            in >> wordIn;
            record += QString::number( wordIn, 'f', 2 ).leftJustified( fieldInfo.len < 6 ? 6 : fieldInfo.len );
        } else {
            for ( int j = 0; j < fieldInfo.len; ++j ) {
                if ( in.status() != QDataStream::Ok ) {
                    log( "Flujo de datos fuera de secuencia" );
                    return ( record + codec->toUnicode( stringIn ) );
                }

                in >> byteIn;
                charIn = byteIn;
                if ( charIn.isPrint() )
                    stringIn += charIn;
            }

            record += codec->toUnicode( stringIn ).leftJustified( fieldInfo.len < 6 ? 6 : fieldInfo.len );
            in >> byteIn;
        }

        if ( i < numFields - 1 )
            record += sep;
    }

    return record;
}

bool dtc_dump::exportToCSV( const QString & fileNameCSV )
{
    QFile f( fileName );
    if ( !f.open( QIODevice::ReadOnly ) ) {
        log( "Error abriendo " + fileName );
        return false;
    }

    QFile fCSV( fileNameCSV );
    if ( !fCSV.open( QIODevice::WriteOnly ) ) {
        log( "Error abriendo " + fileNameCSV );
        return false;
    }

    QFile fCSVTab( fileNameCSV + ".tab" );
    if ( !fCSVTab.open( QIODevice::WriteOnly ) ) {
        log( "Error abriendo " + fileNameCSV + ".tab" );
        return false;
    }

    QDataStream in( &f );

    in.setByteOrder( QDataStream::LittleEndian );
    in.skipRawData( recordLen );

    QTextStream out( &fCSV );
    out.setCodec( "ISO 8859-15" );
    QTextStream outTab( &fCSVTab );
    outTab.setCodec( "ISO 8859-15" );
    dtcFieldInfo fieldInfo;
    int step = 1, steps = f.size() / recordLen;
    QChar sep = 240;
    QString record, strField;

    QProgressDialog prog( QString(), 0, 1, steps, this );
    prog.setModal( true );
    prog.setAutoReset( false );
    prog.setAutoClose( false );
    prog.setWindowIcon( QIcon( ":/images/icon.png" ) );
    prog.setMinimumDuration( 0 );
    prog.setValue( step );
    prog.setLabelText( "Exportando a CSV.." );
    prog.show();
    dtcApp->processEvents();

    for ( int i = 0; i < numFields; ++i ) {
        fieldInfo = fieldsInfo.at( i );
        strField = QString( "%1%2%3%4" )
                   .arg( QString::number( i + 1 ) )
                   .arg( QChar( fieldInfo.type1 ) )
                   .arg( fieldInfo.len )
                   .arg( QChar( fieldInfo.type2 ) );
        record += strField.leftJustified( fieldInfo.len < 6 ? 6 : fieldInfo.len );
        if ( i < numFields - 1 )
            record += sep;
    }

    outTab << record + "\n";
    out << record.simplified().replace( QString( sep ) + " ", sep ).replace( " " + QString( sep ), sep ) + "\n";

    while ( !f.atEnd() ) {
        record = readRecord( in );
        if ( record.isEmpty() )
            break;
        outTab << record + "\n";
        out << record.simplified().replace( QString( sep ) + " ", sep ).replace( " " + QString( sep ), sep ) + "\n";
        ++step;
        prog.setValue( step );
    }

    log( QString( "Exportados %1 registro(s)" ).arg( step ) );

    f.close();
    fCSV.close();
    fCSVTab.close();
    return true;
}

