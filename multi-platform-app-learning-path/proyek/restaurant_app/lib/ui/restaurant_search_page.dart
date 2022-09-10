import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/restaurant_list_page.dart';

class RestaurantSearchPage extends StatelessWidget {
  static const routeName = '/restaurant_search';

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
            children: const <Widget>[
              Text(
                'Cari Restoran',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              FittedBox(
                child: Text(
                  'Cari berdasarkan nama, kategori, dan menu!',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: TextField(
                  autofocus: true,
                  onChanged: (value) {
                    var search = Provider.of<SearchRestaurantsProvider>(context,
                        listen: false);
                    search.setQuery(value.trim());
                    search.searchRestaurant();
                  },
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
              const TitleListRestourant(),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Consumer<SearchRestaurantsProvider>(
                    builder: (context, value, _) {
                      if (value.state == ResultState.loading) {
                        return Center(
                          child: FittedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                CircularProgressIndicator(),
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
              ),
            ],
          ),
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
