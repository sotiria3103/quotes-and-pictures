#ifndef QUOTES_H
#define QUOTES_H

#include <QObject>

class Quotes //: public QObject
{
    private:
        QString m_title; //the name of the person who said/wrote the quote
        QString m_content; //the quote

        //Q_OBJECT
        //Q_PROPERTY(QString title READ title WRITE setTitle)
        //Q_PROPERTY(QString content READ content WRITE setContent)
        //Q_PROPERTY(QString request READ request WRITE setRequest)
    public:
        bool operator==(const Quotes &q) const {
                return (q.m_title == m_title && q.m_content == m_content);
            }
        Quotes(QObject *parent=0);
        Quotes(const QString &content, const QString &title/*, QObject *parent=0*/);
        QString title() const;
        void setTitle(const QString &title);
        QString content() const;
        void setContent(const QString &context);
        //QString fixContent(QString content);
        //Q_INVOKABLE void sendRequest();
        //Q_INVOKABLE void saveFavorite();
        //Q_INVOKABLE void listFavorite();
};

#endif // QUOTES_H
