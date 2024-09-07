import sys
import os
from pathlib import Path
from PySide6.QtCore import QObject,Slot,Signal,QTranslator,QMetaObject,QThread
import time
import requests
import json

class Update_KYC(QThread):
    finished = Signal(int,dict)
    
    def __init__(self,main_app:QObject):
        QThread.__init__(self)
        self.main_app=main_app
        
    @Slot(dict)
    def sendRequest(self,data):
        self.data= data
        self.files={}
        for i in ['image','identity_image','signature']:
            if self.data.get(i):
                self.files[i]=open(self.data.get(i), mode='rb')
                self.data.pop(i, None)

        # self.files= {
        #     'image': open(self.data.get('image'), mode='rb'),
        #     'identity_image': open(self.data.get('identity_image'), mode='rb'),
        #     'signature': open(self.data.get('signature'), mode='rb'),
        # }
        # self.data.pop('image', None)
        # self.data.pop('identity_image', None)
        # self.data.pop('signature', None)
        self.start()
        
    
    def run(self):
        try:
            response=requests.post("http://127.0.0.1:8000/user/kyc/",data=self.data,files=self.files,headers={'Authorization': f'Token {self.main_app.user_info.get("token")}'})
            # if the status code is ok or created
            if response:
                self.main_app.user_kyc_info=response.json()
                print(self.main_app.user_kyc_info)
                
                self.main_app.engine.rootContext().setContextProperty('user_kyc_info',self.main_app.user_kyc_info)        
                
            print(response.json())
            # this is out of the if statement
            self.finished.emit(response.status_code,response.json())
        except:
            self.finished.emit(404,{'detail':'HOST_NOT_RESPONDING'})
            return
    
    