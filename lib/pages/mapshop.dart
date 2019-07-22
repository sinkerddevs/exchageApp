
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShopMap extends StatefulWidget {
  @override
  _ShopMapState createState() => _ShopMapState();
}

class _ShopMapState extends State<ShopMap> {
  CameraPosition _initialPosition = CameraPosition(target: LatLng(26.8206, 30.8025));
  Completer<GoogleMapController> _controller = Completer();


void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
}
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("ແຜນທີ່"),
      ),
      // body: Center(
      //   child: Container(
      //     height: MediaQuery.of(context).size.height,
      //     width: MediaQuery.of(context).size.width,
      //     child:   GoogleMap(
      //       mapType: MapType.none,
      //       initialCameraPosition: CameraPosition( 
      //         target: LatLng(17.974855, 102.630867),
      //         zoom: 11.0
      //         ),
      //       ),
      //   ),
      // ),
      body: Stack(
          children: <Widget>[
            GoogleMap(    
              onMapCreated: _onMapCreated,
              initialCameraPosition: _initialPosition,
            ),
          ],
        )
    );
  }
}