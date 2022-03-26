import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Gallery")),
        body: const CustomBody(),
      ),
    );
  }
}

class CustomBody extends StatelessWidget {
  const CustomBody({Key? key}) : super(key: key);

  final List<String> datas = const [
    'https://i.scdn.co/image/ab6761610000e5eb006ff3c0136a71bfb9928d34',
    'https://awsimages.detik.net.id/community/media/visual/2021/03/09/iu-comeback-dengan-lilac_43.jpeg?w=700&q=90',
    'https://cdn0-production-images-kly.akamaized.net/RJLVAGFYIdVNsWTDOazXMlFODak=/1x24:702x419/469x260/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/2284563/original/053190300_1531929684-2.jpg',
    'https://media.suara.com/pictures/970x544/2020/05/08/70693-iuinstagram.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: GridView.count(
        crossAxisCount: 2,
        children: datas.map((data) => CustomGridCard(uri: data)).toList(),
      ),
    );
  }
}

enum RadioOption { dialog, bottomSheet }

class CustomGridCard extends StatefulWidget {
  final String uri;
  const CustomGridCard({Key? key, required this.uri}) : super(key: key);

  @override
  State<CustomGridCard> createState() => _CustomGridCardState();
}

class _CustomGridCardState extends State<CustomGridCard> {
  RadioOption option = RadioOption.bottomSheet;

  void handleOpenBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(30),
        child: Image.network(
          widget.uri,
        ),
      ),
    );
  }

  void handleOpenDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Image.network(
            widget.uri,
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"),
              ),
            ],
          )
        ],
      ),
    );
  }

  void handleShowImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Select view mode"),
              RadioListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Dialog'),
                value: RadioOption.dialog,
                groupValue: option,
                onChanged: (RadioOption? value) {
                  setState(() {
                    option = value ?? RadioOption.dialog;
                  });
                },
              ),
              RadioListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Bottom Sheet'),
                value: RadioOption.bottomSheet,
                groupValue: option,
                onChanged: (RadioOption? value) {
                  setState(() {
                    option = value ?? RadioOption.bottomSheet;
                  });
                },
              ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  switch (option) {
                    case RadioOption.bottomSheet:
                      return handleOpenBottomSheet(context);
                    case RadioOption.dialog:
                      return handleOpenDialog(context);
                  }
                },
                child: const Text("View"),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(4),
        child: Image.network(widget.uri, fit: BoxFit.cover),
      ),
      onTap: () => handleShowImage(context),
    );
  }
}
