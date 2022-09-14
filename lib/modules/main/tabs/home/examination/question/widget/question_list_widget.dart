import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../../../shared/constants/color_constants.dart';
import '../../../../../../../shared/constants/string_constant.dart';
import '../../../../../../../shared/utils/image_utils.dart';
import '../../../../../../../shared/utils/math_utils.dart';
import '../../../../../../../shared/widgets/base_elevated_button.dart';
import '../../../../../../../shared/widgets/base_text.dart';
import '../../../../../../../shared/widgets/common_container_shadow.dart';
import '../model/question_model.dart';
import '../question_controller.dart';
import 'animated_card.dart';

class QuestionListWidget extends GetView<QuestionController> {
  const QuestionListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: controller.questionModelList.map((questionModel) {
        return Builder(
          builder: (BuildContext context) {
            return CommonContainerWithShadow(
              width: Get.width,
              margin: EdgeInsets.symmetric(
                horizontal: getSize(10.0),
              ),
              child: _buildItem(questionModel),
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        onPageChanged: (index, reason) {
          controller.currentQuestion.value = index;
        },
        enlargeCenterPage: false,
        height: Get.height / 2,
        initialPage: 0,
        reverse: false,
        autoPlay: false,
        enableInfiniteScroll: false,
        scrollDirection: Axis.horizontal,
        scrollPhysics: BouncingScrollPhysics(),
        viewportFraction: 0.8,
      ),
      carouselController: controller.carouselController,
    );
  }

  _buildItem(QuestionModel questionModel) {
    return Padding(
      padding: EdgeInsets.all(
        getSize(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BaseText(text: questionModel.title),
          SizedBox(
            height: getSize(20.0),
          ),

          AnimatedCard(
            questionModel: questionModel,
          ),
          SizedBox(
            height: getSize(20.0),
          ),
          BaseText(
            text: questionModel.question,
            fontSize: 14,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: getSize(20.0),
          ),
          _buildReviewSliderView(),
          // Obx(() {
          //   return BaseText(
          //     text: 'Total Image = ${questionModel.localImagePathList.length}',
          //     fontSize: 12,
          //     textAlign: TextAlign.center,
          //   );
          // }),
          _buildSubmitView(questionModel: questionModel),
        ],
      ),
    );
  }

  _buildReviewSliderView() {
    return Column(
      children: [
        Row(),
        Row(),
      ],
    );
  }

  _buildSubmitView({required QuestionModel questionModel}) {
    return questionModel.questionSubmitted
        ? BaseElevatedButton(
      //width: 40,
      height: 30,
      borderRadius: BorderRadius.circular(getSize(8.0),),
      onPressed: null,
      gradient: LinearGradient(
        colors: [
          ColorConstants.buttonSubmittedStart,
          ColorConstants.buttonSubmittedEnd,
          // Color.fromRGBO(16, 89, 146, 1),
        ],
        begin: Alignment(93.75, 15),
        end: Alignment(31.25, 15),
        //begin: Alignment.topCenter,
        //end: Alignment.bottomCenter,
      ),
      child: Opacity(
        opacity: 0.5,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              getAssetsSVGImg('tick_circle'),
              color: ColorConstants.white,
            ),
            SizedBox(
              width: getSize(5.0),
            ),
            BaseText(
              text: StringConstants.buttonSubmitted,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),

    )
        : Obx(() {
      return Opacity(
        opacity: questionModel.localImagePathList.isEmpty ? 0.3 : 1,
        child: BaseElevatedButton(
          //width: 40,
          height: getSize(30.0),
          borderRadius: BorderRadius.circular(getSize(8.0),),
          // onPressed: (){
          //   _showDialog();
          // },
          onPressed: questionModel.localImagePathList.isEmpty
              ? null
              : () {
            //_showDialog();
          },
          child: BaseText(
            text: StringConstants.inspect,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    });
  }

  // _showDialog() {
  //   Get.dialog(
  //     CongratsDialog(
  //       coin: 5,
  //       continueCallBack: () {
  //         Get.back();
  //       },
  //     ),
  //   );
  // }
}
