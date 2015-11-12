
import Foundation

public class ListViewModel {
    
    public let context = Context.defaultContext
    public var items = [Item]()
    
    public func refresh() {
        items = context.paybacks.map { self.itemForPayback($0) }
        print(items)
    }
    
    func itemForPayback(payback: Payback) -> Item {
        let singleLetter = payback.lastName.substringToIndex(payback.lastName.startIndex.successor())
        
        let title = "\(payback.firstName) \(singleLetter)."
        let subtitle = NSDateFormatter.localizedStringFromDate(payback.createdAt, dateStyle: NSDateFormatterStyle.LongStyle, timeStyle: NSDateFormatterStyle.NoStyle)
        
        let rounded = NSNumber(double: round(payback.amount)).longLongValue
        let amount = "$\(rounded)"
        
        let item = Item(title: title, subtitle: subtitle, amount: amount)
        
        return item
    }
    
    func removePayback(index: Int) {
        context.removePayback(index)
    }
    
    public struct Item {
        public let title: String
        public let subtitle: String
        public let amount: String
    }
    
}
