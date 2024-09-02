import sys
from pathlib import Path
from PySide6.QtCore import QObject,Slot,Signal,QTranslator,QMetaObject,QThread
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtWidgets import QApplication
from PySide6.QtGui import QIcon

from auth.AuthWindow import AuthWindow 
from application.AppWindow import AppWindow
import os
class MainApp(QObject):
    def __init__(self) :
        super().__init__()
        self.app = QApplication(sys.argv)
        self.engine = QQmlApplicationEngine()
        self.app.setWindowIcon(QIcon(str(Path(__file__).resolve().parent / 'application/res/images/banky_logo.svg')))
        
        
        # self.translator = QTranslator(self.app)
        # self.translator.load(str(Path(__file__).resolve().parent /'TranslationFile.qm'))
        # self.app.installTranslator(self.translator)

        
        
        self.DEFAULT_IMPORTPATHLIST=self.engine.importPathList()
        self.engine.rootContext().setContextProperty('main_app',self)
        self.engine.rootContext().setContextProperty('baseDir',os.getcwd().replace("\\", "/"))
        # print(os.getcwd().replace("\\", "/"))
        
        self.goToApp()
        
        
        self.engine.load(Path(__file__).resolve().parent / "main.qml")
        # self.engine.load(Path(__file__).resolve().parent / "test.qml")
        if not self.engine.rootObjects():
            sys.exit(-1)

        self.app.exec()
        
    @Slot()
    def goToApp(self):
        self.engine.setImportPathList(self.DEFAULT_IMPORTPATHLIST)
        # self.tokenUser =self.
        # making token verfication
        am_appli = AppWindow(self)

    @Slot()
    def goToAuth(self):
        self.engine.setImportPathList(self.DEFAULT_IMPORTPATHLIST)
        auth= AuthWindow(self)


if __name__ == "__main__":
    main_application=MainApp()