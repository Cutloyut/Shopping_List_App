import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/features/shopping/provider/shopping_provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    await context.read<ShoppingProvider>().savedlistRead();
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    context.go('/list');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 7,
            children: [
              SizedBox(height: 25),
              Image(
                image: AssetImage("assets/shopping_loading_images.png"),
                fit: BoxFit.cover,
              ),
              Text(
                "Düzenleme/Silme İşlemleri\nİçin Sağ Veya Sola Kaydırın",
                textAlign: TextAlign.center,
              ),
              Text(
                "Ürünün Durumunu Değiştirmek\nİçin Durumun Üstüne Tıklayın",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
