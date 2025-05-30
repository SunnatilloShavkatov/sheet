import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:sheet/sheet.dart';
import 'package:sheet/src/sheet.dart';

/// A widget that add a min interaction zone where hitTestSelf is true
/// This is rarely used by its own
///
/// See also:
///
///  * [Sheet], that uses this widget that enables to drag closed/hidden
/// sheets
class MinInteractionZone extends SingleChildRenderObjectWidget {
  const MinInteractionZone({super.key, required this.direction, required this.extent, super.child});

  final AxisDirection direction;

  final double extent;

  @override
  MinInteractionPaddingRenderBox createRenderObject(BuildContext context) =>
      MinInteractionPaddingRenderBox(direction, extent);

  @override
  void updateRenderObject(BuildContext context, MinInteractionPaddingRenderBox renderObject) {
    renderObject
      ..direction = direction
      ..extent = extent;
  }
}

class MinInteractionPaddingRenderBox extends RenderProxyBox {
  MinInteractionPaddingRenderBox(AxisDirection direction, double extent) : _direction = direction, _extent = extent;

  AxisDirection _direction;

  AxisDirection get direction => _direction;

  set direction(AxisDirection value) {
    if (value == _direction) {
      return;
    }
    _direction = value;
  }

  double _extent;

  double get extent => _extent;

  set extent(double value) {
    if (value == _extent) {
      return;
    }
    _extent = value;
  }

  @override
  bool hitTestSelf(Offset position) {
    Rect minInteractionZone;
    switch (direction) {
      case AxisDirection.up:
        minInteractionZone = Rect.fromLTRB(0, size.height - extent, size.width, size.height);
      case AxisDirection.down:
        minInteractionZone = Rect.fromLTRB(0, 0, size.width, extent);
      case AxisDirection.right:
        minInteractionZone = Rect.fromLTRB(0, 0, extent, size.height);
      case AxisDirection.left:
        minInteractionZone = Rect.fromLTRB(size.width - extent, 0, size.width, size.height);
    }
    return minInteractionZone.contains(position);
  }
}
