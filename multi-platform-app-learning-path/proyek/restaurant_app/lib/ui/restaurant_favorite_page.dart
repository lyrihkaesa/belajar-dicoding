import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/ui/restaurant_list_page.dart';

class RestaurantFavoritePage extends StatelessWidget {
  static const routeName = '/favorite';

  const RestaurantFavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Favorit',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              FittedBox(
                child: Consumer<DatabaseProvider>(
                  builder: (context, value, child) => Text(
                    '${value.favorites.length} restoran.',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Consumer<DatabaseProvider>(
                builder: (context, value, _) {
                  if (value.state == ResultState.loading) {
                    return Center(
                      child: FittedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(
                              color: primaryColor,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Mencari restoran untukmu.'),
                            Text('Tunggu sebentar...'),
                          ],
                        ),
                      ),
                    );
                  } else if (value.state == ResultState.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.favorites.length,
                      itemBuilder: (context, index) {
                        var restaurant = value.favorites[index];
                        return buildRestaurantItem(context, restaurant);
                      },
                    );
                  } else if (value.state == ResultState.noData) {
                    return Center(
                      child: FittedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.no_meals_rounded,
                              color: primaryColor,
                              size: 50,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Tidak ada restoran favorit.'),
                          ],
                        ),
                      ),
                    );
                  } else if (value.state == ResultState.error) {
                    return const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                        child: FittedBox(
                          child: Text('Gagal memuat data pada database!'),
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: FittedBox(
                        child: Text(
                            'Kesalahan memuat daftar restoran sedang terjadi!'),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
