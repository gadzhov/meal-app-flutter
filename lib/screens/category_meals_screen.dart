import 'package:flutter/material.dart';
import 'package:meal_app/widgets/meal_item.dart';

import '../models/category.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  const CategoryMealsScreen(this._filteredMeals, this._category, {Key? key})
      : super(key: key);

  final List<Meal> _filteredMeals;
  final Category _category;

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late List<Meal> _categoryMeals;

  @override
  void initState() {
    _categoryMeals = widget._filteredMeals
        .where((meal) => meal.categories.contains(widget._category.id))
        .toList();
    super.initState();
  }

  void _deleteMeal(Meal meal) => setState(() => _categoryMeals.remove(meal));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget._category.title),
        ),
        body: ListView.builder(
          itemBuilder: (_, index) {
            final meal = _categoryMeals[index];
            return ListTile(
              title: MealItem(meal, _deleteMeal),
            );
          },
          itemCount: _categoryMeals.length,
        ));
  }
}
