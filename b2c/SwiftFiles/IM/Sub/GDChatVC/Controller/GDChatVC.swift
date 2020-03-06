//
//  GDChatVC.swift
//  zjlao
//
//  Created by WY on 17/1/8.
//  Copyright © 2017年 com.16lao.zjlao. All rights reserved.
//

import UIKit
import CoreData
import XMPPFramework
class GDChatVC: GDNormalVC , NSFetchedResultsControllerDelegate  , XMPPvCardTempModuleDelegate{
    var messages  = [XMPPMessageArchiving_Message_CoreDataObject]()
    var toUserJid  : XMPPJID =  XMPPJID(user: "kefu", domain: "jabber.zjlao.com", resource: "iOS")
    var contactFetchedresultsController : NSFetchedResultsController<NSFetchRequestResult>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //获取当前联系人名片
        let vcard  = GDXmppManager.share.xmppVCardTempModule.vCardTemp(for: self.toUserJid, shouldFetch: true )
        mylog(vcard?.nickname)
        GDXmppManager.share.xmppVCardTempModule.addDelegate(self , delegateQueue: DispatchQueue.main)
        
        NSFetchedResultsController<NSFetchRequestResult>.deleteCache(withName: "Message")
        _ = self.setupContactFetchedresultsController()
        do {
            try self.contactFetchedresultsController?.performFetch()
            
            self.messages = self.contactFetchedresultsController?.fetchedObjects as! [XMPPMessageArchiving_Message_CoreDataObject]
            mylog(self.messages.count)
        } catch  {
            mylog("shibai")
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func test() {
        
    }
    func setupContactFetchedresultsController() -> NSFetchedResultsController<NSFetchRequestResult> {
        if self.contactFetchedresultsController == nil  {
            
            let fetchrequest = NSFetchRequest<NSFetchRequestResult>.init()//查询请求
            let entitys = NSEntityDescription.entity(forEntityName: "XMPPMessageArchiving_Message_CoreDataObject", in: XMPPMessageArchivingCoreDataStorage.sharedInstance().mainThreadManagedObjectContext)
            fetchrequest.entity = entitys ?? nil
            let domain = "@\(self.toUserJid.domain)"
            let source = "/\(self.toUserJid.resource)"
            let bearStr = self.toUserJid.user.appending(domain).appending(source)
            let predicate = NSPredicate.init(format: "bareJidStr = %@", self.toUserJid.bare() as String ) //有疑问
            fetchrequest.predicate = predicate
            
            let sort  =  NSSortDescriptor(key: "timestamp", ascending: true )
            fetchrequest.sortDescriptors = [sort]
            let temp = NSFetchedResultsController.init(fetchRequest: fetchrequest, managedObjectContext: XMPPMessageArchivingCoreDataStorage.sharedInstance().mainThreadManagedObjectContext, sectionNameKeyPath: nil , cacheName: nil )
            temp.delegate = self
            self.contactFetchedresultsController = temp
            return self.contactFetchedresultsController!
        }else{
            return self.contactFetchedresultsController!
        }
        
    }
    
//    lazy var contactFetchedresultsController : NSFetchedResultsController = { () -> NSFetchedResultsController<NSFetchRequestResult> in
//        let fetchrequest = NSFetchRequest<NSFetchRequestResult>.init()//查询请求
//        let entitys = NSEntityDescription.entity(forEntityName: "XMPPMessageArchiving_Message_CoreDataObject", in: XMPPMessageArchivingCoreDataStorage.sharedInstance().mainThreadManagedObjectContext)
//        fetchrequest.entity = entitys ?? nil
//        
//        let predicate = NSPredicate.init(format: "bareJidStr = %@", self.toUserJid.bare() ) //有疑问
//        fetchrequest.predicate = predicate
//        
//        let sort  =  NSSortDescriptor(key: "timestamp", ascending: true )
//        fetchrequest.sortDescriptors = [sort]
//        let temp = NSFetchedResultsController.init(fetchRequest: fetchrequest, managedObjectContext: XMPPMessageArchivingCoreDataStorage.sharedInstance().mainThreadManagedObjectContext, sectionNameKeyPath: nil , cacheName: "Message")
//        return temp
//    }()
    //delegate
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>){
        self.messages = self.contactFetchedresultsController?.fetchedObjects as! [XMPPMessageArchiving_Message_CoreDataObject]
        mylog(self.messages.count)
        //self.tableView.reloadData()
    }
}
