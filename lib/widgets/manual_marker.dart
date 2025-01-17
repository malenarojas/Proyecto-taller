
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:login/bloc/blocs.dart';
// import 'package:login/helpers/helpers.dart';

class ManualMarker extends StatelessWidget {
  const ManualMarker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _ManualMarkerBody();
  }
}

class _ManualMarkerBody extends StatelessWidget {
  const _ManualMarkerBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          const Positioned(top: 70, left: 20, child: _BtnBack()),

          Center(
            child: Transform.translate(
              offset: const Offset(0, -22),
              child: BounceInDown(
                  from: 100,
                  child: const Icon(Icons.location_on_rounded, size: 60)),
            ),
          ),

          // Boton de confirmar
          Positioned(
              bottom: 70,
              left: 40,
              child: FadeInUp(
                duration: const Duration(milliseconds: 300),
                child: MaterialButton(
                  minWidth: size.width - 120,
                  child: const Text('Confimar destino',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w300)),
                  color: Colors.black,
                  elevation: 0,
                  height: 50,
                  shape: const StadiumBorder(),
                  onPressed: () async {
                    // Todo: loading

                    mapBloc.ubiDispositivo = locationBloc.state.lastKnownLocation;
                    if (mapBloc.ubiDispositivo == null) return;

                    final end = mapBloc.mapCenter;
                    if (end == null) return;
                    debugPrint("start = " + mapBloc.ubiDispositivo.toString());
                    debugPrint("end = " + end.toString());

                    // showLoadingMessage(context);

                    // final destination =
                    //     await searchBloc.getCoorsStartToEnd(start, end);
                    // await mapBloc.drawRoutePolyline(destination);

                    // searchBloc.add(OnDeactivateManualMarkerEvent());

                    Navigator.pop(context);
                  },
                ),
              )),
        ],
      ),
    );
  }
}

class _BtnBack extends StatelessWidget {
  const _BtnBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 300),
      child: CircleAvatar(
        maxRadius: 30,
        backgroundColor: Colors.white,
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            // BlocProvider.of<SearchBloc>(context)
            //     .add(OnDeactivateManualMarkerEvent());
          },
        ),
      ),
    );
  }
}
