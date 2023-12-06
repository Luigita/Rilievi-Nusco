///****************************************///
///****** Qui vegono definiti i ***********///
///****** menu a tendina delle  ***********///
///****** caratteristiche che   ***********///
///****** compaiono solo in uno ***********///
///****** dei due moduli        ***********///
///****************************************///

///LE CARATTERISTICHE CHE COMPAIONO IN ENTRAMBI I MODULI VENGONO DEFINITE IN FILE SINGOLI///

import 'package:applicazione_prova/rilievo_persiane.dart';
import 'package:applicazione_prova/rilievo_tapparelle.dart';
import 'package:flutter/material.dart';

// const List<String> telaio = <String>[
//   'telaio a elle',
//   'telaio zeta 35',
//   'telaio 60',
// ];
// const List<String> vetri = <String>[
//   'vetro 1',
//   'vetro 2',
//   'vetro 3',
//   'vetro 4',
// ];
// const List<String> maniglie = <String>[
//   'BIANCO',
//   'BRONZO',
//   'BRONZO CHIARO F4',
//   'C33',
//   'CROMO SATINATO',
//   'EV1',
//   'ORO',
//   'ORO SATINATO',
//   'OTTONE',
//   'OTTONE BRONZATO',
//   'RAL1013',
//   'RAL8007',
//   'RAL9001',
//   'TDM',
//   'TITAN F9',
//   'TIT_LUC',
//   'TIT_OP',
//   'ORO LUCIDO',
// ];
// const List<String> finiture = <String>[
//   '01 Bianco massa',
//   '01 Crema massa',
//   '03 Dunkelgrun',
//   '11 Stahlblau',
//   '12 Schiefergrau',
//   '18 Jet Black Matt Premium',
//   '19 Weinrot',
//   '21 Nubbaum',
//   '25 Mooreiche',
//   '26 Mahagoni',
//   '27 Streifen-Douglasie 27',
//   '28 Ginger Oak',
//   '33 Nebraska Premium',
//   '34 Schiefergrau Matt',
//   '35 White Ash',
//   '37 Alux db 703',
//   '39 Weiss antik',
//   '41 Vintage-OAK',
//   '42 Silver Grey',
//   '43 Polareiche Premium',
//   '49 Larch white',
//   '50 Bergkiefer',
//   '51 Golden OAK',
//   '55 Anthrazitgrau',
//   '59 Creme',
//   '62 Tiama',
//   '67 Metbrusch anthrazit',
//   '69 Metbrush Premium',
//   '71 Schwarzbraun',
//   '73 Lichtgrau',
//   '74 Basaltgrau',
//   '84 Basaltgrau Satin',
//   '87 Signalgrau Satin',
//   '88 Anthrazitgrau Satin',
//   '90 Quarzgrau Satin',
//   '93 Woodec Concrete PremPlus',
//   '94 Coriander Oak',
//   '98 Nero Ulti-Matt Premium',
// ];
const List<String> guide = <String>[
  'Guida avvolgibile da 30x32 mm',
  'Guida avvolgibile da 35x51 mm',
  'Guida avvolgibile da 35x86 mm',
  'Guida avvolgibile da 41x48 mm',
];
const List<String> coloriInt = <String>[
  '01 Bianco massa',
  '01 Crema massa',
  '03 Dunkelgrun',
  '11 Stahlblau',
  '12 Schiefergrau',
  '18 Jet Black Matt Premium',
  '19 Weinrot',
  '21 Nubbaum',
  '25 Mooreiche',
  '26 Mahagoni',
  '27 Streifen-Douglasie 27',
  '28 Ginger Oak',
  '33 Nebraska Premium',
  '34 Schiefergrau Matt',
  '35 White Ash',
  '37 Alux db 703',
  '39 Weiss antik',
  '41 Vintage-OAK',
  '42 Silver Grey',
  '43 Polareiche Premium',
  '49 Larch white',
  '50 Bergkiefer',
  '51 Golden OAK',
  '55 Anthrazitgrau',
  '59 Creme',
  '62 Tiama',
  '67 Metbrusch anthrazit',
  '69 Metbrush Premium',
  '71 Schwarzbraun',
  '73 Lichtgrau',
  '74 Basaltgrau',
  '84 Basaltgrau Satin',
  '87 Signalgrau Satin',
  '88 Anthrazitgrau Satin',
  '90 Quarzgrau Satin',
  '93 Woodec Concrete PremPlus',
  '94 Coriander Oak',
  '98 Nero Ulti-Matt Premium',
];
const List<String> coloriEst = <String>[
  '01 Bianco massa',
  '01 Crema massa',
  '03 Dunkelgrun',
  '11 Stahlblau',
  '12 Schiefergrau',
  '18 Jet Black Matt Premium',
  '19 Weinrot',
  '21 Nubbaum',
  '25 Mooreiche',
  '26 Mahagoni',
  '27 Streifen-Douglasie 27',
  '28 Ginger Oak',
  '33 Nebraska Premium',
  '34 Schiefergrau Matt',
  '35 White Ash',
  '37 Alux db 703',
  '39 Weiss antik',
  '41 Vintage-OAK',
  '42 Silver Grey',
  '43 Polareiche Premium',
  '49 Larch white',
  '50 Bergkiefer',
  '51 Golden OAK',
  '55 Anthrazitgrau',
  '59 Creme',
  '62 Tiama',
  '67 Metbrusch anthrazit',
  '69 Metbrush Premium',
  '71 Schwarzbraun',
  '73 Lichtgrau',
  '74 Basaltgrau',
  '84 Basaltgrau Satin',
  '87 Signalgrau Satin',
  '88 Anthrazitgrau Satin',
  '90 Quarzgrau Satin',
  '93 Woodec Concrete PremPlus',
  '94 Coriander Oak',
  '98 Nero Ulti-Matt Premium',
];
const List<String> listelliInt = <String>[
  '3 Lati',
  '4 Lati',
];
const List<String> listelliEst = <String>[
  '3 Lati',
  '4 Lati',
];
const List<String> tipoTapparella = <String>[
  'T13',
  'T45',
  'ARIALUCE',
  'EUROPA',
  'ROMA',
  'SERENA',
];
const List<String> coloriTapparelle = <String>[
  'Tinta Unita',
  'Effetto Legno',
];
// const List<String> modelli = <String>[
//   'modello 1',
//   'modello 2',
//   'modello 3',
//   'modello 4',
// ];
const List<String> coloreFerramenta = <String>[
  'Argento',
  'Oro',
  'Bianco',
  'Testa di Moro',
  'Oro lucido',
  'Bronzo',
  'Oro Satinato',
];
const List<String> finiture = <String>[
  'finitura interna',
];
const List<String> modelloPersiane = <String>[
  'modello persiana',
];
const List<String> colorazionePersiana = <String>[
  'colore persiana',
];
const List<String> controtelai = <String>[
  'controtelai',
];

