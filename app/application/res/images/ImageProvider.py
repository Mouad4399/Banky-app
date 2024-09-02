import sys
from pathlib import Path
from PySide6.QtQuick import QQuickImageProvider
from PySide6.QtGui import QGuiApplication,QClipboard ,QPixmap ,QImage
from PySide6.QtCore import QObject,Slot, Qt, QUrl,QSize
from PySide6.QtQml import QQmlImageProviderBase
import sys
import base64
import math

class ImageProvider(QQuickImageProvider):
    def __init__(self) -> None:
        super().__init__(QQmlImageProviderBase.ImageType.Image)
    def requestImage(self, id ,size,requestedSize):
        # Load image based on the provided id
        # You can replace this logic with your own image loading logic
        # image_path = f".\\AM\\resources\\images\\{id}"
        image_path = Path(__file__).resolve().parent /f"{id}"
        image = QImage(image_path)
        # Calculate the aspect ratio of the original image
        aspect_ratio = image.width() / image.height() 

        if requestedSize.width() == -1 and requestedSize.height() == -1:
            return image.scaled(image.size(),mode=Qt.TransformationMode.SmoothTransformation)
        # Adjust requestedSize if either width or height is 0
        if requestedSize.width() == 0 and requestedSize.height() == 0:
            return image.scaled(image.size(),mode=Qt.TransformationMode.SmoothTransformation)
        elif requestedSize.width() == 0:
            requestedSize.setWidth(math.ceil(requestedSize.height() * aspect_ratio))
        elif requestedSize.height() == 0:
            requestedSize.setHeight(math.ceil(requestedSize.width() / aspect_ratio))

        image = image.scaled(requestedSize,mode=Qt.TransformationMode.SmoothTransformation)        
        return image
