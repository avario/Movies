//
//  NumberFormatter.swift
//  ChainKit
//
//  Created by Avario.
//

import Foundation

public extension NumberFormatter {
	
	public func formattingContext(_ formattingContext: Formatter.Context) -> Self {
		self.formattingContext = formattingContext
		return self
	}
	
	public func numberStyle(_ numberStyle: Style) -> Self {
		self.numberStyle = numberStyle
		return self
	}
	
	public func locale(_ locale: Locale) -> Self {
		self.locale = locale
		return self
	}
	
	public func generatesDecimalNumbers(_ generatesDecimalNumbers: Bool) -> Self {
		self.generatesDecimalNumbers = generatesDecimalNumbers
		return self
	}
	
	public func formatterBehavior(_ formatterBehavior: Behavior) -> Self {
		self.formatterBehavior = formatterBehavior
		return self
	}
	
	public func negativeFormat(_ negativeFormat: String) -> Self {
		self.negativeFormat = negativeFormat
		return self
	}
	
	public func textAttributesForNegativeValues(_ textAttributesForNegativeValues: [String: Any]?) -> Self {
		self.textAttributesForNegativeValues = textAttributesForNegativeValues
		return self
	}
	
	public func positiveFormat(_ positiveFormat: String) -> Self {
		self.positiveFormat = positiveFormat
		return self
	}
	
	public func textAttributesForPositiveValues(_ textAttributesForPositiveValues: [String: Any]?) -> Self {
		self.textAttributesForPositiveValues = textAttributesForPositiveValues
		return self
	}
	
	public func allowsFloats(_ allowsFloats: Bool) -> Self {
		self.allowsFloats = allowsFloats
		return self
	}
	
	public func decimalSeparator(_ decimalSeparator: String) -> Self {
		self.decimalSeparator = decimalSeparator
		return self
	}
	
	public func alwaysShowsDecimalSeparator(_ alwaysShowsDecimalSeparatoralwaysShowsDecimalSeparatoralwaysShowsDecimalSeparator: Bool) -> Self {
		self.alwaysShowsDecimalSeparator = alwaysShowsDecimalSeparator
		return self
	}
	
	public func currencyDecimalSeparator(_ currencyDecimalSeparator: String) -> Self {
		self.currencyDecimalSeparator = currencyDecimalSeparator
		return self
	}
	
	public func usesGroupingSeparator(_ usesGroupingSeparator: Bool) -> Self {
		self.usesGroupingSeparator = usesGroupingSeparator
		return self
	}
	
	public func groupingSeparator(_ groupingSeparator: String) -> Self {
		self.groupingSeparator = groupingSeparator
		return self
	}
	
	public func zeroSymbol(_ zeroSymbol: String) -> Self {
		self.zeroSymbol = zeroSymbol
		return self
	}
	
	public func textAttributesForZero(_ textAttributesForZero: [String: Any]?) -> Self {
		self.textAttributesForZero = textAttributesForZero
		return self
	}
	
	public func nilSymbol(_ nilSymbol: String) -> Self {
		self.nilSymbol = nilSymbol
		return self
	}
	
	public func textAttributesForNil(_ textAttributesForNil: [String: Any]?) -> Self {
		self.textAttributesForNil = textAttributesForNil
		return self
	}
	
	public func notANumberSymbol(_ notANumberSymbol: String) -> Self {
		self.notANumberSymbol = notANumberSymbol
		return self
	}
	
	public func textAttributesForNotANumber(_ textAttributesForNotANumber: [String: Any]?) -> Self {
		self.textAttributesForNotANumber = textAttributesForNotANumber
		return self
	}
	
	public func positiveInfinitySymbol(_ positiveInfinitySymbol: String) -> Self {
		self.positiveInfinitySymbol = positiveInfinitySymbol
		return self
	}
	
	public func textAttributesForPositiveInfinity(_ textAttributesForPositiveInfinity: [String: Any]?) -> Self {
		self.textAttributesForPositiveInfinity = textAttributesForPositiveInfinity
		return self
	}
	
	public func negativeInfinitySymbol(_ negativeInfinitySymbol: String) -> Self {
		self.negativeInfinitySymbol = negativeInfinitySymbol
		return self
	}
	
	public func textAttributesForNegativeInfinity(_ textAttributesForNegativeInfinity: [String: Any]?) -> Self {
		self.textAttributesForNegativeInfinity = textAttributesForNegativeInfinity
		return self
	}
	
	public func positivePrefix(_ positivePrefix: String) -> Self {
		self.positivePrefix = positivePrefix
		return self
	}
	
