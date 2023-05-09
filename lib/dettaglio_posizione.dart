///VISUALIZZA IL DETTAGLIO DELLE POSIZIONI

import 'dart:convert';

import 'package:flutter/material.dart';

import 'nuovo_database.dart';

class DettaglioPosizione extends StatelessWidget {
  final int? id;
  final String tipoConfigurazione;

  const DettaglioPosizione(
      {super.key, required this.id, required this.tipoConfigurazione});

  @override
  Widget build(BuildContext context) {
    double firstHeight = MediaQuery.of(context).size.height;
    double firstWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dettaglio posizione"),
      ),
      body: FutureBuilder<Configurazione>(
        future: DBHelper.instance.getConfigurazione(id!, tipoConfigurazione),
        builder:
            (BuildContext context, AsyncSnapshot<Configurazione> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text('Caricamento ...'));
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Text(
                  snapshot.data!.toStringFormatted()[0] +
                      snapshot.data!.toStringFormatted()[1] +
                      snapshot.data!.toStringFormatted()[2] +
                      snapshot.data!.toStringFormatted()[3] +
                      snapshot.data!.toStringFormatted()[4] +
                      snapshot.data!.toStringFormatted()[5] +
                      snapshot.data!.toStringFormatted()[6] +
                      snapshot.data!.toStringFormatted()[7] +
                      snapshot.data!.toStringFormatted()[8] +
                      snapshot.data!.toStringFormatted()[9] +
                      snapshot.data!.toStringFormatted()[10] +
                      snapshot.data!.toStringFormatted()[11] +
                      snapshot.data!.toStringFormatted()[12] +
                      snapshot.data!.toStringFormatted()[13] +
                      snapshot.data!.toStringFormatted()[14],
                  style: const TextStyle(height: 1.5),
                ),
                Row(
                  children: [
                    Image.memory(base64Decode(snapshot.data!.blob.toString()),
                        height: (firstHeight / 2) - 8,
                        width: (firstWidth / 2) - 8
                    ),
                    Image.memory(
                        base64Decode(snapshot.data!.disegno.toString()),
                        height: (firstHeight / 2) - 8,
                        width: (firstWidth / 2) - 8
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
