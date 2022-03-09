import 'package:flutter/material.dart';

import '../models/category.dart';
import '../routes/route_name.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(this._category, {Key? key}) : super(key: key);

  final Category _category;

  void _navigateToCategoryMealsScreen(BuildContext context) =>
      Navigator.of(context)
          .pushNamed(RouteName.categoryMeals, arguments: _category);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(15);
    return InkWell(
      onTap: () => _navigateToCategoryMealsScreen(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: borderRadius,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          _category.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _category.color.withOpacity(0.7),
              _category.color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
