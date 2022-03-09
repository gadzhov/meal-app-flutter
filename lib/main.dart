import 'package:flutter/material.dart';

import 'dumy_data.dart';
import 'models/category.dart';
import 'models/meal.dart';
import 'models/meal_filters.dart';
import 'routes/route_name.dart';
import 'screens/category_meals_screen.dart';
import 'screens/filters_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/tabs_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _filters = MealFilters(false, false, false, false);
  final _allMeals = List.of(dummyMeals);
  var _filteredMeals = List.of(dummyMeals);
  final _favouriteMeals = <Meal>[];

  void _updateFilters(MealFilters updatedFilters) {
    setState(() {
      _filters
        ..isGlutenFree = updatedFilters.isGlutenFree
        ..isLactoseFree = updatedFilters.isLactoseFree
        ..isVegan = updatedFilters.isVegan
        ..isVegetarian = updatedFilters.isVegetarian;
      _filteredMeals = _allMeals.where((meal) {
        if (_filters.isGlutenFree && !meal.isGlutenFree) {
          return false;
        }

        if (_filters.isLactoseFree && !meal.isLactoseFree) {
          return false;
        }

        if (_filters.isVegan && !meal.isVegan) {
          return false;
        }

        if (_filters.isVegetarian && !meal.isVegetarian) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  void _toggleFavourite(Meal meal) {
    final index = _favouriteMeals.indexOf(meal);
    if (index == -1) {
      setState(() => _favouriteMeals.add(meal));
    } else {
      setState(() => _favouriteMeals.remove(meal));
    }
  }

  bool _isMealFavourite(Meal meal) => _favouriteMeals.contains(meal);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.pink,
      ).copyWith(
        secondary: Colors.amber,
      ),
      canvasColor: const Color.fromRGBO(255, 254, 229, 1),
      fontFamily: 'Raleway',
      textTheme: const TextTheme(
        bodyText1: TextStyle(
          color: Color.fromRGBO(20, 51, 51, 1),
        ),
        bodyText2: TextStyle(
          color: Color.fromRGBO(20, 51, 51, 1),
        ),
        headline6: TextStyle(
          fontSize: 20,
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    return MaterialApp(
      title: 'Meal App!',
      debugShowCheckedModeBanner: false,
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(secondary: Colors.amber),
      ),
      routes: {
        RouteName.home: (ctx) => TabsScreen(_favouriteMeals),
        RouteName.categoryMeals: ((ctx) {
          final category = ModalRoute.of(ctx)!.settings.arguments as Category;
          return CategoryMealsScreen(_filteredMeals, category);
        }),
        RouteName.mealDetail: ((ctx) {
          final meal = ModalRoute.of(ctx)!.settings.arguments as Meal;
          return MealDetailScreen(meal, _toggleFavourite, _isMealFavourite);
        }),
        RouteName.filters: (ctx) => FiltersScreen(_filters, _updateFilters),
      },
    );
  }
}
