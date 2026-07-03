import 'package:flutter/foundation.dart';
import 'package:shopping_list/core/services/storage_services.dart';
import 'package:shopping_list/features/shopping/models/shopping_item_model.dart';

class ShoppingProvider with ChangeNotifier {
  List<ShoppingItemModel> _items = [];
  List<ShoppingItemModel> get items => _items;
  List<String> categoris = [];

  Future<void> addItem(ShoppingItemModel itemModel) async {
    _items.add(itemModel);
    categoris.add(itemModel.category);
    categoris = categoris.toSet().toList();
    await StorageServices().saveItem(_items);
    notifyListeners();
  }

  Future<void> editItem(ShoppingItemModel item) async {
    int index = _items.indexWhere((e) => e.id == item.id);
    if (index != -1) {
      _items[index] = item;
      categoris.add(item.category);
      categoris = categoris.toSet().toList();
      await StorageServices().saveItem(_items);
      notifyListeners();
    }
  }

  Future<void> savedlistRead() async {
    _items = await StorageServices().loadItem();
    notifyListeners();
  }

  Future<void> removeItem(ShoppingItemModel itemModel) async {
    _items.remove(itemModel);
    await StorageServices().saveItem(_items);
    notifyListeners();
  }

  Future<void> stateregen(int index) async {
    _items[index].state = !_items[index].state;
    await StorageServices().saveItem(_items);
    notifyListeners();
  }

  String _searchText = "";
  String _searcategory = "";

  void setSearch(String value) {
    _searchText = value;
    notifyListeners();
  }

  void setCategorySearch(String value) {
    _searcategory = value;
    notifyListeners();
  }

  bool? state;
  void stateflitre(bool? value) {
    state = value;
    notifyListeners();
  }

  List<ShoppingItemModel> get search {
    return _items.where((element) {
      if (state == null) {
        return element.category.toLowerCase().contains(
              _searcategory.toLowerCase(),
            ) &&
            element.name.toLowerCase().contains(_searchText.toLowerCase());
      } else if (state == true) {
        return element.state &&
            element.category.toLowerCase().contains(
              _searcategory.toLowerCase(),
            ) &&
            element.name.toLowerCase().contains(_searchText.toLowerCase());
      } else {
        return !element.state &&
            element.category.toLowerCase().contains(
              _searcategory.toLowerCase(),
            ) &&
            element.name.toLowerCase().contains(_searchText.toLowerCase());
      }
    }).toList();
  }

  double totalEstimatedPrice(List<ShoppingItemModel> items) {
    double toplam = 0;
    for (int i = 0; i < items.length; i++) {
      toplam += items[i].estimatedPrice;
    }
    return toplam;
  }
}
