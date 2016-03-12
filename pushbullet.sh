# Get token
token=$1; shift

# Get command
command="$@"
echo "Executing command '$command'"

# Execute command
echo $@ | bash
returncode=$?

# Push notification
blackhole=`curl -s -u $token: https://api.pushbullet.com/v2/pushes -d type=note -d title="Command '$command' has finished with returncode $returncode."`

exit $returncode
