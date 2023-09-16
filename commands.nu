
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


def "git cb" [] {
  let branches = (git branch --color=never | lines | where (($it | str starts-with "*") == false))
  echo $branches
  let input = (input "Type branch number to checkout and press enter to move on: " | str trim)
  if (($input | str length) > 0) {
    let index = ($input | into int)
    let branch = ($branches | get $index | str trim)
    ^git checkout $branch
  } else {
    echo "Aborting..."
  }
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
        $acc | str replace --all --string $it.item $it.new
    }
}

def repostat [] {
  ls ~/prj/RMFMagic* | each {|it| cd $it.name; print (pwd | path basename); print (g st) } | ignore
}

def "g st" [] {
  let lines =  git status -sb | lines
  $lines.0 | print
  $lines | skip 1 | wrap text | insert type {|it| ($it.text | ansi strip | str substring 0..2) } | insert order {|it| match $it.type { "??" => 0, "UU" => 1, $t if $t =~ ' \S'  => 2, "MM" => 3, _ => 4 } } | sort-by -r order | get text | str join "\n"
}

def logtail [file] {
  tail -f $file | bat --paging=never -l log
}

