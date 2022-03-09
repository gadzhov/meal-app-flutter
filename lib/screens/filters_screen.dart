import 'package:flutter/material.dart';
import 'package:meal_app/models/meal_filters.dart';

import '../widgets/main_drawer.dart';

typedef UpdateFiltersFunc = void Function(MealFilters);

class FiltersScreen extends StatefulWidget {
  const FiltersScreen(this._filters, this._updateFilters, {Key? key})
      : super(key: key);

  final MealFilters _filters;
  final UpdateFiltersFunc _updateFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  Widget _buildListSwitchTile(
          String title, String subtitle, bool value, Function(bool) onChange) =>
      SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        value: value,
        onChanged: onChange,
        activeColor: Theme.of(context).colorScheme.secondary,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
            onPressed: () {
              widget._updateFilters(widget._filters);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Filters applied!')));
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                'Adjust your meal selection',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildListSwitchTile(
                    'Gluten-Free',
                    'Only include gluten-free meals.',
                    widget._filters.isGlutenFree,
                    (value) =>
                        setState(() => widget._filters.isGlutenFree = value)),
                _buildListSwitchTile(
                    'Lactose-Free',
                    'Only include lactose-free meals.',
                    widget._filters.isLactoseFree,
                    (value) =>
                        setState(() => widget._filters.isLactoseFree = value)),
                _buildListSwitchTile(
                    'Vegetarian',
                    'Only include vegetarian meals.',
                    widget._filters.isVegetarian,
                    (value) =>
                        setState(() => widget._filters.isVegetarian = value)),
                _buildListSwitchTile(
                    'Vegan',
                    'Only include vegan meals.',
                    widget._filters.isVegan,
                    (value) => setState(() => widget._filters.isVegan = value)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
