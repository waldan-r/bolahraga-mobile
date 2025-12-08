import 'package:flutter/material.dart';
import 'package:bolahraga/model/product_entry.dart';
import 'package:bolahraga/widgets/drawer.dart';
import 'package:bolahraga/screens/product_detail.dart'; 
import 'package:bolahraga/widgets/product_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductListPage extends StatefulWidget {
  final bool isUserProducts; // Tambah properti untuk filter

  const ProductListPage({super.key, required this.isUserProducts});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  
  Future<List<Product>> fetchProducts(CookieRequest request) async {
    // TODO: Ganti URL dengan URL aplikasi Django kamu dan jangan lupa tambahkan trailing slash (/)!
    String endpoint = 'http://pbp.cs.ui.ac.id/waldan.rafid/bolahraga/json/'; // Endpoint default untuk semua produk
    
    if (widget.isUserProducts) {
      endpoint = 'http://pbp.cs.ui.ac.id/waldan.rafid/bolahraga/json/?user_only=true'; // Contoh URL filter
    }

    final response = await request.get(endpoint);
    
    // Decode response
    var data = response;
    
    // Convert json data to Product objects (menggunakan Product.fromJson)
    List<Product> listProducts = [];
    for (var d in data) {
      if (d != null) {
        listProducts.add(Product.fromJson(d));
      }
    }

    return listProducts;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isUserProducts ? 'Daftar Produk Saya' : 'Daftar Semua Produk'), // Ganti judul
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchProducts(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            // Cek apakah ada data
            if (!snapshot.hasData || snapshot.data!.isEmpty) { 
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      widget.isUserProducts 
                        ? 'Lu belum punya produk di Bolahraga Store.' 
                        : 'Belum ada produk di Bolahraga Store.',
                      style: const TextStyle(fontSize: 20, color: Color(0xff59A5D8)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => ProductCardItem(
                  product: snapshot.data![index],
                  onTap: () {
                    // Navigasi ke halaman detail produk
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage( 
                          product: snapshot.data![index],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }
}