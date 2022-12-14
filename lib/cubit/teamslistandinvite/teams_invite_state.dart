part of 'teams_invite_cubit.dart';

@immutable
abstract class GetteamState {}

class GetteamInitial extends GetteamState {}

class GetteamLoading extends GetteamState {}

class GetteamSuccess extends GetteamState {

  List<Contact> teamsandinviteListdata;
  List<Invite> inviteListdata;

  GetteamSuccess(this.teamsandinviteListdata,this.inviteListdata);
}

class GetteamFail extends GetteamState {}




class IvitememberLoading extends GetteamState {}

class IvitememberSuccess extends GetteamState {

  IvitememberSuccess();
}

class IvitememberFail extends GetteamState {
  final String error;
  IvitememberFail(this.error);
}
