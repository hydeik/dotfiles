{
  flake.modules.darwin.desktop = {
    system = {
      defaults.NSGlobalDomain = {
        # Use F1, F2, etc. keys as standard function keys.
        "com.apple.keyboard.fnState" = true;

        # Mode 3 enables full keyboard control.
        AppleKeyboardUIMode = 3;

        # Whether to enable the press-and-hold feature. The default is true.
        # true => Holding a keyboard key down will bring up a character modification menu.
        # false => When holging a keyboard key down, the key's character brings to repeat.
        ApplePressAndHoldEnabled = false;

        # If you press and hold certain keyboard keys when in a text area,
        # the key’s character begins to repeat. For example, the Delete key
        # continues to remove text for as long as you hold it down.

        # This sets how long you must hold down the key before it starts repeating.
        # [normal minimum is 15 (225 ms), maximum is 120 (1800 ms).]
        InitialKeyRepeat = 15;

        # This sets how fast it repeats once it starts.
        KeyRepeat = 3;
      };
    };
  };
}
