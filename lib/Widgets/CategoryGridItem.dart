import 'package:flutter/material.dart';
import 'package:meals_app/Models/CategoryClassModel.dart';

class CategoryGridItem extends StatelessWidget
{
  const CategoryGridItem({super.key, required this.categoryModel, required this.selectCategoryFunc});

  final CategoryClassModel categoryModel;
  final void Function() selectCategoryFunc;

  @override
  Widget build(BuildContext context)
  {
    return InkWell(
      onTap: selectCategoryFunc,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(17),
        child: Container(
        padding: const EdgeInsets.all(16.2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          gradient: LinearGradient(
            colors: [
              categoryModel.color.withOpacity(0.55),
              categoryModel.color.withOpacity(0.9)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
          )
        ),
        child: Text(
            categoryModel.title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        )),
      ),
    );
  }
}
