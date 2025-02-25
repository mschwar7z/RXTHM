//
//  PlayView.swift
//  MusicApp
//
//  Created by Mia Schwartz on 12/2/22.
//

import SwiftUI
import Foundation
import Firebase
import AVFoundation

struct PlayView: View {
    @State var album: Album
    @State var song: Song
    
    @State var player = AVPlayer()
    
    @State var isPlaying : Bool = true
    
    var body: some View {
        ZStack{
            //top background color!!!!
            Color.orange.opacity(0.15)
                .cornerRadius(20)
                .edgesIgnoringSafeArea(.all)
            //Blur(style: .dark).edgesIgnoringSafeArea(.all)
            VStack{
                Image(album.image)
                    .resizable()
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    .frame(width: 325, height: 345, alignment: .center)
                Spacer()
                Text(song.name)
                    .font(.title)
                    .bold()
                    //.foregroundColor(.purple)
                    .frame(width: 290, height: 20, alignment: .leading)
                Text(album.artist)
                    .foregroundColor(.purple)
                    .frame(width: 290, height: 20, alignment: .leading)
            
                ZStack{
                    /*//bottom background color!!!!!
                    Color
                        .purple.opacity(0)
                        .cornerRadius(20)
                        .shadow(radius: 10)*/
                    HStack{
                        Button(action: self.previous, label: {
                            Image(systemName: "arrow.left.circle")
                                .resizable()
                        }).frame(width: 60, height: 60, alignment: .center).foregroundColor(.black.opacity(0.7))
                        
                        Button(action: self.playPause, label: {
                            Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                .resizable()
                                .foregroundColor(.purple)
                        }).frame(width: 90, height: 90, alignment: .center).padding()
                        
                        Button(action: self.next, label: {
                            Image(systemName: "arrow.right.circle")
                                .resizable()
                        }).frame(width: 60, height: 60, alignment: .center).foregroundColor(.black.opacity(0.7))
                    }//end HStack
                }.edgesIgnoringSafeArea(.bottom).frame(height: 200, alignment: .center)//end ZStack
            }//end VStack
        }//end ZStack
        .onAppear(){
            self.playSong()
        }
    }

    func playSong(){
        let storage = Storage.storage().reference(forURL: self.song.file)
        storage.downloadURL { (url, error) in
            if error != nil {
                print(error ?? "No error")
            } else {
                
                do {
                    try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                } catch {
                    // report for an error
                }
        
                print(url?.absoluteString ?? "")
                player = AVPlayer(playerItem: AVPlayerItem(url: url!))
                player.play()
            }
        }

    }

    func playPause(){
        self.isPlaying.toggle()
        if isPlaying == false{
            player.pause()
        } else {
            player.play()
        }
    }

    func next(){
        if let currentIndex = album.songs.firstIndex(of: song){
            if currentIndex == album.songs.count - 1{
                
            } else {
                player.pause()
                song = album.songs[currentIndex + 1]
                self.playSong()
            }
        }
    }

    func previous(){
        if let currentIndex = album.songs.firstIndex(of: song){
            if currentIndex == 0 {
                
            } else {
                player.pause()
                song = album.songs[currentIndex - 1]
                self.playSong()
        }
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView(album: albums[0], song: albums[0].songs[0])
    }
}
}
