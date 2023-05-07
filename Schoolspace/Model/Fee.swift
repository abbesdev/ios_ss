import Foundation


protocol DateFormatterProtocol {
    var formatter: DateFormatter { get }
}

struct ISO8601DateFormatter: DateFormatterProtocol {
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }()
}
extension KeyedDecodingContainer {
    func decodeISO8601Date(forKey key: Key) throws -> Date {
        let iso8601DateFormatter = ISO8601DateFormatter()
        let dateString = try self.decode(String.self, forKey: key)
        guard let date = iso8601DateFormatter.formatter.date(from: dateString) else {
            throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "Invalid date string: \(dateString)")
        }
        return date
    }
}
struct Fee: Codable, Identifiable {
    let id: String
    let student: String
    let parent: String
    let amount: Int
    let paid: Bool
    let dueDate: Date

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case student
        case parent
        case amount
        case paid
        case dueDate
        case version
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(student, forKey: .student)
        try container.encode(parent, forKey: .parent)
        try container.encode(amount, forKey: .amount)
        try container.encode(paid, forKey: .paid)
        let iso8601DateFormatter = ISO8601DateFormatter()
        try container.encode(iso8601DateFormatter.formatter.string(from: dueDate), forKey: .dueDate)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        student = try container.decode(String.self, forKey: .student)
        parent = try container.decode(String.self, forKey: .parent)
        amount = try container.decode(Int.self, forKey: .amount)
        paid = try container.decode(Bool.self, forKey: .paid)
        dueDate = try container.decodeISO8601Date(forKey: .dueDate)
    }
}
