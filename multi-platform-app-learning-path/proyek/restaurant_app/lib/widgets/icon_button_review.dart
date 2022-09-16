import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';

class OutlinedButtonReview extends StatelessWidget {
  const OutlinedButtonReview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detailRestaurant =
        Provider.of<DetailRestaurantProvider>(context, listen: false);
    return OutlinedButton.icon(
      label: MediaQuery.of(context).size.width <= 300
          ? const SizedBox.shrink()
          : FittedBox(
              fit: BoxFit.cover,
              child: Text(
                'Tambah review',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
      icon: Icon(
        Icons.add_comment_rounded,
        color: Theme.of(context).colorScheme.secondary,
      ),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          builder: (context) => Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Beri Review',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.15,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.close,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      autofocus: true,
                      onChanged: (value) {
                        detailRestaurant.setName(value);
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
                        hintText: "Nama",
                        prefixIcon: Icon(
                          Icons.person,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        hintStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      onChanged: (value) {
                        detailRestaurant.setReview(value);
                      },
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.done,
                      maxLines:
                          MediaQuery.of(context).size.height <= 640 ? 2 : 4,
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        hintText:
                            'Berikan review seperti "Makanan dan minumannya enak".',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      onSubmitted: (value) {
                        detailRestaurant.sendReview();
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).viewInsets.bottom > 100
                          ? 0
                          : 10,
                    ),
                    MediaQuery.of(context).viewInsets.bottom > 100
                        ? const SizedBox.shrink()
                        : Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    detailRestaurant.sendReview();
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Kirim'),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
