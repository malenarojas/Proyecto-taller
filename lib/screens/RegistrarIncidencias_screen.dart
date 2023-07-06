import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(RegistrarIncidenciasScreen());

class RegistrarIncidenciasScreen extends StatefulWidget {
  //ResgistrarIncidencia{Key key,th}

  @override
  _RegistrarIncidenciasScreenState createState() =>
      _RegistrarIncidenciasScreenState();
}

class _RegistrarIncidenciasScreenState
    extends State<RegistrarIncidenciasScreen> {
  TextEditingController descripcionController = TextEditingController();
  TextEditingController procedimientoController = TextEditingController();
  TextEditingController latitudDispositivoController = TextEditingController();
  TextEditingController longitudDispositivoController = TextEditingController();
  TextEditingController latitudIncidenciaController = TextEditingController();
  TextEditingController longitudIncidenciaController = TextEditingController();
  TextEditingController idUsuarioController = TextEditingController();
  TextEditingController idCategoriaController = TextEditingController();
  TextEditingController idTipoIncidenciaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter descripcion'),
              controller: descripcionController,
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter procemiento'),
              controller: procedimientoController,
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter latitud dispositivo'),
              controller: latitudDispositivoController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter longitud dispositivo'),
              controller: longitudDispositivoController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter latitud Incidencia'),
              controller: latitudIncidenciaController,
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter latitud Incidencia'),
              controller: longitudIncidenciaController,
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter id del Usuario'),
              controller: idUsuarioController,
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Categoria Incidencia'),
              controller: idCategoriaController,
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter tipo de incidencia'),
              controller: idTipoIncidenciaController,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  guardarRegistro();
                },
                child: Text("guardar Incidencia"))
          ],
        ),
      ),
    );
  }

  Future<void> guardarRegistro() async {
    //Datos del registro
    String descripcion = descripcionController.text;
    String procedimiento = procedimientoController.text;
    String latitudDispositivo = latitudDispositivoController.text;
    String longitudDispositivo = longitudDispositivoController.text;
    String latitudIncidencia = latitudIncidenciaController.text;
    String longitudIncidencia = longitudIncidenciaController.text;
    String idUsuario = idUsuarioController.text;
    String idCategoria = idCategoriaController.text;
    String idTipoIncidencia = idTipoIncidenciaController.text;

    // URL del endpoint del backend
    String url = "http://172.20.168.129:3001/api/v1/mobile/incidents";

    try {
      // Envío de los datos del registro al backend
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'jwt':
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZFVzdWFyaW8iOjEsImNvZGlnbyI6IjQzOTg4NzY3IiwiaWF0IjoxNjg4MDc1MTg4fQ.BfOyD4vfupHN2wYfQyp3BlJhYEORRLvZw9avsvaPCeY"
      };
      Map<String, String> body = {
        'descripcion': descripcion,
        'procedimiento': procedimiento,
        'latitudDispositivo': latitudDispositivo,
        'longitudDispositivo': longitudDispositivo,
        'latitudIncidencia': latitudIncidencia,
        'longitudIncidencia': longitudIncidencia,
        'idOperativo': idUsuario,
        'idCategoria': idCategoria,
        'idTipoIncidencia': idTipoIncidencia,
      };

      print('Enviando body: $body');
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );
      print(response);
      if (response.statusCode == 200) {
        // Éxito en la solicitud
        print('Registro guardado correctamente');
      } else {
        // Error en la solicitud
        print('Error al guardar el registro: ${response.statusCode}');
      }

      print('Registro guardado exitosamente');
      print('Respuesta del servidor: ${response.body}');
    } catch (error) {
      print('Error al guardar el registro: $error');
    }
  }
}
