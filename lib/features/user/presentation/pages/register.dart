import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localeats/features/user/domain/entities/login.dart';
import 'package:localeats/features/user/presentation/pages/vista_login.dart';
import 'package:quickalert/quickalert.dart';

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

    if (_acceptTerms) {
      List<UserCreate> userData = [
        UserCreate(
            pass: contrasena,
            name: nombreUsuario,
            email: correoElectronico,
            telefono: telefono),
      ];
      context.read<CreateUserBloc>().add(CreateUserRequest(userData[0]));
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Para registrarte, debes aceptar los términos y condiciones.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateUserBloc, CreateState>(
      listener: (context, state) {
        if (state.userStatus == UserRequest.requestSuccess) {
          const Center(child: CircularProgressIndicator());
        }
        if (state.userStatus == UserRequest.requestInProgress) {
          const Center(child: CircularProgressIndicator());
        }
        if (state.userStatus == UserRequest.unknown) {
          const Center(child: CircularProgressIndicator());
        }
        if (state.userStatus == UserRequest.requestFailure) {
          const Center(child: CircularProgressIndicator());
        }
      },
      child: BlocBuilder<CreateUserBloc, CreateState>(
        builder: (context, state) {
          if (state.userStatus == UserRequest.requestInProgress) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.loading,
                  title: 'Loading',
                  text: 'Fetching your data',
                );
              },
            );
            Future.delayed(const Duration(seconds: 2), () {
              // Remover el loading después del retraso
              Navigator.pop(context);
              // _resetLocalStatus(); // Cambiar el estado a success después de quitar el loading
            });
            // _resetLocalStatus();
          }
          if (state.userStatus == UserRequest.requestSuccess) {
            Future.delayed(const Duration(seconds: 2), () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  text: 'Transaction Completed Successfully!',
                );
                _resetStatus();
              });
            });
          }
          if (state.userStatus == UserRequest.requestFailure) {
            Future.delayed(const Duration(seconds: 2), () {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: 'Oops...',
                    text: 'Sorry, something went wrong',
                  );
                  _resetStatus();
                },
              );
            });
          }
          return Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.black),
                        onPressed: _regresar,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/local_logo.jpg',
                            width: 150.0,
                            height: 150.0,
                          ),
                          const SizedBox(height: 20.0),
                          const Text(
                            'LocalExplorer',
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
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
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
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
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
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
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
                              TextButton(
                                onPressed: () {
                                  mostrarAvisoPrivacidad(context);
                                },
                                child: const Text(
                                  'Acepto los términos y condiciones de\nLocalEats',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                            child: Container(
                              width: 200.0,
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
            ),
          );
        },
      ),
    );
  }

  void _resetStatus() {
    context.read<CreateUserBloc>().add(ResetState());
  }

  void mostrarAvisoPrivacidad(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Aviso de Privacidad'),
          content: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¿Quiénes somos?\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Yurandir García Morales, Discover Local, con domicilio en '
                  '[Carretera Tuxtla Gutiérrez, SN, Las Brisas, Suchiapa, '
                  'Universidad Politécnica de Chiapas, 29150, Chiapas, es el '
                  'responsable del uso y protección de sus datos personales, y '
                  'al respecto le informamos lo siguiente:',
                ),
                SizedBox(height: 15),
                Text(
                  "¿Para qué fines utilizaremos sus datos personales?\n",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    'Los datos personales que recabamos de usted, los utilizaremos '
                    'para las siguientes finalidades que son necesarias para el '
                    'servicio que solicita:\n'),
                Text(
                  '• Logeo para tener acceso a la aplicación.\n'
                  '• Register para guardar la información y'
                  ' posteriormente acceder a la app así mismo '
                  'relacionar cuáles son tus locales.\n'
                  '• Ubicación tiempo real para poder sugerirte '
                  'que lugares visitar.\n'
                  '• Datos del negocio del user esto para poder '
                  'mostrarlo al publico para que los demás '
                  'usuarios puedan ver que es lo que ofrece y '
                  'posteriormente que sea visitado con '
                  'frecuencia.',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                    'De manera adicional, utilizaremos su información personal '
                    'para las siguientes finalidades que no son necesarias para '
                    'el servicio solicitado, pero que nos permiten y facilitan '
                    'brindarle una mejor atención: \n'),
                Text(
                  '• Verificar en base a la información del negocio '
                  'no sea algo ilícito. \n'
                  '• Usurpación de identidad del usuario.\n'
                  '• Hacer estadísticas del rendimiento del negocio '
                  'de cada usuario.\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('En caso de que no desee que sus datos personales sean'
                    'tratados para estos fines adicionales, desde este momento '
                    'usted nos puede comunicar lo anterior,'),
                Text(
                  'a través de un correo a localexplore2023@gmail.com o enviando '
                  'un mensaje a nuestro número de quejas y '
                  'sugerencias 961-429-2274. Es importante que en su '
                  'mensaje indique claramente que no desea que sus '
                  "atos personales sean tratados para fines "
                  "adicionales.",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "\n¿Dónde puedo consultar el aviso de privacidad integral?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "\nPara conocer mayor información sobre los términos y "
                  "condiciones en que serán tratados sus datos personales, "
                  "como los terceros con quienes compartimos su información "
                  "personal y la forma en que podrá ejercer sus derechos "
                  "ARCO, puede consultar el aviso de privacidad integral en,",
                ),
                Text(
                  "En la página de registro, encontrarás el botón 'Términos y Condiciones'. Al hacer clic en él, se mostrará toda la información relevante",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
