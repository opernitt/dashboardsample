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

import QtQuick 2.0
import QtQuick.Controls 2.2

Popup {
    id: popup
    x: (root.width) / 2 - (width / 2)
    y: (root.height) / 2 - (height / 2)
    width: 320
    height: 100
    modal: true
    dim: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    property string name
    property string icon
    property string desc
    property string msg
    property string color

    Rectangle {
        color: popup.color
        anchors.fill: parent

        Image {
            id: icon
            source: popup.icon
            width: 64
            height: width
            x: 5
            y: 5
        }

        Text {
            id: name
            text: popup.name + ":"
            color: "white"
            x: icon.x + icon.width + 5
            y: 5
        }

        Text {
            id: msg
            text: popup.msg
            color: "white"
            x: icon.x + icon.width + 5
            y: name.y + name.height + 5
        }

        Text {
            id: desc
            text: popup.desc
            color: "white"
            x: icon.x + icon.width + 5
            y: msg.y + msg.height + 5
        }
    }

    // Close the popup when it is clicked
    // It is automatically closed after clicking outside of it
    MouseArea {
        anchors.fill: parent
        onClicked: popup.close()
    }
}
