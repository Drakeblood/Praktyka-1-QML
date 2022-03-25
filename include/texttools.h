#ifndef TEXTTOOLS_H
#define TEXTTOOLS_H

#include <QObject>

class TextTools : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString inputTextAreaText READ inputTextAreaText WRITE setinputTextAreaText NOTIFY inputTextAreaTextChanged)
    Q_PROPERTY(QString resultTextAreaText READ resultTextAreaText WRITE setResultTextAreaText NOTIFY resultTextAreaTextChanged)
    Q_PROPERTY(TextProcessMethod textProcessMethod READ textProcessMethod WRITE setTextProcessMethod NOTIFY textProcessMethodChanged)

public:
    enum TextProcessMethod
    {
        Reverse,
        LowerCase,
        UpperCase
    };
    Q_ENUM(TextProcessMethod)

private:
    QString inputTextAreaTextNative;
    QString resultTextAreaTextNative;
    TextProcessMethod textProcessMethodNative;

public:
    explicit TextTools(QObject *parent = nullptr);

signals:
    void inputTextAreaTextChanged();
    void resultTextAreaTextChanged();
    void textProcessMethodChanged();

public slots:
    void processText();

private:
    QString inputTextAreaText() const;
    void setinputTextAreaText(QString value);

    QString resultTextAreaText() const;
    void setResultTextAreaText(QString value);

    TextProcessMethod textProcessMethod() const;
    void setTextProcessMethod(TextProcessMethod value);

    void ReverseProcess();
    void LowerCaseProcess();
    void UpperCaseProcess();

};

#endif // TEXTTOOLS_H
