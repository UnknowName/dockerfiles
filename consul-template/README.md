## 基于Nginx与Consul Template 实现后端自动负载均衡指定服务



### 使用前提:
1.需要Consul自动发现服务，或者服务已经注册到了Consul。</br>
推荐可以同registrator与docker run -e SERVICE_NAME参数实现自动注册服务</br>


### 使用方法:
1.修改app.tmp模板文件，根据真实情况配置service名称，示例中的是tomcat.该服务需要注册在Consul的服务</br>
2.也可以修改nginx.tmp中不完善的地方，如增加location的处理。可以根据实际业务需要额外增加</br>
3.然后就像其他Nginx镜像一样使用即可</br>
