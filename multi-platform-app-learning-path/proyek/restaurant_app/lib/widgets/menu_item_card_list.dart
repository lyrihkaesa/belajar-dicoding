import 'package:flutter/material.dart';

class MenuItemCardList extends StatefulWidget {
  final List<dynamic> items;
  final Icon? icon;
  final Text? title;

  const MenuItemCardList({
    Key? key,
    required this.items,
    this.icon,
    this.title,
  }) : super(key: key);

  @override
  State<MenuItemCardList> createState() => _MenuItemCardListState();
}

class _MenuItemCardListState extends State<MenuItemCardList> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title ?? Container(),
        const SizedBox(
          height: 10,
        ),
        Scrollbar(
          thumbVisibility: true,
          controller: _scrollController,
          child: Container(
            padding: const EdgeInsets.only(bottom: 10),
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  child: SizedBox(
                    width: 100,
                    child: Stack(
                      children: [
                        Center(
                          child: widget.icon ??
                              const Icon(
                                Icons.emoji_food_beverage_rounded,
                                size: 50,
                                color: Colors.black12,
                              ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.items[index].name,
                                style: const TextStyle(
                                  fontSize: 12,
                                  height: 1.1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
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
