import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/app_router.dart';
import 'package:shopping_list/core/theme/app_theme.dart';
import 'package:shopping_list/features/shopping/provider/shopping_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppTheme()),
        ChangeNotifierProvider(create: (context) => ShoppingProvider()),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final thmeprovider = context.watch<AppTheme>();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: thmeprovider.themeMode,
      routerConfig: AppRouter.router,
    );
  }
}
