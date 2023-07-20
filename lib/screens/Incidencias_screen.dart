import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login/config/constants.dart';
import 'package:login/models/Incidencia.dart';
import 'package:login/screens/RegistrarIncidencias_screen.dart';

void main() => runApp(IncidenciasScreen());

class IncidenciasScreen extends StatefulWidget {
  @override
  _IncidenciasScreenState createState() => _IncidenciasScreenState();
}

class _IncidenciasScreenState extends State<IncidenciasScreen> {
  late Future<List<Incidencia>> _listadoIncidencias;

  Future<List<Incidencia>> _getIncidencias() async {
    try {
      var uri = Uri.parse("${Constants.API_URL}/incidencias");
      final response = await http.get(uri);
      List<Incidencia> Incidencias = [];
      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(body);

        for (var item in jsonData["data"]) {
          print('item["zona"]["nombre"]: ${item["zona"]["nombre"]}');
          Incidencias.add( Incidencia(
              item["idIncidencia"],
              item["descripcion"],
              item["procedimiento"],
              item["latitudDispositivo"].toDouble(),
              item["longitudDispositivo"].toDouble(),
              item["latitudIncidencia"].toDouble(),
              item["longitudIncidencia"].toDouble(),
              item["idOperativo"],
              item["idCategoriaIncidencia"],
              item["idTipo"],
              item["idDenuncia"],
              item["idZona"],
              item["zona"]["nombre"],
              item["imagenes"],
              item["createdAt"]));
        }
        return Incidencias;
      } else {
        throw Exception("Fallo la conexión");
      }
    } catch (e) {
      print('Se produjo un error: $e'
      );
      throw Exception(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    print("ELIOOOOOT");
    _listadoIncidencias = _getIncidencias();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Lista de incidencias'),
        ),
        body: FutureBuilder(
          future: _listadoIncidencias,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return RefreshIndicator(
                  child: ListView(
                    children:
                        _listIncidencias(snapshot.data as List<Incidencia>),
                  ),
                  onRefresh: () async {
                    setState(() {
                      _listadoIncidencias = _getIncidencias();
                    });
                  });
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text("Error");
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RegistrarIncidenciasScreen()),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  List<Widget> _listIncidencias(List<Incidencia> data) {
    List<Widget> incidencias = [];
    List<String> incidenciasImagenes = [
      'images/Incidencia1.jpeg',
      'images/Incidencia2.jpeg',
      'images/Incidencia3.jpeg',
      'images/Incidencia4.jpeg',
      'images/Incidencia5.jpeg',
      'images/Incidencia6.jpeg',
    ];

    for (var incidencia in data) {
      int indexRandomImage = (0 + Random().nextInt(5 - 0 + 1)).toInt();
      incidencias.add(
        Card(
          margin: EdgeInsets.only(top: 16, left: 16, right: 16),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Imagen de la Incidencia
                Container(
                    height: 350,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: Image.asset(incidenciasImagenes[indexRandomImage]),
                    )),
                // IdIncidencia
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "INCIDENCIA #${incidencia.idIncidencia.toString()}",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              "${incidencia.zona}",
                              textAlign: TextAlign.left,
                              style: const TextStyle(fontSize: 14),
                            )
                          ],
                        ),
                      ),
                      Chip(
                        backgroundColor: Colors.orange.shade700,
                        label: const Text(
                          'CREADO',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                // Descripción
                Padding(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
                  child: Text(
                    incidencia.descripcion,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return incidencias;
  }
}