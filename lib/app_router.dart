import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_list/features/shopping/models/shopping_item_model.dart';
import 'package:shopping_list/features/shopping/screens/shopping_form_screen.dart';
import 'package:shopping_list/features/shopping/screens/shopping_list_screen.dart';
import 'package:shopping_list/features/shopping/screens/shopping_loading_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text("Sayfa Bulunamadı"))),
    routes: [
      GoRoute(
        path: '/',
        name: 'loading',
        builder: (context, state) => LoadingScreen(),
      ),
      GoRoute(
        path: '/list',
        name: 'list',
        builder: (context, state) => ShoppingListScreen(),
      ),
      GoRoute(
        path: '/form',
        name: 'form',
        builder: (context, state) {
          final ShoppingItemModel? item = state.extra as ShoppingItemModel?;
          return ShoppingFormScreen(itemModel: item);
        },
      ),
    ],
  );
}
