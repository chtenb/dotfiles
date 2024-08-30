source ~/dotfiles/nu_scripts/custom-completions/git/git-completions.nu


def "nu-complete g branches" [] {
  (nu-complete git local branches)
  | parse "{value}"
  | insert description "local branch"
  | append (nu-complete git remote branches with prefix
            | parse "{value}"
            | insert description "remote branch")
}

# def "gst" [
#   --verbose(-v)                                       # be verbose
#   --short(-s)                                         # show status concisely
#   --branch(-b)                                        # show branch information
#   --show-stash                                        # show stash information
# ] {
#   git status --verbose=$verbose --short=$short --branch=$branch --show-stash=$show_stash
# }

def --wrapped "g co" [
  ...args
  target?: string@"nu-complete g branches"   # name of the branch or files to checkout
] {
  ^git checkout ...$args $target
}

