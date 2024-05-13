import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class LoadingFooter extends StatefulWidget {
  const LoadingFooter({Key? key}) : super(key: key);

  @override
  LoadingFooterState createState() => LoadingFooterState();
}

class LoadingFooterState extends State<LoadingFooter> {
  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      loadStyle: LoadStyle.ShowWhenLoading,
      builder: (BuildContext context, LoadStatus? _) {
        return Container(
          height: 30,
          alignment: Alignment.center,
          child: const SizedBox(
            height: 23,
            width: 23,
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
              // backgroundColor: Palette.lightShade,
              // valueColor: AlwaysStoppedAnimation<Color>(Get.theme.colorScheme.primary),
            ),
          ),
        );
      },
    );
  }
}
