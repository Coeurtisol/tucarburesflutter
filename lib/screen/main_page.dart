import 'package:flutter/material.dart';
import 'package:tucarburesflutter/screen/favoris_page.dart';
import 'package:tucarburesflutter/screen/recherche_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _widgets = [
    const FavorisPage(),
    const RecherchePage(),
  ];

  int _index = 0;

  void _changePage(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _widgets[_index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _changePage,
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.star_border_outlined), label: 'Ma station'),
          BottomNavigationBarItem(icon: Icon(Icons.search_outlined), label: 'Rechercher'),
        ],
      ),
    );
  }
}
