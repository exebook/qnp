# qnp
Query NPM from downloaded data in &lt;200 ms

`[sudo] npm i -g qnp`

`qnp` will display help:
```
Search local copy of npm database, use `qnp -up` to update.
USAGE: qnp [-up] [t] [d] [k] [g] <keyword -keyword>
t - title, d - desc., k - keywords
-up - update, download and index 80+ MB file from npmjs.org
g - disable colors
default: t d k - all on
```

EXAMPLES
`qnp forth -back` search anything matching **forth** but not containing **back**.
`qnp a coffee` search for packages authored by someone whose name concain **coffee**
`qnp t ^elfu$` search for a package named elfu, this is not RegExp, but `^` and `$` will match the beginning and the ending of the title (also works for author and keywords).
`qnp k ^hub$` search for keyword **hub**, but ignoring **github**, **hubbot** etc.
