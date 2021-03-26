Installer script for fresh Debian (and possibly Debian-like) enviroments to jump start web development on Google Cloud Platform.

```
sudo ~/devenv/install.sh
```

## This installer will

- Add the **Google Cloud SDK** & **gcsfuse** repositories.
- Install (with dependencies) the [packages listed below](#packages).
- Generate and install a self-signed SSL certificate with OpenSSL for use with NGINX.
- Import a basic NGINX configuration with an extensionless PHP interface.
- Enforce HTTP connections from any source on port '80' and '8080' to HTTPS on port '443'.

---

### Packages

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
