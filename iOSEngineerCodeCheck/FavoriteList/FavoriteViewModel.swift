//
//  FavoriteViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by Toshiyana on 2022/07/29.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol FavoriteViewModelInputs {
    var itemSelected: PublishRelay<IndexPath> { get }
}

protocol FavoriteViewModelOutputs {
    var repoItems: BehaviorRelay<[RepoItemObject]> { get }
    var transitionToRepoItemDetail: PublishRelay<RepoItemObject> { get }
    var deselectRow: PublishRelay<IndexPath> { get }
    var updateFavorite: PublishRelay<Void> { get }
}

protocol FavoriteViewModelType {
    var inputs: FavoriteViewModelInputs { get }
    var outputs: FavoriteViewModelOutputs { get }
}

final class FavoriteViewModel: FavoriteViewModelInputs, FavoriteViewModelOutputs {
    // MARK: - FavoriteViewModelInputs
    var itemSelected = PublishRelay<IndexPath>()
    // MARK: - FavoriteViewModelOutputs
    var repoItems = BehaviorRelay<[RepoItemObject]>(value: [])
    var transitionToRepoItemDetail = PublishRelay<RepoItemObject>()
    var deselectRow = PublishRelay<IndexPath>()
    var updateFavorite = PublishRelay<Void>()

    private let disposeBag = DisposeBag()

    init() {
        deselectRow = itemSelected

        itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let strongSelf = self else { return }
                let repoItem = strongSelf.repoItems.value[indexPath.row]
                strongSelf.transitionToRepoItemDetail.accept(repoItem)
            })
            .disposed(by: disposeBag)

        updateFavorite
            .subscribe(onNext: { [weak self] _ in
                guard let strongSelf = self,
                      let objects = RealmManager.getEntityList(type: RepoItemObject.self)
                else { return }
                var objArray: [RepoItemObject] = []
                for obj in objects {
                    objArray.append(obj)
                }
                strongSelf.repoItems.accept(objArray)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - FavoriteViewModelType
extension FavoriteViewModel: FavoriteViewModelType {
    var inputs: FavoriteViewModelInputs { return self }
    var outputs: FavoriteViewModelOutputs { return self }
}
