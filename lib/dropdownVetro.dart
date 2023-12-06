import 'package:applicazione_prova/display_data_persiane.dart';
import 'package:applicazione_prova/display_data_tapparelle.dart';
import 'package:flutter/material.dart';

const List<String> vetriFin = <String>[
  'Vetro finestra',
  'Vetro sabbiato finestra',

];
const List<String> vetriPfin = <String>[
  'Vetro portafinestra',
  'Vetro sabbiato portafinestra',
];

late List<String> vetri;
String dropdownValue = "";

class DropdownVetro extends StatefulWidget {

  DropdownVetro({super.key, required this.text, required this.stringa, required this.tipoFinestra});

  late String text;
  final String stringa;
  final String tipoFinestra;
  @override
  State<DropdownVetro> createState() => _DropdownVetroState();
}
class _DropdownVetroState extends State<DropdownVetro> {

  @override
  Widget build(BuildContext context) {

    if (widget.stringa == "tipoVetroPersiane") {
      vetri = listaVetri(widget.text, widget.stringa, widget.tipoFinestra);
      return DropdownButton(
        isExpanded: true,
        value: dropdownValue,
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
          tipoVetroPersiane = value!;
          widget.text = value;
        },
        items: vetri.map<DropdownMenuItem<String>>((String value) {
          tipoVetroPersiane = dropdownValue;
          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              children: [
                Text(value),
              ],
            ),
          );
        }).toList(),
      );
    } else if (widget.stringa == "tipoVetroTapparelle") {
      vetri = listaVetri(widget.text, widget.stringa, widget.tipoFinestra);
      return DropdownButton(
        isExpanded: true,
        value: dropdownValue,
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
          tipoVetroTapparelle = value!;
          widget.text = value;
        },
        items: vetri.map<DropdownMenuItem<String>>((String value) {
          tipoVetroTapparelle = dropdownValue;
          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              children: [
                Text(value),
              ],
            ),
          );
        }).toList(),
      );
    } else {
      throw Exception("Parametro non corretto");
    }
  }
}

List<String> listaVetri(String text, String stringa, String tipoFinestra){
  if (text == "") {
    if (stringa == "tipoVetroPersiane") {
      if (tipoFinestra.startsWith('F') || tipoFinestra == "") {
        dropdownValue = vetriFin.first;
        tipoVetroPersiane = dropdownValue;
        return vetriFin;
      } else {
        dropdownValue = vetriPfin.first;
        tipoVetroPersiane = dropdownValue;
        return vetriPfin;
      }
    }
    else if (stringa == "tipoVetroTapparelle") {
      if (tipoFinestra.startsWith('F') || tipoFinestra == "") {
        dropdownValue = vetriFin.first;
        tipoVetroTapparelle = dropdownValue;
        return vetriFin;
      } else {
        dropdownValue = vetriPfin.first;
        tipoVetroTapparelle = dropdownValue;
        return vetriPfin;
      }
    }
  } else {
    if (tipoFinestra.startsWith("F")) {
      if (vetriFin.contains(text)) {
        dropdownValue = text;
      } else {
        dropdownValue = vetriFin.first;
      }
      return vetriFin;
    } else {
      if (vetriPfin.contains(text)) {
        dropdownValue = text;
      } else {
        dropdownValue = vetriPfin.first;
      }
      return vetriPfin;
    }
  }
  throw Exception();
}