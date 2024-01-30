import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ministry/constants/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Database? db;

class InitializeDB {
  Future initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "db1.0.sqlite");

    final exist = await databaseExists(path);

    if (exist) {
      debugPrint("db already exists");
      await openDatabase(path);
    } else {
      debugPrint("creating a copy from assets");
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets", "db1.0.sqlite"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
      debugPrint("db copied");
    }
    await openDatabase(path);
    // open the database
    db = await openDatabase(path, readOnly: true);
  }
}

Future getCodes(String sw) async {
  Constants.stringCodes = 'track/';
  List<Map> result = await db!.rawQuery(
      "SELECT code FROM Codes WHERE code LIKE '%$sw%'  ORDER BY id DESC");

  for (var row in result) {
    Constants.stringCodes = '${Constants.stringCodes + row['code']},';
  }
  debugPrint(Constants.stringCodes);
}

saveTrackingId(String trackingId) {
  db?.insert(
    'Codes',
    {
      'code': trackingId,
    },
  );
}

saveNotif({String? body, String? title}) async {
  debugPrint('11111111111111');
  debugPrint(DateTime.now().toString());
  db?.insert(
    'notificationqewq',
    {
      'title': title,
      'body': body,
      'data_time': DateTime.now().toString(),
    },
  );
}

Future getNotifactions() async {
  Constants.notifactionsContentList.clear();
  List<Map> result =
      await db!.rawQuery('SELECT * FROM notification ORDER BY id DESC');
  debugPrint(result.toString() + '<<<<<<<');
  for (var row in result) {
    Constants.notifactionsContentList.add({
      'id': row['id'],
      'title': row['title'],
      'body': row['body'],
      'data_time': row['data_time'],
    });
  }
  debugPrint(
      "${Constants.notifactionsContentList.length}<------Constants.bookMarkContent.length");
}
