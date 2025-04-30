use str
use re
use os

set edit:insert:binding[Down] = { }

fn g {|@a| git $@a }
fn gg {|@a| git grep -IPn --color=always --recurse-submodules $@a }
fn ggn {|@a| git grep -IPn --color=always $@a }
fn gr {|@a| git grep --no-index -IPn --color=always $@a }

set edit:prompt = {
  tilde-abbr $pwd
  styled '❱ ' bright-red
}
set edit:rprompt = (constantly (styled "hello" inverse))

fn strip-ansi {|s|
  re:replace "\e\\[[0-9;]*[a-zA-Z]" "" $s 
}

fn git-state {
  tmp E:PWD = (git rev-parse --show-toplevel)

  if (os:exists .git/BISECT_LOG) {
    echo BISECTING
  } elif (os:exists .git/MERGE_HEAD) {
    echo MERGING
  } elif (or (os:is-dir .git/rebase-merge) (os:is-dir .git/rebase-apply)) {
    echo REBASING
  } elif (os:exists .git/CHERRY_PICK_HEAD) {
    echo CHERRY-PICKING
  } elif (os:exists .git/REVERT_HEAD) {
    echo REVERTING
  } else {
    echo NORMAL
  }
}

fn gst {|@a|
  var state = (git-state)
  if (not (str:contains $state "NORMAL")) {
    echo (styled $state magenta)
  }
  var lines = [(git status -sb)]
  echo (take 1 $lines)
  drop 1 $lines |
    each {|line|
      put [&text=$line &priority=({
        var type = (strip-ansi $line)[0..2]
        if (eq $type "??") {
          put (num 0)
        } elif (eq $type "UU") {
          put (num 1)
        } elif (eq $type "UD") {
          put (num 2)
        } elif (re:match ' \S' $type) {
          put (num 3)
        } elif (re:match '\S\S' $type) {
          put (num 4)
        } elif (re:match '\S ' $type) {
          put (num 5)
        } else {
          put (num 6)
        }
      })]
    } |
    order &reverse &key={|i| put $i[priority]} |
    each {|i| echo $i[text]}
}

fn gco {|@a|
  var branches = [(git branch --color=never | keep-if {|b| not (str:has-prefix $b '*') })]
  $branches | each {|b| echo $b }
  var input = (num (read-line))
  var target = (put $branches[$input] | str:trim-space (one))
  git checkout $target
}
