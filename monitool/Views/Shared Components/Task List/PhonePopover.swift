//
//  PhonePopover.swift
//  monitool
//
//  Created by Christianto Budisaputra on 19/08/21.
//

import SwiftUI

struct PhonePopover<Content: View, PopoverContent: View>: View {
    @Binding var showPopover: Bool
    var popoverSize: CGSize?
    var arrowDirections: UIPopoverArrowDirection = [.down]
    let content: () -> Content
    let popoverContent: () -> PopoverContent

    var body: some View {
        content()
            .background(
                Wrapper(
                    showPopover: $showPopover,
                    arrowDirections: arrowDirections,
                    popoverSize: popoverSize,
                    popoverContent: popoverContent
                ).frame(maxWidth: .infinity, maxHeight: .infinity)
            )
    }

    struct Wrapper<PopoverContent: View>: UIViewControllerRepresentable {
        @Binding var showPopover: Bool
        var arrowDirections: UIPopoverArrowDirection
        let popoverSize: CGSize?
        let popoverContent: () -> PopoverContent

        func makeUIViewController(context _: UIViewControllerRepresentableContext<Wrapper<PopoverContent>>) -> WrapperViewController<PopoverContent> {
            return WrapperViewController(
                popoverSize: popoverSize,
                permittedArrowDirections: arrowDirections,
                popoverContent: popoverContent
            ) {
                self.showPopover = false
            }
        }

        func updateUIViewController(
            _ uiViewController: WrapperViewController<PopoverContent>,
            context _: UIViewControllerRepresentableContext<Wrapper<PopoverContent>>
        ) {
            uiViewController.updateSize(popoverSize)

            if showPopover {
                uiViewController.showPopover()
            } else {
                uiViewController.hidePopover()
            }
        }
    }

    class WrapperViewController<PopoverContent: View>: UIViewController, UIPopoverPresentationControllerDelegate {
        var popoverSize: CGSize?
        let permittedArrowDirections: UIPopoverArrowDirection
        let popoverContent: () -> PopoverContent
        let onDismiss: () -> Void

        var popoverVC: UIViewController?

        @available(*, unavailable)
        required init?(coder _: NSCoder) { fatalError("") }

        init(
            popoverSize: CGSize?,
            permittedArrowDirections: UIPopoverArrowDirection,
            popoverContent: @escaping () -> PopoverContent,
            onDismiss: @escaping () -> Void
        ) {
            self.popoverSize = popoverSize
            self.permittedArrowDirections = permittedArrowDirections
            self.popoverContent = popoverContent
            self.onDismiss = onDismiss
            super.init(nibName: nil, bundle: nil)
        }

        override func viewDidLoad() {
            super.viewDidLoad()
        }

        func adaptivePresentationStyle(for _: UIPresentationController) -> UIModalPresentationStyle {
            return .none // this is what forces popovers on iPhone
        }

        func showPopover() {
            guard popoverVC == nil else { return }
            let vc = UIHostingController(rootView: popoverContent())
            if let size = popoverSize { vc.preferredContentSize = size }
            vc.modalPresentationStyle = UIModalPresentationStyle.popover
            if let popover = vc.popoverPresentationController {
                popover.sourceView = view
                popover.permittedArrowDirections = permittedArrowDirections
                popover.delegate = self
            }
            popoverVC = vc
            present(vc, animated: true, completion: nil)
        }

        func hidePopover() {
            guard let vc = popoverVC, !vc.isBeingDismissed else { return }
            vc.dismiss(animated: true, completion: nil)
            popoverVC = nil
        }

        func presentationControllerWillDismiss(_: UIPresentationController) {
            popoverVC = nil
            onDismiss()
        }

        func updateSize(_ size: CGSize?) {
            popoverSize = size
            if let vc = popoverVC, let size = size {
                vc.preferredContentSize = size
            }
        }
    }
}
