//
//  AboutView.swift
//  Bullseye
//
//  Created by Maurício de Freitas Sayão on 15/08/20.
//  Copyright © 2020 Maurício de Freitas Sayão. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    //255, 214, 179
    let backgroudColor = Color(red: 255.0/255.0, green: 214.0/255.0, blue: 179.0/255.0)
    
    struct HeadingStyle:ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 30))
                .padding(.bottom, 20)
                .padding(.top, 20)
        }
    }
    
    struct TextStyle:ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 16))
                .padding(.leading, 60)
                .padding(.trailing, 60)
                .padding(.bottom, 20)
                
        }
    }
    
    var body: some View {
        Group {
            VStack {
                Text("🎯 Bullseye 🎯").modifier(HeadingStyle())
                   
                
                Text("This is Bullseye, the game were you can win points and earn fame by draggind a slider.").modifier(TextStyle())
                    
                Text("Your goal to place the slider as close as possible to the target value. The you are, the more points your score.").modifier(TextStyle())
                
                Text("Enjoy").modifier(TextStyle())
            }
            .background(backgroudColor)
        .navigationBarTitle("About Bullseye")
        }.background(Image("Background"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
