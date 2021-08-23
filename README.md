## General

Containerized pkg2appimage packaging tooling for building AppImages using
Docker or Podman.

References:
- <https://docs.appimage.org/packaging-guide/converting-binary-packages/pkg2appimage.html>
- <https://github.com/AppImage/pkg2appimage>

Tested so far on:
- Fedora 34 (using Podman user-mode)

## Building

```
$ podman build -f Dockerfile -t pkg2ai-cnt .
```

Builds the image with most common tooling needed for recipes.  
(This probably needs extending later on.)

```
$ mkdir ./buildout
$ podman run -it -v ./buildout:/buildout:z pkg2ai-cnt Dia
```

This results in building out Dia as AppImage into the local `buildout` folder
using the previously created container image.

## License

This project is licensed under MIT and is made available as-is.  
Licenses of the used components are unchanged and belong to their respective
holders.
