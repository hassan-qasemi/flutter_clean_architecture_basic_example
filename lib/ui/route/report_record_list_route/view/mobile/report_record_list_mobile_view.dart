import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:reportrecorder/ui/route/report_record_list_route/interface/report_record_list_provider.dart';

class ReportRecordListMobileView extends ConsumerWidget {
  late double h, w;

  ReportRecordListMobileView(this.h, this.w);

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      height: h,
      width: w,
      child: RefreshIndicator(
        onRefresh: () async {
          await ref.watch(recordProvider.notifier).getRecords(context);
        },
        child: ref.watch(recordProvider).isNotEmpty
            ? _RecordList()
            : const Center(child: Text("no docs here")),
      ),
    );
  }
}

class _RecordList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    return ListView.builder(
      itemBuilder: (ctx, inx) {
        return ListTile(
          leading: Text(ref.watch(recordProvider)[inx].date ?? "no date"),
          title:
              _getTextPlace(ref.watch(recordProvider)[inx].title ?? "no title"),
          subtitle:
              _getTextPlace(ref.watch(recordProvider)[inx].place ?? "no place"),
          trailing: IconButton(
              onPressed: () {
                ref
                    .watch(recordProvider.notifier)
                    .remove(ref.watch(recordProvider)[inx].id!, ctx);
              },
              icon: const Icon(Icons.delete)),
          onTap: () {
            showDialog(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  title: _getTextPlace(
                      ref.watch(recordProvider)[inx].title ?? "no title"),
                  content: _getTextPlace(
                      ref.watch(recordProvider)[inx].desc ?? "no desc"),
                );
              },
            );
          },
        );
      },
      itemCount: ref.watch(recordProvider).length,
    );
  }

  Widget _getTextPlace(String content) => Wrap(children: [Text(content)]);
}
