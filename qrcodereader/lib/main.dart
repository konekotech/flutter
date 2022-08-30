import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() => runApp(const MaterialApp(home: Screen1()));

//スクリーン1
class Screen1 extends StatelessWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '管理者を登録する',
          style: GoogleFonts.kosugiMaru(),
        ),
      ),
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton.extended(
              icon: Icon(Icons.camera),
              label: Text(
                "QRコードを読み取る",
                style: GoogleFonts.kosugiMaru(),
              ),
              //child: Text(
              // 'QR読み取り',
              // style: GoogleFonts.kosugiMaru(),
              //),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Screen5(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            child: Text(
              '次へ',
              style: GoogleFonts.kosugiMaru(),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Screen2(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen2'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('読み取りボタンだよ！！'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Screen3(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Screen3 extends StatelessWidget {
  const Screen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen3'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('読み取りボタンだよ！！'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Screen4(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Screen4 extends StatelessWidget {
  const Screen4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen4'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('読み取りボタンだよ！！'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Screen5(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Screen5 extends StatefulWidget {
  const Screen5({Key? key}) : super(key: key);

  @override
  _QrScanViewState createState() => _QrScanViewState();
}

class _QrScanViewState extends State<Screen5> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR読み取り'),
        centerTitle: true,
      ),
      body: _buildQrView(context),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      if (await canLaunchUrlString(scanData.code.toString())) {
        await launchUrlString(scanData.code.toString());
        controller.resumeCamera();
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Could not find viable url'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Barcode Type: ${describeEnum(scanData.format)}'),
                    Text('Data: ${scanData.code}'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        ).then((value) => controller.resumeCamera());
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
