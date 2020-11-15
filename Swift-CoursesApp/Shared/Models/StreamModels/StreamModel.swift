import SwiftUI

struct StreamType: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var subtitle: String
    var text: String
    var image: String
    var logo: String
    var show: Bool
    var appear: Bool
    var index: Double
}

var StreamsData = [
    StreamType(
        title: "UI Design Livestreams",
        subtitle: "Live sessions discussing about tips and tricks for designing user interfaces.",
        text: "6 videos",
        image: "Livestream 1",
        logo: "Logo UI Design",
        show: false,
        appear: false,
        index: 0
    ),
    StreamType(
        title: "SwiftUI Livestreams",
        subtitle: "Live sessions talking about design and code for SwiftUI.",
        text: "3 videos",
        image: "Livestream 2",
        logo: "Logo SwiftUI",
        show: false,
        appear: false,
        index: 0
    ),
    StreamType(
        title: "iOS Design Livestreams",
        subtitle: "Live sessions discussing about strategies for designing for Apple's platforms.",
        text: "3 videos",
        image: "Livestream 3",
        logo: "Logo Figma",
        show: false,
        appear: false,
        index: 0
    ),
    StreamType(
        title: "Sketch Livestreams",
        subtitle: "Live sessions discussing about tips and tricks for designing user interfaces in Sketch.",
        text: "6 videos",
        image: "Livestream 4",
        logo: "Logo Sketch",
        show: false,
        appear: false,
        index: 0
    ),
    StreamType(
        title: "Framer Livestreams",
        subtitle: "Live sessions talking about design and code for SwiftUI.",
        text: "3 videos",
        image: "Livestream 5",
        logo: "Logo Framer",
        show: false,
        appear: false,
        index: 0
    ),
    StreamType(
        title: "Adobe XD Livestreams",
        subtitle: "Live sessions discussing about strategies for designing using Adobe XD.",
        text: "3 videos",
        image: "Livestream 6",
        logo: "Logo XD",
        show: false,
        appear: false,
        index: 0
    )
]
