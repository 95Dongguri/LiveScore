//
//  LivePresenter.swift
//  LiveScore
//
//  Created by κΉλν on 2022/05/18.
//

import UIKit
import Toast

protocol LiveProtocol: AnyObject {
    func setupNavigationTitle()
    func setupViews()
    func reloadCollectionView()
    func makeToast()
    func pushLiveDetail(with result: Result)
}

class LivePresenter: NSObject {
    
    private weak var vc: LiveProtocol?
    private let liveScoreSearchManager: LiveScoreSearchManagerProtocol

    private var dateFrom = ""
    
    private var resultList: [Result] = []
    
    init(vc: LiveProtocol, liveScoreSearchManager: LiveScoreSearchManagerProtocol = LiveScoreSearchManager()) {
        self.vc = vc
        self.liveScoreSearchManager = liveScoreSearchManager
    }
    
    func viewDidLoad() {
        vc?.setupNavigationTitle()
        vc?.setupViews()
    }
}

extension LivePresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LiveListCollectionViewCell.identifier, for: indexPath) as? LiveListCollectionViewCell else { return UICollectionViewCell() }
        
        let result = resultList[indexPath.row]
        cell.setup(result: result)
        
        return cell
    }
}

extension LivePresenter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let result = resultList[indexPath.row]
        
        vc?.pushLiveDetail(with: result)
    }
}

extension LivePresenter: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        resultList = []
        vc?.reloadCollectionView()
        
        guard let searchDate = searchBar.text?
            .replacingOccurrences(of: "/", with: "-")
            .replacingOccurrences(of: ".", with: "-") else { return }
        
        liveScoreSearchManager.request(from: searchDate) { [weak self] newValue in
            if newValue.isEmpty {
                self?.vc?.makeToast()
            }
            
            self?.resultList = newValue
            self?.vc?.reloadCollectionView()
        }
    }
}
