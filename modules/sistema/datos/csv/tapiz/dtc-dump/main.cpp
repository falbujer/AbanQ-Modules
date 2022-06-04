#include "dtc_dump.h"

#include <QtGui>
#include <QApplication>

int main( int argc, char *argv[] )
{
    QApplication a( argc, argv );
    dtc_dump w;
    w.show();
    a.connect( &a, SIGNAL( lastWindowClosed() ), &a, SLOT( quit() ) );
    return a.exec();
}
