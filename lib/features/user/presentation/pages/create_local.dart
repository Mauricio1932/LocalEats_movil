// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:localeats/features/user/presentation/pages/profile.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;

import 'package:quickalert/quickalert.dart';
// import 'package:quickalert/widgets/quickalert_dialog.dart';

// ...

class CreateLocal extends StatefulWidget {
  const CreateLocal({super.key});

  @override
  State<CreateLocal> createState() => _CreateLocalState();
}

class _CreateLocalState extends State<CreateLocal> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _genero = TextEditingController();
  final TextEditingController _descripcion = TextEditingController();
  final TextEditingController _ubicacion = TextEditingController();
  final TextEditingController _nameLocalFieldController =
      TextEditingController();

  File? selectedFile;
  File? selectPdf;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const Profile(),
                  ),
                );
              },
            ),
            // Spacer()
            const Padding(
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  if (selectedFile != null)
                    Image.file(
                      selectedFile!,
                      width: 350,
                      height: 300,
                    ),
                  if (selectedFile == null)
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
                              color:
                                  Colors.black), // Color del texto de entrada
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

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, ingrese el nombre del negocio.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          style: const TextStyle(
                              color:
                                  Colors.black), // Color del texto de entrada
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
                              color:
                                  Colors.black), // Color del texto de entrada
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
                              color:
                                  Colors.black), // Color del texto de entrada
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30.0, vertical: 0),
                  child: Row(
                    children: [
                      OutlinedButton(
                        onPressed: _pickFile,
                        style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.black)
                            .copyWith(
                          side: MaterialStateProperty.all(const BorderSide(
                            color: Colors.grey, // color del borde
                            width: 1.0, // ancho del borde
                          )),
                          minimumSize:
                              MaterialStateProperty.all(const Size(10, 40)),
                          textStyle: MaterialStateProperty.all<TextStyle>(
                            const TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),
                        child: const Text('Selecionar Imagen'),
                      ),
                      Spacer(),
                      OutlinedButton(
                        onPressed: _pickPdf,
                        style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.black)
                            .copyWith(
                          side: MaterialStateProperty.all(const BorderSide(
                            color: Colors.grey, // color del borde
                            width: 1.0, // ancho del borde
                          )),
                          minimumSize:
                              MaterialStateProperty.all(const Size(10, 40)),
                          textStyle: MaterialStateProperty.all<TextStyle>(
                            const TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),
                        child: const Text('Selecionar Menu "pdf"'),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 5),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
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
                      child: const Text('Publicar'),
                    ))
              ],
            ),
          ],
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
}
