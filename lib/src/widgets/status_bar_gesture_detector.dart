// ignore_for_file: discarded_futures

import 'package:flutter/material.dart';

typedef StatusBarGestureDetectorCallback = void Function(BuildContext context);

class StatusBarGestureDetector extends StatefulWidget {
  const StatusBarGestureDetector({super.key, required this.child, required this.onTap});

  const StatusBarGestureDetector.scrollToTop({super.key, required this.child}) : onTap = _scrollToTopBarTap;

  static void _scrollToTopBarTap(BuildContext context) {
    final controller = PrimaryScrollController.maybeOf(context);
    if (controller != null && controller.hasClients) {
      controller.animateTo(0, duration: const Duration(milliseconds: 1000), curve: Curves.easeOutCirc);
    }
  }

  final Widget child;

  final StatusBarGestureDetectorCallback onTap;

  @override
  State<StatusBarGestureDetector> createState() => _StatusBarGestureDetectorState();
}

class _StatusBarGestureDetectorState extends State<StatusBarGestureDetector> {
  final OverlayPortalController controller = OverlayPortalController();

  @override
  void initState() {
    controller.show();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final view = View.of(context);
    return OverlayPortal.targetsRootOverlay(
      controller: controller,
      overlayChildBuilder:
          (context) => Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: view.padding.top / view.devicePixelRatio,
              width: double.infinity,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => widget.onTap(context),
                excludeFromSemantics: true,
              ),
            ),
          ),
      child: widget.child,
    );
  }
}
