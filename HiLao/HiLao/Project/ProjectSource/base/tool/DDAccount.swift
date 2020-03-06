//
//  DDAccount.swift
//  ZDLao
//
//  Created by WY on 2017/10/13.
//  Copyright © 2017年 com.16lao. All rights reserved.
//

import UIKit
import HandyJSON
class DDAccount: GDModel , NSCoding{
    required init() {
        super.init()
    }
    
    var memberId: Int?
    var mobile: String?
    var email: String?
    var sex: Int?
    var creatAt: String?
    var saltCode: String?
    var name: String?
    var countryID: String?
    var countryCode: String?
    var id: Int? // = 95
    var token: String = ""// "101faa72fd8cd4f1cdb5ef3ca6e8d49c29cd36e9"
    var head_images:String?
    var nickName: String?
    var password: String?
    var isLogin : Bool {
        if let _ = self.id {
            return true
        }else {
            return false
        }
        
    }
    override func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.memberId <-- "member_id"
        mapper <<<
            self.creatAt <-- "create_at"
        mapper <<<
            self.saltCode <-- "saltcode"
        mapper <<<
            self.countryID <-- "country_id"
        mapper <<<
            self.countryCode <-- "country_code"
        mapper <<<
            self.nickName <-- "nickname"
        mapper <<<
            self.id <-- "id"
        
    }
    
    class func share() -> DDAccount {
        if let account = DDAccount.read(){
            return account
        }else{
            return DDAccount.init()
        }
    }
    
    ///save account from memary to disk .
    
    /// return value  : save success or not
    @discardableResult
    func save() -> Bool {
        let docuPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
        if let realDocuPath : NSString = docuPath as NSString? {
            let filePath = realDocuPath.appendingPathComponent("Account.data")
            let isSuccess =  NSKeyedArchiver.archiveRootObject(self , toFile: filePath)
            if isSuccess {
                mylog("archive success")
            }else{
                mylog("archive failure")
            }
            return isSuccess
        }else{
            mylog("the  path of archive is not exist")
            return false
        }
    }
    ///load account from local disk
    class  func read() -> DDAccount? {
        let docuPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
        if let realDocuPath : NSString = docuPath as NSString? {
            let filePath = realDocuPath.appendingPathComponent("Account.data")
            let object =  NSKeyedUnarchiver.unarchiveObject(withFile:  filePath)
            if let realObjc = object as? DDAccount {
                return realObjc
            }else{
                return  nil
            }
        }else{
            mylog("the  path of unarchive is not exist")
            return  nil
        }
    }
    ///set share account's propertis by other account dictionary
    func setPropertisOfShareBy( dict : [String : AnyObject])  {
        self.setPropertisOfShareBy(otherAccount : DDAccount.init())
    }
    
    ///set share account's propertis by other account instance
    func setPropertisOfShareBy( otherAccount : DDAccount)  {
        
    }
    
    ///remove account data from disk
    @discardableResult
    func deleteAccountFromDisk() -> Bool {
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString).appendingPathComponent("Account.data")
        do {
            try  FileManager.default.removeItem(atPath: path)
            mylog("remove account data from disk success")
            
            return true
        }catch  let error as NSError {
            mylog("remove account data from disk failure")
            mylog(error)
            return false
        }
    }
//    init(dict : [String : AnyObject]? = nil ) {
//        super.init()
//        if dict == nil  {return}
//        self.setValuesForKeys(dict!)
////        if let data  = dict?["data"] {
////            if let memberid = data as? String{
////                self.member_id = memberid
////            }
////        }
//    }
    
    /////////////////////////////////////////////////////////////////
    
//    override func setValue(_ value: Any?, forKey key: String) {
//        if key == "id" {
//            self.member_id = value as? String
//            return
//        }
//        super.setValue(value, forKey: key)
//    }
//    override func setValue(_ value: Any?, forUndefinedKey key: String) {
//        //do nothing
//    }
//
    // implement NSCoding protocol method
    

    //unarchive binary data to instance
    required init?(coder aDecoder: NSCoder) {
        self.token = aDecoder.decodeObject(forKey: "token") as? String ?? ""
        self.memberId = aDecoder.decodeObject(forKey: "memberId") as? Int
        self.mobile = aDecoder.decodeObject(forKey: "mobile") as? String
        self.email = aDecoder.decodeObject(forKey: "email") as? String
        self.sex = aDecoder.decodeObject(forKey: "sex") as? Int
        self.saltCode = aDecoder.decodeObject(forKey: "saltCode") as? String
        self.countryID = aDecoder.decodeObject(forKey: "countryID") as? String
        self.countryCode = aDecoder.decodeObject(forKey: "countryCode") as? String
        self.id = aDecoder.decodeObject(forKey: "id") as? Int
        self.nickName = aDecoder.decodeObject(forKey: "nickName") as? String
        head_images = aDecoder.decodeObject(forKey: "head_images") as? String
        self.password = aDecoder.decodeObject(forKey: "password") as? String
    }
    
    
    //unarchive instance to binary data
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.mobile, forKey: "mobile")
        aCoder.encode(self.token, forKey: "token")
        aCoder.encode(self.memberId, forKey: "memberId")
        aCoder.encode(self.email, forKey: "email")
        aCoder.encode(self.sex, forKey: "sex")
        aCoder.encode(self.saltCode, forKey: "saltCode")
        aCoder.encode(self.countryID, forKey: "countryID")
        aCoder.encode(self.countryCode, forKey: "countryCode")
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.nickName, forKey: "nickName")
        aCoder.encode(head_images, forKey: "head_images")
        aCoder.encode(self.password, forKey: "password")
    }
}
