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
alias lnx = wsl.exe --cd '~' /home/chiel/.cargo/bin/nu -e "print $'Entered WSL at (pwd)'"
alias plantuml = java -jar ~/.local/bin/plantuml.jar

alias admin = powershell -Command "Start-Process nu -Verb RunAs"

alias t = task

def --env c [...path] {
  cd $path.0
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

def neo-ansi [--inverse(-i)] {
  def pad [] { fill -a right -w 2 -c 0 }

  print "BG   CLASS  COLORS"

  let eol = "\e[K\e[39;49m"
  let params = if $inverse { "7" } else { "" }

  print -n $"\e[($params)m"
  
  0..12 | each { |bg|
    let bg_code = if $bg == 0 { "49" } else { $"48;5;($bg + 231)" }
    let bg_name = if $bg == 0 { "dflt" } else { $"bg($bg | pad)" }
    print -n $"\e[($bg_code)m($bg_name) normal "
    0..7 | each { |color|
      print -n $"\e[38;5;($color)mbase($color | pad) "
    }
    print $eol
    print -n $"\e[($bg_code)m($bg_name) bright "
    8..15 | each { |color|
      print -n $"\e[38;5;($color)mbase($color | pad) "
    }
    print $eol
    print -n $"\e[($bg_code);1m($bg_name) bold   "
    8..15 | each { |color|
      print -n $"\e[38;5;($color)mbase($color | pad) "
    }
    print $"\e[22m($eol)"
    print -n "\e[49m"
  
    if $bg == 0 or $bg == 1 {
      print -n $"($bg_name) accent "
      12..1 | each { |color|
        print -n $"\e[38;5;(256 - $color)mac($color | pad) "
      }
      print $eol
    }
  }
  print -n "\e[0m"
  
  null
}

def underlines [] {
  printf "\e[4:3m\e[58:5:1mhello\e[0m"
}

def unicode [] {
  printf "𝓒-🎉-✅"
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

def "tohex" [] {
  into int | fmt | get lowerhex | str substring 2..
}

def "g c" [] {
  let branches = (^git branch --color=never | lines | where (($it | str starts-with "*") == false))
  print $branches
  let input = (input "Type branch number to checkout and press enter to move on: " | str trim)
  if (($input | str length) > 0) {
    let index = ($input | into int)
    let branch = ($branches | get $index | str trim | ansi strip)
    ^git checkout $branch
  } else {
    print "Aborting..."
  }
}

def repostat [] {
  ls ~/prj/RMFMagic* | each {|it| cd $it.name; print (pwd | path basename); print (g st) } | ignore
}

def "g st" [] {
  let state = (git showstate)
  if $state !~ "NORMAL" {
    print $'(ansi magenta)($state)(ansi reset)'
  }
  let lines =  git status -sb | lines
  $lines.0 | print
  $lines | skip 1 | wrap text | insert type {|it| ($it.text | ansi strip | str substring 0..2) } | insert order {|it| match $it.type { 
      "??" => 0, "UU" => 1, "UD" => 2, 
      $t if $t =~ ' \S' => 3, 
      $t if $t =~ '\S\S' => 4,  
      $t if $t =~ '\S ' => 5, _ => 6 } 
    } | sort-by -r order | get text | str join "\n"
}

def "g nk" [] {
  cd (git rev-parse --show-toplevel)
  g co -- ...(^git diff --name-only | lines)
}

def "g bisect clean" [] {
  cd (git rev-parse --show-toplevel)
  rm .git/BISECT_*
}


def logtail [file] {
  tail -n100 -f $file | bat --paging=never -l log
}

# alias koka-dev = C:\Users\chiel.tenbrinke\prj\koka\.stack-work\install\d123c6a0\bin\koka.exe
# alias kk = C:\Users\chiel.tenbrinke\prj\koka\.stack-work\install\27da0db2\bin\koka.exe -iC:\Users\chiel.tenbrinke\prj

def confirm [message: string] {
  mut response = (input $"($message) \(Y/n\) ")
  while $response !~ "(?i)^(n|no|y|yes)$" {
    $response = (input "Please answer yes or no")
  }
  $response =~ "(?i)^(y|yes)$"
}

# Delete local branches that are merged into the current branch.
# Before each operation, the user is asked for confirmation.
def rm-br [master_branch_name = "master"] {

  # Get merged branches
  let merged_branches = (^git branch --merged
    | split row "\n"
    | str trim
    | ansi strip
    | where {|b| $b != $master_branch_name and ($b !~ "[*|+]")})
  
  print "Merged local branches:"
  print ($merged_branches | str join "\n    ")

  $merged_branches | each {|it| 
      if (confirm $"Do you want to delete branch ($it)?") {
        print $"Deleting ($it)"
        (^git branch -D $it)
      } else {
        print $"Skipping ($it)"
      }
    } 
}

def svgcat [file?: string] {
  let input = if ($file != null) {
    cat $file
  } else {
    $in
  }
  
  let size = wezterm cli list --format=json | from json 
    | where pane_id == ($env.WEZTERM_PANE | into int) | get 0.size

  $input | magick.exe svg:- -resize $"($size.pixel_width)x($size.pixel_height)" png:- | wezterm imgcat
}

def pumlwatch [file: string] {
  watch $file { |op, path| if ($op == "Write") { 
      cat $path | plantuml -p -tsvg | tee {save -f $"($path).svg"} | svgcat
      return
    }
  }
}


