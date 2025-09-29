// FirebaseService.swift
import FirebaseDatabase
import Combine
import CoreLocation

class FirebaseService: ObservableObject {
    static let shared = FirebaseService()
    private let database = Database.database().reference()
    
    // Use mock data for now - switch to false when ready
    private let useMockData = false
    
    // Fetch all resorts
    func fetchResorts() -> AnyPublisher<[Resort], Error> {
        // For now, return mock data
        if useMockData {
            return Just(Resort.mockResorts)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        // Firebase implementation
        return Future { promise in
            self.database.child("resorts").observeSingleEvent(of: .value) { snapshot in
                var resorts: [Resort] = []
                
                for child in snapshot.children {
                    if let snapshot = child as? DataSnapshot,
                       let resort = self.parseResort(from: snapshot) {
                        resorts.append(resort)
                    }
                }
                
                promise(.success(resorts))
            } withCancel: { error in
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    // Parse resort from Firebase snapshot
    private func parseResort(from snapshot: DataSnapshot) -> Resort? {
        guard let dict = snapshot.value as? [String: Any],
              let name = dict["name"] as? String else {
            return nil
        }
        
        // For MVP, just create a minimal resort
        // You can expand this parsing later
        return Resort(
            id: snapshot.key,
            name: name,
            state: dict["state"] as? String ?? "CO",
            region: dict["region"] as? String ?? "Rocky Mountains",
            latitude: (dict["latitude"] as? Double) ?? 39.6061,
            longitude: (dict["longitude"] as? Double) ?? -106.3550,
            imageUrl: dict["imageUrl"] as? String,
            images: dict["images"] as? [String] ?? [],
            elevation: dict["elevation"] as? Int,
            runs: dict["runs"] as? Int,
            rating: dict["rating"] as? Double,
            isOpen: dict["isOpen"] as? Bool ?? true,
            ticketCost: dict["ticketCost"] as? Double,
            fullDayTicket: dict["fullDayTicket"] as? String ?? "$100",
            halfDayTicket: dict["halfDayTicket"] as? String ?? "$75",
            difficulty: DifficultyInfo(
                percent: DifficultyPercent(
                    green: "25%", blue: "40%", doubleBlue: "15%",
                    black: "15%", doubleBlack: "5%"
                ),
                distance: DifficultyDistance(
                    green: "5 miles", blue: "8 miles", doubleBlue: "3 miles",
                    black: "3 miles", doubleBlack: "1 mile"
                )
            ),
            terrainPark: "Yes",
            backcountry: false,
            snowmobile: false,
            snowTubing: true,
            iceSkating: false,
            nightSkiing: false,
            description: dict["description"] as? String ?? "A great ski resort",
            matchPercentage: nil,
            scrapeUrl: "",
            url: dict["url"] as? String ?? "",
            weather: nil
        )
    }
    
    // For observing resorts, also use mock data for now
    func observeResorts(completion: @escaping ([Resort]) -> Void) {
        if useMockData {
            completion(Resort.mockResorts)
            return
        }
        
        database.child("resorts").observe(.value) { snapshot in
            var resorts: [Resort] = []
            
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let resort = self.parseResort(from: snapshot) {
                    resorts.append(resort)
                }
            }
            
            completion(resorts)
        }
    }
    
    // Fetch single resort
    func fetchResort(id: String) -> AnyPublisher<Resort?, Error> {
        if useMockData {
            let resort = Resort.mockResorts.first { $0.id == id }
            return Just(resort)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return Future { promise in
            self.database.child("resorts").child(id).observeSingleEvent(of: .value) { snapshot in
                let resort = self.parseResort(from: snapshot)
                promise(.success(resort))
            } withCancel: { error in
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
