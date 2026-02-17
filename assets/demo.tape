# CBASH CLI Demo
# Generate: vhs assets/demo.tape

Output assets/demo.gif
Set FontSize 22
Set Width 1280
Set Height 720
Set Theme "Dracula"
Set Padding 24
Set Shell "zsh"

# Load cbash (hidden from recording)
Hide
Type "source ~/.cbash/cbash.sh 2>/dev/null"
Enter
Type "clear"
Enter
Show

Sleep 1s

# Show minimal help
Type "cbash"
Enter
Sleep 4s

Type "clear"
Enter
Sleep 1s

# Clone all repos from file
Type "clone_all test/repos-example.txt /tmp/demo"
Enter
Sleep 3s

# Pull all repos
Type "pull_all /tmp/demo"
Enter
Sleep 3s

# Run command in all repos
Type 'gitfor "git status" /tmp/demo'
Enter
Sleep 3s

# Sync repo
Type "gitsync"
Enter
Sleep 3s

# Auto-commit
Type "commit"
Enter
Sleep 3s
