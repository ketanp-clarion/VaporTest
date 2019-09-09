import FluentMySQL
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    // Configure a MySQL database
    
    try services.register(FluentMySQLProvider())
    let mysqlConfig = MySQLDatabaseConfig(
        hostname: "192.168.1.1",
        port: 3306,
        username: "VaporDemo",
        password: "",
        database: "VaporDemo"
    )
    services.register(mysqlConfig)
    
    var migrations = MigrationConfig()
    migrations.add(model: Employee.self, database: .mysql)
    services.register(migrations)
}
