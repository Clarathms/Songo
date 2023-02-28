//
//  AglomerateView.swift
//  Songo
//
//  Created by Amanda Melo on 25/01/23.
//

import Foundation
import MapKit

class ClusterPlacementView: MKAnnotationView {
    
    private let boxInset = CGFloat(10)
    private let interItemSpacing = CGFloat(5)
    private let maxContentWidth = CGFloat(45)
    private let contentInsets = UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)
    
    private let blurEffect = UIBlurEffect(style: .systemThickMaterial)
    
    private lazy var backgroundMaterial: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: .none)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .fundo
        return view
    }()
    
    private lazy var stackViewL: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: Array(imageViewList[0...1]))
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.spacing = interItemSpacing
        
        return stackView
    }()
    
    private lazy var stackViewR: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: Array(imageViewList[2...3]))
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.spacing = interItemSpacing
        
        return stackView
    }()
    
    static var reuseIdentifier = "ClusterPlacementView"
    
    private lazy var imageView1: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var imageView2: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var imageView3: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var imageView4: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var imageViewList = [imageView1, imageView2, imageView3, imageView4]
    
    private var imageHeightConstraint1: NSLayoutConstraint?
    private var imageHeightConstraint2: NSLayoutConstraint?
    private var imageHeightConstraint3: NSLayoutConstraint?
    private var imageHeightConstraint4: NSLayoutConstraint?
    
    var musicPictures: [UIImage]?
    var musicTitles: [String]?
//        var musicAlbuns: [String] = []
    var musicArtists: [String]?
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        collisionMode = .circle
        centerOffset = CGPoint(x: 0, y: -20) // Offset center point to animate better with marker annotations
        
        backgroundColor = UIColor.clear
        addSubview(backgroundMaterial)
        
        backgroundMaterial.contentView.addSubview(stackViewL)
        backgroundMaterial.contentView.addSubview(stackViewR)
        
        // Make the background material the size of the annotation view container
        backgroundMaterial.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backgroundMaterial.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        backgroundMaterial.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundMaterial.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        // Anchor the top and leading edge of the stack view to let it grow to the content size.
        
        NSLayoutConstraint.activate([
            stackViewL.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: contentInsets.left),
        //    stackViewL.trailingAnchor.constraint(equalTo: stackViewR.leadingAnchor, constant: 0).isActive = true
            stackViewL.topAnchor.constraint(equalTo: self.topAnchor, constant: contentInsets.top),
            
            stackViewR.leadingAnchor.constraint(equalTo: stackViewL.trailingAnchor, constant: interItemSpacing),
            stackViewR.topAnchor.constraint(equalTo: stackViewL.topAnchor, constant: 0),
            stackViewR.bottomAnchor.constraint(equalTo: stackViewL.bottomAnchor)
        ])
        
        
        
        // Anchor the top and leading edge of the stack view to let it grow to the content size.
     //   stackViewR.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -contentInsets.left).isActive = true

        
        // Limit how much the content is allowed to grow.
        imageViewList[0].widthAnchor.constraint(equalToConstant: maxContentWidth).isActive = true
        imageViewList[1].widthAnchor.constraint(equalToConstant: maxContentWidth).isActive = true
        imageViewList[2].widthAnchor.constraint(equalToConstant: maxContentWidth).isActive = true
        imageViewList[3].widthAnchor.constraint(equalToConstant: maxContentWidth).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageViewList[0].image = nil
        imageViewList[1].image = nil
        imageViewList[2].image = nil
        imageViewList[3].image = nil
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        guard let cluster = annotation as? MKClusterAnnotation else { return }
        var musicPicturesC: [UIImage] = []
        var musicTitlesC: [String] = []
