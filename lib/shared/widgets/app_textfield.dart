import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/core/utils/scaffold_msg.dart';
import 'package:shopping_list/features/shopping/models/shopping_item_model.dart';
import 'package:shopping_list/features/shopping/provider/shopping_provider.dart';

class AppTextfield extends StatefulWidget {
  const AppTextfield({super.key, this.item});
  final ShoppingItemModel? item;
  @override
  State<AppTextfield> createState() => _AppTextfieldState();
}

class _AppTextfieldState extends State<AppTextfield> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController countController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController? priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      nameController.text = widget.item!.name;
      countController.text = widget.item!.count.toString();
      categoryController.text = widget.item!.category == "Belirtilmemiş"
          ? ""
          : widget.item!.category;
      priceController?.text = widget.item!.estimatedPrice.toString();
      unitController.text = widget.item!.unit == "Belirtilmemiş"
          ? ""
          : widget.item!.unit;
    }
  }

  @override
  void dispose() {
    super.dispose();
    categoryController.dispose();
    nameController.dispose();
    unitController.dispose();
    priceController?.dispose();
    countController.dispose();
  }

  void _saveShoppingItem(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      scaffoldMesage(context, "* Lütfen İşaretli Alanları Doldurunuz");
      return;
    }

    final name = nameController.text.trim();
    final category = categoryController.text.trim().isEmpty
        ? "Belirtilmemiş"
        : categoryController.text.trim();
    final unit = unitController.text.trim().isEmpty
        ? "Belirtilmemiş"
        : unitController.text.trim();
    final count = double.tryParse(countController.text) ?? 0.0;
    final price = double.tryParse(priceController?.text ?? "") ?? 0.0;
    if (widget.item == null) {
      context.read<ShoppingProvider>().addItem(
        ShoppingItemModel(
          id: DateTime.now().millisecondsSinceEpoch,
          name: name,
          count: count,
          category: category,
          estimatedPrice: price,
          unit: unit,
          state: false,
          dateadd: DateTime.now(),
        ),
      );
      scaffoldMesage(context, "Ürün Eklendi");
    } else {
      context.read<ShoppingProvider>().editItem(
        ShoppingItemModel(
          id: widget.item!.id,
          name: name,
          count: count,
          category: category,
          estimatedPrice: price,
          unit: unit,
          state: false,
          dateadd: DateTime.now(),
        ),
      );
      scaffoldMesage(context, "Ürün Güncellendi");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          spacing: 4,
          children: [
            TextFormField(
              controller: nameController,
              validator: appvalidator,
              decoration: appInputDecorations("Ürün Adı"),
            ),
            TextFormField(
              controller: countController,
              validator: pozitifValueValidator,
              keyboardType: TextInputType.number,
              decoration: appInputDecorations("Adet*"),
            ),
            TextFormField(
              controller: unitController,
              decoration: appInputDecorations("Birim Örn(Adet, kg, L)"),
            ),
            TextFormField(
              controller: categoryController,
              decoration: appInputDecorations("Kategori"),
            ),
            TextFormField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: appInputDecorations("Tahmini Fiyat"),
            ),
            ElevatedButton(
              style: elevantedButtonStyle(),
              onPressed: () => _saveShoppingItem(context),
              child: Text(widget.item != null ? "Güncelle" : "Kayıt Et"),
            ),
          ],
        ),
      ),
    );
  }

  String? pozitifValueValidator(value) {
    if (value == null || value.isEmpty || double.parse(value) < 0.0) {
      return "Bu Kısım Boş Veya Negatif Olamaz";
    }
    return null;
  }

  String? appvalidator(value) {
    if (value == null || value.isEmpty) {
      return "Bu Kısım Boş Olamaz";
    }
    return null;
  }

  InputDecoration appInputDecorations(String hinttext) {
    return InputDecoration(
      hintText: hinttext,
      border: TextfieldoutlineInputBorder.outlineInputBorder,
    );
  }
}

ButtonStyle elevantedButtonStyle() {
  return ElevatedButton.styleFrom(
    side: BorderSide(color: Colors.blue, width: 1.3),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
  );
}

class TextfieldoutlineInputBorder {
  static OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 1),
  );
}
