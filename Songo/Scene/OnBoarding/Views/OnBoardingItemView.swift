//
//  onBoardingView.swift
//  onBoardingApp
//
//  Created by Jefferson Silva on 15/06/21.
//

import UIKit

class OnBoardingItemView: UIView {
    var currentImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)

        return imageView
    }()

    var currentTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .scaleAspectFit
        label.sizeToFit()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = .titleThree
        label.textColor = .label1Dark

        return label
    }()

    var currentMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.textAlignment = .center
        label.font = .body
        label.textColor = .label1Dark
        label.minimumScaleFactor = 0.7
        label.adjustsFontSizeToFitWidth = true

        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()

    init(for item: OnBoardingItem) {
        super.init(frame: .zero)
        self.backgroundColor = .white

        self.currentImage.image = UIImage(named: item.imageName) ?? UIImage(named: "default")

        self.currentTitle.text = item.title
        self.currentMessage.text = item.message

        setupView()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        stackView.addArrangedSubview(currentImage)
        stackView.addArrangedSubview(currentTitle)
        stackView.addArrangedSubview(currentMessage)
        
        stackView.setCustomSpacing(20, after: currentImage)
        stackView.setCustomSpacing(10, after: currentTitle)
        
        self.addSubview(stackView)
    }
    
    func setupViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
