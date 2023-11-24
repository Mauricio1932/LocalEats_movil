import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localeats/features/user/presentation/pages/vista_login.dart';

import '../../../locales/presetation/create_local.dart';
import '../../../locales/presetation/mi_bussinies.dart';
import '../bloc/bloc_login/user_bloc.dart';
import '../bloc/bloc_login/user_event.dart';
import '../bloc/bloc_login/user_state.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void cerrarSesion() {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state.userStatus == UserRequest.requestInProgress) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.userStatus == UserRequest.requestFailure) {
          return const LoginView();
          // Navigator.of(context).pushReplacement(
          //   MaterialPageRoute(
          //     builder: (BuildContext context) =>  LoginView(),
          //   ),
          // );
        }
        if (state.userStatus == UserRequest.unknown) {
          context.read<UserBloc>().add(GetAuthToken());
        }
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.black,
              onPressed: () {
                // Lógica para manejar el botón de retroceso aquí
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.grey[300],
            elevation: 0,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 60, right: 60),
                  child: Text(
                    'Maria Cruz',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.logout),
                  color: Colors.black,
                  onPressed: () {
                    context.read<UserBloc>().add(RemoveAuthToken());
                    context.read<UserBloc>().add(GetAuthToken());
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          body: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state.userStatus == UserRequest.requestInProgress) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.userStatus == UserRequest.requestFailure) {
                return const LoginView();
              }
              if (state.userStatus == UserRequest.unknown) {
                context.read<UserBloc>().add(GetAuthToken());
              }
              return Column(
                children: [
                  const SizedBox(height: 45),
                  Column(
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(
                            color: const Color.fromARGB(255, 152, 151, 151),
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: ClipOval(
                            child: Image.asset(
                              'assets/download5.jpg',
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Column(
                    children: [
                      Text(
                        'Home',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Mis Establecimientos',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const MiBussines(),
                ],
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position: Tween(
                        begin: const Offset(
                            1, 0), // Cambia aquí para iniciar desde arriba
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                  // ... Otros parámetros de PageRouteBuilder);

                  pageBuilder: (_, __, ___) => const CreateLocal(),
                ),
              );
            },
            backgroundColor: const Color.fromARGB(255, 248, 248, 248),
            child: const Icon(Icons.add, color: Colors.black),
          ),
        );
      },
    );
  }
}
