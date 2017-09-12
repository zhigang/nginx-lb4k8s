### 环境变量（Environment）

* BACKEND_KIND

```
BACKEND_KIND=etcdv3
```

* ETCD_URL

```
ETCD_URL=http://127.0.0.1:2379
```

### 常用命令(Command)

* ETCD V3 Get Keys

```
ETCDCTL_API=3 etcdctl --endpoints="http://127.0.0.1:2379" get /registry/services --prefix --keys-only
```

* confd command

```
confd -onetime -backend etcdv3 -node http://127.0.0.1:2379 -config-file /etc/confd/conf.d/nginx.toml;
```