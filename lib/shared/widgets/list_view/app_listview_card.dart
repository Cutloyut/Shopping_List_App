import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/core/utils/number_extentions.dart';
import 'package:shopping_list/features/shopping/provider/shopping_provider.dart';
import 'package:shopping_list/shared/widgets/item_documnets_texts.dart';

class AppListviewCard extends StatelessWidget {
  const AppListviewCard({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShoppingProvider>(context);
    return Card(
      shape: cardBorder(),
      margin: EdgeInsets.all(7),
      child: DefaultTextStyle(
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
          overflow: TextOverflow.ellipsis,
        ),
        maxLines: 1,
        child: Column(
          children: [
            ItemDocumentTexts(index: index),
            GestureDetector(
              onTap: () => context.read<ShoppingProvider>().stateregen(index),
              child: DefaultTextStyle(
                style: TextStyle(color: Colors.black),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: provider.search[index].state
                        ? const Color.fromARGB(255, 39, 73, 89)
                        : const Color.fromARGB(255, 254, 165, 165),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text("Tahmini Fiyat:"), Text("Durum:")],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                provider.search[index].estimatedPrice
                                    .organizedNumber(),
                              ),
                              Row(
                                children: [
                                  Text(
                                    provider.search[index].state
                                        ? "Alındı"
                                        : "Beklemede",
                                  ),
                                  Icon(
                                    provider.search[index].state
                                        ? Icons.check
                                        : Icons.pause,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

RoundedRectangleBorder cardBorder() {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(4),
    side: BorderSide(color: Colors.black, width: 1.3),
  );
}
