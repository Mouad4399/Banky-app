import sys
import os
from pathlib import Path
from PySide6.QtCore import QObject,Slot,Signal,QTranslator,QMetaObject,QThread
import time
import requests
import json

class Get_Acc(QThread):
    finished = Signal(int,dict)
    
    def __init__(self,main_app:QObject):
        QThread.__init__(self)
        self.main_app=main_app
        
    @Slot()
    def sendRequest(self):
        self.start()
        
    
    def run(self):
        try:
            response=requests.get("http://127.0.0.1:8000/user/acc/",headers={'Authorization': f'Token {self.main_app.user_info.get("token")}'})
            # if the status code is ok or created
            if response:
                self.main_app.user_acc_info=response.json()
                print(self.main_app.user_acc_info)
                
                self.main_app.engine.rootContext().setContextProperty('user_acc_info',self.main_app.user_acc_info)        
                
                
                self.finished.emit(response.status_code,response.json())
            else:
                self.finished.emit(response.status_code, response.json())
        except:
            self.finished.emit(404,{'detail':'HOST_NOT_RESPONDING'})
            return
    
    