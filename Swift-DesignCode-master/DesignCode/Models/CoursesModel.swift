import SwiftUI
import Contentful
import Combine


class CoursesModel: ObservableObject {
    @Published var courses: [CourseType] = CoursesData
    
   private let client = Client(spaceId: "0ge8xzmnbp2c", accessToken: "03010b0d79abcb655ca3fda453f2f493b5472e0aaa53664bc7dea5ef4fce2676")

    struct CourseType: Identifiable {
        var id = UUID()
        var title: String
        var subtitle: String
        var image: URL
        var logo: UIImage
        var color: UIColor
        var show: Bool
    }

    private func getCourses(id: String, completion: @escaping([Entry]) -> ()) {
        let query = Query.where(contentTypeId: id)
        client.fetchArray(of: Entry.self, matching: query) { result in
            switch result {
            
            case .success(let array):
                DispatchQueue.main.async {
                    completion(array.items)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }

    init() {
           
        
        let colors = [#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)]
        var index = 0
        
        getCourses(id: "course") { (items) in
            items.forEach { (item) in
                self.courses.append(CourseType(
                    title: item.fields["title"] as! String,
                    subtitle: item.fields["subtitle"]  as! String,
                    image: item.fields.linkedAsset(at: "image")?.url ?? URL(string:"")!,
                    logo: #imageLiteral(resourceName: "Logo1"),
                    color: colors[index],
                    show: false
                ))
                
                index = index + 1
            }
        }
    }
}


 
 
var CoursesData: Array<CoursesModel.CourseType> = [
    CoursesModel.CourseType(title: "Prototype Designs in SwiftUI", subtitle: "18 Sections", image: URL(string: "https://dl.dropbox.com/s/pmggyp7j64nvvg8/Certificate%402x.png?dl=0")!, logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), show: false),
    CoursesModel.CourseType(title: "SwiftUI Advanced", subtitle: "20 Sections", image: URL(string: "https://dl.dropbox.com/s/i08umta02pa09ns/Card3%402x.png?dl=0")!, logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), show: false),
    CoursesModel.CourseType(title: "UI Design for Developers", subtitle: "20 Sections", image: URL(string: "https://dl.dropbox.com/s/etdzsafqqeq0jjg/Card6%402x.png?dl=0")!, logo: #imageLiteral(resourceName: "Logo3"), color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), show: false)
]
