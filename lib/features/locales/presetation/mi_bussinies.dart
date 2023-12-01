import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localeats/features/locales/presetation/bloc/bloc/my_bussines_bloc.dart';
import 'package:localeats/features/locales/presetation/bloc/bloc/my_bussines_state.dart';
import 'package:localeats/features/locales/presetation/edit_local.dart';

import '../../user/presentation/bloc/bloc_locales/locales_bloc.dart';
import '../../user/presentation/bloc/bloc_locales/locales_event.dart';
import '../data/datasourses/locales_data_sourse.dart';
import '../domain/entities/local.dart';
import 'bloc/bloc/my_bussines_event.dart';

class MiBussines extends StatefulWidget {
  const MiBussines({super.key});

  @override
  State<MiBussines> createState() => _MiBussinesState();
}

class _MiBussinesState extends State<MiBussines> {
  bool flag = false;
  late Future<List<Local>> myLocalsFuture;

  @override
  void initState() {
    super.initState();
    myLocalsFuture =
        getMyLocaless(); // Inicializa la variable con la operación asíncrona
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyBussinesBloc, MyBussinesState>(
      builder: (context, state) {
        if (state.bussinesStatus == MyBussinesRequest.requestSuccess) {
          getMyLocaless();

          // return const Center(child: CircularProgressIndicator());
        }
        if (state.bussinesStatus == MyBussinesRequest.requestInProgress) {
          getMyLocaless();
          return const Center(child: CircularProgressIndicator());
        }
        if (state.bussinesStatus == MyBussinesRequest.requestFailure) {
          getMyLocaless();

          if (state.bussiness.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: [
                  // SizedBox(height: 100),
                  Text(
                    "No tienes negocios aún. ¡Comienza ahora y regístralos para ser conocido.",
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
            );
          } else {
            context.read<MyBussinesBloc>().add(GetBussinesRequest());
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  const Text('Problem loading my bussines'),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () {
                      context.read<MyBussinesBloc>().add(GetBussinesRequest());
                    },
                    child: const Text('Try again'),
                  ),
                ],
              ),
            );
          }
        }
        
        if (state.bussinesStatus == MyBussinesRequest.unknown) {
          getMyLocaless();
          context.read<MyBussinesBloc>().add(GetBussinesRequest());
        }
        return Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            height: 500,
            child: FutureBuilder<List<Local>>(
              // Utiliza FutureBuilder para manejar la operación asíncrona
              future: myLocalsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Text(
                          "No tienes negocios aún. ¡Comienza ahora y regístralos para ser conocido.",
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  );
                } else {
                  List<Local> locals = snapshot.data!;
                  return CarouselSlider.builder(
                    options: CarouselOptions(
                      height: 300,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      enlargeCenterPage: true,
                    ),
                    itemCount: (locals.length),
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      final local = locals[index];

                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return SlideTransition(
                                  position: Tween(
                                    begin: const Offset(1, 0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                );
                              },
                              pageBuilder: (_, __, ___) =>
                                  EditLocal(local: locals, id: index),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      'http://192.168.43.57:3000/api/local/view_img?img1=${local.imagen}',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromARGB(197, 45, 45, 45),
                                      Color.fromARGB(198, 0, 0, 0),
                                      Color.fromARGB(0, 0, 0, 0),
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                child: Text(
                                  local.namelocal,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  void _resetLocalStatus() {
    context.read<LocalesBloc>().add(GetMyLocals());

    // context.read<LocalesBloc>().add(ReseteLocal());
  }

  Future<List<Local>> getMyLocaless() async {
    ApiLocalDatasourceImp apiLocalDatasourceImp = ApiLocalDatasourceImp();

    try {
      List<Local> locals = await apiLocalDatasourceImp.getMyLocals();
      return locals;
    } catch (e) {
      throw e;
    }
  }
}


// Expanded(
//       child: Container(
//         padding: const EdgeInsets.only(left: 20, right: 20),
//         height: 370,
//         child: CarouselSlider(
//           options: CarouselOptions(
//             height: 300,
//             initialPage: 0,
//             enableInfiniteScroll: true,
//             autoPlay: true,
//             autoPlayInterval: const Duration(seconds: 3),
//             enlargeCenterPage: true,
//             // scrollDirection: Axis.horizontal,
//           ),
//           items: [1, 2, 3, 4, 5].map((i) {
//             return Builder(
//               builder: (BuildContext context) {
//                 return Stack(
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(12),
//                       child: Container(
//                         width: MediaQuery.of(context).size.width,
//                         margin: const EdgeInsets.symmetric(horizontal: 2.0),
//                         decoration: const BoxDecoration(
//                           image: DecorationImage(
//                             image: NetworkImage(
//                               'http://192.168.1.117:3000/api/local/view_img?img1=locales.jpg',
//                             ),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 0.0,
//                       left: 0.0,
//                       right: 0.0,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12.0),
//                           gradient: const LinearGradient(
//                             colors: [
//                               // Color.fromARGB(, 0, 0, 0),
//                               Color.fromARGB(197, 45, 45, 45),
//                               Color.fromARGB(198, 0, 0, 0),
//                               Color.fromARGB(0, 0, 0, 0),
//                             ],
//                             begin: Alignment.bottomCenter,
//                             end: Alignment.topCenter,
//                           ),
//                         ),
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 10.0, horizontal: 20.0),
//                         child: const Text(
//                           'No image',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             );
//           }).toList(),
//         ),
//       ),
//     );