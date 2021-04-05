Installer script for fresh Debian (and possibly Debian-like) enviroments to jump start web development on Google Cloud Platform.

```
sudo ~/gcp-devenv-setup/install.sh
```

Using [Cloud Shell](https://cloud.google.com/shell)? Run this command instead:

```
sudo ~/gcp-devenv-setup/cloudshell.sh
```
## Packages

The script will install (with dependencies) and configure the following packages:

#### Normal:
- `google-cloud-sdk`
- - `apt-transport-https`
- - `ca-certificates`
- - `gnupg`
- `gcsfuse`
- `curl`
- `python3`
- - `pip`
- `nginx`
- `php7.3-fpm`
- `composer`
- `openssl`

NGINX will forward traffic from any source on port '80' and '8080' to port '443' with HTTPS (using a self-signed certificate; generated with this script)

#### Cloud Shell:
- `gcsfuse`
- `python3`
- - `pip`
- `nginx`
- `php7.3-fpm`
- `composer`
