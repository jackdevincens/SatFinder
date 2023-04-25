//
//  DetailViewModel.swift
//  SatelliteProject
//
//  Created by Jack Marshall DeVincens on 4/24/23.
//

import Foundation

@MainActor
class DetailViewModel: ObservableObject {
    @Published var satellite = Satellite()
    @Published var isLoading = false
    @Published var urlString = ""
    
    private struct Returned: Codable {
        var tle: String
    }
    
    func getData() async {
        print("Accessing Data from \(urlString)")
        isLoading = true
        guard let url = URL(string: urlString) else {
            print("ERROR: Could not create url from \(urlString)")
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let returned = try decoder.decode(Returned.self, from: data)
            let tleString = returned.tle
            let lines = tleString.components(separatedBy: "\r\n")
            let line1 = lines[0]
            let line2 = lines[1]
            self.satellite = linesToSatellite(line1: line1, line2: line2)
            isLoading = false
        } catch {
            print("ERROR: \(error.localizedDescription)")
            isLoading = false
        }
    }
    
    func line1Func(line: String) -> [String] {
        func epochToJulian(year: Int, day: Int) -> String {
            func dateStringFromDayOfYear(dayOfYear: Int, yearVal: Int) -> String {
                // Create a date component with the given day of year
                var dateComponents = DateComponents()
                dateComponents.day = dayOfYear
                
                // Add year information to date components
                dateComponents.year = year
                
                // Create a calendar instance
                let calendar = Calendar.current
                
                // Use the calendar to get the date from the date components
                let date = calendar.date(from: dateComponents)!
                
                // Create a date formatter to format the date as a string
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMMM d"
                
                // Format the date as a string and return it
                return dateFormatter.string(from: date)
            }

            func isLeapYear(year: Int) -> Bool {
                return year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)
            }
            
            let date = dateStringFromDayOfYear(dayOfYear: day, yearVal: year)
            return date  + ", \(year)"
        }
        
        func addSuffixToNumber(_ numberString: String) -> String {
            var suffix = ""
            var number = numberString
            
            // Remove leading zero if necessary
            if number.hasPrefix("0") {
                number.removeFirst()
            }
            
            // Determine suffix based on last digit
            switch number.last {
            case "1":
                suffix = "st"
            case "2":
                suffix = "nd"
            case "3":
                suffix = "rd"
            default:
                suffix = "th"
            }
            
            return number + suffix
        }
        
        let catalogNumber = String(line.dropFirst(2).prefix(5))
        let classification = String(line.dropFirst(7).prefix(1))
        let launchYearString = String(line.dropFirst(9).prefix(2))
        let launchYear = (Int(launchYearString)! <= 56) ? "20\(launchYearString)" : "19\(launchYearString)"
        let launchNumber = addSuffixToNumber((String(line.dropFirst(11).prefix(3))))
        let epochYear = String(line.dropFirst(18).prefix(2))
        let fullYear = (Int(epochYear)! <= 56) ? "20\(epochYear)" : "19\(epochYear)"
        let epochDay = String(line.dropFirst(20).prefix(3))
        let epoch = epochToJulian(year: Int(fullYear)!, day: Int(epochDay)!)
        
        let returned = [catalogNumber, classification, launchYear, launchNumber, epoch]
        
        return returned
    }
    
    func line2Func(line: String) -> [String] {
        let inclinationString = String(line.dropFirst(8).prefix(8)).replacing(" ", with: "")
        let inclination = Double(inclinationString)! <= 90.0 ? "Prograde" : "Retrograde"
        let revolutionsPerDay = String(line.dropFirst(52).prefix(11))
        let totalRevolutions = String(line.dropFirst(63).prefix(5))
        
        return [inclination, revolutionsPerDay, totalRevolutions]
    }
    
    func linesToSatellite(line1: String, line2: String) -> Satellite {
        let line1Values = line1Func(line: line1)
        let line2Values = line2Func(line: line2)
        
        return Satellite(name: satellite.name, catalogNumber: line1Values[0], classification: line1Values[1], launchYear: line1Values[2], launchNumber: line1Values[3], epoch: line1Values[4], inclination: line2Values[0], revolutionsPerDay: line2Values[1], totalRevolutions: line2Values[2])
    }
}
