import UIKit

class ViewController: UIViewController, UITextFieldDelegate{
    
    private var myButton: UIButton!
    private var myTextField: UITextField!
    private var myDate: UITextField!
    private var myToolbar: UIToolbar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //座標情報
        let tWidth: CGFloat = 200
        let tHeight: CGFloat = 30
        let poosX: CGFloat = (self.view.bounds.width - tWidth)/2
        let poosY: CGFloat = (self.view.bounds.height - tHeight)/2-150
        
        // UITextFieldを作成する.
        myTextField = UITextField(frame: CGRect(x: poosX, y: poosY, width: tWidth, height: tHeight))
        myDate = UITextField(frame: CGRect(x: poosX, y: poosY-50, width: tWidth, height: tHeight))
        
        //時間獲得
        myDate.text = getNowClockString()
        
        //キーボードを数値のみに制限
        myTextField.keyboardType = UIKeyboardType.numberPad
        
        // 枠を表示する.
        myTextField.borderStyle = .roundedRect
        myDate.borderStyle = .roundedRect
        
        
        myDate.delegate = self
        
        //DatePicker上のToolBarボタン
        myToolbar = UIToolbar()
        myToolbar.sizeToFit()
        let ToolBarButton = UIBarButtonItem(title: "完了", style: .plain, target: self, action: #selector(ViewController.done))
        myToolbar.items = [ToolBarButton]
        myDate.inputAccessoryView = myToolbar
        myTextField.inputAccessoryView = myToolbar
        
        // Viewに追加する
        self.view.addSubview(myTextField)
        self.view.addSubview(myDate)
        
        
    }
    
    //DatePickerが選ばれた際に呼ばれる.
    internal func onDidChangeDate(sender: UIDatePicker){
        
        // フォーマットを生成.
        let myDateFormatter: DateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyy年MM月dd日"
        
        // 日付をフォーマットに則って取得.
        let mySelectedDate: NSString = myDateFormatter.string(from: sender.date) as NSString
        myDate.text = mySelectedDate as String
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //テキストフィールド選択時、DatePicker表示
    func textFieldShouldBeginEditing(_ myDate: UITextField) -> Bool {
        // DatePickerを生成する.
        let myDatePicker: UIDatePicker = UIDatePicker()
        myDate.inputView = myDatePicker
        
        // datePickerを設定（デフォルトでは位置は画面上部）する.
        myDatePicker.frame = CGRect(x:0, y:420, width:self.view.frame.width, height:250)
        myDatePicker.timeZone = NSTimeZone.local
        myDatePicker.backgroundColor = UIColor.white
        myDatePicker.layer.cornerRadius = 5.0
        myDatePicker.layer.shadowOpacity = 0.5
        myDatePicker.datePickerMode = UIDatePickerMode.date
        
        // 値が変わった際のイベントを登録する.
        myDatePicker.addTarget(self, action: #selector(ViewController.onDidChangeDate(sender:)), for: .valueChanged)
        return true
    }
    
    /*時間獲得*/
    func getNowClockString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        let now = Date()
        return formatter.string(from: now)
    }
    
    internal func onClickBarButton(sender: UIBarButtonItem) {
        
        switch sender.tag {
        case 1:
            myDate.resignFirstResponder()
        default:
            print("ERROR!!")
        }
    }
    
    func done(){
        myDate.resignFirstResponder()
        myTextField.resignFirstResponder()
    }
    
    
}
