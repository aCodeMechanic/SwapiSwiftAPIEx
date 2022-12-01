//
//  PeopleResponse.swift
//  SwapiSwiftMVC
//
//  Created by mac on 14/09/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let peopleResponse = try PeopleResponse(json)

import Foundation

// MARK: - PeopleResponse
class PeopleResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case next = "next"
        case previous = "previous"
        case results = "results"
    }

    init(count: Int, next: String, previous: String, results: [Result]) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}

// MARK: PeopleResponse convenience initializers and mutators

extension PeopleResponse {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(PeopleResponse.self, from: data)
        self.init(count: me.count, next: me.next ?? "", previous: me.previous ?? "", results: me.results)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        count: Int? = nil,
        next: String? = nil,
        previous: String? = nil,
        results: [Result]? = nil
    ) -> PeopleResponse {
        return PeopleResponse(
            count: count ?? self.count,
            next: (next ?? self.next) ?? "",
            previous: (previous ?? self.previous) ?? "",
            results: results ?? self.results
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Result
class Result: Codable {
    let name: String
    let height: String
    let mass: String
    let hairColor: String
    let skinColor: String
    let eyeColor: String
    let birthYear: String
    let gender: String
    let homeworld: String
    let films: [String]
    let species: [String]
    let vehicles: [String]
    let starships: [String]
    let created: String
    let edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case height = "height"
        case mass = "mass"
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender = "gender"
        case homeworld = "homeworld"
        case films = "films"
        case species = "species"
        case vehicles = "vehicles"
        case starships = "starships"
        case created = "created"
        case edited = "edited"
        case url = "url"
    }

    init(name: String, height: String, mass: String, hairColor: String, skinColor: String, eyeColor: String, birthYear: String, gender: String, homeworld: String, films: [String], species: [String], vehicles: [String], starships: [String], created: String, edited: String, url: String) {
        self.name = name
        self.height = height
        self.mass = mass
        self.hairColor = hairColor
        self.skinColor = skinColor
        self.eyeColor = eyeColor
        self.birthYear = birthYear
        self.gender = gender
        self.homeworld = homeworld
        self.films = films
        self.species = species
        self.vehicles = vehicles
        self.starships = starships
        self.created = created
        self.edited = edited
        self.url = url
    }
}

// MARK: Result convenience initializers and mutators

extension Result {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Result.self, from: data)
        self.init(name: me.name, height: me.height, mass: me.mass, hairColor: me.hairColor, skinColor: me.skinColor, eyeColor: me.eyeColor, birthYear: me.birthYear, gender: me.gender, homeworld: me.homeworld, films: me.films, species: me.species, vehicles: me.vehicles, starships: me.starships, created: me.created, edited: me.edited, url: me.url)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        name: String? = nil,
        height: String? = nil,
        mass: String? = nil,
        hairColor: String? = nil,
        skinColor: String? = nil,
        eyeColor: String? = nil,
        birthYear: String? = nil,
        gender: String? = nil,
        homeworld: String? = nil,
        films: [String]? = nil,
        species: [String]? = nil,
        vehicles: [String]? = nil,
        starships: [String]? = nil,
        created: String? = nil,
        edited: String? = nil,
        url: String? = nil
    ) -> Result {
        return Result(
            name: name ?? self.name,
            height: height ?? self.height,
            mass: mass ?? self.mass,
            hairColor: hairColor ?? self.hairColor,
            skinColor: skinColor ?? self.skinColor,
            eyeColor: eyeColor ?? self.eyeColor,
            birthYear: birthYear ?? self.birthYear,
            gender: gender ?? self.gender,
            homeworld: homeworld ?? self.homeworld,
            films: films ?? self.films,
            species: species ?? self.species,
            vehicles: vehicles ?? self.vehicles,
            starships: starships ?? self.starships,
            created: created ?? self.created,
            edited: edited ?? self.edited,
            url: url ?? self.url
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

