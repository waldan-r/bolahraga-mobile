import 'package:flutter/material.dart';
import 'package:bolahraga/screens/menu.dart';
import 'package:bolahraga/screens/add_product_form.dart';

class ItemCard extends StatelessWidget{
  final ItemHomePage item;
  
  const ItemCard(this.item, {super.key});

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
        onTap:(){
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