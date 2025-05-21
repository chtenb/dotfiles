alias g = ^git
alias gg = ^git grep -IPn --color=always --recurse-submodules
alias ggn = ^git grep -IPn --color=always --no-recurse-submodules
alias gr = ^git grep --no-index -IPn --color=always

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

def "g st" [] {
  let state = (git showstate)
  if $state !~ "NORMAL" {
    print $'(ansi magenta)($state)(ansi reset)'
  }
  let lines =  git status -sb | lines
  $lines.0 | print
  $lines | skip 1 | wrap text
    | insert type {|it| ($it.text | ansi strip | str substring 0..2) }
    | insert order {|it| match $it.type { 
      "??" => 0,
      "UU" => 1,
      "UD" => 2, 
      $t if $t =~ ' \S' => 3, 
      $t if $t =~ '\S\S' => 4,  
      $t if $t =~ '\S ' => 5,
      _ => 6 } 
    } | sort-by -r order | get text | str join "\n"
}

def "g nk" [] {
  cd (git rev-parse --show-toplevel)
  git checkout -- ...(^git diff --name-only | lines)
}

def "git bisect clean" [] {
  cd (git rev-parse --show-toplevel)
  rm .git/BISECT_*
}

# Delete local branches that are merged into the current branch.
# Before each operation, the user is asked for confirmation.
def "rm-br" [master_branch_name = "master"] {

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
