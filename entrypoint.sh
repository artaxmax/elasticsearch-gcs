#!/bin/bash

run_as_other_user_if_needed() {
  if [[ "$(id -u)" == "0" ]]; then
    exec chroot --userspec=1000 / "${@}"
  else
    exec "${@}"
  fi
  

[[ -f /usr/share/elasticsearch/config/elasticsearch.keystore ]] || (run_as_other_user_if_needed elasticsearch-keystore create)
if ! (run_as_other_user_if_needed elasticsearch-keystore list | grep -q '^gcs.client.default.credentials_file$'); then
    chmod 755 /usr/share/elasticsearch/credentials/service-account.json
    chown -R 1000:0 /usr/share/elasticsearch/credentials/service-account.json
    (run_as_other_user_if_needed elasticsearch-keystore add-file -s 'gcs.client.default.credentials_file' '/usr/share/elasticsearch/credentials/service-account.json')
fi
echo 'elasticsearch plugins:'
elasticsearch-plugin list
echo 'elasticsearch keystore:'
elasticsearch-keystore list

/usr/local/bin/docker-entrypoint.sh
