# logCollect 日志收集服务

[![travis-ci](https://travis-ci.com/hzde0128/logCollect.svg?branch=master)](https://travis-ci.com/github/hzde0128/logCollect) [![Code Grade](https://www.code-inspector.com/project/4797/status/svg)](https://frontend.code-inspector.com/public/project/4797/logAgent/dashboard) [![Code Quality Score](https://www.code-inspector.com/project/4797/score/svg)](https://frontend.code-inspector.com/public/project/4797/logAgent/dashboard) [![Go Report Card](https://goreportcard.com/badge/github.com/hzde0128/logCollect)](https://goreportcard.com/report/github.com/hzde0128/logCollect)

## 软件架构

![architecture](images/architecture.jpg)

---
说明

通过在运维平台上配置日志收集项，logAgent从etcd中获取要收集的日志信息从业务服务器读取日志信息，发往kafka，logTransfer负责从kafka读取日志，写入到Elasticsearch中，通过Kibana进行日志检索。系统性能数据的收集有Node_Exporter进行采集，Prometheus拉取入库，将告警信息推给AlertManager，最后通过Grafana进行可视化展示。

---

快速开发环境

使用docker-compose快速部署开发环境

```yaml
version: "3"

networks:
  app-kafka:
    driver: bridge

services:
  zookeeper:
    container_name: zookeeper
    image: zookeeper:3.4.14
    restart: always
    networks:
      - app-kafka
  kafka:
    container_name: kafka
    image: bitnami/kafka:2.4.0
    restart: always
    environment: 
      - KAFKA_CFG_ZOOKEEPER_CONNECT=zookeeper:2181
      - ALLOW_PLAINTEXT_LISTENER=yes
      # 后面三条是暴露给外网使用
      - KAFKA_CFG_LISTENER_SECURITY_PROTOCOL_MAP=PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT
      - KAFKA_CFG_LISTENERS=PLAINTEXT://:9092,PLAINTEXT_HOST://:29092
      - KAFKA_CFG_ADVERTISED_LISTENERS=PLAINTEXT://kafka:9092,PLAINTEXT_HOST://localhost:29092
    ports:
    - 127.0.0.1:9092:9092
      # 外网使用29092进行访问
    - 127.0.0.1:29092:29092
    networks:
      - app-kafka
```

## v0.1.0版本实现的功能

- 读取日志文件

- 写入到kafka中

- 可以自行配置要收集的日志文件

## v0.2.0版本实现的功能

- 从etcd中获取日志收集项

- logAgent可以同时运行多个日志收集任务

- 实现实时配置项变更

- 根据当前服务器的IP地址获取配置项

## v0.3.0版本增加logTransfer服务

- 实现日志入库到ES

- 使用第三方日志框架logrus保存日志

- 支持日志文件切割

- 加入消费组，支持多个topic

- tail包从上次读取的位置开始读

## v0.4.0版本增加logManager服务

logManager是有Beego框架搭建起来的web服务，主要是为了方便管理日志收集项

- 从后台界面添加主机和日志收集项

- Cookie和Session实现

- 后台访问鉴权

- CURD增删改查操作完成

## v0.5.0版本logManager优化

- 使用redis进行缓存

- 实现从logManager进行添加/删除/修改日志收集项

- logAgent获取logManager界面增删改的收集项

## 开发计划

- [x] logManager使用redis进行缓存

- [x] logManager添加收集项之后将配置发给etcd

- [x] logAgent从etcd获取到收集项进行收集并监听变更

- [ ] logTransfer从etcd获取配置写ES

![logManager-login](images/logmanager_login.png)

![logManager-dashboard](images/logmanager_dashboard.png)

![logManager-host](images/logmanager_host.png)

## 配套教程

[Go运维开发之日志收集（1）收集应用程序到kafka中](https://huangzhongde.cn/post/2020-03-03-golang_devops_logAgent_1_write_log_to_kafka/)

[Go运维开发之日志收集（2）从etcd中获取配置信息](https://huangzhongde.cn/post/2020-03-04-golang_devops_logAgent_2_get_config_from_etcd/)

[Go运维开发之日志收集（3）根据etcd配置项创建多个tailTask](https://huangzhongde.cn/post/2020-03-04-golang_devops_logAgent_3_get_config_from_etcd_create_tailtask/)

[Go运维开发之日志收集（4）监视etcd配置项的变更](https://huangzhongde.cn/post/2020-03-04-golang_devops_logAgent_4_watch_config_from_etcd/)

[Go运维开发之日志收集（5）根据IP地址去拉取配置日志收集项](https://huangzhongde.cn/post/2020-03-04-golang_devops_logAgent_5_get_conf_adapter_ipaddr/)

[Go运维开发之日志收集（6）从kafka中获取日志信息](https://huangzhongde.cn/post/2020-03-05-golang_devops_logAgent_6_get_data_from_kafka/)

[Go运维开发之日志收集（7）将日志入库到Elasticsearch并通过Kibana进行展示](https://huangzhongde.cn/post/2020-03-05-golang_devops_logAgent_7_write_to_es/)

[Go运维开发之日志收集（8）将应用程序日志写入到文件中](https://huangzhongde.cn/post/2020-03-05-golang_devops_logAgent_8_with_logrus/)

[Go运维开发之日志收集（9）logTransfer支持多个Topic](https://huangzhongde.cn/post/2020-03-10-golang_devops_logAgent_9_kafka_consumer_group_multi_topics/)
