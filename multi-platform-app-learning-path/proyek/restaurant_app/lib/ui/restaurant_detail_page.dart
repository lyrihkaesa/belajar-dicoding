import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/item.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/category_card.dart';
import 'package:restaurant_app/widgets/customer_review_card_list.dart';
import 'package:restaurant_app/widgets/favorite_botton.dart';
import 'package:restaurant_app/widgets/menu_item_card_list.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant-detail';

  const RestaurantDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<ItemModel> loadingItem = [
      ItemModel(name: 'loading...'),
    ];
    List<ItemModel> errorItem = [
      ItemModel(name: 'tidak terhubung ke internet...'),
    ];
    final restaurant = Provider.of<DetailRestaurantProvider>(context);
    bool isLoading() => restaurant.state == ResultState.loading;
    bool isError() => restaurant.state == ResultState.error;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  Hero(
                    tag: restaurant.result.pictureId,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(15),
                      ),
                      child: Center(
                        child: Image.network(
                          "https://restaurant-api.dicoding.dev/images/large/${restaurant.result.pictureId}",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const SizedBox(
                              height: 220,
                              child: Center(
                                child: Icon(
                                  Icons.image_not_supported_rounded,
                                  size: 50,
                                ),
                              ),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return const SizedBox(
                                height: 220,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: primaryColor,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
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
                          FavoriteButton(restaurant: restaurant.result),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.result.name,
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
                          restaurant.result.rating.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
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
                          Icons.location_on,
                          size: 20,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Expanded(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "${restaurant.result.city}, ${isLoading() ? 'loading...' : isError() ? 'tidak terhubung ke server...' : restaurant.result.address}",
                              softWrap: true,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CategoryItemCardList(
                        items: isLoading()
                            ? loadingItem
                            : isError()
                                ? errorItem
                                : restaurant.result.categories),
                    const SizedBox(
                      height: 10,
                    ),
                    ReadMoreText(
                      restaurant.result.description,
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
                      items: isLoading()
                          ? loadingItem
                          : isError()
                              ? errorItem
                              : restaurant.result.menus.foods,
                      title: Text(
                        'Minuman (${restaurant.result.menus.foods.length})',
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
                      items: isLoading()
                          ? loadingItem
                          : isError()
                              ? errorItem
                              : restaurant.result.menus.drinks,
                      title: Text(
                        'Minuman (${restaurant.result.menus.drinks.length})',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const CustomerReviewCardList(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
