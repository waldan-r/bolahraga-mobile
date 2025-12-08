import 'package:flutter/material.dart';
import 'package:bolahraga/screens/menu.dart';
import 'package:bolahraga/screens/add_product_form.dart';
import 'package:bolahraga/screens/product_entry_list.dart';

class LeftDrawer extends StatelessWidget{
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              children: [
                Text(
                  "Bolahraga",
                  textAlign: TextAlign.center, 
                  style: TextStyle(
                    fontSize: 30, 
                    fontWeight: FontWeight.bold, 
                    color: Colors.white
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)
                ),
                Text(
                  "Shop and build your match!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.white
                  ),
                )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap:(){
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                )
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.post_add),
            title: const Text('Create Product'),
            onTap:(){
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute(
                  builder: (context) => ProductFormPage(),
                )
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_reaction_rounded),
            title: const Text('Product List'),
            onTap: () {
              // Route to product list page
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProductListPage(isUserProducts: true)),
              );
            },
          ),
        ],
      )
    );
  }
}