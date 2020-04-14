//
//  CoreDataManager.swift
//  CoreData-NumberFacts
//
//  Created by Juan Ceballos on 4/9/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager   {
    static let shared = CoreDataManager()
    
    private init()  {}
    
    private var users = [User]() // User is a NSMangaeObject
    
    private var posts = [Post]() // same
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // viewContext is of type NSManagedObjectContext
    
    // CRUD
    
    public func createUser(name: String, dob: Date) -> User   {
        let user = User(entity: User.entity(), insertInto: context)
        user.name = name
        user.dob = dob
        
        // save changes to the NSManagedObjectContext
        // similar to saving to file manager
        do {
            try context.save()
        }
        catch {
            print("error saving user: \(error)")
        }
        return user
    }
    
    public func fetchUsers() -> [User] {
        do  {
            users = try context.fetch(User.fetchRequest()) // fetch request gets all
                                                            // objects from Core Data
            // We can use NSPredicate to filter sort during fetch
            // fetch request is of type NSFetchRequest
        }
        catch   {
            print("fetching error: \(error)")
        }
        return users
    }
    
    //=========================================
    
    public func createPost(for user: User, numberFact: Double, title: String) -> Post   {
        
        let post = Post(entity: Post.entity(), insertInto: context)
        
        post.number = numberFact
        post.title = title
        
        // create relationship between post and user
        post.user = user // this relationship was created by ctrl drag
        
        do  {
            try context.save()
        }
        catch   {
            print("error saving: \(error)")
        }
        return post
    }
    
    //========================================
    
    public func fetchPosts() -> [Post]   {
        do  {
            posts = try context.fetch(Post.fetchRequest()) // all the posts [Post]
        }
        catch   {
            print("\(error)")
        }
        return posts
    }
    
    // @discardableResult silences the warning if returned value is not used
    public func deletePost(post: Post)    {
        context.delete(post)
        
        // save context
        do  {
            try context.save()
        }
        catch   {
            print("\(error)")
        }
    }
    
}
