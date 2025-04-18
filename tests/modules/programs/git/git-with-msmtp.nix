{ pkgs, realPkgs, ... }:

{
  imports = [ ../../accounts/email-test-accounts.nix ];

  accounts.email.accounts."hm@example.com".msmtp.enable = true;

  programs.git = {
    enable = true;
    signing.signer = "path-to-gpg";
    userEmail = "hm@example.com";
    userName = "H. M. Test";
  };

  home.stateVersion = "20.09";

  nmt.script = ''
    function assertGitConfig() {
      local value
      value=$(${realPkgs.gitMinimal}/bin/git config \
        --file $TESTED/home-files/.config/git/config \
        --get $1)
      if [[ $value != $2 ]]; then
        fail "Expected option '$1' to have value '$2' but it was '$value'"
      fi
    }

    assertFileExists home-files/.config/git/config
    assertFileContent home-files/.config/git/config \
      ${./git-with-msmtp-expected.conf}

    assertGitConfig "sendemail.hm@example.com.from" "H. M. Test <hm@example.com>"
    assertGitConfig "sendemail.hm-account.from" "H. M. Test Jr. <hm@example.org>"
    assertGitConfig "sendemail.hm@example.com.sendmailCmd" "${pkgs.msmtp}/bin/msmtp"
    assertGitConfig "sendemail.hm@example.com.envelopeSender" "auto"
  '';
}
