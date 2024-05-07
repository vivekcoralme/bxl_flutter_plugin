import 'package:bxlflutterbgatelib/mpos_controller_devices.dart';
import 'package:flutter/services.dart';

class MPosControllerConfig extends MPosControllerDevices {
  @override
  MethodChannel get channel =>
      const MethodChannel('com.bixolon.mposcontroller/config');

  Future<String?> searchDevices() async {
    final devices = await channel.invokeMethod('searchDevices');
    return devices;
  }

  Future<List<String>?> getCustomDevices(int deviceType) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'device_type': deviceType
    };
    final devices = await channel.invokeMethod('getCustomDevices', params);
    List<String>? array = [];
    for (final item in devices) {
      array.add(item as String);
    }
    return array;
  }

  Future<int?> addCustomDevice(int deviceType, String vid, String pid) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'device_type': deviceType,
      'vid': vid,
      'pid': pid
    };
    return await channel.invokeMethod('addCustomDevice', params);
  }

  Future<int?> deleteCustomDevice(
      int deviceType, String vid, String pid) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'device_type': deviceType,
      'vid': vid,
      'pid': pid
    };
    return await channel.invokeMethod('deleteCustomDevice', params);
  }

  Future<int?> reInitCustomDeviceType(int deviceType) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'device_type': deviceType
    };
    return await channel.invokeMethod('reInitCustomDeviceType', params);
  }

  Future<String?> getUSBDevice(int deviceId) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'device_id': deviceId
    };
    return await channel.invokeMethod('getUSBDevice', params);
  }

  Future<String?> getSerialNumber(int deviceId) async {
    return await channel.invokeMethod('getSerialNumber');
  }

  Future<String?> getBgateSerialNumber() async {
    return await channel.invokeMethod('getBgateSerialNumber');
  }

  Future<List<int>?> getSerialConfiguration(int deviceId) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'device_id': deviceId
    };
    final configs =
        await channel.invokeMethod('getSerialConfiguration', params);
    List<int>? array = [];
    for (final item in configs) {
      array.add(item as int);
    }
    return array;
  }

  Future<List<int>?> setSerialConfiguration(
    int deviceId,
    int baudRate,
    int dataBit,
    int stopBit,
    int parityBit,
    int flowControl,
  ) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'device_id': deviceId,
      'baud_rate': baudRate,
      'data_bit': dataBit,
      'stop_bit': stopBit,
      'parity_bit': parityBit,
      'flow_control': flowControl
    };
    return await channel.invokeMethod('setSerialConfiguration', params);
  }

  Future<List<int>?> getSerialConfig(int deviceId) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'device_id': deviceId
    };
    final configs = await channel.invokeMethod('getSerialConfig', params);
    List<int>? array = [];
    for (final item in configs) {
      array.add(item as int);
    }
    return array;
  }

  Future<List<int>?> setSerialConfig(
    int deviceId,
    int baudRate,
    int dataBit,
    int stopBit,
    int parityBit,
  ) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'device_id': deviceId,
      'baud_rate': baudRate,
      'data_bit': dataBit,
      'stop_bit': stopBit,
      'parity_bit': parityBit
    };
    return await channel.invokeMethod('setSerialConfig', params);
  }
}
