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
import QtQuick.Window 2.2
import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.4
import "." // Import Global settings module

Item {
    id: root
    Rectangle {
        color: "#161616"
        anchors.fill: parent
    }

    MouseArea {
        anchors.fill: parent
        onPressed: speedGauge.accelerating = true
        onReleased: speedGauge.accelerating = false
        onVisibleChanged: speedGauge.accelerating = false
    }

    Image {
        id: bgimage
        source: "img/bg.jpg"
        opacity: .25
        anchors.fill: parent
        mirror: true
    }

    Item {
        id: container
        width: root.width
        height: Math.max(root.width, root.height)
        anchors.centerIn: parent

        Row {
            id: gaugeRow
            spacing: container.width * 0.001
            anchors.centerIn: parent

            Item {
                width: height
                height: container.height * 0.35 - gaugeRow.spacing
                anchors.verticalCenter: parent.verticalCenter

                TurnIndicator {
                    id: leftIndicator
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: height
                    height: parent.height / 5
                    direction: Qt.LeftArrow
                    on: Global.turnSignal === Qt.RightArrow
                }

                // RPM Indicator (< 8000 RPM)
                CircularGauge {
                    id: rpmGauge
                    minimumValue: 0
                    maximumValue: 8
                    value: 0.7 + (Global.gears * (maximumValue - 2) * (Global.speed-1) / Global.maxSpeed) % (maximumValue - 2)
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: parent.height / 2 - height / 3 - container.height * 0.01
                    width: parent.width
                    height: parent.height * 0.6
                    style: TachometerStyle {}

                    Behavior on value {
                        NumberAnimation {
                            duration: 120
                        }
                    }
                }
            }

            // Speed Indicator
            CircularGauge {
                id: speedGauge
                maximumValue: Global.maxSpeed
                value: accelerating ? maximumValue : 0
                width: height
                height: container.height * 0.4

                Behavior on value {
                    NumberAnimation {
                        duration: 15000
                        //easing.type: Easing.InOutSine
                    }
                }

                style: DashboardGaugeStyle {
                    unitsText: Global.metricUnits ? "km/h" : "mph"
                }

                property bool accelerating: false

                // Accelerate while [SPACE] is pressed
                Keys.onSpacePressed: accelerating = true
                Keys.onReleased: {
                    if (event.key === Qt.Key_Space) {
                        accelerating = false;
                        event.accepted = true;
                    }
                }

                Component.onCompleted: forceActiveFocus()
            }

            // Instrument Cluster (Temp / Fuel Gauges)
            Item {
                width: height
                height: container.height * 0.35 - gaugeRow.spacing
                anchors.verticalCenter: parent.verticalCenter

                // Right Turn Signal
                TurnIndicator {
                    id: rightIndicator
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: height
                    height: parent.height / 5

                    direction: Qt.RightArrow
                    on: Global.turnSignal === Qt.RightArrow
                }

                CircularGauge {
                    id: fuelGauge
                    value: Global.fuel
                    maximumValue: 1
                    y: parent.height / 2 - height / 2 - container.height * 0.01
                    width: parent.width
                    height: parent.height * 0.4

                    style: IconGaugeStyle {
                        id: fuelGaugeStyle

                        icon: "img/fuel-icon.png"
                        minWarningColor: Qt.rgba(0.5, 0, 0, 1)

                        tickmarkLabel: Text {
                            color: "white"
                            visible: styleData.value === 0 || styleData.value === 1
                            font.pixelSize: fuelGaugeStyle.toPixels(0.225)
                            text: styleData.value === 0 ? "E" : (styleData.value === 1 ? "F" : "")
                        }
                    }
                }

                CircularGauge {
                    value: Global.temperature
                    maximumValue: 1
                    width: parent.width
                    height: parent.height * 0.4
                    y: parent.height / 2 + container.height * 0.01

                    style: IconGaugeStyle {
                        id: tempGaugeStyle

                        icon: "img/temperature-icon.png"
                        maxWarningColor: Qt.rgba(0.5, 0, 0, 1)

                        tickmarkLabel: Text {
                            color: "white"
                            visible: styleData.value === 0 || styleData.value === 1
                            font.pixelSize: tempGaugeStyle.toPixels(0.225)
                            text: styleData.value === 0 ? "C" : (styleData.value === 1 ? "H" : "")
                        }
                    }
                }
            }
        }
    }

    // A Timer used to actuate the turn signal(s) randomly
    Timer {
        id: blinkerTimer
        interval: 3000
        repeat: true
        running: true
        onTriggered: {
            Global.turnSignal = Math.random() < 0.5 ? -1 : Math.random() < 0.75 ? Qt.LeftArrow : Qt.RightArrow;
            //console.log("turnSignal = " + Global.turnSignal)
            if (Global.turnSignal === Qt.LeftArrow) {
                rightIndicator.on = false
                leftIndicator.on = true
            }
            else if (Global.turnSignal === Qt.RightArrow) {
                rightIndicator.on = true
                leftIndicator.on = false
            }
            else {
                rightIndicator.on = false
                leftIndicator.on = false
            }
        }
    }

    // Update the Global object
    Connections {

        // Update the RPM
        target: rpmGauge
        onValueChanged: {
            Global.rpm = rpmGauge.value
            //console.log("RPM: " + Global.rpm);
        }
    }
    Connections {
        // Update the speed and gear
        target: speedGauge
        onValueChanged: {
            Global.speed = speedGauge.value
            Global.gear = !speedGauge.value ? "N" : parseInt(Global.gears*(speedGauge.value-1)/speedGauge.maximumValue+1).toString()
            //console.log("Speed: " + Global.speed + ", gear: " + Global.gear);
        }
    }

    // Handle Settings changes
    Connections {
        // Update the speed and gear
        target: Global
        onMetricUnitsChanged: {
            //console.log("Metric units: " + Global.metricUnits);
        }
    }

    // Handle SwipeView changes
    // Stop accelerating (we are not getting a mouse released)
    Connections {
        target: swipeView
        onIndexChanged: {
            //console.log("New SwipeView index is: " + index)
            speedGauge.accelerating = false
            //speedGauge.value = 0
        }
    }
}
