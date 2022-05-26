import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong2/latlong.dart' as latLng;
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mapbox_navigation/library.dart';

class MapApp extends StatefulWidget {
  double lant;
  double long;
  MapApp({Key? key, required this.lant, required this.long}) : super(key: key);
  @override
  State<MapApp> createState() => MapSampleState();
}

class MapSampleState extends State<MapApp> {
  String _platformVersion = 'Unknown';
  String _instruction = "";

  late final _destination;
  late final _origin;

  late MapBoxNavigation _directions;
  late MapBoxOptions _options;

  bool _isMultipleStop = false;
  late MapBoxNavigationViewController _controller;
  bool _routeBuilt = false;
  bool _isNavigating = false;

  static late final Marker pharmacieMarker;
  static late var cameraPosition;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _destination = WayPoint(
        name: "Way Point 1", latitude: widget.lant, longitude: widget.long);
    pharmacieMarker = Marker(
      width: 80.0,
      height: 80.0,
      point: latLng.LatLng(widget.lant, widget.long),
      builder: (ctx) => Container(
        child: IconButton(
          icon: Icon(Icons.location_on),
          color: Colors.red,
          iconSize: 45,
          onPressed: () {
            print("pressed");
          },
        ),
      ),
    );
    cameraPosition = latLng.LatLng(widget.lant, widget.long);
    initialize();
  }

  Future<void> initialize() async {
    if (!mounted) return;

    _directions = MapBoxNavigation(onRouteEvent: _onEmbeddedRouteEvent);
    _options = MapBoxOptions(
        zoom: 200.0,
        tilt: 0.0,
        bearing: 0.0,
        enableRefresh: false,
        alternatives: true,
        voiceInstructionsEnabled: true,
        bannerInstructionsEnabled: true,
        allowsUTurnAtWayPoints: true,
        mode: MapBoxNavigationMode.drivingWithTraffic,
        units: VoiceUnits.imperial,
        simulateRoute: false,
        animateBuildRoute: true,
        longPressDestinationEnabled: true,
        language: "fr");

    String platformVersion;
    try {
      platformVersion = await _directions.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FlutterMap(
        options: MapOptions(
          center: cameraPosition,
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/karimbelhadj/cl3lnvuaw005215oezs4rcvi3/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoia2FyaW1iZWxoYWRqIiwiYSI6ImNsM2xudDJnMTFvYjIzY3F3cHI5MWNzeWwifQ.F16uNpZ7BjWO_NTa7hjM_w",
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1Ijoia2FyaW1iZWxoYWRqIiwiYSI6ImNsM2xudDJnMTFvYjIzY3F3cHI5MWNzeWwifQ.F16uNpZ7BjWO_NTa7hjM_w',
              'id': 'mapbox.mapbox-streets-v8',
            },
            attributionBuilder: (_) {
              return Text("© OpenStreetMap contributors");
            },
          ),
          MarkerLayerOptions(
            markers: [pharmacieMarker],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          bool serviceEnabled;
          LocationPermission permission;

          serviceEnabled = await Geolocator.isLocationServiceEnabled();
          if (!serviceEnabled) {
            return Future.error('Location services are disabled');
          } else {
            permission = await Geolocator.checkPermission();
            if (permission == LocationPermission.denied) {
              permission = await Geolocator.requestPermission();
              if (permission == LocationPermission.denied) {
                return Future.error('Location permissions are denied');
              } else {
                var position = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high);
                _origin = WayPoint(
                    name: "Way Point 2",
                    latitude: position.latitude,
                    longitude: position.longitude);

                var wayPoints = <WayPoint>[];
                wayPoints.add(_origin);
                wayPoints.add(_destination);

                await _directions.startNavigation(
                    wayPoints: wayPoints, options: _options);
              }
            }
            if (permission == LocationPermission.deniedForever) {
              return Future.error(
                  'Location permissions are permanently denied, we cannot request permissions.');
            } else {
              var position = await Geolocator.getCurrentPosition(
                  desiredAccuracy: LocationAccuracy.high);
              _origin = WayPoint(
                  name: "Way Point 2",
                  latitude: position.latitude,
                  longitude: position.longitude);

              var wayPoints = <WayPoint>[];
              wayPoints.add(_origin);
              wayPoints.add(_destination);

              await _directions.startNavigation(
                  wayPoints: wayPoints, options: _options);
            }
          }
        },
        label: Text('itineraire depuis votre position'),
        icon: Icon(Icons.directions),
      ),
    );
  }

  /********************************************************* */
  Future<void> _onEmbeddedRouteEvent(e) async {
    switch (e.eventType) {
      case MapBoxEvent.progress_change:
        var progressEvent = e.data as RouteProgressEvent;
        if (progressEvent.currentStepInstruction != null)
          _instruction = progressEvent.currentStepInstruction.toString();
        break;
      case MapBoxEvent.route_building:
      case MapBoxEvent.route_built:
        setState(() {
          _routeBuilt = true;
        });
        break;
      case MapBoxEvent.route_build_failed:
        setState(() {
          _routeBuilt = false;
        });
        break;
      case MapBoxEvent.navigation_running:
        setState(() {
          _isNavigating = true;
        });
        break;
      case MapBoxEvent.on_arrival:
        if (!_isMultipleStop) {
          await Future.delayed(Duration(seconds: 3));
          await _controller.finishNavigation();
        } else {}
        break;
      case MapBoxEvent.navigation_finished:
      case MapBoxEvent.navigation_cancelled:
        setState(() {
          _routeBuilt = false;
          _isNavigating = false;
        });
        break;
      default:
        break;
    }
    setState(() {});
  }
}
