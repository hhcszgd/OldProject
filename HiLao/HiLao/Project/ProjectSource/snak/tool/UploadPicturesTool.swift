//
//  UploadPicturesTool.swift
//  Project
//
//  Created by 张凯强 on 2017/11/26.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class UploadPicturesTool: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let tenxunAppid = "1252043302"
    let tenxunAppKey = "2ae4806abe0f1ae393564456ff1130b5"
    let bukey: String = "hilao"
    let regin: String = "bj"
   
    
    override init() {
        super.init()
    }
    
    weak var viewController: UIViewController!
    func changeHeadPortrait() {
        let current = self.viewController
        let alertVC = UIAlertController.init(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let actinCamora = UIAlertAction.init(title: "拍照", style: UIAlertActionStyle.default) { (action) in
            //弹出相册系统
            let pickVC = UIImagePickerController.init()
            //设置相片来源
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
                pickVC.sourceType = UIImagePickerControllerSourceType.camera
                pickVC.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
                current?.present(pickVC, animated: true, completion: nil)
            }else {
                GDAlertView.alert("摄像头不可用", image: nil, time: 2, complateBlock: nil)
            }
        }
        //我的相册
        let actionAlbum = UIAlertAction.init(title: "我的相册", style: UIAlertActionStyle.default) { (action) in
            //弹出相册系统
            let pickVC = UIImagePickerController.init()
            //设置相片来源
            
            pickVC.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
            pickVC.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
            pickVC.allowsEditing = true
            current?.present(pickVC, animated: true, completion: nil)
            
        }
        
        let acitonCancle = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel) { (action) in
            
        }
        alertVC.addAction(actinCamora)
        alertVC.addAction(actionAlbum)
        alertVC.addAction(acitonCancle)
        
        current?.present(alertVC, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var photoImage: UIImage?
        if picker.sourceType == UIImagePickerControllerSourceType.camera {
            if let photo = info[UIImagePickerControllerOriginalImage] as? UIImage {
                photoImage = photo
            }
        }
        if picker.sourceType == UIImagePickerControllerSourceType.savedPhotosAlbum {
            if let photo = info[UIImagePickerControllerEditedImage] as? UIImage {
                photoImage = photo
            }
        }
        //给图片取名headImage
        let imagePath =  NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! + "/headImage"
        
        //获取文件管理器
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: imagePath) {
            do {
                try fileManager.removeItem(at: URL.init(fileURLWithPath: imagePath))
            } catch  {
                
            }
        }
        //检查文件是否存在
        if !fileManager.fileExists(atPath: imagePath) {
            //不存在创建该文件
            do {
                try fileManager.createDirectory(at: URL.init(fileURLWithPath: imagePath), withIntermediateDirectories: true, attributes: nil)
            } catch  {
                mylog(error)
            }
            
        }
        var imageurl: String = ""
        if let originlImage = photoImage {
            if let image = photoImage {
                
                let imageData = UIImageJPEGRepresentation(fixOrientation(image: image), 0.5)
                do {
                    imageurl = imagePath + "/\(self.imageName)" + ".jpeg"
                    try imageData?.write(to: URL.init(fileURLWithPath: imageurl))
                    self.uploadPictrue(imagePath: imageurl, sign: "")
                } catch  {
                    
                }
            }
        }
        
        
        
        
    }
    weak var model: OpenShopModel?
    func uploadPictrue(imagePath: String, sign: String) {
        mylog(imagePath)
        
        NetWork.manager.requestData(router: Router.post("getTencentObjectStorageSignature", .api,[String: Any]())).subscribe(onNext: { [unowned self](dict) in
            if let arr = dict["data"] as? [String], let token = arr.first {
                let clinet = COSClient.init(appId: self.tenxunAppid, withRegion: self.regin)
                let task = COSObjectPutTask.init()
                task?.filePath = imagePath
                task?.bucket = self.bukey
                task?.fileName = self.imageName + ".jpeg"
                task?.sign = token
                task?.insertOnly = true
                task?.directory = "head_img"
                task?.attrs = (self.model?.actionKey)!
                
                
                
                clinet?.completionHandler = {
                    (resp, context) in
                    mylog(resp?.data)
                    mylog(context)
                    mylog(resp?.retCode)
                    if let res = resp as? COSObjectUploadTaskRsp, res.retCode == 0 {
                        mylog("上传成功")
                        
                        if self.model?.actionKey == "shop" {
                            self.model?.imageArr.append(res.sourceURL)
                            mylog(self.model?.imageArr)
                        }else {
                            self.model?.image = res.sourceURL
                        }
                        self.viewController.dismiss(animated: true, completion: nil)
                    }else {
                        self.viewController.dismiss(animated: true, completion: nil)
                    }
                }
                clinet?.progressHandler = { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
                    mylog("金盾")
                    
                }
                clinet?.putObject(task)
                
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        
        
        
        
        
        
    }
    
    
    
    var imageName: String {
        return String(Int(Date.init().timeIntervalSince1970))
    }
    ///保证上传的照片的方向和预想的方向一致
    func fixOrientation(image: UIImage) -> UIImage {
        if image.imageOrientation == UIImageOrientation.up {
            return image
        }
        var transform = CGAffineTransform.identity
        switch image.imageOrientation {
        case UIImageOrientation.down, UIImageOrientation.downMirrored:
            transform = transform.translatedBy(x: image.size.width, y: image.size.height)
            transform = transform.rotated(by: CGFloat(M_PI))
            break
        case UIImageOrientation.left, UIImageOrientation.leftMirrored:
            transform = transform.translatedBy(x: image.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(M_PI_2))
            break
        case UIImageOrientation.right, UIImageOrientation.rightMirrored:
            transform = transform.translatedBy(x: 0, y: image.size.height)
            transform = transform.rotated(by: CGFloat(-M_PI_2))
            break
        case UIImageOrientation.upMirrored, UIImageOrientation.downMirrored:
            transform = transform.translatedBy(x: image.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            break
        case UIImageOrientation.leftMirrored, UIImageOrientation.rightMirrored:
            transform = transform.translatedBy(x: image.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            break
        default:
            break
        }
        let ctx = CGContext(data: nil, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: image.cgImage!.bitsPerComponent, bytesPerRow: 0, space: image.cgImage!.colorSpace!, bitmapInfo: image.cgImage!.bitmapInfo.rawValue)
        ctx?.concatenate(transform)
        switch image.imageOrientation {
        case UIImageOrientation.left, UIImageOrientation.leftMirrored, UIImageOrientation.rightMirrored, UIImageOrientation.rightMirrored:
            ctx?.draw(image.cgImage!, in: CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height))
        default:
            ctx?.draw(image.cgImage!, in: CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height))
        }
        let cgimg = ctx!.makeImage()
        let img = UIImage.init(cgImage: cgimg!)
        
        
        return img
        
    }
    
}
