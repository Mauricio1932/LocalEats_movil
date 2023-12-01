import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/entities/coment_entities.dart';
import 'bloc/comentario_bloc/comentario_bloc.dart';
import 'bloc/comentario_bloc/comentario_event.dart';
import 'bloc/comentario_bloc/comentario_state.dart';

class ViewCometarios extends StatefulWidget {
  final int idPost;

  const ViewCometarios(this.idPost, {Key? key}) : super(key: key);

  // const ViewCometarios(int idPost, {super.key, });

  // const ViewCometarios({Key? key, required this.idPost}) : super(key: key);
  @override
  State<ViewCometarios> createState() => _ViewCometariosState();
}

class _ViewCometariosState extends State<ViewCometarios> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _comentarioFieldController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ComentarioBloc, ComentarioState>(
        builder: (context, state) {
          if (state.commentStatus == CommentRequest.requestInProgress) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.commentStatus == CommentRequest.unknown) {
            List<Comentario> userData = [
              Comentario(post_id: widget.idPost, name: '', comment: ''),
            ];
            context.read<ComentarioBloc>().add(GetCommentRequest(userData[0]));
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: state.comentario.length,
                      itemBuilder: (BuildContext context, int index) {
                        final comentario = state.comentario[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Alinea el texto a la izquierda
                          children: <Widget>[
                            Row(
                              children: [
                                Text(
                                  '${comentario.name}: ',
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  comentario.comment,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    // fontSize: 19,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            // Otros elementos si es necesario
                          ],
                        );
                      },
                    ),
                  ),
                ),
                // Validar si el controller está inicializado
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                            controller: _comentarioFieldController,
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                              hintText: 'Añade un Comentario',
                              hintStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'El comentario no debe estar vacio';
                              }
                              return null;
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            comentar(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> comentar(context) async {
    print("Send comment");
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    final token = sharedPreferences.getString('auth_token') ?? '';

    if (token.isEmpty) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'No tienes una sesion iniciada , inicia e ¡intentalo de nuevo!',
      );
    } else {
      // QuickAlert.show(
      //   context: context,
      //   type: QuickAlertType.success,
      //   title: 'Oops...',
      //   text: 'No has cargado el archivo esperado, ¡intentalo de nuevo!',
      // );
      if (_formKey.currentState?.validate() ?? false) {
        print("se ejecuto");
        // comentario();
      }
    }

//   void comentario() {
//       print("se ejecuto");

//       List<Comentario> userData = [
//         Comentario(post_id: widget.idPost, name: '', comment: _comentarioFieldController.text),
//       ];
//       context.read<AddcommentBloc>().add(NewCommenPost(userData[0]));

//   }
// }
  }
}
