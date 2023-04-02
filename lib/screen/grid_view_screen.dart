import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

class GridViewScreen extends StatelessWidget {
  List<int> numbers = List.generate(100, (index) => index);

  GridViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return MainLayout(
      title: 'GridViewScreen',
      body: renderMax(),
    );
  }



  // 1. 기본 그리드 뷰
  // List를 한번에 다 그려낸다.
  Widget renderCount() {
    return GridView.count(
      crossAxisCount: 2,
      // 간격 crossAxisSpacing
      crossAxisSpacing: 12.0,
      // 위아래 간격
      mainAxisSpacing: 12.0,
      children: numbers
          .map(
            (e) => renderContainer(
            color: rainbowColors[e % rainbowColors.length], index: e),
      )
          .toList(),
    );
  }


  // 2. 보이는 것만 렌더링한다.
  Widget renderBuilder() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
      ),
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,);
      },
    );
  }

  // 3. 위젯의 크기로 가로로 배치가 가능하다.

  Widget renderMax() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        //그리드뷰에 들어가는 item의 길이
        maxCrossAxisExtent: 220,
      ),
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,);
      },
    );
  }


  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
    print(index);
    return Container(
      // height == null ? 300 : height
      height: height ?? 300,
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }
}
