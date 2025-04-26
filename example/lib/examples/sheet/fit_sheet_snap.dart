// ignore_for_file: discarded_futures

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sheet/sheet.dart';

class FitSnapSheet extends StatefulWidget {
  const FitSnapSheet({super.key});

  @override
  State<FitSnapSheet> createState() => _FitSheetState();
}

class _FitSheetState extends State<FitSnapSheet> {
  final SheetController controller = SheetController();

  @override
  void initState() {
    Future<void>.delayed(const Duration(milliseconds: 400), animateSheet);

    super.initState();
  }

  void animateSheet() {
    controller.relativeAnimateTo(0.2, duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Sheet(
    elevation: 4,
    physics: const SnapSheetPhysics(stops: <double>[100, 300, 500], relative: false, parent: BouncingSheetPhysics()),
    controller: controller,
    child: Container(height: 500),
  );
}
