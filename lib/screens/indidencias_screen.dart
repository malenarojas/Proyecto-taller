/*import 'package:flutter/material.dart';
import 'package:login/screens/home_screen.dart';
import 'package:login/services/db_helper.dart';

//void main() => runApp(incidencias_screen());

class IncidenciasScreen extends StatefulBuilder {
  IncidenciasScreen({required StatefulWidgetBuilder builder})
      : super(builder: builder);

  //const IncidenciasScreen({Key? key}) : super(key: key);
  @override
  State<IncidenciasScreen> createState() => _IncidenciasScreenState();
}

class _IncidenciasScreenState extends State<IncidenciasScreen> {
  List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;
  void _refreshData() async {
    final data = await SQLHelper.getallIncidencias();
  }

  void initState() {
    super.initState();
    _refreshData();
  }

  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _fechacreacionController =
      TextEditingController();
  final TextEditingController _id_usuarioController = TextEditingController();
  final TextEditingController _latitud_dispostivoController =
      TextEditingController();
  final TextEditingController _longitud_dispositivoController =
      TextEditingController();
  Future<void> _addIncidencias() async {
    await SQLHelper.createIncidencias(
        _descripcionController.text,
        _estadoController.text,
        _fechacreacionController.text,
        _id_usuarioController.text,
        _latitud_dispostivoController.text,
        _longitud_dispositivoController.text);
  }

  Future<void> update(int id) async {
    await SQLHelper.updateIncidencias(
      id,
      _descripcionController.text,
      _estadoController.text,
      _fechacreacionController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}*/
