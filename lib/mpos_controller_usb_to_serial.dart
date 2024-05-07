import 'package:bxlflutterbgatelib/mpos_controller_devices.dart';
import 'package:flutter/services.dart';

class MPosControllerUsbToSerial extends MPosControllerDevices {
  @override
  MethodChannel get channel =>
      const MethodChannel('com.bixolon.mposcontroller/usbtoserial');

  @override
  EventChannel get dataChannel =>
      const EventChannel('com.bixolon.mposcontroller/usbtoserial/data');

  @override
  Stream<List<int>> get dataEventStream {
    return dataChannel.receiveBroadcastStream().cast();
  }
}
