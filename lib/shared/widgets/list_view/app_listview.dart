import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/core/utils/check_show_dialog.dart';
import 'package:shopping_list/features/shopping/provider/shopping_provider.dart';
import 'package:shopping_list/shared/widgets/list_view/app_listview_card.dart';
import 'package:shopping_list/shared/widgets/app_total_estimated_price_widget.dart';

class AppListview extends StatefulWidget {
  const AppListview({super.key});
  @override
  State<AppListview> createState() => _AppListviewState();
}

class _AppListviewState extends State<AppListview> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingProvider>(
      builder: (context, provider, child) => Column(
        children: [
          provider.search.isEmpty
              ? Center(child: Text("Bir Kayıt Bulunamadı"))
              : Expanded(
                  flex: 4,
                  child: ListView.builder(
                    itemCount: provider.search.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                        background: Container(
                          color: Colors.green,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          child: const Icon(Icons.edit, color: Colors.white),
                        ),
                        secondaryBackground: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        confirmDismiss: (direction) async {
                          if (direction == DismissDirection.startToEnd) {
                            context.push(
                              '/form',
                              extra: provider.search[index],
                            );
                            return false;
                          } else {
                            return checkShowDialog(context);
                          }
                        },
                        onDismissed: (direction) {
                          context.read<ShoppingProvider>().removeItem(
                            provider.search[index],
                          );
                        },
                        key: ValueKey(provider.search[index].id),
                        child: AppListviewCard(index: index),
                      );
                    },
                  ),
                ),
          Spacer(),
          TotalEstimatedPriceWidget(),
        ],
      ),
    );
  }
}
