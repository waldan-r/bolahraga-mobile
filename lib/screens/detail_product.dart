import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:bolahraga/models/product.dart';
import 'package:bolahraga/screens/product_form.dart'; // Import form buat navigasi edit
import 'package:bolahraga/screens/menu.dart'; 

class DetailProductPage extends StatelessWidget {
  final Product product;

  const DetailProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Thumbnail
            if (product.fields.thumbnail != null && product.fields.thumbnail!.isNotEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Image.network(
                    product.fields.thumbnail!,
                    height: 250,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, err, stack) => const Icon(Icons.broken_image, size: 100, color: Colors.grey),
                  ),
                ),
              ),

            // Judul
            Text(
              product.fields.name,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.indigo),
            ),
            const SizedBox(height: 10),

            // Info Detail
            _buildDetailRow("Kategori", product.fields.category),
            _buildDetailRow("Harga", "Rp ${product.fields.price}"),
            _buildDetailRow("Featured", product.fields.isFeatured ? "Yes" : "No"),
            
            const SizedBox(height: 20),
            const Text("Deskripsi:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(product.fields.description, style: const TextStyle(fontSize: 16)),
            
            const SizedBox(height: 40),

            // --- TOMBOL AKSI (EDIT & DELETE) ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Tombol EDIT
                ElevatedButton.icon(
                  onPressed: () {
                    // Pindah ke Form, bawa data produk ini
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductFormPage(product: product),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit, color: Colors.white),
                  label: const Text("Edit", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                ),
                
                // Tombol DELETE
                ElevatedButton.icon(
                  onPressed: () async {
                    // Konfirmasi Dialog
                    bool confirm = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Hapus Produk'),
                        content: const Text('Yakin mau menghapus produk ini?'),
                        actions: [
                          TextButton(
                            child: const Text('Batal'),
                            onPressed: () => Navigator.pop(context, false),
                          ),
                          TextButton(
                            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
                            onPressed: () => Navigator.pop(context, true),
                          ),
                        ],
                      ),
                    ) ?? false;

                    if (confirm) {
                      // Hit Endpoint Delete
                      final response = await request.postJson(
                        "https://waldan-rafid-bolahraga.pbp.cs.ui.ac.id/delete-flutter/${product.pk}/", 
                        jsonEncode({}),
                      );

                      if (context.mounted) {
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Produk berhasil dihapus.")),
                          );
                          // Balik ke Home & Refresh
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const MyHomePage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Gagal menghapus produk.")),
                          );
                        }
                      }
                    }
                  },
                  icon: const Icon(Icons.delete, color: Colors.white),
                  label: const Text("Delete", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            // Tombol Kembali
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Kembali"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100, 
            child: Text("$label", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          const Text(": ", style: TextStyle(fontSize: 16)),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}