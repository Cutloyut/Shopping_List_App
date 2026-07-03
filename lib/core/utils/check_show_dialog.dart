import 'package:flutter/material.dart';

Future<bool> checkShowDialog(BuildContext context) async {
  await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Sil"),
      content: Text("Bu Ürünü Silmek İstediğinizden Emin Misiniz?"),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text("İptal"),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text("Sil", style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}
