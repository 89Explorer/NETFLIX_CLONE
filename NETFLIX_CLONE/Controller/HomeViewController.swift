//
//  HomeViewController.swift
//  NETFLIX_CLONE
//
//  Created by 권정근 on 7/3/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: UI Components
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()

    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        
        homeFeedTableDelegate()
        homeFeedTableHeaderView()
        configureNavbar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 테이블 뷰 적용
        homeFeedTable.frame = view.bounds
    }
    
    // MARK: Functions
    private func homeFeedTableDelegate() {
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
    }
    
    private func homeFeedTableHeaderView() {
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
    }
    
    private func configureNavbar() {

        let originalImage = UIImage(named: "logo.png")
        let scaledSize = CGSize(width: 25, height: 25) // 시스템 버튼과 비슷한 크기

        UIGraphicsBeginImageContextWithOptions(scaledSize, false, 0.0)
        originalImage?.draw(in: CGRect(origin: .zero, size: scaledSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        // 원본 이미지 색상을 유지하기 위해 렌더링 모드를 .alwaysOriginal로 설정
        let originalColorImage = scaledImage?.withRenderingMode(.alwaysOriginal)

        let barButton = UIBarButtonItem(image: originalColorImage, style: .plain, target: self, action: #selector(leftBarButtonTapped))
        navigationItem.leftBarButtonItem = barButton
        
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .plain, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = .label
    }
    
    @objc private func leftBarButtonTapped() {
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    // 테이블의 섹션 전체 수 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40 
    }
}

