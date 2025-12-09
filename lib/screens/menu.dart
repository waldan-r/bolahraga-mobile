// lib/screens/menu.dart
import 'package:flutter/material.dart';
import 'package:bolahraga/widgets/left_drawer.dart';
import 'package:bolahraga/screens/product_form.dart';
import 'package:bolahraga/screens/list_product.dart';
import 'package:bolahraga/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
    const MyHomePage({super.key});

    final List<ShopItem> items = const [
        ShopItem("All Products", Icons.checklist, Colors.blue), // Biru
        ShopItem("My Products", Icons.person, Colors.green),    // Hijau
        ShopItem("Create Product", Icons.add_box, Colors.red),  // Merah
    ];

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text(
                    'Football Shop',
                    style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.indigo,
                actions: [
                  // Tombol Logout di pojok kanan atas biar rapi
                  IconButton(
                    icon: const Icon(Icons.logout, color: Colors.white,),
                    onPressed: () async {
                      final request = context.read<CookieRequest>();
                      // GANTI URL: endpoint logout django
                      final response = await request.logout("http://10.0.2.2:8000/auth/logout/");
                      String message = response["message"];
                      if (context.mounted) {
                          if (response['status']) {
                              String uname = response["username"];
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("$message Sampai jumpa, $uname."),
                              ));
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const LoginPage()),
                              );
                          } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(message),
                              ));
                          }
                      }
                    },
                  )
                ],
            ),
            drawer: const LeftDrawer(),
            body: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        children: <Widget>[
                            const Padding(
                                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text(
                                    'Welcome to Football Shop',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                    ),
                                ),
                            ),
                            GridView.count(
                                primary: false,
                                padding: const EdgeInsets.all(20),
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                crossAxisCount: 3,
                                shrinkWrap: true,
                                children: items.map((ShopItem item) {
                                    return ShopCard(item);
                                }).toList(),
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}

class ShopItem {
    final String name;
    final IconData icon;
    final Color color;

    const ShopItem(this.name, this.icon, this.color);
}

class ShopCard extends StatelessWidget {
    final ShopItem item;

    const ShopCard(this.item, {super.key});

    @override
    Widget build(BuildContext context) {
        final request = context.watch<CookieRequest>();
        return Material(
            color: item.color, // Mengambil warna dari item (Biru, Hijau, Merah)
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
                onTap: () {
                    // 1. Munculkan Snackbar (Sesuai Task 7)
                    ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                            content: Text("Kamu telah menekan tombol ${item.name}!"),
                        ));

                    // 2. Navigasi
                    if (item.name == "Create Product") {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const ProductFormPage()));
                    } else if (item.name == "All Products" || item.name == "My Products") {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const ProductPage()));
                    }
                },
                child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Icon(
                                    item.icon,
                                    color: Colors.white,
                                    size: 30.0,
                                ),
                                const Padding(padding: EdgeInsets.all(3)),
                                Text(
                                    item.name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.white),
                                ),
                            ],
                        ),
                    ),
                ),
            ),
        );
    }
}