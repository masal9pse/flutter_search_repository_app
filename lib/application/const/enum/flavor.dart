/// フレーバー
enum Flavor {
  dev(arg: 'dev'),
  devStg(arg: 'dev_stg'),
  stg(arg: 'stg'),
  prd(arg: 'prd');

  const Flavor({required this.arg});
  final String arg;
}