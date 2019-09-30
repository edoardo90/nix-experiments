FROM lnl7/nix:2.2
RUN mkdir -p /home/nix
COPY test.nix /home/nix
WORKDIR /home/nix
ENTRYPOINT nix-shell test.nix