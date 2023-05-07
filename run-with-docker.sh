#!/bin/sh
if [ -z $TZ ]; then
  TZ=$(timedatectl --property Timezone --value show 2> /dev/null )
fi
docker run -it --rm --env TZ=$TZ -v $PWD:/bookmark-gen -w /bookmark-gen ruby rake
