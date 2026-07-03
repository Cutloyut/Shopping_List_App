import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/features/shopping/provider/shopping_provider.dart';

class ItemDocumentTexts extends StatelessWidget {
  const ItemDocumentTexts({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShoppingProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          IteminfoText(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(provider.search[index].name),
                Text(provider.search[index].count.toString()),
                Text(provider.search[index].unit),
                Text(provider.search[index].category),
                Text(
                  DateFormat(
                    'dd.MM.yyyy',
                  ).format(provider.search[index].dateadd),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IteminfoText extends StatelessWidget {
  const IteminfoText({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Ürün Adı:"),
          Text("Adet:"),
          Text("Birim:"),
          Text("Kategori:"),
          Text("Eklenme Tarihi:"),
        ],
      ),
    );
  }
}
