
fn g {|@a| git $@a }
fn gg {|@a| git grep -IPn --color=always --recurse-submodules $@a }
fn ggn {|@a| git grep -IPn --color=always $@a }
fn gr {|@a| git grep --no-index -IPn --color=always $@a }

