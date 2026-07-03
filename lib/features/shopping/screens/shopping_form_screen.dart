import 'package:flutter/material.dart';
import 'package:shopping_list/features/shopping/models/shopping_item_model.dart';
import 'package:shopping_list/shared/widgets/app_textfield.dart';

class ShoppingFormScreen extends StatelessWidget {
  const ShoppingFormScreen({super.key, this.itemModel});
  final ShoppingItemModel? itemModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ürün Bilgilerini Giriniz...")),
      body: AppTextfield(item: itemModel),
    );
  }
}
