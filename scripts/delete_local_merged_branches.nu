# Delete local branches that are merged into master.
# Before each operation, the user is asked for confirmation.

# Parse command line arguments
def main [master_branch_name = "master"] {

  # Get merged branches
  let merged_branches = (^git branch --merged
    | split row "\n"
    | str trim
    | ansi strip
    | where {|b| $b != $master_branch_name and ($b !~ "[*|+]")})
  
  print "Merged local branches:"
  print ($merged_branches | str join "\n    ")

  $merged_branches | each {|it| 
      if confirm $"Do you want to delete branch ($it)?" {
        print $"Deleting ($it)"
        (^git branch -D $it)
      } else {
        print $"Skipping ($it)"
      }
    } 
}


def confirm [message] {
  mut response = (input $"($message) \(Y/n\) ")
  while $response !~ "(?i)^(n|no|y|yes)$" {
    $response = (input "Please answer yes or no")
  }
  $response =~ "(?i)^(y|yes)$"
}
