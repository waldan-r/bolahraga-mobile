import 'package:flutter/material.dart';
import 'package:bolahraga/screens/menu.dart';
import 'package:bolahraga/screens/add_product_form.dart';
import 'package:bolahraga/screens/product_entry_list.dart'; 
import 'package:bolahraga/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatelessWidget{
  final ItemHomePage item;
  
  const ItemCard(this.item, {super.key});
  
  get request => null;

  @override
  Widget build(BuildContext context){
    Color secondaryColor;
    switch(item.name){
      case ("All Product"): secondaryColor = Colors.blue;
      break;
      case ("My Product"): secondaryColor = Colors.green;
      break;
      case ("Create Product"): secondaryColor = Colors.red;
      break;
      default: secondaryColor = Colors.white;
    }

    return Material(
      color: secondaryColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap:() async {
          ScaffoldMessenger.of(context)
          ..hideCurrentMaterialBanner()
          ..showSnackBar(
            SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!"))
          );
          if (item.name == "Create Product"){
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => const ProductFormPage()
              )
            );
          } else if (item.name == "Lihat Semua Produk") { 
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ProductListPage(isUserProducts: false,) 
              ),
            );
          }
          else if (item.name == "Lihat Produk Saya") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ProductListPage(isUserProducts: true,) 
              ),
            );
          }
          else if (item.name == "Logout") {
            // TODO: Ganti URL dengan URL aplikasi Django kamu dan jangan lupa tambahkan trailing slash (/)!
            // Untuk menghubungkan emulator Android dengan Django di localhost, gunakan URL http://10.0.2.2/
            // Jika menggunakan Chrome, gunakan URL http://localhost:8000
            
            final response = await request.logout(
                "https://pbp.cs.ui.ac.id/waldan.rafid/bolahraga/auth/logout/");
            String message = response["message"];
            if (context.mounted) {
                if (response['status']) {
                    String uname = response["username"];
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("$message SSee you, $uname."),
                    ));
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(message),
                        ),
                    );
                }
            }
          }
        }, // onTap
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
                const Padding(padding: EdgeInsets.all(3),),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            )
          )
        )
      )
    );
  }
}