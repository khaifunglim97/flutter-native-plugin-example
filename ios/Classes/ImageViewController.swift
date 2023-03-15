import UIKit


protocol ImageViewDelegate {
    func onDone(result: Bool, sender: String)
    func onBack(result: Bool, sender: String)
}

class ImageViewController: UIViewController {

    var imgViewDelegate : ImageViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        let backBtn = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(self.btnBackPressed))
        self.navigationItem.leftBarButtonItem = backBtn
        
        let thisLabel = UILabel(frame: CGRect(x: view.bounds.midX - 50, y: view.bounds.midY - 200, width: 100, height: 50))
        thisLabel.text = "Written in Swift"
        thisLabel.textColor = .black
        thisLabel.backgroundColor = .clear
        thisLabel.font = UIFont(name: "Trebuchet MS", size: 12.0)
        thisLabel.textAlignment = .center
        view.addSubview(thisLabel)
        
        let thisImageView = UIImageView(frame: CGRect(x: view.bounds.midX - 50, y: view.bounds.midY - 100, width: 100, height: 100))
        let bundle = Bundle(for: type(of: self))
        let filePath = bundle.path(forResource: "Images/apple", ofType: "png")
        thisImageView.image = UIImage(contentsOfFile: filePath ?? "")
        view.addSubview(thisImageView)
        
        let btnDone:UIButton = UIButton(frame: CGRect(x: view.bounds.midX - 50, y: view.bounds.midY + 150, width: 100, height: 50))
        btnDone.backgroundColor = .black
        btnDone.setTitle("Done", for: .normal)
        btnDone.addTarget(self, action:#selector(self.btnDonePressed), for: .touchUpInside)
        view.addSubview(btnDone)

    }
    
    @objc func btnBackPressed(sender: UIButton!) {
      imgViewDelegate?.onBack(result: false, sender: "Back")
    }

    @objc func btnDonePressed(sender: UIButton!) {
      imgViewDelegate?.onDone(result: true, sender: "Done")
    }
}
