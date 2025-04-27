use str

fn g {|@a| git $@a }
fn gg {|@a| git grep -IPn --color=always --recurse-submodules $@a }
fn ggn {|@a| git grep -IPn --color=always $@a }
fn gr {|@a| git grep --no-index -IPn --color=always $@a }

set edit:prompt = {
  tilde-abbr $pwd
  styled '❱ ' bright-red
}
set edit:rprompt = (constantly (styled "hello" inverse))

fn gst {|@a|
  var state = (git showstate)
  if (not (str:contains $state "NORMAL")) {
    echo (styled $state magenta)
  }
  var lines = [(git status -sb)]
  echo (take 1 $lines)
  all (drop 1 $lines) |
    each {|line| [&text=($line) &type=($line[0..2])] } |
    [(all)]
}
