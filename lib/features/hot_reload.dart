import 'package:flutter/material.dart';

class ReloadButton extends StatefulWidget {
  @override
  _ReloadButtonState createState() => _ReloadButtonState();
}

class _ReloadButtonState extends State<ReloadButton> {
  // Método para manejar la recarga de datos
  Future<void> _handleRefresh() async {
    // Aquí puedes poner la lógica para recargar tus datos
    // Por ejemplo, llamar a una función que recargue la información
    await Future.delayed(Duration(seconds: 2)); // Simulación de recarga
    print('Datos recargados');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reload Button'),
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Contenido de la lista...'),
            ),
            // Más elementos de la lista...
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ReloadButton(),
  ));
}
