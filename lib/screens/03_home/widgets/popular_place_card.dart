import 'package:flutter/material.dart';
import '../../../models/place_model.dart';
import '../../../resourses/styles_manager.dart';

class PopularPlaceCard extends StatefulWidget {
  final Place place;

  const PopularPlaceCard({
    super.key,
    required this.place,
  });

  @override
  State<PopularPlaceCard> createState() => _PopularPlaceCardState();
}

class _PopularPlaceCardState extends State<PopularPlaceCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(
                widget.place.image,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: Icon(
                    widget.place.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: widget.place.isFavorite ? Colors.red : Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.place.isFavorite = !widget.place.isFavorite;
                    });
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.0,
              children: [
                Text(widget.place.name, style: Styles.style14Medium()),
                Text(widget.place.governorate, style: Styles.style12Medium()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
