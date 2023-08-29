import 'package:applicazione_prova/display_data_persiane.dart';
import 'package:applicazione_prova/display_data_tapparelle.dart';
import 'package:flutter/material.dart';

const List<String> telaio = <String>['telaio 1', 'telaio 2', 'telaio 3', 'telaio 4'];

class DropdownTelaio extends StatefulWidget {
  DropdownTelaio({super.key, required this.text, required this.stringa});

  late String text;
  final String stringa;

  @override
  State<DropdownTelaio> createState() => _DropdownTelaioState();
}

class _DropdownTelaioState extends State<DropdownTelaio> {
  String dropdownValue = "";
  @override
  Widget build(BuildContext context) {
    if (widget.text == "") {
      if (widget.stringa == "tipoTelaioPersiane") {
        dropdownValue = telaio.first;
        tipoTelaioPersiane = dropdownValue;
      } else if (widget.stringa == "tipoTelaioTapparelle") {
        dropdownValue = telaio.first;
        tipoTelaioTapparelle = dropdownValue;
      }
    } else {
      dropdownValue = widget.text;
    }
    if (widget.stringa == "tipoTelaioPersiane") {
      return DropdownButton(
        isExpanded: true,
        value: dropdownValue,
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
          tipoTelaioPersiane = value!;
          widget.text = value;
        },
        items: telaio.map<DropdownMenuItem<String>>((String value) {
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
    } else if (widget.stringa == "tipoTelaioTapparelle") {
      return DropdownButton(
        isExpanded: true,
        value: dropdownValue,
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
          tipoTelaioTapparelle = value!;
          widget.text = value;
        },
        items: telaio.map<DropdownMenuItem<String>>((String value) {
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
