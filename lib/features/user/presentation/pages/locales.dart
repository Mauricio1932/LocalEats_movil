import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
// import 'package:infinite_carousel/infinite_carousel.dart';

// import 'package:localeats/features/user/presentation/pages/create_account.dart';
import 'package:localeats/features/user/presentation/pages/profile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../bloc/bloc_locales/locales_bloc.dart';
import '../bloc/bloc_locales/locales_event.dart';
import '../bloc/bloc_locales/locales_state.dart';
import '../bloc/bloc_login/user_bloc.dart';
import '../bloc/bloc_login/user_event.dart';
import '../bloc/bloc_single_local/single_local_bloc.dart';
import '../bloc/bloc_single_local/single_local_event.dart';
import 'local_single.dart';

// import '../bloc/locales_state.dart';
// import '../locales.dart';

class LocalView extends StatefulWidget {
  const LocalView({super.key});

  @override
  State<LocalView> createState() => __LocalViewState();
}

class __LocalViewState extends State<LocalView> {
  void viewLocal(int localId) {
    // context.read<LocalesBloc>().add(LocalSingleView(localId));
    // print('ese es el id: $localId');
    context.read<LocalesSingleBloc>().add(LocalSingleView(localId));
    localpage(localId);
  }

  void localpage(id) {
    Navigator.pushReplacement(
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
                backgroundImage: AssetImage('assets/download5.jpg'),
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
                      'LocalEats',
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
                      Text(
                        "LocalEats",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                // Acción al hacer clic en el botón de cuenta
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      body:
       NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: BlocBuilder<LocalesBloc, LocalesState>(
                builder: (context, state) {
                  if (state.localesStatus == LocalesRequest.requestInProgress) {
                    return const CircularProgressIndicator();
                  }
                  if (state.localesStatus == LocalesRequest.requestFailure) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Problem loading products'),
                        const SizedBox(height: 10),
                        OutlinedButton(
                          onPressed: () {
                            context.read<LocalesBloc>().add(LocalRequest());
                          },
                          child: const Text('Try again'),
                        ),
                      ],
                    );
                  }
                  if (state.localesStatus == LocalesRequest.unknown) {
                    context.read<LocalesBloc>().add(LocalRequest());
                  }

                  return Column(
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
                        itemCount: state.locales.length,
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
                                  color: const Color(0x90FAFAFA),
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
                                            'http://192.168.1.69:3000/api/local/view_img?img1=${local.imagen}',
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
                  );
                },
              ),
            ),
          ];
        },
        body: Center(
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
                              color: const Color.fromRGBO(193, 193, 193, 0.354),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        'http://192.168.1.69:3000/api/local/view_img?img1=${local.imagen}',
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
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        padding: const EdgeInsets.all(0.0),
                                        child: Text(
                                          local.genero,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: Color(0xFF4B4A4A),
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
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
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
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
    // Profile();
    Navigator.pushReplacement(
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
}

// TENGO EL SIG. CODIGO PERO LA LISTA NO FUNCIONA
