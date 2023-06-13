import 'package:flutter/material.dart';
import 'package:login/screens/actividad1_screen.dart';
import 'package:login/screens/message_screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('UniIncident'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(219, 98, 119, 195),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.notifications_active),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => message_screen()),
                );
              },
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 5,
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.map_sharp), text: 'Incidencias'),
              Tab(icon: Icon(Icons.face), text: 'Novedades'),
              Tab(
                icon: Icon(Icons.settings),
                text: 'Settings',
              ),
            ],
          ),
          elevation: 100,
          titleSpacing: 20,
        ),
        drawer: const _Drawer(),
        body: const TabBarView(
          children: [
            Center(child: home()),
            Center(child: proyectos()),
            Center(child: Actividades()),
            Center(child: Settings()),
          ],
        ),
      ),
    );
  }
}

class Settings extends StatelessWidget {
  const Settings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      //leading: FlutterLogo(),
      title: Text('One-line with leading '),
    ));
  }
}

class Actividades extends StatelessWidget {
  const Actividades({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        Card(child: ListTile(title: Text('Incidencias'))),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          margin: EdgeInsets.all(15),
          elevation: 10,
          child: ClipRRect(
            //borderRadius: BorderRadius.circular(30),
            child: FadeInImage(
              // En esta propiedad colocamos la imagen a descargar
              image: NetworkImage(
                  'https://www.arqhys.com/wp-content/uploads/2012/12/las-estructuras-de-acero-3.jpg'),

              // En esta propiedad colocamos el gif o imagen de carga
              // debe estar almacenado localmente
              placeholder: AssetImage('images/Incidencia1.jpeg'),

              // En esta propiedad colocamos mediante el objeto BoxFit
              // la forma de acoplar la imagen en su contenedor
              fit: BoxFit.cover,

              // En esta propiedad colocamos el alto de nuestra imagen
              height: 160,
            ),
          ),
        ),
        boton_proyecto(),
        Card(
          child: ListTile(
            title: Text('Incidencias de consumo de bebidas alcoholicas'),
            subtitle: Text(
                'se encontro a estudiante consumiendo bebidas alcoholicas por las aulas de modulo 232'),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          margin: EdgeInsets.all(15),
          elevation: 10,
          child: ClipRRect(
            //borderRadius: BorderRadius.circular(30),
            child: FadeInImage(
              // En esta propiedad colocamos la imagen a descargar
              image: NetworkImage(
                  'https://www.netjet.es/wp-content/uploads/2020/11/que-es-una-red-de-saneamiento-770x385.jpg'),

              // En esta propiedad colocamos el gif o imagen de carga
              // debe estar almacenado localmente
              placeholder: AssetImage('images/Incidencia2.jpeg'),

              // En esta propiedad colocamos mediante el objeto BoxFit
              // la forma de acoplar la imagen en su contenedor
              fit: BoxFit.cover,

              // En esta propiedad colocamos el alto de nuestra imagen
              height: 160,
            ),
          ),
        ),
        Card(child: boton_proyecto()),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          margin: EdgeInsets.all(15),
          elevation: 10,
          child: ClipRRect(
            //borderRadius: BorderRadius.circular(30),
            child: FadeInImage(
              // En esta propiedad colocamos la imagen a descargar
              image: NetworkImage(
                  'https://caracol.com.co/resizer/HIgksF14c8RF2RYVaWPbQyqQrMs=/650x488/filters:format(jpg):quality(70)/cloudfront-us-east-1.images.arcpublishing.com/prisaradioco/ZGM22NSZKROC3G3H2R67RJDOXQ.jpg'),

              // En esta propiedad colocamos el gif o imagen de carga
              // debe estar almacenado localmente
              placeholder: AssetImage('images/Incidencia3.jpeg'),

              // En esta propiedad colocamos mediante el objeto BoxFit
              // la forma de acoplar la imagen en su contenedor
              fit: BoxFit.cover,

              // En esta propiedad colocamos el alto de nuestra imagen
              height: 160,
            ),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('Incidencias de vendedores ambulantes'),
            subtitle: Text(
                'se encontro a una señora de la tercera edad vendiendo dulces '),
          ),
        ),
      ],
    );
  }
}

class boton_proyecto extends StatelessWidget {
  const boton_proyecto({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('Incidencias de actos obsenos dentro del campus'),
          subtitle: Text(
              'se encontro a una pareja en las aulas del modulo 232 teniendo actos obsenos'),
          trailing: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const actividad1_screen()),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ),
      ],
    );
  }
}

