//
//  ContentView.swift
//  Bullseye
//
//  Created by Maurício de Freitas Sayão on 13/08/20.
//  Copyright © 2020 Maurício de Freitas Sayão. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    let midnightBlue = Color(red: 0.0 / 255.0, green: 51.0 / 255.0, blue: 102.0 / 255.0)
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .foregroundColor(Color.white)
            .modifier(ShadowStyle())
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .foregroundColor(Color.yellow)
            .modifier(ShadowStyle())
            .font(Font.custom("Arial Rounded MT Bold", size: 24))
        }
    }
    
    struct ShadowStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .foregroundColor(Color.black)
            .modifier(ShadowStyle())
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .foregroundColor(Color.black)
            .modifier(ShadowStyle())
            .font(Font.custom("Arial Rounded MT Bold", size: 12))
        }
    }

    var body: some View {
        VStack {
            Spacer()
            // Target row
            HStack {
                Text("Put the bullseyes as close as you can to:").modifier(LabelStyle())
                Text("\(target)").modifier(ValueStyle())
            }
            Spacer()
            // Slider row
            HStack {
                Text("1").modifier(LabelStyle())
                Slider(value: $sliderValue, in: 1...100).accentColor(Color.green)
                Text("100").modifier(LabelStyle())
            }
            Spacer()
            // Button row
            Button(action: {
                self.alertIsVisible = true
               
            }) {
                Text(/*@START_MENU_TOKEN@*/"Hit Me!"/*@END_MENU_TOKEN@*/).modifier(ButtonLargeTextStyle())
            }
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                let roundedValue: Int = Int(sliderValue.rounded())
                return Alert(title: Text("\(alertTitle())"), message: Text("The slider's value is \(roundedValue).\n" +
                    "You score \(pointsForCurrentRound()) points this round"), dismissButton: .default(Text("Awesome")){
                        self.score += self.pointsForCurrentRound()
                        self.target = Int.random(in: 1...100)
                        self.round += 1
                    })
            }
            .background(Image("Button")).modifier(ShadowStyle())
            Spacer()
            // Score row
            HStack {
                Button(action: {
                    self.startNewGame()
                }) {
                    HStack{
                        Image("StartOverIcon").accentColor(midnightBlue)
                        Text("Start over").modifier(ButtonSmallTextStyle())
                    }
                }.background(Image("Button")).modifier(ShadowStyle())
                Spacer()
                Text("Score:").modifier(LabelStyle())
                Text("\(score)").modifier(ValueStyle())
                Spacer()
                Text("Round").modifier(LabelStyle())
                Text("\(round)").modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: AboutView()){
                    HStack{
                        Image("InfoIcon").accentColor(midnightBlue)
                        Text("Info").modifier(ButtonSmallTextStyle())
                    }
                }.background(Image("Button")).modifier(ShadowStyle())
            }.padding(.bottom, 20)
        }.background(Image("Background"), alignment: .center)
        .accentColor(midnightBlue)
        .navigationBarTitle("Bullseye")
    }
    
    func startNewGame() {
        alertIsVisible = false
        sliderValue = 50.0
        target = Int.random(in: 1...100)
        score = 0
        round = 1
    }
    
    func pointsForCurrentRound() -> Int {
        let maximumScore = 100
        let diference = abs(target - Int(sliderValue.rounded()))
        let bouns: Int
        if diference == 0 {
            bouns = 100
        } else if diference == 1 {
            bouns = 50
        } else {
            bouns = 0
        }
        return maximumScore - diference + bouns
    }
    
    func alertTitle() -> String {
        let diference = abs(target - Int(sliderValue.rounded()))
        if diference == 0 {
            return "Perfect!"
        } else if diference < 5 {
            return "You almost had it!"
        }else if diference <= 10 {
            return "Not bad!"
        }else {
            return "Are you even trying?"
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
