//
//  SplashScreen.swift
//  TodoApp
//
//  Created by Khai Nguyen Minh on 3/20/22.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        card(text: "Todo List")
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}

func card(text: String) -> some View {
    ZStack {
        RoundedRectangle(cornerRadius: 25)
            .shadow(radius: 3)
            .frame(width: 600, height: 160)
            .foregroundColor(.white)
        Text(text)
            .fontWeight(.semibold)
            .scalableText()
            .foregroundColor(Color.black)
            .frame(width: 400)
    }
}

private struct SplashAnimation: ViewModifier {
    @State private var animating = true
    let finalYPosition: CGFloat
    let delay: Double

    func body(content: Content) -> some View {
        content
            .offset(y: animating ? -700 : finalYPosition)
            .onAppear {
                animating = false
            }
    }
}
