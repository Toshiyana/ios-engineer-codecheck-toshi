//
//  FavoriteDetailViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by Toshiyana on 2022/07/29.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol FavoriteDetailViewModelInputs {
    var removeFavorite: PublishRelay<String> { get }
    var getFavoriteCondition: PublishRelay<String> { get }
}

protocol FavoriteDetailViewModelOutputs {
    var activeFavorite: PublishRelay<Bool> { get }
}

protocol FavoriteDetailViewModelType {
    var inputs: FavoriteDetailViewModelInputs { get }
    var outputs: FavoriteDetailViewModelOutputs { get }
}

final class FavoriteDetailViewModel: FavoriteDetailViewModelInputs, FavoriteDetailViewModelOutputs {
    // MARK: - FavoriteDetailViewModelInputs
    var removeFavorite = PublishRelay<String>()
    var getFavoriteCondition = PublishRelay<String>()

    // MARK: - FavoriteDetailViewModelOutputs
    var activeFavorite = PublishRelay<Bool>()

    private let disposeBag = DisposeBag()

    init() {
        removeFavorite
            .subscribe(onNext: { id in
                RealmManager.deleteOneObject(type: RepoItemObject.self, id: id)
            })
            .disposed(by: disposeBag)

        getFavoriteCondition
            .subscribe(onNext: { [weak self] id in
                guard let strongSelf = self,
                      let repoItemObjects = RealmManager.getEntityList(type: RepoItemObject.self)
                else { return }

                for i in 0 ..< repoItemObjects.count {
                    if repoItemObjects[i].id == id {
                        strongSelf.activeFavorite.accept(true)
                        return
                    }
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - FavoriteDetailViewModelType
extension FavoriteDetailViewModel: FavoriteDetailViewModelType {
    var inputs: FavoriteDetailViewModelInputs { return self }
    var outputs: FavoriteDetailViewModelOutputs { return self }
}
