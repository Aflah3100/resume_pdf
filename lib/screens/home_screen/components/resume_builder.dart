import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

const PdfColor green = PdfColor.fromInt(0xff9ce5d0);
const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);
const sep = 120.0;

Future<Uint8List> generateResume(PdfPageFormat format) async {
  final doc = pw.Document(title: 'Resume', author: 'Aflah Sedhique');

  final pageTheme = await _myPageTheme(format);

  doc.addPage(
    pw.MultiPage(
      pageTheme: pageTheme,
      build: (pw.Context context) => [
        pw.Partitions(
          children: [
            pw.Partition(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Container(
                    padding: const pw.EdgeInsets.only(left: 30, bottom: 20),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: <pw.Widget>[
                        pw.Text('Aflah Sedhique',
                            textScaleFactor: 2,
                            style: pw.Theme.of(context)
                                .defaultTextStyle
                                .copyWith(fontWeight: pw.FontWeight.bold)),
                        pw.Padding(padding: const pw.EdgeInsets.only(top: 10)),
                        pw.Text('Flutter Developer',
                            textScaleFactor: 1.2,
                            style: pw.Theme.of(context)
                                .defaultTextStyle
                                .copyWith(
                                    fontWeight: pw.FontWeight.bold,
                                    color: green)),
                        pw.Padding(padding: const pw.EdgeInsets.only(top: 20)),
                        pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: <pw.Widget>[
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: <pw.Widget>[
                                pw.Text('Aflah Manzil,'),
                                pw.Text('Cheerankavu Ezhukone PO'),
                                pw.Text('Kollam, Kerala'),
                              ],
                            ),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: <pw.Widget>[
                                pw.Text('+91 7373454537'),
                                pw.Text("aflah3100@gmail.com")
                              ],
                            ),
                            pw.Padding(padding: pw.EdgeInsets.zero)
                          ],
                        ),
                      ],
                    ),
                  ),
                  _Category(title: 'Professional Experience'),
                  _Block(
                      title: 'Flutter Developer Intern',
                      subtitle: "Ubixstar LLP\n08/2024-10/2024 | Remote",
                      description:
                          "Developed Flutter application with respect to guven UI & guidelines"),
                  pw.SizedBox(height: 20),
                  _Category(title: 'Education'),
                  _Block(
                      title: 'Bachelor Of Technology',
                      subtitle:
                          "Amrita Vishwa Vidyapeetham , Amritapuri\n07/2020 – 06/2024 | Kollam, India",
                      description: "CGPA: 9.22"),
                  _Block(
                      title: 'Higher Secondary',
                      subtitle:
                          "TKM Centenary Public School\n06/2018 – 03/2020 | Kollam",
                      description: "CGPA: 9.12"),
                  _Block(
                      title: 'High School',
                      subtitle:
                          "TKM Centenary Public School\n03/2017 – 03/2018 | Kollam",
                      description: "CGPA: 9.95"),
                  _Category(title: 'Projects'),
                  _Block(
                      title: 'Flutter Chat',
                      description:
                          "Developed a chat application using flutter and firebase enabling real time messaging b/w 2 users."),
                  _Block(
                      title: 'Kinetic QR',
                      description:
                          "Mobile application that allows users to create and scan QR codes using Flutter easily."),
                  _Block(
                      title:
                          'Breast Cancer Detection: Deep learning approach for accurate classification',
                      description:
                          "Developed a deep learning based breast cancer detection model using Auto Encoders for accurate feature extraction and classification."),
                  _Block(
                      title: 'Flutter Feed',
                      description:
                          "News app built using flutter allowing users to browse and read news articles from various sources. It utilizes the free news API provided by newsapi.org"),
                  pw.SizedBox(height: 10),
                  _Category(title: 'Skills'),
                  _Block(
                      title: 'Operating System',
                      description: "Linux , Windows"),
                  _Block(
                      title: 'Software Proficiency',
                      description: "Git , Firebase"),
                  _Block(
                      title: 'Programming Languages',
                      description: "Java , Python, C++ , Dart"),
                  _Block(
                      title: 'Soft skills',
                      description: "Leadership , Teamwork , Time management"),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
  return doc.save();
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
  final bgShape = await rootBundle.loadString('assets/resume.svg');

  format = format.applyMargin(
      left: 2.0 * PdfPageFormat.cm,
      top: 4.0 * PdfPageFormat.cm,
      right: 2.0 * PdfPageFormat.cm,
      bottom: 2.0 * PdfPageFormat.cm);
  return pw.PageTheme(
    pageFormat: format,
    theme: pw.ThemeData.withFont(
      base: await PdfGoogleFonts.openSansRegular(),
      bold: await PdfGoogleFonts.openSansBold(),
      icons: await PdfGoogleFonts.materialIcons(),
    ),
    buildBackground: (pw.Context context) {
      return pw.FullPage(
        ignoreMargins: true,
        child: pw.Stack(
          children: [
            pw.Positioned(
              child: pw.SvgImage(svg: bgShape),
              left: 0,
              top: 0,
            ),
            pw.Positioned(
              child: pw.Transform.rotate(
                  angle: pi, child: pw.SvgImage(svg: bgShape)),
              right: 0,
              bottom: 0,
            ),
          ],
        ),
      );
    },
  );
}

class _Block extends pw.StatelessWidget {
  _Block({required this.title, this.description, this.subtitle});

  final String title;
  String? description;
  String? subtitle;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: <pw.Widget>[
          pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: <pw.Widget>[
                pw.Container(
                  width: 6,
                  height: 6,
                  margin: const pw.EdgeInsets.only(top: 5.5, left: 2, right: 5),
                  decoration: const pw.BoxDecoration(
                    color: green,
                    shape: pw.BoxShape.circle,
                  ),
                ),
                pw.Text(title,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontWeight: pw.FontWeight.bold)),
                pw.Spacer(),
              ]),
          pw.Container(
            decoration: const pw.BoxDecoration(
                border: pw.Border(left: pw.BorderSide(color: green, width: 2))),
            padding: const pw.EdgeInsets.only(left: 10, top: 3, bottom: 5),
            margin: const pw.EdgeInsets.only(left: 5),
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Text(subtitle ?? "",
                      style: pw.Theme.of(context)
                          .defaultTextStyle
                          .copyWith(fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: 5),
                  pw.Text(description ?? "",
                      style: pw.Theme.of(context)
                          .defaultTextStyle
                          .copyWith(fontWeight: pw.FontWeight.normal)),
                ]),
          ),
        ]);
  }
}

class _Category extends pw.StatelessWidget {
  _Category({required this.title});

  final String title;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
        color: lightGreen,
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(6)),
      ),
      margin: const pw.EdgeInsets.only(bottom: 10, top: 20),
      padding: const pw.EdgeInsets.fromLTRB(10, 4, 10, 4),
      child: pw.Text(
        title,
        textScaleFactor: 1.5,
      ),
    );
  }
}
