//
//  VoiceCall.swift
//  ClearKeep
//
//  Created by đông on 04/04/2022.
//

import SwiftUI
import Combine
import Common
import CommonUI

private enum Constant {
	static let spacerTopView = 90.0
	static let spacer = 25.0
	static let spacerBottom = 45.0
	static let paddingVertical = 14.0
	static let sizeImage = 120.0
	static let paddingButtonNext = 60.0
	static let borderLineWidth = 2.0
	static let opacity = 0.8
}

struct VoiceCall: View {
	// MARK: - Variables
	let inspection = ViewInspector<Self>()
	@Environment(\.injected) private var injected: DIContainer
	@Environment(\.colorScheme) private var colorScheme
	@Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
	@State private(set) var samples: Loadable<[ICallModel]>
	@State private(set) var isTappedMute: Bool = false
	@State private(set) var isTappedCamera: Bool = false
	@State private(set) var isTappedSpeaker: Bool = false
	@State private(set) var isTappedEndCall: Bool = false
	@State private var timeCalled = 1

	let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

	// MARK: - Init
	public init(samples: Loadable<[ICallModel]> = .notRequested) {
		self._samples = .init(initialValue: samples)
	}

	// MARK: - Body
	var body: some View {
		content
			.onReceive(inspection.notice) { inspection.visit(self, $0) }
			.edgesIgnoringSafeArea(.all)
			.navigationBarBackButtonHidden(true)
	}
}

// MARK: - Private
private extension VoiceCall {
	var content: AnyView {
		AnyView(contentView)
	}
}

// MARK: - Loading Content
private extension VoiceCall {
	var contentView: some View {
		VStack(spacing: Constant.spacer) {
			buttonBackView
				.padding(.top, Constant.spacerTopView)
			userPicture
			userName
			timeCalling
			supportCalling
				.padding(.top, Constant.spacerBottom)
			buttonCancel
				.padding(.bottom, Constant.paddingButtonNext)
			Spacer()
		}
		.background(AppTheme.shared.colorSet.warningDefault.opacity(Constant.opacity))
		.padding(.horizontal, Constant.paddingVertical)
	}

