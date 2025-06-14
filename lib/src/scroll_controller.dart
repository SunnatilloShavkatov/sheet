import 'package:flutter/widgets.dart';
import 'package:sheet/sheet.dart';

class SheetPrimaryScrollController extends ScrollController {
  SheetPrimaryScrollController({
    super.initialScrollOffset,
    super.debugLabel,
    super.onAttach,
    super.onDetach,
    required this.sheetContext,
  });

  final SheetContext sheetContext;

  @override
  SheetPrimaryScrollPosition createScrollPosition(
    ScrollPhysics physics,
    ScrollContext context,
    ScrollPosition? oldPosition,
  ) => SheetPrimaryScrollPosition(
    physics: physics,
    context: context,
    oldPosition: oldPosition,
    sheetContext: sheetContext,
  );
}

class _SheetScrollActivity extends ScrollActivity {
  _SheetScrollActivity(SheetPosition super._delegate);

  @override
  bool get isScrolling => true;

  @override
  bool get shouldIgnorePointer => false;

  @override
  double get velocity => 0;
}

class SheetPrimaryScrollPosition extends ScrollPositionWithSingleContext {
  SheetPrimaryScrollPosition({
    required super.physics,
    required super.context,
    double super.initialPixels,
    super.keepScrollOffset,
    required this.sheetContext,
    super.oldPosition,
    super.debugLabel,
  });

  final SheetContext sheetContext;

  SheetPosition get sheetPosition => sheetContext.position;

  bool sheetShouldSheetAcceptUserOffset(double delta) {
    final bool canDragForward = delta >= 0 && pixels <= minScrollExtent;

    final bool canDragBackwards =
        delta < 0 && sheetPosition.pixels < sheetPosition.maxScrollExtent && pixels <= minScrollExtent;

    return sheetPosition.physics.shouldAcceptUserOffset(sheetPosition) && (canDragForward || canDragBackwards);
  }

  @override
  void applyUserOffset(double delta) {
    if (sheetPosition.preventingDrag) {
      return;
    }
    if (sheetShouldSheetAcceptUserOffset(delta)) {
      if (sheetPosition.activity is! _SheetScrollActivity) {
        sheetPosition.beginActivity(_SheetScrollActivity(sheetPosition));
      }
      final double sheetDelta = sheetPosition.physics.applyPhysicsToUserOffset(sheetPosition, delta);
      sheetPosition.applyUserOffset(sheetDelta);
      return;
    } else {
      super.applyUserOffset(delta);
      if (sheetPosition.activity is! HoldScrollActivity) {
        sheetPosition.hold(() {});
      }
    }
  }

  @override
  void goBallistic(double velocity) {
    if (sheetPosition.preventingDrag) {
      goIdle();
      return;
    }

    if (sheetPosition.hasContentDimensions) {
      if (sheetContext.initialAnimationFinished) {
        sheetPosition.goBallistic(velocity);
      } else {
        goIdle();
        return;
      }
    }

    if (velocity > 0.0 && sheetPosition.pixels >= sheetPosition.maxScrollExtent || (velocity < 0.0 && pixels > 0)) {
      super.goBallistic(velocity);
      return;
    } else if (outOfRange) {
      beginActivity(
        BallisticScrollActivity(
          this,
          ScrollSpringSimulation(
            SpringDescription.withDampingRatio(mass: 0.5, stiffness: 100, ratio: 1.1),
            pixels,
            0,
            velocity,
          ),
          context.vsync,
          true,
        ),
      );
      return;
    } else {
      goIdle();
      return;
    }
  }
}
