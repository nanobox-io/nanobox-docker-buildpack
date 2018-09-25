# For Heroku emulation, we need to export a REDIS_URL
# 

if [ -z "$REDIS_URL" ]; then
  if [[ -n "$REDIS_HOST" ]]; then
    export REDIS_URL="redis://${REDIS_HOST}/1"
  fi
fi
