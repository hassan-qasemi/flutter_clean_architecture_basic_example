import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reportrecorder/domain/entity/report_record.dart';
import 'package:reportrecorder/domain/repository/hive_report_repository.dart';
import '../../../../domain/repository/record_repository_interface.dart';

final recordProvider =
    StateNotifierProvider<ReportRecordListProvider, List<ReportRecord>>(
        (ref) => ReportRecordListProvider());

ReportRecord toRecord(
  String id,
  String title,
  String desc,
  String date,
  String place,
) {
  var rec = ReportRecord();
  rec.id = id;
  rec.title = title;
  rec.desc = desc;
  rec.date = date;
  rec.place = place;
  return rec;
}

class ReportRecordListProvider extends StateNotifier<List<ReportRecord>> {
  late IRecordRepository repository = HiveReportRepository();

  ReportRecordListProvider() : super([]);

  Future<void> add(ReportRecord record, BuildContext ctx) async {
    try {
      await repository.add(record);
      state.add(record);
    } catch (e) {
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> getRecords(BuildContext ctx) async {
    state = [];
    repository.getRecords().listen((event) {
      state.add(event);
    }, onError: (e, st) {
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    });
  }

  Future<void> remove(String id, BuildContext ctx) async {
    try {
      await repository.delete(id);
      state.remove(state.firstWhere((element) => element.id == id));
    } catch (e) {
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
