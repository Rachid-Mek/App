import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late GoogleMapController googleMapController;
  Completer<GoogleMapController> _controller = Completer();
  static final Marker _kGooglePlexMarker = Marker(
    markerId: MarkerId('id2'),
    position: LatLng(36.76899724856483, 3.055379301043981),
  );

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(36.76899724856483, 3.055379301043981),
    zoom: 17.4746,
  );
  Set<Marker> markers = {_kGooglePlexMarker};
  Set<Polyline> _polyline = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  late LatLng currentLocation;
  late LatLng destinationLocation;
  @override
  void initState() {
    super.initState();
    polylinePoints = PolylinePoints();
    this.setInitialLocation();
  }

  void setInitialLocation() {
    currentLocation = LatLng(36.64338524731625, 2.994335786188303);
    destinationLocation = LatLng(36.76899724856483, 3.055379301043981);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        zoomControlsEnabled: false,
        initialCameraPosition: _kGooglePlex,
        markers: markers,
        polylines: _polyline,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
          setPolylines();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Position position = await _determinePostion();
          googleMapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 11)));
          markers.clear();

          markers.add(_kGooglePlexMarker);
          markers.add(
            Marker(
              markerId: const MarkerId("id3"),
              position: LatLng(position.latitude, position.longitude),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue),
            ),
          );
          setPolylines();
          setState(() {});
        },
        label: Text("ma location"),
        icon: Icon(Icons.my_location),
      ),
    );
  }

  Future<Position> _determinePostion() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("service Location est desactiver");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Permission refusée");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Permision refusée en permanant");
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  }

  void setPolylines() async {
    Position position = await _determinePostion();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyCN8om-kEQO1reZ-ry3aT55PiV2GQYf0mA",
      PointLatLng(36.64338524731625, 2.994335786188303),
      PointLatLng(position.latitude, position.longitude),
    );
    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      });
      setState(() {
        _polyline.add(Polyline(
          polylineId: const PolylineId("polyline"),
          width: 5,
          color: Color(0xFF08A5CB),
          points: polylineCoordinates,
        ));
      });
    }
  }
}
