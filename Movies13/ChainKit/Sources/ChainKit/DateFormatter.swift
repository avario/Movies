//
//  DateFormatter.swift
//  ChainKit
//
//  Created by Avario.
//

import Foundation

public extension DateFormatter {
	
	public func localizedDateFormatTemplate(_ dateFormatTemplate: String) -> Self {
		self.setLocalizedDateFormatFromTemplate(dateFormatTemplate)
		return self
	}
	
	public func formattingContext(_ formattingContext: Formatter.Context) -> Self {
		self.formattingContext = formattingContext
		return self
	}
	
	public func dateFormat(_ dateFormat: String) -> Self {
		self.dateFormat = dateFormat
		return self
	}
	
	public func dateStyle(_ dateStyle: Style) -> Self {
		self.dateStyle = dateStyle
		return self
	}
	
	public func timeStyle(_ timeStyle: Style) -> Self {
		self.timeStyle = timeStyle
		return self
	}
	
	public func locale(_ locale: Locale) -> Self {
		self.locale = locale
		return self
	}
	
	public func generatesCalendarDates(_ generatesCalendarDates: Bool) -> Self {
		self.generatesCalendarDates = generatesCalendarDates
		return self
	}
	
	public func formatterBehavior(_ formatterBehavior: Behavior) -> Self {
		self.formatterBehavior = formatterBehavior
		return self
	}
	
	public func timeZone(_ timeZone: TimeZone) -> Self {
		self.timeZone = timeZone
		return self
	}
	
	public func calendar(_ calendar: Calendar) -> Self {
		self.calendar = calendar
		return self
	}
	
	public func isLenient(_ isLenient: Bool) -> Self {
		self.isLenient = isLenient
		return self
	}
	
	public func twoDigitStartDate(_ twoDigitStartDate: Date) -> Self {
		self.twoDigitStartDate = twoDigitStartDate
		return self
	}
	
	public func defaultDate(_ defaultDate: Date) -> Self {
		self.defaultDate = defaultDate
		return self
	}
	
	public func eraSymbols(_ eraSymbols: [String]) -> Self {
		self.eraSymbols = eraSymbols
		return self
	}
	
	public func monthSymbols(_ monthSymbols: [String]) -> Self {
		self.monthSymbols = monthSymbols
		return self
	}
	
	public func shortMonthSymbols(_ shortMonthSymbols: [String]) -> Self {
		self.shortMonthSymbols = shortMonthSymbols
		return self
	}
	
	public func weekdaySymbols(_ weekdaySymbols: [String]) -> Self {
		self.weekdaySymbols = weekdaySymbols
		return self
	}
	
	public func shortWeekdaySymbols(_ shortWeekdaySymbols: [String]) -> Self {
		self.shortWeekdaySymbols = shortWeekdaySymbols
		return self
	}
	
	public func amSymbol(_ amSymbol: String) -> Self {
		self.amSymbol = amSymbol
		return self
	}
	
	public func pmSymbol(_ pmSymbol: String) -> Self {
		self.pmSymbol = pmSymbol
		return self
	}
	
	public func longEraSymbols(_ longEraSymbols: [String]) -> Self {
		self.longEraSymbols = longEraSymbols
		return self
	}
	
	public func veryShortMonthSymbols(_ veryShortMonthSymbols: [String]) -> Self {
		self.veryShortMonthSymbols = veryShortMonthSymbols
		return self
	}
	
	public func standaloneMonthSymbols(_ standaloneMonthSymbols: [String]) -> Self {
		self.standaloneMonthSymbols = standaloneMonthSymbols
		return self
	}
	
	public func shortStandaloneMonthSymbols(_ shortStandaloneMonthSymbols: [String]) -> Self {
		self.shortStandaloneMonthSymbols = shortStandaloneMonthSymbols
		return self
	}
	
	public func veryShortStandaloneMonthSymbols(_ veryShortStandaloneMonthSymbols: [String]) -> Self {
		self.veryShortStandaloneMonthSymbols = veryShortStandaloneMonthSymbols
		return self
	}
	
	public func veryShortWeekdaySymbols(_ veryShortWeekdaySymbols: [String]) -> Self {
		self.veryShortWeekdaySymbols = veryShortWeekdaySymbols
		return self
	}
	
	public func standaloneWeekdaySymbols(_ standaloneWeekdaySymbols: [String]) -> Self {
		self.standaloneWeekdaySymbols = standaloneWeekdaySymbols
		return self
	}
	
	public func shortStandaloneWeekdaySymbols(_ shortStandaloneWeekdaySymbols: [String]) -> Self {
		self.shortStandaloneWeekdaySymbols = shortStandaloneWeekdaySymbols
		return self
	}
	
	public func veryShortStandaloneWeekdaySymbols(_ veryShortStandaloneWeekdaySymbols: [String]) -> Self {
		self.veryShortStandaloneWeekdaySymbols = veryShortStandaloneWeekdaySymbols
		return self
	}
	
	public func quarterSymbols(_ quarterSymbols: [String]) -> Self {
		self.quarterSymbols = quarterSymbols
		return self
	}
	
	public func shortQuarterSymbols(_ shortQuarterSymbols: [String]) -> Self {
		self.shortQuarterSymbols = shortQuarterSymbols
		return self
	}
	
	public func standaloneQuarterSymbols(_ standaloneQuarterSymbols: [String]) -> Self {
		self.standaloneQuarterSymbols = standaloneQuarterSymbols
		return self
	}
	
	public func shortStandaloneQuarterSymbols(_ shortStandaloneQuarterSymbols: [String]) -> Self {
		self.shortStandaloneQuarterSymbols = shortStandaloneQuarterSymbols
		return self
	}
	
	public func gregorianStartDate(_ gregorianStartDate: Date) -> Self {
		self.gregorianStartDate = gregorianStartDate
		return self
	}
	
	public func doesRelativeDateFormatting(_ doesRelativeDateFormatting: Bool) -> Self {
		self.doesRelativeDateFormatting = doesRelativeDateFormatting
		return self
	}
	
}
