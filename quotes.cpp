#include <QEventLoop>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>
#include <iostream>
#include <fstream>
#include <string>
#include <QFile>
#include <QTextStream>
#include <QObjectList>
#include <QRegularExpression>
#include "quotes.h"

Quotes::Quotes(const QString &content, const QString &title/*, QObject *parent*/)
               // :QObject(parent),
    :m_title(title), m_content(content)
{
}

QString Quotes::title() const {
    return m_title;
}

void Quotes::setTitle(const QString &title)  {
    if (title != m_title) {
        m_title = title;
        //emit nameChanged();
    }
}

QString Quotes::content() const {
    return m_content;
}

void Quotes::setContent(const QString &content) {
    if (content != m_content) {
        m_content = content;
        //emit colorChanged();
    }
}

