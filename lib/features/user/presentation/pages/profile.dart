import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:localeats/features/user/presentation/pages/login.dart';
import 'package:localeats/features/user/presentation/pages/vista_login.dart';

// import 'home_page.dart';
import '../bloc/bloc_login/user_bloc.dart';
import '../bloc/bloc_login/user_event.dart';
import '../bloc/bloc_login/user_state.dart';
import 'locales.dart';

// import 'login.dart';

// import 'registerLocal.dart';

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
            backgroundColor: Colors.grey[300],
            elevation: 0,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) => const LocalView(),
                      ),
                    );
                  },
                ),
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
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) => const LocalView(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          body: Column(
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
              const SizedBox(height: 10),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      title: const Text(
                        'Home',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                    ),
                    ListTile(
                      title: const Text(
                        'Mi LocalEats',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Alerta, muy pronto'),
                    content: Text("Estamos trabajando en eso"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Cierra la alerta
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
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
