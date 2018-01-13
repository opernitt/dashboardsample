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
import QtQuick.Layouts 1.3
import FileIO 1.0

Item {
    id: root

    // Apps grid settings
    property int columns: 3 // 3 Apps per row

    Rectangle {
        color: "#161616"
        anchors.fill: parent
    }

    Image {
        id: bgimage
        source: "img/bg.jpg"
        opacity: .25
        anchors.fill: parent
    }

    Rectangle {
        id: mainContainer
        color: "#00000000"
        anchors.fill: parent
    }

    GlowText {
        text: qsTr("Apps")
        color: Global.darkBlue
        pixelSize: Global.fontSize
        x: 10
        y: 10
        width: 100
        height: 36
    }

    // Link to the EPG data file within the resource
    FileIO {
        id: jsonFile
        source: ""
        onError: console.log(msg)
    }

    // Set up the Apps grid when the UI is loaded
    Component.onCompleted: setupGrid()

    // I am using a GridLayout here to allow for automatic resizing.
    // On an embedded device, the screen would likely not be
    // resizable and a more static approach could be more efficient.
    // A more elegant approach could be to implement the dynamic code
    // creation in C++ but that would not separate the UI
    // from the business logic
    function setupGrid() {
        var compSrc = "import QtQuick 2.2; import QtQuick.Layouts 1.3\n" +
            "GridLayout {" +
            "id: appGrid;" +
            //"anchors.topMargin: 5;" +
            //"anchors.bottomMargin: 5;" +
            "anchors.rightMargin: 15;" +
            "anchors.leftMargin: 15;" +
            "anchors.fill: parent;" +
            //"anchors.centerIn: parent;" +
            "columnSpacing: 2;" +
            "rowSpacing: 2;" +
            "rows: 2\;" +                  // 2 rows should be sufficient for now
            "columns: " + columns + "\n"    // 4 columns per row

        // Add the supported Apps from apps.json db
        compSrc += processAppsData()

        // Complete the GridLayout
        compSrc += "}"
        print (compSrc)

        // Create the Apps Grid
        Qt.createQmlObject(compSrc, mainContainer)
    }

    function processAppsData() {
        var compSrc = ""

        // Read the context of the Json data and parse it
        var raw = readJsonFile(":/apps.json")

        try {
            var jsonData = JSON.parse(raw);
            //print(jsonData)

            var apps = jsonData["apps"]

            // Add the Apps
            for (var cnt = 0; cnt < apps.length; cnt++) {
                compSrc += addApp(cnt % columns, Math.floor(cnt / columns, 10), apps[cnt]["name"], apps[cnt]["desc"], apps[cnt]["icon"], apps[cnt]["url"])
            }
        }
        catch (e) {
            console.log(e)
        }

        // Return the completed Item(s)
        return compSrc
    }

    // Add an App
    function addApp(column, row, name, desc, icon, url)
    {
        // Add the AppItem
        var compSrc = "AppItem {" +
                "Layout.column: " + column + ";" +
                "Layout.row: " + row + ";" +
                "name: \"" + name + "\";" +
                "desc: \"" + desc + "\";" +
                "icon: \"img/" + icon + "\";" + // Built-in images are stored under :/img
                "url: \"" + url + "\";" +
                "width: appWindow.width / (columns + 1);" +
                "height: width + 16;" +
                "color: Global.darkBlue" +
                "}\n"
        return compSrc
    }

    // See http://doc.qt.io/qt-5/resources.html
    function readJsonFile(url) {
        jsonFile.setSource(url)
        var data = jsonFile.read()
        //print(data);
        return data
    }

    // Signal when an app is launched
    signal appLaunched(string icon, string name, string desc, string url)

    // Handle when an app is launched
    onAppLaunched: {

        console.log("Launching App " + name)

        // Make sure we have a valid url
        if (url.length) {

        }
        else {
            messageBox(icon, name, desc, "Does not provide a valid url!")
        }
    }

    AppMessageBox {
        id: popup
        color: Global.darkBlue
        visible: false
    }

    function messageBox(icon, name, desc, msg) {
        popup.icon  = icon
        popup.name  = name
        popup.desc  = desc
        popup.msg   = msg
        popup.visible = true
    }
}
