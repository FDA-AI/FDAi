import os
import shutil
import re

# Update this before running the script
search_term = "Aggregated Correlation"
excluded_terms = ["Aggregate Correlation", "Correlation Coefficient"]
replace_term = "Global Variable Relationship"

target_directory = "C:\\Users\\User\\OneDrive\\code\\decentralized-fda"  # Replace with actual path

excluded_extensions = ['.png', '.jpg', '.jpeg', '.gif', '.bmp', '.exe', '.dll']
excluded_dirs = [".git", ".svn"]


import os
import shutil
import re

def generate_case_variations(term):
    """
    Generate variations of the term in different cases:
    camelCase, snake_case, kebab-case, title case, lower case, upper case, SCREAMING_SNAKE_CASE.
    """
    lower_case = term.lower()
    upper_case = term.upper()
    title_case = term.title()
    camel_case = lower_case[0].lower() + title_case[1:]
    snake_case = lower_case.replace(' ', '_')
    screaming_snake_case = upper_case.replace(' ', '_')
    kebab_case = lower_case.replace(' ', '-')
    return [lower_case, title_case, camel_case, snake_case, kebab_case, upper_case, screaming_snake_case]

def create_regex_pattern(terms):
    """
    Create a regex pattern that matches any of the terms in their various cases.
    """
    escaped_terms = [re.escape(term) for term in terms]
    pattern = '|'.join(escaped_terms)
    return re.compile(pattern, re.IGNORECASE)

def rename_entity(path, search_pattern, replace_term):
    """
    Rename a file or directory if it matches the search pattern.
    """
    entity_name = os.path.basename(path)
    new_name = search_pattern.sub(replace_term, entity_name)
    if new_name != entity_name:
        new_path = os.path.join(os.path.dirname(path), new_name)
        shutil.move(path, new_path)
        return new_path
    return path

def is_excluded(match, excluded_patterns):
    """
    Check if the regex match is part of any of the excluded patterns.
    """
    start, end = match.span()
    for pattern in excluded_patterns:
        if pattern.search(match.string, pos=start, endpos=end):
            return True
    return False

def replace_in_file(file_path, search_pattern, replace_term, excluded_patterns):
    """
    Replace occurrences of the search term in the file's content, skipping excluded terms.
    """
    with open(file_path, 'r', encoding='utf-8') as file:
        content = file.read()

    def replace_func(match):
        if is_excluded(match, excluded_patterns):
            return match.group()
        return replace_term

    new_content = search_pattern.sub(replace_func, content)
    if new_content != content:
        with open(file_path, 'w', encoding='utf-8') as file:
            file.write(new_content)

def process_directory(directory, search_pattern, replace_term, excluded_patterns, excluded_extensions, excluded_dirs):
    """
    Process each file and directory within the specified directory, excluding specified directories.
    """
    excluded_directories = {os.path.join(directory, d) for d in excluded_dirs}
    for root, dirs, files in os.walk(directory, topdown=True):
        dirs[:] = [d for d in dirs if os.path.join(root, d) not in excluded_directories]

        for name in files:
            file_path = os.path.join(root, name)
            extension = os.path.splitext(file_path)[1].lower()
            if extension not in excluded_extensions:
                replace_in_file(file_path, search_pattern, replace_term, excluded_patterns)

        for name in dirs:
            dir_path = os.path.join(root, name)
            rename_entity(dir_path, search_pattern, replace_term)

    rename_entity(directory, search_pattern, replace_term)


# Generate regex patterns for the search term and excluded terms
search_pattern = create_regex_pattern(generate_case_variations(search_term))
excluded_patterns = [create_regex_pattern(generate_case_variations(term)) for term in excluded_terms]

# Process the directory
process_directory(target_directory, search_pattern, replace_term, excluded_patterns, excluded_extensions, excluded_dirs)
