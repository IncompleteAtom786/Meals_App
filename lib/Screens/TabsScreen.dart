import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/Providers/FavoritesMealsProviders.dart';
import 'package:meals_app/Providers/FiltersMealsProviders.dart';
import 'package:meals_app/Screens/CategoriesScreen.dart';
import 'package:meals_app/Screens/FiltersScreen.dart';
import 'package:meals_app/Screens/MealsScreen.dart';
import '../Widgets/DrawerWidget.dart';

class TabsScreen extends ConsumerStatefulWidget
{
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState()
  {
    return  _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen>
{
  int _selectedPadeIndex = 0;

  void _selectPage(int index)
  {
    setState(()
    {
      _selectedPadeIndex = index;
    });
  }

  void _setScreen(String identifier) async
  {
    Navigator.of(context).pop();
    if(identifier == "filters")
    {
      final result = await Navigator.of(context).push<Map<Filters, bool>>(MaterialPageRoute(builder: (ctx) => const FiltersScreen()));
    }
  }

  @override
  Widget build(BuildContext context)
  {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(availableMealsToShow: availableMeals,);
    var activePageTitle = "Categories";

    if(_selectedPadeIndex == 1)
      {
        final favoriteMeals = ref.watch(favoriteMealsProvider);
        activePage = MealsScreen(
            title: "Favorites",
            mealsModel: favoriteMeals,
        );
        activePageTitle = "Your Favorites";
      }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),

      drawer: DrawerWidget(onSelectScreen: _setScreen),

      body: activePage,

      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) { _selectPage(index); },
        currentIndex: _selectedPadeIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
        ],
      ),
    );
  }
}
