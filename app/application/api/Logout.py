import sys
import os
from pathlib import Path
from PySide6.QtCore import QObject,Slot,Signal,QTranslator,QMetaObject,QThread
import time
import requests
import json

class Logout(QThread):
    finished = Signal(int,dict)
    
    def __init__(self,main_app:QObject):
        QThread.__init__(self)
        self.main_app=main_app
        
    @Slot()
    def sendRequest(self):
        self.start()
        
    
    def run(self):
        try:
            response=requests.post("http://127.0.0.1:8000/user/logout/",headers={'Authorization': f'Token {self.main_app.user_info.get("token")}'})

            if response:
                # self.main_app.user_info=response.json()
                print("Logout ...")
                print(self.main_app.user_info)
                
                # self.main_app.engine.rootContext().setContextProperty('user_info',self.main_app.user_info)        
                
                # self.main_app.engine.rootContext().setContextProperty('user_profile_info',self.main_app.user_profile_info)        
                
                self.finished.emit(response.status_code,response.json())
            else:
                print("logout.py : there is some problem")
                details= response.json()
                print(details)
                self.finished.emit(response.status_code, response.json())
                
        except:
            self.finished.emit(404,{'detail':'HOST_NOT_RESPONDING'})
            return
       
    
    
