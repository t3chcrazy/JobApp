import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:itjobs/models/Location.dart';
import 'package:latlong/latlong.dart';

class LocationPage extends StatelessWidget {

  final Location jobLocation;

  LocationPage({this.jobLocation});

  @override
  Widget build(BuildContext context) {

    final centerLocation = Marker(
      width: 10,
      height: 10,
      builder: (context) => Icon(Icons.location_on, color: Colors.green),
      point: LatLng(jobLocation.latitude, jobLocation.longitude)
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: FlutterMap(
            options: MapOptions(
              center: LatLng(51.5, -0.09),
              zoom: 1.0,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
                // For example purposes. It is recommended to use
                // TileProvider with a caching and retry strategy, like
                // NetworkTileProvider or CachedNetworkTileProvider
                tileProvider: CachedNetworkTileProvider(),
              ),
              MarkerLayerOptions(markers: [centerLocation])
            ],
          ),
        )
      ],
    );
  }
}