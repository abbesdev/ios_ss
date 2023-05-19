struct SubjectNew: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
    let version: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case description
        case version = "__v"
    }
}
