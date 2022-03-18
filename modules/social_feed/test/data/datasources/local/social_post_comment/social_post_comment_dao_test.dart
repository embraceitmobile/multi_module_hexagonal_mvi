import 'package:drift/native.dart';
import 'package:social_feed/data/datasources/local/social_post_comment/daos/social_post_comment_dao.dart';
import 'package:social_feed/data/datasources/local/database/social_feed_database.dart';
import 'package:test/test.dart';

import '../mocks/mock_social_post_comments.dart';

void main() {
  late SocialFeedDatabase database;
  late SocialPostCommentDao dao;

  setUp(() {
    database = SocialFeedDatabase(NativeDatabase.memory());
    dao = SocialPostCommentDao(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('correct single comment is saved and retrieved', () async {
    await dao.insertOrUpdateComment(singleComment1);
    final fetchResult = await dao.allComments;

    expect(fetchResult.length, 1);
  });

  test(
      'on inserting multiple comments, the corresponding number of items'
      'are retrieved', () async {
    await dao.insertOrUpdateComment(singleComment1);
    await dao.insertOrUpdateComment(singleComment2);
    await dao.insertOrUpdateComment(singleComment3);
    final fetchResult = await dao.allComments;

    expect(fetchResult.length, 3);
  });

  test(
      'on inserting a list of comments, the corresponding number of items are retrieved',
      () async {
    final commentsCount = multipleComments.length;
    await dao.insertOrUpdateComments(multipleComments);

    final fetchResult = await dao.allComments;

    expect(fetchResult.length, commentsCount);
  });

  test(
      'on inserting a comment, the corresponding entry is emitted in the watcher',
      () async {
    await dao.insertOrUpdateComment(singleComment1);
    dao.observeAllComments.listen(expectAsync1((event) {
      expect(event.length, 1);
      expect(event.first.id, singleComment1.id);
    }));
  });

  test(
      'on inserting a comment, the corresponding entry is emitted in the watcher',
      () async {
    await dao.insertOrUpdateComment(singleComment1);
    await dao.insertOrUpdateComment(singleComment2);
    await dao.insertOrUpdateComment(singleComment3);
    dao.observeAllComments.listen(expectAsync1((event) {
      expect(event.length, 3);
      expect(event.last.id, singleComment3.id);
    }));
  });

  test(
      'on inserting a comment, the corresponding entry is emitted in the watcher',
      () async {
    dao.observeAllComments.listen(expectAsync1((event) {}, count: 4, max: 4));

    await dao.insertOrUpdateComment(singleComment1);
    await dao.insertOrUpdateComment(singleComment2);
    await dao.insertOrUpdateComment(singleComment3);
  });

  test(
      'on inserting a list of comments, the corresponding entries are emitted in the watcher',
      () async {
    var count = 0;
    final emitOrder = [0, multipleComments.length];
    dao.observeAllComments.listen(expectAsync1((event) {
      expect(event.length, emitOrder[count]);
      count++;
    }, count: 2, max: 2));

    await dao.insertOrUpdateComments(multipleComments);
  });

  test('on clearing table, all items are removed', () async {
    await dao.insertOrUpdateComments(multipleComments);
    expect((await dao.allComments).length, multipleComments.length);

    await dao.clearAll();
    expect((await dao.allComments).length, 0);
  });
}
