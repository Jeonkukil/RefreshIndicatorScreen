import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

class SingleChildScrollViewScreen extends StatelessWidget {
  // SingleChildScrollView 보이지 않는 부분을 모두 렌더링한다.
  // 리스트를 만드는 함수
  final List<int> numbers = List.generate(
    // 리스트의 길이
      100,
        // index의 경우 순서
        (index) => index,
  );

  SingleChildScrollViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(numbers);

    return MainLayout(
      title: 'SingleChildScrollView',
      body: renderView(),
    );
  }


  // 1 기본 렌더링법
  //SingleChildScrollView 기본으로는 스크롤이 안되지만 화면이 넘어가면 스크롤이 되도록 하는 작동방식
  Widget renderSimple() {
    return SingleChildScrollView(
      child: Column(
        children: rainbowColors.map((e) =>
            renderContainer(color: e),
        ).toList(),
      ),
    );
  }

  //2 화면을 넘어가지 않아도 스크롤 되게하기
  // 이경우는 IOS에만 해당하는 듯 하다.
  Widget renderAlwausScroll() {
    return  SingleChildScrollView(
      // 피직스의 기본값 NeverScrollableScrollPhysics
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          renderContainer(color: Colors.black),
        ],
      ),
    );
  }

  //3 . ios 피직스정리
  Widget renderPhys() {
    return SingleChildScrollView(
      // BouncingScrollPhysics 위로 스크롤시 튕김효과
      physics: BouncingScrollPhysics(),
      child: Column(
        children: rainbowColors.map((e) =>
            renderContainer(color: e),
        ).toList(),
      ),
    );
  }

  //4. singlechildScrollView 퍼포먼스

  Widget renderView () {
    return  SingleChildScrollView(
      child: Column(
        children: numbers.map((e) =>
            renderContainer(
              color: rainbowColors[e % rainbowColors.length],
              index: e,
            ),
        ).toList(),
      ),
    );
  }

  Widget renderContainer({
    required Color color,
    int? index,
}) {
    if(index != null){
      print(index);
    }
    return Container(
      height: 300,
      color: color,
    );
  }
}
