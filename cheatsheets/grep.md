# Advanced Grep Cheatsheet

## Basic Syntax

```
grep [options] pattern [file...]
```

## Common Options

| Option | Description |
|--------|-------------|
| `-i` | Case insensitive search |
| `-v` | Invert match (show lines that don't match) |
| `-w` | Match whole words only |
| `-n` | Show line numbers |
| `-c` | Count matching lines |
| `-l` | Show only filenames with matches |
| `-L` | Show only filenames without matches |
| `-r` | Recursive search through directories |
| `-R` | Recursive search following symbolic links |
| `-A n` | Display n lines after match |
| `-B n` | Display n lines before match |
| `-C n` | Display n lines before and after match |
| `-E` | Extended regex (same as using `egrep`) |
| `-F` | Fixed strings, not regex (same as using `fgrep`) |
| `-P` | Perl-compatible regex (PCRE) |
| `--color=auto` | Highlight matching text |

## Regular Expression Syntax

| Pattern | Matches |
|---------|---------|
| `.` | Any single character |
| `^` | Start of line |
| `$` | End of line |
| `[abc]` | Any character in the set |
| `[^abc]` | Any character not in the set |
| `[a-z]` | Any character in the range |
| `*` | Zero or more of the previous character |
| `+` | One or more of the previous character (with `-E`) |
| `?` | Zero or one of the previous character (with `-E`) |
| `\` | Escape special characters |
| `\b` | Word boundary |
| `\B` | Non-word boundary |
| `\d` | Digit character (with `-P`) |
| `\D` | Non-digit character (with `-P`) |
| `\s` | Whitespace character (with `-P`) |
| `\S` | Non-whitespace character (with `-P`) |
| `\w` | Word character (with `-P`) |
| `\W` | Non-word character (with `-P`) |
| `(...)` | Capturing group (with `-E`) |
| `(?:...)` | Non-capturing group (with `-P`) |
| `|` | Alternation (OR) (with `-E`) |
| `{n}` | Exactly n occurrences (with `-E`) |
| `{n,}` | At least n occurrences (with `-E`) |
| `{n,m}` | Between n and m occurrences (with `-E`) |

## Advanced Examples

### Search for pattern in multiple files
```bash
grep "error" *.log
```

### Case insensitive search
```bash
grep -i "warning" error.log
```

### Count occurrences
```bash
grep -c "failed" error.log
```

### Show line numbers
```bash
grep -n "exception" error.log
```

### Recursive search in directories
```bash
grep -r "TODO" /path/to/project
```

### Search for whole words only
```bash
grep -w "error" *.log  # Matches "error" but not "errors"
```

### Multiple patterns with OR
```bash
grep -E "error|warning|critical" *.log
```

### Exclude pattern
```bash
grep -v "DEBUG" error.log  # Lines without "DEBUG"
```

### Match lines that start with a pattern
```bash
grep "^DEBUG" error.log
```

### Match lines that end with a pattern
```bash
grep "failed$" error.log
```

### Show context around matches
```bash
grep -A 2 -B 1 "exception" error.log  # 2 lines after, 1 line before
```

### Search for IP addresses
```bash
grep -E "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" access.log
```

### Find files containing pattern
```bash
grep -l "TODO" *.java
```

### Find files NOT containing pattern
```bash
grep -L "test" *.py
```

### Count occurrences in each file
```bash
grep -c "ERROR" *.log
```

### Search for pattern with variable
```bash
grep "User: $USERNAME" auth.log
```

### Pipe output from another command
```bash
ps aux | grep "nginx"
```

### Match exact string (not a regex)
```bash
grep -F "*.txt" filename  # Treats *.txt as literal text
```

### Print only the matched text
```bash
grep -o "ID:[0-9]*" log.txt
```

### Search for hexadecimal values
```bash
grep -E "0x[0-9a-fA-F]+" source.c
```

### Find lines with exactly 3 digits
```bash
grep -E "^[0-9]{3}$" numbers.txt
```

### Named capturing groups (PCRE)
```bash
grep -P "(?<name>[A-Z][a-z]+): (?<phone>\d{3}-\d{4})" contacts.txt
```

### Lookahead and lookbehind (PCRE)
```bash
grep -P "password(?=.*[A-Z])(?=.*[0-9])" passwords.txt  # Password with uppercase and digit
```

### Match between two patterns
```bash
grep -Pzo "START.*?END" --include="*.txt" .
```

## Practical Use Cases

### Find all TODOs in a project
```bash
grep -r "TODO" --include="*.{js,py,java,c,cpp,h}" .
```

### Extract all emails from a file
```bash
grep -Eo '\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b' file.txt
```

### Find files with potential security issues
```bash
grep -r --include="*.php" "eval\s*(" .
```

### Search for lines with specific error codes
```bash
grep -E "Error: (404|500)" error.log
```

### Check configuration files for suspicious settings
```bash
grep -E "(password|secret|key).*=.*['\"].*['\"]" config/*
```

### Exclude certain directories from search
```bash
grep -r "pattern" --exclude-dir={node_modules,vendor,dist} .
```

### Exclude certain file types
```bash
grep -r "pattern" --exclude="*.{log,tmp}" .
```

### Find large numbers
```bash
grep -E "[0-9]{6,}" data.txt
```

### Count occurrences of each matching pattern
```bash
grep -o "ERROR\|WARNING\|INFO" log.txt | sort | uniq -c
```

### Find uncommented lines in a config file
```bash
grep -v "^\s*#" config.conf | grep -v "^$"
```

## Performance Tips

1. Use `grep -F` when searching for fixed strings (no regex)
2. Use `grep -l` to stop searching a file after first match
3. Specify file types with `--include` to reduce search scope
4. Use `xargs` with `find` for better performance on large directories
5. Use `LC_ALL=C grep` for byte-by-byte comparison (much faster)

## Combining with Other Commands

### Find and replace with grep and sed
```bash
grep -l "old_text" *.txt | xargs sed -i 's/old_text/new_text/g'
```

### Count occurrences of patterns
```bash
grep -o "pattern" file.txt | wc -l
```

### Search compressed files
```bash
zgrep "error" *.gz
```

### Filter process list
```bash
ps aux | grep "[n]ginx"  # The bracket prevents grep from finding itself
```

### Find files and search in them
```bash
find . -name "*.log" -exec grep "ERROR" {} \;
```