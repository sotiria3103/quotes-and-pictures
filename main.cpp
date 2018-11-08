#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QObjectList>
#include <QQmlContext>
#include <QQuickImageProvider>

#include "images.h"
#include "quotes.h"
#include "mediator.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    Mediator *m = new Mediator();
    Images images;
    m->sendRequest(); //initialize the content and title shown at ReactiveQuotes.qml

    engine.rootContext()->setContextProperty("mediator",m);
    engine.addImageProvider("images", &images);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    return app.exec();
}



