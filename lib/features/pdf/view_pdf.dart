// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';

// class ViewPdf extends StatefulWidget {
//   @override
//   _ViewPdfState createState() => _ViewPdfState();
// }

// class _ViewPdfState extends State<ViewPdf> {
//   String pathPDF = "";

//   @override
//   void initState() {
//     super.initState();
//     loadPDF();
//   }

//   Future<void> loadPDF() async {
//     try {
//       var dir = await getApplicationDocumentsDirectory();
//       var file = File("${dir.path}/demo.pdf");

//       if (!file.existsSync()) {
//         // Si el archivo no existe, copiarlo desde assets
//         ByteData data = await rootBundle.load("assets/menu.pdf");
//         List<int> bytes = data.buffer.asUint8List();
//         await file.writeAsBytes(bytes, flush: true);
//       }

//       setState(() {
//         pathPDF = file.path;
//       });
//     } catch (e) {
//       print("Error cargando el PDF: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter PDF View',
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Ejemplo de PDF')),
//         body: Center(
//           child: Builder(
//             builder: (BuildContext context) {
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   ElevatedButton(
//                     onPressed: () {
//                       if (pathPDF.isNotEmpty) {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => PDFScreen(path: pathPDF),
//                           ),
//                         );
//                       }
//                     },
//                     child: Text("Ver PDF local"),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class PDFScreen extends StatefulWidget {
//   final String? path;

//   PDFScreen({Key? key, this.path}) : super(key: key);

//   @override
//   _PDFScreenState createState() => _PDFScreenState();
// }

// class _PDFScreenState extends State<PDFScreen> {
//   final Completer<PDFViewController> _controller =
//       Completer<PDFViewController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Documento PDF"),
//       ),
//       body: PDFView(
//         filePath: widget.path,
//         autoSpacing: false,
//         pageFling: true,
//         pageSnap: true,
//         fitPolicy: FitPolicy.BOTH,
//         onPageChanged: (int? page, int? total) {
//           print('Página cambiada: $page/$total');
//         },
//         onViewCreated: (PDFViewController pdfViewController) {
//           _controller.complete(pdfViewController);
//         },
//       ),
//     );
//   }
// }
