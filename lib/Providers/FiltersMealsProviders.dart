import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/Providers/MealsProviders.dart';

enum Filters {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan
}


class FiltersNotifier extends StateNotifier<Map<Filters, bool>>
{
  FiltersNotifier() : super({
    Filters.glutenFree: false,
    Filters.lactoseFree: false,
    Filters.vegetarian: false,
    Filters.vegan: false
  });

  void setFilter(Filters filter, bool isActive)
  {
    state = {
      ...state,
      filter: isActive,
    };
  }

  void setFilters(Map<Filters, bool> chosenFilters)
  {
    state = chosenFilters;
  }
}

final filtersProvider = StateNotifierProvider<FiltersNotifier, Map<Filters, bool>>((ref) => FiltersNotifier());

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  return meals.where((mealItem)
  {
    if(activeFilters[Filters.glutenFree]! && !mealItem.isGlutenFree)
    {
      return false;
    }

    if(activeFilters[Filters.lactoseFree]! && !mealItem.isLactoseFree)
    {
      return false;
    }

    if(activeFilters[Filters.vegetarian]! && !mealItem.isVegetarian)
    {
      return false;
    }

    if(activeFilters[Filters.vegan]! && !mealItem.isVegan)
    {
      return false;
    }
    return true;
  }).toList();
});
