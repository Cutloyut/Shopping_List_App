import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:light_dark_theme_toggle/light_dark_theme_toggle.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/core/theme/app_theme.dart';
import 'package:shopping_list/shared/widgets/app_listview.dart';
import 'package:shopping_list/shared/widgets/app_textfield.dart';
import '../provider/shopping_provider.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  Timer? _debounce;
  static final TextEditingController categpryController = TextEditingController(
    text: "Kategori Seç",
  );

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShoppingProvider>(context);
    final themeprovider = Provider.of<AppTheme>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Listeniz"),
        actions: [
          LightDarkThemeToggle(
            value: themeprovider.isDarkMode,
            onChanged: (value) => context.read<AppTheme>().toggleTheme(),
          ),
          IconButton(
            onPressed: () => context.push('/form'),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Ürün Ara",
              border: TextfieldoutlineInputBorder.outlineInputBorder,
            ),
            onChanged: (value) {
              if (_debounce?.isActive ?? false) {
                _debounce!.cancel();
              }
              _debounce = Timer(const Duration(milliseconds: 300), () {
                context.read<ShoppingProvider>().setSearch(value);
              });
            },
          ),
          TextField(
            readOnly: true,
            controller: categpryController,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.keyboard_arrow_down),
              border: TextfieldoutlineInputBorder.outlineInputBorder,
            ),
            onTap: () {
              showCategoryBottomSheet(context, categpryController);
            },
          ),
          Row(
            children: [
              FilterChip(
                label: const Text("Alındı"),
                selected: provider.state == true,
                onSelected: (_) {
                  provider.stateflitre(provider.state == true ? null : true);
                },
              ),
              const SizedBox(width: 10),
              FilterChip(
                label: const Text("Alınmadı"),
                selected: provider.state == false,
                onSelected: (_) {
                  provider.stateflitre(provider.state == false ? null : false);
                },
              ),
            ],
          ),
          Expanded(child: AppListview()),
        ],
      ),
    );
  }
}

void showCategoryBottomSheet(
  BuildContext context,
  TextEditingController categorytext,
) {
  final provider = context.read<ShoppingProvider>();

  showModalBottomSheet(
    context: context,
    builder: (_) {
      return ListView.builder(
        itemCount: provider.categoris.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(provider.categoris[index]),
            onTap: () {
              categorytext.text = provider.categoris[index];
              context.read<ShoppingProvider>().setCategorySearch(
                provider.categoris[index],
              );
              Navigator.pop(context);
            },
          );
        },
      );
    },
  );
}
