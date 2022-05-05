import 'package:flutter/material.dart';

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  const DescriptionTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  _DescriptionTextWidgetState createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 135) {
      firstHalf = widget.text.substring(0, 135);
      secondHalf = widget.text.substring(135, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return secondHalf.isEmpty
        ? Text(
            firstHalf,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
            ),
          )
        : Column(
            children: <Widget>[
              Text(
                flag ? (firstHalf + '...') : (firstHalf + secondHalf),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
              InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      flag ? 'show more' : 'show less',
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                      //style: const TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
                onTap: () {
                  setState(() {
                    flag = !flag;
                  });
                },
              ),
            ],
          );
  }
}
