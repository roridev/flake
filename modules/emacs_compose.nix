let
  SequenceKey = {
    ctrl = "CTRL";
    shift = "SHIFT";
    meta = "META";
    compose = "COMPOSE";
  };

  # Map special keys to XCompose names
  convertOnce = item:
    if item == SequenceKey.compose then "<Multi_key>"
    else if item == SequenceKey.ctrl then "<Ctrl>"
    else if item == SequenceKey.shift then "<Shift>"
    else if item == SequenceKey.meta then "<Alt>"
    else "<${item}>";

  # Escape double-quotes
  escapeReplacement = s:
    builtins.replaceStrings [ "\"" ] [ "\\\"" ] s;

  # Detect special sequences (C-, S-, M-, <>, \x)
  getSpecial = text: idx:
    let
      cur = builtins.substring idx 1 text;
      nxt = builtins.substring (idx + 1) 1 text;
    in
      if cur == "\\" then
        { value = nxt; consumed = 2; }
      else if cur == "C" && nxt == "-" then
        { value = SequenceKey.ctrl; consumed = 2; }
      else if cur == "S" && nxt == "-" then
        { value = SequenceKey.shift; consumed = 2; }
      else if cur == "M" && nxt == "-" then
        { value = SequenceKey.meta; consumed = 2; }
      else if cur == "<" && nxt == ">" then
        { value = SequenceKey.compose; consumed = 2; }
      else
        null;

  # Recursive parser
  parseKeybind = text:
    let
      len = builtins.stringLength text;

      go = idx:
        if idx >= len then
          []
        else if builtins.substring idx 1 text == " " then
          go (idx + 1)
        else
          let
            special = getSpecial text idx;
          in
            if special != null then
              [ special.value ] ++ go (idx + special.consumed)
            else
              let char = builtins.substring idx 1 text;
              in [ char ] ++ go (idx + 1);
    in go 0;

  # Compose complete XCompose entry
  generateXCompose = custom: replacement:
    let
      tokens = parseKeybind custom;
      converted = map convertOnce tokens;
      keybind = builtins.concatStringsSep " " converted;
      safe = escapeReplacement replacement;
    in "${keybind} : \"${safe}\"";

in
{
  inherit generateXCompose parseKeybind convertOnce SequenceKey;
}
