extension EnumFormatter on List{
  List<String> fromEnum(){
    return map<String>((e) => e.name).toList();
  }
}