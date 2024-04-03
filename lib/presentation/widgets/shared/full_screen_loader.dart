import 'package:flutter/material.dart';

class FlullScreenLoader extends StatelessWidget {
  const FlullScreenLoader({Key? key}) : super(key: key);

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Cargando películas..',
      'Comprando palomitas..',
      'Cargando populares..',
      'En la pescadería..',
      'Esto está tardando demasiado, ¿no?  :(',
    ];
    return Stream.periodic(
      const Duration(milliseconds: 2000),
      (step) => messages[step],
    ).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Cargando..'),
          const SizedBox(height: 10),
          const CircularProgressIndicator(strokeWidth: 2),
          const SizedBox(height: 10),
          StreamBuilder(
              stream: getLoadingMessages(),
              builder: ((context, snapshot) {
                          if (!snapshot.hasData) return const Text('Espere, por favor');

                          return Text(snapshot.data!);
                        })
          )
        ],
      ),
    );
  }
}
