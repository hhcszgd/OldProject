//
//  GDStorgeManager.swift
//  zjlao
//
//  Created by WY on 16/11/18.
//  Copyright © 2016年 com.16lao.zjlao. All rights reserved.
/*
 获取历史消息逻辑步骤 :
 1.1 , 当服务器没有聊天历史 ,就标记noServerMessage , 只操作本地数据
 1.2 , 当服务器有了聊天历史 ,标记hadServerMessage , 第一次进入聊天界面就请求一次接口 , 以获取一个最小的消息id , 并保存minMessageID
 1.3 , 如果本地存消息 , 一定要保证有准确的最小sort_key对应的消息id
 2.1 , 每次上拉到上限以后 , 用minMessageID去请求服务器历史消息 并插入数据库
 3.1 , 以后再进入聊天界面 , 最小的sort_key对应的serverID一定有值(非空) , 就拿它来去服务器请求
 
 
 1 , 先从数据库取 
 1,1 本地能取到就加载 , 取到最后一条时再从网络获取聊天记录并插入数据库 , 再接着从数据库读取并展示 , 新的聊天记录正常插入数据库
 1.2 本地取不到的话 , 就去网络获取聊天记录并插入数据库 , 再从数据库读取并展示 , 新的聊天记录正常插入数据库
 1.3 本地取不到 , 服务器也取不到的话 , 新的聊天记录不做数据库存储
 */

import UIKit

import XMPPFramework

