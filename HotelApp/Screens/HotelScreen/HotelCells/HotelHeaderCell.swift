//
//  HotelHeaderCell.swift
//  HotelTest
//
//  Created by admin on 30.08.2023.
//

import UIKit
import Kingfisher

final class HotelHeaderCell: BaseTableCell {
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var photosSlider: UICollectionView!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var locationName: UIButton!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var priceForlabel: UILabel!
    private var images: [String] = []
    private let cellIdentifier = "Cell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ratingLabel.textColor = AppColors.yellowTextColor.color
        ratingLabel.backgroundColor = AppColors.yellowColor.color?.withAlphaComponent(0.2)
        ratingLabel.layer.cornerRadius = 5
        
        pageControl.pageIndicatorTintColor = .darkGray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.backgroundColor = .white
        pageControl.layer.cornerRadius = 5
        photosSlider.dataSource = self
        photosSlider.delegate = self
        photosSlider.isPagingEnabled = true
        photosSlider.contentInsetAdjustmentBehavior = .never
        photosSlider.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        photosSlider.layer.cornerRadius = 10
        
        if let layout = photosSlider.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = photosSlider.bounds.size
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
    }
    
    func setup(hotelData: HotelDTO) {
        pageControl.numberOfPages = hotelData.imageUrl.count
        images = hotelData.imageUrl
        nameLabel.text = hotelData.name
        nameLabel.sizeToFit()
        locationName.setTitle(hotelData.address, for: .normal)
        let price = convertToPrice(number: hotelData.price, prefix: "от ")
        priceLabel.text = price
        priceForlabel.text = hotelData.priceFor.lowercased()
        priceForlabel.textColor = .gray

        let ratingText = "\(hotelData.rating) \(hotelData.ratingName)"
        updateRatingLabel(text: ratingText, label: ratingLabel)
    }
}

extension HotelHeaderCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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

extension HotelHeaderCell: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}
