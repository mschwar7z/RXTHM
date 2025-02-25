//
//  ContentView.swift
//  MusicApp
//
//  Created by Mia Schwartz on 11/17/22.
//

import SwiftUI
import Firebase


struct Album : Hashable {
    var id = UUID()
    var name : String
    var artist : String
    var image : String
    var songs : [Song]
}

struct Song : Hashable {
    var id = UUID()
    var order : String
    var name : String
    var time : String
    var file : String
}

var albums = [Album(name: "", artist: "", image: "",
                    songs: [Song(order: "", name: "", time: "", file: "")])]


struct ContentView: View {
    
    @ObservedObject var data : OurData
    var body: some View {
        NavigationView{
            ScrollView{
                ScrollView(.vertical, showsIndicators: true, content: {
                    VStack{
                        ForEach(self.data.albums, id: \.self, content: {
                            album in
                            AlbumArt(album: album)
                        })
                    }
                })
            }.navigationTitle("Albums").frame(width: 400)
        }
    }
}


struct AlbumArt : View {
    var album : Album
    var body: some View {
        VStack{
            NavigationLink(destination: AlbumView(album: album)) {
                Image(album.image)
                    .resizable()
                    .cornerRadius(15)
                    .shadow(radius: 10)
                    .frame(width: 300, height: 300, alignment: .center)
            }
            Text(album.name)
                .font(.title2)
                .frame(width: 280, height: 17, alignment: .leading)
            
            Text(album.artist)
                .foregroundColor(.purple)
                .frame(width: 280, height: 10, alignment: .leading)
                
        }.padding(10).padding(.leading, 30).padding(.trailing, 30) //endVStack
    }
}


