use str
use re
use os


# CONFIG

set edit:insert:binding[Down] = { }

set edit:prompt = {
  tilde-abbr $pwd
  styled '❱ ' bright-red
}
set edit:rprompt = (constantly (styled "hello" inverse))


# ALIASES

fn g {|@a| git $@a }
fn gg {|@a| git grep -IPn --color=always --recurse-submodules $@a }
fn ggn {|@a| git grep -IPn --color=always $@a }
fn gr {|@a| git grep --no-index -IPn --color=always $@a }

fn vpn-cli { 'C:\Program Files (x86)\Cisco\Cisco Secure Client\vpncli.exe' }
fn ibm-vpn { 'C:\Program Files (x86)\Cisco\Cisco Secure Client\vpncli.exe' connect "EUROPE-MEA (windows)" }
fn no-vpn { 'C:\Program Files (x86)\Cisco\Cisco Secure Client\vpncli.exe' disconnect }
fn delft-vpn { 'C:\Program Files\Google\Chrome\Application\chrome.exe' 'https://bmfw-052p-e4d-e101.delft.nl.ibm.com:6081/php/uid.php?vsys=1&rule=0' }
fn vpn {
  ibm-vpn
  delft-vpn
  ping -t w3.ibm.com
}

fn admin { powershell -Command "Start-Process nu -Verb RunAs" }
fn vi { vim -v }
fn ex { explorer . }
fn l { ls -a }
fn ll { ls -alf }
fn npr { npm run --  }
fn npe { npm exec --  }
fn replac { perl ~/prj/dotfiles/replac/replac.pl }
fn lnx { wsl.exe --cd '~' /home/chiel/.cargo/bin/nu -e "print $'Entered WSL at (pwd)'" }
fn plantuml { java -jar ~/.local/bin/plantuml.jar }
fn logtail {|file| tail -n100 -f $file | bat --paging=never -l log }



# UTILS

fn strip-ansi {|s|
  re:replace "\e\\[[0-9;]*[a-zA-Z]" "" $s 
}

fn confirm {|q|
  print $q" (y/n) " > CON
  re:match "(?i)^(y|yes)$" (read-line < CON)
}

# GIT COMMANDS

fn git-state {
  tmp pwd = (git rev-parse --show-toplevel)

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

fn gst {
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
  var branches = [(git branch --color=never |
    keep-if {|b| not (str:has-prefix $b '*') }
    )]
  $branches | each {|b| echo $b }
  var input = (num (read-line))
  var target = (put $branches[$input] | str:trim-space (one))
  git checkout $target
}

fn gnk {
  tmp pwd = (git rev-parse --show-toplevel)
  git checkout -- (git diff --name-only)
}

fn git-bisect-clean {
  tmp pwd = (git rev-parse --show-toplevel)
  rm .git/BISECT_*
}

fn git-rm-br {|&master=refs/remotes/origin/HEAD|
  var merged = [(git branch --merged $master |
    each {|b| str:trim-space $b } |
    each {|b| strip-ansi $b } |
    keep-if {|b| not (str:has-prefix $b '*') }
    )]
  put $merged

  all $merged |
    each {|b|
      if (confirm "Do you want to delete branch "$b"?") {
        echo (styled "Deleting "$b bold red) ; git branch -D $b
      } else {
        echo (styled "Skipping "$b black)} }
}


fn repostat {
  put ~/prj/Vision* |
    each {|r| tmp pwd = $r; echo (pwd) ; echo (gst |slurp) }
}


# OTHER COMMANDS

fn svgcat {|@files|
  var size = (wezterm cli list --format=json | from-json | all (one) | keep-if {|pane| == $pane[pane_id] $E:WEZTERM_PANE})[size]

  cat (all $files) | magick.exe svg:- -resize $size[pixel_width]"x"$size[pixel_height] png:- | wezterm imgcat
}

fn neo-ansi {|&inverse=$false| 
  fn pad {|s| printf "%02d" $s }

  print "BG   CLASS  COLORS\n"

  var eol = "\e[K\e[39;49m\n"
  var params = (if $inverse { put "7" } else { put "" })

  print "\e["$params"m"
  
  range 13 | each {|bg|
    var bg_code = (if (== $bg 0) { put "49" } else { put "48;5;"(+ $bg 231) })
    var bg_name = (if (== $bg 0) { put "dflt" } else { put "bg"(pad $bg) })
    print "\e["$bg_code"m"$bg_name" normal "
    range 8 | each {|color|
      print "\e[38;5;"$color"mbase"(pad $color)" "
    }
    print $eol
    print "\e["$bg_code"m"$bg_name" bright "
    range 8 16 | each {|color|
      print "\e[38;5;"$color"mbase"(pad $color)" "
    }
    print $eol
    print "\e["$bg_code";1m"$bg_name" bold   "
    range 8 16 | each {|color|
      print "\e[38;5;"$color"mbase"(pad $color)" "
    }
    print "\e[22m"$eol
    print "\e[49m"
  
    if (or (== $bg 0) (== $bg 1)) {
      print $bg_name" accent "
      range 12 0 | each {|color|
        print "\e[38;5;"(- 256 $color)"mac"(pad $color)" "
      }
      print $eol
    }
  }
  print "\e[0m"
}

# fn anonymize {|pattern|
#   var input = (slurp)
  
# }

