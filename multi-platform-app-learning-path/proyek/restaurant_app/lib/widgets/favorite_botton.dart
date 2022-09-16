import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/database_provider.dart';

class FavoriteButton extends StatefulWidget {
  final Restaurant restaurant;
  const FavoriteButton({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, value, child) {
        return FutureBuilder<bool>(
          future: value.isFavorited(widget.restaurant.id),
          builder: (context, snapshot) {
            var isFavorite = snapshot.data ?? false;
            return IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                  if (isFavorite) {
                    value.addFavorite(widget.restaurant);
                  } else {
                    value.removeFavorite(widget.restaurant.id);
                  }
                });
              },
            );
          },
        );
      },
    );
  }
}
