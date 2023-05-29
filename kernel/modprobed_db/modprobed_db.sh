#!/bin/sh
# Installed in:
# - /etc/local.d/modprobed_db.stop
# - /etc/cron.hourly/modprobed_db
dir=/etc/kernel/modprobed_db

# Kernel modules
cat /proc/modules | cut -d ' ' -f 1 | grep -Fxvf "$dir/modprobed.db.blacklist" | cat - "$dir/modprobed.db" | sort | uniq > "$dir/.modprobed.db"
mv "$dir/.modprobed.db" "$dir/modprobed.db"

# Kernel firmwares
dmesg | grep -w 'Loading firmware:' | sed -e 's/.*: //' | grep -Fxvf "$dir/firmwared.db.blacklist" | cat - "$dir/firmwared.db" | sort | uniq > "$dir/.firmwared.db"
mv "$dir/.firmwared.db" "$dir/firmwared.db"
