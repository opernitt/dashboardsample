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

import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3

Item {
    id: settings

    Image {
        id: bgimage
        source: "img/bgpolaris.jpg"
        opacity: .4
        anchors.fill: parent
    }

    GlowText {
        text: qsTr("Settings")
        color: Global.darkBlue
        pixelSize: Global.fontSize
        x: 10
        y: 10
        width: 100
        height: 36
    }

    GroupBox {
        title: "Units"
        x: 15
        y: 50

        RowLayout {
            ExclusiveGroup { id: tabUnitsGroup }
            RadioButton {
                text: "mph"
                checked: Global.metricUnits === false
                exclusiveGroup: tabUnitsGroup
                style: RadioButtonStyle {
                }
            }
            RadioButton {
                text: "km/h"
                checked: Global.metricUnits === true
                exclusiveGroup: tabUnitsGroup
                style: RadioButtonStyle {
                }
                onCheckedChanged: Global.metricUnits = checked
            }
        }
    }

    GroupBox {
        title: "Language"
        x: 15
        y: 100

        RowLayout {
            ExclusiveGroup { id: tabLanguageGroup }
            RadioButton {
                text: "English"
                checked: true
                exclusiveGroup: tabLanguageGroup
            }
        }
    }

    GroupBox {
        title: "Other"
        x: 15
        y: 150

        RowLayout {
            CheckBox {
                text: "On"
                checked: Global.other
            }
        }
    }
}
