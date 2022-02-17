//
//  ContentView.swift
//  TimerApp
//
//  Created by 高橋蓮 on 2022/02/15.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var timerManager = TimerManager()
    
    @State var selectedPickerIndex = 0
    
    let availableMinutes = Array(1...59)
    
    var body: some View {
        
        NavigationView {
            VStack {
                Text(secondsToMinutesAndSeconds(seconds: timerManager.secondsLeft))
                    .font(.system(size: 80))
                    .padding(.top, 80)
                Image(systemName: timerManager.timerMode == .running ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 130, height: 130)
                    .foregroundColor(.red)
                    .onTapGesture(perform: {
                        if self.timerManager.timerMode == .initial {
                            self.timerManager.setTimerLength(minutes: self.availableMinutes[self.selectedPickerIndex]*60)
                        }
                        self.timerManager.timerMode == .running ? self.timerManager.pause() : self.timerManager.start()
                    })
                
                Spacer()
                
                if timerManager.timerMode == .paused {
                    Image(systemName: "gobackward")
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                        .padding(.top, 40)
                        .onTapGesture(perform: {
                            self.timerManager.reset()
                        })
                }
                if timerManager.timerMode == .initial {
                    ZStack {
                        Image(systemName: "rectangle.fill")
                            .foregroundColor(.white)
                            
                        Picker(selection: $selectedPickerIndex, label: Text("時間を選択"), content: {
                            ForEach(0 ..< availableMinutes.count) {
                                Text("\(self.availableMinutes[$0]) min")
                                    .font(.largeTitle)
                            }
                            
                        })
                    }
                    .frame(width: 100)
                }
                Spacer()
            }
            .navigationBarTitle("Timer")
        }
        .font(.system(size: 50))
        .environment(\.colorScheme, .dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
