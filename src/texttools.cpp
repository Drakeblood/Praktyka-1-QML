#include "include/texttools.h"

#include "QtConcurrent/QtConcurrent"

TextTools::TextTools(QObject *parent)
    : QObject(parent)
    , inputTextAreaTextNative("")
    , textProcessMethodNative(TextProcessMethod::Reverse)
{

}

void TextTools::processText()
{
    switch(textProcessMethodNative)
    {
        case TextProcessMethod::Reverse:
        {
            QFuture<void> future = QtConcurrent::run(this, &TextTools::ReverseProcess);
            break;
        }

        case TextProcessMethod::LowerCase:
        {
            QFuture<void> future = QtConcurrent::run(this, &TextTools::LowerCaseProcess);
            break;
        }

        case TextProcessMethod::UpperCase:
        {
            QFuture<void> future = QtConcurrent::run(this, &TextTools::UpperCaseProcess);
            break;
        }
    }
}

QString TextTools::inputTextAreaText() const
{
    return inputTextAreaTextNative;
}

void TextTools::setinputTextAreaText(QString value)
{
    if(inputTextAreaTextNative != value)
    {
        inputTextAreaTextNative = value;
        emit inputTextAreaTextChanged();
    }
}

QString TextTools::resultTextAreaText() const
{
    return resultTextAreaTextNative;
}

void TextTools::setResultTextAreaText(QString value)
{
    if(resultTextAreaTextNative != value)
    {
        resultTextAreaTextNative = value;
        emit resultTextAreaTextChanged();
    }
}

TextTools::TextProcessMethod TextTools::textProcessMethod() const
{
    return textProcessMethodNative;
}

void TextTools::setTextProcessMethod(TextProcessMethod value)
{
    if(textProcessMethodNative != value)
    {
        textProcessMethodNative = value;
        emit textProcessMethodChanged();
    }
}

void TextTools::ReverseProcess()
{
    for(long long i = 0; i < 500000000; i++)
    {
        int a = 2;
        a++;
        int b = 4;
        b++;
        b = a = a + b;
    }
    QString reversedText = inputTextAreaTextNative;
    std::reverse(reversedText.begin(), reversedText.end());
    setResultTextAreaText(reversedText);
}

void TextTools::LowerCaseProcess()
{
    setResultTextAreaText(inputTextAreaTextNative.toLower());
}

void TextTools::UpperCaseProcess()
{
    setResultTextAreaText(inputTextAreaTextNative.toUpper());
}
