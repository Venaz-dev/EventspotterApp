class Chathistory {
  Chathistory({
    required this.success,
    required this.data,
    required this.message,
  });
  late final bool success;
  late final List<Data> data;
  late final String message;
  
  Chathistory.fromJson(Map<String, dynamic> json){
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
    required this.id,
    required this.fromUser,
    required this.toUser,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.lastDate,
  });
  late final int id;
  late final FromUser fromUser;
  late final ToUser toUser;
  late final String content;
  late final String createdAt;
  late final String updatedAt;
  late final String lastDate;
  
  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    fromUser = FromUser.fromJson(json['from_user']);
    toUser = ToUser.fromJson(json['to_user']);
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastDate = json['last_date'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['from_user'] = fromUser.toJson();
    _data['to_user'] = toUser.toJson();
    _data['content'] = content;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['last_date'] = lastDate;
    return _data;
  }
}

class FromUser {
  FromUser({
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
    required this.profilePicture,
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
  
  FromUser.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name']??"";
    email = json['email']??"";
    ipAddress = json['ip_address']??"";
    latLng = json['lat_lng']??"";
    isOnline = json['is_online']??"";
    phoneNumber = json['phone_number']??"";
    createdAt = json['created_at']??"";
    updatedAt = json['updated_at']??"";
    avatar = json['avatar']??"";
    messengerColor = json['messenger_color']??"";
    darkMode = json['dark_mode']??"";
    activeStatus = json['active_status']??"";
    mobileIsPrivate = json['mobile_is_private']??"";
    role = json['role']??"";
    useLocation = json['use_location'];
    allowDirectMessage = json['allow_direct_message']??"";
    profilePrivate = json['profile_private']??"";
    lastSeen = json['last_seen']??"";

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
    userId = json['user_id']??"";
    createdAt = json['created_at']??"";
    updatedAt = json['updated_at']??"";
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

class ToUser {
  ToUser({
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
  late final ProfilePicture? profilePicture;
  
  ToUser.fromJson(Map<String, dynamic> json){
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
    profilePicture = null;
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
    return _data;
  }
}