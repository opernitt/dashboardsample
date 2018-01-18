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

// The screen covers the device screen while the logo is animated
Rectangle {
    id: screen
    anchors.fill: parent
    color: "#f6f6f6" //"white"

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {

            //console.log("clicked...")
            clearSplash();
        }
    }

    Rectangle {
        id: logoScreen
        anchors.centerIn: parent
        //anchors.horizontalCenter: parent.horizontalCenter
        //anchors.verticalCenter: parent.verticalCenter
        //x: parent.width / 4
        //y: parent.height / 4
        width: screen.width / 2
        height: screen.height / 2

        // Logo animation (pseudo rotation)
        Behavior on width {
            NumberAnimation {
                duration: 240; easing.type: Easing.OutQuad
            }
        }

        // Animate the logo by squishing it, then expanding and mirroring it
        Timer {
            property int count : 0
            id: logoTimer
            interval: 240
            running: true
            repeat: true
            onTriggered: {
                switch (count++) {
                case 0:
                case 2:
                case 4:
                case 6:
                //case 8:
                //case 10:
                    logoScreen.width = 5;
                    break;

                case 1:
                case 3:
                case 5:
                case 7:
                //case 9:
                //case 11:
                    logoScreen.width = screen.width / 2;
                    logo.mirror = !logo.mirror;
                    break;

                //case 15:
                case 13:

                    // Clear the logo splash screen and show the UI
                    clearSplash()
                }

                //logo.height = 25;
                //logo.width = 25;
            }
        }

        Image {
            id: logo
            source: "img/logo.jpg"
            anchors.fill: parent
            width: 360 //sourceSize.width
            height: 270 //sourceSize.height
            //x: 0 //(parent.width - sourceSize.width) / 2;
            //y: 0 //(parent.height - sourceSize.height) / 2;
            onStatusChanged: {
                //console.log("Status changed to " + logo.status);
                //if (logo.status == Image.Ready)
                //    logo.width = 25;
            }
        }
    }

    // Clear the logo splash screen and show the UI
    function clearSplash() {
        screen.anchors.fill = undefined
        screen.width = 0;
        screen.height = 0;
        logoTimer.stop();
    }
}
