import sys
import os
from pathlib import Path
from PySide6.QtCore import QObject,Slot,Signal,QTranslator,QMetaObject,QThread
import time
import requests
import json

class Search_Acc(QThread):
    finished = Signal(int,dict)
    
    def __init__(self,main_app:QObject):
        QThread.__init__(self)
        self.main_app=main_app
        
    @Slot(dict)
    def sendRequest(self,data):
        self.data=data
        self.start()
        
    
    def run(self):
        try:
            response=requests.get("http://127.0.0.1:8000/search-account/",data=self.data,headers={'Authorization': f'Token {self.main_app.user_info.get("token")}'})
            # if the status code is ok or created
            
            self.finished.emit(response.status_code, response.json())
        except:
            self.finished.emit(404,{'detail':'HOST_NOT_RESPONDING'})
            return
    
    