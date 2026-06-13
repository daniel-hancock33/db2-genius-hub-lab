# Find all Markdown files recursively and sort them alphabetically
find . -name "*.md" | sort | while read file
do
  # Print a blank line between files
  echo

  # Create a section heading for the Markdown file itself
  # Example:
  # ## [01-setup](./01-setup.md)
  echo "## [$(basename "$file" .md)]($file)"

  # Extract all Markdown headings (#, ##, ###, etc.)
  grep '^#' "$file" | while read line
  do
    # Determine heading level by counting leading '#'
    #
    # Examples:
    # "# Title"      -> level 1
    # "## Section"   -> level 2
    # "### Subsection" -> level 3
    #
    level=$(echo "$line" | sed 's/[^#].*$//' | wc -c)

    # Remove the leading '#' characters and space
    #
    # Example:
    # "## Student SSH Access"
    # becomes:
    # "Student SSH Access"
    #
    title=$(echo "$line" | sed 's/^#* //')

    # Convert heading text into a GitHub-compatible anchor
    #
    # Example:
    # "Student SSH Access"
    # becomes:
    # "student-ssh-access"
    #
    anchor=$(echo "$title" \
      | tr '[:upper:]' '[:lower:]' \
      | sed 's/[[:punct:]]//g' \
      | tr ' ' '-')

    # Calculate indentation based on heading level
    #
    # H1 -> 0 spaces
    # H2 -> 2 spaces
    # H3 -> 4 spaces
    #
    indent=$((level - 1))

    # Generate a Markdown TOC entry
    #
    # Example output:
    # - [Setup and Configuration](./01-setup.md#setup-and-configuration)
    #   - [Student SSH Access](./01-setup.md#student-ssh-access)
    #     - [Prerequisites](./01-setup.md#prerequisites)
    #
    printf '%*s- [%s](%s#%s)\n' \
      $((indent * 2)) "" \
      "$title" "$file" "$anchor"

  done
done
