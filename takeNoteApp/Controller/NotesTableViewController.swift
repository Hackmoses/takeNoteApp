//
//  NotesTableViewController.swift
//  takeNoteApp
//
//  Created by MACBOOK PRO on 11/26/22.
//

import UIKit
import CoreData

var myNote = [Note]()

class NotesTableViewController: UITableViewController {

    var firstLoad = true
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (firstLoad) {
            
            firstLoad = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult> (entityName: "Note")
            
            do {
                let results: NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let note = result as! Note
                    myNote.append(note)
                }
            }
            catch {
                print("Request Failed")
            }
        }

    }
    
    func nonDeletedNote() -> [Note] {
        var noDeletedNoteList = [Note]()
        
        for note in myNote {
            if(note.deletedDate == nil) {
                noDeletedNoteList.append(note)
            }
        }
        
        return noDeletedNoteList
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let noteCell = tableView.dequeueReusableCell(withIdentifier: "myNoteCell", for: indexPath) as! NoteViewCell
        
        let newNote: Note!
        newNote = nonDeletedNote()[indexPath.row]
        
        noteCell.titleLabel.text = newNote.title
        noteCell.detailLabel.text = newNote.detail
        
        return noteCell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nonDeletedNote().count
    }

    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editNote", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "editNote") {
            let indexPath = tableView.indexPathForSelectedRow!
            
            let noteDetail = segue.destination as? NoteViewController
            
            let selectedNote: Note!
            selectedNote = nonDeletedNote()[indexPath.row]
            noteDetail!.selectedNote = selectedNote
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

}
