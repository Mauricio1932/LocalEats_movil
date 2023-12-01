import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iconsax/iconsax.dart';
// import 'package:infinite_carousel/infinite_carousel.dart';

// import 'package:localeats/features/user/presentation/pages/create_account.dart';
import 'package:localeats/features/user/presentation/pages/profile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:quickalert/quickalert.dart';

import '../../user/presentation/bloc/bloc_locales/locales_bloc.dart';
import '../../user/presentation/bloc/bloc_locales/locales_event.dart';
import '../../user/presentation/bloc/bloc_locales/locales_state.dart';
import '../../user/presentation/bloc/bloc_login/user_bloc.dart';
import '../../user/presentation/bloc/bloc_login/user_event.dart';
import '../../user/presentation/bloc/bloc_single_local/single_local_bloc.dart';
import '../../user/presentation/bloc/bloc_single_local/single_local_event.dart';

import 'local_single.dart';

// import '../bloc/locales_state.dart';
// import '../locales.dart';

class LocalView extends StatefulWidget {
  const LocalView({super.key});

  @override
  State<LocalView> createState() => __LocalViewState();
}

class __LocalViewState extends State<LocalView> {
  late Position _currentPosition;
  late String _currentAddress;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark placemark = placemarks[0];

      setState(() {
        _currentPosition = position;
        _currentAddress =
            "${placemark.name}, ${placemark.locality}, ${placemark.country}";
      });
    } catch (e) {
      print('Error al obtener la ubicación: $e');
    }
  }

  void viewLocal(int localId) {
    // context.read<LocalesBloc>().add(LocalSingleView(localId));
    // print('ese es el id: $localId');
    context.read<LocalesSingleBloc>().add(LocalSingleView(localId));

    localpage(localId);
  }

  void localpage(id) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation), // Agrega ".animate(animation)" aquí
            child: child,
          );
        },
        pageBuilder: (_, __, ___) => SingleViewLocal(id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // double deviceWidth = MediaQuery.of(context).size.width;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        toolbarHeight: 100,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color.fromARGB(255, 221, 220, 220),
                  width: 2.0,
                ),
              ),
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/local_logo.jpg'),
                radius: 16,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    child: const Text(
                      'LocalExplorer',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.my_location,
                        color: Colors.black,
                        size: 20,
                      ),
                      SizedBox(width: 3),
                      
                    ],
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                _handleRefresh();
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  Iconsax.refresh_square_25,
                  color: Colors.black,
                  size: 31,
                ),
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<LocalesBloc, LocalesState>(
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
                      context.read<LocalesBloc>().add(LocalGetRequest());
                    },
                    child: const Text('Try again'),
                  ),
                ],
              ),
            );
          }
          if (state.localesStatus == LocalesRequest.unknown) {
            context.read<LocalesBloc>().add(LocalGetRequest());
          }
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 15),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Locales Destacados',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CarouselSlider.builder(
                        options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 2.0,
                          // enlargeCenterPage: true,
                          // enlargeStrategy: C|enterPageEnlargeStrategy.height,
                        ),
                        // itemCount: state.locales.length,
                        itemCount: min(6, state.locales.length),
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                          final local = state.locales[index];

                          return InkWell(
                            onTap: () {
                              viewLocal(local.id);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(144, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(
                                      12.0), // Otras opciones de decoración según sea necesario
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: deviceWidth * 0.8,
                                      height: 140,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            'http://192.168.43.57:3000/api/local/view_img?img1=${local.imagen}',
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Container(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Column(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  local.namelocal,
                                                  style: const TextStyle(
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  local.genero,
                                                  style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 15,
                                                    color: Color.fromARGB(
                                                        255, 75, 74, 74),
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ];
            },
            body: RefreshIndicator(
              onRefresh: _handleRefresh,
              child: Center(
                child: BlocBuilder<LocalesBloc, LocalesState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 15),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Todos los locales',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          // Agregado el Expanded

                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: state.locales.length,
                            itemBuilder: (BuildContext context, int index) {
                              final local = state.locales[index];

                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      viewLocal(local.id);
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 140,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                'http://192.168.43.57:3000/api/local/view_img?img1=${local.imagen}',
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Column(
                                            children: [
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  local.namelocal,
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                child: Text(
                                                  local.genero,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13,
                                                    color: Color(0xFF4B4A4A),
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: _createBottonNavigationBar(),
    );
  }

  int _selectedIndex = 0;
  Widget _createBottonNavigationBar() {
    return BottomNavigationBar(
      showUnselectedLabels: false,
      backgroundColor: Colors.grey[300],
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      unselectedItemColor: const Color.fromARGB(255, 0, 0, 0),
      selectedIconTheme:
          const IconThemeData(color: Color.fromARGB(255, 80, 80, 80)),
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/local_logo.jpg', width: 50, height: 50),
          label: 'LocalExplorer',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Iconsax.user),
          label: 'Profile',
        ),
      ],
      selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // registros();
        break;
      case 1:
        // register();
        break;
      case 2:
        // register();
        login();
        break;
    }
  }

  void login() {
    context.read<UserBloc>().add(GetAuthToken());
    // context.read<MyBussinesBloc>().add(GetBussinesRequest());

    // Profile();
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween(
              begin:
                  const Offset(1, 0), // Cambia aquí para iniciar desde arriba
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        // ... Otros parámetros de PageRouteBuilder);

        pageBuilder: (_, __, ___) => const Profile(),
      ),
    );
  }

  void profile() {}
  Future<void> _handleRefresh() async {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Loading',
      text: 'Fetching your data',
    );
    await Future.delayed(Duration(seconds: 2)); //
    Navigator.pop(context);

    // print('Datos recargados');

    context.read<LocalesBloc>().add(LocalGetRequest());
  }
}

// TENGO EL SIG. CODIGO PERO LA LISTA NO FUNCIONA
