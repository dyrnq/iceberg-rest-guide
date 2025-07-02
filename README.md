# iceberg-rest-guide

this project is POC of gravitino iceberg-rest-server multi-catalog-support. see <https://gravitino.apache.org/docs/0.9.0-incubating/iceberg-rest-service/#multi-catalog-support>.

run

```bash
./launch.sh
```

see docker-compose.yml,there are two minio(foo- and bar-) and two postgres(foo- and bar-)

```bash
    container_name: foo-minio
    container_name: bar-minio
    container_name: foo-postgres
    container_name: bar-postgres
    container_name: gravitino-iceberg-rest
    container_name: mc
```

```bash
docker compose ps
NAME                     IMAGE                                            COMMAND                  SERVICE                  CREATED          STATUS                    PORTS
bar-minio                minio/minio                                      "/usr/bin/docker-ent…"   bar-minio                17 seconds ago   Up 17 seconds (healthy)   0.0.0.0:9200->9000/tcp, 0.0.0.0:9201->9001/tcp
bar-postgres             postgres:12.14                                   "docker-entrypoint.s…"   bar-postgres             17 seconds ago   Up 17 seconds (healthy)   0.0.0.0:25432->5432/tcp
foo-minio                minio/minio                                      "/usr/bin/docker-ent…"   foo-minio                17 seconds ago   Up 17 seconds (healthy)   0.0.0.0:9000-9001->9000-9001/tcp
foo-postgres             postgres:12.14                                   "docker-entrypoint.s…"   foo-postgres             17 seconds ago   Up 17 seconds (healthy)   0.0.0.0:5432->5432/tcp
gravitino-iceberg-rest   apache/gravitino-iceberg-rest:0.9.0-incubating   "/gravitino-iceberg-…"   gravitino-iceberg-rest   17 seconds ago   Up 6 seconds              0.0.0.0:29001->9001/tcp
mc                       minio/mc                                         "/bin/sh -c ' /usr/b…"   mc                       17 seconds ago   Up 11 seconds             
```


```bash
gravitino.iceberg-rest.foo ---> foo-postgres(db=iceberg_rest) ---> foo-minio/warehouse
gravitino.iceberg-rest.bar ---> bar-postgres(db=iceberg_rest) ---> bar-minio/warehouse
```


spark version [sample/IcebergRestMultiSupportSimple.scala](https://github.com/dyrnq/spark-scala-example/blob/main/src/main/scala/sample/IcebergRestMultiSupportSimple.scala)

flink version [sample/IcebergRestCatalogMultiSupport.scala](https://github.com/dyrnq/flink-coding/blob/main/src/main/scala/sample/IcebergRestCatalogMultiSupport.scala)