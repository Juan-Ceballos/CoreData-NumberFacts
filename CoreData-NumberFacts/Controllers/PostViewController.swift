//
//  ViewController.swift
//  CoreData-NumberFacts
//
//  Created by Juan Ceballos on 4/8/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var posts = [Post]()    {
        didSet  {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        fetchPost()
    }
    
    private func fetchPost()    {
        posts = CoreDataManager.shared.fetchPosts()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let createPostVC = segue.destination as? CreatePostViewController
            else    {
                fatalError()
        }
        
        // since we have the instance of create we are now able to set the delegate
        createPostVC.delegate = self
    }

}

extension PostViewController: UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        let post = posts[indexPath.row]
        cell.textLabel?.text = "\(post.title ?? "") \(post.number)"
        cell.detailTextLabel?.text = "Posted by: \(post.user?.name ?? "")"
        return cell
    }
}

extension PostViewController: CreatePostDelegate    {
    func didCreatePost(_ createPostViewController: CreatePostViewController, post: Post) {
        posts.append(post)
    }

}

