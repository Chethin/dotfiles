-- Add the sketchybar module to the package cpath
package.cpath = package.cpath .. ";/Users/" .. os.getenv("USER") .. "/.local/share/sketchybar_lua/?.so"

os.execute("(cd helpers && make)")

-- os.execute("bash -c '~/.config/sketchybar/helpers/vpn_watcher.sh &'")
