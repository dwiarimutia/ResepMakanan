import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterapp1/data/resep.dart';

class DetailScreen extends StatefulWidget {
  final resep reseps;

  const DetailScreen({Key? key, required this.reseps}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late int remainingTime; // Waktu sisa dalam detik
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    remainingTime = widget.reseps.durasiMasak * 60; // Konversi menit ke detik
  }

  void startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '$minutes:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.reseps.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  widget.reseps.image,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.reseps.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Colors.blueAccent,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'HTM: ${widget.reseps.htm}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Durasi Memasak: ${widget.reseps.durasiMasak} menit',
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
            const SizedBox(height: 10),
            Text(
              'Timer: ${formatTime(remainingTime)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: startTimer,
              child: const Text('Mulai Timer'),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Description: ${widget.reseps.tutorial}',
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 18, color: Colors.brown),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
