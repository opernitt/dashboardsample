#ifndef UISETTINGS_H
#define UISETTINGS_H

#include <QObject>
#include <QString>
#include <QTranslator>

/*
 * The UiSettings class handles changes made on the Settings UI
 * This includes handling a UI language change
 */
class UiSettings : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString emptyString READ getEmptyString NOTIFY languageChanged)

public:
    explicit UiSettings(QObject *parent = nullptr);
    void setTranslator(QTranslator *pTranslator);
    //QString getEmptyString() { return "!"+m_Language; }
    QString getEmptyString() { return ""; }

signals:
    void languageChanged();

    // Public slots used to handle signals from the UI
public slots:
    void languageSelectedSlot(QString language);

private:
    QTranslator*    m_pTranslator;  // The QTranslator instance
    QString         m_Language;     // The current UI Language
};

#endif // UISETTINGS_H
