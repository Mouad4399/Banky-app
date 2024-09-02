import sys
import os
from pathlib import Path
from PySide6.QtCore import QObject,Slot,Signal,QTranslator,QMetaObject,QThread
import time
import requests



class Register(QThread):
    finished = Signal(int)
    
    def __init__(self,main_app:QObject):
        QThread.__init__(self)
        self.main_app=main_app
        
    @Slot(dict,str,str)
    def sendRequest(self,data:dict,key:str,fichier_cin:str):
        self.data=data
        self.key=key
        self.files = {
            'cin': ('Alma7al-logo.png', open(fichier_cin, 'rb'), 'image/jpeg')
        }
        self.start()
        
    
    def run(self):
        # data_json = {
        #     'email': self.data['email'],
        #     'mot_de_passe': self.data['password'],
        #     'token': 'Null'
        # }
        # auth_reponse=VuePost.envoyer_donnees('http://127.0.0.1:8000/api-interne/v1/gestion-magasin/connexion', data_json)
        # try:
        #     if auth_reponse.status_code == 200:
        #         self.main_app.user_app_info =auth_reponse.json()
        #         self.main_app.engine.rootContext().setContextProperty('user_app_info',self.main_app.user_app_info)        
        #         self.main_app.user_profile_info=requests.get( f'http://127.0.0.1:8000/api-interne/v1/gestion-magasin/employe/get/employes-informations/employe/{self.main_app.user_app_info["employe_id"]}').json()[0]
        #         self.main_app.engine.rootContext().setContextProperty('user_profile_info',self.main_app.user_profile_info)        
        #     self.finished.emit(auth_reponse.status_code)
        # except:
        #     self.finished.emit(-1)
            
            
            
        register_response=requests.post(f'http://127.0.0.1:8000/api-interne/v1/gestion-magasin/inscription/cle-acces/{self.key}',data=self.data,files=self.files)
        try:
            if register_response.status_code ==200:
                self.main_app.user_app_info=register_response.json()
                self.main_app.user_profile_info=requests.get( f'http://127.0.0.1:8000/api-interne/v1/gestion-magasin/employe/get/employes-informations/employe/{self.main_app.user_app_info.get("employe_id")}').json()[0]
                self.main_app.engine.rootContext().setContextProperty('user_profile_info',self.main_app.user_profile_info) 
            self.finished.emit(register_response.status_code)
        except:
            self.finished.emit(-1)
        
        