	var buttonBackView: some View {
		Button(action: customBack) {
			HStack(spacing: Constant.spacer) {
				AppTheme.shared.imageSet.backIcon
					.aspectRatio(contentMode: .fit)
					.foregroundColor(foregroundBackButton)
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			.foregroundColor(AppTheme.shared.colorSet.offWhite)
		}
	}

	var statusCalling: some View {
		Text("Call.Calling".localized)
			.padding(.all)
			.font(AppTheme.shared.fontSet.font(style: .input2))
			.foregroundColor(AppTheme.shared.colorSet.grey5)
			.frame(maxWidth: .infinity, alignment: .center)
	}

	var userPicture: some View {
		ZStack {
			Circle()
				.fill(backgroundGradientPrimary)
				.frame(width: Constant.sizeImage, height: Constant.sizeImage)
			AppTheme.shared.imageSet.userIcon
		}
	}

	var userName: some View {
		Text("Alex".localized)
			.frame(maxWidth: .infinity, alignment: .center)
			.font(AppTheme.shared.fontSet.font(style: .display2))
			.foregroundColor(AppTheme.shared.colorSet.offWhite)
	}

	var timeCalling: some View {
		Text(getTimer())
			.padding()
			.onReceive(timer) { _ in
				if timeCalled > 0 {
					timeCalled += 1
				}
			}
	}

	var supportCalling: some View {
		HStack {
			Button {
				isTappedMute.toggle()
			} label: {
				ZStack {
					Circle()
						.strokeBorder(AppTheme.shared.colorSet.offWhite, lineWidth: Constant.borderLineWidth)
						.background(Circle().foregroundColor(backgroundButtonMute))
						.frame(width: Constant.paddingButtonNext, height: Constant.paddingButtonNext)
					muteIcon
						.foregroundColor(foregroundButtonMute)
				}
				.frame(maxWidth: .infinity)
			}

			Button {
				isTappedCamera.toggle()
			} label: {
				ZStack {
					Circle()
						.strokeBorder(AppTheme.shared.colorSet.offWhite, lineWidth: Constant.borderLineWidth)
						.background(Circle().foregroundColor(backgroundButtonCamera))
						.frame(width: Constant.paddingButtonNext, height: Constant.paddingButtonNext)
					cameraIcon
						.foregroundColor(foregroundButtonCamera)
				}
				.frame(maxWidth: .infinity)
			}

			Button {
				isTappedSpeaker.toggle()
			} label: {
				ZStack {
					Circle()
						.strokeBorder(AppTheme.shared.colorSet.offWhite, lineWidth: Constant.borderLineWidth)
						.background(Circle().foregroundColor(backgroundButtonSpeaker))
						.frame(width: Constant.paddingButtonNext, height: Constant.paddingButtonNext)
					speakerIcon
						.foregroundColor(foregroundButtonSpeaker)
				}
			}
			.frame(maxWidth: .infinity)
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
	}

	var buttonCancel: some View {
		VStack {
			Button {
				timeCalled = 0
			} label: {
				ZStack {
					Circle()
						.strokeBorder(backgroundEndCall, lineWidth: Constant.borderLineWidth)
						.background(Circle().foregroundColor(backgroundEndCall))
						.frame(width: Constant.paddingButtonNext, height: Constant.paddingButtonNext)
					AppTheme.shared.imageSet.phoneOffIcon
						.foregroundColor(AppTheme.shared.colorSet.offWhite)
				}
		}
			Text("Call.Cancel".localized)
				.font(AppTheme.shared.fontSet.font(style: .body2))
				.foregroundColor(AppTheme.shared.colorSet.offWhite)
		}
	}
}

// MARK: - Color func
private extension VoiceCall {
	var foregroundBackButton: Color {
		colorScheme == .light ? AppTheme.shared.colorSet.offWhite : AppTheme.shared.colorSet.greyLight
	}

	var backgroundGradientPrimary: LinearGradient {
		LinearGradient(gradient: Gradient(colors: AppTheme.shared.colorSet.gradientPrimary), startPoint: .leading, endPoint: .trailing)
	}

	var backgroundEndCall: Color {
		AppTheme.shared.colorSet.errorDefault
	}

	var backgroundButtonMute: Color {
		isTappedMute == true ? AppTheme.shared.colorSet.offWhite : AppTheme.shared.colorSet.offWhite.opacity(0)
	}

	var foregroundButtonMute: Color {
		isTappedMute == true ? AppTheme.shared.colorSet.black : AppTheme.shared.colorSet.offWhite
	}

	var backgroundButtonCamera: Color {
		isTappedCamera == true ? AppTheme.shared.colorSet.offWhite : AppTheme.shared.colorSet.offWhite.opacity(0)
	}

	var foregroundButtonCamera: Color {
		isTappedCamera == true ? AppTheme.shared.colorSet.black : AppTheme.shared.colorSet.offWhite
	}

	var backgroundButtonSpeaker: Color {
		isTappedSpeaker == true ? AppTheme.shared.colorSet.offWhite : AppTheme.shared.colorSet.offWhite.opacity(0)
	}

	var foregroundButtonSpeaker: Color {
		isTappedSpeaker == true ? AppTheme.shared.colorSet.black : AppTheme.shared.colorSet.offWhite
	}

	var muteIcon: Image {
		isTappedMute ? AppTheme.shared.imageSet.microphoneOffIcon : AppTheme.shared.imageSet.microPhoneIcon
	}

	var cameraIcon: Image {
		isTappedCamera ? AppTheme.shared.imageSet.videoOffIcon : AppTheme.shared.imageSet.videoIcon
	}

	var speakerIcon: Image {
		isTappedSpeaker ? AppTheme.shared.imageSet.speakerOffIcon : AppTheme.shared.imageSet.speakerIcon
	}
}

// MARK: - Private Func
private extension VoiceCall {
	func customBack() {
		self.presentationMode.wrappedValue.dismiss()
	}

	func getTimer() -> String {
		let minutes = Int(timeCalled) / 60 % 60
		let seconds = Int(timeCalled) % 60
		return String(format: "%02i:%02i", minutes, seconds)
	}
}

struct VoiceCall_Previews: PreviewProvider {
	static var previews: some View {
		VoiceCall()
	}
}
