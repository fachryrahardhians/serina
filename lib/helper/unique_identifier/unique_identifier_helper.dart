
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:serina/config/constants.dart';
import 'package:serina/helper/random/random_gen_helper.dart';

class IdentifierHelper  {
  static Future<String> getIdentifier () async {
    try{
      DeviceInfoPlugin _plugin = DeviceInfoPlugin();
      if(Platform.isAndroid){
        /// jika android
        final info = await _plugin.androidInfo;
        return info.id;
      }else if(Platform.isIOS){
        /// jika macOS
        final info = await _plugin.iosInfo;
        return info.identifierForVendor!;
      }else{
        return generateRandomString(selfGeneratedIdLength);
      }
    }catch(e){
      debugPrint("GENERATING CAUSE FOUND SOMETHING WRONG");
      return generateRandomString(selfGeneratedIdLength);
    }
  } 
}