import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

import '../widgets/favorite_botton.dart';
import '../widgets/menu_item_card_list.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/article_detail';

  final RestaurantModel restaurant;

  const RestaurantDetailPage({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                Hero(
                  tag: restaurant.pictureId,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(15),
                    ),
                    child: Image.network(
                      restaurant.pictureId,
                    ),
                  ),
                ),
                SafeArea(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.black54,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        const FavoriteButton(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star_rate_rounded,
                        size: 20,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        restaurant.rating.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      const Icon(
                        Icons.location_on,
                        size: 20,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        restaurant.city,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ReadMoreText(
                    restaurant.description,
                    trimLines: 3,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: " baca selengkapnya...",
                    trimExpandedText: " ...sembunyikan",
                    style: Theme.of(context).textTheme.bodyText2,
                    delimiter: "",
                    lessStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    moreStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MenuItemCardList(
                    items: restaurant.menus.foods,
                    title: Text(
                      'Minuman (${restaurant.menus.foods.length})',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    icon: const Icon(
                      Icons.fastfood_rounded,
                      size: 50,
                      color: Colors.black12,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MenuItemCardList(
                    items: restaurant.menus.drinks,
                    title: Text(
                      'Minuman (${restaurant.menus.drinks.length})',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
