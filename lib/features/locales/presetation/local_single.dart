import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localeats/features/maps/presentation/pages/maps.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:localeats/features/pdf/view_pdf.dart';
// import 'package:localeats/features/user/presentation/bloc/bloc_locales/locales_state.dart';

import '../../maps/domain/entities/entities.dart';
import '../../maps/presentation/bloc/bloc_maps/Mapsbloc.dart';
import '../../maps/presentation/bloc/bloc_maps/maps_event.dart';
import '../../menu/domain/entities/entities.dart';
import '../../menu/presentation/bloc/bloc_menu/menu_bloc.dart';
import '../../menu/presentation/bloc/bloc_menu/menu_event.dart';
import '../../menu/presentation/pages/menu.dart';
import '../../user/presentation/bloc/bloc_single_local/single_local_bloc.dart';
import '../../user/presentation/bloc/bloc_single_local/single_local_event.dart';
import '../../user/presentation/bloc/bloc_single_local/single_local_state.dart';
import 'locales.dart';
// import 'locales.dart';

class SingleViewLocal extends StatefulWidget {
  final int id;
  const SingleViewLocal(this.id, {Key? key}) : super(key: key);

  @override
  State<SingleViewLocal> createState() => _SingleViewLocalState();
}

class _SingleViewLocalState extends State<SingleViewLocal> {
  ScrollController controller = ScrollController();

