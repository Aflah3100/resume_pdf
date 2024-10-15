import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:resume_pdf/screens/home_screen/components/resume_builder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Resume PDF",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: PdfPreview(
          build: (format) => generateResume(format),
        ));
  }
}
