import 'package:applicazione_prova/display_data_persiane.dart';
import 'package:applicazione_prova/display_data_tapparelle.dart';
import 'package:applicazione_prova/rilievo_persiane.dart';
import 'package:applicazione_prova/rilievo_tapparelle.dart';
import 'package:flutter/material.dart';

const List<String> telaio = <String>[
  'telaio a elle',
  'telaio zeta 35',
  'telaio 60',
];
const List<String> vetri = <String>[
  'vetro 1',
  'vetro 2',
  'vetro 3',
  'vetro 4',
];
const List<String> maniglie = <String>[
  'maniglia avorio',
  'maniglia bianca',
  'maniglia bronzo',
  'maniglia oro',
];
const List<String> finiture = <String>[
  'finitura 1',
  'finitura 2',
  'finitura 3',
  'finitura 4',
];
const List<String> guide = <String>[
  'guida 1',
  'guida 2',
  'guida 3',
  'guida 4',
];
const List<String> coloriInt = <String>[
  'colore 1',
  'colore 2',
  'colore 3',
  'colore 4',
];
const List<String> coloriEst = <String>[
  'colore 1',
  'colore 2',
  'colore 3',
  'colore 4',
];
const List<String> listelliInt = <String>[
  'listello 1',
  'listello 2',
  'listello 3',
  'listello 4',
];
const List<String> listelliEst = <String>[
  'listello 1',
  'listello 2',
  'listello 3',
  'listello 4',
];
const List<String> tipoTapparella = <String>[
  'tipo 1',
  'tipo 2',
  'tipo 3',
  'tipo 4',
];
const List<String> coloriTapparelle = <String>[
  'colore 1',
  'colore 2',
  'colore 3',
  'colore 4',
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
    if (widget.condizione == "telaio") {
      if (widget.variabile == "") {
        if (widget.stringa == "tipoTelaioPersiane") {
          dropdownValue = telaio.first;
          tipoTelaioPersiane = dropdownValue;
        } else if (widget.stringa == "tipoTelaioTapparelle") {
          dropdownValue = telaio.first;
          tipoTelaioTapparelle = dropdownValue;
        }
      } else {
        dropdownValue = widget.variabile;
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
            widget.variabile = value;
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
            widget.variabile = value;
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
    else if (widget.condizione == "vetro") {
      if (widget.variabile == "") {
        if (widget.stringa == "tipoVetroPersiane") {
          dropdownValue = vetri.first;
          tipoVetroPersiane = dropdownValue;
        } else if (widget.stringa == "tipoVetroTapparelle") {
          dropdownValue = vetri.first;
          tipoVetroTapparelle = dropdownValue;
        }
      } else {
        dropdownValue = widget.variabile;
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
            widget.variabile = value;
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
            widget.variabile = value;
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
    else if (widget.condizione == "maniglia") {
      if (widget.variabile == "") {
        if (widget.stringa == "tipoManigliaPersiane") {
          dropdownValue = maniglie.first;
          tipoManigliaPersiane = dropdownValue;
        }
      } else {
        dropdownValue = widget.variabile;
      }
      if (widget.stringa == "tipoManigliaPersiane") {
        return DropdownButton(
          isExpanded: true,
          value: dropdownValue,
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
            });
            tipoManigliaPersiane = value!;
            widget.variabile = value;
          },
          items: maniglie.map<DropdownMenuItem<String>>((String value) {
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
    else if (widget.condizione == "finitura") {
      if (widget.variabile == "") {
        if (widget.stringa == "tipoFinituraPersiane") {
          dropdownValue = finiture.first;
          tipoFinituraPersiane = dropdownValue;
        }
      } else {
        dropdownValue = widget.variabile;
      }
      if (widget.stringa == "tipoFinituraPersiane") {
        return DropdownButton(
          isExpanded: true,
          value: dropdownValue,
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
            });
            tipoFinituraPersiane = value!;
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
    else if (widget.condizione == "guida") {
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
    else {
      return const SizedBox.shrink();
    }
  }
}
