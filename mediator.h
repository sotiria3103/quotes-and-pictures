#ifndef MEDIATOR_H
#define MEDIATOR_H
#include <QObject>
#include"quotemodel.h"

class Mediator : public QObject {
    QuoteModel *_quoteModel;
    Q_OBJECT
    Q_PROPERTY(QuoteModel* myModel READ myModel WRITE setQuoteModel NOTIFY quoteModelChanged)
    QString path;
    QString myTitle;
    QString myContent;
public:

    explicit Mediator(QObject *parent = 0);
    void setQuoteModel(QuoteModel* m)    {
        _quoteModel = m;
        emit quoteModelChanged();
    }
    QuoteModel* myModel()    {
        return _quoteModel;
    }
    void updateFile();
    QString fixContent(QString content);
    Q_INVOKABLE void sendRequest();
    Q_INVOKABLE QString mTitle() const;
    Q_INVOKABLE QString mContent() const;
signals:
    void quoteModelChanged();
public slots:
    void insertQuote(QString content,QString title);
    void removeQuote(int index);
    void removeLastQuote();
};
#endif // MEDIATOR_H
