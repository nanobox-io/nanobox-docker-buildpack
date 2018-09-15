# For Heroku emulation, we need to export a DATABASE_URL
# 
# Fortunately, heroku is pretty simple and most apps are
# assumed to have a single database, either postgres or
# mysql. Since Nanobox is much more flexible than Heroku,
# we need to make a few assumptions to dumb it down for
# heroku emulation. We are going to assume that if they're
# trying to run a heroku-like app, then they will have
# added a database and named it postgres, or mysql.
# If either of those are true, we'll export them as the
# database_url

if [ -z "$DATABASE_URL" ]; then

  if [ -n "$POSTGRES_HOST" ]; then
    export DATABASE_URL="postgres://${POSTGRES_USER}:${POSTGRES_PASS}@${POSTGRES_HOST}/gonano"
  elif [ -n "$MYSQL_HOST" ] ; then
    
    # if this is rails and using the mysql2 gem, let's use that schema
    if [ -f /app/Gemfile.lock ]; then
      if grep 'mysql2' /app/Gemfile.lock; then
        export DATABASE_URL="mysql2://${MYSQL_USER}:${MYSQL_PASS}@${MYSQL_HOST}/gonano"
      fi
    fi
    
    if [ -z "$DATABASE_URL" ]; then
      export DATABASE_URL="mysql://${MYSQL_USER}:${MYSQL_PASS}@${MYSQL_HOST}/gonano"
    fi
  fi
fi
