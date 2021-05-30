import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_commun_app/model/post/post_model.dart';
import 'package:flutter_commun_app/resource/service/feed/firebase_post_service.dart';
import 'package:flutter_commun_app/resource/service/storage/file_upload_task_response.dart';
import 'package:flutter_commun_app/resource/service/storage/firebase_storage_service.dart';

part 'post_repo_impl.dart';

abstract class PostRepo {
  Future<Either<String, bool>> createPost(PostModel model);
  Future<Either<String, String>> uploadFile(File file, String uploadPath,
      {void Function(FileUploadTaskResponse response) onFileUpload});
  Future<Either<String, List<PostModel>>> getPostLists(String userId);
}