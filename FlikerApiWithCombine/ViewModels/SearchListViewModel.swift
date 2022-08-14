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
    @Published var searchText: String = ""
    @Published var flickerItems: [FlickerItem] = []
    @Published var previousSearchList: [SearchItem]  = [] {
        didSet {
            UserDefaultsUtility.shared.saveItems(previousSearchList: previousSearchList)
        }
    }
    
    init(flickerSearchDataService: FlickerSearchDataService) {
        self.flickerSearchDataService = flickerSearchDataService
        previousSearchList = UserDefaultsUtility.shared.getPreviousSearchItems()
        addSubscribers()
    }
    
    private func addSubscribers() {
        
        // search and update flicker items list
        $searchText
            .filter({ keyword in
                print(keyword)
                return !keyword.isEmpty && keyword.count > 2
            })
            .combineLatest($page, $flickerItems, $previousSearchList)
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
        
        previousSearchList = UserDefaultsUtility.shared.addItem(title: keyword)
        
        let lowercasedText = keyword.lowercased()
        flickerSearchDataService.getItems(searchKeyword: lowercasedText, perPage: 10, page: page)
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: {[weak self] flikerItems in
                guard let self = self else { return }
                self.flickerItems = flikerItems
            }
            .store(in: &cancellables)
        return (returnedItems, nil)
    }
    
    func deleteItem(indexSet: IndexSet) {
        previousSearchList = UserDefaultsUtility.shared.deleteItem(indexSet: indexSet)
    }
    
    func moveItem(fromIndex: IndexSet, toIndex: Int) {
        previousSearchList = UserDefaultsUtility.shared.moveItem(fromIndex: fromIndex, toIndex: toIndex)
    }
}
