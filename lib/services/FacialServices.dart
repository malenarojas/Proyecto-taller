import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login/models/Estamento.dart';

class FacialService extends ChangeNotifier {
  //final String _baseUrl = dotenv.env['BASE_URL'] ?? '';

  Estamento? identifiedEstamento;

  bool _isLoading = false;
  
  late BuildContext context;
  bool get isLoading => _isLoading;

  /*  FacialService() {
   
   
  } */
  Future<AlertDialog?> identifyUser(context, File imageFile) async {
    _isLoading = true;
    notifyListeners();

    try {
      final url =
          'https://incidentsapi.site/public/api/mediaInfractor/identifyUser';

      List<int> imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"foto": base64Image}),
      );

      // final response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        print('Usuario Reincidente ');
       await showAlertDialog(context);
        
      } else if (response.statusCode == 204) {
        print('No se encontró ningún usuario.');
        return null;
      } else {
        print(
            'Error al identificar al usuario. Código de respuesta: ${response.statusCode}');
        throw Exception('Error al identificar al usuario');
      }
    } catch (e) {
      print('Error al realizar la solicitud: $e');
      throw Exception('Error al identificar al usuario');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
Future<void> showAlertDialog(BuildContext context) {
  //this.context = context;
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alerta'),
        content: Text('Infractor reincidente registrado en la base de datos'),
        actions: <Widget>[
          TextButton(
            child: Text('Aceptar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}