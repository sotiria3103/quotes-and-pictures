#include <QFile>
#include <QStandardPaths>
#include <QDir>
#include <QTextStream>
#include <QEventLoop>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>
#include <string>
#include <QObjectList>
#include <QRegularExpression>
#include "mediator.h"
Mediator::Mediator(QObject *parent) : QObject(parent)
{
    _quoteModel = new QuoteModel();

    int rCount;

    QString path="favorites.txt";
    QFile file(path);
    if (file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        QTextStream in(&file);

        while (!in.atEnd())
        {
            QString quote=in.readLine();
            QStringList pieces = quote.split( "~" );// the content and the title are seperated by "~"
            QString content = pieces.value(0); // the content is writen first at the file
            QString title = pieces.value(1); // the title is writen second
            
            _quoteModel->addQuote(Quotes(content,title)); 
        }
        file.close();
    }
}
void Mediator::updateFile()
{
    int i;
    QString path="favorites.txt";
    QFile file(path);
    int rCount = _quoteModel->rowCount();
    if (file.open(QIODevice::WriteOnly | QIODevice::Text))
    {
        QTextStream out(&file);
        for (i=0;i< rCount-1;i++)
            out<<_quoteModel->getContent(i)<<"~"<< _quoteModel->getTitle(i)<<endl; // the content and the title are seperated by "~"
        out<<_quoteModel->getContent(i)<<"~"<< _quoteModel->getTitle(i);
        file.close();
    }
}

void Mediator::removeQuote(int index){
    _quoteModel->removeQuote(index);
    quoteModelChanged();
    updateFile();
}

void Mediator::removeLastQuote(){
    _quoteModel->removeLastQuote();
    quoteModelChanged();
    updateFile();
}

void Mediator::insertQuote(QString content, QString title){
    myContent=content; //quote
    myTitle=title; //who said it
    _quoteModel->addQuote(Quotes(content,title));
    quoteModelChanged();
    updateFile();
}

QString Mediator::mTitle() const {
    return myTitle;
}

QString Mediator::mContent() const {
    return myContent;
}

QString Mediator::fixContent(QString content){
    if(content.contains("&")){
        content=content.replace(QRegularExpression("&#8217;"), "'");
        content=content.replace(QRegularExpression("&#8230;"), "...");
        content=content.replace(QRegularExpression("&#8211;"), "-");
        content=content.replace(QRegularExpression("&#8212;"), "-");
        //content=content.replace(QRegularExpression("&#8216;"), ",");
        content=content.replace(QRegularExpression("&#8220;"), "'");
        content=content.replace(QRegularExpression("&#8221;"), "'");
        content=content.replace(QRegularExpression("&#038;"), "&");
    }
    return content;
}

void Mediator::sendRequest() {
    QEventLoop eventLoop; // create custom temporary event loop on stack
    QNetworkAccessManager mgr;
    QObject::connect(&mgr, SIGNAL(finished(QNetworkReply*)), &eventLoop, SLOT(quit())); // "quit()" the event-loop, when the network request "finished()"

    do{
        QNetworkRequest req( QUrl( QString("http://quotesondesign.com/wp-json/posts?filter[orderby]=rand&filter[posts_per_page]=1") ) ); //http request
        QNetworkReply *reply = mgr.get(req);
        eventLoop.exec(); // blocks stack until "finished()" has been called

        if (reply->error() == QNetworkReply::NoError) {

            QString strReply = (QString)reply->readAll();
            QJsonDocument jsonResponse = QJsonDocument::fromJson(strReply.toUtf8());
            QJsonArray json_array = jsonResponse.array();

            foreach (const QJsonValue &value, json_array) {
                QJsonObject json_obj = value.toObject();

                QString url = json_obj["link"].toString();
                qDebug()<<url;

                QString title = json_obj["title"].toString();                //take the title from json
                QString content = json_obj["content"].toString();            //take the content from json
                content=content.remove(0,3);                                 //remove <p> from start of string
                content=content.remove(content.length()-5,content.length()); //remove <p> from start of string

                content=fixContent(content);
                title=fixContent(title);

                myTitle=title;
                myContent=content;
            }
            delete reply;
        }
        else {
            qDebug() << "Failure" <<reply->errorString(); //failure message
            delete reply;
        }
    }while(myContent.length()>=500);
}
