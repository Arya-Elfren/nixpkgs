{ lib, fetchFromGitHub, installShellFiles, buildGoModule }:

buildGoModule rec {
  pname = "autorestic";
  version = "1.7.6";

  src = fetchFromGitHub {
    owner = "cupcakearmy";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-jlCCARbZSAHK0ojlTdtUl7fo+MAtuQYo64lZeKyQ9ho=";
  };

  vendorHash = "sha256-K3+5DRXcx56sJ4XHikVtmoxmpJbBeAgPkN9KtHVgvYA=";

  nativeBuildInputs = [ installShellFiles ];

  postInstall = ''
    installShellCompletion --cmd autorestic \
         --bash <($out/bin/autorestic completion bash) \
         --fish <($out/bin/autorestic completion fish) \
         --zsh <($out/bin/autorestic completion zsh)
  '';

  meta = with lib; {
    description = "High level CLI utility for restic";
    homepage = "https://github.com/cupcakearmy/autorestic";
    license = licenses.asl20;
    maintainers = with maintainers; [ renesat ];
    mainProgram = "autorestic";
  };
}
