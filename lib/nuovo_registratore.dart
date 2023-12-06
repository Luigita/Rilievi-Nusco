import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
//import 'package:flutter_sound_lite/flutter_sound.dart' as flutter_sound_lite;
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as rotation;

import 'nuovo_database.dart';

const pathAudio = 'audio_sample.aac';

class SoundRecorder extends StatefulWidget {
  const SoundRecorder({super.key, required this.configurazione, required this.tipoConfigurazione});

  final Configurazione configurazione;
  final String tipoConfigurazione;

  @override
  State<SoundRecorder> createState() => _SoundRecorderState();
}

class _SoundRecorderState extends State<SoundRecorder>{
  final recorder = Recorder();
  final timerController = TimerController();
  final player = SoundPlayer();

  @override
  void initState() {
    super.initState();

    recorder.init();
    player.init();
  }

  @override
  void dispose() {
    recorder.dispose();
    player.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Registra audio")),
    //backgroundColor: Colors.black87,
    body: Scaffold(
      body: ListView(
        children: [
          FutureBuilder<Configurazione>(
            future: DBHelper.instance.getConfigurazione(
                widget.configurazione.id!, widget.tipoConfigurazione),
            builder: (context, AsyncSnapshot<Configurazione> snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.memory(
                      base64Decode(snapshot.data!.blob.toString()),
                      gaplessPlayback: true,
                    ),
                    buildTimer(),
                    buildStart(),
                    buildPlayer(),
                    buildSave(snapshot),
                  ],
                ),
              );
            },
          ),
          // buildTimer(),
          // buildStart(),
          // buildPlayer(),
          // buildSave(),
        ],
      )
    ),
  );

  Widget buildTimer(){
    final text = recorder.isRecording ? 'In ascolto ...' : 'Premi START per registrare';
    final animate = recorder.isRecording;

    return Column(
      children: [
        const Icon(Icons.mic),
        TimerWidget(controller: timerController),
        const SizedBox(height: 8),
        Text(text),
      ],
    );
  }

  Widget buildStart() {
    final isRecording = recorder.isRecording;
    final icon = isRecording ? Icons.stop : Icons.mic;
    final text = isRecording ? 'STOP' : 'START';
    final background = isRecording ? Colors.red: Colors.white;
    final onPrimary = isRecording ? Colors.white : Colors.black;

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(175,50),
        backgroundColor: background,
        foregroundColor: onPrimary,
      ),
      icon: Icon(icon),
      label: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      onPressed: () async {
        await recorder.toggleRecording();
        final isRecording = recorder.isRecording;
        setState(() {});

        if (isRecording) {
          timerController.startTimer();
        } else {
          timerController.stopTimer();
        }
      },
    );
  }

  Widget buildPlayer() {
    final isPlaying = player.isPlaying;
    final icon = isPlaying ? Icons.stop : Icons.play_arrow;
    final text = isPlaying ? 'Ferma riproduzione' : 'Riproduci registrazione';

    return ElevatedButton.icon(
        onPressed: () async {
          await player.togglePlaying(whenFinished: () => setState(() {}));
          setState(() {});
        },
        icon: Icon(icon),
        label: Text(text),
    );
  }
  
  Widget buildSave(AsyncSnapshot<Configurazione> snapshot) {



    return FloatingActionButton(
      child: widget.configurazione.id == null
          ? const Icon(Icons.save, color: Colors.red)
          : const Icon(Icons.save, color: Colors.white),
      onPressed: () async {
        try {
          Duration? duration = await FlutterSoundHelper().duration('/data/data/luigita.it.rilievi_nusco/cache/$pathAudio');
          
          String audioVideoPath = await merge(base64Decode(snapshot.data!.blob!), '/data/data/luigita.it.rilievi_nusco/cache/$pathAudio', duration, widget.configurazione, widget.tipoConfigurazione);
          //TODO: salva il video ma ruota l'immagine
          final bytes = await File(audioVideoPath).readAsBytes();
          final base64Video = base64Encode(bytes);

          Configurazione? configurazione = await DBHelper.instance
              .getConfigurazione(widget.configurazione.id!, widget.tipoConfigurazione);
          DBHelper.instance.updateConfigurazione(
              Configurazione(
                id: widget.configurazione.id,
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
                note: configurazione.note,
                blob: configurazione.blob,
                disegno: configurazione.disegno,
                audioVideo: base64Video,
                idParente: configurazione.idParente,
              ),
              widget.tipoConfigurazione);
          Navigator.of(context).pop();
        } catch (e) {
          print(e);
          Navigator.of(context).pop();
        }
      },
    );
  } ///salvare nel database

}

