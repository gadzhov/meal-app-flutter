import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/main_drawer.dart';
import 'categories_screen.dart';
import 'favourites_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen(this._favouriteMeals, {Key? key}) : super(key: key);

  final List<Meal> _favouriteMeals;

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  var _selectedIndex = 0;

  late final List<_ScreenMeta> _tabScreens;

  @override
  void initState() {
    _tabScreens = <_ScreenMeta>[
      const _ScreenMeta('Categories', CategoriesScreen()),
      _ScreenMeta('Your Favourite', FavouritesScreen(widget._favouriteMeals)),
    ];
    super.initState();
  }

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tabScreens[_selectedIndex].title),
      ),
      drawer: const MainDrawer(),
      body: _tabScreens[_selectedIndex].screen,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourites',
          )
        ],
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
      ),
    );
  }
}

class _ScreenMeta {
  final String title;
  final Widget screen;

  const _ScreenMeta(this.title, this.screen);
}
