import 'package:flutter/material.dart';
import 'package:bolahraga/screens/menu.dart';
import 'package:bolahraga/screens/add_product_form.dart';

class LeftDrawer extends StatelessWidget{
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Column(
                
            ),
          ),
          ListTile(),
          ListTile(),
        ],
      )
    );
  }
}