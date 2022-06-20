//
//  ViewController.swift
//  storyly_demo_task
//
//  Created by Emre Kılınç on 20.06.2022.
//

import UIKit
import Storyly

class ViewController: UIViewController {
    let screenSize: CGRect = UIScreen.main.bounds
    let STORYLY_INSTANCE_TOKEN = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NfaWQiOjc2MCwiYXBwX2lkIjo0MDUsImluc19pZCI6NDA0fQ.1AkqOy_lsiownTBNhVOUKc91uc9fDcAxfQZtpm3nj40"
    var initialLoad: Bool = true
    lazy var containerView =  StorylyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//      APP UI
        view.bounds = view.frame.insetBy(dx: 10.0, dy: -30.0);
        view.backgroundColor = UIColor.lightGray
//      Add stroyly here
        self.view.addSubview(containerView)
        containerView.backgroundColor = UIColor.white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.widthAnchor.constraint(equalToConstant: screenSize.width).isActive = true
//        containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant:20).isActive = true
        self.containerView.delegate = self //Set up delegate
        self.containerView.storylyInit = StorylyInit(storylyId: STORYLY_INSTANCE_TOKEN)
        
    }
}

extension ViewController: StorylyDelegate {
    func storylyLoaded(_ storylyView: Storyly.StorylyView,
                       storyGroupList: [Storyly.StoryGroup],
                       dataSource: StorylyDataSource) {
        if initialLoad {
            initialLoad = false
            storylyView.isHidden = false
        }
        initialLoad  = true
        
    }
    func storylyLoadFailed(_ storylyView: Storyly.StorylyView,
                           errorMessage: String) {
        print(errorMessage)
    }
   
    
    
    
}

