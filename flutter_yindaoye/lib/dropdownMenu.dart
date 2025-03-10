import 'package:flutter/material.dart';

class DropdownMenuPage extends StatefulWidget {
  const DropdownMenuPage({super.key});

  @override
  State<DropdownMenuPage> createState() => _DropdownMenuPageState();
}

class _DropdownMenuPageState extends State<DropdownMenuPage>
    with SingleTickerProviderStateMixin {
  final List<String> data = ['语文', '数学', '英语', '物理', '化学', '生物', '地理'];
  late String _dropdownValue = data.first;

  late TabController _tabController;

  //生命周期函数:当组件初始化的时候就会触发
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownMenu(
              width: 300,
              menuHeight: 200, //下拉菜单高度
              // initialSelection: data.first,//设置默认选中值
              hintText: "请选择语言", //提示语
              onSelected: _onSelect, //选中回调
              dropdownMenuEntries: _buildMenuList(data), //菜单内容
            ),
            Text("你选择的学科是:$_dropdownValue")
          ],
        ),
      ),
    );
  }

  void _onSelect(String? value) {
    setState(() {
      print(value);
      _dropdownValue = value!;
    });
  }

  List<DropdownMenuEntry<String>> _buildMenuList(List<String> data) {
    return data.map((String value) {
      return DropdownMenuEntry(value: value, label: value);
    }).toList();
  }
}
