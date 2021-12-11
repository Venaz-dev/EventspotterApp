// class EventsModel {
//   EventsModel({
//     required this.success,
//     required this.data,
//     required this.message,
//   });
//   late final bool success;
//   late final List<Data> data;
//   late final String message;

//   EventsModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
//     message = json['message'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['success'] = success;
//     _data['data'] = data.map((e) => e.toJson()).toList();
//     _data['message'] = message;
//     return _data;
//   }
// }

// class Data {
//   Data({
//     required this.events,
//     //this.livefeed,
//     required this.km,
//     required this.isFavroute,
//     required this.Following,
//     required this.isLiked,
//     required this.totalLikes,
//   });
//   late final Events events;
//   // late final Livefeed? livefeed;
//   late final String km;
//   late final int isFavroute;
//   late final int Following;
//   late final int isLiked;
//   late final int totalLikes;

//   Data.fromJson(Map<String, dynamic> json) {
//     events = Events.fromJson(json['events']);
//     //livefeed = null;
//     km = json['km'];
//     isFavroute = json['isFavroute'];
//     Following = json['Following'];
//     isLiked = json['isLiked'];
//     totalLikes = json['totalLikes'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['events'] = events.toJson();
//     //  _data['livefeed'] = livefeed;
//     _data['km'] = km;
//     _data['isFavroute'] = isFavroute;
//     _data['Following'] = Following;
//     _data['isLiked'] = isLiked;
//     _data['totalLikes'] = totalLikes;
//     return _data;
//   }
// }

// class Events {
//   Events({
//     required this.id,
//     required this.eventName,
//     required this.eventDescription,
//     required this.eventType,
//     required this.eventDate,
//     required this.location,
//     required this.lat,
//     required this.lng,
//     required this.conditions,
//     required this.userId,
//     required this.isPublic,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.isDrafted,
//     this.ticketLink,
//     required this.eventPictures,
//     required this.user,
//     required this.comment,
//     required this.liveFeed,
//   });
//   late final int id;
//   late final String eventName;
//   late final String eventDescription;
//   late final String eventType;
//   late final String eventDate;
//   late final String location;
//   late final String lat;
//   late final String lng;
//   late final List<String> conditions;
//   late final String userId;
//   late final String isPublic;
//   late final String createdAt;
//   late final String updatedAt;
//   late final String isDrafted;
//   String? ticketLink;
//   late final List<EventPictures> eventPictures;
//   late final User user;
//   late final List<Comment> comment;
//   late final List<LiveFeed> liveFeed;

//   Events.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     eventName = json['event_name'];
//     eventDescription = json['event_description'];
//     eventType = json['event_type'];
//     eventDate = json['event_date'];
//     location = json['location'];
//     lat = json['lat'];
//     lng = json['lng'];
//     conditions = List.castFrom<dynamic, String>(json['conditions']);
//     userId = json['user_id'];
//     isPublic = json['is_public'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     isDrafted = json['is_drafted'];
//     ticketLink = json['ticket_link'] ?? 'noLink';

//     eventPictures = List.from(json['event_pictures'])
//         .map((e) => EventPictures.fromJson(e))
//         .toList();
//     user = User.fromJson(json['user']);
//     comment =
//         List.from(json['comment']).map((e) => Comment.fromJson(e)).toList();
//     liveFeed =
//         List.from(json['live_feed']).map((e) => LiveFeed.fromJson(e)).toList();
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['event_name'] = eventName;
//     _data['event_description'] = eventDescription;
//     _data['event_type'] = eventType;
//     _data['event_date'] = eventDate;
//     _data['location'] = location;
//     _data['lat'] = lat;
//     _data['lng'] = lng;
//     _data['conditions'] = conditions;
//     _data['user_id'] = userId;
//     _data['is_public'] = isPublic;
//     _data['created_at'] = createdAt;
//     _data['updated_at'] = updatedAt;
//     _data['is_drafted'] = isDrafted;
//     _data['ticket_link'] = ticketLink;
//     _data['event_pictures'] = eventPictures.map((e) => e.toJson()).toList();
//     _data['user'] = user.toJson();
//     _data['comment'] = comment.map((e) => e.toJson()).toList();
//     _data['live_feed'] = liveFeed.map((e) => e.toJson()).toList();
//     return _data;
//   }
// }

