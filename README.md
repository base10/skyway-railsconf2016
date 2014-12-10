# Skyway

(Unofficial) stats and community site for [Aqueous](http://www.aqueousband.com/).

## Setup (OSX)

Install [Homebrew](http://brew.sh/) and [Pow](http://pow.cx), then:

``` shell
# Add rbenv to bash so that it loads every time you open a terminal
echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
source ~/.bash_profile

# Install Ruby 2.1.2 and set it as the default version
rbenv install 2.1.2
rbenv global 2.1.2
```

Then:

``` shell
git clone git@github.com:qrush/skyway.git
cd skyway
script/setup -v
```

And make sure to link your app with Pow! Assuming you installed it in `~/Dev`:

``` shell
cd ~/.pow
ln -s ~/Dev/skyway
```

## Ops

### Plugins

* https://github.com/Kloadut/dokku-pg-plugin
* https://github.com/rlaneve/dokku-link
* https://github.com/mordred/dokku-redirects-plugin
* https://github.com/jlachowski/dokku-memcached-plugin
* https://github.com/scottatron/dokku-rebuild

### Rebuild

```
apt-get install nodejs postgresql-server-dev-all postgresql-client-9.3 unzip
cd /var/lib/dokku/plugins
dokku plugins-install
dokku postgresql:create aqueousband.com

# Push app to dokku@IP_ADDRESS:aqueousband.com
dokku postgresql:link aqueousband.com aqueousband.com
psql -d db -h DB_ADDRESS -p DB_PORT < dump.sql

dokku memcached:create aqueousband.com
dokku memcached:link aqueousband.com aqueousband.com

dokku redirects:set aqueousband.com www.aqueousband.com=aqueousband.com www.aqueousband.net=aqueousband.com aqueousband.net=aqueousband.com

dokku config:set aqueousband.com ADMIN_PASSWORD=x AWS_ACCESS_KEY_ID=x AWS_SECRET_ACCESS_KEY=x S3_BUCKET_NAME=files.aqueousband.net S3_HOST_NAME=s3-eu-west-1.amazonaws.com
```

### Tasks

Run a migration, ssh in and:

```
dokku run aqueousband.com rake db:migrate
```

Sometimes memcached gets unhappy. If so:

```
dokku memcached:delete aqueousband.com
dokku memcached:rebuild aqueousband.com
dokku memcached:link aqueousband.com aqueousband.com
```

Restarting/rebuilding container: `dokku rebuild aqueousband.com`

## License

MIT. See `LICENSE`.
