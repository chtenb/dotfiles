###### ALIAS ######
source git-commands.nu

# alias ex = start /B files .
alias ex = explorer .
alias rcname = python -c "for i,c in enumerate(f'{input():<12}'[:12]): print(f'\t<C{i+1:>02}>{ord(c)}</C{i+1:>02}>')"

alias l = ls -a
alias ll = ls -alf
# On windows the npm.cmd gives strange errors, but the bash script does not.
# alias npm = if (sys).host.name == "Windows" { bash 'C:\Program Files\nodejs\npm' } else { npm }
alias wnpm = bash 'C:\Program Files\nodejs\npm'
alias npr = npm run -- 
alias npe = npm exec -- 
alias replac = perl ~/prj/dotfiles/replac/replac.pl
alias lnx = wsl.exe --cd '~' /home/chiel/.cargo/bin/nu -e "print $'Entered WSL at (pwd)'"
alias plantuml = java -jar ~/.local/bin/plantuml.jar

alias admin = powershell -Command "Start-Process nu -Verb RunAs"
alias vi = vim -v

def eval [] {
  let input = $in
  $input | lines | each {|it| nu -c $it} | str join "\n"
}

def "repostat" [] {
  ls ~/prj/Vision* | each {|it| cd $it.name; print (pwd | path basename); print (g st) } | ignore
}

alias vpn-cli = `C:\Program Files (x86)\Cisco\Cisco Secure Client\vpncli.exe`
alias ibm-vpn = `C:\Program Files (x86)\Cisco\Cisco Secure Client\vpncli.exe` connect "EUROPE-MEA (windows)"
alias no-vpn = `C:\Program Files (x86)\Cisco\Cisco Secure Client\vpncli.exe` disconnect
alias delft-vpn = `C:\Program Files\Google\Chrome\Application\chrome.exe` 'https://bmfw-052p-e4d-e101.delft.nl.ibm.com:6081/php/uid.php?vsys=1&rule=0'

# curl -s "https://bmfw-052p-e4d-e101.delft.nl.ibm.com:6081/php/uid.php?vsys=1&rule=0"^
# --data-urlencode "inputStr="^
# --data-urlencode "escapeUser=tom.koelman@ibm.com"^
# --data-urlencode "preauthid="^
# --data-urlencode "user=tom.koelman@ibm.com"^
# --data-urlencode "passwd@%PASSWDFILE%"^
# --data-urlencode "ok=Login"^
# --insecure^
# --output output > NUL

def vpn [] {
  ibm-vpn
  delft-vpn
  ping -t w3.ibm.com
}

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


def logtail [file] {
  tail -n100 -f $file | bat --paging=never -l log
}

def confirm [message: string] {
  mut response = (input $"($message) \(Y/n\) ")
  while $response !~ "(?i)^(n|no|y|yes)$" {
    $response = (input "Please answer yes or no")
  }
  $response =~ "(?i)^(y|yes)$"
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


