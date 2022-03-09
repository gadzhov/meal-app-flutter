import 'package:flutter/material.dart';

import '../models/meal.dart';

typedef ToggleFavouriteFunc = void Function(Meal meal);
typedef IsMealFavouriteFunc = bool Function(Meal meal);

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen(
    this._meal,
    this._toggleFavourite,
    this._isMealFavourite, {
    Key? key,
  }) : super(key: key);

  final Meal _meal;
  final ToggleFavouriteFunc _toggleFavourite;
  final IsMealFavouriteFunc _isMealFavourite;

  Widget _buildSectionTitle(BuildContext context, String title) => Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
      );

  Widget _buildContainer(Widget widget) => Container(
        height: 200,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: widget,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                _meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _buildSectionTitle(context, 'Ingredients'),
            _buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) {
                  final ingredient = _meal.ingredients[index];
                  return Card(
                    color: Theme.of(ctx).colorScheme.secondary,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(ingredient),
                    ),
                  );
                },
                itemCount: _meal.ingredients.length,
              ),
            ),
            _buildSectionTitle(context, 'Steps'),
            _buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) {
                  final step = _meal.steps[index];
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          child: Text('#${index + 1}'),
                        ),
                        title: Text(step),
                      ),
                      const Divider()
                    ],
                  );
                },
                itemCount: _meal.steps.length,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(
              _isMealFavourite(_meal) ? Icons.star : Icons.star_border,
            ),
            onPressed: () => _toggleFavourite(_meal),
            heroTag: null,
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            child: const Icon(Icons.delete),
            onPressed: () => Navigator.of(context).pop(_meal),
            heroTag: null,
          ),
        ],
      ),
    );
  }
}
