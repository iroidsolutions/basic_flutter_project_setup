import 'package:align_flutter_app/models/response/home/inspection/examination_response.dart';
import 'package:align_flutter_app/models/response/home/inspection/questions_response.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../../../api/api_repository.dart';
import 'model/question_model.dart';
import 'dart:io';
import 'package:camera/camera.dart';

class QuestionController extends GetxController {
  final ApiRepository apiRepository;
  QuestionController({required this.apiRepository});

  final CarouselController carouselController = CarouselController();
 var questionModelList = <QuestionModel>[].obs;
  var questionsResponse = <QuestionsResponse>[].obs;
  final Rx<int> currentQuestion = 0.obs;
  RxDouble distanceValue = 0.0.obs;
  var argumentData = Get.arguments[0] as ExaminationResponse;
  final RefreshController refreshController = RefreshController();
  var jobId = Get.arguments[1];
  RxBool argumentValue = true.obs;


  initQuestions() {
    questionModelList.clear();

    questionModelList.add(
      QuestionModel(
        id: 1,
        title: 'Windows',
        imagePathList: [],
        question:
            'Inspect the unit to make sure it’s in good working condition?',
        //tip: 'Tip: Do not fully cover your air conditioning unit during the winter.',
        questionSubmitted: false,
        tags: 'demo',
        notes: '',
        rating: 1,
        checkListID: '',
        location: '',
      ),
    );
    questionModelList.add(
      QuestionModel(
        id: 2,
        title: 'Air conditioner 2',
        imagePathList: [
          'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
          'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
          'https://via.placeholder.com/500',
        ],
        question:
            'Inspect the unit to make sure it’s in good working condition?',
        //tip: 'Tip: Do not fully cover your air conditioning unit during the winter.',
        questionSubmitted: true,
        tags: 'demo',
        notes: '',
        rating: 1,
        checkListID: '',
        location: '',
      ),
    );
    questionModelList.add(
      QuestionModel(
        id: 3,
        title: 'Air conditioner 3',
        imagePathList: [
          'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
          'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
        ],
        question:
            'Inspect the unit to make sure it’s in good working condition?',
        // tip: 'Tip: Do not fully cover your air conditioning unit during the winter.',
        questionSubmitted: true,
        tags: 'demo',
        notes: '',
        rating: 1,
        checkListID: '',
        location: '',
      ),
    );
    questionModelList.add(
      QuestionModel(
        id: 4,
        title: 'Air conditioner 4',
        imagePathList: [],
        question:
            'Inspect the unit to make sure it’s in good working condition?',
        //tip: 'Tip: Do not fully cover your air conditioning unit during the winter.',
        questionSubmitted: false,
        tags: 'demo',
        notes: '',
        rating: 1,
        checkListID: '',
        location: '',
      ),
    );

    questionModelList.add(
      QuestionModel(
        id: 5,
        title: 'Air conditioner 1',
        imagePathList: [
          'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
          'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
          //'https://via.placeholder.com/500',
        ],
        question:
            'Inspect the unit to make sure it’s in good working condition?',
        // tip: 'Tip: Do not fully cover your air conditioning unit during the winter.',

        questionSubmitted: true,
        tags: 'demo',
        notes: '',
        rating: 1,
        checkListID: '',
        location: '',
      ),
    );
  }

  addImagePath({required String imagePath}) {
    /* questionModelList[currentQuestion.value].localImagePathList
        .add(imagePath);*/

    //questionModelList[currentQuestion.value].imagePath.value = imagePath;

    //print('localImagePathList.length = ${questionModelList[currentQuestion.value].localImagePathList.length}');
  }

  getQuestion(int examinationId, int jobId) async {
    var res = await apiRepository.getQuestion(examinationId, jobId);
    if (res != null && res.isNotEmpty) {
      questionsResponse.value = res;
      if (questionsResponse.isNotEmpty) {
        questionModelList.clear();
        for (int i = 0; i < questionsResponse.length; i++) {
          questionModelList.add(
            QuestionModel(
              id: questionsResponse[i].questionId!,
              title: questionsResponse[i].title!,
              imagePathList: questionsResponse[i].answer!.images == null ? [] : questionsResponse[i].answer!.images!.map((e) => e.image ?? '').toList(),
              question: questionsResponse[i].description!,
              tags: questionsResponse[i].answer?.tags ?? '',
              notes: questionsResponse[i].answer?.notes ?? '',
              rating: questionsResponse[i].answer?.rating ?? 0,
              checkListID: '',
              location: questionsResponse[i].answer?.location ?? "",
              questionSubmitted: questionsResponse[i].answer?.answerId != null ? true : false,
            ),
          );
          //print("questionsResponse[i].answer=============${questionsResponse[i].answer?.tags}");
        }
      }
    }
  }

  @override
  void onInit() {
    print("jobID=============$jobId");
     // print("jobID=============${questionsResponse[].answer?.rating ?? 0}");
    //getQuestion(argumentData.examinationId ?? 0, jobId);
    super.onInit();
  }
}
