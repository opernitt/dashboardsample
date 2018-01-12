# Dashboard Sample
An example Qt QML App depicting a dashboard

Check out the source files and build the project using
```
qmake
make
```

This sample UI demonstrates various Qt features:
* Mouse/key event handling
* Signal/Slot signaling
* State changes
* Dynamic loading (qrc:/)
* Dynamic contents generation based on data (Json file with mock-up App store)
* Transitioning
* Animations
* UI Navigation (swipe, mouse, keyboard)
* C++/Qml integration

### Prerequisites
```
Qt 5.9.x
```

## Navigating the Sample App
From the main screen, a mock App Store and Settings can be opened with a Swipe to the right or left.
The main screen shows a basic dashboard, which can be animated using the mouse key or touch on a handheld device (such as Raspberry Pi with touchscreen display).

## Missing items and next steps in this project
This project was put together quickly to demonstrate some of Qt's capabilities. The following items will be implemented next:
1. Complete the UI
2. Organize the UI classes (subfolders for /EPG, /AppStore, etc)
3. Add proper comments and documentation so Doxygen can be used to generate a reference guide
4. Add Unit Tests to cover the Controller code (C++)
5. Add End-to-end (E2E) tests to cover the UI (using WebDriver)
6. Add (cross-compile) embedded Linux build and add a recipe to include this project (Yocto)

## Running the tests
Unit and E2E Tests are required

## Deployment
A cross-compile script will be added

## Built With
* [Yocto](https://www.yoctoproject.org/) - Yocto bitbake used to cross-compile
* [Qt/QtCreator](https://www.qt.io/qt-features-libraries-apis-tools-and-ide/) - QtCreator and tools

## Contributing
Contributions are not currently accepted.

## Versioning
We use [Git tagging](https://git-scm.com/book/en/v2/Git-Basics-Tagging) for versioning. 

## Authors
* **Olaf Pernitt** - *Initial work* - [email](mailto:olaf@pernitt.com)

## License
This project is licensed under the GPLv3 License - see the [LICENSE.md](LICENSE.md) file for details.

## Acknowledgments
* The Qt Company

## Trademarks and Copyright
Any trademarks are those of the respective owners.
