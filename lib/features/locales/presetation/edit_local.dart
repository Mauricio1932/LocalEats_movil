// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localeats/features/locales/domain/entities/local.dart';
import 'package:localeats/features/locales/domain/entities/new_local_entities.dart';
import 'package:localeats/features/user/presentation/bloc/bloc_create_local/create_local_bloc.dart';
import 'package:localeats/features/user/presentation/bloc/bloc_create_local/create_local_event.dart';
import 'package:localeats/features/user/presentation/bloc/bloc_create_local/create_local_state.dart';
import 'package:localeats/features/user/presentation/pages/profile.dart';
import 'package:file_picker/file_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
// import 'package:fluttertoast/fluttertoast.dart';

import 'package:quickalert/quickalert.dart';
// import 'package:quickalert/widgets/quickalert_dialog.dart';

class EditLocal extends StatefulWidget {
  final List<Local> local;
  final int id;

  const EditLocal({Key? key, required this.local, required this.id})
      : super(key: key);

  @override
  State<EditLocal> createState() => _EditLocalState();
}

class _EditLocalState extends State<EditLocal> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _genero = TextEditingController();
  final TextEditingController _descripcion = TextEditingController();
  final TextEditingController _ubicacion = TextEditingController();
  final TextEditingController _nameLocalFieldController =
      TextEditingController();

  File? selectedFile;
  File? selectPdf;

  bool flag = false;

  void toggleBussines() {
    setState(() {
      flag = !flag; // Cambia el valor de la bandera
    });
  }

  @override
  Widget build(BuildContext context) {
    _nameLocalFieldController.text = widget.local[widget.id].namelocal;
    _genero.text = widget.local[widget.id].genero;
    _descripcion.text = widget.local[widget.id].descripcion;
    _ubicacion.text = widget.local[widget.id].ubicacion;

    return Scaffold(
      appBar: AppBar(
        // leading: null,
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[300],
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        iconTheme: const IconThemeData(color: Colors.black),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 70, right: 60),
              child: Text(
                'Upload bussnises',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      body: BlocListener<CreateLocalBloc, CreateLocalState>(
        listener: (context, state) {
          // Escuchamos el estado del Bloc y mostramos un mensaje cuando el contador llega a 3.

          if (state.newLocalStatus == LocalRequest.requestSuccess) {
            const Center(child: CircularProgressIndicator());
          }

          if (state.newLocalStatus == LocalRequest.requestInProgress) {
            const Center(child: CircularProgressIndicator());
          }
          if (state.newLocalStatus == LocalRequest.unknown) {
            const Center(child: CircularProgressIndicator());
          }
          if (state.newLocalStatus == LocalRequest.requestFailure) {
            const Center(child: CircularProgressIndicator());
          }
        },
        child: BlocBuilder<CreateLocalBloc, CreateLocalState>(
          builder: (context, state) {
            if (state.newLocalStatus == LocalRequest.requestInProgress) {
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
            if (state.newLocalStatus == LocalRequest.requestSuccess) {
              Future.delayed(const Duration(seconds: 2), () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    text: 'Transaction Completed Successfully!',
                  );
                  _resetLocalStatus();
                });
              });
            }
            if (state.newLocalStatus == LocalRequest.requestFailure) {
              Future.delayed(const Duration(seconds: 2), () {
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: 'Oops...',
                      text: 'Sorry, something went wrong',
                    );
                    _resetLocalStatus();
                  },
                );
              });
            }
            // selectedFile = selectedFile ?? File('assets/notimage.jpg');
            return SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        if (widget.local[0].imagen != "")
                          Image.network(
                            'http://192.168.1.117:3000/api/local/view_img?img1=${widget.local[widget.id].imagen}', // Reemplaza con la URL de tu imagen
                            width: 350,
                            height: 300,
                          ),
                        if (selectedFile != null)
                          Image.file(
                            selectedFile!,
                            width: 350,
                            height: 300,
                          ),
                        if (selectedFile == null &&
                            widget.local[0].imagen == "")
                          Image.asset(
                            'assets/notimage.jpg', // Reemplaza con la ruta correcta de tu imagen local
                            width: 300,
                            height: 240,
                          )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                style: const TextStyle(
                                    color: Colors
                                        .black), // Color del texto de entrada
                                controller: _nameLocalFieldController,
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(Icons.business_sharp),
                                  labelText: 'Nombre del Negocio',
                                  labelStyle: TextStyle(color: Colors.black),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .black), // Borde cuando está enfocado
                                  ),
                                ),