/// 存储类
class GDStorgeManager: UserDefaults {
//    lazy var db: FMDatabase = {
//        let libr  = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true ).first;
//        let libPath = libr?.appending("/xmpp.db")
//        let db = FMDatabase.init(path: libPath)
//        return db!
//    }()
//    
    
    
//    static let share = {}(
//    
//    )
    //MARK:单例
    static  let share : GDStorgeManager  = {
        let tempShare  = GDStorgeManager.init()
        
        return tempShare
    }()
    var currentUser = ""
    func gotCurrentDBQueue() -> (FMDatabaseQueue) {
        
        let userInfo = UserInfo.share()
        var name = ""
        if userInfo == nil {
            name = "default"
        }else{
            name = userInfo!.imName
        }
        let libr  = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true ).first;
        let libPath = libr?.appending("/xmpp\(name).db")
        let que  = FMDatabaseQueue.init(path: libPath)
        if(que != nil ){
            let  sqlContact = "CREATE TABLE IF NOT EXISTS contact(id INTEGER PRIMARY KEY AUTOINCREMENT ,last_message varchar(255),my_account varchar(255),other_account varchar(255) , time_stamp int , server_id varchar(32) , local_id varchar(32) , has_read int NOT NULL DEFAULT '0',from_account varchar(255))"
            
            let  sqlMessage = "CREATE TABLE IF NOT EXISTS message(id INTEGER PRIMARY KEY AUTOINCREMENT ,full_message_xml varchar(255),body varchar(255),my_account varchar(255),other_account varchar(255) , time_stamp int , server_id varchar(32) , local_id varchar(32) , has_read int NOT NULL DEFAULT '0',send_success int NOT NULL DEFAULT '1', from_account varchar(255)  ,  to_account varchar(255), sort_key int) ";
            que!.inDatabase({ (db) in
                let isContactSuccessOption =  (db?.executeStatements(sqlContact))
                if(isContactSuccessOption == nil ){
                    //                self.executeQuery(SQLStr: SQLStr)
                    mylog("建表Contact失败,重复创建")
                }else{
                    let isContactSuccess = isContactSuccessOption!
                    if(isContactSuccess){
                        mylog("建立Contact表成功")
                    }else{
                        //                    self.executeQuery(SQLStr :SQLStr)
                        mylog("建表Contact失败,重复创建")
                    }
                }
            })
            
            
            que!.inDatabase({ (db) in
                let isMessageSuccessOption =  (db?.executeStatements(sqlMessage))
                if(isMessageSuccessOption == nil ){
                    //                self.executeQuery(SQLStr: SQLStr)
                    mylog("建表Message失败,重复创建")
                }else{
                    let isMessageSuccess = isMessageSuccessOption!
                    if(isMessageSuccess){
                        mylog("建立Message表成功")
                    }else{
                        //                    self.executeQuery(SQLStr :SQLStr)
                        mylog("建表Message失败,重复创建")
                    }
                }
            })
        }
        return que!
        
    }
    
    lazy var xmppQueue: FMDatabaseQueue   = {
        let userInfo = UserInfo.share()
        var name = ""
        if userInfo == nil {
            name = "default"
        }else{
            name = userInfo!.imName
        }
        let libr  = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true ).first;
        let libPath = libr?.appending("/xmpp\(name).db")
        let que  = FMDatabaseQueue.init(path: libPath)
        if(que != nil ){
            let  sqlContact = "CREATE TABLE IF NOT EXISTS contact(id INTEGER PRIMARY KEY AUTOINCREMENT ,last_message varchar(255),my_account varchar(255),other_account varchar(255) , time_stamp int , server_id varchar(32) , local_id varchar(32) , has_read int NOT NULL DEFAULT '0',from_account varchar(255))"
            
            let  sqlMessage = "CREATE TABLE IF NOT EXISTS message(id INTEGER PRIMARY KEY AUTOINCREMENT ,full_message_xml varchar(255),body varchar(255),my_account varchar(255),other_account varchar(255) , time_stamp int , server_id varchar(32) , local_id varchar(32) , has_read int NOT NULL DEFAULT '0',send_success int NOT NULL DEFAULT '1', from_account varchar(255)  ,  to_account varchar(255), sort_key int) ";
            que!.inDatabase({ (db) in
                let isContactSuccessOption =  (db?.executeStatements(sqlContact))
                if(isContactSuccessOption == nil ){
                    //                self.executeQuery(SQLStr: SQLStr)
                    mylog("建表Contact失败,重复创建")
                }else{
                    let isContactSuccess = isContactSuccessOption!
                    if(isContactSuccess){
                        mylog("建立Contact表成功")
                    }else{
                        //                    self.executeQuery(SQLStr :SQLStr)
                        mylog("建表Contact失败,重复创建")
                    }
                }
            })
            
            
            que!.inDatabase({ (db) in
                let isMessageSuccessOption =  (db?.executeStatements(sqlMessage))
                if(isMessageSuccessOption == nil ){
                    //                self.executeQuery(SQLStr: SQLStr)
                    mylog("建表Message失败,重复创建")
                }else{
                    let isMessageSuccess = isMessageSuccessOption!
                    if(isMessageSuccess){
                        mylog("建立Message表成功")
                    }else{
                        //                    self.executeQuery(SQLStr :SQLStr)
                        mylog("建表Message失败,重复创建")
                    }
                }
            })
        }

    
        return que!
    }()
    //insert message from server  into localDatabase  , return the insert message array
    func insertHistoryMessage(from: String, to: String, messageID: String , callBack:@escaping ((_ isSucess:Int ,_ insertArr : [GDMessage])->())) -> () {//isSuccess:是否成功 0 是失败 , 非零是成功 ,  resultStr:提示信息
        if currentUser != UserInfo.share().name! {
            mylog(self.xmppQueue)
            self.xmppQueue = self.gotCurrentDBQueue()
            currentUser = UserInfo.share().name!
            mylog(self.xmppQueue)
        }
        UserInfo.share().gotHistoryMessage(from: from, to: to, messageID: messageID, success: { (response) in
            mylog(response?.data)
            mylog(response?.status)
            mylog(response?.msg)
            if(response?.status == ResponseStatus.init(200) || response?.status == ResponseStatus.init(400) ){//200或400表示成功
                if let arr = response?.data as? Array<Any>{
//                    mylog("获取data成功\(arr)")
                    var msgarr  =  [GDMessage]()
                    for (index ,item ) in arr.enumerated() {
                        let msg : XMPPMessage = XMPPMessage.init()
                        var fromUserStr = ""
                        var toUserStr = ""
                        if let msgDict = item as? [NSString : AnyObject] {
                            if let body = msgDict["body"] as? String{
                                mylog(body)
                                msg.addBody(body)
                            }
                            if let fromUser  = msgDict["from"] as? String{
                                mylog(fromUser)
                                if(fromUser.contains("@")){
                                    
                                    let range  = fromUser.range(of: "@")
                                    let user = fromUser.substring(to: (range?.lowerBound)!)
                                    fromUserStr = user
                                    mylog(user)
                                }
                            }
                            if let toUser = msgDict["to"] as? String{
                                mylog(toUser)
                                if(toUser.contains("@")){
                                    
                                    let range  = toUser.range(of: "@")
                                    let user = toUser.substring(to: (range?.lowerBound)!)
                                    toUserStr = user
                                    mylog(user)
                                }
                            }
                            if let serverid  = msgDict["id"] as? String{
                                mylog(serverid)
                                /*
                                 NSXMLElement *archive = [NSXMLElement elementWithName:@"archived" xmlns:@"urn:xmpp:mam:tmp"];
                                 [archive addAttributeWithName:@"id" stringValue:serverID];///////////////
                                 */
                                let archived = DDXMLElement.init(name: "archived", xmlns: "urn:xmpp:mam:tmp")
                                archived?.addAttribute(withName: "id", stringValue: serverid)
                                msg.addChild(archived!)

                            }
                            //执行插入操作
//                            self.insertMessageToDatabase(message: msg, isMax: "min", from:fromUserStr , to: toUserStr)
                            self.insertMessageToDatabase(message: msg, isMax: "min", from: fromUserStr, to: toUserStr, callBack: { (resultCode , resultStr) in
                                //执行回调
//                                callBack(resultCode , resultStr)
                                msgarr.append(item as! GDMessage)
                                if (index == arr.count - 1 ){
                                    callBack(1 , msgarr)
                                }
                                
                            })
                            
                        }else{
                            callBack(0,[])//"数组元素不是字典类型")
                        }
                    }
                }else{
                    callBack(0,[])//"返回data非数组")
                }
                
                
                
            }else{
                callBack(0 , [])//"请求成功,数据返回失败")
            }
        }) { (error) in
            callBack(0 , [])//"请求失败")
        }

    }

    //insert message into database (whenSendMessage) / (whenReciveMessage)
    func insertMessageToDatabase(message : XMPPMessage ,isMax : String, from : String , to : String  , callBack:@escaping ((_ isSucess:Int ,_ resultStr : String)->())) -> () {

//        mylog(currentUser)
//        mylog(UserInfo.share().name!)
        if currentUser != UserInfo.share().name! {
            mylog(self.xmppQueue)
            self.xmppQueue = self.gotCurrentDBQueue()
            currentUser = UserInfo.share().name!
            mylog(self.xmppQueue)
        }
        
        self.xmppQueue.inDatabase { (db ) in
            
            var sortMax : Int = 0;
            var sortMin : Int = 0
            do {
                let resultSet =  try db?.executeQuery("select max(sort_key) as sort from message;", values: nil )
                //                mylog(resultSet?.columnCount())//总工有多少列
                while(resultSet?.next() )!{
                    let resultOption = resultSet?.object(forColumnName: "sort")
                    if let resultAny = resultOption {
//                        mylog(resultAny)
                        if let realInt =  resultAny as? Int {
                                sortMax = realInt
                                sortMax = sortMax + 1
                        }
                    }
                }
            } catch  {
                mylog("查询失败")
            }
            
            do {
                let resultSet =  try db?.executeQuery("select min(sort_key) as sort from message;", values: nil )
                //                mylog(resultSet?.columnCount())//总工有多少列
                while(resultSet?.next() )!{
                    let resultOption = resultSet?.object(forColumnName: "sort")
                    if let resultAny = resultOption {
                        if let realInt =  resultAny as? Int {
                                sortMin = realInt
                                sortMin = sortMin - 1
                        }
                    }
                }
            } catch  {
                mylog("查询失败")
            }
            
            var maxOrMin = 0
            if(isMax == "max"){
               maxOrMin = sortMax
            }else{
                maxOrMin = sortMin
            }
            let  fullMsgXML = message.description;
            let  myAccount = UserInfo.share().imName!//
            let  otherAccount =  from == myAccount ? to : from ;//不准 , 待优化 , 可能是自己 , 也可能是别人
            let  stamp = "\(NSDate.init().timeIntervalSince1970)";
            let  body = message.body()!;
//            if (body.contains("'''")){
//                body = body.replacingOccurrences(of: "'''", with: "''''''")
//            }else if (body.contains("''")){
//                body = body.replacingOccurrences(of: "''", with: "''''")
//            }else if(body.contains("'")){
//                body = body.replacingOccurrences(of: "'", with: "\'\'")
//            }
            let elementArr = message.elements(forName: "archived")
            var  serverID = "0";
            for element in elementArr{
//                DDXMLElement
              let   serverIDOption = element.attributeStringValue(forName: "id")
                if serverIDOption != nil{
                    serverID = serverIDOption!
                }
            }
            var  localID = "0"
            let  localIDOption = message.attributeStringValue(forName: "id");
//            mylog(message.description)
//            mylog(localIDOption)
//            mylog(message.elementID)
            if localIDOption != nil{
                localID = localIDOption!
            }
            let  fromAccount = from;
            let  toAccount =  to;
//            let  SQLStr = "insert into message (full_message_xml, other_account ,my_account, time_stamp , body , server_id ,local_id ,from_account ,to_account , sort_key ) values ('\(fullMsgXML)' ,'\(otherAccount)' ,'\(myAccount)' ,'\(stamp)' ,'\(body)' ,'\(serverID)' ,'\(localID)','\(fromAccount)','\(toAccount)' ,'\(maxOrMin)')"
//            
//            let isSuccessOption =  (db?.executeStatements(SQLStr))//这种方法插入单引号会失败
            let  SQLStr = "insert into message (full_message_xml, other_account ,my_account, time_stamp , body , server_id ,local_id ,from_account ,to_account , sort_key ) values (?,?,?,?,?,?,?,?,?,?)"
            
            let isSuccessOption =  (db?.executeUpdate(SQLStr, withArgumentsIn: [fullMsgXML ,otherAccount ,myAccount ,stamp ,body ,serverID ,localID,fromAccount,toAccount ,maxOrMin]))//这种可以插入单引号
            if(isSuccessOption == nil ){
                //                self.executeQuery(SQLStr: SQLStr)
                mylog("语句执行失败")
                callBack(0,"插入消息失败")
            }else{
                let isSuccess = isSuccessOption!
                if(isSuccess){
                    mylog("语句执行成功")
                    callBack(1,"插入消息成功")
                    //                    self.selectQuery(SQLStr: "", dbQueue: self.xmppQueue)
                }else{
                    //                    self.executeQuery(SQLStr :SQLStr)
                    mylog(db?.lastError())
                    mylog("语句执行失败")
                    callBack(0,"插入消息失败")
                }
            }
        }
        self.saveRecentContact(message: message) { (resultCode, resultStr) in
            if(resultCode == 0 ){
                mylog("保存最近联系人失败")
            }else{
                mylog("保存最近联系人成功")
            }
        }


    }
    //单纯的执行sql语句
    func executeQuery( SQLStr : String , dbQueue : FMDatabaseQueue  , callBack:@escaping ((_ isSucess:Int ,_ resultStr : String)->())) {
        if currentUser != UserInfo.share().name! {
            self.xmppQueue = self.gotCurrentDBQueue()
            currentUser = UserInfo.share().name!
        }

        self.xmppQueue.inDatabase { (db ) in
            
            let isSuccessOption =  (db?.executeStatements(SQLStr))
            if(isSuccessOption == nil ){
//                self.executeQuery(SQLStr: SQLStr)
                mylog("sql语句执行失败")
                callBack(0 , "语句执行失败")
            }else{
                let isSuccess = isSuccessOption!
                if(isSuccess){
                    mylog("sql语句执行成功")
                    callBack(1 , "语句执行成功")

//                    self.selectQuery(SQLStr: "", dbQueue: self.xmppQueue)
                }else{
//                    self.executeQuery(SQLStr :SQLStr)
                    mylog("sql语句执行失败")
                    callBack(0 , "语句执行失败")
                }
            }
        }
    }
    
    
    
    
    
    
    
    // MARK: 注释 : 从contact表中删除联系人
    func deleteContactFromContact(userName:String? , callBack:@escaping ((_ isSucess:Int ,_ resultStr : String)->())) -> () {
        if currentUser != UserInfo.share().name! {
            mylog(self.xmppQueue)
            self.xmppQueue = self.gotCurrentDBQueue()
            currentUser = UserInfo.share().name!
            mylog(self.xmppQueue)
        }
        let delete = "delete from contact where other_account = '\(userName!)'"
        self.xmppQueue.inDatabase { (db) in
            
            let result =  db?.executeUpdate(delete, withArgumentsIn: nil )
            if (result)!{
                callBack(1 , "从contact表删除联系人操作执行成功")
            
            }else {
                mylog("删除contact表历史消息错误")
                callBack(0 , "删除contact表联系人操作执行失败")
            }
        }
    }
    
    
    // MARK: 注释 : 清空表
    
    /// 清空某个联系人的聊天记录 若userName传nil意味着全部清空
    ///
    /// - Parameter userName: 联系人
    
    
    
    
    
    func deleteFormContent(userName:String? , callBack:@escaping ((_ isSucess:Int ,_ resultStr : String)->())) -> () {
        if currentUser != UserInfo.share().name! {
            mylog(self.xmppQueue)
            self.xmppQueue = self.gotCurrentDBQueue()
            currentUser = UserInfo.share().name!
            mylog(self.xmppQueue)
        }
        var delete = ""
        if userName == nil  {
             delete = "delete from message"
        }else{
             delete = "delete from message where other_account = '\(userName!)'"
        }
        
        //        let select = "select distinct  other_account from message  order by sort_key"
        
        self.xmppQueue.inDatabase { (db) in
            
            do {
                let resultSet = try db?.executeQuery(delete, values: nil)
                while(resultSet?.next())!{
                    let str = resultSet?.string(forColumn: "other_account")
                    let str2 = resultSet?.string(forColumn: "time_stamp")
                    let str3 = resultSet?.string(forColumn: "body")
                    mylog(str!)
                    mylog(str2)
                    mylog(str3)
                    //                    let selectTarget = "select max(sort_key) as maxColunm from message  where otner_account = '\(str!)'"
                    
                    
                }
                callBack(1 , "删除联系人操作执行成功")

            }catch {
                mylog("删除历史消息错误")
                callBack(0 , "删除联系人操作执行失败")

            }
            
            
        }

    }
    // MARK: 注释 : (从message表中)获取最近联系人列表
    func gotRecentContact( callBack:@escaping ((_ isSucess:Int ,_ resultStr : [[String:String]])->())) -> () {//返回最近联系人数组,待实现
        if currentUser != UserInfo.share().name! {
            mylog(self.xmppQueue)
            self.xmppQueue = self.gotCurrentDBQueue()
            currentUser = UserInfo.share().name!
            mylog(self.xmppQueue)
        }
//        let select = "select distinct  other_account from message  order by sort_key"
        let select = "select *   from message  group by other_account HAVING max(time_stamp) order by time_stamp DESC"

        self.xmppQueue.inDatabase { (db) in
            var arr = [[String:String]]()
            var dict = [String : String]()
            do {
                let resultSet = try db?.executeQuery(select, values: nil)
                while(resultSet?.next())!{
                    let str = resultSet?.string(forColumn: "other_account")
                    let str2 = resultSet?.string(forColumn: "time_stamp")
                    let str3 = resultSet?.string(forColumn: "body")
                    mylog(str!)
                    mylog(str2)
//                    mylog(str3)
                    if(str != nil){
                        dict["other_account"] = str!
                    }
                    if(str2 != nil){
                        dict["time_stamp"] = str2!
                    }
                    if(str3 != nil){
                        dict["body"] = str3!
                    }
                    arr.append(dict)
                }
                callBack(1,arr)
            }catch {
                mylog("查询最近联系人错误")
                callBack(0,[])
            }
        }
        
        
    }
    
    // MARK: 注释 : (从ocntact表中)获取最近联系人列表
    func gotRecentContactList( callBack:@escaping ((_ isSucess:Int ,_ resultStr : [[String:String]])->())) -> () {//返回最近联系人数组,待实现
        if currentUser != UserInfo.share().name! {
            mylog(self.xmppQueue)
            self.xmppQueue = self.gotCurrentDBQueue()
            currentUser = UserInfo.share().name!
            mylog(self.xmppQueue)
        }
        //        let select = "select distinct  other_account from message  order by sort_key"
        let select = "select *   from contact  order by time_stamp DESC"
        
        self.xmppQueue.inDatabase { (db) in
            var arr = [[String:String]]()
            var dict = [String : String]()
            do {
                let resultSet = try db?.executeQuery(select, values: nil)
                while(resultSet?.next())!{
                    let str = resultSet?.string(forColumn: "other_account")
                    let str2 = resultSet?.string(forColumn: "time_stamp")
//                    let str3 = resultSet?.string(forColumn: "body")
                    let str3 = resultSet?.string(forColumn: "last_message")
                    mylog(str!)
                    mylog(str2)
                    //                    mylog(str3)
                    if(str != nil){
                        dict["other_account"] = str!
                    }
                    if(str2 != nil){
                        dict["time_stamp"] = str2!
                    }
                    if(str3 != nil){
                        dict["last_message"] = str3!
                    }
                    arr.append(dict)
                }
                callBack(1,arr)
            }catch {
                mylog("查询最近联系人错误")
                callBack(0,[])
            }
        }
        
        
    }

    
    
    
    /*
     let libr  = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true ).first;
     let libPath = libr?.appending("/xmpp\(name).db")
     */
    func deleteUserFile(path:String , callBack:@escaping ((_ isSucess:Int ,_ resultStr : String)->())) -> () {//done
        let libr  = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true ).first;
        var  photoPath = ""
        if let librStr  = libr {
            if (path.characters.count > 0) {
                photoPath = librStr.appending("/xmppPhoto/\(path)")
            }else{
                photoPath = librStr.appending("/xmppPhoto")
            }
            
        }
        do {
            try FileManager.default.removeItem(atPath: photoPath)
            mylog("文件删除成功")
            callBack(1,"文件删除成功")
        } catch  {
            mylog("文件删除失败\(error)")
            callBack(0,"文件删除失败")
        }
        
    }
    // MARK: 注释 : 根据用户名查询聊天历史
    func gotMessageHistory(user:String ,  callBack:@escaping ((_ isSucess:Int ,_ resultStr : [GDMessage])->())) -> () {//返回消息数组,待实现
        if currentUser != UserInfo.share().name! {
            mylog(self.xmppQueue)
            self.xmppQueue = self.gotCurrentDBQueue()
            currentUser = UserInfo.share().name!
            mylog(self.xmppQueue)
        }
        let select = "select * from message where other_account = '\(user)' order by sort_key"
        self.xmppQueue.inDatabase { (db) in
            var arr = [GDMessage]()
//            var arr = [[String:String]]()

            var dict = [String:String]()
            do {
                let resultSet = try db?.executeQuery(select, values: nil)
                while(resultSet?.next())!{
                    let str = resultSet?.string(forColumn: "other_account")
                    let str2 = resultSet?.string(forColumn: "time_stamp")
                    let str3 = resultSet?.string(forColumn: "body")
                    let str4 = resultSet?.string(forColumn: "from_account")//判断发自
                    let str5 = resultSet?.string(forColumn: "my_account")

//                    mylog(str!)
//                    mylog(str2)
//                    mylog(str3)
                    let gdmsg = GDMessage()
                    if(str != nil){
                        dict["other_account"] = str!
                        gdmsg.otherAccount = str!
                    }
                    if(str2 != nil){
                        dict["time_stamp"] = str2!
                        gdmsg.timeStamp = str2!
                    }
                    if(str3 != nil){
                        dict["body"] = str3!
                        gdmsg.body = str3!
                    }
                    if(str4 != nil){
                        dict["from_account"] = str4!
                        gdmsg.fromAccount = str4!
                    }
                    if(str5 != nil){
                        dict["my_account"] = str5!
                        gdmsg.myAccount = str5!
                    }
//                    arr.append(dict)
                    arr.append(gdmsg)
                    
                    
                }
                callBack(1,arr)
            }catch {
                mylog("查询消息历史错误")
                callBack(0,[])

            }
            
            
        }
    }
    
    
    
    // MARK: 注释 : 根据用户名查询聊天历史(本地没有或者取完了就去服务器取)
    func gotLocakOrServerMessageHistory(user:String , lastSortKey : String , lastServerMsgID: String , callBack:@escaping ((_ resultCode:Int ,_ resultStr : [GDMessage])->())) -> () {//resultCode为0表示操作失败 , 为1表示从本地数据库获取历史消息成功 , 为2 表示从服务器获取历史消失成功
        if currentUser != UserInfo.share().name! {
            mylog(self.xmppQueue)
            self.xmppQueue = self.gotCurrentDBQueue()
            currentUser = UserInfo.share().name!
            mylog(self.xmppQueue)
        }
        self.xmppQueue.inDatabase { (db) in
            self.singleGotMessageHistoryFromLocal(db: db, user: user , sortKey: lastSortKey , callBack: { (resultCode, gdMessageArr) in
                if(resultCode > 0 ){//查询成功
                    if(gdMessageArr.count == 0 ){//没查到消息 , 到服务器看看去
                        self.singleGotMessageFromServer(user: user, lastSortKey: lastSortKey, lastServerMsgID: lastServerMsgID, callBack: { (resultcode, gdMessageArr, messageArr ) in
                            if (messageArr.count > 0){
                            
                                for (index ,message) in messageArr.enumerated(){
                                    let gdmsg = gdMessageArr[index]
                                    self.singleInsertFouncation(db: db, message: message, isMax: "min", from: gdmsg.fromAccount, to: gdmsg.toAccount, callBack: { (resultCode, resultDescrip) in
                                        if(resultCode>0){//插入成功
                                            if(index == messageArr.count-1){//插完了
                                                mylog("插完了 , 重新查询")
                                                
                                                self.singleGotMessageHistoryFromLocal(db: db, user: user, sortKey: lastSortKey, callBack: { (resultcode, resuleMsgs) in
                                                    callBack(2 , resuleMsgs)
                                                    
                                                })
                                                
                                            }
                                        }else{//插入失败
                                            
                                        }
                                        
                                    })
                                }
                            }else{
                                callBack(0 , [])

                            }
//                            callBack(2 , gdMessageArr)
                        })
                        
                    }else{//查到了
                        callBack(1 , gdMessageArr)
                    }
                }else{//查询失败
                    callBack(0 , [])
                }
            })
            
            
            
            
  
            
            
            
            
            
            
            
        }
    }

    
    //获取单个联系人 30条以内的消息个数
    func singleGotMessageHistoryFromLocal(db : FMDatabase? ,user:String  , sortKey : String ,  callBack:@escaping ((_ isSucess:Int ,_ resultStr : [GDMessage])->()))  {
//        let select = "select * from message  where other_account = '\(user)' and sort_key < 40  order by sort_key desc limit 10 "
        var select = ""
        if (sortKey.characters.count > 0) {
            select = "select * from (select * from message  where other_account = '\(user)' and sort_key < \(sortKey)  order by sort_key desc limit 10) as someting order by someting.sort_key  "
            
        }else{
                    select = "select * from (select * from message  where other_account = '\(user)'   order by sort_key desc limit 10) as someting order by someting.sort_key  "
        }

        mylog(select)
        var arr = [GDMessage]()
        //            var arr = [[String:String]]()
        if (db == nil ) {
            self.xmppQueue.inDatabase { (dbdb ) in
                do {
                    let resultSet = try dbdb?.executeQuery(select, values: nil)
                    while(resultSet?.next())!{
                        let str = resultSet?.string(forColumn: "other_account")
                        let str2 = resultSet?.string(forColumn: "time_stamp")
                        let str3 = resultSet?.string(forColumn: "body")
                        let str4 = resultSet?.string(forColumn: "from_account")//判断发自
                        let str5 = resultSet?.string(forColumn: "my_account")
                        let str6 = resultSet?.string(forColumn: "sort_key")
                        let str7 = resultSet?.string(forColumn: "server_id")
                        let str8 = resultSet?.string(forColumn: "id")
                        mylog("\(str)\(str2)\(str3)\(str4)\(str5)")
                        //                    mylog(str!)
                        //                    mylog(str2)
                        //                    mylog(str3)
                        let gdmsg = GDMessage()
                        if(str != nil){
                            gdmsg.otherAccount = str!
                        }
                        if(str2 != nil){
                            gdmsg.timeStamp = str2!
                        }
                        if(str3 != nil){
                            gdmsg.body = str3!
                        }
                        if(str4 != nil){
                            gdmsg.fromAccount = str4!
                        }
                        if(str5 != nil){
                            gdmsg.myAccount = str5!
                        }
                        if(str6 != nil){
                            gdmsg.sortKey = str6!
                        }
                        if(str7 != nil){
                            gdmsg.serverID = str7!
                        }
                        if(str8 != nil){
                            gdmsg.rowNumber = str8!
                        }
                        arr.append(gdmsg)
                    }
                    if (arr.count > 0 ) {
                        callBack(1,arr)
                    }else{
                        callBack(1,[])
                    }
                }catch {
                    mylog("查询消息历史错误")
                    callBack(0,[])
                    
                }

                
            }
            
        }else{
            do {
                let resultSet = try db?.executeQuery(select, values: nil)
                while(resultSet?.next())!{
                    let str = resultSet?.string(forColumn: "other_account")
                    let str2 = resultSet?.string(forColumn: "time_stamp")
                    let str3 = resultSet?.string(forColumn: "body")
                    let str4 = resultSet?.string(forColumn: "from_account")//判断发自
                    let str5 = resultSet?.string(forColumn: "my_account")
                    let str6 = resultSet?.string(forColumn: "sort_key")
                    let str7 = resultSet?.string(forColumn: "server_id")
                    let str8 = resultSet?.string(forColumn: "id")
//                    mylog("\(str)\(str2)\(str3)\(str4)\(str5)")
                    //                    mylog(str!)
                    //                    mylog(str2)
                    //                    mylog(str3)
                    let gdmsg = GDMessage()
                    if(str != nil){
                        //                    dict["other_account"] = str!
                        gdmsg.otherAccount = str!
                    }
                    if(str2 != nil){
                        //                    dict["time_stamp"] = str2!
                        gdmsg.timeStamp = str2!
                    }
                    if(str3 != nil){
                        //                    dict["body"] = str3!
                        gdmsg.body = str3!
                    }
                    if(str4 != nil){
                        //                    dict["from_account"] = str4!
                        gdmsg.fromAccount = str4!
                    }
                    if(str5 != nil){
                        //                    dict["my_account"] = str5!
                        gdmsg.myAccount = str5!
                    }
                    if(str6 != nil){
                        //                    dict["my_account"] = str5!
                        gdmsg.sortKey = str6!
                    }
                    if(str7 != nil){
                        //                    dict["my_account"] = str5!
                        gdmsg.serverID = str7!
                    }
                    if(str8 != nil){
                        //                    dict["my_account"] = str5!
                        gdmsg.rowNumber = str8!
                    }
                    //                    arr.append(dict)
                    arr.append(gdmsg)
                }
                if (arr.count > 0 ) {
                    callBack(1,arr)
                }else{
                    callBack(1,[])
                }
            }catch {
                mylog("查询消息历史错误")
                callBack(0,[])
                
            }

        }
        //        var dict = [String:String]()
        
    }

    
    //获取单个联系人所有的聊天历史
    func singleGotMessageHistoryFromLocal(db : FMDatabase? ,user:String ,  callBack:@escaping ((_ isSucess:Int ,_ resultStr : [GDMessage])->()))  {
        let select = "select * from message where other_account = '\(user)' order by sort_key"
        var arr = [GDMessage]()
        //            var arr = [[String:String]]()
        
//        var dict = [String:String]()
        do {
            let resultSet = try db?.executeQuery(select, values: nil)
            while(resultSet?.next())!{
                let str = resultSet?.string(forColumn: "other_account")
                let str2 = resultSet?.string(forColumn: "time_stamp")
                let str3 = resultSet?.string(forColumn: "body")
                let str4 = resultSet?.string(forColumn: "from_account")//判断发自
                let str5 = resultSet?.string(forColumn: "my_account")
                let str6 = resultSet?.string(forColumn: "sort_key")
                let str7 = resultSet?.string(forColumn: "server_id")
                let str8 = resultSet?.string(forColumn: "id")

//                mylog("\(str)\(str2)\(str3)\(str4)\(str5)")
                //                    mylog(str!)
                //                    mylog(str2)
                //                    mylog(str3)
                let gdmsg = GDMessage()
                if(str != nil){
//                    dict["other_account"] = str!
                    gdmsg.otherAccount = str!
                }
                if(str2 != nil){
//                    dict["time_stamp"] = str2!
                    gdmsg.timeStamp = str2!
                }
                if(str3 != nil){
//                    dict["body"] = str3!
                    gdmsg.body = str3!
                }
                if(str4 != nil){
//                    dict["from_account"] = str4!
                    gdmsg.fromAccount = str4!
                }
                if(str5 != nil){
//                    dict["my_account"] = str5!
                    gdmsg.myAccount = str5!
                }
                if(str6 != nil){
                    //                    dict["my_account"] = str5!
                    gdmsg.sortKey = str6!
                }
                if(str7 != nil){
                    //                    dict["my_account"] = str5!
                    gdmsg.serverID = str7!
                }
                if(str8 != nil){
                    //                    dict["my_account"] = str5!
                    gdmsg.rowNumber = str8!
                }
                //                    arr.append(dict)
                arr.append(gdmsg)
            }
            if (arr.count > 0 ) {
                callBack(1,arr)
            }else{
                    callBack(1,[])
            }
        }catch {
            mylog("查询消息历史错误")
            callBack(0,[])
            
        }
        
    }
    
    
    func singleGotMessageFromServer(user:String , lastSortKey : String , lastServerMsgID: String , callBack:@escaping ((_ isSucess:Int ,_ customMessageArr : [GDMessage] , _ xmppMessageArr : [XMPPMessage])->())) {
        
        mylog("最后一条服务器id是:\(lastServerMsgID)")
            UserInfo.share().gotHistoryMessage(from: user, to: UserInfo .share().name, messageID: lastServerMsgID, success: { (response) in
                mylog(response?.data)
                mylog(response?.status)
                mylog(response?.msg)
                if(response?.status == ResponseStatus.init(200) || response?.status == ResponseStatus.init(400) ){//200或400表示成功
                    if let arr = response?.data as? Array<Any>{
                        //                    mylog("获取data成功\(arr)")
                        var costomMsgarr  =  [GDMessage]()
                        var xmppMsgarr  =  [XMPPMessage]()

                        
                        
                        for (index ,item ) in arr.enumerated() {
                            let msg : XMPPMessage = XMPPMessage.init()
                            let customMsg : GDMessage = GDMessage()
                            var fromUserStr = ""
                            var toUserStr = ""
                            
                            
                            //反向插入
                            let descItem =  arr[arr.count - index - 1];
                            
                            if let msgDict = descItem as? [NSString : AnyObject] {
                                if let body = msgDict["body"] as? String{
                                    mylog(body)
                                    msg.addBody(body)
                                    customMsg.body = body
                                }
                                if let fromUser  = msgDict["from"] as? String{
                                    mylog(fromUser)
                                    if(fromUser.contains("@")){
                                        
                                        let range  = fromUser.range(of: "@")
                                        let user = fromUser.substring(to: (range?.lowerBound)!)
                                        fromUserStr = user
                                        customMsg.fromAccount = user
                                        mylog(user)
                                    }
                                }
                                if let toUser = msgDict["to"] as? String{
                                    mylog(toUser)
                                    if(toUser.contains("@")){
                                        
                                        let range  = toUser.range(of: "@")
                                        let user = toUser.substring(to: (range?.lowerBound)!)
                                        toUserStr = user
                                        customMsg.toAccount = user
                                        mylog(user)
                                    }
                                }
                                if let serverid  = msgDict["id"] as? String{
                                    mylog(serverid)
                                    /*
                                     NSXMLElement *archive = [NSXMLElement elementWithName:@"archived" xmlns:@"urn:xmpp:mam:tmp"];
                                     [archive addAttributeWithName:@"id" stringValue:serverID];///////////////
                                     */
                                    let archived = DDXMLElement.init(name: "archived", xmlns: "urn:xmpp:mam:tmp")
                                    archived?.addAttribute(withName: "id", stringValue: serverid)
                                    msg.addChild(archived!)
                                    
                                }
                                customMsg.myAccount = UserInfo .share().name
                                //执行插入操作
                                costomMsgarr.append(customMsg)
                                xmppMsgarr.append(msg)
                                  
                                
                            }else{
                                callBack(0,[],[])//"数组元素不是字典类型")
                            }
                        }
                        callBack(1 , costomMsgarr , xmppMsgarr)
                    }else{
                        callBack(0,[],[])//"返回data非数组")
                    }
                    
                    
                    
                }else{
                    callBack(0 , [],[])//"请求成功,数据返回失败")
                }
            }) { (error) in
                callBack(0 , [],[])//"请求失败")
            }
            
            
            
            
            
            

    }
    
    // MARK: 注释 : 存储最近联系人
