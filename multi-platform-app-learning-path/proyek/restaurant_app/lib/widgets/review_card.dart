import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/customer_review.dart';

class CardReview extends StatelessWidget {
  const CardReview({
    Key? key,
    required this.customerReview,
  }) : super(key: key);

  final CustomerReview customerReview;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: primaryColorBackground,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              customerReview.name,
              style: const TextStyle(
                fontSize: 14,
                height: 1.2,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              customerReview.review,
              style: const TextStyle(
                fontSize: 12,
                height: 1.1,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                customerReview.date,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.1,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
