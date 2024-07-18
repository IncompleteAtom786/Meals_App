import 'package:flutter/material.dart';
import 'package:meals_app/Screens/MealsItemScreen.dart';
import '../Models/MealsModel.dart';
import '../Widgets/MealItemWidget.dart';

class MealsScreen extends StatelessWidget
{
  const MealsScreen({
    super.key,
    required this.title,
    required this.mealsModel,
  });

  final String? title;
  final List<MealsModel> mealsModel;

  void _selectMeal(BuildContext context, MealsModel mealsModel)
  {
    Navigator.push(context, MaterialPageRoute(builder: (ctx) => MealsItemScreen(mealsModelDataDisplay: mealsModel)));
  }

  @override
  Widget build(BuildContext context)
  {
    Widget content = ListView.builder(
        itemCount: mealsModel.length,
        itemBuilder: (ctx, index) => MealItemWidget(
          mealsModel: mealsModel[index],
          selectMealFunc: ()
        {
            _selectMeal(context, mealsModel[index]);
            },
        )
    );

    if(mealsModel.isEmpty)
      {
        content = Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Uh Oh.....nothing here!",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,),
              ),

              const SizedBox(height: 16),

              Text("Try selecting a different category!",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
              )
            ],
          ),
        );
      }

    if(title == null)
    {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
