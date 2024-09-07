import sys
import os
from pathlib import Path
from PySide6.QtCore import QObject,Slot,Signal,QTranslator,QMetaObject,QThread
import time
import requests
import json

class Register(QThread):
    finished = Signal(int,dict)
    
    def __init__(self,main_app:QObject):
        QThread.__init__(self)
        self.main_app=main_app
        
    @Slot(dict)
    def sendRequest(self,data:dict):
        self.data= data
        
        self.start()
        
    
    def run(self):
        try:
            response=requests.post("http://127.0.0.1:8000/user/sign-up/",data=self.data)

            if response:
                self.main_app.user_info=response.json()
                self.main_app.user_info['email']=self.data.get('email')
                print(self.main_app.user_info)
                
                self.main_app.engine.rootContext().setContextProperty('user_info',self.main_app.user_info)        
                
                # self.main_app.engine.rootContext().setContextProperty('user_profile_info',self.main_app.user_profile_info)        
                
            self.finished.emit(response.status_code,response.json())

        except:
            self.finished.emit(404,{'detail':'HOST_NOT_RESPONDING'})
            return
    