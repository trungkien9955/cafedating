import 'package:cafedating/features/loader/loading_screen.dart';
import 'package:cafedating/features/notification/provider/async_notis.dart';
import 'package:cafedating/features/notification/view/noti_item.dart';
import 'package:cafedating/models/noti/noti_entities.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotisScreen extends ConsumerStatefulWidget {
  const NotisScreen({super.key});

  @override
  ConsumerState<NotisScreen> createState() => _NotisScreenState();
}

class _NotisScreenState extends ConsumerState<NotisScreen> {
  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<Noti>> asyncNotisData = ref.watch(asyncNotisProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Thông báo'),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(12),
        child: switch (asyncNotisData) {
          AsyncData(:final value) => ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return NotiItem(
                  id: value[index].id,
                  title: value[index].title,
                  body: value[index].body,
                  type: value[index].type,
                  senderPhotoUrl: value[index].senderPhotoUrl,
                  senderId: value[index].senderId,
                  receiverId: value[index].receiverId,
                  time: value[index].time,
                  isRead: value[index].isRead,
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: value.length),
          AsyncError(:final error, :final stackTrace) =>
            Text('${error.toString()} ${stackTrace.toString()}'),
          _ => const LoadingScreen()
        },
      )),
    );
  }
}
