#!/bin/sh -eux

# Thank you to https://github.com/timsutton/osx-vm-templates
# for the implementation

# This script adds a Mac OS Launch Daemon, which runs every time the
# machine is booted. The daemon will re-detect the attached network
# interfaces. If this is not done, network devices may not work.
plist=/Library/LaunchDaemons/com.github.timsutton.osx-vm-templates.detectnewhardware.plist;

cat <<PLIST >"$plist";
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.github.timsutton.osx-vm-templates.detectnewhardware</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/sbin/networksetup</string>
        <string>-detectnewhardware</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
PLIST

# These should be already set as follows, but since they're required
# in order to load properly, we set them explicitly.
chmod 644 "$plist";
chown root:wheel "$plist";
