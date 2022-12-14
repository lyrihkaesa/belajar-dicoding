import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/provider/search_restaurants_provider.dart';
import 'package:restaurant_app/ui/restaurant_list_page.dart';

class RestaurantSearchPage extends StatelessWidget {
  static const routeName = '/search';

  const RestaurantSearchPage({super.key});

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
                'Cari',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              FittedBox(
                child: Consumer<SearchRestaurantsProvider>(
                  builder: (context, value, child) => Text(
                    '${value.result.founded} restoran.',
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
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                autofocus: true,
                onChanged: (value) {
                  var search = Provider.of<SearchRestaurantsProvider>(context,
                      listen: false);
                  search.setQuery(value.trim());
                  search.searchRestaurant();
                },
                style: const TextStyle(
                  fontSize: 12,
                ),
                cursorColor: Theme.of(context).colorScheme.secondary,
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Cari nama, kategori, dan menu.",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  hintStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer<SearchRestaurantsProvider>(
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
                  } else if (value.state == ResultState.hasData ||
                      value.query == "") {
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
                      child: FittedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.question_mark_outlined,
                              color: primaryColor,
                              size: 50,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text('"${value.query}" tidak ditemukan.'),
                          ],
                        ),
                      ),
                    );
                  } else if (value.state == ResultState.error) {
                    return const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                        child: FittedBox(
                          child: Text(
                              'Gagal terhubung ke server. Pastikan Anda terkonkesi internet!'),
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

class TitleListRestourant extends StatelessWidget {
  const TitleListRestourant({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var search = Provider.of<SearchRestaurantsProvider>(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Text(
        'Restoran (${search.result.founded})',
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
