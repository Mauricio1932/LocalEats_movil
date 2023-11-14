import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
// import 'package:localeats/features/user/presentation/pages/create_account.dart';
import 'package:localeats/features/user/presentation/pages/profile.dart';

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
    print('ese es el id: $localId');
    context.read<LocalesSingleBloc>().add(LocalSingleView(localId));
    localpage(localId);
  }

  void localpage(int id) {
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
      body: Center(
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
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        context.read<LocalesBloc>().add(LocalRequest());
                      },
                      child: const Text('Try again'))
                ],
              );
            }
            if (state.localesStatus == LocalesRequest.unknown) {
              context.read<LocalesBloc>().add(LocalRequest());
            }

            return Column(children: [
              const SizedBox(height: 0),
              const Padding(
                padding: EdgeInsets.only(top: 18.0, left: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Locales Destacados',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.locales.length,
                    itemBuilder: (BuildContext context, int index) {
                      final local = state.locales[index];
                      // final inLocal = state.localId.contains(local.id);

                      return InkWell(
                        onTap: () {
                          viewLocal(local.id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: deviceWidth * 0.8,
                                  height: 135,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      // http://localhost:3000/api/local/view_img?img1=2.jpg
                                      image: NetworkImage('http://10.11.2.252:3000/api/local/view_img?img1=${local.imagen}',), // Utiliza NetworkImage para cargar la imagen desde la red
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        // Acción al hacer clic en la imagen
                                        // Agrega aquí el código que deseas ejecutar al hacer clic en la imagen
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Container(
                                  width: deviceWidth * 0.8,
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(
                                    local.namelocal,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Container(
                                  width: deviceWidth * 0.8,
                                  padding: const EdgeInsets.all(0.0),
                                  child: Text(
                                    local.genero,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
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
              ),
              const SizedBox(width: 30),
              const Padding(
                padding: EdgeInsets.only(top: 0.0, left: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Todos los locales',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 60),
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: deviceWidth * 30000.20,
                    height: 400,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 2.0, left: 25.0),
                      scrollDirection: Axis.vertical,
                      itemCount: state.locales.length,
                      itemBuilder: (BuildContext context, int index) {
                        final local = state.locales[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: deviceWidth * 0.8,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    // image: AssetImage(local.imagen),
                                    image: NetworkImage(local.imagen),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Container(
                                width: deviceWidth * 0.8,
                                padding: const EdgeInsets.all(3.0),
                                child: const Text(
                                  "local.texto",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Container(
                                width: deviceWidth * 0.8,
                                padding: const EdgeInsets.all(0.0),
                                child: Text(
                                  "local.textoAdicional",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ]);
          },
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

  void profile(){
   
  }
}
