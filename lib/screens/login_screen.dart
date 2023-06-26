import 'package:flutter/material.dart';
import 'package:login/screens/Incidencias_screen.dart';
import 'package:login/widgets/input_decoration.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            decoration: InputDecorations.inputDecoration(
                                hintText: '218099282',
                                labelText: 'Codigo',
                                icono:
                                    const Icon(Icons.alternate_email_rounded)),
                            validator: (value) {
                              String pattern =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regExp = new RegExp(pattern);
                              return regExp.hasMatch(value ?? '')
                                  ? null
                                  : 'El valor ingresado no es un correo';
                            },
                          ),
                          const SizedBox(height: 50),
                          TextFormField(
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => IncidenciasScreen()),
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
      height: Size.height * 0.4,
      child: Stack(
        children: [
          Positioned(child: burbuja(), top: 90, left: 30),
          Positioned(child: burbuja(), top: -40, left: -30),
          Positioned(child: burbuja(), top: -50, right: -20),
          Positioned(child: burbuja(), bottom: -50, left: 10),
          Positioned(child: burbuja(), bottom: 120, right: 20),
        ],
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
