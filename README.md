# dynip2hosts
save dynamic IP to /etc/hosts for easy  http request

Our  server connect to vpn server customer for access to inftasructure. We not have access to customer vpn-server. We need  get currect vpn IP-client for reverse tcp connection with
him it has make for client with ppp connection and to connect client for actual grey vpn-IP.

Задача организовать подключение от сервера заказчика до нашего сервера. сервер подключается по vpn. нужно от сервера заказчика подключаться к нашему серверу. актуальный IP, 
полученный по vpn получаем  по запросам curl например, при поднятии интерфейса ppp/tun.
