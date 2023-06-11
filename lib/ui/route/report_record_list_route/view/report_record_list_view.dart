import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:reportrecorder/ui/route/report_record_list_route/view/mobile/report_record_list_mobile_view.dart';

class RecordReportListView extends ConsumerWidget {
  late double w, h;

  RecordReportListView(this.h, this.w);

  @override
  Widget build(BuildContext context, ref) {
    return ReportRecordListMobileView(h, w);
  }
}
