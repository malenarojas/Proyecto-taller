import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login/config/constants.dart';

import '../models/Estamento.dart';
import '../models/Tipo.dart';
import '../models/Zona.dart';
import '../models/categoria.dart';

void main() => runApp(RegistrarIncidenciasScreen());

class RegistrarIncidenciasScreen extends StatefulWidget {
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
  TextEditingController idZonaController = TextEditingController();

  Estamento? selectedEstamento;
  List<Estamento> estamentos = [
    Estamento(4, "Malena Rojas", 218044322),
    Estamento(6, "Maria Angélica Miranda Mendoza", 218123821),
  ];
  Categoria? selectedCategoria;
  List<Categoria> categorias = [
    Categoria(1, "Normal"),
    Categoria(2, "Foraneo"),
  ];
  Tipo? selectedTipo;
  List<Tipo> tipos = [
    Tipo(1, "Robo"),
    Tipo(2, "Violencia"),
    Tipo(3, "Acoso"),
    Tipo(4, "Estupefaciente"),
    Tipo(5, "Bullyng"),
    Tipo(6, "Bebidas alcoholicas"),
    Tipo(7, "Conduccion Peligrosa"),
    Tipo(8, "Parqueo inapropiado"),
  ];

  Zona? selectedzona;
  List<Zona> zonas = [
    Zona(1, "Campus"),
    Zona(2, "Modulos"),
    Zona(3, "Rectorado"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          //  width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              DropdownButton<Estamento>(
                value: selectedEstamento,
                onChanged: (Estamento? newValue) {
                  setState(() {
                    selectedEstamento = newValue!;
                  });
                },
                items: estamentos.map<DropdownMenuItem<Estamento>>(
                  (Estamento estamento) {
                    return DropdownMenuItem<Estamento>(
                      value: estamento,
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.81,
                          child: Text(estamento.nombre)),
                    );
                  },
                ).toList(),
              ),
              DropdownButton<Categoria>(
                value: selectedCategoria,
                onChanged: (Categoria? newValue) {
                  setState(() {
                    selectedCategoria = newValue!;
                  });
                },
                items: categorias.map<DropdownMenuItem<Categoria>>(
                  (Categoria categoria) {
                    return DropdownMenuItem<Categoria>(
                      value: categoria,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.81,
                        child: Text(categoria.nombre),
                      ),
                    );
                  },
                ).toList(),
              ),
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ingresar descripcion'),
                controller: descripcionController,
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ingresar procemiento'),
                controller: procedimientoController,
                maxLines: null,
              ),
              // const SizedBox(height: 10),
              // TextField(
              //   decoration: const InputDecoration(
              //       border: OutlineInputBorder(),
              //       hintText: 'Ingresar latitud dispositivo'),
              //   controller: latitudDispositivoController,
              //   keyboardType: TextInputType.number,
              // ),
              // const SizedBox(height: 10),
              // TextField(
              //   decoration: const InputDecoration(
              //       border: OutlineInputBorder(),
              //       hintText: 'Ingresar longitud dispositivo'),
              //   controller: longitudDispositivoController,
              //   keyboardType: TextInputType.number,
              // ),
              // const SizedBox(height: 10),
              // TextField(
              //   decoration: const InputDecoration(
              //       border: OutlineInputBorder(),
              //       hintText: 'Ingresar latitud Incidencia'),
              //   controller: latitudIncidenciaController,
              // ),
              // const SizedBox(height: 10),
              // TextField(
              //   decoration: const InputDecoration(
              //       border: OutlineInputBorder(),
              //       hintText: 'Ingresar latitud Incidencia'),
              //   controller: longitudIncidenciaController,
              // ),
              const SizedBox(height: 10),
              DropdownButton<Zona>(
                value: selectedzona,
                onChanged: (Zona? newValue) {
                  setState(() {
                    selectedzona = newValue!;
                  });
                },
                items: zonas.map<DropdownMenuItem<Zona>>(
                  (Zona zona) {
                    return DropdownMenuItem<Zona>(
                      value: zona,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.81,
                        child: Text(zona.nombre),
                      ),
                    );
                  },
                ).toList(),
              ),
              const SizedBox(height: 10),
              DropdownButton<Tipo>(
                value: selectedTipo,
                onChanged: (Tipo? newValue) {
                  setState(() {
                    selectedTipo = newValue!;
                  });
                },
                items: tipos.map<DropdownMenuItem<Tipo>>(
                  (Tipo tipo) {
                    return DropdownMenuItem<Tipo>(
                      value: tipo,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.81,
                        child: Text(tipo.nombre),
                      ),
                    );
                  },
                ).toList(),
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: ElevatedButton(
                      onPressed: () {
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => mapp_scren(),
                          ),
                        );*/
                      },
                      child: Text("ENVIAR UBICACION DE LA INCIDENCIAQ"),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: ElevatedButton(
                      onPressed: () {
                        guardarRegistro();
                      },
                      child: Text("REGISTRAR INCIDENCIA"),
                    ),
                  ),
                ),
              )
            ],
          ),
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
    String idZona = idZonaController.text;

    // URL del endpoint del backend
    String url = "${Constants.API_URL}/incidents";

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
        'idZona': idZona,
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
