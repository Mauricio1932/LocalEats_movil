import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import '../../domain/entities/entities.dart';
import '../bloc/bloc_menu/menu_bloc.dart';
import '../bloc/bloc_menu/menu_event.dart';
import '../bloc/bloc_menu/menu_state.dart';

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
                    onPressed: () {},
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
  int id2;

  PDFScreen({Key? key, required this.id2}) : super(key: key);

  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  String? remotePDFpath;
  int? currentPage = 0;
  int? totalPages;
  late String namePdf = "";


  Future<void> loadRemotePDF() async {
    try {
      // Aquí puedes poner la URL del PDF que desees cargar
      const remotePDFUrl = "http://192.168.43.57:3000/api/menu/view_pdf?pdf=";

      setState(() {
        remotePDFpath = "$remotePDFUrl$namePdf";
      });
    } catch (e) {
      print("Error cargando el PDF remoto: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menú"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: BlocBuilder<MenuBloc, MenuState>(
        builder: (context, state) {
          if (state.menuStatus == MenuRequest.requestInProgress) {
            // context.read<LocalesSingleBloc>().add(LocalSingleView(widget.id));
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.menuStatus == MenuRequest.requestFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Problem loading products'),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        List<Menu> menu = [
                          Menu(
                            id: widget.id2,
                            pdf: '',
                          ),
                        ];
                        context.read<MenuBloc>().add(GetPdfMenu(menu[0]));
                      },
                      child: const Text('Try again'))
                ],
              ),
            );
          }
          if (state.menuStatus == MenuRequest.requestSuccess) {
            print("cargo success");
            namePdf = state.menu[0].pdf;
            loadRemotePDF();

            print(namePdf);
            print(remotePDFpath);
          }
          if (state.menuStatus == MenuRequest.unknown) {
            List<Menu> menu = [
              Menu(id: widget.id2, pdf: ''),
            ];
            context.read<MenuBloc>().add(GetPdfMenu(menu[0]));
          }
          // return Text("data ${state.menu[0].pdf} ${state.menuStatus}");
          return Stack(
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
              ).cachedFromUrl(remotePDFpath!),
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
          );
        },
      ),
    );
  }
}
