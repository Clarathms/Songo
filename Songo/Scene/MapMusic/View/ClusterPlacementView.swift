//
//  AglomerateView.swift
//  Songo
//
//  Created by Amanda Melo on 25/01/23.
//

import Foundation
import MapKit

class ClusterPlacementView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        collisionMode = .circle
        centerOffset = CGPoint(x: 0, y: -20) // Offset center point to animate better with marker annotations
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    static var reuseIdentifier = "ClusterPlacementView"
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        if let cluster = annotation as? MusicPlaylistModel {
            let totalSongs = cluster.memberAnnotations.count
            image = drawRatio(to: totalSongs, wholeColor: .fundoSecundario)
            displayPriority = .defaultHigh
        }
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
