// import 'package:flutter/material.dart';

// import '../data/models/local_model.dart';

// class LocalDetailPage extends StatelessWidget {
//   final LocalModel local;

//   const LocalDetailPage({required this.local});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Detalles del Local'),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               local.namelocal,
//               style: TextStyle(
//                 fontSize: 24.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 16.0),
//             Image.network(
//               local.imagen,
//               width: double.infinity,
//               height: 200.0,
//               fit: BoxFit.cover,
//             ),
//             SizedBox(height: 16.0),
//             Text(
//               'Descripción:',
//               style: TextStyle(
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               local.descripcion,
//               style: TextStyle(fontSize: 16.0),
//             ),
//             SizedBox(height: 16.0),
//             Text(
//               'Categoría: ${local.genero}',
//               style: TextStyle(fontSize: 16.0),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
