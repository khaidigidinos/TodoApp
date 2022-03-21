//
//  AppLoadingScreen.swift
//  TodoApp
//
//  Created by Khai Nguyen Minh on 3/20/22.
//

import SwiftUI

struct AppLoadingScreen: View {
    @State private var showSplash = true
    @State private var showAddNewTodo = false
    var body: some View {
        if(showSplash) {
            SplashScreen()
             .edgesIgnoringSafeArea(.all)
             .onAppear {
                 DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                     withAnimation(.linear(duration: 1)) {
                         showSplash = false
                     }
                 }
             }
        } else {
            ContentView()
                .environmentObject(TodoItemsStore())
        }
    }
}

struct AppLoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        AppLoadingScreen()
    }
}
