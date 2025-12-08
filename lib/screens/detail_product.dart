// lib/screens/detail_product.dart
import 'package:flutter/material.dart';
import 'package:bolahraga/models/product.dart';

class DetailProductPage extends StatelessWidget {
  final Product product;

  const DetailProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Tombol kembali
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kalau thumbnail berupa URL gambar
            // Image.network(product.fields.thumbnail), 
            Text(
              product.fields.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text("Category: ${product.fields.category}"),
            Text("Price: Rp ${product.fields.price}"),
            Text("Featured: ${product.fields.isFeatured ? 'Yes' : 'No'}"),
            const SizedBox(height: 20),
            const Text(
              "Description:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(product.fields.description),
            
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                    Navigator.pop(context);
                },
                child: const Text("Kembali ke Daftar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}