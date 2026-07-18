# ESP-IDF daily workflow — activate with: get_idf

export IDF_PATH="$HOME/esp/esp-idf"

# Install ESP-IDF from scratch (clones repo + toolchain)
# Usage: esp-setup [target]  — ej: esp-setup esp32 (default: esp32)
esp-setup() {
  local target="${1:-esp32}"
  local esp_dir="${IDF_PATH:h}"
  local idf_dir="$IDF_PATH"

  if [[ -d "$idf_dir/.git" ]]; then
    echo "ESP-IDF ya existe en $idf_dir. Usa esp-update para actualizar."
    return 0
  fi

  echo "Clonando ESP-IDF en $idf_dir..."
  mkdir -p "$esp_dir"
  git clone --recursive https://github.com/espressif/esp-idf.git "$idf_dir"

  echo "Instalando toolchain para $target..."
  (cd "$idf_dir" && ./install.sh "$target")

  echo "Listo. Activa con: get_idf"
}

# Update ESP-IDF (pull + submodules + reinstall toolchain)
# Usage: esp-update [target]  — ej: esp-update all (default: esp32)
esp-update() {
  local target="${1:-esp32}"
  local idf_dir="$IDF_PATH"

  if [[ ! -d "$idf_dir/.git" ]]; then
    echo "ESP-IDF no encontrado. Usa esp-setup primero."
    return 1
  fi

  echo "Actualizando ESP-IDF..."
  git -C "$idf_dir" pull --rebase
  git -C "$idf_dir" submodule update --init --recursive

  echo "Reinstalando toolchain para $target..."
  (cd "$idf_dir" && ./install.sh "$target")

  echo "Actualizacion completa. Activa con: get_idf"
}

# Activate ESP-IDF environment in current shell
get_idf() {
  if [[ -z "$IDF_PYTHON_ENV_PATH" ]]; then
    echo "Activating ESP-IDF..."
    source "$IDF_PATH/export.sh"
    echo "ESP-IDF ready. idf.py, esptool.py, espefuse.py disponibles."
    echo "Puerto USB detectado: $(ls /dev/cu.usbserial-* 2>/dev/null || echo 'ninguno')"
  else
    echo "ESP-IDF ya activo. idf.py version: $(idf.py --version 2>/dev/null)"
  fi
}

# Flash + monitor shortcut (usa puerto detectado o permite override)
idf-flash() {
  local port="${1:-$(ls /dev/cu.usbserial-* 2>/dev/null | head -1)}"
  if [[ -z "$port" ]]; then
    echo "No se detecto puerto USB. Especifica: idf-flash /dev/cu.xxx"
    return 1
  fi
  idf.py -p "$port" flash
}

idf-monitor() {
  local port="${1:-$(ls /dev/cu.usbserial-* 2>/dev/null | head -1)}"
  if [[ -z "$port" ]]; then
    echo "No se detecto puerto USB. Especifica: idf-monitor /dev/cu.xxx"
    return 1
  fi
  idf.py -p "$port" monitor
}

idf-flash-monitor() {
  local port="${1:-$(ls /dev/cu.usbserial-* 2>/dev/null | head -1)}"
  if [[ -z "$port" ]]; then
    echo "No se detecto puerto USB. Especifica: idf-flash-monitor /dev/cu.xxx"
    return 1
  fi
  idf.py -p "$port" flash monitor
}

# Shortcut to check connected chip
esp-info() {
  local port="${1:-$(ls /dev/cu.usbserial-* 2>/dev/null | head -1)}"
  if [[ -z "$port" ]]; then
    echo "No se detecto puerto USB. Especifica: esp-info /dev/cu.xxx"
    return 1
  fi
  python3 "$IDF_PATH/components/esptool_py/esptool/esptool.py" --port "$port" chip_id
}

# Build project
idf-build() {
  idf.py build
}

# Full clean + build
idf-rebuild() {
  idf.py fullclean build
}

# Menuconfig
idf-config() {
  idf.py menuconfig
}

# Size analysis
idf-size() {
  idf.py size
}
