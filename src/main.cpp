/****************************************************************************
**
** Copyright (C) 2018 Olaf Pernitt
** Contact: https://www.linkedin.com/in/opernitt/
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** This software is licensed under the GNU General Public License v3.0
** Permissions of this strong copyleft license are conditioned on making
** available complete source code of licensed works and modifications,
** which include larger works using a licensed work, under the same license.
** Copyright and license notices must be preserved.
** Contributors provide an express grant of patent rights.
**
****************************************************************************/

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QTranslator>
#include <QDebug>
#include "fileio.h"
#include "uisettings.h"

// The QTranslator
QTranslator translator;

/*
 * The entry point for the app
 * Creates a QGuiApplication instance,
 * installs a QTranslator and provides
 * access from QML to:
 * FileIO:      io.dtv.fileio 1.0
 * UiSettings:  io.dtv.uisettings 1.0
 */
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    // Install the QTranslator
    // Language selection is done in Settings, in response to a UI change
    app.installTranslator(&translator);

    // Register the FileIO type
    qmlRegisterType<FileIO, 1>("io.dtv.fileio", 1, 0, "FileIO");

    // Register the UiSettings type
    qmlRegisterType<UiSettings>("io.dtv.uisettings", 1, 0, "UiSettings");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    // Set up custom styles
    //qApp->setStyleSheet();

    // Create the UI Settings handler and set the Translation instance
    UiSettings uisettings;
    uisettings.setTranslator(&translator);

    // Expose emptyString on appWindow, which changes every time a language is selected
    //engine.rootContext()->setContextProperty("rootItem", &uisettings);

    // Connect slots to the signals from the Global Settings Object
    QObject *item = engine.rootObjects()[0];
    QObject::connect(item, SIGNAL(languageSelected(QString)),
                     &uisettings, SLOT(languageSelectedSlot(QString)));

    // Execute the main loop
    int ret = app.exec();

    // Disconnect the signals
    QObject::disconnect(item, SIGNAL(languageSelected(QString)),
                        &uisettings, SLOT(languageSelectedSlot(QString)));

    // ret from app.exec()
    return ret;
}
