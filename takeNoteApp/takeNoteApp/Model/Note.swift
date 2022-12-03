//
//  Note.swift
//  takeNoteApp
//
//  Created by MACBOOK PRO on 11/26/22.
//

import CoreData

@objc(Note)

class Note: NSManagedObject {
    @NSManaged var id : NSNumber!
    @NSManaged var title : String!
    @NSManaged var detail : String!
    @NSManaged var deletedDate : Date?
}
