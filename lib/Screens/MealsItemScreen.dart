import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/Models/MealsModel.dart';
import 'package:meals_app/Providers/FavoritesMealsProviders.dart';

class MealsItemScreen extends ConsumerWidget
{
  const MealsItemScreen({
    super.key,
    required this.mealsModelDataDisplay,
  });

  final MealsModel mealsModelDataDisplay;

  @override
  Widget build(BuildContext context, WidgetRef ref)
  {
    final favoriteMeal = ref.watch(favoriteMealsProvider);
    final isFavorite = favoriteMeal.contains(mealsModelDataDisplay);

    return Scaffold(
      appBar: AppBar(
        title: Text(mealsModelDataDisplay.title),
        actions: [
          IconButton(
              onPressed: ()
              {
                final mealWasAdded = ref.read(favoriteMealsProvider.notifier).toggleMealFavoriteStatusFromProvider(mealsModelDataDisplay);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(mealWasAdded ? 'Meal added as favorite!' : 'Meal removed from the favorite!')));
              },
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: Icon(isFavorite ? Icons.star : Icons.star_border, key: ValueKey(isFavorite),),
                transitionBuilder: (child, animation) {
                  return RotationTransition(
                    turns: Tween<double>(begin: 0.9, end: 1).animate(animation),
                    child: child,
                  );
                },
              ) 
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: mealsModelDataDisplay.id,
              child: Image.network(
                mealsModelDataDisplay.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 14,),

            Text(
              "Ingredients",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold
              ),
            ),

            const SizedBox(height: 14),

            for(final ingredient in mealsModelDataDisplay.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface
                    ),
              ),

            const SizedBox(height: 14),

            Text(
              "Steps: ",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold
              ),
            ),

            for(final steps in mealsModelDataDisplay.steps)
              Padding(

                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  steps,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface
                  ),
                ),
              )
          ],
        ),
    ),
    );
  }
}
