import 'dart:io';

import '../../commons/all.dart';

class CommonScreen extends StatelessWidget {
  final Widget? body;
  final Widget? floatingActionButton;
  final String? title;
  final List<Widget>? actions;

  const CommonScreen({
    super.key,
    this.body,
    this.floatingActionButton,
    this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: floatingActionButton,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          title ?? "",
          style: TextStyle(
            fontSize: FontSize.s22,
            fontFamily: FontFamily.semiBold,
          ),
        ),
        actions: actions ?? [],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: Platform.isIOS? 0 : 10),
        child: body,
      ),
    );
  }
}
