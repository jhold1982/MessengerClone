//
//  Date.swift
//  MessengerClone
//
//  Created by Justin Hold on 3/18/25.
//

import Foundation

/**
 * Extension for Date class that provides custom formatting methods for displaying time and date information.
 * This extension helps create user-friendly timestamp displays by providing context-aware date formatting.
 */
extension Date {
	/// Returns a configured DateFormatter for time formatting
	/// Time is formatted in short style with 24-hour format (HH:mm)
	private var timeFormatter: DateFormatter {
		let formatter = DateFormatter()
		
		formatter.timeStyle = .short
		formatter.dateFormat = "HH:mm"
		
		return formatter
	}
	
	/// Returns a configured DateFormatter for date formatting
	/// Date is formatted as MM/dd/yy with medium time style
	/// Note: Setting both timeStyle and dateFormat may cause conflicts as they override each other
	private var dayFormatter: DateFormatter {
		let formatter = DateFormatter()
		
		formatter.timeStyle = .medium
		formatter.dateFormat = "MM/dd/yy"
		
		return formatter
	}
	
	/**
	 * Formats the current date instance as a time string using timeFormatter
	 * @return String representation of time in "HH:mm" format
	 */
	private func timeString() -> String {
		return timeFormatter.string(from: self)
	}
	
	/**
	 * Formats the current date instance as a date string using dayFormatter
	 * @return String representation of date in "MM/dd/yy" format
	 */
	private func dateString() -> String {
		return dayFormatter.string(from: self)
	}
	
	/**
	 * Creates a context-aware timestamp string based on when the date occurred
	 * - Returns the time (HH:mm) if the date is today
	 * - Returns "Yesterday" if the date was yesterday
	 * - Returns the date in MM/dd/yy format for any other date
	 *
	 * This method is especially useful for messaging apps, activity logs, and other UI elements
	 * where contextual time information improves user experience.
	 *
	 * @return String representing the formatted timestamp appropriate to the date's context
	 */
	func timeStringStamp() -> String {
		if Calendar.current.isDateInToday(self) {
			return timeString()
		} else if Calendar.current.isDateInYesterday(self) {
			return "Yesterday"
		} else {
			return dateString()
		}
	}
}
