import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../config/constants.dart';
import 'defaults.dart';

var indexClicked = 0;

class MainPage extends StatefulWidget {
  @override
  final String codigo;
  final String contrasena;

   MainPage({required this.codigo, required this.contrasena});
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {


  void sendPostRequest() async {
    // Construir el cuerpo de la solicitud POST en formato JSON
    Map<String, dynamic> requestBody = {
      'idUsuario': 6,
    };
    String jsonBody = json.encode(requestBody);

    try {
      // Realizar la solicitud POST
      String urls = "${Constants.API_URL}/emergencia";
      Uri url = Uri.parse(urls);
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonBody,
      );

      // Verificar la respuesta del servidor
      if (response.statusCode == 200) {
        // La solicitud fue exitosa, aquí puedes manejar la respuesta del servidor si es necesario
        print('Solicitud POST exitosa');
      } else {
        // La solicitud falló, aquí puedes manejar el error si es necesario
        print('Error en la solicitud POST: ${response.statusCode}');
      }
    } catch (e) {
      // Error de conexión o excepción, aquí puedes manejar el error si es necesario
      print('Error en la solicitud POST: $e');
    }
  }

  late List<Widget> pages;
  bool showButton = false;

  void initState() {
    super.initState();
   showResultPage(widget.codigo);
   pages = [
     Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Text('Bienvenido ${widget.codigo}'),
            showButton // Mostrar el botón si showButton es true
                ? FloatingActionButton.extended(
              onPressed: () {
                sendPostRequest();
              },
              label: Text('Botón de Emergencia'),
              icon: Icon(Icons.done),
              backgroundColor: Colors.red, // Color de fondo rojo
            )
                : Container(),
          ],
        ),
      ),
    const Center(
      child: Text('Registrar Incidencias'),
    ),
    const Center(
      child: Text('Registrar ubicacion'),
    ),
    const Center(
      child: Text('Boton alert'),
    ),
    const Center(
      child: Text('Trash'),
    ),
    const Center(
      child: Text('Spam'),
    ),
  ];
}
void updateState(int index) {
  setState(() {
    indexClicked = index;
  });
  Navigator.pop(context);
}

 bool isValidNumber(String number) {
    // Aquí puedes agregar tus propias condiciones de validación
    // Por ejemplo, validar si el número es un número entero positivo
    try {
      int parsedNumber = int.parse(number);
      return parsedNumber > 0;
    } catch (e) {
      return false;
    }
  }

  void showResultPage(String codigo) {
    String number = '218099282'; // Reemplaza esto por el número encontrado
    bool isValid = isValidNumber(number);

    if (isValid) {
      setState(() {
        showButton = true; // Mostrar el botón si el número es válido
      });
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Número no válido'),
            content: Text('El número encontrado no es válido.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
     final codigo = widget.codigo; // Crear una variable local para 'codigo'
    final contrasena = widget.contrasena;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Incidencias Encontradas',
        ),
      ),
      body: pages[indexClicked],
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('images/drawer.jpg'),
                ),
              ),
              padding: EdgeInsets.all(0),
              child: Container(
                child: const Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    CircleAvatar(
                      radius: 42,
                      backgroundImage: AssetImage('images/profile.jpg'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'John Rambo',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'john@rambo.com',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  AppDrawerTile(
                    index: 0,
                    onTap: ()=> Navigator.pushReplacementNamed(context, 'Facial'),
                  ),
                  AppDrawerTile(
                    index: 1,
                    onTap: ()=> Navigator.pushReplacementNamed(context, 'Registrar Incidencias'),
                  ),
                  AppDrawerTile(
                    index: 2,
                    onTap: ()=> Navigator.pushReplacementNamed(context, ''),
                  ),
                  AppDrawerTile(
                    index: 3,
                    onTap: ()=> Navigator.pushReplacementNamed(context, 'Home'),
                  ),
                  AppDrawerTile(
                    index: 4,
                    onTap: ()=> Navigator.pushReplacementNamed(context, 'Home'),
                  ),
                  AppDrawerTile(
                    index: 5,
                    onTap: ()=> Navigator.pushReplacementNamed(context, 'Home'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                   AppDrawerDivider(),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      'JetMail',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        fontSize: 20,
                        color: Defaults.drawerItemSelectedColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      'Version 1.2.5',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                        color: Defaults.drawerItemColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                 AppDrawerDivider(),
                ],
              ),
            ),
          ],
        ),
      ),
      
    );
  }
}

class AppDrawerDivider extends StatelessWidget {
  const AppDrawerDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: Defaults.drawerItemColor,
      indent: 3,
      endIndent: 3,
    );
  }
}

class AppDrawerTile extends StatelessWidget {
  const AppDrawerTile({
    Key? key,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  final int index;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        onTap: onTap,
        selected: indexClicked == index,
        selectedTileColor: Defaults.drawerSelectedTileColor,
        leading: Icon(
          Defaults.drawerItemIcon[index],
          size: 35,
          color: indexClicked == index
              ? Defaults.drawerItemSelectedColor
              : Defaults.drawerItemColor,
        ),
        title: Text(
          Defaults.drawerItemText[index],
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: indexClicked == index
                ? Defaults.drawerItemSelectedColor
                : Defaults.drawerItemColor,
          ),
        ),
      ),
    );
  }
}