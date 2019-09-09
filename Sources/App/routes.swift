import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world    !!!"
    }
    router.get("hello","ketan2") { req in
        return "Hello, Ketan Parkeh    !!!"
    }
    
    
    router.get("hello2", String.parameter) { req -> String in
        //2
        let name = try req.parameters.next(String.self)
        // 3
        return "Hello, \(name)!"
    }
    
    router.get("hello", String.parameter) { req -> String in
        //2
        let name = try req.parameters.next(String.self)
        // 3
        return "Hello, \(name)!"
    }
    router.post("sms") { req -> Future<HTTPStatus> in
        return try req.content.decode(MessageRequest.self).map(to: HTTPStatus.self) { messageRequest in
            print("To: (messageRequest.to)")
            print("From: (messageRequest.from)")
            print("Body: (messageRequest.body)")
            return .ok
        }
    }
    router.post(InfoData.self, at: "info1") { req, data -> InfoResponse in
        return InfoResponse(request: data)
    }
    router.post(Item.self, at: "item/create") { req, data -> String in
        return "You posted \(data.name) \(data.description)"
    }
    router.post(InfoData.self, at: "info") { req, data -> String in
        return "Hello \(data.name ?? "asasas")!"
    }
    
    
    let employeeController = EmployeeController()
    router.get("alluser", use: employeeController.index)
    router.post("adduser", use: employeeController.create)
    
    
}
struct Item: Content {
    let name: String
    let description: String
}
struct InfoData: Content {
    let name: String?
    let lastname: String?
}
struct InfoResponse: Content {
    let request: InfoData?
}

struct MessageRequest: Content {
    var to: String?
    var from: String?
    var body: String?
}
