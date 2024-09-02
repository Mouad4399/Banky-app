import sys
import os
from pathlib import Path
from PySide6.QtCore import QObject,Slot,Signal,QTranslator,QMetaObject,QThread
import time
import requests
import json

class Authenticate(QThread):
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
            response=requests.post("http://127.0.0.1:8000/user/login/",json=self.data)

            if response:
                self.main_app.user_info=response.json()
                print(self.main_app.user_info)
                
                self.main_app.engine.rootContext().setContextProperty('user_info',self.main_app.user_info)        
                
                # self.main_app.engine.rootContext().setContextProperty('user_profile_info',self.main_app.user_profile_info)        
                
                self.finished.emit(response.status_code,response.json())
            else:
                details= response.json()
                print(details)
                self.finished.emit(response.status_code, response.json())
        except:
            self.finished.emit(404,{'detail':'HOST_NOT_RESPONDING'})
            return
    
    
    
    
    
    
    # def run(self):
    #     data_json = self.connexion.__dict__
    #     auth_reponse=VuePost.envoyer_donnees('http://127.0.0.1:8000/api-interne/v1/gestion-magasin/connexion', data_json)
    #     try:
    #         if auth_reponse.status_code == 200:
    #             self.main_app.user_app_info =auth_reponse.json()
    #             self.main_app.engine.rootContext().setContextProperty('user_app_info',self.main_app.user_app_info)        
    #             print(self.main_app.user_app_info["employe_id"])
    #             response_data=requests.get( f'http://127.0.0.1:8000/api-interne/v1/gestion-magasin/employe/get/employes-informations/employe/{self.main_app.user_app_info["employe_id"]}').json()
    #             self.main_app.user_profile_info=next((item for item in response_data if item.get('email') == data_json['email']), None)
                
    #             self.main_app.engine.rootContext().setContextProperty('user_profile_info',self.main_app.user_profile_info)        
    #         print(auth_reponse.status_code)
    #         self.finished.emit(auth_reponse.status_code)
    #     except:
    #         self.finished.emit(-1)
        
        