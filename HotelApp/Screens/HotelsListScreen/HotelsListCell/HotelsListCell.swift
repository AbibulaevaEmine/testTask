//
//  HotelsListCell.swift
//  HotelApp
//
//  Created by admin on 01.09.2023.
//

import UIKit

final class HotelsListCell: BaseTableCell {
    @IBOutlet private weak var roomName: UILabel!
    @IBOutlet private weak var photosCollection: UICollectionView!
    @IBOutlet private weak var includeStackView: UIStackView!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var pricePerLabel: UILabel!
    @IBOutlet private weak var pageControl: UIPageControl!
    private var bookingActionClosure: () -> () = {}
    private let cellIdentifier = "Cell"
    
    private var images: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pageControl.pageIndicatorTintColor = .darkGray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.backgroundColor = .white
        pageControl.layer.cornerRadius = 5
        photosCollection.dataSource = self
        photosCollection.delegate = self
        photosCollection.isPagingEnabled = true
        photosCollection.contentInsetAdjustmentBehavior = .never
        photosCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        photosCollection.layer.cornerRadius = 10
        
        if let layout = photosCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = photosCollection.bounds.size
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        
        includeStackView.axis = .vertical
        includeStackView.alignment = .leading
        includeStackView.distribution = .fillEqually
        includeStackView.spacing = 8
        includeStackView.removeAllSubviews()
    }
    
    func setup(model: HotelRoomsDTO, actionForBtn: @escaping () -> ()) {
        roomName.text = model.name
        roomName.sizeToFit()
        priceLabel.text = convertToPrice(number: model.price)
        pricePerLabel.text = model.pricePer
        pageControl.numberOfPages = model.imageUrl.count
        images = model.imageUrl
        priceLabel.sizeToFit()
        bookingActionClosure = actionForBtn
        setupLabels(count: model.peculiarities, includeStackView: includeStackView)
    }
    
    @IBAction private func bookingAction() {
        bookingActionClosure()
    }
}

extension HotelsListCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.frame = cell.contentView.bounds
        imageView.clipsToBounds = true
        
        if let url = URL(string: images[indexPath.item]) {
            imageView.kf.setImage(with: url)
        }
        
        cell.addSubview(imageView)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

extension HotelsListCell: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}

