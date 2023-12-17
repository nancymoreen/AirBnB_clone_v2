#!/usr/bin/env bash
# sets up the web servers for the deployment of web_static

if ! command -v nginx &>/dev/null; then
    sudo apt-get update
    sudo apt-get -y install nginx
fi

sudo mkdir -p /data/web_static/{releases/test,shared}
sudo touch /data/web_static/releases/test/index.html
echo -e "<html>\n  <head>\n  </head>\n  <body>\n    Holberton School\n  </body>\n</html>" | sudo tee /data/web_static/releases/test/index.html >/dev/null
sudo ln -sf /data/web_static/releases/test /data/web_static/current
sudo chmod 755 /data /data/web_static /data/web_static/releases /data/web_static/shared /data/web_static/releases/test
sudo chown -R ubuntu:ubuntu /data

nginx_config="/etc/nginx/sites-available/default"
sudo sed -i '/^\s*server\s*{/a \\\n\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t}\n' "$nginx_config"

sudo service nginx restart
