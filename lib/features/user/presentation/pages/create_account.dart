// ignore_for_file: prefer_final_fields

import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform;

import 'locales.dart';
// import 'login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _nombreUsuarioController = TextEditingController();
  TextEditingController _telefonoController = TextEditingController();
  TextEditingController _correoElectronicoController = TextEditingController();
  TextEditingController _contrasenaController = TextEditingController();
  bool _acceptTerms = false;

  void _regresar() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => const LocalView(),
      ),
    );
  }

  void _enviarFormulario() async {
    if (_acceptTerms) {
      String nombreUsuario = _nombreUsuarioController.text;
      String telefono = _telefonoController.text;
      String correoElectronico = _correoElectronicoController.text;
      String contrasena = _contrasenaController.text;

      Map<String, String> datosRegistro = {
        "name": nombreUsuario,
        "telefono": telefono,
        "email": correoElectronico,
        "pass": contrasena,
      };

      Dio dio = Dio();

      try {
        var respuesta = await dio.post(
          'http://localhost:3000/api/login/create',
          data: jsonEncode(datosRegistro),
          options: Options(contentType: Headers.jsonContentType),
        );

        var datos = respuesta.data;
        print(datos);

        if (respuesta.statusCode == 200) {
          // Registro exitoso, navegar a la página de inicio de sesión o manejar de acuerdo
          // Navigator.of(context).pushReplacement(
          //   MaterialPageRoute(
          //     builder: (BuildContext context) => const Login(),
          //   ),
          // );
        } else {
          // Manejar error de registro
          _mostrarAlertaError('Error en el registro: ${respuesta.statusCode}');
        }
      } catch (error) {
        _mostrarAlertaError('Error en la solicitud: $error');
        print('Error en la solicitud: $error');
      }
    } else {
      // Mostrar diálogo de términos y condiciones
      if (defaultTargetPlatform == TargetPlatform.android || kIsWeb) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Términos y Condiciones'),
              content: const Text(
                  'Debes aceptar los términos y condiciones para registrarte.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Aceptar'),
                ),
              ],
            );
          },
        );
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: const Text('Términos y Condiciones'),
              content: const Text(
                  'Debes aceptar los términos y condiciones para registrarte.'),
              actions: [
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Aceptar'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void _mostrarAlertaError(String mensaje) {
    if (defaultTargetPlatform == TargetPlatform.android || kIsWeb) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error en el registro'),
            content: Text(mensaje),
            actions: <Widget>[
              TextButton(
                child: const Text('Cerrar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Error en el registro'),
            content: Text(mensaje),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text('Cerrar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: _regresar,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logo2.png',
                      width: 150.0,
                      height: 150.0,
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'LocalEats',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 7.0,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          TextField(
                            controller: _nombreUsuarioController,
                            decoration: const InputDecoration(
                              labelText: 'Usuario',
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.person),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          TextField(
                            controller: _telefonoController,
                            decoration: const InputDecoration(
                              labelText: 'Teléfono',
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.phone),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          TextField(
                            controller: _correoElectronicoController,
                            decoration: const InputDecoration(
                              labelText: 'Correo Electrónico',
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.mail),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          TextField(
                            controller: _contrasenaController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Contraseña',
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.lock),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            children: [
                              Checkbox(
                                value: _acceptTerms,
                                onChanged: (value) {
                                  setState(() {
                                    _acceptTerms = value ?? false;
                                  });
                                },
                              ),
                              const Text(
                                  'Acepto los términos y condiciones de\nLocalEats'),
                            ],
                          ),
                          const SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: _enviarFormulario,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 93, 93, 93),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                            child: Container(
                              width: 900.0,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: const Center(
                                child: Text(
                                  'Registrarme',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
