//
//  ViewController.swift
//  EmoteDiary
//
//  Created by 이찬호 on 5/17/24.
//

import UIKit

class MainViewController: UIViewController {
//    private var counts = Array(repeating: 0, count: 9)
    private var buttonNames = ["행복해",
                               "사랑해",
                               "좋아해",
                               "당황해",
                               "속상해",
                               "우울해",
                               "심심해",
                               "짜증나",
                               "열받아",
    ]
    private var counts = ["행복해" :0,
                          "사랑해": 0,
                          "좋아해": 0,
                          "당황해": 0,
                          "속상해": 0,
                          "우울해": 0,
                          "심심해": 0,
                          "짜증나": 0,
                          "열받아": 0,
    ]
    private var buttonList: [UIButton] = []
    private var labelList: [UILabel] = []
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    @IBOutlet var button5: UIButton!
    @IBOutlet var button6: UIButton!
    @IBOutlet var button7: UIButton!
    @IBOutlet var button8: UIButton!
    @IBOutlet var button9: UIButton!
    
    
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var label4: UILabel!
    @IBOutlet var label5: UILabel!
    @IBOutlet var label6: UILabel!
    @IBOutlet var label7: UILabel!
    @IBOutlet var label8: UILabel!
    @IBOutlet var label9: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        settingList()
        settingButtons()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let index = sender.tag
        let buttonName = buttonNames[index]
        counts[buttonName] = counts[buttonName, default: 0] + 1
        guard let count = counts[buttonName] else { return }
        labelList[index].text = "\(buttonName) \(count)"
        saveData()
    }
    
    @objc private func buttonLongTapped(_ sender: UILongPressGestureRecognizer) {
        guard let index = sender.view?.tag else { return }
        let buttonName = buttonNames[index]
        let alert = UIAlertController(title: nil, message: "\(buttonName)을 초기화 하겠습니까?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "초기화", style: .destructive) { [self] _ in
            counts[buttonName] = 0
            labelList[index].text = "\(buttonName) \(0)"
            saveData()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    private func settingList() {
        labelList = [label1, label2, label3, label4, label5, label6, label7, label8, label9]
        buttonList = [button1, button2, button3, button4, button5, button6, button7, button8, button9]
    }
    
    private func settingButtons() {
        for (index, button) in buttonList.enumerated() {
            settingButton(index, button)
        }
    }
    
    private func settingButton(_ i: Int, _ button: UIButton) {
        button.tag = i
        button.setImage(UIImage(named: "slime\(i+1)"), for: .normal)
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(buttonLongTapped))
        longGesture.view?.tag = i
        button.addGestureRecognizer(longGesture)
        let buttonName = buttonNames[i]
        guard let count = counts[buttonName] else { return }
        labelList[i].text = "\(buttonName) \(count)"
        labelList[i].textAlignment = .center
    }
    
    private func loadData() {
        guard let data = UserDefaults.standard.dictionary(forKey: "counts") as? [String: Int] else { return }
        counts = data
    }
    
    private func saveData() {
        UserDefaults.standard.set(counts, forKey: "counts")
    }
    
    

}

