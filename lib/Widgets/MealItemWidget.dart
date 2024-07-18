import 'package:flutter/material.dart';
import 'package:meals_app/Models/MealsModel.dart';
import 'package:meals_app/Widgets/MealMetadataWidget.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItemWidget extends StatelessWidget
{
  const MealItemWidget({super.key, required this.mealsModel, required this.selectMealFunc});

  final MealsModel mealsModel;
  final void Function() selectMealFunc;

  String get complexityMetadata
  {
    return mealsModel.affordability.name[0].toUpperCase() + mealsModel.affordability.name.substring(1);
  }

  String get affordabilityMetadata
  {
    return mealsModel.complexity.name[0].toUpperCase() + mealsModel.complexity.name.substring(1);
  }

  @override
  Widget build(BuildContext context)
  {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: selectMealFunc,
        child: Stack(
          children: [
            Hero(
              tag: mealsModel.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(mealsModel.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            
            Positioned(
              bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black54,
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                  child: Column(
                    children: [
                      Text(
                        mealsModel.title,
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),

                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MealMetadataWidget(
                              iconData: Icons.schedule,
                              label: '${mealsModel.duration} min'
                          ),

                          const SizedBox(width: 12),

                          MealMetadataWidget(
                              iconData: Icons.work,
                              label: complexityMetadata
                          ),

                          const SizedBox(width: 12),

                          MealMetadataWidget(
                              iconData: Icons.attach_money,
                              label: affordabilityMetadata
                          )
                        ],
                      )
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
