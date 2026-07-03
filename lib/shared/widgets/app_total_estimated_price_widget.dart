import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/core/utils/number_extentions.dart';
import 'package:shopping_list/features/shopping/provider/shopping_provider.dart';

class TotalEstimatedPriceWidget extends StatelessWidget {
  const TotalEstimatedPriceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShoppingProvider>(context);
    return Card(
      color: const Color.fromARGB(255, 151, 149, 247),
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(4)),
      margin: EdgeInsets.all(7),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: DefaultTextStyle(
          style: TextStyle(color: Colors.black),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Toplam Ürün:"), Text("Tahmini Fiyat:")],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(provider.search.length.toString()),
                    Text(
                      provider
                          .totalEstimatedPrice(provider.search)
                          .organizedNumber(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
