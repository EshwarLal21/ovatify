import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_waveform/just_waveform.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:ovatify/Helper/appColor.dart';
import 'package:ovatify/Helper/image_Class.dart';
import 'package:rxdart/rxdart.dart';
import '../widget/btn_custumize.dart';
import '../widget/text.dart';
import 'List_Tracker_Screen.dart';

class UploadTrackScreen extends StatefulWidget {
  @override
  State<UploadTrackScreen> createState() => _UploadTrackScreenState();
}

class _UploadTrackScreenState extends State<UploadTrackScreen> {
  File? selectedAudioFile;
  String? fileName;
  String? fileSize;
  Duration? audioDuration;
  Waveform? waveform;
  bool isProcessingWaveform = false;

  final player = AudioPlayer();
  final progressStream = BehaviorSubject<WaveformProgress>();


  Future<void> uploadTrackToAPI(File file) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://ovatify.betfastwallet.com/api/user/music/creation'), // replace with real URL
      );

      request.headers.addAll({
        'Accept': 'application/json',
      });

      request.fields.addAll({
        'title': 'our title', // Replace with real input if you want form fields
        'description': 'our description will be here',
        'genre': 'testing genre',
        'status': 'draft',
        'duration': _formatDuration(audioDuration), // Using your helper function
        'metadata[]': 'value1',
      });

      request.files.add(
        await http.MultipartFile.fromPath(
          'music_file',
          file.path,
        ),
      );

      final response = await request.send();
      print(response.statusCode);
      print(response);

      if (response.statusCode == 200) {
        String responseData = await response.stream.bytesToString();
        print("✅ Upload Success: $responseData");
        Get.snackbar('Success', 'Track uploaded successfully!', backgroundColor: Colors.green);
        Get.to(() => ListTrackerScreen());
      } else {
        print("❌ Upload Failed: ${response.reasonPhrase}");
        Get.snackbar('Error', 'Upload failed: ${response.reasonPhrase}', backgroundColor: Colors.red);
      }
    } catch (e) {
      print("⚠️ Error uploading: $e");
      Get.snackbar('Exception', e.toString(), backgroundColor: Colors.red);
    }
  }


  @override
  void initState() {
    super.initState();
    progressStream.listen((progress) {
      if (progress.waveform != null) {
        setState(() {
          waveform = progress.waveform;
          isProcessingWaveform = false;
        });
      }
    });
  }

  @override
  void dispose() {
    player.dispose();
    progressStream.close();
    super.dispose();
  }

  Future<void> _processAudioFile(File file) async {
    setState(() {
      isProcessingWaveform = true;
    });

    try {
      final tempDir = await getTemporaryDirectory();
      final waveFile = File('${tempDir.path}/temp.wave');

      await JustWaveform.extract(
        audioInFile: file,
        waveOutFile: waveFile,
      ).listen(progressStream.add, onError: progressStream.addError);
    } catch (e) {
      progressStream.addError(e);
      setState(() {
        isProcessingWaveform = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: CustomLabelText(
          text: 'Upload Track',
          color: Colors.white,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 18.h),
            CustomLabelText(
              text: 'UPLOAD',
              color: AppColors.magenta,
              fontSize: 20.sp,
            ),
            CustomLabelText(
              text: 'YOUR AUDIO TRACK',
              color: AppColors.white,
              fontSize: 20.sp,
            ),
            SizedBox(height: 5.h),
            Center(
              child: DottedBorder(
                // color: AppColors.primary,
                // strokeWidth: 2,
                // dashPattern: [6, 4],
//borderType: BorderType.RRect,
                // radius: Radius.circular(12),
                child: Container(
                  width: 80.w,
                  height: 25.h,
                  color: Colors.transparent,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppImages.music),
                        SizedBox(height: 2.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomLabelText(
                              text: 'Drag file here or ',
                              color: AppColors.white,
                              fontSize: 16.sp,
                            ),
                            GestureDetector(
                              onTap: () async {
                                FilePickerResult? result = await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ['mp3', 'wav', 'aac', 'm4a'],
                                );

                                if (result != null && result.files.single.path != null) {
                                  File file = File(result.files.single.path!);
                                  await player.setFilePath(file.path);
                                  Duration? duration = player.duration;

                                  setState(() {
                                    selectedAudioFile = file;
                                    fileName = result.files.single.name;
                                    fileSize = '${(result.files.single.size / (1024 * 1024)).toStringAsFixed(1)} MB';
                                    audioDuration = duration;
                                  });

                                  await _processAudioFile(file);
                                }
                              },
                              child: CustomLabelText(
                                text: 'Browse',
                                color: AppColors.magenta,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (selectedAudioFile != null)
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Center(
                    child:
                    Container(
                      width: 80.w,
                      height: 23.h,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.darkgrey,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () {
                              },
                              child: Icon(
                                Icons.close,
                                color: AppColors.primary,
                                size: 24,
                              ),
                            ),
                          ),
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 1.h,),
                                Image.asset(AppImages.waves2),
                                Text(
                                  fileName ?? '',
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '${fileSize ?? ''} • ${_formatDuration(audioDuration)}',
                                  style: TextStyle(color: Colors.white70, fontSize: 14),
                                ),
                                SizedBox(height: 8),
                                if (isProcessingWaveform)
                                  LinearProgressIndicator(
                                    color: AppColors.magenta,
                                    backgroundColor: AppColors.black2,
                                  )
                                else if (waveform != null)
                                  Container(
                                    height: 2.h,
                                    child: CustomPaint(
                                      painter: AudioWaveformPainter(
                                        waveform: waveform!,
                                        start: Duration.zero,
                                        duration: waveform!.duration,
                                        waveColor: AppColors.primary,
                                        scale: 1.0,
                                        strokeWidth: 2.0,
                                        pixelsPerStep: 4.0,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )

                ),
              ),
            SizedBox(height: 3.h),
            CustomButton(
              title: 'Proceed',
              fontsize: 16.sp,
              borderwidth: 0.51,
              borderRadius: 15.sp,
              borderColor: AppColors.primary,
              onPressed: () {
                if (selectedAudioFile != null) {
                  uploadTrackToAPI(selectedAudioFile!);
                } else {
                  Get.snackbar('No File', 'Please select an audio file before uploading.', backgroundColor: Colors.orange);
                }
                Get.to(() => ListTrackerScreen());
              },
              // height: 5.h,
              // width: 34.w,

            ),
            SizedBox(height: 2.h,),
            CustomButton(
              title: 'Back to home',
              fontsize: 16.sp,
              borderwidth: 0.51,
              borderRadius: 15.sp,
              backgroundColor: AppColors.black,
              borderColor: AppColors.white,
              onPressed: () {
                Get.to(() => ListTrackerScreen());
              },
              // height: 5.h,
              // width: 34.w,

            ),
            SizedBox(height: 2.h,),

          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration? d) {
    if (d == null) return '';
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}

class AudioWaveformPainter extends CustomPainter {
  final double scale;
  final double strokeWidth;
  final double pixelsPerStep;
  final Paint wavePaint;
  final Waveform waveform;
  final Duration start;
  final Duration duration;

  AudioWaveformPainter({
    required this.waveform,
    required this.start,
    required this.duration,
    Color waveColor = Colors.blue,
    this.scale = 1.0,
    this.strokeWidth = 2.0,
    this.pixelsPerStep = 4.0,
  }) : wavePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = strokeWidth
    ..strokeCap = StrokeCap.round
    ..color = waveColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (duration == Duration.zero) return;

    double width = size.width;
    double height = size.height;

    final waveformPixelsPerWindow = waveform.positionToPixel(duration).toInt();
    final waveformPixelsPerDevicePixel = waveformPixelsPerWindow / width;
    final waveformPixelsPerStep = waveformPixelsPerDevicePixel * pixelsPerStep;
    final sampleOffset = waveform.positionToPixel(start);
    final sampleStart = -sampleOffset % waveformPixelsPerStep;
    for (var i = sampleStart.toDouble();
    i <= waveformPixelsPerWindow + 1.0;
    i += waveformPixelsPerStep) {
      final sampleIdx = (sampleOffset + i).toInt();
      final x = i / waveformPixelsPerDevicePixel;
      final minY = normalise(waveform.getPixelMin(sampleIdx), height);
      final maxY = normalise(waveform.getPixelMax(sampleIdx), height);
      canvas.drawLine(
        Offset(x + strokeWidth / 2, max(strokeWidth * 0.75, minY)),
        Offset(x + strokeWidth / 2, min(height - strokeWidth * 0.75, maxY)),
        wavePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant AudioWaveformPainter oldDelegate) {
    return false;
  }

  double normalise(int s, double height) {
    if (waveform.flags == 0) {
      final y = 32768 + (scale * s).clamp(-32768.0, 32767.0).toDouble();
      return height - 1 - y * height / 65536;
    } else {
      final y = 128 + (scale * s).clamp(-128.0, 127.0).toDouble();
      return height - 1 - y * height / 256;
    }
  }
}