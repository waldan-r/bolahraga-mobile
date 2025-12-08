import 'package:flutter/material.dart';
import 'package:bolahraga/models/product_entry.dart'; // Ganti dari news_entry.dart

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

// Fungsi helper untuk mendapatkan label kategori
  String getCategoryLabel(String categoryKey) {
    switch (categoryKey) {
      case 'field_setup': return 'Field Setup';
      case 'training_equipment': return 'Training Equipment';
      case 'match_equipment': return 'Match Equipment';
      case 'safety_recovery': return 'Safety & Recovery';
      case 'event_accessories': return 'Event Accessories';
      case 'player_gear': return 'Player Gear';
      default: return categoryKey;
    }
  }

  Widget _buildDetailRow(String label, String value, {bool isFeatured = false, Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: isFeatured ? FontWeight.bold : FontWeight.normal,
                color: valueColor ?? (isFeatured ? Colors.amber.shade700 : Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color stockColor = product.stock > 10 ? Colors.green.shade600 : 
                      product.stock > 0 ? Colors.orange.shade700 : 
                      Colors.red.shade600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.thumbnail != null && product.thumbnail!.isNotEmpty)
              Image.network(
                'https://waldan-rafid-bolahraga.pbp.cs.ui.ac.id//proxy-image/?url=${Uri.encodeComponent(product.thumbnail!)}', 
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 250,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.image_not_supported, size: 50),
                  ),
                ),
              ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(height: 32),

                  _buildDetailRow('Product ID', product.id),
                  _buildDetailRow('Price', 'Rp ${product.price.toString()}', valueColor: Colors.green.shade700),
                  _buildDetailRow('Stock', product.stock.toString(), valueColor: stockColor),
                  _buildDetailRow('Category', getCategoryLabel(product.category)),
                  _buildDetailRow('Featured', product.isFeatured ? 'Ya' : 'Tidak', isFeatured: product.isFeatured),
                  if (product.userId != null)
                    _buildDetailRow('User ID', product.userId.toString()),
                  
                  const Divider(height: 32),

                  const Text(
                    'Deskripsi Produk:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 16.0,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 24),
                  
                  // Tombol Kembali
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Kembali ke halaman sebelumnya
                        Navigator.pop(context); 
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Kembali ke Daftar Produk',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}