import 'package:flutter/material.dart';

class DescriptionText extends StatefulWidget {
  final String text;

  DescriptionText({required this.text});

  @override
  _DescriptionTextState createState() => _DescriptionTextState();
}

class _DescriptionTextState extends State<DescriptionText> {
  late String firstHalf;
  late String secondHalf;
  bool flag = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.text.length > 300) {
      firstHalf = widget.text.substring(0, 300);
      secondHalf = widget.text.substring(0, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: secondHalf.isEmpty
            ? Text(
                '\t\t\t\t' + firstHalf,
                style: TextStyle(fontSize: 15),
              )
            : Column(
                children: [
                  Text(
                    '\t\t\t\t' +
                        (flag ? (firstHalf + '...') : (firstHalf + secondHalf)),
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.justify,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            flag = !flag;
                          });
                        },
                        child: Text(
                          flag ? 'show more' : 'show less',
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                          textAlign: TextAlign.justify,
                        ),
                      )
                    ],
                  )
                ],
              ));
  }
}
