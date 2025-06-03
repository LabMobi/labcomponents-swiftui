//
//  LabIndeterminateCircularIndicator.swift
//  LabComponents
//
//  Created by Ugis Ozols on 03/06/2025.
//

import SwiftUI

public struct LabIndeterminateCircularIndicator: View {

    public var color: Color
    public var contentDescription: String

    /// Initialize the indicator.
    /// - Parameters:
    ///   - color: The tint color (defaults to `.accentColor`).
    ///   - contentDescription: The `accessibilityLabel` (defaults to “Loading, please wait”).
    public init(
        color: Color = LabIndeterminateCircularIndicatorDefaults.defaultIndeterminateProgressColor(),
        contentDescription: String = NSLocalizedString("Loading, please wait", comment: "")
    ) {
        self.color = color
        self.contentDescription = contentDescription
    }

    @State private var currentIndex: Int = 0
    private let rotationPositions: [Double] = (0..<12).map { Double($0) * 30.0 }
    private let timer = Timer.publish(every: 1.0 / 12.0, on: .main, in: .common).autoconnect()

    public var body: some View {
        Image("ic_progress_default", bundle: .module)
            .renderingMode(.template)
            .rotationEffect(.degrees(rotationPositions[currentIndex]))
            .foregroundColor(color)
            .accessibilityLabel(Text(contentDescription))
            .onReceive(timer) { _ in
                currentIndex = (currentIndex + 1) % rotationPositions.count
            }
    }
}

/// Default provider for the indicator’s tint color.
public enum LabIndeterminateCircularIndicatorDefaults {
    /// By default, use the app’s accent color.
    public static func defaultIndeterminateProgressColor() -> Color {
        .accentColor
    }
}

struct LabIndeterminateCircularIndicator_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            LabIndeterminateCircularIndicator()
                .scaleEffect(1.5)
                .frame(width: 80, height: 80)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
