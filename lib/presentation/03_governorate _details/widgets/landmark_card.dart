import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../app/functions.dart';
import '../../../domain/entities/governrate_model.dart';
import '../../resourses/colors_manager.dart';
import '../../resourses/language_manager.dart';
import '../../resourses/styles_manager.dart';

class LandmarkCard extends StatefulWidget {
  const LandmarkCard({
    super.key,
    required this.landmark,
  });

  final Landmark landmark;

  @override
  State<LandmarkCard> createState() => _LandmarkCardState();
}

class _LandmarkCardState extends State<LandmarkCard> {
  late final LatLng landmarkLocation;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    super.initState();
    landmarkLocation = LatLng(
        double.parse(widget.landmark.lat), double.parse(widget.landmark.lng));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        spacing: 16.0,
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.landmark.image),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    ColorsManager.black.withValues(alpha: 0.5),
                    BlendMode.darken),
              ),
              boxShadow: [BoxShadow(color: ColorsManager.black, blurRadius: 6)],
            ),
            child: Align(
              alignment: LocalizationUtils.isCurrentLocalAr(context)
                  ? Alignment.bottomRight
                  : Alignment.bottomLeft,
              child: Text(
                widget.landmark.name,
                style: Styles.style24Bold().copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          RichText(
              text: TextSpan(
            text: widget.landmark.description,
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
                  CameraPosition(target: landmarkLocation, zoom: 12),
              markers: {
                Marker(
                  markerId: MarkerId("${widget.landmark.name}_marker"),
                  position: landmarkLocation,
                  infoWindow: InfoWindow(
                    title: widget.landmark.name,
                    snippet: widget.landmark.name,
                  ),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
