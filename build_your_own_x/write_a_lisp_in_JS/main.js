function lexer(input) {
  let pos = 0

  function next() {
    if (pos < input.length) {
      return input.charAt(pos++)
    }
    return null
  }
  function rewind() {
    pos--
  }

  function string() {
    let token = next()
    let c

    while ((c = next()) != null) {
      if (c == '"') {
        return token + c
      }
      token = token + c
    }
    return token
  }

}
