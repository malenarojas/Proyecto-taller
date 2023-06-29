import 'package:flutter/material.dart';
import 'package:login/screens/Incidencias_screen.dart';
import 'package:login/screens/actividad1_screen.dart';
import 'package:login/screens/actividad_screen.dart';
import 'package:login/screens/home_screen.dart';
import 'package:login/screens/login_screen.dart';
import 'package:login/screens/message_screens.dart';
import 'package:login/screens/status_screen.dart';
import 'package:login/services/push_notifications_service.dart';
import 'package:login/services/socket_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey =
      new GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();

    //context
    PushNotificationService.messagesStream.listen((message) {
      print('MyApp: $message');
      navigatorKey.currentState?.pushNamed('message', arguments: message);

      final snackBar = SnackBar(content: Text(message));
      messengerKey.currentState?.showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => SocketService())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'Login',
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: messengerKey,
        routes: {
          'Login': (context) => const LoginScreen(),
          'Incidencia': (context) => IncidenciasScreen(),
          'Home': (context) => const HomeScreen(),
          'message': (context) => message_screen(),
          'actividad': (context) => const actividad_screen(),
          'status': (context) => status_screen(),
          'actividad1': (context) => actividad1_screen()
        },
      ),
    );
  }
}
