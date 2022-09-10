import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';

class CategoryItemCardList extends StatefulWidget {
  final List<dynamic> items;

  const CategoryItemCardList({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  State<CategoryItemCardList> createState() => _CategoryItemCardListState();
}

class _CategoryItemCardListState extends State<CategoryItemCardList> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      controller: _scrollController,
      child: SizedBox(
        height: 32,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            return Card(
              color: primaryColorSoft,
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    widget.items[index].name,
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1.1,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
