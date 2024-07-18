import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/Models/MealsModel.dart';

class FavoriteMealsNotifier extends StateNotifier<List<MealsModel>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleMealFavoriteStatusFromProvider(MealsModel mealsModel) {
    final mealIsFavorite = state.contains(mealsModel);
    if (mealIsFavorite) {
      state = state.where((meal) => meal.id != mealsModel.id).toList();
      return false;
    } else {
      state = [...state, mealsModel];
      return true;
    }
  }
}

final favoriteMealsProvider = StateNotifierProvider<FavoriteMealsNotifier, List<MealsModel>>((ref) {
  return FavoriteMealsNotifier();
});
