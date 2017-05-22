//
//  ViewController.swift
//  FirebaseDemo
//
//  Created by mineachem on 4/21/17.
//  Copyright © 2017 mineachem. All rights reserved.
//

import UIKit
import Firebase
class RealtimeDatabaseViewController: UIViewController {

    @IBOutlet weak var textFieldName: UITextField!

    @IBOutlet weak var textFieldGenre: UITextField!
    
    @IBOutlet weak var labelMessage: UILabel!
    
    var refArtists: DatabaseReference!
    
    @IBOutlet weak var tableViewArtists: UITableView!
    
    //list to store all the artist
    var artistList = [ArtistModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewArtists.delegate = self
        tableViewArtists.dataSource = self
        //getting a reference to the node artists
        refArtists = Database.database().reference().child("artists")
        
        
        //observing the the data changes
        refArtists.observe(DataEventType.value, with: { (snapshot) in
            // if the reference have some values
            if snapshot.childrenCount > 0 {
                //clearing the list
                self.artistList.removeAll()
                
                //iterationg through all the values
                
                for artist in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    
                    let artistObject = artist.value as? [String:AnyObject]
                    let artistName = artistObject?["artistName"]
                    let artistId = artistObject?["id"]
                    let artistGenre = artistObject?["artistGenre"]
                    
                    //creating artist object with model and fetched values
                    
                    let artist = ArtistModel(id: artistId as! String?, name: artistName as! String?, genre: artistGenre as! String)
                    
                    //appending it to list
                    self.artistList.append(artist)
                    
                }
                //reloading the tableview
                
                self.tableViewArtists.reloadData()
            }
        })
    }
    
    
    @IBAction func addArtists(_ sender: Any) {
        addArtist()
    }
    
    
    func addArtist() {
        //generating a new key inside artists node
        // and also getting the generated key
        let key = refArtists.childByAutoId().key
        
        //creating artist with the given values
        let artist = ["id": key,
                      "artistName": textFieldName.text! as String,
                      "artistGenre": textFieldGenre.text! as String
                      ]
        
        //adding the artist inside the generated unique key
        refArtists.child(key).setValue(artist)
        
        //displaying message
        labelMessage.text = "Artist Added"
    }

   
    func updateArtist(id:String,name:String, genre:String){
        
        
        //creating artist with the new given values
        let artist = ["id": id,
                      "artistName": name,
                      "artistGenre": genre
        ]
        
        //updating the artist using the key of the artist
        refArtists.child(id).setValue(artist)
        
        //displaying message
        labelMessage.text = "Artist Updated"
    }
    
    func deleteArtist(id:String){
        refArtists.child(id).setValue(nil)
    }
}

extension RealtimeDatabaseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return artistList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //creating a cell using the custom class
        let cell = tableView.dequeueReusableCell(withIdentifier: "artists", for: indexPath) as! ArtistsTableViewCell
        
        //the artist object
        let artist: ArtistModel
        
        // getting the artist
        
        artist = artistList[indexPath.row]
        
        // adding values to labels
        cell.labelName.text = artist.name
        cell.labelGenre.text = artist.genre
        
        //returning cell
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //getting the selected artist
        let artist = artistList[indexPath.row]
        
        //building an alert
        let alertController = UIAlertController(title: artist.name, message: "Give new values to update", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            
            
            //getting artist id
            let id = artist.id
            
            //getting new values
            let name = alertController.textFields?[0].text
            let genre = alertController.textFields?[1].text
            
            //calling the update method to update artist
            self.updateArtist(id: id!, name: name!, genre: genre!)
        }
        
        // the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            
            self.deleteArtist(id: artist.id!)
        
        }
            
        
            //adding two textfields to alert
            
            alertController.addTextField(configurationHandler: { (textField) in
                textField.text = artist.name
            })
            alertController.addTextField(configurationHandler: { (textField) in
                textField.text = artist.genre
            })
    
            // adding action
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //presenting dialog
        present(alertController, animated: true, completion: nil)
        
        
    }
}
