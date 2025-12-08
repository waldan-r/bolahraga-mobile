import 'package:flutter/material.dart';
import 'package:bolahraga/widgets/menu_card.dart';
import 'package:bolahraga/widgets/drawer.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String nama = "Waldan Rafid";
  final String npm = "2406346693";
  final String kelas = "F";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LeftDrawer(),
      appBar: AppBar(
        title: const Text(
          'BOLAHRAGA', style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: 'NPM', content: npm),
                InfoCard(title: 'Name', content: nama),
                InfoCard(title: 'Class', content: kelas),
              ],
            ),
            const SizedBox(height: 16.0,),
            Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Welcome to Bolahraga!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  GridView.count(
                    primary: true,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    children: items.map((ItemHomePage item) {
                      return ItemCard(item);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }

  final List<ItemHomePage> items = [
    ItemHomePage("All Product", Icons.sports_soccer_rounded),
    ItemHomePage("My Product", Icons.sports_soccer_sharp),
    ItemHomePage("Create Product", Icons.add),
    ItemHomePage("Logout", Icons.logout),
  ];
}

class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context){
    return Card(elevation: 2.0, child: Container(width: MediaQuery.of(context).size.width / 3.5, padding: const EdgeInsets.all(16.0), child: Column(children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold),), const SizedBox(height: 8.0), Text(content),],),),);
  }
}

class ItemHomePage {
  final String name;
  final IconData icon;

  ItemHomePage(this.name, this.icon);
}