import 'dart:io';

import 'package:flutter/material.dart';
import 'package:localeats/features/user/presentation/pages/profile.dart';
// import 'package:file_picker/file_picker.dart';

class CreateLocal extends StatefulWidget {
  const CreateLocal({super.key});

  @override
  State<CreateLocal> createState() => _CreateLocalState();
}

class _CreateLocalState extends State<CreateLocal> {
  File? selectedFile;

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
      body: Column(
        children: [
          if (selectedFile != null)
            Image.file(
              selectedFile!,
              width: 200,
              height: 200,
            ),
          Image.asset(
            'ruta/de/tu/imagen/local.jpg', // Reemplaza con la ruta correcta de tu imagen local
            width: 200,
            height: 200,
          )
        ],
      ),
    );
  }
}
