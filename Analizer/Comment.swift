//
//  Comment.swift
//  Analizer
//
//  Created by Blaz on 23/09/14.
//  Copyright (c) 2014 Blaz. All rights reserved.
//

import Foundation

class Comment {
    var body = ""
    var comment_id = 0
    var ownerRep = 0
    var ownerName = ""
    
    init(body:String, comment_id:Int, ownerRep:Int, ownerName:String) {
        self.body = body
        self.comment_id = comment_id
        self.ownerRep = ownerRep
        self.ownerName = ownerName
    }
}