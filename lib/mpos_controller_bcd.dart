import 'package:bxlflutterbgatelib/mpos_controller_devices.dart';
import 'package:flutter/services.dart';

class MPosControllerBcd extends MPosControllerDevices {
  @override
  MethodChannel get channel =>
      const MethodChannel('com.bixolon.mposcontroller/bcd');

  Future<int?> displayString(
    String data,
    int characterSet,
    int internationalCharacterSet,
    int line,
  ) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data': data,
      'character_set': characterSet,
      'international_character_set': internationalCharacterSet,
      'line': line
    };
    return await channel.invokeMethod('displayString', params);
  }

  Future<int?> clearScreen() async {
    return await channel.invokeMethod('clearScreen');
  }

  Future<int?> storeBase64Image(
    String data,
    int width,
    int imageNumber,
  ) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'data': data,
      'width': width,
      'image_number': imageNumber
    };
    return await channel.invokeMethod('storeBase64Image', params);
  }

  Future<int?> storeImageFile(
    String fileName,
    int width,
    int imageNumber,
  ) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'file_name': fileName,
      'width': width,
      'image_number': imageNumber
    };
    return await channel.invokeMethod('storeImageFile', params);
  }

  Future<int?> displayImage(
      int xPosition, int yPosition, int imageNumber) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'x_pos': yPosition,
      'y_pos': yPosition,
      'image_number': imageNumber
    };
    return await channel.invokeMethod('displayImage', params);
  }

  Future<int?> clearImage(int imageNumber) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'image_number': imageNumber
    };
    return await channel.invokeMethod('clearImage', params);
  }

  Future<int?> showCursor(int showCursor) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'show_cursor': showCursor
    };
    return await channel.invokeMethod('showCursor', params);
  }
}
