import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  late String time;
  String url;
  String flag;
  String location;
  late bool isDaytime; // true or false if daytime or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async{
    try{
    Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
    Map data = jsonDecode(response.body);
    String offset = data['utc_offset'].substring(1,3);
    String datetime = data['datetime'];

    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours:int.parse(offset)));

    isDaytime = now.hour > 6 && now.hour < 20;
    time = DateFormat.jm().format(now);
    }
    catch(e){
      print('caught error: $e');
      time = 'Couldn\'t get time';
    }

  }

}

