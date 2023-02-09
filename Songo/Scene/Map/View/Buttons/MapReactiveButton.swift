//
//  MapReactiveButton.swift
//  Songo
//
//  Created by Amanda Melo on 24/01/23.
//

import Foundation
import MusicKit
import UIKit

class MapReactiveButton: SongButtonView {
    
    //    @State var plusIcon = UIImage(systemName: "plus")
    let warningImage = UIImage(systemName: "plus")
    let myImageView:UIImageView = UIImageView()
//    var titleController = AppleMusicController().currentTitle


//    var tituloMusica: String {
//        appleMusicController.getCurrentMusic()
//    }
    
    var image : UIImage? {
        let warningImage = UIImage(systemName: "plus")
        let myImageView:UIImageView = UIImageView()
        
        myImageView.contentMode = UIView.ContentMode.scaleAspectFit
        myImageView.frame.size.width = .zero
        myImageView.frame.size.height = .zero
        myImageView.tintColor = .white
        //  myImageView.center = self.view.center
        myImageView.image = warningImage
        
        
        return warningImage
        
    }
    
    
    override init() {
        super.init()
//        setTitle(NSLocalizedString(titleController ?? "Sem musica", comment: "MapReactiveButton: title for MapReactiveButton"), for: .addCurrentSong)
        setImage(image, for: .addCurrentSong)
        
        //   setupImage()
        //
        //        setTitle(NSLocalizedString("Localização atual", comment: "MapReactiveButton: title for MapReactiveButton"), for: .userNotFocus)
        //        setImage(UIImage(systemName: "square.and.arrow.up"), for: .userNotFocus)
        tintColor = .white

   
        
//        image.wi.constraint(equalToConstant: UIScreen.main.bounds.width * 10 ).isActive = true
//        image.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 10).isActive = true
//             

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //?
    
    
    /// Replaces the original function to change the button status.
    /// - Parameter state: the button status can be:
    override func setButtonState(state: UIControl.State) {
        super.setButtonState(state: state)
        isEnabled = (state == .locationOccupied) ? false : true
    }
    
    func addConstraint() {
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
       
            myImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 10 ),
            myImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 10)
            
        ])
    }
}
