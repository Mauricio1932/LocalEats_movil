import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localeats/features/user/presentation/pages/create_local.dart';

import '../bloc/bloc_create_local/create_local_bloc.dart';
import '../bloc/bloc_create_local/create_local_state.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:snack/snack.dart';
// import 'locales.dart';

class LocalStatus extends StatefulWidget {
  const LocalStatus({super.key});

  @override
  State<LocalStatus> createState() => _LocalStatusState();
}

class _LocalStatusState extends State<LocalStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CreateLocalBloc, CreateLocalState>(
        builder: (context, state) {
          if (state.newLocalStatus == LocalRequest.requestInProgress) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.newLocalStatus == LocalRequest.requestSuccess) {
            _showSuccessAlert(context);
            // return const SizedBox.shrink();
          }
          if (state.newLocalStatus == LocalRequest.requestFailure) {
            _showSuccessAlert(context);
            // return Center(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       const Text('Problema al subir tu negocio'),
            //       const SizedBox(height: 10),
            //       OutlinedButton(
            //         onPressed: () {
            //           Navigator.pop(context);
            //         },
            //         child: const Text('Try again'),
            //       ),
            //     ],
            //   ),
            // );
          }
          return AlertDialog(
            title: const Text('Oops...'),
            content: const Text(
                'No has cargado el archivo esperado, ¡inténtalo de nuevo!'),
            actions: [
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cierra el AlertDialog
                },
                child: const Text('Try again'),
              ),
            ],
          );
          // Resto del
        },
      ),
    );
  }

  void _showSuccessAlert(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 200,
          color: Colors.white,
          child: Center(
            child: Text(
              'Contenido del Modal',
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      },
    );
  }
}
