import 'package:flutter/material.dart';
import 'package:meals_app/Data/DummyCategoriesData.dart';
import 'package:meals_app/Models/CategoryClassModel.dart';
import 'package:meals_app/Models/MealsModel.dart';
import 'package:meals_app/Screens/MealsScreen.dart';
import 'package:meals_app/Widgets/CategoryGridItem.dart';

class CategoriesScreen extends StatefulWidget
{
  const CategoriesScreen({super.key, required this.availableMealsToShow});

  final List<MealsModel> availableMealsToShow;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin
{
  late AnimationController _animationController;
  @override
  void initState()
  {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose()
  {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, CategoryClassModel categoryClassModel)
  {
    final filteredMeals = widget.availableMealsToShow.where((meal) => meal.categories.contains(categoryClassModel.id)).toList();

    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (ctx) => MealsScreen(
                title: categoryClassModel.title,
                mealsModel: filteredMeals,
            ),
        ));
  }

  @override
  Widget build(BuildContext context)
  {
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
          gridDelegate:const  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3/2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20
          ),

          children: [
            for(final categoryData in dummyCategoriesData)
              CategoryGridItem(categoryModel: categoryData, selectCategoryFunc: () { _selectCategory(context, categoryData); })
          ],
        ),
        builder: (context, child) => SlideTransition(
          position: Tween(
            begin: const Offset(0, 0.3),
            end: const Offset(0, 0),
          ).animate(
              CurvedAnimation(
                  parent: _animationController,
                  curve: Curves.easeInOut
              )),
          child: child,
          ),
    );
  }
}
