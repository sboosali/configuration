#!/bin/bash
set -e
set -u

########################################
# ①  Bootstrap #########################
########################################

HOME_MANAGER_URI="https://github.com/rycee/home-manager/archive/release-18.03.tar.gz"

# ^ URL, for automatic updates.

########################################

echo '##############################'
echo
command -v git
echo

########################################

echo '##############################'
echo
echo "${HOME_MANAGER_URI}"
echo

########################################
# ②  Configure #########################
########################################

NIXPKGS_CONFIG_D="$HOME"/.config/nixpkgs

HOME_MANAGER_CONFIG="${NIXPKGS_CONFIG_D}"/home.nix

########################################

echo '##############################'
echo
echo "${NIXPKGS_CONFIG_D}"
echo
echo "${HOME_MANAGER_CONFIG}"
echo

########################################

mkdir -p "${NIXPKGS_CONFIG_D}"

#touch "${HOME_MANAGER_CONFIG}"

if   [ ! -f  "${HOME_MANAGER_CONFIG}" ]

then
echo '##############################'
echo
echo "${HOME_MANAGER_CONFIG}"
echo

#TODO# then cat > "${HOME_MANAGER_CONFIG}" <<EOF
#EOF

else
echo '##############################'
echo
cat "${HOME_MANAGER_CONFIG}"
echo
echo '##############################'
echo
nix-instantiate --parse "${HOME_MANAGER_CONFIG}" || true
echo
echo '##############################'
echo
nix-instantiate --eval "${HOME_MANAGER_CONFIG}" || true
echo
fi

########################################
# ③  Install ###########################
########################################

echo '##############################'
echo
command -v nix-shell
echo

########################################

echo '##############################'
echo
nix-shell "${HOME_MANAGER_URI}" -A install
echo

########################################
# ④  Build #############################
########################################

echo '##############################'
echo
command -v home-manager
echo
echo '##############################'
echo
home-manager --help
echo

########################################

# build the example configuration.

#TODO# home-manager build

echo '##############################'
echo

HOME_MANAGER_COMMAND="${1:-build}"

echo "${HOME_MANAGER_COMMAND}"
echo

home-manager "${HOME_MANAGER_COMMAND}"

echo

########################################
# ⑤  Register ##########################
########################################

echo '##############################'
echo
echo <<EOF

export HOME_MANAGER_RC="\$HOME"/.nix-profile/etc/profile.d/hm-session-vars.sh

if   [ -e "\${HOME_MANAGER_RC}" ]
then . "\${HOME_MANAGER_RC}"
fi

EOF
echo

########################################

export HOME_MANAGER_RC="$HOME"/.nix-profile/etc/profile.d/hm-session-vars.sh

echo '##############################'
echo
echo "${HOME_MANAGER_RC}"
echo
. "${HOME_MANAGER_RC}"
echo

########################################
# ⑥  _ #################################
########################################

echo '##############################'
echo

########################################
