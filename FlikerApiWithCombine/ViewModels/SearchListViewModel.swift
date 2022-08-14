//
//  SearchListViewViewModel.swift
//  FlikerApiWithCombine
//
//  Created by Ahmed Elsman on 06/08/2022.
//

import Foundation
import Combine

class SearchListViewModel: ObservableObject {
    
    private var flickerSearchDataService: FlickerSearchDataService
    private var cancellables = Set<AnyCancellable>()
    private let searchListKey: String = "previous_search"
    
    @Published var page: Int = 1
    @Published var hasMoreRows: Bool = true
    @Published var searchText: String = ""
    @Published var flickerItems: [FlickerItem] = []
    @Published var previousSearchList: [SearchItem]  = [] {
        didSet {
            UserDefaultsUtility.saveItems(previousSearchList: previousSearchList)
        }
    }
    
    init() {
        flickerSearchDataService = FlickerSearchDataService()
        UserDefaultsUtility.getPreviousSearchItems(previousSearchList: &previousSearchList)
        addSubscribers()
    }
    
    private func addSubscribers() {
        
        // search and update flicker items list
        $searchText
            .filter({ keyword in
                return !keyword.isEmpty && keyword.count > 2
            })
            .combineLatest($page, flickerSearchDataService.$flikerItems, $previousSearchList)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(mapSearchAndReturnedFlickerItems)
            .sink { [weak self] (returnedData) in
                guard let self = self else { return }
                self.flickerItems = returnedData.flickerItems
                if let previousSearchItems = returnedData.previousSearchItems {
                    self.previousSearchList = previousSearchItems
                }
            }
            .store(in: &cancellables)
    }
    
    private func mapSearchAndReturnedFlickerItems(keyword: String, page: Int, returnedItems: [FlickerItem], previousSearchItems: [SearchItem]) -> (flickerItems: [FlickerItem], previousSearchItems: [SearchItem]?) {

        UserDefaultsUtility.addItem(title: keyword, previousSearchList: &previousSearchList)
        
        let lowercasedText = keyword.lowercased()
        flickerSearchDataService.getItems(searchKeyword: lowercasedText, perPage: 10, page: page)
        return (returnedItems, nil)
    }
    
    func deleteItem(indexSet: IndexSet) {
        UserDefaultsUtility.deleteItem(indexSet: indexSet, previousSearchList: &previousSearchList)
    }
    
    func moveItem(fromIndex: IndexSet, toIndex: Int) {
        UserDefaultsUtility.moveItem(fromIndex: fromIndex, toIndex: toIndex, previousSearchList: &previousSearchList)
    }
}
