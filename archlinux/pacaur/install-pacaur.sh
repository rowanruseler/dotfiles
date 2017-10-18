#!/bin/bash

source ./lib/common.sh

install_pkg() {
  local pkg=$1; shift

  # query database
  [[ -n "$(pacman -Qs "$pkg")" ]] && { return 0; }


  # download PKGBUILD
  echo
  read -rp ":: Download $pkg build files? [Y/n] " bool
  case "$bool" in
    [nN][oO]|[nN]) return 1 ;;
    *) curl -o PKGBUILD "https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=${pkg}" ;;
  esac
  
  # makepkg
  case "$pkg" in
    cower) makepkg PKGBUILD --skippgpcheck --install --needed ;;
    pacaur) makepkg PKGBUILD --install --needed ;;
  esac
}


main() {
  # install pacaur dependencies
  sudo pacman -S expac yajl --noconfirm --needed

  # setup tmp-working-dir
  setup_workdir
  pushd "$WORKDIR"

  # install cower and pacaur
  aur=(cower pacaur)
  for pkg in "${aur[@]}"; do
    install_pkg "$pkg"
  done

  # clean up tmp-working-dir
  popd >/dev/null
  cleanup
}
main