class Dropdown extends StatefulWidget {
  Dropdown(
      {super.key,
      required this.variabile,
      required this.stringa,
      required this.condizione});

  late String variabile;
  final String stringa;
  final String condizione;

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String dropdownValue = "";
  @override
  Widget build(BuildContext context) {
    // if (widget.condizione == "telaio") {
    //   if (widget.variabile == "") {
    //     if (widget.stringa == "tipoTelaioPersiane") {
    //       dropdownValue = telaio.first;
    //       tipoTelaioPersiane = dropdownValue;
    //     } else if (widget.stringa == "tipoTelaioTapparelle") {
    //       dropdownValue = telaio.first;
    //       tipoTelaioTapparelle = dropdownValue;
    //     }
    //   } else {
    //     dropdownValue = widget.variabile;
    //   }
    //   if (widget.stringa == "tipoTelaioPersiane") {
    //     return DropdownButton(
    //       isExpanded: true,
    //       value: dropdownValue,
    //       onChanged: (String? value) {
    //         // This is called when the user selects an item.
    //         setState(() {
    //           dropdownValue = value!;
    //         });
    //         tipoTelaioPersiane = value!;
    //         widget.variabile = value;
    //       },
    //       items: telaio.map<DropdownMenuItem<String>>((String value) {
    //         return DropdownMenuItem<String>(
    //           value: value,
    //           child: Row(
    //             children: [
    //               Text(value),
    //             ],
    //           ),
    //         );
    //       }).toList(),
    //     );
    //   } else if (widget.stringa == "tipoTelaioTapparelle") {
    //     return DropdownButton(
    //       isExpanded: true,
    //       value: dropdownValue,
    //       onChanged: (String? value) {
    //         // This is called when the user selects an item.
    //         setState(() {
    //           dropdownValue = value!;
    //         });
    //         tipoTelaioTapparelle = value!;
    //         widget.variabile = value;
    //       },
    //       items: telaio.map<DropdownMenuItem<String>>((String value) {
    //         return DropdownMenuItem<String>(
    //           value: value,
    //           child: Row(
    //             children: [
    //               Text(value),
    //             ],
    //           ),
    //         );
    //       }).toList(),
    //     );
    //   } else {
    //     throw Exception("Parametro non corretto");
    //   }
    // }
    // else if (widget.condizione == "vetro") {
    //   if (widget.variabile == "") {
    //     if (widget.stringa == "tipoVetroPersiane") {
    //       dropdownValue = vetri.first;
    //       tipoVetroPersiane = dropdownValue;
    //     } else if (widget.stringa == "tipoVetroTapparelle") {
    //       dropdownValue = vetri.first;
    //       tipoVetroTapparelle = dropdownValue;
    //     }
    //   } else {
    //     dropdownValue = widget.variabile;
    //   }
    //   if (widget.stringa == "tipoVetroPersiane") {
    //     return DropdownButton(
    //       isExpanded: true,
    //       value: dropdownValue,
    //       onChanged: (String? value) {
    //         // This is called when the user selects an item.
    //         setState(() {
    //           dropdownValue = value!;
    //         });
    //         tipoVetroPersiane = value!;
    //         widget.variabile = value;
    //       },
    //       items: vetri.map<DropdownMenuItem<String>>((String value) {
    //         return DropdownMenuItem<String>(
    //           value: value,
    //           child: Row(
    //             children: [
    //               Text(value),
    //             ],
    //           ),
    //         );
    //       }).toList(),
    //     );
    //   } else if (widget.stringa == "tipoVetroTapparelle") {
    //     return DropdownButton(
    //       isExpanded: true,
    //       value: dropdownValue,
    //       onChanged: (String? value) {
    //         // This is called when the user selects an item.
    //         setState(() {
    //           dropdownValue = value!;
    //         });
    //         tipoVetroTapparelle = value!;
    //         widget.variabile = value;
    //       },
    //       items: vetri.map<DropdownMenuItem<String>>((String value) {
    //         return DropdownMenuItem<String>(
    //           value: value,
    //           child: Row(
    //             children: [
    //               Text(value),
    //             ],
    //           ),
    //         );
    //       }).toList(),
    //     );
    //   } else {
    //     throw Exception("Parametro non corretto");
    //   }
    // }
    // if (widget.condizione == "maniglia") {
    //   if (widget.variabile == "") {
    //     if (widget.stringa == "tipoManigliaPersiane") {
    //       dropdownValue = maniglie.first;
    //       tipoManigliaPersiane = dropdownValue;
    //     }
    //   } else {
    //     dropdownValue = widget.variabile;
    //   }
    //   if (widget.stringa == "tipoManigliaPersiane") {
    //     return DropdownButton(
    //       isExpanded: true,
    //       value: dropdownValue,
    //       onChanged: (String? value) {
    //         // This is called when the user selects an item.
    //         setState(() {
    //           dropdownValue = value!;
    //         });
    //         tipoManigliaPersiane = value!;
    //         widget.variabile = value;
    //       },
    //       items: maniglie.map<DropdownMenuItem<String>>((String value) {
    //         return DropdownMenuItem<String>(
    //           value: value,
    //           child: Row(
    //             children: [
    //               Text(value),
    //             ],
    //           ),
    //         );
    //       }).toList(),
    //     );
    //   } else {
    //     throw Exception("Parametro non corretto");
    //   }
    // }
    // else if (widget.condizione == "finitura") {
    //   if (widget.variabile == "") {
    //     if (widget.stringa == "tipoFinituraPersiane") {
    //       dropdownValue = finiture.first;
    //       tipoFinituraPersiane = dropdownValue;
    //     }
    //   } else {
    //     dropdownValue = widget.variabile;
    //   }
    //   if (widget.stringa == "tipoFinituraPersiane") {
    //     return DropdownButton(
    //       isExpanded: true,
    //       value: dropdownValue,
    //       onChanged: (String? value) {
    //         // This is called when the user selects an item.
    //         setState(() {
    //           dropdownValue = value!;
    //         });
    //         tipoFinituraPersiane = value!;
    //         widget.variabile = value;
    //       },
    //       items: finiture.map<DropdownMenuItem<String>>((String value) {
    //         return DropdownMenuItem<String>(
    //           value: value,
    //           child: Row(
    //             children: [
    //               Text(value),
    //             ],
    //           ),
    //         );
    //       }).toList(),
    //     );
    //   } else {
    //     throw Exception("Parametro non corretto");
    //   }
    // }
    // else
      if (widget.condizione == "guida") {
      {
        if (widget.variabile == "") {
          if (widget.stringa == "tipoGuidaTapparelle") {
            dropdownValue = guide.first;
            tipoGuidaTapparelle = dropdownValue;
          }
        } else {
          dropdownValue = widget.variabile;
        }
        if (widget.stringa == "tipoGuidaTapparelle") {
          return DropdownButton(
            isExpanded: true,
            value: dropdownValue,
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
              tipoGuidaTapparelle = value!;
              widget.variabile = value;
            },
            items: guide.map<DropdownMenuItem<String>>((String value) {
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
    else if (widget.condizione == "colore_int") {
      {
        if (widget.variabile == "") {
          if (widget.stringa == "tipoColoreIntTapparelle") {
            dropdownValue = coloriInt.first;
            tipoColoreIntTapparelle = dropdownValue;
          }
        } else {
          dropdownValue = widget.variabile;
        }
        if (widget.stringa == "tipoColoreIntTapparelle") {
          return DropdownButton(
            isExpanded: true,
            value: dropdownValue,
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
              tipoColoreIntTapparelle = value!;
              widget.variabile = value;
            },
            items: coloriInt.map<DropdownMenuItem<String>>((String value) {
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
    else if (widget.condizione == "colore_est") {
      {
        if (widget.variabile == "") {
          if (widget.stringa == "tipoColoreEstTapparelle") {
            dropdownValue = coloriEst.first;
            tipoColoreEstTapparelle = dropdownValue;
          }
        } else {
          dropdownValue = widget.variabile;
        }
        if (widget.stringa == "tipoColoreEstTapparelle") {
          return DropdownButton(
            isExpanded: true,
            value: dropdownValue,
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
              tipoColoreEstTapparelle = value!;
              widget.variabile = value;
            },
            items: coloriEst.map<DropdownMenuItem<String>>((String value) {
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
    else if (widget.condizione == "listelli_int") {
      {
        if (widget.variabile == "") {
          if (widget.stringa == "tipoListelliIntTapparelle") {
            dropdownValue = listelliInt.first;
            tipoListelliIntTapparelle = dropdownValue;
          }
        } else {
          dropdownValue = widget.variabile;
        }
        if (widget.stringa == "tipoListelliIntTapparelle") {
          return DropdownButton(
            isExpanded: true,
            value: dropdownValue,
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
              tipoListelliIntTapparelle = value!;
              widget.variabile = value;
            },
            items: listelliInt.map<DropdownMenuItem<String>>((String value) {
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
    else if (widget.condizione == "listelli_est") {{
      if (widget.variabile == "") {
        if (widget.stringa == "tipoListelliEstTapparelle") {
          dropdownValue = listelliEst.first;
          tipoListelliEstTapparelle = dropdownValue;
        }
      } else {
        dropdownValue = widget.variabile;
      }
      if (widget.stringa == "tipoListelliEstTapparelle") {
        return DropdownButton(
          isExpanded: true,
          value: dropdownValue,
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
            });
            tipoListelliEstTapparelle = value!;
            widget.variabile = value;
          },
          items: listelliEst.map<DropdownMenuItem<String>>((String value) {
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
    }}
    else if (widget.condizione == "tipo_tapparella") {
      {
        if (widget.variabile == "") {
          if (widget.stringa == "tipoTapparellaTapparelle") {
            dropdownValue = tipoTapparella.first;
            tipoTapparellaTapparelle = dropdownValue;
          }
        } else {
          dropdownValue = widget.variabile;
        }
        if (widget.stringa == "tipoTapparellaTapparelle") {
          return DropdownButton(
            isExpanded: true,
            value: dropdownValue,
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
              tipoTapparellaTapparelle = value!;
              widget.variabile = value;
            },
            items: tipoTapparella.map<DropdownMenuItem<String>>((String value) {
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
    else if (widget.condizione == "colore_tapparella") {
      {
        if (widget.variabile == "") {
          if (widget.stringa == "coloreTapparellaTapparelle") {
            dropdownValue = coloriTapparelle.first;
            coloreTapparellaTapparelle = dropdownValue;
          }
        } else {
          dropdownValue = widget.variabile;
        }
        if (widget.stringa == "coloreTapparellaTapparelle") {
          return DropdownButton(
            isExpanded: true,
            value: dropdownValue,
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
              coloreTapparellaTapparelle = value!;
              widget.variabile = value;
            },
            items: coloriTapparelle.map<DropdownMenuItem<String>>((String value) {
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
    else if (widget.condizione == "finituraInterna") {
      {
        if (widget.variabile == "") {
          if (widget.stringa == "finituraInterna") {
            dropdownValue = finiture.first;
            finituraInterna = dropdownValue;
          }
        } else {
          dropdownValue = widget.variabile;
        }
        if (widget.stringa == "finituraInterna") {
          return DropdownButton(
            isExpanded: true,
            value: dropdownValue,
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
              finituraInterna = value!;
              widget.variabile = value;
            },
            items: finiture.map<DropdownMenuItem<String>>((String value) {
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
    else if (widget.condizione == "finituraEsterna") {
      {
        if (widget.variabile == "") {
          if (widget.stringa == "finituraEsterna") {
            dropdownValue = finiture.first;
            finituraEsterna = dropdownValue;
          }
        } else {
          dropdownValue = widget.variabile;
        }
        if (widget.stringa == "finituraEsterna") {
          return DropdownButton(
            isExpanded: true,
            value: dropdownValue,
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
              finituraEsterna = value!;
              widget.variabile = value;
            },
            items: finiture.map<DropdownMenuItem<String>>((String value) {
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
    else if (widget.condizione == "modelloPersiana") {
      {
        if (widget.variabile == "") {
          if (widget.stringa == "modelloPersiana") {
            dropdownValue = modelloPersiane.first;
            modelloPersiana = dropdownValue;
          }
        } else {
          dropdownValue = widget.variabile;
        }
        if (widget.stringa == "modelloPersiana") {
          return DropdownButton(
            isExpanded: true,
            value: dropdownValue,
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
              modelloPersiana = value!;
              widget.variabile = value;
            },
            items: modelloPersiane.map<DropdownMenuItem<String>>((String value) {
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
    else if (widget.condizione == "colorazionePersianaInt") {
      {
        if (widget.variabile == "") {
          if (widget.stringa == "colorazionePersianaInt") {
            dropdownValue = colorazionePersiana.first;
            colorazionePersianaInt = dropdownValue;
          }
        } else {
          dropdownValue = widget.variabile;
        }
        if (widget.stringa == "colorazionePersianaInt") {
          return DropdownButton(
            isExpanded: true,
            value: dropdownValue,
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
              colorazionePersianaInt = value!;
              widget.variabile = value;
            },
            items: colorazionePersiana.map<DropdownMenuItem<String>>((String value) {
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
    else if (widget.condizione == "colorazionePersianaEst") {
      {
        if (widget.variabile == "") {
          if (widget.stringa == "colorazionePersianaEst") {
            dropdownValue = colorazionePersiana.first;
            colorazionePersianaEst = dropdownValue;
          }
        } else {
          dropdownValue = widget.variabile;
        }
        if (widget.stringa == "colorazionePersianaEst") {
          return DropdownButton(
            isExpanded: true,
            value: dropdownValue,
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
              colorazionePersianaEst = value!;
              widget.variabile = value;
            },
            items: colorazionePersiana.map<DropdownMenuItem<String>>((String value) {
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
    else if (widget.condizione == "controtelaio") {
      {
        if (widget.variabile == "") {
          if (widget.stringa == "controtelaio") {
            dropdownValue = controtelai.first;
            controtelaio = dropdownValue;
          }
        } else {
          dropdownValue = widget.variabile;
        }
        if (widget.stringa == "controtelaio") {
          return DropdownButton(
            isExpanded: true,
            value: dropdownValue,
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
              controtelaio = value!;
              widget.variabile = value;
            },
            items: controtelai.map<DropdownMenuItem<String>>((String value) {
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
    // else if (widget.condizione == "modello") {
    //   {
    //     if (widget.variabile == "") {
    //       if (widget.stringa == "modelloPersiane") {
    //         dropdownValue = modelli.first;
    //         modelloPersiane = dropdownValue;
    //       }
    //     } else {
    //       dropdownValue = widget.variabile;
    //     }
    //     if (widget.stringa == "modelloPersiane") {
    //       return DropdownButton(
    //         isExpanded: true,
    //         value: dropdownValue,
    //         onChanged: (String? value) {
    //           // This is called when the user selects an item.
    //           setState(() {
    //             dropdownValue = value!;
    //           });
    //           modelloPersiane = value!;
    //           widget.variabile = value;
    //         },
    //         items: modelli.map<DropdownMenuItem<String>>((String value) {
    //           return DropdownMenuItem<String>(
    //             value: value,
    //             child: Row(
    //               children: [
    //                 Text(value),
    //               ],
    //             ),
    //           );
    //         }).toList(),
    //       );
    //     } else {
    //       throw Exception("Parametro non corretto");
    //     }
    //   }
    // }
    // else if (widget.condizione == "ferramenta") {
    //   {
    //     if (widget.variabile == "") {
    //       if (widget.stringa == "ferramentaPersiane") {
    //         dropdownValue = coloreFerramenta.first;
    //         ferramentaPersiane = dropdownValue;
    //       }
    //     } else {
    //       dropdownValue = widget.variabile;
    //     }
    //     if (widget.stringa == "ferramentaPersiane") {
    //       return DropdownButton(
    //         isExpanded: true,
    //         value: dropdownValue,
    //         onChanged: (String? value) {
    //           // This is called when the user selects an item.
    //           setState(() {
    //             dropdownValue = value!;
    //           });
    //           ferramentaPersiane = value!;
    //           widget.variabile = value;
    //         },
    //         items: coloreFerramenta.map<DropdownMenuItem<String>>((String value) {
    //           return DropdownMenuItem<String>(
    //             value: value,
    //             child: Row(
    //               children: [
    //                 Text(value),
    //               ],
    //             ),
    //           );
    //         }).toList(),
    //       );
    //     } else {
    //       throw Exception("Parametro non corretto");
    //     }
    //   }
    // }
    else {
      return ErrorWidget("ERRORE");
    }
  }
}
