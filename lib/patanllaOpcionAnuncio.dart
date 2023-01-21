import 'package:flutter/material.dart';


class patallaAnuncio extends StatefulWidget {
  patallaAnuncio({Key? key, required String title}) : super(key: key);

  @override
  State<patallaAnuncio> createState() => _patallaAnuncioState();
}

class _patallaAnuncioState extends State<patallaAnuncio> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Barra Superior"),
      ),
      body: Column(
        children: [
           ElevatedButton(
            onPressed: () {
              print('hola');
            }, 
            child:  const Text('Mostrar') )
        ],

      ),
      backgroundColor: const Color.fromARGB(255, 72, 236, 78),
    );
  }
}