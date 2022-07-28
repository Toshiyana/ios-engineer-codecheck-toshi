//
//  DetailViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by Toshiyana on 2022/07/29.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol DetailViewModelInputs {
    var addFavorite: PublishRelay<RepoItem> { get }
    var removeFavorite: PublishRelay<String> { get }
    var getFavoriteCondition: PublishRelay<String> { get }
}

protocol DetailViewModelOutputs {
    var activeFavorite: PublishRelay<Bool> { get }
}

protocol DetailViewModelType {
    var inputs: DetailViewModelInputs { get }
    var outputs: DetailViewModelOutputs { get }
}

final class DetailViewModel: DetailViewModelInputs, DetailViewModelOutputs {
    // MARK: - DetailViewModelInputs
    var addFavorite = PublishRelay<RepoItem>()
    var removeFavorite = PublishRelay<String>()
    var getFavoriteCondition = PublishRelay<String>()

    // MARK: - DetailViewModelOutputs
    var activeFavorite = PublishRelay<Bool>()

    private let disposeBag = DisposeBag()

    init() {
        addFavorite
            .subscribe(onNext: { repoItem in
                let repoItemObject = RepoItemObject(repoItem: repoItem)
                RealmManager.addEntity(object: repoItemObject)
            })
            .disposed(by: disposeBag)

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

// MARK: - DetailViewModelType
extension DetailViewModel: DetailViewModelType {
    var inputs: DetailViewModelInputs { return self }
    var outputs: DetailViewModelOutputs { return self }
}
