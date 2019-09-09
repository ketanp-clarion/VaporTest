import FluentSQLite
import Vapor

/// A single entry of a Employee list.
final class Employee: SQLiteModel {
    /// The unique identifier for this `Employee`.
    var id: Int?
    
    /// A title describing what this `Employee` entails.
    var name: String
    var emailAddress: String
    var phoneNumber: String
    var password: String
    
    /// Creates a new `Employee`.
    init(id: Int? = nil, name: String, emailAddress: String, phoneNumber: String, password: String) {
        self.id = id
        self.name = name
        self.emailAddress = emailAddress
        self.phoneNumber = phoneNumber
        self.password = password
    }
}

/// Allows `Employee` to be used as a dynamic migration.
extension Employee: Migration { }

/// Allows `Employee` to be encoded to and decoded from HTTP messages.
extension Employee: Content { }

/// Allows `Employee` to be used as a dynamic parameter in route definitions.
extension Employee: Parameter { }
