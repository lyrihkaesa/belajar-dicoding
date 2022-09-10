import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';
import 'package:restaurant_app/ui/restaurant_search_page.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurant_list';

  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                'Restoran',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                'Rekomendasi restoran untuk Anda!',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                var search = Provider.of<SearchRestaurantsProvider>(context,
                    listen: false);
                search.setQuery('');
                Navigator.pushNamed(context, RestaurantSearchPage.routeName);
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Consumer<RestaurantsProvider>(
            builder: (context, value, _) {
              if (value.state == ResultState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (value.state == ResultState.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.result.restaurants.length,
                  itemBuilder: (context, index) {
                    var restaurant = value.result.restaurants[index];
                    return buildRestaurantItem(context, restaurant);
                  },
                );
              } else if (value.state == ResultState.noData) {
                return Center(
                  child: Text(value.message),
                );
              } else if (value.state == ResultState.error) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.wifi_off_rounded,
                          size: 50,
                          color: primaryColor,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Gagal terhubung ke server. Pastikan Anda terkonkesi internet!',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            value.getAllRestaurant();
                          },
                          child: const Text(
                            'Hubungkan kembali',
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(
                  child:
                      Text('Kesalahan memuat daftar restoran sedang terjadi!'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

Widget buildRestaurantItem(BuildContext context, Restaurant restaurant) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
    leading: Hero(
      tag: restaurant.pictureId,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.network(
          "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
          width: 85,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const SizedBox(
              width: 85,
              child: Center(
                child: Icon(Icons.image_not_supported_rounded),
              ),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return const SizedBox(
                width: 85,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    ),
    title: Padding(
      padding: const EdgeInsets.only(left: 2),
      child: Text(
        restaurant.name,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          fit: BoxFit.fitWidth,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on,
                size: 18,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                restaurant.city,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.star_rate_rounded,
              size: 18,
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              restaurant.rating.toString(),
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    ),
    trailing: const Icon(
      Icons.arrow_forward_ios_rounded,
    ),
    onTap: () {
      final detailRestaurant =
          Provider.of<DetailRestaurantProvider>(context, listen: false);
      detailRestaurant.setRestaurant(restaurant);
      Navigator.pushNamed(context, RestaurantDetailPage.routeName);
    },
  );
}
