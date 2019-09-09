import Vapor

/// Controls basic CRUD operations on `UserController`s.
final class EmployeeController {
    /// Returns a list of all `UserController`s.
    func index(_ req: Request) throws -> Future<[Employee]> {
        return Employee.query(on: req).all()
    }

    /// Saves a decoded `Todo` to the database.
    func create(_ req: Request) throws -> Future<Employee> {
        return try req.content.decode(Employee.self).flatMap { employee in
            return employee.save(on: req)
        }
    }

    /// Deletes a parameterized `Todo`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Employee.self).flatMap { employee in
            return employee.delete(on: req)
        }.transform(to: .ok)
    }
}
