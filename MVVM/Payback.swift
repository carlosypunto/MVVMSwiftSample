
import Foundation

class Payback: Equatable {
    
    var firstName: String
    var lastName: String
    var createdAt: NSDate
    var updatedAt: NSDate
    var amount: Double
    
    init(firstName: String, lastName: String, createdAt: NSDate, amount: Double) {
        self.firstName = firstName
        self.lastName = lastName
        self.createdAt = createdAt
        self.updatedAt = createdAt
        self.amount = amount
    }
    
}

func ==(l: Payback, r: Payback) -> Bool {
    return l.firstName == r.firstName &&
           l.lastName == r.lastName &&
           l.createdAt == r.createdAt &&
           l.amount == r.amount
}