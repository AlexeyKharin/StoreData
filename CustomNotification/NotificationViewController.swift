//
//  NotificationViewController.swift
//  CustomNotification
//
//  Created by Alexey Kharin on 02.05.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    
    @IBOutlet var image: UIImageView? {
        didSet {
            image?.backgroundColor = .black
            image?.contentMode = .scaleAspectFit
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        if let imageURL = notification.request.content.attachments.last?.url {
//        if let imageURL = notification.request.content.userInfo["attachment-url"] as! URL? {
//            //               if let imageURL = URL(string: urlString) {
            if let data = NSData(contentsOf: imageURL) {
                self.image?.image = UIImage(data: data as Data)
            }
        }
    }
}
