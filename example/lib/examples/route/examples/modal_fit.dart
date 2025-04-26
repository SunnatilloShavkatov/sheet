import 'package:flutter/material.dart';
import 'package:sheet/sheet.dart';

class ModalFit extends StatefulWidget {
  const ModalFit({super.key});

  @override
  State<ModalFit> createState() => _ModalFitState();
}

class _ModalFitState extends State<ModalFit> {
  bool _isSheetOpen = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _isSheetOpen = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) => SheetMediaQuery(
    child: ListView(
      shrinkWrap: true,
      children: <Widget>[
        ListTile(title: const Text('Edit'), leading: const Icon(Icons.edit), onTap: () => Navigator.of(context).pop()),
        ListTile(
          title: const Text('Copy'),
          leading: const Icon(Icons.content_copy),
          onTap: () => Navigator.of(context).pop(),
        ),
        if (_isSheetOpen) ...[
          ListTile(
            title: const Text('Cut'),
            leading: const Icon(Icons.content_cut),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: const Text('Move'),
            leading: const Icon(Icons.folder_open),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: const Text('Delete'),
            leading: const Icon(Icons.delete),
            onTap: () => Navigator.of(context).pop(),
          ),
        ],
      ],
    ),
  );
}
