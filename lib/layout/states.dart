import 'package:social_app/layout/Social_Layout.dart';

abstract class SocialLayoutStates{}

class SocialLayoutInitialState extends SocialLayoutStates{}
class SocialLayoutLoadingState extends SocialLayoutStates{}
class SocialLayoutSuccessState extends SocialLayoutStates{}
class SocialLayoutErrorState extends SocialLayoutStates{
  final String error;

  SocialLayoutErrorState(this.error);
}
class SocialLayoutChangButtomNavState extends SocialLayoutStates{}



class SocialProfileImageSuccess extends SocialLayoutStates{}
class SocialProfileImageError extends SocialLayoutStates{}
class o extends SocialLayoutStates{}
class p extends SocialLayoutStates{}
class s extends SocialLayoutStates{}


class SocialUploadProfileImageSuccess extends SocialLayoutStates{}
class SocialUploadProfileImageError extends SocialLayoutStates{}



class SocialCoverImageSuccess extends SocialLayoutStates{}
class SocialCoverImageError extends SocialLayoutStates{}



class SocialUploadCoverImageSuccess extends SocialLayoutStates{}
class SocialUploadCoverImageError extends SocialLayoutStates{}


class SocialUpdateProfileErrorStates extends SocialLayoutStates{}


class SocialLoadingStates extends SocialLayoutStates{}

class SocialPostImageSuccess extends SocialLayoutStates{}
class SocialPostImageError extends SocialLayoutStates{}







//create post
class SocialCreatePostLoadingImage extends SocialLayoutStates{}
class SocialCreatePostImageSuccess extends SocialLayoutStates{}
class SocialCreatePostImageError extends SocialLayoutStates{}




class SocialRemovePostImageError extends SocialLayoutStates{}
class SocialRemoveChatImageError extends SocialLayoutStates{}



//getPosts
class SocialGetPostsLoadingState extends SocialLayoutStates{}
class SocialGetPostsSuccessState extends SocialLayoutStates{}
class SocialGetPostsErrorState extends SocialLayoutStates{
  final String error;

  SocialGetPostsErrorState(this.error);
}




//like Posts
class SocialLikePostsSuccessState extends SocialLayoutStates{}
class SocialLikePostsErrorState extends SocialLayoutStates{
  final String error;

  SocialLikePostsErrorState(this.error);
}


//comments Post
class SocialCommentsPostsSuccessState extends SocialLayoutStates{}
class SocialCommentsPostsErrorState extends SocialLayoutStates{
  final String error;

  SocialCommentsPostsErrorState(this.error);
}




class SocialGetAllUsersLoadingState extends SocialLayoutStates{}
class SocialGetAllUsersSuccessState extends SocialLayoutStates{}
class SocialGetAllUsersErrorState extends SocialLayoutStates{
  final String error;

  SocialGetAllUsersErrorState(this.error);
}


//messages
class SocialSendMessageSuccessState extends SocialLayoutStates{}
class SocialSendMessageErrorState extends SocialLayoutStates{}

class SocialGetMessageSuccessState extends SocialLayoutStates{}


class SocialChatImageSuccess extends SocialLayoutStates{}



class SocialChatImageLoadingImage extends SocialLayoutStates{}
class SocialChatImageError extends SocialLayoutStates{}