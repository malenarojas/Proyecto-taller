import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:login/bloc/blocs.dart';

class MapView extends StatelessWidget {

  final LatLng initialLocation;

  const MapView({ 
    Key? key, 
    required this.initialLocation 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final mapBloc = BlocProvider.of<MapBloc>(context);

    final CameraPosition initialCameraPosition = CameraPosition(
        target: initialLocation,
        zoom: 15
    );

    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        compassEnabled: false,
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,

        onMapCreated: ( controller ) => mapBloc.add( OnMapInitialzedEvent(controller) ),
        onCameraMove: ( position ) => mapBloc.mapCenter = position.target
        // TODO: Markers
        // TODO: polylines
        // TODO: Cuando se mueve el mapa
      ),
    );
  }
}