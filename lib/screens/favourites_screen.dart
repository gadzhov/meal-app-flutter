import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen(this._favouriteMeals, {Key? key}) : super(key: key);

  final List<Meal> _favouriteMeals;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _favouriteMeals.isEmpty
          ? Center(
              child: Text('No favourites yet, please add some!',
                  style: Theme.of(context).textTheme.headline6),
            )
          : ListView.builder(
              itemBuilder: (_, index) {
                final meal = _favouriteMeals[index];
                return ListTile(
                  title: MealItem(meal, null),
                );
              },
              itemCount: _favouriteMeals.length,
            ),
    );
  }
}
