{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.keymap = {pkgs, ...}: {
    services.kanata = {
      enable = true;
      keyboards = {
        "elowen" = {
          config = ''
            (defsrc
              grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
              caps a    s    d    f    g    h    j    k    l    ;    '    ret
              lsft z    x    c    v    b    n    m    ,    .    /    rsft
              lctl lmet lalt muhenkan spc henkan ralt rmet rctl
            )

            (defalias
              cap (tap-hold-press 200 200 esc lctl)
              mh  (layer-while-held muhenkan)
            )

            (deflayer default
              grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
              @cap a    s    d    f    g    h    j    k    l    ;    '    ret
              lsft z    x    c    v    b    n    m    ,    .    /    rsft
              lctl lmet lalt   @mh    spc    @rom   ralt rmet rctl
            )

            (deflayer muhenkan
              _    _    _    _    _    _    _    _    _    _    _    _    _    _
              ret  _    up   _    _    _    _    _    _    _    _    _    _    _
              _    left down rght _    _    left down up   rght _    _    _
              _    _    _    _    _    _    _    _    _    _    _    _
              _    _    _    _    _    _    _    _    _
            )

            (defalias
              rom (layer-while-held romanian)
              ă (fork (unicode ă) (unicode Ă) (lsft rsft))
              ș (fork (unicode ș) (unicode Ș) (lsft rsft))
              ț (fork (unicode ț) (unicode Ț) (lsft rsft))
              î (fork (unicode î) (unicode Î) (lsft rsft))
            )
            (deflayer romanian
              _    _    _    _    _    _    _    _    _    _    _    _    _    _
              _    _    _    _    _    @ț   _    _    @î   _    _    _    _    _
              _    @ă   @ș   _    _    _    _    _    _    _    _    _    _
              _    _    _    _    _    _    _    _    _    _    _    _
              _    _    _    _    _    _    _    _    _
            )
          '';
        };
      };
    };
  };
}
