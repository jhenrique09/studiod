import 'package:flutter/foundation.dart';

String getApiBaseUrl(){
  if(kReleaseMode){
    return "https://api-studiod.jhenrique09.me/v1/";
  } else {
    return "http://10.9.9.11:3000/v1/";
  }
}