	public func positiveSuffix(_ positiveSuffix: String) -> Self {
		self.positiveSuffix = positiveSuffix
		return self
	}
	
	public func negativePrefix(_ negativePrefix: String) -> Self {
		self.negativePrefix = negativePrefix
		return self
	}
	
	public func negativeSuffix(_ negativeSuffix: String) -> Self {
		self.negativeSuffix = negativeSuffix
		return self
	}
	
	public func currencyCode(_ currencyCode: String) -> Self {
		self.currencyCode = currencyCode
		return self
	}
	
	public func currencySymbol(_ currencySymbol: String) -> Self {
		self.currencySymbol = currencySymbol
		return self
	}
	
	public func internationalCurrencySymbol(_ internationalCurrencySymbol: String) -> Self {
		self.internationalCurrencySymbol = internationalCurrencySymbol
		return self
	}
	
	public func percentSymbol(_ percentSymbol: String) -> Self {
		self.percentSymbol = percentSymbol
		return self
	}
	
	public func perMillSymbol(_ perMillSymbol: String) -> Self {
		self.perMillSymbol = perMillSymbol
		return self
	}
	
	public func minusSign(_ minusSign: String) -> Self {
		self.minusSign = minusSign
		return self
	}
	
	public func plusSign(_ plusSign: String) -> Self {
		self.plusSign = plusSign
		return self
	}
	
	public func exponentSymbol(_ exponentSymbol: String) -> Self {
		self.exponentSymbol = exponentSymbol
		return self
	}
	
	public func groupingSize(_ groupingSize: Int) -> Self {
		self.groupingSize = groupingSize
		return self
	}
	
	public func secondaryGroupingSize(_ secondaryGroupingSize: Int) -> Self {
		self.secondaryGroupingSize = secondaryGroupingSize
		return self
	}
	
	public func multiplier(_ multiplier: NSNumber?) -> Self {
		self.multiplier = multiplier
		return self
	}
	
	public func formatWidth(_ formatWidth: Int) -> Self {
		self.formatWidth = formatWidth
		return self
	}
	
	public func paddingCharacter(_ paddingCharacter: String) -> Self {
		self.paddingCharacter = paddingCharacter
		return self
	}
	
	public func paddingPosition(_ paddingPosition: PadPosition) -> Self {
		self.paddingPosition = paddingPosition
		return self
	}
	
	public func roundingMode(_ roundingMode: RoundingMode) -> Self {
		self.roundingMode = roundingMode
		return self
	}
	
	public func roundingIncrement(_ roundingIncrement: NSNumber) -> Self {
		self.roundingIncrement = roundingIncrement
		return self
	}
	
	public func minimumIntegerDigits(_ minimumIntegerDigits: Int) -> Self {
		self.minimumIntegerDigits = minimumIntegerDigits
		return self
	}
	
	public func maximumIntegerDigits(_ maximumIntegerDigits: Int) -> Self {
		self.maximumIntegerDigits = maximumIntegerDigits
		return self
	}
	
	public func minimumFractionDigits(_ minimumFractionDigits: Int) -> Self {
		self.minimumFractionDigits = minimumFractionDigits
		return self
	}
	
	public func maximumFractionDigits(_ maximumFractionDigits: Int) -> Self {
		self.maximumFractionDigits = maximumFractionDigits
		return self
	}
	
	public func minimum(_ minimum: NSNumber?) -> Self {
		self.minimum = minimum
		return self
	}
	
	public func maximum(_ maximum: NSNumber?) -> Self {
		self.maximum = maximum
		return self
	}
	
	public func currencyGroupingSeparator(_ currencyGroupingSeparator: String) -> Self {
		self.currencyGroupingSeparator = currencyGroupingSeparator
		return self
	}
	
	public func isLenient(_ isLenient: Bool) -> Self {
		self.isLenient = isLenient
		return self
	}
	
	public func usesSignificantDigits(_ usesSignificantDigits: Bool) -> Self {
		self.usesSignificantDigits = usesSignificantDigits
		return self
	}
	
	public func minimumSignificantDigits(_ minimumSignificantDigits: Int) -> Self {
		self.minimumSignificantDigits = minimumSignificantDigits
		return self
	}
	
	public func maximumSignificantDigits(_ maximumSignificantDigits: Int) -> Self {
		self.maximumSignificantDigits = maximumSignificantDigits
		return self
	}
	
	public func isPartialStringValidationEnabled(_ isPartialStringValidationEnabled: Bool) -> Self {
		self.isPartialStringValidationEnabled = isPartialStringValidationEnabled
		return self
	}
	
}
