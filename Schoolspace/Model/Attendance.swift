struct Attendance: Codable {
    let id: String
    let student: String
    let teacher: String
    let subject: String
    let present: Bool
    let absent: Bool
    let createdAt: String
    let updatedAt: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case student
        case teacher
        case subject
        case present
        case absent
        case createdAt
        case updatedAt
        case v = "__v"
    }
}
