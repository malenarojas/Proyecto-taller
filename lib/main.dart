import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/bloc/blocs.dart';
import 'package:login/screens/Facial_screen.dart';
import 'package:login/screens/Incidencias_screen.dart';
import 'package:login/screens/RegistrarIncidencias_screen.dart';
import 'package:login/screens/actividad1_screen.dart';
import 'package:login/screens/actividad_screen.dart';
import 'package:login/screens/home_screen.dart';
import 'package:login/screens/login_screen.dart';
import 'package:login/screens/map_screen.dart';
import 'package:login/screens/message_screens.dart';
import 'package:login/screens/status_screen.dart';
//import 'package:login/services/push_notifications_service.dart';
import 'package:login/services/socket_service.dart';
import 'package:login/widgets/drawer_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GpsBloc()),
        BlocProvider(create: (context) => LocationBloc()),
        BlocProvider(create: (context) => MapBloc()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => SocketService())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'Login',
        // navigatorKey: navigatorKey,
        // scaffoldMessengerKey: messengerKey,º
        routes: {
          'drawer':(context) =>  MainPage(),
          'Login': (context) => const LoginScreen(),
          'Incidencia': (context) => IncidenciasScreen(),
          'Home': (context) => const HomeScreen(),
          'message': (context) => message_screen(),
          'actividad': (context) => const actividad_screen(),
          'status': (context) => status_screen(),
          'actividad1': (context) => const actividad1_screen(),
          'map': (context) => const MapScreen(),
          'Facial':(context) => const FacialScreen(),
          'Registrar Incidencias' :(context) => RegistrarIncidenciasScreen(),
        },
      ),
    );
  }
}