class Recorder {
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecorderInitialised = false;
  bool get isRecording => _audioRecorder!.isRecording;

  Future init() async {
    _audioRecorder = FlutterSoundRecorder();

    await _audioRecorder!.openAudioSession();
  //                     .openAudioSession()

    _isRecorderInitialised = true;
  }

  Future dispose() async {
    if (!_isRecorderInitialised) return;

    _audioRecorder!.closeAudioSession();
    //             .closeAudioSession()
    _audioRecorder = null;
    _isRecorderInitialised = false;
  }

  Future _record() async {
    if (!_isRecorderInitialised) return;
    await _audioRecorder!.startRecorder(toFile: pathAudio);
  }

  Future _stop() async {
    if (!_isRecorderInitialised) return;
    await _audioRecorder!.stopRecorder();
  }

  Future toggleRecording() async {
    if(_audioRecorder!.isStopped) {
      await _record();
    } else {
      await _stop();
    }
  }
}

class SoundPlayer {
  FlutterSoundPlayer? _audioPlayer;

  bool get isPlaying => _audioPlayer!.isPlaying;

  Future init() async {
    _audioPlayer = FlutterSoundPlayer();

    await _audioPlayer!.openAudioSession();
  }

  Future dispose() async {
    _audioPlayer!.closeAudioSession();
    _audioPlayer = null;
  }

  Future _play(VoidCallback whenFinished) async {
    await _audioPlayer!.startPlayer(
      fromURI: pathAudio,
      //codec: Codec.aacMP4,
      whenFinished: whenFinished,
    );
  }

  Future _stop() async {
    await _audioPlayer!.stopPlayer();
  }

  Future togglePlaying({required VoidCallback whenFinished}) async {
    if (_audioPlayer!.isStopped) {
      await _play(whenFinished);
    } else {
      await _stop();
    }
  }
}

class TimerController extends ValueNotifier<bool> {
  TimerController({bool isPlaying = false}) : super(isPlaying);

  void startTimer() => value = true;

  void stopTimer() => value = false;
}

class TimerWidget extends StatefulWidget{
  final TimerController controller;

  const TimerWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget>{
  Duration duration = Duration();

  Timer? timer;

  @override
  void initState() {
    super.initState();
    
    widget.controller.addListener(() {
      if (widget.controller.value) {
        startTimer();
      } else {
        stopTimer();
      }
    });
  }

  void reset() => setState(() => duration = Duration());

  void addTime() {
    const addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;

      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer({bool resets = true}) {
    if (!mounted) return;
    if (resets) {
      reset();
    }
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  void stopTimer({bool resets = true}) {
    if (!mounted) return;
    if (resets) {
      reset();
    }
    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) {
    return Text(formatTime(duration));
    throw UnimplementedError();
  }

}

Future<String> merge(List<int> photoData, String audioPath, Duration? tempoRegistrato, Configurazione configurazione, String tipoConfigurazione) async {
  const outputVideoFileName = 'output.mp4';
  final outputVideoPath =
      '${(await getTemporaryDirectory()).path}/$outputVideoFileName';
  final photoPath = '${(await getTemporaryDirectory()).path}/photo.jpg';

  //final immagine = rotation.decodeImage(photoData.);

  if (!await File(outputVideoPath).exists()) {
    File(outputVideoPath).create();
  }

  // final immagine = await File(photoPath).writeAsBytes(photoData);
  // final immagineRuotata = rotation.copyRotate(immagine as rotation.Image, angle: 90);
  // await File(photoPath).writeAsBytes(immagineRuotata.getBytes());

  await File(photoPath).writeAsBytes(photoData);

  final FlutterFFmpeg flutterFFmpeg = FlutterFFmpeg();

  ///********* argomenti per l'esecuzione del comando ffmpeg *********///

  final arguments =
      '-loop 1 -i $photoPath -i $audioPath -y -t ${tempoRegistrato?.inSeconds} $outputVideoPath';

  ///****************************************************************///

  int result = await flutterFFmpeg.execute(arguments);

  if (result == 0) {
    print('Video creato con successo!');

    final videoBytes = await File(outputVideoPath).readAsBytes();
    configurazione.audioVideo = base64Encode(videoBytes);
    DBHelper.instance.updateConfigurazione(
        configurazione, tipoConfigurazione);

    return outputVideoPath;
  } else {
    print('Errore durante la creazione del video');
    return "error";
  }
}

String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));

  return [
    if (duration.inHours > 0) hours,
    minutes,
    seconds,
  ].join(':');
}

String formatSeconds(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final seconds = twoDigits(duration.inSeconds.remainder(60));

  return seconds;
}