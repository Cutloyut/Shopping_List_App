import 'package:flutter/material.dart';

Future<void> scaffoldMesage(BuildContext context, String mesaj) async {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Center(child: Text(mesaj))));
}
