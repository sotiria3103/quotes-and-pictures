#ifndef QUOTEMODEL_H
#define QUOTEMODEL_H
#include <QObject>
#include <QAbstractListModel>
#include "quotes.h"
class QuoteModel : public QAbstractListModel
{
    Q_OBJECT
    public:
        enum QuoteRoles {
            ContentRole = Qt::UserRole + 1,
            TitleRole
        };
        //enum ColorRoles {
          //  NameRole = Qt::UserRole + 1,
            //ColorRole
        //};
        QuoteModel(QObject *parent = 0);
        void addQuote(const Quotes &quote);
        void removeQuote (int index);
        void removeLastQuote();
        int rowCount(const QModelIndex & parent = QModelIndex()) const;
        QVariant data(const QModelIndex &index, int role=Qt::DisplayRole) const;
        QString getContent(int i);
        QString getTitle(int i);
    protected:
        QHash<int, QByteArray> roleNames() const;
    private:
        QList<Quotes> m_quotes;
};

#endif // QUOTEMODEL_H
