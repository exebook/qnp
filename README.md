# qnp -- query node packages
Query NPM from downloaded data in &lt;200 ms. This is useful when you need to do dozens of searches before you find what you were looking for.

##Updating local database

Once it is installed, type `qnp -up`, and wait until download of 80MB registry and indexing is done. Downloading may take a while, indexing takes less than a minute.

#Search examples
`qnp forth -back` search **anything** matching **forth** but not containing **back**.

`qnp a coffee` search for packages **authored** by someone whose name concain **coffee**.

`qnp t ^elfu$` search for a package **titled** as **elfu**, *qnp query is not the Regular Expression*, but `^` and `$` will match the beginning and the ending of the title (also works for author and keywords).

`qnp k ^hub$` search **hub** in **keywords**, but ignore **github**, **hubbot** etc.

##Installation

`[sudo] npm install -g qnp`

Invoking `qnp` without arguments will display help:

```
Search local copy of npm database, use `qnp -up` to update.
USAGE: qnp [-up] [t] [d] [k] [g] <keyword -keyword>
t - title, d - desc., k - keywords
-up - update, download and index 80+ MB file from npmjs.org
g - disable colors
default: t d k - all on
```

##How speed is achieved

qnp will start socket server on port 7000 that will load prepared index file into memory and stay in background. Indexed data in the server process takes about 20 MB.
