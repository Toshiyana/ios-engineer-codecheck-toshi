//
//  SearchListViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by Toshiyana on 2022/07/25.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import RxSwift
import RxCocoa
import PKHUD

protocol SearchListViewModelInputs {
    var searchBarText: PublishRelay<String> { get }
    var searchButtonClicked: PublishRelay<Void> { get }
    var itemSelected: PublishRelay<IndexPath> { get }
}

protocol SearchListViewModelOutputs {
    var repoItems: BehaviorRelay<[RepoItem]> { get }
    var transitionToRepoItemDetail: PublishRelay<RepoItem> { get }
    var isLoadingHudAvailable: PublishRelay<Bool> { get }
    var errorResult: PublishRelay<Error> { get }
    var deselectRow: PublishRelay<IndexPath> { get }
}

protocol SearchListViewModelType {
    var inputs: SearchListViewModelInputs { get }
    var outputs: SearchListViewModelOutputs { get }
}

final class SearchListViewModel: SearchListViewModelInputs, SearchListViewModelOutputs {
    private let disposeBag = DisposeBag()

    // MARK: - SearchListViewModelInputs
    var searchBarText = PublishRelay<String>()
    var searchButtonClicked = PublishRelay<Void>()
    var itemSelected = PublishRelay<IndexPath>()

    // MARK: - SearchListViewModelOutputs
    var repoItems = BehaviorRelay<[RepoItem]>(value: [])
    var transitionToRepoItemDetail = PublishRelay<RepoItem>()
    var isLoadingHudAvailable = PublishRelay<Bool>()
    var errorResult = PublishRelay<Error>()
    var deselectRow = PublishRelay<IndexPath>()

    private let githubAPI: GitHubAPIProtocol

    init(githubAPI: GitHubAPIProtocol) {
        self.githubAPI = githubAPI

        deselectRow = itemSelected

        searchButtonClicked
            .withLatestFrom(searchBarText)
            .flatMapLatest { [weak self] text -> Observable<Event<GitHubResponse>> in
                guard let strongSelf = self else { return .empty() }
                strongSelf.isLoadingHudAvailable.accept(true)
                return try githubAPI.searchRepository(keyValue: ["q": text])
                    .materialize()
            }
            .subscribe(onNext: { [weak self] event in
                guard let strongSelf = self else { return }
                switch event {
                case .next(let response):
                    print("DEBUG: search response count:: \(response.items.count)")
                    print("DEBUG: search response items:: \(response.items)")
                    strongSelf.isLoadingHudAvailable.accept(false)
                    strongSelf.repoItems.accept(response.items)

                case .error(let error):
                    print("searchButtonClicked error: \(error)")
                    strongSelf.isLoadingHudAvailable.accept(false)
                    strongSelf.errorResult.accept(error)
                case .completed:
                    break
                }
            })
            .disposed(by: disposeBag)

        itemSelected
            .subscribe { [weak self] event in
                guard let strongSelf = self, let indexPath = event.element else { return }
                let repoItem = strongSelf.repoItems.value[indexPath.row]
                strongSelf.transitionToRepoItemDetail.accept(repoItem)
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - SearchListViewModelType
extension SearchListViewModel: SearchListViewModelType {
    var inputs: SearchListViewModelInputs { return self }
    var outputs: SearchListViewModelOutputs { return self }
}
