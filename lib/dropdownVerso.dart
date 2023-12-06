import 'package:applicazione_prova/display_data_persiane.dart';
import 'package:applicazione_prova/display_data_tapparelle.dart';
import 'package:flutter/material.dart';

const List<String> versi = <String>[
  'Dx',
  'Sx',
  'Dx Lat 3-2-1',
  'Sx Lat 1-2-3',
  'Dx Cent 2-1-3',
  'Sx Cent 3-1-2',
];

String dropdownValue = "";

class DropdownVerso extends StatefulWidget {
  DropdownVerso({super.key, required this.text, required this.stringa});

  late String text;
  final String stringa;
  @override
  State<DropdownVerso> createState() => _DropdownVersoState();
}

class _DropdownVersoState extends State<DropdownVerso> {
  String dropdownValue = "";
  @override
  Widget build(BuildContext context) {
    if (widget.text == "") {
      if (widget.stringa == "tipoVersoPersiane") {
        dropdownValue = versi.first;
        tipoVersoPersiane = dropdownValue;
      } else if (widget.stringa == "tipoVersoTapparelle") {
        dropdownValue = versi.first;
        tipoVersoTapparelle = dropdownValue;
      }
    } else {
      dropdownValue = widget.text;
    }
    if (widget.stringa == "tipoVersoPersiane") {
      return DropdownButton(
        isExpanded: true,
        value: dropdownValue,
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
          tipoVersoPersiane = value!;
          widget.text = value;
        },
        items: versi.map<DropdownMenuItem<String>>((String value) {
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
    } else if (widget.stringa == "tipoVersoTapparelle") {
      return DropdownButton(
        isExpanded: true,
        value: dropdownValue,
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
          tipoVersoTapparelle = value!;
          widget.text = value;
        },
        items: versi.map<DropdownMenuItem<String>>((String value) {
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
