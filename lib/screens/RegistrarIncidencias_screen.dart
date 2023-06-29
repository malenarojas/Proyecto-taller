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
  TextEditingController idUsarioController = TextEditingController();
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
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter longitud dispositivo'),
              controller: longitudDispositivoController,
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter latitud Incidencia'),
              controller: latitudDispositivoController,
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
              controller: idUsarioController,
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
                  hintText: 'Enter latitud Incidencia'),
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
}

Future<void> guardarRegistro() async {
  // Datos del registro
  String descripcion = "John Doe";
  String procedimiento = "johndoe@example.com";
  String latitudDispositivo = "-17.775589";
  String longitudDispositivo = "-63.196325";
  int latitudIncidencia = 0;
  int longitudIncidencia = 0;
  int idUsuario = 1;
  int idCategoria = 1;
  int idTipoInidencia = 1;

  // URL del endpoint del backend
  String url = "http://localhost:3001/api/v1/mobile/incidents";

  try {
    // Envío de los datos del registro al backend
    await http.post(
      Uri.parse(url),
      body: {
        'descripcion': descripcion,
        'procedimiento': procedimiento,
        'latitudDispositivo': latitudDispositivo,
        'longitudDispositivo': longitudDispositivo,
        'latitudIncidencia': latitudDispositivo,
        'longitudIncidencia': longitudDispositivo,
        'idOperativo': idUsuario,
        'idCategoria': idCategoria,
        'idTipoIncidencia': idTipoInidencia,
      },
    );
    print('Registro guardado exitosamente');
  } catch (error) {
    print('Error al guardar el registro: $error');
  }
}
