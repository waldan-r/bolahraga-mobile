import "package:flutter/material.dart";
import "package:bolahraga/widgets/drawer.dart";
import "package:bolahraga/screens/menu.dart";

class ProductFormPage extends StatefulWidget{
  const ProductFormPage({super.key});
  
  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage>{
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int _price = 0;
  String _description = "";
  Uri _thumbnail = Uri.parse("");
  int _stock = 0;
  bool _isFeatured = false;
  String _category = "Field Setup";
  final List<String> _categoryChoices = [
   'Field Setup',
    'Training Equipment',
    'Match Equipment',
    'Safety Recovery',
    'Event Accessories',
    'Player Gear'
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Add Product',
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Product Name
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration:  InputDecoration(
                    hintText: "Product Name",
                    labelText: "Product Name",
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value){
                    setState(() {
                      _name = value!;
                    });
                  },
                  validator: (String? value){
                    if (value == null || value.isEmpty){
                      return "Product name should not be empty!";
                    }
                    return null;
                  },
                ),
              ),
              
              // Product Price
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Price",
                    labelText: "Price",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  
                  onChanged: (String? value) {
                    setState(() {
                      _price = int.parse(value!);
                    });
                  },
                  
                  validator: (String? value){
                    int? validInt = int.tryParse(value!);
                    if ( validInt == null){
                      return "Input must be an integer!";
                    } else if (int.parse(value) < 0){
                      return "Input a valid integer!";
                    }
                    return null;
                  }
                ),
              ),

              // Product Description
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Description",
                    labelText: "Description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Description should not be empty!";
                    }
                    return null;
                  },
                ),
              ),

              // Product Category
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Category",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  value: _category,
                  items: _categoryChoices
                      .map((cat) => DropdownMenuItem(
                            value: cat,
                            child: Text(
                                cat[0].toUpperCase() + cat.substring(1)),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _category = newValue!;
                    });
                  },
                ),
              ),

              // Product Stock
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Stock",
                    labelText: "Stock",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _stock = int.parse(value!);
                    });
                  },
                  validator: (String? value){
                    int? validInt = int.tryParse(value!);
                    if ( validInt == null){
                      return "Input must be an integer!";
                    } else if (int.parse(value) < 0){
                      return "Input a valid integer!";
                    }
                    return null;
                  }
                ),
              ),

              // Product Thumbnail
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "URL Thumbnail",
                    labelText: "URL Thumbnail",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      Uri? validUri = Uri.tryParse(value);
                      _thumbnail = validUri!;
                    });
                  },
                  validator: (String? value){
                    if (value == null || value.isEmpty){
                      return "Thumbnail should not be empty!";
                    }
                    if (Uri.tryParse(value)?.isAbsolute == false){
                      return "Input unrecognizable";
                    }
                    return null;
                  }
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SwitchListTile(
                  title: const Text("Tandai sebagai Berita Unggulan"),
                  value: _isFeatured,
                  onChanged: (bool value) {
                    setState(() {
                      _isFeatured = value;
                    });
                  },
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Product Added Successfully'),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text('Name: $_name'),
                                      Text('Description: $_description'),
                                      Text('Price: $_price'),
                                      Text('Category: $_category'),
                                      Text('Stock: $_stock'),
                                      Text('Thumbnail: $_thumbnail'),
                                      Text(
                                          'Featured: ${_isFeatured ? "Yes" : "No"}'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    // Navigator.pop(context);
                                    // _formKey.currentState!.reset();

                                    Navigator.pushReplacement(
                                      context, 
                                      MaterialPageRoute(
                                        builder: (context) => MyHomePage()
                                      )
                                    );
                                    _formKey.currentState!.reset();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Simpan",
                      style: TextStyle(color: Colors.white),
                      
                    ),
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}