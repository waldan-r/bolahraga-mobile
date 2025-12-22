import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:bolahraga/screens/menu.dart';
import 'package:bolahraga/widgets/left_drawer.dart';
import 'package:bolahraga/models/product.dart';

class ProductFormPage extends StatefulWidget {
  final Product? product;

  const ProductFormPage({super.key, this.product});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Variabel input
  String _name = "";
  int _price = 0;
  String _description = "";
  String _category = "";
  String _thumbnail = "";
  bool _isFeatured = false;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _name = widget.product!.fields.name;
      _price = widget.product!.fields.price;
      _description = widget.product!.fields.description;
      _category = widget.product!.fields.category;
      _thumbnail = widget.product!.fields.thumbnail ?? "";
      _isFeatured = widget.product!.fields.isFeatured;
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    String title = widget.product == null ? "Form Tambah Produk" : "Edit Produk";

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(title)),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: _name,
                  decoration: InputDecoration(
                    hintText: "Nama Produk",
                    labelText: "Nama Produk",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                  ),
                  onChanged: (String? value) => setState(() { _name = value!; }),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) return "Nama tidak boleh kosong!";
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: widget.product != null ? _price.toString() : "", 
                  decoration: InputDecoration(
                    hintText: "Harga",
                    labelText: "Harga",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (String? value) {
                    setState(() { _price = int.tryParse(value!) ?? 0; });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) return "Harga tidak boleh kosong!";
                    if (int.tryParse(value) == null) return "Harga harus berupa angka!";
                    if (int.parse(value) < 0) return "Harga tidak boleh negatif!";
                    return null;
                  },
                ),
              ),
              // Field CATEGORY
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: _category,
                  decoration: InputDecoration(
                    hintText: "Kategori",
                    labelText: "Kategori",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                  ),
                  onChanged: (String? value) => setState(() { _category = value!; }),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) return "Kategori tidak boleh kosong!";
                    return null;
                  },
                ),
              ),
              // Field THUMBNAIL
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: _thumbnail,
                  decoration: InputDecoration(
                    hintText: "URL Gambar (Thumbnail)",
                    labelText: "Thumbnail URL",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                  ),
                  onChanged: (String? value) => setState(() { _thumbnail = value!; }),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) return "Thumbnail tidak boleh kosong!";
                    return null;
                  },
                ),
              ),
              // Field DESCRIPTION
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: _description,
                  decoration: InputDecoration(
                    hintText: "Deskripsi",
                    labelText: "Deskripsi",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                  ),
                  maxLines: 3,
                  onChanged: (String? value) => setState(() { _description = value!; }),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) return "Deskripsi tidak boleh kosong!";
                    return null;
                  },
                ),
              ),
              // Checkbox IS_FEATURED
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CheckboxListTile(
                  title: const Text("Tandai sebagai Featured?"),
                  value: _isFeatured,
                  onChanged: (bool? value) => setState(() { _isFeatured = value!; }),
                ),
              ),
              
              // TOMBOL SAVE
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.indigo),
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        
                        String url;
                        if (widget.product == null) {
                          url = "https://waldan-rafid-bolahraga.pbp.cs.ui.ac.id/create-flutter/";
                        } else {
                          url = "https://waldan-rafid-bolahraga.pbp.cs.ui.ac.id/edit-flutter/${widget.product!.pk}/";
                        }

                        final response = await request.postJson(
                          url, 
                          jsonEncode(<String, String>{
                            'name': _name,
                            'price': _price.toString(),
                            'description': _description,
                            'category': _category,
                            'thumbnail': _thumbnail,
                            'is_featured': _isFeatured.toString(),
                          }),
                        );

                        if (context.mounted) {
                          if (response['status'] == 'success') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(widget.product == null ? "Produk baru disimpan!" : "Produk berhasil diupdate!")),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const MyHomePage()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Gagal menyimpan, silakan coba lagi.")),
                            );
                          }
                        }
                      }
                    },
                    child: const Text("Save", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}