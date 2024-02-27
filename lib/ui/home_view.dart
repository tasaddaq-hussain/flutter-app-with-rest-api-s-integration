import 'package:flutter/material.dart';
import 'package:meta_melon_task_app/enums/enums.dart';
import 'package:meta_melon_task_app/ui/base_view.dart';
import 'package:meta_melon_task_app/ui/home_viewmodel.dart';
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      onModelReady: (model) {
        model.onReady();
      },
      onModelDestroy: (model) => model.onDestroy(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Meta Melon'),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: model.itemStatus == ViewItemState.BUSY
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 3))
                    : Text('${model.morePost.length} posts'),
              ),
            ],
          ),
          body: model.processStatus == ViewState.BUSY
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SmartRefresher(
                    enablePullUp: true,
                    enablePullDown: true,
                    controller: model.refreshController,
                    onLoading: model.onMoreLoading,
                    onRefresh: model.onRefresh,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: model.morePost.length,
                      itemBuilder: (context, i) {
                        return Card(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () => model.postDialog(
                                context,
                                model.post[i].title.toString(),
                                model.post[i].body.toString()),
                            child: ListTile(
                              title: Text(
                                model.post[i].title.toString(),
                                textAlign: TextAlign.start,
                              ),
                              subtitle: Text(
                                model.post[i].body.toString(),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
        );
      },
    );
  }
}
