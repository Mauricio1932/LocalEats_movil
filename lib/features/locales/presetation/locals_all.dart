import 'package:flutter/material.dart';
import 'package:localeats/features/locales/domain/entities/local.dart';

class AllLocals extends StatefulWidget {
  List<Local> locales;

  // Utiliza el constructor adecuado
  AllLocals({Key? key, required this.locales}) : super(key: key);

  @override
  State<AllLocals> createState() => _AllLocalsState();
}

class _AllLocalsState extends State<AllLocals> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 500,
      child: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true, // Añade esto
              itemCount: widget.locales.length,
              itemBuilder: (BuildContext context, int index) {
                final local = widget.locales[index];

                return Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(
                        12.0), // Otras opciones de decoración según sea necesario
                  ),
                  child: Column(
                    children: [],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
