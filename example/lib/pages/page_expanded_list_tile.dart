import 'package:flutter_twice/flutter_twice.dart';

import '../index.dart';

class PageExpandedListTile extends StatefulWidget {
  const PageExpandedListTile({Key? key}) : super(key: key);

  @override
  _PageExpandedListTileState createState() => _PageExpandedListTileState();
}

class _PageExpandedListTileState extends State<PageExpandedListTile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PageExpandedListTile"),
      ),
      body: Column(children: [
        Expanded(
          child: ListView(children: [
            ExpandedListTile(
              onTap: () => print("onTap."),
              title: "点击展开列表",
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (_, index) {
                    return ListTile(
                      title: Text("这是第$index行"),
                    );
                  }),
            ),
            ExpandedListTile(
              onTap: () => print("onTap."),
              title: "点击展开列表",
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (_, index) {
                    return ListTile(
                      title: Text("这是第$index行"),
                    );
                  }),
            ),
            ExpandedListTile(
              onTap: () => print("onTap."),
              title: "点击展开列表",
              child: ExpandedListTile(
                onTap: () => print("onTap."),
                title: "点击展开列表",
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (_, index) {
                      return ListTile(
                        title: Text("这是第$index行"),
                      );
                    }),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}
