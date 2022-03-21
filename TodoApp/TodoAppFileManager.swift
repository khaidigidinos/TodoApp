//
//  TodoAppFileManager.swift
//  TodoApp
//
//  Created by Khai Nguyen Minh on 3/21/22.
//

import Foundation

struct TodoItem : Identifiable, Equatable {
    let text: String
    let id = UUID()
    var checked: Bool
}

class TodoItemsStore : ObservableObject {
    
    @Published var todoItems: [TodoItem] = []
    
    enum FileError: Error {
        case loadFailure
        case saveFailure
        case urlFailure
    }
    
    init() {
        do {
            try load()
        } catch {
            
        }
    }
    
    func getURL() -> URL? {
        guard let documentsURL = FileManager
            .default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                return nil
            }
        return documentsURL.appendingPathComponent("todoitems.plist")
    }
    
    func save() throws {
        guard let dataURL = getURL() else {
            throw FileError.urlFailure
        }
        
        let list = todoItems.map{
            [$0.text, $0.checked]
        }
        
        do {
            let data = try PropertyListSerialization.data(fromPropertyList: list, format: .binary, options: .zero)
            
            try data.write(to: dataURL, options: .atomic)
        } catch {
            throw FileError.saveFailure
        }
    }
    
    func load() throws {
        guard let dataURL = getURL() else {
            throw FileError.urlFailure
        }
        
        do {
            let data = try Data(contentsOf: dataURL)
            
            let list = try PropertyListSerialization.propertyList(from: data, options: [],format: nil)
            
            let convertedList = list as? [[Any]] ?? []
            todoItems = convertedList.map {
                TodoItem(
                    text: $0[0] as? String ?? "",
                    checked: $0[1] as? Bool ?? false
                )
            }
        } catch {
            throw FileError.loadFailure
        }
    }
    
    func addNewTodoItem(_text: String) throws {
        todoItems.insert(TodoItem(text: _text, checked: false), at: todoItems.count)
        do {
            try save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
