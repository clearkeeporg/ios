//
//  SearchTextField.swift
//
//
//  Created by NamNH on 03/03/2022.
//

// swiftlint:disable multiple_closures_with_trailing_closure

import SwiftUI

private enum Constants {
	static let textFieldHeight = 52.0
	static let paddingVertical = 14.0
	static let paddingHorizontal = 24.0
	static let spacing = 14.0
}

public struct SearchTextField: View {
	// MARK: - Variables
	@Environment(\.colorScheme) var colorScheme
	@Binding var searchText: String
	@Binding var inputStyle: TextInputStyle
	@State private var shouldShowCancelButton: Bool = false
	private let inputIcon: Image?
	private let placeHolder: String
	private let keyboardType: UIKeyboardType
	private let onEditingChanged: (Bool) -> Void
	private let onTextChanged: (String) -> Void

	// MARK: - Init
	public init(searchText: Binding<String>,
				inputStyle: Binding<TextInputStyle>,
				inputIcon: Image? = nil,
				placeHolder: String,
				keyboardType: UIKeyboardType = .default,
				onEditingChanged: @escaping (Bool) -> Void,
				onTextChanged: @escaping (String) -> Void) {
		self._searchText = searchText
		self._inputStyle = inputStyle
		self.inputIcon = inputIcon
		self.placeHolder = placeHolder
		self.keyboardType = keyboardType
		self.onEditingChanged = onEditingChanged
		self.onTextChanged = onTextChanged
	}

	// MARK: - Body
	public var body: some View {
		HStack(alignment: .center) {
			if let inputIcon = inputIcon {
				inputIcon
					.foregroundColor(tintColor)
					.padding(.leading, Constants.paddingHorizontal)
			} else {
				Spacer()
					.frame(width: Constants.spacing)
			}
			CustomSearchTextField(placeHolder: placeHolder, text: $searchText, isFocused: onEditingChanged, onTextChanged: onTextChanged)
				.onChange(of: searchText) {
					shouldShowCancelButton = $0.count > 0
				}
				.font(font)
				.foregroundColor(textColor)
				.padding(.vertical, Constants.paddingVertical)
				.padding(.trailing, Constants.spacing)
				.autocapitalization(.none)
			if shouldShowCancelButton {
				Button(action: { searchText = "" }) {
					commonUIConfig.imageSet.closeIcon
						.foregroundColor(tintColor)
						.padding(.trailing, Constants.paddingHorizontal)
				}
			}
		}
		.frame(height: Constants.textFieldHeight)
		.background(backgroundColor)
		.cornerRadius(cornerRadius)
		.overlay(
			RoundedRectangle(cornerRadius: cornerRadius)
				.stroke(borderColor, lineWidth: borderWidth)
		)
	}
}

// MARK: - Private func
private extension SearchTextField {
	var backgroundColor: Color {
		colorScheme == .light ? inputStyle.backgroundColorLight : inputStyle.backgroundColorDark
	}

	var tintColor: Color {
		colorScheme == .light ? inputStyle.tintColorLight : inputStyle.tintColorDark
	}

	var borderColor: Color {
		colorScheme == .light ? inputStyle.borderColorLight : inputStyle.borderColorDark
	}

	var borderWidth: CGFloat {
		inputStyle.borderWidth
	}

	var cornerRadius: CGFloat {
		inputStyle.cornerRadius
	}

	var textColor: Color {
		colorScheme == .light ? inputStyle.textColorLight : inputStyle.textColorDark
	}

	var notifyColor: Color {
		colorScheme == .light ? inputStyle.notifyColorLight : inputStyle.notifyColorDark
	}

	var font: Font {
		inputStyle.textStyle.font
	}
}
