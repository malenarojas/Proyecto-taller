/*import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:login/models/Estamento.dart';

class FacialService extends ChangeNotifier {
  final String _baseUrl = dotenv.env['BASE_URL'] ?? '';

  Estamento? identifiedUser;
  

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /*  FacialService() {
   
   
  } */

 
  Future<Estamento?> identifyUser(File imageFile) async {
  _isLoading = true;
  notifyListeners();

  try {
    final url = '$_baseUrl/api/identify_user';

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath(
      'foto',
      imageFile.path,
      contentType: MediaType('image', 'jpeg'), 
    ));
  
    final response = await http.Response.fromStream(await request.send());
    
    if (response.statusCode == 200) {
      
      final Map<String, dynamic> userTemp = json.decode(response.body);
      final User user = User.fromMap(userTemp['user']);
      identifiedUser = user;
      
      return identifiedUser;
    } else if (response.statusCode == 204) {
      
      print('No se encontró ningún usuario.');
      return null;
    } else {
      
      print('Error al identificar al usuario. Código de respuesta: ${response.statusCode}');
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

}*/