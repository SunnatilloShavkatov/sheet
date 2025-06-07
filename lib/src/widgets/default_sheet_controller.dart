import 'package:flutter/material.dart';
import 'package:sheet/sheet.dart';

typedef SheetControllerCallback = void Function(SheetController controller);

class DefaultSheetController extends StatefulWidget {
  const DefaultSheetController({super.key, required this.child, this.onCreated});

  final Widget child;

  /// A callback called when the controller is created
  final SheetControllerCallback? onCreated;

  static SheetController? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_InheritedSheetController>()?.controller;

  @override
  State<DefaultSheetController> createState() => _DefaultSheetControllerState();
}

class _DefaultSheetControllerState extends State<DefaultSheetController> {
  late final SheetController controller = SheetController();

  @override
  void initState() {
    widget.onCreated?.call(controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => _InheritedSheetController(controller: controller, child: widget.child);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class _InheritedSheetController extends InheritedWidget {
  const _InheritedSheetController({required super.child, required this.controller});

  final SheetController controller;

  @override
  bool updateShouldNotify(_InheritedSheetController oldWidget) => false;
}
