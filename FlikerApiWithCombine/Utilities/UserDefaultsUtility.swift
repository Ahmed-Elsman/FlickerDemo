//
//  UserDefaultsUtility.swift
//  FlikerApiWithCombine
//
//  Created by Ahmed Elsman on 09/08/2022.
//

import Foundation

protocol SearchHistoryRepository {
    static func addItem<T: Searchable>(title: String) -> [T]
    static func getPreviousSearchItems<T: Searchable>() -> [T]
    static func moveItem<T: Searchable>(fromIndex: IndexSet, toIndex: Int) -> [T]
    static func deleteItem<T: Searchable>(indexSet: IndexSet) -> [T]
    static func saveItems<T: Searchable>(previousSearchList: [T])
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
    
    static func addItem<T: Searchable>(title: String) -> [T] {
        var previousSearchList = UserDefaultsUtility.getPreviousSearchItems() as [T]
        if UserDefaultsUtility.isValidToAdd(title, previousSearchList: previousSearchList) {
            let newItem = T(id: UUID().uuidString, title: title)
            previousSearchList.append(newItem)
        }
        return previousSearchList
    }
    
    static func getPreviousSearchItems<T: Searchable>() -> [T] {
        guard
            let data = UserDefaults.standard.data(forKey: UserDefaultsKeys.SearchListKey.rawValue),
            let items = try? JSONDecoder().decode([T].self, from: data)
        else {return []}
        return items
    }
    
    static func moveItem<T: Searchable>(fromIndex: IndexSet, toIndex: Int) -> [T] {
        var previousSearchList = UserDefaultsUtility.getPreviousSearchItems() as [T]
        previousSearchList.move(fromOffsets: fromIndex, toOffset: toIndex)
        return previousSearchList
    }
    
    static func deleteItem<T: Searchable>(indexSet: IndexSet) -> [T] {
        var previousSearchList = UserDefaultsUtility.getPreviousSearchItems() as [T]
        previousSearchList.remove(atOffsets: indexSet)
        return previousSearchList
    }
    
    static func saveItems<T: Searchable>(previousSearchList: [T]) {
        if let data = try? JSONEncoder().encode(previousSearchList) {
            UserDefaults.standard.set(data, forKey: UserDefaultsKeys.SearchListKey.rawValue)
        }
    }
}
