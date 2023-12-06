import 'package:applicazione_prova/display_data_persiane.dart';
import 'package:applicazione_prova/display_data_tapparelle.dart';
import 'package:flutter/material.dart';

///*********** images (ovvero le tipologie di infissi) ***************///
///** deve iniziare SEMPRE con una finestra e non una portafinestra **///
Map<String, String> images = {
  'F1AR': 'assets/images/F1AR.jpg',
  'F2AR': 'assets/images/F2AR.jpg',
  'F3AR': 'assets/images/F3AR.jpg',
  'F4AR': 'assets/images/F4AR.jpg',
  'PF1AR': 'assets/images/PF1AR.jpg',
  'PF2AR': 'assets/images/PF2AR.jpg',
  'PF3AR': 'assets/images/PF3AR.jpg',
  'PF4AR': 'assets/images/PF4AR.jpg',
};
Map<String, String> profili = {
  'BG73': 'assets/images/MAX73.jpg',
  'GEA': 'assets/images/P9000.jpg',
  'LUMAX': 'assets/images/LUMAX.jpg',
};

class TendinaTipologia extends StatefulWidget {

  final Function() notifyParent; ///notifica al widget superiore quando cambiare stato
  TendinaTipologia({super.key, required this.text, required this.stringa, required this.notifyParent});

  //String textController;
  late String text;
  final String stringa;

  @override
  State<TendinaTipologia> createState() => _TendinaTipologiaState();
}

class _TendinaTipologiaState extends State<TendinaTipologia> {
  String dropdownValue = "";
  @override
  Widget build(BuildContext context) {
    if (widget.text == "") {
      if (widget.stringa == "tipoPersiane" ||
          widget.stringa == "tipoTapparelle") {
        dropdownValue = images.keys.first;
        tipoPersiane = dropdownValue;
        tipoTapparelle = dropdownValue;
      }
      else if (widget.stringa == "tipoProfiloPersiane" ||
          widget.stringa == "tipoProfiloTapparelle") {
        dropdownValue = profili.keys.first;
        tipoProfiloTapparelle = dropdownValue;
        tipoProfiloPersiane = dropdownValue;
      }
    }
    else {
      dropdownValue = widget.text;
    }
    // return DropdownButton(
    //   isExpanded: true,
    //   value: dropdownValue,
    //   //icon: const Icon(Icons.arrow_downward),
    //   onChanged: (String? value) {
    //     // This is called when the user selects an item.
    //     setState(() {
    //       dropdownValue = value!;
    //     });
    //     tipoPersiane = value!;
    //     widget.text = value;
    //   },
    //   items: list.map<DropdownMenuItem<String>>((String value) {
    //     return DropdownMenuItem<String>(
    //       value: value,
    //       child: Row(
    //         children: [
    //           Text(value),
    //           Image(image: AssetImage(images[0]),
    //           )
    //         ],
    //       ),
    //     );
    //   }).toList(),
    // );

    ///per tipo finestra perisane
    if (widget.stringa == "tipoPersiane") {
      return DropdownButton(
        itemHeight: 120,
        isExpanded: true,
        value: dropdownValue,
        //icon: const Icon(Icons.arrow_downward),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          tipoPersiane = value!;
          widget.text = value;
          setState(() {
            dropdownValue = value;
          });
          widget.notifyParent();
        },
        items: images.keys.map((key) {
          return DropdownMenuItem(
            value: key,
            child: Row(
              children: [
                Image.asset(
                  images[key]!,
                  height: 95,
                ),
                const SizedBox(width: 10),
                Text(key),
              ],
            ),
          );
        }).toList(),
      );
    }
    ///per profili persiane
    else if (widget.stringa == "tipoProfiloPersiane") {
      return DropdownButton(
        itemHeight: 90,
        isExpanded: true,
        value: dropdownValue,
        //icon: const Icon(Icons.arrow_downward),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          tipoProfiloPersiane = value!;
          widget.text = value;
          setState(() {
            dropdownValue = value;
          });
          /// modifica lo stato del parent, utilizzato per aggiornare una lista che dipende dal Profilo
          // widget.notifyParent();
        },
        items: profili.keys.map((key) {
          return DropdownMenuItem(
            value: key,
            child: Row(
              children: [
                Image.asset(
                  profili[key]!,
                  height: 70,
                ),
                const SizedBox(width: 10),
                Text(key),
              ],
            ),
          );
        }).toList(),
      );
    }

    ///per tipo finestra tapparelle
    else if (widget.stringa == "tipoTapparelle") {
      return DropdownButton(
        itemHeight: 120,
        isExpanded: true,
        value: dropdownValue,
        //icon: const Icon(Icons.arrow_downward),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          tipoTapparelle = value!;
          widget.text = value;
          setState(() {
            dropdownValue = value;
          });
          widget.notifyParent();
        },
        items: images.keys.map((key) {
          return DropdownMenuItem(
            value: key,
            child: Row(
              children: [
                Image.asset(
                  images[key]!,
                  height: 95,
                ),
                const SizedBox(width: 10),
                Text(key),
              ],
            ),
          );
        }).toList(),
      );
    }
    ///per profili tapparelle
    else if (widget.stringa == "tipoProfiloTapparelle") {
      return DropdownButton(
        itemHeight: 90,
        isExpanded: true,
        value: dropdownValue,
        //icon: const Icon(Icons.arrow_downward),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          tipoProfiloTapparelle = value!;
          widget.text = value;
          setState(() {
            dropdownValue = value;
          });
          /// modifica lo stato del parent, utilizzato per aggiornare una lista che dipende dal Profilo
          // widget.notifyParent();
        },
        items: profili.keys.map((key) {
          return DropdownMenuItem(
            value: key,
            child: Row(
              children: [
                Image.asset(
                  profili[key]!,
                  height: 70,
                ),
                const SizedBox(width: 10),
                Text(key),
              ],
            ),
          );
        }).toList(),
      );
    }

    else {
      throw Exception("Parametro non corretto");
    }
  }
}
