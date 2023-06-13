import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/models/band1.dart';
import 'package:login/services/socket_service.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import '../services/socket_service.dart';

//void main() => runApp(const actividad_screen());

class actividad1_screen extends StatefulWidget {
  const actividad1_screen({Key? key}) : super(key: key);

  @override
  State<actividad1_screen> createState() => _actividad1_screenState();
}

class _actividad1_screenState extends State<actividad1_screen> {
  List<Band1> bands1 = [
    //Band(id: '1', name: 'desarrollo de techo', description: 'proyecto proinco'),
    //Band(id: '2',name: 'desarrollo de las cableado',description: 'proyecto proinco'),
    //Band(id: '3', name: 'desarrollo de techo', description: 'proyecto proinco'),
    //Band(id: '4', name: 'desarrollo de techo', description: 'proyecto proinco')
  ];

  @override
  void initState() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.on('active-bands1', (payload) {
      this.bands1 =
          (payload as List).map((band1) => Band1.fromMap(band1)).toList();
      setState(() {});
    });
    super.initState();
  }

  void dispose() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.off('active-bands1');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('desarrollo de actividades'),
        backgroundColor: const Color.fromARGB(219, 98, 119, 195),
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
      body: Column(
        children: [
          _showGraph(),
          Expanded(
            child: ListView.builder(
                itemCount: bands1.length,
                itemBuilder: (context, i) => _bandTile(bands1[i])),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBand,
      ),
    );
  }

  Widget _bandTile(Band1 band1) {
    final socketService = Provider.of<SocketService>(context);
    return Dismissible(
        key: Key(band1.id),
        direction: DismissDirection.startToEnd,
        onDismissed: (_) {
          socketService.emit('delete-band1', {'id': band1.id});
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
            child: Text(band1.name.substring(0, 2)),
            backgroundColor: Colors.green[100],
          ),
          title: Text(band1.name),
          trailing: Text('${band1.votes}', style: TextStyle(fontSize: 20)),
          onTap: () =>
              socketService.socket.emit('vote-band1', {'id': band1.id}),
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
      socketService.emit('add-band1', {'name': name});
    }
    Navigator.pop(context);
  }

  Widget _showGraph() {
    Map<String, double> dataMap = {
      "proyecto": 5,
      //"React": 3,
      //"Xamarin": 2,
      //"Ionic": 2,
    };
    bands1.forEach((band1) {
      dataMap.putIfAbsent(band1.name, () => band1.votes.toDouble());
    });
    return Container(
      width: double.infinity,
      height: 400,
      child: PieChart(
        dataMap: dataMap,
        chartType: ChartType.ring,
      ),
    );
  }
}
