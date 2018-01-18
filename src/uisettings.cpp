/****************************************************************************
**
** Copyright (C) 2018 Olaf Pernitt
** Contact: https://www.linkedin.com/in/opernitt/
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** This software is licensed under the GNU General Public License v3.0
** Permissions of this strong copyleft license are conditioned on making
** available complete source code of licensed works and modifications,
** which include larger works using a licensed work, under the same license.
** Copyright and license notices must be preserved.
** Contributors provide an express grant of patent rights.
**
****************************************************************************/

#include "uisettings.h"
#include <QGuiApplication>
#include <QDebug>

/*
 * The UiSettings class handles any changes made to the Settings UI screen
 */
UiSettings::UiSettings(QObject *parent) :
    QObject(parent),
    m_pTranslator(NULL)
{
}

/*
 * Store the QTranslator instance to be able to switch the UI language on-the-fly
 */
void UiSettings::setTranslator(QTranslator *pTranslator)
{
    // Store the QTranslator instance
    m_pTranslator = pTranslator;
}

/*
 * This slot is called whenever a UI language is selected in the UiSettings UI screen
 * When the UI language is changed, the languageChanged signal is emitted and
 * UI strings are reloaded.
 */
void UiSettings::languageSelectedSlot(QString language)
{
    // Make sure the language is changing
    if (m_Language != language)
    {
        qDebug() << "UI Language selected: " << language;
        if (!m_pTranslator)
            qWarning() << "No Translator available!";
        else
        {
            // Reset the current UI language
            if (qApp)
                qApp->removeTranslator(m_pTranslator);

            // Default (en) is built-in and does not require a translation file
            if (language != "en")
            {
                // Load the specified language
                if (!m_pTranslator->load("dashboard_" + language, ":/"))
                    qWarning() << "Translator failed to load resource for language " << language;
                else
                {
                    // Update the language
                    // Emit the Signal that the language changed
                    // All UI pages using emptyString() will be reloaded
                    m_Language = language;
                    emit languageChanged();
                }
            }
        }
    }
}
