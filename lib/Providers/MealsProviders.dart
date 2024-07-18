import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Data/DummyMealsData.dart';

final mealsProvider = Provider((ref) {
  return dummyMealsData;
});
