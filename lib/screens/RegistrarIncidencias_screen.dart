import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:login/bloc/blocs.dart';
import 'package:login/config/constants.dart';
import 'package:login/screens/Facial_screen.dart';
import 'package:login/screens/loading_screen.dart';

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
    Estamento(
        idEstamento: 3,
        nombre: 'Eliot German Humerez Aguirre - Docente',
        codigo: 21404,
        foto: ''),
    Estamento(
        idEstamento: 4,
        nombre: 'Malena Rojas Camargo - Estudiante',
        codigo: 218099282,
        foto: ''),
    Estamento(
        idEstamento: 6,
        nombre: 'Angélica Miranda Mendoza - Estudiante',
        codigo: 218099282,
        foto: ''),
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
    Tipo(8, "Parqueo Inapropiado"),
    Tipo(9, "Actos Obscenos"),
  ];

  Zona? selectedzona;
  List<Zona> zonas = [
    Zona(1, "Campus"),
    Zona(2, "Modulos"),
    Zona(3, "Rectorado"),
  ];

  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<MapBloc, MapState>(builder: (context, state) {
        final mapBloc = BlocProvider.of<MapBloc>(context);
        if (mapBloc.mapCenter != null) {
          latitudDispositivoController.text =
              mapBloc.mapCenter!.latitude.toString();
          longitudDispositivoController.text =
              mapBloc.mapCenter!.longitude.toString();
        }
        return SingleChildScrollView(
          child: Container(
            //  width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: DropdownButtonFormField<Estamento>(
                      decoration: const InputDecoration(
                        labelText: 'Selecciona al Infractor',
                        border: OutlineInputBorder(),
                      ),
                      hint: Text("Selecciona al Infractor"),
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
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: Text(estamento.nombre)),
                          );
                        },
                      ).toList(),
                    )),
                Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: DropdownButtonFormField<Categoria>(
                      decoration: const InputDecoration(
                        labelText: 'Selecciona una Categoría',
                        border: OutlineInputBorder(),
                      ),
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
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: Text(categoria.nombre),
                            ),
                          );
                        },
                      ).toList(),
                    )),
                TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Ingresar una descripción'),
                  controller: descripcionController,
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Ingresar el procedimiento'),
                  controller: procedimientoController,
                  maxLines: null,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<Zona>(
                  decoration: const InputDecoration(
                    labelText: 'Selecciona la zona',
                    border: OutlineInputBorder(),
                  ),
                  hint: Text("Selecciona la zona"),
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
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Text(zona.nombre),
                        ),
                      );
                    },
                  ).toList(),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<Tipo>(
                  decoration: const InputDecoration(
                    labelText: 'Selecciona el Tipo de Incidencia',
                    border: OutlineInputBorder(),
                  ),
                  hint: Text("Selecciona el Tipo de Incidencia"),
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
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Text(tipo.nombre),
                        ),
                      );
                    },
                  ).toList(),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Latitud Incidencia'),
                        controller: latitudIncidenciaController,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Longitud Incidencia'),
                        controller: longitudIncidenciaController,
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoadingScreen(),
                            ),
                          );
                        },
                        child: const Text("CARGAR UBICACION DE LA INCIDENCIA"),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    pickImage();
                  },
                  child: Text("Seleccionar imagen"),
                ),
                selectedImage != null
                    ? Image.file(selectedImage!)
                    : Container(),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: ElevatedButton(
                      onPressed: () {
                        //guardarRegistro();
                      },
                      child: Text("Registrar una ubicacion"),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: ElevatedButton(
                      onPressed: () {
                        guardarRegistro();
                        //mostrarMensaje('Se guardo correctamente');
                      },
                      child: Text("REGISTRAR INCIDENCIA"),
                    ),
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FacialScreen()),
                    );
                  },
                  child: Icon(Icons.add),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: ElevatedButton(
                        onPressed: () {
                          latitudDispositivoController.text =
                              mapBloc.mapCenter!.latitude.toString();
                          longitudDispositivoController.text =
                              mapBloc.mapCenter!.longitude.toString();
                          latitudIncidenciaController.text =
                              mapBloc.ubiDispositivo!.latitude.toString();
                          longitudIncidenciaController.text =
                              mapBloc.ubiDispositivo!.longitude.toString();
                          //guardarRegistro();
                        },
                        child: const Text("Cargar ubicacion"),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  void mostrarMensaje(String mensaje) {
    final snackBar = SnackBar(content: Text(mensaje));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        selectedImage = File(pickedImage.path);
      }
    });
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
    String url = "${Constants.API_URL}/incidencias";

    try {
      List<String> base64Images = [];
      if (selectedImage != null) {
        List<int> imageBytes = await selectedImage!.readAsBytes();
        String base64Image = base64Encode(imageBytes);
        base64Images.add(base64Image);
      }
      // Envío de los datos del registro al backend
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'jwt':
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZFVzdWFyaW8iOjEsImNvZGlnbyI6IjQzOTg4NzY3IiwiaWF0IjoxNjg4MDc1MTg4fQ.BfOyD4vfupHN2wYfQyp3BlJhYEORRLvZw9avsvaPCeY"
      };
      List<int> idEstamentos = [selectedEstamento!.idEstamento];
      Map<String, dynamic> body = {
        'descripcion': descripcion,
        'procedimiento': procedimiento,
        'latitudDispositivo': latitudDispositivo,
        'longitudDispositivo': longitudDispositivo,
        'latitudIncidencia': latitudIncidencia,
        'longitudIncidencia': longitudIncidencia,
        'idOperativo': 1,
        'idCategoriaIncidencia': selectedCategoria!.idCategoria,
        'idTipo': selectedTipo!.idTipo,
        'idZona': selectedzona!.idZona,
        'idEstamentos': idEstamentos,
        'imagenes': base64Images,
      };

      print('Enviando url: $url');
      print('Enviando body: ${jsonEncode(body)}');
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );
      print('Respuesta del servidor: ${response.body}');
      if (response.statusCode == 201) {
        // Éxito en la solicitud
        print('Incidencia registrada exitosamente.');
        mostrarMensaje('Incidencia registrada exitosamente.');
      } else {
        // Error en la solicitud
        print(
            'Error al guardar el registro statusCode: ${response.statusCode}');
      }
    } catch (error) {
      print('Error al guardar el registro: $error');
    }
  }
}
