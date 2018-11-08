#include "quotemodel.h"

QuoteModel::QuoteModel(QObject *parent): QAbstractListModel(parent) {
}
void QuoteModel::addQuote(const Quotes &quote){
    if(m_quotes.contains(quote)==false){ //it doesn't add the quote if it already exists
        beginInsertRows(QModelIndex(), rowCount(), rowCount());
        m_quotes << quote;
        endInsertRows();
    }
}

void QuoteModel::removeQuote(int index) {

    beginRemoveRows(QModelIndex(), index, index);
    m_quotes.removeAt(index);
    endRemoveRows();
}

void QuoteModel::removeLastQuote() {
    beginRemoveRows(QModelIndex(), m_quotes.length()-1, m_quotes.length()-1);
    m_quotes.removeAt(m_quotes.length()-1);
    endRemoveRows();
}

int QuoteModel::rowCount(const QModelIndex & parent) const {
    Q_UNUSED(parent);
    return m_quotes.count();
}
QVariant QuoteModel::data(const QModelIndex & index, int role) const {
    if (index.row() < 0 || index.row() >= m_quotes.count())
        return QVariant();
    const Quotes &quote = m_quotes[index.row()];
    if (role == ContentRole)
        return quote.content();
    else if (role==TitleRole)
        return quote.title();
    return QVariant();
}
QHash<int, QByteArray> QuoteModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[ContentRole] = "content";
    roles[TitleRole]="qtitle";
    return roles;
}

QString QuoteModel::getContent(int i)
{
    if (i>=0 && i<m_quotes.count())
        return m_quotes[i].content();
    return NULL;
}
QString QuoteModel::getTitle(int i)
{
    if (i>=0 && i<m_quotes.count())
        return m_quotes[i].title();
    return NULL;
}
