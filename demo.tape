# CBASH CLI Demo
# Generate with: vhs demo.tape

Output demo.gif
Set FontSize 16
Set Width 1000
Set Height 600
Set Theme "Dracula"
Set Padding 20
Set Shell "bash"

# Source cbash first
Type "source ~/.cbash/cbash.sh"
Enter
Sleep 1s
Hide

# Show help
Show
Type "cbash"
Enter
Sleep 4s

# Auto-commit example
Type "cbash git auto-commit"
Enter
Sleep 2s

# Pull all repos
Type "cbash git pull-all ~/repos"
Enter
Sleep 2s

# Git for command
Type 'cbash git for "git status"'
Enter
Sleep 2s

# End
Type "# 200+ aliases - type less, ship faster!"
Enter
Sleep 2s
