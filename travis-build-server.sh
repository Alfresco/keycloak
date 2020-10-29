#!/bin/bash -e

travis_fold start build_keycloak_server
echo "Starting to build Keycloak server."
( while : ; do echo "Building, please wait..." ; sleep 50 ; done ) &
BUILDING_PID=$!
TMPFILE=`mktemp`
if ! mvn -s $TRAVIS_BUILD_DIR/maven-settings.xml -Pdistribution -pl distribution/server-dist -am -Dmaven.test.skip clean install -Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener=warn &> "$TMPFILE"; then
    cat "$TMPFILE"
    kill $BUILDING_PID
    exit 1
fi
echo "Keycloak server build completed."
kill $BUILDING_PID
travis_fold end build_keycloak_server
