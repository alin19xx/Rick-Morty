//
//  CharactersLastPageMock.swift
//  Rick&MortyTests
//
//  Created by Alex Lin Segarra on 16/1/25.
//

import Foundation

struct CharactersLastPageMock {
    static func makeJsonMock() -> Data {
        """
        {
            "info": {
                "count": 826,
                "pages": 42,
                "next": null,
                "prev": "https://rickandmortyapi.com/api/character/?page=41"
            },
            "results": [
                {
                    "id": 821,
                    "name": "Gotron",
                    "status": "unknown",
                    "species": "Robot",
                    "type": "Ferret Robot",
                    "gender": "Genderless",
                    "origin": {
                        "name": "Earth (Replacement Dimension)",
                        "url": "https://rickandmortyapi.com/api/location/20"
                    },
                    "location": {
                        "name": "Earth (Replacement Dimension)",
                        "url": "https://rickandmortyapi.com/api/location/20"
                    },
                    "image": "https://rickandmortyapi.com/api/character/avatar/821.jpeg",
                    "episode": [
                        "https://rickandmortyapi.com/api/episode/48"
                    ],
                    "url": "https://rickandmortyapi.com/api/character/821",
                    "created": "2021-11-02T17:15:24.788Z"
                },
                {
                    "id": 822,
                    "name": "Young Jerry",
                    "status": "unknown",
                    "species": "Human",
                    "type": "",
                    "gender": "Male",
                    "origin": {
                        "name": "Earth (Unknown dimension)",
                        "url": "https://rickandmortyapi.com/api/location/30"
                    },
                    "location": {
                        "name": "Earth (Unknown dimension)",
                        "url": "https://rickandmortyapi.com/api/location/30"
                    },
                    "image": "https://rickandmortyapi.com/api/character/avatar/822.jpeg",
                    "episode": [
                        "https://rickandmortyapi.com/api/episode/51"
                    ],
                    "url": "https://rickandmortyapi.com/api/character/822",
                    "created": "2021-11-02T17:18:31.934Z"
                },
                {
                    "id": 823,
                    "name": "Young Beth",
                    "status": "unknown",
                    "species": "Human",
                    "type": "",
                    "gender": "Female",
                    "origin": {
                        "name": "Earth (Unknown dimension)",
                        "url": "https://rickandmortyapi.com/api/location/30"
                    },
                    "location": {
                        "name": "Earth (Unknown dimension)",
                        "url": "https://rickandmortyapi.com/api/location/30"
                    },
                    "image": "https://rickandmortyapi.com/api/character/avatar/823.jpeg",
                    "episode": [
                        "https://rickandmortyapi.com/api/episode/51"
                    ],
                    "url": "https://rickandmortyapi.com/api/character/823",
                    "created": "2021-11-02T17:19:00.951Z"
                },
                {
                    "id": 824,
                    "name": "Young Beth",
                    "status": "unknown",
                    "species": "Human",
                    "type": "",
                    "gender": "Female",
                    "origin": {
                        "name": "Earth (Unknown dimension)",
                        "url": "https://rickandmortyapi.com/api/location/30"
                    },
                    "location": {
                        "name": "Earth (Unknown dimension)",
                        "url": "https://rickandmortyapi.com/api/location/30"
                    },
                    "image": "https://rickandmortyapi.com/api/character/avatar/824.jpeg",
                    "episode": [
                        "https://rickandmortyapi.com/api/episode/51"
                    ],
                    "url": "https://rickandmortyapi.com/api/character/824",
                    "created": "2021-11-02T17:19:47.957Z"
                },
                {
                    "id": 825,
                    "name": "Young Jerry",
                    "status": "unknown",
                    "species": "Human",
                    "type": "",
                    "gender": "Male",
                    "origin": {
                        "name": "Earth (Unknown dimension)",
                        "url": "https://rickandmortyapi.com/api/location/30"
                    },
                    "location": {
                        "name": "Earth (Unknown dimension)",
                        "url": "https://rickandmortyapi.com/api/location/30"
                    },
                    "image": "https://rickandmortyapi.com/api/character/avatar/825.jpeg",
                    "episode": [
                        "https://rickandmortyapi.com/api/episode/51"
                    ],
                    "url": "https://rickandmortyapi.com/api/character/825",
                    "created": "2021-11-02T17:20:14.305Z"
                },
                {
                    "id": 826,
                    "name": "Butter Robot",
                    "status": "Alive",
                    "species": "Robot",
                    "type": "Passing Butter Robot",
                    "gender": "Genderless",
                    "origin": {
                        "name": "Earth (Replacement Dimension)",
                        "url": "https://rickandmortyapi.com/api/location/20"
                    },
                    "location": {
                        "name": "Earth (Replacement Dimension)",
                        "url": "https://rickandmortyapi.com/api/location/20"
                    },
                    "image": "https://rickandmortyapi.com/api/character/avatar/826.jpeg",
                    "episode": [
                        "https://rickandmortyapi.com/api/episode/9"
                    ],
                    "url": "https://rickandmortyapi.com/api/character/826",
                    "created": "2021-11-02T17:24:37.458Z"
                }
            ]
        }
        """.data(using: .utf8)!
    }
}
