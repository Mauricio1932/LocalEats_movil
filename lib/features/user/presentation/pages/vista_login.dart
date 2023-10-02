// ignore_for_file: unused_field, prefer_final_fields, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localeats/features/user/presentation/pages/profile.dart';

import '../../domain/entities/login.dart';
import '../bloc/bloc_login/user_bloc.dart';
import '../bloc/bloc_login/user_event.dart';
import '../bloc/bloc_login/user_state.dart';
import 'login_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'create_account.dart';
import 'locales.dart';
import 'register.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // variable de permanencia
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  //variable de acceso
  late Future<bool> _access;

  String? _username;
  String? _password;

  final _formKey = GlobalKey<FormState>();

  void _showErrorAlert(String message) {
    if (defaultTargetPlatform == TargetPlatform.android || kIsWeb) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error de inicio de sesión'),
            content: Text(message),
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
            title: Text('Error de inicio de sesión'),
            content: Text(message),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('Cerrar'),
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
  // var userToken;

  void _submitForm() async {
    // _persistirSesion();
    // navigateToHomeView();
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState!
          .save(); // Guardar los valores del formulario en las variables

      if (_username == null || _password == null) {
        print('Nombre de usuario o contraseña es nulo.');
        print(_password);
        return; // Sale de la función para evitar errores adicionales
      }

      String name = _username!;
      String pass = _password!;
    }
  }

  void navigateToHomeView() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => LocalView(),
      ),
    );
  }

  void loginUser() {
    List<User> userData = [
      User(password: '83r5^_', username: 'mor_2314', token: ''),
    ];

    context.read<UserBloc>().add(LoginUserRequest(userData[0]));
    // context.read<UserBloc>().add(GetAuthToken());
    load_profile();
  }

  void load_profile() {
    context.read<UserBloc>().add(GetAuthToken());
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => Profile(),
      ),
    );
  }

  void register_profile() {
    context.read<UserBloc>().add(GetAuthToken());
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => const RegisterView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      return SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () {
                  navigateToHomeView();
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo2.png',
                    width: 200.0,
                    height: 200.0,
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
                              return 'Por favor ingresa un usuario';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _username =
                                value; // Guardar el valor de entrada en _username
                          },
                        ),
                        const SizedBox(height: 10.0),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
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
                                    return 'Por favor ingresa una contraseña';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _password =
                                      value; // Guardar el valor de entrada en _password
                                },
                              ),
                              const SizedBox(height: 10.0),
                              GestureDetector(
                                onTap: () {
                                  // Acción al presionar el texto "Forgot Password?"
                                },
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 93, 93, 93),
                                    fontSize: 13.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      loginUser();
                      // print("estoy en login${state.userStatus}");
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 93, 93, 93),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                          'Iniciar sesión',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: () {register_profile();},
                    child: const Text(
                      'Registrarme',
                      style: TextStyle(
                        color: Color.fromARGB(255, 93, 93, 93),
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }));
  }
}
