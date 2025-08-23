# For newer versions, what to change:

First copy the template to the right folder:
```
cp /usr/share/pipewire/pipewire.conf .config/pipewire/
```

Go to ~/.config/pipewire/pipwire.conf and adjust the following rules:
```
default.clock.rate = 96000
default.clock.allowed-rates = [ 48000 88200 96000 176400 19200 352800 384000 ]
default.clock.quantum       = 1024
default.clock.quantum-limit = 8192
default.audio.format = S32LE
```

Then restart:

```
systemctl -- user restart pipewire pipewire-pulse wireplumber
```

Best to restart your PC aswell.
