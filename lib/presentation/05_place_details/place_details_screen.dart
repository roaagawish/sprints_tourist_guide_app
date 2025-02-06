import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../app/functions.dart';
import '../../domain/entities/place_entity.dart';
import '../resourses/colors_manager.dart';
import '../resourses/language_manager.dart';
import '../resourses/styles_manager.dart';

class PlaceDetailsScreen extends StatefulWidget {
  const PlaceDetailsScreen({
    super.key,
    required this.place,
  });

  final PlaceEntity place;

  @override
  State<PlaceDetailsScreen> createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  late final LatLng placeLocation;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    super.initState();
    placeLocation = LatLng(
        double.parse(widget.place.lat!), double.parse(widget.place.lng!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.place.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 16.0,
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.place.image),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        ColorsManager.black.withValues(alpha: 0.5),
                        BlendMode.darken),
                  ),
                  boxShadow: [
                    BoxShadow(color: ColorsManager.black, blurRadius: 6)
                  ],
                ),
                child: Align(
                  alignment: LocalizationUtils.isCurrentLocalAr(context)
                      ? Alignment.bottomRight
                      : Alignment.bottomLeft,
                  child: Text(
                    widget.place.name,
                    style: Styles.style24Bold().copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              RichText(
                  text: TextSpan(
                text: widget.place.description,
                style: Styles.style14Medium().copyWith(
                    color: isLightTheme(context)
                        ? ColorsManager.black
                        : ColorsManager.white),
              )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                child: GoogleMap(
                  mapType: MapType.hybrid,
                  onMapCreated: _onMapCreated,
                  initialCameraPosition:
                      CameraPosition(target: placeLocation, zoom: 12),
                  markers: {
                    Marker(
                      markerId: MarkerId("${widget.place.name}_marker"),
                      position: placeLocation,
                      infoWindow: InfoWindow(
                        title: widget.place.name,
                        snippet: widget.place.governorate,
                      ),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueRed),
                    ),
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
