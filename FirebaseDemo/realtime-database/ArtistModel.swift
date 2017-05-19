//
//  ArtistModel.swift
//  FirebaseDemo
//
//  Created by mineachem on 5/9/17.
//  Copyright © 2017 mineachem. All rights reserved.
//

import Foundation

class ArtistModel {
    
    var id: String?
    var name: String?
    var genre: String?
    
    init(id: String?, name: String?, genre: String?) {
        self.id = id
        self.name = name
        self.genre = genre
    }
    
}
