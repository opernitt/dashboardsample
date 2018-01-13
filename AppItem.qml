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

import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Item {
    id: item

    // AppItem properties
    property string name    // The App's name
    property string desc    // The App's description
    property string url     // The App's url
    property string icon    // The App's app store icon
    property string color   // The App's background color

    Rectangle {
        id: rect
        color: Qt.lighter(item.color, 3.0)
        radius: 3
        border.color: "#f0f0f0"
        border.width: 2
        anchors.fill: parent
        //Component.onCompleted: console.log("width = " + width + ", height = " + height)

        Column {
            id: column
            topPadding: 5
            Image {
                id: image
                source: item.icon
                opacity: 1
                //anchors.horizontalCenter: column.horizontalCenter
                //anchors.topMargin: 5
                width: item.width * .9
                x: item.width * .05
                height: width
            }
            Text {
                id: text
                text: item.name
                color: "black"
                font.pixelSize: 16
                font.family: "helvetica"
                anchors.horizontalCenter: column.horizontalCenter
            }
        }
    }

    /*Glow {
        anchors.fill: rect
        radius: 3
        samples: 17
        color: Qt.lighter(item.color, 1.0)
        source: rect
    }*/

    MouseArea {
        anchors.fill: parent
        onPressed: rect.color = "yellow"
        onReleased: {

            rect.color = Qt.lighter(item.color, 3.0)
            root.appLaunched(item.icon, item.name, item.desc, item.url)
        }
    }
}
