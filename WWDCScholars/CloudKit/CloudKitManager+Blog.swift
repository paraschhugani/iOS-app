//
//  CloudKitManager+Blog.swift
//  WWDCScholars
//
//  Created by Matthijs Logemann on 03/06/2017.
//  Copyright © 2017 WWDCScholars. All rights reserved.
//

import Foundation
import CloudKit

typealias BlogPostLoaded = ((BlogPost) -> Void)

extension CloudKitManager {
    
    // MARK: - Functions
    
    func loadBlogPosts(cursor: CKQueryOperation.Cursor? = nil, recordFetched: @escaping BlogPostLoaded, completion: QueryCompletion) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "BlogPost", predicate: predicate)
        let operation = CKQueryOperation(query: query)
        operation.resultsLimit = CKQueryOperation.maximumResults
        operation.cursor = cursor
        operation.qualityOfService = .userInteractive
        
        operation.queryCompletionBlock = completion
        
        operation.recordFetchedBlock = { (record:CKRecord!) in
            let blogPost = BlogPost.init(record: record)
            recordFetched(blogPost)
        }
        
        self.database.add(operation)
    }
}
