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
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

// Our touch screen has a native resolution of 480x320
ApplicationWindow {
    id: appWindow
    visible: true
    width: 480
    height: 320
    title: qsTr("Dashboard Sample")

    // The SwipeView allows easily swipe between screens
    // We provide 3 screens:
    // 0: Settings (swipe right)
    // 1: Dashboard (default)
    // 2: App Store (swipe left)
    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: 1 //tabBar.currentIndex

        // Signal when the SwipeView index changed
        signal indexChanged(int index);
        onCurrentIndexChanged: indexChanged(currentIndex);

        // The Settings screen (swipe right)
        Settings {
        }

        // The Dashboard
        Dashboard {
        }

        // The Apps screen (swipe left)
        Apps {
        }
    }

/*    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("First")
        }
        TabButton {
            text: qsTr("Second")
        }
    }
*/
    LogoSplash {
        id: logoSplash
        anchors.fill: parent
    }
}
