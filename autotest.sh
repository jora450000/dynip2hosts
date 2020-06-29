#!/bin/sh


killall perl

perl webserver.pl &
sleep 1
curl http://192.168.1.73:8080/
#killall perl


