import 'package:flutter/material.dart';
import 'package:flutter_twice/index.dart';

class PageCustomText extends StatefulWidget {
  const PageCustomText({Key? key}) : super(key: key);

  @override
  _PageCustomTextState createState() => _PageCustomTextState();
}

class _PageCustomTextState extends State<PageCustomText> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("跑马灯控件"),
      ),
      body: Column(children: [
        Container(
          width: double.infinity,
          height: 100,
          child: Center(
            child: Marquee(
              child: Text(
                "下面是专辑封面 下面是专辑封面 下面是专辑封面 下面是专辑封面",
                maxLines: 1,
                overflow: TextOverflow.visible,
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
        ),
        SizedBox(height:20),
        Container(
          color: Colors.yellow,
          width: 300,
          height: 300,
          child: Marquee(
            orientation: Orientation.landscape,
            child:Column(
              children: [
                Image.network("https://c-ssl.duitang.com/uploads/item/201601/15/20160115224508_TfuGA.jpeg",width: 300,),
                Image.network("http://p2.music.126.net/fHyz7zYjnIaUTKoiEkgAbA==/109951164194349109.jpg",width: 300,),
                Image.network("https://hbimg.huabanimg.com/9758e2248a413d3cc0cb3b05c9447ab51ae0b78c979d6c-Ym5Ehm_fw658/format/webp",width: 300,),
                Image.network("https://hbimg.huabanimg.com/db2dbd8d46be21c206c11848125d7c7587e9dafa4b71e-LWeH0F_fw658/format/webp",width: 300,),
                Image.network("https://hbimg.huabanimg.com/db2dbd8d46be21c206c11848125d7c7587e9dafa4b71e-LWeH0F_fw658/format/webp",width: 300,),
                Image.network("https://hbimg.huabanimg.com/db2dbd8d46be21c206c11848125d7c7587e9dafa4b71e-LWeH0F_fw658/format/webp",width: 300,),
              ],
            )
          ),
        )
      ]),
    );
  }
}

