enum ResponseType {
  useDefinedInMethod(90000),
  c200ok(200),
  c201created(201),
  c202accepted(202),
  c401unautorized(401),
  c404notFound(404),
  ;

  const ResponseType(this.code);

  final int code;
}
