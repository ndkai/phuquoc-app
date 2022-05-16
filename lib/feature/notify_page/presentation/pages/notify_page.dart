import 'package:flutter/material.dart';
import 'package:phuquoc/feature/base/base_page.dart';

class NotifyPage extends StatefulWidget {
  const NotifyPage({Key? key}) : super(key: key);

  @override
  _NotifyPageState createState() => _NotifyPageState();
}

class _NotifyPageState extends State<NotifyPage> {
  @override
  Widget build(BuildContext context) {
    return BaseSubPage(
      child: Text("Trang thong bao"),
    );
  }
}

