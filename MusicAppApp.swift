//
//  MusicAppApp.swift
//  MusicApp
//
//  Created by Mia Schwartz on 11/17/22.
//

import SwiftUI
import Firebase

@main
struct MusicAppApp: App {
    
    let data = OurData()
    
    init(){
        FirebaseApp.configure()
        data.loadAlbums()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(data: data)
        }
    }
}
