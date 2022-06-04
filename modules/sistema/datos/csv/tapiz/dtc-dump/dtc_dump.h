#ifndef DTC_DUMP_H
#define DTC_DUMP_H

#include <QtGui/QMainWindow>
#include "ui_dtc_dump.h"

#define dtcApp ( static_cast<QApplication *> ( QCoreApplication::instance() ) )

class QTextEdit;
class QTableWidget;
class QVBoxLayout;

struct dtcFieldInfo
{
    quint8 type1;
    quint8 type2;
    quint8 len;
};

class dtc_dump : public QMainWindow
{
    Q_OBJECT

public:

    dtc_dump( QWidget *parent = 0 );
    ~dtc_dump();

private slots:

    void on_actOpenFile_triggered();
    void on_actExit_triggered();
    void on_actExportCSV_triggered();

private:

    void log( const QString & text );
    bool readHead();
    bool previewFile();
    QString readRecord( QDataStream & in );
    bool exportToCSV( const QString & fileNameCSV );
    
    Ui::dtc_dumpClass ui;

	QWidget * mainWidget;
    QTextEdit * textEdit;
    QTableWidget * tableView;
    QVBoxLayout *vboxLayout;
    QString fileName;
    QList<dtcFieldInfo> fieldsInfo;
    int recordLen;
    quint8 numFields;
    quint16 numRecs;
};

#endif // DTC_DUMP_H
