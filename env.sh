# Contains useful functions for speeding up uno-q development.

UTIL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

create-sketch() {
  cp -r "$UTIL_DIR/sketch" "$1"
  mv "$1/sketch.ino" "$1/$1.ino"
}

create-app() {
  cp -r "$UTIL_DIR/containers/uno-q-python-template" "$1"
}

create-project() {
  mkdir "$1"
  cp -r "$UTIL_DIR/sketch" "$1/"
  cp -r "$UTIL_DIR/containers/uno-q-python-template" "$1/app"
}

compile() {
  local path="${1:-sketch}"
  arduino-cli compile $path -b arduino:zephyr:unoq --build-path $path/build
}

upload() {
  local path="${1:-sketch}"
  arduino-cli compile $path -b arduino:zephyr:unoq --build-path $path/build -u
}

# Uno-Q only commands.
start-app() {
  local path="${1:-app}"
  local tag="${2:-0.1.0}"
  local name="$(basename "$PWD")"
  docker build -t $name:$tag $path
  docker create --privileged -v /sys/class/leds:/sys/class/leds --name $name $name:$tag
  docker start $name
}

stop-app() {
  local name="$(basename "$PWD")"
  docker stop $name
  docker container remove $name
}

# Local only commands.
sync-up() {
  rsync -az . arduino@uno-q:~/Development/$(basename "$PWD")/
}

sync-down() {
  rsync -az arduino@uno-q:~/Development/$(basename "$PWD")/ .
}
