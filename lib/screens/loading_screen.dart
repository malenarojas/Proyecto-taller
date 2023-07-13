import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/bloc/blocs.dart';
import 'package:login/screens/screens.dart';
// import 'package:hackathon_user_app/presentation/screens/map_screen.dart';
// import 'package:hackathon_user_app/presentation/views/MenuOptions.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<GpsBloc, GpsState>(
      builder: (context, state) {
        return state.isAllGranted ? const MapScreen() : const GpsAccessScreen();
      },
    ));
  }
}
