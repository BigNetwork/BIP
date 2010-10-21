# Bignetwork Internet Player

I BIP kan man lägga upp och rösta på låtar man gillar. Låtarna med flest röster hamnar överst och spelas först.

Musiken kommer från Spotify och på sikt hoppas vi kunna göra samma sak med YouTube-videor.

## How to install

### Install Ruby v1.9.2
Proposed solution: with RVM:

    rvm install 1.9.2
    rvm 1.9.2

### Make sure you have the Bundler gem installed:
    gem install bundler

### Clone this repository
    git clone http://?????/BIP.git

### Make sure the gems needed for BIP are installed:
In the folder that was created from the git clone, run this:

    bundle install

### Make sure you have a database

To use the default SQLite database, run this:

    rake db:migrate

### Start the server

    ruby script/rails server

