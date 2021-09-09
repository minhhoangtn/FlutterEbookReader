import 'package:ebook_reader/enum/api_request_status.dart';
import 'package:ebook_reader/widgets/error_widget.dart';
import 'package:flutter/material.dart';

class BodyBuilder extends StatelessWidget {
  final APIRequestStatus apiRequestStatus;
  final Widget child;
  final VoidCallback onPressErrorWidget;
  const BodyBuilder(
      {required this.apiRequestStatus,
      required this.child,
      required this.onPressErrorWidget});

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    switch (apiRequestStatus) {
      case APIRequestStatus.loading:
        return Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).accentColor));
      case APIRequestStatus.error:
        return MyErrorWidget(
          onRefresh: onPressErrorWidget,
        );
      case APIRequestStatus.loaded:
        return child;
      default:
        return CircularProgressIndicator(color: Theme.of(context).accentColor);
    }
  }
}