class proyectos extends StatelessWidget {
  const proyectos({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        Card(child: ListTile(title: Text('Proyectos recientes'))),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          margin: EdgeInsets.all(15),
          elevation: 10,
          child: ClipRRect(
            //borderRadius: BorderRadius.circular(30),
            child: FadeInImage(
              // En esta propiedad colocamos la imagen a descargar
              image: NetworkImage(
                  'https://cadecocruz.org.bo/userfiles/image/2016/10/03/rascacielos.jpeg'),

              // En esta propiedad colocamos el gif o imagen de carga
              // debe estar almacenado localmente
              placeholder: AssetImage('images/Incidencia4.png'),

              // En esta propiedad colocamos mediante el objeto BoxFit
              // la forma de acoplar la imagen en su contenedor
              fit: BoxFit.cover,

              // En esta propiedad colocamos el alto de nuestra imagen
              height: 160,
            ),
          ),
        ),
        Card(
          elevation: 10,
          child: ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text(
                'Incidencia de actos violentos dentro delcampus univercitarios'),
            subtitle: Text(
                'se encontro en el modulo 242 a dos varones en un acto violento'),
            leading: Icon(Icons.home),
          ),
        ),
        boton_proyecto(),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          margin: EdgeInsets.all(15),
          elevation: 10,
          child: ClipRRect(
            //borderRadius: BorderRadius.circular(30),
            child: FadeInImage(
              // En esta propiedad colocamos la imagen a descargar
              image: NetworkImage(
                  'https://boliviaemprende.com/wp-content/uploads/2015/08/monumental-Vista-Torre-Monterrey1.jpg'),

              // En esta propiedad colocamos el gif o imagen de carga
              // debe estar almacenado localmente
              placeholder: AssetImage('images/Incidencia5.png'),

              // En esta propiedad colocamos mediante el objeto BoxFit
              // la forma de acoplar la imagen en su contenedor
              fit: BoxFit.cover,

              // En esta propiedad colocamos el alto de nuestra imagen
              height: 160,
            ),
          ),
        ),
        Card(
          elevation: 10,
          child: ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text('Incidencias de juegos de azar'),
            subtitle: Text(
                'Se encontro a un grupo de estudiantes jugando juegos de azar en aulas de modulo 236'),
            leading: Icon(Icons.home),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          margin: EdgeInsets.all(15),
          elevation: 10,
          child: ClipRRect(
            //borderRadius: BorderRadius.circular(30),
            child: FadeInImage(
              // En esta propiedad colocamos la imagen a descargar
              image: NetworkImage(
                  'https://vistarmagazine.com/wp-content/uploads/2019/08/paseo-prado.jpg'),

              // En esta propiedad colocamos el gif o imagen de carga
              // debe estar almacenado localmente
              placeholder: AssetImage('images/Incidencia6.png'),

              // En esta propiedad colocamos mediante el objeto BoxFit
              // la forma de acoplar la imagen en su contenedor
              fit: BoxFit.cover,

              // En esta propiedad colocamos el alto de nuestra imagen
              height: 200,
            ),
          ),
        ),
        Card(
          elevation: 10,
          child: ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text('Incidencias de consumo de estupefacientes'),
            subtitle: Text(
                'SORPRENDIDOS POR EL PERSONAL DE SEGURIDAD Y TRASLADADOS A LA ADMINISTRACION MODULOS PARA SU RESPECTIVA LLAMADA DE ATENCION'),
            leading: Icon(Icons.home),
          ),
        ),
        Card(
          elevation: 10,
          child: ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text(
                'Incidencias de cosumo de drogas dentro del campu universitario'),
            subtitle: Text(
                'se encontro 3 personas en el modulo 235 consumiendo drogas en el baño de mujeres'),
            leading: Icon(Icons.home),
          ),
        ),
      ],
    );
  }
}

class home extends StatelessWidget {
  const home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        /*Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 221, 247, 233),
              image: DecorationImage(
                image: AssetImage('assets/images/logo.png'),
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
        ),*/
        Card(
            elevation: 5, child: ListTile(title: Text('CONSTRUCTURA PROINCO'))),
        Card(
          elevation: 5,
          child: ListTile(
            title: Text('Procesos de la Empresa '),
            subtitle: Text(
                '-Seguimiento y control de obras civiles -Construcciones Civiles -Elaboración de Proyectos de Edificaciones'),
          ),
        ),
        Card(
          elevation: 5,
          child: ListTile(
            title: Text('Misión'),
            subtitle: Text(
                'PROINCO es una empresa constructora dedicada a la construcción de proyectos de Arquitectura y obra civil, en el ámbito privado, cuya misión es satisfacer las necesidades de nuestros clientes antes, durante y después de finalizado el proyecto '),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          elevation: 5,
          child: ListTile(
            title: Text('Visión'),
            subtitle: Text(
                'Ser la empresa constructora de referencia a nivel regional, liderando el mercado por medio de la responsabilidad, y eficiencia, cumpliendo a tiempo con todos y cada uno de los trabajos encomendados, lograr que todo nuestro personal se sienta motivado y orgulloso de pertenecer a nuestra organización, fomentando el control y la calidad en el servicio, buscando siempre dar más de sí mismos y con esto lograr la satisfacción del cliente.'),
            trailing: Icon(Icons.more_vert),
            isThreeLine: true,
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          margin: EdgeInsets.all(15),
          elevation: 10,
          child: ClipRRect(
              //borderRadius: BorderRadius.circular(30),
              /*child: FadeInImage(
              // En esta propiedad colocamos la imagen a descargar
              image:
                  NetworkImage('https://images.app.goo.gl/BT3WHm5D9cbJ6wys8'),

              // En esta propiedad colocamos el gif o imagen de carga
              // debe estar almacenado localmente
              placeholder: AssetImage('images/logo.png'),

              // En esta propiedad colocamos mediante el objeto BoxFit
              // la forma de acoplar la imagen en su contenedor
              fit: BoxFit.cover,

              // En esta propiedad colocamos el alto de nuestra imagen
              height: 360,
              
            ),*/

              ),
        ),
      ],
    );
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(219, 84, 179, 118),
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          _ListTile(
            titulo: 'Message',
            icono: Icons.message,
          ),
          _ListTile(
            titulo: 'Profile',
            icono: Icons.account_circle,
          ),
          _ListTile(
            titulo: 'Settings',
            icono: Icons.settings,
          ),
        ],
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  final String titulo;
  final icono;
  const _ListTile({
    Key? key,
    required this.titulo,
    required this.icono,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icono),
      title: Text(titulo),
    );
  }
}
