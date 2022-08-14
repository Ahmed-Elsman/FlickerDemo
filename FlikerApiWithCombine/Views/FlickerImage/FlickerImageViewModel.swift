//
//  FlickerImageViewModel.swift
//  FlikerApiWithCombine
//
//  Created by Ahmed Elsman on 06/07/2022.
//

import Foundation
import SwiftUI
import Combine

class FlickerImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let flickerItem: FlickerItem
    private let dataService: FlickerImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(flickerItem: FlickerItem) {
        self.flickerItem = flickerItem
        self.dataService = FlickerImageService()
        self.addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers() {
        dataService.downloadFlickerImage(imagePath: flickerItem.imagePath)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedData) in
                guard let self = self else { return }
                self.image = UIImage(data: returnedData)
            }
            .store(in: &cancellables)
    }
}
