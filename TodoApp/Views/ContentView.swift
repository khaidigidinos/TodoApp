//
//  ContentView.swift
//  TodoApp
//
//  Created by Khai Nguyen Minh on 3/20/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var todoItems: TodoItemsStore
    @State private var showAddNewTodo = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Button(action: {
                showAddNewTodo.toggle()
            }) {
                Image(systemName: "plus")
            }
                .font(.title)
                .padding(.trailing)
                .sheet(isPresented: $showAddNewTodo) {
                    AddNewTodoView(showAddNewTodo: $showAddNewTodo).environmentObject(todoItems)
                }
            
            VStack {
                Text("Todo List")
                    .font(.title)
                    .padding()
                Form {
                    ForEach(todoItems.todoItems) { item in
                        HStack {
                            Image(systemName: "square" + (item.checked == true ? ".fill" : ""))
                                .onTapGesture {
                                    do {
                                        let index = todoItems.todoItems.firstIndex(of: item)
                                        todoItems.todoItems[index ?? -1].checked = !todoItems.todoItems[index ?? -1].checked
                                        try todoItems.save()
                                    } catch {}
                                }
                            Text(item.text)
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environmentObject(TodoItemsStore())
            ContentView()
                .environmentObject(TodoItemsStore())
                .previewInterfaceOrientation(.portraitUpsideDown)
        }
    }
}
