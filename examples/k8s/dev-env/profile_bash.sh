# DADE shell profile for bash

export DADE_REPO_ROOT="$(cd $(dirname "${BASH_SOURCE[0]}")/.. ; pwd)"
source /dev/stdin <<< "$(${DADE_REPO_ROOT}/dev-env/bin/dade assist)"