// class EventPictures {
//   EventPictures({
//     required this.id,
//     required this.eventId,
//     required this.imagePath,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//   late final int id;
//   late final String eventId;
//   late final String imagePath;
//   late final String createdAt;
//   late final String updatedAt;

//   EventPictures.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     eventId = json['event_id'];
//     imagePath = json['image_path'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['event_id'] = eventId;
//     _data['image_path'] = imagePath;
//     _data['created_at'] = createdAt;
//     _data['updated_at'] = updatedAt;
//     return _data;
//   }
// }

// class User {
//   User({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.ipAddress,
//     required this.latLng,
//     required this.isOnline,
//     // this.emailVerifiedAt,
//     required this.phoneNumber,
//     required this.createdAt,
//     required this.updatedAt,
//     //  this.profileImage,
//     required this.mobileIsPrivate,
//     required this.avatar,
//     required this.messengerColor,
//     required this.darkMode,
//     required this.activeStatus,
//     required this.role,
//     // this.isBlock,
//     required this.useLocation,
//     required this.profilePrivate,
//     this.profilePicture,
//     required this.followers,
//   });
//   late final int id;
//   late final String name;
//   late final String email;
//   late final String ipAddress;
//   late final String latLng;
//   late final String isOnline;
//   late final Null emailVerifiedAt;
//   late final String phoneNumber;
//   late final String createdAt;
//   late final String updatedAt;
//   late final Null profileImage;
//   late final String mobileIsPrivate;
//   late final String avatar;
//   late final String messengerColor;
//   late final String darkMode;
//   late final String activeStatus;
//   late final String role;
//   late final Null isBlock;
//   late final String useLocation;
//   late final String profilePrivate;
//   ProfilePicture? profilePicture;
//   late final List<Followers> followers;

//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     ipAddress = json['ip_address'];
//     latLng = json['lat_lng'];
//     isOnline = json['is_online'];
//     //  emailVerifiedAt = null;
//     phoneNumber = json['phone_number'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     // profileImage = null;
//     mobileIsPrivate = json['mobile_is_private'];
//     avatar = json['avatar'];
//     messengerColor = json['messenger_color'];
//     darkMode = json['dark_mode'];
//     activeStatus = json['active_status'];
//     role = json['role'];
//     // isBlock = null;
//     useLocation = json['use_location'];
//     profilePrivate = json['profile_private'];

//     if (json['profile_picture'] != null) {
//       profilePicture = (ProfilePicture.fromJson(json['profile_picture']));
//     } else {
//       profilePicture = ProfilePicture(
//           id: 0,
//           image: "images/user.jpeg",
//           userId: "0",
//           createdAt: "112",
//           updatedAt: "12332");
//     }
//     followers =
//         List.from(json['followers']).map((e) => Followers.fromJson(e)).toList();
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['name'] = name;
//     _data['email'] = email;
//     _data['ip_address'] = ipAddress;
//     _data['lat_lng'] = latLng;
//     _data['is_online'] = isOnline;
//     _data['email_verified_at'] = emailVerifiedAt;
//     _data['phone_number'] = phoneNumber;
//     _data['created_at'] = createdAt;
//     _data['updated_at'] = updatedAt;
//     _data['profile_image'] = profileImage;
//     _data['mobile_is_private'] = mobileIsPrivate;
//     _data['avatar'] = avatar;
//     _data['messenger_color'] = messengerColor;
//     _data['dark_mode'] = darkMode;
//     _data['active_status'] = activeStatus;
//     _data['role'] = role;
//     _data['is_block'] = isBlock;
//     _data['use_location'] = useLocation;
//     _data['profile_private'] = profilePrivate;
//     _data['profile_picture'] = profilePicture;
//     _data['followers'] = followers.map((e) => e.toJson()).toList();
//     return _data;
//   }
// }

// class ProfilePicture {
//   ProfilePicture({
//     required this.id,
//     required this.image,
//     required this.userId,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//   late final int id;
//   late final String? image;
//   late final String userId;
//   late final String createdAt;
//   late final String updatedAt;