// initialValue:

                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, ingrese el nombre del negocio.';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                style: const TextStyle(
                                    color: Colors
                                        .black), // Color del texto de entrada
                                controller: _genero,
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(Icons.category),
                                  labelText: 'Genero',
                                  labelStyle: TextStyle(color: Colors.black),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .black), // Borde cuando está enfocado
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, ingrese el Categoria del negocio.';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                style: const TextStyle(
                                    color: Colors
                                        .black), // Color del texto de entrada
                                controller: _descripcion,
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(Icons.description),
                                  labelText: 'Descripción',
                                  labelStyle: TextStyle(color: Colors.black),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .black), // Borde cuando está enfocado
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, ingrese el Descripción del negocio.';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                style: const TextStyle(
                                    color: Colors
                                        .black), // Color del texto de entrada
                                controller: _ubicacion,
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(Icons.location_on),
                                  labelText: 'Ubicacion',
                                  labelStyle: TextStyle(color: Colors.black),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .black), // Borde cuando está enfocado
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, ingrese el ubicacion (cordenadas) del negocio.';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 0),
                        child: Row(
                          children: [
                            OutlinedButton(
                              onPressed: _pickFile,
                              style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.black)
                                  .copyWith(
                                side:
                                    MaterialStateProperty.all(const BorderSide(
                                  color: Colors.grey, // color del borde
                                  width: 1.0, // ancho del borde
                                )),
                                minimumSize: MaterialStateProperty.all(
                                    const Size(10, 40)),
                                textStyle: MaterialStateProperty.all<TextStyle>(
                                  const TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ),
                              child: const Text('Selecionar Imagen'),
                            ),
                            const Spacer(),
                            OutlinedButton(
                              onPressed: _pickPdf,
                              style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.black)
                                  .copyWith(
                                side:
                                    MaterialStateProperty.all(const BorderSide(
                                  color: Colors.grey, // color del borde
                                  width: 1.0, // ancho del borde
                                )),
                                minimumSize: MaterialStateProperty.all(
                                    const Size(10, 40)),
                                textStyle: MaterialStateProperty.all<TextStyle>(
                                  const TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ),
                              child: const Text('Selecionar Menu "pdf"'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                          padding: const EdgeInsets.only(right: 30.0, left: 30),
                          child: flag
                              ? ElevatedButton(
                                  onPressed: () {
                                    toggleBussines();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    // ignore: deprecated_member_use
                                    primary: Colors.blue, // color de fondo
                                    // onPrimary: Colors.white, // color del texto
                                    side: const BorderSide(
                                      color: Colors.grey, // color del borde
                                      width: 1.0, // ancho del borde
                                    ),
                                    minimumSize: const Size(999, 40),
                                    textStyle: const TextStyle(
                                        fontSize: 16,
                                        color:
                                            Color.fromARGB(255, 187, 77, 77)),
                                  ),
                                  child: const Text('Activar Negocio'),
                                )
                              : ElevatedButton(
                                  onPressed: () {
                                    // postLocal();
                                    toggleBussines();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    // ignore: deprecated_member_use
                                    primary: Colors.red, // color de fondo
                                    // onPrimary: Colors.white, // color del texto
                                    side: const BorderSide(
                                      color: Colors.grey, // color del borde
                                      width: 1.0, // ancho del borde
                                    ),
                                    minimumSize: const Size(999, 40),
                                    textStyle: const TextStyle(
                                        fontSize: 16,
                                        color:
                                            Color.fromARGB(255, 187, 77, 77)),
                                  ),
                                  child: const Text('Desactivar Negocio'),
                                )),
                      Container(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: ElevatedButton(
                          onPressed: () {
                            postLocal();
                          },
                          style: ElevatedButton.styleFrom(
                            // ignore: deprecated_member_use
                            primary: Colors.black, // color de fondo
                            // onPrimary: Colors.white, // color del texto
                            side: const BorderSide(
                              color: Colors.grey, // color del borde
                              width: 1.0, // ancho del borde
                            ),
                            minimumSize: const Size(999, 40),
                            textStyle: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 187, 77, 77)),
                          ),
                          child: const Text('Actualizar Negocio'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      String filePath = result.files.single.path!;
      String extension = filePath.split('.').last.toLowerCase();

      if (extension == 'jpg' ||
          extension == 'jpeg' ||
          extension == 'png' ||
          extension == 'gif') {
        setState(() {
          selectedFile = File(filePath);
          // fileName = result.files.single.name ?? '';
        });

        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
        ); // That's it to display an alert, use other properties to customize.
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: 'No has cargado el archivo esperado, ¡intentalo de nuevo!',
        );
      }
    }
  }

  Future<void> _pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      String filePath = result.files.single.path!;
      String extension = path.extension(filePath);

      if (extension.toLowerCase() == ".pdf") {
        setState(() {
          selectPdf = File(filePath);
        });
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
        ); // That's it to display an alert, use other properties to customize.
      } else {
        // No es un archivo PDF, muestra la alerta.
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: 'No has cargado el archivo esperado, ¡intentalo de nuevo!',
        );
      }
    }
  }

  void postLocal() {
    if (_formKey.currentState!.validate()) {
      // Realizar la acción deseada

      List<NewLocal> data = [
        NewLocal(
          id: 0,
          namelocal: _nameLocalFieldController.text,
          genero: _genero.text,
          descripcion: _descripcion.text,
          ubicacion: _ubicacion.text,
          menu: '',
          imagen2: selectedFile!,
          imagen: '',
        ),
      ];

      // context.read<CreateLocalBloc>().add(CreateLocalRequest(data[0]));
      final createLocalBloc = context.read<CreateLocalBloc>();

      // Agrega el evento para realizar la operación en el Bloc
      createLocalBloc.add(CreateLocalRequest(data[0]));
    }
    // _resetLocalStatus();
  }

  void _resetLocalStatus() {
    context.read<CreateLocalBloc>().add(ReseteLocal());
  }
}
