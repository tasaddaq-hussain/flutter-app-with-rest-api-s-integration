import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:meta_melon_task_app/enums/enums.dart';
import 'package:meta_melon_task_app/model/posts_model.dart';
import 'package:meta_melon_task_app/services/api_service.dart';
import 'package:meta_melon_task_app/ui/base_viewmodel.dart';
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';

class HomeViewModel extends BaseViewModel {
  final ApiService _apiService = ApiService();

  ViewState _processStatus = ViewState.IDLE;
  ViewState get processStatus => _processStatus;

  ViewItemState _itemStatus = ViewItemState.IDLE;
  ViewItemState get itemStatus => _itemStatus;

  List<PostModel> post = [];
  List<PostModel> morePost = [];
  List<PostModel> searchPost = [];

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  TextEditingController textEditingController = TextEditingController();

  void onReady() {
    fetchPosts();
  }

  void onDestroy() {
    refreshController.dispose();
    // we can dispose streams and controlors here, when user left screen..
  }

  Future<dynamic> fetchPosts() async {
    _processStatus = ViewState.BUSY;
    log('runing..');
    final postdata = await _apiService.getPostApi();
    post = postdata;
    morePost = post.take(10).toList();
    _processStatus = ViewState.IDLE;
    log('processing completed..');

    notifyListeners();
  }

  void onMoreLoading() async {
    log('onMoreLoading runing...');
    await Future.delayed(const Duration(seconds: 2));
    if (post.length > morePost.length + 10) {
      morePost.addAll(post.getRange(morePost.length, morePost.length + 10));
      notifyListeners();
    } else {
      morePost.addAll(post.getRange(morePost.length, post.length));
      notifyListeners();
    }
    refreshController.loadComplete();
  }

  void onRefresh() async {
    _itemStatus = ViewItemState.BUSY;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    fetchPosts();
    _itemStatus = ViewItemState.IDLE;
    notifyListeners();
    refreshController.refreshCompleted();
  }

  // dialog for show more detail of post.
  Future postDialog(BuildContext context, String title, String body) {
    return showDialog(
      context: context,
      builder: (c) {
        return AlertDialog(
          title: Text(title.toString()),
          content: Text(body.toString()),
          actions: [
            Center(
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
              ),
            ),
          ],
        );
      },
    );
  }
}
