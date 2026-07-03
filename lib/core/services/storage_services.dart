import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_list/features/shopping/models/shopping_item_model.dart';

class StorageServices {
  Future<void> saveItem(List<ShoppingItemModel> list) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonlist = list.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList("ItemList", jsonlist);
  }

  Future<List<ShoppingItemModel>> loadItem() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? jsonlist = prefs.getStringList("ItemList");
    if (jsonlist == null) return [];

    return jsonlist
        .map((e) => ShoppingItemModel.fromJson(jsonDecode(e)))
        .toList();
  }
}
