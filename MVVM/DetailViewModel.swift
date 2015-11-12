
import Foundation

public class DetailViewModel {

    public let context: Context = Context.defaultContext
    public var title = "New Payback"
    public var name = ""
    public var amount = ""
    public weak var delegate: DetailViewModelDelegate?
    
    public var infoText: String {
        let names = nameComponents
        let amount = (self.amount as NSString).doubleValue
        return "\(name)\n\(amount)"
    }
    
    private var index: Int = -1
    
    var isNew: Bool {
        return index == -1
    }
    
    // new initializer
    public init(delegate: DetailViewModelDelegate) {
        self.delegate = delegate
    }
    
    // edit initializer
    public convenience init(delegate: DetailViewModelDelegate, index: Int) {
        self.init(delegate: delegate)
        self.index = index
        print(index)
        title = "Edit Payback"
        let payback = context.paybacks[index]
        name = payback.firstName + " " + payback.lastName
        amount = "\(payback.amount)"
    }
    
    public func handleDonePressed() {
        if !validateName() {
            delegate?.showInvalidName()
        }
        else if !validateAmount() {
            delegate?.showInvalidAmount()
        }
        else {
            if isNew {
                addPayback()
            }
            else {
                savePayback()
            }
            delegate?.dismissAddView()
        }
    }
    
    private var nameComponents : [String] {
        return name.componentsSeparatedByString(" ").filter { !$0.isEmpty }
    }
    
    
    func validateName() -> Bool {
        return nameComponents.count >= 2
    }
    
    func validateAmount() -> Bool {
        let value = (amount as NSString).doubleValue
        return value.isNormal && value > 0
    }
    
    func addPayback() {
        let names = nameComponents
        let amount = (self.amount as NSString).doubleValue
        let payback = Payback(firstName: names[0], lastName: names[1], createdAt: NSDate(), amount: amount)
        context.addPayback(payback)
    }
    
    func savePayback() {
        let names = nameComponents
        let amount = (self.amount as NSString).doubleValue
        context.editPayback(index, firstName: names[0], lastname: names[1], amount: amount, updated: NSDate())
    }
    
}

public protocol DetailViewModelDelegate: class {
    func dismissAddView()
    func showInvalidName()
    func showInvalidAmount()
}
