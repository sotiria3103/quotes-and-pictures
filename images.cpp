#include <QEventLoop>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>
#include <QImage>
#include <QQuickImageProvider>
#include <QObject>
#include <QImageReader>

#include "images.h"

Images::Images() : QQuickImageProvider(QQuickImageProvider::Image){

}

QImage Images::requestImage(const QString &id, QSize *size, const QSize &requestedSize) {

    // create custom temporary event loop on stack
    QEventLoop eventLoop;

    // "quit()" the event-loop, when the network request "finished()"
    QNetworkAccessManager mgr;
    QObject::connect(&mgr, SIGNAL(finished(QNetworkReply*)), &eventLoop, SLOT(quit()));

    // the HTTP request
    QNetworkRequest req( QUrl( QString("http://www.splashbase.co/api/v1/images/random") ) );
    QNetworkReply *reply = mgr.get(req);
    eventLoop.exec(); // blocks stack until "finished()" has been called

    if (reply->error() == QNetworkReply::NoError) {

        QJsonObject jsonObject= QJsonDocument::fromJson(reply->readAll()).object();
        QString url= jsonObject["url"].toString();
        url=url.remove(4,1);

        QUrl qurl=url;

        //QNetworkAccessManager mgr2;
        //QEventLoop eventloop2;
        connect(&mgr, SIGNAL(finished(QNetworkReply*)), &eventLoop, SLOT(quit()));
        QNetworkRequest request(qurl);
        QNetworkReply *replyy = mgr.get(request);

        eventLoop.exec();

        if (replyy->error() == QNetworkReply::NoError)
        {
            QByteArray arr=replyy->readAll();
            QImage image;
            image.loadFromData(arr);

            return image;
        }else{
            qDebug()<<"Failure" <<reply->errorString();
        }
    }else {
        //failure
        qDebug() << "Failure" <<reply->errorString();
        delete reply;
    }
}

