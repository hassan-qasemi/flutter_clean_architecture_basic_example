import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reportrecorder/domain/entity/report_record.dart';
import 'package:reportrecorder/domain/repository/record_repository_interface.dart';

class HiveReportRepository implements IRecordRepository {
  final colName = "reportrecords";

  late Box _reportBox;

  HiveReportRepository() {
    () async {
      _reportBox = Hive.isBoxOpen(colName)
          ? Hive.box(colName)
          : await Hive.openBox(colName);
    }.call();
  }

  @override
  Future<void> add(ReportRecord record) async =>
      await _reportBox.put(record.id, record.toJson());

  @override
  Stream<ReportRecord> getRecords() async* {
    StreamController<ReportRecord> recordStreamController = StreamController();
    late ReportRecord rec;
    for (var element in _reportBox.values) {
      rec = ReportRecord.fromJson(element.data());
      recordStreamController.add(rec);
    }
    yield* recordStreamController.stream;
  }

  @override
  Future<void> delete(String id) async => await _reportBox.delete(id);
}
