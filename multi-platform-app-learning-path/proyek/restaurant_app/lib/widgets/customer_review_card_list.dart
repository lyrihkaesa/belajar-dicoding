import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/customer_review.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/widgets/icon_button_review.dart';
import 'package:restaurant_app/widgets/review_card.dart';

class CustomerReviewCardList extends StatefulWidget {
  const CustomerReviewCardList({Key? key}) : super(key: key);

  @override
  State<CustomerReviewCardList> createState() => _CustomerReviewCardListState();
}

class _CustomerReviewCardListState extends State<CustomerReviewCardList> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final restaurant = Provider.of<DetailRestaurantProvider>(context);
    bool isLoading() =>
        restaurant.stateReview == ReviewState.loading ||
        restaurant.state == ReviewState.loading;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                'Review (${isLoading() ? 0 : restaurant.result.customerReviews.length})',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            const Flexible(
              child: OutlinedButtonReview(),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        restaurant.stateReview == ReviewState.error
            ? FittedBox(
                fit: BoxFit.scaleDown,
                child: Card(
                  color: Colors.red[200],
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Gagal menambahkan review ${restaurant.messageReview}",
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
        isLoading()
            ? const SizedBox(
                height: 300,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Scrollbar(
                thumbVisibility: true,
                controller: _scrollController,
                child: SizedBox(
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    controller: _scrollController,
                    itemCount: restaurant.state == ResultState.error
                        ? 1
                        : restaurant.result.customerReviews.length,
                    itemBuilder: (context, index) {
                      return CardReview(
                          customerReview: restaurant.state == ResultState.error
                              ? CustomerReview(
                                  name: 'Anonymus',
                                  review: 'tidak terhubung ke internet...',
                                  date: DateTime.now().toString(),
                                )
                              : restaurant.result.customerReviews[index]);
                    },
                  ),
                ),
              ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