//    func saveRecentContact(db : FMDatabase? ,message : XMPPMessage ,isMax : String, from : String , to : String  , callBack:@escaping ((_ isSucess:Int ,_ resultStr : String)->())) {
    func saveRecentContact(message : XMPPMessage , callBack:@escaping ((_ isSucess:Int ,_ resultStr : String)->())) {

        self.xmppQueue.inDatabase { (db) in
            let date : NSDate = NSDate.init()
            let timeStamp = date.timeIntervalSince1970
            let currentUser =  UserInfo.share().name!
            let to_user = message.to().user!
            var other_account_name = ""
            if(currentUser != to_user){
                other_account_name = message.to().user
            }else{
                other_account_name = message.from().user
            }
            
            let select = "select * from  contact  where other_account = '\(other_account_name)'"
            do{
                let selectResult = try db?.executeQuery(select, values: [] )
                  mylog("查询联系人\(other_account_name)成功")
                var index : NSInteger = 0
                while(selectResult?.next() )!{
                    index += 1
                }
                if (index > 0){
                     mylog("查询联系人\(other_account_name)成功 , 执行更新操作")
                     let update = "update contact set last_message = ? , time_stamp = ? where other_account = ?"
                    let updateResult = db?.executeUpdate(update, withArgumentsIn:  [message.body()! , "\(timeStamp)" , other_account_name] )
                        if let realResult = updateResult{
                            if(realResult){
                                mylog("更新联系人\(other_account_name)成功 ")

                                
                            }else{
                                mylog("更新联系人\(other_account_name)失败 ")
                                    }
                        }

                }else{
                     mylog("查询联系人\(other_account_name)失败 , 无响应的联系人 , 执行插入操作")
                    let insert = "insert into contact ( other_account , time_stamp , last_message) values (?,?,?)"
                    let insertResult = db?.executeUpdate(insert, withArgumentsIn:  [other_account_name , "\(timeStamp)" ,message.body()!])
                        if let insertRealResult = insertResult{
                            if(insertRealResult){
                                mylog("插入最近联系人成功")
        
                            }else{
                                mylog("插入最近联系人失败")
                            }
                        }else{
                            mylog("插入最近联系人失败")
                            
                        }
                }

            }catch{
                  mylog("查询联系人\(other_account_name)失败")
            }
//            if let selectRealResult = selectResult{
//                if(selectRealResult){
//                    mylog("查询联系人\(other_account_name)成功")
//                    
//                }else{
//                    mylog("查询联系人\(other_account_name)失败")
//                }
//            }else{
//                mylog("查询联系人\(other_account_name)失败")
//            }
            
            
//            let update = "update contact set last_message = ? , time_stamp = ? where other_account = ?"
//             let insert = "insert into contact ( other_account , time_stamp , last_message) values (?,?,?)"
//            
//            
//            let updateResult = db?.executeUpdate(update, withArgumentsIn:  [message.body()! , "\(timeStamp)" , other_account_name] )
//            if let realResult = updateResult{
//                if(realResult){
//                    mylog("更新最近联系人成功")
//                    
//                }else{
//                    mylog("更新最近联系人失败,开始执行插入")
//                     let insertResult = db?.executeUpdate(insert, withArgumentsIn:  [other_account_name , "\(timeStamp)" ,message.body()!])
//                    if let insertRealResult = insertResult{
//                        if(insertRealResult){
//                            mylog("插入最近联系人成功")
//                            
//                        }else{
//                            mylog("插入最近联系人失败")
//                            
//                            
//                        }
//                    }else{
//                        mylog("插入最近联系人失败")
//                        
//                    }
//                    
//                }
//            }else{
//                  mylog("更新最近联系人失败,开始执行插入")
//                let insertResult = db?.executeUpdate(insert, withArgumentsIn:  [other_account_name , "\(timeStamp)" ,message.body()!])
//                if let insertRealResult = insertResult{
//                    if(insertRealResult){
//                        mylog("插入最近联系人成功")
//                        
//                    }else{
//                        mylog("插入最近联系人失败")
//                        
//                        
//                    }
//                }else{
//                    mylog("插入最近联系人失败")
//                    
//                }
//            }
            
            
            
//            do {
//               try db?.executeUpdate(update, values: [message.body()! , "\(timeStamp)"] )
//                mylog("更新最近联系人成功")
//
//            } catch  {
//                mylog("更新最近联系人失败,开始执行插入")
//                let insert = "insert into contact ( other_account , time_stamp , last_message) values (?,?,?)"
//                do {
//                    
//                    try db?.executeUpdate(insert, values: [other_account_name , "\(timeStamp)" ,message.body()!] )
//                    mylog("最近联系人插入成功")
//
//                } catch  {
//                    mylog("最近联系人插入失败")
//
//                    
//                }
//
//            }
            
            
        }
    }
    // MARK: 注释 : 插入单条信息
    func singleInsertFouncation( db : FMDatabase? ,message : XMPPMessage ,isMax : String, from : String , to : String  , callBack:@escaping ((_ isSucess:Int ,_ resultStr : String)->()))  {
        var sortMax : Int = 0;
        var sortMin : Int = 0
        do {
            let resultSet =  try db?.executeQuery("select max(sort_key) as sort from message;", values: nil )
            //                mylog(resultSet?.columnCount())//总工有多少列
            while(resultSet?.next() )!{
                let resultOption = resultSet?.object(forColumnName: "sort")
                if let resultAny = resultOption {
                    //                        mylog(resultAny)
                    if let realInt =  resultAny as? Int {
                        sortMax = realInt
                        sortMax = sortMax + 1
                    }
                }
            }
        } catch  {
            mylog("查询失败")
        }
        
        do {
            let resultSet =  try db?.executeQuery("select min(sort_key) as sort from message;", values: nil )
            //                mylog(resultSet?.columnCount())//总工有多少列
            while(resultSet?.next() )!{
                let resultOption = resultSet?.object(forColumnName: "sort")
                if let resultAny = resultOption {
                    if let realInt =  resultAny as? Int {
                        sortMin = realInt
                        sortMin = sortMin - 1
                    }
                }
            }
        } catch  {
            mylog("查询失败")
        }
        
        var maxOrMin = 0
        if(isMax == "max"){
            maxOrMin = sortMax
        }else{
            maxOrMin = sortMin
        }
        let  fullMsgXML = message.description;
        let  myAccount = UserInfo.share().imName!//
        let  otherAccount =  from == myAccount ? to : from ;//不准 , 待优化 , 可能是自己 , 也可能是别人
        let  stamp = "\(NSDate.init().timeIntervalSince1970)";
        var   body = ""
        if let bodyStr = message.body() {
            
              body = bodyStr;
        }
        //            if (body.contains("'''")){
        //                body = body.replacingOccurrences(of: "'''", with: "''''''")
        //            }else if (body.contains("''")){
        //                body = body.replacingOccurrences(of: "''", with: "''''")
        //            }else if(body.contains("'")){
        //                body = body.replacingOccurrences(of: "'", with: "\'\'")
        //            }
        let elementArr = message.elements(forName: "archived")
        var  serverID = "0";
        for element in elementArr{
            //                DDXMLElement
            let   serverIDOption = element.attributeStringValue(forName: "id")
            if serverIDOption != nil{
                serverID = serverIDOption!
            }
        }
        var  localID = "0"
        let  localIDOption = message.attributeStringValue(forName: "id");
        //            mylog(message.description)
        //            mylog(localIDOption)
        //            mylog(message.elementID)
        if localIDOption != nil{
            localID = localIDOption!
        }
        let  fromAccount = from;
        let  toAccount =  to;
        //            let  SQLStr = "insert into message (full_message_xml, other_account ,my_account, time_stamp , body , server_id ,local_id ,from_account ,to_account , sort_key ) values ('\(fullMsgXML)' ,'\(otherAccount)' ,'\(myAccount)' ,'\(stamp)' ,'\(body)' ,'\(serverID)' ,'\(localID)','\(fromAccount)','\(toAccount)' ,'\(maxOrMin)')"
        //
        //            let isSuccessOption =  (db?.executeStatements(SQLStr))//这种方法插入单引号会失败
        let  SQLStr = "insert into message (full_message_xml, other_account ,my_account, time_stamp , body , server_id ,local_id ,from_account ,to_account , sort_key ) values (?,?,?,?,?,?,?,?,?,?)"
        
        let isSuccessOption =  (db?.executeUpdate(SQLStr, withArgumentsIn: [fullMsgXML ,otherAccount ,myAccount ,stamp ,body ,serverID ,localID,fromAccount,toAccount ,maxOrMin]))//这种可以插入单引号
        if(isSuccessOption == nil ){
            //                self.executeQuery(SQLStr: SQLStr)
            mylog("语句执行失败")
            callBack(0,"插入消息失败")
        }else{
            let isSuccess = isSuccessOption!
            if(isSuccess){
                mylog("语句执行成功")
                callBack(1,"插入消息成功")
                //                    self.selectQuery(SQLStr: "", dbQueue: self.xmppQueue)
            }else{
                //                    self.executeQuery(SQLStr :SQLStr)
                mylog(db?.lastError())
                mylog("语句执行失败")
                callBack(0,"插入消息失败")
            }
        }

    }

    // MARK: 注释 : 当收到对方收到消息后返回回执消息时 , 更新自己发送的消息的 serverID
    func updateMineMsgServerID(serverID : String , localID : String) {
        if currentUser != UserInfo.share().name! {
            mylog(self.xmppQueue)
            self.xmppQueue = self.gotCurrentDBQueue()
            currentUser = UserInfo.share().name!
            mylog(self.xmppQueue)
        }
        self.xmppQueue.inDatabase { (db) in
            let update = "update message set server_id = '\(serverID)' where local_id = '\(localID)'"
            let result = db?.executeStatements(update)
            if (result != nil) {
                if (result!){
                    mylog("updateMineMsgServerID成功")
                }else{
                    mylog("updateMineMsgServerID失败")
                }
            }else{
                mylog("updateMineMsgServerID失败")
            }
        }
    }
    /*
    func selectQuery(SQLStr : String , dbQueue : FMDatabaseQueue  , queryResult : @escaping FMDBExecuteStatementsCallbackBlock) {//红点默认不现实 , 查到了有has_read = 0才显示 , 并且return非零数
        //- (BOOL)executeStatements:(NSString *)sql withResultBlock:(FMDBExecuteStatementsCallbackBlock)block;
        
        dbQueue.inDatabase { (db ) in
            let isSuccessOption =  db?.executeStatements(SQLStr, withResultBlock: { (result ) -> Int32 in//这个block 每查到一个对象就会调用一次,如果查询到想要的结果可以return  非零  来结束查询
                //result :
                /*
                 has_read = 1;
                 fromAccount = <null>;
                 id = 28;
                 body = <null>;
                 local_id = <null>;
                 time_stamp = <null>;
                 send_success = <null>;
                 other_account = <null>;
                 my_account = wnagyuanfei;
                 server_id = <null>;
                 full_message_xml = <null>;
                 */
                guard let resultReal = result else{ return 0 ;}
                guard let id = resultReal["id"] else{return 0 ;}
                let update = "update  message set has_read = 1 where id = '\(id)' "
                print("\(id):\(update)")
                db?.executeStatements(update)
               return  queryResult(result)
                
            })
            if(isSuccessOption == nil ){
                //                self.executeQuery(SQLStr: SQLStr)
                mylog("查询失败")
            }else{
                let isSuccess = isSuccessOption!
                if(isSuccess){
                    mylog("查询成功")
                }else{
                    //                    self.executeQuery(SQLStr :SQLStr)
                    mylog("查询失败")
                }
            }
        }
    }*/

    //MARK:
    //MARK:增
    //MARK:删
    //MARK:改
    //MARK:查
}
