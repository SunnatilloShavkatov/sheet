import 'package:flutter/material.dart';
import 'package:sheet/route.dart';
import 'package:sheet/sheet.dart';

class FloatingModal extends StatelessWidget {
  const FloatingModal({super.key, required this.child, this.backgroundColor});

  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) => DisplayFeatureSubScreen(
    anchorPoint: Offset.infinite,
    child: SafeArea(
      minimum: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Material(
        color: backgroundColor,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(12),
        child: child,
      ),
    ),
  );
}

class FloatingSheetRoute<T> extends SheetRoute<T> {
  FloatingSheetRoute({required WidgetBuilder builder})
    : super(builder: (BuildContext context) => FloatingModal(child: Builder(builder: builder)), fit: SheetFit.loose);
}
