import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchBar<T> extends StatefulWidget implements PreferredSizeWidget {
  /// 从content中查找
  final List<T> contents;

  /// 返回为ture时，将content添加到搜索结果
  final bool Function(T content, String target) compare;

  /// 搜索结束
  final Function()? onSearched;

  /// 回调搜索结果
  final Function(List<T> searchResult)? onSearchResult;


  const SearchBar(
      {Key? key,
      required this.contents,
      required this.compare,
        this.onSearchResult,
      this.onSearched})
      : super(key: key);

  @override
  _SearchBarState<T> createState() => _SearchBarState<T>();

  @override
  Size get preferredSize => const Size.fromHeight(48.0);
}

class _SearchBarState<T> extends State<SearchBar<T>> {
  TextEditingController _textEditingController = TextEditingController();
  bool _isOffStage = true;
  final double searchBarHeight = 32.0;

  List<T> _searchResult = [];


  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isShowEnglish = Localizations.localeOf(context) ==  Locale('en', 'US');

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Material(
        color: isDark ? Theme.of(context).primaryColor : Colors.white,
        child: SafeArea(
          child: Row(
            children: <Widget>[
              // IconButton(
              //     onPressed: () {},
              //     icon: Icon(
              //       Icons.arrow_back,
              //       color: _isDark ? Colors.white : Colors.black,
              //     )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: searchBarHeight,
                  child: TextField(
                    autofocus: true,
                    onChanged: _onChange,
                    controller: _textEditingController,
                    style: TextStyle(height: 1, fontSize: searchBarHeight / 2),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor:
                            isDark ? Color(0xFF303233) : Color(0xFFF6F6F6),
                        border: InputBorder.none,
                        hintText: isShowEnglish ? "Search" : "搜索",
                        suffixIcon: Offstage(
                          offstage: _isOffStage,
                          child: GestureDetector(
                            onTap: (){
                              _textEditingController.clear();
                              _onChange("");
                            },
                            child: Icon(
                              Icons.highlight_off,
                            ),
                          ),
                        )
                        // contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        ),
                  ),
                ),
              ),
              TextButton(onPressed: () {
                Navigator.of(context).pop();
              }, child: Text(isShowEnglish ? "Cancel" : "取消"))
            ],
          ),
        ),
      ),
    );
  }

  _onChange(String target) {
    _searchResult.clear();

    if(target.isNotEmpty){
      widget.contents.forEach((element) {
        if(widget.compare(element,target)){
          _searchResult.add(element);
        }
      });
    }

    if(widget.onSearched != null){
      widget.onSearched!.call();
    }

    if(widget.onSearchResult != null){
      widget.onSearchResult!(_searchResult);
    }

    setState(() {
      _isOffStage = target.isEmpty ? true : false;
    });
  }
}
