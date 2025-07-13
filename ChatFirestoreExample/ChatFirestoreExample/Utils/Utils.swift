//
//  Utils.swift
//  ChatFirestoreExample
//
//  Created by Alisa Mylnikova on 19.06.2023.
//

import SwiftUI

extension Sequence {
    func asyncMap<T>(
        _ transform: (Element) async throws -> T
    ) async rethrows -> [T] {
        var values = [T]()

        for element in self {
            try await values.append(transform(element))
        }

        return values
    }
}

extension View {
    func font(_ size: CGFloat, _ color: Color = .black, _ weight: Font.Weight = .regular) -> some View {
        self
            .fontWeight(weight)
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension String {
    func toURL() -> URL? {
        URL(string: self)
    }
}

extension Date {
    func timeAgoFormat(numericDates: Bool = false) -> String {
        let calendar = Calendar.current
        let date = self
        let now = Date()
        let earliest = (now as NSDate).earlierDate(date)
        let latest = (earliest == now) ? date : now
        let components: DateComponents = (calendar as NSCalendar).components(
            [.minute, .hour, .day, .weekOfYear, .month, .year, .second],
            from: earliest,
            to: latest,
            options: NSCalendar.Options()
        )

        if components.year! >= 2 {
            return "\(components.year!) anos atrás"
        } else if components.year! >= 1 {
            return numericDates ? "1 ano atrás" : "Ano passado"
        } else if components.month! >= 2 {
            return "\(components.month!) meses atrás"
        } else if components.month! >= 1 {
            return numericDates ? "1 mês atrás" : "Mês passado"
        } else if components.weekOfYear! >= 2 {
            return "\(components.weekOfYear!) semanas atrás"
        } else if components.weekOfYear! >= 1 {
            return numericDates ? "1 semana atrás" : "Semana passada"
        } else if components.day! >= 2 {
            return "\(components.day!) dias atrás"
        } else if components.day! >= 1 {
            return numericDates ? "1 dia atrás" : "Ontem"
        } else if components.hour! >= 2 {
            return "\(components.hour!) horas atrás"
        } else if components.hour! >= 1 {
            return numericDates ? "1 hora atrás" : "Há uma hora"
        } else if components.minute! >= 2 {
            return "\(components.minute!) minutos atrás"
        } else if components.minute! >= 1 {
            return numericDates ? "1 minuto atrás" : "Há um minuto"
        } else {
            return "Agora mesmo"
        }
    }
}
