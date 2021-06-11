//
//  ContentView.swift
//  SoundBar
//
//  Created by XiaoyuWang on 2021/6/10.
//

import SwiftUI
import AVFoundation

let numberOfSamples: Int = 1

struct BarView: View {
    var value: CGFloat

    var body: some View {
            RoundedRectangle(cornerRadius: 20)
                //.frame(width: (UIScreen.main.bounds.width - CGFloat(numberOfSamples) * 4) / CGFloat(numberOfSamples), height: value)
                .frame(width: (UIScreen.main.bounds.width - 120) / CGFloat(numberOfSamples), height: value)

    }
}

struct ContentView: View {
    
    let hueColors = stride(from: 0, to: 1, by: 0.01).map {
            Color(hue: $0, saturation: 1, brightness: 1)
        }

   
        @ObservedObject private var mic = MicrophoneMonitor(numberOfSamples: numberOfSamples)
            
            // 2
            private func normalizeSoundLevel(level: Float) -> CGFloat {
                print(level)
                let level = max(0.1, CGFloat(level) + 50)  // between 0.1 and 25
                
                return CGFloat(level * ((UIScreen.main.bounds.height-40) / 50)) // scaled to max at 300 (our height of our bar)
            }
            
            var body: some View {
                //多个bar
//                VStack {
//                     // 3
//                    HStack(spacing: 4) {
//                         // 4
//                        ForEach(mic.soundSamples, id: \.self) { level in
//                            BarView(value: self.normalizeSoundLevel(level: level))
//                        }
//                    }
//                }
                ZStack{
                    LinearGradient(gradient: Gradient(colors:[.red,.blue,.green]),startPoint: .top,endPoint: .bottom)
                        .mask(
                            VStack(alignment: .leading){
                            Spacer()
                            BarView(value: self.normalizeSoundLevel(level: mic.soundSamples[0]))
                                .animation(.easeInOut)
                        })
                    
                    
                    
                }
                
                    
                
                
            }
    
}

