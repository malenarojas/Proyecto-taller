import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class RegistrarInfractorScreen extends StatefulWidget {
  @override
  _RegistrarInfractorScreenState createState() => _RegistrarInfractorScreenState();
}

class _RegistrarInfractorScreenState extends State<RegistrarInfractorScreen> {
  File? _imageFile;
  bool _isLoading = false;
  TextEditingController _nombreController = TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    super.dispose();
  }

  Future<void> _selectImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _registerInfractor() async {
    if (_imageFile != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        final url = 'http://localhost:8000/api/mediaInfractor/store';

        List<int> imageBytes = await _imageFile!.readAsBytes();
        String base64Image = base64Encode(imageBytes);

        var request = http.MultipartRequest('POST', Uri.parse(url));
        request.files.add(await http.MultipartFile.fromPath(
          'foto',
          _imageFile!.path,
        ));
        request.fields['nombre'] = _nombreController.text;
        request.fields['image_base64'] = base64Image;

        final response = await http.Response.fromStream(await request.send());

        if (response.statusCode == 200) {
          // Éxito en la solicitud
          print('Infractor registrado correctamente');
          print('Respuesta del servidor: ${response.body}');
        } else {
          // Error en la solicitud
          print('Error al registrar el infractor: ${response.statusCode}');
        }
      } catch (e) {
        print('Error al realizar la solicitud: $e');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  void mostrarMensaje(String mensaje) {
  final snackBar = SnackBar(content: Text(mensaje));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Infractor'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageFile != null
                ? Image.file(
                    _imageFile!,
                    width: 200,
                    height: 200,
                  )
                : Container(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectImageFromGallery,
              child: Text('Seleccionar Imagen'),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre del Infractor',
                ),
              ),
            ),
            SizedBox(height: 20),
           ElevatedButton(
              onPressed: _isLoading ? null : () {
                _registerInfractor();
                mostrarMensaje('resgistro guardado');
              },
              child: _isLoading ? CircularProgressIndicator() : Text('Registrar Infractor'),
            ),
          ],
        ),
      ),
    );
  }
}