//   ProfilePicture.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     image = json['image'];
//     userId = json['user_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['image'] = image;
//     _data['user_id'] = userId;
//     _data['created_at'] = createdAt;
//     _data['updated_at'] = updatedAt;
//     return _data;
//   }
// }

// class Followers {
//   Followers({
//     required this.id,
//     required this.userId,
//     required this.followerId,
//     required this.followingId,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//   late final int id;
//   late final String userId;
//   late final String followerId;
//   late final String followingId;
//   late final String createdAt;
//   late final String updatedAt;

//   Followers.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     followerId = json['follower_id'];
//     followingId = json['following_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['user_id'] = userId;
//     _data['follower_id'] = followerId;
//     _data['following_id'] = followingId;
//     _data['created_at'] = createdAt;
//     _data['updated_at'] = updatedAt;
//     return _data;
//   }
// }

// class Comment {
//   Comment({
//     required this.id,
//     required this.eventId,
//     required this.userId,
//     required this.comment,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//   late final int id;
//   late final String eventId;
//   late final String userId;
//   late final String comment;
//   late final String createdAt;
//   late final String updatedAt;

//   Comment.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     eventId = json['event_id'];
//     userId = json['user_id'];
//     comment = json['comment'] ?? "hi";
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['event_id'] = eventId;
//     _data['user_id'] = userId;
//     _data['comment'] = comment;
//     _data['created_at'] = createdAt;
//     _data['updated_at'] = updatedAt;
//     return _data;
//   }
// }

// class LiveFeed {
//   LiveFeed({
//     required this.id,
//     required this.eventId,
//     required this.userId,
//     required this.path,
//     this.description,
//     this.tagPeople,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//   late final int id;
//   late final String eventId;
//   late final String userId;
//   late final String path;
//   late final Null description;
//   late final Null tagPeople;
//   late final String createdAt;
//   late final String updatedAt;

//   LiveFeed.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     eventId = json['event_id'];
//     userId = json['user_id'];
//     path = json['path'];
//     // description = null;
//     /// tagPeople = null;
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['event_id'] = eventId;
//     _data['user_id'] = userId;
//     _data['path'] = path;
//     //_data['description'] = description;
//     //  _data['tag_people'] = tagPeople;
//     _data['created_at'] = createdAt;
//     _data['updated_at'] = updatedAt;
//     return _data;
//   }
// }

// class Livefeed {
//   Livefeed({
//     required this.id,
//     required this.eventId,
//     required this.userId,
//     required this.path,
//     this.description,
//     this.tagPeople,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//   late final int id;
//   late final String eventId;
//   late final String userId;
//   late final String path;
//   late final Null description;
//   late final Null tagPeople;
//   late final String createdAt;
//   late final String updatedAt;

//   Livefeed.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     eventId = json['event_id'];
//     userId = json['user_id'];
//     path = json['path'];
//     description = null;
//     tagPeople = null;
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['event_id'] = eventId;
//     _data['user_id'] = userId;
//     _data['path'] = path;
//     _data['description'] = description;
//     _data['tag_people'] = tagPeople;
//     _data['created_at'] = createdAt;
//     _data['updated_at'] = updatedAt;
//     return _data;
//   }
// }
class EventsModel {
  EventsModel({
    required this.success,
    required this.data,
    required this.message,
  });
  late final bool success;
  late final List<Data> data;
  late final String message;
  
  EventsModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.events,
     this.livefeed,
    required this.km,
    required this.isFavroute,
    required this.Following,
    required this.isLiked,
    required this.totalLikes,
  });
  late final Events events;
  late final Null livefeed;
  late final String km;
  late final int isFavroute;
  late final int Following;
  late final int isLiked;
  late final int totalLikes;
  
  Data.fromJson(Map<String, dynamic> json){
    events = Events.fromJson(json['events']);
    livefeed = null;
    km = json['km'];
    isFavroute = json['isFavroute'];
    Following = json['Following'];
    isLiked = json['isLiked'];
    totalLikes = json['totalLikes'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['events'] = events.toJson();
    _data['livefeed'] = livefeed;
    _data['km'] = km;
    _data['isFavroute'] = isFavroute;
    _data['Following'] = Following;
    _data['isLiked'] = isLiked;
    _data['totalLikes'] = totalLikes;
    return _data;
  }
}

