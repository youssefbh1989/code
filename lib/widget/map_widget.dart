import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/constants.dart';
import '../models/salonmodels.dart';

class Map_widget extends StatefulWidget {
  final SalonModel salon;
  const Map_widget({Key key, this.salon}) : super(key: key);

  @override
  State<Map_widget> createState() => _Map_widgetState();
}

class _Map_widgetState extends State<Map_widget> {
  void openMaps(LatLng ltn) async {
    final lat = widget.salon.lat != null && widget.salon.lat != .0 ? widget.salon.lat : 25.287215;
    final lng = widget.salon.lng != null && widget.salon.lng != .0 ? widget.salon.lng : 51.535910;
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(googleUrl) == null) {
      throw 'Could not open the map.';
    } else {
      await launch(googleUrl);
    }
  }

  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.w),
            child: widget.salon.lng != 0
                ? Row(
              children: [
                heightSpace,
                Expanded(
                  child: Container(
                    height: 18.h,
                    decoration: BoxDecoration(
                      color: greyColor,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: ClipPath(
                      clipper: ShapeBorderClipper(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10)),
                      ),
                      child: GoogleMap(
                        mapType: MapType.terrain,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                              widget.salon.lat ?? 25.287215,
                              widget.salon.lng ?? 51.535910),
                          zoom: 14.4746,
                        ),
                        markers: widget.salon.lat != null &&
                            widget.salon.lat != .0
                            ? {
                          Marker(
                            position: LatLng(widget.salon.lat,
                                widget.salon.lng),
                            markerId: const MarkerId('pos'),
                          )
                        }
                            : (<Marker>{}),
                        onMapCreated:
                            (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                        onTap: openMaps,
                      ),
                    ),
                  ),
                ),
              ],
            )
                : Container())
      ],
    );
  }
}
