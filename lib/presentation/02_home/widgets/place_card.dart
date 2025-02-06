import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/place_entity.dart';
import '../../01_auth_screens/bloc/auth_bloc.dart';
import '../../resourses/assets_manager.dart';
import '../../resourses/routes_manager.dart';
import '../../resourses/styles_manager.dart';
import '../blocs/like_unlike_cubit/like_unlike_cubit.dart';

class PlaceCard extends StatefulWidget {
  final PlaceEntity place;

  const PlaceCard({
    super.key,
    required this.place,
  });

  @override
  State<PlaceCard> createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  late bool liked;
  @override
  void initState() {
    super.initState();
    liked = widget.place.likes.contains(context.read<AuthBloc>().authObj!.uid);
  }

  @override
  void didUpdateWidget(covariant PlaceCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Check if the place has changed
    if (oldWidget.place != widget.place) {
      // Update the liked state based on the new place data
      setState(() {
        liked =
            widget.place.likes.contains(context.read<AuthBloc>().authObj!.uid);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                widget.place.image.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: widget.place.image,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.error, color: Colors.red),
                                Text(
                                  'Failed_to_load_image'.tr(),
                                  style: Styles.style14Medium(),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : Image.asset(
                        PngAssets.cairo, //dummy img
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: Icon(
                      (liked) ? Icons.favorite : Icons.favorite_border,
                      color: (liked) ? Colors.red : Colors.white,
                    ),
                    onPressed: () {
                      // for immediate effect.
                      setState(() {
                        liked = !liked;
                      });
                      // for acutual effect in database
                      BlocProvider.of<LikeUnlikeCubit>(context)
                          .toggle(place: widget.place);
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  Routes.placeDetailsRoute,
                  arguments: widget.place,
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
                    child:
                        Text(widget.place.name, style: Styles.style14Medium()),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
                    child: Text(widget.place.governorate,
                        style: Styles.style12Medium()),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
