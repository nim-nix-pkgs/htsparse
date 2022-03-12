{
  description = ''Nim wrappers for tree-sitter parser grammars'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-htsparse-master.flake = false;
  inputs.src-htsparse-master.owner = "haxscramper";
  inputs.src-htsparse-master.ref   = "refs/heads/master";
  inputs.src-htsparse-master.repo  = "htsparse";
  inputs.src-htsparse-master.type  = "github";
  
  inputs."hmisc".owner = "nim-nix-pkgs";
  inputs."hmisc".ref   = "master";
  inputs."hmisc".repo  = "hmisc";
  inputs."hmisc".type  = "github";
  inputs."hmisc".inputs.nixpkgs.follows = "nixpkgs";
  inputs."hmisc".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-htsparse-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-htsparse-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}