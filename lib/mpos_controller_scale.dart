import 'package:bxlflutterbgatelib/mpos_controller_devices.dart';
import 'package:flutter/services.dart';

class MPosControllerScale extends MPosControllerDevices {
  @override
  MethodChannel get channel =>
      const MethodChannel('com.bixolon.mposcontroller/scale');

  @override
  EventChannel get dataChannel =>
      const EventChannel('com.bixolon.mposcontroller/scale/data');

  @override
  Stream<List<int>> get dataEventStream {
    return dataChannel.receiveBroadcastStream().cast();
  }
}
