import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class ViewPdf extends StatefulWidget {
  @override
  _ViewPdfState createState() => _ViewPdfState();
}

class _ViewPdfState extends State<ViewPdf> {
  String? remotePDFpath;
  // PDFViewController? _pdfViewController;

  @override
  void initState() {
    super.initState();
    loadRemotePDF();
  }

  Future<void> loadRemotePDF() async {
    try {
      // Aquí puedes poner la URL del PDF que desees cargar
      const remotePDFUrl =
          "https://img1.wsimg.com/blobby/go/38cd8d70-7daa-4e1d-8176-428903e248e3/071822%2013va%20Edicion%202022%20MENU%20GRANDE%20COMIDAS.pdf";

      setState(() {
        remotePDFpath = remotePDFUrl;
      });
    } catch (e) {
      print("Error cargando el PDF remoto: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter PDF View',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Ejemplo de PDF')),
        body: Center(
          child: Builder(
            builder: (BuildContext context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      if (remotePDFpath != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PDFScreen(path: remotePDFpath!),
                          ),
                        );
                      }
                    },
                    child: Text("Ver PDF remoto"),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class PDFScreen extends StatefulWidget {
  final String path;

  PDFScreen({Key? key, required this.path}) : super(key: key);

  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? currentPage = 0;
  int? totalPages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menú"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          PDF(
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: true,
            pageSnap: true,
            fitPolicy: FitPolicy.BOTH,
            onPageChanged: (int? page, int? total) {
              // print('Página cambiada: $page/$total');
              setState(() {
                currentPage = page;
                totalPages = total;
              });
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
          ).cachedFromUrl(widget.path),
          Positioned(
            bottom: 16,
            left: 16,
            right:
                16, // Agrega margen a la derecha para evitar que los botones se salgan
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    if (_controller.isCompleted) {
                      _controller.future.then((controller) {
                        if (currentPage! > 0) {
                          controller.setPage(currentPage! - 1);
                        }
                      });
                    }
                  },
                  iconSize: 60,
                  icon: const Icon(Icons.arrow_circle_left_outlined),
                ),
                IconButton(
                  onPressed: () {
                    if (_controller.isCompleted) {
                      _controller.future.then((controller) {
                        if (currentPage! < totalPages! - 1) {
                          controller.setPage(currentPage! + 1);
                        }
                      });
                    }
                  },
                  iconSize: 60,
                  icon: const Icon(Icons.arrow_circle_right_outlined),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
