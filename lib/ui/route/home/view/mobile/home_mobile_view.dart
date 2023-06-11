import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../report_record_list_route/interface/report_record_list_provider.dart';
import '../../../report_record_list_route/view/report_record_list_view.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class HomeMobileView extends ConsumerWidget {
  late double h, w;

  HomeMobileView(this.h, this.w);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.bookmark_border),
        title: const Text("Report Records"),
        actions: [
          IconButton(
              onPressed: () async {
                await ref.watch(recordProvider.notifier).getRecords(context);
              },
              icon: const Icon(Icons.refresh)),
        ],
      ),
      body: RecordReportListView(h, w),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) {
              return _AddReportDialog(ctx);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _AddReportDialog extends ConsumerWidget {
  late BuildContext _ctx;
  late double h, w;
  late TextEditingController _titleCOntroller;

  late TextEditingController _descCOntroller;

  late TextEditingController _dateCOntroller;

  late TextEditingController _placeCOntroller;

  _AddReportDialog(this._ctx) {
    _titleCOntroller = TextEditingController();
    _descCOntroller = TextEditingController();
    _dateCOntroller = TextEditingController(
        text: DateFormat('yyyy/MM/dd').format(DateTime.now()));
    _placeCOntroller = TextEditingController();
  }

  @override
  Widget build(BuildContext context, ref) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return SimpleDialog(
      title: const ListTile(
        title: Text("Add new Report"),
      ),
      children: [
        _getTextField(_titleCOntroller, "title", w),
        SizedBox(
          height: h * .01,
        ),
        _getTextField(_descCOntroller, "description", w),
        SizedBox(
          height: h * .01,
        ),
        _getTextField(_dateCOntroller, "date", w),
        SizedBox(
          height: h * .01,
        ),
        _getTextField(_placeCOntroller, "place", w),
        SizedBox(
          height: h * .01,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: w * .05),
          child: ElevatedButton(
            onPressed: () async {
              await ref.watch(recordProvider.notifier).add(
                  toRecord(
                    base64Encode(md5
                        .convert(utf8.encode(DateTime.now().toIso8601String()))
                        .bytes),
                    _titleCOntroller.text,
                    _descCOntroller.text,
                    _dateCOntroller.text,
                    _placeCOntroller.text,
                  ),
                  _ctx);
              Navigator.of(context).pop();
            },
            child: const Text("add"),
          ),
        ),
        SizedBox(
          height: h * .01,
        ),
      ],
    );
  }

  Widget _getTextField(
          TextEditingController controller, String label, double w) =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: w * .05),
        child: TextField(
          controller: controller,
          maxLines: null,
          decoration: InputDecoration(
            label: Text(label),
          ),
        ),
      );
}
