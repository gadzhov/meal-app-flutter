import 'package:flutter/material.dart';

import '../routes/route_name.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget _buildListTile(IconData icon, String title, VoidCallback onTab) =>
      ListTile(
        leading: Icon(
          icon,
          size: 26,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: onTab,
      );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          SizedBox(
            height: 150,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Text(
                'Cooking up!',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          _buildListTile(Icons.restaurant, 'Meals',
              () => Navigator.of(context).pushReplacementNamed(RouteName.home)),
          _buildListTile(
              Icons.settings,
              'Filter',
              () => Navigator.of(context)
                  .pushReplacementNamed(RouteName.filters)),
        ],
      ),
    );
  }
}
