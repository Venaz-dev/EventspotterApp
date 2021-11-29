class GetUserFollowingStatus {
  GetUserFollowingStatus({
    required this.success,
    required this.data,
    required this.status,
  });
  late final bool success;
  late final Data data;
  late final String status;
  
  GetUserFollowingStatus.fromJson(Map<String, dynamic> json){
    success = json['success'];
    data = Data.fromJson(json['data']);
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.toJson();
    _data['status'] = status;
    return _data;
  }
}

class Data {
  Data({
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
     this.profileImage,
    required this.mobileIsPrivate,
    required this.avatar,
    required this.messengerColor,
    required this.darkMode,
    required this.activeStatus,
    required this.role,
     this.isBlock,
    required this.useLocation,
    required this.allowDirectMessage,
    required this.profilePrivate,
   //required this.address,
    required this.profilePicture,
    required this.followers,
    required this.following,
    required this.events,
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
  late final Null profileImage;
  late final String mobileIsPrivate;
  late final String avatar;
  late final String messengerColor;
  late final String darkMode;
  late final String activeStatus;
  late final String role;
  late final Null isBlock;
  late final String useLocation;
  late final String allowDirectMessage;
  late final String profilePrivate;
  //late final Address address;
   ProfilePicture? profilePicture;
  late final List<dynamic> followers;
  late final List<Following> following;
  late final List<dynamic> events;
  
  Data.fromJson(Map<String, dynamic> json){
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
    profileImage = null;
    mobileIsPrivate = json['mobile_is_private'];
    avatar = json['avatar'];
    messengerColor = json['messenger_color'];
    darkMode = json['dark_mode'];
    activeStatus = json['active_status'];
    role = json['role'];
    isBlock = null;
    useLocation = json['use_location'];
    allowDirectMessage = json['allow_direct_message'];
    profilePrivate = json['profile_private'];
    //address = Address.fromJson(json['address']);

     if (json['profile_picture'] != null) {
      profilePicture = (ProfilePicture.fromJson(json['profile_picture']));
    } else {
      profilePicture = ProfilePicture(
          id: 0, image: "images/user.jpeg", userId: "0", createdAt: "112", updatedAt: "12332");
    }
    followers = List.castFrom<dynamic, dynamic>(json['followers']);
    following = List.from(json['following']).map((e)=>Following.fromJson(e)).toList();
    events = List.castFrom<dynamic, dynamic>(json['events']);
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
    _data['profile_image'] = profileImage;
    _data['mobile_is_private'] = mobileIsPrivate;
    _data['avatar'] = avatar;
    _data['messenger_color'] = messengerColor;
    _data['dark_mode'] = darkMode;
    _data['active_status'] = activeStatus;
    _data['role'] = role;
    _data['is_block'] = isBlock;
    _data['use_location'] = useLocation;
    _data['allow_direct_message'] = allowDirectMessage;
    _data['profile_private'] = profilePrivate;
   // _data['address'] = address.toJson();
    _data['profile_picture'] = profilePicture;
    _data['followers'] = followers;
    _data['following'] = following.map((e)=>e.toJson()).toList();
    _data['events'] = events;
    return _data;
  }
}

class Address {
  Address({
    required this.id,
    required this.address,
    required this.city,
     this.zipCode,
    required this.country,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });
  late final int id;
  late final String address;
  late final String city;
  late final Null zipCode;
  late final String country;
  late final String createdAt;
  late final String updatedAt;
  late final String userId;
  
  Address.fromJson(Map<String, dynamic> json){
    id = json['id'];
    address = json['address'];
    city = json['city'];
    zipCode = null;
    country = json['country'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['address'] = address;
    _data['city'] = city;
    _data['zip_code'] = zipCode;
    _data['country'] = country;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['user_id'] = userId;
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

class Following {
  Following({
    required this.id,
    required this.userId,
    required this.followingId,
    required this.createdAt,
    required this.updatedAt,
    required this.isAccepted,
  });
  late final int id;
  late final String userId;
  late final String followingId;
  late final String createdAt;
  late final String updatedAt;
  late final String isAccepted;
  
  Following.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['user_id'];
    followingId = json['following_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isAccepted = json['is_accepted'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['following_id'] = followingId;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['is_accepted'] = isAccepted;
    return _data;
  }
}