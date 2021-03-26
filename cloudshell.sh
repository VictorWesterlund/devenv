#!/bin/bash
echo "-- installing dev tools for Cloud Shell --"

DEBIAN_FRONTEND=noninteractive
ARG=$1

cd ~/devenv > /dev/null 2>&1
cd devenv > /dev/null 2>&1

# Overwrite last line of output
overwrite() { 
	echo -e "\r\033[1A\033[0K$@"; 
}

label() {
	echo "$1"
	sleep 1s
}

update() {
	overwrite "⧖ Updating package list.."
	sudo apt-get update > /dev/null 2>&1
	overwrite "✓ Packages updated"

	if [ "$ARG" == "upgrade" ]; then
		overwrite "⧖ Upgrading packages.."
		sudo apt-get upgrade -yq > /dev/null 2>&1
		overwrite "✓ Packages upgraded"
	fi
}

install() {
	overwrite "⧖ Installing $1 ($2).."
	sudo apt-get install -y $2 > /dev/null 2>&1
	overwrite "✓ Package '$2' installed"
}

echo "Starting.."

# GCSFUSE
export GCSFUSE_REPO=gcsfuse-`lsb_release -c -s` > /dev/null 2>&1
echo "deb http://packages.cloud.google.com/apt $GCSFUSE_REPO main" > /dev/null 2>&1 | sudo tee /etc/apt/sources.list.d/gcsfuse.list > /dev/null 2>&1
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg > /dev/null 2>&1 | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - > /dev/null 2>&1
update

# -- Install new packages --
label "⧖ Installing packages.."

install "Python" "python3"
install "NGINX" "nginx"
install "PHP" "php7.3-fpm"
install "Composer" "composer"
install "Google Cloud Storage FUSE" "gcsfuse"

overwrite "✓ Packages installed."

# -- Configure new packages --
label "⧖ Configuring packages.."

# Python
overwrite "⧖ Installing PIP for Python 3.."
python3 -m pip install > /dev/null 2>&1
overwrite "Python 3 module 'PIP' intalled for user '$USER'"

# NGINX
overwrite "⧖ Copying files.."
sudo cp -n ./files/cloudshell.conf /etc/nginx/sites-available/localhost.conf > /dev/null 2>&1
sudo cp -n ./files/fastcgi-php.local.conf /etc/nginx/snippets/fastcgi-php.local.conf > /dev/null 2>&1
overwrite "⧖ Creating symlinks.."
sudo ln -s -n /etc/nginx/sites-available/localhost.conf /etc/nginx/sites-enabled/localhost.conf > /dev/null 2>&1
overwrite "⧖ Cleaing up.."
sudo rm /etc/nginx/sites-enabled/default > /dev/null 2>&1
overwrite "NGINX Configured."

overwrite "✓ Packages configured."

# -- Cleanup --
label "⧖ Starting services.."

sudo service nginx restart > /dev/null 2>&1
sudo service php7.3-fpm start > /dev/null 2>&1

overwrite "✓ Services started."
echo "-- dev tools installed --"
