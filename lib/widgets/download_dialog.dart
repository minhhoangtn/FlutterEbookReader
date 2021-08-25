import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DownloadDialog extends StatefulWidget {
  final String url;
  final String appPath;

  DownloadDialog({required this.url, required this.appPath});

  @override
  _DownloadDialogState createState() => _DownloadDialogState();
}

class _DownloadDialogState extends State<DownloadDialog> {
  int receivedBytes = 0;
  int totalBytes = 0;
  String progress = '0';
  CancelToken cancelToken = CancelToken();

  Future<void> _download() async {
    await Dio().download(
      widget.url,
      widget.appPath,
      deleteOnError: true,
      cancelToken: cancelToken,
      onReceiveProgress: (received, total) {
        setState(() {
          receivedBytes = received;
          totalBytes = total;
          progress = (receivedBytes / totalBytes * 100).toStringAsFixed(0);
        });

        if (receivedBytes == totalBytes) Navigator.of(context).pop(totalBytes);
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _download();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Downloading...',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Container(
                height: 5,
                child: LinearProgressIndicator(
                  value: double.parse(progress) / 100,
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).accentColor),
                  backgroundColor:
                      Theme.of(context).accentColor.withOpacity(0.3),
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('$progress %'),
                  Text('$receivedBytes of $totalBytes'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          cancelToken.cancel();
                          print('cancel download');
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Theme.of(context).accentColor),
                      )),
                  SizedBox(width: 15),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
