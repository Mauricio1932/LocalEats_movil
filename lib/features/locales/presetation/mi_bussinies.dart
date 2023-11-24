import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localeats/features/locales/presetation/edit_local.dart';

import '../../user/presentation/bloc/bloc_locales/locales_bloc.dart';
import '../../user/presentation/bloc/bloc_locales/locales_event.dart';
import '../../user/presentation/bloc/bloc_locales/locales_state.dart';

class MiBussines extends StatefulWidget {
  const MiBussines({super.key});

  @override
  State<MiBussines> createState() => _MiBussinesState();
}

class _MiBussinesState extends State<MiBussines> {
  bool flag = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalesBloc, LocalesState>(
      builder: (context, state) {
        if (state.localesStatus == LocalesRequest.requestInProgress) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.localesStatus == LocalesRequest.requestFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Problem loading products'),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {
                    context.read<LocalesBloc>().add(GetMyLocals());
                  },
                  child: const Text('Try again'),
                ),
              ],
            ),
          );
        }
        if (state.localesStatus == LocalesRequest.unknown) {
          context.read<LocalesBloc>().add(GetMyLocals());
        }
        return Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            height: 370,
            child: CarouselSlider.builder(
              options: CarouselOptions(
                height: 300,
                initialPage: 0,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                enlargeCenterPage: true,
              ),
              itemCount: (state.locales.length), // Limitar a 5 elementos
              itemBuilder: (BuildContext context, int index, int realIndex) {
                final local = state.locales[index];

                return Builder(
                  builder: (BuildContext context) {
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
                                EditLocal(local: state.locales, id: index),
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
                                    'http://192.168.1.117:3000/api/local/view_img?img1=${local.imagen}',
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
                          if (flag)
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 300, // Ajusta según tus necesidades
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(191, 0, 0,
                                    0), // Color del fondo si está desactivado
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Text(
                                  '🚫', // Símbolo de prohibición
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
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