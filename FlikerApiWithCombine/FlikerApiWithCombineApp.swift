//
//  FlikerApiWithCombineApp.swift
//  FlikerApiWithCombine
//
//  Created by Ahmed Elsman on 06/08/2022.
//

import SwiftUI

@main
struct FlikerApiWithCombineApp: App {
    var body: some Scene {
        
        let flickerSearchDataService = FlickerSearchDataService()
        
        let vm = SearchListViewModel(flickerSearchDataService: flickerSearchDataService)
        
        WindowGroup {
            SearchListView(vm: vm)
        }
    }
}
