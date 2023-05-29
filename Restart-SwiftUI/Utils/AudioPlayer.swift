//
//  AudioPlayer.swift
//  Restart-SwiftUI
//
//  Created by Can Kanbur on 29.05.2023.
//

import Foundation
import AVFoundation

var audioPlayer : AVAudioPlayer?

func playSound(soundName: String,soundType:String){
    if let path = Bundle.main.path(forResource: soundName, ofType: soundType){
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(filePath: path))
            audioPlayer?.play()
        }catch{
            print("error")
        }
    }
}
