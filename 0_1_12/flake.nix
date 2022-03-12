{
  description = ''Nim wrappers for tree-sitter parser grammars'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-htsparse-0_1_12.flake = false;
  inputs.src-htsparse-0_1_12.owner = "haxscramper";
  inputs.src-htsparse-0_1_12.ref   = "refs/tags/0.1.12";
  inputs.src-htsparse-0_1_12.repo  = "htsparse";
  inputs.src-htsparse-0_1_12.type  = "github";
  
  inputs."hmisc".owner = "nim-nix-pkgs";
  inputs."hmisc".ref   = "master";
  inputs."hmisc".repo  = "hmisc";
  inputs."hmisc".type  = "github";
  inputs."hmisc".inputs.nixpkgs.follows = "nixpkgs";
  inputs."hmisc".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-htsparse-0_1_12"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-htsparse-0_1_12";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}