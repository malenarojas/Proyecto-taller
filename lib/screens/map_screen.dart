/*import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  GoogleMapController mapController;
  Map<MarkerId,Marker> markres=<MarkerId,Marker>{};
  final location= new Location().getLocation();
  LocationData pinPos;
  LocationData actualLocation;

  void _onMapCreated(GoogleMapController controller){
    mapController= controller;
    _add(LatLng(pinPos.latitude, pinPos.longitude));
  }

  @override
  Widget build(BuildContext context) {
    final lugarProvider=Provider.of<LugarProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('seleciones una ubicacion'),),
      floatingActionButton: _floatingButtons(context,lugarProvider),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      body: _createMap(),
    );
  }

  Widget _createMap(){
    return FutureBuilder(
      future: location,
      builder: (BuildContext context,AsyncSnapshot<LocationData>(context, snapshot) {
        if(snapshot.hasData){
          final pos = snapshot.data;
          pinPos =pos;
          actualLocation= pos;
          return SafeArea(child: GoogleMap(
            onMapCreated: _onMapcreated,
            myLocalitationEnabled: true,
            initialCameraPosition: CameraPosition(
              target:Latting(pos.latitude,pos.longitude),
              zoom: 15
            ),
            markers:Set<Marker>.of(markers.values),

          ),
          );

        }
        else {
          return Center(chil: LinearProgressIndicador());
        }
        
      }
      )
      );
  }
  void _add(LatLng latLng){
    final MarkerId markerId = MarkerId('normal');
    final marker=Marker(markerId: markerId,draggable: true,onDrag: (latLng){
      pinPos =   new LocationData.fromMap({
        'latitude':latLng.latitude,
        'longitude':latLng.latitude,
      });
    },
    position: latLng,
    infoWindow: InfoWindow(title: 'Lugar',snippet: 'aqui se ubica el sitio,'),
    onTap: () {
      
    },
    );
  }



}