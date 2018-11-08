#ifndef IMAGES_H
#define IMAGES_H

#include <QObject>
#include <QQuickImageProvider>

class Images : public QObject, public QQuickImageProvider
{
    //Q_OBJECT
    public:
        explicit Images();
        Q_INVOKABLE virtual QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize);
};

#endif // IMAGES_H
