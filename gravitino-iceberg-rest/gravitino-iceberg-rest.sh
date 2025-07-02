#!/usr/bin/env bash

gravitino_home="/root/gravitino-iceberg-rest-server"
if [ -e "${gravitino_home}"/libs ]; then
pushd "${gravitino_home}"/libs || exit 1
# wget --continue https://repo.maven.apache.org/maven2/org/apache/iceberg/iceberg-aws-bundle/1.5.2/iceberg-aws-bundle-1.5.2.jar
# wget --continue https://repo.maven.apache.org/maven2/org/postgresql/postgresql/42.7.4/postgresql-42.7.4.jar
#iceberg_ver="$(ls -1 iceberg-aws-[1-10]*.jar | head -n 1 | grep -oP '\d+(\.\d+)+')"
iceberg_ver="$(find . -maxdepth 1 -type f -name 'iceberg-aws-[1-9]*.jar' | head -n 1 | grep -oP '\d+(\.\d+)+')"
echo "iceberg_ver=${iceberg_ver}"
wget --continue https://maven.aliyun.com/repository/public/org/apache/iceberg/iceberg-aws-bundle/"${iceberg_ver}"/iceberg-aws-bundle-"${iceberg_ver}".jar
wget --continue https://maven.aliyun.com/repository/public/org/postgresql/postgresql/42.7.4/postgresql-42.7.4.jar
popd || exit 1
fi

pwd;

exec ${gravitino_home}/bin/gravitino-iceberg-rest-server.sh run