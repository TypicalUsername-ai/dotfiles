{ theme }:
let
  communityRepo = builtins.fetchGit {
    url = "https://github.com/eza-community/eza-themes.git";
    shallow = true;
    rev = "21184b55bfe34e8473c8160f9de0c03e4f76857f";
  };
  ezaCommunityTheme = communityRepo.outPath + "/themes/${theme}.yml";
in
ezaCommunityTheme
