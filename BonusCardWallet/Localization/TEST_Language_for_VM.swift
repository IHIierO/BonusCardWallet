//
//  TEST_Language_for_VM.swift
//  BonusCardWallet
//
//  Created by Artem Vorobev on 28.04.2023.
//

import UIKit
import Combine

class YourViewModelList: ObservableObject {
  
  // Let say we have list of view models to be published
  @Published var viewModels: [YourViewModel] = []
  
  // Let say we declared language variable with available language from LocalizationService.
  // And we will use it for initialization of our view models
  private var language = LocalizationService.shared.language
  private var notificationCancellables = Set<AnyCancellable>()
  
  // somewhere in this class we would like to add observer to listen to new language
  
  func addLanguageObserver() {
      NotificationCenter
        .default
        .publisher(for: LocalizationService.changedLanguage)
        .sink { [weak self] _ in
               guard let strongSelf = self else {
                 return
               }
               strongSelf.language = LocalizationService.shared.language
               
               /*
               * Here we will re-create our array of `YourViewModel` type
               * because I defined `YourViewModel` as structure.
               * And we will pass new language in every object of YourViewModel
               */
               let viewModels = [YourViewModel(language: strongSelf.language),
                                YourViewModel(language: strongSelf.language)]
               
               /*
               * Then will publish our list of view models
               */
                DispatchQueue.main.async {
                    strongSelf.viewModels = viewModels
                }
            }
            .store(in: &notificationCancellables)
  }
}

struct YourViewModel {
  let language: Language
  // some other stuff
}
