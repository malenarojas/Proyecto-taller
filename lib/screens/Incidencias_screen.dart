import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login/models/Incidencia.dart';

void main() => runApp(IncidenciasScreen());

class IncidenciasScreen extends StatefulWidget {
  @override
  _IncidenciasScreenState createState() => _IncidenciasScreenState();
}

class _IncidenciasScreenState extends State<IncidenciasScreen> {
  late Future<List<Incidencia>> _listadoIncidencias;

  Future<List<Incidencia>> _getIncidencias() async {
    var uri = Uri.parse("http://localhost:3001/api/v1/mobile/incidents");
    final response = await http.get(uri);
    List<Incidencia> Incidencias = [];
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for (var item in jsonData["data"]) {
        Incidencias.add(Incidencia(
            item["descripcion"],
            item["procedimiento"],
            item["latitudDispositivo"],
            item["longitudDispositivo"],
            item["latitudIncidencia"],
            item["longitudIncidencia"],
            item["idOperativo"],
            item["idCategoria"],
            item["idTipoIncidencia"]));
      }
      print(Incidencias);
      return Incidencias;

      // Aquí deberías procesar los datos recibidos y devolver una lista de Incidencia
    } else {
      throw Exception("Fallo la conexión");
    }
  }

  @override
  void initState() {
    super.initState();
    _listadoIncidencias = _getIncidencias();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: FutureBuilder(
          future: _listadoIncidencias,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: _listIncidencias(snapshot.data as List<Incidencia>),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text("Error");
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _listIncidencias(List<Incidencia> data) {
    List<Widget> Incidencias = [];
    for (var Incidencia in data) {
      Incidencias.add(Card(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(Incidencia.descripcion),
            )
          ],
        ),
      ));
    }
    return Incidencias;
  }
}