  double nearMeIconScale = 0.8; // Escala del icono "near me"
  double starIconScale = 0.8;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _comentarioFieldController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocBuilder<LocalesSingleBloc, LocalSingleState>(
        builder: (context, state) {
          if (state.localesStatus == SingleRequest.requestInProgress) {
            // context.read<LocalesSingleBloc>().add(LocalSingleView(widget.id));
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.localesStatus == SingleRequest.requestFailure) {
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
                        // print("${widget.id}");

                        var localId = widget.id;
                        context
                            .read<LocalesSingleBloc>()
                            .add(LocalSingleView(localId));
                      },
                      child: const Text('Try again'))
                ],
              ),
            );
          }
          if (state.localesStatus == SingleRequest.unknown) {
            context.read<LocalesSingleBloc>().add(LocalSingleView(widget.id));
          }
          final local = state.locales.first;

          return Stack(
            children: [
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.network(
                        'http://192.168.1.117:3000/api/local/view_img?img1=${local.imagen}', // Reemplaza con la URL de la imagen que desees cargar
                        height: 250.0, // Altura de la imagen en píxeles
                        fit: BoxFit
                            .cover, // Ajusta la imagen para que llene el contenedor
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: FractionalTranslation(
                        translation: const Offset(0.0, -0.5),
                        child: Container(
                            width: 150,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: const Color.fromARGB(255, 242, 90, 90),
                            ),
                            child: TextButton(
                              onPressed: () {
                                // Lógica que se ejecutará cuando se presione el botón
                                goingToLocation(local.id);
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: const BorderSide(
                                        color: Colors.white, width: 2.0),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(Colors
                                        .black), // Color de fondo del botón
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.near_me,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Ubicación',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    // padding: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Align(
                      alignment: Alignment.topLeft, //
                      child: Column(
                        children: [
                          Text(
                            local.namelocal,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // SizedBox(height: 2),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    // padding: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Align(
                      alignment: Alignment.topLeft, //
                      child: Column(
                        children: [
                          Text(
                            local.genero,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          // SizedBox(height: 2),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    // padding: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Align(
                      alignment: Alignment.topLeft, //
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            controller: controller,
                            child: Column(
                              children: [
                                Text(
                                  local.descripcion,
                                  overflow: TextOverflow.fade,
                                  maxLines: 4,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey,
                                  ),
                                  // softWrap: true,
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(height: 2),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    // padding: EdgeInsets.all(100),
                    width: deviceWidth * 0.9,
                    height: deviceWidth * 0.45,
                    color: const Color.fromARGB(255, 247, 247, 247),
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 9.0),
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              // itemCount: state.comentario.length,
                              itemBuilder: (BuildContext context, int index) {
                                // final comentario = state.comentario[index];
                                return const Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start, // Alinea el texto a la izquierda
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Text(
                                          'comentario: ',
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          "comentario.comment",
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 16,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Otros elementos si es necesario
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                    controller: _comentarioFieldController,
                                    decoration: const InputDecoration(
                                      labelStyle: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                      hintText: 'Añade un Comentario',
                                      hintStyle: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors
                                                .black), // Color de la línea de abajo cuando está enfocado
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'El comentario no debe estar vacio';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.send),
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  onPressed: () {
                                    sendComent(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),

                  // const SizedBox(height: 180),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 9, horizontal: 20),
                    child: Positioned(
                      bottom: 0, // Ajusta la distancia desde la parte inferior
                      left: 10, // Ajusta la distancia desde la izquierda
                      right: 10, // Ajusta la distancia desde la derecha
                      child: OutlinedButton(
                        onPressed: () {
                          lookMenu(local.id);
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                              color: Colors.black), // Ajusta el color del borde
                        ),
                        child: Container(
                          height: 50,
                          width: 9360,
                          alignment: Alignment.center,
                          child: const Text(
                            'Ver Menú',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black, // Ajusta el color del texto
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 9, horizontal: 20),
                    child: Positioned(
                      bottom: 0, // Ajusta la distancia desde la parte inferior
                      left: 10, // Ajusta la distancia desde la izquierda
                      right: 10, // Ajusta la distancia desde la derecha
                      child: ElevatedButton(
                        onPressed: () {
                          var localId = widget.id;

                          context
                              .read<LocalesSingleBloc>()
                              .add(DeleteViewLocal(localId));
                          backHome();
                        },
                        style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(const Size(9360, 50)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          textStyle: MaterialStateProperty.all<TextStyle>(
                            const TextStyle(fontSize: 16),
                          ),
                        ),
                        child: const Text('Cerrar'),
                      ),
                    ),
                  ),
                ],
              ),

              // Stack(
              //   children: [
              //     // Coloca aquí el contenido principal de tu app
              //     // Center(
              //     //   // child: Text('Contenido de la aplicación'),
              //     // ),
              //     // Botones en la parte inferior
              //     Positioned(
              //       left: 0,
              //       right: 0,
              //       bottom: 0,
              //       child: Column(
              //         children: [
              //           const SizedBox(height: 180),
              //           Padding(
              //             padding: const EdgeInsets.symmetric(
              //                 vertical: 10, horizontal: 20),
              //             child: Positioned(
              //               bottom:
              //                   20, // Ajusta la distancia desde la parte inferior
              //               left: 10, // Ajusta la distancia desde la izquierda
              //               right: 10, // Ajusta la distancia desde la derecha
              //               child: OutlinedButton(
              //                 onPressed: () {
              //                   lookMenu(local.id);
              //                   // var localId = widget.id;

              //                   // context
              //                   //     .read<LocalesSingleBloc>()
              //                   //     .add(DeleteViewLocal(localId));
              //                   // backHome();
              //                 },
              //                 style: OutlinedButton.styleFrom(
              //                   side: const BorderSide(
              //                       color: Colors
              //                           .black), // Ajusta el color del borde
              //                 ),
              //                 child: Container(
              //                   height: 50,
              //                   width: 9360,
              //                   alignment: Alignment.center,
              //                   child: const Text(
              //                     'Ver Menú',
              //                     style: TextStyle(
              //                       fontSize: 16,
              //                       color: Colors
              //                           .black, // Ajusta el color del texto
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.symmetric(
              //                 vertical: 10, horizontal: 20),
              //             child: Positioned(
              //               bottom: 0,
              //               left: 10, // Ajusta la distancia desde la izquierda
              //               right: 10, // Ajusta la distancia desde la derecha
              //               child: ElevatedButton(
              //                 onPressed: () {
              //                   var localId = widget.id;

              //                   context
              //                       .read<LocalesSingleBloc>()
              //                       .add(DeleteViewLocal(localId));
              //                   backHome();
              //                 },
              //                 style: ButtonStyle(
              //                   minimumSize: MaterialStateProperty.all(
              //                       const Size(9360, 50)),
              //                   backgroundColor:
              //                       MaterialStateProperty.all<Color>(
              //                           Colors.black),
              //                   textStyle: MaterialStateProperty.all<TextStyle>(
              //                     const TextStyle(fontSize: 16),
              //                   ),
              //                 ),
              //                 child: const Text('Cerrar'),
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
            ],
          );
        },
      ),
    );
  }

  void backHome() {
    // context.read<LocalesBloc>().add(LocalSingleView(localId));
    // context.read<LocalesBloc>().add(LocalRequest());

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween(
              begin:
                  const Offset(0, -1), // Cambia aquí para iniciar desde arriba
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        // ... Otros parámetros de PageRouteBuilder);

        pageBuilder: (_, __, ___) => const LocalView(),
      ),
    );
  }

  void goingToLocation(id) {
    // context.read<LocalesBloc>().add(LocalSingleView(localId));
    List<Maps> maps = [
      Maps(id: id, ubicacion: ""),
    ];
    context.read<MapsBloc>().add(MapViewRequest(maps[0]));

    Navigator.push(
      context,
      PageRouteBuilder(
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween(
              begin:
                  const Offset(0, -1), // Cambia aquí para iniciar desde arriba
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        // ... Otros parámetros de PageRouteBuilder);

        pageBuilder: (_, __, ___) => MapScreen(), //pasar el id
      ),
    );
  }

  void lookMenu(id) {
    // MaterialPageRoute(
    //   builder: (context) => PDFScreen(path: remotePDFpath!),
    // );
    // context.read<LocalesBloc>().add(LocalSingleView(localId));
    // context.read<LocalesBloc>().add(LocalRequest());
    List<Menu> menu = [
      Menu(id: id, pdf: ''),
    ];
    context.read<MenuBloc>().add(GetPdfMenu(menu[0]));

    //insertar evento menu
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween(
              begin:
                  const Offset(0, -1), // Cambia aquí para iniciar desde arriba
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        // ... Otros parámetros de PageRouteBuilder);

        pageBuilder: (_, __, ___) => PDFScreen(
          id2: id,
        ),
      ),
    );
  }
}

Future<void> sendComent(context) async {
  print("Send comment");
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  final token = sharedPreferences.getString('auth_token') ?? '';

  if (token.isEmpty) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Oops...',
      text: 'No tienes una sesion iniciada, ¡intentalo de nuevo!',
    );
  } else {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Oops...',
      text: 'No has cargado el archivo esperado, ¡intentalo de nuevo!',
    );
  }
}
