import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'features/user/presentation/locales.dart';
// import 'features/users/presentation/pages/login.dart';
// import 'features/users/presentation/pages/home_page.dart';



class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        navigateToNextScreen(); // Navegar a la siguiente pantalla después de la vista splash
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void navigateToNextScreen() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LocalView()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadeTransition(
              opacity: _animation,
              child: Image.asset(
                'assets/logo2.png', // Reemplaza 'your_image.png' con la ruta de tu imagen en assets
                width: 150.0,
                height: 150.0,
              ),
            ),
            const SizedBox(height: 24.0),
            FadeTransition(
              opacity: _animation,
              child: const Text(
                'LocalEats',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 7.0,

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


