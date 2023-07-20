import 'package:flutter/material.dart';
import 'package:login/widgets/input_decoration.dart';

import '../widgets/drawer_screen.dart';

class LoginScreen extends StatelessWidget {

  
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController codigoController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            cajapurpura(Size),
            iconperson(),
            fromlogin(context),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView fromlogin(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 350),
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            // height: 400,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 15,
                    offset: Offset(10, 5),
                  )
                ]),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text('UniIncident',
                    style: Theme.of(context).textTheme.headline4),
                const SizedBox(height: 50),
                Container(
                  child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: codigoController,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            decoration: InputDecorations.inputDecoration(
                                hintText: '218099282',
                                labelText: 'Código',
                                icono: const Icon(Icons.numbers)),
                            validator: (value) {
                              String pattern = r'^\d+$';
                              RegExp regExp = new RegExp(pattern);
                              return regExp.hasMatch(value ?? '')
                                  ? null
                                  : 'El valor ingresado no es un número';
                            },
                          ),
                          const SizedBox(height: 50),
                          TextFormField(
                            controller: contrasenaController,
                            autocorrect: false,
                            obscureText: true,
                            decoration: InputDecorations.inputDecoration(
                                hintText: '********',
                                labelText: 'contraseña',
                                icono: const Icon(Icons.lock_clock_outlined)),
                            validator: (value) {
                              return (value != null && value.length >= 6)
                                  ? null
                                  : 'La contraseña debe ser mayor o igual a los 6 caracteres';
                            },
                          ),
                          const SizedBox(height: 40),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            disabledColor: Colors.grey,
                            color: Color.fromARGB(219, 227, 89, 19),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 80, vertical: 15),
                              child: const Text(
                                'Ingresar',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            onPressed: () {
                              String codigo = codigoController.text;
                              String contrasena = contrasenaController.text;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainPage(codigo: codigo,contrasena: contrasena)),
                              );
                              //Navigator.pushReplacementNamed(context, 'Incidencia');
                            },
                          ),
                          const SizedBox(height: 30),
                        ],
                      )),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          const Text(
            'crea una nueva cuenta',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  SafeArea iconperson() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 100),
        width: double.infinity,
        child: const Icon(
          Icons.person_pin,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }

  Container cajapurpura(Size Size) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(219, 33, 45, 168),
        Color.fromARGB(219, 98, 119, 195),
      ])),
      width: double.infinity,
      height: Size.height * 0.45,
      child: Padding(
        padding: EdgeInsets.all(0),
        child: Image.asset(
          'images/authuagrm.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Container burbuja() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color.fromRGBO(255, 255, 255, 0.05)),
    );
  }
}
