//
//  SwiftUIView.swift
//  MusicApp
//
//  Created by Mia Schwartz on 11/30/22.
//

import SwiftUI
import Firebase
import Foundation


struct AlbumView: View {
    var album : Album
    var body: some View {
        ScrollView{
            ScrollView(.vertical, showsIndicators: true, content: {
                VStack{
                    VStack{
                        Image(album.image)
                            .resizable()
                            .cornerRadius(15)
                            .shadow(radius: 5)
                            .padding(.top, 10)
                            .frame(width: 325, height: 325, alignment: .center)
                        
                        Text(album.name)
                            .font(.title2)
                            .frame(width: 350, height: 20, alignment: .center)
                        
                        Text(album.artist)
                            .font(.title3)
                            .foregroundColor(.purple)
                            .frame(width: 325, height: 10, alignment: .center)
                    }
                        VStack{
                            
                            ForEach(self.album.songs, id: \.self, content: {
                                song in
                                NavigationLink(destination: PlayView(album: album, song: song)) {
                                    SongList(song: song)
                                }
                            })
                        }
                }
            })
            
            
        }
    }
}


struct SongList : View {
    var song : Song
    var body: some View {
        
        HStack{
            
            
                Text(song.order)
                    .foregroundColor(.purple)
                
                Text(song.name)
                    .foregroundColor(.black)
                    .font(.title2)
                
                    //.frame(width: .infinity, height: 17, alignment: .leading)
                Spacer()
                Text(song.time)
                    .foregroundColor(.gray)
                    //.frame(width: 280, height: 10, alignment: .leading)
            
            
             
            
                
        }.padding(7).padding(.leading, 20).padding(.trailing, 30) //endHStack
    }
}

struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumView(album: albums[0])
    }
}
