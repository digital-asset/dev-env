{ system ? builtins.currentSystem }:

let
  pkgs = import ./nixpkgs.nix { inherit system; };

  # Selects "bin" output from multi-output derivations which are has it. For
  # other multi-output derivations, select only the first output. For
  # single-output generation, do nothing.
  #
  # This ensures that as few output as possible of the tools we use below are
  # realized by Nix.
  selectBin = pkg:
    if pkg == null then
      null
    else if builtins.hasAttr "bin" pkg then
      pkg.bin
    else if builtins.hasAttr "outputs" pkg then
      builtins.getAttr (builtins.elemAt pkg.outputs 0) pkg
    else
      pkg;

in rec {
  inherit pkgs;
  tools = pkgs.lib.mapAttrs (_: pkg: selectBin pkg) (rec {
    # define tools here
    # Note: for technical reasons, you should not try to get Bash from dev-env.

    # Remember that uncommenting those (or adding your own) is only the first
    # step; you also need to symlink the executable in `dev-env/bin`. See
    # README for details.

    # Here are a few examples to get you started:

    # shell tools
    #jq = pkgs.jq;
    #date = pkgs.coreutils;
    #mktemp = pkgs.coreutils;
    #make = pkgs.gnumake;
    #m4 = pkgs.m4;
    #curl = pkgs.curl;
    #lsof = pkgs.lsof;
    #patch = pkgs.patch;
    #wget = pkgs.wget;
    #base64 = pkgs.coreutils;
    #bc = pkgs.bc;
    #find = pkgs.findutils;
    #gawk = pkgs.gawk;
    #grep = pkgs.gnugrep;
    #sed = pkgs.gnused;
    #sha1sum = pkgs.coreutils;
    #xargs = pkgs.findutils;
    #xmlstarlet = pkgs.xmlstarlet;

    # devops
    #gcloud = pkgs.google-cloud-sdk;
    #aws = pkgs.awscli;
    #terraform = pkgs.terraform_0_13.withPlugins (p: with p; [
    #  google
    #  google-beta
    #]);
    #kubectl = pkgs.kubectl;
    #minikube = pkgs.minikube;
    #bq = gcloud;
    #gsutil = gcloud;

    # Java
    #jdk    = pkgs.jdk8;
    #java   = jdk;
    #javac  = jdk;
    #jinfo  = jdk;
    #jmap   = jdk;
    #jstack = jdk;
    #jar    = jdk;

    # Python development
    #pip3        = pkgs.python37Packages.pip;
    #python      = python37;
    #python3     = python37;
    #python37    = pkgs.python37Packages.python;
    #pex = pkgs.python37Packages.pex;

    # web stuff
    #sass = pkgs.sass;
    #graphviz  = pkgs.graphviz_2_32;
    #dot       = graphviz;
    #tred      = graphviz;
    #unflatten = graphviz;
    #circo     = graphviz;
    #pandoc = pkgs.pandoc;

    # Cryptography tooling
    #gnupg = pkgs.gnupg;
    #gpg   = gnupg;

    # Packaging tools
    #patchelf = pkgs.patchelf;
    #zip = pkgs.zip;
    #openssl = pkgs.openssl.bin;
    #tar = pkgs.gnutar;

  });

}
