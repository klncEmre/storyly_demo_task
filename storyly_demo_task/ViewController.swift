//
//  ViewController.swift
//  storyly_demo_task
//
//  Created by Emre Kılınç on 20.06.2022.
//

import UIKit
import Storyly

class ViewController: UIViewController {
    private let emresview: StoryGroupViewFactory = SampleViewFactory()
    
    let screenSize: CGRect = UIScreen.main.bounds
    let STORYLY_INSTANCE_TOKEN = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NfaWQiOjc2MCwiYXBwX2lkIjo0MDUsImluc19pZCI6NDA0fQ.1AkqOy_lsiownTBNhVOUKc91uc9fDcAxfQZtpm3nj40"
    var initialLoad: Bool = true
    lazy var containerView =  StorylyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//      APP UI
        view.bounds = view.frame.insetBy(dx: 10.0, dy: -35.0);
        
//      Add stroyly here
        self.view.addSubview(containerView)
        containerView.backgroundColor = UIColor.white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.widthAnchor.constraint(equalToConstant: screenSize.width).isActive = true
//        containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant:20).isActive = true
        self.containerView.delegate = self //Set up delegat
        containerView.storyGroupTextColor = UIColor.systemBlue
        containerView.storyGroupIconBackgroundColor = UIColor.yellow
        self.containerView.storylyInit = StorylyInit(storylyId: STORYLY_INSTANCE_TOKEN)
        containerView.rootViewController = self
        containerView.storyGroupViewFactory = emresview
        
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
        print("-----" + String(storyGroupList.count))
        
    }
    func storylyLoadFailed(_ storylyView: Storyly.StorylyView,
                           errorMessage: String) {
        print(errorMessage)
    }
   
    
}


class SampleViewFactory: StoryGroupViewFactory {

    func createView() -> StoryGroupView {
        return SampleView(frame: .zero)
    }

    // Size of your custom view
    func getSize() -> CGSize {
        return CGSize(width: 10, height: 178)
    }
}
class SampleView: StoryGroupView {
    let kCONTENT_XIB_NAME = "SampleView"

    @IBOutlet var contentView: UIView!
    @IBOutlet var sampleText: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }
    
    override func populateView(storyGroup: StoryGroup?) {
        // Handle populating view with Storyly related data
        // ie, self.sampleText.text = storyGroup?.title
    }
}
