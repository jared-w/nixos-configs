let
  jared-w =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHshmuDCXrzqzGLahxb2flsdOX3Cf3n25903mhiI/B34";
in {
  "galois-onsite-config".publicKeys = [ jared-w ];
  "matterhorn-config.ini".publicKeys = [ jared-w ];
  "wg-colo".publicKeys = [ jared-w ];
  "wg-portland".publicKeys = [ jared-w ];
}
