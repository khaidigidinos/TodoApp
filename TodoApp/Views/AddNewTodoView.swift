//
//  AddNewTodoView.swift
//  TodoApp
//
//  Created by Khai Nguyen Minh on 3/21/22.
//

import SwiftUI

struct AddNewTodoView: View {
    @Binding var showAddNewTodo: Bool
    @EnvironmentObject var todoItems: TodoItemsStore
    @State private var input = ""
    var body: some View {
        VStack {
            Text("Enter new item below")
                .font(.title)
                .padding()
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .shadow(radius: 3)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .padding()
                TextField("Enter new item", text: $input)
                    .scaledToFit()
                    .padding()
            }.padding(.bottom)
            Button("Save", action: {
                do {
                    if(!input.isEmpty) {
                        try todoItems.addNewTodoItem(_text: input)
                    }
                } catch {
                    
                }
                showAddNewTodo.toggle()
            })
            .padding(.bottom)
            Button("Cancel", action: { showAddNewTodo.toggle() })
        }
    }
}

struct AddNewTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTodoView(showAddNewTodo: .constant(true))
    }
}
