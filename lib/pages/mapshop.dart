
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShopMap extends StatefulWidget {
  @override
  _ShopMapState createState() => _ShopMapState();
}

class _ShopMapState extends State<ShopMap> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(17.9640988, 102.6133707);
  final Set<Marker> _marker = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMaptype = MapType.normal;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("ແຜນທີ່"),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:   GoogleMap(
            // onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(17.974855, 102.630867),
              zoom: 11.0
              ),
              ),
        
        ),
        
      ),
    );
  }
}