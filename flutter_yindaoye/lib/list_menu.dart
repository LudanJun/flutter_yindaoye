import 'package:flutter/material.dart';
import 'package:flutter_yindaoye/GradientText.dart';

class ListMenuPage extends StatefulWidget {
  const ListMenuPage({super.key});

  @override
  State<ListMenuPage> createState() => _ListMenuPageState();
}

class _ListMenuPageState extends State<ListMenuPage> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("菜单"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: const Color.fromRGBO(238, 238, 238, 1),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 0.0, 15.0),
              child: _setTitle('推荐菜品', 'recommend'),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(10, 0.0, 10.0, 15.0),
              child: Wrap(
                runSpacing: 15,
                children: [
                  _recommendFood(
                    5,
                    "酸菜鱼",
                    "川菜必点必吃!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!",
                    58,
                    "https://attachment4.jmw.com.cn/image/2019/03/01/15514261568182.jpg",
                    "酸辣",
                    "新鲜",
                    "爽口",
                    7,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // 模拟刷新操作的异步函数
  Future<void> _handleRefresh() async {
    return Future.delayed(Duration(seconds: 2)).then((_) {
      print("下拉刷新了");
      // 刷新完成后，你可能需要更新状态并通知UI刷新
      // 这通常涉及到调用setState()如果你的上下文是StatefulWidget
      // 或者如果你使用setStatelessWidget，你可能需要使用其他状态管理方式
    });
  }

  //公共头部标题
  Widget _setTitle(String mainTitle, String subHead) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        //只设置了最外部容器的左边边框
        border: Border(
          left: BorderSide(
            width: 8,
            color: Colors.blue,
          ),
        ),
      ),
      //如果不在child里添加实质性的控件内容 最外部容器是不显示效果的
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mainTitle,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            GradientText(
              data: subHead,
              gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.deepPurple]),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recommendFood(
    int value,
    String name,
    String desc,
    int price,
    String imageUrl,
    String tag1,
    String tag2,
    String tag3,
    int saleNum, //月销数量
  ) {
    return Container(
      alignment: Alignment.topLeft,
      height: 190,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Container(
        color: Colors.white,
        alignment: Alignment.topLeft,
        child: Flex(
          crossAxisAlignment: CrossAxisAlignment.start,
          direction: Axis.horizontal,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topLeft,
                height: 70,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '月售$saleNum',
                      style: const TextStyle(
                        color: Colors.black45,
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 30,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(255, 250, 205, 1),
                          ),
                          child: const Text(
                            '简介',
                            style: TextStyle(
                              color: Color.fromRGBO(255, 165, 0, 1),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 8.0),
                          width: 230.0,
                          child: Text(
                            desc,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          alignment: Alignment.center,
                          height: 24,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(255, 165, 0, 1),
                                width: 1),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(3),
                            ),
                          ),
                          child: Text(
                            tag1,
                            style: const TextStyle(
                              color: Color.fromRGBO(255, 165, 0, 1),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          alignment: Alignment.center,
                          height: 24,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(160, 32, 240, 1),
                                width: 1),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(3),
                            ),
                          ),
                          child: Text(
                            tag1,
                            style: const TextStyle(
                              color: Color.fromRGBO(160, 32, 240, 1),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          alignment: Alignment.center,
                          height: 24,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(255, 69, 0, 1),
                                width: 1),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(3),
                            ),
                          ),
                          child: Text(
                            tag1,
                            style: const TextStyle(
                              color: Color.fromRGBO(255, 69, 0, 1),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              const Text('￥',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text(
                                price.toString(),
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 23,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Offstage(
                                //是否隐藏
                                offstage: count == 0 ? true : false,
                                child: IconButton(
                                  onPressed: () {
                                    if (value > 0) {
                                      setState(() {
                                        count -= 1;
                                        print(count);
                                      });
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.remove_circle_outline,
                                    color: Color.fromRGBO(255, 165, 0, 1),
                                    size: 28,
                                  ),
                                ),
                              ),
                              Offstage(
                                offstage: count == 0 ? true : false,
                                child: Container(
                                  width: 25,
                                  child: Text(
                                    count.toString(),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    print(count);
                                    count += 1;
                                  });
                                },
                                icon: const Icon(
                                  Icons.add_circle,
                                  color: Color.fromRGBO(255, 165, 0, 1),
                                  size: 28,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
