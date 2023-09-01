
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

