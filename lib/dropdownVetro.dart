import 'package:applicazione_prova/display_data_persiane.dart';
import 'package:applicazione_prova/display_data_tapparelle.dart';
import 'package:flutter/material.dart';

const List<String> vetri = <String>['vetro 1', 'vetro 2', 'vetro 3', 'vetro 4'];

class DropdownVetro extends StatefulWidget {
  DropdownVetro({super.key, required this.text, required this.stringa});

  late String text;
  final String stringa;

  @override
  State<DropdownVetro> createState() => _DropdownVetroState();
}

class _DropdownVetroState extends State<DropdownVetro> {
  String dropdownValue = "";
  @override
  Widget build(BuildContext context) {
    if (widget.text == "") {
      if (widget.stringa == "tipoVetroPersiane") {
        dropdownValue = vetri.first;
        tipoVetroPersiane = dropdownValue;
      } else if (widget.stringa == "tipoVetroTapparelle") {
        dropdownValue = vetri.first;
        tipoVetroTapparelle = dropdownValue;
      }
    } else {
      dropdownValue = widget.text;
    }
    if (widget.stringa == "tipoVetroPersiane") {
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
