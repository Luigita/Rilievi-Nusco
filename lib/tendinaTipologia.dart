import 'package:applicazione_prova/display_data_persiane.dart';
import 'package:applicazione_prova/display_data_tapparelle.dart';
import 'package:flutter/material.dart';

Map<String, String> images = {
  'PF1AR': 'assets/images/SAL_F1AR-ST76.jpg',
  'PF2AR': 'assets/images/SAL_F2AR-ST76.jpg',
  'PF3AR': 'assets/images/SAL_F3ARM-ST76.jpg',
};
Map<String, String> profili = {
  'BG73': 'assets/images/MAX73.jpg',
  'GEA': 'assets/images/P9000.jpg',
  'LUMAX': 'assets/images/LUMAX.jpg',
};

class TendinaTipologia extends StatefulWidget {
  TendinaTipologia({super.key, required this.text, required this.stringa});

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
      } else if (widget.stringa == "tipoProfiloPersiane" ||
          widget.stringa == "tipoProfiloTapparelle") {
        dropdownValue = profili.keys.first;
        tipoProfiloTapparelle = dropdownValue;
        tipoProfiloPersiane = dropdownValue;
      }
    } else {
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

    if (widget.stringa == "tipoPersiane") {
      return DropdownButton(
        itemHeight: 120,
        isExpanded: true,
        value: dropdownValue,
        //icon: const Icon(Icons.arrow_downward),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
          tipoPersiane = value!;
          widget.text = value;
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
    } else if (widget.stringa == "tipoProfiloPersiane") {
      return DropdownButton(
        itemHeight: 90,
        isExpanded: true,
        value: dropdownValue,
        //icon: const Icon(Icons.arrow_downward),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
          tipoProfiloPersiane = value!;
          widget.text = value;
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
    } else if (widget.stringa == "tipoTapparelle") {
      return DropdownButton(
        itemHeight: 120,
        isExpanded: true,
        value: dropdownValue,
        //icon: const Icon(Icons.arrow_downward),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
          tipoTapparelle = value!;
          widget.text = value;
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
    } else if (widget.stringa == "tipoProfiloTapparelle") {
      return DropdownButton(
        itemHeight: 90,
        isExpanded: true,
        value: dropdownValue,
        //icon: const Icon(Icons.arrow_downward),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
          tipoProfiloTapparelle = value!;
          widget.text = value;
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
    } else {
      throw Exception("Parametro non corretto");
    }
  }
}
