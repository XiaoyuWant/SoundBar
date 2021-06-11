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
                //.frame(width: (UIScreen.main.bounds.width - CGFloat(numberOfSamples) * 4-120) / CGFloat(numberOfSamples), height: value)
                .frame(width: (UIScreen.main.bounds.width - 300) / CGFloat(numberOfSamples), height: value)

    }
}

struct ContentView: View {
    
   
        @ObservedObject private var mic = MicrophoneMonitor(numberOfSamples: numberOfSamples)
            
            private func normalizeSoundLevel(level: Float) -> CGFloat {
                print(level)
                let level = max(0.1, CGFloat(level) + 50)  // between 0.1 and 25
                
                return CGFloat(level * ((UIScreen.main.bounds.height-40) / 50))
            }
            
            var body: some View {
                

                ZStack{
                    LinearGradient(gradient: Gradient(colors:[.red,.blue,.green]),startPoint: .top,endPoint: .bottom)
                        .mask(
                            //多个bar
//                            HStack(spacing:4){
//                                ForEach(mic.soundSamples,id:\.self){ level in
//                                    VStack(alignment: .leading){
//                                    Spacer()
//                                    BarView(value: self.normalizeSoundLevel(level: level))
//                                        .animation(.easeInOut)
//                                }
//
//                                }
//
//                            }
                            // 单个bar
                            VStack(alignment: .leading){
                            Spacer()
                            BarView(value: self.normalizeSoundLevel(level: mic.soundSamples[0]))
                                .animation(.easeInOut)
                        }
                            )
                    // 网格遮罩
                    VStack{
                        ForEach(0..<20){ num in
                            Spacer()
                            Rectangle()
                                .colorInvert()
                                .frame(width: UIScreen.main.bounds.width, height: 5, alignment: .leading)
                            Spacer()
                                
                            
                            
                        }
                    }
                    
                    
                    
                }
                
                    
                
                
            }
    
}

