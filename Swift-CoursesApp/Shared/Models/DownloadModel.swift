import SwiftUI

struct DownloadType: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var logo: String
}

var DownloadVideosData = [
    DownloadType(
        title: "UI Design for iOS 14.zip",
        subtitle: "10 MB",
        logo: "Logo UI Design"
    ),
    DownloadType(
        title: "UI Design for developers.zip",
        subtitle: "32 MB",
        logo: "Logo UI Design"
    ),
    DownloadType(
        title: "SwiftUI Part 1.zip",
        subtitle: "62 MB",
        logo: "Logo SwiftUI"
    ),
    DownloadType(
        title: "SwiftUI Part 2.zip",
        subtitle: "29 MB",
        logo: "Logo SwiftUI"
    )
]

var DownloadFigmaData = [
    DownloadType(
        title: "Angle Free.zip",
        subtitle: "10 MB",
        logo: "Logo Figma"
    ),
    DownloadType(
        title: "Shape Icons Free.zip",
        subtitle: "32 MB",
        logo: "Logo Figma"
    ),
    DownloadType(
        title: "Shape Illustrations Free.zip",
        subtitle: "62 MB",
        logo: "Logo Figma"
    ),
    DownloadType(
        title: "Design+Code 4 UI Kit.zip",
        subtitle: "29 MB",
        logo: "Logo Figma"
    )
]
