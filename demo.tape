# CBASH CLI Demo
# Generate with: vhs demo.tape

Output demo.gif
Set FontSize 14
Set Width 1200
Set Height 800
Set Theme "Dracula"
Set Padding 20
Set Shell "bash"

Type "source ~/.cbash/cbash.sh"
Enter
Sleep 1s
Hide

Show
Type "cbash"
Enter
Sleep 4s

# Show clone-all example file
Type "cat test/repos-example.txt"
Enter
Sleep 2s

# Clone all repos from file (alias)
Type "clone_all test/repos-example.txt /tmp/demo"
Enter
Sleep 3s

# Pull all repos (alias)
Type "pull_all /tmp/demo"
Enter
Sleep 2s

# Auto-commit (alias)
Type "commit"
Enter
Sleep 2s

# End
Type "# 200+ aliases - type less, ship faster!"
Enter
Sleep 2s
