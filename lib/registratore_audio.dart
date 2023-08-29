import 'dart:convert';
import 'dart:io' as io;

import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart' as audio;

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

import 'nuovo_database.dart';

class RegistraAudio extends StatefulWidget {
  final Configurazione configurazione;
  final String tipoConfigurazione;

  const RegistraAudio(
      {super.key,
      required this.configurazione,
      required this.tipoConfigurazione});

  @override
  State<RegistraAudio> createState() => _RegistraAudioState();
}

class _RegistraAudioState extends State<RegistraAudio> {
  var tempoRegistrato;

  final audioPlayer = audio.AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;
  //late final _audioPath;

  Future initPlayer() async {
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == audio.PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });

    Future setAudio() async {
      audioPlayer.setReleaseMode(audio.ReleaseMode.loop);

      var base64 = base64Decode(widget.configurazione.audioVideo!);
      await audioPlayer.setSourceBytes(base64);

      //final file = io.File(_audioPath);
      // audioPlayer.setSourceAsset(_audioPath);
    }

    setAudio();
  }

  @override
  void initState() {
    super.initState();

    initRecorder();
  }

  @override
  void dispose() {
    recorder.closeRecorder();

    audioPlayer.dispose();

    super.dispose();
  }

  Future initRecorder() async {
    await recorder.openRecorder();

    isRecorderReady = true;
    recorder.setSubscriptionDuration(
      const Duration(milliseconds: 500),
    );
  }

  Future record() async {
    var tempDir = await getTemporaryDirectory();
    String path = '${tempDir.path}/audio.aac';

    if (!isRecorderReady) return;

    await recorder.startRecorder(toFile: path);
  }

  Future stop(List<int> photoData) async {
    if (!isRecorderReady) return;

    final path = await recorder.stopRecorder();
    final audioFile = io.File(path!);

    merge(
      photoData,
      audioFile.path,
    );

    //_audioPath = audioFile.path;
    print("$audioFile");
  }

  Future<String> merge(List<int> photoData, String audioPath) async {
    const outputVideoFileName = 'output.mp4';
    final outputVideoPath =
        '${(await getTemporaryDirectory()).path}/$outputVideoFileName';
    final photoPath = '${(await getTemporaryDirectory()).path}/photo.jpg';

    if (!await io.File(outputVideoPath).exists()) {
      io.File(outputVideoPath).create();
    }

    await io.File(photoPath).writeAsBytes(photoData);

    final FlutterFFmpeg flutterFFmpeg = FlutterFFmpeg();
    final arguments =
        '-loop 1 -i $photoPath -i $audioPath -y -t $tempoRegistrato $outputVideoPath';

    int result = await flutterFFmpeg.execute(arguments);

    if (result == 0) {
      print('Video creato con successo!');

      final videoBytes = await io.File(outputVideoPath).readAsBytes();
      widget.configurazione.audioVideo = base64Encode(videoBytes);
      DBHelper.instance.updateConfigurazione(
          widget.configurazione, widget.tipoConfigurazione);

      return outputVideoPath;
    } else {
      print('Errore durante la creazione del video');
      return "error";
    }
  }

  @override
  Widget build(BuildContext context) {
    // double firstHeight = MediaQuery.of(context).size.height;
    // double firstWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registra audio"),
      ),
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
                    const SizedBox(height: 32),
                    ElevatedButton(
                        onPressed: () async {
                          if (recorder.isRecording) {
                            await stop(
                                base64Decode(snapshot.data!.blob.toString()));
                          } else {
                            await record();
                          }
                          setState(() {});
                        },
                        child: Icon(
                            recorder.isRecording ? Icons.stop : Icons.mic,
                            size: 80)),
                    const SizedBox(height: 32),

                    ///widget per registrazione audio
                    StreamBuilder<RecordingDisposition>(
                      stream: recorder.onProgress,
                      builder: (context, snapshot) {
                        final duration = snapshot.hasData
                            ? snapshot.data!.duration
                            : Duration.zero;
                        tempoRegistrato = duration.inSeconds;
                        //print('QUESTO è IL TEMPO REGISTRATO${duration.inSeconds} s');
                        return Text('${duration.inSeconds} s');
                      },
                    ),

                    ///portare fuori da streambuilder, riproduce l'audio precedente ma con il tempo di registrazione di quello attuale///
                    Column(
                      children: [
                        //Text('${duration.inSeconds} s'),
                        Slider(
                            min: 0,
                            max: duration.inSeconds.toDouble(),
                            value: position.inSeconds.toDouble(),
                            onChanged: (value) async {
                              final position = Duration(seconds: value.toInt());
                              await audioPlayer.seek(position);
                            }),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 100),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(formatTime(position)),
                              CircleAvatar(
                                radius: 35,
                                child: IconButton(
                                  icon: Icon(
                                    isPlaying ? Icons.pause : Icons.play_arrow,
                                  ),
                                  iconSize: 50,
                                  onPressed: () async {
                                    await initPlayer();
                                    if (isPlaying) {
                                      //_RegistraAudioState().initState();
                                      await audioPlayer.pause();
                                    } else {
                                      await audioPlayer.resume();
                                    }
                                  },
                                ),
                              ),
                              Text(formatTime(duration - position)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Column(
                    //   children: [
                    //     Slider(
                    //         min: 0,
                    //         max: duration.inSeconds.toDouble(),
                    //         value: position.inSeconds.toDouble(),
                    //         onChanged: (value) async {
                    //           final position = Duration(seconds: value.toInt());
                    //           await audioPlayer.seek(position);
                    //         }),
                    //     Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 100),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Text(formatTime(position)),
                    //           CircleAvatar(
                    //             radius: 35,
                    //             child: IconButton(
                    //               icon: Icon(
                    //                 isPlaying ? Icons.pause : Icons.play_arrow,
                    //               ),
                    //               iconSize: 50,
                    //               onPressed: () async {
                    //                 if (isPlaying) {
                    //                   _RegistraAudioState().initState();
                    //                   await audioPlayer.pause();
                    //                 } else {
                    //                   await audioPlayer.resume();
                    //                 }
                    //               },
                    //             ),
                    //           ),
                    //           Text(formatTime(duration - position)),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    //// FutureBuilder<Configurazione>(
                    ////     future: DBHelper.instance.getConfigurazione(
                    ////         widget.configurazione.id!, widget.tipoConfigurazione),
                    ////     builder: (context, AsyncSnapshot<Configurazione> snapshot) {
                    ////       if (!snapshot.hasData) {
                    ////         return const Center(child: Text('Caricamento ...'));
                    ////       }
                    ////       return Center(
                    ////         child:
                    ////         Image.memory(
                    ////             base64Decode(snapshot.data!.audioVideo.toString())),
                    ////       );
                    ////     }),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
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
