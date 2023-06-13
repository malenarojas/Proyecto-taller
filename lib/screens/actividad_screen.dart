import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/main.dart';
import 'package:flutter/material.dart';
import 'package:login/models/band.dart';
import 'package:login/services/socket_service.dart';
import 'package:provider/provider.dart';

import '../services/socket_service.dart';

//void main() => runApp(const actividad_screen());

class actividad_screen extends StatefulWidget {
  const actividad_screen({Key? key}) : super(key: key);

  @override
  State<actividad_screen> createState() => _actividad_screenState();
}

class _actividad_screenState extends State<actividad_screen> {
  List<Band> bands = [
    //Band(id: '1', name: 'desarrollo de techo', description: 'proyecto proinco'),
    //Band(id: '2',name: 'desarrollo de las cableado',description: 'proyecto proinco'),
    //Band(id: '3', name: 'desarrollo de techo', description: 'proyecto proinco'),
    //Band(id: '4', name: 'desarrollo de techo', description: 'proyecto proinco')
  ];

  @override
  void initState() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.on('active-bands', (payload) {
      this.bands = (payload as List).map((band) => Band.fromMap(band)).toList();
      setState(() {});
    });
    super.initState();
  }

  void dispose() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.off('active-bands');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('desarrollo de actividades'),
        backgroundColor: const Color.fromARGB(219, 84, 179, 118),
        elevation: 1,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: (socketService.serverStatus == ServerStatus.Online)
                ? Icon(Icons.check_circle, color: Colors.white)
                : Icon(Icons.offline_bolt, color: Colors.red),
          )
        ],
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, i) => _bandTile(bands[i])),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBand,
      ),
    );
  }

  Widget _bandTile(Band band) {
    final socketService = Provider.of<SocketService>(context);
    return Dismissible(
        key: Key(band.id),
        direction: DismissDirection.startToEnd,
        onDismissed: (_) {
          socketService.emit('delete-band', {'id': band.id});
        },
        background: Container(
          padding: EdgeInsets.only(left: 8.0),
          color: Colors.red,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Delete Band',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        child: ListTile(
          leading: CircleAvatar(
            child: Text(band.name.substring(0, 2)),
            backgroundColor: Colors.green[100],
          ),
          title: Text(band.name),
          trailing: Text(
            '${band.id}',
            style: TextStyle(fontSize: 20),
          ),
          onTap: () {
            (band.name);
          },
        ));
  }

  addNewBand() {
    final TextControlller = new TextEditingController();
    if (Platform.isAndroid) {
      // Android
      showCupertinoDialog(
          context: context,
          builder: (_) {
            return CupertinoAlertDialog(
              title: Text('nuevo nombre de tarea'),
              content: CupertinoTextField(
                controller: TextControlller,
              ),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('Add'),
                  onPressed: (() => addBandToList(TextControlller.text)),
                ),
                CupertinoDialogAction(
                    isDestructiveAction: true,
                    child: Text('Dismiss'),
                    onPressed: (() => Navigator.pop(context)))
              ],
            );
          });
    }
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      //podemos agregar
      final socketService = Provider.of<SocketService>(context, listen: false);
      socketService.emit('add-band', {'name': name});
    }
    Navigator.pop(context);
  }
}
