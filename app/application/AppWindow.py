# This Python file uses the following encoding: utf-8
import os
import sys
from pathlib import Path
from PySide6.QtCore import QObject,Slot, QDir, QFileInfo,QMimeDatabase,QPointF,QTranslator,QCoreApplication
from PySide6.QtWebEngineCore import *
from PySide6.QtWebEngineQuick import *
from PySide6.QtQml import QQmlApplicationEngine

from PySide6.QtMultimedia import  QMediaDevices
from PySide6.QtGui import QLinearGradient,QColor,QBrush,QGuiApplication,QClipboard
from PySide6.QtWidgets import QApplication,QFileDialog
from argparse import ArgumentParser, RawTextHelpFormatter

from .res.images.ImageProvider import ImageProvider

from .api.Logout import Logout
from .api.Get_KYC import Get_KYC
from .api.Get_Acc import Get_Acc
from .api.Update_KYC import Update_KYC
from .api.Search_Acc import Search_Acc
from .api.Transfer_Amount import Transfer_Amount
from .api.Request_Amount import Request_Amount
from .api.Get_Transaction import Get_Transaction
from .api.Get_Transactions_Summary import Get_Transactions_Summary
from .api.Settlement import Settlement

class AppWindow(QObject):
    
    def __init__(self,main_app:QObject) -> None:
        super().__init__()
        
        # empty_kyc ={'id': '', 'full_name': '', 'image': '', 'marrital_status': '', 'gender': '', 'identity_type': '', 'identity_image': '', 'date_of_birth': '', 'signature': '', 'country': '', 'state': '', 'city': '', 'mobile': '', 'fax': '', 'date': '', 'user':'' , 'account': ''}
        # main_app.engine.rootContext().setContextProperty('user_kyc_info',empty_kyc)   
        # empty_acc={'id': '', 'account_balance': '', 'account_number': '', 'account_id': '', 'pin_number': '', 'red_code': '', 'account_status': '', 'date': '', 'kyc_submitted': '', 'kyc_confirmed': '', 'review': '', 'user': '', 'recommended_by': ''}     
        # main_app.engine.rootContext().setContextProperty('user_acc_info',empty_acc)        



        self.logout=Logout(main_app)
        self.get_kyc=Get_KYC(main_app)
        self.get_acc=Get_Acc(main_app)
        self.update_kyc=Update_KYC(main_app)
        self.search_acc=Search_Acc(main_app)
        self.transfer_amount=Transfer_Amount(main_app)
        self.request_amount=Request_Amount(main_app)
        self.get_transaction=Get_Transaction(main_app)
        self.get_transactions_summary=Get_Transactions_Summary(main_app)
        self.settlement=Settlement(main_app)
        
        # essentials
        main_app.window = self
        main_app.engine.rootContext().setContextProperty('window',main_app.window)
        main_app.img=ImageProvider()
        main_app.engine.addImageProvider("img", main_app.img)
        main_app.engine.addImportPath(os.path.join(os.path.dirname(__file__),"views"))
        main_app.engine.addImportPath(os.path.join(os.path.dirname(__file__),"res"))
        main_app.engine.rootContext().setContextProperty('current_view','./application/main.qml')


    @Slot(result=str)
    def disp(self):
        print('I am in app')
        return 'I am in app'

    @Slot(str,result=QObject)
    def getAttr(self,attr_name):
        return getattr(self, attr_name)
    
    @Slot(result=str)
    def getPaste(self):
        cb = QClipboard(self)
        return cb.text()

    
    @Slot(QWebEngineDownloadRequest)
    def openFolderDialog(self,download:QWebEngineDownloadRequest):
        assert (download and download.state() == QWebEngineDownloadRequest.DownloadRequested)

        proposal_dir = download.downloadDirectory()
        proposal_name = download.downloadFileName()
        proposal = QDir(proposal_dir).filePath(proposal_name)
        path, _ = QFileDialog.getSaveFileName( dir=proposal,filter="PDF files (*.pdf)")
        if not path:
            download.cancel()
            return
        fi = QFileInfo(path)
        download.setDownloadDirectory(fi.path())
        download.setDownloadFileName(fi.fileName())
        download.accept()
        
    @Slot(str,result=str)
    def getMimeType(self, file_path:str):
        mime_db = QMimeDatabase()
        mime_info = mime_db.mimeTypeForFile(file_path)
        return mime_info.name().split('/')[0] if mime_info.isValid() else "Unknown"
    
    @Slot(float,str,result=QBrush)
    def GetBrush(self,height,hex_code:str):
        linear_grad = QLinearGradient(QPointF(height*0.8, 0), QPointF(height*0.8, height*0.8))
        # 99" = 60% transparency
        linear_grad.setColorAt(0, QColor.fromRgbF(QColor.fromString(hex_code).redF(),QColor.fromString(hex_code).greenF(),QColor.fromString(hex_code).blueF(), 0.6))
        linear_grad.setColorAt(1, QColor.fromRgbF(QColor.fromString(hex_code).redF(),QColor.fromString(hex_code).greenF(),QColor.fromString(hex_code).blueF(), 0))
        brush = QBrush(linear_grad)
        return brush
    
    # @Slot(float,result=QBrush)
    # def GetBrushi(self,height):
    #     linear_grad = QLinearGradient(QPointF(height*0.8, 0), QPointF(height*0.8, height*0.8))
    #     linear_grad.setColorAt(0, QColor.fromRgbF(20/255, 201/255, 201/255, 0.4))
    #     linear_grad.setColorAt(1, QColor.fromRgbF(20/255, 201/255, 201/255, 0))
    #     # QColor.fromString(hex_code).redF,QColor.fromString(hex_code).blueF,QColor.fromString(hex_code).greenF,
    #     brush = QBrush(linear_grad)
    #     return brush
