import 'package:bloc/bloc.dart';
import 'package:marlo/modals/Getteam_class.dart';
import 'package:meta/meta.dart';
import 'package:result_type/result_type.dart';

import '../repository/getteamsandinviteRepo.dart';

part 'teams_invite_state.dart';

class GetteamCubit extends Cubit<GetteamState> {


  GetteamCubit(this.geteamsAndinvitemember) : super(GetteamInitial());
  final GetTeamview geteamsAndinvitemember;


  Future<void> GetteamGet() async {
    emit(GetteamLoading());
    Result? result = await geteamsAndinvitemember.GetTeams();
    if (result.isSuccess) {


      dynamic resultteamData = result.success["contacts"];
      List<Contact> teamsandinviteListdata = await TeamandinviteList(
        resultteamData,
      );



      dynamic resultinviteData = result.success["invites"];
      List<Invite> inviteListdata = await InviteList(
        resultinviteData,
      );


      emit(GetteamSuccess(teamsandinviteListdata,inviteListdata));
    } else {
      emit(GetteamFail());
    }
  }



  Future<void> InviteNewmember(String email,String role) async {
    emit(IvitememberLoading());
    Result? result = await geteamsAndinvitemember.Invitmember(email,role) ;
    if (result.isSuccess) {


      emit(IvitememberSuccess());
    } else {
      emit(IvitememberFail(result.failure));
    }
  }

}

List<Contact> TeamandinviteList(List data) {
  List<Contact> Teams = [];
  var length = data.length;
  print(length.toString());

  for (int i = 0; i < length; i++) {
    Contact contactTeams =  Contact(

        firstname: data[i]["firstname"],
        lastname: data[i]["lastname"],
        isactive: data[i]["isactive"],
        roleName: data[i]["role_name"],);
    Teams.add(contactTeams);
  }
  return Teams;
}


List<Invite> InviteList(List data) {
  List<Invite> invite = [];
  var length = data.length;
  print(length.toString());

  for (int i = 0; i < length; i++) {
    Invite inviteTeams =  Invite(
      email: data[i]["email"],
      configName: data[i]["config_name"],);
    invite.add(inviteTeams);
  }
  return invite;
}