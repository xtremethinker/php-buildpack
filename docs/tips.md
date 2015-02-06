## Tips

While I hope the build pack is simple enough to use, here are some tips that can make your experience better.

1. To use the `-c` options with `cf push` and still want the app to be started by the buildpack, you'll need to append the default startup script (`./start.sh`).

For example,

```sh
cf push php_app -c 'echo "Hello, World" && ./start.sh'
```
