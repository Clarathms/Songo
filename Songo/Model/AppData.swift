//
//  AppData.swift
//  Songo
//
//  Created by Amanda Melo on 07/02/23.
//

import Foundation
import CodableExtensions

//class AppData: Codable {
//    init() {}
//    
//    private var addedMusic: [SongPlacementModel] = []
//    
//    func saveData() {
//        self.addedMusic = DAO.shared.addedMusic
//           
//           do {
//               try self.save()
//           } catch let err {
//               print(err.localizedDescription)
//           }
//       }
//    
//    static func loadData() -> AppData {
//        guard let loaded = (try? AppData.load()) else {return AppData()}
//        
//        DAO.shared.addedMusic = loaded.addedMusic
//        
//        return loaded
//    }
//}
