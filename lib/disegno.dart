import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:gallery_saver/gallery_saver.dart';
import 'package:signature/signature.dart';

//import 'mio_database.dart';
import 'nuovo_database.dart';

class Disegno extends StatefulWidget {
  //final int? id;
  final String tipoConfigurazione;

  final Configurazione configurazionePersiana;

  const Disegno(
      {super.key,
      required this.configurazionePersiana,
      required this.tipoConfigurazione});

  @override
  State<Disegno> createState() => _DisegnoState();
}

class _DisegnoState extends State<Disegno> {
  // initialize the signature controller
  late SignatureController _controller = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.red,
    exportBackgroundColor: Colors.white,
    exportPenColor: Colors.black,
    onDrawStart: () => log('onDrawStart called!'),
    onDrawEnd: () => log('onDrawEnd called!'),
  );

  @override
  void initState() {
    super.initState();
    //_controller.addListener(() => log('Value changed'));
  }

  @override
  void dispose() {
    // IMPORTANT to dispose of the controller
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  Future<void> exportImage(
      BuildContext context, double firstWidth, double firstHeight) async {
    if (_controller.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          key: Key('snackbarPNG'),
          content: Text('Nessun contenuto'),
        ),
      );
      return;
    }

    final Uint8List? data = await _controller.toPngBytes(
        height: firstHeight.toInt(), width: firstWidth.toInt());
    if (data == null) {
      return;
    }

    //final bytes = await File(data.toString()).readAsBytes();

    final base64Disegno = base64Encode(data);

    try {
      Configurazione? configurazione = await DBHelper.instance
          .getConfigurazione(
              widget.configurazionePersiana.id!, widget.tipoConfigurazione);

      await DBHelper.instance.updateConfigurazione(
          Configurazione(
            id: widget.configurazionePersiana.id,
            riferimento: configurazione.riferimento,
            quantita: configurazione.quantita,
            larghezza: configurazione.larghezza,
            altezza: configurazione.altezza,
            tipo: configurazione.tipo,
            dxsx: configurazione.dxsx,
            vetro: configurazione.vetro,
            telaio: configurazione.telaio,
            larghezzaLuce: configurazione.larghezzaLuce,
            altezzaLuce: configurazione.altezzaLuce,
            blob: configurazione.blob,
            disegno: base64Disegno,
            note: configurazione.note,
            idParente: configurazione.idParente,
          ),
          widget.tipoConfigurazione);
    } catch (e) {
      print(e);
    }

    if (!mounted) return;

    await push(
      context,
      Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.check),
        ),
        appBar: AppBar(
          title: const Text('Anteprima'),
        ),
        body: Center(
          child: Container(
            color: Colors.grey[400],
            child: Image.memory(data),
          ),
        ),
      ),
    );
  }

  // Future<void> exportSVG(BuildContext context) async {
  //   if (_controller.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         key: Key('snackbarSVG'),
  //         content: Text('No content'),
  //       ),
  //     );
  //     return;
  //   }
  //
  //   final SvgPicture data = _controller.toSVG()!;
  //   //
  //   // final bytes = await File(data.toString()).readAsBytes();
  //   //
  //   // final base64Disegno= base64Encode(data);
  //
  //   try {
  //     Rilievo? rilievo = await DBHelper.instance.getRilievo(widget.id!);
  //
  //     widget.id != null
  //         ? await DBHelper.instance.update(
  //       Rilievo(
  //         id: widget.id,
  //         nome: rilievo?.nome,
  //         cognome: rilievo?.cognome,
  //         disegno: base64Disegno,
  //       ),
  //     )
  //         : await DBHelper.instance.update(
  //       Rilievo(
  //         id: widget.id,
  //         nome: rilievo?.nome,
  //         cognome: rilievo?.cognome,
  //         disegno: base64Disegno,
  //       ),
  //     );
  //   } catch (e) {
  //     print(e);
  //   }
  //
  //   if (!mounted) return;
  //
  //   await push(
  //     context,
  //     Scaffold(
  //       appBar: AppBar(
  //         title: const Text('SVG Image'),
  //       ),
  //       body: Center(
  //         child: Container(
  //           color: Colors.grey[300],
  //           child: data,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 600) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    double firstHeight = MediaQuery.of(context).size.height;
    double firstWidth = MediaQuery.of(context).size.width;
    List<Point> exportedPoints;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disegno tecnico'),
      ),
      body: ListView(
        children: <Widget>[
          // const SizedBox(
          //   height: 300,
          //   child: Center(
          //     child: Text('Big container to test scrolling issues'),
          //   ),
          // ),
          //SIGNATURE CANVAS
          Signature(
            key: const Key('signature'),
            controller: _controller,
            height: firstHeight,
            width: firstWidth,
            backgroundColor: Colors.grey[300]!,
          ),
          //OK AND CLEAR BUTTONS

          // const SizedBox(
          //   height: 300,
          //   child: Center(
          //     child: Text('Big container to test scrolling issues'),
          //   ),
          // ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          decoration: const BoxDecoration(color: Colors.black),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              //SHOW EXPORTED IMAGE IN NEW ROUTE
              IconButton(
                key: const Key('exportPNG'),
                icon: const Icon(Icons.save),
                color: Colors.blue,
                onPressed: () => {
                  exportImage(context, firstWidth, firstHeight),
                },
                tooltip: 'Save',
              ),
              IconButton(
                key: const Key('exportSVG'),
                icon: const Icon(Icons.share),
                color: Colors.blue,
                onPressed: () {
                  exportedPoints = _controller.points;
                  _controller = SignatureController(points: exportedPoints);
                },
                tooltip: 'Export SVG',
              ),
              IconButton(
                icon: const Icon(Icons.undo),
                color: Colors.blue,
                onPressed: () {
                  setState(() => _controller.undo());
                },
                tooltip: 'Undo',
              ),
              IconButton(
                icon: const Icon(Icons.redo),
                color: Colors.blue,
                onPressed: () {
                  setState(() => _controller.redo());
                },
                tooltip: 'Redo',
              ),
              //CLEAR CANVAS
              IconButton(
                key: const Key('clear'),
                icon: const Icon(Icons.clear),
                color: Colors.blue,
                onPressed: () {
                  setState(() => _controller.clear());
                },
                tooltip: 'Clear',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Pushes a widget to a new route.
Future push(context, widget) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) {
        return widget;
      },
    ),
  );
}
