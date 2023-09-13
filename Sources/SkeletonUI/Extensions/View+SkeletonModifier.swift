import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension View {
    func skeleton(with loading: Bool,
                  width: CGFloat? = nil,
                  height: CGFloat? = nil,
                  transition: (type: AnyTransition, animation: Animation?) = (.opacity, .default),
                  animation: AnimationType = .linear(),
                  appearance: AppearanceType = .gradient(),
                  shape: ShapeType = .capsule,
                  lines: Int = 1,
                  scales: [Int: CGFloat]? = .none,
                  spacing: CGFloat? = .none,
                  padding: EdgeInsets? = nil) -> some View {
        ZStack {
            if loading {
                VStack(spacing: spacing) {
                    ForEach(.zero ..< lines, id: \.self) { line in
                        GeometryReader { geometry in
                            modifier(SkeletonModifier(shape: shape, animation: animation, appearance: appearance))
                                .frame(width: (scales?[line] ?? 1) * geometry.size.width, height: geometry.size.height)
                        }
                    }
                }
                .frame(width: width, height: height)
                .transition(transition.type)
                .padding(.top, padding?.top ?? 0)
                .padding(.bottom, padding?.bottom ?? 0)
                .padding(.leading, padding?.leading ?? 0)
                .padding(.trailing, padding?.trailing ?? 0)
            } else {
                self
                    .transition(transition.type)
            }
        }
        .animation(transition.animation, value: loading)
    }
}
