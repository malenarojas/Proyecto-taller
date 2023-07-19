import 'package:flutter/material.dart';

//import 'package:google_fonts/google_fonts.dart';

import 'defaults.dart';

var indexClicked = 0;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final pages = [
    const Center(
      child: Text('Facial Reconiction'),
    ),
    const Center(
      child: Text('Registrar Incidencias'),
    ),
    const Center(
      child: Text('Registrar ubicacion'),
    ),
    const Center(
      child: Text('Boton alert'),
    ),
    const Center(
      child: Text('Trash'),
    ),
    const Center(
      child: Text('Spam'),
    ),
  ];

void updateState(int index) {
  setState(() {
    indexClicked = index;
  });
  Navigator.pop(context);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Incidencias Encontradas',
        ),
      ),
      body: pages[indexClicked],
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('images/drawer.jpg'),
                ),
              ),
              padding: EdgeInsets.all(0),
              child: Container(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    CircleAvatar(
                      radius: 42,
                      backgroundImage: AssetImage('images/profile.jpg'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'John Rambo',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'john@rambo.com',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  AppDrawerTile(
                    index: 0,
                    onTap: ()=> Navigator.pushReplacementNamed(context, 'Facial'),
                  ),
                  AppDrawerTile(
                    index: 1,
                    onTap: ()=> Navigator.pushReplacementNamed(context, 'Registrar Incidencias'),
                  ),
                  AppDrawerTile(
                    index: 2,
                    onTap: ()=> Navigator.pushReplacementNamed(context, ''),
                  ),
                  AppDrawerTile(
                    index: 3,
                    onTap: ()=> Navigator.pushReplacementNamed(context, 'Home'),
                  ),
                  AppDrawerTile(
                    index: 4,
                    onTap: ()=> Navigator.pushReplacementNamed(context, 'Home'),
                  ),
                  AppDrawerTile(
                    index: 5,
                    onTap: ()=> Navigator.pushReplacementNamed(context, 'Home'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                   AppDrawerDivider(),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      'JetMail',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        fontSize: 20,
                        color: Defaults.drawerItemSelectedColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      'Version 1.2.5',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                        color: Defaults.drawerItemColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                 AppDrawerDivider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppDrawerDivider extends StatelessWidget {
  const AppDrawerDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: Defaults.drawerItemColor,
      indent: 3,
      endIndent: 3,
    );
  }
}

class AppDrawerTile extends StatelessWidget {
  const AppDrawerTile({
    Key? key,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  final int index;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        onTap: onTap,
        selected: indexClicked == index,
        selectedTileColor: Defaults.drawerSelectedTileColor,
        leading: Icon(
          Defaults.drawerItemIcon[index],
          size: 35,
          color: indexClicked == index
              ? Defaults.drawerItemSelectedColor
              : Defaults.drawerItemColor,
        ),
        title: Text(
          Defaults.drawerItemText[index],
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: indexClicked == index
                ? Defaults.drawerItemSelectedColor
                : Defaults.drawerItemColor,
          ),
        ),
      ),
    );
  }
}