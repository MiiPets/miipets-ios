import UIKit

class AppointmentsDataSource: NSObject {
    
    // MARK: - Properties
    
    private let currentDate: Date = Date()
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("MMMM")
        
        return formatter
    }()
    
    // MARK: - Public
    
    var visibleMonths: [String] {
        var months = [self.monthString(for: self.currentDate)]

        for i in 1...3 {
            months.append(self.monthString(for: self.currentDate.add(months: i)))
        }
        
        return months
    }
}

// MARK: - Date convenience

extension AppointmentsDataSource {
    
    fileprivate func monthString(for date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}

extension Date {
    
    fileprivate func add(months: Int) -> Date {
        return Calendar.current.date(byAdding: .month, value: months, to: self)!
    }
}
