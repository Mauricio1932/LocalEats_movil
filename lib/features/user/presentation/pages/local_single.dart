import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:localeats/features/user/presentation/bloc/bloc_locales/locales_state.dart';
import '../bloc/bloc_single_local/single_local_bloc.dart';
import '../bloc/bloc_single_local/single_local_event.dart';
import '../bloc/bloc_single_local/single_local_state.dart';
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
  @override
  Widget build(BuildContext context) {
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

        return Stack(children: [
          Column(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.network(
                  local
                      .image, // Reemplaza con la URL de la imagen que desees cargar
                  height: 200.0, // Altura de la imagen en píxeles
                  fit: BoxFit
                      .contain, // Ajusta la imagen para que llene el contenedor
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Align(
                alignment: Alignment
                    .topCenter, // Ajusta la posición vertical del cuadro
                child: FractionalTranslation(
                  translation:
                      const Offset(0.0, -0.5), // Mueve el cuadro hacia arriba
                  child: Container(
                    width:
                        150, // Ajusta el ancho del cuadro según tus necesidades
                    height:
                        35, // Ajusta el alto del cuadro según tus necesidades
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.black,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.scale(
                          scale: nearMeIconScale,
                          child: const Icon(
                            Icons.near_me,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          'Ubicación',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                      local.title,
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
                      local.category,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 13,
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
                            local.description,
                            overflow: TextOverflow.fade,
                            maxLines: 4,
                            style: const TextStyle(
                              fontSize: 12,
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
            const SizedBox(height: 240),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Positioned(
                bottom: 20, // Ajusta la distancia desde la parte inferior
                left: 10, // Ajusta la distancia desde la izquierda
                right: 10, // Ajusta la distancia desde la derecha
                child: ElevatedButton(
                  onPressed: () {
                    // context
                    //     .read<LocalesSingleBloc>()
                    //     .add(DeleteViewLocal(local.id));

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
                  child: const Text('Close business'),
                ),
              ),
            ),
          ]),
        ]);
      }),
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
}
