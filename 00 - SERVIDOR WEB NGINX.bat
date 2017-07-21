title "SERVIDOR WEB NGINX"
cd C:\Program Files\NGINX\nginx-1.13.3
start nginx
tasklist /fi "imagename eq nginx.exe"
pause
nginx -s stop
