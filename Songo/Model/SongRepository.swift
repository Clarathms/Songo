//
//  SongRepository.swift
//  Songo
//
//  Created by Amanda Melo on 26/01/23.
//

import Foundation
import MapKit

protocol SongRepository {
    
    //MARK: - CRUD Methods
    
    /// Saves an annotation
    /// - Parameters:
    ///   - item: The `SongnModel` item to be saved
    ///   - completionHandler: Asynchronously returns the saved `AnnotationModel` with its ID or an `Error`
    func create(_ item: SongModel, then completionHandler: @escaping (SongModel?, Error?) -> Void)
    
    /// Gets a specific annotation
    /// - Parameters:
    ///   - id: The ID of the `AnnotationModel` to be fetched
    ///   - completionHandler: Asynchronously returns the requested `AnnotationModel` or an `Error`
    func read(id: String, then completionHandler: @escaping (SongModel?, Error?) -> Void)
    
    /// Updates an already saved annotation
    /// - Parameters:
    ///   - item: The `AnnotationModel` item to be updated
    ///   - completionHandler: Asynchronously returns the updated `AnnotationModel` or an `Error`
    func update(_ item: SongModel, then completionHandler: @escaping (SongModel?, Error?) -> Void)
    
    /// Deletes an annotation
    /// - Parameters:
    ///   - item: The `AnnotationModel` item to be deleted
    ///   - completionHandler: Asynchronously returns `nil` (if succeeded) or an `Error`
    func delete(_ item: SongModel, then completionHandler: @escaping (Error?) -> Void)
    
    //MARK: - Specific Methods
    
    /// Lists every annotation in a radius
    /// - Parameters:
    ///   - userLocation: The center of the radius to fetch the annotations
    ///   - radius: The radius of the search area
    ///   - completionHandler: Asynchronously returns an array of `AnnotationModel` or an `Error`.
    ///   **This method normaly has four callbacks, but may have up to nine.**
    func list(userLocation: CLLocationCoordinate2D, radius: Double, then completionHandler: @escaping ([SongModel]?, Error?) -> Void)
    
    /// Lists every annotation with id in the list
    /// - Parameters:
    ///   - ids: Array of ids to be fetched
    ///   - limit: A quantity limit for fetching
    ///   - startAt: A index where the fetch should start from
    ///   - completionHandler: Asynchronously returns an array of `AnnotationModel` or an `Error`.
    func list(by ids: [String], limit: Int, startAt: Int?, then completionHandler: @escaping (SongModel?, Error?) -> Void)
}
