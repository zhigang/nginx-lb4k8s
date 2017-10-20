### 版本(Vsersion)
* nginx: 1.13
* confd: 0.14.0

### 使用(How to use)
* Set Backend on `config/confd/confd.toml`
```
backend = "etcdv3"
confdir = "/etc/confd"
interval = 10
nodes = [
  "http://127.0.0.1:2379",
]
```

* Set gateway domain on `config/confd/templates/nginx.tmpl`
```
############## webapi ##############

server {
    listen 80 ;
    server_name gateway.mydomain.com;
    ...
```

* Setting k8s service with annotations

    nginx.gateway.type set 'api', visit it use http://gateway.mydomain.com/service.namespace/service.name or http://gateway.mydomain.com/my_url

    * nginx.gateway.type：api, don't use nginx.gateway.url
    ```
    "annotations": {
        "nginx.gateway.type": "api"
    }
    ```

    * nginx.gateway.type：api, use nginx.gateway.url
    ```
    "annotations": {
        "nginx.gateway.type": "api",
        "nginx.gateway.url": "my_url"
    }
    ```

    * nginx.gateway.type：website, visit it use http://mydomain.com
    ```
    "annotations": {
        "nginx.gateway.type": "wxqy-website",
        "nginx.gateway.domain": "mydomain.com"
    }
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