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

//    var appleMusicController1: AppleMusicController = AppleMusicController()

 //   let myImageView:UIImageView = UIImageView()
//    var titleController = AppleMusicController().currentTitle

  //  var curTitle : appl
    let containerView = UIView(frame: CGRect(x:0,y:0,width:320,height:500))
      let image1 = UIImageView()


    var image : UIImage? {
        let recebeImg = UIImage(systemName: "plus")
        let myImageView:UIImageView = UIImageView()
        
        myImageView.contentMode = UIView.ContentMode.scaleAspectFit
//        myImageView.frame.size.width = .zero
//        myImageView.frame.size.height =

        myImageView.tintColor = .white
        myImageView.sizeToFit()
        myImageView.image = recebeImg

        return recebeImg
        
    }

    let imageView2: UIImageView  =  {
       let iv = UIImageView()
       iv.contentMode = .scaleAspectFit
       iv.image = UIImage(named: "plus")
       return iv
   }()

    
    override init() {
        super.init()
       // var coverView: UIImage? = self.appleMusicController1.currentPicture

//        setTitle(NSLocalizedString(titleController ?? "Sem musica", comment: "MapReactiveButton: title for MapReactiveButton"), for: .addCurrentSong)
     //   setImage(coverView, for: .disabled)
        setImage(image, for: .addCurrentSong)
        tintColor = .white


        
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
    
//    func addConstraint() {
//        image.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//
//            image.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 10 ),
//            image.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 10)
//
//        ])
//    }
 
    
}
