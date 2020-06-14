import XCTest
@testable import MiiPets

class ServiceParsingTests: XCTestCase {

    func testParsingOfServicesResponse() {
        // given
        let bundle = Bundle(for: SitterViewModel.self)
        let file = bundle.url(forResource: "services", withExtension: "json")?.path
        let data = try? Data(contentsOf: URL(fileURLWithPath: file!))

        XCTAssertNotNil(data)

        // when

        do {
            let content: Services! = try JSONDecoder().decode(Services.self, from: data!)

            // then
            XCTAssertNotNil(content)
            XCTAssertEqual(content.services.count, 5)

            let service = content.services.first!

            XCTAssertEqual(service.serviceID, "1")
            XCTAssertEqual(service.userID, "1")
            XCTAssertEqual(service.type, .walker)
            XCTAssertEqual(service.title, "Lovely walk on Sea point promanade")
            XCTAssertEqual(service.price, "200.00")
            XCTAssertEqual(service.currency, "ZAR")
            XCTAssertEqual(service.priceRate, "per day")
            XCTAssertEqual(service.overview, "Does your dog love walks on the beach? Then she/he will love this service! I will take your lovely dog on a walk around the Seapoint promenade (about 2 km). I will adapt to the peace of your dog and return when I see they get too tired. The total time this should take is about 1 hour and I will only charge you for only 1 hour even if it does take a little longer. I will also constantly send updates annd pictures :).")
            XCTAssertEqual(service.location, "Cape Town, Western Cape")
            XCTAssertEqual(service.gallery?.count, 1)
            XCTAssertEqual(service.gallery?.first?.path, "www.google.com")
            XCTAssertEqual(service.allowedPets?.count, 1)
            XCTAssertEqual(service.allowedPets?.first?.type, .dogs)
            XCTAssertEqual(service.numberOfReviews, 2)
            XCTAssertEqual(service.overallRating, 4.3)
            XCTAssertNotNil(service.businessHours)
            XCTAssertEqual(service.businessHours?.startTime, "08:00")
            XCTAssertEqual(service.businessHours?.endTime, "12:00")
        } catch let error {
            debugPrint("Decoding error: \(error.localizedDescription)")
            XCTFail()
        }
    }
}
