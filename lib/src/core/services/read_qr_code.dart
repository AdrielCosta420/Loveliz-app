import 'package:flutter_barcode_scanner_plus/flutter_barcode_scanner_plus.dart';

Future<void> readQrCode() async {
  try {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666', // Color of the scan line
      'Cancel', // Text for cancel button
      true, // Show flash icon
      ScanMode.QR, // Scan mode (QR or barcode)
    );

    if (barcodeScanRes != '-1') {
      // If the scan was successful, do something with the result
      print('QR Code: $barcodeScanRes');
    } else {
      // Handle the case when the scan is canceled
      print('Scan canceled');
    }
  } catch (e) {
    // Handle any errors that occur during scanning
    print('Error scanning QR code: $e');
  } finally {
    // Optionally, you can add any cleanup code here
  }
}
