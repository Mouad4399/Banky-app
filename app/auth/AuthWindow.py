# This Python file uses the following encoding: utf-8
import os
import sys
from pathlib import Path
from PySide6.QtGui import QGuiApplication,QClipboard
from PySide6.QtCore import QObject,Slot,Property,QCoreApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtWidgets import QApplication,QFileDialog

from .res.images.ImageProvider import ImageProvider
from .models.Authenticate import Authenticate
from .models.Register import Register

class AuthWindow(QObject):
    def __init__(self,main_app:QObject):
        super().__init__()

        main_app.img=ImageProvider()
        main_app.window = self
        main_app.engine.rootContext().setContextProperty('window',main_app.window)
        main_app.engine.addImageProvider("img", main_app.img)
        
        
        self.authenticate=Authenticate(main_app)
        self.register=Register(main_app)
        
        
        main_app.engine.addImportPath(Path(__file__).resolve().parent /"views")
        main_app.engine.addImportPath(Path(__file__).resolve().parent /"res")
        main_app.engine.rootContext().setContextProperty('current_view','./auth/main.qml')

    @Slot(str,result=QObject)
    def getAttr(self,attr_name):
        return getattr(self, attr_name)

    @Slot()
    def disp(self):
        print('I am in auth')

    @Slot(result=str)
    def getPaste(self):
        cb = QClipboard(self)
        return cb.text()
    
