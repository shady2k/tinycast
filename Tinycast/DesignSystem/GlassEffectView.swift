import SwiftUI

/// Native Liquid Glass backdrop for Tinycast's borderless panels.
struct GlassEffectView: NSViewRepresentable {
    func makeNSView(context: Context) -> NSView {
        if #available(macOS 26, *) { return NSGlassEffectView() }
        let view = NSVisualEffectView()
        view.material = .hudWindow
        view.blendingMode = .behindWindow
        view.state = .active
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {}
}

// Local Sequoia build: Liquid Glass on macOS 26, the closest material on macOS 15.
extension View {
    @ViewBuilder
    func compatGlass(clearInteractive: Bool = false, in shape: some Shape) -> some View {
        if #available(macOS 26, *) {
            glassEffect(clearInteractive ? .clear.interactive() : .regular, in: shape)
        } else {
            background(clearInteractive ? .ultraThinMaterial : .regularMaterial, in: shape)
        }
    }

    @ViewBuilder
    func compatGlassButtonStyle() -> some View {
        if #available(macOS 26, *) {
            buttonStyle(.glass)
        } else {
            buttonStyle(.bordered)
        }
    }
}
