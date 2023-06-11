import 'package:reportrecorder/domain/entity/report_record.dart';

abstract class IRecordRepository {
  Future<void> add(ReportRecord record);

  Stream<ReportRecord> getRecords();

  Future<void> delete(String id);
}
