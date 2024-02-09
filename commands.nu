###### ALIAS ######

alias g = git
# alias ex = start /B files .
alias ex = explorer .
alias gg = git grep -IPn --color=always --recurse-submodules
alias ggn = git grep -IPn --color=always
alias gr = git grep --no-index -IPn --color=always
alias rcname = python -c "for i,c in enumerate(f'{input():<12}'[:12]): print(f'\t<C{i+1:>02}>{ord(c)}</C{i+1:>02}>')"

alias darkcol = cp ~/dotfiles/delta/dark.gitconfig ~/dotfiles/delta/current.gitconfig
alias lightcol = cp ~/dotfiles/delta/light.gitconfig ~/dotfiles/delta/current.gitconfig
alias ansicol = cp ~/dotfiles/delta/ansi.gitconfig ~/dotfiles/delta/current.gitconfig

alias l = ls -a
alias ll = ls -alf
# On windows the npm.cmd gives strange errors, but the bash script does not.
# alias npm = if (sys).host.name == "Windows" { bash 'C:\Program Files\nodejs\npm' } else { npm }
alias wnpm = bash 'C:\Program Files\nodejs\npm'
alias npr = npm run -- 
alias npe = npm exec -- 
alias replac = perl ~/dotfiles/replac/replac.pl

alias t = task

def --env c [...path] {
  cd $path
  ls -sa
}

def tstop [] {
  task rc.confirmation=off rc.bulk:0 status:pending +ACTIVE ids | xargs -i task {} stop
}
def tsw [task] {
  tstop
  task $task start
}
def --env twrap [] {
  tstop
  cd ~/.task
  git add .
  git commit -m "Wrap up"
  git push
  cd
}


def colors [] {
  [30 40 90 100] | each { |$color_offset| 
    0..9 | each { |$color|
      if $color != 8 { # 8 is not a color code
        1..9 | each { |$style|
          $"\e[($color + $color_offset);($style)m" + $'\e[($color + $color_offset)($style)m' + "\e[0m"
        } | str join
      }
    } | flatten
  } | flatten
}

def 256colors [] {
  0..255 | each { |$color|
    $"\e[38;5;($color)m" + $'($color)' + "\e[0m"
  } | str join
}


def anonymize [pattern] {
    let input = $in

    let replacements = ($input
        | parse --regex $"\(($pattern)\)"
        | get capture0
        | uniq
        | enumerate
        | insert new {|it| $"anon($it.index)"})
    
    $replacements | reduce --fold $input {|it, acc|
        $acc | str replace --all $it.item $it.new
    }
}

def "g c" [] {
  let branches = (^git branch --color=never | lines | where (($it | str starts-with "*") == false))
  echo $branches
  let input = (input "Type branch number to checkout and press enter to move on: " | str trim)
  if (($input | str length) > 0) {
    let index = ($input | into int)
    let branch = ($branches | get $index | str trim | ansi strip)
    ^git checkout $branch
  } else {
    echo "Aborting..."
  }
}

def repostat [] {
  ls ~/prj/RMFMagic* | each {|it| cd $it.name; print (pwd | path basename); print (g st) } | ignore
}

def "g st" [] {
  let lines =  git status -sb | lines
  $lines.0 | print
  $lines | skip 1 | wrap text | insert type {|it| ($it.text | ansi strip | str substring 0..2) } | insert order {|it| match $it.type { 
      "??" => 0, "UU" => 1, "UD" => 2, 
      $t if $t =~ ' \S'  => 3, 
      $t if $t =~ '\S\S'  => 4,  
      $t if $t =~ '\S ' => 5, _ => 6 } 
    } | sort-by -r order | get text | str join "\n"
}

def "g nk" [] {
  g co -- ...(^git diff --name-only | lines)
}


def logtail [file] {
  tail -n100 -f $file | bat --paging=never -l log
}

# alias koka-dev = C:\Users\chiel.tenbrinke\prj\koka\.stack-work\install\d123c6a0\bin\koka.exe
alias kk = C:\Users\chiel.tenbrinke\prj\koka\.stack-work\install\27da0db2\bin\koka.exe -iC:\Users\chiel.tenbrinke\prj
