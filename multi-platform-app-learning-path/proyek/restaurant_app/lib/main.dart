import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';
import 'package:restaurant_app/ui/restaurant_list_page.dart';

import 'data/repository/restaurant_repository.dart';
import 'provider/restaurant_provider.dart';
import 'ui/restaurant_search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantsProvider>(
          create: (_) => RestaurantsProvider(
            restaurantRepository: RestaurantRepository(),
          ),
        ),
        ChangeNotifierProvider<DetailRestaurantProvider>(
          create: (_) => DetailRestaurantProvider(
            restaurantRepository: RestaurantRepository(),
          ),
        ),
        ChangeNotifierProvider<SearchRestaurantsProvider>(
          create: (_) => SearchRestaurantsProvider(
            restaurantRepository: RestaurantRepository(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Restaurant App',
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primaryColor,
                onPrimary: Colors.black,
                secondary: secondaryColor,
              ),
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: myTextTheme,
          appBarTheme: const AppBarTheme(elevation: 0),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: primaryColor,
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.15,
              ),
              padding: const EdgeInsets.all(15),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(11),
                ),
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              foregroundColor: primaryColor,
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.15,
              ),
              padding: const EdgeInsets.all(15),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(11),
                ),
              ),
            ),
          ),
        ),
        initialRoute: RestaurantListPage.routeName,
        routes: {
          RestaurantListPage.routeName: (context) => const RestaurantListPage(),
          RestaurantDetailPage.routeName: (context) =>
              const RestaurantDetailPage(),
          RestaurantSearchPage.routeName: (context) =>
              const RestaurantSearchPage(),
        },
      ),
    );
  }
}