//        var musicAlbuns: [String] = []
        var musicArtistsC: [String] = []
        
        for member in cluster.memberAnnotations {
            guard let music = member as? MusicPlacementModel else { return }
            musicPicturesC.append(music.musicPicture ?? UIImage())
            musicArtistsC.append(music.artist ?? " ---- ")
            musicTitlesC.append(music.title ?? " ----- ")
//            musicAlbuns.append(music.)
        }
        musicTitles = musicTitlesC
        musicArtists = musicArtistsC
        musicPictures = musicPicturesC
        
        if let heightConstraint = imageHeightConstraint1 {
            imageViewList[0].removeConstraint(heightConstraint)
            imageViewList[1].removeConstraint(heightConstraint)
            imageViewList[2].removeConstraint(heightConstraint)
            imageViewList[3].removeConstraint(heightConstraint)
        }

        var ratio: CGFloat = 1
        var count = 0
        for musicPicture in musicPicturesC {
            if musicPicture.size != CGSize.zero {
                if count < imageViewList.count {
                    imageViewList[count].image = musicPicture
                    ratio = musicPicture.size.height / musicPicture.size.width
                }
            } else {
                imageViewList[count].image = .add
            }
            count += 1
        }
        
        imageHeightConstraint1 = imageViewList[0].heightAnchor.constraint(equalTo: imageViewList[0].widthAnchor, multiplier: ratio, constant: 0)
        imageHeightConstraint1?.isActive = true

        imageHeightConstraint2 = imageViewList[1].heightAnchor.constraint(equalTo: imageViewList[1].widthAnchor, multiplier: ratio, constant: 0)
        imageHeightConstraint2?.isActive = true

        imageHeightConstraint3 = imageViewList[2].heightAnchor.constraint(equalTo: imageViewList[2].widthAnchor, multiplier: ratio, constant: 0)
        imageHeightConstraint3?.isActive = true

        imageHeightConstraint4 = imageViewList[3].heightAnchor.constraint(equalTo: imageViewList[3].widthAnchor, multiplier: ratio, constant: 0)
        imageHeightConstraint4?.isActive = true
        
        
        updateConstraints()
        
        /*
         The image view has a width constraint to keep the image to a reasonable size. A height constraint to keep the aspect ratio
         proportions of the image is required to keep the image packed into the stack view. Without this constraint, the image's height
         will remain the intrinsic size of the image, resulting in extra height in the stack view that is not desired.
         */
        displayPriority = .defaultHigh
        zPriority = .min
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // The stack view will not have a size until a `layoutSubviews()` pass is completed. As this view's overall size is the size
        // of the stack view plus a border area, the layout system needs to know that this layout pass has invalidated this view's
        // `intrinsicContentSize`.
        invalidateIntrinsicContentSize()
        
        // Use the intrinsic content size to inform the size of the annotation view with all of the subviews.
        let contentSize = intrinsicContentSize
        frame.size = intrinsicContentSize
        
        // The annotation view's center is at the annotation's coordinate. For this annotation view, offset the center so that the
        // drawn arrow point is the annotation's coordinate.
        centerOffset = CGPoint(x: contentSize.width / 2, y: contentSize.height / 2)
        
        let shape = CAShapeLayer()
        let path = CGMutablePath()

        // Draw the pointed shape.
        let pointShape = UIBezierPath()
        pointShape.move(to: CGPoint(x: boxInset, y: 0))
        pointShape.addLine(to: CGPoint.zero)
        pointShape.addLine(to: CGPoint(x: boxInset, y: boxInset))
        path.addPath(pointShape.cgPath)

        // Draw the rounded box.
        let box = CGRect(x: boxInset, y: 0, width: self.frame.size.width - boxInset, height: self.frame.size.height)
        let roundedRect = UIBezierPath(roundedRect: box,
                                       byRoundingCorners: [.topRight, .bottomLeft, .bottomRight],
                                       cornerRadii: CGSize(width: 5, height: 5))
        path.addPath(roundedRect.cgPath)

        shape.path = path
        backgroundMaterial.layer.mask = shape
    }
    
    override var intrinsicContentSize: CGSize {
        var size = stackViewL.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = maxContentWidth*2 + contentInsets.left + interItemSpacing + contentInsets.right - 10//size.width*2 + contentInsets.left + contentInsets.right
        size.height = maxContentWidth*2 + contentInsets.top + interItemSpacing + contentInsets.bottom - 10//+= contentInsets.top + contentInsets.bottom
        return size
    }
    
    private func drawRatio(to whole: Int, wholeColor: UIColor?) -> UIImage {
        
        // Cluster image dimensions
        let squareSize: CGFloat = 50
        let borderSize: CGFloat = 5
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: squareSize, height: squareSize))
        return renderer.image { _ in
            // Fill full circle with wholeColor
            wholeColor?.setFill()
            UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: squareSize, height: squareSize)).fill()
            
            // Fill inner circle with white color
            let fillInnerCircleColor = UIColor.fundo
            fillInnerCircleColor.setFill()
            UIBezierPath(ovalIn: CGRect(x: borderSize / 2, y: borderSize / 2, width: squareSize - borderSize, height: squareSize - borderSize)).fill()

            // Finally draw count text vertically and horizontally centered
            let attributes = [ NSAttributedString.Key.foregroundColor: UIColor.black,
                               NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)]
            
            let text = (whole > 99 ? "99+" : "\(whole)")
            let size = text.size(withAttributes: attributes)
            let rect = CGRect(x: (squareSize / 2) - (size.width / 2), y: (squareSize / 2) - (size.height / 2), width: size.width, height: size.height)
            text.draw(in: rect, withAttributes: attributes)
        }
    }
    private func count() -> Int {
        guard let cluster = annotation as? MKClusterAnnotation else {
            return 0
        }
        return cluster.memberAnnotations.count
    }
}
