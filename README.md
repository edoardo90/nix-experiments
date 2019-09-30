# nix-experiments

### History

I installed nix on windows 10 (WSL) following

[https://nathan.gs/2019/04/12/nix-on-windows/](https://nathan.gs/2019/04/12/nix-on-windows/)


Exept that nix-shell did not work as expected
(see: [https://www.tweag.io/posts/2017-11-10-nix-on-wsl.html](https://www.tweag.io/posts/2017-11-10-nix-on-wsl.html))

So I decided to run it inside a Docker, starting from:
[https://github.com/LnL7/nix-docker](https://github.com/LnL7/nix-docker)

## First Hello, World

While looking for nix tutorials one seemed to me very well done:
[https://www.sam.today/blog/environments-with-nix-shell-learning-nix-pt-1/](https://www.sam.today/blog/environments-with-nix-shell-learning-nix-pt-1/)

This is the "test.nix" used in the first part of the Sam tutorial

```nix
# This imports the nix package collection,
# so we can access the `pkgs` and `stdenv` variables
with import <nixpkgs> {};

# Make a new "derivation" that represents our shell
stdenv.mkDerivation {
  name = "my-environment";

  # The packages in the `buildInputs` list will be added to the PATH in our shell
  buildInputs = [
    # cowsay is an arbitary package
    # see https://nixos.org/nixos/packages.html to search for more
    pkgs.cowsay
  ];
}
```

To try it "inside" a docker container it is possible to use a Dockerfile

```Dockerfile
FROM lnl7/nix:2.2
RUN mkdir -p /home/nix
COPY test.nix /home/nix
WORKDIR /home/nix
ENTRYPOINT nix-shell test.nix
```

Starting from this Dockerfile it is possible to create a docker image

```bash
docker build -t nix/test-shell-copy_entry .
```

After the build we can run the creted docker container with:
```bash
 docker run -it nix/test-shell-copy_entry
```
