import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/repository/restaurant_repository.dart';
import 'package:restaurant_app/ui/detail_page.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/restaurant_list';

  const RestaurantListPage({super.key});

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  final RestaurantRepository restaurantRepository = RestaurantRepository();
  String search = "";

  void updateListRestaurants(String search) {
    setState(() {
      this.search = search;
    });
  }

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
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: TextField(
                  onChanged: (value) => updateListRestaurants(value),
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: primaryColorBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Cari nama dan kota",
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    hintStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: primaryColorSoft,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder<List<RestaurantModel>>(
                  future: restaurantRepository.getDataRestaurant(search),
                  builder: (context, snapshot) {
                    List<RestaurantModel> restaurants = snapshot.data ?? [];
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: restaurants.length,
                        itemBuilder: (context, index) {
                          return _buildRestaurantItem(
                              context, restaurants[index]);
                        },
                      );
                    } else {
                      return const Center(
                        child: Text('Sebuah kesalahan telah terjadi!'),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildRestaurantItem(BuildContext context, RestaurantModel restaurant) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
    leading: Hero(
      tag: restaurant.pictureId,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.network(
          restaurant.pictureId,
          width: 85,
          fit: BoxFit.cover,
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
      children: [
        Row(
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
      Navigator.pushNamed(
        context,
        RestaurantDetailPage.routeName,
        arguments: restaurant,
      );
    },
  );
}
