// lib/screens/list_product.dart
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:bolahraga/models/product.dart';
import 'package:bolahraga/screens/detail_product.dart'; // Kita buat abis ini
import 'package:bolahraga/screens/login.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Future<List<Product>> fetchProduct(CookieRequest request) async {
    // Ganti URL sesuai endpoint JSON lu
    // PENTING: Pake endpoint yg lu edit di BAGIAN 1 tadi
    var response = await request.get(
      'http://10.0.2.2:8000/json/', 
    );

    var data = response;
    
    // Konversi JSON ke object Product
    List<Product> listProduct = [];
    for (var d in data) {
      if (d != null) {
        listProduct.add(Product.fromJson(d));
      }
    }
    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
        actions: [
            IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                    // Endpoint logout
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
            ),
        ],
      ),
      body: FutureBuilder(
        future: fetchProduct(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text("Belum ada data produk."),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: InkWell(
                    onTap: () {
                        // Navigasi ke Detail Page
                        Navigator.push(context, 
                            MaterialPageRoute(builder: (context) => DetailProductPage(product: snapshot.data![index]))
                        );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${snapshot.data![index].fields.name}",
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text("Rp ${snapshot.data![index].fields.price}"),
                          const SizedBox(height: 10),
                          Text("${snapshot.data![index].fields.description}"),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}