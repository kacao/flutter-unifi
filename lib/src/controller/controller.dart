import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:core';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' show IOClient;
import 'package:rxdart/rxdart.dart';
import '../utils.dart';

//import 'package:logging/logging.dart';
part 'package:unifi/src/controller/ext.dart';
part 'package:unifi/src/controller/http.dart';
part 'package:unifi/src/controller/exceptions.dart';
part 'package:unifi/src/controller/mixes/vouchers.dart';
part 'package:unifi/src/controller/mixes/guests.dart';
part 'package:unifi/src/controller/mixes/events.dart';

const siteDefault = 'default';

Map<String, String> defaultHeaders = {
  'Content-Type': 'application/json',
  'Connection': 'keep-alive',
  'Accept': 'application/json'
};

// endpoints
const _epBase = 'proxy/network/';
const _epLogin = 'api/auth/login';
const _epLogout = 'api/auth/logout';
const _epWebsocket = 'wss/s/%site%/events';

class Controller extends BaseController with GuestsMix, VouchersMix, EventsMix {
  final String host, username, password, siteId;
  final int port;
  late Uri _url, _urlLogin, _urlLogout, _urlWs;
  String _csrfToken = '';
  bool _authenticated = false;

  final Client _client = Client();
  Map<String, String> _headers = Map<String, String>.from(defaultHeaders);
  Cookie jar = Cookie("", "");

  get authenticated => _authenticated;

  Controller(
      {required this.host,
      this.port: 443,
      required this.username,
      required this.password,
      this.siteId: siteDefault}) {
    _url = Uri.https('$host:$port', "");
    _urlWs =
        Uri.parse("wss://$host:$port").resolve(_epBase).resolve(_epWebsocket);
    _urlLogin = _url.resolve(_epLogin);
    _urlLogout = _url.resolve(_epLogout);

    //log.level = Level.ALL;
    //log.onRecord.listen((record) {
    //  print('${record.level.name}: ${record.time}: ${record.message}');
    //});
  }

  factory Controller.fromMap(Map<String, dynamic> map) {
    return Controller(
        host: map['host'],
        port: map['port'],
        username: map['username'],
        password: map['password']);
  }

  @override
  Future<dynamic> post(String endpoint, Map<String, dynamic> payloads,
      {String? siteId, bool authenticate: true}) async {
    return await fetch(endpoint,
        payloads: payloads,
        method: Method.post,
        siteId: siteId,
        authenticate: authenticate);
  }

  @override
  Future<dynamic> fetch(String endpoint,
      {Method method: Method.get,
      Map<String, dynamic>? payloads,
      String? siteId,
      bool authenticate: true}) async {
    if (!_authenticated) await login();
    var sid = this.siteId;
    Uri url;

    if (endpoint.contains("login") | (endpoint.contains("logout"))) {
      url = _url.resolve(endpoint);
    } else {
      sid = siteId ?? this.siteId;
      endpoint = endpoint.replaceAll('%site%', sid);
      url = _url.resolve(path.join(_epBase, endpoint));
    }
    final Map<String, String> headers = getHeaders();
    var res = await _client.fetch(url,
        method: method, headers: headers, payloads: payloads);

    if ((res.statusCode == HttpStatus.forbidden) && (authenticate)) {
      if (await login()) {
        return fetch(endpoint,
            method: method,
            payloads: payloads,
            siteId: siteId,
            authenticate: false);
      } else {
        throw InvalidCredentials("Invalid login");
      }
    }

    if (res.statusCode == HttpStatus.ok) {
      _collectHeaders(res.headers);
      return jsonDecode(res.body)['data'];
    }

    var msg = '';
    try {
      msg = jsonDecode(res.body).toString();
    } on Exception {
      msg = res.body;
    }
    throw ApiException(res.statusCode, msg);
  }

  Future<bool> login() async {
    var res = await _client.get(_url);
    this._csrfToken = res.headers['x-csrf-token'] ?? "";
    final Map<String, String> payloads = {
      'username': username,
      'password': password
    };
    final headers = getHeaders();
    res = await _client.post(_urlLogin, headers: headers, payloads: payloads);
    _collectHeaders(res.headers);
    if (res.statusCode == HttpStatus.ok) {
      _authenticated = true;
      events._add(Event(EventType.authenticated));
      return true;
    }
    return false;
  }

  Future<bool> logout() async {
    var headers = getHeaders();
    var res = await _client.post(_urlLogout, headers: headers);
    if (res.statusCode == HttpStatus.ok) {
      jar = Cookie("", "");
      _csrfToken = "";
      _authenticated = false;
      events._add(Event(EventType.unauthenticated));
      return true;
    }
    return false;
  }

  @override
  Map<String, String> getHeaders() {
    Map<String, String> addons = {
      'Cookie': jar.toString(),
      "x-csrf-token": _csrfToken
    };
    return mergeMaps(_headers, addons);
  }

  ///
  /// update csrf token and cookies based on latest http response
  ///
  void _collectHeaders(Map<String, String> headers) {
    if (headers.containsKey('x-csrf-token'))
      _csrfToken = headers['x-csrf-token'] ?? "";
    if (headers.containsKey('set-cookie'))
      jar = Cookie.fromSetCookieValue(headers['set-cookie']!);
  }

  void dispose() {
    _events.dispose();
    logout();
  }
}

abstract class BaseController {
  Future<dynamic> post(String endpoint, Map<String, dynamic> payloads,
      {String? siteId, bool authenticate: true});

  Future<dynamic> fetch(String endpoint,
      {Method method: Method.get,
      Map<String, dynamic>? payloads,
      String? siteId,
      bool authenticate: true});
  Map<String, String> getHeaders();
}
