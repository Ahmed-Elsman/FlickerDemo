//
//  UserDefaultsUtility.swift
//  FlikerApiWithCombine
//
//  Created by Ahmed Elsman on 09/08/2022.
//

import Foundation

protocol SearchHistoryRepository {
    static func addItem(title: String, previousSearchList: inout [SearchItem])
    static func getPreviousSearchItems(previousSearchList: inout [SearchItem])
    static func moveItem(fromIndex: IndexSet, toIndex: Int, previousSearchList: inout [SearchItem])
    static func deleteItem(indexSet: IndexSet, previousSearchList: inout [SearchItem])
    static func saveItems(previousSearchList: [SearchItem])
}

class UserDefaultsUtility: SearchHistoryRepository {
    
    enum UserDefaultsKeys: String {
        case SearchListKey = "previous_search"
    }
    
    // MARK: UserDefaults Functions
    
    static private func isValidToAdd<T: Searchable>(_ keyword: String, previousSearchList: [T]) -> Bool {
        let item = T(id: UUID().uuidString, title: keyword)
        return !previousSearchList.contains(where: {$0 == item})
    }
    
    static func addItem<T: Searchable>(title: String, previousSearchList: inout [T]) {
        if UserDefaultsUtility.isValidToAdd(title, previousSearchList: previousSearchList) {
            let newItem = T(id: UUID().uuidString, title: title)
            previousSearchList.append(newItem)
        }
    }
    
    static func getPreviousSearchItems<T: Searchable>(previousSearchList: inout [T]) {
        guard
            let data = UserDefaults.standard.data(forKey: UserDefaultsKeys.SearchListKey.rawValue),
            let items = try? JSONDecoder().decode([T].self, from: data)
        else {return}
        previousSearchList = items
    }
    
    static func moveItem<T: Searchable>(fromIndex: IndexSet, toIndex: Int, previousSearchList: inout [T]) {
        previousSearchList.move(fromOffsets: fromIndex, toOffset: toIndex)
    }
    
    static func deleteItem<T: Searchable>(indexSet: IndexSet, previousSearchList: inout [T]) {
        previousSearchList.remove(atOffsets: indexSet)
    }
    
    static func saveItems<T: Searchable>(previousSearchList: [T]) {
        if let data = try? JSONEncoder().encode(previousSearchList) {
            UserDefaults.standard.set(data, forKey: UserDefaultsKeys.SearchListKey.rawValue)
        }
    }
}
