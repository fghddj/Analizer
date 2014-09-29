//
//  DetailView.swift
//  Analizer
//
//  Created by Blaz on 29/09/14.
//  Copyright (c) 2014 Blaz. All rights reserved.
//

import Foundation
import UIKit

class DetailView:UIViewController {
    var sentimentURL = "https://api.idolondemand.com/1/api/sync/analyzesentiment/v1?apiKey=705dc46d-9b20-4f9f-94a2-3ed429138b57&text="
    var comment:Comment!
    var sentimentResponse:NSDictionary!
    
    @IBOutlet weak var sentiment: UILabel!
    @IBOutlet weak var commentBody: UITextView!
    @IBOutlet weak var userLabel: UILabel!
    
    override func viewDidLoad() {
        commentBody.text = comment.body
        userLabel.text = "\(comment.ownerName) : \(comment.ownerRep)"
        getSentiment()
    }
    
    func getSentiment() {
        var error:NSError?
        var encodedText = comment.body.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        Get.JSON(sentimentURL + encodedText!) {
            (response) in
            self.sentimentResponse = response
            dispatch_async(dispatch_get_main_queue()) {
                var aggregate = self.sentimentResponse["aggregate"]!["sentiment"]! as String
                self.sentiment.text = aggregate
                self.highlightText()
            }
        }
    }
    
    func highlightText() {
        var positives = sentimentResponse["positive"]! as NSArray
        var fullAttString = NSMutableAttributedString(string: comment.body)
        for positiveSentiment in positives {
            var string = comment.body as NSString
            var positive = positiveSentiment as NSDictionary
            var selectedRange = string.rangeOfString(positive["original_text"]! as String)
            fullAttString.addAttribute(String(NSForegroundColorAttributeName), value: UIColor.greenColor(), range: selectedRange)
        }
        
        var negatives = sentimentResponse["negative"]! as NSArray
        for negativeSentiment in negatives {
            var string = comment.body as NSString
            var negative = negativeSentiment as NSDictionary
            var selectedRange = string.rangeOfString(negative["original_text"]! as String)
            fullAttString.addAttribute(String(NSForegroundColorAttributeName), value: UIColor.redColor(), range: selectedRange)
        }
        
        commentBody.attributedText = fullAttString
    }
    
}