import Foundation
import MapboxDirections
import MapboxVisionARNative

extension MapboxVisionARNative.Route {
    /**
     Create `MapboxVisionARNative.Route` instance from `MapboxDirections.Route`.
     */
    convenience init(route: MapboxDirections.Route) {
        var points = [RoutePoint]()

        route.legs.forEach {
            $0.steps.forEach { step in
                let maneuver = RoutePoint(position: GeoCoordinate(lon: step.maneuverLocation.longitude, lat: step.maneuverLocation.latitude))
                points.append(maneuver)

                guard let coords = step.coordinates else { return }
                let routePoints = coords.map {
                    RoutePoint(position: GeoCoordinate(lon: $0.longitude, lat: $0.latitude), maneuverType: convert(maneuverType: step.maneuverType))
                }
                points.append(contentsOf: routePoints)
            }
        }

        self.init(points: points,
                  eta: Float(route.expectedTravelTime),
                  sourceStreetName: route.legs.first?.source.name ?? "",
                  destinationStreetName: route.legs.last?.destination.name ?? "")
    }
}

func convert(maneuverType: MapboxDirections.ManeuverType) -> MapboxVisionARNative.ManeuverType {
    switch maneuverType {
    case .none:
        return .none
    case .depart:
        return .depart
    case .turn:
        return .turn
    case .continue:
        return .continue
    case .passNameChange:
        return .newName
    case .merge:
        return .merge
    case .takeOnRamp:
        return .onRamp
    case .takeOffRamp:
        return .offRamp
    case .reachFork:
        return .fork
    case .reachEnd:
        return .endOfRoad
    case .useLane:
        return .none
    case .takeRoundabout:
        return .roundabout
    case .takeRotary:
        return .rotary
    case .turnAtRoundabout:
        return .roundaboutTurn
    case .exitRoundabout:
        return .roundaboutExit
    case .exitRotary:
        return .rotaryExit
    case .heedWarning:
        return .notification
    case .arrive:
        return .arrive
    case .passWaypoint:
        return .none
    }
}
