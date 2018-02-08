#!/usr/bin/env bash
set -eo pipefail

function ownAllTheThings {
  ${COMPOSE} ${DO} app chown -R ${USER_ID}:${GROUP_ID} .
}

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
COMPOSE="docker-compose"

# Check if the file with environment variables exists, otherwise copy the default file.
if [ ! -f ${ROOT_DIR}/.env ]; then
  if [ ! -f ${ROOT_DIR}/.env.dist ]; then
    >&2 echo 'Unable to locate .env or .env.dist file'
    exit 1
  fi

  cp ${ROOT_DIR}/.env.dist ${ROOT_DIR}/.env

  # Add current user and group to .env file, with root as fallback.
  echo "" >> ${ROOT_DIR}/.env
  echo "USER_ID=${UID-0}" >> ${ROOT_DIR}/.env
  echo "GROUP_ID=${GROUPS-0}" >> ${ROOT_DIR}/.env
fi
export $(cat ${ROOT_DIR}/.env | xargs)

if [ $# -gt 0 ]; then
  # Check if services are running.
  RUNNING=$(${COMPOSE} ps -q)

  # Either run or exec based on RUNNING var.
  DO="run --rm"
  if [ "${RUNNING}" != "" ]; then
    DO="exec"
  fi

  # Start services.
  if [ "$1" == "up" ]; then
    ${COMPOSE} up -d

    echo ""
    echo "App server running on http://localhost:${APP_PORT}"

  # Build the files.
  elif [ "$1" == "generate" ]; then
    ${COMPOSE} ${DO} app hugo
    ownAllTheThings

  # Setup the application.
  elif [ "$1" == "setup" ]; then
    ${COMPOSE} run --rm app bash -c "
mkdir -p themes
cd themes
rm -rf hugo-theme-docdock
git clone https://github.com/vjeantet/hugo-theme-docdock.git
cd hugo-theme-docdock
git checkout ${HUGO_DOCDOCK_COMMIT_HASH}
" >/dev/null

  # Export the application.
  elif [ "$1" == "export" ]; then
    if [ "$2" != "live" ] && [ "$2" != "staging" ]; then
      echo "Unknown environment '$2' use live or staging"
      exit
    fi
    FILES="public"
    DOMAIN="docs.myparcel.com"
    if [ "$2" == "staging" ]; then
      DOMAIN="staging-${DOMAIN}"
    fi
    ${COMPOSE} ${DO} app hugo --baseURL "https://${DOMAIN}/"
    echo -e "\033[32mexporting \033[0m${FILES}\033[32m to ${DOMAIN}\033[0m"
    tar -czf export.tar.gz ${FILES}
    scp export.tar.gz ubuntu@${DOMAIN}:~/${DOMAIN}/
    rm export.tar.gz

  else
    ${COMPOSE} "$@"
  fi
else
  ${COMPOSE} ps
fi
