import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'enum.dart';

void println(PrintTag tag, String msg){
  if(kDebugMode){
    var logger = Logger(
      filter: null, // Use the default LogFilter (-> only log in debug mode)
      printer: PrettyPrinter(), // Use the PrettyPrinter to format and print log
      output: null, // Use the default LogOutput (-> send everything to console)
    );
   switch(tag){

     case PrintTag.v:
       logger.v(msg);
       break;
     case PrintTag.d:
       logger.d(msg);
       break;
     case PrintTag.i:
       logger.i(msg);
       break;
     case PrintTag.w:
       logger.w(msg);
       break;
     case PrintTag.e:
       logger.e(msg.toString());
       break;
   }
  }
}