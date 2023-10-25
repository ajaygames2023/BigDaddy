import '../../utils/enum.dart';

/// code : 200
/// message : "Success"
/// data : [{"RankId":1,"Id":"210295","Remarks":"Training Grounds","isMR":"","UserCount":"0","Gametype":"RING","MaxPlayers":"6","RingVariant":"HOLDEM","isZoom":false,"BettingRule":"NL","Blinds":"1/2","type":"","IS_ANONYNOUMS_TABLE":null,"JACKPOT_ID":null,"bonus":0,"auto_buyin":"true","Fee":"30/120"},{"RankId":2,"Id":"210296","Remarks":"Knight Clash","isMR":"","UserCount":0,"Gametype":"RING","MaxPlayers":"6","RingVariant":"HOLDEM","isZoom":false,"BettingRule":"NL","Blinds":"2/5","type":"","IS_ANONYNOUMS_TABLE":null,"JACKPOT_ID":null,"bonus":0,"auto_buyin":"true","Fee":"75/300"},{"RankId":3,"Id":"210297","Remarks":"House of Lords","isMR":"","UserCount":0,"Gametype":"RING","MaxPlayers":"6","RingVariant":"HOLDEM","isZoom":false,"BettingRule":"NL","Blinds":"5/10","type":"","IS_ANONYNOUMS_TABLE":null,"JACKPOT_ID":null,"bonus":0,"auto_buyin":"true","Fee":"150/600"},{"RankId":4,"Id":"210298","Remarks":"Duke Duels","isMR":"","UserCount":0,"Gametype":"RING","MaxPlayers":"6","RingVariant":"HOLDEM","isZoom":false,"BettingRule":"NL","Blinds":"10/25","type":"","IS_ANONYNOUMS_TABLE":null,"JACKPOT_ID":null,"bonus":0,"auto_buyin":"true","Fee":"500/2500"},{"RankId":5,"Id":"210299","Remarks":"Ace Mavericks","isMR":"","UserCount":0,"Gametype":"RING","MaxPlayers":"6","RingVariant":"HOLDEM","isZoom":false,"BettingRule":"NL","Blinds":"25/50","type":"","IS_ANONYNOUMS_TABLE":null,"JACKPOT_ID":null,"bonus":0,"auto_buyin":"true","Fee":"1250/5k"},{"RankId":6,"Id":"210300","Remarks":"Queen River","isMR":"","UserCount":0,"Gametype":"RING","MaxPlayers":"6","RingVariant":"HOLDEM","isZoom":false,"BettingRule":"NL","Blinds":"50/100","type":"","IS_ANONYNOUMS_TABLE":null,"JACKPOT_ID":null,"bonus":0,"auto_buyin":"true","Fee":"2500/10k"},{"RankId":7,"Id":"210302","Remarks":"Regents Room","isMR":"","UserCount":0,"Gametype":"RING","MaxPlayers":"6","RingVariant":"HOLDEM","isZoom":false,"BettingRule":"NL","Blinds":"100/200","type":"","IS_ANONYNOUMS_TABLE":null,"JACKPOT_ID":null,"bonus":0,"auto_buyin":"true","Fee":"5k/20k"},{"RankId":8,"Id":"210301","Remarks":"Queen Flush","isMR":"","UserCount":0,"Gametype":"RING","MaxPlayers":"6","RingVariant":"HOLDEM","isZoom":false,"BettingRule":"NL","Blinds":"100/200","type":"","IS_ANONYNOUMS_TABLE":null,"JACKPOT_ID":null,"bonus":0,"auto_buyin":"true","Fee":"5k/12500"},{"RankId":9,"Id":"210303","Remarks":"Council of Kings","isMR":"","UserCount":0,"Gametype":"RING","MaxPlayers":"6","RingVariant":"HOLDEM","isZoom":false,"BettingRule":"NL","Blinds":"250/500","type":"","IS_ANONYNOUMS_TABLE":null,"JACKPOT_ID":null,"bonus":0,"auto_buyin":"true","Fee":"15k/50k"},{"RankId":10,"Id":"210304","Remarks":"Mega Monarchs","isMR":"","UserCount":0,"Gametype":"RING","MaxPlayers":"6","RingVariant":"HOLDEM","isZoom":false,"BettingRule":"NL","Blinds":"500/1k","type":"","IS_ANONYNOUMS_TABLE":null,"JACKPOT_ID":null,"bonus":0,"auto_buyin":"true","Fee":"50k/150k"}]
/// encryptionEnabled : false

class ApiModel {
  ApiModel({
    int? code,
    String? message,
    ApiStatus? apiStatus,
    dynamic response,}){
    _code = code;
    _message = message;
    _apiStatus = apiStatus;
    _response = response;  }

  ApiModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _apiStatus = json['apiStatus'];
    _response = json['response'] ?? "";
  }
  int? _code;
  ApiStatus? _apiStatus;
  String? _message;
  dynamic _response;
  bool? _encryptionEnabled;
  ApiModel copyWith({  int? code,
    String? message,
    ApiStatus? apiStatus,
    dynamic response
  }) => ApiModel(  code: code ?? _code,
    message: message ?? _message,
    apiStatus: apiStatus ?? _apiStatus,
    response: response ?? _response,
     );
  int? get code => _code;
  ApiStatus? get apiStatus => _apiStatus;
  String? get message => _message;
  dynamic get response => _response;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    map['apiStatus'] = _apiStatus;
    map['response'] = _response ?? "";
    return map;
  }

}
