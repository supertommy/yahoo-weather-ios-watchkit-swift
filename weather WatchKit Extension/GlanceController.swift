//
//  GlanceController.swift
//  weather WatchKit Extension
//
//  Created by Tommy Leung on 3/14/15.
//  Copyright (c) 2015 Tommy Leung. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController
{
    @IBOutlet weak var titleLabel: WKInterfaceLabel!
    @IBOutlet weak var temperatureLabel: WKInterfaceLabel!

    override func awakeWithContext(context: AnyObject?)
    {
        super.awakeWithContext(context)
        
        self.titleLabel.setText("")
        
        let userInfo = Dictionary<NSObject, AnyObject>()
        WKInterfaceController.openParentApplication(userInfo, reply: handleResponseFromPhoneApp)
    }

    override func willActivate()
    {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate()
    {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    private func handleResponseFromPhoneApp(replyInfo: [NSObject: AnyObject]!, error: NSError!)
    {
        let title = replyInfo["location"] as String
        let temp = replyInfo["temp"] as String
        let unit = replyInfo["unit"] as String
        
        self.titleLabel.setText("Weather for \(title)")
        self.temperatureLabel.setText("\(temp)\(unit)")
    }
}
