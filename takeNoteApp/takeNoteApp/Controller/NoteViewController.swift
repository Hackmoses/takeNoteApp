//
//  ViewController.swift
//  takeNoteApp
//
//  Created by MACBOOK PRO on 11/26/22.
//
import Foundation
import UIKit
import CoreData

class NoteViewController: UIViewController {

    
    var selectedNote : Note? = nil
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var moreDetailTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (selectedNote != nil) {
            titleTextField.text = selectedNote?.title
            moreDetailTextView.text = selectedNote?.detail
        }
      
    }

    @IBAction func saveNote(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        if(selectedNote == nil) {
            let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
            
            let aNote = Note(entity: entity!, insertInto: context)
            aNote.id = myNote.count as NSNumber
            aNote.title = titleTextField.text
            aNote.detail = moreDetailTextView.text
            
            do {
                try context.save()
                myNote.append(aNote)
                navigationController?.popViewController(animated: true)
            }
            catch {
                print("Note Save Error")
            }
            
            
        }
        else {
            let request = NSFetchRequest<NSFetchRequestResult> (entityName: "Note")
            
            do {
                let results: NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let note = result as! Note
                    if (note == selectedNote) {
                        
                        note.title = titleTextField.text
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
                }
            }
            catch {
                print("Request Failed")
            }
            
        }
       
    }
    
    @IBAction func deleteNote(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult> (entityName: "Note")
        
        do {
            let results: NSArray = try context.fetch(request) as NSArray
            for result in results {
                let note = result as! Note
                if (note == selectedNote) {
                    
                    note.deletedDate = Date()
                    note.detail = moreDetailTextView.text
                    navigationController?.popViewController(animated: true)
                }
            }
        }
        catch {
            print("Request Failed")
        }
    }
    
    
}

