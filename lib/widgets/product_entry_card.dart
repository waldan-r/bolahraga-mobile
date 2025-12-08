import 'package:flutter/material.dart';
import 'package:bolahraga/models/product_entry.dart';

class ProductCardItem extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCardItem({
    super.key,
    required this.product,
    required this.onTap,
  });

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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: InkWell(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thumbnail
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: product.thumbnail != null && product.thumbnail!.isNotEmpty
                      ? Image.network(
                          'http://pbp.cs.ui.ac.id/waldan.rafid/bolahraga/proxy-image/?url=${Uri.encodeComponent(product.thumbnail!)}', // TODO: Ganti URL base
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: 150,
                            color: Colors.grey[300],
                            child: const Center(child: Icon(Icons.image_not_supported)),
                          ),
                        )
                      : Container(
                          height: 150,
                          color: Colors.grey[300],
                          child: const Center(child: Icon(Icons.image)),
                        ),
                ),
                const SizedBox(height: 8),

                // Nama Produk
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),

                // Harga
                Text(
                  'Harga: Rp ${product.price.toString()}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),

                // Kategori
                Text('Kategori: ${getCategoryLabel(product.category)}'),
                const SizedBox(height: 6),

                // Deskripsi preview
                Text(
                  product.description.length > 100
                      ? '${product.description.substring(0, 100)}...'
                      : product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 6),

                // Featured indicator
                if (product.isFeatured)
                  const Text(
                    'PRODUK UNGGULAN',
                    style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                const SizedBox(height: 6),
                
                // Stock indicator
                Text(
                  'Stok: ${product.stock}',
                  style: TextStyle(
                    color: product.stock > 0 ? Colors.blue : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}