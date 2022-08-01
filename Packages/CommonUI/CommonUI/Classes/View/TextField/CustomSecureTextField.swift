//
//  TextFieldStyle.swift
//  
//
//  Created by NamNH on 03/03/2022.
//

import SwiftUI

public struct CustomSecureTextField: UIViewRepresentable {

	let placeHolder: String
	@Binding var text: String
	@Binding var isRevealed: Bool
	let isFocused: (Bool) -> Void
	let onSubmit: () -> Void

	public func makeUIView(context: UIViewRepresentableContext<CustomSecureTextField>) -> UITextField {
		let textField = UITextField(frame: .zero)
		textField.placeholder = placeHolder
		textField.isUserInteractionEnabled = true
		textField.delegate = context.coordinator
		textField.autocapitalizationType = .none
		return textField
	}

	public func makeCoordinator() -> CustomSecureTextField.Coordinator {
		return Coordinator(text: $text, isEnabled: $isRevealed, isFocused: isFocused, onSubmit: onSubmit)
	}

	public func updateUIView(_ uiView: UITextField, context: Context) {
		uiView.isSecureTextEntry = !isRevealed
	}

	public class Coordinator: NSObject, UITextFieldDelegate {
		@Binding var text: String
		let isFocused: (Bool) -> Void
		let onSubmit: () -> Void

		init(text: Binding<String>, isEnabled: Binding<Bool>, isFocused: @escaping (Bool) -> Void, onSubmit: @escaping () -> Void) {
			_text = text
			self.isFocused = isFocused
			self.onSubmit = onSubmit
		}

		public func textFieldDidBeginEditing(_ textField: UITextField) {
			text = textField.text ?? ""
			self.isFocused(true)
		}

		public func textFieldDidEndEditing(_ textField: UITextField) {
			text = textField.text ?? ""
			self.isFocused(false)
		}

		public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
			textField.resignFirstResponder()
			self.onSubmit()
			return true
		}
		
		public func textFieldDidChangeSelection(_ textField: UITextField) {
			text = textField.text ?? ""
		}
	}
}
