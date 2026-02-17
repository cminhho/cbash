# CBASH CLI Demo
# Generate with: vhs demo.tape

Output assets/demo.gif
Set FontSize 12
Set Width 1200
Set Height 900
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
Sleep 4s

Type "clear"
Enter
Sleep 0.5s

# Show full help
Type "cbash --full"
Enter
Sleep 4s

Type "clear"
Enter
Sleep 0.5s

# Clone all repos from file (zoom in)
Set FontSize 18
Type "clone_all test/repos-example.txt /tmp/demo"
Enter
Sleep 2s
Set FontSize 12

# Pull all repos (zoom in)
Set FontSize 18
Type "pull_all /tmp/demo"
Enter
Sleep 2s
Set FontSize 12

# Run command in all repos (zoom in)
Set FontSize 18
Type 'gitfor "git status" /tmp/demo'
Enter
Sleep 2s
Set FontSize 12

# Sync repo (zoom in)
Set FontSize 18
Type "gitsync"
Enter
Sleep 2s
Set FontSize 12

# Auto-commit (zoom in)
Set FontSize 18
Type "commit"
Enter
Sleep 2s
Set FontSize 12
