//
//  FilmResponse.swift
//  SwapiSwiftMVC
//
//  Created by mac on 14/09/22.
//

import Foundation

// MARK: - FilmResponse
class FilmResponse: Codable {
    let title: String
    let episodeID: Int
    let openingCrawl: String
    let director: String
    let producer: String
    let releaseDate: String
    let characters: [String]
    let planets: [String]
    let starships: [String]
    let vehicles: [String]
    let species: [String]
    let created: String
    let edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case episodeID = "episode_id"
        case openingCrawl = "opening_crawl"
        case director = "director"
        case producer = "producer"
        case releaseDate = "release_date"
        case characters = "characters"
        case planets = "planets"
        case starships = "starships"
        case vehicles = "vehicles"
        case species = "species"
        case created = "created"
        case edited = "edited"
        case url = "url"
    }

    init(title: String, episodeID: Int, openingCrawl: String, director: String, producer: String, releaseDate: String, characters: [String], planets: [String], starships: [String], vehicles: [String], species: [String], created: String, edited: String, url: String) {
        self.title = title
        self.episodeID = episodeID
        self.openingCrawl = openingCrawl
        self.director = director
        self.producer = producer
        self.releaseDate = releaseDate
        self.characters = characters
        self.planets = planets
        self.starships = starships
        self.vehicles = vehicles
        self.species = species
        self.created = created
        self.edited = edited
        self.url = url
    }
}

// MARK: FilmResponse convenience initializers and mutators

extension FilmResponse {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(FilmResponse.self, from: data)
        self.init(title: me.title, episodeID: me.episodeID, openingCrawl: me.openingCrawl, director: me.director, producer: me.producer, releaseDate: me.releaseDate, characters: me.characters, planets: me.planets, starships: me.starships, vehicles: me.vehicles, species: me.species, created: me.created, edited: me.edited, url: me.url)
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
        title: String? = nil,
        episodeID: Int? = nil,
        openingCrawl: String? = nil,
        director: String? = nil,
        producer: String? = nil,
        releaseDate: String? = nil,
        characters: [String]? = nil,
        planets: [String]? = nil,
        starships: [String]? = nil,
        vehicles: [String]? = nil,
        species: [String]? = nil,
        created: String? = nil,
        edited: String? = nil,
        url: String? = nil
    ) -> FilmResponse {
        return FilmResponse(
            title: title ?? self.title,
            episodeID: episodeID ?? self.episodeID,
            openingCrawl: openingCrawl ?? self.openingCrawl,
            director: director ?? self.director,
            producer: producer ?? self.producer,
            releaseDate: releaseDate ?? self.releaseDate,
            characters: characters ?? self.characters,
            planets: planets ?? self.planets,
            starships: starships ?? self.starships,
            vehicles: vehicles ?? self.vehicles,
            species: species ?? self.species,
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

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
