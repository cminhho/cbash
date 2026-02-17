# CBASH CLI Demo
# Generate with: vhs demo.tape

Output assets/demo.gif
Set FontSize 11
Set Width 1400
Set Height 2000
Set Theme "Dracula"
Set Padding 20
Set Shell "zsh"

# Load cbash (hidden from recording)
Hide
Type "source ~/.cbash/cbash.sh 2>/dev/null"
Enter
Sleep 1s
Type "clear"
Enter
Sleep 0.5s
Show

# Show minimal help
Type "cbash"
Enter
Sleep 5s

Type "clear"
Enter
Sleep 0.5s

# Show full help
Type "cbash --full"
Enter
Sleep 5s

Type "clear"
Enter
Sleep 0.5s

# Clone all repos from file
Type "clone_all test/repos-example.txt /tmp/demo"
Enter
Sleep 3s

# Pull all repos
Type "pull_all /tmp/demo"
Enter
Sleep 2s