class Events {
  Events({
    required this.id,
    required this.eventName,
    required this.eventDescription,
    required this.eventType,
    required this.eventDate,
    required this.location,
    required this.lat,
    required this.lng,
    required this.conditions,
    required this.userId,
    required this.isPublic,
    required this.createdAt,
    required this.updatedAt,
    required this.isDrafted,
     this.ticketLink,
    required this.eventPictures,
    required this.user,
    required this.comment,
    required this.liveFeed,
  });
  late final int id;
  late final String eventName;
  late final String eventDescription;
  late final String eventType;
  late final String eventDate;
  late final String location;
  late final String lat;
  late final String lng;
  late final List<String> conditions;
  late final String userId;
  late final String isPublic;
  late final String createdAt;
  late final String updatedAt;
  late final String isDrafted;
  late final String? ticketLink;
  late final List<EventPictures> eventPictures;
  late final User user;
  late final List<Comment> comment;
  late final List<LiveFeed> liveFeed;
  
  Events.fromJson(Map<String, dynamic> json){
    id = json['id'];
    eventName = json['event_name'];
    eventDescription = json['event_description'];
    eventType = json['event_type'];
    eventDate = json['event_date'];
    location = json['location'];
    lat = json['lat'];
    lng = json['lng'];
    conditions = List.castFrom<dynamic, String>(json['conditions']);
    userId = json['user_id'];
    isPublic = json['is_public'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isDrafted = json['is_drafted'];
    ticketLink = json['ticket_link']??"";
    eventPictures = List.from(json['event_pictures']).map((e)=>EventPictures.fromJson(e)).toList();
    user = User.fromJson(json['user']);
    comment = List.from(json['comment']).map((e)=>Comment.fromJson(e)).toList();
   liveFeed =
   List.from(json['live_feed']).map((e) => LiveFeed.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['event_name'] = eventName;
    _data['event_description'] = eventDescription;
    _data['event_type'] = eventType;
    _data['event_date'] = eventDate;
    _data['location'] = location;
    _data['lat'] = lat;
    _data['lng'] = lng;
    _data['conditions'] = conditions;
    _data['user_id'] = userId;
    _data['is_public'] = isPublic;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['is_drafted'] = isDrafted;
    _data['ticket_link'] = ticketLink;
    _data['event_pictures'] = eventPictures.map((e)=>e.toJson()).toList();
    _data['user'] = user.toJson();
    _data['comment'] = comment.map((e)=>e.toJson()).toList();
     _data['live_feed'] = liveFeed.map((e) => e.toJson()).toList();
    return _data;
  }
}

class EventPictures {
  EventPictures({
    required this.id,
    required this.eventId,
    required this.imagePath,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String eventId;
  late final String imagePath;
  late final String createdAt;
  late final String updatedAt;
  
  EventPictures.fromJson(Map<String, dynamic> json){
    id = json['id'];
    eventId = json['event_id'];
    imagePath = json['image_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['event_id'] = eventId;
    _data['image_path'] = imagePath;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.ipAddress,
    required this.latLng,
    required this.isOnline,
     this.emailVerifiedAt,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.avatar,
    required this.messengerColor,
    required this.darkMode,
    required this.activeStatus,
     this.profileImage,
    required this.mobileIsPrivate,
    required this.role,
     this.isBlock,
    required this.useLocation,
    required this.allowDirectMessage,
    required this.profilePrivate,
    required this.lastSeen,
     this.profilePicture,
    required this.followers,
  });
  late final int id;
  late final String name;
  late final String email;
  late final String ipAddress;
  late final String latLng;
  late final String isOnline;
  late final Null emailVerifiedAt;
  late final String phoneNumber;
  late final String createdAt;
  late final String updatedAt;
  late final String avatar;
  late final String messengerColor;
  late final String darkMode;
  late final String activeStatus;
  late final Null profileImage;
  late final String mobileIsPrivate;
  late final String role;
  late final Null isBlock;
  late final String useLocation;
  late final String allowDirectMessage;
  late final String profilePrivate;
  late final String lastSeen;
   ProfilePicture? profilePicture;
  late final List<Followers> followers;
  
  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    ipAddress = json['ip_address'];
    latLng = json['lat_lng'];
    isOnline = json['is_online'];
    emailVerifiedAt = null;
    phoneNumber = json['phone_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    avatar = json['avatar'];
    messengerColor = json['messenger_color'];
    darkMode = json['dark_mode'];
    activeStatus = json['active_status'];
    profileImage = null;
    mobileIsPrivate = json['mobile_is_private'];
    role = json['role'];
    isBlock = null;
    useLocation = json['use_location'];
    allowDirectMessage = json['allow_direct_message'];
    profilePrivate = json['profile_private'];
    lastSeen = json['last_seen'];
     if (json['profile_picture'] != null) {
      profilePicture = (ProfilePicture.fromJson(json['profile_picture']));
    } else {
      profilePicture = ProfilePicture(
          id: 0,
          image: "images/user.jpeg",
          userId: "0",
          createdAt: "112",
          updatedAt: "12332");
    }
    followers = List.from(json['followers']).map((e)=>Followers.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['ip_address'] = ipAddress;
    _data['lat_lng'] = latLng;
    _data['is_online'] = isOnline;
    _data['email_verified_at'] = emailVerifiedAt;
    _data['phone_number'] = phoneNumber;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['avatar'] = avatar;
    _data['messenger_color'] = messengerColor;
    _data['dark_mode'] = darkMode;
    _data['active_status'] = activeStatus;
    _data['profile_image'] = profileImage;
    _data['mobile_is_private'] = mobileIsPrivate;
    _data['role'] = role;
    _data['is_block'] = isBlock;
    _data['use_location'] = useLocation;
    _data['allow_direct_message'] = allowDirectMessage;
    _data['profile_private'] = profilePrivate;
    _data['last_seen'] = lastSeen;
    _data['profile_picture'] = profilePicture;
    _data['followers'] = followers.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class ProfilePicture {
  ProfilePicture({
    required this.id,
    required this.image,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String image;
  late final String userId;
  late final String createdAt;
  late final String updatedAt;
  
  ProfilePicture.fromJson(Map<String, dynamic> json){
    id = json['id'];
    image = json['image'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['image'] = image;
    _data['user_id'] = userId;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}

class Followers {
  Followers({
    required this.id,
    required this.userId,
    required this.followerId,
    required this.followingId,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String userId;
  late final String followerId;
  late final String followingId;
  late final String createdAt;
  late final String updatedAt;
  
  Followers.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['user_id'];
    followerId = json['follower_id'];
    followingId = json['following_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['follower_id'] = followerId;
    _data['following_id'] = followingId;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}

class Comment {
  Comment({
    required this.id,
    required this.eventId,
    required this.userId,
     required this.comment,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });
  late final int id;
  late final String eventId;
  late final String? userId;
  late final String? comment;
  late final String? createdAt;
  late final String updatedAt;
  late final User user;
  
  Comment.fromJson(Map<String, dynamic> json){
    id = json['id'];
    eventId = json['event_id']??"";
    userId = json['user_id']??"";
    comment = json['comment']??"";
    createdAt = json['created_at']??"";
    updatedAt = json['updated_at']??"";
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['event_id'] = eventId;
    _data['user_id'] = userId;
    _data['comment'] = comment;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['user'] = user.toJson();
    return _data;
  }
}
class LiveFeed {
  LiveFeed({
    required this.id,
    required this.eventId,
    required this.userId,
    required this.path,
    this.description,
    this.tagPeople,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String eventId;
  late final String userId;
  late final String path;
  late final Null description;
  late final Null tagPeople;
  late final String createdAt;
  late final String updatedAt;

  LiveFeed.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventId = json['event_id'];
    userId = json['user_id'];
    path = json['path'];
    // description = null;
    /// tagPeople = null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['event_id'] = eventId;
    _data['user_id'] = userId;
    _data['path'] = path;
    //_data['description'] = description;
    //  _data['tag_people'] = tagPeople;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}