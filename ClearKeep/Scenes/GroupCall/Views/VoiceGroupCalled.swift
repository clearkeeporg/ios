//
//  VoiceGroupCalled.swift
//  ClearKeep
//
//  Created by đông on 08/04/2022.
//

import SwiftUI
import Combine
import Common
import CommonUI

private enum Constant {
	static let sizeButtonCalled = 60.0
	static let spacer = 25.0
	static let spacerBottom = 45.0
	static let paddingVertical = 14.0
	static let sizeImage = 120.0
	static let paddingButtonNext = 90.0
	static let borderLineWidth = 2.0
	static let opacity = 0.6
}

struct VoiceGroupCalled: View {
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
			.background(background)
			.edgesIgnoringSafeArea(.all)
			.navigationBarBackButtonHidden(true)
	}
}

// MARK: - Private
private extension VoiceGroupCalled {
	var content: AnyView {
		AnyView(contentView)
	}
}

// MARK: - Loading Content
private extension VoiceGroupCalled {
	var contentView: some View {
		VStack {
			ZStack {
				backgroundGradientPrimaryTop.opacity(Constant.opacity)
					.frame(maxWidth: .infinity)
					.frame(height: Constant.paddingButtonNext)
				buttonBackView
					.padding(.top, Constant.spacerBottom)
			}
			VStack {
				Spacer()
				Spacer()
				supportCalling
					.padding(.top, Constant.spacerBottom)
				Spacer()
				buttonCancel
					.padding(.bottom, Constant.paddingButtonNext)
			}
			.padding(.horizontal, Constant.paddingVertical)
		}
		.edgesIgnoringSafeArea(.all)
	}

	var buttonBackView: some View {
		HStack {
			Button(action: customBack) {
				AppTheme.shared.imageSet.chevleftIcon
					.aspectRatio(contentMode: .fit)
					.foregroundColor(foregroundBackButton)
					.frame(alignment: .leading)
					.padding(.leading, Constant.spacer)
			}
			Text("UI Designs".localized)
				.font(AppTheme.shared.fontSet.font(style: .display3))
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding(.leading, Constant.spacer)
				.foregroundColor(AppTheme.shared.colorSet.offWhite)
			timeCalling
		}
	}

	var timeCalling: some View {
		Text(getTimer())
			.foregroundColor(AppTheme.shared.colorSet.offWhite)
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
						.frame(width: Constant.sizeButtonCalled, height: Constant.sizeButtonCalled)
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
						.frame(width: Constant.sizeButtonCalled, height: Constant.sizeButtonCalled)
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
						.frame(width: Constant.sizeButtonCalled, height: Constant.sizeButtonCalled)
					speakerIcon
						.foregroundColor(foregroundButtonSpeaker)
				}
			}
			.frame(maxWidth: .infinity)
		}
		.frame(maxWidth: .infinity)
	}

	var buttonCancel: some View {
		VStack {
			Button {
				timeCalled = 0
			} label: {
				ZStack {
					Circle()
						.strokeBorder(AppTheme.shared.colorSet.errorDefault, lineWidth: Constant.borderLineWidth)
						.background(Circle().foregroundColor(AppTheme.shared.colorSet.errorDefault))
						.frame(width: Constant.sizeButtonCalled, height: Constant.sizeButtonCalled)
					AppTheme.shared.imageSet.phoneOffIcon
						.foregroundColor(AppTheme.shared.colorSet.offWhite)
				}
			}
			Text("CallGroup.End".localized)
				.font(AppTheme.shared.fontSet.font(style: .body2))
				.foregroundColor(AppTheme.shared.colorSet.offWhite)
		}
	}
}

// MARK: - Color func
private extension VoiceGroupCalled {
	var backgroundDarkGrey2: LinearGradient {
		LinearGradient(gradient: Gradient(colors: [AppTheme.shared.colorSet.darkGrey2, AppTheme.shared.colorSet.darkGrey2]), startPoint: .leading, endPoint: .trailing)
	}

	var background: LinearGradient {
		colorScheme == .light ? backgroundGradientPrimary : backgroundDarkGrey2
	}

	var foregroundBackButton: Color {
		colorScheme == .light ? AppTheme.shared.colorSet.offWhite : AppTheme.shared.colorSet.greyLight
	}

	var backgroundGradientPrimary: LinearGradient {
		LinearGradient(gradient: Gradient(colors: AppTheme.shared.colorSet.gradientPrimary), startPoint: .leading, endPoint: .trailing)
	}

	var backgroundGradientPrimaryTop: LinearGradient {
		LinearGradient(gradient: Gradient(colors: AppTheme.shared.colorSet.gradientPrimary), startPoint: .top, endPoint: .bottom)
	}

	var backgroundButtonMute: Color {
		isTappedMute ? AppTheme.shared.colorSet.offWhite : AppTheme.shared.colorSet.offWhite.opacity(0)
	}

	var foregroundButtonMute: Color {
		isTappedMute ? AppTheme.shared.colorSet.black : AppTheme.shared.colorSet.offWhite
	}

	var backgroundButtonCamera: Color {
		isTappedCamera ? AppTheme.shared.colorSet.offWhite : AppTheme.shared.colorSet.offWhite.opacity(0)
	}

	var foregroundButtonCamera: Color {
		isTappedCamera ? AppTheme.shared.colorSet.black : AppTheme.shared.colorSet.offWhite
	}

	var backgroundButtonSpeaker: Color {
		isTappedSpeaker ? AppTheme.shared.colorSet.offWhite : AppTheme.shared.colorSet.offWhite.opacity(0)
	}

	var foregroundButtonSpeaker: Color {
		isTappedSpeaker ? AppTheme.shared.colorSet.black : AppTheme.shared.colorSet.offWhite
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
private extension VoiceGroupCalled {
	func customBack() {
		self.presentationMode.wrappedValue.dismiss()
	}

	func getTimer() -> String {
		let minutes = Int(timeCalled) / 60 % 60
		let seconds = Int(timeCalled) % 60
		return String(format: "%02i:%02i", minutes, seconds)
	}
}

struct VoiceGroupCalled_Previews: PreviewProvider {
	static var previews: some View {
		VoiceGroupCalled()
	}
}
