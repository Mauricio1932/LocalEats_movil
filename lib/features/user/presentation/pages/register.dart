import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localeats/features/user/presentation/pages/vista_login.dart';

import '../../domain/entities/user.dart';
import '../bloc/bloc_create_user/create_user_bloc.dart';
import '../bloc/bloc_create_user/create_user_event.dart';
import '../bloc/bloc_create_user/create_user_state.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nombreUsuarioController = TextEditingController();
  TextEditingController _telefonoController = TextEditingController();
  TextEditingController _correoElectronicoController = TextEditingController();
  TextEditingController _contrasenaController = TextEditingController();
  bool _acceptTerms = false;

  void _regresar() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => const LoginView(),
      ),
    );
  }

  void profile() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => const LoginView(),
      ),
    );
  }

  void enviarFormulario() {
    String nombreUsuario = _nombreUsuarioController.text;
    String telefono = _telefonoController.text;
    String correoElectronico = _correoElectronicoController.text;
    String contrasena = _contrasenaController.text;

    print("Nombre de Usuario: $nombreUsuario");
    print("Teléfono: $telefono");
    print("Correo Electrónico: $correoElectronico");
    print("Contraseña: $contrasena");

    List<UserCreate> userData = [
      UserCreate(
          pass: contrasena, name: nombreUsuario, email: correoElectronico, telefono: telefono),
    ];

    context.read<CreateUserBloc>().add(CreateUserRequest(userData[0]));
  }

  // String nombreUsuario = _nombreUsuarioController.text;
  // String telefono = _telefonoController.text;
  // String correoElectronico = _correoElectronicoController.text;
  // String contrasena = _contrasenaController.text;

  // Map<String, String> datosRegistro = {
  //   "name": nombreUsuario,
  //   "telefono": telefono,
  //   "email": correoElectronico,
  //   "pass": contrasena,
  // };
  // }

  // void _mostrarAlertaError(String mensaje) {
  //   if (defaultTargetPlatform == TargetPlatform.android || kIsWeb) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text('Error en el registro'),
  //           content: Text(mensaje),
  //           actions: <Widget>[
  //             TextButton(
  //               child: const Text('Cerrar'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   } else if (defaultTargetPlatform == TargetPlatform.iOS) {
  //     showCupertinoDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return CupertinoAlertDialog(
  //           title: const Text('Error en el registro'),
  //           content: Text(mensaje),
  //           actions: <Widget>[
  //             CupertinoDialogAction(
  //               child: const Text('Cerrar'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateUserBloc, CreateState>(builder: (context, state) {
      if (state.userStatus == UserRequest.requestSuccess) {
        return const LoginView();
      }
      if (state.userStatus == UserRequest.requestInProgress) {
        // return const Center(child: CircularProgressIndicator());

        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (BuildContext context) => LoginView(),
        //   ),
        // );
        // return LoginView();
      }
      // if (state.userStatus == UserRequest.requestFailure) {
      //   // return
      // }
      return Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: _regresar,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logo2.png',
                        width: 150.0,
                        height: 150.0,
                      ),
                      const SizedBox(height: 20.0),
                      const Text(
                        'LocalEats',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 7.0,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'El campo no puede estar vacio!';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20.0),
                            TextFormField(
                              controller: _telefonoController,
                                 keyboardType: TextInputType.number,
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'El campo no puede estar vacio!';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20.0),
                            TextFormField(
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'El campo no puede estar vacio!';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),

                      TextFormField(
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'El campo no puede estar vacio!';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 10.0),
                      // Row(
                      //   children: [
                      //     Checkbox(
                      //       value: _acceptTerms,
                      //       onChanged: (value) {
                      //         setState(() {
                      //           _acceptTerms = value ?? false;
                      //         });
                      //       },
                      //     ),
                      //     const Text(
                      //         'Acepto los términos y condiciones de\nLocalEats'),
                      //   ],
                      // ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          // enviarFormulario();
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.validate()) {
                            enviarFormulario();
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 93, 93, 93),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        child: Container(
                          width: 200.0,
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
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
        ),
      );
    });
  }
}
